# -*- coding: utf-8 -*-
"""batch_build — catalog.json → 全量上架产物 (63 SKU).

每 SKU 产出:
  content/full/{sku}.html   (build_full.docx_to_html, 在线阅读用)
  content/full/{sku}.pdf    (存量 PDF 直拷 / work/pdf_gen COM 产物)
  content/sample/{sku}.md   (试读: 一句话定位 + 目录全览 + 第1章开篇片段)
  report.json 条目           (系列/定价/徽章真实口径/intro/audience)
旗舰 R50/CNNC 原地升级 cat/intro 字段, 蓝皮书不动.

用法: python tools/batch_build.py [--dry-run]
"""
from __future__ import annotations

import json
import re
import shutil
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
from build_full import docx_to_html  # noqa: E402

WORK = ROOT / "work"
CATALOG = WORK / "catalog.json"
CONTENT = ROOT / "content"

PROVS = ("云南", "天津", "宁夏", "山东", "浙江", "海南", "湖南", "福建",
         "贵州", "黑龙江", "新疆", "河北", "四川", "青海", "山西", "湖北",
         "辽宁")
ENT_SUF = ["EPC总承包业务经营与管理研究报告", "EPC总承包业务全景洞察报告",
           "EPC总承包业务研究报告", "EPC总承包业务探秘", "EPC业务探秘",
           "EPC经营管理研究报告", "EPC业务经营与管理研究报告",
           "EPC经营与管理研究报告", "EPC业务研究报告"]

LEDE = {
    "ent": "{subj}是怎么干工程总承包的？这份报告把它拆开给你看。",
    "prov": "{prov}的 EPC 市场机会在哪里？未来五年怎么走？",
    "topic": "{title}——工程总承包实战里的要紧问题，这份报告从头到尾拆清楚。",
    "excl": "总包创研院独家研究成稿，市面上找不到第二份。",
}
INTRO = {
    "ent": ("组织底子与股权架构、业务版图与代表项目、设计采购施工怎么咬合、"
            "商务与风控怎么设防——{n} 章体系化拆解，案例与数据说话，"
            "看完能对照自查。"),
    "prov": ("哪些行业在放量、哪些区域有项目、竞争格局怎么样、外来企业怎么进场"
            "——{n} 章逐项拆解，数据说话，看完知道机会在哪、怎么拿。"),
    "topic": ("机制、流程、真实案例与可操作的做法——{n} 章拆解，"
            "把实战里最容易出血的部位一个个讲透。"),
    "excl": ("{n} 章拆解{subj}，{w} 万字成稿，案例与数据说话。"),
}
AUD = {
    "ent": "工程企业战略/市场负责人、总承包公司经营层、行业投资机构",
    "prov": "省内工程企业与建企经营层、准备进场的央国企与民营承包商、行业投资机构",
    "topic": "工程总承包从业者、项目经理与经营层、准备进入该领域的投资机构",
    "excl": "工程企业战略/市场负责人、总承包公司经营层、行业投资机构",
}

# 旗舰原地升级 (intro 从 build_report 硬编码迁入配置)
FLAGSHIP = {
    "R50-SNEI": {
        "cat": "flagship", "cat_name": "旗舰深度", "src_appendix": True,
        "method_note": "每个结论标注来源 · 单一来源的结论会明确提醒 · 每个数字查得到出处",
        "intro_lede": ("想摸清一家头部总承包企业的打法，你自己组织调研，"
                       "要么抽调骨干干几个月，要么花数万元请咨询公司。"
                       "这份报告把这件事做完了——而且比大多数咨询报告更硬："
                       "每个结论踩在几条证据上、证据是官方一手还是转载，全部标明。"),
        "intro": ("研究对象是中国石化集团南京工程有限公司（国内炼化工程 EPC 第一梯队）。"
                  "全文 10 万字级、15 章体系化拆解：股权治理与重组基因、业务版图与战略错位、"
                  "设计主导型五大体系、概算控造价实务、合同履约与分拆模式风险……"
                  "每章末附可操作清单与执行路线——看完能对照自查的那种，不是看完就忘的那种。"),
        "audience": "工程企业战略/市场负责人、总承包公司经营层、行业投资机构",
    },
    "CNNC-EPC": {
        "cat": "flagship", "cat_name": "旗舰深度",
        "method_note": "1,600+ 份原始资料交叉验证 · 52 张分析表格 · 关键结论多源互证",
        "intro_lede": ("核电工程是工程行业皇冠上的明珠——同时考验一家工程企业的"
                       "设计深度、供应链韧性、建造组织与核安全治理。这份报告把"
                       "国内唯一具备核电站全厂一体化总承包能力的工程公司拆开给你看。"),
        "intro": ("研究对象是中国核电工程有限公司（中核工程）——国内唯一具备核电站"
                  "全厂设计、采购、施工、调试一体化总承包能力的工程公司。全文 15.6 万字、"
                  "14 章体系化拆解：多项目矩阵管控、设计龙头机制、核级设备供应链、"
                  "调试移交体系、核电级四控、合同商务与风险管控；第 10-11 章深度复盘"
                  "「华龙一号」全球首堆工程与多项目标杆矩阵，末三章提炼可迁移的方法论。"),
        "audience": ("行业同类企业决策层、业主方与投资方、施工央企与总承包竞争对手、"
                     "工程法律与合同专业人士"),
    },
}


def _subj(title: str, cat: str) -> str:
    t = title.strip("《》?？ ")
    if cat == "ent":
        for suf in ENT_SUF:
            if t.endswith(suf):
                return t[: -len(suf)]
        return t
    if "铁设" in t:
        return "中国铁设"
    return t


def _excerpt(docx: Path, first_ch: str = "", need: int = 560,
             cap: int = 820) -> str:
    """第 1 个正章 (跳过 摘要/目录/前言 类) 之后的正文段落片段.

    双探针: Heading1 样式 或 首章标题文本锚点 (兜底非标样式文档).
    """
    from docx import Document
    doc = Document(str(docx))
    anchor = first_ch[:14] if first_ch else ""
    started, buf, cnt = False, [], 0
    skip = re.compile(r"^(摘要|目录|前言|序言|序|概述|引言|报告说明|编制说明)")
    for p in doc.paragraphs:
        txt = p.text.strip()
        if not txt:
            continue
        st = (p.style.name or "").lower()
        is_h = "heading 1" in st or st == "title" or (
            anchor and txt.startswith(anchor))
        if is_h and len(txt) <= 80:
            if anchor:
                started = txt.startswith(anchor) or (
                    "heading 1" in st and not skip.match(txt))
            else:
                started = not skip.match(txt)
            continue
        if not started:
            continue
        txt = re.sub(r"\[来源[:：][^\]]*\]", "", txt)
        if len(re.findall(r"[一-鿿]", txt)) < 15:      # 跳过短标签行
            continue
        buf.append(txt)
        cnt += len(txt)
        if cnt >= need:
            break
    out, n = [], 0
    for t in buf:
        out.append(t)
        n += len(t)
        if n >= need or n >= cap:
            break
    return "\n\n".join(out)


def _fmt_w(w: int) -> str:
    s = f"{w / 10000:.1f}".rstrip("0").rstrip(".")
    return s or "0.1"


def build_entry(e: dict) -> dict:
    cat, title = e["cat"], e["title"]
    n, w = len(e["chapters"]), e["words"]
    subj = _subj(title, cat)
    prov = next((p for p in PROVS if title.startswith(p) or p in title[:12]), "")
    if cat == "prov":
        lede = LEDE[cat].format(prov=prov)
        subtitle = f"{n} 章拆解{prov}EPC 市场机会与打法 · {_fmt_w(w)} 万字成稿"
    else:
        lede = LEDE[cat].format(title=title.strip("《》"), subj=subj)
        if cat == "ent":
            subtitle = (f"{n} 章拆解{subj}的工程总承包打法 · "
                        f"{_fmt_w(w)} 万字成稿")
        elif cat == "excl":
            subtitle = f"总包创研院独家 · {n} 章 · {_fmt_w(w)} 万字成稿"
        else:
            subtitle = f"{_fmt_w(w)} 万字 · {n} 章实战拆解"
    badges = [{"v": _fmt_w(w), "k": "万字成稿"}, {"v": str(n), "k": "章"}]
    if e["tables"] >= 3:
        badges.append({"v": str(e["tables"]), "k": "张分析表格"})
    if e["pages"] > 0:
        badges.append({"v": str(e["pages"]), "k": "页 PDF"})
    chapters = [{"id": f"ch{i+1}", "title": c, "desc": ""}
                for i, c in enumerate(e["chapters"])]
    return {
        "sku": e["sku"], "cat": cat, "cat_name": e["cat_name"],
        "title": f"《{title.strip('《》')}》", "subtitle": subtitle,
        "price": e["price"], "price_label": f"电子版 ¥{e['price']}",
        "words_wan": int(w / 10000) or 1, "badges": badges,
        "intro_lede": lede, "intro": INTRO[cat].format(
            n=n, subj=subj, w=_fmt_w(w)),
        "audience": AUD[cat],
        "sample_file": f"{e['sku'].lower()}.md",
        "sample_label": "报告目录全览 + 第 1 章开篇片段",
        "chapters": chapters,
    }


def build_sample_md(e: dict, r: dict) -> str:
    n = len(e["chapters"])
    toc = e["chapters"][:40]
    lines = [f"- {c}" for c in toc]
    if n > 40:
        lines.append(f"- ……（其余 {n - 40} 章见完整版目录）")
    facts = [f"{_fmt_w(e['words'])} 万字成稿", f"{n} 章"]
    if e["tables"] >= 3:
        facts.append(f"{e['tables']} 张分析表格")
    if e["pages"] > 0:
        facts.append(f"{e['pages']} 页 PDF")
    excerpt = _excerpt(Path(e["docx"]), e["chapters"][0] if e["chapters"] else "")
    md = f"""# 先看清楚：你买的到底是什么

一句话：**{r['title'].strip('《》')}——{r['intro_lede'][:64]}**

{r['intro']}

这份报告的成色，先看几个真实数字：{' · '.join(facts)}。

# 报告目录（全 {n} 章一览）

{chr(10).join(lines)}

**每一章回答一个要紧的问题——答案在完整版里，这里只给目录。**

# 第 1 章开篇片段

{excerpt}

---

试读到此结束。完整版 {n} 章 · {_fmt_w(e['words'])} 万字 · 不满意按档退款。
"""
    return md


def main(argv: list[str]) -> int:
    dry = "--dry-run" in argv
    cat = json.loads(CATALOG.read_text(encoding="utf-8"))["entries"]
    cfg_path = CONTENT / "report.json"
    cfg = json.loads(cfg_path.read_text(encoding="utf-8"))
    for r in cfg["reports"]:
        if r["sku"] in FLAGSHIP:
            r.update(FLAGSHIP[r["sku"]])
    keep = len(cfg["reports"])
    made, problems = 0, []
    for e in cat:
        r = build_entry(e)
        if dry:
            print(f"[dry] {e['sku']} {r['title'][:24]} {r['subtitle'][:40]}")
            continue
        html = docx_to_html(Path(e["docx"]))
        if len(html) < 10000:
            problems.append(f"{e['sku']}: html 仅 {len(html)}B")
        (CONTENT / "full" / f"{e['sku']}.html").write_text(html,
                                                           encoding="utf-8")
        pdf_src = Path(e["pdf"]) if e["pdf"] else (
            WORK / "pdf_gen" / f"{e['sku']}.pdf")
        if pdf_src.is_file():
            shutil.copyfile(pdf_src, CONTENT / "full" / f"{e['sku']}.pdf")
        else:
            problems.append(f"{e['sku']}: 无 PDF")
        md = build_sample_md(e, r)
        if len(md) < 800:
            problems.append(f"{e['sku']}: 试读过短 {len(md)}B")
        (CONTENT / "sample" / f"{e['sku'].lower()}.md").write_text(
            md, encoding="utf-8")
        if not e["chapters"]:
            problems.append(f"{e['sku']}: 章节为空")
        cfg["reports"] = [x for x in cfg["reports"] if x["sku"] != e["sku"]]
        cfg["reports"].append(r)
        made += 1
    if not dry:
        order = {"flagship": 0, "ent": 1, "prov": 2, "topic": 3, "excl": 4}
        cfg["reports"].sort(key=lambda x: (x.get("coming_soon") and 9
                                           or order.get(x.get("cat"), 5),
                                           x["sku"]))
        cfg_path.write_text(json.dumps(cfg, ensure_ascii=False, indent=1),
                            encoding="utf-8")
        print(f"[build] {made} SKU 产物落地, report.json "
              f"{keep}→{len(cfg['reports'])} 条")
    for p in problems:
        print("[!!]", p)
    return 1 if (problems and not dry) else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
