# -*- coding: utf-8 -*-
"""快速部署 kb-pay 开通变更（secret 追加 + config 改 10fen）到 TCB 云托管。"""
import sys, os, subprocess, time
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ENGINE_DIR = r"E:\AI-Station\services\qianwen-engine"
NODE = "node"
UPDATE = os.path.join(ENGINE_DIR, "scripts", "update_envparams_w11.js")
DEPLOY = os.path.join(ENGINE_DIR, "scripts", "qw_prep_w11.py")

print("[1] 复用 W11 部署链（staging → cloudrun.deploy）")
# W11 的 prep 脚本会做 staging → LF 归一 → SECRET_FILES_B64 注入 → deploy
r = subprocess.run(["py", "-3", "-X", "utf8", DEPLOY],
                   cwd=ENGINE_DIR, capture_output=True, text=True, timeout=600,
                   encoding="utf-8", errors="replace")
print(r.stdout[-500:] if r.stdout else "")
if r.returncode != 0:
    print("[!] 部署脚本输出:", (r.stderr or "")[-300:])
    sys.exit(1)
print("[2] 完成")
