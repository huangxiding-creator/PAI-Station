r"""微信 4.x 渠道桥接件（vendor: wechat-ai-memory）。

桥接 E:\AI-Station\vendor\wechat-ai-memory 的 4.x 解密链路（discovery →
DecryptedDatabaseCache → WeChat4LocalSource），把本机微信 4.x 加密库变成
可查询渠道。密钥持久化在 data/secrets/wechat4_key_<account_id>.hex（红线
免疫区，不入 git）；密钥未就位时诚实报「待抓密钥」，绝不伪造。

用法:
  python wechat4_channel.py accounts                 # 发现账户（零密钥需求）
  python wechat4_channel.py status                   # 账户+密钥就位态+库清单
  python wechat4_channel.py conversations [--account ID] [--kind group]
  python wechat4_channel.py messages --conversation ID [--limit 50]
                              [--start 2026-09-01] [--end 2026-09-21]
  python wechat4_channel.py save-key --hex <64hex> [--account ID]   # 写密钥（供抓密钥流程收口）
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from datetime import datetime
from pathlib import Path

# GBK 控制台防乱码（env-quirks 已知坑：中文消息打印炸 UnicodeEncodeError）
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    sys.stderr.reconfigure(encoding="utf-8", errors="replace")

STATION_ROOT = Path(__file__).resolve().parents[2]
VENDOR_SRC = STATION_ROOT / "vendor" / "wechat-ai-memory" / "src"
SECRETS_DIR = STATION_ROOT / "data" / "secrets"

if str(VENDOR_SRC) not in sys.path:
    sys.path.insert(0, str(VENDOR_SRC))

from wechat_context_exporter.sources.wechat4_discovery import (  # noqa: E402
    discover_wechat4_accounts,
)
from wechat_context_exporter.sources.wechat4_crypto import (  # noqa: E402
    verify_account_key,
)
from wechat_context_exporter.sources import WeChat4LocalSource  # noqa: E402

_HEX_RE = re.compile(r"^[0-9a-fA-F]{64}$")


def key_path(account_id: str) -> Path:
    return SECRETS_DIR / f"wechat4_key_{account_id}.hex"


def load_saved_key(account_id: str) -> bytes | None:
    """读持久化密钥；缺失/格式错/验签失败均返回 None（诚实降级）。"""
    path = key_path(account_id)
    if not path.is_file():
        return None
    text = path.read_text(encoding="utf-8").strip()
    if not _HEX_RE.match(text):
        return None
    try:
        return bytes.fromhex(text)
    except ValueError:
        return None


def pick_account(account_id: str | None):
    accounts = discover_wechat4_accounts()
    if not accounts:
        raise SystemExit("未发现本机微信 4.x 数据目录（xwechat_files）")
    if account_id:
        for account in accounts:
            if account.id == account_id:
                return account
        known = ", ".join(a.id for a in accounts)
        raise SystemExit(f"账户 {account_id} 不存在；已知账户: {known}")
    # 默认取最近活跃账户（discovery 按 mtime 降序）
    return accounts[0]


def cmd_accounts(_args: argparse.Namespace) -> None:
    accounts = discover_wechat4_accounts()
    rows = []
    for account in accounts:
        session_db = account.db_dir / "session" / "session.db"
        try:
            mtime = datetime.fromtimestamp(session_db.stat().st_mtime)
            mtime_text = mtime.strftime("%Y-%m-%d %H:%M")
        except OSError:
            mtime_text = "?"
        rows.append(
            {
                "account_id": account.id,
                "account_dir": str(account.account_dir),
                "session_db_mtime": mtime_text,
                "key_ready": load_saved_key(account.id) is not None,
            }
        )
    print(json.dumps({"accounts": rows}, ensure_ascii=False, indent=2))


def cmd_status(args: argparse.Namespace) -> None:
    account = pick_account(args.account)
    dbs = sorted(account.db_dir.rglob("*.db"))
    key = load_saved_key(account.id)
    key_state = "missing"
    if key is not None:
        session_db = account.db_dir / "session" / "session.db"
        first_page = session_db.open("rb").read(4096) if session_db.is_file() else b""
        key_state = (
            "verified" if key and verify_account_key(key, first_page) else "stale"
        )
    by_dir: dict[str, int] = {}
    for db in dbs:
        try:
            rel = db.parent.relative_to(account.db_dir).as_posix()
        except ValueError:
            rel = "."
        by_dir[rel] = by_dir.get(rel, 0) + 1
    print(
        json.dumps(
            {
                "account_id": account.id,
                "account_dir": str(account.account_dir),
                "db_count": len(dbs),
                "db_by_dir": by_dir,
                "key_state": key_state,  # missing / verified / stale
                "key_file": str(key_path(account.id)),
            },
            ensure_ascii=False,
            indent=2,
        )
    )


def build_source(account) -> WeChat4LocalSource:
    key = load_saved_key(account.id)
    if key is None:
        raise SystemExit(
            f"账户 {account.id} 密钥未就位（待抓密钥）。"
            f"先运行 tools/wechat4/capture_key.py（需用户在场），"
            f"密钥落位 {key_path(account.id)}"
        )
    return WeChat4LocalSource(account=account, raw_key=key)


def cmd_conversations(args: argparse.Namespace) -> None:
    account = pick_account(args.account)
    source = build_source(account)
    rows = []
    for conversation in source.list_conversations():
        if args.kind and conversation.kind.value != args.kind:
            continue
        rows.append(
            {"id": conversation.id, "name": conversation.name, "kind": conversation.kind.value}
        )
    limit = args.limit or len(rows)
    print(
        json.dumps(
            {"account_id": account.id, "count": len(rows), "conversations": rows[:limit]},
            ensure_ascii=False,
            indent=2,
        )
    )


def cmd_messages(args: argparse.Namespace) -> None:
    account = pick_account(args.account)
    source = build_source(account)
    start = datetime.fromisoformat(args.start) if args.start else None
    end = datetime.fromisoformat(args.end) if args.end else None
    messages = source.get_messages(args.conversation, start=start, end=end)
    rows = []
    for message in reversed(messages[-args.limit :]):  # 时间正序输出末尾 N 条
        row = {
            "time": message.timestamp.strftime("%Y-%m-%d %H:%M:%S"),
            "sender": message.sender,
            "is_outgoing": message.is_outgoing,
            "type": message.type.value,
            "content": message.content[:500],
        }
        if message.duration_ms:
            row["duration_ms"] = message.duration_ms
        if message.transcript:
            row["transcript"] = message.transcript[:500]
        rows.append(row)
    print(
        json.dumps(
            {
                "account_id": account.id,
                "conversation": args.conversation,
                "total": len(messages),
                "showing": len(rows),
                "messages": rows,
            },
            ensure_ascii=False,
            indent=2,
        )
    )


def cmd_save_key(args: argparse.Namespace) -> None:
    hex_text = args.hex.strip()
    if not _HEX_RE.match(hex_text):
        raise SystemExit("密钥须为 64 位 hex（32 字节）")
    account = pick_account(args.account)
    SECRETS_DIR.mkdir(parents=True, exist_ok=True)
    key_path(account.id).write_text(hex_text.lower(), encoding="utf-8")
    session_db = account.db_dir / "session" / "session.db"
    first_page = session_db.open("rb").read(4096) if session_db.is_file() else b""
    verified = verify_account_key(bytes.fromhex(hex_text), first_page)
    print(
        json.dumps(
            {
                "account_id": account.id,
                "saved_to": str(key_path(account.id)),
                "verified_against_session_db": verified,
            },
            ensure_ascii=False,
            indent=2,
        )
    )


def main() -> None:
    parser = argparse.ArgumentParser(description="微信 4.x 渠道桥接（wechat-ai-memory vendor）")
    sub = parser.add_subparsers(dest="command", required=True)

    sub.add_parser("accounts", help="发现本机 4.x 账户（零密钥需求）")

    status_parser = sub.add_parser("status", help="账户+密钥就位态+库清单")
    status_parser.add_argument("--account")

    conv_parser = sub.add_parser("conversations", help="列出会话（需密钥）")
    conv_parser.add_argument("--account")
    conv_parser.add_argument("--kind", choices=["direct", "group"])
    conv_parser.add_argument("--limit", type=int)

    msg_parser = sub.add_parser("messages", help="读取消息（需密钥）")
    msg_parser.add_argument("--account")
    msg_parser.add_argument("--conversation", required=True)
    msg_parser.add_argument("--start", help="ISO 日期，如 2026-09-01")
    msg_parser.add_argument("--end")
    msg_parser.add_argument("--limit", type=int, default=50)

    save_parser = sub.add_parser("save-key", help="写入密钥到 secrets（抓密钥流程收口用）")
    save_parser.add_argument("--hex", required=True)
    save_parser.add_argument("--account")

    args = parser.parse_args()
    handlers = {
        "accounts": cmd_accounts,
        "status": cmd_status,
        "conversations": cmd_conversations,
        "messages": cmd_messages,
        "save-key": cmd_save_key,
    }
    handlers[args.command](args)


if __name__ == "__main__":
    main()
