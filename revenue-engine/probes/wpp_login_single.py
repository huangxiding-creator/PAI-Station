# -*- coding: utf-8 -*-
"""单小号扫码登录（T-041）：自动续码盯梢版。

用法：py -I revenue-engine/probes/wpp_login_single.py
行为：生成新 token+二维码 → 自动开浏览器 → 每 5 秒探登录 → 码死自动换新（最多 5 轮）
      → 登录确认后写 accounts.json 并提示启动采集腿。
环境：RE_WPP_ADMIN_KEY（默认用部署时密钥，可覆盖）
"""
from __future__ import annotations

import json
import os
import sys
import time
import webbrowser
from pathlib import Path

import requests

ROOT = Path(__file__).resolve().parents[2]
P = ROOT / "revenue-engine" / "reports" / "survival" / "accounts.json"
URL = os.environ.get("RE_WPP_URL", "http://127.0.0.1:1238")
ADMIN_KEY = os.environ.get(
    "RE_WPP_ADMIN_KEY", "c112cf8e077542199a99fa74ea2a6bb7")


def main() -> int:
    for rnd in range(5):
        try:
            tok = requests.post(f"{URL}/admin/GenAuthKey1?key={ADMIN_KEY}",
                                json={"Count": 1, "Days": 14},
                                timeout=15).json()["Data"]["authKeys"][0]
            qr = requests.post(f"{URL}/login/GetLoginQrCodeNew?key={tok}",
                               json={"Check": False, "Proxy": ""},
                               timeout=15).json()["Data"]
        except Exception as e:
            print(f"round{rnd + 1} 生成失败: {e}（栈可能未起，查 wsl_keepalive）")
            time.sleep(10)
            continue
        P.parent.mkdir(parents=True, exist_ok=True)
        P.write_text(json.dumps([{"name": "小号1", "token": tok}],
                                ensure_ascii=False), encoding="utf-8")
        print(f"\n=== 第 {rnd + 1} 轮 === 请扫浏览器新码: {qr.get('QrCodeUrl', '')}")
        webbrowser.open(qr.get("QrCodeUrl", ""))
        for i in range(48):  # 4 分钟窗口
            try:
                r = requests.get(f"{URL}/login/GetLoginStatus?key={tok}",
                                 timeout=8).json()
                if r.get("Code") == 200:
                    print("\n✅ 登录确认！accounts.json 已写入。接下来：")
                    print("  1) py -I revenue-engine/probes/survival_watch.py  # 首枚采集")
                    print("  2) 注册 30 分钟军团腿（register_survival_watch.ps1）")
                    print("  3) 14 天时钟自首枚事件起算")
                    return 0
                if r.get("Code") == -2:
                    print(f"token 于第 {i + 1} 探失效，换新码…")
                    break
            except Exception as e:
                print("探活异常:", e)
            time.sleep(5)
    print("5 轮未登录，退出。人到位后重跑本命令。")
    return 1


if __name__ == "__main__":
    sys.exit(main())
