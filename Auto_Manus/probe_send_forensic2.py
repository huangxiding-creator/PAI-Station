# -*- coding: utf-8 -*-
"""取证2: 全页可见按钮坐标/文本/title/svg 扫描 — 定位真发送键.
tiptap Enter=换行不提交 → 必须找 send 箭头按钮."""
import json
import sys
import time

sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_lib as lib

page = lib.make_page()
print("URL:", page.url, flush=True)
if "manus.im" not in (page.url or ""):
    page.get(lib.APP_URL)
    time.sleep(4)

box = page.ele("xpath://*[@contenteditable='true']", timeout=8)
if not box:
    print("无 composer", flush=True)
    sys.exit(1)
box.click()
time.sleep(0.3)
box.input("请搜集整理「中石化南京工程有限公司」EPC总承包业务的公开资料：每条含来源名称、URL、发布时间与原文摘录。")
time.sleep(1.5)
bx = box.rect.viewport_location
bw = box.rect.size
print(f"composer 坐标 x={bx[0]} y={bx[1]} w={bw[0]} h={bw[1]}", flush=True)

cands = []
try:
    for b in page.eles("tag:button", timeout=3):
        try:
            if not b.states.is_displayed:
                continue
            loc = b.rect.viewport_location
            size = b.rect.size
            txt = (b.text or "").strip()
            title = b.attr("title") or ""
            aria = b.attr("aria-label") or ""
            cls = (b.attr("class") or "")[:60]
            # svg 内部标识
            svg = ""
            try:
                sv = b.ele("tag:svg", timeout=0.3)
                if sv:
                    svg = (sv.attr("class") or "")[:40]
            except Exception:
                pass
            cands.append((loc[0], loc[1], size[0], size[1], txt[:20],
                          title[:20], aria[:20], cls, svg))
        except Exception:
            continue
except Exception as e:
    print("枚举异常", type(e).__name__, flush=True)

print(f"可见按钮 {len(cands)} 个:", flush=True)
for c in sorted(cands, key=lambda t: (t[1], t[0])):
    print(f"  x={c[0]:>5} y={c[1]:>4} {c[2]:>3}x{c[3]:<3} text={c[4]!r} "
          f"title={c[5]!r} aria={c[6]!r} svg={c[8]!r} cls={c[7]!r}", flush=True)
print("取证2完成", flush=True)
