#!/bin/sh
# 密钥文件落盘：值经 SECRET_FILES_B64 环境变量注入（JSON map 文件名→base64），
# 不进镜像层；与 TCB_DEPLOY.md 第 4 节的 CFS 挂载方案二选一（环境变量版免买卷）。
# b64 一律容忍缺填充（CLI service:config 的 xx=a&yy=b 解析按 '=' 截值，
# 值内 '=' 必须剥除后传入，此处补回）。
set -e

if [ -n "$SECRET_FILES_B64" ] && [ -n "$SECRETS_DIR" ]; then
  mkdir -p "$SECRETS_DIR"
  python - "$SECRET_FILES_B64" "$SECRETS_DIR" <<'PY'
import base64
import json
import os
import sys


def d64(s):
    s = s.strip()
    if len(s) % 4:
        s += "=" * (-len(s) % 4)
    return base64.b64decode(s)


files = json.loads(d64(sys.argv[1]))
outdir = sys.argv[2]
for name, b64 in files.items():
    with open(os.path.join(outdir, name), "wb") as fh:
        fh.write(d64(b64))
print(f"entrypoint: materialized {len(files)} secret files into {outdir}")
PY
fi

exec "$@"
