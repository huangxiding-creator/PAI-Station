# -*- coding: utf-8 -*-
"""qianwen-engine 阿里云 ECS 部署驱动（通道=云助手 RunCommand，SSH 22 不对公网开）。
布局: /opt/qianwen/{services/qianwen-engine/qianwen_engine, data/secrets, data/qianwen, venv}
"""
import base64
import json
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(r"E:\AI-Station")
PKG_TGZ = ROOT / "WeAppForge/work/qw_engine.tgz"
SECRETS = {
    "metaso_kb_session.json": ROOT / "data/secrets/metaso_kb_session.json",
    "zongbao_qianwen_mp.secret": ROOT / "data/secrets/zongbao_qianwen_mp.secret",
    "qianwen_engine_hmac.key": ROOT / "data/secrets/qianwen_engine_hmac.key",
}
REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
CHUNK = 16000


def run(*args, timeout=60):
    r = subprocess.run(
        ["aliyun", *args], capture_output=True, text=True, timeout=timeout
    )
    if r.returncode != 0:
        raise RuntimeError(f"aliyun {' '.join(args[:3])} failed: {r.stderr[:300]}")
    return r.stdout


def ecs_cmd(script, name, wait=300):
    """在 ECS 执行 shell，阻塞至完成，返回 (exit_code, output_text)。"""
    out = run("ecs", "RunCommand", "--RegionId", REGION, "--Type", "RunShellScript",
              "--CommandContent", script, "--Name", name,
              f"--InstanceId.1", INSTANCE, "--Timeout", "600", timeout=60)
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
    b64 = base64.b64encode(PKG_TGZ.read_bytes()).decode()
    chunks = [b64[i:i + CHUNK] for i in range(0, len(b64), CHUNK)]
    print(f"[1/5] 分片上传 {len(chunks)} 片…")
    ecs_cmd("rm -f /opt/qianwen/pkg.b64 && mkdir -p /opt/qianwen/data/secrets"
            " /opt/qianwen/data/qianwen /opt/qianwen/services/qianwen-engine",
            "qw-mkdir")
    for i, c in enumerate(chunks):
        code, _ = ecs_cmd(f"printf %s '{c}' >> /opt/qianwen/pkg.b64", f"qw-chunk{i}")
        assert code == 0, f"chunk {i} 失败"

    print("[2/5] 解包 + 写密钥…")
    sec_cmds = [
        f"printf %s '{base64.b64encode(p.read_bytes()).decode()}'"
        f" | base64 -d > /opt/qianwen/data/secrets/{n}"
        for n, p in SECRETS.items()
    ]
    code, out = ecs_cmd(
        "base64 -d /opt/qianwen/pkg.b64 | tar xz -C /opt/qianwen/services/qianwen-engine"
        " && ls /opt/qianwen/services/qianwen-engine/qianwen_engine | tr '\\n' ' '"
        " && " + " && ".join(sec_cmds)
        + " && ls -la /opt/qianwen/data/secrets | tail -4",
        "qw-unpack")
    print(out.strip()[:400])
    assert code == 0

    print("[3/5] venv + 依赖（阿里云镜像）…")
    code, out = ecs_cmd(
        "test -x /opt/qianwen/venv/bin/pip || python3 -m venv /opt/qianwen/venv;"
        "/opt/qianwen/venv/bin/pip install -q -i https://mirrors.aliyun.com/pypi/simple/"
        " fastapi 'uvicorn[standard]' curl_cffi && echo PIP_OK"
        " && /opt/qianwen/venv/bin/python -c 'import curl_cffi,fastapi,uvicorn"
        " && print(\"IMPORT_OK\")'",
        "qw-pip", wait=420)
    print(out.strip()[-300:])
    assert "IMPORT_OK" in out, "依赖安装失败"

    print("[4/5] systemd 常驻服务…")
    unit = (
        "[Unit]\nDescription=qianwen-engine (biaoxun KB)\nAfter=network.target\n\n"
        "[Service]\nWorkingDirectory=/opt/qianwen/services/qianwen-engine\n"
        "ExecStart=/opt/qianwen/venv/bin/python -m uvicorn qianwen_engine.app:app"
        " --host 0.0.0.0 --port 8869 --log-level warning\n"
        "Restart=always\nRestartSec=3\n\n[Install]\nWantedBy=multi-user.target\n"
    )
    ub64 = base64.b64encode(unit.encode()).decode()
    code, out = ecs_cmd(
        f"printf %s '{ub64}' | base64 -d > /etc/systemd/system/qianwen-engine.service"
        " && systemctl daemon-reload && systemctl enable --now qianwen-engine"
        " && sleep 3 && systemctl is-active qianwen-engine"
        " && curl -s -o /dev/null -w 'local_probe=%{{http_code}}' http://127.0.0.1:8869/api/quota",
        "qw-systemd", wait=120)
    print(out.strip()[-300:])
    assert code == 0 and "local_probe=401" in out, "服务自检未达 401"

    print("[5/5] 完成")
    return 0


if __name__ == "__main__":
    sys.exit(main())
