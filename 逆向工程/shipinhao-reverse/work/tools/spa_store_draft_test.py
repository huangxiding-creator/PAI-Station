# -*- coding: utf-8 -*-
"""决定性实验 v2：经 window._store.draftStore.createDraft() 发我们的载荷（SPA 全管线）。
若成功 → 载荷正确，纯 HTTP 差在中间件(头/查询串)；若失败 → 载荷错误。
产物: work/api_probe/spa_store_draft_test.json
"""
import json
import pathlib
import sys
import time

sys.path.insert(0, r"F:/We-AIPO")
from DrissionPage import ChromiumPage, ChromiumOptions  # noqa: E402

OUT = pathlib.Path(r"E:/AI-Station/逆向工程/shipinhao-reverse/work/api_probe/spa_store_draft_test.json")


def wait_js_result(tab, var, n=40):
    r = None
    for _ in range(n):
        time.sleep(0.5)
        r = tab.run_js(f"return window.{var}")
        if r:
            break
    return r


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
    ds = tab.run_js(
        "return JSON.stringify(Object.getOwnPropertyNames(Object.getPrototypeOf(window._store.draftStore)).slice(0,30))")
    print("DRAFTSTORE_PROTO:", ds)
    try:
        tab.listen.start("/cgi-bin/mmfinderassistant-bin/")
    except Exception as e:
        print("LISTEN_ERR:", e)
    payload = {
        "objectType": 0, "longitude": 0, "latitude": 0, "feedLongitude": 0, "feedLatitude": 0,
        "originalFlag": 0, "topics": [], "isFullPost": 1, "handleFlag": 2, "videoClipTaskId": "",
        "traceInfo": {"traceKey": "", "uploadCdnStart": int(time.time() * 1000)},
        "objectDesc": {"mpTitle": "SPA管线测试(将删除)", "description": "sph.py v2 决定性实验片,无媒体字段",
                        "extReading": {"link": "", "title": ""}, "mediaType": 4,
                        "location": {}, "topic": {"finderTopicInfo": ""}, "event": {},
                        "mentionedUser": [], "media": []},
        "clientid": "cli-" + str(int(time.time()))}
    pj = json.dumps(payload, ensure_ascii=False)
    tab.run_js(
        "window.__r=null;"
        "const p=" + json.dumps(pj) + ";"
        "try{window._store.draftStore.createDraft(JSON.parse(p),'cli-'+Date.now())"
        ".then(x=>{window.__r=JSON.stringify({ec:x&&x.res?x.res.errCode:'?',msg:x&&x.res?(x.res.errMsg||x.res.message):String(x).slice(0,80),d:JSON.stringify((x&&x.res&&x.res.data)||{}).slice(0,200)})})"
        ".catch(e=>{window.__r='ERR:'+String(e).slice(0,150)})}catch(e){window.__r='SYNC_ERR:'+String(e).slice(0,150)}",
        as_expr=True)
    r = wait_js_result(tab, "__r")
    print("CREATE_DRAFT_VIA_STORE:", r)
    time.sleep(3)
    pkts = []
    try:
        for p in tab.listen.steps(timeout=4):
            e = {"url": (getattr(p, "url", "") or "")[:220]}
            try:
                rb = getattr(p, "requestBody", None)
                e["body"] = (rb if isinstance(rb, str) else json.dumps(rb, ensure_ascii=False))[:6000]
            except Exception:
                pass
            try:
                params = getattr(p, "requestParams", None)
            except Exception:
                pass
            pkts.append(e)
    except Exception as ex:
        print("COLLECT_ERR:", ex)
    try:
        tab.listen.stop()
    except Exception:
        pass
    OUT.write_text(json.dumps({"result": r, "packets": pkts}, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    for p in pkts:
        print("PKT:", p.get("url", "")[:150])
        if p.get("body"):
            b = p["body"]
            print("  BODY[:500]:", b[:500])
    print("SAVED:", OUT)


if __name__ == "__main__":
    main()
