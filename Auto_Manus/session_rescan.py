# -*- coding: utf-8 -*-
"""完整性复扫器 — 用户令 (09-22): 不重复采集, 但绝不漏任何账号/任务/会话.

三个漏点全闭环:
  ① 分页截断: 主动 list_sessions(pageSize=200) 全量重列;
  ② 登录失败: failed_accounts.json 登记的账号本轮重试;
  ③ 断点遗漏: manifest 逐 sid 对账, 缺的补采 (复用 harvest 采集逻辑).

产出: harvest_sessions/integrity_report.json (每账号 期望/已采/差额).
用法: python session_rescan.py [--retry-failed-only]
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
import session_harvester as hv

OUT_ROOT = Path("harvest_sessions")
MANIFEST = OUT_ROOT / "manifest.json"
FAILED = OUT_ROOT / "failed_accounts.json"
REPORT = OUT_ROOT / "integrity_report.json"

# 0922 深夜修正: 旧 7 分散名单文件已删, 用户令以完整名单为准
# (与 harvest_all.py 同源); 复扫对账也必须对着完整名单, 否则秒崩.
ACCOUNT_FILES = (
    "Manus账号（全部）260922_干净版.txt",
)


def all_accounts() -> list:
    seen, out = set(), []
    for f in ACCOUNT_FILES:
        for email, password in lib.load_accounts(f):
            if email not in seen:
                seen.add(email)
                out.append((email, password, f))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--retry-failed-only", action="store_true",
                    help="只重试 failed_accounts.json 里的账号")
    ap.add_argument("--token-only", action="store_true",
                    help="只跑有存档 token 的账号 (纯 urllib, 不开浏览器)")
    args = ap.parse_args()

    m = hv.load_manifest()
    accounts = all_accounts()
    if args.token_only:
        accounts = [a for a in accounts if api.load_token(a[0])]
    # token-only 纯 urllib 不开浏览器; 混合模式才开 (浏览器腿兜无 token 账号)
    if args.token_only:
        page = None
    else:
        page = lib.make_page()
        lib.ensure_network(page)  # 浏览器实测判据 (curl/urllib 假阴性)
    report = {}
    _from_token = {}  # email -> bool (token 直调成功的账号走无浏览器收割)
    patched = missing = login_fail = 0
    if args.retry_failed_only and FAILED.is_file():
        failed_emails = set(json.loads(
            FAILED.read_text(encoding="utf-8")).keys())
        accounts = [a for a in accounts if a[0] in failed_emails]
    print(f"[rescan] 对账范围: {len(accounts)} 账号", flush=True)

    for i, (email, password, src) in enumerate(accounts, 1):
        # 0923: token 优先路 — 存档 token 直接 urllib 直调 (免浏览器/免登录,
        # 免疫 web 区域判定); 失败才降级浏览器完整登录路.
        sessions = None
        tok = api.load_token(email)
        if tok:
            try:
                got = api.list_sessions(None, tok)
                if isinstance(got, list):
                    sessions = got
                    _from_token[email] = True
            except Exception:
                sessions = None
        if sessions is None and page is None:
            # token-only 模式且 token 失效: 无浏览器可降级, 记 login_fail
            login_fail += 1
            hv._record_failed(email, "rescan-token-expired")
            report[email] = {"expect": -1, "collected": -1,
                             "missing": [], "err": "token-expired"}
            continue
        if sessions is None:
            try:
                sessions = lib.ensure_login(page, email, password)
            except RuntimeError:
                login_fail += 1
                report[email] = {"expect": -1, "collected": -1,
                                 "missing": [], "err": "ban"}
                continue
            if sessions is None:
                login_fail += 1
                hv._record_failed(email, "rescan-login")
                report[email] = {"expect": -1, "collected": -1,
                                 "missing": [], "err": "login"}
                continue
            try:
                tok = api.capture_token(page)
                api.save_token(email, tok)
                hv.tok = tok  # collect_account 读 harvest 模块级全局
                sessions = api.list_sessions(page, tok)  # 全量重列 (防截断)
            except Exception as e:
                print(f"[rescan] {email}: 全量列会话失败 ({e}), 用监听值",
                      flush=True)
        else:
            hv.tok = tok
            hv._current_email = email
        expect = [s.get("uid") for s in (sessions or []) if s.get("uid")]
        have = {sid for (em, sid) in
                ((k.split("::", 1)) for k in m["collected"])
                if em == email}
        miss = [sid for sid in expect if sid not in have]
        report[email] = {"expect": len(expect), "collected": len(have),
                         "missing": miss, "src": src}
        if miss:
            missing += len(miss)
            print(f"[rescan] {email}: 期望 {len(expect)} 已采 "
                  f"{len(have)} 缺 {len(miss)} → 补采", flush=True)
            # token 路会话列表来自 urllib → 无浏览器收割; 浏览器路保持原样
            page_arg = None if _from_token.get(email) else page
            stats = hv.collect_account(page_arg, email,
                                       [s for s in sessions
                                        if s.get("uid") in set(miss)], m)
            patched += stats["new"]
            hv.save_manifest(m)
        # 成功补齐的账号从 failed 登记中摘除
        if FAILED.is_file():
            d = json.loads(FAILED.read_text(encoding="utf-8"))
            if email in d and not miss:
                d.pop(email)
                FAILED.write_text(json.dumps(d, ensure_ascii=False,
                                             indent=1), encoding="utf-8")
        if i < len(accounts):
            time.sleep(lib.BETWEEN_ACCOUNTS_S)

    REPORT.write_text(json.dumps(report, ensure_ascii=False, indent=1),
                      encoding="utf-8")
    total_expect = sum(v["expect"] for v in report.values() if v["expect"] >= 0)
    total_have = sum(v["collected"] for v in report.values())
    print(f"[rescan] 对账完成: 账号 {len(report)} | 期望会话 {total_expect} "
          f"| 已采 {total_have} | 本轮补采 {patched} | 登录失败 "
          f"{login_fail} | 报告 {REPORT}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
