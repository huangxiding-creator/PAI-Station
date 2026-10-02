# -*- coding: utf-8 -*-
"""v0.7.0 热修：wechat.py token 40001 自愈 + 海报码切 release（用户令：海报码切正式版后提审）。"""
import base64
import json
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(r"E:\AI-Station")
ENGINE = ROOT / "services/qianwen-engine/qianwen_engine"
FILES = {
    "/opt/qianwen/services/qianwen-engine/qianwen_engine/wechat.py": ENGINE / "wechat.py",
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
    print("[1/3] 上传 wechat.py（token 自愈）…")
    CHUNK = 12000
    for i, (remote, local) in enumerate(FILES.items()):
        b64 = base64.b64encode(local.read_bytes()).decode()
        tmp = "/opt/qianwen/up.b64"
        code, _ = ecs_cmd(f"rm -f {tmp}", f"qw-v070h-c{i}a")
        assert code == 0
        for j in range(0, len(b64), CHUNK):
            code, _ = ecs_cmd(f"printf %s '{b64[j:j + CHUNK]}' >> {tmp}",
                              f"qw-v070h-c{i}b{j // CHUNK}")
            assert code == 0
        code, out = ecs_cmd(f"base64 -d {tmp} > {remote} && rm -f {tmp} && wc -c < {remote}",
                            f"qw-v070h-c{i}c")
        assert code == 0
        print(f"  {remote.split('/')[-1]}: {out.strip()} bytes")

    print("[2/3] 海报码切 release + 重启 + 自检 …")
    code, out = ecs_cmd(
        "cd /opt/qianwen/services/qianwen-engine"
        " && sed -i 's|POSTER_QR_ENV_VERSION = \"trial\"|POSTER_QR_ENV_VERSION = \"release\"|'"
        " qianwen_engine/config.py"
        " && grep -n POSTER_QR_ENV_VERSION qianwen_engine/config.py"
        " && /opt/qianwen/venv/bin/python -m py_compile qianwen_engine/*.py"
        " && systemctl restart qianwen-engine && sleep 3"
        " && systemctl is-active qianwen-engine"
        " && curl -s -o /dev/null -w 'local_probe=%{http_code}' http://127.0.0.1:8869/api/health",
        "qw-v070h-restart", wait=120)
    print(out.strip()[-300:])
    assert code == 0 and "local_probe=200" in out and 'POSTER_QR_ENV_VERSION = "release"' in out

    print("[3/3] 完成：token 自愈在役 + 海报码=release（提审后发布即生效）")
    return 0


if __name__ == "__main__":
    sys.exit(main())
