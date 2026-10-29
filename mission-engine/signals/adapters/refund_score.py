# -*- coding: utf-8 -*-
"""signals/adapters/refund_score.py — 买家退款评分适配器（W3.2，七源第7源）。

数据源: qianwen-engine（TCB）GET /api/feedback/pending（X-Admin-Key=
data/secrets/qianwen_engine_hmac.key 的hex，与 feedback_revision_loop 同契约）。
盲测证据路线（1017用户令）: 质量判据=AI六维面板+买家评分；低分按比例退款。
fid=fb_{unix秒}_{SKU短码} 内嵌时间戳与SKU，解析作 ts/sku（非现造）。
probe/test 探针 openid 过滤（同产线惯例）。pending 只含未 ack 项——
已被飞轮 ack 的历史评分经 revision_ledger(fids) 与本源互补成全量。
confidence=total_score/100（实测分，数字零造假）。
"""
from __future__ import annotations

import json
import re
import urllib.request
from datetime import datetime
from pathlib import Path

from ..contract import Signal
from .base import Adapter

ENGINE = "https://qianwen-engine-322438-9-1499254664.sh.run.tcloudbase.com"
KEY_FILE = Path("E:/AI-Station/data/secrets/qianwen_engine_hmac.key")
_FID_RE = re.compile(r"^fb_(\d{9,11})_([A-Za-z0-9\-]+)$")


class RefundScoreAdapter(Adapter):
    source_type = "refund_score"

    def __init__(self, engine: str = ENGINE, key_file: Path | str = KEY_FILE,
                 timeout: int = 30):
        self.engine = engine.rstrip("/")
        self.key_file = Path(key_file)
        self.timeout = timeout

    def discover(self) -> list[dict]:
        key = self.key_file.read_bytes().hex()      # 密钥不进仓不进日志
        req = urllib.request.Request(
            f"{self.engine}/api/feedback/pending", method="GET",
            headers={"X-Admin-Key": key})
        with urllib.request.urlopen(req, timeout=self.timeout) as r:
            d = json.loads(r.read())
        if not d.get("ok"):
            raise RuntimeError(f"engine 返回 not ok: {str(d)[:120]}")
        return [it for it in (d.get("items") or [])
                if "probe" not in str(it.get("openid") or "").lower()
                and "test" not in str(it.get("openid") or "").lower()]

    def normalize(self, raw) -> Signal:
        d = raw if isinstance(raw, dict) else json.loads(raw)
        fid = d.get("fid") or ""
        m = _FID_RE.match(fid)
        if not m:
            raise ValueError(f"fid 格式非法: {fid!r}")
        unix_s, sku_short = m.groups()
        ts = datetime.fromtimestamp(int(unix_s)).strftime("%Y-%m-%d %H:%M:%S")
        try:
            scores = json.loads(d.get("scores_json") or "{}")
        except ValueError:
            scores = {}
        total = scores.get("total_score")
        return Signal(
            source_type=self.source_type,
            payload={"sku_short": sku_short, "scores": scores,
                     "openid_tail": str(d.get("openid") or "")[-6:]},
            evidence={"fid": fid, "sku_short": sku_short},
            jtbd_tags=["退款评分", f"sku-{sku_short}",
                       f"category-{scores.get('feedback_category', '')}"],
            ts=ts,
            confidence=(float(total) / 100
                        if isinstance(total, (int, float)) else 0.5),
        )
