# -*- coding: utf-8 -*-
"""WeChatPadPro 双小号登录辅助（T-041）：GenAuthKey×2 → 各自二维码 → 落 accounts.json。

用法：py -I revenue-engine/probes/wpp_login.py
输出：两个二维码 URL（终端打印，浏览器打开扫码）+ accounts.json 写入
      revenue-engine/reports/survival/accounts.json（survival_watch.py 消费）
"""
from __future__ import annotations

import json
import os
import time
from pathlib import Path

import requests

ROOT = Path(__file__).resolve().parents[2]
DIR = ROOT / "revenue-engine" / "reports" / "survival"
URL = os.environ.get("RE_WPP_URL", "http://127.0.0.1:1238")
ADMIN_KEY = os.environ.get("RE_WPP_ADMIN_KEY", "")


def main() -> int:
    if not ADMIN_KEY:
        print("缺 RE_WPP_ADMIN_KEY 环境变量")
        return 1
    # 1. 两个 token
    r = requests.post(f"{URL}/admin/GenAuthKey1?key={ADMIN_KEY}",
                      json={"Count": 2, "Days": 14},  # 存活实验期=14 天，短租
                      timeout=15)
    body = r.json()
    data = body.get("Data")
    tokens = data if isinstance(data, list) else (data or {}).get("authKeys", [])
    if len(tokens) < 2:
        print("GenAuthKey 未返回 2 个 token:", body)
        return 1
    # 2. 各自登录二维码
    accounts = []
    for i, tok in enumerate(tokens[:2], 1):
        qr = requests.post(f"{URL}/login/GetLoginQrCodeNew?key={tok}",
                           json={"Check": False, "Proxy": ""},
                           timeout=15).json()
        data = qr.get("Data") or {}
        accounts.append({"name": f"小号{i}", "token": tok,
                         "key": data.get("Key", ""), "ts": time.strftime("%FT%T")})
        print(f"\n=== 小号{i} 扫码 ===\n二维码URL: {data.get('QrCodeUrl', '(无)')}\n"
              f"提示: {data.get('Txt', '')}")
    DIR.mkdir(parents=True, exist_ok=True)
    (DIR / "accounts.json").write_text(
        json.dumps(accounts, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"\naccounts.json 已写入（{len(accounts)} 号）。扫码后用 "
          f"`py -I revenue-engine/probes/survival_watch.py` 开始采集。")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
