# -*- coding: utf-8 -*-
"""决定性实验：在已登录 platform tab 里直接调 SPA 自己的 postService.postDraft()。
监听抓到 SPA 管线发出的真实请求（头+查询串+体），与我们的纯 HTTP 请求逐项对比。
产物: work/api_probe/spa_invoke_draft.json
"""
import json
import pathlib
import sys
import time

sys.path.insert(0, r"F:/We-AIPO")
from DrissionPage import ChromiumPage, ChromiumOptions  # noqa: E402

OUT = pathlib.Path(r"E:/AI-Station/逆向工程/shipinhao-reverse/work/api_probe/spa_invoke_draft.json")


def main():
    co = ChromiumOptions().set_local_port(9222)
    page = ChromiumPage(addr_or_opts=co)
    tab = None
    for t in page.get_tabs():
        if "channels.weixin.qq.com/platform" in (t.url or "") and "login" not in t.url:
            tab = t
            break
    if not tab:
        print("NO_LOGGED_TAB"); return 1
    print("USE_TAB:", (tab.url or "")[:70])
    # 存量 SPA store 检查（window 键扫描）
    keys = tab.run_js(
        "return JSON.stringify(Object.keys(window).filter(k=>/store|_store/i.test(k)))") or "[]"
    print("WINDOW_STORE_KEYS:", keys)
    has_store = tab.run_js("return !!window._store && !!window._store.postService")
    print("HAS_STORE:", has_store)
    if not has_store:
        print("NO_STORE_ABORT")
        return 1
    try:
        tab.listen.start("/cgi-bin/mmfinderassistant-bin/post/")
    except Exception as e:
        print("LISTEN_ERR:", e)
    # 1) 先读后写：getDraftList 验证 store 管线（异步结果轮询窗口变量）
    tab.run_js(
        "window.__r1=null;"
        "window._store.postService.getDraftList({count:3})"
        ".then(r=>{window.__r1=JSON.stringify({ec:r.errCode,n:((r.data||{}).list||[]).length})})"
        ".catch(e=>{window.__r1='ERR:'+String(e).slice(0,120)})", as_expr=True)
    r1 = None
    for _ in range(20):
        time.sleep(0.5)
        r1 = tab.run_js("return window.__r1")
        if r1:
            break
    print("READ_VIA_SPA:", r1)
    # 2) 用我们的载荷调 postDraft（SPA 全管线发出）
    payload = {
        "objectType": 0, "longitude": 0, "latitude": 0, "feedLongitude": 0, "feedLatitude": 0,
        "originalFlag": 0, "topics": [], "isFullPost": 1, "handleFlag": 2, "videoClipTaskId": "",
        "traceInfo": {"traceKey": "", "uploadCdnStart": int(time.time() * 1000)},
        "objectDesc": {"mpTitle": "SPA管线测试(将删除)", "description": "sph.py v2 决定性实验片",
                        "extReading": {"link": "", "title": ""}, "mediaType": 4,
                        "location": {}, "topic": {"finderTopicInfo": ""}, "event": {},
                        "mentionedUser": [], "media": []},
        "clientid": "spa-test-" + str(int(time.time()))}
    pj = json.dumps(payload, ensure_ascii=False)
    tab.run_js(
        "window.__r2=null;"
        "const p=" + json.dumps(pj) + ";"
        "window._store.postService.postDraft(JSON.parse(p), 'cli-'+Date.now(), null)"
        ".then(r=>{window.__r2=JSON.stringify({ec:r.errCode,msg:r.errMsg||r.message,d:JSON.stringify(r.data||{}).slice(0,200)})})"
        ".catch(e=>{window.__r2='ERR:'+String(e).slice(0,150)})", as_expr=True)
    r2 = None
    for _ in range(30):
        time.sleep(0.5)
        r2 = tab.run_js("return window.__r2")
        if r2:
            break
    print("WRITE_VIA_SPA:", r2)
    time.sleep(4)
    pkts = []
    try:
        for p in tab.listen.steps(timeout=4):
            e = {"url": (getattr(p, "url", "") or "")[:200]}
            try:
                rb = p.requestBody
                e["body"] = (rb if isinstance(rb, str) else json.dumps(rb, ensure_ascii=False))[:6000]
            except Exception:
                pass
            try:
                hs = getattr(p, "requestHeaders", None)
                if hs:
                    e["headers"] = {k: str(v)[:120] for k, v in dict(hs).items() if k.lower() in
                                    ("x-wechat-uin", "finger-print-device-id", "content-type", "referer", "cookie")}
            except Exception:
                pass
            pkts.append(e)
    except Exception as e:
        print("COLLECT_ERR:", e)
    try:
        tab.listen.stop()
    except Exception:
        pass
    OUT.write_text(json.dumps({"read": r1, "write": r2, "packets": pkts},
                              ensure_ascii=False, indent=1), encoding="utf-8")
    for p in pkts:
        print("PKT:", p.get("url", "")[:140])
        if p.get("body"):
            print("  BODY:", p["body"][:700])
        if p.get("headers"):
            print("  HDRS:", json.dumps(p["headers"], ensure_ascii=False)[:300])
    print("SAVED:", OUT)


if __name__ == "__main__":
    main()
