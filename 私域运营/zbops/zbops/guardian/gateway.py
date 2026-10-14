# -*- coding: utf-8 -*-
"""Guardian：ActionGateway 统一咽喉（票据链）。

固定管线（不可重排）：急停→日历→令牌桶→内容审核→人审路由→审计→签发票据。
票据 = HMAC-SHA256(内容哈希+通道+对象+急停epoch+TTL90s)，执行器验签后放行。
对机器 owner 不设防（明示边界，见 ARCHITECTURE §5.5）。
"""
from __future__ import annotations

import hashlib
import hmac
import json
import os
import time
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path


@dataclass
class Permit:
    ok: bool
    reason: str = ""
    ticket: str = ""


class RateLimiter:
    """四维令牌桶（通道/对象/动作），SQLite 持久化重启不清零。"""

    def __init__(self, db_path: str):
        import sqlite3
        self.db = sqlite3.connect(db_path, check_same_thread=False)
        self.db.execute("""CREATE TABLE IF NOT EXISTS token_bucket(
            k TEXT PRIMARY KEY, window TEXT, count INTEGER)""")
        self.db.commit()

    def check_and_consume(self, channel, obj, action, limit: int,
                          window_sec: int = 3600) -> tuple[bool, str]:
        key = f"{channel}|{obj}|{action}"
        now = int(time.time())
        win = now // window_sec
        row = self.db.execute(
            "SELECT window, count FROM token_bucket WHERE k=?", (key,)).fetchone()
        if not row or row[0] != str(win):
            self.db.execute(
                "INSERT OR REPLACE INTO token_bucket VALUES(?,?,1)", (key, str(win)))
            self.db.commit()
            return True, ""
        if row[1] >= limit:
            return False, f"限额 {limit}/{window_sec}s 已达（{key}）"
        self.db.execute("UPDATE token_bucket SET count=count+1 WHERE k=?", (key,))
        self.db.commit()
        return True, ""

    def refund(self, channel, obj, action, window_sec: int = 3600):
        """令牌返还：被审核/人审拒绝的动作不消耗配额（架构裁定：被拒不扣减）。"""
        key = f"{channel}|{obj}|{action}"
        win = str(int(time.time()) // window_sec)
        self.db.execute(
            "UPDATE token_bucket SET count=MAX(0,count-1) WHERE k=? AND window=?",
            (key, win))
        self.db.commit()


class KillSwitch:
    """全局+分通道急停；epoch 递增使在途票据全部失效。"""

    def __init__(self, runtime_dir: str):
        self.dir = Path(runtime_dir)
        self.dir.mkdir(parents=True, exist_ok=True)
        self._epoch_file = self.dir / "kill_epoch"

    @property
    def epoch(self) -> int:
        return int(self._epoch_file.read_text()) if self._epoch_file.exists() else 0

    def tripped(self) -> bool:
        return (self.dir / "breaker.on").exists()

    def trip(self, reason: str):
        (self.dir / "breaker.on").write_text(
            f"{datetime.now().isoformat()} {reason}", encoding="utf-8")
        self._epoch_file.write_text(str(self.epoch + 1))

    def rearm(self):
        (self.dir / "breaker.on").unlink(missing_ok=True)


class ActionGateway:
    def __init__(self, cfg: dict, db_path: str):
        self.cfg = cfg
        self.ratelimit = RateLimiter(db_path)
        self.kill = KillSwitch(cfg.get("runtime_dir", "C:/zb-ops/runtime"))
        self.log_dir = Path(cfg.get("log_dir", "C:/zb-ops/logs"))
        self.log_dir.mkdir(parents=True, exist_ok=True)
        self._secret = os.environ.get("ZBOPS_HMAC_SECRET") or \
            hashlib.sha256(db_path.encode()).hexdigest()  # 单机自派生（owner可换）
        q = cfg.get("quiet_hours", ["22:00", "08:00"])
        self.quiet = (q[0], q[1])
        self._audit_chain_prev = ""

    # ---- 票据 ----
    def _sign(self, payload: str) -> str:
        return hmac.new(self._secret.encode(), payload.encode(),
                        hashlib.sha256).hexdigest()[:32]

    def _audit(self, row: dict):
        row["prev_hash"] = self._audit_chain_prev
        line = json.dumps(row, ensure_ascii=False, sort_keys=True)
        h = hashlib.sha256(line.encode()).hexdigest()
        self._audit_chain_prev = h
        f = self.log_dir / f"audit-{datetime.now():%Y-%m-%d}.jsonl"
        with f.open("a", encoding="utf-8") as fp:
            fp.write(json.dumps({**row, "hash": h}, ensure_ascii=False) + "\n")

    # ---- 主闸 ----
    def permit(self, channel: str, object_id: str, action: str,
               content: str) -> Permit:
        ts = datetime.now().isoformat(timespec="seconds")

        # 1) 急停
        if self.kill.tripped():
            return Permit(False, "急停熔断中（breaker.on 存在）")
        # 2) 静默时段
        t = datetime.now().strftime("%H:%M")
        if self.quiet[0] <= t or t < self.quiet[1]:
            return Permit(False, f"静默时段 {self.quiet}")
        # 3) 令牌桶
        rates = self.cfg.get("rates", {})
        limit = rates.get(f"{channel}_per_chat_hourly", 6)
        ok, why = self.ratelimit.check_and_consume(channel, object_id, action, limit)
        if not ok:
            self._audit({"ts": ts, "channel": channel, "obj": object_id,
                         "action": action, "verdict": "rate_denied", "why": why})
            return Permit(False, why)
        # 4) 内容审核（被拒内容返还令牌——被拒不消耗配额）
        from .moderation import moderate
        v = moderate(content)
        if v.level == "A":
            self.ratelimit.refund(channel, object_id, action)
            self._audit({"ts": ts, "channel": channel, "obj": object_id,
                         "action": action, "verdict": "blocked", "hits": v.hits})
            return Permit(False, f"审核 A 级命中: {v.hits}")
        # 5) B 级→人审（单机 P0：直接拒绝并记台账，人审队列 P1 接入）
        if v.level == "B":
            self.ratelimit.refund(channel, object_id, action)
            self._audit({"ts": ts, "channel": channel, "obj": object_id,
                         "action": action, "verdict": "review_hold", "hits": v.hits})
            return Permit(False, f"审核 B 级需人审: {v.hits}")
        # 6) 签发票据（绑定内容哈希+epoch，90s TTL）
        payload = f"{channel}|{object_id}|{action}|{hashlib.sha256(content.encode()).hexdigest()[:16]}|{self.kill.epoch}|{int(time.time()) // 90}"
        ticket = self._sign(payload)
        self._audit({"ts": ts, "channel": channel, "obj": object_id,
                     "action": action, "verdict": "permitted",
                     "content_hash": hashlib.sha256(content.encode()).hexdigest()[:16],
                     "ticket": ticket})
        return Permit(True, ticket=ticket)

    def verify_ticket(self, ticket: str, channel: str, object_id: str,
                      action: str, content: str) -> bool:
        payload = f"{channel}|{object_id}|{action}|{hashlib.sha256(content.encode()).hexdigest()[:16]}|{self.kill.epoch}|{int(time.time()) // 90}"
        return hmac.compare_digest(self._sign(payload), ticket)
