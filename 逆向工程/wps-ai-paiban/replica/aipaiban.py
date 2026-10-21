#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
AI排版复刻件（WPS「AI排版」会员功能本地复刻）
================================================

逆向蓝本：WPS Office 12.1.0.28802
  office6/addons/kcoworkdockpanel/service/skills/wps-doc-aitypeset/
  （SKILL.md 六品类路由 + references/ 全量规则，证据已归档于 ../evidence/）

复刻架构（与 WPS 原件逐层对应）：
  1. 结构识别      ← doc-element-recog.md + structure-reconciliation.md
                     （WPS 用云端引擎 A源 + overview B源 双源合并；本地以启发式复刻）
  2. 规整度评估    ← path-beauty-rule.md §规整度评估（full / incremental 分流）
  3. 主体风格决策  ← beauty-theme-select.md（三套主题包，默认通用黑色）
  4. 设计令牌      ← beauty-default.yaml + beauty-type-scales.yaml + beauty-palettes.yaml
  5. oplist 规划   ← full-beauty.md / incremental-beauty.md / path-strict-rule.md
  6. 原子操作执行  ← tools/atomic-ops/*.md（16 个 op 的本地 python-docx 实现）
  7. 变更摘要      ← beauty/op-list-summary.md（先问题后方案、from→to 聚合）

单位约定（atomic-ops.md §单位约定的忠实复刻）：
  rPr.sz 用磅(pt)；spacing/ind/sectPr 用带单位字符串 "12pt"/"2ch"/"1.5x"/"24pt+"；
  中文字号名→pt 查 strict_rules/spec-unit-conversion.md 换算表。

品类预设（复刻 WPS 云端模板排版的本地等价物，参数为公开国标）：
  official  公文   ← GB/T 9704-2012《党政机关公文格式》
  thesis    论文   ← GB/T 7713.1-2006 学位论文编写规则（通用版）

用法：
  py -3 aipaiban.py input.docx [-o out.docx] [--mode auto|full|incremental]
       [--theme official-black|steel-blue|personal-navy]
       [--preset beauty|official|thesis] [--toc auto|on|off]
       [--page-numbers on|off] [--h1-break on|off] [--table-style three_line|off]
       [--dry-run]（只出 oplist+变更摘要，不写文件）

仅支持 .docx/.dotx（python-docx 限制；WPS 原件另支持 .doc/.wps，属其私有引擎能力）。
不调用任何 WPS 云端接口——所有排版决策本地完成。
"""
from __future__ import annotations

import argparse
import importlib
import json
import re
import sys
from collections import Counter
from dataclasses import dataclass, field
from pathlib import Path

from docx import Document
from docx.enum.style import WD_STYLE_TYPE
from docx.enum.table import WD_TABLE_ALIGNMENT
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.oxml.ns import qn
from docx.oxml import OxmlElement
from docx.shared import Pt, Twips

# ---------------------------------------------------------------------------
# 0. 单位换算 —— spec-unit-conversion.md 复刻
# ---------------------------------------------------------------------------

CN_SIZE_TO_PT = {  # 中文字号名 → pt（spec-unit-conversion.md §字号）
    "初号": 42, "小初": 36, "一号": 26, "小一": 24, "二号": 22, "小二": 18,
    "三号": 16, "小三": 15, "四号": 14, "小四": 12, "五号": 10.5, "小五": 9,
    "六号": 7.5, "七号": 5.5, "八号": 5,
}
PT_PER_UNIT = {"pt": 1.0, "cm": 28.3465, "mm": 2.83465, "in": 72.0}


def parse_len(v):
    """'12pt'/'2cm'/'2ch' → (值, 单位)；裸数字按 None 返回交由调用方处理。"""
    if isinstance(v, (int, float)):
        return float(v), None
    m = re.fullmatch(r"(-?[\d.]+)\s*(pt|cm|mm|in|ch|x)?", str(v).strip())
    if not m:
        raise ValueError(f"无法解析长度: {v!r}")
    return float(m.group(1)), m.group(2)


def len_to_twips(v, font_pt=12.0):
    """带单位字符串 → OOXML twips（1pt=20twips）。ch 按当前字号换算（beauty-default.yaml 注释）。"""
    n, unit = parse_len(v)
    if unit == "ch":
        return int(round(n * font_pt * 20))
    if unit is None or unit == "pt":
        return int(round(n * 20))
    return int(round(n * PT_PER_UNIT[unit] * 20))


def parse_line(v):
    """行距自描述字符串 → (w:line 值, lineRule)。'1.5x'→(360,'auto')；'24pt'→(480,'exact')；'24pt+'→(480,'atLeast')。"""
    s = str(v).strip()
    m = re.fullmatch(r"(-?[\d.]+)x\+?", s)
    if m:
        return int(round(float(m.group(1)) * 240)), "auto"
    m = re.fullmatch(r"(-?[\d.]+)pt\+?", s)
    if m:
        rule = "atLeast" if s.endswith("+") else "exact"
        return int(round(float(m.group(1)) * 20)), rule
    raise ValueError(f"无法解析行距: {v!r}")


def sz_to_half_pt(sz):
    """rPr.sz（磅，number）→ OOXML 半磅值。"""
    return int(round(float(sz) * 2))


def jc_map(jc):
    return {"start": "left", "end": "right", "both": "both",
            "center": "center", "distribute": "distribute"}.get(jc, jc)


# ---------------------------------------------------------------------------
# 1. 设计令牌 —— beauty-default.yaml / beauty-type-scales.yaml / beauty-palettes.yaml
#    merge(default, typeScale, palette) 三层合并（full-beauty.md §4）
# ---------------------------------------------------------------------------

# beauty-default.yaml roles（排版基线：对齐/缩进/间距/字体分工）
BEAUTY_DEFAULT = {
    "title":            {"fontFamily": "宋体", "latinFont": "Times New Roman", "fontSize": 18, "bold": True,  "textAlign": "center", "textIndent": "0",  "lineHeight": "1.35x", "marginTop": "0pt",  "marginBottom": "8pt"},
    "heading-1":        {"fontFamily": "黑体", "latinFont": "Times New Roman", "fontSize": 14, "bold": False, "textAlign": "left",   "textIndent": "0",  "lineHeight": "1.35x", "marginTop": "6pt",  "marginBottom": "3pt"},
    "heading-1-center": {"fontFamily": "黑体", "latinFont": "Times New Roman", "fontSize": 14, "bold": False, "textAlign": "center", "textIndent": "0",  "lineHeight": "1.35x", "marginTop": "6pt",  "marginBottom": "3pt"},
    "heading-2":        {"fontFamily": "宋体", "latinFont": "Times New Roman", "fontSize": 13, "bold": True,  "textAlign": "left",   "textIndent": "0",  "lineHeight": "1.35x", "marginTop": "5pt",  "marginBottom": "2pt"},
    "heading-3":        {"fontFamily": "宋体", "latinFont": "Times New Roman", "fontSize": 12, "bold": True,  "textAlign": "left",   "textIndent": "0",  "lineHeight": "1.35x", "marginTop": "3pt",  "marginBottom": "1pt"},
    "heading-4":        {"fontFamily": "宋体", "latinFont": "Times New Roman", "fontSize": 12, "bold": True,  "textAlign": "left",   "textIndent": "0",  "lineHeight": "1.35x", "marginTop": "2pt",  "marginBottom": "1pt"},
    "body":             {"fontFamily": "宋体", "latinFont": "Times New Roman", "fontSize": 12, "bold": False, "textAlign": "both",   "textIndent": "2ch", "lineHeight": "1.35x", "marginTop": "0pt",  "marginBottom": "0pt"},
    "addressees":       {"fontFamily": "宋体", "latinFont": "Times New Roman", "fontSize": 12, "bold": False, "textAlign": "left",   "textIndent": "0",  "lineHeight": "1.35x", "marginTop": "0pt",  "marginBottom": "0pt"},
    "list-item":        {"fontFamily": "宋体", "latinFont": "Times New Roman", "fontSize": 12, "bold": False, "textAlign": "left",   "textIndent": "0",  "lineHeight": "1.35x", "marginTop": "0pt",  "marginBottom": "0pt"},
    "blockquote":       {"fontFamily": "宋体", "latinFont": "Times New Roman", "fontSize": 12, "bold": False, "textAlign": "left",   "textIndent": "2ch", "lineHeight": "1.35x", "marginTop": "3pt",  "marginBottom": "3pt"},
    "caption":          {"fontFamily": "宋体", "latinFont": "Times New Roman", "fontSize": 10.5, "bold": False, "textAlign": "center", "textIndent": "0"},
    "footer-like":      {"fontFamily": "宋体", "latinFont": "Times New Roman", "fontSize": 12, "bold": False, "textAlign": "right",  "textIndent": "0",  "lineHeight": "1.35x", "marginTop": "0pt",  "marginBottom": "0pt"},
    "footer-like-lead": {"fontFamily": "宋体", "latinFont": "Times New Roman", "fontSize": 12, "bold": False, "textAlign": "right",  "textIndent": "0",  "lineHeight": "1.35x", "marginTop": "16pt", "marginBottom": "0pt"},
    "appendix-title":   {"fontFamily": "黑体", "latinFont": "Times New Roman", "fontSize": 14, "bold": False, "textAlign": "left",   "textIndent": "0",  "lineHeight": "1.35x", "marginTop": "6pt",  "marginBottom": "3pt"},
    "page-header-footer": {"fontFamily": "宋体", "latinFont": "Times New Roman", "fontSize": 10.5, "bold": False, "textAlign": "center", "textIndent": "0"},
}

# beauty-type-scales.yaml（字号配套覆盖，只列与 default 不同的键）
TYPE_SCALES = {
    "official-document": {"label": "通用字号", "page": {"defaultFont": "宋体", "defaultSize": 12, "latinFont": "Times New Roman"}, "overrides": {}},
    "modern-steel":      {"label": "现代字号", "page": {"defaultFont": "微软雅黑", "defaultSize": 12, "latinFont": "Times New Roman"},
                          "overrides": {
                              "heading-2": {"fontFamily": "宋体", "bold": False},
                              "heading-3": {"fontFamily": "微软雅黑"}, "heading-4": {"fontFamily": "微软雅黑"},
                              "body": {"fontFamily": "微软雅黑"}, "addressees": {"fontFamily": "微软雅黑"},
                              "list-item": {"fontFamily": "微软雅黑"}, "blockquote": {"fontFamily": "微软雅黑"},
                              "caption": {"fontFamily": "微软雅黑"}, "footer-like": {"fontFamily": "微软雅黑"},
                              "footer-like-lead": {"fontFamily": "微软雅黑"}}},
    "personal-navy":     {"label": "通用字号", "page": {"defaultFont": "宋体", "defaultSize": 12, "latinFont": "Times New Roman"}, "overrides": {}},
}

# beauty-palettes.yaml（role → color + 统一样式名 styleNames）
PALETTES = {
    "official-black": {"label": "通用黑色", "scale": "official-document",
                       "colors": {"title": "#000000", "heading-1": "#000000", "heading-1-center": "#000000",
                                  "heading-2": "#000000", "heading-3": "#000000", "heading-4": "#000000",
                                  "body": "#000000", "addressees": "#000000", "list-item": "#000000",
                                  "blockquote": "#666666", "caption": "#666666", "footer-like": "#000000",
                                  "footer-like-lead": "#000000", "appendix-title": "#000000", "page-header-footer": "#666666"}},
    "steel-blue": {"label": "方案钢蓝", "scale": "modern-steel",
                   "colors": {"title": "#2F5D7C", "heading-1": "#2F5D7C", "heading-1-center": "#2F5D7C",
                              "heading-2": "#2F5D7C", "heading-3": "#334155", "heading-4": "#334155",
                              "body": "#111111", "addressees": "#111111", "list-item": "#111111",
                              "blockquote": "#667085", "caption": "#667085", "footer-like": "#111111",
                              "footer-like-lead": "#111111", "appendix-title": "#2F5D7C", "page-header-footer": "#667085"}},
    "personal-navy": {"label": "藏青蓝", "scale": "personal-navy",
                      "colors": {"title": "#24324F", "heading-1": "#24324F", "heading-1-center": "#24324F",
                                 "heading-2": "#24324F", "heading-3": "#42506B", "heading-4": "#42506B",
                                 "body": "#111111", "addressees": "#111111", "list-item": "#111111",
                                 "blockquote": "#666666", "caption": "#666666", "footer-like": "#111111",
                                 "footer-like-lead": "#111111", "appendix-title": "#24324F", "page-header-footer": "#666666"}},
}

# beauty-palettes.yaml styleNames（统一样式名，import_element_styles 写入用）
STYLE_NAMES = {
    "title": "美化文档标题", "heading-1": "美化标题 1", "heading-1-center": "美化标题 1（居中）",
    "heading-2": "美化标题 2", "heading-3": "美化标题 3", "heading-4": "美化标题 4",
    "body": "美化正文", "addressees": "美化主送对象", "list-item": "美化列表项",
    "blockquote": "美化引用说明", "caption": "美化图表标题", "footer-like": "美化尾注",
    "footer-like-lead": "美化尾注（首行）", "appendix-title": "美化附录标题", "page-header-footer": "美化页眉页脚",
}

# role → formatList tag / OOXML element（incremental-beauty.md §role→tag 映射）
ROLE_TO_TAG = {"doc_title": "doc_title", "heading-1": "catalog_h1", "heading-2": "catalog_h2",
               "heading-3": "catalog_h3", "heading-4": "catalog_h4", "heading-5": "catalog_h5"}
HEADING_ROLE_OF_LEVEL = {1: "heading-1", 2: "heading-2", 3: "heading-3", 4: "heading-4", 5: "heading-5"}


def merge_role_style(role, theme_id, h1_center=False):
    """merge(default, typeScale, palette) —— full-beauty.md §4 合并三源。"""
    if role == "heading-1" and h1_center:
        role = "heading-1-center"
    base = dict(BEAUTY_DEFAULT[role])
    scale_id = PALETTES[theme_id]["scale"]
    base.update(TYPE_SCALES[scale_id]["overrides"].get(role, {}))
    base["color"] = PALETTES[theme_id]["colors"].get(role, "#000000")
    return base


def role_to_pPr_rPr(spec, outline_lvl):
    """role 令牌 → oplist pPr/rPr（beauty-default.yaml 文件尾 oplist 换算注释的复刻）。"""
    pPr = {
        "jc": jc_map(spec.get("textAlign", "left")),
        "outlineLvl": outline_lvl,           # 10=正文（OOXML 9），1~9=标题层级
        "keepNext": spec.get("textAlign") in ("center", "left") and outline_lvl < 10,
        "spacing": {"line": spec.get("lineHeight", "1.35x"),
                    "before": spec.get("marginTop", "0pt"), "after": spec.get("marginBottom", "0pt")},
        "ind": {"firstLine": spec.get("textIndent", "0")},
    }
    rPr = {"sz": spec["fontSize"], "b": bool(spec.get("bold")),
           "color": spec.get("color", "#000000"),
           "rFonts": {"eastAsia": spec["fontFamily"], "ascii": spec.get("latinFont", "Times New Roman"),
                      "hAnsi": spec.get("latinFont", "Times New Roman")}}
    return pPr, rPr


# ---------------------------------------------------------------------------
# 2. 品类预设 —— 公文 GB/T 9704-2012 / 论文 GB/T 7713（本地等价于 WPS 云端模板排版）
#    strict 模式：batch_set_paragraph_props 直出（path-strict-rule.md S1~S8 约束）
# ---------------------------------------------------------------------------

PRESET_OFFICIAL = {  # GB/T 9704-2012 党政机关公文格式
    "label": "公文 GB/T 9704-2012",
    "sectPr": {"pgSz": {"w": "595.3pt", "h": "841.9pt", "orient": "portrait"},
               "pgMar": {"top": "3.7cm", "bottom": "3.5cm", "left": "2.8cm", "right": "2.6cm"}},
    "rules": [
        {"tag": "doc_title", "pPr": {"jc": "center", "spacing": {"before": "0pt", "after": "22pt", "line": "1x"}},
         "rPr": {"sz": 22, "b": True, "rFonts": {"eastAsia": "宋体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},  # 二号小标宋（以宋体加粗代）
        {"tag": "catalog_h1", "pPr": {"jc": "left", "spacing": {"before": "6pt", "after": "6pt", "line": "28pt"}, "ind": {"firstLine": "2ch"}, "outlineLvl": 1, "keepNext": True},
         "rPr": {"sz": 16, "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},          # 一级标题 黑体三号
        {"tag": "catalog_h2", "pPr": {"jc": "left", "spacing": {"before": "6pt", "after": "6pt", "line": "28pt"}, "ind": {"firstLine": "2ch"}, "outlineLvl": 2, "keepNext": True},
         "rPr": {"sz": 16, "rFonts": {"eastAsia": "楷体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},          # 二级标题 楷体三号
        {"tag": "catalog_h3", "pPr": {"jc": "left", "spacing": {"before": "6pt", "after": "6pt", "line": "28pt"}, "ind": {"firstLine": "2ch"}, "outlineLvl": 3, "keepNext": True},
         "rPr": {"sz": 16, "b": True, "rFonts": {"eastAsia": "仿宋", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},  # 三级标题 仿宋三号加粗
        {"tag": "main_text", "pPr": {"jc": "both", "spacing": {"before": "0pt", "after": "0pt", "line": "28pt"}, "ind": {"firstLine": "2ch"}, "outlineLvl": 10},
         "rPr": {"sz": 16, "rFonts": {"eastAsia": "仿宋", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},          # 正文 仿宋三号，行距 28 磅（28~30 取最小值）
        {"tag": "signature", "pPr": {"jc": "end", "spacing": {"before": "24pt", "after": "0pt", "line": "28pt"}, "ind": {"firstLine": "0pt"}},
         "rPr": {"sz": 16, "rFonts": {"eastAsia": "仿宋", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},          # 落款右对齐（structure-reconciliation §落款）
        {"tag": "addressees", "pPr": {"jc": "left", "spacing": {"before": "0pt", "after": "0pt", "line": "28pt"}, "ind": {"firstLine": "0pt"}},
         "rPr": {"sz": 16, "rFonts": {"eastAsia": "仿宋", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},          # 主送机关顶格
    ],
    "header_footer": {"footers": {"default": {"mode": "set", "pageNumber": {"show": True, "format": "arabic", "align": "center"}}}},
}

PRESET_THESIS = {  # GB/T 7713.1-2006 学位论文编写规则（通用版）
    "label": "论文 GB/T 7713（通用）",
    "sectPr": {"pgSz": {"w": "595.3pt", "h": "841.9pt", "orient": "portrait"},
               "pgMar": {"top": "2.54cm", "bottom": "2.54cm", "left": "3.0cm", "right": "2.6cm"}},
    "rules": [
        {"tag": "doc_title", "pPr": {"jc": "center", "spacing": {"before": "0pt", "after": "18pt", "line": "1.5x"}},
         "rPr": {"sz": 16, "b": True, "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},
        {"tag": "catalog_h1", "pPr": {"jc": "center", "spacing": {"before": "24pt", "after": "18pt", "line": "1.5x"}, "ind": {"firstLine": "0pt"}, "outlineLvl": 1, "keepNext": True},
         "rPr": {"sz": 16, "b": True, "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},  # 章标题 黑体三号居中
        {"tag": "catalog_h2", "pPr": {"jc": "left", "spacing": {"before": "13pt", "after": "13pt", "line": "1.5x"}, "ind": {"firstLine": "0pt"}, "outlineLvl": 2, "keepNext": True},
         "rPr": {"sz": 14, "b": True, "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},  # 节标题 黑体四号
        {"tag": "catalog_h3", "pPr": {"jc": "left", "spacing": {"before": "12pt", "after": "6pt", "line": "1.5x"}, "ind": {"firstLine": "0pt"}, "outlineLvl": 3, "keepNext": True},
         "rPr": {"sz": 12, "b": True, "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},
        {"tag": "main_text", "pPr": {"jc": "both", "spacing": {"before": "0pt", "after": "0pt", "line": "1.5x"}, "ind": {"firstLine": "2ch"}, "outlineLvl": 10},
         "rPr": {"sz": 12, "rFonts": {"eastAsia": "宋体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},          # 正文 宋体小四 1.5 倍行距
        {"tag": "abs_title", "pPr": {"jc": "center", "spacing": {"before": "12pt", "after": "12pt", "line": "1.5x"}},
         "rPr": {"sz": 16, "b": True, "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},
        {"tag": "abs_content", "pPr": {"jc": "both", "spacing": {"line": "1.5x"}, "ind": {"firstLine": "2ch"}},
         "rPr": {"sz": 12, "rFonts": {"eastAsia": "宋体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},
        {"tag": "abs_keywords", "pPr": {"jc": "left", "spacing": {"before": "6pt", "line": "1.5x"}, "ind": {"firstLine": "0pt"}},
         "rPr": {"sz": 12, "rFonts": {"eastAsia": "宋体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},
        {"tag": "ref_title", "pPr": {"jc": "center", "spacing": {"before": "18pt", "after": "12pt", "line": "1.5x"}},
         "rPr": {"sz": 16, "b": True, "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},
        {"tag": "ref_list", "pPr": {"jc": "left", "spacing": {"line": "1.5x"}, "ind": {"left": "0pt", "hanging": "24pt"}},
         "rPr": {"sz": 10.5, "rFonts": {"eastAsia": "宋体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}},        # 参考文献 五号悬挂缩进
        {"tag": "signature", "pPr": {"jc": "end", "spacing": {"before": "24pt"}}, "rPr": {"sz": 12}},
    ],
    "header_footer": {"footers": {"default": {"mode": "set", "pageNumber": {"show": True, "format": "arabic", "align": "center"}}}},
}


# ---------------------------------------------------------------------------
# 3. 结构识别器 —— doc-element-recog.md（A源）+ structure-reconciliation.md（B源合并）本地复刻
# ---------------------------------------------------------------------------

RE_CHAPTER = re.compile(r"^第\s*[一二三四五六七八九十百千零〇两\d]+\s*[章部编]")
RE_PART = re.compile(r"^第\s*[一二三四五六七八九十百千零〇两\d]+\s*部分")
RE_SECTION = re.compile(r"^第\s*[一二三四五六七八九十百千零〇两\d]+\s*[节条款]")
RE_CN_LIST = re.compile(r"^[一二三四五六七八九十]+\s*、")
RE_CN_PAREN = re.compile(r"^（[一二三四五六七八九十]+）")
RE_ARAB_DOTTED = re.compile(r"^(\d+(?:\.\d+)+)[\s、．.]?")
RE_ARAB_LIST = re.compile(r"^\d+\s*[、．.]")
RE_ARAB_PAREN = re.compile(r"^[（(]\s*\d+\s*[)）]")
RE_ADDRESSEE = re.compile(r"^(尊敬的|各位|敬爱的|同志们|代表们|各位领导|各位同事|各位来宾)[^。！？\n]{0,28}[:：]$")
RE_SIG_DATE = re.compile(r"^(20\d{2}\s*年|[〇○零一二三四五六七八九二]{2,5}\s*年).*?(月|日|$)|^[〇○\d\s年月日]+$")
RE_ABS_TITLE = re.compile(r"^摘\s*要|^摘\s{2,}要$|^Abstract|^ABSTRACT", re.I)
RE_ABS_KW = re.compile(r"^(关键词|关键字|Key\s*words?)\s*[:：]", re.I)
RE_REF_TITLE = re.compile(r"^(参考文献|References|REFERENCES|引用文献)\s*$")
RE_ACK_TITLE = re.compile(r"^(致\s*谢|谢\s*辞|后\s*记|Acknowledg(e)?ments?)\s*$", re.I)
RE_APPENDIX = re.compile(r"^附\s*录")
RE_TOC_TITLE = re.compile(r"^目\s*录$|^目\s{2,}录$|^Table of Contents$", re.I)
RE_SENT_END = re.compile(r"[。！？；;，,]$")


def heading_rank(text):
    """编号前缀 → 层级 rank（小值=高级）。None=非编号标题形态。"""
    t = text.strip()
    if not t:
        return None
    if RE_PART.match(t):
        return 1
    if RE_CHAPTER.match(t):
        return 1
    if RE_CN_LIST.match(t):
        return 1
    if RE_SECTION.match(t):
        return 2
    if RE_CN_PAREN.match(t):
        return 2
    if RE_ARAB_DOTTED.match(t):
        return len(RE_ARAB_DOTTED.match(t).group(1).split(".")) + 1
    if RE_ARAB_PAREN.match(t):
        return 4
    if RE_ARAB_LIST.match(t):
        return 3
    return None


@dataclass
class Para:
    idx: int                      # 段落在 body 中的序号
    p: object                     # python-docx paragraph
    text: str = ""
    style_name: str = ""
    outline_lvl: int | None = None
    jc: str | None = None
    sizes: list = field(default_factory=list)   # 半磅
    bold: bool = False
    east_font: str | None = None
    first_line_chars: int | None = None
    has_image: bool = False
    has_break: bool = False
    in_table: bool = False
    # 识别结果
    tag: str = "main_text"
    level: int = 0                # 标题层级（1~5），0=非标题
    confidence: str = "medium"


def read_paragraphs(doc):
    """采集全文顶层段落（表格内段落标记 in_table，不参与 formatList——structure-reconciliation 规则）。"""
    paras = []

    def scan(parent, in_table):
        for p in parent.paragraphs:
            para = Para(idx=len(paras), p=p, in_table=in_table)
            para.text = p.text or ""
            try:
                para.style_name = p.style.name if p.style is not None else ""
            except Exception:
                para.style_name = ""
            pPr = p._p.pPr
            if pPr is not None:
                ol = pPr.find(qn("w:outlineLvl"))
                if ol is not None:
                    para.outline_lvl = int(ol.get(qn("w:val")))
                ind = pPr.find(qn("w:ind"))
                if ind is not None and ind.get(qn("w:firstLineChars")):
                    para.first_line_chars = int(ind.get(qn("w:firstLineChars")))
            para.jc = _jc_of(p)
            for r in p.runs:
                if r.font.size is not None:
                    para.sizes.append(r.font.size.pt)
                if r.font.bold:
                    para.bold = True
                rPr = r._r.rPr
                if rPr is not None:
                    rf = rPr.find(qn("w:rFonts"))
                    if rf is not None and rf.get(qn("w:eastAsia")) and para.east_font is None:
                        para.east_font = rf.get(qn("w:eastAsia"))
                if r._r.find(qn("w:drawing")) is not None or r._r.find(qn("w:pict")) is not None:
                    para.has_image = True
                if r._r.find(qn("w:br")) is not None:
                    para.has_break = True
            paras.append(para)

    scan(doc, False)
    for tbl in doc.tables:
        for row in tbl.rows:
            for cell in row.cells:
                scan(cell, True)
    return paras


def _jc_of(p):
    j = p.alignment
    if j is None:
        pPr = p._p.pPr
        if pPr is not None:
            jc = pPr.find(qn("w:jc"))
            return jc.get(qn("w:val")) if jc is not None else None
        return None
    return {WD_ALIGN_PARAGRAPH.CENTER: "center", WD_ALIGN_PARAGRAPH.RIGHT: "end",
            WD_ALIGN_PARAGRAPH.JUSTIFY: "both", WD_ALIGN_PARAGRAPH.LEFT: "start",
            WD_ALIGN_PARAGRAPH.DISTRIBUTE: "distribute"}.get(j, str(j).split(".")[-1].lower() if j else None)


def _style_heading_level(style_name):
    """'Heading 2' / '标题 3' → 2/3；其余 None。"""
    m = re.match(r"^(?:heading|标题)\s*(\d)$", (style_name or "").strip(), re.I)
    return int(m.group(1)) if m else None


def recognize_structure(paras):
    """产出 formatList {tag: [para.idx,...]}（open_typeset_session recog_result 等价物）。

    优先级：样式/大纲级别（A源强信号） > 文本形态启发式（B源）。
    冲突取舍遵循 structure-reconciliation.md Step 3：短+总结意义=标题；封面/称呼语/落款单独保护。
    """
    body = [p for p in paras if not p.in_table]
    nonempty = [p for p in body if p.text.strip()]

    # --- 第 1 轮：样式信号 ---
    for p in body:
        lv = _style_heading_level(p.style_name)
        if lv is None and p.outline_lvl is not None and p.outline_lvl <= 8:
            lv = p.outline_lvl + 1
        if lv:
            p.tag = f"catalog_h{min(lv, 5)}"
            p.level = min(lv, 5)
            p.confidence = "high"

    # --- 第 2 轮：特殊区段标题 ---
    for p in body:
        t = p.text.strip()
        if not t:
            continue
        if p.level == 0:
            if RE_ABS_TITLE.match(t) and len(t) <= 12:
                p.tag, p.confidence = "abs_title", "high"
            elif RE_ABS_KW.match(t):
                p.tag, p.confidence = "abs_keywords", "high"
            elif RE_REF_TITLE.match(t):
                p.tag, p.confidence = "ref_title", "high"
            elif RE_ACK_TITLE.match(t):
                p.tag, p.confidence = "ack_title", "high"
            elif RE_APPENDIX.match(t) and len(t) <= 20:
                p.tag, p.level, p.confidence = "appendix_title", 1, "high"
            elif RE_TOC_TITLE.match(t) and len(t) <= 6:
                p.tag, p.confidence = "catalog_title", "high"

    # --- 第 3 轮（前置）：封面 / 主标题 / 称呼语（B源特别说明三则；须先于编号启发式，
    #     否则首段粗短行会被误判为末级标题 —— 2026-10-21 实测回归锚）---
    first_heading_i = next((i for i, p in enumerate(body) if p.level), len(body))
    first_long_body_i = next((i for i, p in enumerate(body) if len(p.text.strip()) > 50), len(body))
    zone_end = min(first_heading_i, first_long_body_i)
    seen_nonempty = 0
    for i, p in enumerate(body):
        t = p.text.strip()
        if not t:
            continue
        seen_nonempty += 1
        if i < zone_end and seen_nonempty == 1 and len(t) <= 40 and not RE_ADDRESSEE.match(t):
            p.tag, p.level, p.confidence = "doc_title", 0, "high"
        elif (i < zone_end and seen_nonempty <= 8 and p.tag == "main_text"
              and len(t) <= 40 and heading_rank(t) is None and not p.bold):
            p.tag, p.confidence = "cover", "medium"      # 封面信息区保护，不参与美化
        if p.tag in ("main_text", "cover") and RE_ADDRESSEE.match(t) and i < zone_end + 3:
            p.tag, p.confidence = "addressees", "high"   # 称呼语顶格

    # --- 第 4 轮：编号标题启发式（压缩 rank → 连续层级）---
    ranks_found = set()
    cand = []
    for p in body:
        if p.level or p.tag != "main_text" or not p.text.strip():
            continue
        t = p.text.strip()
        rank = heading_rank(t)
        if rank is not None and len(t) <= 60 and not RE_SENT_END.search(t[-1:] and t[-1] or t):
            # 短、无句末标点 → 标题候选（structure-reconciliation §冲突取舍条件1）
            cand.append((p, rank))
            ranks_found.add(rank)
        elif rank is None and len(t) <= 25 and not RE_SENT_END.search(t) and p.bold and not p.has_image:
            cand.append((p, 90))   # 无编号短加粗行 → 末级候选
            ranks_found.add(90)
    rank_map = {r: i + 1 for i, r in enumerate(sorted(ranks_found))} if ranks_found else {}
    for p, rank in cand:
        lv = rank_map.get(rank, 5)
        # 连续 3+ 个同 rank 短编号段 = 列表项，不是标题（numFormatList 规则）
        p.tag = f"catalog_h{lv}"
        p.level = lv
        p.confidence = "medium"
    _demote_list_runs(body)

    # --- 第 5 轮：落款（B源特别说明：末尾署名/日期，右对齐或日期/机构形态）---
    tail = [p for p in nonempty[-4:]] if nonempty else []
    for p in tail:
        t = p.text.strip()
        if p.tag in ("main_text",) and (
            p.jc in ("end", "right")
            or RE_SIG_DATE.match(t)
            or (len(t) <= 20 and re.search(r"(公司|单位|集团|中心|部|委|办|局|院|校)$", t))
        ):
            p.tag, p.confidence = "signature", "high"
    # 落款首段拆分（footer-like-lead）：保持顺序，首个 signature 段为 lead

    # 摘要/参考文献内容归属
    _attach_sections(body, "abs_title", {"abs_content"}, stop_tags={"abs_keywords", "catalog_h1", "catalog_h2", "catalog_h3", "cover"})
    _attach_sections(body, "ref_title", {"ref_list"}, stop_tags={"catalog_h1", "catalog_h2", "catalog_h3", "ack_title"})

    formatList = {}
    for p in body:
        if p.tag in ("cover", "catalog_title") or (p.tag == "main_text" and not p.text.strip()):
            continue
        formatList.setdefault(p.tag, []).append(p.idx)
    return formatList


def _demote_list_runs(body):
    """连续 ≥3 个同级编号短段 → 退回正文（structure-reconciliation §冲突取舍条件3）。"""
    run = []
    for p in body:
        if p.tag.startswith("catalog_h"):
            run.append(p)
        else:
            if len(run) >= 3:
                texts = [x.text.strip() for x in run]
                if all(len(t) <= 30 for t in texts) and all(heading_rank(t) is not None for t in texts):
                    for x in run:
                        x.tag, x.level = "main_text", 0
            run = []
    if len(run) >= 3:
        texts = [x.text.strip() for x in run]
        if all(len(t) <= 30 for t in texts) and all(heading_rank(t) is not None for t in texts):
            for x in run:
                x.tag, x.level = "main_text", 0


def _attach_sections(body, title_tag, content_tags, stop_tags):
    mode = False
    for p in body:
        if p.tag == title_tag:
            mode = True
            continue
        if mode:
            if p.tag in stop_tags or p.tag.startswith("catalog_h") or not p.text.strip():
                if p.tag in stop_tags or p.tag.startswith("catalog_h"):
                    mode = False
                continue
            p.tag = list(content_tags)[0]
            p.level = 0
            p.confidence = "medium"


# ---------------------------------------------------------------------------
# 4. 规整度评估 —— path-beauty-rule.md §规整度评估（full/incremental 分流）
# ---------------------------------------------------------------------------

def _eff_bold(p):
    if any(r.font.bold for r in p.p.runs if r.font.bold):
        return True
    st, seen = p.p.style, set()
    while st is not None and id(st) not in seen:
        seen.add(id(st))
        try:
            if st.font is not None and st.font.bold:
                return True
        except Exception:
            pass
        st = st.base_style
    return False


def _visual_sig(p):
    """(字号, 加粗, 中文字体) 视觉签名——run 直接格式优先，回落样式链生效值。"""
    sz, font = _effective_size_font(p)
    return (round(sz, 1) if sz else None, _eff_bold(p), font)


def assess_regularity(body):
    """返回 (mode, reasons)。1~3 全过 → incremental；否则 full。"""
    h_levels = {}
    for p in body:
        if p.level:
            h_levels.setdefault(p.level, []).append(p)
    body_paras = [p for p in body if p.tag == "main_text" and p.text.strip()]
    long_bodies = sorted(body_paras, key=lambda x: -len(x.text))[:5]

    # 规则1：各级标题 baseline ≥50% 视觉相同
    for lv, ps in sorted(h_levels.items()):
        if not ps:
            continue
        sigs = Counter(_visual_sig(p) for p in ps)
        top, cnt = sigs.most_common(1)[0]
        if cnt / len(ps) < 0.5 or top[0] is None:
            return "full", [f"第{lv}级标题无 ≥50% 一致的视觉基线"]
    # 规则2：标题字号梯度（多级时须有层次）
    if len(h_levels) >= 2:
        sizes = []
        for lv in sorted(h_levels):
            szs = [s for s in (_visual_sig(p)[0] for p in h_levels[lv]) if s]
            if szs:
                sizes.append(sum(szs) / len(szs))
        if sizes and (max(sizes) - min(sizes) < 0.75):
            return "full", ["多级标题字号几乎无梯度"]
    # 规则3：最低级标题 vs 正文可区分
    if h_levels and long_bodies:
        min_lv = min(h_levels)
        h_sz = [_visual_sig(p)[0] for p in h_levels[min_lv]]
        h_sz = [s for s in h_sz if s]
        b_sz = [_visual_sig(p)[0] for p in long_bodies]
        b_sz = [s for s in b_sz if s]
        if h_sz and b_sz:
            h_b = any(_visual_sig(p)[1] for p in h_levels[min_lv])
            b_b = any(_visual_sig(p)[1] for p in long_bodies)
            if (sum(h_sz) / len(h_sz)) <= (sum(b_sz) / len(b_sz)) + 0.1 and h_b == b_b:
                return "full", ["最低级标题与正文视觉不可区分"]
    return "incremental", ["各级标题基线一致、梯度与层次清晰"]


def h1_all_center_eligible(body):
    """full-beauty.md §一级标题对齐：全部无编号或「第x章/节/部分」→ 居中；任一条款式 → 全部左对齐。"""
    for p in body:
        if p.tag == "catalog_h1":
            t = p.text.strip()
            if RE_CHAPTER.match(t) or RE_PART.match(t) or RE_SECTION.match(t):
                continue
            if heading_rank(t) is None:
                continue
            return False, t
    return True, None


# ---------------------------------------------------------------------------
# 5. OOXML 低层写入 —— oplist pPr/rPr/sectPr → python-docx / 原生 XML
# ---------------------------------------------------------------------------

def _get_or_add(parent, tag):
    el = parent.find(qn(tag))
    if el is None:
        el = OxmlElement(tag)
        parent.append(el)
    return el


def write_pPr(p, pPr, outline_from_spec=True):
    """把 oplist pPr 写到段落直接格式（batch_set_paragraph_props 语义：只写出现的字段）。"""
    pf = p.paragraph_format
    if "jc" in pPr:
        p.alignment = {"center": WD_ALIGN_PARAGRAPH.CENTER, "both": WD_ALIGN_PARAGRAPH.JUSTIFY,
                       "end": WD_ALIGN_PARAGRAPH.RIGHT, "start": WD_ALIGN_PARAGRAPH.LEFT,
                       "left": WD_ALIGN_PARAGRAPH.LEFT, "right": WD_ALIGN_PARAGRAPH.RIGHT,
                       "distribute": WD_ALIGN_PARAGRAPH.DISTRIBUTE}.get(pPr["jc"])
    sp = pPr.get("spacing")
    if sp:
        pPr_el = _get_or_add(p._p, "w:pPr")
        sp_el = _get_or_add(pPr_el, "w:spacing")
        if "before" in sp:
            sp_el.set(qn("w:before"), str(len_to_twips(sp["before"])))
        if "after" in sp:
            sp_el.set(qn("w:after"), str(len_to_twips(sp["after"])))
        if "line" in sp:
            val, rule = parse_line(sp["line"])
            sp_el.set(qn("w:line"), str(val))
            sp_el.set(qn("w:lineRule"), rule)
    ind = pPr.get("ind")
    if ind:
        pPr_el = _get_or_add(p._p, "w:pPr")
        ind_el = _get_or_add(pPr_el, "w:ind")
        font_pt = 12.0
        if "firstLine" in ind:
            n, unit = parse_len(ind["firstLine"])
            if unit == "ch":
                ind_el.set(qn("w:firstLineChars"), str(int(n * 100)))
                ind_el.set(qn("w:firstLine"), str(len_to_twips(ind["firstLine"], font_pt)))
            else:
                ind_el.set(qn("w:firstLine"), str(len_to_twips(ind["firstLine"])))
        if "left" in ind:
            ind_el.set(qn("w:left"), str(len_to_twips(ind["left"])))
            if parse_len(ind["left"])[1] == "ch":
                ind_el.set(qn("w:leftChars"), str(int(parse_len(ind["left"])[0] * 100)))
        if "hanging" in ind:
            n, unit = parse_len(ind["hanging"])
            if unit == "ch":
                ind_el.set(qn("w:hangingChars"), str(int(n * 100)))
            ind_el.set(qn("w:hanging"), str(len_to_twips(ind["hanging"])))
        if "right" in ind:
            ind_el.set(qn("w:right"), str(len_to_twips(ind["right"])))
    pPr_el = p._p.get_or_add_pPr()
    if outline_from_spec and "outlineLvl" in pPr:
        ol = _get_or_add(pPr_el, "w:outlineLvl")
        ol.set(qn("w:val"), str(min(int(pPr["outlineLvl"]) - 1, 9) if pPr["outlineLvl"] <= 10 else 9))
    if "keepNext" in pPr:
        _get_or_add(pPr_el, "w:keepNext")
    if "widowControl" in pPr:
        _get_or_add(pPr_el, "w:widowControl")


def write_rPr(p, rPr):
    """oplist rPr 整段 applyCharProps（batch_set_paragraph_props 语义）。"""
    for r in p.runs:
        if r._r.find(qn("w:drawing")) is not None:
            continue
        if "sz" in rPr:
            r.font.size = Pt(float(rPr["sz"]))
        if "b" in rPr:
            r.font.bold = bool(rPr["b"])
        if "i" in rPr:
            r.font.italic = bool(rPr["i"])
        if "color" in rPr:
            from docx.shared import RGBColor
            c = rPr["color"].lstrip("#")
            r.font.color.rgb = RGBColor(int(c[0:2], 16), int(c[2:4], 16), int(c[4:6], 16))
        rf = rPr.get("rFonts")
        if rf:
            if "ascii" in rf:
                r.font.name = rf["ascii"]
            rPr_el = _get_or_add(r._r, "w:rPr")
            rf_el = _get_or_add(rPr_el, "w:rFonts")
            if "eastAsia" in rf:
                rf_el.set(qn("w:eastAsia"), rf["eastAsia"])
            if "ascii" in rf:
                rf_el.set(qn("w:ascii"), rf["ascii"])
            if "hAnsi" in rf:
                rf_el.set(qn("w:hAnsi"), rf["hAnsi"])


def clear_span_props(p):
    """清除段落内 run 直接字符格式，让样式 rPr 完全生效（batch_apply clear_span_props=true）。"""
    for r in p.runs:
        if r._r.find(qn("w:drawing")) is not None:
            continue
        rPr = r._r.find(qn("w:rPr"))
        if rPr is not None:
            r._r.remove(rPr)


def make_style(doc, style_name, pPr, rPr, base="Normal"):
    """import_element_styles：按 oplist 令牌创建命名样式（含 outlineLvl / eastAsia 字体）。"""
    styles = doc.styles
    st = styles[style_name] if style_name in [s.name for s in styles] else styles.add_style(style_name, WD_STYLE_TYPE.PARAGRAPH)
    try:
        st.base_style = styles[base]
    except Exception:
        pass
    st.priority = 90
    # 段落属性
    sp = pPr.get("spacing", {})
    if sp:
        if "before" in sp:
            st.paragraph_format.space_before = Pt(len_to_twips(sp["before"]) / 20)
        if "after" in sp:
            st.paragraph_format.space_after = Pt(len_to_twips(sp["after"]) / 20)
        if "line" in sp:
            val, rule = parse_line(sp["line"])
            if rule == "auto":
                from docx.enum.text import WD_LINE_SPACING
                st.paragraph_format.line_spacing = val / 240.0
            else:
                st.paragraph_format.line_spacing = Pt(val / 20)
    ind = pPr.get("ind", {})
    if "firstLine" in ind:
        n, unit = parse_len(ind["firstLine"])
        if unit == "ch":
            pPr_el = st.element.get_or_add_pPr()
            ind_el = _get_or_add(pPr_el, "w:ind")
            ind_el.set(qn("w:firstLineChars"), str(int(n * 100)))
            ind_el.set(qn("w:firstLine"), str(len_to_twips(ind["firstLine"], 12.0)))
        else:
            st.paragraph_format.first_line_indent = Pt(len_to_twips(ind["firstLine"]) / 20)
    if "hanging" in ind:
        st.paragraph_format.first_line_indent = Pt(-len_to_twips(ind["hanging"]) / 20)
    if "left" in ind:
        st.paragraph_format.left_indent = Pt(len_to_twips(ind["left"]) / 20)
    if "jc" in pPr:
        st.paragraph_format.alignment = {"center": WD_ALIGN_PARAGRAPH.CENTER, "both": WD_ALIGN_PARAGRAPH.JUSTIFY,
                                         "end": WD_ALIGN_PARAGRAPH.RIGHT, "start": WD_ALIGN_PARAGRAPH.LEFT,
                                         "left": WD_ALIGN_PARAGRAPH.LEFT, "right": WD_ALIGN_PARAGRAPH.RIGHT}.get(pPr["jc"])
    pPr_el = st.element.get_or_add_pPr()
    if "outlineLvl" in pPr:
        ol = _get_or_add(pPr_el, "w:outlineLvl")
        ol.set(qn("w:val"), str(min(int(pPr["outlineLvl"]) - 1, 9)))
    if pPr.get("keepNext"):
        _get_or_add(pPr_el, "w:keepNext")
    _get_or_add(pPr_el, "w:widowControl")
    # 字符属性
    f = st.font
    if "sz" in rPr:
        f.size = Pt(float(rPr["sz"]))
    if "b" in rPr:
        f.bold = bool(rPr["b"])
    if "i" in rPr:
        f.italic = bool(rPr["i"])
    if "color" in rPr:
        from docx.shared import RGBColor
        c = rPr["color"].lstrip("#")
        f.color.rgb = RGBColor(int(c[0:2], 16), int(c[2:4], 16), int(c[4:6], 16))
    rf = rPr.get("rFonts", {})
    if rf.get("ascii"):
        f.name = rf["ascii"]
    rPr_el = st.element.get_or_add_rPr()
    rf_el = _get_or_add(rPr_el, "w:rFonts")
    if rf.get("eastAsia"):
        rf_el.set(qn("w:eastAsia"), rf["eastAsia"])
    if rf.get("ascii"):
        rf_el.set(qn("w:ascii"), rf["ascii"])
    if rf.get("hAnsi"):
        rf_el.set(qn("w:hAnsi"), rf["hAnsi"])
    return st


# ---------------------------------------------------------------------------
# 6. 原子操作执行器 —— oplist_exec 复刻（16 op 中的 12 个核心 op）
# ---------------------------------------------------------------------------

class OpExecutor:
    def __init__(self, doc, paras, formatList):
        self.doc = doc
        self.paras = paras
        self.formatList = formatList
        self.applied = []
        self.failed = []

    def _targets(self, tag):
        """formatList tag → 段落实体列表（resolveTag 复刻；表格内段落天然不在 formatList）。"""
        return [self.paras[i] for i in self.formatList.get(tag, [])]

    # —— 结构清理（cleanup-trim.md）——
    def op_cleanup_empty_paragraphs(self):
        n = 0
        for p in list(self.doc.paragraphs):
            if p.text.strip():
                continue
            # 含图片/对象/分页分节符的段保留
            if (p._p.find(".//" + qn("w:drawing")) is not None
                    or p._p.find(".//" + qn("w:pict")) is not None
                    or p._p.find(".//" + qn("w:br")) is not None
                    or p._p.find(".//" + qn("w:sectPr")) is not None
                    or p._p.find(".//" + qn("w:fldChar")) is not None):
                continue
            p._p.getparent().remove(p._p)
            n += 1
        self.applied.append(f"cleanup_empty_paragraphs: 删除空段 {n} 处")

    def op_trim_paragraph_leading_chars(self):
        n = 0
        for p in self.doc.paragraphs:
            if not p.text or not p.text.strip():
                continue
            jc = _jc_of(p)
            if jc in ("center", "end", "right", "distribute"):   # 居中/右对齐段跳过
                continue
            runs = p.runs
            if not runs:
                continue
            first = runs[0]
            stripped = first.text.lstrip(" 　\t")
            if stripped != first.text:
                first.text = stripped
                n += 1
        self.applied.append(f"trim_paragraph_leading_chars: 清段首空白 {n} 处")

    # —— 样式管理（import-element-styles / batch-apply-paragraph-style）——
    def op_import_element_styles(self, element_style_rules):
        for rule in element_style_rules:
            make_style(self.doc, rule.get("style_name") or rule["element"],
                       rule.get("pPr", {}), rule.get("rPr", {}))
        self.applied.append(f"import_element_styles: 写入样式 {len(element_style_rules)} 条")

    def op_batch_apply_paragraph_style(self, rules):
        total = 0
        tag_counts = {}
        for rule in rules:
            tag = rule["source"]["tag"]
            style_name = rule["target"].get("style_name") or rule["target"].get("element", "Normal")
            clear = rule.get("clear_span_props", False)
            for para in self._targets(tag):
                para.p.style = self.doc.styles[style_name]
                if clear:
                    clear_span_props(para.p)
                # clearInlineBeforeApply（beauty-default.yaml）：清直接 jc/ind/spacing，让样式完全生效
                pPr = para.p._p.pPr
                if pPr is not None:
                    for t_ in ("w:jc", "w:ind", "w:spacing"):
                        el = pPr.find(qn(t_))
                        if el is not None:
                            pPr.remove(el)
                total += 1
                tag_counts[tag] = tag_counts.get(tag, 0) + 1
        self.applied.append(f"batch_apply_paragraph_style: 挂接 {total} 段 {tag_counts}")

    # —— strict 直出（batch-set-paragraph-props.md：只写声明字段，不改 pStyle）——
    def op_batch_set_paragraph_props(self, rules):
        total = 0
        for rule in rules:
            for para in self._targets(rule["source"]["tag"]):
                if "pPr" in rule:
                    write_pPr(para.p, rule["pPr"])
                if "rPr" in rule:
                    write_rPr(para.p, rule["rPr"])
                total += 1
        self.applied.append(f"batch_set_paragraph_props: 直出 {total} 段")

    # —— 页面设置（setup-page-setup.md）——
    def op_setup_page_setup(self, sectPr):
        for sec in self.doc.sections:
            sz, mar = sectPr.get("pgSz", {}), sectPr.get("pgMar", {})
            if sz:
                sec.page_width = Twips(len_to_twips(sz.get("w", "595.3pt")))
                sec.page_height = Twips(len_to_twips(sz.get("h", "841.9pt")))
            if mar:
                if "top" in mar:
                    sec.top_margin = Twips(len_to_twips(mar["top"]))
                if "bottom" in mar:
                    sec.bottom_margin = Twips(len_to_twips(mar["bottom"]))
                if "left" in mar:
                    sec.left_margin = Twips(len_to_twips(mar["left"]))
                if "right" in mar:
                    sec.right_margin = Twips(len_to_twips(mar["right"]))
        self.applied.append("setup_page_setup: 纸张/边距已写入全部节")

    # —— 页眉页脚页码（setup-header-footer.md）——
    def op_setup_header_footer(self, spec):
        for sec in self.doc.sections:
            footer = sec.footer
            footer.is_linked_to_previous = False
            fp = footer.paragraphs[0] if footer.paragraphs else footer.add_paragraph()
            for r in list(fp.runs):
                r._r.getparent().remove(r._r)
            fp.alignment = WD_ALIGN_PARAGRAPH.CENTER
            pn = spec.get("pageNumber", {})
            fmt = pn.get("format", "arabic")
            if pn.get("show", True) and fmt == "pageXOfY":
                _add_field_run(fp, None, "第 ")
                _add_field_run(fp, "PAGE")
                _add_field_run(fp, None, " 页 共 ")
                _add_field_run(fp, "NUMPAGES")
                _add_field_run(fp, None, " 页")
            elif pn.get("show", True):
                _add_field_run(fp, fmt.upper() if fmt.startswith("roman") else "PAGE")
            hf_style = self.doc.styles["美化页眉页脚"] if "美化页眉页脚" in [s.name for s in self.doc.styles] else None
            if hf_style is not None:
                fp.style = hf_style
        header = spec.get("headers")
        if header and header.get("default", {}).get("text"):
            for sec in self.doc.sections:
                hp = sec.header.paragraphs[0] if sec.header.paragraphs else sec.header.add_paragraph()
                for r in list(hp.runs):
                    r._r.getparent().remove(r._r)
                hp.add_run(header["default"]["text"])
                hp.alignment = WD_ALIGN_PARAGRAPH.CENTER
        self.applied.append("setup_header_footer: 页脚页码已设置")

    # —— 目录（setup-toc-styles + table-of-contents.md：TOC 域插入）——
    def op_insert_table_of_contents(self, before_paragraph=None, levels=3):
        toc_title_style = "美化目录标题"
        pPr, rPr = {"jc": "center", "spacing": {"before": "12pt", "after": "12pt"}}, \
                   {"sz": 16, "b": True, "rFonts": {"eastAsia": "黑体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}
        make_style(self.doc, toc_title_style, pPr, rPr)
        anchor = before_paragraph if before_paragraph is not None else self.doc.paragraphs[0]
        t_title = anchor.insert_paragraph_before("目  录")
        t_title.style = self.doc.styles[toc_title_style]
        t_field = anchor.insert_paragraph_before("")
        _add_toc_field(t_field, levels)
        self.applied.append(f"insert_table_of_contents: 已插入 TOC 域（{levels} 级）")

    # —— 表格三线表（setup-table-style.md three_line）——
    def op_setup_table_style(self, tblPr):
        n = 0
        for tbl in self.doc.tables:
            tblPr_el = tbl._tbl.tblPr
            borders = OxmlElement("w:tblBorders")
            _set_border(borders, "top", "single", 12)      # 1.5pt（OOXML 边框单位 1/8pt）
            _set_border(borders, "bottom", "single", 12)
            _set_border(borders, "left", "none", 0)
            _set_border(borders, "right", "none", 0)
            _set_border(borders, "insideH", "none", 0)
            _set_border(borders, "insideV", "none", 0)
            old = tblPr_el.find(qn("w:tblBorders"))
            if old is not None:
                tblPr_el.remove(old)
            tblPr_el.append(borders)
            # 表头底线 0.75pt + 表头加粗居中
            if tbl.rows:
                for cell in tbl.rows[0].cells:
                    tcPr = cell._tc.get_or_add_tcPr()
                    tcb = OxmlElement("w:tcBorders")
                    _set_border(tcb, "bottom", "single", 6)
                    old = tcPr.find(qn("w:tcBorders"))
                    if old is not None:
                        tcPr.remove(old)
                    tcPr.append(tcb)
                    for p in cell.paragraphs:
                        p.alignment = WD_ALIGN_PARAGRAPH.CENTER
                        for r in p.runs:
                            r.font.bold = True
            tbl.alignment = WD_TABLE_ALIGNMENT.CENTER
            n += 1
        self.applied.append(f"setup_table_style: 三线表 {n} 张")

    # —— 分页（batch-page-break-before.md）——
    def op_batch_page_break_before(self, rules):
        n = 0
        for rule in rules:
            if rule.get("break") != "page":
                continue
            for para in self._targets(rule["target"]["tag"]):
                pPr_el = para.p._p.get_or_add_pPr()
                if pPr_el.find(qn("w:pageBreakBefore")) is None:
                    pb = OxmlElement("w:pageBreakBefore")
                    pPr_el.append(pb)
                    n += 1
        self.applied.append(f"batch_page_break_before: 段前分页 {n} 处")


def _set_border(parent, edge, style, sz_eighth):
    b = OxmlElement(f"w:{edge}")
    b.set(qn("w:val"), style)
    b.set(qn("w:sz"), str(sz_eighth))
    b.set(qn("w:space"), "0")
    b.set(qn("w:color"), "000000")
    parent.append(b)


def _add_field_run(p, instr=None, text=None):
    r = p.add_run()
    if text is not None:
        r.text = text
        return r
    fld1 = OxmlElement("w:fldChar"); fld1.set(qn("w:fldCharType"), "begin")
    instr_el = OxmlElement("w:instrText"); instr_el.set(qn("xml:space"), "preserve")
    instr_el.text = f" {instr} "
    fld2 = OxmlElement("w:fldChar"); fld2.set(qn("w:fldCharType"), "end")
    r._r.append(fld1); r._r.append(instr_el); r._r.append(fld2)
    return r


def _add_toc_field(p, levels):
    r = p.add_run()
    f1 = OxmlElement("w:fldChar"); f1.set(qn("w:fldCharType"), "begin")
    it = OxmlElement("w:instrText"); it.set(qn("xml:space"), "preserve")
    it.text = f' TOC \\o "1-{levels}" \\h \\z \\u '
    sep = OxmlElement("w:fldChar"); sep.set(qn("w:fldCharType"), "separate")
    t = OxmlElement("w:t"); t.text = "（在 Word/WPS 中按 Ctrl+A → F9 更新目录域）"
    f2 = OxmlElement("w:fldChar"); f2.set(qn("w:fldCharType"), "end")
    for el in (f1, it, sep, t, f2):
        r._r.append(el)


# ---------------------------------------------------------------------------
# 7. 规划器 —— full / incremental / preset 三路 oplist 编排
# ---------------------------------------------------------------------------

TAG_TO_ROLE = {
    "doc_title": "title", "catalog_h1": "heading-1", "catalog_h2": "heading-2",
    "catalog_h3": "heading-3", "catalog_h4": "heading-4", "catalog_h5": "heading-5",
    "main_text": "body", "addressees": "addressees", "signature": "footer-like",
    "appendix_title": "appendix-title", "table_title": "caption", "image_title": "caption",
    "abs_title": "heading-1", "abs_content": "body", "abs_keywords": "body",
    "ref_title": "heading-1", "ref_list": "body", "ack_title": "heading-1",
}
TAG_OUTLINE = {"doc_title": 10, "catalog_h1": 1, "catalog_h2": 2, "catalog_h3": 3,
               "catalog_h4": 4, "catalog_h5": 5, "main_text": 10, "addressees": 10,
               "signature": 10, "appendix_title": 1, "abs_title": 1, "abs_content": 10,
               "abs_keywords": 10, "ref_title": 1, "ref_list": 10, "ack_title": 1,
               "table_title": 10, "image_title": 10}


def plan_full(doc, paras, formatList, theme_id):
    """full-beauty.md §oplist 编排流程复刻：决策(主题/字号/h1对齐) → 样式表 → 全文挂接。"""
    body = [p for p in paras if not p.in_table]
    all_center, bad_sample = h1_all_center_eligible(body)
    plan = {"mode": "full", "ruleSource": "beauty-default+type-scales",
            "themeAssessment": {"themeId": theme_id, "themeLabel": PALETTES[theme_id]["label"]},
            "scaleAssessment": {"scaleId": PALETTES[theme_id]["scale"],
                                "scaleLabel": TYPE_SCALES[PALETTES[theme_id]["scale"]]["label"]},
            "h1AlignAssessment": {"allCenterEligible": all_center, "badSample": bad_sample}}

    # 默认页字体（Normal 先归位，保证未识别段不被旧默认污染）
    scale = TYPE_SCALES[PALETTES[theme_id]["scale"]]
    normal = merge_role_style("body", theme_id)
    pPr_n, rPr_n = role_to_pPr_rPr(normal, 10)
    element_style_rules = [{"element": "Normal", "style_name": STYLE_NAMES["body"], "pPr": pPr_n, "rPr": rPr_n}]

    apply_rules = [{"source": {"tag": "main_text"}, "target": {"style_name": STYLE_NAMES["body"]},
                    "is_normal": True, "clear_span_props": True}]

    present_tags = set(formatList.keys())
    # 标题族（硬约束 #6：doc_title 与 catalog_h1 样式独立）
    for tag, role in (("doc_title", "title"), ("catalog_h1", "heading-1"), ("catalog_h2", "heading-2"),
                      ("catalog_h3", "heading-3"), ("catalog_h4", "heading-4")):
        if tag not in present_tags:
            continue
        eff_role = role
        if tag == "catalog_h1" and all_center:
            eff_role = "heading-1-center"
        spec = merge_role_style(eff_role, theme_id)
        pPr, rPr = role_to_pPr_rPr(spec, TAG_OUTLINE[tag])
        element_style_rules.append({"element": {"doc_title": "title"}.get(tag, f"heading {tag[-1]}"),
                                    "style_name": STYLE_NAMES[eff_role], "pPr": pPr, "rPr": rPr})
        apply_rules.append({"source": {"tag": tag}, "target": {"style_name": STYLE_NAMES[eff_role]},
                            "is_normal": False, "clear_span_props": True})
    # 次级标签
    for tag, role in (("addressees", "addressees"), ("appendix_title", "appendix-title"),
                      ("abs_title", "heading-1-center"), ("abs_content", "body"), ("abs_keywords", "body"),
                      ("ref_title", "heading-1-center"), ("ack_title", "heading-1-center"),
                      ("table_title", "caption"), ("image_title", "caption")):
        if tag not in present_tags or tag == "main_text":
            continue
        spec = merge_role_style(role, theme_id)
        pPr, rPr = role_to_pPr_rPr(spec, TAG_OUTLINE.get(tag, 10))
        name = STYLE_NAMES.get(role, STYLE_NAMES["body"])
        element_style_rules.append({"element": "Normal", "style_name": name, "pPr": pPr, "rPr": rPr})
        apply_rules.append({"source": {"tag": tag}, "target": {"style_name": name},
                            "is_normal": False, "clear_span_props": True})
    # 参考文献条目：悬挂缩进
    if "ref_list" in present_tags:
        spec = merge_role_style("body", theme_id)
        pPr, rPr = role_to_pPr_rPr(spec, 10)
        pPr["ind"] = {"left": "0pt", "hanging": "24pt"}
        element_style_rules.append({"element": "Normal", "style_name": "美化参考文献", "pPr": pPr, "rPr": rPr})
        apply_rules.append({"source": {"tag": "ref_list"}, "target": {"style_name": "美化参考文献"},
                            "is_normal": True, "clear_span_props": False})
    # 落款两段式（full-beauty.md §落款：首段 footer-like-lead 段前 24pt）
    if "signature" in present_tags:
        for role, style in (("footer-like-lead", "footer-like-lead"), ("footer-like", "footer-like")):
            spec = merge_role_style(role, theme_id)
            if role == "footer-like-lead":
                spec["marginTop"] = "24pt"       # 与正文拉开 ≥2 行（structure-reconciliation §落款）
            pPr, rPr = role_to_pPr_rPr(spec, 10)
            element_style_rules.append({"element": "Normal", "style_name": STYLE_NAMES[style], "pPr": pPr, "rPr": rPr})
        apply_rules.append({"source": {"tag": "signature"}, "target": {"style_name": STYLE_NAMES["footer-like-lead"]},
                            "is_normal": False, "clear_span_props": True})

    plan["oplist"] = [
        {"scope": {}, "action": {"type": "trim_paragraph_leading_chars"}},
        {"scope": {}, "action": {"type": "cleanup_empty_paragraphs"}},
        {"scope": {}, "action": {"type": "import_element_styles", "element_style_rules": element_style_rules}},
        {"scope": {}, "action": {"type": "batch_apply_paragraph_style", "format_rule": {"rules": apply_rules}}},
    ]
    return plan


def plan_incremental(doc, paras, formatList, theme_id):
    """incremental-beauty.md 复刻：baseline（同 role 视觉众数）→ anomaly fixList → 只修异常段。"""
    body = [p for p in paras if not p.in_table]

    def baseline(tag):
        ps = [paras[i] for i in formatList.get(tag, [])]
        sigs = []
        for p in ps:
            sz = max(p.sizes) if p.sizes else None
            sigs.append((round(sz, 1) if sz else None, bool(p.bold), p.east_font))
        if len(ps) < 3 or not sigs:
            return None, None
        (bsz, bb, bf), cnt = Counter(sigs).most_common(1)[0]
        if cnt / len(ps) < 0.5 or bsz is None:
            return None, None
        return (bsz, bb, bf), ps

    fix = {}   # tag -> list[para]
    issues = []
    for tag in ("main_text", "doc_title", "catalog_h1", "catalog_h2", "catalog_h3"):
        base, ps = baseline(tag)
        if base is None:
            continue
        bsz, bb, bf = base
        for p in ps:
            sz = max(p.sizes) if p.sizes else None
            if sz is not None and abs(sz - bsz) >= 1.5:            # fontSize_outlier（≥1.5pt 即异常）
                fix.setdefault(tag, []).append(p)
        # 段首全角空格但 baseline 用 textIndent → indent_outlier
        for p in ps:
            if p.text and p.text[:1] in ("　", " ", "\t") and len(p.text.strip()) > 10:
                fix.setdefault(tag, []).append(p)
    # heading_level_jump / 字号梯度崩塌：h2 ≥ h1
    h1_base, _ = baseline("catalog_h1")
    h2_base, _ = baseline("catalog_h2")
    if h1_base and h2_base and h2_base[0] >= h1_base[0]:
        fix.setdefault("catalog_h2", []).extend([paras[i] for i in formatList.get("catalog_h2", [])])
        issues.append("二级标题字号 ≥ 一级标题（层次倒挂）")
    # 畸态梯度：h1 过大（>20pt）→ 收敛（incremental-beauty.md 检查链建议梯度）
    if h1_base and h1_base[0] > 20:
        fix.setdefault("catalog_h1", []).extend([paras[i] for i in formatList.get("catalog_h1", [])])
        issues.append(f"一级标题 {h1_base[0]}pt 过大，收敛到 14pt 梯度")

    for tag, ps in fix.items():
        issues.append(f"{tag}: {len(set(id(x) for x in ps))} 段偏离基线")
    fix = {t: list(dict.fromkeys(ps)) for t, ps in fix.items() if ps}

    plan = {"mode": "incremental", "ruleSource": "document-baseline", "fixList":
            {t: [p.idx for p in ps] for t, ps in fix.items()},
            "issues": issues}
    oplist = [
        {"scope": {}, "action": {"type": "trim_paragraph_leading_chars"}},
        {"scope": {}, "action": {"type": "cleanup_empty_paragraphs"}},
    ]
    if fix:
        # 标题成对挂接（incremental-beauty.md §标题样式统一：import 与 batch_apply 成对）
        element_rules, apply_rules = [], []
        for tag, ps in fix.items():
            role = TAG_TO_ROLE.get(tag, "body")
            if tag == "main_text":
                name, pPr, rPr = "正文", {"jc": "both", "spacing": {"line": "1.35x", "before": "0pt", "after": "0pt"},
                                           "ind": {"firstLine": "2ch"}, "outlineLvl": 10}, \
                    {"sz": 12, "rFonts": {"eastAsia": "宋体", "ascii": "Times New Roman", "hAnsi": "Times New Roman"}}
            else:
                spec = merge_role_style("heading-1-center" if tag == "catalog_h1" and h1_all_center_eligible(body)[0] else role, "official-black")
                if tag == "catalog_h1" and h1_base and h1_base[0] > 20:
                    pass  # 收敛梯度由 merge_role_style 给出（title 18 / h1 14 / h2 13 / h3 12）
                pPr, rPr = role_to_pPr_rPr(spec, TAG_OUTLINE.get(tag, 10))
                name = STYLE_NAMES.get(role, "美化正文")
            element_rules.append({"element": "Normal", "style_name": name, "pPr": pPr, "rPr": rPr})
            for p in ps:
                apply_rules.append({"source": {"tag": tag, "data_ids": [str(p.idx)]},
                                    "target": {"style_name": name}, "is_normal": tag == "main_text",
                                    "clear_span_props": True})
        oplist += [
            {"scope": {}, "action": {"type": "import_element_styles", "element_style_rules": element_rules}},
            {"scope": {}, "action": {"type": "batch_apply_paragraph_style", "format_rule": {"rules": apply_rules}}},
        ]
    plan["oplist"] = oplist
    return plan


def plan_preset(preset, paras, formatList):
    """品类预设 strict 直出（path-strict-rule.md：batch_set_paragraph_props 单 op 聚合）。

    预设令牌 {tag,pPr,rPr} → op 契约 rules[].source.tag（batch-set-paragraph-props.md）。
    """
    rules = []
    for r in preset["rules"]:
        if r["tag"] in formatList:
            rules.append({"source": {"tag": r["tag"]}, "pPr": r.get("pPr", {}), "rPr": r.get("rPr", {})})
    oplist = [{"scope": {}, "action": {"type": "batch_set_paragraph_props", "format_rule": {"rules": rules}}}]
    if preset.get("sectPr"):
        oplist.append({"scope": {}, "action": {"type": "setup_page_setup", "format_rule": {"sectPr": preset["sectPr"]}}})
    return {"mode": "strict", "ruleSource": f"preset:{preset['label']}", "oplist": oplist,
            "preset": preset}


# ---------------------------------------------------------------------------
# 8. 主流程 + 变更摘要（op-list-summary.md：先问题后方案、from→to 聚合）
# ---------------------------------------------------------------------------

def build_change_summary(before_stats, after_stats, plan, ex: OpExecutor, doc_stats_after):
    lines = []
    lines.append("## 变更摘要\n")
    lines.append(f"**状态**：`applied`　**模式**：{plan['mode']}　**规则来源**：{plan.get('ruleSource','')}\n")
    if plan["mode"] == "full":
        ta, sa = plan["themeAssessment"], plan["scaleAssessment"]
        lines.append(f"**主体风格**：{ta['themeLabel']}（{ta['themeId']}）+ {sa['scaleLabel']}（{sa['scaleId']}）\n")
        if not plan["h1AlignAssessment"]["allCenterEligible"]:
            lines.append(f"**一级标题对齐**：检测到条款式标题「{plan['h1AlignAssessment']['badSample']}」→ 全文 h1 统一左对齐\n")
        else:
            lines.append("**一级标题对齐**：全部无编号或「第x章/节/部分」形态 → 统一居中\n")
    if plan["mode"] == "incremental":
        lines.append("**发现的问题**：" + ("；".join(plan["issues"]) if plan["issues"] else "文档整体规整") + "\n")
    lines.append("\n**发现的问题（改前实测）**：")
    for k, v in before_stats.items():
        lines.append(f"- {k}：{v}")
    lines.append("\n**已执行的变更**：")
    for a in ex.applied:
        lines.append(f"- {a}")
    lines.append("\n**改后实测**：")
    for k, v in doc_stats_after.items():
        lines.append(f"- {k}：{v}")
    return "\n".join(lines)


def _effective_size_font(p):
    """run 级直接格式优先，回落样式链（clear_span_props 后属性落在样式表——实测须读生效值）。"""
    sizes = [s for s in p.sizes if s]
    if sizes:
        return max(sizes), p.east_font
    st, sz, font = p.p.style, None, p.east_font
    seen = set()
    while st is not None and id(st) not in seen:
        seen.add(id(st))
        try:
            if st.font is not None and st.font.size is not None and sz is None:
                sz = st.font.size.pt
        except Exception:
            pass
        rPr = st.element.find(qn("w:rPr")) if st.element is not None else None
        if rPr is not None and font is None:
            rf = rPr.find(qn("w:rFonts"))
            if rf is not None and rf.get(qn("w:eastAsia")):
                font = rf.get(qn("w:eastAsia"))
        st = st.base_style
    return sz, font


def measure(doc, paras, formatList):
    """零造假实测：直接从文档对象测量关键指标（字号/字体取 run 级→样式链的生效值）。"""
    body = [p for p in paras if not p.in_table]
    nonempty = [p for p in body if p.text.strip()]
    empty_n = len(body) - len(nonempty)
    sizes = Counter()
    for p in nonempty:
        sz, _ = _effective_size_font(p)
        if sz:
            sizes[f"{sz:g}pt"] += 1
    space_indent = sum(1 for p in nonempty if p.text[:1] in ("　", " ", "\t"))
    fonts = Counter(((_effective_size_font(p)[1]) or "(默认)") for p in nonempty)
    tags = {t: len(v) for t, v in formatList.items()}
    return {
        "段落数(非空/空)": f"{len(nonempty)}/{empty_n}",
        "字号档位分布": dict(sizes.most_common()),
        "段首空格缩进段数": space_indent,
        "中文字体分布": dict(fonts.most_common(5)),
        "识别标签": tags,
    }


def main(argv=None):
    ap = argparse.ArgumentParser(description="WPS AI排版 复刻件（本地出版级自动排版）")
    ap.add_argument("input")
    ap.add_argument("-o", "--output")
    ap.add_argument("--mode", choices=["auto", "full", "incremental"], default="auto")
    ap.add_argument("--theme", choices=list(PALETTES.keys()), default="official-black")
    ap.add_argument("--preset", choices=["beauty", "official", "thesis", "official-wps", "thesis-wps",
                                         "exam-arts", "exam-science",
                                         "contract", "bid", "contract-public", "bid-public"], default="beauty")
    ap.add_argument("--preset-json", help="外部预设 JSON（from_sample.py 产出，--preset 走 beauty 时亦可叠加）")
    ap.add_argument("--toc", choices=["auto", "on", "off"], default="auto")
    ap.add_argument("--page-numbers", choices=["on", "off"], default="on")
    ap.add_argument("--h1-break", choices=["on", "off"], default="off")
    ap.add_argument("--table-style", choices=["three_line", "off"], default="three_line")
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args(argv)

    src = Path(args.input)
    if not src.exists():
        print(f"输入不存在: {src}", file=sys.stderr)
        return 2
    doc = Document(str(src))
    paras = read_paragraphs(doc)
    body = [p for p in paras if not p.in_table]
    formatList = recognize_structure(paras)
    print(f"[结构识别] {json.dumps({k: len(v) for k, v in formatList.items()}, ensure_ascii=False)}")

    # ---- 规划 ----
    if args.preset_json:
        ext = json.loads(Path(args.preset_json).read_text(encoding="utf-8"))
        plan = plan_preset(ext, paras, formatList)
    elif args.preset != "beauty":
        registry = {"official": (__name__, "PRESET_OFFICIAL"), "thesis": (__name__, "PRESET_THESIS"),
                    "official-wps": ("presets_national", "PRESET_OFFICIAL_WPS"),
                    "thesis-wps": ("presets_national", "PRESET_THESIS_WPS"),
                    "exam-arts": ("presets_exam", "PRESET_EXAM_ARTS"),
                    "exam-science": ("presets_exam", "PRESET_EXAM_SCIENCE"),
                    "contract": ("presets_trade_wps", "PRESET_CONTRACT_WPS"),
                    "bid": ("presets_trade_wps", "PRESET_BID_WPS"),
                    "contract-public": ("presets_trade", "PRESET_CONTRACT"),
                    "bid-public": ("presets_trade", "PRESET_BID")}
        mod_name, attr = registry[args.preset]
        mod = importlib.import_module(mod_name) if mod_name != __name__ else sys.modules[__name__]
        plan = plan_preset(getattr(mod, attr), paras, formatList)
    else:
        mode = args.mode
        if mode == "auto":
            mode, reasons = assess_regularity(body)
            print(f"[规整度评估] → {mode}（{'；'.join(reasons)}）")
        plan = (plan_full if mode == "full" else plan_incremental)(doc, paras, formatList, args.theme)

    before_stats = measure(doc, paras, formatList)

    # ---- 执行（oplist_exec 复刻：单次全量提交）----
    ex = OpExecutor(doc, paras, formatList)
    applied_ops = []
    if args.dry_run:
        print(json.dumps(plan, ensure_ascii=False, indent=2, default=str))
        return 0
    for op in plan["oplist"]:
        t = op["action"]["type"]
        if t == "trim_paragraph_leading_chars":
            ex.op_trim_paragraph_leading_chars()
        elif t == "cleanup_empty_paragraphs":
            ex.op_cleanup_empty_paragraphs()
        elif t == "import_element_styles":
            ex.op_import_element_styles(op["action"]["element_style_rules"])
        elif t == "batch_apply_paragraph_style":
            ex.op_batch_apply_paragraph_style(op["action"]["format_rule"]["rules"])
        elif t == "batch_set_paragraph_props":
            ex.op_batch_set_paragraph_props(op["action"]["format_rule"]["rules"])
        elif t == "setup_page_setup":
            ex.op_setup_page_setup(op["action"]["format_rule"]["sectPr"])
        applied_ops.append(t)

    # preset 附加：页脚页码
    hf = plan.get("preset", {}).get("header_footer") if args.preset != "beauty" else None
    if args.page_numbers == "on":
        ex.op_setup_header_footer((hf or {}).get("footers", {"default": {"mode": "set",
                  "pageNumber": {"show": True, "format": "arabic", "align": "center"}}}).get("default", {}))
    # 目录：auto=有 ≥2 个 h1 时插入（出版级默认件）
    h1_n = len(formatList.get("catalog_h1", []))
    if args.toc == "on" or (args.toc == "auto" and h1_n >= 2):
        first_h1 = next((p for p in body if p.tag == "catalog_h1"), None)
        if first_h1 is not None:
            ex.op_insert_table_of_contents(before_paragraph=first_h1.p)
    if args.h1_break == "on" and h1_n:
        ex.op_batch_page_break_before([{"target": {"tag": "catalog_h1", "kind": "element"}, "break": "page"}])
    if args.table_style == "three_line" and doc.tables:
        ex.op_setup_table_style({"style": "three_line"})

    # ---- 改后实测 + 摘要 ----
    paras2 = read_paragraphs(doc)
    formatList2 = recognize_structure(paras2)
    after_stats = measure(doc, paras2, formatList2)
    summary = build_change_summary(before_stats, after_stats, plan, ex, after_stats)

    out = Path(args.output) if args.output else src.with_name(src.stem + "_排版.docx")
    doc.save(str(out))
    (out.with_suffix(".summary.md")).write_text(summary, encoding="utf-8")
    print(summary)
    print(f"\n[已写出] {out}")
    print(f"[已写出] {out.with_suffix('.summary.md')}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
