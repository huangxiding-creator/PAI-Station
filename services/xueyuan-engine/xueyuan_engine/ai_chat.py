# -*- coding: utf-8 -*-
"""AI 伴读域 [P2]——FR-P2-01 scaffold：POST /reports/{rid}/chat（Bearer+已购闸）。

免费模型铁律（照 criticize judge 双 provider 模式；付费 API 调用数=0）：
- 默认 provider=local=确定性检索式应答：问句→jieba 切词→已购章命中段抽取+
  原文引用页码（page 为 CHARS_PER_PAGE 估算口径），answer 诚实标注
  「检索式应答，待接免费模型」——零外呼零计费；
- openai_compat 适配器留缝（XY_CHAT_PROVIDER=openai_compat + XY_CHAT_BASE_URL/
  XY_CHAT_MODEL/XY_CHAT_API_KEY 或 XY_CHAT_KEY_FILE；密钥只走 env/secrets
  路径，代码零密钥），仅当运维显式确认**免费**端点后启用；站内
  qianwen-engine 两腿（KB 网页池/search-api）均积分制付费资源，禁止接入；
- 真腿失败→降级回 local 检索式（伴读能力下线不伤 P0/P1，开关降级，FR-P2-01）。

引用 quote 复用 owned_search.make_snippet（命中句 ±40 字，最小暴露面）。
"""
from __future__ import annotations

import logging
import os
from pathlib import Path

from curl_cffi import requests as cr
from fastapi import APIRouter, Request
from pydantic import BaseModel

from . import config, store, wechat
from .catalog import chapter_rows, get_report
from .chapters import _entitled
from .errors import ApiError
from .fts import tokenize
from .owned_search import make_snippet, plain_text

router = APIRouter(prefix="/api/v1", tags=["ai-chat"])
logger = logging.getLogger("xueyuan.ai_chat")

DISCLAIMER = "检索式应答，待接免费模型"


class ChatIn(BaseModel):
    question: str


def chat_provider() -> str:
    return (os.environ.get("XY_CHAT_PROVIDER") or "local").strip().lower()


def estimate_page(chapters: list[dict], chapter_id: str, offset: int) -> int:
    """页码估算（纯函数）：前序章按 char_count 折页 + 章内偏移折页。

    CHARS_PER_PAGE 口径与详情页 trial_pages 同源（估算非精确排版页）。
    """
    cum_pages = 0
    for ch in sorted(chapters, key=lambda c: c["idx"]):
        pages = max(1, -(-int(ch.get("char_count") or 0) // config.CHARS_PER_PAGE)) \
            if ch.get("char_count") else 1
        if ch["id"] == chapter_id or ch["id"].split("/")[-1] == chapter_id:
            return cum_pages + offset // config.CHARS_PER_PAGE + 1
        cum_pages += pages
    return max(1, offset // config.CHARS_PER_PAGE + 1)


def retrieve_segments(question: str, chapters: list[dict],
                      top_k: int | None = None) -> list[dict]:
    """确定性检索：问句切词→各章命中计数→Top-K 段（带 quote/page/offset）。"""
    top_k = config.CHAT_TOP_K if top_k is None else top_k
    toks = sorted({t.lower() for t in tokenize(question.strip()) if t.strip()})
    scored: list[tuple[int, dict, str, int]] = []
    for ch in chapters:
        plain = plain_text(ch.get("html") or "")
        if not plain:
            continue
        low = plain.lower()
        positions = [low.find(t) for t in toks if t and low.find(t) >= 0]
        if not positions:
            continue
        scored.append((len(positions), ch, plain, min(positions)))
    scored.sort(key=lambda x: (-x[0], x[1]["idx"]))
    out: list[dict] = []
    for _, ch, plain, first in scored[:top_k]:
        quote, offset = make_snippet(plain, first)
        out.append({"chapter_id": ch["id"].split("/")[-1],
                    "chapter_title": ch["title"], "page": estimate_page(
                        chapters, ch["id"], offset),
                    "quote": quote})
    return out


def local_answer(question: str, report: dict, chapters: list[dict]) -> tuple[str, list[dict]]:
    """检索式应答（零外呼；无命中诚实说无，不编造）。"""
    cites = retrieve_segments(question, chapters)
    if not cites:
        return (f"在《{report.get('title', '')}》中未检索到与您提问直接相关的内容。"
                f"{DISCLAIMER}"), []
    best = cites[0]
    answer = (f"依据《{report.get('title', '')}》检索，与您提问最相关的段落位于"
              f"「{best['chapter_title']}」（约第 {best['page']} 页）：\n"
              f"「{best['quote']}」\n以上为报告原文命中段，供溯源核对。{DISCLAIMER}")
    return answer, cites


# ── openai_compat 适配缝（密钥只走 env/secret 路径；未配置=RuntimeError）──
def _chat_prompt(question: str, report: dict, context: str) -> str:
    return ("你是研报伴读助手。只依据下述报告摘段回答用户问题，引用章节与数据，"
            "不得编造；摘段没有相关信息就明确说明。\n"
            f"报告：{report.get('title', '')}\n摘段：\n{context}\n"
            f"用户问题：{question}")


def _openai_compat_chat(question: str, report: dict,
                        chapters: list[dict]) -> tuple[str, list[dict]]:
    """OpenAI 兼容端点适配（仅免费端点；失败抛错由端点降级回 local）。"""
    base = os.environ.get("XY_CHAT_BASE_URL", "").rstrip("/")
    model = os.environ.get("XY_CHAT_MODEL", "")
    key = os.environ.get("XY_CHAT_API_KEY", "")
    keyfile = os.environ.get("XY_CHAT_KEY_FILE", "")
    if not key and keyfile and Path(keyfile).exists():
        key = Path(keyfile).read_text(encoding="utf-8").strip()
    if not (base and model):
        raise RuntimeError("XY_CHAT_* 未配置（openai_compat provider 不可用）")
    cites = retrieve_segments(question, chapters)
    context = "\n".join(
        f"[{c['chapter_title']}·约第{c['page']}页] {c['quote']}" for c in cites
    ) or "（无命中摘段）"
    r = cr.post(
        f"{base}/chat/completions",
        headers={"Authorization": f"Bearer {key}"},
        json={"model": model, "temperature": 0,
              "messages": [{"role": "user", "content": _chat_prompt(
                  question, report, context)}]},
        timeout=60,
    )
    r.raise_for_status()
    content = str(((r.json().get("choices") or [{}])[0].get("message") or {})
                  .get("content") or "").strip()
    if not content:
        raise RuntimeError("openai_compat 回包空 content")
    return content, cites


@router.post("/reports/{rid}/chat")
def chat(rid: str, body: ChatIn, request: Request):
    """AI 伴读提问（Bearer+已购闸；能力降级不伤 P0/P1）。"""
    openid = wechat.bearer_openid(request)
    if not openid:
        raise ApiError(401, "UNAUTHORIZED", "未登录或凭证过期")
    uid = store.get_or_create_user(openid)["id"]
    report = get_report(rid)
    if not report:
        raise ApiError(404, "REPORT_NOT_FOUND", "报告不存在或已下架")
    if not _entitled(uid, rid):  # 已购闸：伴读仅对已购用户开放
        raise ApiError(403, "NOT_ENTITLED", "尚未解锁该研报")
    question = (body.question or "").strip()
    if not question or len(question) > config.CHAT_QUESTION_MAX:
        raise ApiError(400, "INVALID_PARAM",
                       f"问句须为 1-{config.CHAT_QUESTION_MAX} 字")
    chapters = chapter_rows(rid)
    provider = chat_provider()
    degraded = False
    if provider == "openai_compat":
        try:
            answer, cites = _openai_compat_chat(question, report, chapters)
        except Exception:  # noqa: BLE001 —— 真腿故障降级回 local（不伤主链）
            logger.exception("openai_compat 伴读失败，降级检索式应答")
            answer, cites = local_answer(question, report, chapters)
            degraded = True
    else:
        answer, cites = local_answer(question, report, chapters)
    return {
        "report_id": rid, "question": question, "answer": answer,
        "provider": "local" if degraded else provider, "citations": cites,
        "degraded": degraded,
        "disclaimer": DISCLAIMER if (provider == "local" or degraded) else "",
    }
