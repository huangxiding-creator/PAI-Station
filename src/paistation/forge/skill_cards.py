"""技能卡蒸馏（提案第 19 章铸造厂 / M2.5）：课程全要素 → SKILL.md 卡。

deep 模型从课程文稿提炼可复用的方法论卡片（名称/适用时机/步骤/示例），
输出符合本项目 M3 技能引擎的 SKILL.md 格式（frontmatter + 正文）。
模型抖动输出非 JSON 时返回空卡组——蒸馏缺席但不崩（H1 同款纪律）。
"""
import json
import os
import re

_PROMPT = (
    "以下是一门课程的完整文稿（混沌学园）。请从中提炼出可复用的"
    "方法论/模型/操作框架，作为技能卡。要求：\n"
    "1. 每张卡是一个独立可执行的方法，不是知识点罗列\n"
    "2. 步骤必须具体可操作（3-6 步），示例来自课程原内容\n"
    "3. 只输出 JSON 数组，每项字段：\n"
    '   {"name": "技能名(不超过12字)", "description": "一句话说明(不超过30字)",'
    ' "when_to_use": "适用时机", "steps": ["步骤1", "..."],'
    ' "example": "课程中的实例", "source": "出处章节"}\n'
    "4. 提炼 3-5 张最有复用价值的卡\n\n课程内容：\n")


def _loads_array(raw: str) -> list:
    """围栏剥离 → 整体解析 → 正则兜底，三段式解析 JSON 数组。"""
    text = re.sub(r"```(?:json)?\s*", "", str(raw)).strip().rstrip("`")
    try:
        data = json.loads(text)
        if isinstance(data, list):
            return data
    except ValueError:
        pass
    m = re.search(r"\[.*\]", text, re.DOTALL)
    if m:
        try:
            data = json.loads(m.group(0))
            return data if isinstance(data, list) else []
        except ValueError:
            return []
    return []


def distill_cards(deep_fn, course: dict, max_cards: int = 5,
                  max_chars: int = 60000) -> list[dict]:
    """单门课程 → 技能卡列表；同名去重、超量截断、字段清洗。"""
    parts = [f"课程：{course.get('title', '')}（讲师：{course.get('teacher', '')}）",
             f"简介：{course.get('intro', '')}"]
    for ch in course.get("chapters") or []:
        parts.append(f"\n## {ch.get('title', '')}\n{ch.get('transcript', '')}")
    payload = "\n".join(parts)[:max_chars]
    try:
        raw = deep_fn(_PROMPT + payload, reasoning=True)["text"]
    except Exception:  # noqa: BLE001 - 模型故障→空卡组，不挡流程
        return []
    cards, seen = [], set()
    for item in _loads_array(raw):
        if not isinstance(item, dict):
            continue
        name = str(item.get("name", "")).strip()[:24]
        desc = str(item.get("description", "")).strip()[:60]
        steps = [str(s).strip() for s in item.get("steps") or [] if str(s).strip()]
        if not (name and desc and steps):
            continue
        if name in seen:
            continue
        seen.add(name)
        cards.append({
            "name": name, "description": desc,
            "when_to_use": str(item.get("when_to_use", "")).strip()[:80],
            "steps": steps[:6], "example": str(item.get("example", "")).strip(),
            "source": str(item.get("source", "")).strip()[:40]})
        if len(cards) >= max_cards:
            break
    return cards


def card_to_skill_md(card: dict) -> str:
    """卡片 → SKILL.md（与 M3 技能引擎 frontmatter 约定一致）。"""
    lines = ["---", f"name: {card['name']}",
             f"description: {card['description']}", "---", "",
             f"# {card['name']}", "", card["description"], ""]
    if card.get("when_to_use"):
        lines += ["## 适用时机", "", card["when_to_use"], ""]
    lines += ["## 操作步骤", ""]
    lines += [f"{i}. {s}" for i, s in enumerate(card["steps"], 1)]
    if card.get("example"):
        lines += ["", "## 示例", "", card["example"]]
    if card.get("source"):
        lines += ["", f"（出处：{card['source']}）"]
    lines.append("")
    return "\n".join(lines)


def save_cards(cards: list, out_dir: str) -> list:
    """每卡一目录：out_dir/<name>/SKILL.md。"""
    written = []
    for card in cards:
        d = os.path.join(out_dir, card["name"])
        os.makedirs(d, exist_ok=True)
        path = os.path.join(d, "SKILL.md")
        with open(path, "w", encoding="utf-8") as fh:
            fh.write(card_to_skill_md(card))
        written.append(path)
    return written
