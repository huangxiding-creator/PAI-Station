# -*- coding: utf-8 -*-
"""_nb_top8_bank_dedupe — top8 重跑后 bank_chNN.md 的 NB 锚块去重 (1026 NB初稿铁律强化令).

背景: sched_nb_draft.py 每跑一次都会把 NB 块「追加」进 bank_chNN.md 尾部。
top3(旧跑) → top8(重跑) 后, P{ch}0051-53 各出现两份 (旧在先/新在后)。
本件处理 (任务明示「重跑后若重复追加以去重处理如实记录」):
  1) 逐 bank 比对旧/新块 md5 → 删旧留新 (新 top8 的前 3 篇即旧 top3);
  2) bank_ch04: 新 NB4-6 按公式落锚 P000354-356, 与第4章写作期补录区
     (P000354/355/356, 数字零造假链在用) 撞锚 → 新 NB 块重编号为
     P000359/P000360/P000361, 补录区一字不动;
  3) 全程逐块记录 sched/_nb_dedupe_log.json。
用法: py -X utf8 _nb_top8_bank_dedupe.py
"""
from __future__ import annotations

import hashlib
import json
import re
import sys
from pathlib import Path

M2 = Path(__file__).resolve().parent / "sched"
ANCHOR_RE = re.compile(r"^## (P\d{6}) \(([^)]*)")
COMMENT_RE = re.compile(r"^<!-- ======== 补录区")
REN = {"P000354": "P000359", "P000355": "P000360", "P000356": "P000361"}

log = {"when": "2026-10-26 top8 rerun dedupe", "banks": {}}


def md5(t: str) -> str:
    return hashlib.md5(t.encode("utf-8", errors="replace")).hexdigest()[:12]


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    for ch in range(1, 13):
        fp = M2 / f"bank_ch{ch:02d}.md"
        lines = fp.read_text(encoding="utf-8").splitlines(keepends=True)
        heads = [(i, m.group(1), m.group(2))
                 for i, ln in enumerate(lines) if (m := ANCHOR_RE.match(ln))]
        # 块边界 = 下一个锚头; 若中间夹着补录区注释行则截到注释前 (保注释)
        blocks = []
        for k, (i, a, lab) in enumerate(heads):
            b = heads[k + 1][0] if k + 1 < len(heads) else len(lines)
            for j in range(i + 1, b):
                if COMMENT_RE.match(lines[j]):
                    b = j
                    break
            blocks.append({"i": i, "end": b, "anchor": a, "label": lab,
                           "md5": md5("".join(lines[i:b]))})
        nb = [b for b in blocks if b["label"].startswith("NB章基底")]
        bk = {"nb_blocks_found": len(nb),
              "anchors": [b["anchor"] for b in nb], "removed": [], "md5_pairs": [],
              "renumbered": []}
        # 找重复锚 (同锚两块且均为 NB): 删第一份 (旧)
        remove_ranges = []
        by_anchor: dict[str, list] = {}
        for b in nb:
            by_anchor.setdefault(b["anchor"], []).append(b)
        for a, bs in by_anchor.items():
            if len(bs) == 2:
                old, new = bs[0], bs[1]
                same = old["md5"] == new["md5"]
                bk["md5_pairs"].append({"anchor": a, "old_md5": old["md5"],
                                        "new_md5": new["md5"], "identical": same})
                remove_ranges.append((old["i"], old["end"]))
                bk["removed"].append({"anchor": a, "lines": old["end"] - old["i"],
                                      "identical_to_new": same})
        for i0, i1 in sorted(remove_ranges, reverse=True):
            del lines[i0:i1]
        # ch04: 新 NB 块撞补录锚 → 重编号
        if ch == 4:
            for ln_i, ln in enumerate(lines):
                m = ANCHOR_RE.match(ln)
                if m and m.group(2).startswith("NB章基底") and m.group(1) in REN:
                    lines[ln_i] = ln.replace(f"## {m.group(1)} (",
                                             f"## {REN[m.group(1)]} (", 1)
                    bk["renumbered"].append({"from": m.group(1),
                                             "to": REN[m.group(1)]})
        fp.write_text("".join(lines), encoding="utf-8")
        # 终态自检: NB 锚全唯一
        final = [m.group(1) for ln in lines if (m := ANCHOR_RE.match(ln))
                 and m.group(2).startswith("NB章基底")]
        bk["final_nb_anchors"] = final
        bk["final_unique"] = len(final) == len(set(final)) == 8
        log["banks"][f"ch{ch:02d}"] = bk
        print(f"[dedupe] ch{ch:02d} NB块{bk['nb_blocks_found']}→{len(final)} "
              f"删旧{len(bk['removed'])} 重编号{len(bk['renumbered'])} "
              f"唯一性={'OK' if bk['final_unique'] else 'FAIL'}")
    (M2 / "_nb_dedupe_log.json").write_text(
        json.dumps(log, ensure_ascii=False, indent=1), encoding="utf-8")
    print("[dedupe] log → sched/_nb_dedupe_log.json")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
