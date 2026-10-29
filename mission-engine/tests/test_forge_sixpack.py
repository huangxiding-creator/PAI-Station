# -*- coding: utf-8 -*-
"""tests/test_forge_sixpack.py — W4.3铸模契约测试（离线零网络）。

门1三族/KB禁区 → 门2SCORECARD加权+单维地板 → 门3DeltaIndex(锚/判据/Σlog10) →
渲染六件套(六段齐+水印+门禁行) → 账本事件 → push默认关+离线桩禁推。
全程私有目录，不碰真proposals/真账本/网络。
运行: py -X utf8 tests\\test_forge_sixpack.py
"""
from __future__ import annotations

import json
import sys
import tempfile
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from forge.sixpack import (StubScorecardLlm, cast, gate_delta,     # noqa: E402
                           gate_family, gate_scorecard, parse_draft,
                           build_push_cmd)

DRAFT = """【锻造厂草案·R20261023-182636】状态: draft(W4.1)——未过SCORECARD门与审批闸，勿直接执行

① 标题+一句话
报价与计价依据支持
为编制造价和核对报价提供可依赖的计价依据和市场价基准。

② 能力单元（最小可行AI能力）
自动提供计价依据和市场价基准
- 现状替代: 人工查询 → AI价值: 提速

③ 对抗校验+评分（IdeaDig五阶段·第3/4段）
- SCORECARD: 价值8 难度5 共性7
  证据8 时效0.9
  → 综合 241.9

④ 证据溯源（全部指针可回查主账本）
- seq49｜wechat_insight｜2026-10-18 23:32:47｜{"signal_id": "s1"}
- seq51｜wechat_insight｜2026-10-18 23:32:48｜{"signal_id": "s2"}

⑤ 下一步（W4.3/W4.4 人工+门禁链）
对抗校验复核 → 六件套 → 审批闸
"""


def expect(label, cond, detail=""):
    print(f"[{label}] {'OK' if cond else 'NG'} {detail[:160]}")
    assert cond, f"{label}: {detail}"


def spec_ok(**over):
    s = {
        "family": "research_report", "slug": "t-seq49",
        "one_liner": "三场景一册，依据全指针可溯源",
        "signal_anchor": "同诉求双群7日观测12次(seq49杂谈4次+seq54总包XX 8次)",
        "axes": [
            {"axis": "时效", "multiplier": 10, "counted": True,
             "anchor": "自行汇编以工作日计→一次到手(seq49)",
             "falsifiable": "附录任抽5条自行从零定位合计<1工作日=伪"},
            {"axis": "质量", "multiplier": 10, "counted": True,
             "anchor": "依据带标准号100%溯源 vs 群内真假混杂(seq51)",
             "falsifiable": "溯源表抽检任一条无指针=伪"},
            {"axis": "变现", "multiplier": 0, "counted": False,
             "anchor": "上架即走既有发布链(实测在役)",
             "falsifiable": "发布链五段实测齐备"},
        ],
        "wbs": [{"step": "S1 定纲", "what": "骨架+调研", "reuse": "七源管线",
                 "hours": 4, "acceptance": "四自查绿"}],
        "cost": "全本地在役；你侧≈30分钟",
        "risks": ["数字零造假：无源不入稿", "kill开关：不可溯源即降级如实告知"],
        "reply_opts": "「批准」=排产｜「否决」=弃案｜「修改 你的意见」=重铸",
        "benefit": "直连在役研报产线变现",
    }
    s.update(over)
    return s


def main() -> int:
    t0 = time.time()
    print("== W4.3 sixpack 契约测试 ==")

    # 1) 草案解析
    d = parse_draft(DRAFT)
    expect("parse", d["run_id"] == "R20261023-182636"
           and d["title"] == "报价与计价依据支持"
           and d["score"] == 241.9 and d["seqs"] == [49, 51]
           and "计价依据" in d["capability"], json.dumps(d, ensure_ascii=False))
    try:
        parse_draft("# 不是草案\n无头")
        bad = "未抛错"
    except ValueError:
        bad = ""
    expect("parse-reject", bad == "", bad)

    # 2) 门1 产品族
    ok, fam = gate_family(spec_ok(), d)
    expect("family-ok", ok and fam == "研究报告", fam)
    ok, why = gate_family(spec_ok(family="kb_builder"), d)
    expect("family-whitelist", not ok and "白名单" in why, why)
    ok, why = gate_family(spec_ok(one_liner="一键构建企业知识库"), d)
    expect("family-kb-ban", not ok and "KB禁区" in why, why)
    ok, why = gate_family(spec_ok(family="deployed_tool",
                                  one_liner="纯英文 kb of docs"), d)
    expect("family-kb-word", not ok and "KB禁区" in why, why)

    # 3) 门2 SCORECARD（离线桩默认过门；注入低分验地板）
    ok2, card = gate_scorecard(StubScorecardLlm(), d, spec_ok())
    expect("card-ok", ok2 and card["weighted"] == 7.5 and card["worst"] == 7.0,
           json.dumps(card, ensure_ascii=False))
    ok2, card = gate_scorecard(
        StubScorecardLlm({"feasibility": 2, "value": 9,
                          "monetization": 9, "tenx": 9}), d, spec_ok())
    expect("card-floor", not ok2 and card["worst"] == 2.0
           and card["pass"] is False, json.dumps(card, ensure_ascii=False))

    # 4) 门3 DeltaIndex
    ok, dt = gate_delta(spec_ok()["axes"])
    expect("delta-ok", ok and abs(dt["sigma"] - 2.0) < 1e-9
           and dt["claim_x"] == 100, json.dumps(dt, ensure_ascii=False))
    ok, dt = gate_delta([{"axis": "时效", "multiplier": 5, "counted": True,
                          "anchor": "无seq锚的倍率", "falsifiable": "判据"}])
    expect("delta-noanchor", not ok and any("seq指针" in f for f in dt["fails"]),
           json.dumps(dt, ensure_ascii=False))
    ok, dt = gate_delta([{"axis": "时效", "multiplier": 10, "counted": True,
                          "anchor": "seq49锚", "falsifiable": ""},
                         {"axis": "质量", "multiplier": 3, "counted": True,
                          "anchor": "seq51锚", "falsifiable": "判据"}])
    expect("delta-nofalsify+lowsum", not ok
           and any("可证伪" in f for f in dt["fails"])
           and dt["sigma"] < 2.0, json.dumps(dt, ensure_ascii=False))
    ok, dt = gate_delta([])
    expect("delta-empty", not ok and "零轴" in dt["fail"], json.dumps(dt))
    ok, dt = gate_delta([{"axis": "变现", "multiplier": 0, "counted": False,
                          "anchor": "期权锚"}])
    expect("delta-option-needs-judge", not ok, json.dumps(dt, ensure_ascii=False))

    # 5) 全链cast: 过门渲染+私有账本+默认不push
    work = Path(tempfile.mkdtemp(prefix="sixpack_t_"))
    dp = work / "draft.md"
    dp.write_text(DRAFT, encoding="utf-8")
    led = work / "forge.jsonl"
    res = cast(dp, spec_ok(), llm=StubScorecardLlm(),
               out_dir=work, ledger_file=led)
    expect("cast-pass", res["pass"] and res["out"]
           and res["gates"]["family"]["pass"]
           and res["gates"]["delta"]["sigma"] >= 2.0,
           json.dumps(res, ensure_ascii=False)[:300])
    body = Path(res["out"]).read_text(encoding="utf-8")
    expect("render-6sections", all(f"\n\n{x}" in body for x in
                                   "①②③④⑤⑥") and body.count("\n\n") >= 6,
           body[:120])
    expect("render-watermark", "W4.3铸模成品" in body
           and "离线桩评分(禁推送)" in body and "门1/2/3全过" in body)
    expect("render-gate-line", "ΔΣlog10=2.00" in body
           and "SCORECARD=7.5/10" in body and "seq49" in body)
    expect("render-wbs", "S1 定纲" in body and "现成件" in body and "验收" in body)
    events = [json.loads(x) for x in led.read_text(encoding="utf-8").splitlines()]
    expect("ledger-event", len(events) == 1 and events[0]["event"] == "w43_cast"
           and events[0]["detail"]["pass"] is True, str(events)[:200])

    # 6) 门禁失败链: 族外→零输出只落账
    res2 = cast(dp, spec_ok(family="chatbot"), llm=StubScorecardLlm(),
                out_dir=work, ledger_file=led)
    outs = list(work.glob("*六件套*.md"))
    expect("cast-fail-noout", (not res2["pass"] and res2["out"] is None
                               and len(outs) == 1
                               and len(led.read_text(encoding='utf-8').splitlines()) == 2),
           json.dumps(res2, ensure_ascii=False)[:200])

    # 7) push: 默认关；离线桩禁推；cmd构造正确
    res3 = cast(dp, spec_ok(), llm=StubScorecardLlm(),
                out_dir=work, ledger_file=led, push=True)
    expect("push-stub-blocked", res3["pass"] and res3["pushed"] is False
           and "禁推" in res3.get("push_error", ""),
           json.dumps(res3, ensure_ascii=False)[:200])
    cmd = build_push_cmd(d, spec_ok(), Path("x.md"), "W4.4", "")
    expect("push-cmd", cmd[1:4] == ["-X", "utf8", "approval_gate.py"]
           and "--body-file" in cmd and "x.md" in cmd[-1]
           and "提案：" in cmd[cmd.index("--title") + 1], " ".join(cmd))

    # 8) demo-spec 模板可跑cast（换计数轴两枚10×保Σ门）
    demo = json.loads(json.dumps(__import__("forge.sixpack", fromlist=["x"])
                                 .DEMO_SPEC))
    demo["slug"] = "t-demo"
    demo["family"] = "solution"
    demo["axes"] = spec_ok()["axes"]
    res4 = cast(dp, demo, llm=StubScorecardLlm(),
                out_dir=work, ledger_file=led)
    expect("demo-spec-castable", res4["pass"] and "解决方案" in res4["gates"]["family"]["detail"],
           json.dumps(res4.get("gates", {}), ensure_ascii=False)[:200])

    print(f"== 全绿 ({time.time() - t0:.1f}s) ==")
    return 0


if __name__ == "__main__":
    sys.exit(main())
