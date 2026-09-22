# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_lib as lib

page = lib.make_page()
page.get(lib.APP_URL)
time.sleep(6)
lib.dismiss_ads(page)
ce = page.ele("xpath://*[@contenteditable='true']", timeout=8)
print("composer found:", ce.tag, str(ce.attr("class"))[:80])
# 沿祖先链找按钮群
anc = ce
for _ in range(6):
    try:
        anc = anc.parent()
    except Exception:
        break
    btns = anc.eles("tag:button")
    if btns:
        print(f"ancestor {anc.tag}.{str(anc.attr('class'))[:50]} -> {len(btns)} buttons")
        for b in btns[:12]:
            print("   btn aria=", repr(b.attr("aria-label")),
                  "type=", repr(b.attr("type")),
                  "txt=", repr((b.text or '')[:12]),
                  "dis=", b.attr("disabled"))
        break
# 试输入
ce.click()
ce.input("测试123")
time.sleep(1.5)
cur = page.ele("xpath://*[@contenteditable='true']")
print("after input text:", repr((cur.text or "")[:30]))
page.get_screenshot(path="probe_out/composer_typed.png")
