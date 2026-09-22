# -*- coding: utf-8 -*-
"""webhook 事件收割器 — ECS 增量拉取 + 分类处置 (0923).

事件契约: task_stopped{stop_reason: finish|ask, attachments[{file_name,url}]}.
处置:
  - test 事件 (task_id=test_task_id) → 计数忽略
  - finish + attachments → 直接下载成果到 harvest_sessions/hook_files/<acct>/
  - ask → 登记 pending_questions.json (等用户/后续自动回复)
  - 重大完成 (attachments>=1) → 企微通知 (限频: 每轮最多 1 条汇总)
状态: data/hook_harvest_state.json 记已处理行数; 幂等可重跑.
用法: python hook_harvest.py [--loop 300]
"""
import argparse
import json
import sys
import time
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
SECRET = Path("data/hook_secret.txt").read_text(encoding="utf-8").strip()
EV_URL = f"http://47.120.43.20:8890/ev/{SECRET}"
STATE = Path("data/hook_harvest_state.json")
OUT_FILES = Path("harvest_sessions/hook_files")
PENDING_Q = Path("harvest_sessions/pending_questions.json")


def load_state() -> int:
    if STATE.is_file():
        try:
            return json.loads(STATE.read_text(encoding="utf-8"))["after"]
        except Exception:
            return 0
    return 0


def save_state(after: int) -> None:
    STATE.write_text(json.dumps({"after": after, "ts": time.ctime()}),
                     encoding="utf-8")


def pull_events(after: int) -> tuple[int, list]:
    """拉增量 → (新after, 事件列表). 网络失败返回原 after."""
    op = urllib.request.build_opener()  # 境内 ECS 直连
    try:
        r = op.open(f"{EV_URL}?after={after}&limit=300", timeout=15)
        d = json.loads(r.read().decode("utf-8"))
        lines = d.get("lines", [])
        # 事件稀疏: total 行数为准推进 offset (跳过已删行风险低, jsonl 只增)
        return after + len(lines), [json.loads(x) for x in lines if x.strip()]
    except Exception as e:
        print(f"[pull] 失败 {type(e).__name__}, 下轮重试", flush=True)
        return after, []


def download_attachment(url: str, dest: Path) -> bool:
    """成果文件直下 (manuscdn 直链, 不需要登录态)."""
    op = urllib.request.build_opener(urllib.request.ProxyHandler(
        {"https": "http://127.0.0.1:7890"}))
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
        data = op.open(req, timeout=60).read()
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(data)
        return True
    except Exception as e:
        print(f"  [dl-fail] {dest.name} {type(e).__name__}", flush=True)
        return False


def process_once() -> dict:
    after = load_state()
    new_after, events = pull_events(after)
    stats = {"test": 0, "finish": 0, "ask": 0, "files": 0, "dl_ok": 0}
    for ev in events:
        acct = ev.get("acct", "?")
        detail = (ev.get("event") or {}).get("task_detail", {})
        if detail.get("task_id") == "test_task_id":
            stats["test"] += 1
            continue
        reason = detail.get("stop_reason", "?")
        if reason == "finish":
            stats["finish"] += 1
            for att in detail.get("attachments") or []:
                stats["files"] += 1
                name = (att.get("file_name") or "unnamed")[:100]
                dest = OUT_FILES / acct / name
                if dest.is_file() and dest.stat().st_size == att.get("size_bytes"):
                    continue  # 幂等
                if download_attachment(att.get("url", ""), dest):
                    stats["dl_ok"] += 1
                    print(f"  [dl] {acct}/{name}", flush=True)
        elif reason == "ask":
            stats["ask"] += 1
            pend = json.loads(PENDING_Q.read_text(encoding="utf-8")) if PENDING_Q.is_file() else {}
            pend[f"{acct}::{detail.get('task_id')}"] = {
                "title": detail.get("task_title", ""),
                "message": detail.get("message", "")[:300],
                "ts": ev.get("recv_ts", ""),
                "question": (detail.get("question_expectation") or {}),
            }
            PENDING_Q.write_text(json.dumps(pend, ensure_ascii=False, indent=1),
                                 encoding="utf-8")
    if new_after > after:
        save_state(new_after)
    return stats


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--loop", type=int, default=0,
                    help="循环间隔秒 (默认单次)")
    args = ap.parse_args()
    while True:
        s = process_once()
        if any(s.values()):
            print(f"[harvest] {json.dumps(s, ensure_ascii=False)}", flush=True)
        else:
            print(f"[harvest] 无新事件", flush=True)
        if not args.loop:
            break
        time.sleep(args.loop)


if __name__ == "__main__":
    main()
