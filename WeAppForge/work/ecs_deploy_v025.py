# -*- coding: utf-8 -*-
"""ECS 部署引擎 v0.2.5（虚拟支付腿）。
tar.gz 本地打包 → base64 分片经云助手追加 → 远端解包覆盖 → systemd 重启 → 探针。
"""
import base64
import io
import json
import subprocess
import tarfile
import time
from pathlib import Path

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
CHUNK = 16000
ENGINE = Path(r"E:\AI-Station\services\qianwen-engine\qianwen_engine")
NO_WINDOW = 0x08000000


def run(*args, timeout=90):
    p = subprocess.run(["aliyun", "ecs", *args], capture_output=True, text=True,
                       timeout=timeout, creationflags=NO_WINDOW)
    if p.returncode != 0:
        raise RuntimeError(f"aliyun {' '.join(args[:2])} 失败: {p.stderr[:300]}")
    return p.stdout


def ecs_cmd(script, name, wait=300):
    out = run("RunCommand", "--Type", "RunShellScript", "--Name", name,
              "--CommandContent", script, "--InstanceId.1", INSTANCE, "--RegionId", REGION)
    inv = json.loads(out)["InvokeId"]
    t0 = time.time()
    while time.time() - t0 < wait:
        time.sleep(4)
        r = json.loads(run("DescribeInvocationResults", "--RegionId", REGION, "--InvokeId", inv))
        rs = r.get("Invocation", {}).get("InvocationResults", {}).get("InvocationResult", [])
        if rs and rs[0].get("InvocationStatus") in ("Success", "Failed", "Cancelled", "Timeout"):
            code = rs[0].get("ExitCode", -1)
            output = base64.b64decode(rs[0].get("Output") or "").decode("utf-8", "replace")
            print(f"[{name}] exit={code}")
            if output.strip():
                print(output[-1500:])
            if code != 0:
                raise RuntimeError(f"{name} ExitCode={code}")
            return output
    raise TimeoutError(f"{name} 超时")


def main():
    buf = io.BytesIO()
    with tarfile.open(fileobj=buf, mode="w:gz") as tf:
        tf.add(str(ENGINE), arcname="qianwen_engine")
    b64 = base64.b64encode(buf.getvalue()).decode()
    chunks = [b64[i:i + CHUNK] for i in range(0, len(b64), CHUNK)]
    print(f"包体 {buf.tell()} bytes → {len(chunks)} 片")

    ecs_cmd("rm -f /opt/qianwen/pkg25.b64", "clean")
    for i, ch in enumerate(chunks):
        ecs_cmd(f"printf %s '{ch}' >> /opt/qianwen/pkg25.b64", f"chunk{i:02d}", wait=120)

    ecs_cmd(
        "cd /opt/qianwen && base64 -d pkg25.b64 | tar xz -C services/qianwen-engine/ && "
        "([ -f data/secrets/virtual_pay.secret ] || "
        "printf '# 虚拟支付配置\\noffer_id=\\nproduct_id=\\nenv=0\\n' > data/secrets/virtual_pay.secret) && "
        "systemctl restart qianwen-engine && sleep 2 && "
        "echo service=$(systemctl is-active qianwen-engine) && "
        "curl -s -o /dev/null -w 'health=%{http_code}\\n' http://127.0.0.1:8869/api/health && "
        "curl -s -o /dev/null -w 'pay_sign_route=%{http_code}\\n' -X POST http://127.0.0.1:8869/api/answer/xxxx/pay_sign && "
        "rm -f pkg25.b64",
        "deploy",
    )
    print("ECS DEPLOY v0.2.5 DONE")


if __name__ == "__main__":
    main()
