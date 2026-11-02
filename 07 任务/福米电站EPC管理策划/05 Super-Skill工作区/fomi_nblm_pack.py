# -*- coding: utf-8 -*-
"""fomi_nblm_pack - FOMI-EPC NBLM 上传包整理器 (Phase 0 总本; 照 caselaw 锚点块模型简化为真源直上).
产出 (workspace/nblm_upload/):
  00_战役总笔记本/  11 源 (8 md 消化件 + 3 原始PDF) ≤50
  NotebookLM指令集.md / 上传清单.md
铁律: 只新增不删除; 幂等(已存在跳过)。
用法: py -X utf8 fomi_nblm_pack.py
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
WS = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划\05 Super-Skill工作区")
DOCKET = WS / "RESEARCH_DOCKET"
UPLOAD = WS / "nblm_upload"
FW = UPLOAD / "00_战役总笔记本"
SRC = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划")

REPORT = "几内亚福米水电站EPC建设管理策划方案"


def jload_dir(d: Path, keys: list) -> list:
    out = []
    for f in sorted(d.glob("*.json")):
        try:
            o = json.loads(f.read_text(encoding="utf-8"))
        except Exception:
            continue
        if not isinstance(o, dict):
            continue
        for k in keys:
            v = o.get(k) or []
            if isinstance(v, list):
                out.extend(str(x) for x in v if str(x).strip())
    return out


def uniq(items: list) -> list:
    seen, out = set(), []
    for x in items:
        if x in seen:
            continue
        seen.add(x)
        out.append(x)
    return out


def md_of(title: str, intro: str, sections: list) -> str:
    parts = [f"# {title}\n\n> {intro}\n"]
    for head, items in sections:
        if not items:
            continue
        parts.append(f"\n## {head}\n")
        parts.extend("- " + x.replace("\n", " ") for x in items)
    return "\n".join(parts) + "\n"


def main() -> int:
    FW.mkdir(parents=True, exist_ok=True)
    manifest = [f"# FOMI-EPC NBLM 上传清单 (Phase 0 总本)\n", ""]

    # ---- md 消化源 (8) ----
    readers = DOCKET / "readers"
    researchers = DOCKET / "researchers"
    deep = DOCKET / "deep"

    c01 = md_of("福米工程事实全集(素材精读提取)",
                "10路精读的可研/施组/附图/运维/莫莫克/兰州/公司件事实, 每条带出处定位",
                [("关键事实", uniq(jload_dir(readers, ["key_facts"]))),
                 ("量化事实", uniq(jload_dir(readers, ["quantitative_facts"]))),
                 ("待决口径(引用前须择源)", uniq(jload_dir(readers, ["gaps"]))[:120])])
    c02 = md_of("对标研究与国别条件全集(外网研究提取)",
                "PMI/IPMA大奖标准/几内亚国别/Fomi国际面/C-PMBOK研究结论, 每条带来源",
                [("核心发现", uniq(jload_dir(researchers, ["key_findings"]))),
                 ("带源事实", uniq(jload_dir(researchers, ["facts_with_source"]))),
                 ("评奖标准图谱", uniq(jload_dir(researchers, ["criteria_map"]))),
                 ("标杆案例", uniq(jload_dir(researchers, ["benchmark_cases"])))])
    c03 = md_of("兰州水源地一手档案深学成果",
                "体系文件/六个用战略/合同成果/论文专利外部评价四路深学的原文证据",
                [("关键事实", uniq(jload_dir(deep, ["key_facts"]))),
                 ("原文金句", uniq(jload_dir(deep, ["evidence_quotes"]))),
                 ("量化事实", uniq(jload_dir(deep, ["quantitative_facts"]))),
                 ("可复用素材", uniq(jload_dir(deep, ["reusable_material"])))])
    mds = [
        ("c01_工程事实全集.md", c01),
        ("c02_对标研究全集.md", c02),
        ("c03_兰州一手档案.md", c03),
    ]
    for name, body in [("c04_S1对标矩阵与目录框架.md", "S1"),
                       ("c05_S2黄河院素材台账.md", "S2"),
                       ("c06_S3读者工程与海外专章.md", "S3")]:
        fp = DOCKET / "synth" / [f for f in ("S1_对标矩阵与目录框架.md",
                                            "S2_黄河院素材台账.md",
                                            "S3_读者工程与海外专章.md")
                                 if f.startswith(name[4:6])][0]
        mds.append((name, fp.read_text(encoding="utf-8")))
    mds.append(("c07_数字基准表.md",
                (DOCKET / "synth" / "数字基准表.md").read_text(encoding="utf-8")))
    summ = []
    for f in sorted((WS / "extracted").glob("*Summary*.txt")):
        summ.append(f.read_text(encoding="utf-8", errors="replace"))
    summ.append((WS / "IDEA_SEED.md").read_text(encoding="utf-8"))
    mds.append(("c08_编制需求与口述纪要.md", "\n\n---\n\n".join(summ)))

    for name, body in mds:
        fp = FW / name
        if not fp.exists():
            fp.write_text(body, encoding="utf-8")
        manifest.append(f"- {name} | {fp.stat().st_size:,}B")
        print(f"[pack] {name} {fp.stat().st_size:,}B")

    # ---- 原始 PDF (3) ----
    pdfs = [
        ("c09_福米可研报告2026.pdf",
         SRC / "03 福米电站项目资料" / "福米多功能大坝项目可行性研究报告vf.pdf"),
        ("c10_施组设计上册.pdf",
         SRC / "03 福米电站项目资料" / "（上册）福米水利枢纽工程施工组织设计.pdf"),
        ("c11_施组设计下册.pdf",
         SRC / "03 福米电站项目资料" / "（下册）福米水利枢纽工程施工组织设计.pdf"),
    ]
    for name, src in pdfs:
        dst = FW / name
        if not dst.exists() and src.is_file():
            dst.write_bytes(src.read_bytes())
        if dst.exists():
            manifest.append(f"- {name} | {dst.stat().st_size:,}B (原始PDF)")
            print(f"[pack] {name} {dst.stat().st_size:,}B")

    # ---- 指令集 ----
    prompt = (
        "# NotebookLM 指令集（FOMI-EPC 策划方案 Phase 0 框架生成, 复制粘贴用）\n\n"
        "## 一、框架生成指令（在 00_战役总笔记本 中发送）\n"
        "你是世界顶级国际工程咨询公司的资深合伙人，曾主导多个非洲大型水电EPC项目的"
        "项目管理策划。基于本笔记本全部资料，为《" + REPORT + "》设计目录框架。"
        "背景：本方案是中国工商银行融资审查的关键支撑文件——工行对'设计院牵头EPC总"
        "承包能力'存疑，方案必须用黄河勘测规划设计研究院的真实资质、业绩、体系与数字化"
        "能力打消疑虑，同时可指导工程实施。读者：工行审贷委员会（非工程专业）为第一读者，"
        "几内亚业主方与公司内部为第二读者。要求：\n"
        "1)开篇为'综合说明'（执行摘要，给行领导的一页式驾驶舱：疑虑导航+量化承诺）；\n"
        "2)总体15-18章，每章标题用判断句而非名词堆砌；每章列出本章回应的读者疑虑与"
        "3-6个小节要点；\n"
        "3)必须覆盖：项目理解与几内亚实施条件、承包商能力陈述（黄河院资质业绩体系）、"
        "风险管理、组织与专家团队、进度、设计管理（设计牵头EPC价值）、采购与海运清关"
        "物流、施工管理、试运行移交与运维衔接、质量、HSE、属地合规与社会管理（海外"
        "专章）、合同资金税务、沟通相关方、数字化（数字总包平台+AI眼镜）；\n"
        "4)每章注明建议引用的资料主题（可研章节/施组/素材台账条目/对标标准）；\n"
        "5)对标基因：GB/T 50358-2017全覆盖并超越、PMBOK绩效域、PMI与IPMA大奖标准；\n"
        "6)输出用简体中文markdown，每章一块以「## 第N章 章标题」开头，下一行"
        "「本章回应：…」，再以- 开头列出小节要点；全文不超过3200字。\n")
    (UPLOAD / "NotebookLM指令集.md").write_text(prompt, encoding="utf-8")
    (UPLOAD / "上传清单.md").write_text("\n".join(manifest) + "\n", encoding="utf-8")
    n = len(list(FW.iterdir()))
    print(f"[pack] 00_战役总笔记本 {n} 源 | 指令集落盘 | {FW}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
