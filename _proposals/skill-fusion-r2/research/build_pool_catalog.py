# -*- coding: utf-8 -*-
"""构建 skill 融合总目录池：扫全部来源 SKILL.md frontmatter → pool_catalog.jsonl + 分层初筛。

来源：
  A. skillsweep/        （GitHub 生态克隆，含补克隆仓）
  B. qoder/unpack/      （qoder 市场九技能）
  C. MuseAI-Skills/     （68 技能快照）
  D. market-research-skills/（genli 4 技能）
输出：pool_catalog.jsonl（一行一 skill）+ 控制台分层统计。
"""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path(r"E:\AI-Station\_proposals\skill-fusion-r2\research")

SOURCES = [
    ("skillsweep", ROOT / "vendor" / "skillsweep"),
    ("qoder", ROOT / "qoder" / "unpack"),
    ("museai", ROOT / "vendor" / "MuseAI-Skills"),
    ("genli", ROOT / "vendor" / "market-research-skills" / "skills"),
]

# 主战场词典：调研/搜集/分析/成稿/验证/交付/PDF/图表/学术检索/数据/渠道
LEXICON = {
    # 调研与检索
    "research": 3, "调研": 3, "research": 3, "deep research": 4, "search": 2, "检索": 3,
    "literature": 3, "文献": 3, "paper": 3, "论文": 3, "academic": 2, "学术": 2,
    "scholar": 3, "arxiv": 3, "pubmed": 3, "citation": 3, "引用": 2, "bibliograph": 3,
    # 搜集与渠道
    "scrape": 3, "scraping": 3, "crawl": 3, "采集": 3, "harvest": 3, "web": 1,
    "news": 2, "rss": 2, "monitor": 2, "监测": 2, "intelligence": 2, "情报": 3,
    "osint": 3, "competitive": 3, "竞品": 3, "market": 2, "行业": 2, "industry": 2,
    # 分析与证据
    "analy": 2, "分析": 2, "evidence": 3, "证据": 3, "fact-check": 4, "fact check": 4,
    "verify": 3, "核验": 3, "核实": 3, "audit": 3, "审查": 2, "review": 1,
    "data": 1, "数据": 1, "statistics": 2, "统计": 2, "survey": 2, "synthesis": 3,
    "insight": 2, "hypothes": 3, "reasoning": 1, "argument": 2,
    # 成稿与交付
    "report": 3, "研报": 4, "报告": 3, "writing": 2, "写作": 3, "document": 1,
    "docx": 2, "word": 1, "pdf": 2, "publish": 2, "排版": 3, "typeset": 2,
    "brief": 2, "简报": 3, "memo": 2, "deliver": 2, "交付": 3,
    # 图表
    "chart": 3, "图表": 3, "visuali": 2, "可视化": 3, "plot": 2, "diagram": 2,
    "figure": 2, "matplotlib": 2, "table": 1,
    # 质量与流程
    "quality": 2, "workflow": 1, "pipeline": 1, "checklist": 2, "quality gate": 3,
}

FM_RE = re.compile(r"\A---\s*\n(.*?)\n---\s*\n", re.S)


def parse_frontmatter(text: str):
    m = FM_RE.match(text)
    if not m:
        return {}
    fm = {}
    for line in m.group(1).splitlines():
        mm = re.match(r"^(name|description|license):\s*(.+)$", line.strip())
        if mm:
            val = mm.group(2).strip().strip("'\"")
            fm[mm.group(1)] = val
    return fm


def score(desc: str, name: str) -> int:
    text = (name + " " + desc).lower()
    s = 0
    for kw, w in LEXICON.items():
        if kw in text:
            s += w
    return s


def main():
    rows = []
    seen_names = {}
    for src, base in SOURCES:
        if not base.exists():
            print(f"[WARN] missing source dir: {base}")
            continue
        for sk in base.rglob("SKILL.md"):
            skill_dir = sk.parent
            # 排除明显非技能位（node_modules/.git/测试夹具）
            sp = str(sk).replace("\\", "/")
            if "/.git/" in sp or "/node_modules/" in sp or "/fixtures/" in sp or "/__pycache__/" in sp:
                continue
            repo = skill_dir.relative_to(base).parts[0] if src == "skillsweep" else src
            try:
                text = sk.read_text(encoding="utf-8", errors="replace")[:4000]
            except OSError:
                continue
            fm = parse_frontmatter(text)
            name = fm.get("name") or skill_dir.name
            desc = fm.get("description", "")
            s = score(desc, name)
            # 重名去重（保留分高者）
            key = name.lower().strip()
            prev = seen_names.get(key)
            row = {
                "name": name, "repo": str(repo), "source": src,
                "path": str(skill_dir), "desc": desc[:300], "score": s,
            }
            if prev is not None:
                if s > rows[prev]["score"]:
                    rows[prev] = row
                    # 记录撞名
                    rows[prev]["dup_of"] = key
            else:
                seen_names[key] = len(rows)
                rows.append(row)

    out = ROOT / "pool_catalog.jsonl"
    with out.open("w", encoding="utf-8") as f:
        for r in rows:
            f.write(json.dumps(r, ensure_ascii=False) + "\n")

    total = len(rows)
    t1 = [r for r in rows if r["score"] >= 8]
    t2 = [r for r in rows if 3 <= r["score"] < 8]
    t3 = [r for r in rows if r["score"] < 3]
    print(f"TOTAL unique skills: {total}")
    print(f"T1 (score>=8, 直接主战场): {len(t1)}")
    print(f"T2 (3<=score<8, 邻域):     {len(t2)}")
    print(f"T3 (<3, 弱相关):           {len(t3)}")
    print("\n=== T1 按来源分布 ===")
    bysrc = {}
    for r in t1:
        k = f"{r['source']}/{r['repo']}"
        bysrc[k] = bysrc.get(k, 0) + 1
    for k, v in sorted(bysrc.items(), key=lambda x: -x[1]):
        print(f"  {v:4d}  {k}")
    print("\n=== T1 TOP30（按分） ===")
    for r in sorted(t1, key=lambda x: -x["score"])[:30]:
        print(f"  {r['score']:3d}  [{r['source']}/{r['repo']}] {r['name']}: {r['desc'][:80]}")


if __name__ == "__main__":
    main()
