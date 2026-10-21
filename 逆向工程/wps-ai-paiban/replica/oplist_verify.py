#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
oplist 参数验证环（独立 CLI 移植件）
====================================

蓝本（evidence/wps-doc-aitypeset/test/verify-spec-oplist/）：
  - summarize_oplist.py（39KB）：TAG_TO_ROLE / STYLE_NAME_TO_ROLE / ROLE_SPEC_MATCHERS /
    USER_SCOPE_TO_ROLE / PARAM_SPEC_HINTS「无中生有」检测 / strict-props 与
    import-batch 双形态 pPr·rPr 解析
  - verify-oplist-workflow.md：三态判定口径（一致 / 不一致 / 无中生有 / 缺失 / MANUAL）

本 CLI 在蓝本「数据压缩 + 人工审读」两步之上，把审读固化为自动比对：

  1. 解析 plan JSON（{"oplist":[...]}、顶层 ops、或顶层数组皆可）
     - strict-props：batch_set_paragraph_props → rules[].source.tag + pPr/rPr
     - import-batch：import_element_styles + batch_apply_paragraph_style（style_name 分流）
     - 同 tag 多 rule 先深合并再展平（对齐蓝本 _deep_merge_dict 语义）
  2. tag → verify role 分组聚合（TAG_TO_ROLE；import-batch 兼容 STYLE_NAME_TO_ROLE）
  3. 对 spec.txt 逐 role 反向匹配格式描述（user-entered 行级 scope / format-content 气泡），
     值级比对覆盖 字号/字体/行距/缩进/对齐/段前后(+加粗/斜体)；
     换算复用同目录 aipaiban.py 的 CN_SIZE_TO_PT / parse_len / PT_PER_UNIT
     （import 失败自动回落本地等价表，保证 stdlib-only 亦可用）
  4. 输出 markdown 对照表：role | oplist 参数 | 规范原文 | 一致/不一致/无中生有/缺失
  5. 退出码：存在「无中生有」→ 1；仅存在「不一致」→ 2；干净 → 0

用法：
  py -3 oplist_verify.py <plan.json> <spec.txt> [-o comparison.md]
"""

from __future__ import annotations

import argparse
import json
import os
import re
import sys
from collections import OrderedDict, defaultdict

REPLICA_DIR = os.path.dirname(os.path.abspath(__file__))

# ---------------------------------------------------------------------------
# 换算层：优先复用 aipaiban.py，失败回落本地等价表（stdlib-only 保底）
# ---------------------------------------------------------------------------

_FALLBACK_CN_SIZE_TO_PT = {  # 与 aipaiban.CN_SIZE_TO_PT / spec-unit-conversion.md 同表
    "初号": 42, "小初": 36, "一号": 26, "小一": 24, "二号": 22, "小二": 18,
    "三号": 16, "小三": 15, "四号": 14, "小四": 12, "五号": 10.5, "小五": 9,
    "六号": 7.5, "七号": 5.5, "八号": 5,
}
_FALLBACK_PT_PER_UNIT = {"pt": 1.0, "cm": 28.3465, "mm": 2.83465, "in": 72.0}


def _fallback_parse_len(v):
    if isinstance(v, (int, float)) and not isinstance(v, bool):
        return float(v), None
    m = re.fullmatch(r"(-?[\d.]+)\s*(pt|cm|mm|in|ch|x)?", str(v).strip())
    if not m:
        raise ValueError(f"无法解析长度: {v!r}")
    return float(m.group(1)), m.group(2)


def _load_converters():
    """尽量复用 aipaiban 的换算；不可用则回落（来源记入报告）。"""
    try:
        if REPLICA_DIR not in sys.path:
            sys.path.insert(0, REPLICA_DIR)
        import aipaiban as _ap
        return dict(_ap.CN_SIZE_TO_PT), _ap.PT_PER_UNIT, _ap.parse_len, "aipaiban"
    except Exception:
        return (dict(_FALLBACK_CN_SIZE_TO_PT), _FALLBACK_PT_PER_UNIT,
                _fallback_parse_len, "builtin-fallback")


CN_SIZE_TO_PT, PT_PER_UNIT, parse_len, CONVERTER_SOURCE = _load_converters()
CN_SIZE_ALT = "|".join(sorted(CN_SIZE_TO_PT.keys(), key=len, reverse=True))

TOL = 0.051  # 浮点等值容差（pt）


# ---------------------------------------------------------------------------
# Role 解析（移植自 summarize_oplist.py：TAG_TO_ROLE / STYLE_NAME_TO_ROLE）
# ---------------------------------------------------------------------------

TAG_TO_ROLE = {
    "doc_title": "paper-title",
    "abs_title": "abstract-title",
    "abs_content": "abstract-body",
    "abs_title_en": "abstract-en-title",
    "abs_content_en": "abstract-en-body",
    "abs_keywords": "keywords",
    "abs_keywords_en": "keywords-en",
    "catalog_title": "toc-title",
    "catalog_h1": "heading-1",
    "catalog_h2": "heading-2",
    "catalog_h3": "heading-3",
    "catalog_h4": "heading-4",
    "main_text": "body",
    "image_title": "caption",
    "table_title": "table-caption",
    "appendix_title": "appendix-title",
    "ref_title": "ref-title",
    "ref_list": "ref-content",
    "ack_title": "ack-title",
    "ack_content": "ack-body",
    "signature": "body",
    "addressee": "body",
    "addressees": "body",
}

STYLE_NAME_TO_ROLE = {
    "_Strict_doc_title": "paper-title",
    "_Strict_abs_title": "abstract-title",
    "_Strict_abs_content": "abstract-body",
    "_Strict_abs_en_title": "abstract-en-title",
    "_Strict_abs_en_content": "abstract-en-body",
    "_Strict_keywords_label": "keywords",
    "_Strict_keywords_body": "keywords",
    "_Strict_keywords_en_label": "keywords-en",
    "_Strict_keywords_en_body": "keywords-en",
    "_Strict_toc_title": "toc-title",
    "_Strict_ref_title": "ref-title",
    "_Strict_ref_entry": "ref-content",
    "_Strict_ack_title": "ack-title",
    "_Strict_ack_body": "ack-body",
    "_Strict_image_title": "caption",
    "_Strict_table_title": "table-caption",
    "_Strict_appendix_title": "appendix-title",
}


def resolve_verify_role(tag: str, style_name: str = "") -> str:
    if style_name and style_name in STYLE_NAME_TO_ROLE:
        return STYLE_NAME_TO_ROLE[style_name]
    return TAG_TO_ROLE.get(tag, tag)


USER_SCOPE_TO_ROLE = [
    (("论文题目", "题名"), "paper-title"),
    (("英文摘要", "Abstract", "ABSTRACT"), "abstract-en-title"),
    (("摘要标题", "摘要"), "abstract-title"),
    (("摘要正文", "摘要内容"), "abstract-body"),
    (("英文关键词", "Key words", "Keywords"), "keywords-en"),
    (("关键词", "关键字"), "keywords"),
    (("目录标题", "目录", "目  录"), "toc-title"),
    (("四级标题", "第四层次"), "heading-4"),
    (("三级标题", "条标题", "第三层次"), "heading-3"),
    (("二级标题", "节标题", "第二层次"), "heading-2"),
    (("一级标题", "章标题", "第一层次"), "heading-1"),
    (("图名", "图注", "图的编号", "图片标题"), "caption"),
    (("表名", "表注", "表序", "表格标题"), "table-caption"),
    (("参考文献标题", "参考文献"), "ref-title"),
    (("参考文献条目", "参考文献内容"), "ref-content"),
    (("致谢标题", "致谢", "谢辞"), "ack-title"),
    (("致谢正文", "致谢内容"), "ack-body"),
    (("附录标题", "附录"), "appendix-title"),
    (("正文", "段落文字", "正文部分", "正文文本"), "body"),
    (("文档标题",), "paper-title"),
]


# ---------------------------------------------------------------------------
# Spec 解析（user-entered 行级 / format-content 气泡；移植自 summarize_oplist.py）
# ---------------------------------------------------------------------------

RE_PAGE_START = re.compile(r"^==\[页码：(\d+)\]开始==$")
RE_PAGE_END = re.compile(r"^==\[页码：(\d+)\]结束==$")
RE_PARA = re.compile(r"^\[段(\d+)\]\s*(.*)")
RE_BUBBLE_SEP = re.compile(r"^---\s*气泡标注\s*---$")
RE_BUBBLE_REF = re.compile(r"^\[气泡(\d+)→段(\d+)\]\s*(.*)")
RE_BUBBLE_FLOAT = re.compile(r"^\[气泡(\d+)\]\s*(.*)")

NON_STYLE_HINTS = (
    "上标", "空1行", "空2行", "空3行", "后间隔", "间隔两行", "间隔三行",
    "字数", "用逗号隔开", "用逗号分隔", "编号与", "之间空2个字符",
    "数学公式", "公式标号", "选填", "页脚", "页眉", "页码", "页边距",
    "重新编号", "按参考文献的格式", "引用参考文献",
)

STYLE_HINTS = (
    "宋体", "黑体", "楷体", "仿宋", "Calibri", "calibri", "Times New Roman",
    "三号", "四号", "小四", "五号", "小五", "号字", "号加粗",
    "行距", "段前", "段后", "居中", "顶左", "两端对齐", "首行缩进", "加粗",
)


def _scope_hint(raw: str) -> str:
    colon_pos = raw.find("：")
    return raw[:colon_pos].strip() if 0 < colon_pos < 24 else ""


def _is_page_level(text: str) -> bool:
    return any(kw in text for kw in ("页边距", "页眉", "页脚", "页码"))


def _has_style_content(raw: str) -> bool:
    return any(h in raw for h in STYLE_HINTS)


def _is_non_style_annotation(raw: str) -> bool:
    if not _has_style_content(raw):
        return True
    if re.match(r"^空\d*行", raw):
        return True
    if any(k in raw for k in (
        "引用参考文献", "按参考文献的格式", "数学公式", "公式标号",
        "选填", "脚注用", "后间隔两行", "后间隔三行", "前后分别间隔",
    )):
        return True
    if "上标" in raw and not any(k in raw for k in ("宋体", "黑体", "三号", "四号", "小四", "五号")):
        return True
    return False


def _make_bubble(ref: str, raw: str, para_text: str, page, user_role_hint: str = "") -> dict:
    is_page = _is_page_level(raw)
    return {
        "ref": ref, "raw": raw, "para_text": para_text, "page": page,
        "scope": _scope_hint(raw), "is_page_level": is_page,
        "is_non_style": is_page or _is_non_style_annotation(raw),
        "user_role_hint": user_role_hint,
    }


def extract_bubbles(spec_path: str) -> list:
    with open(spec_path, "r", encoding="utf-8") as f:
        lines = f.readlines()
    bubbles, para_contents = [], {}
    current_page, in_bubble = None, False
    for line in lines:
        line = line.rstrip("\r\n")
        m = RE_PAGE_START.match(line)
        if m:
            current_page, in_bubble = int(m.group(1)), False
            continue
        if RE_PAGE_END.match(line):
            in_bubble = False
            continue
        if RE_BUBBLE_SEP.match(line):
            in_bubble = True
            continue
        m = RE_PARA.match(line)
        if m and not in_bubble:
            para_contents[int(m.group(1))] = m.group(2).strip()
            continue
        if not in_bubble:
            continue
        m = RE_BUBBLE_REF.match(line)
        if m:
            bubbles.append(_make_bubble(
                f"气泡{m.group(1)}→段{m.group(2)}", m.group(3).strip(),
                para_contents.get(int(m.group(2)), ""), current_page))
            continue
        m = RE_BUBBLE_FLOAT.match(line)
        if m:
            bubbles.append(_make_bubble(
                f"气泡{m.group(1)}（浮动）", m.group(2).strip(), "", current_page))
    return bubbles


def _match_user_scope(line: str):
    colon_pos = -1
    for sep in ("：", ":"):
        pos = line.find(sep)
        if 0 < pos < 32:
            colon_pos = pos
            break
    scope_part = line[:colon_pos].strip() if colon_pos > 0 else line.strip()
    for keywords, role in USER_SCOPE_TO_ROLE:
        if any(kw in scope_part for kw in keywords):
            return scope_part, role
    return scope_part, ""


def extract_user_requirements(spec_path: str) -> list:
    with open(spec_path, "r", encoding="utf-8") as f:
        text = f.read()
    bubbles = []
    for idx, raw_line in enumerate(text.splitlines(), 1):
        line = raw_line.strip()
        if not line or line.startswith("#"):
            continue
        scope, role_hint = _match_user_scope(line)
        b = _make_bubble(f"录入{idx}", line, "", None, role_hint)
        b["scope"] = scope
        bubbles.append(b)
    return bubbles


def detect_spec_input_mode(spec_path: str, plan: dict) -> str:
    meta_fmt = (plan.get("meta") or {}).get("specFormat", "")
    if meta_fmt == "user-entered-format-requirements":
        return "user-entered"
    try:
        with open(spec_path, "r", encoding="utf-8") as f:
            head = f.read(4096)
    except OSError:
        return "user-entered"
    if "--- 气泡标注 ---" in head or RE_BUBBLE_REF.search(head):
        return "format-content"
    if meta_fmt in ("format-content-txt", "plain-spec-txt"):
        return "format-content"
    return "user-entered"


def load_spec_bubbles(spec_path: str, plan: dict):
    mode = detect_spec_input_mode(spec_path, plan)
    if mode == "user-entered":
        return extract_user_requirements(spec_path), mode
    return extract_bubbles(spec_path), mode


# format-content 模式：以 verify role 为主键反向捞气泡（移植 ROLE_SPEC_MATCHERS）

def _para_contains(b, *kws):
    return any(kw in b.get("para_text", "") for kw in kws)


def _scope_is(b, *scopes):
    return b.get("scope", "") in scopes


def _scope_contains(b, *parts):
    return any(p in b.get("scope", "") for p in parts)


def _raw_contains(b, *parts):
    return any(p in b.get("raw", "") for p in parts)


def _raw_excludes(b, *parts):
    return not any(p in b.get("raw", "") for p in parts)


ROLE_SPEC_MATCHERS = {
    "abstract-title": lambda b: (
        _scope_is(b, "摘要") and _raw_excludes(b, "内容", "calibri", "Calibri")
        and _para_contains(b, "摘  要", "摘要")
    ),
    "abstract-body": lambda b: (
        _scope_is(b, "内容") and _raw_excludes(b, "Times New Roman")
    ),
    "abstract-en-title": lambda b: (
        (_scope_contains(b, "摘要") and _raw_contains(b, "calibri", "Calibri"))
        or (_para_contains(b, "Abstract", "ABSTRACT")
            and _raw_contains(b, "calibri", "Calibri", "三号"))
    ),
    "abstract-en-body": lambda b: (
        _scope_contains(b, "内容") and _raw_contains(b, "Times New Roman")
    ),
    "keywords": lambda b: (
        _para_contains(b, "关键词") and _raw_contains(b, "宋体")
        and not re.match(r"^空\d*行", b.get("raw", ""))
    ),
    "keywords-en": lambda b: (
        _para_contains(b, "Key words", "Key Words")
        and _raw_contains(b, "Times New Roman", "小四")
    ),
    "toc-title": lambda b: (
        _scope_contains(b, "标题") and _para_contains(b, "目  录", "目录")
        and _raw_excludes(b, "一级标题", "二级标题")
    ),
    "paper-title": lambda b: _scope_contains(b, "论文题目", "文档标题"),
    "heading-1": lambda b: (
        _scope_contains(b, "一级标题") and _raw_excludes(b, "黑体四号")
        and not _para_contains(b, "目  录")
    ),
    "heading-2": lambda b: _scope_contains(b, "二级标题"),
    "heading-3": lambda b: _scope_contains(b, "三级标题"),
    "heading-4": lambda b: _scope_contains(b, "四级标题", "第四层次"),
    "appendix-title": lambda b: (
        _scope_contains(b, "附录") or _para_contains(b, "附录")
    ),
    "body": lambda b: (
        (_scope_contains(b, "段落文字", "正文部分", "正文宋体")
         or _raw_contains(b, "段落文字", "正文宋体"))
        and not _para_contains(b, "感谢")
    ),
    "caption": lambda b: (
        _scope_contains(b, "图名", "图注", "图的编号")
        or ("图名置于" in b.get("raw", "") and "表名置于" not in b.get("raw", ""))
    ),
    "table-caption": lambda b: (
        _scope_contains(b, "表名", "表注", "表序") or _raw_contains(b, "表名置于")
    ),
    "ref-title": lambda b: (
        _scope_contains(b, "标题") and _para_contains(b, "参考文献")
        and _raw_excludes(b, "上标", "引用参考")
    ),
    "ref-content": lambda b: (
        _scope_contains(b, "参考文献宋体")
        or (_raw_contains(b, "参考文献宋体", "参考文献小四")
            and _raw_excludes(b, "上标", "引用参考", "按参考文献的格式"))
    ),
    "ack-title": lambda b: (
        _scope_contains(b, "标题") and _para_contains(b, "致  谢", "致谢")
    ),
    "ack-body": lambda b: (
        _raw_contains(b, "正文部分") and _para_contains(b, "感谢", "致谢")
    ),
}


def collect_spec_for_roles(roles, bubbles, *, spec_mode="format-content"):
    """对每个 verify role 收集规范要求行。返回 (role到bubbles, 其他标注, 页面级标注)"""
    role_specs = {role: [] for role in roles}
    used_refs = set()
    page_level = [b for b in bubbles if b["is_page_level"]]
    style_bubbles = [b for b in bubbles if not b["is_page_level"] and not b["is_non_style"]]
    non_style = [b for b in bubbles if not b["is_page_level"] and b["is_non_style"]]

    if spec_mode == "user-entered":
        for b in style_bubbles:
            role = b.get("user_role_hint", "")
            if role and role in role_specs:
                role_specs[role].append(b)
                used_refs.add(b["ref"])
        unassigned = [b for b in style_bubbles if b["ref"] not in used_refs]
        return role_specs, non_style + unassigned, page_level

    for role in roles:
        matcher = ROLE_SPEC_MATCHERS.get(role)
        if not matcher:
            continue
        for b in style_bubbles:
            if matcher(b):
                role_specs[role].append(b)
                used_refs.add(b["ref"])
    unassigned = [b for b in style_bubbles if b["ref"] not in used_refs]
    return role_specs, non_style + unassigned, page_level


# ---------------------------------------------------------------------------
# 「无中生有」检测（移植 PARAM_SPEC_HINTS / SPEC_INFERRED_FIELDS）
# ---------------------------------------------------------------------------

PARAM_SPEC_HINTS = {
    "fontFamily": ["宋体", "黑体", "楷体", "仿宋", "Calibri", "calibri",
                   "Times New Roman", "字体"],
    "fontFamily_ascii": ["Times New Roman", "Calibri", "西文", "英文", "字体"],
    "fontSize": ["初号", "小初", "一号", "小一", "二号", "小二", "三号", "小三",
                 "四号", "小四", "五号", "小五", "号字", "pt"],
    "bold": ["加粗"],
    "italic": ["斜体", "倾斜"],
    "textAlign": ["居中", "顶左", "左对齐", "两端对齐", "居左", "右对齐"],
    "lineHeight": ["行距", "单倍", "倍行距", "固定值"],
    "marginTop": ["段前"],
    "marginBottom": ["段后"],
    "textIndent": ["缩进", "顶格", "顶左"],
}

SPEC_INFERRED_FIELDS = [
    ("与中文摘要内容一致", ["textIndent"]),
    ("与中文摘要一致", ["textIndent"]),
]


def _spec_combined_text(spec_bubbles) -> str:
    return " ".join(b.get("raw", "") for b in spec_bubbles)


def detect_unspecified_params(params: dict, spec_bubbles: list) -> list:
    """规范未写明的 (field, value) 即「无中生有」（蓝本原语义，含空spec全标）。"""
    if not spec_bubbles:
        return [(k, v) for k, v in params.items()]
    combined = _spec_combined_text(spec_bubbles)
    covered = set()
    for phrase, fields in SPEC_INFERRED_FIELDS:
        if phrase in combined:
            covered.update(fields)
    for field, hints in PARAM_SPEC_HINTS.items():
        if field not in params:
            continue
        if any(h in combined for h in hints):
            covered.add(field)
    return [(k, v) for k, v in params.items()
            if k in PARAM_SPEC_HINTS and k not in covered]


# ---------------------------------------------------------------------------
# Plan 解析（strict-props / import-batch 双形态；值归一化含单位字符串）
# ---------------------------------------------------------------------------

STRICT_PROPS_OP = "batch_set_paragraph_props"
LEGACY_IMPORT_OP = "import_element_styles"
LEGACY_BATCH_APPLY_OP = "batch_apply_paragraph_style"

JC_TO_CANON = {"start": "left", "left": "left", "end": "right", "right": "right",
               "both": "justify", "center": "center", "distribute": "distribute"}


def _num_pt(v):
    """数字/单位字符串 → pt 浮点。"""
    n, unit = parse_len(v)
    if unit is None or unit == "pt":
        return float(n)
    if unit in PT_PER_UNIT:
        return round(float(n) * PT_PER_UNIT[unit], 3)
    raise ValueError(f"非磅长度: {v!r}")


def _canon_size(v):
    if isinstance(v, str) and v.strip() in CN_SIZE_TO_PT:
        return float(CN_SIZE_TO_PT[v.strip()])
    return float(_num_pt(v))


def _canon_line(v, rule=""):
    """行距归一化。支持 1.5x / 24pt / 24pt+ 字符串与 数字+lineRule 两形态。"""
    s = str(v).strip()
    m = re.fullmatch(r"(-?[\d.]+)\s*x\+?", s)
    if m:
        return ("x", float(m.group(1)))
    if re.search(r"pt|磅", s):
        n, _unit = parse_len(s.replace("磅", "pt"))
        return ("pt", float(n))
    n = float(v)
    rule = str(rule or "").lower()
    if rule == "single":
        return ("x", 1.0)
    if rule in ("auto", "multiple"):
        # OOXML auto：240/行；小于 20 视为倍数直写
        return ("x", round(n / 240.0, 3) if n >= 100 else n)
    # exact/atLeast/未注明：plan JSON 约定数字=磅
    return ("pt", n)


def _canon_indent(v):
    if isinstance(v, str) and re.search(r"ch|字符", v):
        n, _unit = parse_len(re.sub(r"字符", "ch", v))
        return ("ch", float(n))
    return ("pt", float(_num_pt(v)))


def _ppr_rpr_to_flat_params(pPr, rPr):
    """pPr/rPr → 归一化 flat params（值可直接与规范解析值比对）。"""
    params = OrderedDict()
    pPr, rPr = pPr or {}, rPr or {}
    fonts = rPr.get("rFonts") or {}
    ea = fonts.get("eastAsia") or fonts.get("ea") or ""
    ascii_f = fonts.get("ascii") or ""
    if ea:
        params["fontFamily"] = ea
    if ascii_f and ascii_f != ea:
        params["fontFamily_ascii"] = ascii_f
    if "sz" in rPr:
        params["fontSize"] = _canon_size(rPr["sz"])
    if "b" in rPr:
        params["bold"] = bool(rPr["b"])
    if "i" in rPr:
        params["italic"] = bool(rPr["i"])
    jc = pPr.get("jc")
    if jc:
        params["textAlign"] = JC_TO_CANON.get(jc, jc)
    sp = pPr.get("spacing") or {}
    if "before" in sp:
        params["marginTop"] = float(_num_pt(sp["before"]))
    if "after" in sp:
        params["marginBottom"] = float(_num_pt(sp["after"]))
    if "line" in sp:
        params["lineHeight"] = _canon_line(sp["line"], sp.get("lineRule", ""))
    ind = pPr.get("ind") or {}
    if "firstLine" in ind:
        params["textIndent"] = _canon_indent(ind["firstLine"])
    return params


def _deep_merge_dict(base, overlay):
    result = dict(base)
    for k, v in overlay.items():
        if k in result and isinstance(result[k], dict) and isinstance(v, dict):
            result[k] = _deep_merge_dict(result[k], v)
        else:
            result[k] = v
    return result


def _params_key(params: dict) -> str:
    return json.dumps(params, sort_keys=True, ensure_ascii=False, default=str)


def _op_type(op: dict) -> str:
    action = op.get("action")
    if isinstance(action, dict):
        return action.get("type") or op.get("op") or ""
    return op.get("op") or op.get("type") or ""


def _op_action(op: dict) -> dict:
    action = op.get("action")
    return action if isinstance(action, dict) else {}


def extract_ops(plan) -> list:
    """支持 oplist 键、顶层 ops、嵌套 dict、顶层数组四种 plan 载体。"""
    if isinstance(plan, list):
        return [p for p in plan if isinstance(p, dict)]
    if not isinstance(plan, dict):
        return []
    for key in ("oplist", "ops", "op_list", "operations"):
        v = plan.get(key)
        if isinstance(v, list):
            return [p for p in v if isinstance(p, dict)]
        if isinstance(v, dict):
            inner = v.get("ops") or v.get("oplist")
            if isinstance(inner, list):
                return [p for p in inner if isinstance(p, dict)]
    return []


def detect_oplist_format(ops: list) -> str:
    has_strict = has_import = False
    for op in ops:
        t = _op_type(op)
        if t == STRICT_PROPS_OP:
            has_strict = True
        if t in (LEGACY_IMPORT_OP, LEGACY_BATCH_APPLY_OP):
            has_import = True
    if has_strict:
        return "strict-props"
    if has_import:
        return "import-batch"
    return "none"


def _rules_of(action: dict) -> list:
    fr = action.get("format_rule")
    if isinstance(fr, dict) and isinstance(fr.get("rules"), list):
        return fr["rules"]
    if isinstance(action.get("rules"), list):
        return action["rules"]
    return []


def analyze_strict_props(ops: list) -> dict:
    tag_merged, tag_counts = {}, defaultdict(int)
    non_style_ops = defaultdict(int)
    for op in ops:
        action = _op_action(op)
        t = _op_type(op)
        if t == STRICT_PROPS_OP:
            for rule in _rules_of(action):
                if not isinstance(rule, dict):
                    continue
                tag = (rule.get("source") or {}).get("tag", "unknown")
                slot = tag_merged.setdefault(tag, {"pPr": {}, "rPr": {}})
                slot["pPr"] = _deep_merge_dict(slot["pPr"], rule.get("pPr") or {})
                slot["rPr"] = _deep_merge_dict(slot["rPr"], rule.get("rPr") or {})
                tag_counts[tag] += 1
        else:
            non_style_ops[t or "?"] += 1

    summary = OrderedDict()
    for tag in tag_merged:
        role = resolve_verify_role(tag)
        flat = _ppr_rpr_to_flat_params(tag_merged[tag]["pPr"], tag_merged[tag]["rPr"])
        if role in summary:
            info = summary[role]
            if _params_key(flat) != _params_key(info["params"]):
                info["outliers"].append({"tag": tag, "params": flat})
            info["count"] += tag_counts[tag]
            if tag not in info["tags"]:
                info["tags"].append(tag)
        else:
            summary[role] = {"count": tag_counts[tag], "params": flat,
                             "outliers": [], "tags": [tag]}
    for info in summary.values():
        info["consistent"] = not info["outliers"]
    return {"role_summary": summary, "non_style_ops": dict(non_style_ops),
            "total_ops": len(ops), "format": "strict-props"}


def analyze_import_batch(ops: list) -> dict:
    import_rules, batch_rules = {}, []
    non_style_ops = defaultdict(int)
    for op in ops:
        action = _op_action(op)
        t = _op_type(op)
        if t == LEGACY_IMPORT_OP:
            for rule in action.get("element_style_rules") or []:
                if not isinstance(rule, dict):
                    continue
                key = rule.get("style_name") or rule.get("element") or ""
                if key:
                    import_rules[key] = {"pPr": rule.get("pPr") or {},
                                         "rPr": rule.get("rPr") or {}}
        elif t == LEGACY_BATCH_APPLY_OP:
            for rule in _rules_of(action):
                if isinstance(rule, dict):
                    batch_rules.append(rule)
        else:
            non_style_ops[t or "?"] += 1

    summary = OrderedDict()
    for rule in batch_rules:
        tag = (rule.get("source") or {}).get("tag", "unknown")
        target = rule.get("target") or {}
        target_style = target.get("style_name", "")
        import_key = target_style or target.get("element", "")
        entry = import_rules.get(import_key, {})
        flat = _ppr_rpr_to_flat_params(entry.get("pPr"), entry.get("rPr"))
        role = resolve_verify_role(tag, target_style)
        if role in summary:
            info = summary[role]
            if _params_key(flat) != _params_key(info["params"]):
                info["outliers"].append({"tag": tag, "target": import_key, "params": flat})
            info["count"] += 1
        else:
            summary[role] = {"count": 1, "params": flat, "outliers": [],
                             "tags": [tag], "target": import_key,
                             "style_name": target_style}
    for info in summary.values():
        info["consistent"] = not info["outliers"]
    return {"role_summary": summary, "non_style_ops": dict(non_style_ops),
            "total_ops": len(ops), "format": "import-batch"}


def analyze_oplist(ops: list) -> dict:
    fmt = detect_oplist_format(ops)
    if fmt == "strict-props":
        return analyze_strict_props(ops)
    if fmt == "import-batch":
        return analyze_import_batch(ops)
    return {"role_summary": OrderedDict(), "non_style_ops": {},
            "total_ops": len(ops), "format": "none"}


# ---------------------------------------------------------------------------
# 规范文本 → 已写明格式值（字号/字体/行距/缩进/对齐/段前后/加粗/斜体）
# ---------------------------------------------------------------------------

CJK_FONTS = ["仿宋_GB2312", "方正小标宋简体", "华文中宋", "华文仿宋", "微软雅黑",
             "宋体", "黑体", "楷体_GB2312", "楷体", "仿宋", "隶书", "幼圆"]
LATIN_FONTS = ["Times New Roman", "Calibri", "Arial"]
ALIGN_PATTERNS = [("两端对齐", "justify"), ("分散对齐", "distribute"),
                  ("居中", "center"), ("顶左", "left"), ("左对齐", "left"),
                  ("居左", "left"), ("右对齐", "right"), ("居右", "right"),
                  ("左置", "left")]


def parse_spec_values(bubbles: list) -> dict:
    """逐行解析 role 的规范要求 → {field: (canonical_value, 证据短语, ref)}。"""
    values = {}
    for b in bubbles:
        raw = b.get("raw", "")
        t = raw
        found = []

        def take(m):
            found.append(m.group(0))
            return m.group(0)

        # ---- 行距（先于字号，防行距N磅的磅数被误当字号）----
        if re.search(r"单倍行距|单倍行间距", t):
            if "lineHeight" not in values:
                values["lineHeight"] = (("x", 1.0), "单倍行距", b["ref"])
        else:
            m = (re.search(r"(?:行距|行间距)[^0-9]{0,6}(\d+(?:\.\d+)?)\s*(?:磅|pt)", t)
                 or re.search(r"(?:固定值|最小值)\s*(\d+(?:\.\d+)?)\s*(?:磅|pt)", t)
                 or re.search(r"(\d+(?:\.\d+)?)\s*(?:磅|pt)\s*(?:的)?(?:行距|行间距)", t))
            if m:
                if "lineHeight" not in values:
                    values["lineHeight"] = (("pt", float(m.group(1))), take(m), b["ref"])
            else:
                m = re.search(r"(\d+(?:\.\d+)?)\s*倍行距", t)
                if m and "lineHeight" not in values:
                    values["lineHeight"] = (("x", float(m.group(1))), take(m), b["ref"])

        # ---- 段前 / 段后 ----
        m = re.search(r"段前\s*(?:各|为|是)?\s*(\d+(?:\.\d+)?)\s*(?:磅|pt)", t)
        if m and "marginTop" not in values:
            values["marginTop"] = (float(m.group(1)), take(m), b["ref"])
        m = re.search(r"段后\s*(?:各|为|是)?\s*(\d+(?:\.\d+)?)\s*(?:磅|pt)", t)
        if m and "marginBottom" not in values:
            values["marginBottom"] = (float(m.group(1)), take(m), b["ref"])

        # ---- 首行缩进 ----
        m = (re.search(r"首行缩进\s*(\d+(?:\.\d+)?)\s*(?:个)?(?:字符|字)", t)
             or re.search(r"缩进\s*(\d+(?:\.\d+)?)\s*(?:个)?(?:字符|字)", t))
        if m and "textIndent" not in values:
            values["textIndent"] = (("ch", float(m.group(1))), take(m), b["ref"])
        else:
            m = re.search(r"首行缩进\s*(\d+(?:\.\d+)?)\s*(?:磅|pt)", t)
            if m and "textIndent" not in values:
                values["textIndent"] = (("pt", float(m.group(1))), take(m), b["ref"])

        # ---- 对齐（按序，防两端对齐被泛对齐吞掉）----
        for pat, canon in ALIGN_PATTERNS:
            m = re.search(pat, t)
            if m:
                if "textAlign" not in values:
                    values["textAlign"] = (canon, take(m), b["ref"])
                break

        # ---- 加粗 / 斜体（含否定式）----
        if re.search(r"(?:不|无需|没有)加粗", t):
            if "bold" not in values:
                values["bold"] = (False, "不加粗", b["ref"])
        else:
            m = re.search(r"加粗|粗体", t)
            if m and "bold" not in values:
                values["bold"] = (True, take(m), b["ref"])
        m = re.search(r"斜体|倾斜", t)
        if m and "italic" not in values:
            values["italic"] = (True, take(m), b["ref"])

        # ---- 字体 ----
        for name in CJK_FONTS:
            if name in t:
                if "fontFamily" not in values:
                    values["fontFamily"] = (name, name, b["ref"])
                break
        for name in LATIN_FONTS:
            if name in t or name.lower() in t.lower():
                if "fontFamily_ascii" not in values:
                    values["fontFamily_ascii"] = (name, name, b["ref"])
                break

        # ---- 字号（先 CN 字号名；再在剩余文本找裸 N磅/Npt）----
        m = re.search(r"(" + CN_SIZE_ALT + r")", t)
        if m and "fontSize" not in values:
            values["fontSize"] = (float(CN_SIZE_TO_PT[m.group(1)]), take(m), b["ref"])
        else:
            rest = t
            for frag in found:
                rest = rest.replace(frag, "\u0000", 1)
            m = re.search(r"(\d+(?:\.\d+)?)\s*(?:磅|pt)", rest)
            if m and "fontSize" not in values:
                values["fontSize"] = (float(m.group(1)), take(m), b["ref"])
    return values


# ---------------------------------------------------------------------------
# 比对与判定（口径：verify-oplist-workflow.md 三态 + 缺失扩展）
# ---------------------------------------------------------------------------

STATE_MATCH, STATE_MISMATCH = "一致", "不一致"
STATE_FABRICATED, STATE_MISSING = "无中生有", "缺失"
STATE_UNPARSED, STATE_UNCHECKED = "待核（提及未解析）", "不校验（超出范围）"


def _canon_eq(a, b) -> bool:
    if a is None or b is None:
        return False
    if isinstance(a, tuple) and isinstance(b, tuple):
        if a[0] != b[0]:
            return False
        try:
            return abs(float(a[1]) - float(b[1])) <= TOL
        except (TypeError, ValueError):
            return str(a[1]) == str(b[1])
    if isinstance(a, bool) or isinstance(b, bool):
        return bool(a) == bool(b)
    if isinstance(a, (int, float)) and isinstance(b, (int, float)):
        return abs(float(a) - float(b)) <= TOL
    sa = re.sub(r"\s+", "", str(a)).lower()
    sb = re.sub(r"\s+", "", str(b)).lower()
    return sa == sb


def _fmt_val(v) -> str:
    if isinstance(v, tuple):
        kind, n = v
        if kind == "pt":
            return f"{n:g}pt"
        if kind == "x":
            return f"{n:g}倍行距"
        if kind == "ch":
            return f"{n:g}字符"
        return str(v)
    if isinstance(v, bool):
        return "加粗" if v else "不加粗"
    if isinstance(v, float):
        return f"{v:g}pt"
    return str(v)


def _spec_display(field: str, canon) -> str:
    if field == "fontSize" and isinstance(canon, (int, float)):
        for name, pt in CN_SIZE_TO_PT.items():  # 反查中文字号名便于人读
            if abs(pt - float(canon)) <= TOL:
                return f"{name}={canon:g}pt"
        return f"{canon:g}pt"
    return _fmt_val(canon)


FIELD_LABELS = {
    "fontFamily": "中文字体", "fontFamily_ascii": "西文字体", "fontSize": "字号",
    "bold": "加粗", "italic": "斜体", "textAlign": "对齐", "lineHeight": "行距",
    "marginTop": "段前", "marginBottom": "段后", "textIndent": "首行缩进",
}


def compare_role(role: str, info: dict, spec_bubbles: list) -> dict:
    """单 role 三态比对 → rows + verdict。"""
    params = info.get("params") or {}
    spec_vals = parse_spec_values(spec_bubbles) if spec_bubbles else {}
    combined = _spec_combined_text(spec_bubbles)
    covered = set()
    for phrase, fields in SPEC_INFERRED_FIELDS:
        if phrase in combined:
            covered.update(fields)
    for field, hints in PARAM_SPEC_HINTS.items():
        if any(h in combined for h in hints):
            covered.add(field)

    unspecified = {k for k, _v in detect_unspecified_params(params, spec_bubbles)}
    rows = []
    for field, val in params.items():
        if field in spec_vals:
            spec_canon, ev, ref = spec_vals[field]
            state = STATE_MATCH if _canon_eq(val, spec_canon) else STATE_MISMATCH
            spec_disp = _spec_display(field, spec_canon)
            raw_hit = f"「{ev}」（{ref}）"
        elif field in unspecified:
            state = STATE_FABRICATED
            spec_disp = "（未写明）"
            raw_hit = "—"
        elif field in covered:
            state = STATE_UNPARSED
            spec_disp = "（规范有提及，值未解析出）"
            raw_hit = combined[:40] + "…" if len(combined) > 40 else combined
        else:
            state = STATE_UNCHECKED
            spec_disp = "（本环不校验）"
            raw_hit = "—"
        rows.append({"field": field, "oplist_val": _fmt_val(val),
                     "spec_disp": spec_disp, "raw_hit": raw_hit, "state": state})

    for field, (spec_canon, ev, ref) in spec_vals.items():
        if field in params:
            continue
        if field == "bold" and spec_canon is False:
            rows.append({"field": field, "oplist_val": "不加粗（未写 b）",
                         "spec_disp": _spec_display(field, spec_canon),
                         "raw_hit": f"「{ev}」（{ref}）", "state": STATE_MATCH})
            continue
        rows.append({"field": field, "oplist_val": "（oplist 未设置）",
                     "spec_disp": _spec_display(field, spec_canon),
                     "raw_hit": f"「{ev}」（{ref}）", "state": STATE_MISSING})

    states = [r["state"] for r in rows]
    if STATE_MISMATCH in states:
        verdict = STATE_MISMATCH
    elif STATE_FABRICATED in states:
        verdict = STATE_FABRICATED
    elif STATE_MISSING in states:
        verdict = STATE_MISSING
    elif STATE_MATCH in states:
        verdict = STATE_MATCH
    elif states and all(s == STATE_UNPARSED for s in states):
        verdict = STATE_UNPARSED
    elif not params and spec_bubbles:
        verdict = STATE_MISSING
    elif not spec_bubbles and not params:
        verdict = "无样式 op"
    else:
        verdict = "无依据（规范未检索到该 role）"
    return {"rows": rows, "verdict": verdict}


# ---------------------------------------------------------------------------
# Markdown 报告
# ---------------------------------------------------------------------------

def _bubble_line(b: dict) -> str:
    para = f"（段落: {b['para_text'][:24]}）" if b.get("para_text") else ""
    return f"- [{b['ref']}] {b['raw']} {para}".rstrip()


def generate_markdown(report: dict, plan_path: str, spec_path: str) -> str:
    L = []
    L.append("# Oplist 参数验证环对照报告")
    L.append("")
    L.append(f"- **Plan**: `{os.path.basename(plan_path)}` | "
             f"**Spec**: `{os.path.basename(spec_path)}`")
    L.append(f"- **oplist 形态**: `{report['format']}` | "
             f"**spec 输入模式**: `{report['spec_mode']}` | "
             f"**换算来源**: `{report['converter']}`")
    L.append(f"- **verify role 数**: {len(report['roles'])} | "
             f"总 op: {report['total_ops']} | 非格式 op: {report['non_style_ops'] or '无'}")
    L.append("")
    L.append("## 概览（三态统计）")
    L.append("")
    s = report["stats"]
    L.append(f"- **一致**: {s['match']} | **无中生有**: {s['fabricated']}"
             f"（涉 {len(s['fabricated_roles'])} 个 role） | **缺失**: {s['missing']}"
             f" | 另：不一致 {s['mismatch']}、待核 {s['unparsed']}")
    if s["fabricated_roles"]:
        L.append(f"- **无中生有涉及 role**: {', '.join(sorted(s['fabricated_roles']))}")
    if report["inconsistent_roles"]:
        L.append(f"- **内部不一致 role**: {', '.join(report['inconsistent_roles'])}"
                 f"（同 role 不同 tag 参数互异）")
    L.append(f"- **退出码**: {report['exit_code']}"
             + ("（存在无中生有）" if report["exit_code"] == 1 else
                "（仅存在不一致）" if report["exit_code"] == 2 else "（干净）"))
    L.append("")
    L.append("> 判定口径移植 verify-oplist-workflow.md：要求已写明→一致/不一致；"
             "要求未写而 oplist 有→无中生有；要求写了 oplist 没有→缺失。")
    L.append("")
    L.append("## 逐 Role 对照")
    L.append("")
    for role in report["roles"]:
        info = report["role_summary"][role]
        cmp_ = report["role_cmp"][role]
        L.append(f"### {role}")
        L.append("")
        if report["format"] == "strict-props":
            tags = "、".join(f"`{t}`" for t in info.get("tags", []))
            L.append(f"**AI ops**: {info['count']} 条 rule（tag: {tags}，"
                     f"op: `batch_set_paragraph_props`）")
        else:
            L.append(f"**AI ops**: {info['count']} 条（tag: "
                     f"`{info.get('tags', ['?'])[0]}` → target: `{info.get('target', '?')}`，"
                     f"style_name: `{info.get('style_name', '')}`）")
        ok = "OK" if info.get("consistent") else f"存在 {len(info['outliers'])} 条异常"
        L.append(f"**内部一致性**: {ok}")
        specs = report["role_specs"].get(role, [])
        if specs:
            L.append("**规范检索**:")
            for b in specs:
                L.append(_bubble_line(b))
        else:
            L.append("**规范检索**: 未检索到该 role 的段落样式要求")
        L.append("")
        L.append("| 参数 | oplist 值 | 规范要求 | 规范原文命中 | 判定 |")
        L.append("|---|---|---|---|---|")
        for r in cmp_["rows"]:
            label = FIELD_LABELS.get(r["field"], r["field"])
            L.append(f"| {label}（{r['field']}） | {r['oplist_val']} | "
                     f"{r['spec_disp']} | {r['raw_hit']} | {r['state']} |")
        for o in info.get("outliers", []):
            extra = f" target=`{o.get('target', '?')}`" if "target" in o else ""
            L.append(f"- 内部不一致: tag=`{o.get('tag', '?')}`{extra}: "
                     f"{_params_key(o.get('params', {}))}")
        L.append("")
        L.append(f"- **role 判定**: **{cmp_['verdict']}**")
        L.append("")
    return L


def append_summary_tables(L: list, report: dict) -> list:
    L.append("## 汇总对照表（role | oplist 参数 | 规范原文 | 判定）")
    L.append("")
    L.append("| role | oplist 参数 | 规范原文 | 判定 |")
    L.append("|---|---|---|---|")
    for role in report["roles"]:
        specs = report["role_specs"].get(role, [])
        spec_raw = "<br>".join(f"[{b['ref']}] {b['raw']}" for b in specs) or "（未检索到）"
        rows = report["role_cmp"][role]["rows"]
        for r in rows:
            L.append(f"| {role} | {r['field']}={r['oplist_val']} | "
                     f"{spec_raw} | {r['state']} |")
        if not rows:
            L.append(f"| {role} | （无样式参数） | {spec_raw} | 无样式 op |")
    L.append("")
    fab_rows = [(role, r) for role in report["roles"]
                for r in report["role_cmp"][role]["rows"]
                if r["state"] == STATE_FABRICATED]
    L.append("## 无中生有清单")
    L.append("")
    if fab_rows:
        L.append("| role | 字段 | oplist 值 | 说明 |")
        L.append("|---|---|---|---|")
        for role, r in fab_rows:
            L.append(f"| {role} | {r['field']} | {r['oplist_val']} | "
                     f"规范检索结果未写明该属性 |")
    else:
        L.append("（无）")
    L.append("")
    miss_rows = [(role, r) for role in report["roles"]
                 for r in report["role_cmp"][role]["rows"]
                 if r["state"] == STATE_MISSING]
    L.append("## 缺失清单（规范已写、oplist 未设置）")
    L.append("")
    if miss_rows:
        L.append("| role | 字段 | 规范要求 | 规范原文命中 |")
        L.append("|---|---|---|---|")
        for role, r in miss_rows:
            L.append(f"| {role} | {r['field']} | {r['spec_disp']} | {r['raw_hit']} |")
    else:
        L.append("（无）")
    L.append("")
    if report["other_annotations"]:
        L.append("## 其他规范标注（不参与 params 比对）")
        L.append("")
        for b in report["other_annotations"]:
            L.append(_bubble_line(b))
        L.append("")
    if report["page_level"]:
        L.append("## 页面级要求（不参与 params 比对）")
        L.append("")
        for b in report["page_level"]:
            L.append(_bubble_line(b))
        L.append("")
    return L


def render_report(report: dict, plan_path: str, spec_path: str) -> str:
    L = generate_markdown(report, plan_path, spec_path)
    L = append_summary_tables(L, report)
    return "\n".join(L)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def build_report(plan: dict, ops: list, spec_path: str) -> dict:
    analysis = analyze_oplist(ops)
    bubbles, spec_mode = load_spec_bubbles(spec_path, plan)
    roles = list(analysis["role_summary"].keys())
    role_specs, other_ann, page_level = collect_spec_for_roles(
        roles, bubbles, spec_mode=spec_mode)

    role_cmp = OrderedDict()
    stats = {"match": 0, "mismatch": 0, "fabricated": 0, "missing": 0,
             "unparsed": 0, "fabricated_roles": set()}
    for role in roles:
        cmp_ = compare_role(role, analysis["role_summary"][role],
                            role_specs.get(role, []))
        role_cmp[role] = cmp_
        for r in cmp_["rows"]:
            if r["state"] == STATE_MATCH:
                stats["match"] += 1
            elif r["state"] == STATE_MISMATCH:
                stats["mismatch"] += 1
            elif r["state"] == STATE_FABRICATED:
                stats["fabricated"] += 1
                stats["fabricated_roles"].add(role)
            elif r["state"] == STATE_MISSING:
                stats["missing"] += 1
            elif r["state"] == STATE_UNPARSED:
                stats["unparsed"] += 1
    inconsistent = [r for r in roles
                    if not analysis["role_summary"][r].get("consistent")]
    exit_code = 1 if stats["fabricated"] else (2 if stats["mismatch"] else 0)
    return {
        "format": analysis["format"], "spec_mode": spec_mode,
        "converter": CONVERTER_SOURCE, "total_ops": analysis["total_ops"],
        "non_style_ops": analysis["non_style_ops"],
        "role_summary": analysis["role_summary"],
        "roles": roles, "role_specs": role_specs, "role_cmp": role_cmp,
        "other_annotations": other_ann, "page_level": page_level,
        "stats": stats, "inconsistent_roles": inconsistent,
        "exit_code": exit_code,
    }


def main(argv=None) -> int:
    if hasattr(sys.stdout, "reconfigure"):
        try:
            sys.stdout.reconfigure(encoding="utf-8", errors="replace")
        except Exception:
            pass
    parser = argparse.ArgumentParser(
        description="oplist 参数验证环：plan JSON vs spec.txt 三态比对"
                    "（移植自 WPS wps-doc-aitypeset verify-spec-oplist）")
    parser.add_argument("plan", help="AI 生成的 plan/oplist JSON（oplist 键或顶层 ops）")
    parser.add_argument("spec", help="规范 txt（user-entered 原文或 FormatContent 气泡）")
    parser.add_argument("-o", "--output", help="输出 Markdown 路径（缺省打印到 stdout）")
    args = parser.parse_args(argv)

    with open(args.plan, "r", encoding="utf-8") as f:
        plan = json.load(f)
    ops = extract_ops(plan)
    report = build_report(plan, ops, args.spec)
    md = render_report(report, args.plan, args.spec)

    if args.output:
        out = os.path.abspath(args.output)
        parent = os.path.dirname(out)
        if parent:
            os.makedirs(parent, exist_ok=True)
        with open(out, "w", encoding="utf-8") as f:
            f.write(md)
    else:
        print(md)

    s = report["stats"]
    tag = "FAIL" if report["exit_code"] else "OK"
    dest = f" -> {os.path.abspath(args.output)}" if args.output else ""
    print(f"[{tag}] format={report['format']}, spec_mode={report['spec_mode']}, "
          f"roles={len(report['roles'])}, 一致={s['match']}, "
          f"不一致={s['mismatch']}, 无中生有={s['fabricated']}, "
          f"缺失={s['missing']}, exit={report['exit_code']}{dest}")
    return report["exit_code"]


if __name__ == "__main__":
    sys.exit(main())
