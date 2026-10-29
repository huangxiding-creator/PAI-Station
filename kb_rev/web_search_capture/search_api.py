# -*- coding: utf-8 -*-
# W3.5 wenku.baidu.com 免登录检索元数据钥匙孔 (实测 2026-10-21)
# 配方: POST https://wenku.baidu.com/gsula/sula/syncmrecall  scene=PCSearch
# 铁律: 无登录/不下载/调用间隔>=3s/仅取元数据; 复用请保持节流
import json, re, ssl, sys, time, urllib.request, urllib.parse

_URL = "https://wenku.baidu.com/gsula/sula/syncmrecall"
_UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36"
# fileType 观察值: 16=电子书(书道); 1/2/3/4/5/7 为经典文库格式码(未逐一核验)
_FMT = {1: "doc", 2: "pdf", 3: "ppt", 4: "xls", 5: "txt", 7: "epub", 16: "ebook"}

def wenku_search(word, pn=1, book_lane=False, timeout=30):
    params = {"word": word, "pn": pn, "noCacheMembershipCard": True}
    if book_lane:
        params.update({"fd": 11, "fdResource": "11"})
    body = json.dumps({"requests": [{"sceneID": "PCSearch", "params": params}]}, ensure_ascii=False).encode("utf-8")
    headers = {"User-Agent": _UA, "Content-Type": "application/json;charset=utf-8",
               "Accept": "application/json, text/plain, */*",
               "Referer": "https://wenku.baidu.com/search?word=" + urllib.parse.quote(word),
               "Origin": "https://wenku.baidu.com", "Accept-Language": "zh-CN,zh;q=0.9"}
    req = urllib.request.Request(_URL, data=body, headers=headers, method="POST")
    with urllib.request.urlopen(req, timeout=timeout, context=ssl.create_default_context()) as r:
        j = json.loads(r.read().decode("utf-8", "replace"))
    res = (j.get("data", {}).get("items", {}).get("PCSearch") or {}).get("result", {})
    strip = lambda s: re.sub(r"</?em>", "", s or "")
    items = []
    for it in res.get("items", []):
        x = it.get("data", {})
        items.append({
            "title": strip(x.get("title")),
            "fmt": _FMT.get(x.get("fileType"), str(x.get("fileType"))),
            "pages": x.get("pageNum"),
            "size": None,  # 响应无字节数字段, 如实返回 None
            "vip": x.get("sellType"),
            "url": x.get("url"),
            "doc_id": x.get("docID"),
            "abstract": strip(x.get("content"))[:150],
            "views": x.get("viewCount"),
            "downloads": x.get("downloadCount"),
            "score": x.get("qualityScore"),
        })
    return {"total": res.get("extra", {}).get("total"), "n": len(items), "items": items}

if __name__ == "__main__":
    w = sys.argv[1] if len(sys.argv) > 1 else "项目管理"
    if len(sys.argv) > 2 and sys.argv[2] == "book":
        out = wenku_search(w, book_lane=True)
    else:
        out = wenku_search(w)
    print(json.dumps(out, ensure_ascii=False, indent=1)[:2600])
