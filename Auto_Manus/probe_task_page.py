# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_lib as lib

page = lib.make_page()
page.get("https://manus.im/app/qhgtXDTfqdUiFuFL0MUzTk")
time.sleep(8)
lib.dismiss_ads(page)
body = page.ele("tag:body")
text = (body.text or "")[:1800]
print("=== TASK PAGE TEXT ===")
print(text)
page.get_screenshot(path="probe_out/task_qhgt.png")
print("shot saved")
