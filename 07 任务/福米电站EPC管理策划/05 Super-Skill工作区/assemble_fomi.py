# -*- coding: utf-8 -*-
"""assemble_fomi - 组装《几内亚福米水电站EPC建设管理策划方案》初稿.
结构: 封面信息块 + 综合说明(_ch00) + 第1-16章(_ch01..16) + 附录A-E + 留白统计.
用法: py -X utf8 assemble_fomi.py [--out 策划方案_初稿_v0.1.md]
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
WS = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划\05 Super-Skill工作区")
OUT = WS / "nblm_out"
DOCKET = WS / "RESEARCH_DOCKET"
TITLE = "几内亚福米水电站EPC建设管理策划方案"

COVER = f"""# {TITLE}

**编制单位：黄河勘测规划设计研究院有限公司**
**版本：初稿 v0.1（NBLM 产线 16 章生成版，待红队审查与排版）**
**日期：2026-11**

---

"""


def appendix_blocks() -> list:
    ap = []
    bank = DOCKET / "synth" / "appendix_bank"
    if (bank / "A_三层对标矩阵(银行版).md").is_file():
        pairs = [
            ("附录A 三层对标矩阵（GB/T 50358-2017 × PMBOK × PMI/IPMA）",
             bank / "A_三层对标矩阵(银行版).md"),
            ("附录B GB/T 50358-2017 条款覆盖表（17章终裁版）",
             bank / "B_GB覆盖表(银行版).md"),
            ("附录C 数字口径说明",
             bank / "C_数字口径说明(银行版).md"),
            ("附录D 审贷前件清单与闭合安排",
             bank / "D_审贷前件清单.md"),
            ("附录E 图表素材到位清单",
             DOCKET / "synth" / "最小图片清单.md"),
        ]
        for title, fp in pairs:
            if fp.is_file():
                ap.append(f"\n\n---\n\n# {title}\n\n"
                          + fp.read_text(encoding="utf-8", errors="replace"))
        return ap
    pairs = [
        ("附录A 三层对标矩阵（GB/T 50358-2017 × PMBOK × PMI/IPMA）",
         DOCKET / "synth" / "S1_对标矩阵与目录框架.md"),
        ("附录B GB/T 50358-2017 条款级对照表（17章终裁版）",
         DOCKET / "synth" / "附录B_GB条款对照.md"),
        ("附录C 数字基准表（全文数字唯一权威源）",
         DOCKET / "synth" / "数字基准表.md"),
        ("附录D 图表素材到位清单（最小图片8件+降级预案）",
         DOCKET / "synth" / "最小图片清单.md"),
        ("附录E 素材缺口待供清单（G-01~G-15）",
         DOCKET / "synth" / "S2_黄河院素材台账.md"),
    ]
    for title, fp in pairs:
        if not fp.is_file():
            continue
        ap.append(f"\n\n---\n\n# {title}\n\n")
        text = fp.read_text(encoding="utf-8", errors="replace")
        if title.startswith("附录E"):
            m = re.search(r"(缺口清单|G-01)[\s\S]{0,12000}", text)
            text = m.group(0) if m else text[:12000]
        elif title.startswith("附录A"):
            text = text[:16000]
        ap.append(text)
    return ap


def main() -> int:
    out_name = "策划方案_初稿_v0.1.md"
    if "--out" in sys.argv:
        out_name = sys.argv[sys.argv.index("--out") + 1]
    no_appendix = "--no-appendix" in sys.argv
    parts = [COVER]
    missing = []
    es = OUT / "_ch00_综合说明.md"
    if es.is_file():
        parts.append("\n# 综合说明（执行摘要）\n\n"
                     + es.read_text(encoding="utf-8", errors="replace"))
    else:
        missing.append("综合说明")
    for i in range(1, 21):            # 20章(含第4章设计院牵头EPC优势)
        fp = OUT / f"_v2_ch{i:02d}.md"
        if not fp.is_file():
            fp = OUT / f"_ch{i:02d}.md"
        if fp.is_file():
            parts.append("\n\n---\n\n" + fp.read_text(encoding="utf-8",
                                                      errors="replace"))
        else:
            missing.append(f"第{i}章")
    if not no_appendix:
        parts.extend(appendix_blocks())
    body = "".join(parts)
    cjk = len(re.findall(r"[一-鿿]", body))
    blanks = len(re.findall(r"【待(供给|核|续)", body))
    fp = WS / out_name
    fp.write_text(body, encoding="utf-8")
    print(f"[asm] {out_name}: {len(body):,}字 CJK {cjk:,} | "
          f"缺章: {missing or '无'} | 留白标记 {blanks} 处"
          + (" | 无附录交付版" if no_appendix else ""))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
