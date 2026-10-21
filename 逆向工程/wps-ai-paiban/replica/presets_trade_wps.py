#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""合同/标书预设 —— WPS 内部模板【真身实测参数】版。

来源（零手填，全部直读解密真身 docx 的 styles.xml/sectPr）：
  E:\\AI-Station\\逆向工程\\wps-ai-paiban\\work\\decrypt\\out_final\\{contract,bid}.docx
  （解密链：12B 魔数+base64 → AES-128-CBC(key=5FE71BD15A854390, iv=96D8FDE5E10A6321,
    blob[7:] 为密文，首块因 IV 释读差异损坏 16B，zip 从 PK\\x03\\x04 雕出——Ghidra FUN_10013020 密钥）
  参数 JSON 同目录 {contract,bid}.params.json

真身要点（与公开惯例的差异，实测为准）：
  - 正文 Normal = 宋体/Calibri 五号(10.5pt) 两端对齐（styles 无 firstLine 字段 → 不设缩进，如实）
  - h1 = 宋体 12pt 加粗 左对齐 12/6pt 1.5x（非「三号黑体居中」的惯例说法）
  - 标书与合同模板高度同构，差异在 h2 段前(合同 6pt/标书 0pt)与 h3 加粗
  - 落款无模板样式证据 → 沿用 structure-reconciliation §落款 规则（右对齐+段前24pt），标注为复刻侧规则
"""
__all__ = ["PRESET_CONTRACT_WPS", "PRESET_BID_WPS"]

_TNR = {"eastAsia": "宋体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}

PRESET_CONTRACT_WPS = {
    "label": "合同（WPS 内部模板真身参数）",
    "sectPr": {"pgSz": {"w": "595.3pt", "h": "841.9pt", "orient": "portrait"},
               "pgMar": {"top": "72pt", "bottom": "72pt", "left": "90pt", "right": "90pt"}},
    "rules": [
        {"tag": "doc_title", "pPr": {"jc": "center", "spacing": {"before": "12pt", "after": "12pt", "line": "1x"}, "outlineLvl": 10},
         "rPr": {"sz": 16, "b": True, "rFonts": {"eastAsia": "宋体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},
        {"tag": "catalog_h1", "pPr": {"jc": "left", "spacing": {"before": "12pt", "after": "6pt", "line": "1.5x"}, "outlineLvl": 1, "keepNext": True},
         "rPr": {"sz": 12, "b": True, "rFonts": {"eastAsia": "宋体", "ascii": "宋体", "hAnsi": "宋体"}}},
        {"tag": "catalog_h2", "pPr": {"jc": "left", "spacing": {"before": "6pt", "after": "6pt", "line": "1.5x"}, "outlineLvl": 2, "keepNext": True},
         "rPr": {"sz": 12, "b": True, "rFonts": _TNR}},
        {"tag": "catalog_h3", "pPr": {"jc": "left", "spacing": {"after": "6pt", "line": "1.25x"}, "outlineLvl": 3, "keepNext": True},
         "rPr": {"sz": 12, "rFonts": _TNR}},
        {"tag": "main_text", "pPr": {"jc": "both", "outlineLvl": 10},
         "rPr": {"sz": 10.5, "rFonts": {"eastAsia": "宋体", "ascii": "Calibri", "hAnsi": "Calibri"}}},
        {"tag": "signature", "pPr": {"jc": "end", "spacing": {"before": "24pt"}},
         "rPr": {"sz": 10.5, "rFonts": {"eastAsia": "宋体", "ascii": "Calibri", "hAnsi": "Calibri"}}},
    ],
    "header_footer": {"footers": {"default": {"mode": "set", "pageNumber": {"show": True, "format": "arabic", "align": "center"}}}},
}

PRESET_BID_WPS = {
    "label": "标书（WPS 内部模板真身参数）",
    "sectPr": {"pgSz": {"w": "595.3pt", "h": "841.9pt", "orient": "portrait"},
               "pgMar": {"top": "72pt", "bottom": "72pt", "left": "90pt", "right": "90pt"}},
    "rules": [
        {"tag": "doc_title", "pPr": {"jc": "center", "spacing": {"before": "12pt", "after": "12pt", "line": "1x"}, "outlineLvl": 10},
         "rPr": {"sz": 16, "b": True, "rFonts": {"eastAsia": "宋体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},
        {"tag": "catalog_h1", "pPr": {"jc": "left", "spacing": {"before": "12pt", "after": "6pt", "line": "1.5x"}, "outlineLvl": 1, "keepNext": True},
         "rPr": {"sz": 12, "b": True, "rFonts": {"eastAsia": "宋体", "ascii": "宋体", "hAnsi": "宋体"}}},
        {"tag": "catalog_h2", "pPr": {"jc": "left", "spacing": {"after": "6pt", "line": "1.5x"}, "outlineLvl": 2, "keepNext": True},
         "rPr": {"sz": 12, "b": True, "rFonts": _TNR}},
        {"tag": "catalog_h3", "pPr": {"jc": "left", "spacing": {"after": "6pt", "line": "1.5x"}, "outlineLvl": 3, "keepNext": True},
         "rPr": {"sz": 12, "b": True, "rFonts": _TNR}},
        {"tag": "main_text", "pPr": {"jc": "both", "outlineLvl": 10},
         "rPr": {"sz": 10.5, "rFonts": {"eastAsia": "宋体", "ascii": "Calibri", "hAnsi": "Calibri"}}},
        {"tag": "signature", "pPr": {"jc": "end", "spacing": {"before": "24pt"}},
         "rPr": {"sz": 10.5, "rFonts": {"eastAsia": "宋体", "ascii": "Calibri", "hAnsi": "Calibri"}}},
    ],
    "header_footer": {"footers": {"default": {"mode": "set", "pageNumber": {"show": True, "format": "arabic", "align": "center"}}}},
}
