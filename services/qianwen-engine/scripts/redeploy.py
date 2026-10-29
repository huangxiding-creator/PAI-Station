# -*- coding: utf-8 -*-
"""用 cloudbase CLI 重部署 qianwen-engine（取新 secret + config）。"""
import sys, os, subprocess, time, base64, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ENGINE = r"E:\AI-Station\services\qianwen-engine"
CLI = r"C:\Users\91216\AppData\Roaming\npm\cloudbase.cmd"
ENV_ID = "cloudbase-d2gzke5r0b706b3a3"

# 1) 构造 SECRET_FILES_B64（新 virtual_pay.secret 含 kb_product_id）
vp = open(r"E:\AI-Station\data\secrets\virtual_pay.secret", "rb").read()
b64 = base64.b64encode(vp).decode()
print(f"[1] virtual_pay.secret -> B64 ({len(b64)} chars)")

# 2) 用 CLI 更新服务环境变量（secret 变更走 env）
# cloudbase run update --serviceName qianwen-engine --envId <id> --env SECRET_NAME=value
# 但 TCB 云托管 secret 走的是挂载卷/构建时注入——最可靠的是整包重部署
# 用 docker 路或代码上传路

# 方法：直接用 CLI 的 run deploy
print("[2] 尝试 cloudbase run deploy...")
r = subprocess.run(
    [CLI, "run", "deploy", "--serviceName", "qianwen-engine",
     "--envId", ENV_ID, "--localPath", ENGINE,
     "--buildDockerfile", "Dockerfile"],
    capture_output=True, text=True, timeout=600,
    encoding="utf-8", errors="replace")
print("stdout:", (r.stdout or "")[-300:])
print("stderr:", (r.stderr or "")[-200:])

if r.returncode != 0:
    print("[!] run deploy 不通，尝试 cloudfunctions 式更新 env...")
    # 查看当前服务信息
    r2 = subprocess.run(
        [CLI, "run", "describe", "--serviceName", "qianwen-engine", "--envId", ENV_ID],
        capture_output=True, text=True, timeout=30,
        encoding="utf-8", errors="replace")
    print("describe:", (r2.stdout or "")[-500:])
