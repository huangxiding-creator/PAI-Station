"""
从 AI oplist JSON + 规范/要求文本中提取双栏对照摘要。

核心逻辑（verify role 驱动）：
  1. 读 oplist → 按 verify role 分组提取样式 params
     - 旧形态：setParaStyle/setRunStyle → 按 block role 分组
     - strict 形态：batch_set_paragraph_props → 直接从 rules[].pPr/rPr 提取；
       source.tag → verify role（独立 tag，见 TAG_TO_ROLE）
     - 过渡形态：import_element_styles + batch_apply_paragraph_style（仍兼容）
  2. 读 spec 文本
     - FormatContent txt（meta.specFormat=format-content-txt）：提取气泡标注
     - 用户录入原文（meta.specFormat=user-entered-format-requirements）：按 scope 关键词解析
  3. 对每个 verify role，用 ROLE_SPEC_MATCHERS 反向检索规范/requirements
  4. 输出 Markdown 对照表

用法:
  python test/verify-spec-oplist/summarize_oplist.py <oplist.json> <spec.txt> [-o comparison.md]
"""

import json
import re
import os
import argparse
from collections import defaultdict, OrderedDict
from typing import Callable

# ---------------------------------------------------------------------------
# FormatContent 气泡解析
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
    """纯标注/版式说明，不作为段落样式模板来源。"""
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


def extract_bubbles(spec_path: str) -> list[dict]:
    with open(spec_path, "r", encoding="utf-8") as f:
        lines = f.readlines()

    bubbles: list[dict] = []
    para_contents: dict[int, str] = {}
    current_page: int | None = None
    in_bubble = False

    for line in lines:
        line = line.rstrip("\r\n")

        m = RE_PAGE_START.match(line)
        if m:
            current_page = int(m.group(1))
            in_bubble = False
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
            bubble_id = int(m.group(1))
            target_para = int(m.group(2))
            raw_text = m.group(3).strip()
            bubbles.append(_make_bubble(
                f"气泡{bubble_id}→段{target_para}",
                raw_text,
                para_contents.get(target_para, ""),
                current_page,
            ))
            continue

        m = RE_BUBBLE_FLOAT.match(line)
        if m:
            raw_text = m.group(2).strip()
            bubbles.append(_make_bubble(
                f"气泡{int(m.group(1))}（浮动）",
                raw_text,
                "",
                current_page,
            ))

    return bubbles


def _make_bubble(ref: str, raw: str, para_text: str, page: int | None) -> dict:
    is_page = _is_page_level(raw)
    non_style = is_page or _is_non_style_annotation(raw)
    return {
        "ref": ref,
        "raw": raw,
        "para_text": para_text,
        "page": page,
        "scope": _scope_hint(raw),
        "is_page_level": is_page,
        "is_non_style": non_style,
    }


# ---------------------------------------------------------------------------
# Role → 规范检索规则（以 oplist role 为主键，反向捞气泡）
# ---------------------------------------------------------------------------

def _para_contains(b: dict, *keywords: str) -> bool:
    t = b.get("para_text", "")
    return any(kw in t for kw in keywords)


def _scope_is(b: dict, *scopes: str) -> bool:
    return b.get("scope", "") in scopes


def _scope_contains(b: dict, *parts: str) -> bool:
    s = b.get("scope", "")
    return any(p in s for p in parts)


def _page_in(b: dict, lo: int, hi: int) -> bool:
    p = b.get("page")
    return p is not None and lo <= p <= hi


def _raw_contains(b: dict, *parts: str) -> bool:
    raw = b.get("raw", "")
    return any(p in raw for p in parts)


def _raw_excludes(b: dict, *parts: str) -> bool:
    raw = b.get("raw", "")
    return not any(p in raw for p in parts)


ROLE_SPEC_MATCHERS: dict[str, Callable[[dict], bool]] = {
    "abstract-title": lambda b: (
        _scope_is(b, "摘要")
        and _raw_excludes(b, "内容", "calibri", "Calibri")
        and _para_contains(b, "摘  要", "摘要")
    ),
    "abstract-body": lambda b: (
        _scope_is(b, "内容")
        and _page_in(b, 6, 6)
        and _raw_excludes(b, "Times New Roman")
    ),
    "abstract-en-title": lambda b: (
        (_scope_contains(b, "摘要") and _raw_contains(b, "calibri", "Calibri"))
        or (_para_contains(b, "Abstract", "ABSTRACT") and _raw_contains(b, "calibri", "Calibri", "三号"))
        or (b.get("ref", "").startswith("气泡32"))
    ),
    "abstract-en-body": lambda b: (
        _scope_is(b, "内容")
        and (_raw_contains(b, "Times New Roman") or _page_in(b, 7, 7))
    ),
    "keywords": lambda b: (
        _para_contains(b, "关键词")
        and _raw_contains(b, "宋体")
        and not re.match(r"^空\d*行", b.get("raw", ""))
    ),
    "keywords-en": lambda b: (
        _para_contains(b, "Key words", "Key Words")
        and _raw_contains(b, "Times New Roman", "小四")
    ),
    "toc-title": lambda b: (
        _scope_contains(b, "标题")
        and _para_contains(b, "目  录", "目录")
        and _raw_excludes(b, "一级标题", "二级标题")
    ),
    "paper-title": lambda b: (
        _scope_contains(b, "论文题目")
    ),
    "heading-1": lambda b: (
        _scope_contains(b, "一级标题")
        and _raw_excludes(b, "黑体四号")
        and not _para_contains(b, "目  录")
    ),
    "heading-2": lambda b: _scope_contains(b, "二级标题"),
    "heading-3": lambda b: _scope_contains(b, "三级标题"),
    "heading-4": lambda b: _scope_contains(b, "四级标题", "第四层次"),
    "appendix-title": lambda b: (
        _scope_contains(b, "附录")
        or _para_contains(b, "附录")
    ),
    "body": lambda b: (
        (
            _scope_contains(b, "段落文字", "正文部分", "正文宋体")
            or _raw_contains(b, "段落文字", "正文宋体")
        )
        and not _para_contains(b, "感谢")
    ),
    "caption": lambda b: (
        _scope_contains(b, "图名", "图注", "图的编号")
        or ("图名置于" in b.get("raw", "") and "表名置于" not in b.get("raw", ""))
    ),
    "table-caption": lambda b: (
        _scope_contains(b, "表名", "表注", "表序")
        or _raw_contains(b, "表名置于")
    ),
    "ref-title": lambda b: (
        _scope_contains(b, "标题")
        and _para_contains(b, "参考文献")
        and _raw_excludes(b, "上标", "引用参考")
    ),
    "ref-content": lambda b: (
        _scope_contains(b, "参考文献宋体")
        or (
            _raw_contains(b, "参考文献宋体", "参考文献小四")
            and _raw_excludes(b, "上标", "引用参考", "按参考文献的格式")
        )
    ),
    "ack-title": lambda b: (
        _scope_contains(b, "标题")
        and _para_contains(b, "致  谢", "致谢")
    ),
    "ack-body": lambda b: (
        _raw_contains(b, "正文部分")
        and _para_contains(b, "感谢", "致谢")
    ),
}

# source.tag → verify role（独立 tag 一一映射，对齐 KFormatTags / spec-tag-binding.md）
TAG_TO_ROLE: dict[str, str] = {
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

# 过渡形态 import+batch_apply 的 style_name 分流（strict-props 不使用）
STYLE_NAME_TO_ROLE: dict[str, str] = {
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
    """source.tag → verify role；style_name 仅用于过渡形态 import+batch_apply 兼容。"""
    if style_name and style_name in STYLE_NAME_TO_ROLE:
        return STYLE_NAME_TO_ROLE[style_name]
    return TAG_TO_ROLE.get(tag, tag)


# ---------------------------------------------------------------------------
# 用户录入格式要求解析（非 FormatContent 气泡）
# ---------------------------------------------------------------------------

USER_SCOPE_TO_ROLE: list[tuple[tuple[str, ...], str]] = [
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


def _match_user_scope(line: str) -> tuple[str, str]:
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


def extract_user_requirements(spec_path: str) -> list[dict]:
    """解析用户录入的纯文本格式要求（非 FormatContent 气泡）。"""
    with open(spec_path, "r", encoding="utf-8") as f:
        text = f.read()

    bubbles: list[dict] = []
    for idx, raw_line in enumerate(text.splitlines(), 1):
        line = raw_line.strip()
        if not line or line.startswith("#"):
            continue
        scope, role_hint = _match_user_scope(line)
        is_page = _is_page_level(line)
        bubbles.append({
            "ref": f"录入{idx}",
            "raw": line,
            "para_text": "",
            "page": None,
            "scope": scope,
            "is_page_level": is_page,
            "is_non_style": is_page or _is_non_style_annotation(line),
            "user_role_hint": role_hint,
        })
    return bubbles


def detect_spec_input_mode(spec_path: str, oplist: dict) -> str:
    """返回 spec 输入模式：format-content | user-entered。"""
    meta_fmt = (oplist.get("meta") or {}).get("specFormat", "")
    if meta_fmt == "user-entered-format-requirements":
        return "user-entered"
    with open(spec_path, "r", encoding="utf-8") as f:
        head = f.read(4096)
    if "--- 气泡标注 ---" in head or RE_BUBBLE_REF.search(head):
        return "format-content"
    if meta_fmt in ("format-content-txt", "plain-spec-txt"):
        return "format-content"
    return "user-entered"


def load_spec_bubbles(spec_path: str, oplist: dict) -> tuple[list[dict], str]:
    mode = detect_spec_input_mode(spec_path, oplist)
    if mode == "user-entered":
        return extract_user_requirements(spec_path), mode
    return extract_bubbles(spec_path), mode


def collect_spec_for_roles(
    roles: list[str],
    bubbles: list[dict],
    *,
    spec_mode: str = "format-content",
) -> tuple[dict[str, list[dict]], list[dict], list[dict]]:
    """
    对每个 verify role 收集规范/requirements 中的段落样式要求。
    返回 (role→bubbles, 非样式标注, 页面级标注)
    """
    role_specs: dict[str, list[dict]] = {role: [] for role in roles}
    used_refs: set[str] = set()

    page_level = [b for b in bubbles if b["is_page_level"]]
    style_bubbles = [b for b in bubbles if not b["is_page_level"] and not b["is_non_style"]]
    non_style = [b for b in bubbles if not b["is_page_level"] and b["is_non_style"]]

    if spec_mode == "user-entered":
        for b in style_bubbles:
            role = b.get("user_role_hint", "")
            if role and role in role_specs:
                role_specs[role].append(b)
                used_refs.add(b["ref"])
        unassigned_style = [b for b in style_bubbles if b["ref"] not in used_refs]
        return role_specs, non_style + unassigned_style, page_level

    for role in roles:
        matcher = ROLE_SPEC_MATCHERS.get(role)
        if not matcher:
            continue
        for b in style_bubbles:
            if matcher(b):
                role_specs[role].append(b)
                used_refs.add(b["ref"])

    unassigned_style = [b for b in style_bubbles if b["ref"] not in used_refs]

    return role_specs, non_style + unassigned_style, page_level


# ---------------------------------------------------------------------------
# 「无中生有」检测：oplist params 字段在规范检索结果中无依据
# ---------------------------------------------------------------------------

PARAM_SPEC_HINTS: dict[str, list[str]] = {
    "fontFamily": [
        "宋体", "黑体", "楷体", "仿宋", "Calibri", "calibri", "Times New Roman", "字体",
    ],
    "fontSize": [
        "初号", "小初", "一号", "小一", "二号", "小二", "三号", "小三",
        "四号", "小四", "五号", "小五", "号字", "pt",
    ],
    "bold": ["加粗"],
    "textAlign": ["居中", "顶左", "左对齐", "两端对齐", "居左", "右对齐"],
    "lineHeight": ["行距", "单倍", "倍行距", "固定值"],
    "marginTop": ["段前"],
    "marginBottom": ["段后"],
    "textIndent": ["缩进", "顶格", "顶左"],
}

SPEC_INFERRED_FIELDS: list[tuple[str, list[str]]] = [
    ("与中文摘要内容一致", ["textIndent"]),
    ("与中文摘要一致", ["textIndent"]),
]


def _spec_combined_text(spec_bubbles: list[dict]) -> str:
    return " ".join(b.get("raw", "") for b in spec_bubbles)


def detect_unspecified_params(
    params: dict,
    spec_bubbles: list[dict],
) -> list[tuple[str, object]]:
    """返回规范未写明的 (field, value) 列表，即「无中生有」。"""
    if not spec_bubbles:
        return [(k, v) for k, v in params.items()]

    combined = _spec_combined_text(spec_bubbles)
    covered: set[str] = set()

    for phrase, fields in SPEC_INFERRED_FIELDS:
        if phrase in combined:
            covered.update(fields)

    for field, hints in PARAM_SPEC_HINTS.items():
        if field not in params:
            continue
        if any(h in combined for h in hints):
            covered.add(field)

    return [(k, v) for k, v in params.items() if k in PARAM_SPEC_HINTS and k not in covered]


# ---------------------------------------------------------------------------
# Oplist 分析（支持新旧两种形态）
# ---------------------------------------------------------------------------

STYLE_OPS = {"setParaStyle", "setRunStyle"}
STRICT_PROPS_OP = "batch_set_paragraph_props"
LEGACY_IMPORT_OP = "import_element_styles"
LEGACY_BATCH_APPLY_OP = "batch_apply_paragraph_style"


def _params_key(params: dict) -> str:
    return json.dumps(params, sort_keys=True, ensure_ascii=False)


def _parse_range(data_id: str) -> tuple[int, int] | None:
    m = re.match(r"(\d+)\s*-\s*(\d+)", str(data_id))
    return (int(m.group(1)), int(m.group(2))) if m else None


def _find_block_role(op_data_id: str, blocks: list[dict]) -> str:
    for b in blocks:
        if b["dataId"] == op_data_id:
            return b.get("role", "unknown")
    op_range = _parse_range(op_data_id)
    if not op_range:
        return "unknown"
    op_s, op_e = op_range
    for b in blocks:
        br = _parse_range(b["dataId"])
        if br and br[0] <= op_s and op_e <= br[1]:
            return b.get("role", "unknown")
    return "unknown"


def _deep_merge_dict(base: dict, overlay: dict) -> dict:
    """浅层 dict 递归合并，overlay 覆盖 base（对齐引擎同 tag 合并语义）。"""
    result = dict(base)
    for k, v in overlay.items():
        if k in result and isinstance(result[k], dict) and isinstance(v, dict):
            result[k] = _deep_merge_dict(result[k], v)
        else:
            result[k] = v
    return result


def _ppr_rpr_to_flat_params(pPr: dict, rPr: dict) -> dict:
    """Convert pPr/rPr to flat params dict for comparison."""
    params: dict = {}

    if rPr.get("rFonts"):
        fonts = rPr["rFonts"]
        ea = fonts.get("eastAsia", "")
        ascii_f = fonts.get("ascii", "")
        if ea:
            params["fontFamily"] = ea
        if ascii_f and ascii_f != ea:
            params["fontFamily_ascii"] = ascii_f
    if "sz" in rPr:
        params["fontSize"] = f"{rPr['sz']}pt"
    if rPr.get("b"):
        params["bold"] = True
    if rPr.get("i"):
        params["italic"] = True
    if rPr.get("color"):
        params["color"] = rPr["color"]

    jc_map = {"center": "center", "both": "justify", "start": "left", "end": "right"}
    if pPr.get("jc"):
        params["textAlign"] = jc_map.get(pPr["jc"], pPr["jc"])

    spacing = pPr.get("spacing", {})
    if "before" in spacing:
        params["marginTop"] = f"{spacing['before']}pt"
    if "after" in spacing:
        params["marginBottom"] = f"{spacing['after']}pt"
    if "line" in spacing:
        rule = spacing.get("lineRule", "")
        if rule in ("exact", "atLeast"):
            params["lineHeight"] = spacing["line"]
        elif rule in ("multiple", "auto"):
            params["lineHeight"] = spacing["line"]
        elif rule in ("single",):
            params["lineHeight"] = 1
        else:
            params["lineHeight"] = spacing["line"]

    ind = pPr.get("ind", {})
    if "firstLine" in ind:
        val = ind["firstLine"]
        if isinstance(val, str) and "ch" in val:
            params["textIndent"] = val
        else:
            params["textIndent"] = f"{val}pt"

    return params


def _detect_oplist_format(oplist: dict) -> str:
    """Detect oplist format: strict-props | import-batch | legacy."""
    ops = oplist.get("ops", [])
    has_strict_props = False
    has_import_batch = False
    has_legacy = False
    for op in ops:
        op_type = op.get("op") or op.get("action", {}).get("type", "")
        if op_type in STYLE_OPS:
            has_legacy = True
        if op_type == STRICT_PROPS_OP:
            has_strict_props = True
        if op_type in (LEGACY_IMPORT_OP, LEGACY_BATCH_APPLY_OP):
            has_import_batch = True
    if has_strict_props:
        return "strict-props"
    if has_import_batch:
        return "import-batch"
    if has_legacy:
        return "legacy"
    return "legacy"


def _summarize_by_role(
    tag_entries: list[tuple[str, dict, int]],
    *,
    fmt: str,
) -> OrderedDict:
    """将 (tag, flat_params, rule_count) 列表按 verify role 汇总。"""
    summary = OrderedDict()
    for tag, flat_params, rule_count in tag_entries:
        role = resolve_verify_role(tag)
        if role in summary:
            existing = summary[role]
            if _params_key(flat_params) != _params_key(existing["params"]):
                existing["outliers"].append({
                    "tag": tag,
                    "params": flat_params,
                    "reason": f"tag={tag} has different params from primary",
                })
            existing["count"] += rule_count
            if tag not in existing.get("tags", []):
                existing.setdefault("tags", []).append(tag)
        else:
            summary[role] = {
                "count": rule_count,
                "consistent": True,
                "params": flat_params,
                "outliers": [],
                "sample_reasons": [],
                "tag": tag,
                "tags": [tag],
            }
    for info in summary.values():
        if info["outliers"]:
            info["consistent"] = False
    return summary


def analyze_oplist_strict_props(oplist: dict) -> dict:
    """Analyze strict oplist (batch_set_paragraph_props)."""
    ops = oplist.get("ops", [])
    tag_merged: dict[str, dict] = {}
    tag_counts: dict[str, int] = defaultdict(int)
    non_style_ops: dict[str, int] = defaultdict(int)

    for op in ops:
        action = op.get("action", {})
        op_type = action.get("type", op.get("op", ""))

        if op_type == STRICT_PROPS_OP:
            for rule in action.get("format_rule", {}).get("rules", []):
                tag = rule.get("source", {}).get("tag", "unknown")
                pPr = rule.get("pPr") or {}
                rPr = rule.get("rPr") or {}
                if tag not in tag_merged:
                    tag_merged[tag] = {"pPr": {}, "rPr": {}}
                tag_merged[tag]["pPr"] = _deep_merge_dict(tag_merged[tag]["pPr"], pPr)
                tag_merged[tag]["rPr"] = _deep_merge_dict(tag_merged[tag]["rPr"], rPr)
                tag_counts[tag] += 1
        else:
            non_style_ops[op_type] += 1

    tag_entries = [
        (
            tag,
            _ppr_rpr_to_flat_params(data["pPr"], data["rPr"]),
            tag_counts[tag],
        )
        for tag, data in tag_merged.items()
    ]
    summary = _summarize_by_role(tag_entries, fmt="strict-props")
    style_count = sum(s["count"] for s in summary.values())
    return {
        "role_summary": summary,
        "non_style_ops": dict(non_style_ops),
        "total_ops": len(ops),
        "style_ops_count": style_count,
        "format": "strict-props",
    }


def analyze_oplist_import_batch(oplist: dict) -> dict:
    """Analyze transitional oplist (import_element_styles + batch_apply_paragraph_style)."""
    ops = oplist.get("ops", [])

    import_rules: dict[str, dict] = {}
    batch_rules: list[dict] = []
    non_style_ops: dict[str, int] = defaultdict(int)

    for op in ops:
        action = op.get("action", {})
        op_type = action.get("type", op.get("op", ""))

        if op_type == LEGACY_IMPORT_OP:
            for rule in action.get("element_style_rules", []):
                key = rule.get("style_name") or rule.get("element", "")
                if key:
                    import_rules[key] = {
                        "pPr": rule.get("pPr", {}),
                        "rPr": rule.get("rPr", {}),
                        "element": rule.get("element", ""),
                        "style_name": rule.get("style_name", ""),
                    }
        elif op_type == LEGACY_BATCH_APPLY_OP:
            for rule in action.get("format_rule", {}).get("rules", []):
                batch_rules.append(rule)
        else:
            non_style_ops[op_type] += 1

    summary = OrderedDict()
    for rule in batch_rules:
        tag = rule.get("source", {}).get("tag", "unknown")
        target_element = rule.get("target", {}).get("element", "")
        target_style = rule.get("target", {}).get("style_name", "")
        is_normal = rule.get("is_normal", False)

        import_key = target_style or target_element
        import_entry = import_rules.get(import_key, {})
        flat_params = _ppr_rpr_to_flat_params(
            import_entry.get("pPr", {}),
            import_entry.get("rPr", {}),
        )

        role = resolve_verify_role(tag, target_style)

        if role in summary:
            existing = summary[role]
            if _params_key(flat_params) != _params_key(existing["params"]):
                existing["outliers"].append({
                    "tag": tag,
                    "target": import_key,
                    "params": flat_params,
                    "reason": f"tag={tag} has different params from primary",
                })
            existing["count"] += 1
        else:
            summary[role] = {
                "count": 1,
                "consistent": True,
                "params": flat_params,
                "outliers": [],
                "sample_reasons": [],
                "tag": tag,
                "target": import_key,
                "style_name": target_style,
                "is_normal": is_normal,
            }

    for role, info in summary.items():
        if info["outliers"]:
            info["consistent"] = False

    style_count = sum(s["count"] for s in summary.values())
    return {
        "role_summary": summary,
        "non_style_ops": dict(non_style_ops),
        "total_ops": len(ops),
        "style_ops_count": style_count,
        "format": "import-batch",
    }


def analyze_oplist_legacy(oplist: dict) -> dict:
    """Analyze legacy-format oplist (setParaStyle/setRunStyle)."""
    blocks = oplist.get("structureProfile", {}).get("blocks", [])
    ops = oplist.get("ops", [])

    role_groups: dict[str, list[dict]] = defaultdict(list)
    for op in ops:
        if op.get("op") not in STYLE_OPS:
            continue
        did = op.get("target", {}).get("dataId", "")
        role_groups[_find_block_role(did, blocks)].append(op)

    summary = OrderedDict()
    for role in sorted(role_groups.keys()):
        ops_list = role_groups[role]
        params_variants: dict[str, list[dict]] = defaultdict(list)
        for op in ops_list:
            params_variants[_params_key(op.get("params", {}))].append(op)

        consistent = len(params_variants) == 1
        primary_key = max(params_variants, key=lambda k: len(params_variants[k]))
        primary_params = json.loads(primary_key)

        outliers = []
        if not consistent:
            for key, variant_ops in params_variants.items():
                if key != primary_key:
                    for o in variant_ops:
                        outliers.append({
                            "dataId": o.get("target", {}).get("dataId", ""),
                            "op": o.get("op"),
                            "params": o.get("params", {}),
                            "reason": o.get("reason", ""),
                        })

        summary[role] = {
            "count": len(ops_list),
            "consistent": consistent,
            "params": primary_params,
            "outliers": outliers,
            "sample_reasons": list(OrderedDict.fromkeys(
                o.get("reason", "") for o in ops_list if o.get("reason")
            ))[:3],
        }

    non_style_ops = [op for op in ops if op.get("op") not in STYLE_OPS]
    non_style_summary = defaultdict(int)
    for op in non_style_ops:
        non_style_summary[op.get("op", "?")] += 1

    return {
        "role_summary": summary,
        "non_style_ops": dict(non_style_summary),
        "total_ops": len(ops),
        "style_ops_count": sum(s["count"] for s in summary.values()),
        "format": "legacy",
    }


def analyze_oplist(oplist: dict) -> dict:
    fmt = _detect_oplist_format(oplist)
    if fmt == "strict-props":
        return analyze_oplist_strict_props(oplist)
    if fmt == "import-batch":
        return analyze_oplist_import_batch(oplist)
    return analyze_oplist_legacy(oplist)


# ---------------------------------------------------------------------------
# Markdown 输出
# ---------------------------------------------------------------------------

def _format_params(params: dict) -> str:
    return "\n".join(f"  {k}: {v}" for k, v in params.items())


def _format_bubble_line(b: dict) -> str:
    para_hint = f"（段落: {b['para_text'][:24]}）" if b.get("para_text") else ""
    return f"- [{b['ref']}] {b['raw']} {para_hint}".rstrip()


def generate_markdown(
    oplist_analysis: dict,
    role_specs: dict[str, list[dict]],
    other_annotations: list[dict],
    page_level: list[dict],
    oplist_path: str,
    spec_path: str,
    *,
    spec_mode: str = "format-content",
    oplist_meta: dict | None = None,
) -> str:
    role_summary = oplist_analysis["role_summary"]
    oplist_fmt = oplist_analysis.get("format", "legacy")
    meta_fmt = (oplist_meta or {}).get("specFormat", "")

    spec_label = "用户录入要求" if spec_mode == "user-entered" else "规范 txt"
    lines = [
        "# Op List vs 规范对照摘要",
        "",
        f"- **Oplist**: `{os.path.basename(oplist_path)}`",
        f"- **{spec_label}**: `{os.path.basename(spec_path)}`",
        f"- **oplist 形态**: `{oplist_fmt}`",
    ]
    if meta_fmt:
        lines.append(f"- **meta.specFormat**: `{meta_fmt}`")
    lines.extend([
        f"- **spec 输入模式**: `{spec_mode}`",
        f"- **总 op 数**: {oplist_analysis['total_ops']}（其中格式类 {oplist_analysis['style_ops_count']}）",
        f"- **verify role 数**: {len(role_summary)}",
        "",
        "> 规范侧按 **verify role 反向检索** 段落样式要求；不要求每条要求都归属某个 role。",
        "",
    ])

    if oplist_analysis["non_style_ops"]:
        lines.append("## 非格式类 Op 统计")
        lines.append("")
        for op_name, count in oplist_analysis["non_style_ops"].items():
            lines.append(f"- `{op_name}`: {count} 条")
        lines.append("")

    lines.append("---")
    lines.append("")
    lines.append("## 逐 Role 对照")
    lines.append("")

    for role in sorted(role_summary.keys()):
        rs = role_summary[role]
        specs = role_specs.get(role, [])

        lines.append(f"### {role}")
        lines.append("")

        if oplist_fmt == "strict-props":
            tags = rs.get("tags") or [rs.get("tag", "?")]
            tag_info = "、".join(f"`{t}`" for t in tags)
            lines.append(f"**AI ops**: {rs['count']} 条 rule（tag: {tag_info}，op: `batch_set_paragraph_props`）")
        elif oplist_fmt == "import-batch":
            style_info = rs.get("style_name", "")
            style_part = f", style_name=`{style_info}`" if style_info else ""
            tag_info = f"（tag: `{rs.get('tag', '?')}` → target: `{rs.get('target', '?')}`{style_part}）"
            lines.append(f"**AI ops**: {rs['count']} 条 {tag_info}")
        else:
            lines.append(f"**AI ops**: {rs['count']} 条")

        if rs["consistent"]:
            lines.append("**内部一致性**: OK")
        else:
            lines.append(f"**内部一致性**: 存在 {len(rs['outliers'])} 条异常")
        lines.append("")
        lines.append("**Params 模板**:")
        lines.append("```")
        lines.append(_format_params(rs["params"]))
        lines.append("```")

        if rs.get("sample_reasons"):
            lines.append("")
            lines.append("**op reason 示例**（来自 oplist，非规范原文）:")
            for r in rs["sample_reasons"]:
                lines.append(f"- {r}")

        unspecified = detect_unspecified_params(rs["params"], specs)
        if unspecified:
            lines.append("")
            lines.append("**无中生有**（oplist 有、规范检索结果未写明）:")
            for field, value in unspecified:
                lines.append(f"- `{field}: {value}`")

        if rs["outliers"]:
            lines.append("")
            lines.append("**内部不一致的 op**:")
            for o in rs["outliers"]:
                if oplist_fmt in ("strict-props", "import-batch"):
                    extra = f" target=`{o.get('target', '?')}`" if oplist_fmt == "import-batch" else ""
                    lines.append(
                        f"- tag=`{o.get('tag', '?')}`{extra}: "
                        f"{json.dumps(o.get('params', {}), ensure_ascii=False)}"
                    )
                else:
                    lines.append(f"- `{o['dataId']}` ({o['op']}): {json.dumps(o['params'], ensure_ascii=False)}")
                    if o.get("reason"):
                        lines.append(f"  reason: {o['reason']}")

        lines.append("")
        if specs:
            lines.append("**规范格式要求**（段落样式，按 role 检索）:")
            for b in specs:
                lines.append(_format_bubble_line(b))
        else:
            lines.append("**规范格式要求**: 未检索到专属段落样式气泡（可对照同族 role 或人工补充）")

        lines.append("")
        lines.append("**判定**: `__待 Agent 审读__`")
        lines.append("")
        lines.append("---")
        lines.append("")

    if other_annotations:
        lines.append("## 其他规范标注（非本次 params 比对范围）")
        lines.append("")
        lines.append("以下气泡为版式/标注/内容/封面等要求，不参与 params 逐项比对：")
        lines.append("")
        for b in other_annotations:
            lines.append(_format_bubble_line(b))
        lines.append("")

    if page_level:
        lines.append("## 页面级要求")
        lines.append("")
        for b in page_level:
            lines.append(_format_bubble_line(b))
        lines.append("")

    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description="生成 oplist vs 规范的双栏对照摘要（role 驱动，支持 strict-props / import-batch / legacy）"
    )
    parser.add_argument("oplist", help="AI 生成的 oplist JSON 路径")
    parser.add_argument("spec", help="规范 txt 或用户录入要求 txt 路径")
    parser.add_argument("-o", "--output", help="输出 Markdown 路径（不指定则 stdout）")
    args = parser.parse_args()

    with open(args.oplist, "r", encoding="utf-8") as f:
        oplist = json.load(f)

    bubbles, spec_mode = load_spec_bubbles(args.spec, oplist)
    analysis = analyze_oplist(oplist)
    roles = list(analysis["role_summary"].keys())
    role_specs, other_annotations, page_level = collect_spec_for_roles(
        roles, bubbles, spec_mode=spec_mode
    )
    md = generate_markdown(
        analysis,
        role_specs,
        other_annotations,
        page_level,
        args.oplist,
        args.spec,
        spec_mode=spec_mode,
        oplist_meta=oplist.get("meta"),
    )

    if args.output:
        out = os.path.abspath(args.output)
        os.makedirs(os.path.dirname(out), exist_ok=True)
        with open(out, "w", encoding="utf-8") as f:
            f.write(md)
        matched = sum(len(v) for v in role_specs.values())
        fmt = analysis.get("format", "legacy")
        print(f"[OK] format={fmt}, spec_mode={spec_mode}, {len(roles)} roles, {matched} 条样式要求, {len(other_annotations)} 条其他标注 → {out}")
    else:
        print(md)


if __name__ == "__main__":
    main()
