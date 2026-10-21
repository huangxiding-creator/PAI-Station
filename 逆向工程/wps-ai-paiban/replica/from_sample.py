#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
model_essay（范文仿排）预设提取器 —— WPS AI排版复刻件配套
==========================================================

从范文 docx 提取格式基线，生成与 aipaiban.PRESET_OFFICIAL 同 schema 的预设 JSON，
供主件对目标文档套用（plan_preset → batch_set_paragraph_props strict 直出）。

用法：
  py -3 from_sample.py <范文.docx> -o <preset.json>

链路（识别器不重写，直接复用 aipaiban）：
  read_paragraphs + recognize_structure
  → 每个 tag 取同 role 段落的生效格式众数（plan_incremental baseline 思路，逐属性取众数；
     生效值 = run 直接格式优先，回退段落样式链 / docDefaults）
  → rules[{tag, pPr{jc,spacing,ind,outlineLvl,keepNext}, rPr{sz,b,rFonts}}]
  → sectPr 从范文第一节实测（pgSz→pt / pgMar→cm，带单位字符串，parse_len/parse_line 可回环）

字段语义与 batch_set_paragraph_props 一致：只写声明字段；范文无证据的属性缺省不写
（主件套用时保留目标文档该属性）。header_footer 按范文页脚是否实测到 PAGE 域取 show。
"""
from __future__ import annotations

import argparse
import json
import sys
from collections import Counter
from pathlib import Path

_HERE = Path(__file__).resolve().parent
if str(_HERE) not in sys.path:
    sys.path.insert(0, str(_HERE))

from docx import Document
from docx.enum.section import WD_ORIENT
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.oxml.ns import qn
from docx.shared import Twips

from aipaiban import (TAG_OUTLINE, _eff_bold, _effective_size_font, jc_map,
                      parse_len, parse_line, read_paragraphs, recognize_structure)

# 规则顺序（与 PRESET_OFFICIAL 的 rules 排布对齐；只输出范文里实际出现的 tag）
TAG_ORDER = ["doc_title", "catalog_h1", "catalog_h2", "catalog_h3", "catalog_h4",
             "catalog_h5", "main_text", "addressees", "signature", "abs_title",
             "abs_content", "abs_keywords", "ref_title", "ref_list", "ack_title",
             "appendix_title"]
HEADING_TAGS = {t for t in TAG_ORDER if t.startswith("catalog_h")}
# sectPr 缺属性时的 Word 默认回退（twips）
DEFAULT_MARGIN_TWIPS = {"top": 1440, "bottom": 1440, "left": 1800, "right": 1800}
DEFAULT_PAGE_PT = (612.0, 792.0)
JC_ALLOWED = {"left", "center", "right", "both", "end", "start", "distribute"}


# ---------------------------------------------------------------------------
# 生效值读取 —— run 直接格式优先，回退段落样式链（docDefaults 兜底字体）
# ---------------------------------------------------------------------------

def _style_chain(p):
    """段落样式链（base_style 逐级，防环）。"""
    st, seen = p.p.style, set()
    while st is not None and id(st) not in seen:
        seen.add(id(st))
        yield st
        st = st.base_style


def eff_jc(p):
    """对齐生效值：直接 w:jc → 样式链 w:jc；None=无证据。"""
    if p.jc:
        return jc_map(p.jc)
    for st in _style_chain(p):
        if st.element is None:
            continue
        pPr = st.element.find(qn("w:pPr"))
        jc = pPr.find(qn("w:jc")) if pPr is not None else None
        if jc is not None and jc.get(qn("w:val")):
            return jc_map(jc.get(qn("w:val")))
    return None


def _merged_pPr_attr(p, child_tag, attrs):
    """逐属性取 OOXML 生效值：段直接 pPr → 样式链 pPr（最近定义优先）。"""
    out = {}

    def absorb(el):
        if el is None:
            return
        for key, attr in attrs:
            v = el.get(qn(attr))
            if key not in out and v is not None and v != "":
                out[key] = v

    pPr = p.p._p.pPr
    absorb(pPr.find(qn(child_tag)) if pPr is not None else None)
    for st in _style_chain(p):
        if st.element is None:
            continue
        s_pPr = st.element.find(qn("w:pPr"))
        absorb(s_pPr.find(qn(child_tag)) if s_pPr is not None else None)
    return out


def eff_spacing(p):
    """行距/段前后生效值 → 自描述串（'1.35x'/'24pt'/'24pt+'/'6pt'）。"""
    raw = _merged_pPr_attr(p, "w:spacing", [("before", "w:before"), ("after", "w:after"),
                                            ("line", "w:line"), ("lineRule", "w:lineRule")])
    out = {}
    if "before" in raw:
        out["before"] = f"{int(raw['before']) / 20:g}pt"
    if "after" in raw:
        out["after"] = f"{int(raw['after']) / 20:g}pt"
    if "line" in raw:
        v, rule = int(raw["line"]), raw.get("lineRule", "auto")
        if rule == "auto":
            out["line"] = f"{v / 240:g}x"
        elif rule == "atLeast":
            out["line"] = f"{v / 20:g}pt+"
        else:                                   # exact
            out["line"] = f"{v / 20:g}pt"
    return out


def eff_ind(p):
    """缩进生效值 → ind dict（firstLine 优先 *Chars 字符单位，其次悬挂/左缩进）。"""
    raw = _merged_pPr_attr(p, "w:ind", [("firstLineChars", "w:firstLineChars"),
                                        ("firstLine", "w:firstLine"),
                                        ("hangingChars", "w:hangingChars"),
                                        ("hanging", "w:hanging"),
                                        ("leftChars", "w:leftChars"),
                                        ("left", "w:left")])
    if "firstLineChars" in raw:
        return {"firstLine": f"{int(raw['firstLineChars']) / 100:g}ch"}
    if "firstLine" in raw:
        return {"firstLine": f"{int(raw['firstLine']) / 20:g}pt"}
    if "hangingChars" in raw:
        return {"hanging": f"{int(raw['hangingChars']) / 100:g}ch"}
    if "hanging" in raw:
        return {"hanging": f"{int(raw['hanging']) / 20:g}pt"}
    if "leftChars" in raw:
        return {"left": f"{int(raw['leftChars']) / 100:g}ch"}
    if "left" in raw:
        return {"left": f"{int(raw['left']) / 20:g}pt"}
    return {}


def eff_fonts(doc, p):
    """中西文字体生效值 (eastAsia, ascii, hAnsi)：run rPr → 样式链 → docDefaults。"""
    ea = asc = han = None
    for r in p.p.runs:
        rPr = r._r.rPr
        rf = rPr.find(qn("w:rFonts")) if rPr is not None else None
        if rf is None:
            continue
        ea = rf.get(qn("w:eastAsia")) or ea
        asc = rf.get(qn("w:ascii")) or asc
        han = rf.get(qn("w:hAnsi")) or han
    if ea and asc and han:
        return ea, asc, han
    for st in _style_chain(p):
        if st.element is None:
            continue
        rPr = st.element.find(qn("w:rPr"))
        rf = rPr.find(qn("w:rFonts")) if rPr is not None else None
        if rf is None:
            continue
        ea = ea or rf.get(qn("w:eastAsia"))
        asc = asc or rf.get(qn("w:ascii"))
        han = han or rf.get(qn("w:hAnsi"))
        if ea and asc and han:
            return ea, asc, han
    dd = doc.styles.element.find(qn("w:docDefaults"))
    if dd is not None:
        rp_def = dd.find(qn("w:rPrDefault"))
        rPr = rp_def.find(qn("w:rPr")) if rp_def is not None else None
        rf = rPr.find(qn("w:rFonts")) if rPr is not None else None
        if rf is not None:
            ea = ea or rf.get(qn("w:eastAsia"))
            asc = asc or rf.get(qn("w:ascii"))
            han = han or rf.get(qn("w:hAnsi"))
    return ea, asc, han


def _sig(p):
    """视觉签名（plan_incremental baseline 同构：(字号, 加粗, 中文字体)）。"""
    sz, font = _effective_size_font(p)
    return (round(sz, 1) if sz else None, bool(_eff_bold(p)), font)


def _mode(values):
    """众数；返回 (众数值, 命中数, 有效样本数)，全空 → (None, 0, 0)。"""
    vals = [v for v in values if v is not None]
    if not vals:
        return None, 0, 0
    v, cnt = Counter(vals).most_common(1)[0]
    return v, cnt, len(vals)


def _num(x):
    """18.0 → 18（JSON 干净输出）。"""
    f = float(x)
    return int(f) if f == int(f) else round(f, 2)


# ---------------------------------------------------------------------------
# 规则组装 —— 每 tag 一条 {tag, pPr, rPr}（PRESET_OFFICIAL.rules 元素同构）
# ---------------------------------------------------------------------------

def build_rule(tag, ps, doc):
    n = len(ps)
    sz, sz_cnt, sz_n = _mode([_effective_size_font(p)[0] and round(_effective_size_font(p)[0], 1)
                              for p in ps])
    sz = _num(sz) if sz else None
    bold, b_cnt, b_n = _mode([_eff_bold(p) for p in ps])
    jc, jc_cnt, jc_n = _mode([eff_jc(p) for p in ps])
    ea, ea_cnt, _ = _mode([eff_fonts(doc, p)[0] for p in ps])
    asc, asc_cnt, _ = _mode([eff_fonts(doc, p)[1] for p in ps])
    han, han_cnt, _ = _mode([eff_fonts(doc, p)[2] for p in ps])
    sp = [eff_spacing(p) for p in ps]
    sp_before, sb_cnt, sb_n = _mode([s.get("before") for s in sp])
    sp_after, sa_cnt, sa_n = _mode([s.get("after") for s in sp])
    sp_line, sl_cnt, sl_n = _mode([s.get("line") for s in sp])
    ind, ind_cnt, ind_n = _mode([json.dumps(eff_ind(p), ensure_ascii=False, sort_keys=True) for p in ps])
    ind = json.loads(ind) if ind else {}
    sig, sig_cnt = Counter(_sig(p) for p in ps).most_common(1)[0]

    pPr = {}
    if jc:
        pPr["jc"] = jc
    spacing = {k: v for k, v in (("before", sp_before), ("after", sp_after), ("line", sp_line)) if v}
    if spacing:
        pPr["spacing"] = spacing
    if ind:
        pPr["ind"] = ind
    pPr["outlineLvl"] = TAG_OUTLINE.get(tag, 10)
    if tag in HEADING_TAGS:
        pPr["keepNext"] = True
    rPr = {}
    if sz is not None:
        rPr["sz"] = sz
    rPr["b"] = bool(bold)
    rFonts = {k: v for k, v in (("eastAsia", ea), ("ascii", asc), ("hAnsi", han)) if v}
    if rFonts:
        rPr["rFonts"] = rFonts

    share = {"sz": f"{sz_cnt}/{sz_n}", "b": f"{b_cnt}/{b_n}", "jc": f"{jc_cnt}/{jc_n}",
             "line": f"{sl_cnt}/{sl_n}", "before": f"{sb_cnt}/{sb_n}",
             "after": f"{sa_cnt}/{sa_n}", "ind": f"{ind_cnt}/{ind_n}",
             "eastAsia": f"{ea_cnt}/{n}", "ascii": f"{asc_cnt}/{n}", "hAnsi": f"{han_cnt}/{n}"}
    prov = {"n": n, "sig": list(sig) if sig else None, "sig_share": f"{sig_cnt}/{n}", "share": share}
    return {"tag": tag, "pPr": pPr, "rPr": rPr}, prov


# ---------------------------------------------------------------------------
# sectPr / header_footer 实测
# ---------------------------------------------------------------------------

def read_sectPr(doc):
    """第一节 pgSz(pg) / pgMar(cm) 带单位字符串；缺属性回退 Word 默认。"""
    sec = doc.sections[0]
    w = sec.page_width.pt if sec.page_width is not None else DEFAULT_PAGE_PT[0]
    h = sec.page_height.pt if sec.page_height is not None else DEFAULT_PAGE_PT[1]
    orient = "landscape" if sec.orientation == WD_ORIENT.LANDSCAPE else "portrait"

    def mar(length, key):
        if length is not None:
            cm = length.cm
        else:
            cm = Twips(DEFAULT_MARGIN_TWIPS[key]).cm
        return f"{cm:.3f}".rstrip("0").rstrip(".") + "cm"   # 实测精度：3 位小数去尾零（2.54/3.175cm）

    return {"pgSz": {"w": f"{w:.1f}pt", "h": f"{h:.1f}pt", "orient": orient},
            "pgMar": {"top": mar(sec.top_margin, "top"), "bottom": mar(sec.bottom_margin, "bottom"),
                      "left": mar(sec.left_margin, "left"), "right": mar(sec.right_margin, "right")}}


_FOOT_ALIGN = {WD_ALIGN_PARAGRAPH.CENTER: "center", WD_ALIGN_PARAGRAPH.RIGHT: "right",
               WD_ALIGN_PARAGRAPH.LEFT: "left", WD_ALIGN_PARAGRAPH.JUSTIFY: "both"}


def read_header_footer(doc):
    """范文页脚实测到 PAGE 域 → show True（align 取首个页脚段对齐）。"""
    align = "center"
    has_page = False
    for sec in doc.sections:
        for fp in sec.footer.paragraphs:
            if any("PAGE" in (it.text or "") for it in fp._p.iter(qn("w:instrText"))):
                has_page = True
                align = _FOOT_ALIGN.get(fp.alignment, "center")
                break
        if has_page:
            break
    return {"footers": {"default": {"mode": "set",
                                    "pageNumber": {"show": has_page, "format": "arabic", "align": align}}}}


# ---------------------------------------------------------------------------
# 自检 —— json.load 回读 + schema 齐全 + 单位可被 aipaiban 回环解析
# ---------------------------------------------------------------------------

def validate_preset(path):
    with open(path, encoding="utf-8") as f:
        d = json.load(f)
    problems = []
    for k in ("label", "rules", "sectPr"):
        if k not in d or not d[k]:
            problems.append(f"缺顶层键 {k}")
            return problems
    if not isinstance(d["rules"], list):
        problems.append("rules 不是列表")
        return problems
    try:
        sz, mar = d["sectPr"]["pgSz"], d["sectPr"]["pgMar"]
        for k in ("w", "h", "orient"):
            if k not in sz:
                problems.append(f"pgSz 缺 {k}")
        parse_len(sz["w"])
        parse_len(sz["h"])
        for k in ("top", "bottom", "left", "right"):
            if k not in mar:
                problems.append(f"pgMar 缺 {k}")
            else:
                parse_len(mar[k])
    except (KeyError, ValueError) as e:
        problems.append(f"sectPr 解析失败: {e}")
    for r in d["rules"]:
        tag = r.get("tag", "?")
        if not isinstance(r.get("pPr"), dict) or not isinstance(r.get("rPr"), dict):
            problems.append(f"{tag}: pPr/rPr 结构缺失")
            continue
        pPr, rPr = r["pPr"], r["rPr"]
        try:
            if pPr.get("jc") and pPr["jc"] not in JC_ALLOWED:
                problems.append(f"{tag}: 非法 jc {pPr['jc']}")
            sp = pPr.get("spacing", {})
            for k in ("before", "after"):
                if k in sp:
                    parse_len(sp[k])
            if "line" in sp:
                parse_line(sp["line"])
            for v in pPr.get("ind", {}).values():
                parse_len(v)
            if "sz" in rPr:
                float(rPr["sz"])
        except ValueError as e:
            problems.append(f"{tag}: 单位不可解析 {e}")
        if "outlineLvl" not in pPr:
            problems.append(f"{tag}: 缺 outlineLvl")
    return problems


def _rule_line(r):
    pPr, rPr, sp, ind = r["pPr"], r["rPr"], r["pPr"].get("spacing", {}), r["pPr"].get("ind", {})
    rf = rPr.get("rFonts", {})
    return (f"{r['tag']:<12} sz={rPr.get('sz', '-')} b={rPr.get('b', '-')} "
            f"font={rf.get('eastAsia', '-')}/{rf.get('ascii', '-')} jc={pPr.get('jc', '-')} "
            f"line={sp.get('line', '-')} sp={sp.get('before', '-')}/{sp.get('after', '-')} "
            f"ind={ind or '-'}")


# ---------------------------------------------------------------------------
# 主流程
# ---------------------------------------------------------------------------

def main(argv=None):
    ap = argparse.ArgumentParser(
        description="model_essay 范文仿排：范文 docx → PRESET_OFFICIAL 同 schema 预设 JSON")
    ap.add_argument("input", help="范文 .docx")
    ap.add_argument("-o", "--output", help="输出 preset JSON 路径（默认 <范文名>_preset.json）")
    args = ap.parse_args(argv)

    src = Path(args.input)
    if not src.exists():
        print(f"输入不存在: {src}", file=sys.stderr)
        return 2
    if src.suffix.lower() not in (".docx", ".dotx"):
        print(f"仅支持 .docx/.dotx: {src}", file=sys.stderr)
        return 2

    doc = Document(str(src))
    paras = read_paragraphs(doc)
    formatList = recognize_structure(paras)

    rules, prov = [], {}
    for tag in TAG_ORDER:
        idxs = formatList.get(tag)
        if not idxs:
            continue
        rule, stats = build_rule(tag, [paras[i] for i in idxs], doc)
        rules.append(rule)
        prov[tag] = stats
    if not rules:
        print("[错误] 结构识别未产出任何可提取标签（范文无正文/标题？）", file=sys.stderr)
        return 3

    preset = {
        "label": f"范文仿排 {src.stem}",
        "sectPr": read_sectPr(doc),
        "rules": rules,
        "header_footer": read_header_footer(doc),
        "provenance": {"sample": src.name, "sections": len(doc.sections),
                       "tag_counts": {k: len(v) for k, v in formatList.items()},
                       "baseline": prov},
    }
    out = Path(args.output) if args.output else src.with_name(src.stem + "_preset.json")
    out.write_text(json.dumps(preset, ensure_ascii=False, indent=2), encoding="utf-8")

    print(f"[结构识别] {json.dumps(preset['provenance']['tag_counts'], ensure_ascii=False)}")
    print(f"[sectPr] {json.dumps(preset['sectPr'], ensure_ascii=False)}")
    for r, (tag, pv) in zip(rules, prov.items()):
        print(f"[rule] {_rule_line(r)}   (n={pv['n']}, sig {pv['sig_share']})")
    problems = validate_preset(out)
    if problems:
        print(f"[self-check] FAIL: {'; '.join(problems)}", file=sys.stderr)
        return 4
    print(f"[self-check] PASS json.load 回读 OK：label/rules/sectPr 齐全（{len(rules)} 条规则），"
          f"全部单位串可被 aipaiban.parse_len/parse_line 回环解析")
    print(f"[已写出] {out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
