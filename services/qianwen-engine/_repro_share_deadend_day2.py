# -*- coding: utf-8 -*-
"""code-repro：429 文案「分享可再得」次日结构性死端（commit 23a48173 引入的文案）。

两日执行迹：
  D1: 6 免费问尽 → 第7问 429「今日6问已用完，分享可再得」→ 分享 SKU-A 赠次成功(granted=True) → 第7问放行
  跨日（北京时间 00:00）：free_used/bonus_earned/bonus_used 全清零
  D2: 6 免费问尽 → 第7问 429 同文案「分享可再得」→ 再分享同一 SKU-A → granted=False 静默 + quota=0（死端）
  对照：分享另一报告 SKU-B → granted=True（证明机制=每 sku×action 终身一次，目录有限）
运行：python -I _repro_share_deadend_day2.py
"""
from __future__ import annotations

import json
import sys
import tempfile
from pathlib import Path
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parent))

from qianwen_engine import config, report_catalog, wechat, zhipu  # noqa: E402
from qianwen_engine import app as app_mod  # noqa: E402
from qianwen_engine import store  # noqa: E402

from fastapi.testclient import TestClient  # noqa: E402

FAKE_REPLY = "结论行\n第1章：论据一\n第2章：论据二"
D1, D2 = "2099-01-01", "2099-01-02"


def _mk_content(cdir: Path) -> None:
    (cdir / "full").mkdir(parents=True)
    (cdir / "sample").mkdir(parents=True)
    r = {"reports": [
        {"sku": sku, "title": f"{sku} 报告", "subtitle": "副题", "price": 498,
         "price_label": "¥498", "words_wan": 5, "badges": [], "cat": "ent",
         "cat_name": "企业研究", "intro_lede": "导语", "intro": "简介",
         "audience": "从业者",
         "chapters": [{"id": i, "title": f"第{i}章 主题{i}", "desc": f"主题{i}描述"}
                      for i in range(1, 7)],
         "sample_file": f"{sku.lower()}.md", "sample_label": "试读"}
        for sku in ("SKU-A", "SKU-B")]}
    (cdir / "report.json").write_text(json.dumps(r, ensure_ascii=False), encoding="utf-8")
    for sku in ("SKU-A", "SKU-B"):
        (cdir / "full" / f"{sku}.pdf").write_bytes(b"%PDF-1.4 " + b"a" * 40)
        (cdir / "sample" / f"{sku.lower()}.md").write_text("# 试读\n合同计价与变更签证。", encoding="utf-8")


def main() -> int:
    tmp = Path(tempfile.mkdtemp(prefix="repro_share_deadend_"))
    config.DB_PATH = tmp / "t.sqlite"
    config.DATA_DIR = tmp
    _mk_content(tmp / "content")
    config.REPORT_CONTENT_DIR = tmp / "content"
    report_catalog._CACHE.update({"mtime": 0.0, "reports": [], "by_sku": {}})
    store._init_done = False
    wechat.code2session = lambda code: {"openid": f"open-{code}", "unionid": ""}
    zhipu.deep_answer = lambda system, prompt, **k: FAKE_REPLY

    ok = True
    with patch.object(store, "_today", return_value=D1), TestClient(app_mod.app) as c:
        c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-t1")})

        def ask(q):
            return c.post("/api/report/SKU-A/ask", json={"q": q})

        def share(sku):
            return c.post(f"/api/report/{sku}/share")

        # ── Day 1 ──
        for i in range(config.FREE_PER_DAY):
            r = ask(f"变更签证怎么办理{i}")
            assert r.status_code == 200, (i, r.status_code)
        r7 = ask("变更签证怎么办理再问")
        print(f"D1 第7问: {r7.status_code} detail={r7.json()['detail']!r} left={r7.json()['left']}")
        assert r7.status_code == 429 and "分享可再得" in r7.json()["detail"]
        s1 = share("SKU-A")
        g1 = s1.json()
        print(f"D1 分享SKU-A: granted={g1['granted']} total_left={g1['quota']['total_left']}")
        assert g1["granted"] is True and g1["quota"]["total_left"] == 1
        r7b = ask("变更签证怎么办理再问")
        print(f"D1 第7问(赠次后): {r7b.status_code} left={r7b.json()['left']}")
        assert r7b.status_code == 200 and r7b.json()["left"] == 0

    # ── 跨日：北京 00:00，_row_user 清零 free_used/bonus_earned/bonus_used ──
    with patch.object(store, "_today", return_value=D2), TestClient(app_mod.app) as c:
        c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-t1")})

        def ask(q):
            return c.post("/api/report/SKU-A/ask", json={"q": q})

        for i in range(config.FREE_PER_DAY):
            r = ask(f"计价规则是什么{i}")
            assert r.status_code == 200, (i, r.status_code)
        r7 = ask("计价规则是什么再问")
        print(f"D2 第7问: {r7.status_code} detail={r7.json()['detail']!r} left={r7.json()['left']}")
        assert r7.status_code == 429 and "分享可再得" in r7.json()["detail"]

        s2 = c.post("/api/report/SKU-A/share")
        g2 = s2.json()
        print(f"D2 再分享同一SKU-A: http={s2.status_code} granted={g2['granted']} "
              f"total_left={g2['quota']['total_left']} (free={g2['quota']['free_left']} bonus={g2['quota']['bonus_left']})")
        # 死端断言：文案承诺的补救动作再也无法触发，quota 仍为 0
        assert s2.status_code == 200 and g2["granted"] is False and g2["quota"]["total_left"] == 0

        # 对照：换一份报告分享 → 可赠（机制=每 sku×action 终身一次；目录有限终将枯竭）
        s3 = c.post("/api/report/SKU-B/share")
        g3 = s3.json()
        print(f"D2 分享另一报告SKU-B: granted={g3['granted']} total_left={g3['quota']['total_left']}")
        assert g3["granted"] is True and g3["quota"]["total_left"] == 1

        # D2 再问第7问：仍 429 同文案（同一 sku 分享已终身领过）
        r7c = ask("计价规则是什么再问")
        print(f"D2 第7问(再分享后): {r7c.status_code} detail={r7c.json()['detail']!r}")
        assert r7c.status_code == 429 and "分享可再得" in r7c.json()["detail"]

    print("\nREPRO CONFIRMED: D2 同报告再分享 granted=False 且 quota=0，"
          "429 文案承诺的补救动作结构性失效（rewards UNIQUE(openid,aid,action) 无日维度 × bonus_earned 日清零）")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
