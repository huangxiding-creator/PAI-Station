# -*- coding: utf-8 -*-
"""ECS qianwen 运维小工具：RunCommand 执行 + 轮询取回输出。

用法:
  python tools/ecs_qw.py <script_file>        # 执行 shell 脚本并打印输出
  cat script.sh | python tools/ecs_qw.py      # stdin 版

契约: 脚本本体保持 ASCII（b64 分片除外）；输出自动 base64 解码；
退出码透传（非零 = 远端脚本失败）。 REGION/INSTANCE 与部署登记簿一致。
"""
from __future__ import annotations

import base64
import json
import subprocess
import sys
import time

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
POLL_SEC = 480


def _aliyun(*args: str) -> dict:
    r = subprocess.run(["aliyun", *args], capture_output=True, text=True,
                       encoding="utf-8", errors="replace")
    if r.returncode != 0:
        raise RuntimeError(f"aliyun {' '.join(args[:3])} 失败:\n{r.stdout}\n{r.stderr}")
    return json.loads(r.stdout)


def run(script: str) -> tuple[int, str]:
    """执行脚本 → (ExitCode, Output)。超时返回 (-1, 'TIMEOUT')。"""
    res = _aliyun("ecs", "RunCommand",
                  "--RegionId", REGION, "--InstanceId.1", INSTANCE,
                  "--Type", "RunShellScript", "--Name", "qw-ops",
                  "--Timeout", "180",
                  "--ContentEncoding", "Base64",
                  "--CommandContent", base64.b64encode(script.encode("utf-8")).decode("ascii"))
    invoke_id = res["InvokeId"]
    deadline = time.time() + POLL_SEC
    while time.time() < deadline:
        time.sleep(3)
        d = _aliyun("ecs", "DescribeInvocationResults",
                    "--RegionId", REGION, "--InvokeId", invoke_id,
                    "--InstanceId", INSTANCE)
        recs = ((d.get("Invocation") or {}).get("InvocationResults") or {})
        rec = recs.get("InvocationResult") or []
        rec = rec[0] if isinstance(rec, list) and rec else {}
        if rec.get("InvokeRecordStatus") == "Finished" or rec.get("InvocationStatus") in ("Success", "Failed", "Cancelled", "Timeout"):
            out = rec.get("Output") or ""
            try:
                out = base64.b64decode(out).decode("utf-8", "replace")
            except Exception:
                pass
            ec = rec.get("ExitCode")
            return int(ec) if ec is not None else -1, out
    return -1, "TIMEOUT"


if __name__ == "__main__":
    try:                                    # GBK 控制台兜底（中文输出不炸显示层）
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass
    src = open(sys.argv[1], encoding="utf-8").read() if len(sys.argv) > 1 else sys.stdin.read()
    code, out = run(src)
    print(out)
    sys.exit(code)
