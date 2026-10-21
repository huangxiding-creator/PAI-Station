#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""从解密真身 docx 提取 WPS 内部真实排版参数（styles.xml 直读，零手填）。"""
import json
import sys
import zipfile
from pathlib import Path

OUT = Path(r"E:\AI-Station\逆向工程\wps-ai-paiban\work\decrypt\out_final")

W = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}"


def parse_styles(docx_path):
    import xml.etree.ElementTree as ET
    with zipfile.ZipFile(docx_path) as z:
        root = ET.fromstring(z.read("word/styles.xml"))
        sect = None
        try:
            doc = ET.fromstring(z.read("word/document.xml"))
            body = doc.find(f"{W}body")
            sectPr = body.find(f"{W}sectPr")
            if sectPr is not None:
                pg = sectPr.find(f"{W}pgSz")
                mar = sectPr.find(f"{W}pgMar")
                tw = lambda v: round(int(v) / 20, 1)
                sect = {
                    "pgSz": {"w_pt": tw(pg.get(f"{W}w")), "h_pt": tw(pg.get(f"{W}h"))},
                    "pgMar_pt": {k: tw(mar.get(f"{W}{k}")) for k in ("top", "bottom", "left", "right")},
                }
        except KeyError:
            pass
        out = {}
        for st in root.findall(f"{W}style"):
            sid = st.get(f"{W}styleId")
            name_el = st.find(f"{W}name")
            name = name_el.get(f"{W}val") if name_el is not None else sid
            pPr, rPr = st.find(f"{W}pPr"), st.find(f"{W}rPr")
            info = {"name": name}
            if rPr is not None:
                rf = rPr.find(f"{W}rFonts")
                if rf is not None:
                    info["eastAsia"] = rf.get(f"{W}eastAsia")
                    info["ascii"] = rf.get(f"{W}ascii")
                sz = rPr.find(f"{W}sz")
                if sz is not None:
                    info["sz_pt"] = int(sz.get(f"{W}val")) / 2
                b = rPr.find(f"{W}b")
                if b is not None and b.get(f"{W}val") != "0":
                    info["bold"] = True
            if pPr is not None:
                jc = pPr.find(f"{W}jc")
                if jc is not None:
                    info["jc"] = jc.get(f"{W}val")
                sp = pPr.find(f"{W}spacing")
                if sp is not None:
                    tw = lambda v: round(int(v) / 20, 1)
                    if sp.get(f"{W}before"):
                        info["before_pt"] = tw(sp.get(f"{W}before"))
                    if sp.get(f"{W}after"):
                        info["after_pt"] = tw(sp.get(f"{W}after"))
                    if sp.get(f"{W}line"):
                        rule = sp.get(f"{W}lineRule", "auto")
                        v = int(sp.get(f"{W}line"))
                        info["line"] = f"{v/240:.2f}x" if rule == "auto" else f"{round(v/20,1)}pt{'' if rule=='exact' else '+'}"
                ind = pPr.find(f"{W}ind")
                if ind is not None:
                    for k, label in (("firstLine", "firstLine_pt"), ("firstLineChars", "firstLine_chars"),
                                     ("leftChars", "left_chars"), ("hangingChars", "hanging_chars")):
                        v = ind.get(f"{W}{k}")
                        if v:
                            info[label] = round(int(v) / (100 if k.endswith("Chars") else 20), 2)
                ol = pPr.find(f"{W}outlineLvl")
                if ol is not None:
                    info["outlineLvl"] = int(ol.get(f"{W}val"))
            if len(info) > 1:
                out[sid] = info
        return {"sectPr": sect, "styles": out}


for name in ("contract", "bid", "official", "nationalstandard", "general", "desc_base"):
    p = OUT / f"{name}.docx"
    if not p.exists():
        continue
    data = parse_styles(p)
    keep = {k: v for k, v in data["styles"].items()
            if any(s in (v.get("name", "") or "").lower() for s in ("heading", "标题", "normal", "正文", "title", "title"))
            or v.get("outlineLvl") is not None}
    print(f"== {name} == sectPr={json.dumps(data['sectPr'], ensure_ascii=False)}")
    for sid, info in keep.items():
        print(f"  {sid:<28} {json.dumps(info, ensure_ascii=False)}")
    (OUT / f"{name}.params.json").write_text(json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")
