# -*- coding: utf-8 -*-
"""T19 锚定验证：两份 .shtm 样本（初始响应+渲染态）上跑挖掘锚点全家（零网络）。"""
import io
import re

CASES = (
    ("督导raw", r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_shtm_raw.html"),
    ("督导rendered", r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_shtm_playwright.html"),
    ("投标rendered", r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_shtm_5110103104004213.html"),
)
ANCHORS = {
    "internal_aid": r"(?:office|pic)\s*:\s*\{\s*aid\s*:\s*(\d+)",
    "actual_page": r"actual_page\s*:\s*(\d+)",
    "preview_page": r"preview_page\s*:\s*(\d+)",
    "view_token": r"view_token\s*:\s*'([^']*)'",
    "senddate": r"senddate\s*:\s*'([0-9a-f]{32})'",
    "title": r"title\s*:\s*'((?:[^'\\]|\\.)*)'",
    "format": r"format\s*:\s*'(\w+)'",
}

for name, path in CASES:
    html = io.open(path, encoding="utf-8").read()
    got = {}
    for key, pat in ANCHORS.items():
        m = re.search(pat, html)
        got[key] = (m.group(1)[:36] if m else None)
    print(name, "| len", len(html), "|", got)
