# -*- coding: utf-8 -*-
"""book_derivs — 一书裂变多形态 (1124 用户令 ⑤: 书是源, 15 SKU 任务的 v1 四件).

v1 四件: 速读版 / 行动清单版 / zhuanlan连载(12篇) / KB条目包
派生确定性提取 (导语+小结+金句), 零模型调用, 秒级完成。

用法: py -X utf8 tools/book_derivs.py --campaign-dir work/m2/<slug> --campaign EPC-XX --title 《书名》
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]


def cjk(t: str) -> int:
    return len(re.findall(r"[一-鿿]", t))


def chapter_parts(t: str) -> dict:
    m = re.search(r"^# (第.+章 .+)$", t, re.M)
    title = m.group(1) if m else ""
    summ = re.search(r"^### \d+\.\d+(?:\.\d+)? 本章小结.*?$\n(.*?)(?=^### |\Z)", t, re.M | re.S)
    daol = re.search(r"^# .+?$\n(.*?)(?=^## )", t, re.M | re.S)
    bolds = re.findall(r"^\*\*([^*]+)\*\*$", t, re.M)
    return {"title": title, "summary": summ.group(1).strip() if summ else "",
            "lead": daol.group(1).strip()[:1200] if daol else "", "bolds": bolds}


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign-dir", required=True)
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--title", required=True)
    ns = ap.parse_args()
    sched = REPO / ns.campaign_dir / "sched"
    out = REPO / "data" / "factory" / "products" / ns.campaign
    out.mkdir(parents=True, exist_ok=True)

    sudu = [f"# {ns.title}·速读版", ""]
    chk = [f"# {ns.title}·行动清单版", ""]
    zhuanlan = []
    for f in sorted(sched.glob("_ch*_final.md")):
        t = f.read_text(encoding="utf-8", errors="replace")
        p = chapter_parts(t)
        if not p["title"]:
            continue
        nn = f.stem[3:5]
        sudu += [f"## {p['title']}", "", (p["summary"] or p["lead"])[:2800], ""]
        for line in (p["summary"] or "").split("\n"):
            if re.match(r"^\d+[.、]", line.strip()):
                chk.append(f"- [{p['title'][1:5]}] {line.strip()[:130]}")
        # 专栏连载: 导语+金句+小结 = 每章一篇独立可发的专栏稿
        col = [f"# {ns.title}·连载{int(nn)} | {p['title']}", "",
               f"> {ns.title} 第{int(nn)}/12 篇连载 · 出品：总包创研院研究团队", ""]
        if p["lead"]:
            col += [p["lead"], ""]
        for b in p["bolds"][:3]:
            col += [f"**{b}**", ""]
        if p["summary"]:
            col += ["## 本章十条", "", p["summary"], ""]
        (out / f"zhuanlan_{int(nn):02d}.md").write_text("\n".join(col), encoding="utf-8")
        zhuanlan.append(nn)

    (out / "速读版.md").write_text("\n".join(sudu), encoding="utf-8")
    (out / "行动清单版.md").write_text("\n".join(chk), encoding="utf-8")
    kb = {"campaign": ns.campaign, "title": ns.title,
          "entries": [{"id": f"{ns.campaign}-ch{int(nn):02d}",
                       "file": f"zhuanlan_{int(nn):02d}.md"} for nn in zhuanlan]}
    (out / "kb_entries.json").write_text(json.dumps(kb, ensure_ascii=False, indent=1),
                                         encoding="utf-8")
    print(f"[derivs] 速读版 {cjk(chr(10).join(sudu)):,}字 | 清单 {len(chk)-2}条 | "
          f"zhuanlan {len(zhuanlan)}篇 | KB条目 {len(zhuanlan)} → {out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
