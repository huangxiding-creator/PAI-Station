"""多源语料收集器（M7.5 / PROPOSAL_M7 §6，AIResearch collectors 思想移植）。

AIResearch 原版是外部子项目 subprocess 适配器（依赖外部路径，违反本仓库
独立可运行铁律），故移植其接口思想而非实现：关键词驱动的多源收集 +
统计 + 容错。本版源为 PAI-Station 自有语料湖：
- hundun 池：data/hundun/_mining/*.json（619 门课卡片）
- weread 池：data/weread/*/*.md（已提取行业书）
外部源（论文/研报/视频）留可插拔钩子位，config 开关（M8 接）。
"""

import glob
import json
import os


def collect_corpus(theme: str, *, pools: dict[str, str], keywords: tuple | list = (),
                   max_chunk_chars: int = 60000) -> dict:
    """按关键词扫多池收集语料块。返回 {chunks, stats}（缺池容错，不崩）。"""
    kws = [k.strip() for k in keywords if k.strip()] or [theme]
    chunks, matched = [], 0

    hundun_dir = pools.get("hundun", "")
    if hundun_dir and os.path.isdir(hundun_dir):
        for path in sorted(glob.glob(os.path.join(hundun_dir, "*.json"))):
            try:
                course = json.load(open(path, encoding="utf-8"))
            except (OSError, ValueError):
                continue
            if not isinstance(course, dict) or not course.get("title"):
                continue
            if not any(k in course.get("title", "") or k in course.get("folder", "")
                       for k in kws):
                continue
            lines = [f"# 课程：《{course['title']}》 讲师：{course.get('teacher', '')}"]
            for item in course.get("items", []):
                lines.append(f"- {item.get('name', '')}：{item.get('core', '')}"
                             f"｜AI应用：{item.get('ai_application', '')}")
            text = "\n".join(lines)
            if text.strip():
                chunks.append(text)
                matched += 1

    weread_dir = pools.get("weread", "")
    if weread_dir and os.path.isdir(weread_dir):
        for path in sorted(glob.glob(os.path.join(weread_dir, "**", "*.md"),
                                     recursive=True)):
            try:
                text = open(path, encoding="utf-8").read()
            except OSError:
                continue
            if not any(k in text[:5000] or k in os.path.basename(path) for k in kws):
                continue
            chunks.append(f"# 书籍语料：{os.path.basename(path)}\n{text[:max_chunk_chars]}")
            matched += 1

    return {"chunks": chunks,
            "stats": {"matched_files": matched, "pools": sorted(pools)}}


def merge_corpus(chunks: list[str]) -> str:
    """合并语料块（AIResearch 七步之『合并』）：编号分节，空安全。"""
    parts = []
    for i, chunk in enumerate(chunks, 1):
        parts.append(f"==== 来源 {i} ====\n{chunk}")
    return "\n\n".join(parts)
