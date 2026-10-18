# -*- coding: utf-8 -*-
"""dl_collect_channels — 面B3：视频号后台评论采集器 (F5, CDP 9337 自家后台).

DrissionPage 附加 9337 sph_profile 登录态（复用 channels 域），进评论区列表页
抓取评论文本 → 台账。只读自家后台，合规通道。
用法: F:/We-AIPO/.venv/Scripts/python.exe -X utf8 tools/dl_collect_channels.py [--max 60]
"""
from __future__ import annotations

import argparse
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import demand_ledger as dl  # noqa: E402


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--max", type=int, default=60)
    ns = ap.parse_args()
    from DrissionPage import Chromium
    b = Chromium(addr_or_port=9337) if hasattr(Chromium, "addr_or_port") else None
    if b is None:
        # 新版 API: ChromiumOptions 指定调试地址
        from DrissionPage import ChromiumOptions
        co = ChromiumOptions()
        co.set_local_port(9337)
        b = Chromium(co)
    tab = b.latest_tab
    tab.get("https://channels.weixin.qq.com/platform/comment")
    time.sleep(8)
    n = 0
    # 滚动加载评论
    for _ in range(6):
        tab.run_js("window.scrollTo(0, document.body.scrollHeight)")
        time.sleep(2)
    # 抓评论文本（通用: 含评论内容容器的文本节点）
    texts = tab.run_js("""
      function deep(root, out){ root.querySelectorAll('*').forEach(function(e){
        if(e.shadowRoot) deep(e.shadowRoot,out);
        if(e.children.length===0 && e.innerText && e.innerText.trim().length>=8
           && e.innerText.length<=300) out.push(e.innerText.trim())
      }); return out }
      return deep(document, []).slice(0, """ + str(ns.max) + """)
    """) or []
    for t in texts:
        if dl.append("sph_comment", t, ref="channels:comment",
                     jtbd={"trigger": "视频评论",
                           "job_statement": "观众在视频号评论",
                           "outcome": "表达需求/观点"},
                     urgency="high", score=70):
            n += 1
    print(f"[B3] 视频号评论入账 {n} (候选文本 {len(texts)})")
    print("[B3] 完成:", dl.stats())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
