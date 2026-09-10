"""B2「书→记忆闭环」：RIA 出题 → 人改写关卡 → fsrs 分档入队 → Anki 导出。

制卡纪律吸收自生态共识（GITHUB_CATALOG L2 层）：AnkiGPT 人审准入（AI 会错，
卡必须人审）、Lute 卡正面带原文语境（防脱离语境死卡）、llm-flashcards 一卡一
概念、genanki GUID 只哈希身份字段（人改写→原地更新，复习历史不丢）、
flashcards-obsidian 权责铁律（AI-Station 拥有内容，Anki 只拥有调度历史）。
"""
from __future__ import annotations

import hashlib
import json
import os
import re

from .fsrs_queue import FsrsQueue

RIA_TYPES = ("concept", "action")
DEFAULT_QUOTAS = {"concept": 3, "action": 2}
# py-fsrs desired_retention 分档：概念卡求准（0.9），行动卡求频（0.8）
_RETENTION_BY_TYPE = {"concept": 0.9, "action": 0.8}
_MAX_QUOTE_CHARS = 80
STAGED_FILENAME = "cards_staged.json"

_RIA_PROMPT = """你是 RIA 制卡器（阅读 R 摘录 / I 转述 / A 行动）。基于书中一章出记忆卡。

书：《{title}》（{author}）
章：{chapter}
配额：概念卡 {n_concept} 张 / 行动卡 {n_action} 张（一卡一概念，宁缺毋滥）。

每张卡输出 JSON 对象：
- concept（概念卡）：quote=本章原句（≤{max_quote}字，必须原文照录）；
  question="书中说「{quote_snippet}」，指的是什么？"风格；retell=一句话转述；action 留空。
- action（行动卡）：quote=触发行动的原句；question="如何应用…？"；
  retell=一句话原则；action=SMART 行动（本周可执行，有动词有对象）。

只输出 JSON 数组：[{{"type": "concept|action", "quote": "...", "question": "...",
"retell": "...", "action": "..."}}]

原文：
{text}"""


def card_retention(card: dict) -> float:
    """按卡型分档目标记忆率：concept 0.9 / action 0.8。"""
    return _RETENTION_BY_TYPE.get(card.get("type"), 0.9)


def _loads_json_array(text: str) -> list:
    """健壮 JSON 数组解析：容忍代码围栏与前后废话。"""
    candidate = text.strip()
    fence = re.search(r"```(?:json)?\s*(.*?)```", candidate, re.S)
    if fence:
        candidate = fence.group(1).strip()
    start, end = candidate.find("["), candidate.rfind("]")
    if start >= 0 and end > start:
        candidate = candidate[start:end + 1]
    try:
        obj = json.loads(candidate)
    except (ValueError, TypeError):
        return []
    return obj if isinstance(obj, list) else []


def generate_cards(book: dict, deep_fn, quotas: dict | None = None) -> list[dict]:
    """全书出卡（配额为全书总量，逐章填充，填满即止）。

    模型失败/解析失败 → 该章不出卡；全空则返回 []（缺席不崩纪律）。
    """
    remaining = dict(quotas or DEFAULT_QUOTAS)
    cards: list[dict] = []
    book_id = str(book.get("bookId", ""))
    for chapter in book.get("chapters", []):
        if chapter.get("skipped") or not (chapter.get("text") or "").strip():
            continue
        if all(v <= 0 for v in remaining.values()):
            break
        try:
            prompt = _RIA_PROMPT.format(
                title=book.get("title", ""), author=book.get("author", ""),
                chapter=chapter.get("title", ""),
                n_concept=max(remaining.get("concept", 0), 0),
                n_action=max(remaining.get("action", 0), 0),
                max_quote=_MAX_QUOTE_CHARS, quote_snippet="原句关键词",
                text=chapter.get("text", ""))
            raw = _loads_json_array(
                (deep_fn(prompt, reasoning=True) or {}).get("text", ""))
        except Exception:
            continue
        valid = [c for c in raw if isinstance(c, dict)
                 and c.get("type") in RIA_TYPES and (c.get("question") or "").strip()]
        kept: list[dict] = []
        for card_type in RIA_TYPES:
            wanted = remaining.get(card_type, 0)
            if wanted <= 0:
                continue
            take = [c for c in valid if c.get("type") == card_type][:wanted]
            kept += take
            remaining[card_type] -= len(take)
        kept.sort(key=lambda c: valid.index(c))       # 恢复模型原顺序
        for seq, c in enumerate(kept, 1):
            cards.append({
                "card_id": f"{book_id}-{chapter.get('chapterUid')}-{seq:02d}",
                "book_id": book_id,
                "chapter_uid": chapter.get("chapterUid"),
                "type": c["type"],
                "quote": (c.get("quote") or "")[:_MAX_QUOTE_CHARS],
                "question": (c.get("question") or "").strip(),
                "retell": (c.get("retell") or "").strip(),
                "action": (c.get("action") or "").strip(),
                "source": f"{book.get('title', '')}·{chapter.get('title', '')}",
                "staged": False,
            })
    return cards


def stage_cards(cards: list[dict], book_dir: str) -> str:
    """卡入暂存区 cards_staged.json（人改写关卡的工作面；重复 card_id 幂等合并）。"""
    path = os.path.join(book_dir, STAGED_FILENAME)
    existing: list[dict] = []
    if os.path.exists(path):
        try:
            with open(path, encoding="utf-8") as fh:
                existing = json.load(fh).get("cards", [])
        except (OSError, ValueError):
            existing = []
    by_id = {c["card_id"]: {**c, "staged": True} for c in existing}
    for card in cards:
        by_id[card["card_id"]] = {**card, "staged": True}
    staged = list(by_id.values())
    os.makedirs(book_dir, exist_ok=True)
    with open(path, "w", encoding="utf-8", newline="\n") as fh:
        json.dump({"cards": staged}, fh, ensure_ascii=False, indent=2)
    return path


def _card_back(card: dict) -> str:
    """概念卡：转述；行动卡：行动指令（C2 模板派生 R→I 正面卡 + A 行动卡）。"""
    if card.get("type") == "action" and card.get("action"):
        return f"行动：{card['action']}"
    return card.get("retell", "")


def commit_cards(staged_path: str, queue: FsrsQueue, edits: dict) -> dict:
    """人改写关卡：仅 edits[id]["approved"] is True 的卡准入队。

    edits 可覆写 question/retell/action（AnkiGPT 纪律：逐卡编辑/删除才准进）。
    其余留在暂存区，下次继续审。
    """
    with open(staged_path, encoding="utf-8") as fh:
        staged = json.load(fh).get("cards", [])
    committed: list[str] = []
    remaining: list[dict] = []
    for card in staged:
        edit = edits.get(card["card_id"]) or {}
        if edit.get("approved") is not True:
            remaining.append(card)
            continue
        final = {**card}
        for field in ("question", "retell", "action"):
            if edit.get(field):
                final[field] = edit[field]
        queue.add(front=final["question"], back=_card_back(final),
                  source=final.get("source", ""),
                  retention=card_retention(final))
        committed.append(final["card_id"])
    with open(staged_path, "w", encoding="utf-8", newline="\n") as fh:
        json.dump({"cards": remaining}, fh, ensure_ascii=False, indent=2)
    return {"committed": committed, "remaining": len(remaining)}


def guid_for(card: dict) -> int:
    """genanki GUID=身份字段哈希（bookId+chapterUid+seq）——人改写后重导出
    = Anki 原地更新，复习历史不丢（genanki 官方推荐做法）。"""
    identity = f"{card.get('book_id', '')}|{card.get('chapter_uid', '')}|{card.get('seq', 0)}"
    return int(hashlib.md5(identity.encode("utf-8")).hexdigest()[:12], 16)


_APKG_MODEL_ID = int(hashlib.md5(b"paistation-ria-v1").hexdigest()[:8], 16)


def export_apkg(cards: list[dict], out_path: str, deck_name: str = "RIA") -> str:
    """导出 .apkg（genanki，可选依赖 `pip install paistation[anki]`）。"""
    try:
        import genanki
    except ImportError as exc:
        raise RuntimeError("缺少 genanki，安装：.venv/Scripts/python -m pip install genanki"
                           ) from exc
    model = genanki.Model(
        _APKG_MODEL_ID,
        "RIA Note",
        fields=[{"name": name} for name in ("Question", "Retell", "Action", "Source")],
        templates=[{
            "name": "RIA Card",
            "qfmt": "{{Question}}",
            "afmt": ('{{FrontSide}}<hr id="answer">'
                     "转述：{{Retell}}<br>行动：{{Action}}"
                     "<br><small>{{Source}}</small>"),
        }])
    deck = genanki.Deck(
        int(hashlib.md5(deck_name.encode("utf-8")).hexdigest()[:8], 16), deck_name)
    for card in cards:
        note = genanki.Note(
            guid=guid_for(card), model=model,
            fields=[card.get("question", ""), card.get("retell", ""),
                    card.get("action", ""), card.get("source", "")])
        deck.add_note(note)
    parent = os.path.dirname(os.path.abspath(out_path))
    os.makedirs(parent, exist_ok=True)
    deck.write_to_file(out_path)   # genanki ≥0.13 API（旧版叫 write_file）
    return out_path
