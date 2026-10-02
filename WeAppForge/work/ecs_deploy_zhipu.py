# -*- coding: utf-8 -*-
"""v0.5.1 增量部署：智谱免费链三文件 + 密钥 → ECS，重启服务并本地探针。
（复用 ecs_deploy.py 的云助手通道；全量部署仍走 ecs_deploy.py）"""
import base64
import json
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(r"E:\AI-Station")
ENGINE = ROOT / "services/qianwen-engine/qianwen_engine"
FILES = {
    "/opt/qianwen/services/qianwen-engine/qianwen_engine/zhipu.py": ENGINE / "zhipu.py",
    "/opt/qianwen/services/qianwen-engine/qianwen_engine/config.py": ENGINE / "config.py",
    "/opt/qianwen/services/qianwen-engine/qianwen_engine/app.py": ENGINE / "app.py",
    "/opt/qianwen/data/secrets/zhipu.secret": ROOT / "data/secrets/zhipu.secret",
}
REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"


def run(*args, timeout=60):
    r = subprocess.run(["aliyun", *args], capture_output=True, text=True, timeout=timeout)
    if r.returncode != 0:
        raise RuntimeError(f"aliyun {' '.join(args[:3])} failed: {r.stderr[:300]}")
    return r.stdout


def ecs_cmd(script, name, wait=300):
    out = run("ecs", "RunCommand", "--RegionId", REGION, "--Type", "RunShellScript",
              "--CommandContent", script, "--Name", name,
              "--InstanceId.1", INSTANCE, "--Timeout", "600", timeout=60)
    iid = json.loads(out)["InvokeId"]
    t0 = time.time()
    while time.time() - t0 < wait:
        time.sleep(4)
        res = json.loads(run("ecs", "DescribeInvocationResults",
                             "--RegionId", REGION, "--InvokeId", iid, timeout=60))
        results = (res.get("Invocation", {}).get("InvocationResults", {})
                   .get("InvocationResult", []))
        if results and results[0].get("ExitCode") is not None:
            output = base64.b64decode(results[0].get("Output") or "")
            return results[0]["ExitCode"], output.decode("utf-8", "replace")
    raise TimeoutError(f"ECS 命令超时: {name}")


def main():
    print("[1/3] 上传 4 个文件（分片追加，规避 RunCommand 内容上限）…")
    CHUNK = 12000
    for i, (remote, local) in enumerate(FILES.items()):
        b64 = base64.b64encode(local.read_bytes()).decode()
        tmp = "/opt/qianwen/up.b64"
        code, _ = ecs_cmd(f"rm -f {tmp}", f"qw-zhipu-c{i}a")
        assert code == 0
        for j in range(0, len(b64), CHUNK):
            code, _ = ecs_cmd(f"printf %s '{b64[j:j + CHUNK]}' >> {tmp}",
                              f"qw-zhipu-c{i}b{j // CHUNK}")
            assert code == 0, f"{remote} 分片失败 @{j}"
        code, out = ecs_cmd(
            f"base64 -d {tmp} > {remote} && chmod 600 {remote} && rm -f {tmp}"
            f" && wc -c < {remote}", f"qw-zhipu-c{i}c")
        assert code == 0, f"{remote} 上传失败"
        print(f"  {remote}: {out.strip()} bytes")

    print("[2/3] 重启 qianwen-engine …")
    code, out = ecs_cmd(
        "systemctl restart qianwen-engine && sleep 3 && systemctl is-active qianwen-engine"
        " && curl -s -o /dev/null -w 'local_probe=%{http_code}' http://127.0.0.1:8869/api/quota",
        "qw-zhipu-restart", wait=120)
    print(out.strip()[-200:])
    assert code == 0 and "local_probe=401" in out, "服务自检未达 401"

    print("[3/3] 完成：zhipu 链在役（生产 smoke 走 ecs_zhipu_smoke.py）")
    return 0


if __name__ == "__main__":
    sys.exit(main())
