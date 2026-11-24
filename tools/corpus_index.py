# -*- coding: utf-8 -*-
"""corpus_index — 判例切片语料总索引 (1124 用户令 ③: 语料广度×100 的地基).

union data/harvest/judgment_slices/**.md 的全部切片 → data/harvest/corpus_index.jsonl
每行: {h, file, start, end(字符偏移), chars, an(案号), court, date, name, cause(案由), head, pool}
一次构建长期复用 (68k 唯一切片 / 3.38亿字); 取原文按 [start:end] 切, 无整文件重复。

用法: py -X utf8 tools/corpus_index.py [--rebuild]
"""
from __future__ import annotations

import hashlib
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
ROOT = REPO / "data" / "harvest" / "judgment_slices"
OUT = REPO / "data" / "harvest" / "corpus_index.jsonl"
META = REPO / "data" / "harvest" / "corpus_index.meta.json"
SLICE_MIN = 400
META_PAT = re.compile(r"^(案号|案件名称|法院|所属地区|案件类型|审理程序|裁判日期|当事人|案由|路径)")


def parse_meta(body: str) -> dict:
    an = re.search(r"案号:\s*([^\n]+)", body)
    court = re.search(r"法院:\s*([^\n]+)", body)
    date = re.search(r"裁判日期:\s*([0-9-]+)", body)
    name = re.search(r"案件名称:\s*([^\n]+)", body)
    cause = re.search(r"案由:\s*([^\n]+)", body)
    head = ""
    for ln in body.splitlines():
        s = ln.strip()
        if len(s) >= 30 and not META_PAT.match(s) and not s.startswith("#"):
            head = s[:200]
            break
    return {
        "an": an.group(1).strip() if an else "",
        "court": court.group(1).strip() if court else "",
        "date": date.group(1) if date else "",
        "name": name.group(1).strip()[:80] if name else "",
        "cause": cause.group(1).strip()[:40] if cause else "",
        "head": head,
        # 内容样本: 正文前800字 (含当事人诉辩/事实开头 — 打分主战场)
        "sample": re.sub(r"\s+", "", body)[:2000],
    }


def build() -> int:
    seen: dict[str, dict] = {}
    n_files = 0
    t0 = time.time()
    for f in sorted(ROOT.rglob("*.md")):
        n_files += 1
        pool = f.parent.name
        rel = str(f.relative_to(ROOT))
        try:
            t = f.read_text(encoding="utf-8", errors="replace")
        except Exception:
            continue
        # 切片边界: 行首 "# " (首块) 与 "\n# " (后续块)
        bounds = [m.start() for m in re.finditer(r"^# ", t, re.M)]
        if not bounds:
            continue
        bounds.append(len(t))
        for i in range(len(bounds) - 1):
            start, end = bounds[i], bounds[i + 1]
            chunk = t[start:end]
            body = chunk.lstrip("# ").strip()
            if len(body) < SLICE_MIN:
                continue
            h = hashlib.md5(body.encode("utf-8", "ignore")).hexdigest()[:12]
            if h in seen:
                continue
            rec = {"h": h, "file": rel, "start": start, "end": end,
                   "chars": len(body), "pool": pool, **parse_meta(body)}
            seen[h] = rec
    OUT.write_text(
        "\n".join(json.dumps(v, ensure_ascii=False) for v in seen.values()) + "\n",
        encoding="utf-8")
    META.write_text(json.dumps({
        "ts": time.strftime("%Y-%m-%d %H:%M:%S"), "files": n_files,
        "slices": len(seen), "chars": sum(v["chars"] for v in seen.values()),
        "schema": "v4-offset-cause-sample2000",
    }, ensure_ascii=False), encoding="utf-8")
    print(f"[index] {n_files} 文件 → {len(seen):,} 唯一切片 "
          f"({sum(v['chars'] for v in seen.values()):,}字) {time.time()-t0:.0f}s")
    return 0


def main() -> int:
    if OUT.is_file() and "--rebuild" not in sys.argv:
        m = json.loads(META.read_text(encoding="utf-8")) if META.is_file() else {}
        if m.get("schema") != "v4-offset-cause-sample2000":
            return build()
        print(f"[index] 已有索引 {m.get('slices','?'):,} 切片 ({m.get('ts','?')} 构建) — 用 --rebuild 重建")
        return 0
    return build()


if __name__ == "__main__":
    raise SystemExit(main())
