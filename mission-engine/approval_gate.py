# -*- coding: utf-8 -*-
"""approval_gate — 微信审批闸 (W4.3b-b 审批事件流接线)。

出站: request → 落 ledger/approvals.jsonl(pending) + 写桥出站池
      (~/.wechat-claude-code/outbound-spool/*.json, daemon 30s 刷达手机)
      + 企微兜底通知(tools/notify_approval_wecom.py)。
入站: 用户手机回复 批准/否决/修改<意见> → 微信座舱(值守官)运行
      consume --text "<原文>" → 决议落账(approvals+run-ledger) → 座舱回执。
等待: wait --id <id> 阻塞轮询, 决出即 rc=0 (验收: 回复批准 60s 内开闸落账)。

账本 approvals.jsonl append-only 两类行:
  {"event":"request","approval_id":APPR-...,"ts":...,"task":...,"title":...,
   "summary":...,"benefit":...,"push":"wechat+wecom|wechat|wecom|none|spool_err:..."}
  {"event":"decision","approval_id":...,"ts":...,"decision":"approve|reject|revise",
   "note":...,"via":"cockpit|engine","elapsed_sec":...}

用法:
  py -X utf8 approval_gate.py request --title T --summary S --benefit B [--task W4.4] [--no-push]
  py -X utf8 approval_gate.py consume --text "批准"          # 座舱: 用户微信原文
  py -X utf8 approval_gate.py consume --id APPR-... --decision approve [--note N]
  py -X utf8 approval_gate.py status [--json]
  py -X utf8 approval_gate.py wait --id APPR-... [--timeout-sec 60]

env 重定向(测试隔离): ME_HOME / ME_APPROVAL_LEDGER / ME_RUN_LEDGER /
ME_SPOOL_DIR / ME_WECOM(空串=禁用兜底) / ME_BRIDGE_PID
退出码: 0=成功(含 none_pending/unrecognized) 1=wait超时 2=用法/内部错误
"""
from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import time
import uuid
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")

HOME = Path(os.environ.get("ME_HOME", Path(__file__).resolve().parent))
APPROVAL_LEDGER = Path(os.environ.get(
    "ME_APPROVAL_LEDGER", HOME / "ledger" / "approvals.jsonl"))
RUN_LEDGER = Path(os.environ.get(
    "ME_RUN_LEDGER", HOME / "ledger" / "run-ledger.jsonl"))
SPOOL_DIR = Path(os.environ.get(
    "ME_SPOOL_DIR", Path.home() / ".wechat-claude-code" / "outbound-spool"))
WECOM = os.environ.get(
    "ME_WECOM", r"E:\AI-Station\tools\notify_approval_wecom.py")
BRIDGE_PID_FILE = Path(os.environ.get(
    "ME_BRIDGE_PID", Path.home() / ".wechat-claude-code" / "wechat-claude-code.pid"))


# ---------------------------------------------------------------------------
# 基础件
# ---------------------------------------------------------------------------

def now_ts() -> str:
    return time.strftime("%Y-%m-%d %H:%M:%S")


def append_jsonl(path: Path, obj: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("a", encoding="utf-8") as f:
        f.write(json.dumps(obj, ensure_ascii=False) + "\n")


def read_approvals() -> list[dict]:
    if not APPROVAL_LEDGER.exists():
        return []
    rows = []
    for line in APPROVAL_LEDGER.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            rows.append(json.loads(line))
        except json.JSONDecodeError:
            continue  # 坏行跳过(只增不删, 留痕在文件里)
    return rows


def pending_approvals(rows: list[dict] | None = None) -> list[dict]:
    """按账本顺序返回尚无 decision 行的 request。"""
    rows = read_approvals() if rows is None else rows
    decided = {r["approval_id"] for r in rows if r.get("event") == "decision"}
    return [r for r in rows
            if r.get("event") == "request" and r["approval_id"] not in decided]


def bridge_alive() -> bool:
    try:
        pid = int(BRIDGE_PID_FILE.read_text(encoding="utf-8").strip())
    except (OSError, ValueError):
        return False
    try:
        # 中文Windows tasklist 输出为GBK; 字节模式+宽容解码, PID为ASCII必然存活
        raw = subprocess.run(["tasklist", "/FI", f"PID eq {pid}"],
                             capture_output=True, timeout=10).stdout or b""
        return str(pid).encode() in raw
    except (OSError, subprocess.SubprocessError):
        return False


# ---------------------------------------------------------------------------
# 出站: request
# ---------------------------------------------------------------------------

def wechat_text(appr: dict) -> str:
    return (f"🔔 引擎审批请求 [{appr['approval_id']}]\n"
            f"{appr['title']}\n"
            f"一句话: {appr['summary']}\n"
            f"预期收益: {appr['benefit']}\n"
            f"──────────────\n"
            f"回复 「批准」/「否决」/「修改 你的意见」")


def cmd_request(args: argparse.Namespace) -> int:
    approval_id = f"APPR-{time.strftime('%Y%m%d-%H%M%S')}-{uuid.uuid4().hex[:4]}"
    push = "none"

    if not args.no_push:
        appr = {"approval_id": approval_id, "title": args.title,
                "summary": args.summary, "benefit": args.benefit}
        body = wechat_text(appr)
        if args.body_file:
            try:
                body = (f"🔔 引擎审批请求 [{approval_id}]\n"
                        + Path(args.body_file).read_text(encoding="utf-8").strip()
                        + "\n──────────────\n回复 「批准」/「否决」/「修改 你的意见」")
            except OSError as e:
                print(f"[body-file] 读取失败退回三行格式: {e}", file=sys.stderr)
        try:
            SPOOL_DIR.mkdir(parents=True, exist_ok=True)
            spool_file = SPOOL_DIR / f"{approval_id}.json"
            spool_file.write_text(json.dumps({
                "text": body, "created_at": time.strftime(
                    "%Y-%m-%dT%H:%M:%S+08:00"),
            }, ensure_ascii=False), encoding="utf-8")
            push = "wechat"
        except OSError as e:
            push = f"spool_err:{e}"

    if not args.no_push and WECOM and Path(WECOM).exists():
        detail = f"{args.summary}\n预期收益: {args.benefit}\n回复: 批准/否决/修改"
        try:
            r = subprocess.run(
                [sys.executable, "-X", "utf8", WECOM, args.title, detail],
                capture_output=True, timeout=30)
            if r.returncode == 0:
                push += "+wecom" if push == "wechat" else "wecom"
            else:
                print(f"[wecom-fallback] 兜底通知失败 rc={r.returncode}: "
                      f"{r.stdout.decode('utf-8', errors='replace')[:200]}",
                      file=sys.stderr)
        except (OSError, subprocess.SubprocessError) as e:
            print(f"[wecom-fallback] 兜底通知异常(不阻塞): {e}", file=sys.stderr)

    row = {"event": "request", "approval_id": approval_id, "ts": now_ts(),
           "task": args.task, "title": args.title, "summary": args.summary,
           "benefit": args.benefit, "push": push}
    append_jsonl(APPROVAL_LEDGER, row)
    append_jsonl(RUN_LEDGER, {"ts": now_ts(), "event": "approval_requested",
                              "detail": {"approval_id": approval_id,
                                         "title": args.title, "push": push,
                                         "bridge_alive": bridge_alive()}})
    print(json.dumps({"approval_id": approval_id, "push": push,
                      "bridge_alive": bridge_alive()},
                     ensure_ascii=False))
    return 0


# ---------------------------------------------------------------------------
# 入站: consume (座舱值守官调)
# ---------------------------------------------------------------------------

def parse_reply(text: str) -> dict:
    """解析用户回复原文 → {decision, note, approval_id}。
    decision: approve|reject|revise|null(非审批语义)"""
    import re
    t = text.strip().lower()
    for ch in "，。！! \t":  # 宽容首尾标点/空格
        t = t.strip(ch)
    # 宽容全角
    t = t.replace("　", " ")
    id_hit = re.search(r"APPR-\d{8}-\d{6}-[0-9a-fA-F]{4}", text)
    target = id_hit.group(0).upper() if id_hit else None
    # note 中剔除 id 原文（id 已单列）
    note_src = text.replace(id_hit.group(0), " ") if id_hit else text

    if t.startswith(("批准", "同意", "approve", "yes", "批")):
        return {"decision": "approve", "note": "", "approval_id": target}
    if t.startswith(("否决", "驳回", "拒绝", "reject", "no", "驳")):
        return {"decision": "reject", "note": "", "approval_id": target}
    for kw in ("修改", "改一下", "revise"):
        if t.startswith(kw):
            note = note_src.strip()[len(kw):].strip(" ：:")
            return {"decision": "revise", "note": note, "approval_id": target}
    return {"decision": None, "note": "", "approval_id": target}


def canonical_id(rows: list[dict], typed: str) -> str | None:
    """用户手打 id 大小写宽容 → 账本原样 id。"""
    for r in rows:
        if r.get("approval_id", "").upper() == typed.upper():
            return r["approval_id"]
    return None


def find_target(rows: list[dict], approval_id: str | None) -> tuple[dict | None, str]:
    """按 id 或最老 pending 定位待批项。返回 (request行, 状态说明)"""
    pend = pending_approvals(rows)
    if approval_id:
        cid = canonical_id(rows, approval_id)
        if cid:
            for r in pend:
                if r["approval_id"] == cid:
                    return r, ""
            return None, "already_decided"  # 存在但已决
        return None, "unknown_id"
    if pend:
        return pend[0], ""
    return None, "none_pending"


def decide(approval_id: str, decision: str, note: str, via: str) -> dict | None:
    """落决议账; 幂等: 已决返回原 decision 行。"""
    rows = read_approvals()
    req = next((r for r in rows if r.get("event") == "request"
                and r["approval_id"] == approval_id), None)
    old = next((r for r in rows if r.get("event") == "decision"
                and r["approval_id"] == approval_id), None)
    if old:
        return {"already_decided": True, **old}
    if req is None:
        return None
    elapsed = None
    try:
        t_req = time.mktime(time.strptime(req["ts"], "%Y-%m-%d %H:%M:%S"))
        elapsed = round(time.time() - t_req, 1)
    except ValueError:
        pass
    row = {"event": "decision", "approval_id": approval_id, "ts": now_ts(),
           "decision": decision, "note": note, "via": via,
           "elapsed_sec": elapsed}
    append_jsonl(APPROVAL_LEDGER, row)
    append_jsonl(RUN_LEDGER, {"ts": now_ts(), "event": "approval_decided",
                              "detail": {"approval_id": approval_id,
                                         "decision": decision,
                                         "elapsed_sec": elapsed,
                                         "title": req["title"], "via": via}})
    return row


def cmd_consume(args: argparse.Namespace) -> int:
    if args.text is not None:
        p = parse_reply(args.text)
        if p["decision"] is None:
            print(json.dumps({"parsed": "unrecognized",
                              "hint": "非审批指令, 按值守官语义自由处理",
                              "text": args.text}, ensure_ascii=False))
            return 0
        decision, note, target_id = p["decision"], p["note"], p["approval_id"]
    elif args.id and args.decision in ("approve", "reject", "revise"):
        decision, note, target_id = args.decision, args.note or "", args.id
    else:
        print("用法: consume --text <原文> 或 --id ID --decision approve|reject|revise",
              file=sys.stderr)
        return 2

    rows = read_approvals()
    req, status = find_target(rows, target_id)
    if status == "already_decided":
        cid = canonical_id(rows, target_id)
        old = next(r for r in rows if r.get("event") == "decision"
                   and r["approval_id"] == cid)
        print(json.dumps({"already_decided": True, **old}, ensure_ascii=False))
        return 0
    if req is None:
        print(json.dumps({"result": status, "hint": {
            "none_pending": "当前无待批事项",
            "unknown_id": f"未找到待批项 {target_id}"}[status]}, ensure_ascii=False))
        return 0

    row = decide(req["approval_id"], decision, note, via="cockpit")
    verdict = {"approve": "✅ 已批准", "reject": "❌ 已否决",
               "revise": "✏️ 已记录修改意见"}[decision]
    out = {**row, "reply_to_user": f"{verdict} [{req['approval_id']}] {req['title']}"}
    if decision == "revise" and not note:
        out["reply_to_user"] += "（未附意见, 执行时按值守官理解或再询）"
    print(json.dumps(out, ensure_ascii=False))
    return 0


# ---------------------------------------------------------------------------
# 查询/等待
# ---------------------------------------------------------------------------

def cmd_status(args: argparse.Namespace) -> int:
    pend = pending_approvals()
    if args.json:
        print(json.dumps(pend, ensure_ascii=False))
    elif pend:
        for r in pend:
            age = ""
            try:
                born = time.mktime(time.strptime(r["ts"], "%Y-%m-%d %H:%M:%S"))
                age = f" 年龄{(time.time() - born) / 3600:.1f}h"
            except (ValueError, TypeError, OverflowError):
                pass
            print(f"[{r['approval_id']}] {r['title']} push={r['push']}{age}")
    else:
        print("(无待批)")
    return 0


def cmd_wait(args: argparse.Namespace) -> int:
    deadline = time.time() + args.timeout_sec
    while time.time() < deadline:
        rows = read_approvals()
        row = next((r for r in rows if r.get("event") == "decision"
                    and r["approval_id"] == args.id), None)
        if row:
            print(json.dumps(row, ensure_ascii=False))
            return 0
        time.sleep(args.poll_sec)
    print(json.dumps({"result": "timeout", "approval_id": args.id,
                      "waited_sec": args.timeout_sec}, ensure_ascii=False),
          file=sys.stderr)
    return 1


def main() -> int:
    ap = argparse.ArgumentParser(description="微信审批闸 W4.3b-b")
    sub = ap.add_subparsers(dest="cmd", required=True)

    p = sub.add_parser("request", help="建审批请求并推送微信(企微兜底)")
    p.add_argument("--title", required=True)
    p.add_argument("--summary", required=True)
    p.add_argument("--benefit", required=True)
    p.add_argument("--task", default="")
    p.add_argument("--body-file",
                   help="六件套长文(审批推送内容铁律): 文件内容替代默认三行格式推送")
    p.add_argument("--no-push", action="store_true",
                   help="只落账不推送(测试/重放)")
    p.set_defaults(fn=cmd_request)

    p = sub.add_parser("consume", help="消费用户回复(座舱值守官调)")
    p.add_argument("--text", help="用户微信回复原文")
    p.add_argument("--id", help="直接指定 approval_id")
    p.add_argument("--decision", choices=["approve", "reject", "revise"])
    p.add_argument("--note", default="")
    p.set_defaults(fn=cmd_consume)

    p = sub.add_parser("status", help="查待批清单")
    p.add_argument("--json", action="store_true")
    p.set_defaults(fn=cmd_status)

    p = sub.add_parser("wait", help="阻塞等决议(60s开闸验收)")
    p.add_argument("--id", required=True)
    p.add_argument("--timeout-sec", type=int, default=60)
    p.add_argument("--poll-sec", type=float, default=2.0)
    p.set_defaults(fn=cmd_wait)

    args = ap.parse_args()
    try:
        return args.fn(args)
    except Exception as e:  # noqa: BLE001 — CLI 兜底, 错误须可见
        print(f"[approval_gate] 内部错误: {e}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
