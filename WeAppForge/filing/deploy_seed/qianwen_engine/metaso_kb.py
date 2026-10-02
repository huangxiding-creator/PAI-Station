# -*- coding: utf-8 -*-
"""总包智库 KB 直连引擎（主引擎）。

契约（2026-09-28 实弹验证，复刻 We-AIPO src/metaso/api_client.py 破解层；
2026-09-30 单发 SSE 探针补全流契约）：
  POST /api/knowledge/chat  body={model,stream,messages[{id,conversationId,role,content,parentId}],
        topicId,scope:'knowledge',searchFile:false,'metaso-pc':'pc',token}
        headers={Content-Type,json; token: meta-token} Cookie=网页会话 → SSE：
        ① type=conversation_init → {data.id}=cid（t≈0）
        ② type=heartbeat ×N（知识库检索中）
        ③ OpenAI 兼容 chat.completion.chunk → choices[0].delta.content = 回答增量正文
           （含 [[书名†页]] 引用标记；流走完=回答完成）→ v0.7.0 起直接消费此流
  GET  /api/conversation/{cid}/branched-messages → data.activePathMessages[].content.stages[]
        兜底轮询线：stage 里的 texts[].text 拼接，取最长者（生成中最后 stage 常为空，
        只取最后一段会恒得空串——v0.6.0 字数=0 事故根因）

护栏（账号安全四件套）：节流 / 日积分硬顶 / 熔断 / 会话失效自动刷新重试一次。
"""
from __future__ import annotations

import json
import re
import threading
import time
import uuid
from dataclasses import dataclass, field
from typing import Callable, Optional

from curl_cffi import requests as cr

from . import config, session as kb_session


class EngineError(RuntimeError):
    """引擎业务错误（对外可展示）。"""


class CircuitOpen(EngineError):
    """熔断打开。"""


class DailyCapExceeded(EngineError):
    """当日积分硬顶。"""


@dataclass
class KbAnswer:
    question: str
    answer: str
    cid: str
    url: str
    citations: list = field(default_factory=list)
    elapsed_sec: float = 0.0


# ── 护栏状态（进程内；跨进程由调用方持久化用量） ───────────────
_guard = threading.Lock()
_last_ask_ts = 0.0
_fail_streak = 0
_breaker_open_until = 0.0
_points_used_today = 0
_today_str = ""


def _today() -> str:
    return time.strftime("%Y-%m-%d")


def _guard_enter(cost: int = 3) -> None:
    """节流 + 日顶 + 熔断三闸（阻塞式节流）。"""
    global _last_ask_ts, _fail_streak, _breaker_open_until, _points_used_today, _today_str
    with _guard:
        if _today_str != _today():
            _today_str, _points_used_today = _today(), 0
        now = time.time()
        if now < _breaker_open_until:
            wait_min = (_breaker_open_until - now) / 60
            raise CircuitOpen(f"熔断中，约{wait_min:.0f}分钟后半开")
        elapsed = now - _last_ask_ts
        if elapsed < config.KB_MIN_INTERVAL_SEC:
            time.sleep(config.KB_MIN_INTERVAL_SEC - elapsed)
        _last_ask_ts = time.time()
        if _points_used_today + cost > config.KB_DAILY_POINT_CAP:
            raise DailyCapExceeded(
                f"今日积分已用 {_points_used_today}/{config.KB_DAILY_POINT_CAP}，明日恢复"
            )
        _points_used_today += cost


def _record(ok: bool) -> None:
    global _fail_streak, _breaker_open_until
    with _guard:
        if ok:
            _fail_streak = 0
        else:
            _fail_streak += 1
            if _fail_streak >= config.KB_BREAKER_THRESHOLD:
                _breaker_open_until = time.time() + config.KB_BREAKER_RECOVERY_SEC
                _fail_streak = 0


def points_used_today() -> int:
    with _guard:
        if _today_str != _today():
            return 0
        return _points_used_today


# ── 引用清洗 ───────────────────────────────────────────────
_CITE_RE = re.compile(r"\[\[([^\[\]†]+)†(\d+)\]\]")


def split_citations(text: str) -> tuple[str, list]:
    """拆出正文与引用列表 [[书名†页]]。正文角标替换为 [n]。"""
    cites: list = []
    idx: dict = {}

    def _sub(m: re.Match) -> str:
        key = (m.group(1).strip(), m.group(2))
        if key not in idx:
            idx[key] = len(cites) + 1
            cites.append({"source": key[0], "loc": key[1], "n": idx[key]})
        return f"[{idx[key]}]"

    body = _CITE_RE.sub(_sub, text)
    return body, cites


# ── 核心调用 ───────────────────────────────────────────────
_DELTA_CONTENT_RE = re.compile(r'"delta"\s*:\s*\{[^}]*?"content"\s*:\s*"((?:[^"\\]|\\.)*)"')


def _decode_json_str(s: str) -> str:
    r"""SSE 行内 JSON 字符串反转义（\n \t \" \\ \uXXXX）。"""
    try:
        return json.loads('"' + s + '"')
    except Exception:  # noqa: BLE001 — 容错：原样返回
        return s


def _chat_post_stream(sess: dict, question: str, model: str,
                      on_event: Optional[Callable] = None,
                      deadline_ts: float = 0.0) -> tuple:
    """提交问题并消费整条 SSE 流 → (cid, 全文, 是否流完成)。

    流契约（0930 探针）：conversation_init 提 cid → heartbeat 检索中 →
    chat.completion.chunk.choices[0].delta.content 增量正文。
    每有新增即 on_event("streaming", {"chars", "partial"})——真流式字数+打字机素材。
    流中断/超时：返回已累计文本，由调用方走 branched-messages 兜底轮询。
    """
    tmp = "temp-" + uuid.uuid4().hex[:12]
    body = {
        "model": model,
        "stream": True,
        "messages": [{
            "id": tmp, "conversationId": tmp,
            "role": "user", "content": question, "parentId": None,
        }],
        "topicId": config.KB_TOPIC_ID,
        "scope": "knowledge",
        "include": None, "exclude": None,
        "searchFile": False,
        "metaso-pc": "pc",
        "token": sess["token"],
    }
    r = cr.post(
        config.KB_CHAT_URL,
        headers={"Content-Type": "application/json", "token": sess["token"],
                 "Cookie": sess["cookie"]},
        json=body, impersonate="chrome", stream=True,
        timeout=config.KB_ASK_TIMEOUT_SEC,
    )
    if r.status_code in (401, 403):
        raise kb_session.KbSessionError(f"HTTP {r.status_code} 会话失效")
    if r.status_code != 200:
        raise EngineError(f"chat HTTP {r.status_code}: {r.text[:120]}")

    cid = ""
    buf: list = []
    chars = 0
    stream_done = False
    try:
        for chunk in r.iter_lines():
            if not chunk:
                continue
            if deadline_ts and time.time() > deadline_ts:
                break
            line = chunk.decode("utf-8", errors="replace")
            if not cid:
                m = re.search(r'"type"\s*:\s*"conversation_init"', line)
                if m:
                    m2 = re.search(r'"id"\s*:\s*"(\d{10,})"', line)
                    if m2:
                        cid = m2.group(1)
                        _emit(on_event, "delivered", {"cid": cid})
                else:
                    m3 = re.search(r'"id"\s*:\s*"(\d{15,})"', line)
                    if m3:
                        cid = m3.group(1)
                        _emit(on_event, "delivered", {"cid": cid})
                continue
            # cid 已到手：只认增量正文事件（chat.completion.chunk）
            for m in _DELTA_CONTENT_RE.finditer(line):
                piece = _decode_json_str(m.group(1))
                if piece:
                    buf.append(piece)
                    chars += len(piece)
            if '"type":"chunk"' in line or '"type": "chunk"' in line:
                stream_done = True
            if buf:
                _emit(on_event, "streaming",
                      {"chars": chars, "partial": "".join(buf)})
    except Exception:  # noqa: BLE001 — 网络中断：带着已收文本走兜底
        pass
    finally:
        try:
            r.close()
        except Exception:  # noqa: BLE001
            pass
    return cid, "".join(buf), stream_done


def _fulltext_get(sess: dict, cid: str) -> str:
    """兜底轮询线：取各 stage 全文里最长者（生成中最后 stage 常为空）。"""
    r = cr.get(
        config.KB_CONV_URL.format(cid=cid),
        headers={"token": sess["token"], "Cookie": sess["cookie"]},
        impersonate="chrome", timeout=60,
    )
    if r.status_code != 200:
        return ""
    try:
        d = r.json()
    except Exception:
        return ""
    best = ""

    for msg in (d.get("data", {}).get("activePathMessages") or []):
        stages = ((msg or {}).get("content") or {}).get("stages") or []
        for st_ in stages:
            t = "".join(tx.get("text", "") for tx in (st_.get("texts") or []))
            if len(t) > len(best):
                best = t
    return best


_INTRO_MARKERS = ("知识库", "介绍", "订阅", "开通")


def _looks_like_intro(text: str) -> bool:
    """积分耗尽时 KB 返回介绍页文案而非回答（We-AIPO K1 判据移植）。"""
    return 0 < len(text) < config.MIN_ANSWER_LEN and all(
        kw in text for kw in _INTRO_MARKERS[:2]
    )


def _emit(cb: Optional[Callable], kind: str, data: Optional[dict] = None) -> None:
    """阶段事件外送（透明化）：cb 异常不得影响主流程。"""
    if cb is None:
        return
    try:
        cb(kind, data or {})
    except Exception:
        pass


def ask(question: str, model: str = "fast",
        sleep: Callable[[float], None] = time.sleep,
        on_event: Optional[Callable] = None) -> KbAnswer:
    """问总包智库一个问题，阻塞至回答完成（SSE 流式消费 ≤150s + 兜底轮询 ≤120s）。

    v0.7.0：直接吃 chat.completion.chunk 增量流——真字数进度 + 流中断不判死
    （带着已收文本走 branched-messages 兜底轮询），根治「轮数走满判超时」事故。

    Raises: CircuitOpen / DailyCapExceeded / EngineError / KbSessionError
    """
    question = (question or "").strip()
    if not question:
        raise EngineError("问题为空")
    if len(question) > 500:
        question = question[:500]

    _guard_enter(cost=3)
    _emit(on_event, "submitted")
    t0 = time.time()
    sess = kb_session.get_session()
    try:
        deadline = time.time() + config.KB_STREAM_TIMEOUT_SEC
        try:
            cid, answer, stream_done = _chat_post_stream(
                sess, question, model, on_event=on_event, deadline_ts=deadline)
        except kb_session.KbSessionError:
            # 会话失效 → 在线刷新一次重试
            _emit(on_event, "session_refreshing")
            kb_session.invalidate()
            sess = kb_session.get_session(force_refresh=True)
            cid, answer, stream_done = _chat_post_stream(
                sess, question, model, on_event=on_event, deadline_ts=deadline)

        # 兜底线：流未完成/文本不足 → branched-messages 轮询补齐
        if len(answer) < config.MIN_ANSWER_LEN and cid:
            for i in range(config.KB_POLL_MAX_ROUNDS):
                sleep(config.KB_POLL_INTERVAL_SEC)
                got = _fulltext_get(sess, cid)
                if len(got) > len(answer):
                    answer = got
                _emit(on_event, "polling", {"round": i + 1, "chars": len(answer)})
                if len(answer) >= config.MIN_ANSWER_LEN:
                    break
        if not answer:
            raise EngineError("回答超时/为空")
        if _looks_like_intro(answer):
            raise DailyCapExceeded("网页积分可能耗尽（返回介绍页）")
        _record(ok=True)
        body, cites = split_citations(answer)
        return KbAnswer(
            question=question, answer=body, cid=cid,
            url=f"https://metaso.cn/subject-v2/{config.KB_TOPIC_ID}?conversationId={cid}",
            citations=cites, elapsed_sec=time.time() - t0,
        )
    except (CircuitOpen, DailyCapExceeded):
        raise
    except kb_session.KbSessionError:
        _record(ok=False)
        raise
    except Exception as exc:  # noqa: BLE001
        _record(ok=False)
        raise EngineError(f"KB 问答失败: {exc}") from exc


# ── 外援腿：search-api chat（API 积分池；须充值，P0 默认关） ──
def search_api_key() -> str:
    f = config.SEARCH_API_KEY_FILE
    if not f.exists():
        return ""
    for line in f.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if line and not line.startswith("#"):
            return line.split("=", 1)[-1].strip()
    return ""


def search_ask(question: str, model: str = "fast") -> str:
    """公网问答（带 [[n]] 网络引用）。API 积分池按点计费，P0 仅按需单查。"""
    key = search_api_key()
    if not key:
        raise EngineError("search-api 未配置 key")
    r = cr.post(
        config.SEARCH_CHAT_URL,
        headers={"Authorization": f"Bearer {key}", "Accept": "application/json",
                 "Content-Type": "application/json"},
        json={"model": model, "stream": False,
              "messages": [{"role": "user", "content": question}]},
        impersonate="chrome", timeout=120,
    )
    if r.status_code != 200:
        raise EngineError(f"search-api HTTP {r.status_code}: {r.text[:120]}")
    d = r.json()
    return (d.get("choices") or [{}])[0].get("message", {}).get("content", "")


def engine_status() -> dict:
    return {
        "points_used_today": points_used_today(),
        "daily_point_cap": config.KB_DAILY_POINT_CAP,
        "session_stale_sec": kb_session.stale_seconds(),
    }
