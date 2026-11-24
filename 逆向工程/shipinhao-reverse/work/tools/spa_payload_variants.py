# -*- coding: utf-8 -*-
"""修正载荷批量验证：经 draftStore.createDraft 测多个变体，找 300002 真凶。
注意：只存草稿（无公开影响），变体成功即停。产物: work/api_probe/payload_variants.json
"""
import json
import pathlib
import sys
import time
import uuid as _uuid

sys.path.insert(0, r"F:/We-AIPO")
from DrissionPage import ChromiumPage, ChromiumOptions  # noqa: E402

OUT = pathlib.Path(r"E:/AI-Station/逆向工程/shipinhao-reverse/work/api_probe/payload_variants.json")

# 1125 实测上传产物（真实存在的 CDN url）
VID_URL = None  # 运行时由 sph dfs_upload 现传（避免陈旧）
THUMB_URL = None


def build_variants(vurl, turl, dur, w, h, size):
    now_s = int(time.time())
    media_v1 = {
        "spec": [], "url": vurl, "thumbUrl": turl, "mediaType": 4,
        "videoPlayLen": dur, "width": w, "height": h,
        "md5sum": str(_uuid.uuid4()), "fileSize": size, "bitrate": int(size * 8 / max(dur, 1)),
        "coverUrl": turl, "fullThumbUrl": turl, "fullUrl": "", "fullWidth": 0,
        "fullHeight": 0, "fullMd5sum": "", "fullFileSize": "0", "fullBitrate": 0,
        "halfRect": {}, "fullCoverUrl": turl, "cardShowStyle": 2,
        "shareCoverUrl": "", "shareCoverShowStyle": 0}
    desc_ui = {"mpTitle": "CLI变体测试(将删除)", "description": "载荷变体验证,存完即删",
               "extReading": {"link": "", "title": ""}, "mediaType": 4,
               "location": {}, "topic": {"finderTopicInfo": ""}, "event": {},
               "mentionedUser": [], "media": [media_v1]}
    base = {
        "objectType": 0, "longitude": 0, "latitude": 0, "feedLongitude": 0, "feedLatitude": 0,
        "originalFlag": 0, "topics": [], "isFullPost": 1, "handleFlag": 2, "videoClipTaskId": "",
        "traceInfo": {"traceKey": "", "uploadCdnStart": now_s, "uploadCdnEnd": now_s},
        "objectDesc": desc_ui, "clientid": "cli-" + str(now_s)}
    import copy
    v1 = copy.deepcopy(base)
    v2 = copy.deepcopy(base); v2["postFlag"] = 0
    v3 = copy.deepcopy(v2); v3["handleFlag"] = 1
    v4 = copy.deepcopy(v2); v4["objectDesc"] = dict(desc_ui); v4["objectDesc"]["mediaType"] = 2
    v5 = copy.deepcopy(v2); v5["traceInfo"] = {"traceKey": "", "uploadCdnStart": now_s * 1000}
    return [("v1_秒级成对trace+UImedia", v1), ("v2_v1+postFlag0", v2),
            ("v3_v2+handleFlag1", v3), ("v4_v2+mediaType2", v4),
            ("v5_v2+毫秒trace(负对照)", v5)]


def main():
    # 现场上传测试片+封面（真实 URL）
    sys.path.insert(0, r"E:/AI-Station/逆向工程/shipinhao-reverse")
    import importlib.util
    spec = importlib.util.spec_from_file_location("sph", r"E:/AI-Station/逆向工程/shipinhao-reverse/sph.py")
    S = importlib.util.module_from_spec(spec); spec.loader.exec_module(S)
    class A: vault=None; cookie=None
    c = S.load_cookies(A())
    video = pathlib.Path(r"E:/AI-Station/逆向工程/shipinhao-reverse/work/test/cli_test_clip.mp4")
    cover = pathlib.Path(r"E:/AI-Station/逆向工程/shipinhao-reverse/work/test/cli_test_clip.cover.jpg")
    vm = S.video_meta(video)
    v = S.dfs_upload(c, video, "video")
    t = S.dfs_upload(c, cover, "thumb")
    print("UPLOADED:", v["url"][:60], t["url"][:60])
    variants = build_variants(v["url"], t["url"], vm["duration"], vm["width"], vm["height"], vm["width"] and video.stat().st_size)

    co = ChromiumOptions().set_local_port(9222)
    page = ChromiumPage(addr_or_opts=co)
    tab = None
    for tt in page.get_tabs():
        if "channels.weixin.qq.com/platform" in (tt.url or "") and "login" not in tt.url:
            tab = tt; break
    if not tab:
        print("NO_LOGGED_TAB"); return 1
    results = []
    for name, payload in variants:
        tab.run_js("window.__r=null", as_expr=True)
        pj = json.dumps(payload, ensure_ascii=False)
        vn = "p" + str(int(time.time() * 1000))
        tab.run_js(
            "var " + vn + "=" + json.dumps(pj) + ";"
            "try{window._store.draftStore.createDraft(JSON.parse(" + vn + "),'cli-'+Date.now())"
            ".then(x=>{window.__r=JSON.stringify({ec:x&&x.res?x.res.errCode:'?',d:JSON.stringify((x&&x.res&&x.res.data)||{}).slice(0,300)})})"
            ".catch(e=>{window.__r='ERR:'+String(e).slice(0,120)})}catch(e){window.__r='SYNC:'+String(e).slice(0,120)}",
            as_expr=True)
        r = None
        for _ in range(24):
            time.sleep(0.5)
            r = tab.run_js("return window.__r")
            if r:
                break
        print(f"[{name}] -> {r}")
        results.append({"name": name, "result": r})
        try:
            ec = json.loads(r).get("ec") if r and r.startswith("{") else None
        except Exception:
            ec = None
        if ec == 0:
            print("WINNER:", name)
            break
        time.sleep(1.5)
    OUT.write_text(json.dumps(results, ensure_ascii=False, indent=1), encoding="utf-8")
    print("SAVED:", OUT)


if __name__ == "__main__":
    main()
