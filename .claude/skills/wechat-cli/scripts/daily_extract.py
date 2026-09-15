#!/usr/bin/env python
"""提取指定日期全部微信聊天记录（huohuoer/wechat-cli 路径）。

sessions 拿全量会话 -> 按当日零点过滤活跃会话 -> 逐会话 history --start-time 拉消息
-> 合并落盘 data/wechat_export/<date>/all_<date>.json（本地目录，gitignore 豁免）。
用法：python daily_extract.py [YYYY-MM-DD]（默认今天）
"""
import datetime
import json
import os
import pathlib
import subprocess
import sys
import tempfile

# 控制台 GBK 遇 emoji 聊天名会炸（本机 2026-09-15 实测 🌈 崩溃）
if sys.stdout and hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace", line_buffering=True)

CLI = r"E:\AI-Station\vendor\wechat-cli\.venv\Scripts\wechat-cli.exe"
OUT_ROOT = pathlib.Path(r"E:\AI-Station\data\wechat_export")
PER_CHAT_LIMIT = 500  # 单会话单日上限，超出会在 index 里标 truncated


def run_cli(args: list[str]) -> dict:
    env = {**os.environ, "PYTHONIOENCODING": "utf-8"}
    proc = subprocess.run([CLI, *args], capture_output=True, env=env)
    try:
        return json.loads(proc.stdout.decode("utf-8"))
    except json.JSONDecodeError:
        # 管道偶发截断兜底：改走临时文件重跑一次（本机实测文件输出完整）
        fd, tmp = tempfile.mkstemp(suffix=".json")
        os.close(fd)
        try:
            with open(tmp, "wb") as sink:
                subprocess.run([CLI, *args], stdout=sink, stderr=subprocess.DEVNULL, env=env)
            return json.loads(open(tmp, encoding="utf-8").read())
        finally:
            os.unlink(tmp)


def main() -> int:
    date_text = sys.argv[1] if len(sys.argv) > 1 else datetime.date.today().isoformat()
    day = datetime.date.fromisoformat(date_text)
    midnight = datetime.datetime.combine(day, datetime.time.min).timestamp()

    sessions = run_cli(["sessions", "--limit", "200"])
    active = [s for s in sessions if s.get("timestamp", 0) >= midnight]
    print(f"[+] 会话总数 {len(sessions)}，{date_text} 活跃 {len(active)}")

    out_dir = OUT_ROOT / date_text
    out_dir.mkdir(parents=True, exist_ok=True)

    combined = []
    index = []
    failures = []
    for i, s in enumerate(active, 1):
        chat = s["chat"]
        try:
            history = run_cli(["history", chat, "--start-time", date_text, "--limit", str(PER_CHAT_LIMIT)])
            messages = history.get("messages") or []
            entry = {
                "chat": chat,
                "username": s.get("username"),
                "is_group": s.get("is_group"),
                "message_count": len(messages),
                "truncated": len(messages) >= PER_CHAT_LIMIT,
                "messages": messages,
            }
            combined.append(entry)
            index.append({k: v for k, v in entry.items() if k != "messages"})
            print(f"    [{i}/{len(active)}] {chat}: {len(messages)} 条" + ("（可能截断）" if entry["truncated"] else ""))
        except Exception as exc:  # 单会话失败不致命，记录后继续
            failures.append({"chat": chat, "error": str(exc)})
            print(f"    [{i}/{len(active)}] {chat}: 失败 {exc}")

    payload = {
        "date": date_text,
        "generated_at": datetime.datetime.now().isoformat(timespec="seconds"),
        "chat_count": len(combined),
        "message_count": sum(e["message_count"] for e in combined),
        "failures": failures,
        "index": index,
        "chats": combined,
    }
    out_file = out_dir / f"all_{date_text}.json"
    out_file.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"[+] {payload['chat_count']} 会话 / {payload['message_count']} 条消息 -> {out_file}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
