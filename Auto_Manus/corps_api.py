# -*- coding: utf-8 -*-
"""corps_api — API 直调军团引擎 (1023 用户令: 从浏览器自动化升级为 API 直调).

最高成功率方法: data/tokens/ 97 把 JWT 令牌, 100% API 有效, 零浏览器.
功能: 令牌轮转 → 积分检查 → 会话管理 → 成果收割 → 全 API 化.

用法:
  py corps_api.py status          # 全令牌健康+积分扫描
  py corps_api.py collect <简报>  # API 派单采集
  py corps_api.py harvest        # 拉全部已完成会话成果
"""
from __future__ import annotations

import json
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from manus_api import (load_token, save_token, _urllib_call,  # noqa: E402
                       list_sessions, get_files, get_credits)

ROOT = Path(__file__).resolve().parent
TOKEN_DIR = ROOT / "data" / "tokens"
LEDGER = ROOT / "data" / "corps_api_log.jsonl"


def all_tokens() -> list[dict]:
    """全令牌清单 [{email, token}]."""
    out = []
    for f in sorted(TOKEN_DIR.glob("*.json")):
        email = f.stem.replace("_at_", "@")
        tok = load_token(email)
        if tok and tok.get("authorization"):
            out.append({"email": email, "token": tok})
    return out


def check_credits(tok: dict) -> int:
    """积分查询 → int (失败=-999)."""
    st, text = _urllib_call(
        "POST", "/user.v1.UserService/GetAvailableCredits", tok, {}, timeout=10)
    if st != 200:
        return -999
    try:
        return int(json.loads(text).get("totalCredits", -1))
    except (ValueError, json.JSONDecodeError):
        return -999


def api_sessions(tok: dict) -> list:
    """列会话 (纯 API)."""
    try:
        return list_sessions(None, tok)
    except Exception:
        return []


def harvest_session_files(tok: dict, sid: str, email: str) -> list:
    """拉一个会话的成果文件列表."""
    st, text = _urllib_call(
        "GET", f"/api/chat/getSessionFilesV2?sessionId={sid}", tok, timeout=15)
    if st != 200:
        return []
    try:
        return json.loads(text).get("files", [])
    except (ValueError, json.JSONDecodeError):
        return []


def log_action(action: str, detail: dict):
    """军团 API 台账."""
    LEDGER.parent.mkdir(parents=True, exist_ok=True)
    with LEDGER.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(
            {"ts": time.strftime("%F %T"), "action": action, **detail},
            ensure_ascii=False) + "\n")


def cmd_status():
    """全令牌健康+积分扫描."""
    tokens = all_tokens()
    print(f"令牌总档: {len(tokens)}")
    ready = []
    for t in tokens:
        credits = check_credits(t["token"])
        mark = "✅" if credits >= 60 else ("⏳" if credits >= 0 else "❌")
        print(f"  {mark} {t['email'][:24]:26s} {credits}积分")
        if credits >= 60:
            ready.append(t["email"])
    print(f"\n可派单(≥60积分): {len(ready)} / {len(tokens)}")
    log_action("status", {"total": len(tokens), "ready": len(ready)})
    return ready


def cmd_harvest():
    """拉全部已完成会话的成果."""
    tokens = all_tokens()
    total_sessions = 0
    total_files = 0
    for t in tokens:
        sessions = api_sessions(t["token"])
        for s in sessions:
            sid = s.get("sessionId", "")
            title = s.get("title", "")[:40]
            status = s.get("status", "")
            if status in ("completed", "done"):
                files = harvest_session_files(t["token"], sid, t["email"])
                total_files += len(files)
                if files:
                    print(f"  📎 {t['email'][:16]} | {title} | {len(files)}件")
            total_sessions += 1
    print(f"\n会话总数: {total_sessions} | 成果文件: {total_files}")
    log_action("harvest", {"sessions": total_sessions, "files": total_files})


def main():
    cmd = sys.argv[1] if len(sys.argv) > 1 else "status"
    if cmd == "status":
        cmd_status()
    elif cmd == "harvest":
        cmd_harvest()
    else:
        print(__doc__)


if __name__ == "__main__":
    main()
