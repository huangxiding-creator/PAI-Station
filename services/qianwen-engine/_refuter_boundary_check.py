# -*- coding: utf-8 -*-
"""独立边界复现：声称缺陷=用户共享入锅圈后，非所有者点开必 404。
逐步推演主链路：owner share_on → pot_list 在列 → 他人 GET 详情 → 断言状态码。
对照组：v0.5.0 播种条目（POT_OPENID）他人应可见；owner 本人应可见。
"""
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from qianwen_engine import config, wechat, store  # noqa: E402

# ── 离线隔离环境（与 tests/test_api.py fixture 同款，绝不碰生产 DB）──
tmp = Path(tempfile.mkdtemp(prefix="qw_refuter_"))
config.DB_PATH = tmp / "t.sqlite"
config.DATA_DIR = tmp
store._init_done = False

from fastapi.testclient import TestClient  # noqa: E402
from qianwen_engine import app as app_mod  # noqa: E402

A, B = "owner-A", "stranger-B"
tok_a = "Bearer " + wechat.issue_token(A)
tok_b = "Bearer " + wechat.issue_token(B)

failures = []

with TestClient(app_mod.app) as c:
    # 步骤1：A 有一篇已完成答案并共享入锅圈
    c.headers.update({"Authorization": tok_a})
    aid = store.save_answer(A, "A 的咨询问题", "A 的专业解答正文" * 100, [])
    r_on = c.post(f"/api/answer/{aid}/share_on")
    print(f"[1] A share_on -> {r_on.status_code} {r_on.json()}")
    if r_on.status_code != 200:
        failures.append("share_on 未成功，前置条件不成立")

    # 步骤2：共享条目是否进入锅圈列表（对所有用户）
    c.headers.update({"Authorization": tok_b})
    pot = c.get("/api/pot/list")
    ids = [i["id"] for i in pot.json()["items"]]
    print(f"[2] B 视角 pot/list -> {pot.status_code}，A 的条目在列: {aid in ids}")
    if aid not in ids:
        failures.append("共享条目未进锅圈列表——他人根本看不到卡片（缺陷前提不成立）")

    # 步骤3：B（他人）从锅圈点开 A 的共享答案（即 pot.js onItem 的目标请求）
    r_b = c.get(f"/api/answer/{aid}")
    print(f"[3] B GET /api/answer/{aid} -> {r_b.status_code} {r_b.json()}")
    if r_b.status_code == 404:
        print("    >>> 缺陷实际发生：他人点开共享答案 = 404「答案不存在」")
    elif r_b.status_code == 200:
        failures.append("他人 GET 共享答案返回 200——缺陷未发生，声称被推翻")
    else:
        failures.append(f"他人 GET 返回意外状态 {r_b.status_code}，需人工判读")

    # 步骤4：他人点赞共享答案（claims: like 同样被 get_answer_visible 拦截）
    r_like = c.post(f"/api/answer/{aid}/like")
    print(f"[4] B POST like -> {r_like.status_code} {r_like.json()}")

    # 对照组1：owner 本人视角应正常
    c.headers.update({"Authorization": tok_a})
    r_a = c.get(f"/api/answer/{aid}")
    print(f"[C1] A 本人 GET -> {r_a.status_code} shared={r_a.json().get('shared')}")
    if r_a.status_code != 200:
        failures.append("owner 本人反而看不到自己的答案——与声称不符")

    # 对照组2：v0.5.0 播种条目（POT_OPENID 所有）他人应可见（声称其不受影响）
    pot_aid = store.save_pot_answer("播种的锅圈问题", "播种解答" * 60, [])
    c.headers.update({"Authorization": tok_b})
    r_seed = c.get(f"/api/answer/{pot_aid}")
    print(f"[C2] B GET 播种条目 -> {r_seed.status_code} is_pot={r_seed.json().get('is_pot')}")
    if r_seed.status_code != 200:
        failures.append("播种条目他人也不可见——与『v0.5.0 不受影响』的声称边界不符")

print("\n===== 判定 =====")
if failures:
    for f in failures:
        print(" -", f)
else:
    print("主链路全按声称走完：他人点开共享答案 404，owner/播种条目均正常。")
