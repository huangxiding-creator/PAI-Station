# -*- coding: utf-8 -*-
"""1002 备份拉回：SFTP 下载 /root/archives/qianwen-legacy-1002.tar.gz →
E:/AI-Station/data/backups/，远端/本地 sha256 对拍。密码只在内存，绝不打印。"""
import hashlib
import json
import os
import sys

import paramiko

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

CREDS = json.load(open(r"E:/AI-Station/data/secrets/aliyun_ecs_password.json", encoding="utf-8"))
HOST = "47.120.43.20"
REMOTE = "/root/archives/qianwen-legacy-1002.tar.gz"
LOCAL = r"E:/AI-Station/data/backups/qianwen-legacy-1002.tar.gz"

os.makedirs(os.path.dirname(LOCAL), exist_ok=True)

cli = paramiko.SSHClient()
cli.set_missing_host_key_policy(paramiko.AutoAddPolicy())
pkey = paramiko.RSAKey.from_private_key_file(r"E:/AI-Station/data/secrets/ecs_tmp_pull_key")
cli.connect(HOST, port=22, username="root", pkey=pkey,
            timeout=20, banner_timeout=20, auth_timeout=20)

# 远端哈希
_, out, err = cli.exec_command(f"sha256sum {REMOTE}")
rhash = out.read().decode().split()[0].strip()
rsize = int(cli.exec_command(f"stat -c %s {REMOTE}")[1].read() or 0)

sftp = cli.open_sftp()
sftp.get(REMOTE, LOCAL)
sftp.close()

with open(LOCAL, "rb") as f:
    data = f.read()
lhash = hashlib.sha256(data).hexdigest()

print(f"remote sha256 : {rhash}")
print(f"local  sha256 : {lhash}")
print(f"remote bytes  : {rsize}")
print(f"local  bytes  : {len(data)}")
print("MATCH" if (rhash == lhash and rsize == len(data)) else "MISMATCH")
cli.close()
sys.exit(0 if rhash == lhash else 1)
