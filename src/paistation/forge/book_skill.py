"""B1「书→技能包」管线：book.json → agentskills 规范技能包。

输出契约（chapters/ 三索引/SKILL.md≤4K 前重后轻/Topic Index 导航）与
预算纪律（estimate_tokens / depth 预算矩阵 / discovery_tax ROI 账本）
移植自 virgiliojr94/book-to-skill（MIT，源码级解剖结论）；我们的优势是
微信读书 book.json 自带章节树——适配器保留其字段契约，下游规格/预算/
预检全部白拿，且免掉它 80% 复杂度（11 语言章节标题猜测）。
"""
from __future__ import annotations

import json
import os
import re
from datetime import date

from .sanitize import guard_generated, sanitize_text

# ---- 计费口径（book-to-skill utils.py 直接抄） ----
_CJK_RE = re.compile(
    r"[⼀-⿟　-〿぀-ヿ㐀-䶿一-鿿가-힣豈-﫿＀-￯\U00020000-\U0003FFFF]")
WORDS_PER_TOKEN = 0.75      # 拉丁：word/0.75
CJK_CHARS_PER_TOKEN = 1.5   # CJK：字/1.5（含增补平面，专为我们中文书）

# depth 预算矩阵（token/章）：sketch 骨架 / reference 默认 / study 复现案例
_DEPTHS = {"sketch": 600, "reference": 900, "study": 1600}
_OVER_BUDGET_FACTOR = 1.3   # 超预算 30% 才打标——留模型呼吸空间

_KEEP_RE = re.compile(r"[^\w\s-]+", re.UNICODE)

# 微信读书 epub 树的无内容页（level-1 但无蒸馏价值）
_SKIP_TITLES = frozenset({"封面", "版权信息", "版权页", "书名页", "目录"})
# 父子折叠上限（字符）：超过则子章独立成单元——真实书 level-1 常是"部"，
# level-2 才是真章；整部折叠会把 1/3 本书压进一张预算卡，颗粒度失真
_FOLD_MAX_CHARS = 24000
_PARENT_TEXT_MIN_CHARS = 200   # 拆分时父级自有文字超过此值才单独成单元


def estimate_tokens(text: str) -> int:
    """CJK 字数/1.5 + 拉丁词数/0.75（book-to-skill 口径，含增补平面）。"""
    if not text:
        return 0
    cjk_chars = len(_CJK_RE.findall(text))
    latin_text = _CJK_RE.sub(" ", text)
    latin_words = len(latin_text.split())
    return int(cjk_chars / CJK_CHARS_PER_TOKEN + latin_words / WORDS_PER_TOKEN)


def slugify(text: str, fallback: str = "ch") -> str:
    """文件名友好的 slug：保留 CJK 与字母数字，去标点，空格转连字符。"""
    cleaned = _KEEP_RE.sub("", str(text).strip())
    slug = re.sub(r"[\s_]+", "-", cleaned).strip("-").lower()
    return slug or fallback


# ---- 确定性适配器层：book.json → 语料 + 元数据契约 ----

def chapter_units(book: dict) -> list[dict]:
    """章节树 → 蒸馏单元。

    规则：skipped/空章/无内容页剔除；level≥2 子节默认折入父章；但父章
    （真实书里常是"第X部分"）折叠后超过 _FOLD_MAX_CHARS 时，子章独立
    成单元（标题带部前缀），保住 study 深度的章节颗粒度。
    """
    entries = []
    for ch in book.get("chapters", []):
        text = (ch.get("text") or "").strip()
        if ch.get("skipped") or not (text or ch.get("html")):
            continue
        title = (ch.get("title") or "").strip()
        if title in _SKIP_TITLES:
            continue
        entries.append((title, int(ch.get("level") or 1),
                        ch.get("chapterUid"), text))
    # 先按 level-1 分组：(父标题, 父uid, 父自有文字, [(子标题, 子uid, 子文字)])
    groups: list[dict] = []
    for title, level, uid, text in entries:
        if level <= 1 or not groups:
            groups.append({"title": title or f"第{len(groups) + 1}节", "uid": uid,
                           "own": text, "children": []})
        else:
            groups[-1]["children"].append({"title": title, "uid": uid, "text": text})
    units: list[dict] = []
    for group in groups:
        own, children = group["own"], group["children"]
        combined = len(own) + sum(len(c["text"]) for c in children)
        if combined <= _FOLD_MAX_CHARS:
            parts = [own] + [f"### {c['title']}\n{c['text']}" for c in children]
            units.append({"title": group["title"], "chapter_uid": group["uid"],
                          "text": "\n\n".join(p for p in parts if p)})
            continue
        if len(own) >= _PARENT_TEXT_MIN_CHARS:   # 部级自有导语单独成单元
            units.append({"title": group["title"], "chapter_uid": group["uid"],
                          "text": own})
        for child in children:
            units.append({"title": f"{group['title']}·{child['title']}",
                          "chapter_uid": child["uid"], "text": child["text"]})
    for i, unit in enumerate(units, 1):
        unit["idx"] = i
    return units


def book_to_corpus(book: dict) -> dict:
    """book.json → {text, metadata}。字段契约对齐 book-to-skill：
    estimated_tokens/chapters/chapters_method/has_toc/images_dropped。
    我们的章节树免猜：chapters_method 恒为 book-json-tree。"""
    units = chapter_units(book)
    invisible_removed = 0
    sections = []
    for unit in units:
        clean, removed = sanitize_text(unit["text"])
        invisible_removed += removed
        sections.append(f"# {unit['title']}\n{clean}")
    text = "\n\n".join(sections)
    images_dropped = sum(
        len(re.findall(r"<img\b", ch.get("html") or ""))
        for ch in book.get("chapters", []) if not ch.get("skipped"))
    metadata = {
        "bookId": str(book.get("bookId", "")),
        "title": book.get("title", ""),
        "author": book.get("author", ""),
        "format": book.get("format", ""),
        "chars": len(text),
        "words": len(text.split()),
        "estimated_tokens": estimate_tokens(text),
        "chapters": len(units),
        "chapters_method": "book-json-tree",
        "has_toc": True,
        "images_dropped": images_dropped,
        "partial": bool(book.get("partial", False)),
        "invisible_removed": invisible_removed,
    }
    return {"text": text, "metadata": metadata}


# ---- 蒸馏层 ----

_CHAPTER_PROMPT = """你是书籍结构蒸馏器。把下面一章蒸馏成 agent 可直接执行的参考卡。

书：《{title}》（{author}）
章：{chapter}（约 {src_tokens} token 原文 → 目标 ≤{budget} token）
深度：{depth}

必须输出以下小节（markdown，无前后废话）：
## Core Idea
（一句话：本章核心论点）
## Frameworks
- 框架名：When 适用场景。How 使用步骤。
## Key Concepts
- 概念（一句话定义）
## Key Takeaways
1. 可执行要点
{extra}
纪律：决策规则（When X do Y because Z）> 决策树 > 权衡；禁止整段抄原文散文；
禁止词条式定义堆砌（那是 glossary 的活）；数字/阈值/边界条件必须保留。
只输出 markdown 本身。

原文：
{source}"""

_STUDY_EXTRA = "\n## Worked Example\n（study 深度必须复现书中一个完整案例推演）\n"
_DEPTH_HINTS = {
    "sketch": "sketch——只留骨架：核心论点+框架名+一行用法",
    "reference": "reference——框架/概念/要点，够用即止",
    "study": "study——必须复现 Worked Example，深靠内容挣不靠数字凑",
}


def _core_of(md: str, fallback: str) -> str:
    m = re.search(r"##\s*Core Idea\s*\n+(.+?)(?:\n\s*\n|\n#|\Z)", md, re.S)
    if m:
        return m.group(1).strip().splitlines()[0].strip()
    for line in md.splitlines():
        stripped = line.lstrip("# ").strip()
        if stripped:
            return stripped
    return fallback


def _distill_chapter(deep_fn, book: dict, unit: dict, budget: int,
                     depth: str) -> tuple[str, bool]:
    prompt = _CHAPTER_PROMPT.format(
        title=book.get("title", ""), author=book.get("author", ""),
        chapter=unit["title"], src_tokens=estimate_tokens(unit["text"]),
        budget=budget, depth=_DEPTH_HINTS.get(depth, _DEPTH_HINTS["reference"]),
        extra=_STUDY_EXTRA if depth == "study" else "",
        source=unit["text"])
    try:
        md = (deep_fn(prompt, reasoning=True) or {}).get("text", "").strip()
        return md, False
    except Exception:
        return "", True        # 模型抖动：缺席但不崩，管线继续


def _loads_json_obj(text: str) -> dict:
    """健壮 JSON 对象解析：容忍代码围栏/前后废话/单键包装。

    金标准实战：模型会把提示里的字面标记（INDEX_JSON）当包装键回包
    {"INDEX_JSON": {...}}——解包单键 dict 包装，数据键提到顶层。
    """
    candidate = text.strip()
    fence = re.search(r"```(?:json)?\s*(.*?)```", candidate, re.S)
    if fence:
        candidate = fence.group(1).strip()
    start, end = candidate.find("{"), candidate.rfind("}")
    if start >= 0 and end > start:
        candidate = candidate[start:end + 1]
    try:
        obj = json.loads(candidate)
    except (ValueError, TypeError):
        return {}
    if not isinstance(obj, dict):
        return {}
    if len(obj) == 1:
        inner = next(iter(obj.values()))
        if isinstance(inner, dict):
            return inner
    return obj


_INDEX_PROMPT = """你是书籍索引器。基于各章核心句，为《{title}》技能包生成导航索引。

任务标记：INDEX_JSON。输出一个 JSON 对象（顶层就是下面的数据键，禁止再包一层），键：
- frameworks: ["框架名（Use 适用场景）", ...]（全书 ≤8 个）
- topics: [{{"term": "主题词", "chapters": [章号 int]}}]（≤12 个，agent 导航唯一通道）
- glossary: [{{"term": "术语", "def": "一句话定义", "chapter": 章号}}]（≤15 条）
- patterns: [{{"name": "模式名", "when": "何时用", "how": "怎么用"}}]（≤8 条）
- cheatsheet: [{{"when": "当…时", "do": "做…，因为…"}}]（决策规则，≤10 条）
只输出 JSON。

各章核心句：
{chapters}"""


def _distill_indexes(deep_fn, book: dict, chapters: list[dict]) -> dict:
    """索引蒸馏带一次重试——它是全书最后一只调用（跟在 N 次章节调用后），
    金标准实战里恰是它最容易被限流/抖动吞掉（异常→{} 全空索引）。"""
    lines = "\n".join(
        f"ch{c['idx']:02d} {c['title']}：{c['core']}" for c in chapters)
    prompt = _INDEX_PROMPT.format(title=book.get("title", ""), chapters=lines)
    for _attempt in range(2):
        try:
            obj = _loads_json_obj(
                (deep_fn(prompt, reasoning=True) or {}).get("text", ""))
        except Exception:
            obj = {}
        if obj.get("topics") or obj.get("frameworks"):
            break
    return {key: (obj.get(key) or []) for key in
            ("frameworks", "topics", "glossary", "patterns", "cheatsheet")}


def _skill_md(book: dict, chapters: list[dict], indexes: dict, depth: str) -> str:
    book_id = str(book.get("bookId", ""))
    title, author = book.get("title", ""), book.get("author", "")
    topics = indexes["topics"]
    keywords = "、".join(str(t.get("term", "")) for t in topics[:4] if t) or title
    lines = [
        "---",
        f"name: weread-{book_id}",
        f"description: 《{title}》（{author}）结构蒸馏技能包——框架/概念/决策规则速查。"
        f"Use when 需要引用《{title}》的框架做分析或决策时。关键词：{keywords}。",
        "---",
        f"# {title} 技能包",
        "",
        "## How to Use",
        "1. 查 Topic Index 定位主题 → 打开对应 chapters/chNN-*.md 懒加载细读；",
        "2. 决策场景先查 cheatsheet.md 决策规则，再查 patterns.md 模式；",
        f"3. 蒸馏深度 {depth}，章节有 token 预算，引用细节请回原书。",
        "",
        "## Topic Index",
    ]
    if topics:
        for t in topics:
            term = str(t.get("term", ""))
            chs = ", ".join(f"ch{int(n):02d}" for n in t.get("chapters", []) if n)
            lines.append(f"- **{term}** → {chs}")
    else:
        lines.append("- （本次未生成主题索引）")
    lines += ["", "## Chapter Index", "", "| 章 | 文件 | 标题 |", "|---|---|---|"]
    for c in chapters:
        fname = f"ch{c['idx']:02d}-{c['slug']}.md"
        lines.append(f"| ch{c['idx']:02d} | [{fname}](chapters/{fname}) | {c['title']} |")
    lines += ["", "## Frameworks"]
    if indexes["frameworks"]:
        lines += [f"- {f}" for f in indexes["frameworks"]]
    else:
        lines.append("- （见各章 md）")
    lines += [
        "",
        "## Scope & Limits",
        "- 结构蒸馏：框架/概念/决策规则，不替代原文叙事与案例；",
        "- 章节有预算，over_budget 标记的章可能失真，missing 标记的章需重跑；",
        "- 一切引用回原书（微信读书 bookId 见 package.json）。",
        "",
    ]
    return "\n".join(lines)


_INDEX_FILE_HEADERS = {
    "glossary": "# 术语表（glossary）",
    "patterns": "# 模式库（patterns）",
    "cheatsheet": "# 决策速查（cheatsheet：When X → do Y，because Z）",
}


def _index_file_text(name: str, indexes: dict) -> str:
    items = indexes.get(name) or []
    if name == "glossary":
        body = [f"- **{i.get('term', '')}** — {i.get('def', '')}"
                f"（ch{int(i.get('chapter', 0) or 0):02d}）" for i in items]
    elif name == "patterns":
        body = [f"- **{i.get('name', '')}**：When {i.get('when', '')}"
                f" → How {i.get('how', '')}" for i in items]
    else:
        # 模型 when 常自带"当…时"前后缀，避免渲染成"当 当…时 →"
        body = [f"- **{str(i.get('when', '')).strip().removeprefix('当')}"
                f"** → {i.get('do', '')}" for i in items]
    lines = [_INDEX_FILE_HEADERS[name], "", *(body or ["（无）"])]
    return "\n".join(lines) + "\n"


class GateError(RuntimeError):
    """出厂闸门拦截：外泄级阻断，不落盘。"""


def distill_book(book: dict, deep_fn, depth: str = "reference",
                 existing: dict | None = None) -> dict:
    """book.json → 技能包（内存形态）。

    existing 传上次产物执行 Update-Fold-in：同名章白拿不重算，新章续排。
    """
    if depth not in _DEPTHS:
        depth = "reference"
    budget = _DEPTHS[depth]
    units = chapter_units(book)
    old_by_title = ({c["title"]: c for c in existing["chapters"]}
                    if existing else {})
    chapters: list[dict] = []
    for unit in units:
        prev = old_by_title.get(unit["title"])
        if prev is not None:                      # fold-in：旧章白拿
            entry = {**prev, "idx": len(chapters) + 1,
                     "chapter_uid": unit["chapter_uid"]}
        else:
            md, missing = _distill_chapter(deep_fn, book, unit, budget, depth)
            clean, _removed = sanitize_text(md)
            chapters.append({
                "idx": len(chapters) + 1,
                "slug": slugify(unit["title"]),
                "title": unit["title"],
                "chapter_uid": unit["chapter_uid"],
                "md": clean,
                "core": _core_of(clean, unit["title"]),
                "missing": missing,
                "over_budget": estimate_tokens(clean) > int(budget * _OVER_BUDGET_FACTOR),
            })
            continue
        chapters.append(entry)
    indexes = _distill_indexes(deep_fn, book, chapters)
    skill_md = _skill_md(book, chapters, indexes, depth)
    corpus = book_to_corpus(book)
    skill_tokens = (estimate_tokens(skill_md)
                    + sum(estimate_tokens(c["md"]) for c in chapters)
                    + sum(estimate_tokens(_index_file_text(n, indexes))
                          for n in _INDEX_FILE_HEADERS))
    full_tokens = corpus["metadata"]["estimated_tokens"]
    roi = {
        "full_tokens": full_tokens,
        "skill_tokens": skill_tokens,
        "ratio": round(full_tokens / skill_tokens, 1) if skill_tokens else 0.0,
    }
    return {
        "book": {"bookId": str(book.get("bookId", "")), "title": book.get("title", ""),
                 "author": book.get("author", ""), "format": book.get("format", ""),
                 "depth": depth},
        "chapters": chapters,
        "indexes": indexes,
        "skill_md": skill_md,
        "roi": roi,
        "generated": date.today().isoformat(),
    }


def save_package(pkg: dict, out_dir: str) -> dict:
    """技能包落盘。先全量过闸门（剥离+扫描+外泄对检），有阻断即抛 GateError，
    一个文件都不写——拦截时目录保持不存在。"""
    texts: list[tuple[str, str]] = [("SKILL.md", pkg["skill_md"])]
    for c in pkg["chapters"]:
        fname = f"ch{c['idx']:02d}-{c['slug']}.md"
        texts.append((f"chapters/{fname}", c["md"]))
    for name in _INDEX_FILE_HEADERS:
        texts.append((f"{name}.md", _index_file_text(name, pkg["indexes"])))

    cleaned: list[tuple[str, str]] = []
    findings: list[dict] = []
    blockers: list[dict] = []
    for rel, text in texts:
        clean, found, blocked = guard_generated(text)
        cleaned.append((rel, clean))
        findings += [{**f, "file": rel} for f in found]
        blockers += [{**b, "file": rel} for b in blocked]
    if blockers:
        raise GateError(f"出厂闸门拦截（外泄级 {len(blockers)} 处，未落盘）："
                        + "; ".join(f"{b['file']}:{b['line']}" for b in blockers))

    files: list[str] = []
    for rel, clean in cleaned:
        path = os.path.join(out_dir, *rel.split("/"))
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, "w", encoding="utf-8", newline="\n") as fh:
            fh.write(clean if clean.endswith("\n") or not clean else clean + "\n")
        files.append(path)
    manifest = {
        "metadata": {**pkg["book"], "chapters": len(pkg["chapters"]),
                     "generated": pkg["generated"]},
        "roi": pkg["roi"],
        "scan_findings": findings,
    }
    manifest_path = os.path.join(out_dir, "package.json")
    with open(manifest_path, "w", encoding="utf-8", newline="\n") as fh:
        json.dump(manifest, fh, ensure_ascii=False, indent=2)
    return {"files": files, "manifest": manifest_path, "scan_findings": findings}
