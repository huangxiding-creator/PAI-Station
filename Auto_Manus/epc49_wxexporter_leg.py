# -*- coding: utf-8 -*-
"""EPC49 官微全历史导出腿 v1 — 1004 用户令「全部同意全部执行现在就执行」.

wechat-article-exporter (down.mptext.top API, key 在 01 账号授权/公众号管理API.txt):
  官微名「四川电力设计咨询公司」(三源确证) 全历史 MD 导出 →
  暂存 _pipeline/wxexporter/Downloads (断点续传 .download-record.json 在暂存区) →
  分发 02/_channel_wxexporter/<公众号>/ (只发单篇 MD, 合并件留暂存供 NB)。
账号安全: API 自带 0.5s 节流+429 指数退避, 单号全历史数百篇在四件套内。
产出由 PoolJudge 入账班自动 ingest→judge (wechat:exporter)。
"""
import io
import os
import re
import shutil
import subprocess
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
import epc49_topics as T  # noqa: E402

CODE_VERSION = "v1"
AUTH_FILE = Path(r"E:\AI-Station\ResearchFactory-Eng\01 账号授权"
                 r"\公众号管理API.txt")
SCRIPT = Path(r"C:\Users\91216\.claude\skills\epc-deep-research\scripts"
              r"\wechat-article-exporter_wechat_exporter.py")
STAGE = T.BATTLE / "_pipeline" / "wxexporter"
DL = STAGE / "Downloads"
OUT_ROOT = ([d for d in T.BATTLE.iterdir() if d.name.startswith("02")][0]
            / "_channel_wxexporter")
ACCOUNTS = ["四川电力设计咨询公司"]


def pick_live_key() -> str:
    """授权文件 4 把无标签 key 逐把验活 (每把 1 发 size=1 搜索), 回首个活 key.

    1004 实锤: parse_auth_file 默认取 L1, L1 已死 → 'API 密钥无效' 假死。
    活 key 写 STAGE/.auth_key (单行≥20字符可被 --auth-file 解析), key 不进命令行。
    """
    import requests
    cands = [ln.strip() for ln in
             AUTH_FILE.read_text(encoding="utf-8").splitlines()
             if len(ln.strip()) >= 20]
    for i, key in enumerate(cands, 1):
        try:
            r = requests.get(
                "https://down.mptext.top/api/public/v1/account",
                params={"keyword": "test", "begin": 0, "size": 1},
                headers={"X-Auth-Key": key,
                         "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"},
                timeout=15)
            ct = r.headers.get("content-type", "")
            if not ct.startswith("application/json"):
                print(f"[exporter] key#{i} 非JSON回包 (疑似死key)", flush=True)
                continue
            data = r.json()
            if isinstance(data, dict) and data.get("base_resp", {}).get("ret") == -1:
                print(f"[exporter] key#{i} 服务端判无效", flush=True)
                continue
            print(f"[exporter] key#{i} 验活通过", flush=True)
            STAGE.mkdir(parents=True, exist_ok=True)
            (STAGE / ".auth_key").write_text(key, encoding="utf-8")
            return str(STAGE / ".auth_key")
        except Exception as e:
            print(f"[exporter] key#{i} 探测异常: {str(e)[:60]}", flush=True)
    return ""


def main() -> int:
    print(f"[{CODE_VERSION}] 官微导出腿启动 {time.strftime('%F %T')} "
          f"账号={ACCOUNTS}", flush=True)
    if not AUTH_FILE.is_file():
        print(f"[exporter] 授权文件不存在: {AUTH_FILE}", file=sys.stderr)
        return 1
    STAGE.mkdir(parents=True, exist_ok=True)
    live = pick_live_key()
    if not live:
        print("[exporter] 4 把 key 全灭 — 需用户到 down.mptext.top 重新取 key "
              "(skill 注: key 有时效性)", flush=True)
        return 3
    log_path = STAGE / f"run_{time.strftime('%m%d_%H%M')}.log"

    rc = -1
    env = {**os.environ, "PYTHONIOENCODING": "utf-8"}  # 1004 实锤: 子进程GBK炸emoji
    try:
        with log_path.open("w", encoding="utf-8", errors="replace") as log:
            p = subprocess.run(
                [sys.executable, "-u", str(SCRIPT),
                 "--auth-file", live,
                 "--accounts", ",".join(ACCOUNTS),
                 "--output", str(DL)],
                timeout=7200, stdout=log, stderr=subprocess.STDOUT,
                env=env, creationflags=0x08000000)
            rc = p.returncode
    except subprocess.TimeoutExpired:
        print("[exporter] 超时 7200s (断点记录在暂存区, 重跑续传)", flush=True)
        rc = -9

    # 分发: 只发单篇 MD (合并件在 STAGE/Merge, 供 NB 用, 不入池防双计)
    n = 0
    for acc_dir in DL.glob("*/"):
        if not acc_dir.is_dir():
            continue
        dst_dir = OUT_ROOT / acc_dir.name
        dst_dir.mkdir(parents=True, exist_ok=True)
        for f in acc_dir.glob("*.md"):
            if "+合并" in f.name:
                continue
            dst = dst_dir / f.name
            if not dst.exists():
                shutil.copy2(f, dst)
                n += 1
    print(f"[exporter] rc={rc} | 分发单篇 MD {n} 件 → {OUT_ROOT.name}/ | "
          f"日志 {log_path.name}", flush=True)
    tail = log_path.read_text(encoding="utf-8", errors="replace")[-600:]
    print(f"[exporter] 日志尾:\n{tail}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
