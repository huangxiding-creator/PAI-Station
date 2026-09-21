r"""4.x 全量数据 → 简报管线注入器。

用微信 4.x 解密渠道拉当天全部活跃会话消息，生成 indexed_messages.json
（与 hub S1 同格式：chat/sender/time/content），供 S3 语义编辑作全量素材。
桥流只覆盖在线时段+桥会话（实测 9-21: 80/282），本注入器补齐缺口。

用法:
  python tools/wechat4/inject_brief_source.py --run-dir <run目录> [--date 2026-09-21]
  # 生成 <run>/db-index/indexed_messages.json（原桥流版备份 .bridge.bak）
"""

from __future__ import annotations

import argparse
import json
import sys
from datetime import date, datetime, timedelta
from pathlib import Path

STATION_ROOT = Path(__file__).resolve().parents[2]
VENDOR_SRC = STATION_ROOT / "vendor" / "wechat-ai-memory" / "src"
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    sys.stderr.reconfigure(encoding="utf-8", errors="replace")
if str(VENDOR_SRC) not in sys.path:
    sys.path.insert(0, str(VENDOR_SRC))

from wechat_context_exporter.models import MessageType  # noqa: E402
from wechat_context_exporter.sources.wechat4_discovery import (  # noqa: E402
    discover_wechat4_accounts,
)
from wechat_context_exporter.sources.wechat4_source import WeChat4LocalSource  # noqa: E402


def load_key(account_id: str) -> bytes:
    path = STATION_ROOT / "data" / "secrets" / f"wechat4_key_{account_id}.hex"
    return bytes.fromhex(path.read_text(encoding="utf-8").strip())


def today_active_usernames(source: WeChat4LocalSource, since: datetime) -> set[str]:
    """SessionTable.last_timestamp >= since 的会话 username 集合。"""
    import sqlite3

    db = source._databases.get("session\\session.db")
    conn = sqlite3.connect(f"file:{db.as_posix()}?mode=ro", uri=True)
    try:
        rows = conn.execute(
            "SELECT username FROM SessionTable WHERE last_timestamp >= ?",
            (int(since.timestamp()),),
        ).fetchall()
    finally:
        conn.close()
    return {r[0] for r in rows}


def message_to_row(message, chat_name: str) -> dict:
    content = message.content or ""
    if message.type == MessageType.IMAGE:
        content = "[图片]"
    elif message.type == MessageType.VOICE:
        content = message.transcript or f"[语音 {max(1, round((message.duration_ms or 0) / 1000))}s]"
    elif message.type == MessageType.FILE:
        content = content or "[文件]"
    elif message.type == MessageType.SYSTEM:
        content = f"[系统] {content[:80]}"
    return {
        "chat": chat_name,
        "sender": message.sender or ("我" if message.is_outgoing else ""),
        "time": message.timestamp.isoformat(),
        "content": content[:2000],
    }


def main() -> None:
    parser = argparse.ArgumentParser(description="4.x 全量消息注入简报管线")
    parser.add_argument("--run-dir", required=True, help="简报 run 目录（含 db-index/）")
    parser.add_argument("--date", default=date.today().strftime("%Y-%m-%d"))
    parser.add_argument("--account", default="wxid_ui29wkg2ug6922_66f7")
    parser.add_argument("--max-per-chat", type=int, default=500)
    args = parser.parse_args()

    since = datetime.strptime(args.date, "%Y-%m-%d")
    end = since + timedelta(days=1)

    accounts = discover_wechat4_accounts()
    account = next(a for a in accounts if a.id == args.account)
    source = WeChat4LocalSource(account=account, raw_key=load_key(args.account))

    active = today_active_usernames(source, since)
    print(f"[inject] {args.date} 活跃会话: {len(active)}")

    conversations = [c for c in source.list_conversations() if c.id in active]
    print(f"[inject] 匹配 Conversation: {len(conversations)}")

    rows: list[dict] = []
    for index, conversation in enumerate(conversations, start=1):
        try:
            messages = source.get_messages(conversation.id, start=since, end=end)
        except Exception as exc:  # noqa: BLE001 - 单会话失败不拖垮全量
            print(f"  [{index}/{len(conversations)}] {conversation.name}: SKIP {exc}")
            continue
        kept = messages[-args.max_per_chat:]
        rows.extend(message_to_row(m, conversation.name) for m in kept)
        if index % 20 == 0 or index == len(conversations):
            print(f"  [{index}/{len(conversations)}] cumulated {len(rows)} msgs")

    rows.sort(key=lambda r: r["time"])
    target = Path(args.run_dir) / "db-index" / "indexed_messages.json"
    if target.is_file():
        backup = target.with_suffix(".json.bridge.bak")
        if not backup.exists():
            backup.write_bytes(target.read_bytes())
        bridge_count = len(json.loads(backup.read_text(encoding="utf-8")))
        print(f"[inject] 桥流版 {bridge_count} 条已备份 → {backup.name}")
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(rows, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[inject] 4.x 全量 {len(rows)} 条 → {target}")


if __name__ == "__main__":
    main()
