"""企微自建应用连通性探测：凭证 → gettoken → 业务 API 逐面探测。

用法：
  python tools/wecom_probe.py            # 全部探测
  python tools/wecom_probe.py --only agent,contact

凭证从 config/wecom.secret.ini 读取（gitignored，永不回显）。
access_token 内存即用即弃，不落盘。
"""
from __future__ import annotations

import argparse
import configparser
import json
import urllib.request
from pathlib import Path

CONFIG = Path(__file__).resolve().parents[1] / "config" / "wecom.secret.ini"
BASE = "https://qyapi.weixin.qq.com/cgi-bin"


def load_creds() -> dict:
    cp = configparser.ConfigParser()
    if not cp.read(CONFIG, encoding="utf-8"):
        raise SystemExit(f"missing config: {CONFIG}")
    return {k: cp["wecom"][k] for k in ("corp_id", "agent_id", "secret")}


def _get(url: str, timeout: int = 15) -> dict:
    with urllib.request.urlopen(url, timeout=timeout) as r:
        return json.loads(r.read().decode("utf-8"))


def fetch_token(corp: str, secret: str) -> str:
    d = _get(f"{BASE}/gettoken?corpid={corp}&corpsecret={secret}")
    if d.get("errcode"):
        raise SystemExit(f"gettoken failed: {d.get('errcode')} {d.get('errmsg')}")
    return d["access_token"]


PROBES = {
    "agent": ("agent/get", lambda a: f"&agentid={a['agent_id']}"),
    "contact": ("user/simplelist", lambda a: "&department_id=1&fetch_child=1"),
}


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(prog="wecom_probe")
    parser.add_argument("--only", default=",".join(PROBES),
                        help="comma-separated: " + ",".join(PROBES))
    args = parser.parse_args(argv)

    creds = load_creds()
    token = fetch_token(creds["corp_id"], creds["secret"])
    print("gettoken: ok")
    for name in [n.strip() for n in args.only.split(",") if n.strip()]:
        path, mk = PROBES[name]
        try:
            d = _get(f"{BASE}/{path}?access_token={token}{mk(creds)}")
        except Exception as e:  # noqa: BLE001 — 探测工具，异常即结果
            print(f"{name}: network-error {type(e).__name__}")
            continue
        code = d.get("errcode")
        print(f"{name}: errcode={code} {d.get('errmsg', '')}")
        if code == 0 and name == "contact":
            for u in (d.get("userlist") or [])[:10]:
                print(f"  - {u.get('name')} | {u.get('userid')} | status={u.get('status')}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
