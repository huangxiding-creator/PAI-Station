"""学习笔记生成（M2.5）：deep 综合 3 门课 → 1 篇可发布笔记。"""
import glob
import json
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation import config
from paistation.llm.zhipu_client import ZhipuClient

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA = os.path.join(ROOT, "data", "hundun")

PROMPT = """你刚学完混沌学园以下三门课。请写一篇 1500 字左右的学习笔记，
发布到"工程行业大脑"知识库，供同事学习。要求：
1. 标题点出三门课的贯通主线（AI 时代的品牌与组织）
2. 每门课提炼 2-3 个最核心的洞察（含课程中的关键概念/案例）
3. 结尾给出"工程行业企业可落地的 3 个行动"
4. 用 markdown 二级标题分节，语气务实，不用空话
只输出笔记正文。

三门课材料：
"""


def main():
    cfg = config.load(os.path.join(ROOT, "config", "pai.ini"))
    key = config.resolve_api_key(cfg)
    client = ZhipuClient(
        key, [cfg["llm"]["fast_model"], cfg["llm"]["deep_model"]],
        vision_model=cfg["llm"]["vision_model"])
    parts = []
    for path in sorted(glob.glob(os.path.join(DATA, "*.json"))):
        course = json.load(open(path, encoding="utf-8"))
        chapters = "；".join(
            f"{c['title']}（{c['transcript'][:3000]}）"
            for c in course["chapters"][:3])
        parts.append(f"### {course['title']}（{course['teacher']}）\n"
                     f"简介：{course['intro']}\n章节摘要：{chapters}")
    note = client.deep(PROMPT + "\n\n".join(parts), reasoning=True)["text"]
    out = os.path.join(DATA, "学习笔记_混沌学园三门课.md")
    with open(out, "w", encoding="utf-8") as fh:
        fh.write(note.strip() + "\n")
    print(f"[note] {len(note)} 字 -> {out}")
    print(note[:400])
    return 0


if __name__ == "__main__":
    sys.exit(main())
