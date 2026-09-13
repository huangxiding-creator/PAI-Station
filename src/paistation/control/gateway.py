"""C3 本机网关：注册表→策略→执行→回滚→账本，第三方可复用的稳定 API。

执行链：judge→deny 直接拒；confirm 在 auto_confirm=False 时拒绝待批；
执行失败触发 rollback；每次执行追加 execution.jsonl（append-only 可回放）。
无 handler 的动作=dry-run（框架先行，真机动作后续接入）。
"""
from __future__ import annotations

import json
from datetime import datetime
from pathlib import Path

from .policy import Action, Policy
from .registry import Registry


def _ts() -> str:
    return datetime.now().isoformat(timespec="seconds")


def _log_path(home: str | Path) -> Path:
    return Path(home) / "control" / "execution.jsonl"


def execution_log(home: str | Path) -> list[dict]:
    path = _log_path(home)
    if not path.is_file():
        return []
    return [json.loads(x) for x in
            path.read_text(encoding="utf-8").splitlines() if x.strip()]


class Gateway:
    def __init__(self, registry: Registry, home: str | Path,
                 policy: Policy | None = None, auto_confirm: bool = False):
        self._registry = registry
        self._home = Path(home)
        self._policy = policy or Policy(registry)
        self._auto_confirm = auto_confirm

    def execute(self, name: str, args: dict | None = None) -> dict:
        args = dict(args or {})
        verdict = self._policy.judge(Action(name, args))
        row = {"ts": _ts(), "action": name, "args": args,
               "decision": verdict["decision"]}
        if verdict["decision"] == "deny":
            row.update({"ok": False, "error": verdict["why"]})
            self._record(row)
            return {"ok": False, "denied": True, "error": verdict["why"]}
        if verdict["decision"] == "confirm" and not self._auto_confirm:
            row.update({"ok": False, "error": "待确认：" + verdict["why"]})
            self._record(row)
            return {"ok": False, "pending_confirm": True,
                    "error": verdict["why"]}
        spec = self._registry.get(name)
        if spec.handler is None:
            row.update({"ok": True, "dry_run": True})
            self._record(row)
            return {"ok": True, "dry_run": True}
        try:
            result = spec.handler(args)
        except Exception as exc:                       # noqa: BLE001 —— 回滚律
            if spec.rollback:
                spec.rollback(args)
                row["rolled_back"] = True
            row.update({"ok": False, "error": str(exc)})
            self._record(row)
            return {"ok": False, "error": str(exc), "rolled_back": bool(spec.rollback)}
        row["ok"] = True
        self._record(row)
        return {"ok": True, "result": result}

    def _record(self, row: dict) -> None:
        path = _log_path(self._home)
        path.parent.mkdir(parents=True, exist_ok=True)
        with path.open("a", encoding="utf-8") as fh:
            fh.write(json.dumps(row, ensure_ascii=False) + "\n")
