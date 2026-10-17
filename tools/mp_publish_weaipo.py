# -*- coding: utf-8 -*-
"""mp_publish_weaipo — 公众号发文·We-AIPO autopub 复刻驱动 (1016 用户令:
功能从 F:\\We-AIPO 复刻, 不造轮子).

直驱 We-AIPO autopub 核心管线 (无 GUI): Orchestrator.run_for_profile —
会话复用 (acct 档案 cookie) → ensure_login (活会话零扫码) → 草稿箱发表
(选择器/安全门/截图存证/验证全复刻) → 拟人间隔. 发表内容=各号草稿箱中
已就位文章 (push_article API 推入的同一草稿箱).

用法 (须用 We-AIPO venv, 其依赖齐):
  F:/We-AIPO/.venv/Scripts/python.exe tools/mp_publish_weaipo.py \
      --profile acct05 --nickname 工程行业大脑 [--dry]
档案映射 (autopub/data/live_login_state.json):
  acct01=总包说  acct05=工程行业大脑  acct07=总包之声(会话死, 需扫码)
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
WE_AIPO = Path(r"F:\We-AIPO")
AUTOPUB = WE_AIPO / "autopub"
sys.path.insert(0, str(AUTOPUB))


def main() -> int:
    ap = argparse.ArgumentParser(description="公众号发文(We-AIPO autopub 复刻驱动)")
    ap.add_argument("--profile", required=True, help="如 acct05")
    ap.add_argument("--nickname", default="", help="目标公众号昵称 (错号守卫)")
    ap.add_argument("--dry", action="store_true", help="只登入验证, 不跑发表管线")
    ns = ap.parse_args()

    from src.config import load_config
    from src.core.state import StateDB
    from src.core.orchestrator import Orchestrator
    from src.notify.wecom import WecomNotifier

    cfg = load_config()
    state = StateDB()
    notifier = WecomNotifier(cfg) if getattr(cfg, "通知", None) else None
    orch = Orchestrator(cfg, state, notifier)
    if ns.dry:
        from src.browser.session import BrowserSession
        from src.browser.login import ensure_login
        sess = BrowserSession(cfg, ns.profile)
        sess.start()
        try:
            r = ensure_login(sess, timeout_minutes=2, target_nickname=ns.nickname)
            print(f"[rep] dry: login.ok={r.ok} detail={r.detail} "
                  f"nickname={r.nickname}")
        finally:
            sess.stop()
        return 0
    rep = orch.run_for_profile(ns.profile, ns.nickname or "")
    if rep is None:
        print(f"[rep] {ns.profile} 管线未跑成 (登录失败/会话启动失败)")
        return 2
    ok = [r for r in (rep.results or ()) if getattr(r, "ok", False)]
    print(f"[rep] {ns.profile} 完成: ok={len(ok)}/{len(rep.results or ())} "
          f"triggers={len(rep.triggers or ())}")
    for r in (rep.results or ()):
        print("   -", getattr(r, "title", "")[:30],
              "ok=" + str(getattr(r, "ok", "?")),
              str(getattr(r, "detail", ""))[:40])
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
