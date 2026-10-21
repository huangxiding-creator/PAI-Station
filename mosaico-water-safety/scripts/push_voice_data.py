#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""把 esp-sr 小乐音色库推送到水利安检卡(设备存储 /tts/)。

前置: 板已烧固件、已配网, 手机/电脑能打开设备配置页(同局域网)。
用法: py push_voice_data.py --host 192.168.x.x
      py push_voice_data.py --host http://esp-mosaico.local
推送后重启设备(TTS 在启动时加载音色), 日志见 "TTS ready"。
"""
import argparse
import hashlib
import json
import sys
import time
import urllib.request

DAT = r"E:/AI-Station/mosaico-water-safety/assets/tts/esp_tts_voice_data_xiaole.dat"
REMOTE_PATH = "/tts/esp_tts_voice_data_xiaole.dat"
EXPECT_MD5 = "a7d2b11b7834a72a47e071e05697a394"
CHUNK = 64 * 1024


def req(host: str, method: str, path: str, body: bytes = b"", ctype: str = "application/json", timeout: int = 30):
    url = host.rstrip("/") + path
    r = urllib.request.Request(url, data=body or None, method=method)
    if body:
        r.add_header("Content-Type", ctype)
    with urllib.request.urlopen(r, timeout=timeout) as resp:
        return resp.status, resp.read()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--host", required=True, help="设备地址, 如 192.168.1.23 或 http://esp-mosaico.local")
    args = ap.parse_args()
    host = args.host if args.host.startswith("http") else "http://" + args.host

    data = open(DAT, "rb").read()
    md5 = hashlib.md5(data).hexdigest()
    if md5 != EXPECT_MD5:
        sys.exit(f"[err] 本地音色库校验失败 md5={md5}")
    print(f"[dat] {len(data):,} bytes md5={md5}")

    status, body = req(host, "POST", "/api/files/mkdir",
                       json.dumps({"path": "/tts", "recursive": True}).encode("utf-8"))
    print(f"[mkdir] {status} {body[:120].decode('utf-8', 'replace')}")

    print(f"[upload] {REMOTE_PATH} ...", flush=True)
    t0 = time.time()
    status, body = req(host, "POST",
                       f"/api/files/upload?path={urllib.request.quote(REMOTE_PATH)}",
                       data, ctype="application/octet-stream", timeout=300)
    dt = time.time() - t0
    print(f"[upload] {status} {body[:160].decode('utf-8', 'replace')} in {dt:.1f}s")

    status, body = req(host, "GET", f"/api/files?path=/tts")
    ok = REMOTE_PATH.split("/")[-1] in body.decode("utf-8", "replace")
    print(f"[verify] {status} file-listed={ok}")
    if not ok:
        sys.exit(1)
    print("[done] 重启设备生效: 长按电源重启, 串口/日志确认 'TTS ready'")


if __name__ == "__main__":
    main()
