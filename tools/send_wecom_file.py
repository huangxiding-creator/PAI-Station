# -*- coding: utf-8 -*-
r"""企业微信 webhook 文件发送器。

用法: python tools/send_wecom_file.py <文件路径> [显示名]
流程：upload_media (multipart, type=file, ≤20MB) → media_id → file 消息。
配置：config/wecom.secret.ini [wecom] webhook（密钥不进仓库）。
"""
import configparser
import os
import sys
import json
import uuid
import urllib.request


def webhook() -> str:
    hook = os.environ.get("PAI_WECOM_WEBHOOK", "")
    if hook:
        return hook
    parser = configparser.ConfigParser()
    parser.read(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                             "config", "wecom.secret.ini"), encoding="utf-8")
    return parser.get("wecom", "webhook", fallback="")


def send_file(path: str, display: str = "") -> dict:
    key = webhook().split("key=")[-1]
    boundary = uuid.uuid4().hex
    name = display or os.path.basename(path)
    with open(path, "rb") as fh:
        blob = fh.read()
    body = (f"--{boundary}\r\n"
            f'Content-Disposition: form-data; name="media"; filename="{name}"; '
            f'filelength={len(blob)}\r\n'
            f"Content-Type: application/octet-stream\r\n\r\n").encode() + blob + \
           f"\r\n--{boundary}--\r\n".encode()
    req = urllib.request.Request(
        f"https://qyapi.weixin.qq.com/cgi-bin/webhook/upload_media?key={key}&type=file",
        data=body, headers={"Content-Type": f"multipart/form-data; boundary={boundary}"})
    with urllib.request.urlopen(req, timeout=120) as resp:
        up = json.loads(resp.read().decode())
    if up.get("errcode") not in (0, None):
        raise RuntimeError(f"upload failed: {up}")
    payload = json.dumps({"msgtype": "file", "file": {"media_id": up["media_id"]}},
                         ensure_ascii=True)
    req2 = urllib.request.Request(webhook(), data=payload.encode(),
                                  headers={"Content-Type": "application/json"})
    with urllib.request.urlopen(req2, timeout=30) as resp2:
        return json.loads(resp2.read().decode())


if __name__ == "__main__":
    result = send_file(sys.argv[1], sys.argv[2] if len(sys.argv) > 2 else "")
    print("wecom file send:", result)
