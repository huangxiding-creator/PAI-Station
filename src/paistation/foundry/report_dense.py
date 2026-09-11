"""M9.5b 调研报告密度重构：结论卡拼贴 → 节级综合（密度计可过、内容不编造）。

问题（2026-09-11 首课题实测）：build_density_doc 本地拼贴 4 卡×200 字——
同节卡片是「节点×利益相关方」变体，内容重复 3+ 次；组件行被丢弃（600 卡仅
1 张带组件）→ 密度 42/100（九件套 0.1 件/节、四前提 0 分、案例 1%）。

修法：每节一次 GLM 综合（SECTION_SYNTH_PROMPT）——把该节全部结论卡压成
一段密实内容，四前提（标准化/流程化/数据化/知识化）在 EPC 语境自然落地，
组件由模型判断（+关键词兜底）；**只用所给卡片，不得新增事实**（C14）。
卡片变体去重交给综合语义完成（不做事前去重——600 卡实测同节仅 ~7 张，
提示词装得下，事前截断去重反而丢信息）。
纯函数部分（解析/组装）可测；GLM 循环在 tools/research_dense_report.py。
"""
import re

# EPC 语境四前提锚点（密度计标记词在内容中自然出现，非硬塞词）
SECTION_SYNTH_PROMPT = """你是工程总承包（EPC）领域首席研究员。把下列结论卡综合成 ONE 节密实内容。

课题节：{title}
该节结论卡（{n_cards} 张，来自不同利益相关方视角，核心结论高度重叠——
你的任务是把它们压成一段不重复的综合叙述）：
{cards}

输出格式（严格遵守，只用所给卡片内容综合，不得新增事实/数字/案例；
卡片没提的维度写"本节卡片未覆盖"）：
综合：80-150 字，合并各方视角的核心结论（去重后的唯一结论集）
标准：本节涉及的标准/合同范本/条款依据（如 FIDIC、合同范本条款；标准化）
流程：本节涉及的处置流程或步骤（流程化）
数据：本节涉及的关键指标/统计/量化判据（数据化）
沉淀：本节的知识沉淀建议（入库/清单/复盘机制；知识化）
案例：本节卡片中提到的一则实例（没有则写"本节卡片未覆盖"）
组件：从[key_points,wbs,formula,experience_map,pitfall_checklist,arsenal,case,infographic,flowchart]选 1-2 个最能代表本节内容的，逗号分隔"""

_COMPONENT_LINE = re.compile(r"组件[:：]\s*(.+)")
_FIELD_LINE = re.compile(
    r"^(综合|标准|流程|数据|沉淀|案例)[:：]\s*(.+)$", re.M)
_NINE = ("key_points", "wbs", "formula", "experience_map", "pitfall_checklist",
         "arsenal", "case", "infographic", "flowchart")


def parse_synthesis(text: str) -> dict:
    """模型输出 → {content, components}。字段行重组为 content（保持领域结构），
    组件行解析校验（非法值丢弃，cap 2）；解析失败整段作 content 兜底。"""
    fields = dict(_FIELD_LINE.findall(text or ""))
    comp_line = _COMPONENT_LINE.search(text or "")
    components = []
    if comp_line:
        for token in re.split(r"[,，\s]+", comp_line.group(1)):
            token = token.strip()
            if token in _NINE and token not in components:
                components.append(token)
    if fields:
        content = "\n".join(f"{k}：{v}" for k, v in fields.items())
    else:
        content = (text or "").strip()
    return {"content": content, "components": components[:2]}


def keyword_components(content: str) -> list[str]:
    """关键词兜底（模型组件行缺席时）：领域词 → 九件套。"""
    tag_map = [("案例", "case"), ("步骤", "flowchart"), ("流程", "flowchart"),
               ("公式", "formula"), ("清单", "pitfall_checklist"),
               ("要点", "key_points"), ("分解", "wbs"), ("武器", "arsenal"),
               ("经验", "experience_map"), ("图", "infographic")]
    found = [slug for kw, slug in tag_map if kw in (content or "")]
    return list(dict.fromkeys(found))[:2]


def merge_components(parsed: list[str], fallback: list[str]) -> list[str]:
    """模型判断优先 + 关键词兜底，去重 cap 2。"""
    out = list(parsed)
    for slug in fallback:
        if slug not in out:
            out.append(slug)
    return out[:2]


def build_dense_doc(topic: str, master: list[dict],
                    synthesized: dict[str, dict]) -> dict:
    """master 框架 + 节级综合结果 → 密度计文档。

    synthesized: {node_id: {content, components}}；缺席节点如实标注待证
    （单源/无源标注，不编造内容）。
    """
    chapters = [n for n in master if n.get("level") == "章"]
    sections = [n for n in master if n.get("level") != "章"]
    doc_chapters = {ch["id"]: {"title": ch["title"],
                               "framework": "调研重构框架", "sections": []}
                    for ch in chapters}
    fallback_ch = chapters[0]["id"] if chapters else ""
    for sec in sections:
        syn = synthesized.get(sec["id"], {})
        doc_chapters.setdefault(sec["id"].split(".")[0],
                                doc_chapters.get(fallback_ch,
                                                 {"sections": []}))
        doc_chapters[sec["id"].split(".")[0]]["sections"].append({
            "title": sec["title"],
            "framework": "5W1H×利益相关方",
            "content": syn.get("content")
                        or "（该节点结论卡待证——单源/无源标注）",
            "components": list(syn.get("components", [])),
            "subsections": [],
        })
    return {"title": topic, "chapters": list(doc_chapters.values())}


def assemble_report_md(doc: dict, meta: dict) -> str:
    """密度文档 → 人读报告 markdown（含验收摘要头）。"""
    lines = [f"# {doc.get('title', '')} —— 调研报告（两阶段管线出厂）", ""]
    lines += [f"- 框架节点：{meta.get('nodes', 0)}｜问题：{meta.get('questions', 0)}"
              f"｜有证据：{meta.get('evidenced', 0)}"
              f"｜结论卡：{meta.get('conclusions', 0)}", ""]
    for ch in doc.get("chapters", []):
        lines += [f"## {ch['title']}", ""]
        for sec in ch.get("sections", []):
            lines += [f"### {sec['title']}", "",
                      sec.get("content", ""), ""]
    return "\n".join(lines)
