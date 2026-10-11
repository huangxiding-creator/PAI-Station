# -*- coding: utf-8 -*-
"""F1 跨战役收割件入池 — 1011 采集域开火第一腿 (渠道完备门过账推进).

把 ResearchTopics 研究树 (EPC49/50 各战役工作区) 里各渠道已收割的
公开资料 + 课题工作稿, 以及 data/rss_harvest/articles RSS 常年收割面
(PAIStation-rss-harvest 每日 07:37/19:37 落盘), 按 F1-BLUEBOOK 自己的
judge + tiers 过账 (engine=cross:<渠道> 溯源, dossier §2 渠道账自动过账).

纪律 (1011 定):
  - 排除 53_裁判文书 (法院卷宗非蓝皮书素材, 单件动辄百 MB);
  - 排除 01 用户私有 (用户私有资料隐私红线, 永不入战役池);
  - 单文件 >2MB 跳过 (合并巨件防单件虚账, 报告/文章常态 <2MB);
  - 幂等: ammo_pool.ingest 按 source_path + dedup_key(内容头) 双查重,
    采集域持续落新件, 本腿周期重跑即增量入账;
  - 同一把尺: 只认 F1 词表 judge 有效 + tiers 标题分层, 与存量/军团
    完全同规 — 跨战役复用在 QUALITY_DOSSIER §5 披露.

用法: python f1_cross_ingest.py [--dry]
"""
import argparse
import os
import re
import sys
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\reforge_factory")
import ammo_pool as ap                                   # noqa: E402

sys.path.insert(0, r"E:\AI-Station\_proposals"
                r"\flagship-paid-report-1007\work")
import f1_pool_build as fpb                              # noqa: E402

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
CID = "F1-BLUEBOOK"
ROOTS = [Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics")]
RSS_ROOT = Path(r"E:\AI-Station\data\rss_harvest\articles")  # 二腿: RSS 常年收割面
EXCLUDE_DIR = ("53_裁判文书", "01 用户私有", ".git")
MAX_BYTES = 2_000_000
EXTS = (".md", ".txt", ".docx")
CHAN = re.compile(r"_channel_([A-Za-z0-9_]+)")
CRED = {"policy": "gov", "standards": "gov", "sasac": "gov", "ndrc": "gov",
        "ndrc_pifu": "gov", "nea": "gov", "mohurd": "gov", "stats": "gov",
        "mem_gov": "gov", "mot": "gov", "nnsa": "gov", "cnki": "paper",
        "academic_en": "paper", "arxiv": "paper", "djyanbao": "research",
        "rss": "media"}


def iter_files():
    """walk 研究树 + RSS 收割面 → (file, channel); 排除目录整枝剪掉, 大文件跳过."""
    for root in [*ROOTS, RSS_ROOT]:
        is_rss = root == RSS_ROOT
        for dp, dn, fns in os.walk(root):
            if any(x in dp for x in EXCLUDE_DIR):
                dn[:] = []                              # 整枝不下降
                continue
            ch = "rss" if is_rss else (
                m.group(1) if (m := CHAN.search(dp)) else "topics")
            for fn in fns:
                if fn.startswith("~$") or not fn.endswith(EXTS):
                    continue
                p = Path(dp) / fn
                try:
                    if p.stat().st_size > MAX_BYTES:
                        continue
                except OSError:
                    continue
                yield p, ch


def main() -> int:
    apx = argparse.ArgumentParser()
    apx.add_argument("--dry", action="store_true", help="只数不入")
    args = apx.parse_args()
    if not args.dry:                                   # 并发闸 (O_EXCL)
        lock = Path(r"E:\AI-Station\ammo_pool\F1-BLUEBOOK\.cross_ingest.lock")
        try:
            fd = os.open(lock, os.O_CREAT | os.O_EXCL | os.O_WRONLY)
        except FileExistsError:
            print("[闸] 已有实例在跑, 本轮让路退出")
            return 0
        os.write(fd, str(os.getpid()).encode())
        os.close(fd)
        try:
            return _run(args)
        finally:
            lock.unlink(missing_ok=True)
    return _run(args)


def _run(args) -> int:
    items = [{"file": str(p), "engine": f"cross:{ch}",
              "cred": CRED.get(ch, "web")} for p, ch in iter_files()]
    print(f"[walk] 候选 {len(items)} 件" + (" (dry)" if args.dry else ""))
    if args.dry:
        return 0
    added, skipped = ap.ingest_files(CID, items)
    ap.judge(CID, limit=0)
    ap.rebuild(CID)
    tr = fpb.persist_tier_keys()
    t12 = tr["t1"] + tr["t2"]
    print(f"\n[分层账] T1={tr['t1']:,} ({tr['n1']}件) | T2={tr['t2']:,} "
          f"({tr['n2']}件) | T3={tr['t3']:,} | T0={tr['t0']:,}")
    print(f"[字数门] T1 {'✅' if tr['t1'] >= ap.T1_MIN_CHARS else '⏳'} "
          f"{tr['t1']:,}/{ap.T1_MIN_CHARS:,} ∧ T1+T2 "
          f"{'✅' if t12 >= ap.T12_MIN_CHARS else '⏳'} "
          f"{t12:,}/{ap.T12_MIN_CHARS:,} → "
          f"{'PASS' if tr['gate_ok'] else 'FAIL'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
