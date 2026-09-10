"""武器库成册器：synthesized.json → 《AI 产品研发思维武器库》md + docx。

四卷机械生成（按频次×来源数排序，应用地图由主控阶段补写）：
- 卷一 思维模型 / 卷二 原则 / 卷三 方法论（含步骤）/ 卷四 经验与教训
每条目：规范名+别名 / 核心思想 / 原文金句 / AI 产品研发应用 / 来源课程。
输出 data/hundun/AI产品研发思维武器库.md（与 docx）。
"""
import json
import os
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MINE = os.path.join(ROOT, "data", "hundun", "_mining")
OUT_MD = os.path.join(ROOT, "data", "hundun", "AI产品研发思维武器库.md")

_VOL = {"思维模型": "卷一　思维模型", "原则": "卷二　原则",
        "方法论": "卷三　方法论", "经验": "卷四　经验与教训"}
_MAX_PER_VOL = 80


def entry_md(idx: int, c: dict) -> list:
    lines = [f"### {idx}. {c['name']}"]
    if c.get("aliases"):
        lines.append(f"*别名：{'、'.join(c['aliases'])}*")
    lines += ["", f"**核心思想**：{c.get('core', '')}", ""]
    if c.get("quote"):
        lines += [f"> {c['quote']}", ""]
    if c.get("steps"):
        steps = " → ".join(s.strip() for s in c["steps"].split("；") if s.strip())
        lines += [f"**操作步骤**：{steps}", ""]
    if c.get("ai_application"):
        lines += [f"**AI 产品研发应用**：{c['ai_application']}", ""]
    srcs = c.get("courses") or []
    freq = c.get("freq", len(srcs))
    shown = "、".join(f"《{s}》" for s in srcs[:6])
    more = f" 等 {len(srcs)} 门" if len(srcs) > 6 else ""
    lines += [f"<sub>来源：{shown}{more}（{freq} 次提及）</sub>", ""]
    return lines


def main() -> int:
    data = json.load(open(os.path.join(MINE, "synthesized.json"),
                          encoding="utf-8"))
    stats = data.get("stats", {})
    clusters = data.get("clusters", {})
    total_in = sum(len(v) for v in clusters.values())
    lines = [
        "# AI 产品研发思维武器库", "",
        "> 从混沌学园全站 647 门课程、3031 万字授课文稿中，逐课提炼并跨课"
        "聚类去重而成的知识武器库。", "",
        f"- 数据底座：**{stats.get('courses', 0)}** 门课程 → "
        f"**{stats.get('items', 0)}** 条原始资产 → **{total_in}** 个规范条目",
        "- 四类资产：思维模型（认知透镜）/ 原则（行事铁律）/ 方法论（可操作"
        "流程）/ 经验（实战教训）",
        f"- 生成时间：{__import__('datetime').datetime.now():%Y-%m-%d %H:%M}",
        "", "---", "",
    ]
    for label in ("思维模型", "原则", "方法论", "经验"):
        items = clusters.get(label) or []
        if not items:
            continue
        lines += [f"## {_VOL[label]}（{len(items)}）", ""]
        for i, c in enumerate(items[:_MAX_PER_VOL], 1):
            lines += entry_md(i, c)
        if len(items) > _MAX_PER_VOL:
            lines += [f"*（其余 {len(items) - _MAX_PER_VOL} 条频次较低，"
                      "见数据底座 synthesized.json）*", ""]
        lines += ["---", ""]
    lines += ["## 卷五　AI 产品研发应用地图", "",
              "*（由主控阶段基于全库综合绘制：研发场景 × 高频武器矩阵）*", ""]
    with open(OUT_MD, "w", encoding="utf-8") as fh:
        fh.write("\n".join(lines))
    print(f"[handbook] {total_in} 条目 -> {OUT_MD} "
          f"({os.path.getsize(OUT_MD) // 1024}KB)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
