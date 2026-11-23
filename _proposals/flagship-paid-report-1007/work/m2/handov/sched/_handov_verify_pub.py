# -*- coding: utf-8 -*-
"""_handov_verify_pub — 同源验证发布记录 (appmsgpublish) + 草稿是否仍在箱."""
import re, sys, time, json
from DrissionPage import ChromiumPage, ChromiumOptions

port = int(sys.argv[1]); key = sys.argv[2]
co = ChromiumOptions(); co.set_local_port(port)
page = ChromiumPage(co)
page.get("https://mp.weixin.qq.com/")
time.sleep(2)
m = re.search(r"token=(\d+)", page.url or "")
tok = m.group(1) if m else ""
print("token:", tok)
page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsgpublish?sub=list&type=101_1_102_103&token={tok}&lang=zh_CN&f=json")
time.sleep(3)
body = page.html or ""
print("发布记录含题名:", key in body)
# 草稿箱是否已无该稿 (金标准: 草稿从箱里消失=发布成功)
page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&token={tok}&lang=zh_CN")
time.sleep(2)
raw = page.run_js("""
return (function(){
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/cgi-bin/appmsg?action=list_ex&type=77&token=%s&lang=zh_CN&begin=0&count=50', false);
  xhr.withCredentials = true; xhr.send(); return xhr.responseText;
})()
""" % tok)
d = json.loads(raw or "{}")
items = d.get("app_msg_list") or []
still = [it for it in items if key in (it.get("title") or "")]
print("草稿箱仍含该稿:", len(still) > 0, "| 箱内总数:", len(items))
