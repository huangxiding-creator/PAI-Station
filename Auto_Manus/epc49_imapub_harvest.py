# -*- coding: utf-8 -*-
"""EPC49 ima_public 公开库收割腿 — 1003 发现的电力工程 2 库.

电力工程规范AI知识库(500件) + 国际电力工程(261件), 走 ima_public.cli
harvest topic 模式 (catalog 只增不删, 名含'电力工程'即命中), 断点 _state_*.
"""
import io
import subprocess
import sys
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

PY = sys.executable
COLLECTORS = Path(r"E:\AI-Station\ResearchFactory-Eng\EPC100\collectors")
OUT = Path(r"E:/AI-Station/ResearchFactory-Eng/ResearchTopics/"
           "《四川电力设计咨询有限责任公司怎么干EPC总承包？》/02 初次网络调研"
           "/52_ima公开库")


def main() -> int:
    OUT.mkdir(parents=True, exist_ok=True)
    r = subprocess.run(
        [PY, "-m", "ima_public.cli", "harvest",
         "--topic", "电力工程", "--kb-limit", "2", "--max-files", "60",
         "--out", str(OUT)],
        cwd=str(COLLECTORS), capture_output=True, text=True,
        encoding="utf-8", errors="replace", timeout=7200)
    print(r.stdout or "", flush=True)
    if r.returncode != 0:
        print(f"[imapub] 失败: {(r.stderr or '')[-300:]}", flush=True)
    return r.returncode


if __name__ == "__main__":
    raise SystemExit(main())
