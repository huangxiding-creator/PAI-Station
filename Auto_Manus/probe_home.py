# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_lib as lib

page = lib.make_page()
page.get(lib.APP_URL)
time.sleep(6)
lib.dismiss_ads(page)
body = page.ele("tag:body")
text = (body.text or "")[:2500]
print("=== HOME DOM TEXT (2500) ===")
print(text)
print("=== INPUTS ===")
for el in page.eles("tag:textarea"):
    print("textarea:", repr(el.attr("placeholder")), el.attr("class")[:60] if el.attr("class") else "")
for el in page.eles("tag:input"):
    ph = el.attr("placeholder") or ""
    if ph:
        print("input:", repr(ph))
print("=== CONTENTEDITABLE ===")
for el in page.eles("xpath://*[@contenteditable='true']"):
    print("ce:", el.tag, repr(el.attr("placeholder")), str(el.attr("class"))[:60])
page.get_screenshot(path="probe_out/home.png")
print("shot saved")
