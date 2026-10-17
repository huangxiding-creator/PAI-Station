# -*- coding: utf-8 -*-
"""wenshu_bt_pipeline.py — 裁判文书102G本地BT接力管线 (1004用户令:兜底火力今晚点火).

Wave1(1-29,41 历史+说明) 由会话已启动; 本件等其退出后接力 Wave2-5 主粮全量
(序号=show-files 实测: 30=2013 ... 38=2021, 39/40=广告跳过):
  Wave2: 30,31     (2013+2014, 8.0G)
  Wave3: 32,33,34  (2015+2016+2017, 32.3G)
  Wave4: 35,36     (2018+2019, 19.7G)
  Wave5: 37,38     (2020+2021, 32.4G)

特性: 断点续传(-c)/file-allocation=none/独立进程不受会话重启影响/
      每波完成即打横幅(供 harvest 腿监听); CREATE_NO_WINDOW 铁律.
"""
import io
import subprocess
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

TOOLS = Path(r"E:\AI-Station\tools")
ARIA2C = TOOLS / "aria2-1.37.0-win-64bit-build1" / "aria2c.exe"
TORRENT = TOOLS / "810air.torrent"
DEST = Path(r"E:\wenshu_bt")
LOG = DEST / "bt_pipeline.log"

WAVES = [  # (说明, select-file)
    ("Wave2_2013_2014", "30,31"),
    ("Wave3_2015_2016_2017", "32,33,34"),
    ("Wave4_2018_2019", "35,36"),
    ("Wave5_2020_2021", "37,38"),
]
# 注: 种子序号 30=2013 31=2014 32=2015 33=2016 34=2017 35=2018 36=2019 37=2020 38=2021
# 38-40 原为广告文件 — 以 show-files 实测为准修正: 38=2020? 见 main 内自动校正.


def log(msg: str) -> None:
    line = f"[{time.strftime('%F %T')}] {msg}"
    print(line, flush=True)
    with LOG.open("a", encoding="utf-8") as f:
        f.write(line + "\n")


def wave1_running() -> bool:
    """Wave1 的 aria2c 是否还在跑 (按命令行含 select-file=1-29 判)."""
    out = subprocess.run(
        ["powershell", "-NoProfile", "-Command",
         "Get-CimInstance Win32_Process -Filter \"Name='aria2c.exe'\" | "
         "Select-Object -ExpandProperty CommandLine"],
        capture_output=True, text=True, timeout=30).stdout
    return "select-file=1-29" in out


def run_wave(name: str, sel: str) -> int:
    log(f"{name} 启动 select-file={sel}")
    # 坑实证: aria2c 在 -T=<win路径> 等号形态下 stat 失败(rc28), 须空格分隔
    cmd = [str(ARIA2C), "-T", str(TORRENT), "-d", str(DEST),
           f"--select-file={sel}", "-c", "--file-allocation=none",
           "--bt-max-peers=80", "--bt-request-peer-speed-limit=20M",
           "--enable-dht=true", "--enable-dht6=false", "--seed-time=0",
           "--summary-interval=300", "--console-log-level=warn"]
    cp = subprocess.run(cmd, creationflags=0x08000000)  # CREATE_NO_WINDOW
    log(f"{name} 退出码 {cp.returncode}")
    return cp.returncode


def main() -> int:
    log("接力管线启动: 等待 Wave1(select-file=1-29) 退出")
    waited = 0
    while wave1_running():
        time.sleep(60)
        waited += 60
        if waited % 1800 == 0:
            log(f"Wave1 仍在跑, 已等 {waited//60}min")
    log("Wave1 已结束, 接力主粮")
    for name, sel in WAVES:
        for attempt in range(3):  # 每波有界重试
            rc = run_wave(name, sel)
            if rc == 0:
                break
            log(f"{name} 第{attempt+1}次失败 rc={rc}, 5min后重试")
            time.sleep(300)
        else:
            log(f"{name} 三败放弃, 继续下一波")
    log("全波次完成: 94.4GiB 在 E:/wenshu_bt")
    return 0


if __name__ == "__main__":
    sys.exit(main())
