#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""国标品类预设 —— WPS 内部模板【真身实测参数】版。

来源（零手填，直读解密真身 docx 的 styles.xml/sectPr）：
  work/decrypt/out_final/{official,nationalstandard}.docx + .params.json
  （official = presettemplates/official；nationalstandard = presettemplates/thesis/standard/nationalstandard）

与 GB/T 概论版（aipaiban.PRESET_OFFICIAL/PRESET_THESIS）的差异，全部以真身为准：
  - official-wps：公文标题真身 = 方正小标宋简体 二号(22pt) 居中 行距36pt（概论版以宋体加粗代）；
    正文 Normal 真身行距 1.0x（概论版按 GB 惯例取 28pt 固定）；各级标题行距 28pt 固定、首行缩进2字符
  - thesis-wps：正文真身 = 宋体 12pt 1.2x（概论版 1.5x）；h1/h2/h3 = 黑体 16/15/14pt 加粗 2.5/2.5pt 1.5x
    （概论版 h2=四号14）；Title = 黑体 22pt 加粗居中
  - 正文首行缩进 2 字符：真身模板 Normal 未内嵌 ind（依赖段落直挂），此处按 GB/T 9704 与论文
    惯例补 2ch，标注为复刻侧推断（真身标题级 firstLineChars=2.0 为佐证）
"""
__all__ = ["PRESET_OFFICIAL_WPS", "PRESET_THESIS_WPS"]

_FS = {"eastAsia": "仿宋_GB2312", "ascii": "仿宋_GB2312", "hAnsi": "仿宋_GB2312"}
_TNR = {"eastAsia": "宋体", "ascii": "Calibri", "hAnsi": "Calibri"}

PRESET_OFFICIAL_WPS = {
    "label": "公文（WPS 内部模板真身 · GB/T 9704-2012）",
    "sectPr": {"pgSz": {"w": "595.3pt", "h": "841.9pt", "orient": "portrait"},
               "pgMar": {"top": "3.7cm", "bottom": "3.5cm", "left": "2.8cm", "right": "2.6cm"}},
    "rules": [
        {"tag": "doc_title", "pPr": {"jc": "center", "spacing": {"line": "36pt"}, "outlineLvl": 10},
         "rPr": {"sz": 22, "b": False, "rFonts": {"eastAsia": "方正小标宋简体", "ascii": "方正小标宋简体", "hAnsi": "方正小标宋简体"}}},
        {"tag": "catalog_h1", "pPr": {"jc": "left", "spacing": {"line": "28pt"}, "ind": {"firstLine": "2ch"}, "outlineLvl": 1, "keepNext": True},
         "rPr": {"sz": 16, "rFonts": {"eastAsia": "黑体", "ascii": "黑体", "hAnsi": "黑体"}}},
        {"tag": "catalog_h2", "pPr": {"jc": "left", "spacing": {"line": "28pt"}, "ind": {"firstLine": "2ch"}, "outlineLvl": 2, "keepNext": True},
         "rPr": {"sz": 16, "rFonts": {"eastAsia": "楷体_GB2312", "ascii": "楷体_GB2312", "hAnsi": "楷体_GB2312"}}},
        {"tag": "catalog_h3", "pPr": {"jc": "left", "spacing": {"line": "28pt"}, "ind": {"firstLine": "2ch"}, "outlineLvl": 3, "keepNext": True},
         "rPr": {"sz": 16, "rFonts": _FS}},
        {"tag": "main_text", "pPr": {"jc": "both", "spacing": {"line": "1x"}, "ind": {"firstLine": "2ch"}, "outlineLvl": 10},
         "rPr": {"sz": 16, "rFonts": _FS}},
        {"tag": "addressees", "pPr": {"jc": "left", "spacing": {"line": "1x"}, "ind": {"firstLine": "0pt"}},
         "rPr": {"sz": 16, "rFonts": _FS}},
        {"tag": "signature", "pPr": {"jc": "end", "spacing": {"before": "24pt", "line": "1x"}},
         "rPr": {"sz": 16, "rFonts": _FS}},
    ],
    "header_footer": {"footers": {"default": {"mode": "set", "pageNumber": {"show": True, "format": "arabic", "align": "center"}}}},
}

PRESET_THESIS_WPS = {
    "label": "论文国标（WPS 内部模板真身 · GBT7713）",
    "sectPr": {"pgSz": {"w": "595.3pt", "h": "841.9pt", "orient": "portrait"},
               "pgMar": {"top": "72pt", "bottom": "72pt", "left": "90pt", "right": "90pt"}},
    "rules": [
        {"tag": "doc_title", "pPr": {"jc": "center", "spacing": {"before": "2.5pt", "after": "2.5pt", "line": "1.5x"}, "outlineLvl": 10},
         "rPr": {"sz": 22, "b": True, "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},
        {"tag": "catalog_h1", "pPr": {"jc": "left", "spacing": {"before": "2.5pt", "after": "2.5pt", "line": "1.5x"}, "ind": {"firstLine": "0pt"}, "outlineLvl": 1, "keepNext": True},
         "rPr": {"sz": 16, "b": True, "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},
        {"tag": "catalog_h2", "pPr": {"jc": "left", "spacing": {"before": "2.5pt", "after": "2.5pt", "line": "1.5x"}, "ind": {"firstLine": "0pt"}, "outlineLvl": 2, "keepNext": True},
         "rPr": {"sz": 15, "b": True, "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},
        {"tag": "catalog_h3", "pPr": {"jc": "left", "spacing": {"before": "2.5pt", "after": "2.5pt", "line": "1.5x"}, "ind": {"firstLine": "0pt"}, "outlineLvl": 3, "keepNext": True},
         "rPr": {"sz": 14, "b": True, "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},
        {"tag": "main_text", "pPr": {"jc": "both", "spacing": {"line": "1.2x"}, "ind": {"firstLine": "2ch"}, "outlineLvl": 10},
         "rPr": {"sz": 12, "rFonts": _TNR}},
        {"tag": "ref_list", "pPr": {"jc": "left", "spacing": {"line": "1.2x"}, "ind": {"left": "0pt", "hanging": "24pt"}},
         "rPr": {"sz": 12, "rFonts": _TNR}},
        {"tag": "signature", "pPr": {"jc": "end", "spacing": {"before": "24pt"}}, "rPr": {"sz": 12, "rFonts": _TNR}},
    ],
    "header_footer": {"footers": {"default": {"mode": "set", "pageNumber": {"show": True, "format": "arabic", "align": "center"}}}},
}
