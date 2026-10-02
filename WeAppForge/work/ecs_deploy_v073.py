# -*- coding: utf-8 -*-
"""v0.7.3 引擎增量上云：tar 打包 qianwen_engine/ + 播种机 + 题库 → b64 分片 → 云助手落位
→ py_compile → systemctl restart → health。幂等可重跑。"""
import base64
import json
import subprocess
import sys
import tarfile
import time
from io import BytesIO
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
SRC = Path(r"E:\AI-Station\services\qianwen-engine")
DEST = "/opt/qianwen/services/qianwen-engine"
NAME = "qw-v073-deploy"


def run(*a, timeout=90):
    r = subprocess.run(["aliyun", *a], capture_output=True, text=True,
                       timeout=timeout, encoding="utf-8", errors="replace")
    return r.stdout


def ecs(script, name=NAME, wait=300):
    out = run("ecs", "RunCommand", "--RegionId", REGION, "--Type", "RunShellScript",
              "--CommandContent", script, "--Name", name,
              "--InstanceId.1", INSTANCE, "--Timeout", "300")
    iid = json.loads(out)["InvokeId"]
    for _ in range(int(wait / 3)):
        time.sleep(3)
        res = json.loads(run("ecs", "DescribeInvocationResults", "--RegionId", REGION, "--InvokeId", iid))
        rs = res.get("Invocation", {}).get("InvocationResults", {}).get("InvocationResult", [])
        if rs and rs[0].get("ExitCode") is not None:
            code = rs[0]["ExitCode"]
            text = base64.b64decode(rs[0].get("Output") or "").decode("utf-8", "replace")
            return code, text
    return -1, "TIMEOUT"


def main():
    # [1] 打包：引擎包 + 播种机 + 题库（剔 __pycache__/tests）
    buf = BytesIO()
    with tarfile.open(fileobj=buf, mode="w:gz") as tf:
        for p in sorted((SRC / "qianwen_engine").rglob("*.py")):
            if "__pycache__" in p.parts:
                continue
            tf.add(str(p), arcname=f"qianwen_engine/{p.relative_to(SRC / 'qianwen_engine')}")
        tf.add(str(SRC / "pot_seed_zhipu.py"), arcname="pot_seed_zhipu.py")
        tf.add(r"E:\AI-Station\WeAppForge\work\pot_questions_v2.json", arcname="pot_questions_v2.json")
    blob = buf.getvalue()
    b64 = base64.b64encode(blob).decode()
    print(f"[1] tgz={len(blob)}B b64={len(b64)}c shards={(len(b64) + 14999) // 15000}")

    # [2] 分片落位（追加式）
    code, out = ecs("rm -f /tmp/qw_v073.b64 && echo INIT_OK")
    assert "INIT_OK" in out, out
    for i in range(0, len(b64), 15000):
        chunk = b64[i:i + 15000]
        code, out = ecs(f"printf '%s' '{chunk}' >> /tmp/qw_v073.b64 && wc -c < /tmp/qw_v073.b64",
                        name=f"{NAME}-s{i // 15000}")
        expected = min(i + 15000, len(b64))
        if str(expected) not in out.replace(" ", ""):
            print(f"[2] shard {i // 15000} 长度不符: {out.strip()} != {expected}")
            return 1
    print(f"[2] {((len(b64) + 14999) // 15000)} 片全部落位")

    # [3] 备份现役 + 解包 + 编译 + 重启 + 自检
    script = (
        "cd /opt/qianwen/services/qianwen-engine && "
        "mkdir -p /opt/qianwen/backup_v072 && cp -r qianwen_engine /opt/qianwen/backup_v072/ && "
        "base64 -d /tmp/qw_v073.b64 | tar xzf - && rm -f /tmp/qw_v073.b64 && "
        "/opt/qianwen/venv/bin/python -m py_compile qianwen_engine/*.py pot_seed_zhipu.py && echo COMPILE_OK && "
        "systemctl restart qianwen-engine && sleep 3 && "
        "systemctl is-active qianwen-engine && "
        "curl -s -o /dev/null -w 'local=%{http_code}\\n' http://127.0.0.1:8869/api/health && "
        "sqlite3 /opt/qianwen/data/qianwen/db.sqlite 'SELECT count(*) FROM pot_items;' && "
        "python3 - <<'PY'\n"
        "import sqlite3\n"
        "con = sqlite3.connect('/opt/qianwen/data/qianwen/db.sqlite')\n"
        "cols = [r[1] for r in con.execute('PRAGMA table_info(answers)')]\n"
        "print('answers cols has views/shares:', 'views' in cols, 'shares' in cols)\n"
        "PY"
    )
    code, out = ecs(script, name=f"{NAME}-go", wait=240)
    print("[3]", out.strip())
    if code != 0 or "COMPILE_OK" not in out or "local=200" not in out:
        print("!! 部署自检未过")
        return 1
    print("[OK] v0.7.3 引擎已上云（views/shares 迁移 + 三动作奖励 + 隐私门）")
    return 0


if __name__ == "__main__":
    sys.exit(main())
