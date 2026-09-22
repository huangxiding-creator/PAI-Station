# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_api as api
import manus_lib as lib

page = lib.make_page()
print("tab url:", page.url)
print("tabs:", [(t.url or '')[:60] for t in page.browser.tab_ids][:5])
page.get(lib.APP_URL)
time.sleep(5)
print("after get url:", page.url)
for trial in range(3):
    try:
        r = page.run_js("return 1+1", as_expr=True)
        print("trivial js:", r)
        break
    except Exception as e:
        print("trivial js fail:", type(e).__name__)
        time.sleep(3)
try:
    st, text = api.api_call(page, "POST", "/user.v1.UserService/GetAvailableCredits",
                            api.load_token(lib.load_accounts("账号列表 - 调试.txt")[0][0]), body={})
    print("credits:", st, text[:80])
except Exception as e:
    print("credits exc:", type(e).__name__, str(e)[:80])
