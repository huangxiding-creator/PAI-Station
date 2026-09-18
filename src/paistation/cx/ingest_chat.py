# -*- coding: utf-8 -*-
"""微信群聊（wechat-cli history）→ 统一事件封套（关系维时间层）。

聊天面入轴纪律（2026-09-18 定型）：**纯元数据聚合，零内容**。
只聚合（群, 日, 发送者）计数与消息类型分布，消息正文永不入轴、
永不入画像产物——在场关系（谁和主人同群同日活跃）即可满足时间层，
bystander 风险最低。9-16 拍板：混合源只解析工作面，群聊为半职业空间。

数据形态（wechat-cli history --format json）：
    {"chat": 群显示名, "username": "xxx@chatroom", "messages": [
        "[YYYY-MM-DD HH:MM[:SS]] 发送者: [类型] 内容", ...]}

source_id = "<chatroom_id>#<日>"：全量回填幂等，重跑只补新日。
发送者 "me" = 本人（保留原样，主人锚点另行管理）。
"""

from __future__ import annotations

import json
import re
from collections import Counter
from datetime import datetime
from pathlib import Path
from typing import Any

from .events import EventEnvelope

SOURCE = "wechat_chat"
EVENT_TYPE = "chat.activity"

# "[2025-09-01 07:56] me: [链接/文件]" → 日/时刻/发送者/内容
_LINE_RE = re.compile(
    r"^\[(\d{4}-\d{2}-\d{2}) (\d{2}:\d{2})(?::(\d{2}))?\] (.+?):(?: (.*))?$",
    re.DOTALL,
)

# 内容头的 [类型] 标签 → 归一化类型（未命中保留原文标签）
_TAG_RE = re.compile(r"^\[([^\]]{1,10})\]")
_TAG_MAP = {
    "图片": "image",
    "链接/文件": "link",
    "链接": "link",
    "文件": "file",
    "语音": "voice",
    "视频": "video",
    "动画表情": "sticker",
    "位置": "location",
    "系统消息": "system",
    "红包": "gift",
    "转账": "gift",
    "音乐": "link",
    "小程序": "link",
    "聊天记录": "note",
    "引用": "quote",
}


def normalize_type(content: str) -> str:
    """内容 → 归一化消息类型（不看正文语义，只认标签头）。"""
    m = _TAG_RE.match(content)
    if not m:
        return "text"
    tag = m.group(1)
    return _TAG_MAP.get(tag, tag)


def parse_messages(lines: list[str]) -> list[tuple[str, str, str, str]]:
    """文本行 → [(日, HH:MM:SS, 发送者, 类型)]；不可解析行跳过。"""
    out: list[tuple[str, str, str, str]] = []
    for line in lines:
        m = _LINE_RE.match(line.strip())
        if not m:
            continue
        day, hhmm, ss, sender, content = m.groups()
        ts = f"{hhmm}:{ss or '00'}"
        out.append((day, ts, sender, normalize_type(content or "")))
    return out


def parse_history_doc(
    doc: dict[str, Any], group_user: str, group_name: str
) -> list[EventEnvelope]:
    """一个群的 history JSON 封套 → 按（日）聚合的封套事件列表。

    每日一事件：payload={group, senders:{名:条数}, types:{类型:条数}, total}，
    start=当日最后一条消息时刻（本地时间，封套层统一转 UTC）。
    """
    bucket: dict[str, dict[str, Any]] = {}
    for day, ts, sender, typ in parse_messages(doc.get("messages") or []):
        b = bucket.setdefault(
            day, {"senders": Counter(), "types": Counter(), "last": "00:00:00"}
        )
        b["senders"][sender] += 1
        b["types"][typ] += 1
        if ts >= b["last"]:  # 同 HH:MM:SS 字典序即时序
            b["last"] = ts

    events: list[EventEnvelope] = []
    for day in sorted(bucket):
        b = bucket[day]
        start = datetime.fromisoformat(f"{day}T{b['last']}")
        events.append(
            EventEnvelope(
                source=SOURCE,
                source_id=f"{group_user}#{day}",
                start=start,
                type=EVENT_TYPE,
                payload={
                    "group": group_name,
                    "senders": dict(b["senders"]),
                    "types": dict(b["types"]),
                    "total": sum(b["senders"].values()),
                },
            )
        )
    return events


def load_history_file(path) -> list[EventEnvelope]:
    """缓存文件 → 事件列表（文件损坏返回空）。"""
    try:
        doc = json.loads(Path(path).read_text(encoding="utf-8"))
    except (json.JSONDecodeError, OSError):
        return []
    return parse_history_doc(
        doc, doc.get("username") or Path(path).stem, doc.get("chat") or ""
    )
