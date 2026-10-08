# -*- coding: utf-8 -*-
"""doc_tail.py — 官方虚拟支付文档尾部（签名算法段）。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch  # noqa: E402

DOC_URL = "https://developers.weixin.qq.com/miniprogram/dev/platform-capabilities/business-capabilities/virtual-payment.html"


def main():
    page = attach_or_launch()
    t2 = page.new_tab(DOC_URL)
    time.sleep(8)
    txt = (t2.run_js("return (document.body.innerText || '');") or "")
    t2.close()
    # 找签名相关段定位
    idx = txt.find("签名")
    print(json.dumps({"len": len(txt), "sign_idx": idx,
                      "tail": txt[8500:14024]}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
