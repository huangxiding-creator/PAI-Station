# -*- coding: utf-8 -*-
"""_draft_inventory — 三公众号草稿箱盘点 (API只读): 近一周文章+贴图清单."""
import json
import time
import urllib.request

ACC = json.load(open(r"F:\We-AIPO\data\wechat_accounts.json", encoding="utf-8"))
WEEK = 7 * 86400
now = time.time()

for a in ACC:
    if not a.get("enabled"):
        continue
    name = a["name"]
    # token
    r = urllib.request.urlopen(urllib.request.Request(
        "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential"
        f"&appid={a['appid']}&secret={a['appsecret']}"), timeout=20)
    tok = json.loads(r.read().decode()).get("access_token", "")
    if not tok:
        print(f"[{name}] token失败")
        continue
    items, offset = [], 0
    while True:
        req = urllib.request.Request(
            "https://api.weixin.qq.com/cgi-bin/draft/batchget"
            f"?access_token={tok}",
            data=json.dumps({"offset": offset, "count": 10,
                             "no_content": 1}).encode(),
            headers={"Content-Type": "application/json"}, method="POST")
        d = json.loads(urllib.request.urlopen(req, timeout=20).read().decode())
        batch = d.get("item", [])
        items += batch
        offset += len(batch)
        if not batch or offset >= int(d.get("total_count", len(items))):
            break
    print(f"\n== {name} 草稿箱 {len(items)} 件 ==")
    for it in items:
        ts = it.get("update_time", 0)
        age_d = (now - ts) / 86400
        if age_d > WEEK:
            continue
        arts = it.get("content", {}).get("news_item", [])
        kind = arts[0].get("title", "") if arts else "(无news_item=图片消息/贴图)"
        thumb = arts[0].get("thumb_url", "") if arts else ""
        print(f"  [{time.strftime('%m-%d %H:%M', time.localtime(ts))}] "
              f"{age_d:.1f}d前 | {kind[:44]}" + (" | 有图" if thumb else ""))
