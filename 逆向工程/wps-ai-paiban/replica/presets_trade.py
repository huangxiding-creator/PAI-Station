#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!   公开惯例版参数，非 WPS 内部模板参数   !!
!!   公开惯例版参数，非 WPS 内部模板参数   !!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

合同（PRESET_CONTRACT）/ 标书（PRESET_BID）排版预设
—— 供 aipaiban.py plan_preset() 直接消费的纯数据件（零第三方依赖）。

数据来源与诚实声明（2026-10-21 产出时点）：
  1. WPS 内部「合同/标书」品类模板参数的解密（逆向工作台 WI-002：
     kwpsaitypeset.dll 模板容器解密）尚未完成。work/decrypt/hits_all.txt
     仅命中字符串偏移（template / presettemplates / nationalstandard 等），
     无任何可用参数值。故本文件全部参数取自公开通用行业惯例，
     逐条出处类型见各预设 notes 字段（律所合同排版惯例 / 招投标文件
     排版惯例 / Word·WPS 默认规格 / 宿主引擎行为）。
  2. 合同（民法典合同编体系）与国内招标文件均无法定统一版式国标
     （GB/T 9704-2012 仅约束党政机关公文），因此标注为
     「公开通用惯例」而非任何标准号——数字零造假，不虚标出处。
  3. 字段结构与单位约定 100% 对齐宿主 aipaiban.py（与 PRESET_OFFICIAL /
     PRESET_THESIS 同构）：
       - rPr.sz = 磅数 number（二号22/小二18/三号16/四号14/小四12，
         对齐 CN_SIZE_TO_PT 换算表）
       - spacing/ind/sectPr = 带单位字符串："22pt"/"2ch"/"1.5x"/"36pt"/
         "2.54cm"（对齐 parse_len/parse_line/len_to_twips）
       - pPr 键域 = jc/spacing/ind/outlineLvl/keepNext（write_pPr 支持集）
       - rPr 键域 = sz/b/rFonts{eastAsia,ascii,hAnsi}（write_rPr 支持集）
       - rules[].tag 必须是宿主 recognize_structure 可产出的标签
         （doc_title/catalog_h1~h3/main_text/signature 等），
         plan_preset 只应用 formatList 中实际出现的 tag，多余规则为安全 no-op。
  4. 接线方式（宿主 main() 扩展示例，本文件不改动宿主）：
         from presets_trade import PRESET_CONTRACT, PRESET_BID
         plan = plan_preset({"contract": PRESET_CONTRACT,
                             "bid": PRESET_BID}[args.preset], paras, formatList)
"""

PRESET_CONTRACT = {
    # —— 合同：公开通用惯例（律所法务排版通行格式）——
    "label": "合同 公开通用惯例版（非WPS内部参数）",
    "sectPr": {"pgSz": {"w": "595.3pt", "h": "841.9pt", "orient": "portrait"},
               "pgMar": {"top": "2.54cm", "bottom": "2.54cm",
                         "left": "3.18cm", "right": "3.18cm"}},
    "rules": [
        {"tag": "doc_title",  # 合同标题
         "pPr": {"jc": "center",
                 "spacing": {"before": "0pt", "after": "22pt", "line": "1.5x"},
                 "ind": {"firstLine": "0pt"}},
         "rPr": {"sz": 22, "b": True,
                 "rFonts": {"eastAsia": "宋体", "ascii": "Times New Roman",
                            "hAnsi": "Times New Roman"}}},
        {"tag": "catalog_h1",  # 第一条 / 一、 条款层
         "pPr": {"jc": "left",
                 "spacing": {"before": "12pt", "after": "6pt", "line": "1.5x"},
                 "ind": {"firstLine": "0pt"}, "outlineLvl": 1, "keepNext": True},
         "rPr": {"sz": 14, "b": False,
                 "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman",
                            "hAnsi": "Times New Roman"}}},
        {"tag": "catalog_h2",  # （一）/ 1.1 款项层
         "pPr": {"jc": "left",
                 "spacing": {"before": "6pt", "after": "3pt", "line": "1.5x"},
                 "ind": {"firstLine": "0pt"}, "outlineLvl": 2, "keepNext": True},
         "rPr": {"sz": 12, "b": True,
                 "rFonts": {"eastAsia": "宋体", "ascii": "Times New Roman",
                            "hAnsi": "Times New Roman"}}},
        {"tag": "catalog_h3",  # 1.1.1 / 1、 目层（兜底层级）
         "pPr": {"jc": "left",
                 "spacing": {"before": "3pt", "after": "2pt", "line": "1.5x"},
                 "ind": {"firstLine": "0pt"}, "outlineLvl": 3, "keepNext": True},
         "rPr": {"sz": 12, "b": True,
                 "rFonts": {"eastAsia": "宋体", "ascii": "Times New Roman",
                            "hAnsi": "Times New Roman"}}},
        {"tag": "main_text",  # 正文 + 甲乙双方信息段（非封面保护段）
         "pPr": {"jc": "both",
                 "spacing": {"before": "0pt", "after": "0pt", "line": "1.5x"},
                 "ind": {"firstLine": "2ch"}, "outlineLvl": 10},
         "rPr": {"sz": 12, "b": False,
                 "rFonts": {"eastAsia": "宋体", "ascii": "Times New Roman",
                            "hAnsi": "Times New Roman"}}},
        {"tag": "signature",  # 签署区（甲乙方盖章/日期）
         "pPr": {"jc": "end",
                 "spacing": {"before": "36pt", "after": "0pt", "line": "1.5x"},
                 "ind": {"firstLine": "0pt"}},
         "rPr": {"sz": 12, "b": False,
                 "rFonts": {"eastAsia": "宋体", "ascii": "Times New Roman",
                            "hAnsi": "Times New Roman"}}},
    ],
    "header_footer": {"footers": {"default": {"mode": "set",
        "pageNumber": {"show": True, "format": "arabic", "align": "center"}}}},
    "notes": {
        "_declaration": "公开惯例版参数，非 WPS 内部模板参数（WI-002 解密未完成）",
        "sectPr": "出处类型=软件默认规格：Word/WPS 中文版默认页边距（上下2.54cm/左右3.18cm），合同排版公开通行值",
        "doc_title": "出处类型=律所合同排版公开惯例：标题二号宋体加粗或小二黑体加粗、居中（常见双变体，本件取二号宋体加粗22pt）",
        "catalog_h1": "出处类型=律所合同排版公开惯例：条款层「第一条/一、」四号黑体或小四宋体加粗、左对齐不缩进（本件取四号黑体14pt）",
        "catalog_h2": "出处类型=律所合同排版公开惯例：款项层「（一）/1.1」小四宋体加粗，字号回落正文档",
        "catalog_h3": "出处类型=公开通用做法（无统一强惯例）：目标层兜底小四宋体加粗，与h2同号靠编号层级区分",
        "main_text": "出处类型=律所合同排版公开惯例：正文小四宋体（或仿宋变体）两端对齐、1.5倍行距、首行缩进2字符；甲乙双方信息段同为小四——注意宿主识别器把封面区（首个标题/长段前）≤40字短行标为cover保护、不参与strict直出，落在该区外的信息段走main_text通道即获小四",
        "signature": "出处类型=律所合同排版公开惯例：签署区右对齐为通行式（左对齐+右留白为变体），段前大间距取36pt≈空两行（小四1.5倍行距换算）",
        "header_footer": "出处类型=公开通行做法：合同页脚阿拉伯页码居中（与宿主PRESET_OFFICIAL页码令牌同构）",
        "outlineLvl": "出处类型=宿主引擎行为：条款编号「第一条/1.」经heading_rank（RE_SECTION/RE_CN_LIST/RE_ARAB_DOTTED）压缩映射到h1/h2/h3；纯「第一条」文档压缩后挂h1，混合「一、+（一）」时同rank合并到h1",
    },
}

PRESET_BID = {
    # —— 标书：公开通用惯例（招投标文件排版通行格式）——
    "label": "标书 公开通用惯例版（非WPS内部参数）",
    "sectPr": {"pgSz": {"w": "595.3pt", "h": "841.9pt", "orient": "portrait"},
               "pgMar": {"top": "2.5cm", "bottom": "2.5cm",
                         "left": "3.0cm", "right": "2.8cm"}},
    "rules": [
        {"tag": "doc_title",  # 封面大标题
         "pPr": {"jc": "center",
                 "spacing": {"before": "0pt", "after": "30pt", "line": "1.5x"},
                 "ind": {"firstLine": "0pt"}, "outlineLvl": 1, "keepNext": True},
         "rPr": {"sz": 26, "b": True,
                 "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman",
                            "hAnsi": "Times New Roman"}}},
        {"tag": "catalog_h1",  # 章标题（第一章 / 一、 / 1.）
         "pPr": {"jc": "center",
                 "spacing": {"before": "24pt", "after": "18pt", "line": "1.5x"},
                 "ind": {"firstLine": "0pt"}, "outlineLvl": 1, "keepNext": True},
         "rPr": {"sz": 16, "b": True,
                 "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman",
                            "hAnsi": "Times New Roman"}}},
        {"tag": "catalog_h2",  # 节标题（1.1）
         "pPr": {"jc": "left",
                 "spacing": {"before": "13pt", "after": "6pt", "line": "1.5x"},
                 "ind": {"firstLine": "0pt"}, "outlineLvl": 2, "keepNext": True},
         "rPr": {"sz": 14, "b": False,
                 "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman",
                            "hAnsi": "Times New Roman"}}},
        {"tag": "catalog_h3",  # 条标题（1.1.1）
         "pPr": {"jc": "left",
                 "spacing": {"before": "6pt", "after": "3pt", "line": "1.5x"},
                 "ind": {"firstLine": "0pt"}, "outlineLvl": 3, "keepNext": True},
         "rPr": {"sz": 12, "b": False,
                 "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman",
                            "hAnsi": "Times New Roman"}}},
        {"tag": "main_text",  # 正文
         "pPr": {"jc": "both",
                 "spacing": {"before": "0pt", "after": "0pt", "line": "1.5x"},
                 "ind": {"firstLine": "2ch"}, "outlineLvl": 10},
         "rPr": {"sz": 12, "b": False,
                 "rFonts": {"eastAsia": "宋体", "ascii": "Times New Roman",
                            "hAnsi": "Times New Roman"}}},
        {"tag": "signature",  # 落款（投标函/授权书尾部）
         "pPr": {"jc": "end",
                 "spacing": {"before": "24pt", "after": "0pt", "line": "1.5x"},
                 "ind": {"firstLine": "0pt"}},
         "rPr": {"sz": 12, "b": False,
                 "rFonts": {"eastAsia": "宋体", "ascii": "Times New Roman",
                            "hAnsi": "Times New Roman"}}},
    ],
    "header_footer": {"footers": {"default": {"mode": "set",
        "pageNumber": {"show": True, "format": "arabic", "align": "center"}}}},
    "notes": {
        "_declaration": "公开惯例版参数，非 WPS 内部模板参数（WI-002 解密未完成）",
        "sectPr": "出处类型=招投标文件排版公开惯例：上下2.5cm；左右取任务区间2.8-3.0cm内常用组合——左3.0cm（装订侧加宽惯例）+右2.8cm",
        "doc_title": "出处类型=标书封面公开惯例：大号标题（一号26pt或小一24pt变体）黑体加粗居中；outlineLvl=1使封面可挂标题样式（宿主write_pPr→w:outlineLvl=0即Heading1语义；宿主识别器重跑时封面首短行仍重标doc_title，幂等）。如需封面不进目录可删outlineLvl键",
        "catalog_h1": "出处类型=标书排版公开惯例：章标题三号黑体居中、段前24磅（对齐宿主PRESET_THESIS章标题令牌形态 before24pt/after18pt）",
        "catalog_h2": "出处类型=标书排版公开惯例（无强制公开值）：节标题四号黑体左对齐，取招标文件模板通行档",
        "catalog_h3": "出处类型=通用排版层级惯例：条标题小四黑体左对齐，梯度16/14/12递减",
        "main_text": "出处类型=标书排版公开惯例：正文小四宋体、两端对齐、1.5倍行距、首行缩进2字符",
        "signature": "出处类型=标书排版公开惯例：落款（投标人/日期）右对齐，段前24pt与正文隔开",
        "header_footer": "出处类型=公开通行做法：页码页脚居中阿拉伯数字（与宿主PRESET_OFFICIAL/PRESET_THESIS页码令牌同构；宿主op_setup_header_footer实际恒居中写入，align键为契约文档值）",
        "outlineLvl": "出处类型=宿主引擎行为：章/节/条编号经heading_rank（RE_CHAPTER/RE_CN_LIST/RE_ARAB_DOTTED）压缩映射到h1/h2/h3",
    },
}

__all__ = ["PRESET_CONTRACT", "PRESET_BID"]
