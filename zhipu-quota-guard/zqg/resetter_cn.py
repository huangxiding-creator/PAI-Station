# -*- coding: utf-8 -*-
"""resetter_cn — CN 域重置执行器（www.bigmodel.cn/api/biz/customer-package-reset/use）。

协议源：skill tencent-captcha-click references/bigmodel-console-protocol.md
（JS bundle 3870.5d6be6fc.js 静态取证，2026-10-23）。JWT=cookie bigmodel_token_production。
"""
from __future__ import annotations

import json
import random
import sys
import time
import urllib.error
import urllib.request
import uuid
from pathlib import Path
from typing import Any, Callable

ROOT = Path(__file__).resolve().parents[1]
STATE = ROOT / "state"
CN_BASE = "https://www.bigmodel.cn/api"

Errors = (__import__("zqg.resetter", fromlist=["ThrottledError", "BizError"]) if False else None)


class ThrottledError(RuntimeError):
    pass


class BizError(RuntimeError):
    pass


def _jwt() -> str:
    p = STATE / "zcode_jwt.txt"
    if not p.exists():
        raise BizError("JWT 缺失（state/zcode_jwt.txt）——先跑 browser_relogin")
    t = p.read_text(encoding="utf-8").strip()
    return t if t.lower().startswith("bearer") else "Bearer " + t


def _req(url: str, jwt: str, payload: dict | None = None, transport=None) -> tuple[int, dict]:
    data = json.dumps(payload).encode() if payload is not None else None
    headers = {"Authorization": jwt, "accept": "application/json",
               "User-Agent": "Mozilla/5.0", "Bigmodel-Target-Type": "PERSONAL"}
    if data is not None:
        headers["content-type"] = "application/json"
    if transport is not None:
        return transport(url, headers, data)
    r = urllib.request.Request(url, data=data, headers=headers)
    try:
        with urllib.request.urlopen(r, timeout=15) as resp:
            return resp.status, json.loads(resp.read().decode("utf-8", "replace") or "{}")
    except urllib.error.HTTPError as e:
        try:
            return e.code, json.loads(e.read().decode("utf-8", "replace") or "{}")
        except Exception:  # noqa: BLE001
            return e.code, {}


def fetch_cards(jwt: str | None = None, transport=None) -> dict:
    j = jwt or _jwt()
    st, body = _req(f"{CN_BASE}/biz/customer-package-reset/list?targetType=PERSONAL", j, transport=transport)
    if st != 200 or body.get("code") != 200:
        raise BizError(f"card list {st}: {str(body)[:150]}")
    return body.get("data") or {}


def execute(reset_type: str = "five_hour", *, mode: str = "auto",
            ledger: Any = None, sleep: Callable[[float], None] = time.sleep,
            rng: Callable[[], float] = random.random, transport=None) -> dict:
    """按有效期 FIFO 选卡并使用。dry_run/notify_only 不发真包。"""
    typ = "FIVE_HOUR" if reset_type in ("five_hour", "FIVE_HOUR", 3) else "WEEK"
    src = {"FIVE_HOUR": "fiveHourResets", "WEEK": "weekResets"}[typ]
    if mode in ("dry_run", "notify_only"):
        time.sleep(0)
        return {"simulated": True, "reset_type": typ, "mode": mode}
    jwt = _jwt()
    # 防风控前置延迟
    sleep(3 + rng() * 5)
    cards = fetch_cards(jwt, transport=transport)
    pool = [c for c in (cards.get(src) or []) if c.get("available")]
    if not pool:
        raise BizError(f"无可用 {typ} 卡（库存见 list 响应）")
    pool.sort(key=lambda c: str(c.get("expireTime") or ""))   # FIFO：先花快过期
    card = pool[0]
    payload = {"targetType": "PERSONAL", "resetType": typ,
               "recordId": str(card.get("recordId", "")),
               "grantType": card.get("grantType", "GLOBAL"),
               "requestId": str(uuid.uuid4())}
    st, body = _req(f"{CN_BASE}/biz/customer-package-reset/use", jwt, payload, transport=transport)
    if st == 429:
        raise ThrottledError("use 429 限流")
    if st != 200 or body.get("code") != 200 or body.get("success") is not True:
        raise BizError(f"use {st}: {str(body)[:200]}")
    if ledger is not None:
        try:
            ledger.append("reset_result", {"card": typ, "recordId": payload["recordId"],
                                           "expire": card.get("expireTime"), "ok": True})
        except Exception:  # noqa: BLE001
            pass
    return {"ok": True, "reset_type": typ, "recordId": payload["recordId"],
            "expire": card.get("expireTime")}


if __name__ == "__main__":
    print(json.dumps(fetch_cards(), ensure_ascii=False)[:300])
