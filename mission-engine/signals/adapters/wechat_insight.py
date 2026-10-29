# -*- coding: utf-8 -*-
"""signals/adapters/wechat_insight.py — 微信群聊/朋友圈洞察适配器（W3.2b，用户点名首交付）。

数据源: wechat-24h-ops/data/topic-signals/*.jsonl（上游=逆向个人微信会话
+wechat-intelligence-hub JTBD 分析；洞察桥 topic_signals_to_radar.py 同源）。
实测 20261018.jsonl: 322 行仅 27 唯一 signal_id（上游重复追加常态）——
bus dedup 天然收敛重复行，零成本幂等。
ts 从 signal_id（sig_YYYYMMDD_HHMMSS）解析，非现造；坏行/非法 id 拒收留痕。
"""
from __future__ import annotations

import json
import re
from datetime import datetime, timedelta
from pathlib import Path

from ..contract import Signal
from .base import Adapter

SIG_DIR_DEFAULT = Path("E:/AI-Station/wechat-24h-ops/data/topic-signals")
DEFAULT_WINDOW_DAYS = 7            # 对齐 frequency_7d 语义
_ID_RE = re.compile(r"^sig_(\d{8})_(\d{6})$")


class WechatInsightAdapter(Adapter):
    source_type = "wechat_insight"

    def __init__(self, sig_dir: Path | str = SIG_DIR_DEFAULT,
                 window_days: int = DEFAULT_WINDOW_DAYS):
        self.sig_dir = Path(sig_dir)
        self.window_days = window_days

    def discover(self) -> list[str]:
        """窗口内日期文件（YYYYMMDD.jsonl）的原始行列表；文件名非法/窗外跳过。"""
        if not self.sig_dir.is_dir():
            return []
        cutoff = int((datetime.now() - timedelta(days=self.window_days))
                     .strftime("%Y%m%d"))
        lines: list[str] = []
        for fp in sorted(self.sig_dir.glob("*.jsonl")):
            if not fp.stem.isdigit() or int(fp.stem) < cutoff:
                continue
            for ln in fp.read_text(encoding="utf-8",
                                   errors="replace").splitlines():
                if ln.strip():
                    lines.append(ln.strip())
        return lines

    def normalize(self, raw) -> Signal:
        d = json.loads(raw)                        # 坏行 ValueError → reject 留痕
        sid = d.get("signal_id") or ""
        m = _ID_RE.match(sid)
        if not m:
            raise ValueError(f"signal_id 格式非法: {sid!r}")
        date, tm = m.groups()
        ts = f"{date[:4]}-{date[4:6]}-{date[6:]} {tm[:2]}:{tm[2:4]}:{tm[4:]}"
        jtbd = d.get("jtbd") or {}
        return Signal(
            source_type=self.source_type,
            payload={"demand_quote": d.get("demand_quote") or "",
                     "jtbd": jtbd,
                     "source_face": d.get("source_face") or "",
                     "frequency_7d": d.get("frequency_7d") or 0,
                     "urgency": d.get("urgency") or "",
                     "score": d.get("score") or 0,
                     "expert_panel": d.get("expert_panel") or {},
                     "trend": (d.get("stats_snapshot") or {}).get("trend", "")},
            evidence={"signal_id": sid, "source_ref": d.get("source_ref") or {}},
            jtbd_tags=["微信洞察", str(d.get("source_face") or ""),
                       str(jtbd.get("job_type") or ""),
                       f"urgency-{d.get('urgency') or ''}"],
            ts=ts,
            confidence=min((d.get("score") or 0) / 100, 1.0),   # 专家面板score映射
        )
