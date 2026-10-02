# -*- coding: utf-8 -*-
"""off.json 送达工具：本地改下架名单 → 一键送达 ECS 并重启生效（RL 决策③配套运维件）。

用法:
  python ship_off_json.py            # 送达 projects/zongbao/content/off.json 并重启+验收
  python ship_off_json.py <路径>     # 送达指定 off.json
动作: base64 单片写 /opt/xueyuan/data/content_pkg/off.json → systemctl restart
      → 探针 /health + /catalog total（预期=38-在列数，当前名单 6 → 32）
红线: 只写这一个文件+只 restart xueyuan-engine；不碰其它任何远端文件。
"""
import base64
import json
import os
import subprocess
import sys
import time
from pathlib import Path

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
REMOTE = "/opt/xueyuan/data/content_pkg/off.json"
UNIT = "xueyuan-engine"
HEALTH = "http://127.0.0.1:8871/health"
NO_WINDOW = 0x08000000


def aliyun(*args, timeout=90):
    env = {k: v for k, v in os.environ.items()
           if k.upper() not in ("HTTP_PROXY", "HTTPS_PROXY", "ALL_PROXY")}
    p = subprocess.run(["aliyun", "ecs", *args], capture_output=True, text=True,
                       encoding="utf-8", errors="replace", timeout=timeout,
                       env=env, creationflags=NO_WINDOW)
    if p.returncode != 0:
        raise RuntimeError(f"aliyun {args[0]} 失败: {(p.stderr or '')[:300]}")
    return p.stdout


def run(script, name):
    out = aliyun("RunCommand", "--Type", "RunShellScript", "--Name", name,
                 "--CommandContent", script, "--InstanceId.1", INSTANCE,
                 "--RegionId", REGION, "--Timeout", "300")
    inv = json.loads(out)["InvokeId"]
    for _ in range(20):
        time.sleep(5)
        r = json.loads(aliyun("DescribeInvocationResults", "--RegionId", REGION,
                              "--InvokeId", inv))
        rs = r.get("Invocation", {}).get("InvocationResults", {}).get(
            "InvocationResult", [])
        if rs and rs[0].get("InvocationStatus") in ("Success", "Failed",
                                                    "Cancelled", "Timeout"):
            code = rs[0].get("ExitCode", -1)
            output = base64.b64decode(rs[0].get("Output") or "").decode(
                "utf-8", "replace")
            print(f"[{name}] exit={code}")
            if output.strip():
                print(output[-1200:])
            if code != 0:
                raise RuntimeError(f"{name} ExitCode={code}")
            return output
    raise TimeoutError(f"{name} 轮询超时")


def main():
    src = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(
        "E:/AI-Station/WeAppForge/projects/zongbao/content/off.json")
    data = json.loads(src.read_text(encoding="utf-8"))
    offs = [s for s in data.get("off", []) if str(s).strip()]
    b64 = base64.b64encode(src.read_bytes()).decode()
    if len(b64) > 30000:
        raise RuntimeError("off.json 过大（>30KB b64），请走分片工具")
    print(f"本地名单: {len(offs)} 份下架 → {offs}")
    script = (
        f"printf %s '{b64}' | base64 -d > {REMOTE}.new && "
        f"python3 -c \"import json;json.load(open('{REMOTE}.new'))\" && "
        f"mv {REMOTE}.new {REMOTE} && "
        f"systemctl restart {UNIT} && sleep 4 && "
        f"curl -s -o /dev/null -w 'health=%{{http_code}}\\n' {HEALTH} && "
        f"curl -s 'http://127.0.0.1:8871/api/v1/catalog?page=1&page_size=1' "
        f"| head -c 200"
    )
    run(script, "xy-ship-off")
    print("送达+重启完成；total 见上（预期=38-在列数）")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except Exception as e:  # noqa: BLE001
        print(f"FAIL: {e}", file=sys.stderr)
        sys.exit(2)
