# -*- coding: utf-8 -*-
"""_handov_check_draft — 骑活会话或自起(第3参=acct号)拉草稿箱全量找稿."""
import json, re, sys, time
from DrissionPage import ChromiumPage, ChromiumOptions

port = int(sys.argv[1])
key = sys.argv[2] if len(sys.argv) > 2 else "竣工验收"
co = ChromiumOptions()
co.set_local_port(port)
if len(sys.argv) > 3:
    co.set_user_data_path(r"F:\We-AIPO\autopub\data\browser_profiles" + "\\" + sys.argv[3])
page = ChromiumPage(co)
page.get("https://mp.weixin.qq.com/")
time.sleep(2)
m = re.search(r"token=(\d+)", page.url or "")
if not m and len(sys.argv) > 3:
    acct = sys.argv[3]
    try:
        cred = json.load(open(r"E:\AI-Station\电力KB收割\mp_cred_" + acct + ".json", encoding="utf-8"))
        page.set.cookies(cred["cookies"])
        time.sleep(1)
        page.get("https://mp.weixin.qq.com/")
        time.sleep(3)
    except Exception as e:
        print("cookie注入异常:", str(e)[:60])
    m = re.search(r"token=(\d+)", page.url or "")
tok = m.group(1) if m else ""
print("token:", tok)
if not tok:
    sys.exit(3)
page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&token={tok}&lang=zh_CN")
time.sleep(3)
raw = page.run_js("""
return (function(){
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/cgi-bin/appmsg?action=list_ex&type=77&token=%s&lang=zh_CN&begin=0&count=20', false);
  xhr.withCredentials = true; xhr.send(); return xhr.responseText;
})()
""" % tok)
d = json.loads(raw or "{}")
items = (d.get("app_msg_list") or [])
print("草稿箱 type=77 共:", len(items))
for it in items:
    print(" -", (it.get("title") or "")[:50], "| msgid:", it.get("appmsgid"), "| time:", it.get("create_time"))
hit = [it for it in items if key in (it.get("title") or "")]
print("命中:", len(hit))
