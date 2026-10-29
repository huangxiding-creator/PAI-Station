# -*- coding: utf-8 -*-
"""hbba HB 条目全文阅读链富化 (1019 用户令: SL 加阅读原文)
有 openpdf 按钮 -> read_url = /portal/online/{pk}; 无 -> 保留 stdDetail 详情链
幂等: 已是 /portal/online/ 的跳过
"""
import json
import re
import sys
import time

sys.path.insert(0, r"E:\AI-Station\逆向工程\std-samr")
from samr_lib import HbbaClient, SamrError

PATH = r"E:\AI-Station\逆向工程\std-samr\water_standards.json"
RX_ONLINE = re.compile(r'href="(/portal/online/[0-9a-fA-F]{64})"')


def main():
    doc = json.load(open(PATH, encoding="utf-8"))
    items = doc["items"]
    hb = [x for x in items if x["src"] == "HB"]
    todo = [x for x in hb if "/portal/online/" not in (x.get("read_url") or "")]
    print(f"HB 总 {len(hb)}, 待探 {len(todo)}")
    c = HbbaClient(delay=(0.3, 0.55))
    t0 = time.time()
    have = skip = fail = 0
    for i, it in enumerate(todo, 1):
        pk = it["id"]
        try:
            html = c.detail(pk)
            m = RX_ONLINE.search(html)
            if m:
                it["read_url"] = f"https://hbba.sacinfo.org.cn{m.group(1)}"
                it["has_text"] = True
                have += 1
            else:
                it["has_text"] = False
                skip += 1
        except SamrError as e:
            it["has_text"] = False
            fail += 1
        if i % 100 == 0:
            print(f"  {i}/{len(todo)} 有文本={have} 无={skip} fail={fail} {time.time()-t0:.0f}s", flush=True)
    # 汇总口径
    doc["counts"]["hb_text"] = sum(1 for x in hb if x.get("has_text"))
    doc["counts"]["hb_notext"] = sum(1 for x in hb if x.get("has_text") is False)
    with open(PATH, "w", encoding="utf-8") as f:
        json.dump(doc, f, ensure_ascii=False)
    print(f"[saved] 有全文 {have} / 无全文 {skip} / fail {fail}  总用时 {time.time()-t0:.0f}s")


if __name__ == "__main__":
    main()
