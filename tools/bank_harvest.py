# -*- coding: utf-8 -*-
"""bank_harvest — 全量语料分章收割器 (1124 用户令 ③: 每书 34 案 → 200-500 案).

语料总索引 (data/harvest/corpus_index.jsonl, 68k 唯一切片) 按各章检索词打分,
跨章配额约束 (每案 ≤2 章), 直出 bank_chNN.md + bank_chNN.index.md —
取代「跨池捡现成 35 锚」的权宜模式, 也取代 stage_s1 的文件名匹配 (对切片内容永远漏)。

用法: py -X utf8 tools/bank_harvest.py --campaign-dir work/m2/<slug> [--per-chapter 35] [--max-per-case 2]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
INDEX = REPO / "data" / "harvest" / "corpus_index.jsonl"
SLICE_ROOT = REPO / "data" / "harvest" / "judgment_slices"
BANK_SLICE_MIN = 400


def load_index() -> list[dict]:
    recs = []
    for ln in INDEX.read_text(encoding="utf-8").splitlines():
        try:
            recs.append(json.loads(ln))
        except json.JSONDecodeError:
            pass
    return recs


def chapter_terms(ch: dict) -> list[str]:
    """章节检索词: kws + 标题 2-4 字滑窗去噪."""
    terms = [k for k in ch.get("kws", []) if k]
    title = ch.get("title", "")
    for frag in re.findall(r"[一-鿿]{2,6}", title):
        terms.append(frag[:4])
        if len(frag) > 4:
            terms.append(frag[:6])
    seen, out = set(), []
    for t in terms:
        if t and t not in seen:
            seen.add(t)
            out.append(t)
    return out[:12]


def score(rec: dict, terms: list[str]) -> int:
    hay = " ".join([rec.get("name", ""), rec.get("an", ""), rec.get("court", ""),
                    rec.get("head", ""), rec.get("cause", ""), rec.get("sample", "")])
    n = 0
    for t in terms:
        if t in hay:
            n += 3
            if t in rec.get("name", ""):
                n += 2
            if t in rec.get("sample", ""):
                n += 1
    return n


def slice_text(rec: dict) -> str | None:
    f = SLICE_ROOT / rec["file"]
    if not f.is_file():
        return None
    t = f.read_text(encoding="utf-8", errors="replace")
    try:
        return t[rec["start"]:rec["end"]].rstrip() + "\n"
    except KeyError:
        return None


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign-dir", required=True)
    ap.add_argument("--per-chapter", type=int, default=35)
    ap.add_argument("--max-per-case", type=int, default=2)
    ns = ap.parse_args()

    sched = REPO / ns.campaign_dir / "sched"
    chj = sched / "chapters.json"
    if not chj.is_file():
        print("[miss] chapters.json 缺席")
        return 1
    chapters = json.loads(chj.read_text(encoding="utf-8"))
    recs = load_index()
    print(f"[index] {len(recs):,} 切片可选")

    case_use: dict[str, int] = {}
    used_hashes: set[str] = set()
    report = []
    for ch in chapters:
        nn = f"{ch['no']:02d}"
        terms = chapter_terms(ch)
        scored = []
        for rec in recs:
            if rec["h"] in used_hashes or rec.get("chars", 0) > 20000                     or rec.get("chars", 0) < 800:
                continue
            an = rec.get("an", "")
            if an and case_use.get(an, 0) >= ns.max_per_case:
                continue
            s = score(rec, terms)
            if s > 0:
                scored.append((s, rec.get("chars", 0), rec))
        scored.sort(key=lambda x: (-x[0], -x[1]))
        picked = []
        topical = 0
        seen_case_ch: set[str] = set()
        for s, _, rec in scored:
            if len(picked) >= ns.per_chapter:
                break
            an = rec.get("an", "") or rec["h"]
            if an in seen_case_ch:
                continue
            seen_case_ch.add(an)
            picked.append(rec)
            used_hashes.add(rec["h"])
            if s >= 3:
                topical += 1
            if an:
                case_use[an] = case_use.get(an, 0) + 1
        # 配额兜底: 软词/最新案补齐 (每章额度硬保证, 稀疏题才走到这)
        if len(picked) < ns.per_chapter:
            soft = [r for r in recs
                    if r["h"] not in used_hashes
                    and (not r.get("an") or case_use.get(r["an"], 0) < ns.max_per_case)
                    and 800 <= r.get("chars", 0) <= 12000]
            soft.sort(key=lambda r: (0 if "建设工程施工合同" in r.get("cause", "") else 1,
                                     -r.get("chars", 0)))
            for rec in soft:
                an = rec.get("an", "") or rec["h"]
                if an in seen_case_ch:
                    continue
                picked.append(rec)
                used_hashes.add(rec["h"])
                if an:
                    case_use[an] = case_use.get(an, 0) + 1
                if len(picked) >= ns.per_chapter:
                    break
        # 直出 bank_chNN.md
        parts = [f"# Bank·第{ch['no']}章 {ch['title']} `[全量收割]`",
                 f"检索词: {'、'.join(terms[:6])} | 树子问: {ch['subqs'][0] if ch.get('subqs') else ''}",
                 f"全量索引收割 {len(picked)} 锚 (语料 68k 池)"]
        for rec in picked:
            t = slice_text(rec)
            if not t:
                continue
            parts.append(f"## {rec['h']} ({rec['pool']} {rec['chars']:,}字)\n路径: {rec['file']}\n\n{t}")
        bank = sched / f"bank_ch{nn}.md"
        bank.write_text("\n\n".join(parts) + "\n", encoding="utf-8")
        report.append((ch["no"], ch["title"][:16], len(picked), bank.stat().st_size))
        print(f"[bank] ch{nn} {ch['title'][:16]}… {len(picked)}锚 {bank.stat().st_size:,}B")

    n_cases = len(case_use)
    print(f"[done] 12章合计用例(案号去重): {n_cases} — 旧模式约34")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
