# -*- coding: utf-8 -*-
"""Manus 生产 CLI — 只覆盖研究报告生产直接要用的功能 (用户令 2026-09-22).

范围 (近生产): 登录复用/积分/会话列表/任务状态/文件清单/成果下载/
新任务下发(规划·调研·搜集三用途)/历史会话采集/原始 API 透传.
暂不 CLI 化 (距离远): 知识库/插件/定时任务/连接器/云电脑等.

防封号铁律: 登录态优先复用 (ensure_login), 同一浏览器实例跨命令共享
(端口 9333 附着), 绝不反复退出重登.

用法:
  python manus_cli.py login 1
  python manus_cli.py whoami
  python manus_cli.py sessions
  python manus_cli.py credits
  python manus_cli.py status <sid>
  python manus_cli.py files <sid>
  python manus_cli.py download <sid>
  python manus_cli.py dispatch research_plan --topic "江苏省EPC总承包市场" --account 1
  python manus_cli.py harvest --limit 1
  python manus_cli.py raw GET "/api/chat/getSessionOutline?sessionId=XXX"
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_api as api
import manus_lib as lib

ACCOUNT_FILE = "账号列表 - 调试.txt"
DOWNLOAD_ROOT = Path("downloads")
LEDGER = Path("dispatch_ledger.json")
DAILY_PER_ACCOUNT = 1  # 日限额: 每账号每日下发次数帽 (四件套之四)


# ---------------------------------------------------------------- 会话引导
def _current_email() -> str:
    p = Path("data/current_account.txt")
    return p.read_text(encoding="utf-8").strip() if p.is_file() else ""


def _set_current(email: str):
    Path("data").mkdir(exist_ok=True)
    Path("data/current_account.txt").write_text(email, encoding="utf-8")


def _boot(page, account_idx: int | None):
    """返回 (email, tok). account_idx 给出=确保该账号登录; 不给=复用当前态."""
    email = _current_email()
    if account_idx is not None:
        email, password = lib.load_accounts(ACCOUNT_FILE)[account_idx - 1]
        sessions = lib.ensure_login(page, email, password)
        if sessions is None:
            sys.exit(f"[cli] 登录失败: {email}")
        _set_current(email)
    elif not email:
        sys.exit("[cli] 未知当前账号 — 先: python manus_cli.py login <序号>")
    tok = api.load_token(email)
    if not tok:
        try:
            tok = api.capture_token(page)
            api.save_token(email, tok)
        except RuntimeError as e:
            sys.exit(f"[cli] token 捕获失败: {e}")
    return email, tok


# ---------------------------------------------------------------- 子命令
def _credits_of(page, tok) -> str:
    st, text = api.get_credits(page, tok)
    if st != 200:
        return f"? ({st})"
    try:
        d = json.loads(text)
        return str(d.get("availableCredits",
                         d.get("totalCredits", d)))
    except Exception:
        return text[:40]


def cmd_login(args):
    page = lib.make_page()
    email, tok = _boot(page, args.account)
    print(f"[cli] 就绪: {email} 积分={_credits_of(page, tok)} "
          f"(登录态已持久, 后续命令零重登)")


def cmd_whoami(args):
    page = lib.make_page()
    email, tok = _boot(page, args.account)
    st, text = api.user_info(page, tok)
    if st != 200:
        sys.exit(f"[cli] UserInfo {st}: {text[:120]}")
    d = json.loads(text)
    info = {k: d.get(k) for k in ("email", "name", "subscriptionPlan",
                                  "planName", "createdAt") if k in d}
    print(json.dumps(info, ensure_ascii=False, indent=1))
    st, text = api.get_credits(page, tok)
    if st == 200:
        print("credits:", text[:200])


def cmd_sessions(args):
    page = lib.make_page()
    email, tok = _boot(page, args.account)
    sessions = api.list_sessions(page, tok)
    print(f"[cli] {email}: {len(sessions)} 个会话")
    for i, s in enumerate(sessions, 1):
        print(f"  {i:3d}. {s.get('uid')}  {str(s.get('title', ''))[:60]}"
              f"  [{s.get('status', '')}]")


def cmd_credits(args):
    page = lib.make_page()
    email, tok = _boot(page, args.account)
    st, text = api.get_credits(page, tok)
    print(f"[cli] {email} 积分 → {st}: {text[:200]}")


def cmd_status(args):
    page = lib.make_page()
    _boot(page, args.account)
    page.get(f"https://manus.im/app/{args.sid}")
    time.sleep(6)
    lib.dismiss_ads(page)
    print(f"[cli] {args.sid} → {lib.check_status(page)}")


def cmd_files(args):
    page = lib.make_page()
    email, tok = _boot(page, args.account)
    st, text = api.get_files(page, tok, args.sid)
    if st != 200:
        sys.exit(f"[cli] getFilesV2 {st}: {text[:120]}")
    entries = lib.list_file_entries(text)
    print(f"[cli] {args.sid}: {len(entries)} 个文件")
    for name, title, size, ctype in entries:
        print(f"  - {name}  {size}B  {ctype}  {str(title)[:40]}")


def cmd_download(args):
    page = lib.make_page()
    email, tok = _boot(page, args.account)
    st, text = api.get_files(page, tok, args.sid)
    if st != 200:
        sys.exit(f"[cli] getFilesV2 {st}: {text[:120]}")
    out = DOWNLOAD_ROOT / args.sid
    saved = lib.download_files(page, text, out, max_files=args.max)
    print(f"[cli] 下载 {len(saved)} 个文件 → {out}")
    for p in saved:
        print("  -", p)


def _ledger() -> dict:
    day = time.strftime("%Y-%m-%d")
    if LEDGER.is_file():
        try:
            d = json.loads(LEDGER.read_text(encoding="utf-8"))
            if d.get("day") == day:
                return d
        except Exception:
            pass
    return {"day": day, "dispatched": {}}


def cmd_dispatch(args):
    prompt = lib.build_prompt(args.use_case, args.topic, args.extra)
    ledger = _ledger()
    page = lib.make_page()
    email, tok = _boot(page, args.account)
    n = ledger["dispatched"].get(email, 0)
    if n >= DAILY_PER_ACCOUNT:
        sys.exit(f"[cli] 日限额: {email} 今日已下发 {n} 次 "
                 f"(帽 {DAILY_PER_ACCOUNT}, 放宽须批)")
    print(f"[cli] 下发 {args.use_case} → {email}: {args.topic[:50]}")
    sid, hits = lib.send_task(page, prompt)
    if not sid:
        sys.exit("[cli] 任务创建失败 (未跳转 /app/<sid>)")
    ledger["dispatched"][email] = n + 1
    LEDGER.write_text(json.dumps(ledger, ensure_ascii=False, indent=1),
                      encoding="utf-8")
    print(f"[cli] ✓ 新任务 {sid}")
    Path("data/dispatch_log.jsonl").parent.mkdir(exist_ok=True)
    with open("data/dispatch_log.jsonl", "a", encoding="utf-8") as fh:
        fh.write(json.dumps({
            "ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "email": email,
            "sid": sid, "use_case": args.use_case, "topic": args.topic,
            "api_hits": hits,
        }, ensure_ascii=False) + "\n")
    if hits:
        print("[cli] 新建任务命中的 API 端点 (契约素材):")
        for u in hits:
            print("   ", u)
    st, _ = api.get_credits(page, tok)
    if st == 200:
        print("[cli] 下发后积分查询 → 可用 (明细略, 防刷屏)")


def cmd_harvest(args):
    import session_harvester as hv
    sys.argv = ["session_harvester.py", "--account-file", ACCOUNT_FILE]
    if args.limit:
        sys.argv += ["--limit", str(args.limit)]
    hv.main()


def cmd_raw(args):
    page = lib.make_page()
    email, tok = _boot(page, args.account)
    body = json.loads(args.body) if args.body else ({} if args.method == "POST" else None)
    st, text = api.api_call(page, args.method, args.path, tok, body=body)
    print(f"[cli] {args.method} {args.path} → {st} (len={len(text)})")
    print(text[:3000])


# ---------------------------------------------------------------- 入口
def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)

    def common(sp):
        sp.add_argument("--account", type=int, default=None,
                        help="账号序号 (缺省=复用当前登录态, 零重登)")

    sp = sub.add_parser("login"); sp.add_argument("account", type=int)
    common(sp); sp.set_defaults(func=cmd_login)
    sp = sub.add_parser("whoami"); common(sp); sp.set_defaults(func=cmd_whoami)
    sp = sub.add_parser("sessions"); common(sp); sp.set_defaults(func=cmd_sessions)
    sp = sub.add_parser("credits"); common(sp); sp.set_defaults(func=cmd_credits)
    sp = sub.add_parser("status"); sp.add_argument("sid"); common(sp)
    sp.set_defaults(func=cmd_status)
    sp = sub.add_parser("files"); sp.add_argument("sid"); common(sp)
    sp.set_defaults(func=cmd_files)
    sp = sub.add_parser("download"); sp.add_argument("sid")
    sp.add_argument("--max", type=int, default=10); common(sp)
    sp.set_defaults(func=cmd_download)
    sp = sub.add_parser("dispatch")
    sp.add_argument("use_case", choices=["research_plan", "survey_plan", "collect"])
    sp.add_argument("--topic", required=True)
    sp.add_argument("--extra", default=""); common(sp)
    sp.set_defaults(func=cmd_dispatch)
    sp = sub.add_parser("harvest")
    sp.add_argument("--limit", type=int, default=None)
    sp.set_defaults(func=cmd_harvest)
    sp = sub.add_parser("raw")
    sp.add_argument("method", choices=["GET", "POST"])
    sp.add_argument("path"); sp.add_argument("--body", default=None)
    common(sp); sp.set_defaults(func=cmd_raw)

    args = ap.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
