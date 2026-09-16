# -*- coding: utf-8 -*-
"""CX 企微：会议列表/详情 → 会议参与人实体 + 会议事件入主时间轴。

- meeting get 详情 attendees[{userid, name, is_attended, duration}]：
  参与人 → person 实体（企微 userid 强标识符进别名）+ 与主人 associate_of 边
- 主人在场（attendees 含主人 userid）的会议 → EventEnvelope(type=meeting.attend)
  入主时间轴，payload 含主题与参与人名单（bystander 红线：只存聚合，不存纪要原文）
- 企微 name 常为"显示名(备注名)"格式：括号前为正名，括号内容进别名。
"""

from __future__ import annotations

import json
import re

from paistation.cx.events import EventEnvelope
from paistation.cx.ingest_sources import _parse_dt

_PAREN = re.compile(r"^(.*?)\((.*?)\)\s*$")


def _clean_name(raw: str) -> tuple[str, str | None]:
    """'总包君(总包君)' → ('总包君', None)；'张三(张工)' → ('张三', '张工')。"""
    m = _PAREN.match(raw.strip())
    if not m:
        return raw.strip(), None
    outer, inner = m.group(1).strip(), m.group(2).strip()
    return outer, (inner if inner and inner != outer else None)


def parse_wecom_meeting_details(json_text: str) -> list[dict]:
    """批次详情（[{meetings:[...]}] 或单批 {meetings:[...]}）→ 展平会议列表。"""
    try:
        data = json.loads(json_text)
    except ValueError:
        return []
    batches = data if isinstance(data, list) else [data]
    out: list[dict] = []
    for b in batches:
        for m in (b.get("meetings") or []) if isinstance(b, dict) else []:
            mid = (m.get("meeting_id") or "").strip()
            if not mid:
                continue
            attendees = []
            for a in m.get("attendees") or []:
                name, inner = _clean_name(a.get("name") or "")
                uid = (a.get("userid") or "").strip()
                if not name and not uid:
                    continue
                att = {"userid": uid, "name": name}
                if inner:
                    att["alias"] = inner
                attendees.append(att)
            out.append({
                "meeting_id": mid,
                "subject": (m.get("subject") or "").strip(),
                "begin_time": m.get("begin_time") or "",
                "end_time": m.get("end_time") or "",
                "attendees": attendees,
            })
    return out


def register_wecom_attendees(store, meetings: list[dict], owner_userid: str | None) -> dict:
    """参与人 → person 实体 + 与主人 associate_of 边（owner 自身跳过）。幂等。"""
    created = 0
    links = 0
    for m in meetings:
        for a in m["attendees"]:
            if not a["name"]:
                continue
            aliases = [x for x in (a.get("userid"), a.get("alias")) if x]
            eid, is_new = store.register("person", a["name"], aliases=aliases, source="wecom")
            created += int(is_new)
            if owner_userid and a["userid"] and a["userid"] != owner_userid:
                links += int(store.register_link(eid, "person/总包君", "associate_of", "wecom_meeting"))
    return {"persons_created": created, "links": links}


def collect_wecom_events(meetings: list[dict], owner_userid: str | None) -> list[EventEnvelope]:
    """主人在场的会议 → meeting.attend 事件（payload 聚合，无原文）。"""
    evs: list[EventEnvelope] = []
    for m in meetings:
        if owner_userid and not any(a["userid"] == owner_userid for a in m["attendees"]):
            continue
        if not m["begin_time"]:
            continue
        try:
            ev = EventEnvelope(
                source="wecom_meeting",
                source_id=m["meeting_id"],
                start=_parse_dt(m["begin_time"]),
                end=_parse_dt(m["end_time"]) if m["end_time"] else None,
                type="meeting.attend",
                payload={
                    "subject": m["subject"],
                    "attendees": [a["name"] for a in m["attendees"] if a["name"]],
                    "attendee_count": len(m["attendees"]),
                },
            )
        except Exception:
            continue
        evs.append(ev)
    return evs
