"""C5 审批密码学：高风险动作签名授权日志（AP2 Verifiable Intent 同构）。

HMAC-SHA256（密钥外部注入，绝不入库）；全程可审计回放（Rabbit 反面律：
不可验证的"用户同意"等于没同意）。
"""
from __future__ import annotations

import hashlib
import hmac
import json
from datetime import datetime
from pathlib import Path


def _ts() -> str:
    return datetime.now().isoformat(timespec="seconds")


def _payload(appr: dict) -> bytes:
    material = {k: appr[k] for k in ("action", "args", "ts")}
    return json.dumps(material, ensure_ascii=False,
                      sort_keys=True).encode("utf-8")


class ApprovalLog:
    def __init__(self, home: str | Path, secret: bytes):
        self._home = Path(home)
        self._secret = secret

    def _sign(self, appr: dict) -> str:
        return "hmac-sha256:" + hmac.new(self._secret, _payload(appr),
                                         hashlib.sha256).hexdigest()

    def issue(self, action: str, args: dict, why: str) -> dict:
        appr = {"action": action, "args": args, "ts": _ts(), "why": why}
        appr["sig"] = self._sign(appr)
        path = self._home / "control" / "approvals.jsonl"
        path.parent.mkdir(parents=True, exist_ok=True)
        with path.open("a", encoding="utf-8") as fh:
            fh.write(json.dumps(appr, ensure_ascii=False) + "\n")
        return appr

    def verify(self, appr: dict) -> bool:
        if not isinstance(appr, dict) or "sig" not in appr:
            return False
        want = self._sign(appr)
        return hmac.compare_digest(want, appr["sig"])


def build_approval(log: ApprovalLog, action: str, args: dict,
                   why: str) -> dict:
    return log.issue(action, args, why)


def verify_approval(log: ApprovalLog, appr: dict) -> bool:
    return log.verify(appr)
