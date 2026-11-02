# -*- coding: utf-8 -*-
"""mitm_dump.py — mitmproxy 插件：dump 微信读书 app 域请求的完整头表"""
import sys
from mitmproxy import http

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
LOG = r"E:\AI-Station\逆向工程\weread-apk-reverse\evidence\mitm_weread.log"


def request(flow: http.HTTPFlow) -> None:
    host = flow.request.pretty_host
    if "weread" in host:
        with open(LOG, "a", encoding="utf-8") as fh:
            fh.write("=== %s %s\n" % (flow.request.method, flow.request.url))
            for k, v in flow.request.headers.items():
                fh.write("%s: %s\n" % (k, v))
            fh.write("\n")
        print("[CAP] %s %s" % (flow.request.method, flow.request.url[:90]), flush=True)
