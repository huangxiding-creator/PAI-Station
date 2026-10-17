# -*- coding: utf-8 -*-
"""notify_approval_wecom — 批准闸企微通知 (1017 用户常令: 需批准时发企业微信).

用法: py -X utf8 tools/notify_approval_wecom.py "事项标题" ["选项/说明"]
webhook: data/secrets/invoice_wecom_webhook.txt → 兜底 F:/We-AIPO/.env WECOM_WEBHOOK_URL
"""
from __future__ import annotations

import json
import sys
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]


def webhook() -> str:
    wf = REPO / "data" / "secrets" / "invoice_wecom_webhook.txt"
    if wf.exists():
        u = wf.read_text(encoding="utf-8").strip()
        if u.startswith("http"):
            return u
    env = Path(r"F:\We-AIPO\.env")
    if env.exists():
        for line in env.read_text(encoding="utf-8").splitlines():
            if line.startswith("WECOM_WEBHOOK_URL="):
                return line.split("=", 1)[1].strip()
    return ""


def main() -> int:
    title = sys.argv[1] if len(sys.argv) > 1 else "待批准事项"
    detail = sys.argv[2] if len(sys.argv) > 2 else ""
    u = webhook()
    if not u:
        print("[notify] 无 webhook 配置")
        return 1
    md = (f"🔔 **需要您的批准**\n> {title}\n" +
          (f"\n{detail}\n" if detail else "") +
          "\n请回到 Claude 会话答复（或在企微直接回复安排）。")
    req = urllib.request.Request(
        u, data=json.dumps({"msgtype": "markdown",
                            "markdown": {"content": md}}).encode(),
        headers={"Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=10) as r:
        print("[notify] wecom:", r.read().decode()[:60])
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
