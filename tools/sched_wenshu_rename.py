# -*- coding: utf-8 -*-
"""sched_wenshu_rename — SCHED wenshu 件改名 + 台账修复 (1020).

根因: tools/sched_corpus_scan.py 写件名用 CSV row[0] (常是 URL), T1 词
只进了正文 (HIT 正则门过) 没进文件名; tier_report 按文件名匹配词表 →
82M 核心判决语料全落 T0, T1 硬门虚低。

修复 (如实原则 — 文件名只补正文里真实命中的词, 不造词):
  1. 扫 data/wenshu_sched_scan/*.md, 读头 6000 字符找 T1 词;
  2. 文件名已含 T1 词 → 跳过; 否则改名 {stem}_{首个命中词}.md;
  3. manifest 行同步: source_path 改新名 + 回填 text_head (文件头 500 字,
     修 D 轴维度匹配 — 老行无 text_head, wenshu 语料进不了维度格);
  4. 全程持池锁重写 manifest (与在跑腿串行), 完了 rebuild。
幂等: 重跑对已改名件零动作。用法: py -X utf8 tools/sched_wenshu_rename.py [--dry]
"""
from __future__ import annotations

import argparse
import io
import json
import re
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
import ammo_pool as ap  # noqa: E402

OUT = Path(r"E:\AI-Station\data\wenshu_sched_scan")
CID = "EPC-SCHED"
T1_WORDS = ["工期延误", "工期顺延", "延误索赔", "赶工", "停工损失",
            "工期签证", "网络计划", "关键线路", "进度偏差", "施工组织设计",
            "工期管理", "进度管理"]
HEAD = 6000


def main() -> int:
    ap_ = argparse.ArgumentParser()
    ap_.add_argument("--dry", action="store_true")
    ns = ap_.parse_args()
    camp = ap._camp_dir(CID)
    files = sorted(OUT.glob("*.md"))
    print(f"[rename] 扫 {len(files)} 件 | dry={ns.dry}", flush=True)

    # 1) 决定改名映射 + 读正文头 (锁外预读, 快)
    renames: dict[str, str] = {}        # 旧路径 -> 新路径
    heads: dict[str, str] = {}          # 新路径 -> text_head
    n_skip = n_hit_rename = n_nohit = 0
    for fp in files:
        name = fp.stem
        if any(w in name for w in T1_WORDS):
            n_skip += 1
            continue
        try:
            text = fp.read_text(encoding="utf-8", errors="replace")[:HEAD]
        except OSError:
            continue
        word = next((w for w in T1_WORDS if w in text), None)
        if not word:
            n_nohit += 1
            continue
        new_fp = fp.with_name(f"{name}_{word}.md")
        i = 1
        while new_fp.exists() and new_fp != fp:
            new_fp = fp.with_name(f"{name}_{word}_{i}.md")
            i += 1
        renames[str(fp)] = str(new_fp)
        heads[str(new_fp)] = text[:500]
        n_hit_rename += 1
    print(f"[rename] 已含T1词 {n_skip} | 补词改名 {n_hit_rename} | "
          f"头6000字无T1词 {n_nohit}", flush=True)
    if ns.dry:
        for old, new in list(renames.items())[:10]:
            print(f"  {Path(old).name} → {Path(new).name}")
        return 0

    # 2) 改名 (文件系统)
    t0 = time.time()
    n_done = 0
    for old, new in renames.items():
        try:
            Path(old).rename(new)
            n_done += 1
        except OSError as e:
            print(f"[rename✗] {Path(old).name[:50]}: {type(e).__name__}",
                  flush=True)
    print(f"[rename] 文件改名 {n_done}/{len(renames)} ({time.time()-t0:.0f}s)",
          flush=True)

    # 3) manifest 同步 (持锁整写: source_path 换新名 + text_head 回填)
    mp = camp / "manifest.jsonl"
    n_row = n_path = n_head = 0
    with ap._pool_lock(camp):
        rows = []
        for line in mp.read_text(encoding="utf-8").splitlines():
            if not line.strip():
                continue
            try:
                r = json.loads(line)
            except json.JSONDecodeError:
                rows.append(line)
                continue
            n_row += 1
            sp = r.get("source_path", "")
            if sp in renames:
                r["source_path"] = renames[sp]
                n_path += 1
            if not r.get("text_head"):
                fp2 = Path(r.get("source_path", ""))
                if fp2.is_file() and "wenshu_sched_scan" in str(fp2):
                    try:
                        r["text_head"] = fp2.read_text(
                            encoding="utf-8", errors="replace")[:500]
                        n_head += 1
                    except OSError:
                        pass
            rows.append(json.dumps(r, ensure_ascii=False))
        mp.write_text("\n".join(rows) + "\n", encoding="utf-8")
    print(f"[manifest] 行 {n_row} | 改路径 {n_path} | 补text_head {n_head}",
          flush=True)

    # 4) 重算池账
    ap.rebuild(CID)
    tr = ap.tier_report(CID)
    print(f"[分层账] T1 {tr['t1']:,} 字/{tr['n1']}件 | T2 {tr['t2']:,} | "
          f"T0 {tr['t0']:,} | T1门(≥2000万) "
          f"{'✓' if tr['t1'] >= 20_000_000 else '✗'}", flush=True)
    print(f"[rename] 全部完成 {time.strftime('%F %T')}", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
