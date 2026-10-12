# -*- coding: utf-8 -*-
"""vp_probe_9336.py — 只读探针：9336 浏览器各标签页 URL+标题+正文前 300 字。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch  # noqa: E402


def main():
    page = attach_or_launch()
    tabs = []
    for t in page.get_tabs():
        info = {"url": (t.url or "")[:150]}
        try:
            info["title"] = (t.title or "")[:60]
            info["text"] = ((t.run_js("return (document.body.innerText || '').slice(0, 300);") or "")
                            .replace("\n", "|"))[:300]
        except Exception as e:  # noqa: BLE001
            info["err"] = str(e)[:80]
        tabs.append(info)
    print(json.dumps({"n": len(tabs), "tabs": tabs}, ensure_ascii=False, indent=1))
    return 0


if __name__ == "__main__":
    sys.exit(main())
