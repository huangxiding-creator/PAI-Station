# -*- coding: utf-8 -*-
"""A 线 — Manus 历史会话全量采集器 (逆向剖析的资料生产件).

用户令 (2026-09-22): 全面深刻分析所有 Manus 账号的历史运行详细规划与
执行过程 — 把 Manus 的工程化能力逆向出来汲取进本项目.

采集路径 (2026-09-22 token 版实证): 登录账号 → capture_token 拦截
authorization → api_call (XHR 带 Bearer token) 抓 getSessionV2 /
getSessionFilesV2 / getSessionOutline / GetAvailableCredits (POST) →
结构化落盘. 旧版纯 cookie XHR 全 403, 根因=缺 authorization header.

账号安全: 四件套全内建 (lib.CircuitBreaker + 节流 30s + 封号即停);
断点续跑: manifest 键 account::sid 已采集即跳过; 只读采集, 绝不操作任务.

用法:
  python session_harvester.py --limit 1            # 小批量验证
  python session_harvester.py --limit 5            # 小批
  python session_harvester.py                       # 全量 (晚间窗口)
  python session_harvester.py --account-file "账号列表 - 30个标杆项目.txt"
"""
from __future__ import annotations

import argparse
import hashlib
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_api as api
import manus_lib as lib

OUT_ROOT = Path("harvest_sessions")
MANIFEST = OUT_ROOT / "manifest.json"

KIND_PATHS = {
    "v2": "/api/chat/getSessionV2?sessionId={sid}&type=private",
    "files": "/api/chat/getSessionFilesV2?sessionId={sid}",
    "outline": "/api/chat/getSessionOutline?sessionId={sid}",
}


def load_manifest() -> dict:
    if MANIFEST.is_file():
        try:
            return json.loads(MANIFEST.read_text(encoding="utf-8"))
        except Exception:
            pass
    return {"collected": {}, "accounts": {}}


def save_manifest(m: dict):
    MANIFEST.parent.mkdir(parents=True, exist_ok=True)
    tmp = MANIFEST.with_suffix(".tmp")
    tmp.write_text(json.dumps(m, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    tmp.replace(MANIFEST)


def fetch_kind(page, tok: dict, sid: str, kind: str) -> tuple[int, str]:
    """带 token 调 API; 401/403 时重捕 token 重试一次 (自愈)."""
    if kind == "credits":
        method, path = "POST", "/user.v1.UserService/GetAvailableCredits"
        body: dict | None = {}
    else:
        method, path = "GET", KIND_PATHS[kind].format(sid=sid)
        body = None
    st, text = api.api_call(page, method, path, tok, body=body)
    if st in (401, 403):
        try:
            tok.update(api.capture_token(page))
            api.save_token(_current_email, tok)
            st, text = api.api_call(page, method, path, tok, body=body)
        except Exception:
            pass
    return st, text


_current_email = ""  # save_token 用 (模块级, 避免层层传参)


def collect_account(page, email: str, sessions: list, m: dict) -> dict:
    """采单账号全会话 → 返回统计. 只读, 绝不操作任务."""
    stats = {"sessions": len(sessions), "new": 0, "skip": 0,
             "fail": 0, "credits": None}
    st, body = fetch_kind(page, tok, "", "credits")
    if st == 200:
        try:
            stats["credits"] = json.loads(body)
        except Exception:
            pass
    acct_dir = OUT_ROOT / hashlib.md5(email.encode()).hexdigest()[:10]
    for sess in sessions:
        sid = sess.get("uid")
        if not sid:
            continue
        key = f"{email}::{sid}"
        if key in m["collected"]:
            stats["skip"] += 1
            continue
        rec = {"email_hash": acct_dir.name, "sid": sid,
               "title": str(sess.get("title", ""))[:120],
               "ts": time.strftime("%Y-%m-%dT%H:%M:%S")}
        ok_any = False
        for kind, name in (("v2", "messages"), ("files", "files"),
                           ("outline", "outline")):
            st, body = fetch_kind(page, tok, sid, kind)
            if st == 200 and body:
                acct_dir.mkdir(parents=True, exist_ok=True)
                (acct_dir / f"{sid}.{name}.json").write_text(
                    body, encoding="utf-8")
                rec[name + "_len"] = len(body)
                ok_any = True
            else:
                rec[name + "_status"] = st
            time.sleep(1.0)  # 请求间节流
        if ok_any:
            m["collected"][key] = rec
            stats["new"] += 1
        else:
            stats["fail"] += 1
        save_manifest(m)  # 每会话 checkpoint (断点续跑)
    return stats


def main():
    global tok
    ap = argparse.ArgumentParser()
    ap.add_argument("--account-file", default="账号列表 - 调试.txt")
    ap.add_argument("--limit", type=int, default=None)
    ap.add_argument("--delay", type=int, default=lib.BETWEEN_ACCOUNTS_S)
    args = ap.parse_args()

    accounts = lib.load_accounts(args.account_file, args.limit)
    print(f"[harvest] {args.account_file}: {len(accounts)} 账号", flush=True)
    m = load_manifest()
    breaker = lib.CircuitBreaker()
    page = lib.make_page()

    total_new = 0
    for i, (email, password) in enumerate(accounts, 1):
        global _current_email
        _current_email = email
        print(f"[harvest] === 账号 {i}/{len(accounts)}: {email} ===", flush=True)
        try:
            sessions = lib.ensure_login(page, email, password)
        except RuntimeError as e:
            print(f"[harvest] 熔断信号: {e} — 全局停批", flush=True)
            breaker.record_ban(email)
            break
        if sessions is None:
            stop = breaker.record_fail()
            print(f"[harvest] 登录失败 (连续 {breaker.consecutive}) "
                  f"{'→ 冷却停批' if stop else '→ 跳过'}", flush=True)
            if stop:
                break
            time.sleep(args.delay)
            continue
        breaker.record_ok()
        try:
            tok = api.capture_token(page)
            api.save_token(email, tok)
        except RuntimeError as e:
            print(f"[harvest] token 捕获失败: {e} — 跳过该账号", flush=True)
            time.sleep(args.delay)
            continue
        stats = collect_account(page, email, sessions, m)
        total_new += stats["new"]
        m["accounts"][email] = {"sessions": stats["sessions"],
                                "credits": stats["credits"],
                                "ts": time.strftime("%Y-%m-%dT%H:%M:%S")}
        save_manifest(m)
        cr = stats["credits"]
        cr_txt = ""
        if isinstance(cr, dict):
            cr_txt = " 积分=" + str(
                cr.get("availableCredits", cr.get("credits", "?")))
        print(f"[harvest] {email}: 会话 {stats['sessions']} 新采 "
              f"{stats['new']} 跳 {stats['skip']} 败 {stats['fail']}"
              f"{cr_txt}", flush=True)
        if i < len(accounts):
            time.sleep(args.delay)  # 四件套之节流
    print(f"[harvest] 批完成: 新采会话 {total_new}; manifest={MANIFEST}",
          flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
