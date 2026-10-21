# -*- coding: utf-8 -*-
"""sched_dupcheck — 跨章重复段落终检门 (1021 汲取令落地, 蓝本: Manus live
events[93] 交付前终检: 全书切段→跨文件重复计数必须为 0).

与密度门的分工: 密度门三判据全部是章内自冗余指标, 检不出两章互相复制的
同一段文字 —— 多引擎混产(写手+NBLM+NB三稿制)下跨章重复风险最高, 本门补位。

切段规则 (Manus live 同款): 按空行切段, 取 ≥150 字且非表格/标题/引用行的
正文段建 dict, 跨文件重复计数必须为 0 (白名单行除外)。
排位: sweep 之后、sched_merge_nblm 总装之前; 重复章退回精修。
用法: py -X utf8 sched_dupcheck.py [--dir nblm_out] [--min 150] [--json]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from collections import Counter
from pathlib import Path

M2 = Path(__file__).resolve().parent
OUT_DEFAULT = M2 / "sched" / "nblm_out"
LEDGER = M2 / "sched" / "dup_rejects.jsonl"
# 合法重复: 章末结构标题等模板行 (短于 min 已天然排除, 此处留扩展位)
WHITELIST_EXACT = set()


def segments(text: str, min_chars: int) -> list[str]:
    """空行切段 → 过滤表格/标题/引用/列表行 → 取 ≥min_chars 正文段."""
    segs = []
    for para in re.split(r"\n\s*\n", text):
        p = para.strip()
        if len(p) < min_chars:
            continue
        lines = [ln for ln in p.splitlines() if ln.strip()]
        body = [ln for ln in lines
                if not ln.lstrip().startswith(("#", ">", "|", "-", "*",
                                                "：", ":", "```"))]
        # 正文行占比过半才算正文段 (整段表格/引用不参与比对)
        if not body or len(body) * 2 < len(lines):
            continue
        segs.append(p)
    return segs


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--dir", default=str(OUT_DEFAULT))
    ap.add_argument("--min", type=int, default=150)
    ap.add_argument("--json", action="store_true")
    ns = ap.parse_args()

    d = Path(ns.dir)
    files = sorted(d.glob("ch*_编辑稿.md"))
    if not files:
        print(f"[dup] {d} 无 ch*_编辑稿.md")
        return 1

    counter: Counter[str] = Counter()
    where: dict[str, set[str]] = {}
    for f in files:
        for seg in segments(f.read_text(encoding="utf-8"), ns.min):
            key = re.sub(r"\s+", "", seg)          # 空白归一后比对
            if key in WHITELIST_EXACT:
                continue
            counter[key] += 1
            where.setdefault(key, set()).add(f.name)

    dups = {k: where[k] for k, c in counter.items() if c > 1}
    # 同文件内部重复也算 (拼接双版残留的机器证据)
    total_dup = len(dups)

    if ns.json:
        rows = [{"files": sorted(v), "head": k[:60], "len": len(k)}
                for k, v in dups.items()]
        print(json.dumps(rows, ensure_ascii=False, indent=1))
    else:
        for k, v in list(dups.items())[:20]:
            print(f"[dup] {'/'.join(sorted(v))} · {len(k)}字 · {k[:50]}…")
        print(f"[dup] {'✅ 跨章重复 0 段' if not total_dup else f'❌ 重复段 {total_dup} 组'}"
              f" | 扫 {len(files)} 章 · 门槛 ≥{ns.min}字")

    LEDGER.parent.mkdir(parents=True, exist_ok=True)
    with LEDGER.open("a", encoding="utf-8") as fh:
        import time
        fh.write(json.dumps(
            {"ts": time.strftime("%F %T"), "files": len(files),
             "min": ns.min, "dup_groups": total_dup}, ensure_ascii=False) + "\n")

    return 0 if not total_dup else 2


if __name__ == "__main__":
    raise SystemExit(main())
