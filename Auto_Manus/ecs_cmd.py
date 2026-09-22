# -*- coding: utf-8 -*-
"""ECS 云助手执行器 — aliyun CLI RunCommand 封装 (0922).

SSH 22 仅对 workbench 内网开 (设计态), 生产部署走云助手.
用法: python ecs_cmd.py "shell命令" [超时秒]
"""
import base64
import json
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"


def run_shell(cmd: str, timeout: int = 120) -> str:
    b64 = base64.b64encode(cmd.encode("utf-8")).decode()
    r = subprocess.run([
        "aliyun", "ecs", "RunCommand",
        "--region", REGION,
        "--Type", "RunShellScript",
        "--Name", "cc-auto",
        "--InstanceId.1", INSTANCE,
        "--CommandContent", cmd,
        "--Timeout", str(timeout),
    ], capture_output=True, text=True, encoding="utf-8")
    if r.returncode != 0:
        return f"[RunCommand FAIL] {r.stderr[:300]}"
    inv_id = json.loads(r.stdout)["InvokeId"]
    for _ in range(int(timeout / 3) + 10):
        time.sleep(3)
        rr = subprocess.run([
            "aliyun", "ecs", "DescribeInvocationResults",
            "--region", REGION, "--InvokeId", inv_id],
            capture_output=True, text=True, encoding="utf-8")
        rd = json.loads(rr.stdout)
        inv = rd.get("Invocation", {}).get("InvocationResults", {}).get(
            "InvocationResult", [])
        if inv and inv[0].get("InvocationStatus") in ("Finished", "Success",
                                                      "Failed", "Cancelled"):
            out = inv[0].get("Output", "") or ""
            exit_code = inv[0].get("ExitCode", -1)
            if out and not out.startswith("["):
                try:  # 阿里云常回 base64
                    import base64 as _b64
                    dec = _b64.b64decode(out).decode("utf-8", "replace")
                    if dec.isprintable() or "\n" in dec:
                        out = dec
                except Exception:
                    pass
            return f"[exit={exit_code}]\n{out}"
    return "[TIMEOUT] 云助手未在窗口内返回"


def main() -> None:
    cmd = sys.argv[1]
    timeout = int(sys.argv[2]) if len(sys.argv) > 2 else 120
    print(run_shell(cmd, timeout))


if __name__ == "__main__":
    main()
