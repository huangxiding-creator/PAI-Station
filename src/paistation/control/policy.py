"""C2 风控式信任：动作四级 ×（限额/白名单）→ allow/deny/confirm。

取代一次性弹窗（Rokid×支付宝范式）：read 默认放行；write 走路径白名单；
spend 限额累计；irreversible 恒 confirm。unknown 恒 deny。
"""
from __future__ import annotations

from dataclasses import dataclass, field

from .registry import Registry


@dataclass
class Action:
    name: str
    args: dict = field(default_factory=dict)


class Policy:
    def __init__(self, registry: Registry,
                 write_whitelist: tuple[str, ...] = (),
                 spend_limit_yuan: float = 0.0,
                 irreversible_allowed: bool = False):
        self._registry = registry
        self._write_whitelist = write_whitelist
        self._spend_limit = spend_limit_yuan
        self._irreversible_allowed = irreversible_allowed
        self._spent = 0.0                    # 会话内累计（持久限额走账本，后续接）

    def _spend(self, yuan: float) -> None:
        self._spent += yuan

    def judge(self, action: Action) -> dict:
        try:
            spec = self._registry.get(action.name)
        except KeyError:
            return {"decision": "deny", "why": f"未注册动作：{action.name}"}
        if spec.path == "read":
            return {"decision": "allow", "why": ""}
        if spec.path == "write":
            target = str(action.args.get("path", ""))
            if any(target.startswith(w) for w in self._write_whitelist):
                return {"decision": "allow", "why": ""}
            return {"decision": "deny",
                    "why": f"写路径不在白名单：{target}"}
        if spec.path == "spend":
            yuan = float(action.args.get("yuan", 0))
            if self._spend_limit and self._spent + yuan > self._spend_limit:
                return {"decision": "confirm",
                        "why": f"超限额：累计 {self._spent + yuan:.2f}"
                        f" > 限额 {self._spend_limit:.2f}"}
            self._spend(yuan)
            return {"decision": "allow", "why": ""}
        # irreversible
        if self._irreversible_allowed:
            return {"decision": "allow", "why": ""}
        return {"decision": "confirm",
                "why": "不可逆动作：需显式确认（审批密码学日志）"}
