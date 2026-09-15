# -*- coding: utf-8 -*-
"""M9c 微信情报连接器：wih 引擎产物目录轮询 → cloud.wih.insight 事件。

设计边界（与 wih 上游一致）：连接器不碰微信本体、不取 salt-key、
不代授权——真实扫描由用户经 wechat-cli skill 完成授权后产出报告/
断点文件；本连接器只感知「产物目录里出现了什么」，把情报就绪
信号送进统一事件流（→ 意图层/晨报）。产物未授权=目录空=未激活。
"""
from __future__ import annotations

import logging
from pathlib import Path

from paistation.sense.cloud.base import CloudConnector

_log = logging.getLogger("paistation.sense.cloud.wih")

SUFFIXES = {".jsonl", ".md", ".json"}


class WeChatIntelConnector(CloudConnector):
    name = "cloud.wechat-intel"
    scopes = ("cloud.wechat.read",)

    def __init__(self, out_dir=None):
        self._out = Path(out_dir) if out_dir else None

    def login_flow(self) -> bool:
        """授权材料（salt-key）由用户经 wechat-cli 人工接入，不代取。"""
        return False

    def test_session(self) -> bool:
        return self._out is not None and self._out.is_dir()

    def collect(self, since_watermark):
        if not self.test_session():
            return [], since_watermark  # 无产物目录=未激活
        since = float(since_watermark or 0.0)
        events: list[dict] = []
        new_wm = since
        for f in sorted(self._out.iterdir()):
            if f.suffix.lower() not in SUFFIXES or not f.is_file():
                continue
            mt = f.stat().st_mtime
            if mt <= since:
                continue
            new_wm = max(new_wm, mt)
            events.append({
                "type": "cloud.wih.insight",
                "text": f"微信情报报告《{f.name}》已更新",
                "evidence": {"file": f.name, "mtime": mt,
                             "size": f.stat().st_size},
            })
        return events, new_wm
