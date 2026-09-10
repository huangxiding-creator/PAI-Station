"""思想密度计（M7.0 / PROPOSAL_M7 §3.4）：把"极高质量"变成可证伪的闸门。

密度分构成（满分 100）：
  章模型标注 15 + 节模型标注 15 + 九件套密度 25 + 三级目录 10 + 四前提 20 + 案例密度 15
判定：score < threshold(默认60) → failures 列出原因（供重生成环与降级标注使用）。
四前提（09-09 转录 AI 转型四条件）：标准化 / 流程化 / 数据化 / 知识化。
纯标准库、纯函数（宪法：只读映射，不改入参）。
"""

# 抄作业九件套（§3.2）——方案 schema 中 sections[].components 的合法取值
NINE_COMPONENTS: tuple[str, ...] = (
    "key_points", "wbs", "formula", "experience_map", "pitfall_checklist",
    "arsenal", "case", "infographic", "flowchart",
)

# 四前提的文本标记（命中任一即认定该前提在内容中出现；每前提 ≥2 标记便于测试兜底）
PREMISES: dict[str, tuple[str, ...]] = {
    "标准化": ("标准化", "标准", "SOP"),
    "流程化": ("流程化", "流程", "SOP"),
    "数据化": ("数据化", "数据", "看板", "指标"),
    "知识化": ("知识化", "知识库", "知识", "沉淀"),
}

# 各维度满分权重（合计 100）
_W_CHAPTER_MODEL = 15   # 章层模型标注覆盖率
_W_SECTION_MODEL = 15   # 节层模型标注覆盖率
_W_COMPONENTS = 25      # 九件套组件密度（目标每节 ≥2 件）
_W_TOC = 10             # 章-节-小节三级封顶
_W_PREMISES = 20        # 四前提逐项检查
_W_CASE = 15            # 案例密度（小案例是降认知门槛的关键组件）
_COMPONENTS_TARGET = 2  # 每节组件目标数


def _sections(doc: dict) -> list[dict]:
    """摊平全部节（空安全）。"""
    return [s for ch in doc.get("chapters", []) for s in ch.get("sections", [])]


def four_premises(doc: dict) -> dict[str, bool]:
    """四前提逐项检查（每节四查四过）：一前提通过 ⟺ 每一节的内容都命中其标记。"""
    sections = _sections(doc)
    result = {}
    for premise, markers in PREMISES.items():
        result[premise] = bool(sections) and all(
            any(m in (s.get("content", "") + "".join(s.get("components", []))) for m in markers)
            for s in sections
        )
    return result


def toc_depth_ok(doc: dict) -> bool:
    """目录铁律：章-节-小节三级封顶（出现第 4 层 subsections 即违规）。"""
    for ch in doc.get("chapters", []):
        for s in ch.get("sections", []):
            if s.get("subsections"):
                return False
    return True


def density_score(doc: dict, threshold: int = 60) -> dict:
    """思想密度打分：返回 {score, passed, failures}（failures 为中文原因列表）。"""
    chapters = doc.get("chapters", [])
    sections = _sections(doc)
    failures: list[str] = []

    if not chapters or not sections:
        return {"score": 0, "passed": False, "failures": ["空方案：无章或无节"]}

    # 1) 章模型标注（15 分，按覆盖率折算）
    ch_tagged = sum(1 for ch in chapters if str(ch.get("framework", "")).strip())
    score = _W_CHAPTER_MODEL * ch_tagged / len(chapters)
    if ch_tagged < len(chapters):
        failures.append(f"章模型标注不全：{ch_tagged}/{len(chapters)} 章缺思维模型")

    # 2) 节模型标注（15 分）
    sec_tagged = sum(1 for s in sections if str(s.get("framework", "")).strip())
    score += _W_SECTION_MODEL * sec_tagged / len(sections)
    if sec_tagged < len(sections):
        failures.append(f"节模型标注不全：{len(sections) - sec_tagged} 节缺子框架")

    # 3) 九件套密度（25 分，目标每节 ≥2 件）
    valid_counts = [
        len([c for c in s.get("components", []) if c in NINE_COMPONENTS])
        for s in sections
    ]
    avg = sum(valid_counts) / len(sections)
    score += min(_W_COMPONENTS, _W_COMPONENTS * avg / _COMPONENTS_TARGET)
    if avg < _COMPONENTS_TARGET:
        failures.append(f"九件套密度不足：平均 {avg:.1f} 件/节（目标 ≥{_COMPONENTS_TARGET}）")

    # 4) 三级目录（10 分）
    if toc_depth_ok(doc):
        score += _W_TOC
    else:
        failures.append("目录违规：出现第四层嵌套（章-节-小节三级封顶）")

    # 5) 四前提（20 分，每个 5 分）
    premises = four_premises(doc)
    passed_n = sum(premises.values())
    score += _W_PREMISES * passed_n / len(PREMISES)
    for premise, ok in premises.items():
        if not ok:
            failures.append(f"四前提缺失：{premise} 未在方案中体现")

    # 6) 案例密度（15 分，含小案例组件的节占比）
    case_ratio = sum(1 for s in sections if "case" in s.get("components", [])) / len(sections)
    score += _W_CASE * case_ratio
    if case_ratio < 0.5:
        failures.append(f"案例密度不足：仅 {case_ratio:.0%} 节含小案例（目标 ≥50%）")

    score = round(score)
    return {"score": score, "passed": score >= threshold, "failures": failures}
