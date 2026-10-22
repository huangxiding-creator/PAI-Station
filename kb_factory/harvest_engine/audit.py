# -*- coding: utf-8 -*-
"""harvest_audit 收割台账（FR1.1 / NFR2 数字零造假）：每请求如实一行 JSON。

同构 channel_adapters.base.AuditLog（复用其写入器，不重复定义）；台账文件独立为
本包内 harvest_audit.jsonl（与 channel_adapters/audit.jsonl 风格一致、互不相混）。
行字段固定七列（任务书契约）：ts/site/event/query_or_docid/count/status/detail。

注意：默认路径未入 gitignore——测试与回放一律显式传 path（tests/fixtures/ 下），
不得在单测中写包内默认位。
"""
import os

from kb_factory.channel_adapters.base import AuditLog

AUDIT_DEFAULT_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), "harvest_audit.jsonl")


class HarvestAudit(AuditLog):
    """收割台账：每请求一行（event 取 adapters.base.FOUR_STAGES 或 orchestrator 事件名）。"""

    def __init__(self, path: str = AUDIT_DEFAULT_PATH):
        super().__init__(path=path)

    def request(self, site: str, event: str, query_or_docid: str,
                count: int, status: str, detail: str = "") -> None:
        """记一行收割事实（零造假：count=实测条数/页数，status=ok|fail，detail=原样事实）。"""
        self.log(site=site, event=event, query_or_docid=query_or_docid,
                 count=count, status=status, detail=detail)
