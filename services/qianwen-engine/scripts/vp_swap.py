# -*- coding: utf-8 -*-
"""回滚 report_498 + 改 report_1999 为知识库道具。"""
import sys, json, time
sys.path.insert(0, ".")
import requests
from qianwen_engine import config, wechat
from scripts.vpay_goods_publish import vp_secret, appkey_for

vp = vp_secret()
app_key = appkey_for(vp, 0)
f = config.MP_SECRET_FILE
secret = [l.split("=",1)[1].strip() for l in f.read_text(encoding="utf-8").splitlines() if l.startswith("appsecret=")][0]
r = requests.get("https://api.weixin.qq.com/cgi-bin/token",
    params={"grant_type":"client_credential","appid":config.WX_APPID,"secret":secret}, timeout=15)
token = r.json()["access_token"]

def call(uri, payload):
    body = json.dumps(payload, separators=(",",":"), ensure_ascii=False)
    _, sig, _ = wechat.virtual_pay_sign(app_key, "", body=body, uri=uri)
    r = requests.post(f"https://api.weixin.qq.com{uri}",
        params={"access_token": token, "pay_sig": sig},
        data=body.encode("utf-8"), headers={"Content-Type":"application/json"}, timeout=20)
    d = r.json()
    ec = d.get("errcode")
    print(f"  {uri.split('/')[-1]}: errcode={ec} {d.get('errmsg','')}")
    time.sleep(3)
    return d

url = "https://res.wx.qq.com/a/wx_fsp/assets/favicon.ico"

# 1) 回滚 report_498
print("[1] 回滚 report_498 → ¥498 原名")
call("/xpay/start_upload_goods", {"upload_item": [
    {"id": "report_498", "name": "研究报告解锁-标准版", "price": 49800,
     "remark": "研究报告解锁，一次解锁永久阅读", "item_url": url}], "env": 0})
d1 = call("/xpay/start_publish_goods", {"publish_item": [{"id": "report_498"}], "env": 0})
print(f"  回滚: {'OK' if d1.get('errcode')==0 else 'FAIL'}")

# 2) 改 report_1999 → ¥1 知识库
print("[2] report_1999 → 知识库整库交付 ¥1")
call("/xpay/start_upload_goods", {"upload_item": [
    {"id": "report_1999", "name": "知识库整库交付", "price": 100,
     "remark": "专业知识库整库交付", "item_url": url}], "env": 0})
d2 = call("/xpay/start_publish_goods", {"publish_item": [{"id": "report_1999"}], "env": 0})
print(f"  改造: {'OK' if d2.get('errcode')==0 else 'FAIL'}")
