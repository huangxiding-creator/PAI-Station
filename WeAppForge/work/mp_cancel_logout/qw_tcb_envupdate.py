# -*- coding: utf-8 -*-
"""qw_tcb_envupdate.py — 【已退役，留档勿用】service:config 更新 EnvParams。
1007 实证死路：run service:config 的 options 没声明 envId 旗标（options.envId 恒
undefined，旗标放根位置/补丁注入都过不了）；且客户端 checkTcbrEnv 拒非 tcbr 环境。
正解 = manager-node 通道：E:\\AI-Station\\data\\state\\mn_client\\update_envparams.js
（UpdateCloudRunServer 稀疏 DiffConfigItems，EnvParams 走 JSON 字符串无 '=' 截断）。
配方详见 services/qianwen-engine/TCB_DEPLOY.md §8a。"""
import json
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

NODE = r"D:\Program Files\nodejs\node.exe"
TCB = r"C:\Users\91216\AppData\Roaming\npm\node_modules\@cloudbase\cli\bin\tcb"
ENV_ID = "cloudbase-d2gzke5r0b706b3a3"
ENVP = Path(r"E:\AI-Station\data\state\qianwen_tcb_envparams.json")


def main():
    envp = json.loads(ENVP.read_text(encoding="utf-8"))
    val = str(envp["SECRET_FILES_B64"]).replace("=", "")
    arg = f"SECRET_FILES_B64={val}"
    print(f"arg_len={len(arg)} (only SECRET_FILES_B64, merge preserves the rest)")
    r = subprocess.run(
        [NODE, TCB, "-e", ENV_ID,
         "run", "service:config", "-s", "qianwen-engine",
         "--envParams", arg, "--json"],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
        timeout=300,
    )
    out = (r.stdout or "") + (("\n[stderr]" + r.stderr) if (r.stderr or "").strip() else "")
    # 不打印任何密钥段（输出里若有 EnvParams 回显则截断显示）
    print("exit:", r.returncode)
    print(out[-1600:])
    return r.returncode


if __name__ == "__main__":
    raise SystemExit(main())
