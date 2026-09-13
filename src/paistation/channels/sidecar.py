"""D4 IM 侧挂：IM 消息→任务→回执（企微语义先行，AstrBot 同协议可挂）。

命令面：/run <action> <json-args>、/status、/help。
回执=evidence over narrative：成功带结果，失败带原因，待确认明确标注。
"""
from __future__ import annotations

import json

from paistation.control.gateway import Gateway, execution_log


def handle_message(text: str, gateway: Gateway) -> str:
    text = text.strip()
    if text == "/help":
        names = ", ".join(s.name for s in gateway._registry.list())  # noqa: SLF001
        return (f"可用动作：{names or '（无）'}\n"
                "命令：/run <action> <json参数> / /status / /help")
    if text == "/status":
        rows = execution_log(gateway._home)  # noqa: SLF001
        ok_n = sum(1 for r in rows if r.get("ok"))
        return f"执行 {len(rows)} 次，成功 {ok_n} 次"
    if text.startswith("/run "):
        parts = text.split(maxsplit=2)
        if len(parts) < 2:
            return "❌ 用法：/run <action> <json参数>"
        action = parts[1]
        try:
            args = json.loads(parts[2]) if len(parts) > 2 else {}
        except ValueError:
            return "❌ 参数不是合法 JSON"
        result = gateway.execute(action, args)
        if result.get("ok"):
            return f"✅ {action} → {result.get('result', result.get('dry_run'))}"
        if result.get("pending_confirm"):
            return f"⏳ 待确认：{result.get('error', '')}"
        return f"❌ {action}：{result.get('error', '失败')}"
    return "未知命令（/help 查看）"


def format_receipt(task_id: str, result: dict) -> str:
    mark = "✅" if result.get("ok") else "❌"
    payload = result.get("result", result.get("error", ""))
    return f"[{task_id}] {mark} {payload}"
