# -*- coding: utf-8 -*-
"""反驳核查：声称 share_off 在 bonus_earned=0 时静默跳过扣次仍返回 200，
而 answer.js:323 无条件 toast「已撤出锅圈，扣 1 次咨询机会」。

场景构造（生产可达态，全部走真实 HTTP 端点与真实 store 代码）：
  Day N   : POST /api/login（建 users 行）→ 提问得 ready 答案 → share_on
            （bonus_earned=1, shared=1, quota_day=Day N）
  跨日    : quota_day 拨回 Day N（=昨日收摊态，bonus_earned=1 保留）
  Day N+1 :
    主场景 A：正常打开小程序 → 落 ask 页 onLoad→silentLogin→recheck →
              GET /api/quota（ask.js:104）→ _row_user 跨日重置 bonus_earned=0
              → 进答案页（GET /api/answer 不触 users 表）→ 取消共享
    对照  B：分享卡片冷启动直达答案页（app.js onLaunch 无 API、答案页 load
              只 GET /api/answer，均不触 users 表）→ bonus_earned 仍为昨日
              陈旧值 1 → 取消共享
"""
import sqlite3
import sys
import tempfile
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
try:
    sys.stdout.reconfigure(encoding="utf-8")
except Exception:
    pass

from qianwen_engine import config, wechat, store  # noqa: E402

# ── 离线隔离环境（与 tests/test_api.py / _refuter_boundary_check.py 同款）──
tmp = Path(tempfile.mkdtemp(prefix="qw_shareoff_ded_"))
config.DB_PATH = tmp / "t.sqlite"
config.DATA_DIR = tmp
store._init_done = False
# 登录桩：code → openid（离线）
wechat.code2session = lambda code: {"openid": "user-" + code, "unionid": ""}

from fastapi.testclient import TestClient  # noqa: E402
from qianwen_engine import app as app_mod  # noqa: E402


def _today():
    return time.strftime("%Y-%m-%d", time.gmtime(time.time() + 8 * 3600))


def _yesterday():
    return time.strftime("%Y-%m-%d", time.gmtime(time.time() + 8 * 3600 - 86400))


def _raw_user(openid):
    conn = sqlite3.connect(config.DB_PATH)
    conn.row_factory = sqlite3.Row
    try:
        return dict(conn.execute(
            "SELECT free_used, bonus_earned, bonus_used, quota_day FROM users WHERE openid=?",
            (openid,)).fetchone())
    finally:
        conn.close()


def _set_day(openid, day):
    conn = sqlite3.connect(config.DB_PATH)
    conn.execute("UPDATE users SET quota_day=? WHERE openid=?", (day, openid))
    conn.commit()
    conn.close()


results = {}

with TestClient(app_mod.app) as c:
    # ══ 主场景 A：Day N 登录+提问+共享 ══
    r_login = c.post("/api/login", json={"code": "A"})
    tok_a = r_login.json()["token"]
    c.headers.update({"Authorization": "Bearer " + tok_a})
    A = "user-A"
    aid_a = store.save_answer(A, "A 的咨询问题", "A 的专业解答正文 " * 80, [])
    r_on = c.post(f"/api/answer/{aid_a}/share_on")
    row = _raw_user(A)
    print(f"[A·DayN] login+share_on -> {r_on.status_code} {r_on.json()}")
    print(f"[A·DayN] 用户行: {row}  (今天={_today()})")
    assert r_on.status_code == 200 and row["bonus_earned"] == 1, "DayN 共享后应 +1"

    # 跨日：收摊态 quota_day=Day N（相对『现在』=昨日），bonus_earned=1
    _set_day(A, _yesterday())

    # Day N+1 正常打开小程序：ask 页 onLoad→silentLogin→recheck→GET /api/quota
    q_before = c.get("/api/quota").json()["quota"]
    row = _raw_user(A)
    print(f"[A·DayN+1] GET /api/quota（ask.js:104）后: quota={q_before}")
    print(f"[A·DayN+1] 用户行（跨日重置后）: {row}")
    assert row["bonus_earned"] == 0, "跨日重置应清零 bonus_earned"
    total_before = q_before["total_left"]

    # 答案页加载（不触 users 表）→ shared=true → 用户确认弹窗 → 取消共享
    d = c.get(f"/api/answer/{aid_a}").json()
    print(f"[A·DayN+1] 答案页 GET /api/answer -> shared={d.get('shared')}")
    assert d.get("shared") is True

    r_off = c.post(f"/api/answer/{aid_a}/share_off")
    body = r_off.json()
    row_after = _raw_user(A)
    print(f"[A·DayN+1] POST /share_off -> {r_off.status_code} {body}")
    print(f"[A·DayN+1] 取消后用户行: {row_after}")

    results["A_http_200"] = r_off.status_code == 200
    results["A_ledger_unchanged"] = (row_after["bonus_earned"] == 0
                                     and row_after["bonus_used"] == 0
                                     and row_after["free_used"] == 0)
    results["A_quota_unchanged"] = body["quota"]["total_left"] == total_before
    results["A_total_before"] = total_before
    results["A_total_after"] = body["quota"]["total_left"]

    # ══ 对照 B：冷启动直达答案页，今日从未触 users 表 ══
    c.headers.pop("Authorization", None)
    r_login_b = c.post("/api/login", json={"code": "B"})
    tok_b = r_login_b.json()["token"]
    c.headers.update({"Authorization": "Bearer " + tok_b})
    B = "user-B"
    aid_b = store.save_answer(B, "B 的咨询问题", "B 的专业解答正文 " * 80, [])
    r_on_b = c.post(f"/api/answer/{aid_b}/share_on")
    _set_day(B, _yesterday())
    row_b = _raw_user(B)
    print(f"\n[B·DayN] login+share_on -> {r_on_b.status_code}；拨回昨日后用户行: {row_b}")
    assert row_b["bonus_earned"] == 1

    # Day N+1 冷启动直达答案页（无任何 users 表触达）→ 取消共享
    d_b = c.get(f"/api/answer/{aid_b}").json()
    r_off_b = c.post(f"/api/answer/{aid_b}/share_off")
    row_b_after = _raw_user(B)
    print(f"[B·DayN+1·冷启动] 答案页 shared={d_b.get('shared')}；"
          f"POST /share_off -> {r_off_b.status_code} {r_off_b.json()}")
    print(f"[B·DayN+1·冷启动] 取消后用户行: {row_b_after}")
    results["B_deducted_stale"] = (r_off_b.status_code == 200
                                   and row_b["bonus_earned"] == 1
                                   and row_b_after["bonus_earned"] == 0)

    print("\n===== 总判定 =====")
    print(f"A（正常打开过小程序再取消）: HTTP200={results['A_http_200']} "
          f"账本零变动={results['A_ledger_unchanged']} "
          f"配额不变={results['A_quota_unchanged']} "
          f"(total_left {results['A_total_before']} -> {results['A_total_after']})")
    print(f"B（冷启动直达答案页取消）: 陈旧计数器被真实扣减 1->0 = {results['B_deducted_stale']}")
    print("[客户端] answer.js:321-324 成功回调忽略响应体，"
          "200 即无条件 toast「已撤出锅圈，扣 1 次咨询机会」")
    if (results["A_http_200"] and results["A_ledger_unchanged"]
            and results["A_quota_unchanged"]):
        print(">>> 声称成立：服务端一次没扣仍返回成功，客户端必弹「扣 1 次」"
              "——告知与实际记账不符；且同一动作在 B 路径又真扣，行为不一致。")
        sys.exit(0)
    print(">>> 未能复现声称。")
    sys.exit(1)
