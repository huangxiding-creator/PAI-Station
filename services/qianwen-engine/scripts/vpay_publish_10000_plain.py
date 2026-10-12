# -*- coding: utf-8 -*-
"""vpay_publish_10000_plain.py — report_10000 现网发布（plain requests 通道）。

背景：1012 curl_cffi(impersonate=chrome) 经 Clash TUN 连 api.weixin.qq.com 被掐
（SSL_ERROR_SYSCALL，复现两次；普通 requests/curl 通畅）。签名是纯计算，仍复用
引擎 wechat.virtual_pay_sign；HTTP 腿换 requests，其余流程=scripts/vpay_goods_publish.py
（query → upload → publish → poll，幂等可重跑）。只处理 report_10000。

用法: python scripts/vpay_publish_10000_plain.py [--query-only]
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

import requests

PKG_PARENT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(PKG_PARENT))

from qianwen_engine import config, wechat  # noqa: E402
from scripts.vpay_goods_publish import vp_secret, appkey_for  # noqa: E402

ITEM = {"id": "report_10000", "name": "研究报告解锁-10000元", "price": 1000000,
        "remark": "解锁旗舰蓝皮书五卷套装 10000元档，一次解锁永久阅读",
        "item_url": "https://ai.epcschool.top/static/goods/zongbaojun.jpg"}
API_BASE = "https://api.weixin.qq.com"
STATE_FILE = config.REPO / "data" / "state" / "vpay_goods_publish.json"


def get_token() -> str:
    secret = None
    f = config.MP_SECRET_FILE
    if f and f.exists():
        for line in f.read_text(encoding="utf-8").splitlines():
            if line.startswith("appsecret="):
                secret = line.split("=", 1)[1].strip()
    if not secret:
        sys.exit("FATAL: appsecret 未配置")
    r = requests.get(f"{API_BASE}/cgi-bin/token",
                     params={"grant_type": "client_credential",
                             "appid": config.WX_APPID, "secret": secret}, timeout=15)
    d = r.json()
    if d.get("errcode"):
        sys.exit(f"FATAL: access_token {d.get('errcode')}: {d.get('errmsg')}")
    return d["access_token"]


def call_xpay(token: str, method_uri: str, payload: dict, app_key: str,
              retry_rate_limit: int = 3) -> dict:
    body = json.dumps(payload, separators=(",", ":"), ensure_ascii=False)
    _, pay_sig, _ = wechat.virtual_pay_sign(app_key, "", body=body, uri=method_uri)
    d = {}
    for attempt in range(retry_rate_limit + 1):
        r = requests.post(f"{API_BASE}{method_uri}",
                          params={"access_token": token, "pay_sig": pay_sig},
                          data=body.encode("utf-8"),
                          headers={"Content-Type": "application/json"}, timeout=20)
        try:
            d = r.json()
        except Exception:  # noqa: BLE001
            sys.exit(f"FATAL: {method_uri} 响应非 JSON（HTTP {r.status_code}）: {r.text[:200]}")
        if d.get("errcode") == 268490015 and attempt < retry_rate_limit:
            wait = 15 * (attempt + 1)
            print(f"     限频，{wait}s 后重试（{attempt + 1}/{retry_rate_limit}）", flush=True)
            time.sleep(wait)
            continue
        break
    time.sleep(3)
    if d.get("errcode"):
        print(f"ERR  {method_uri} errcode={d.get('errcode')} {d.get('errmsg')}", flush=True)
    return d


def parse_publish_status(q: dict) -> dict:
    out = {}
    for key in ("publish_item", "publish_goods", "goods", "list", "item_list"):
        rows = q.get(key)
        if isinstance(rows, list):
            for it in rows:
                gid = it.get("id") or it.get("item_id")
                if gid:
                    out[str(gid)] = it.get("publish_status", it.get("status"))
            if out:
                break
    return out


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--query-only", action="store_true")
    args = ap.parse_args()

    vp = vp_secret()
    env = 0
    app_key = appkey_for(vp, env)
    if vp.get("report_product_10000") != "report_10000":
        sys.exit("FATAL: secret report_product_10000 对账不过")

    token = get_token()
    print(f"== plain-requests publish env={env} item={ITEM['id']} price={ITEM['price']}", flush=True)

    q = call_xpay(token, "/xpay/query_publish_goods", {"env": env}, app_key)
    cur = parse_publish_status(q)
    print(f"query: {json.dumps(cur, ensure_ascii=False)}", flush=True)
    if args.query_only:
        print(json.dumps(q, ensure_ascii=False, indent=2)[:2000])
        return 0

    if cur.get(ITEM["id"]) == 2:
        print("OK   report_10000 已是发布成功态，跳过", flush=True)
        return 0

    d = call_xpay(token, "/xpay/start_upload_goods", {"upload_item": [ITEM], "env": env}, app_key)
    print(f"upload: {json.dumps(d, ensure_ascii=False)}", flush=True)
    if d.get("errcode"):
        return 2

    for attempt in range(11):
        d = call_xpay(token, "/xpay/start_publish_goods",
                      {"publish_item": [{"id": ITEM["id"]}], "env": env}, app_key)
        print(f"publish: {json.dumps(d, ensure_ascii=False)}", flush=True)
        if d.get("errcode") == 268490012 and attempt < 10:
            print(f"     批量任务运行中，60s 后重试（{attempt + 1}/10）", flush=True)
            time.sleep(60)
            continue
        break
    if d.get("errcode"):
        return 3

    deadline = time.time() + 600
    while time.time() < deadline:
        time.sleep(30)
        q = call_xpay(token, "/xpay/query_publish_goods", {"env": env}, app_key)
        cur = parse_publish_status(q)
        print(f"poll: task_status={q.get('status')} items={json.dumps(cur, ensure_ascii=False)}", flush=True)
        if q.get("status") == 3 and cur.get(ITEM["id"]) == 2:
            print("PUBLISHED [OK] report_10000", flush=True)
            return 0
    print("TIMEOUT：publish ACK 已拿，未在限内确认（可重跑续查）", flush=True)
    return 4


if __name__ == "__main__":
    sys.exit(main())
