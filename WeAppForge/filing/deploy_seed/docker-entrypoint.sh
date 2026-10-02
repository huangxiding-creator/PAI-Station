#!/bin/sh
# 密钥文件落盘：值经 SECRET_FILES_B64 环境变量注入（JSON map 文件名→base64），
# 不进镜像层；与 TCB_DEPLOY.md 第 4 节的 CFS 挂载方案二选一（环境变量版免买卷）。
set -e

if [ -n "$SECRET_FILES_B64" ] && [ -n "$SECRETS_DIR" ]; then
  mkdir -p "$SECRETS_DIR"
  python - "$SECRET_FILES_B64" "$SECRETS_DIR" <<'PY'
import base64
import json
import os
import sys

files = json.loads(base64.b64decode(sys.argv[1]))
outdir = sys.argv[2]
for name, b64 in files.items():
    with open(os.path.join(outdir, name), "wb") as fh:
        fh.write(base64.b64decode(b64))
print(f"entrypoint: materialized {len(files)} secret files into {outdir}")
PY
fi

exec "$@"
