"""三层九件套提示词（M7.1 / PROPOSAL_M7 §3.1-3.4）。

融合 AIResearch《专著目录框架》《节内容撰写》模板并升级为：
三层思维模型嵌套（L1 章层/L2 节层/L3 内容层）+ 抄作业九件套 + 四前提 + 密度闸门。
纯模板函数（宪法：只读拼接，不含任何 IO）。
"""

# 九件套渲染标记（内容层用【】包裹嵌入 markdown；键即 density.NINE_COMPONENTS）
NINE_MARKERS: tuple[tuple[str, str], ...] = (
    ("key_points", "【关键点】"),
    ("wbs", "【WBS 任务分解】"),
    ("formula", "【业务公式】"),
    ("experience_map", "【经验地图】"),
    ("pitfall_checklist", "【避坑清单】"),
    ("arsenal", "【实操武器库】"),
    ("case", "【小案例】"),
    ("infographic", "【信息图】"),
    ("flowchart", "【流程图】"),
)

_NINE_TEXT = "\n".join(f"  - {mark}（组件 id: {key}）" for key, mark in NINE_MARKERS)

# 目录覆盖线（两类产品的骨架差异所在，由 fde/report 各自传入）
DEFAULT_COVERAGE = "行业诊断 → AI 机会识别 → 实施路线图 → 抄作业工具包 → 度量体系"


def toc_prompt(theme: str, corpus: str = "", cards_l1=(), n_chapters: int = 8,
               coverage: str = DEFAULT_COVERAGE) -> str:
    """目录生成提示词（L1 章层骨架 + 三级目录铁律 + 产品覆盖线）。"""
    cards_text = "\n".join(f"- {name}：{one}" for name, one in cards_l1) or "-（自选成熟框架）"
    return f"""你是顶级咨询公司的资深合伙人，正在为《{theme}》设计实施方案目录。

## 可选章层大框架（L1，从中选配并组合，可微调措辞但须保留框架名）
{cards_text}

## 目录铁律（不可违反）
1. 章-节-小节三级封顶，绝不出现第四层；
2. 每章必须标注所用 L1 框架（framework 字段），每节必须标注 L2 子框架；
3. 建议 {n_chapters} 章左右，每章 3-6 节；
4. 节标题具体到可执行（"1.1 现状诊断：从事件到心智的四层下钻"，不要"1.1 概述"）；
5. 全书须覆盖：{coverage}。

## 语料（仅供提炼，不得照抄原文）
{corpus[:30000] or "（无语料，凭行业常识与框架推演）"}

## 输出（只输出 JSON，不要任何解释）
{{"title": "方案主标题", "chapters": [
  {{"title": "第1章 …", "framework": "L1框架名", "sections": [
    {{"title": "1.1 …", "framework": "L2子框架名"}}]}}]}}"""


def section_prompt(chapter: str, section: dict, corpus: str = "", cards_l2l3=(),
                   immune_rules=(), failures=()) -> str:
    """节内容生成提示词（L2 节框架 + L3 内容层九件套 + 四前提）。"""
    cards_text = "\n".join(f"- {name}：{one}" for name, one in cards_l2l3) or "-（自选最适子框架）"
    immune_text = "\n".join(f"- {r}" for r in immune_rules) or "-（暂无，恪守通用纪律）"
    failures_text = "\n".join(f"- {f}" for f in failures)
    failures_block = (f"\n## 上一稿未过密度闸门，逐条修复\n{failures_text}\n"
                      if failures else "")
    return f"""你是前沿部署工程师（FDE），为《{chapter}》撰写「{section.get("title", "")}」一节。
本节指定子框架（L2）：{section.get("framework", "") or "（自选）"}——结构须严格遵循该框架展开。

## 内容层要求（L3：思维模型表达 + 抄作业九件套）
1. 从下列候选模型中选用合适的表达方式，行文中自然体现其结构：
{cards_text}
2. 九件套组件中**至少选用 2 种**嵌入内容（用标记行开头，如【避坑清单】后接清单体）：
{_NINE_TEXT}
3. 四前提必须在内容中具体体现（不是喊口号，要落到本节的动作）：
   标准化（SOP/标准）、流程化（流程/泳道）、数据化（看板/指标/数据）、知识化（知识库/沉淀）；
4. 抄作业导向：读者能直接搬走执行——表格给字段、清单给勾选项、公式给变量、案例给"背景-动作-结果"。

## 语料纪律
- 只用语料中的事实与数据；语料缺失处标注"（待验证）"，**严禁编造**；
- 语料是原料，必须用框架重构，不得整段照抄。

## 免疫规则（历史反馈沉淀，必须遵守）
{immune_text}{failures_block}
## 语料
{corpus[:40000] or "（无语料，凭框架与行业常识推演，并如实标注推演性质）"}

## 输出（只输出 JSON，不要任何解释）
{{"framework": "实际采用的节框架名", "components": ["组件id1", "组件id2"],
  "content": "markdown 正文（含【组件标记】块，800-1500 字）"}}"""
