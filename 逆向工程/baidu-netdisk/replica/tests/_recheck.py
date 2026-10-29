#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""聚焦复检（解析修复后）：whoami/search/meta/shares 等，共 5 发（ls+metas 各一发；README 记账即 5）。保留为战役记录。"""
from __future__ import annotations

import os
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

from bdncore import BdnApi, BdnSession  # noqa: E402

sess = BdnSession()
api = BdnApi(sess)

t0 = time.perf_counter()
r = api.login_status()
a = r["account"]
print(f"[whoami ] errno={r.get('errno',0)} 账号={a['username']} uk={a['uk']} "
      f"vip{a['vip_level']}(type={a['vip_type']}) ({(time.perf_counter()-t0)*1000:.0f}ms)")

t0 = time.perf_counter()
r = api.search("演讲", dir_path="/")
print(f"[search ] errno={r.get('errno',0)} key='演讲' 递归命中{len(r.get('entries') or [])}条 "
      f"({(time.perf_counter()-t0)*1000:.0f}ms)")

t0 = time.perf_counter()
r = api.list_dir("/", num=20)
fsids = [e["fs_id"] for e in r["entries"]][:3]
r = api.metas(fsids)
first = (r.get("entries") or [{}])[0]
print(f"[meta   ] errno={r.get('errno',0)} {len(fsids)}fsid→{len(r['entries'])}条"
      f"[{r['_source']}] 首条={first.get('name')} isdir={first.get('isdir')} "
      f"({(time.perf_counter()-t0)*1000:.0f}ms, 2发)")

t0 = time.perf_counter()
r = api.share_records()
e0 = (r.get("entries") or [{}])[0]
print(f"[shares ] errno={r.get('errno',0)} {len(r['entries'])}条 首条shareid={e0.get('shareid')} "
      f"看{e0.get('views')}/下{e0.get('downloads')} passwd={e0.get('passwd')} "
      f"({(time.perf_counter()-t0)*1000:.0f}ms)")

print(f"\n复检请求总数: {sess.requests_sent} 发（累计战役活体: 21+4探针+{sess.requests_sent}）")
