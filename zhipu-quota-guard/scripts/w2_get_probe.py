# -*- coding: utf-8 -*-
"""W2.1 路①补完 — GET-only 跨域镜像探测：reset 端点族在四域的存在性。
纯 GET 幂等，绝不 POST（误触=烧卡）。密钥同 W0 从 settings.json 读，输出脱敏。"""
import json
import sys
import urllib.error
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

RESET = "/api/v1/coding-plan/reset"


def load_key() -> str:
    s = json.loads(Path.home().joinpath(".claude", "settings.json").read_text(encoding="utf-8"))
    env = s.get("env", s) if isinstance(s, dict) else {}
    return str(env.get("ANTHROPIC_AUTH_TOKEN", "") or "")


def get(url: str, token: str):
    req = urllib.request.Request(url, headers={
        "Authorization": f"Bearer {token}",
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
        "Accept": "application/json",
    })
    try:
        with urllib.request.urlopen(req, timeout=15) as r:
            return r.status, r.read().decode("utf-8", "replace")[:400]
    except urllib.error.HTTPError as e:
        return e.code, e.read().decode("utf-8", "replace")[:400]
    except Exception as e:  # noqa: BLE001
        return -1, repr(e)[:200]


def main() -> int:
    k = load_key()
    print(f"[key] {'***' + k[-4:] if k else 'MISSING'} (len={len(k)})")
    domains = ["zcode.z.ai", "api.z.ai", "open.bigmodel.cn", "bigmodel.cn"]
    paths = [RESET + "/status", RESET + "/history"]
    for dom in domains:
        for p in paths:
            st, body = get(f"https://{dom}{p}", k)
            print(f"[{dom}{p}] HTTP {st} {body[:200]}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
