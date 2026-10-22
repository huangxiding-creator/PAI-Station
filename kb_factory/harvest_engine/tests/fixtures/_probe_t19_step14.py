# -*- coding: utf-8 -*-
"""T19 破壁试验I：openapi 两代方言 httpx 直打 + 搜索页 ?q= 形态（3 请求）。"""
import json

import httpx

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")

facts = {}
with httpx.Client(timeout=30.0, headers={"User-Agent": UA,
                                         "Referer": "https://max.book118.com/"}) as c:
    # ① 新方言：t=senddate（来自 .shtm 活挖）
    r1 = c.get("https://openapi.book118.com/getPreview.html", params={
        "project_id": 1, "aid": 517914739, "t": "8996781c247cede6c40127d29ea9f34e",
        "view_token": "mF72t6fHpxRnXBHR99i@Z5UtaQ9xHhHo6fIXDiC_2nuLcO_EAaNAwcPpDnBAPyQ=",
        "page": 1})
    facts["new_dialect"] = {"status": r1.status_code, "len": len(r1.text),
                            "has_data": '"data"' in r1.text, "head": r1.text[:150]}
    # ② 旧方言：aid_encode（BOOK118_SPEC 2026-08 金样 token）
    r2 = c.get("https://openapi.book118.com/getPreview.html", params={
        "project_id": 1, "aid": 188244482, "view_token": "Bw_2kzdPgXts68EgVwn_mM4e8ALH_opi",
        "aid_encode": 5134312044001323, "page": 1})
    facts["old_dialect"] = {"status": r2.status_code, "len": len(r2.text),
                            "has_data": '"data"' in r2.text, "head": r2.text[:150]}
    # ③ 搜索页 ?q= 形态
    r3 = c.get("https://max.book118.com/search.html", params={"q": "施工方案"})
    facts["search_q"] = {"status": r3.status_code, "len": len(r3.text),
                         "has_shtm": ".shtm" in r3.text, "has_tdsearch": "tdsearch" in r3.text}

with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step14.json",
          "w", encoding="utf-8") as f:
    json.dump(facts, f, ensure_ascii=False, indent=1)
print(json.dumps(facts, ensure_ascii=False, indent=1)[:2200])
