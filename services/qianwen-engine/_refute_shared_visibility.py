# -*- coding: utf-8 -*-
"""边界复现：声称「共享入锅圈的答案对其他用户全部 404」。

逐步推演声称的链条：
  1. 用户A（open-A）POST /api/ask → 等待 ready
  2. 用户A POST /api/answer/{aid}/share_on → 声称 200 且 +1 次
  3. 用户B（open-B）GET /api/pot/list → 声称能看到该条目（JOIN 无 openid 过滤）
  4. 用户B GET /api/answer/{aid}（pot.js:46 跳 answer 页 → api.js:105 唯一详情端点）
     → 声称 get_answer_visible 返回 None → 404「答案不存在」
  5. 用户B POST /api/answer/{aid}/like → 声称同样 404
  6. 对照：用户A 本人 GET /api/answer/{aid} 应当 200（openid 命中）
  7. 对照：锅圈策展条目（save_pot_answer，openid=pot-curator）对用户B 应当 200
"""
from __future__ import annotations

import sys
import tempfile
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from qianwen_engine import config, metaso_kb, wechat, store  # noqa: E402


def _kb_answer(q):
    return metaso_kb.KbAnswer(
        question=q, answer="结论[[书†1]]" + "详" * 300,
        cid="123456789012345678", url="https://metaso.cn/x",
        citations=[{"n": 1, "source": "测试规范", "loc": 12}], elapsed_sec=1.0)


def main() -> int:
    from fastapi.testclient import TestClient
    from qianwen_engine import app as app_mod

    tmp = Path(tempfile.mkdtemp(prefix="qw_shared_vis_"))
    config.DB_PATH = tmp / "t.sqlite"
    config.DATA_DIR = tmp
    store._init_done = False

    metaso_kb.ask = lambda q, model="fast", sleep=None, on_event=None: _kb_answer(q)
    metaso_kb._guard_enter = lambda cost=3: None
    metaso_kb._record = lambda ok: None

    results = {}
    with TestClient(app_mod.app) as c:
        # ── 1. 用户A 提问并等 ready ──
        c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-A")})
        r = c.post("/api/ask", json={"question": "EPC 固定总价合同能不能调价"})
        assert r.status_code == 200, r.text
        aid = r.json()["id"]
        for _ in range(200):
            d = c.get(f"/api/answer/{aid}").json()
            if d.get("status") != "pending":
                assert d["status"] == "ready", d
                break
            time.sleep(0.05)
        print(f"[A] 提问完成 aid={aid} status=ready")

        # ── 2. 用户A 共享入锅圈 ──
        r = c.post(f"/api/answer/{aid}/share_on")
        results["A_share_on_status"] = r.status_code
        results["A_share_on_bonus_left"] = r.json().get("quota", {}).get("bonus_left")
        print(f"[A] POST /share_on → {r.status_code} shared={r.json()['shared']} "
              f"bonus_left={results['A_share_on_bonus_left']}")

        # ── 3. 用户B 看锅圈列表 ──
        c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-B")})
        r = c.get("/api/pot/list")
        items = r.json()["items"]
        results["B_pot_list_sees"] = any(i["id"] == aid for i in items)
        print(f"[B] GET /api/pot/list → 条目可见: {results['B_pot_list_sees']}"
              f"（共 {len(items)} 条，目标预览: "
              f"{next((i['preview'][:20] for i in items if i['id'] == aid), 'N/A')}…）")

        # ── 4. 用户B 点开详情（pot.js:46 → answer 页 → api.js:105）──
        r = c.get(f"/api/answer/{aid}")
        results["B_get_answer_status"] = r.status_code
        print(f"[B] GET /api/answer/{aid} → {r.status_code} {r.json()}")

        # ── 5. 用户B 点赞 ──
        r = c.post(f"/api/answer/{aid}/like")
        results["B_like_status"] = r.status_code
        print(f"[B] POST /api/answer/{aid}/like → {r.status_code} {r.json()}")

        # ── 6. 对照：分享者本人仍能打开 ──
        c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-A")})
        r = c.get(f"/api/answer/{aid}")
        results["A_owner_get_status"] = r.status_code
        print(f"[A] 本人 GET /api/answer/{aid} → {r.status_code}")

        # ── 7. 对照：锅圈策展条目（pot-curator）对陌生用户可见（既有老语义）──
        pot_aid = store.save_pot_answer("锅圈策展问题", "公开解答" * 80, [])
        c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-B")})
        r = c.get(f"/api/answer/{pot_aid}")
        results["B_pot_curator_get_status"] = r.status_code
        print(f"[B] 对照 GET 策展条目 /api/answer/{pot_aid} → {r.status_code}")

    print("\n===== 判定 =====")
    defect = (results["A_share_on_status"] == 200
              and results["A_share_on_bonus_left"] == 1
              and results["B_pot_list_sees"] is True
              and results["B_get_answer_status"] == 404
              and results["B_like_status"] == 404
              and results["A_owner_get_status"] == 200
              and results["B_pot_curator_get_status"] == 200)
    for k, v in results.items():
        print(f"  {k} = {v}")
    print(f"声称的缺陷是否实际发生: {'YES — 完整复现' if defect else 'NO — 未能复现'}")
    return 0 if defect else 1


if __name__ == "__main__":
    sys.exit(main())
