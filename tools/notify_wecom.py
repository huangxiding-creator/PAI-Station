# -*- coding: utf-8 -*-
r"""企业微信 webhook 通知器（防乱码版）。

用法: python tools/notify_wecom.py "标题" "正文"
乱码根因：Git Bash 在 GBK 代码页下把中文按 GBK 发送，企微按 UTF-8 解码即乱码。
修复：json.dumps(ensure_ascii=True) 把中文转 \uXXXX 纯 ASCII 转义，传输层免疫编码问题。
"""
import json
import sys
import urllib.request

DEFAULT_WEBHOOK = ""  # 密钥不进仓库：从环境变量或 config/wecom.secret.ini 读取


def _webhook() -> str:
    import os
    hook = os.environ.get("PAI_WECOM_WEBHOOK", "")
    if hook:
        return hook
    import configparser
    parser = configparser.ConfigParser()
    parser.read("config/wecom.secret.ini", encoding="utf-8")
    return parser.get("wecom", "webhook", fallback=DEFAULT_WEBHOOK)


def send(title: str, body: str) -> dict:
    content = f"**{title}**\n{body}"
    payload = json.dumps({"msgtype": "markdown", "markdown": {"content": content}}, ensure_ascii=True)
    req = urllib.request.Request(
        _webhook(),
        data=payload.encode("ascii"),
        headers={"Content-Type": "application/json"},
    )
    with urllib.request.urlopen(req, timeout=15) as resp:
        return json.loads(resp.read().decode("utf-8"))


def main() -> int:
    title = sys.argv[1] if len(sys.argv) > 1 else "PAI-Station"
    body = sys.argv[2] if len(sys.argv) > 2 else ""
    hook = _webhook()
    if not hook:
        print("WeCom webhook not configured (PAI_WECOM_WEBHOOK or config/wecom.secret.ini)")
        return 1
    try:
        result = send(title, body)
    except Exception as error:  # 通知失败不阻塞主流程
        print(f"WeCom notify failed: {error}")
        return 1
    print(f"WeCom response: {result}")
    return 0 if result.get("errcode") == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
