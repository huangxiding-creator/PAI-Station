# -*- coding: utf-8 -*-
"""边界复现：share_on 赠 +1 是否被同一请求内 quota_left 的跨日重置吞掉。

场景构造（生产可达态）：
  用户昨天问过问题（users.quota_day=昨天），今天冷启动经分享卡片直达答案页
  （app.js onLaunch 无 API、answer 页 load 只 GET /api/answer，均不触 users 表），
  今日第一个触达 users 表的请求就是 POST /api/answer/{aid}/share_on。
  端点序列 = store.share_on(...) → 返回体 store.quota_left(...)（app.py:283-285）。
"""
from __future__ import annotations

import sqlite3
import sys
import tempfile
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from qianwen_engine import config, metaso_kb, wechat  # noqa: E402


def _today() -> str:
    return time.strftime("%Y-%m-%d", time.gmtime(time.time() + 8 * 3600))


def _yesterday() -> str:
    return time.strftime("%Y-%m-%d", time.gmtime(time.time() + 8 * 3600 - 86400))


def _kb_answer(q):
    return metaso_kb.KbAnswer(
        question=q, answer="结论[[书†1]]" + "详" * 300,
        cid="123456789012345678", url="https://metaso.cn/x",
        citations=[{"n": 1, "source": "测试规范", "loc": 12}], elapsed_sec=1.0)


def _raw_user(openid):
    conn = sqlite3.connect(config.DB_PATH)
    conn.row_factory = sqlite3.Row
    try:
        return dict(conn.execute(
            "SELECT free_used, bonus_earned, bonus_used, quota_day FROM users WHERE openid=?",
            (openid,)).fetchone())
    finally:
        conn.close()


def _set_stale(openid):
    """把 quota_day 拨回昨天（=该用户今天还没碰过 users 表）。"""
    conn = sqlite3.connect(config.DB_PATH)
    conn.execute("UPDATE users SET quota_day=? WHERE openid=?", (_yesterday(), openid))
    conn.commit()
    conn.close()


def _ask_ready(client, q="EPC 固定总价能不能调价"):
    r = client.post("/api/ask", json={"question": q})
    assert r.status_code == 200, r.text
    aid = r.json()["id"]
    for _ in range(200):
        d = client.get(f"/api/answer/{aid}").json()
        if d.get("status") != "pending":
            assert d["status"] == "ready", d
            return aid
        time.sleep(0.05)
    raise AssertionError("answer never ready")


def main():
    from fastapi.testclient import TestClient
    from qianwen_engine import app as app_mod, store

    tmp = Path(tempfile.mkdtemp(prefix="qw_shareon_repro_"))
    config.DB_PATH = tmp / "t.sqlite"
    config.DATA_DIR = tmp
    store._init_done = False

    wechat.code2session = lambda code: {"openid": "open-t1", "unionid": ""}
    metaso_kb.ask = lambda q, model="fast", sleep=None, on_event=None: _kb_answer(q)
    metaso_kb._guard_enter = lambda cost=3: None
    metaso_kb._record = lambda ok: None

    openid = "open-t1"
    results = {}

    with TestClient(app_mod.app) as client:
        client.headers.update({"Authorization": "Bearer " + wechat.issue_token(openid)})

        # ── 场景 A（声称的缺陷）：quota_day=昨天，今日首个触 users 表的请求=share_on ──
        aid_a = _ask_ready(client, "场景A的问题")
        _set_stale(openid)  # 昨天最后一次活动后 users 表保持的旧状态
        before = _raw_user(openid)
        print(f"[A] share_on 前用户行: {before}  (今天={_today()})")
        r = client.post(f"/api/answer/{aid_a}/share_on")
        assert r.status_code == 200, r.text
        body = r.json()
        results["A_share_on_http"] = body
        print(f"[A] POST /share_on 返回体: shared={body['shared']} "
              f"quota={body['quota']}")
        after_resp = _raw_user(openid)
        print(f"[A] 同一请求结束后用户行: {after_resp}")
        results["A_bonus_left_in_same_response"] = body["quota"]["bonus_left"]

        # 供对照的瞬态观察（store 层同序列复演，证明 +1 确实先落上去了又被抹）
        aid_t = store.save_answer(openid, "瞬态观察的问题", "答案正文" * 80, [])
        _set_stale(openid)
        ok = store.share_on(aid_t, openid)
        mid = _raw_user(openid)
        print(f"[A-瞬态] store.share_on 返回 {ok}，紧接着裸读用户行: {mid}")
        q = store.quota_left(openid)
        print(f"[A-瞬态] 随后 store.quota_left → bonus_left={q['bonus_left']}")
        results["A_transient_bonus_earned"] = mid["bonus_earned"]
        results["A_transient_bonus_left_after_quota_left"] = q["bonus_left"]

        # ── 场景 B（对照）：quota_day=今天（正常同日流）──
        aid_b = _ask_ready(client, "场景B的问题")
        r2 = client.post(f"/api/answer/{aid_b}/share_on")
        assert r2.status_code == 200, r2.text
        print(f"[B 对照] POST /share_on 返回体 quota={r2.json()['quota']}")
        results["B_bonus_left_same_day"] = r2.json()["quota"]["bonus_left"]

        # ── 场景 C（grant_reward 对照）：同样 quota_day=昨天，走老赠次路径
        from qianwen_engine import store as st
        aid_c = st.save_answer(openid, "场景C的问题", "答案正文" * 80, [])
        _set_stale(openid)
        granted = st.grant_reward(openid, aid_c, "share")
        q2 = st.quota_left(openid)
        print(f"[C 对照] grant_reward(share) granted={granted} → quota_left={q2}")
        results["C_grant_reward_bonus_left"] = q2["bonus_left"]

        # ── 场景 D（后果链）：A 的 +1 被吞后，取消共享的免扣
        r3 = client.post(f"/api/answer/{aid_a}/share_off")
        assert r3.status_code == 200, r3.text
        row_d = _raw_user(openid)
        print(f"[D 后果] share_off 返回体 quota={r3.json()['quota']}；"
              f"事后用户行 bonus_earned={row_d['bonus_earned']} bonus_used={row_d['bonus_used']}")

    # ── 判定 ──
    print("\n===== 判定 =====")
    bug = (results["A_bonus_left_in_same_response"] == 0
           and results["B_bonus_left_same_day"] == 1
           and results["A_transient_bonus_earned"] >= 1
           and results["C_grant_reward_bonus_left"] == 1)
    print(f"A(旧日计数) 同请求内 bonus_left = {results['A_bonus_left_in_same_response']}")
    print(f"A-瞬态 share_on 后裸读 bonus_earned = {results['A_transient_bonus_earned']}"
          "  ← +1 确实先落上去了")
    print(f"B(同日对照) bonus_left = {results['B_bonus_left_same_day']}")
    print(f"C(grant_reward 对照, 旧日计数) bonus_left = {results['C_grant_reward_bonus_left']}")
    print(f"缺陷是否实际发生: {'YES — 复现成功' if bug else 'NO — 未能复现'}")
    return 0 if bug else 1


if __name__ == "__main__":
    sys.exit(main())
