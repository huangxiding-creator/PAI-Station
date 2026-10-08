# -*- coding: utf-8 -*-
"""_deploy_v111.py — 官网 index.html 上 ECS（文案改:三年语料沉淀→十年知识沉淀）.
gzip→b64 分片(15000/片)→云助手落位→远端 md5 校验→备份旧件→原子替换。
幂等可重跑。双口 8884/8889 同 root /www/ZongBaoShuo，一文件双生效。"""
import base64
import gzip
import hashlib
import json
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
SRC = Path(r"E:\AI-Station\website\zongbaoshuo\index.html")
DEST = "/www/ZongBaoShuo/index.html"
NAME = "zbs-v111-deploy"


def run(*a, timeout=90):
    r = subprocess.run(["aliyun", *a], capture_output=True, text=True,
                       timeout=timeout, encoding="utf-8", errors="replace")
    if not r.stdout.strip():
        raise RuntimeError(f"aliyun empty out: {r.stderr[:300]}")
    return r.stdout


def ecs(script, wait=180):
    out = run("ecs", "RunCommand", "--RegionId", REGION, "--Type", "RunShellScript",
              "--CommandContent", script, "--Name", NAME,
              "--InstanceId.1", INSTANCE, "--Timeout", "180")
    iid = json.loads(out)["InvokeId"]
    import time
    for _ in range(int(wait / 3)):
        time.sleep(3)
        res = json.loads(run("ecs", "DescribeInvocationResults",
                             "--RegionId", REGION, "--InvokeId", iid))
        rs = res.get("Invocation", {}).get("InvocationResults", {}).get("InvocationResult", [])
        if rs and rs[0].get("ExitCode") is not None:
            return rs[0]["ExitCode"], base64.b64decode(
                rs[0].get("Output") or "").decode("utf-8", "replace")
    return -1, "TIMEOUT"


def main():
    raw = SRC.read_bytes()
    gz = gzip.compress(raw, 9)
    b64 = base64.b64encode(gz).decode()
    md5 = hashlib.md5(raw).hexdigest()
    print(f"[1] index.html={len(raw)}B gz={len(gz)}B b64={len(b64)}c "
          f"shards={(len(b64) + 14999) // 15000} md5={md5}")

    code, out = ecs("rm -f /tmp/zbs_v111.b64 && echo INIT_OK")
    assert "INIT_OK" in out, out
    for i in range(0, len(b64), 15000):
        code, out = ecs(f"printf '%s' '{b64[i:i+15000]}' >> /tmp/zbs_v111.b64 && echo SHARD_OK")
        assert "SHARD_OK" in out, out
    print(f"[2] {len(b64) // 15000 + 1} shards landed")

    script = (
        "set -e; base64 -d /tmp/zbs_v111.b64 | gunzip > /tmp/zbs_v111.html; "
        f"test \"$(md5sum /tmp/zbs_v111.html | cut -d' ' -f1)\" = \"{md5}\" || {{ echo MD5_MISMATCH; exit 2; }}; "
        f"mkdir -p {str(Path(DEST).parent)}; "
        f"[ -f {DEST} ] && cp {DEST} {DEST}.bak-$(date +%Y%m%d-%H%M) || true; "
        f"mv /tmp/zbs_v111.html {DEST}; rm -f /tmp/zbs_v111.b64; "
        f"echo DONE $(md5sum {DEST} | cut -d' ' -f1) $(stat -c%s {DEST})"
    )
    code, out = ecs(script)
    print(f"[3] exit={code} out={out.strip()}")
    return 0 if "DONE " + md5 in out else 1


if __name__ == "__main__":
    raise SystemExit(main())
