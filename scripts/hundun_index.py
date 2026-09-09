"""混沌学园采集索引生成器：全部课程 JSON → 总目录 README。

输出 data/hundun/README.md：AI课程/课程资料各分类的课程清单
（标题/讲师/时长/章节数/文稿字数），按分类分组，含统计汇总。
幂等：重跑即刷新（供采集完成后终版生成）。
"""
import glob
import json
import os
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BASE = os.path.join(ROOT, "data", "hundun")
OUT = os.path.join(BASE, "README.md")


def _fmt(duration) -> str:
    import re
    if isinstance(duration, str):
        m = re.match(r"(?:(\d+)时)?(?:(\d+)分)?(?:(\d+)秒)?", duration.strip())
        if m and any(m.groups()):
            h, mi, s = (int(g or 0) for g in m.groups())
            total = h * 3600 + mi * 60 + s
            return f"{total // 60}分钟"
        return duration
    s = int(duration or 0)
    return f"{s // 60}分钟"


def load_courses() -> list:
    out = []
    for path in glob.glob(os.path.join(BASE, "**", "*.json"), recursive=True):
        parent = os.path.basename(os.path.dirname(path))
        if parent in ("_recon",):
            continue
        name = os.path.basename(path)
        if len(name) != 37 or not name.endswith(".json"):
            continue
        try:
            with open(path, encoding="utf-8") as fh:
                c = json.load(fh)
        except (OSError, ValueError):
            continue
        chapters = c.get("chapters") or []
        c["_folder"] = parent
        c["_chars"] = sum(len(ch.get("transcript") or "") for ch in chapters)
        c["_chapters"] = len(chapters)
        out.append(c)
    return out


def main() -> int:
    courses = load_courses()
    ai = [c for c in courses if c["_folder"] == "AI课程"]
    others: dict[str, list] = {}
    for c in courses:
        if c["_folder"] != "AI课程" and os.path.basename(c["_folder"]) != "hundun":
            others.setdefault(c["_folder"], []).append(c)
    root_level = [c for c in courses
                  if os.path.basename(c["_folder"]) == "hundun"]

    lines = ["# 混沌学园课程采集总目录", ""]
    total_chars = sum(c["_chars"] for c in courses)
    lines += [f"- 采集课程：**{len(courses)}** 门（AI 相关 {len(ai)} 门）",
              f"- 文稿总量：**{total_chars / 10000:.1f} 万字**",
              f"- 生成时间：{__import__('datetime').datetime.now():%Y-%m-%d %H:%M}",
              "", "## 目录结构", "",
              "- `AI课程/`——与 AI/人工智能相关的课程（用户指定单独归档）",
              "- `课程资料/<分类>/`——其余课程按平台分类存放", ""]

    def table(items: list) -> list:
        rows = ["| 课程 | 讲师 | 时长 | 章节 | 文稿字数 |", "|---|---|---|---|---|"]
        for c in sorted(items, key=lambda x: -x["_chars"]):
            rows.append(f"| {c.get('title', '')[:40]} | {c.get('teacher', '')}"
                        f" | {_fmt(c.get('duration'))} | {c['_chapters']}"
                        f" | {c['_chars']} |")
        return rows

    if ai:
        lines += ["## AI 课程（单独归档）", ""] + table(ai) + [""]
    for folder in sorted(others):
        lines += [f"## {folder}", ""] + table(others[folder]) + [""]
    if root_level:
        lines += ["## 早期采集（根目录）", ""] + table(root_level) + [""]
    with open(OUT, "w", encoding="utf-8") as fh:
        fh.write("\n".join(lines))
    print(f"[index] {len(courses)} 门 / {total_chars / 10000:.1f} 万字 -> {OUT}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
