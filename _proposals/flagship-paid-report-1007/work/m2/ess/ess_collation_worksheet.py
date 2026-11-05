# -*- coding: utf-8 -*-
"""ess_collation_worksheet — 收编工作单生成器 (EPC-ESS 第14份, 照 LUMPSUM 第13份).

输入: sched/_chXX_nblm.adversarial.json + _chXX_claims.json + bank_chXX.md
输出: sched/collation/_chXX_worksheet.md — 每章一份收编任务单:
  A. 对抗需修正项 (bear反证 point/type/detail/anchor + bull原论点/原quote)
  B. claims核查口径 (claim句数/tally/pass_rate)
  C. bank锚谱 (P锚数/头部锚列表/字节数)
  D. 编辑法引用 (caselaw _ch01_collation_ledger.md 为格式模板)
用法: py -X utf8 ess_collation_worksheet.py
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
SCHED = HERE / "sched"
OUT = SCHED / "collation"
OUT.mkdir(exist_ok=True)
CASELAW_LEDGER = HERE.parent / "caselaw" / "sched" / "_ch01_collation_ledger.md"

REPORT = "国际储能与光伏EPC总承包投标实战研究报告·2026"


def cjk_len(t: str) -> int:
    return len(re.findall(r"[一-鿿]", t))


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    tot_fix = 0
    for nn in [str(i).zfill(2) for i in range(1, 13)]:
        adv_p = SCHED / f"_ch{nn}_nblm.adversarial.json"
        clm_p = SCHED / f"_ch{nn}_claims.json"
        md_p = SCHED / f"_ch{nn}_nblm.md"
        bank_p = SCHED / f"bank_ch{nn}.md"
        if not adv_p.is_file():
            print(f"[skip] ch{nn} 无对抗件")
            continue
        adv = json.loads(adv_p.read_text(encoding="utf-8"))
        clm = json.loads(clm_p.read_text(encoding="utf-8")) if clm_p.is_file() else {}
        md = md_p.read_text(encoding="utf-8", errors="replace") if md_p.is_file() else ""
        bank = bank_p.read_text(encoding="utf-8", errors="replace")
        anchors = re.findall(r"^## (P\d+)", bank, flags=re.M)

        fixes = []
        for r in adv.get("results", []):
            for c in r.get("bear", {}).get("counter_arguments", []):
                fixes.append({
                    "point": c.get("point", ""),
                    "type": c.get("type", ""),
                    "detail": c.get("detail", ""),
                    "anchor": c.get("anchor", ""),
                })
        tally = (clm.get("summary") or {}).get("tally", {})
        sents = (clm.get("summary") or {}).get("sentences_total", "?")
        claims_n = (clm.get("summary") or {}).get("claim_sentences", "?")

        lines = [
            f"# 收编工作单 · 第{int(nn)}章 ({REPORT})",
            "",
            f"- 源稿: `_ch{nn}_nblm.md` ({len(md):,}B / CJK {cjk_len(md):,})",
            f"- bank: `bank_ch{nn}.md` ({len(bank):,}B / P锚 {len(anchors)} 个)",
            f"- claims: 句{sents} / claim句{claims_n} / {json.dumps(tally, ensure_ascii=False)}",
            f"- 对抗裁决: {json.dumps(adv.get('verdict_tally', {}), ensure_ascii=False)}",
            f"- 格式模板: `{CASELAW_LEDGER}` (caselaw ch01 收编账, 照此结构写台账)",
            "",
            f"## A. 需修正项 ({len(fixes)} 条, 逐条回写+复审)",
            "",
        ]
        for i, f in enumerate(fixes, 1):
            lines += [
                f"### A{i}. {f['point']}",
                f"- 类型: {f['type']} | bear锚: {f['anchor']}",
                f"- 反证细节: {f['detail']}",
                "- 处置: [待编辑: 软化绝对化表述/补反证条件/挂bank实锚, 完成后打钩]",
                "",
            ]
        lines += [
            "## B. 收编编辑法 (照 caselaw 产线, 五步)",
            "",
            "1. **P锚挂接**: 章内引用/项目数据/政策文号逐节过, 挂 bank P锚 (尾注或行内`Pxxxxxx`),",
            "   幽灵锚清零; bank 无据的构造数→改挂实锚或打「示意性标签」并声明.",
            "2. **数字修正**: 一切统计数/装机量/金额/造价指标/政策文号与 bank 逐一对勘,",
            "   构造数按「如实转录+边界声明」或删除 (数字零造假).",
            "3. **对抗回写**: A 节每条落地到正文 (软化/加条件/补反证), 复审打钩.",
            "4. **体裁统一**: 章尾保留/补齐「本章小结与盲区」块; 全章零 AI 腔/零来源标注腔.",
            "5. **产出三件**: `_ch{nn}_final.md` + `_ch{nn}_collation_ledger.md`",
            "   (照模板结构: 产出件清单/锚映射/数字修正账/项目修正账/对抗回写账) +",
            "   台账头记 CJK 门 (≥15,000, 终稿不得低于源稿).",
            "",
            "## C. bank 头部锚 (前 12)",
            "",
            ", ".join(anchors[:12]),
            "",
        ]
        (OUT / f"_ch{nn}_worksheet.md").write_text("\n".join(lines), encoding="utf-8")
        tot_fix += len(fixes)
        print(f"[OK] ch{nn} worksheet: 修正{len(fixes)}条 claim句{claims_n} P锚{len(anchors)}")
    print(f"[done] 12章工作单落 {OUT} | 总修正项 {tot_fix}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
