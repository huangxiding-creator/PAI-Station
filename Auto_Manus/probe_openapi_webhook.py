# -*- coding: utf-8 -*-
"""探 OpenapiService (webhook/API key 面) — 用存档 token 纯 urllib.

已知前端契约: getAPI({})->{apiKeys,webhooks}; createWebhook({webhook:{url}}).
connect-RPC URL: /{package}.OpenapiService/{Method} — package 试错.
"""
import glob
import json
import sys
import urllib.error
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")


def call(tok: dict, path: str, body: str = "{}", timeout: int = 15):
    req = urllib.request.Request(
        "https://api.manus.im" + path, data=body.encode("utf-8"), method="POST",
        headers={"Authorization": tok["authorization"],
                 "x-client-id": tok.get("client_id", ""),
                 "Content-Type": "application/json",
                 "x-client-type": "web", "Origin": "https://manus.im"})
    op = urllib.request.build_opener(urllib.request.ProxyHandler(
        {"https": "http://127.0.0.1:7890"}))
    try:
        r = op.open(req, timeout=timeout)
        return r.status, r.read().decode("utf-8", "replace")[:2000]
    except urllib.error.HTTPError as e:
        return e.code, e.read().decode("utf-8", "replace")[:300]
    except Exception as e:
        return -1, f"{type(e).__name__}: {e}"[:200]


def main():
    tf = sorted(glob.glob("data/tokens/*.json"))[0]
    email = Path(tf).stem.replace("_at_", "@")
    tok = json.loads(Path(tf).read_text(encoding="utf-8"))
    print(f"[acct] {email}")
    for pkg in ("openapi.v1", "api.v1", "openapi", "v1", "openapi.api"):
        for meth in ("GetAPI", "getAPI"):
            path = f"/{pkg}.OpenapiService/{meth}"
            st, text = call(tok, path)
            print(f"  {path} -> {st} {text[:150]}")
            if st == 200:
                print("[HIT] 端点定案")
                return


if __name__ == "__main__":
    main()
