# -*- coding: utf-8 -*-
"""_audit_nblm — NBLM 章稿验收审计 (ch1试产门 + 滚动账).

验收四查 (数字零造假, 全实测):
  1) CJK 字数 (门: ≥15000)
  2) 结构: 章标题/小节数
  3) 源引用可溯: [源N] 引用分布 vs 该笔记本实际上传源清单 (缺失/编造编号)
  4) dupcheck: 重复段/重复标题计数
用法: py -X utf8 _audit_nblm.py 1 [2 3 ...]   # 章号; 无参=全部已有稿
"""
from __future__ import annotations

import json
import re
import sys
from collections import Counter
from pathlib import Path

HERE = Path(__file__).resolve().parent
CJK_GATE = 15000


def cjk(t: str) -> int:
    return len(re.findall(r"[一-鿿]", t))


def audit(nn: str, bank_no: str | None) -> dict:
    p = HERE / f"_ch{nn}_nblm.md"
    if not p.is_file():
        return {"ch": nn, "missing": True}
    t = p.read_text(encoding="utf-8")
    heads = [l.strip() for l in t.split("\n") if re.match(r"^#{1,4}\s+\S", l.strip())]
    sec = [h for h in heads if re.match(r"^#{2,3}\s", h)]
    cites_raw = (re.findall(r"\[源\s*(\d{1,2})\]", t)
                 + re.findall(r"\[S(\d{1,2})\]", t)
                 + re.findall(r"\[(\d{1,2})\]", t))
    cites = [str(int(c)) for c in cites_raw]
    cc = Counter(cites)
    src_dir = HERE / "nblm_upload" / f"ch{bank_no or nn}_笔记本"
    have = set()
    if src_dir.is_dir():
        for f in src_dir.glob("*.md"):
            m = re.match(r"(\d+)", f.name)
            if m:
                have.add(str(int(m.group(1))))
    ghost = sorted({c for c in cc if c not in have}, key=int)
    paras = [x.strip() for x in re.split(r"\n+", t) if len(x.strip()) >= 30]
    dpc = sum(v - 1 for v in Counter(paras).values() if v > 1)
    dhd = sum(v - 1 for v in Counter(heads).values() if v > 1)
    ai_ref = bool(re.search(r"AI|人工智能|大模型|GPT|Claude|NotebookLM|机器生成", t))
    return {
        "ch": nn, "file": p.name, "bytes": p.stat().st_size,
        "cjk": cjk(t), "gate": CJK_GATE, "gate_hit": cjk(t) >= CJK_GATE,
        "h2h3": len(sec), "cited_sources": len(cc),
        "citations_total": sum(cc.values()),
        "src_available": len(have), "ghost_cites": ghost,
        "dup_paras": dpc, "dup_heads": dhd,
        "ai_mention": ai_ref,
    }


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    chs = json.loads((HERE / "chapters_nblm.json").read_text(encoding="utf-8")) \
        if (HERE / "chapters_nblm.json").is_file() else []
    ledger = json.loads((HERE / "nblm_ledger.json").read_text(encoding="utf-8")) \
        if (HERE / "nblm_ledger.json").is_file() else {"chapters": {}}
    nums = sys.argv[1:]
    files = sorted(HERE.glob("_ch*_nblm.md"))
    if not nums:
        nums = [f.name[3:5] for f in files]
    nums = [n.zfill(2) for n in nums]
    rows = []
    for n in nums:
        bank = str(ledger["chapters"].get(n, {}).get("bank_no", "")).zfill(2) \
            if ledger["chapters"].get(n, {}).get("bank_no") else None
        r = audit(n, bank)
        rows.append(r)
        if r.get("missing"):
            print(f"ch{n}: 无稿")
            continue
        print(f"ch{n}: CJK {r['cjk']:,} (门{r['gate']:,} {'✓' if r['gate_hit'] else '✗'}) "
              f"| 小节{r['h2h3']} | 源引用{r['cited_sources']}/{r['src_available']}种"
              f"{r['citations_total']}次 | 幽灵编号{len(r['ghost_cites'])} "
              f"| dup段{r['dup_paras']} dup题{r['dup_heads']} | 提及AI={r['ai_mention']}")
    (HERE / "nblm_audit.json").write_text(
        json.dumps(rows, ensure_ascii=False, indent=1), encoding="utf-8")
    print("[audit] → nblm_audit.json")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
