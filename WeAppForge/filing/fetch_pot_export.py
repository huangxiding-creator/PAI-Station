# -*- coding: utf-8 -*-
"""从 ECS 分块拉取锅圈导出文件并端到端校验。"""
import base64
import gzip
import json
import subprocess
import time

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
TOTAL = 173428
CHUNK = 15000


def run_cmd(shell: str) -> str:
    r = subprocess.run(
        ["aliyun", "ecs", "RunCommand", "--RegionId", REGION, "--Type", "RunShellScript",
         "--CommandContent", shell, "--InstanceId.1", INSTANCE],
        capture_output=True, text=True, timeout=60)
    inv = json.loads(r.stdout)["InvokeId"]
    for _ in range(20):
        time.sleep(4)
        r2 = subprocess.run(
            ["aliyun", "ecs", "DescribeInvocationResults", "--RegionId", REGION,
             "--InvokeId", inv], capture_output=True, text=True, timeout=60)
        d = json.loads(r2.stdout)
        res = d["Invocation"]["InvocationResults"]["InvocationResult"][0]
        if res.get("InvocationStatus") in ("Finished", "Success", "Running"):
            if res.get("Output"):
                return base64.b64decode(res["Output"]).decode("utf-8", "replace").strip()
    raise RuntimeError("no output for " + inv)


def main() -> int:
    parts = []
    pos = 1
    while pos <= TOTAL:
        end = min(pos + CHUNK - 1, TOTAL)
        out = run_cmd(f"cut -c {pos}-{end} /tmp/pot_b64.txt")
        # 去掉命令 echo 的换行尾巴
        parts.append(out.strip())
        print(f"chunk {pos}-{end}: got {len(out)} chars")
        pos = end + 1
    b64 = "".join(parts)
    print("assembled b64 len:", len(b64))
    data = gzip.decompress(base64.b64decode(b64))
    obj = json.loads(data.decode("utf-8"))
    print("answers:", len(obj["answers"]), "pot_items:", len(obj["pot_items"]))
    with open("pot_export.json", "wb") as f:
        f.write(data)
    print("saved pot_export.json", len(data), "bytes")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
