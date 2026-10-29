# -*- coding: utf-8 -*-
"""kb_goods ¥1 道具发布（requests 版，绕 curl_cffi SSL 断连）。"""
import sys, json, time, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from qianwen_engine import config, wechat
import urllib.request
import urllib.parse
import hashlib
import hmac
import base64

API = "https://api.weixin.qq.com"
ITEM_URL = "https://ai.epcschool.top/static/goods/zongbaojun.jpg"
GOOD = {"id": "kb_goods", "name": "知识库整库交付", "price": 100,
        "remark": "专业知识库整库交付，按容量计价"}
# 绕 curl_cffi：从 release_submit 缓存读 stable_token
TOKEN_CACHE = config.REPO / "微信小程序" / "zongbao-ai" / "tools" / "_release_token.json"

def get_token():
    if TOKEN_CACHE.exists():
        t = json.loads(TOKEN_CACHE.read_text(encoding="utf-8"))
        tok = t.get("access_token") or ""
        if tok:
            return tok
    # 缓存无 → 直连 stable_token API（urllib，不走 curl_cffi）
    vp = secret()
    appid = "wx5cee1574ce45819b"
    appsecret = None
    sf = config.REPO / "data" / "secrets" / "zongbao_qianwen_mp.secret"
    if sf.exists():
        for l in sf.read_text(encoding="utf-8").splitlines():
            if l.strip().startswith("appsecret"):
                appsecret = l.split("=", 1)[1].strip()
    if not appsecret:
        raise RuntimeError("appsecret 缺失")
    body = json.dumps({"grant_type": "client_credential",
                       "appid": appid, "secret": appsecret}).encode()
    req = urllib.request.Request(
        "https://api.weixin.qq.com/cgi-bin/stable_token",
        data=body, headers={"Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=20) as r:
        d = json.loads(r.read())
    tok = d.get("access_token") or ""
    if not tok:
        raise RuntimeError(f"token fail: {d}")
    TOKEN_CACHE.write_text(json.dumps(d), encoding="utf-8")
    return tok

def secret():
    out = {}
    for l in config.VIRTUAL_PAY_FILE.read_text(encoding="utf-8").splitlines():
        l = l.strip()
        if l and "=" in l and not l.startswith("#"):
            k, v = l.split("=", 1)
            out[k.strip()] = v.strip()
    return out

def pay_sig(app_key, body, uri):
    """复用引擎原生签名（纯计算，零网络）——自算公式实测签名校验不过。"""
    _, sig, _ = wechat.virtual_pay_sign(app_key, "", body=body, uri=uri)
    return sig

def call(method_uri, payload, app_key):
    body = json.dumps(payload, separators=(",", ":"), ensure_ascii=False)
    sig = pay_sig(app_key, body, method_uri)
    token = get_token()
    qs = urllib.parse.urlencode({"access_token": token, "pay_sig": sig})
    req = urllib.request.Request(
        f"{API}{method_uri}?{qs}",
        data=body.encode("utf-8"),
        headers={"Content-Type": "application/json"}, method="POST")
    with urllib.request.urlopen(req, timeout=20) as r:
        d = json.loads(r.read())
    print(f"  {method_uri.split('/')[-1]}: {json.dumps(d, ensure_ascii=False)[:150]}")
    time.sleep(3)
    return d

def main():
    v = secret()
    env = int(v.get("env", 0))
    app_key = v.get("prod_appkey") if env == 0 else v.get("sandbox_appkey")
    if not app_key:
        print("FATAL: appkey 缺失"); return 1
    print(f"[0] env={env} appkey={app_key[:4]}***")

    # 1) 查现状
    q = call("/xpay/query_publish_goods", {"env": env}, app_key)
    existing = {}
    for key in ("publish_item", "publish_goods", "goods", "list", "item_list"):
        rows = q.get(key)
        if isinstance(rows, list):
            for it in rows:
                gid = it.get("id") or it.get("item_id")
                if gid: existing[str(gid)] = it.get("publish_status", it.get("status"))
            if existing: break
    print(f"[1] 现有道具: {existing}")
    if existing.get("kb_goods") == 2:
        print("[✓] kb_goods 已发布(publish_status=2)，无需重发"); return 0

    # 2) 上传（照 vpay_goods_publish.py:213 官方格式 upload_item 数组包裹）
    item = {**GOOD, "item_url": ITEM_URL}
    u = call("/xpay/start_upload_goods", {"upload_item": [item], "env": env}, app_key)
    if u.get("errcode") and u.get("errcode") != 0:
        print(f"[!] upload errcode={u.get('errcode')} {u.get('errmsg')}")
        if u.get("errcode") == 268490023:  # 已存在
            print("  道具已存在，直接发布")
        else:
            return 1

    # 3) 发布（补全字段——原脚本只传id但我们的query为空，可能需完整信息匹配）
    p = call("/xpay/start_publish_goods",
             {"publish_item": [{"id": GOOD["id"], "name": GOOD["name"],
                                "price": GOOD["price"], "item_url": ITEM_URL,
                                "remark": GOOD["remark"]}], "env": env}, app_key)
    if p.get("errcode") and p.get("errcode") != 0:
        # 降级试：原脚本体（只传 id）
        print("  [retry] 只传id...")
        time.sleep(5)
        p = call("/xpay/start_publish_goods",
                 {"publish_item": [{"id": GOOD["id"]}], "env": env}, app_key)
    if p.get("errcode") and p.get("errcode") != 0:
        print(f"[!] publish errcode={p.get('errcode')} {p.get('errmsg')}")
        return 1

    # 4) 轮询确认
    for i in range(10):
        time.sleep(3)
        q2 = call("/xpay/query_publish_goods", {"env": env}, app_key)
        for key in ("publish_item", "publish_goods", "goods", "list", "item_list"):
            rows = q2.get(key)
            if isinstance(rows, list):
                for it in rows:
                    if (it.get("id") or it.get("item_id")) == "kb_goods":
                        st = it.get("publish_status", it.get("status"))
                        print(f"  kb_goods publish_status={st}")
                        if st == 2:
                            print("[✓] kb_goods 发布成功！")
                            return 0
    print("[!] 10轮后未确认=2，可能审核中——后续可重跑 --query 查")
    return 0

if __name__ == "__main__":
    sys.exit(main())
