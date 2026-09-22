# -*- coding: utf-8 -*-
"""webhook 配置契约实测 — createWebhook -> webhookTest -> GetAPI (0922).

端点: /openapi.v1.OpenapiService/{Method} (GetAPI 已实证 200).
流程: 注册临时 webhook.site 端点 -> 测活 -> 读回配置.
"""
import glob
import json
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

HOOK_URL = "https://webhook.site/a5c348f5-81bd-4726-b45e-7af8352ccb2e"


def call(tok: dict, method: str, body: str = "{}", timeout: int = 20):
    req = urllib.request.Request(
        f"https://api.manus.im/openapi.v1.OpenapiService/{method}",
        data=body.encode("utf-8"), method="POST",
        headers={"Authorization": tok["authorization"],
                 "x-client-id": tok.get("client_id", ""),
                 "Content-Type": "application/json",
                 "x-client-type": "web", "Origin": "https://manus.im"})
    op = urllib.request.build_opener(urllib.request.ProxyHandler(
        {"https": "http://127.0.0.1:7890"}))
    try:
        r = op.open(req, timeout=timeout)
        return r.status, r.read().decode("utf-8", "replace")
    except urllib.error.HTTPError as e:
        return e.code, e.read().decode("utf-8", "replace")[:500]
    except Exception as e:
        return -1, f"{type(e).__name__}: {e}"[:300]


def main() -> None:
    tf = sorted(glob.glob("data/tokens/*.json"))[0]
    email = Path(tf).stem.replace("_at_", "@")
    tok = json.loads(Path(tf).read_text(encoding="utf-8"))
    print(f"[acct] {email}")

    for label, method, body in (
        ("1.GetAPI(前)", "GetAPI", "{}"),
        ("2.createWebhook", "CreateWebhook",
         json.dumps({"webhook": {"url": HOOK_URL}})),
        ("3.webhookTest", "WebhookTest",
         json.dumps({"webhook": {"url": HOOK_URL}})),
        ("4.GetAPI(后)", "GetAPI", "{}"),
    ):
        st, text = call(tok, method, body)
        print(f"\n[{label}] -> {st}")
        print(text[:600])
        time.sleep(2)


if __name__ == "__main__":
    main()
