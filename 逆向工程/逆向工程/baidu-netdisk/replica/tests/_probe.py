#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""响应结构探针（诊断件，保留为战役记录）：只打键名/计数/非敏感标量，凭据零明文。"""
from __future__ import annotations

import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

from bdncore import BdnApi, BdnSession, mask  # noqa: E402

SENSITIVE = {"bdstoken", "bduss", "stoken", "sign", "token"}


def peek(tag, obj, depth=0, max_depth=3):
    pad = "  " * (depth + 1)
    if isinstance(obj, dict):
        for k, v in obj.items():
            if isinstance(v, (dict, list)) and depth < max_depth:
                size = len(v)
                print(f"{pad}{k}: {type(v).__name__}[{size}]")
                peek(tag, v, depth + 1, max_depth)
            elif k.lower() in SENSITIVE:
                print(f"{pad}{k}: {mask(v)}")
            elif isinstance(v, (int, float, bool)):
                print(f"{pad}{k}: {v}")
            else:
                s = str(v)
                print(f"{pad}{k}: {s[:60]!r}" + ("…" if len(s) > 60 else ""))
    elif isinstance(obj, list):
        for i, item in enumerate(obj[:2]):
            print(f"{pad}[{i}]")
            peek(tag, item, depth + 1, max_depth)


sess = BdnSession()
api = BdnApi(sess)
print(f"探针预算自检: 已发 {sess.requests_sent}")

print("\n===== 1. loginStatus =====")
r = api.login_status()
peek("loginStatus", r, max_depth=2)

print("\n===== 2. xpan search key='A' =====")
r = sess.get("/rest/2.0/xpan/file", params={
    "method": "search", "key": "A", "dir": "/", "recursion": 1,
    "page": 1, "num": 20, "clienttype": 8})
peek("search", r, max_depth=3)

print("\n===== 3. api/filemetas =====")
r = sess.get("/api/filemetas", params={
    "fsids": "[341179797843843,66900732116275,820069836744263]",
    "dlink": 0, "clienttype": 8})
peek("filemetas", r, max_depth=3)

print("\n===== 4. share/record 首条 =====")
r = api.share_records()
entries = r.get("list") or []
if entries:
    peek("share[0]", entries[0], max_depth=3)
else:
    peek("share/record", r, max_depth=2)

print(f"\n探针总请求数: {sess.requests_sent}")
