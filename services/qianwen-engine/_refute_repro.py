# -*- coding: utf-8 -*-
"""边界复现：审查者声称 answer 详情 can_share/shared/liked 不按请求者视角计算。
本脚本用当前代码逐步推演：
  1) A(本人) ready 答案 → 点赞 → 共享入锅圈
  2) B(他人) 打开 A 的答案详情 → ???
  3) B 点共享/取消共享 → ???
  4) 反事实推演：把 get_answer_visible 换成『自然修法』(shared 即全员可见)后再看 B 拿到什么
"""
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from qianwen_engine import config, metaso_kb, wechat, zhipu, store

# ── 离线环境（与 tests/test_api.py fixture 同款）──
tmp = Path(tempfile.mkdtemp())
config.DB_PATH = tmp / "t.sqlite"
config.DATA_DIR = tmp
store._init_done = False
metaso_kb.ask = lambda q, model="fast", sleep=None, on_event=None: metaso_kb.KbAnswer(
    question=q, answer="结论[[书†1]]" + "详" * 300, cid="123456789012345678",
    url="https://metaso.cn/x", citations=[{"n": 1, "source": "测试规范", "loc": 12}],
    elapsed_sec=1.0)
zhipu.configured = lambda: False

from fastapi.testclient import TestClient
from qianwen_engine import app as app_mod

A, B = "user-A", "user-B"
tok_a = "Bearer " + wechat.issue_token(A)
tok_b = "Bearer " + wechat.issue_token(B)

with TestClient(app_mod.app) as c:
    # ── 状态构造：A 的 ready 答案，A 点过赞，A 已共享 ──
    aid = store.save_answer(A, "A 的问题", "A 的答案" * 100, [])
    c.headers.update({"Authorization": tok_a})
    r_like = c.post(f"/api/answer/{aid}/like")            # 本人点赞 → answers.liked=1
    r_on = c.post(f"/api/answer/{aid}/share_on")          # 共享入锅圈 → shared=1
    print(f"[setup] A like -> {r_like.status_code} {r_like.json()}")
    print(f"[setup] A share_on -> {r_on.status_code} {r_on.json()}")
    pot_ids = [i["id"] for i in c.get("/api/pot/list").json()["items"]]
    print(f"[setup] pot list contains A's answer: {aid in pot_ids}")

    # ── 步骤1：B 打开 A 的共享答案详情（锅圈列表点进去的正是这个请求）──
    c.headers.update({"Authorization": tok_b})
    r_b = c.get(f"/api/answer/{aid}")
    print(f"\n[step1] B GET /api/answer/{aid} -> {r_b.status_code} {r_b.json()}")

    # ── 步骤2：B 若强行点共享/取消共享/点赞 ──
    r_b_on = c.post(f"/api/answer/{aid}/share_on")
    r_b_off = c.post(f"/api/answer/{aid}/share_off")
    r_b_like = c.post(f"/api/answer/{aid}/like")
    print(f"[step2] B share_on -> {r_b_on.status_code} {r_b_on.json()}")
    print(f"[step2] B share_off -> {r_b_off.status_code} {r_b_off.json()}")
    print(f"[step2] B like -> {r_b_like.status_code} {r_b_like.json()}")

    # ── 对照：A 本人视角 ──
    c.headers.update({"Authorization": tok_a})
    d_a = c.get(f"/api/answer/{aid}").json()
    print(f"\n[owner] A sees liked={d_a['liked']} shared={d_a['shared']} can_share={d_a['can_share']}")

    # ── 反事实：把可见性换成『自然修法』(shared=1 即全员可见) 再看 B ──
    orig = store.get_answer_visible
    def fixed_visible(aid_, openid_):
        row = store.get_answer(aid_)
        if row is None:
            return None
        if row["openid"] == openid_ or row["openid"] == config.POT_OPENID or row["shared"]:
            return row
        return None
    app_mod.store.get_answer_visible = fixed_visible
    try:
        c.headers.update({"Authorization": tok_b})
        d_b = c.get(f"/api/answer/{aid}").json()
        print(f"\n[counterfactual after visibility fix] B sees "
              f"liked={d_b['liked']} shared={d_b['shared']} can_share={d_b['can_share']}")
        r_cf_off = c.post(f"/api/answer/{aid}/share_off")
        print(f"[counterfactual] B share_off -> {r_cf_off.status_code} {r_cf_off.json()}")
    finally:
        app_mod.store.get_answer_visible = orig
        store._init_done = False

print("\nverdict: see steps above")
