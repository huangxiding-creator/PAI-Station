# -*- coding: utf-8 -*-
"""水利标准全量采集 (1019用户令: 全量收集)
源1: hbba 行业标准 industry=水利 (SL 全量, 全状态)
源2: hbba key=水利 (跨行业水利命名)
源3: std.samr GB 国标 水利关键词组 (全状态) + 详情富化(CCS/ICS/归口/openstd阅读链)
产出: water_standards.json (带 provenance)
"""
import json
import re
import sys
import time

sys.path.insert(0, r"E:\AI-Station\逆向工程\std-samr")
from samr_lib import SamrClient, HbbaClient, SamrError

OUT = r"E:\AI-Station\逆向工程\std-samr\water_standards.json"

GB_KEYWORDS = ["水利", "水利水电", "水文", "灌溉", "大坝", "水库", "水土保持",
               "泵站", "输水", "水电站", "河道", "引水", "水闸", "堤防", "防洪",
               "灌区", "治涝", "土石坝", "灌浆", "水土"]


def norm_gb(row, kw):
    return {
        "src": "GB", "id": row["id"], "code": row["C_STD_CODE"], "name": row["C_C_NAME"],
        "nature": row.get("STD_NATURE", ""), "status": row.get("STATE", ""),
        "issue": row.get("ISSUE_DATE", ""), "act": row.get("ACT_DATE", ""),
        "industry": "国标", "dept": "", "read_url": "", "ccs": "", "ics": "",
        "matched": [kw],
    }


def main():
    t0 = time.time()
    all_items = {}

    # ---- 源1+2: hbba ----
    hb = HbbaClient(delay=(0.35, 0.6))
    n1 = n2 = 0
    for rec in hb.search_all(industry="水利"):
        pk = rec["pk"]
        if pk in all_items:
            all_items[pk]["matched"].append("行业:水利")
            continue
        all_items[pk] = {
            "src": "HB", "id": pk, "code": rec.get("code", ""), "name": rec.get("chName", ""),
            "nature": "", "status": rec.get("status", ""),
            "issue": rec.get("issue_date", ""), "act": rec.get("act_date", ""),
            "industry": rec.get("industry", ""), "dept": rec.get("chargeDept", ""),
            "read_url": f"https://hbba.sacinfo.org.cn/stdDetail/{pk}",
            "ccs": "", "ics": "", "matched": ["行业:水利"],
        }
        n1 += 1
    print(f"[hbba industry=水利] {n1} 条")
    for rec in hb.search_all(key="水利"):
        pk = rec["pk"]
        if pk in all_items:
            all_items[pk]["matched"].append("关键词:水利")
            continue
        all_items[pk] = {
            "src": "HB", "id": pk, "code": rec.get("code", ""), "name": rec.get("chName", ""),
            "nature": "", "status": rec.get("status", ""),
            "issue": rec.get("issue_date", ""), "act": rec.get("act_date", ""),
            "industry": rec.get("industry", ""), "dept": rec.get("chargeDept", ""),
            "read_url": f"https://hbba.sacinfo.org.cn/stdDetail/{pk}",
            "ccs": "", "ics": "", "matched": ["关键词:水利"],
        }
        n2 += 1
    print(f"[hbba key=水利 新增] {n2} 条")

    # ---- 源3: std.samr GB ----
    gb = SamrClient(delay=(0.3, 0.6))
    for kw in GB_KEYWORDS:
        try:
            cnt = 0
            for row in gb.search_all(text=kw):
                rid = row["id"]
                if rid in all_items:
                    if kw not in all_items[rid]["matched"]:
                        all_items[rid]["matched"].append(kw)
                    continue
                all_items[rid] = norm_gb(row, kw)
                cnt += 1
            print(f"[gb kw={kw}] 新增 {cnt}")
        except SamrError as e:
            print(f"[gb kw={kw}] ERR {e}")

    # ---- GB 详情富化 (read_url/ccs/ics/归口) ----
    gb_ids = [k for k, v in all_items.items() if v["src"] == "GB"]
    ok = fail = 0
    for i, rid in enumerate(gb_ids, 1):
        try:
            det = gb.detail(rid)
            it = all_items[rid]
            if det.get("hcno"):
                it["read_url"] = f"https://openstd.samr.gov.cn/bzgk/std/newGbInfo?hcno={det['hcno']}"
            it["ccs"] = det.get("中国标准分类号", "")
            it["ics"] = (det.get("国际标准分类号", "") or "")[:40]
            it["dept"] = det.get("主管部门", "") or det.get("归口单位", "")
            ok += 1
        except SamrError:
            fail += 1
        if i % 100 == 0:
            print(f"  [gb detail] {i}/{len(gb_ids)} ok={ok} fail={fail} elapsed={time.time()-t0:.0f}s")
    print(f"[gb detail] 完成 ok={ok} fail={fail}")

    items = sorted(all_items.values(), key=lambda x: (x["src"], x["code"]))
    doc = {
        "generated_at": time.strftime("%Y-%m-%d %H:%M:%S"),
        "sources": {
            "HB": "hbba.sacinfo.org.cn 行业标准备案系统(行业标准全文公开)",
            "GB": "std.samr.gov.cn 国家标准全文公开系统",
        },
        "counts": {
            "total": len(items),
            "hb": sum(1 for x in items if x["src"] == "HB"),
            "gb": sum(1 for x in items if x["src"] == "GB"),
            "current": sum(1 for x in items if x["status"] == "现行"),
        },
        "items": items,
    }
    with open(OUT, "w", encoding="utf-8") as f:
        json.dump(doc, f, ensure_ascii=False)
    print(f"[saved] {OUT}  total={doc['counts']['total']} (HB={doc['counts']['hb']} GB={doc['counts']['gb']}) 现行={doc['counts']['current']}  用时{time.time()-t0:.0f}s")


if __name__ == "__main__":
    main()
