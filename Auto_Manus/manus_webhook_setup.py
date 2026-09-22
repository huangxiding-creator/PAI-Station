# -*- coding: utf-8 -*-
"""军团 webhook 批量配置器 — 每账号唯一回调 URL (0922).

URL: http://47.120.43.20:8890/hk/<SECRET>/<ACCT>  — ACCT=token 文件安全名.
幂等: GetAPI 查已注册; 同 URL active=跳过, 旧 URL=删旧建新.
默认 dry-run, --apply 实配; --limit N 试点前 N 个.

契约 (0922 实证): createWebhook->webhook_id; webhookTest->statusCode;
GetAPI->{webhooks:[{webhookId,url,status}]}.
"""
import argparse
import glob
import json
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
TOKEN_DIR = Path("data/tokens")
SECRET = Path("data/hook_secret.txt").read_text(encoding="utf-8").strip()
HOOK_BASE = "http://47.120.43.20:8890/hk"
API = "https://api.manus.im/openapi.v1.OpenapiService"
REQ_GAP = 1.2  # 同账号相邻请求节流 (秒)


def call(tok: dict, method: str, body: str, timeout: int = 20):
    req = urllib.request.Request(
        f"{API}/{method}", data=body.encode("utf-8"), method="POST",
        headers={"Authorization": tok["authorization"],
                 "x-client-id": tok.get("client_id", ""),
                 "Content-Type": "application/json",
                 "x-client-type": "web", "Origin": "https://manus.im"})
    op = urllib.request.build_opener(urllib.request.ProxyHandler(
        {"https": "http://127.0.0.1:7890"}))
    try:
        r = op.open(req, timeout=timeout)
        return r.status, json.loads(r.read().decode("utf-8", "replace"))
    except urllib.error.HTTPError as e:
        return e.code, e.read().decode("utf-8", "replace")[:200]
    except Exception as e:
        return -1, f"{type(e).__name__}"


def configure_one(tf: Path, apply: bool) -> str:
    """单账号配置. 返回 outcome: ok-skip/ok-new/ok-replace/fail-*."""
    acct = tf.stem
    email = acct.replace("_at_", "@")
    want_url = f"{HOOK_BASE}/{SECRET}/{acct}"
    tok = json.loads(tf.read_text(encoding="utf-8"))

    st, cur = call(tok, "GetAPI", "{}")
    if st != 200:
        return f"fail-getapi({st})"
    hooks = cur.get("webhooks") or []
    same = [h for h in hooks if h.get("url") == want_url
            and h.get("status") == "active"]
    if same:
        return "ok-skip(已active)"

    if not apply:
        return f"dry(需配: 现有{len(hooks)}条)"

    for h in hooks:  # 清旧 (只增不删原则不适用于对端配置: 旧URL已不可达, 留着是死配置)
        call(tok, "DeleteWebhook",
             json.dumps({"webhookId": h.get("webhookId")}))
        time.sleep(REQ_GAP)

    st, r = call(tok, "CreateWebhook", json.dumps({"webhook": {"url": want_url}}))
    if st != 200:
        return f"fail-create({st})"
    wid = r.get("webhook_id") or r.get("webhookId")
    time.sleep(REQ_GAP)
    st, r = call(tok, "WebhookTest", json.dumps({"webhook": {"url": want_url}}))
    code = (r.get("result", {}).get("response", {}).get("statusCode")
            if isinstance(r, dict) else None)
    mark = "" if code == 200 else "  <== test未达200!"
    return f"ok-new({wid[:8]} test={code}){mark}"


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true", help="实配 (默认 dry-run)")
    ap.add_argument("--limit", type=int, default=0, help="只配前 N 个 (试点)")
    ap.add_argument("--acct", help="只配指定账号 (token 文件 stem)")
    args = ap.parse_args()

    files = sorted(TOKEN_DIR.glob("*.json"))
    if args.acct:
        files = [f for f in files if f.stem == args.acct]
    if args.limit:
        files = files[:args.limit]
    print(f"[mode] {'APPLY' if args.apply else 'DRY-RUN'} 账号数={len(files)}")

    stats = {}
    for i, tf in enumerate(files, 1):
        try:
            out = configure_one(tf, args.apply)
        except Exception as e:
            out = f"fail-exc({type(e).__name__})"
        stats[out.split("(")[0]] = stats.get(out.split("(")[0], 0) + 1
        flag = "" if out.startswith(("ok", "dry")) else "  <=="
        print(f"  [{i}/{len(files)}] {tf.stem}: {out}{flag}")
        time.sleep(REQ_GAP)
    print("\n[汇总]", json.dumps(stats, ensure_ascii=False))


if __name__ == "__main__":
    main()
