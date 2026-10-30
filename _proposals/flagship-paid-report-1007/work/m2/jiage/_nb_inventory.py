# -*- coding: utf-8 -*-
"""_nb_inventory — NB 123 篇全量清单导出 (1026 钉选兜底选材用).

复刻 sched_nb_draft.py 的切篇/去重逻辑, 输出 sched/_nb_inventory.json:
每篇 {title, vol, chars, norm, hit_kws: 对四薄命中章检索词的命中清单}.
纯只读, 不改任何既有文件。
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

M2 = Path(__file__).resolve().parent / "sched"
NB = Path(r"E:\AI-Station\ResearchFactory-Eng\NB_MD_library_v2")
VOLS = ["90_研究报告成果合集_vol001.md", "90_研究报告成果合集_vol002.md",
        "90_研究报告成果合集_vol003.md", "91_法规共性资料_vol001.md"]
BLOCK_HEAD = "\n\n---\n\n# "
MIN_CHARS = 2000

PIN_KWS = {  # 四薄命中章检索词 (chapters.json 口径)
    "ch2": ["计价规范", "管理办法", "住建部", "定额", "造价管理"],
    "ch5": ["信息价", "市场价", "材料价", "价差", "造价指数"],
    "ch6": ["招标控制价", "控制价", "投标报价", "招投标", "评标"],
    "ch7": ["综合单价", "组价", "措施项目费", "不平衡报价", "工程量清单"],
}


def norm_title(s: str) -> str:
    s = re.sub(r"^《[^》]*》\s*/\s*", "", s.strip())
    s = re.sub(r"_(citefixed|conf)(?=\.md$|$)", "", s)
    s = re.sub(r"\s*\[目标字数[^\]]*\]", "", s)
    s = re.sub(r"\.md$", "", s)
    s = s.replace("_", " ").replace("　", " ")
    s = re.sub(r"\s+", " ", s)
    return s.strip()[:60]


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    segs_all = []
    for vol in VOLS:
        fp = NB / vol
        if not fp.is_file():
            continue
        raw = fp.read_text(encoding="utf-8", errors="replace")
        for seg in raw.split(BLOCK_HEAD)[1:]:
            nl = seg.find("\n", 1)
            title = seg[:nl].strip() if nl > 0 else seg.strip()[:80]
            if len(seg) < MIN_CHARS:
                continue
            segs_all.append((title, vol, BLOCK_HEAD + seg))
    by_title: dict[str, tuple[str, str, int]] = {}
    for title, vol, text in segs_all:
        base = norm_title(title)
        if base not in by_title or len(text) > by_title[base][2]:
            by_title[base] = (vol, text, len(text))
    inv = []
    for base, (vol, text, n) in by_title.items():
        head = text[:6000]
        hits = {ch: [k for k in kws if k in head[:2000] or k in text[:6000]]
                for ch, kws in PIN_KWS.items()}
        # 与计分口径一致: 标题命中 + 头部命中
        inv.append({"norm": base, "vol": vol, "chars": n,
                    "hit_ch": {c: v for c, v in hits.items() if v}})
    inv.sort(key=lambda r: (-len(r["hit_ch"]), -r["chars"]))
    (M2 / "_nb_inventory.json").write_text(
        json.dumps(inv, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[inv] {len(inv)} 篇 → sched/_nb_inventory.json")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
