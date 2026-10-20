# -*- coding: utf-8 -*-
"""EPC49 文献云全文论文腿 v1 — 1004 用户令「全部同意全部执行现在就执行」.

驱动 vendor PaperDown/wenchuanyun_pipeline.py (wxy88.top 知网镜像全文PDF):
  备份共享词文件 → 写四川院定向词 → 跑管线 (WXY_HEADLESS=1 白天无头) →
  新增 PDF 落战场 02/_channel_wenchuanyun/ → 还原词文件 (finally 保证)。

账号安全四件套: 节流=管线内置1s下载间隔; 冷却=每词入口重进(天然15-40s/词);
日限额=vendor MAX_PER_DAY 已对齐200(今日已耗7); 熔断=入口全败跳词+login 4轮死退。
产出由 PoolJudge 入账班 (21:37/00:40) 自动 ingest→judge (paper:wenchuanyun)。
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
sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
import epc49_topics as T  # noqa: E402

CODE_VERSION = "v3"  # v3: 镜像迁ccki.top KNS8——限额墙先判+quota信号停跑+KNS8选择器
# v2: vendor UA 修复(HeadlessChrome 被WAF拦结果XHR, 1004实锤)
VENDOR = Path(r"E:\AI-Station\ResearchFactory-Eng\engineering-research.skill"
              r"\vendor\PaperDown")
KW_FILE = VENDOR / "需要采集的论文关键词.txt"
DL_DIR = VENDOR / "downloads_wxy"
OUT = ([d for d in T.BATTLE.iterdir() if d.name.startswith("02")][0]
       / "_channel_wenchuanyun")
LOG_DIR = T.BATTLE / "_pipeline"

# 四川院定向全文词 (与已跑29词零重复, 24词×≤10篇, 日限额200内自然熔断)
KEYWORDS = [
    "四川电力设计咨询 EPC 总承包",
    "中电建四川院 工程总承包",
    "四川院 输变电 EPC",
    "电力设计院 EPC 总承包 转型",
    "输变电工程 总承包 设计施工一体化",
    "变电站 EPC 总承包 设计优化",
    "新能源电站 EPC 项目管理",
    "光伏电站 EPC 总承包 管理",
    "风电场 EPC 工程管理",
    "电化学储能电站 EPC 建设",
    "抽水蓄能 EPC 设计",
    "源网荷储 一体化 工程总承包",
    "高海拔 输电线路 工程设计",
    "电力 EPC 采购管理 设备",
    "电力 EPC 施工管理 调试并网",
    "电力 EPC 风险管理 对策",
    "电力 EPC 造价控制",
    "设计主导 电力工程 EPC 优势",
    "电力工程总承包 联合体",
    "海外电力工程 EPC 国际总承包",
    "四川电力设计咨询 中标",
    "中国电建 四川 设计院",
    "电网工程 总承包 项目管理",
    "配电网 改造 EPC",
]


def main() -> int:
    headed = "--headed" in sys.argv
    print(f"[{CODE_VERSION}] 文献云腿启动 {time.strftime('%F %T')} "
          f"({'有头' if headed else '无头'}模式, {len(KEYWORDS)} 词)",
          flush=True)
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    OUT.mkdir(parents=True, exist_ok=True)
    log_path = LOG_DIR / f"epc49_wxy_run_{time.strftime('%m%d_%H%M')}.log"

    before = {f.name for f in DL_DIR.glob('*.pdf')} if DL_DIR.is_dir() else set()

    orig = KW_FILE.read_text(encoding="utf-8") if KW_FILE.exists() else ""
    KW_FILE.write_text("\n".join(KEYWORDS) + "\n", encoding="utf-8")
    print(f"[wxy] 词文件已换 ({len(KEYWORDS)} 词), 原词表 {len(orig.splitlines())} 行 "
          f"跑完还原", flush=True)

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
    print(f"[wxy] 管线 rc={rc} | 本轮新增 PDF {len(new)} 件 ({kb//1024}MB) "
          f"→ {OUT.name}/ | 日志 {log_path.name}", flush=True)
    tail = log_path.read_text(encoding="utf-8", errors="replace")[-600:]
    print(f"[wxy] 日志尾:\n{tail}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
