# -*- coding: utf-8 -*-
"""海报码切正式版（用户令 1001：包括海报的码也切到最后的正式版）。
带发布活体门：先探线上 release 页面表——pages/ask/ask 在表=0.7.3 已发布→
本机+ECS 双双 trial→release（台账#71 教训：两处必须同步切）+重启+自检；
不在表(41030)=release 仍旧 1.0.7→拒绝切（此刻切=海报码重演「页面不存在」），
重试窗口内每 45s 复探（捕捉刚点发布的传播时延）。幂等可重跑。"""
import base64
import io
import json
import subprocess
import sys
import time
from pathlib import Path

from curl_cffi import requests

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path(r"E:\AI-Station")
LOCAL_CFG = ROOT / "services/qianwen-engine/qianwen_engine/config.py"
REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
REMOTE_CFG = "/opt/qianwen/services/qianwen-engine/qianwen_engine/config.py"


def probe_release(page: str, token: str) -> bool:
    """check_path=true：release 页面表含该页 → True。"""
    r = requests.post(
        f"https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token={token}",
        data=io.BytesIO(json.dumps({
            "page": page, "scene": "probe-rel",
            "check_path": True, "env_version": "release", "width": 280,
        }).encode("utf-8")),
        headers={"Content-Type": "application/json"},
        impersonate="chrome", timeout=60)
    b = r.content
    return b[:4] == b"\x89PNG" or b[:3] == b"\xff\xd8\xff"


def get_token() -> str:
    sec = dict(l.strip().split("=", 1) for l in io.open(
        ROOT / "data/secrets/zongbao_qianwen_mp.secret", encoding="utf-8") if "=" in l)
    d = requests.get("https://api.weixin.qq.com/cgi-bin/token",
                     params={"grant_type": "client_credential",
                             "appid": sec["appid"], "secret": sec["appsecret"]},
                     impersonate="chrome", timeout=30).json()
    if "access_token" not in d:
        raise RuntimeError(f"token fail: {d.get('errcode')} {d.get('errmsg')}")
    return d["access_token"]


def ecs(script: str, name: str, wait: int = 240):
    r = subprocess.run(
        ["aliyun", "ecs", "RunCommand", "--RegionId", REGION, "--Type", "RunShellScript",
         "--CommandContent", script, "--Name", name,
         "--InstanceId.1", INSTANCE, "--Timeout", "300"],
        capture_output=True, text=True, timeout=90, encoding="utf-8", errors="replace")
    iid = json.loads(r.stdout)["InvokeId"]
    for _ in range(int(wait / 3)):
        time.sleep(3)
        res = json.loads(subprocess.run(
            ["aliyun", "ecs", "DescribeInvocationResults", "--RegionId", REGION,
             "--InvokeId", iid], capture_output=True, text=True, timeout=90,
            encoding="utf-8", errors="replace").stdout)
        rs = (res.get("Invocation", {}).get("InvocationResults", {})
              .get("InvocationResult", []))
        if rs and rs[0].get("ExitCode") is not None:
            out = base64.b64decode(rs[0].get("Output") or "").decode("utf-8", "replace")
            return rs[0]["ExitCode"], out
    return -1, "TIMEOUT"


def flip_local() -> None:
    text = LOCAL_CFG.read_text(encoding="utf-8")
    old = 'POSTER_QR_ENV_VERSION = "trial"'
    new = 'POSTER_QR_ENV_VERSION = "release"'
    if new in text:
        print("[local] 已是 release，跳过")
        return
    assert old in text, "local config 未找到 trial 行"
    LOCAL_CFG.write_text(text.replace(old, new, 1), encoding="utf-8")
    got = [l for l in LOCAL_CFG.read_text(encoding="utf-8").splitlines()
           if "POSTER_QR_ENV_VERSION" in l]
    assert got and '"release"' in got[0], got
    print(f"[local] OK {got[0].strip()}")


def flip_remote() -> None:
    code, out = ecs(
        f"cd /opt/qianwen/services/qianwen-engine"
        f" && sed -i 's|POSTER_QR_ENV_VERSION = \"trial\"|POSTER_QR_ENV_VERSION = \"release\"|'"
        f" qianwen_engine/config.py"
        f" && grep -n POSTER_QR_ENV_VERSION qianwen_engine/config.py"
        f" && /opt/qianwen/venv/bin/python -m py_compile qianwen_engine/*.py"
        f" && systemctl restart qianwen-engine && sleep 3"
        f" && systemctl is-active qianwen-engine"
        f" && curl -s -o /dev/null -w 'local_probe=%{{http_code}}' http://127.0.0.1:8869/api/health",
        "qw-poster-release", wait=180)
    print("[ecs]", out.strip()[-300:])
    assert code == 0 and "local_probe=200" in out and '"release"' in out, "ECS 切换自检未过"


def main() -> int:
    print("[1/3] 探线上 release 页面表（发布活体门）…")
    token = get_token()
    live = False
    for i in range(5):
        if probe_release("pages/ask/ask", token):
            live = True
            print(f"  probe#{i}: pages/ask/ask 在 release 表 —— 0.7.3 已发布")
            break
        print(f"  probe#{i}: 41030 —— release 仍无 ask（旧 1.0.7），45s 后复探")
        if i < 4:
            time.sleep(45)
    if not live:
        print("ABORT: 正式版未发布（release 表无 pages/ask/ask）。"
              "此刻切 release=海报码扫出旧 1.0.7 报「页面不存在」（台账#71 同型事故）。"
              "等控制台「版本管理→发布 0.7.3」完成后重跑本脚本即自动完成切换。")
        return 2

    print("[2/3] 本机 config.py 切 release …")
    flip_local()
    print("[3/3] ECS 切 release + 重启 + 自检 …")
    flip_remote()
    print("[OK] 海报码=release（海报缓存按 env 隔离自动失效重生成，无需清缓存）")
    return 0


if __name__ == "__main__":
    sys.exit(main())
