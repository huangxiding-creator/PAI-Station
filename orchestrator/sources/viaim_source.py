# -*- coding: utf-8 -*-
"""Viaim Source：耳机录音 → Trigger。

定时拉取 viaim-cli 最新录音，转为 Trigger 进入 Eval。
"""
from __future__ import annotations

import json
import os
import subprocess
from pathlib import Path

from domain import Trigger

CLI = os.path.join(os.environ.get("LOCALAPPDATA", ""), "viaim-cli", "viaim-cli.exe")
STATE_FILE = Path(__file__).parent.parent / "state_viaim.json"


def _run(args: list[str]) -> dict:
    r = subprocess.run([CLI] + args, capture_output=True, text=True,
                       timeout=60, encoding="utf-8", errors="replace")
    try:
        return json.loads(r.stdout)
    except (json.JSONDecodeError, TypeError):
        return {"ok": False, "error": {"message": r.stdout[:200]}}


def _load_state() -> dict:
    if STATE_FILE.exists():
        return json.loads(STATE_FILE.read_text(encoding="utf-8"))
    return {"last_record_id": "", "last_sync": 0}


def _save_state(state: dict):
    STATE_FILE.write_text(json.dumps(state, ensure_ascii=False, indent=1),
                          encoding="utf-8")


def poll(max_items: int = 10) -> list[Trigger]:
    """拉取最新录音，转为 Trigger 列表。"""
    state = _load_state()
    r = _run(["record", "list", "--page-size", str(max_items)])
    if not r.get("ok"):
        return []

    triggers = []
    for rec in r.get("data", {}).get("data", []):
        rid = rec.get("record_id", "")
        if rid == state.get("last_record_id", ""):
            break  # 按时间倒序，遇到已处理的就停

        # 过滤：只取有内容的录音（跳过纯音乐/私人）
        overview = rec.get("overview", "")
        title = rec.get("title", "")
        if not overview and not title:
            continue

        # 提取项目分类
        categories = [c.get("name", "") for c in rec.get("categories", [])]
        trigger = Trigger(
            source="viaim",
            actor="user",
            thread_id=f"viaim_{rid[:8]}",
            content=f"[耳机录音] {title}\n{overview}",
            metadata={
                "record_id": rid,
                "title": title,
                "overview": overview,
                "categories": categories,
                "duration_ms": rec.get("duration", 0),
                "record_time": rec.get("record_time", 0),
            },
        )
        triggers.append(trigger)

    if triggers:
        state["last_record_id"] = triggers[0].metadata.get("record_id", "")
        state["last_sync"] = int(__import__("time").time() * 1000)
        _save_state(state)

    return triggers
