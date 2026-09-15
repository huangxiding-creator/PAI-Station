# -*- coding: utf-8 -*-
"""M9a 腾讯会议连接器：用户会议列表/状态变化 → cloud.meeting.list 事件。

token 即授权材料（用户自 meeting.tencent.com/ai-skill 获取，经环境
变量或 secret.ini 注入）；MCP 走 JSON-RPC 2.0 over HTTP，认证头
X-Tencent-Meeting-Token。transport 可注入（测试不打真平台）。

增量语义：水位线=已见 (meeting_id, status) 集合，新组合即事件——
「新会议出现」「会议状态翻转」都自然覆盖，且天然幂等。
"""
from __future__ import annotations

import json
import logging
import os

from paistation.sense.cloud.base import CloudConnector
from paistation.sense.cloud.feishu import UrllibTransport

_log = logging.getLogger("paistation.sense.cloud.tencent")

BASE = "https://mcp.meeting.tencent.com/mcp/wemeet-open/v1"
SKILL_VERSION = "paistation-m9/1.0"
STATUS_TEXT = {
    "MEETING_STATUS_ING": "进行中",
    "MEETING_STATUS_END": "已结束",
    "MEETING_STATUS_NOT_STARTED": "即将开始",
}


class TencentMeetingConnector(CloudConnector):
    name = "cloud.tencent-meeting"
    scopes = ("cloud.meeting.read",)

    def __init__(self, token: str = "", transport=None):
        self._token = token or os.environ.get("TENCENT_MEETING_TOKEN", "")
        self._http = transport or UrllibTransport()

    def login_flow(self) -> bool:
        """token 型授权：在位即已授权（材料由用户人工取得）。"""
        return bool(self._token)

    def test_session(self) -> bool:
        status, _ = self._call("get_user_meetings", {"is_show_all_sub_meetings": 0})
        return status == 200

    def collect(self, since_watermark):
        if not self._token:
            return [], since_watermark  # 未配置=未激活，不动水位线
        snapshot: set[str] = {f"{a}|{b}" for a, b in self._seen_from(since_watermark)}
        events: list[dict] = []
        for tool, args in (("get_user_meetings", {"is_show_all_sub_meetings": 0}),
                           ("get_user_ended_meetings", {"page_size": 20})):
            status, body = self._call(tool, args)
            if status != 200 or body is None:
                return [], since_watermark  # 故障：水位线原地踏步
            for mt in self._extract_meetings(body):
                mid = str(mt.get("meeting_id") or mt.get("meetingId") or "")
                if not mid:
                    continue
                st = str(mt.get("status") or mt.get("meeting_status") or "")
                key = f"{mid}|{st}"
                if key in snapshot:
                    continue
                snapshot.add(key)
                subject = mt.get("subject") or mt.get("meeting_subject") or "未命名会议"
                st_text = STATUS_TEXT.get(st, "状态更新")
                events.append({
                    "type": "cloud.meeting.list",
                    "text": f"腾讯会议《{subject}》{st_text}",
                    "evidence": {"meeting_id": mid, "status": st,
                                 "meeting_code": str(mt.get("meeting_code") or "")},
                })
        new_wm = sorted(snapshot)
        return events, {"seen": [k.split("|") for k in new_wm]}

    # ---- 内部 ----

    def _call(self, tool: str, args: dict):
        return self._http.request(
            "POST", BASE,
            headers={"X-Tencent-Meeting-Token": self._token,
                     "X-Skill-Version": SKILL_VERSION},
            json_body={"jsonrpc": "2.0", "method": "tools/call",
                       "params": {"name": tool, "arguments": args}, "id": 1})

    @staticmethod
    def _extract_meetings(body) -> list[dict]:
        """content[0].text(JSON) 里的 meetings 列表；解析失败返回空。"""
        try:
            inner = body.get("result", body)
            text = (inner.get("content") or [{}])[0].get("text", "")
            payload = json.loads(text)
            if isinstance(payload, dict):
                for key in ("meetings", "meeting_info_list", "data"):
                    if isinstance(payload.get(key), list):
                        return payload[key]
            if isinstance(payload, list):
                return payload
        except (ValueError, AttributeError, IndexError, TypeError):
            _log.debug("会议列表解析失败，按空处理")
        return []

    @staticmethod
    def _seen_from(wm) -> list[list[str]]:
        if isinstance(wm, dict) and isinstance(wm.get("seen"), list):
            return [list(pair) for pair in wm["seen"] if isinstance(pair, (list, tuple))
                    and len(pair) == 2]
        return []
