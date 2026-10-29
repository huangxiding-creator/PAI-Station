# -*- coding: utf-8 -*-
"""W0 真身侦察 — API 腿：验证套餐 Key 归属站、额度端点、卡库存端点。
密钥只从 ~/.claude/settings.json 读取，输出全程脱敏。"""
import json
import sys
import urllib.error
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")


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
            return r.status, r.read().decode("utf-8", "replace")[:2500]
    except urllib.error.HTTPError as e:
        return e.code, e.read().decode("utf-8", "replace")[:400]
    except Exception as e:  # noqa: BLE001
        return -1, repr(e)[:200]


def main() -> int:
    k = load_key()
    print(f"[key] {'***' + k[-4:] if k else 'MISSING'} (len={len(k)})")
    targets = [
        ("zai_quota_limit", "https://api.z.ai/api/monitor/usage/quota/limit"),
        ("bigmodel_quota_limit", "https://open.bigmodel.cn/api/monitor/usage/quota/limit"),
        ("zai_card_list", "https://api.z.ai/api/biz/customer-package-reset/list?targetType=PERSONAL"),
        ("bigmodel_card_list", "https://open.bigmodel.cn/api/biz/customer-package-reset/list?targetType=PERSONAL"),
        ("zai_subscription", "https://api.z.ai/api/biz/subscription/list"),
    ]
    for name, url in targets:
        st, body = get(url, k)
        print(f"\n[{name}] HTTP {st}\n{body}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
