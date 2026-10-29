# -*- coding: utf-8 -*-
"""signals/adapters/viaim.py — 讯飞耳机录音适配器（W3.2a，用户点名首交付）。

discover: viaim-cli record list（默认48h窗，--start-ts 毫秒，v1.1.9 实测）
normalize: list 条目 → Signal（overview=讯飞AI概述即摘要原料；record_id 稳定主键）
说话人/全文深挖不在信号层做——W4 锻造厂按 evidence.record_id 拉 record
detail/summary；避免重复记录的 N+1 CLI 调用（bus 去重在 normalize 之后）。
登录态/密钥全在 viaim-cli 用户目录，本适配器零密钥零仓内配置。
"""
from __future__ import annotations

import json
import shutil
import subprocess
import time
from datetime import datetime
from pathlib import Path

from ..contract import Signal
from .base import Adapter

DEFAULT_WINDOW_HOURS = 48
DEFAULT_PAGE_SIZE = 50


def _viaim_bin() -> str:
    return shutil.which("viaim-cli") or str(
        Path.home() / "AppData" / "Local" / "viaim-cli" / "viaim-cli.EXE")


class ViaimAdapter(Adapter):
    source_type = "viaim"

    def __init__(self, window_hours: int = DEFAULT_WINDOW_HOURS,
                 page_size: int = DEFAULT_PAGE_SIZE, bin_path: str | None = None):
        self.window_hours = window_hours
        self.page_size = page_size
        self.bin = bin_path or _viaim_bin()

    def discover(self) -> list:
        start_ms = int((time.time() - self.window_hours * 3600) * 1000)
        r = subprocess.run(
            [self.bin, "record", "list", "--page-size", str(self.page_size),
             "--start-ts", str(start_ms)],
            capture_output=True, text=True, encoding="utf-8", errors="replace",
            timeout=60)
        try:
            out = json.loads(r.stdout) if r.stdout.strip() else {}
        except ValueError:
            raise RuntimeError(
                f"viaim-cli 输出不可解析 rc={r.returncode}: {r.stderr[:120]}") from None
        if not out.get("ok"):
            err = out.get("error") or {}
            raise RuntimeError(
                f"viaim record list 失败: {err.get('reason') or err.get('message') or r.stderr[:120]}")
        data = out.get("data") or {}
        return data.get("data") or []

    def normalize(self, raw) -> Signal:
        ts_ms = raw.get("record_time")
        ts = (datetime.fromtimestamp(ts_ms / 1000)
              .strftime("%Y-%m-%d %H:%M:%S") if ts_ms else "")
        return Signal(
            source_type=self.source_type,
            payload={"title": raw.get("title") or "",
                     "overview": raw.get("overview") or "",
                     "sub_title": raw.get("sub_title") or "",
                     "duration_sec": round((raw.get("duration") or 0) / 1000, 1),
                     "languages": raw.get("languages") or []},
            evidence={"record_id": raw.get("record_id"),
                      "source": "viaim-cli record list"},
            jtbd_tags=["语音想法"],      # v1 通用标签；JTBD 精炼=W4 IdeaDig 锻造职责
            ts=ts,
            confidence=0.9,             # 讯飞AI概述+标题，实测转写质量
        )
