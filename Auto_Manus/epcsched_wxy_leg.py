# -*- coding: utf-8 -*-
"""EPC-SCHED 文献云全文论文腿 v1 (1020) — 工期主题知网镜像PDF.

复刻 epc49_wxy_leg.py v3 已验证模式:
  备份共享词文件 → 写SCHED定向词 → 跑管线 (WXY_HEADLESS=1) →
  新增 PDF 落 SCHED 战场 02/_channel_wenchuanyun/ → 还原词文件 (finally).
  共享 downloads_wxy 按题名全局查重 — 只下载新题名, 不重复耗配额.
产出由本腿直接 ingest (engine=paper:wenchuanyun → C轴 cnki 渠道).
"""
import io
import os
import shutil
import subprocess
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")

CODE_VERSION = "sched-wxy-v1"
VENDOR = Path(r"E:\AI-Station\ResearchFactory-Eng\engineering-research.skill"
              r"\vendor\PaperDown")
KW_FILE = VENDOR / "需要采集的论文关键词.txt"
DL_DIR = VENDOR / "downloads_wxy"
OUT = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
           r"\《工程工期管理与延误索赔实战指南》"
           r"\02 初次网络调研\_channel_wenchuanyun")
LOG_DIR = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
               r"\《工程工期管理与延误索赔实战指南》\_pipeline")

KEYWORDS = [
    "工期延误 索赔",
    "工期顺延",
    "施工进度控制",
    "网络计划技术 施工",
    "工程 赶工",
    "停工损失 赔偿",
    "工期签证",
    "EPC 工期 风险",
    "关键线路法 进度",
    "施工组织设计 优化 工期",
]


def main() -> int:
    headed = "--headed" in sys.argv
    print(f"[{CODE_VERSION}] SCHED 文献云腿启动 {time.strftime('%F %T')} "
          f"({'有头' if headed else '无头'}, {len(KEYWORDS)} 词)", flush=True)
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    OUT.mkdir(parents=True, exist_ok=True)
    log_path = LOG_DIR / f"epcsched_wxy_run_{time.strftime('%m%d_%H%M')}.log"

    before = ({f.name for f in DL_DIR.glob('*.pdf')}
              if DL_DIR.is_dir() else set())

    orig = KW_FILE.read_text(encoding="utf-8") if KW_FILE.exists() else ""
    KW_FILE.write_text("\n".join(KEYWORDS) + "\n", encoding="utf-8")
    print(f"[wxy] 词文件已换 ({len(KEYWORDS)} 词), 原词表 "
          f"{len(orig.splitlines())} 行 跑完还原", flush=True)

    env = {**os.environ, "WXY_HEADLESS": "0" if headed else "1",
           "PYTHONIOENCODING": "utf-8"}
    rc = -1
    try:
        with log_path.open("w", encoding="utf-8", errors="replace") as log:
            p = subprocess.run(
                [sys.executable, "-u", "wenchuanyun_pipeline.py"],
                cwd=str(VENDOR), env=env, timeout=7200,
                stdout=log, stderr=subprocess.STDOUT,
                creationflags=0x08000000)
            rc = p.returncode
    except subprocess.TimeoutExpired:
        print("[wxy] 管线超时 7200s (已下载件照收)", flush=True)
        rc = -9
    finally:
        KW_FILE.write_text(orig, encoding="utf-8")
        print("[wxy] 词文件已还原", flush=True)

    new = sorted((set(f.name for f in DL_DIR.glob('*.pdf')) - before)
                 if DL_DIR.is_dir() else set())
    kb = 0
    for name in new:
        src = DL_DIR / name
        dst = OUT / name
        i = 1
        while dst.exists():
            dst = OUT / f"{Path(name).stem}_{i}{Path(name).suffix}"
            i += 1
        shutil.copy2(src, dst)
        kb += src.stat().st_size // 1024
    print(f"[wxy] rc={rc} | 新增 PDF {len(new)} 件 ({kb//1024}MB) → "
          f"{OUT.name}/ | 日志 {log_path.name}", flush=True)

    if new:
        import ammo_pool as ap
        ok = 0
        for f in sorted(OUT.glob("*.pdf")):
            r = ap.ingest("EPC-SCHED", str(f), "paper:wenchuanyun", "",
                          "academic", "")
            ok += (r == 0)
        print(f"[ingest] paper:wenchuanyun → {ok} 件入池 (待审判)", flush=True)
    tail = log_path.read_text(encoding="utf-8", errors="replace")[-400:]
    print(f"[wxy] 日志尾:\n{tail}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
