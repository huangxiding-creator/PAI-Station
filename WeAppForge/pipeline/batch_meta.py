# -*- coding: utf-8 -*-
"""batch_meta.py — 内容产线上架元数据表（T-P0-02）
数据源：E:\AI-Station\EngOpp-Mining\reports\ 40 份 docx（COPYRIGHT_AUDIT.md 2026-09-28 实数）。
推断纪律：只从文件名直推（水利局/厅=政府水利部门、城市→省份映射），推不出留空记「待补」，绝不编造。
SLUG 表外的新 docx 走 infer_meta 兜底（常驻增量纳管：新文件落盘即纳入批处理清单）。
"""
from __future__ import annotations

import hashlib
import re

GOV_WATER = "政府水利部门"

# 文件名 → {slug, title, province, owner_type}
META: dict[str, dict] = {
    # ---- 河南（14）----
    "henan_all_汇总_20260807.docx": {"slug": "henan-huizong-20260807", "title": "河南省商机汇总报告（20260807）", "province": "河南", "owner_type": ""},
    "三门峡市水利局_20260807.docx": {"slug": "sanmenxia-shuiliju-2026", "title": "三门峡市水利局商机研究报告", "province": "河南", "owner_type": GOV_WATER},
    "信阳市水利局_20260807.docx": {"slug": "xinyang-shuiliju-2026", "title": "信阳市水利局商机研究报告", "province": "河南", "owner_type": GOV_WATER},
    "南阳市水利局_20260807.docx": {"slug": "nanyang-shuiliju-2026", "title": "南阳市水利局商机研究报告", "province": "河南", "owner_type": GOV_WATER},
    "平顶山市水利局_20260807.docx": {"slug": "pingdingshan-shuiliju-2026", "title": "平顶山市水利局商机研究报告", "province": "河南", "owner_type": GOV_WATER},
    "开封市水利局_20260807.docx": {"slug": "kaifeng-shuiliju-2026", "title": "开封市水利局商机研究报告", "province": "河南", "owner_type": GOV_WATER},
    "洛阳市水利局_20260807.docx": {"slug": "luoyang-shuiliju-2026", "title": "洛阳市水利局商机研究报告", "province": "河南", "owner_type": GOV_WATER},
    "济源示范区水利局_20260807.docx": {"slug": "jiyuan-shuiliju-2026", "title": "济源示范区水利局商机研究报告", "province": "河南", "owner_type": GOV_WATER},
    "濮阳市水利局_20260807.docx": {"slug": "puyang-shuiliju-2026", "title": "濮阳市水利局商机研究报告", "province": "河南", "owner_type": GOV_WATER},
    "许昌市水利局_20260807.docx": {"slug": "xuchang-shuiliju-2026", "title": "许昌市水利局商机研究报告", "province": "河南", "owner_type": GOV_WATER},
    "郑州市水利局_20260807.docx": {"slug": "zhengzhou-shuiliju-2026", "title": "郑州市水利局商机研究报告", "province": "河南", "owner_type": GOV_WATER},
    "驻马店市水利局_20260807.docx": {"slug": "zhumadian-shuiliju-2026", "title": "驻马店市水利局商机研究报告", "province": "河南", "owner_type": GOV_WATER},
    "河南省水利厅_20260807.docx": {"slug": "henan-shuiliting-2026", "title": "河南省水利厅商机研究报告", "province": "河南", "owner_type": GOV_WATER},
    "河南省水利工程商机挖掘报告_完整版_20260810.docx": {"slug": "henan-juewa-wanban-2026", "title": "河南省水利工程商机挖掘报告（完整版）", "province": "河南", "owner_type": ""},
    # ---- 湖北（15）----
    "hubei_汇总_20260807.docx": {"slug": "hubei-huizong-20260807", "title": "湖北省商机汇总报告（20260807）", "province": "湖北", "owner_type": ""},
    "hubei_汇总_20260812.docx": {"slug": "hubei-huizong-20260812", "title": "湖北省商机汇总报告（20260812）", "province": "湖北", "owner_type": ""},
    "十堰市水利和湖泊局_20260812.docx": {"slug": "shiyan-shuiliju-2026", "title": "十堰市水利和湖泊局商机研究报告", "province": "湖北", "owner_type": GOV_WATER},
    "咸宁市水利和湖泊局_20260812.docx": {"slug": "xianning-shuiliju-2026", "title": "咸宁市水利和湖泊局商机研究报告", "province": "湖北", "owner_type": GOV_WATER},
    "孝感市水利和湖泊局_20260812.docx": {"slug": "xiaogan-shuiliju-2026", "title": "孝感市水利和湖泊局商机研究报告", "province": "湖北", "owner_type": GOV_WATER},
    "宜昌市水利和湖泊局_20260812.docx": {"slug": "yichang-shuiliju-2026", "title": "宜昌市水利和湖泊局商机研究报告", "province": "湖北", "owner_type": GOV_WATER},
    "武汉市水务局_20260807.docx": {"slug": "wuhan-shuiwuju-20260807", "title": "武汉市水务局商机研究报告（20260807）", "province": "湖北", "owner_type": GOV_WATER},
    "武汉市水务局_20260812.docx": {"slug": "wuhan-shuiwuju-20260812", "title": "武汉市水务局商机研究报告（20260812）", "province": "湖北", "owner_type": GOV_WATER},
    "荆门市水利和湖泊局_20260812.docx": {"slug": "jingmen-shuiliju-2026", "title": "荆门市水利和湖泊局商机研究报告", "province": "湖北", "owner_type": GOV_WATER},
    "襄阳市水利和湖泊局_20260812.docx": {"slug": "xiangyang-shuiliju-2026", "title": "襄阳市水利和湖泊局商机研究报告", "province": "湖北", "owner_type": GOV_WATER},
    "鄂州市水利和湖泊局_20260812.docx": {"slug": "ezhou-shuiliju-2026", "title": "鄂州市水利和湖泊局商机研究报告", "province": "湖北", "owner_type": GOV_WATER},
    "黄石市水利和湖泊局_20260812.docx": {"slug": "huangshi-shuiliju-2026", "title": "黄石市水利和湖泊局商机研究报告", "province": "湖北", "owner_type": GOV_WATER},
    "湖北省水利厅_20260812.docx": {"slug": "hubei-shuiliting-2026", "title": "湖北省水利厅商机研究报告", "province": "湖北", "owner_type": GOV_WATER},
    "湖北省水利工程商机研究_总包创研院_1786519550.docx": {"slug": "hubei-shuili-1786519550", "title": "湖北省水利工程商机研究", "province": "湖北", "owner_type": ""},
    "湖北省水利工程商机研究_顶级报告_1786469616.docx": {"slug": "hubei-shuili-dingji-2026", "title": "湖北省水利工程商机研究（顶级报告）", "province": "湖北", "owner_type": ""},
    # ---- 新疆（4）----
    "新疆维吾尔自治区水利工程商机研究_总包创研院_1786540281.docx": {"slug": "xj-shuili-1786540281", "title": "新疆维吾尔自治区水利工程商机研究（1786540281）", "province": "新疆", "owner_type": ""},
    "新疆维吾尔自治区水利工程商机研究_总包创研院_1786563665.docx": {"slug": "xj-shuili-1786563665", "title": "新疆维吾尔自治区水利工程商机研究（1786563665）", "province": "新疆", "owner_type": ""},
    "新疆维吾尔自治区水利工程商机研究_总包创研院_1786577270.docx": {"slug": "xj-shuili-1786577270", "title": "新疆维吾尔自治区水利工程商机研究（1786577270）", "province": "新疆", "owner_type": ""},
    "新疆维吾尔自治区水利工程商机研究_总包创研院_1786577903.docx": {"slug": "xj-shuili-1786577903", "title": "新疆维吾尔自治区水利工程商机研究（1786577903）", "province": "新疆", "owner_type": ""},
    # ---- 江苏（2，去重择一）----
    "江苏省水网工程商机研究_总包创研院_1788885508.docx": {"slug": "js-shuiwang-2026", "title": "江苏省水网工程商机研究", "province": "江苏", "owner_type": ""},
    "江苏省水网工程商机研究_总包创研院_1788892913.docx": {"slug": "js-shuiwang-2026", "title": "江苏省水网工程商机研究", "province": "江苏", "owner_type": ""},
    # ---- 浙江 / 甘肃 / 西藏（1/1/3）----
    "浙江省水利工程商机研究_总包创研院_1787663960.docx": {"slug": "zj-shuili-2026", "title": "浙江省水利工程商机研究", "province": "浙江", "owner_type": ""},
    "甘肃省水利工程商机研究_总包创研院_1787480104.docx": {"slug": "gs-shuili-2026", "title": "甘肃省水利工程商机研究", "province": "甘肃", "owner_type": ""},
    "西藏自治区水利工程商机研究_总包创研院_1786827950.docx": {"slug": "xz-shuili-1786827950", "title": "西藏自治区水利工程商机研究（1786827950）", "province": "西藏", "owner_type": ""},
    "西藏自治区水利工程商机研究_总包创研院_1786853555.docx": {"slug": "xz-shuili-2026", "title": "西藏自治区水利工程商机研究", "province": "西藏", "owner_type": ""},
    "西藏自治区水利工程商机研究_总包创研院_1786853659.docx": {"slug": "xz-shuili-2026", "title": "西藏自治区水利工程商机研究", "province": "西藏", "owner_type": ""},
}

# 双版本去重（COPYRIGHT_AUDIT §四-1：图片集 MD5 互同 + 正文字数完全一致的实锤对）
# 择优规则：章节数→字数→时间戳更新者；两对实测全部平手，按时间戳新者留。
DEDUP_PAIRS: list[tuple[str, str, str]] = [
    (
        "江苏省水网工程商机研究_总包创研院_1788892913.docx",
        "江苏省水网工程商机研究_总包创研院_1788885508.docx",
        "19章/658423字完全一致+7图MD5互同，留时间戳更新版1788892913",
    ),
    (
        "西藏自治区水利工程商机研究_总包创研院_1786853659.docx",
        "西藏自治区水利工程商机研究_总包创研院_1786853555.docx",
        "21章/62823字完全一致+7图MD5互同，留时间戳更新版1786853659",
    ),
]

PROVINCES = ["北京", "天津", "上海", "重庆", "河北", "山西", "辽宁", "吉林", "黑龙江",
             "江苏", "浙江", "安徽", "福建", "江西", "山东", "河南", "湖北", "湖南",
             "广东", "海南", "四川", "贵州", "云南", "陕西", "甘肃", "青海", "台湾",
             "内蒙古", "广西", "西藏", "宁夏", "新疆", "香港", "澳门"]

CITY2PROV = {
    "三门峡": "河南", "信阳": "河南", "南阳": "河南", "平顶山": "河南", "开封": "河南",
    "洛阳": "河南", "济源": "河南", "濮阳": "河南", "许昌": "河南", "郑州": "河南",
    "驻马店": "河南", "十堰": "湖北", "咸宁": "湖北", "孝感": "湖北", "宜昌": "湖北",
    "武汉": "湖北", "荆门": "湖北", "襄阳": "湖北", "鄂州": "湖北", "黄石": "湖北",
}


def infer_meta(filename: str) -> dict:
    """SLUG 表外新 docx 的兜底推断（常驻增量纳管路径）——推不出留空，不编造"""
    stem = re.sub(r"\.docx$", "", filename)
    slug = "auto-" + hashlib.md5(stem.encode("utf-8")).hexdigest()[:8]
    province = next((p for p in PROVINCES if p in filename), "")
    if not province:
        province = next((pv for city, pv in CITY2PROV.items() if city in filename), "")
    owner = GOV_WATER if re.search(r"水利局|水利和湖泊局|水利厅|水务局", filename) else ""
    return {"slug": slug, "title": stem, "province": province, "owner_type": owner,
            "auto": True}
