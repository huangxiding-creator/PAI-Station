# -*- coding: utf-8 -*-
"""publish_sitting_drafts — 定向发布我们自己推入草稿箱的宣传稿 (F5b 第一弹).

复用 autopub 全套发布机器 (BrowserSession/ensure_login/DraftPublisher:
拟人间隔/弹窗处理/金标准验证/StateDB 记账), 只在 _parse_cards 缝上做
标题过滤——只发白名单内的草稿卡, 其余卡留给 WeAIPO 自己的窗口.
免打扰红线: 不碰贴图 tab, 不碰非白名单卡, 尊重 data/run.lock,
登录失效(需扫码)直接放弃退出, 绝不阻塞等人扫.

用法 (cwd 无关, 自动切 autopub 根):
  python publish_sitting_drafts.py --profile acct07 --nickname 总包之声 \
      --match "设计与施工" --match "信息差" [--go]
默认 dry-run: 只解析卡片并打印将发布名单, --go 才真发.
"""
from __future__ import annotations

import argparse
import io
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
AUTOPUB = Path(r"E:\CPOPC\We-AIPO\autopub")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--profile", required=True, help="浏览器档案名, 如 acct07")
    ap.add_argument("--nickname", required=True, help="公号昵称 (StateDB 记账键)")
    ap.add_argument("--match", action="append", required=True,
                    help="标题包含片段 (可多次); 命中任一即入白名单")
    ap.add_argument("--go", action="store_true", help="真发布 (默认 dry-run)")
    ns = ap.parse_args()

    # cwd 切到 autopub 根: run.lock/StateDB/浏览器 profile 全是相对路径
    os_chdir = AUTOPUB
    sys.path.insert(0, str(AUTOPUB))
    import os
    os.chdir(os_chdir)

    from run import _acquire_run_lock, _release_run_lock   # 串行红线同款锁
    from src.config import load_config
    from src.core.state import StateDB
    from src.browser.session import BrowserSession
    from src.browser.login import ensure_login
    from src.browser.drafts import DraftPublisher

    if not _acquire_run_lock():
        print("[pub] run.lock 被占 (WeAIPO 窗口在跑?) — 按免打扰红线让路退出")
        return 2
    try:
        cfg = load_config()
        state = StateDB()
        session = BrowserSession(cfg, ns.profile)
        try:
            session.start()
        except RuntimeError as exc:
            print(f"[pub] 浏览器启动失败: {exc}")
            _release_run_lock()
            return 1
        try:
            # 登录: cookie 活=秒过; 死=最多等 1 分钟 (不等扫码, 交给白天窗口)
            login = ensure_login(session, timeout_minutes=1)
            if not login.ok:
                print(f"[pub] 登录失效 ({login.detail}) — 放弃, 留给白天窗口")
                return 3
            print(f"[pub] 登录 OK: {login.nickname}")

            pub = DraftPublisher(session, cfg, state, None,
                                 account_name=ns.nickname)
            orig_parse = pub._parse_cards

            def filtered(*a, **k):
                import re as _re
                cards = orig_parse(*a, **k)
                # 同题多版 (旧QR重推遗留): 每片段只留时间最晚的一张卡
                best: dict[str, object] = {}
                for c in cards:
                    tt = str(getattr(c, "time_text", "") or "")
                    m = _re.search(r"(\d{1,2}):(\d{2})", tt)
                    tkey = int(m.group(1)) * 60 + int(m.group(2)) if m else -1
                    for frag in ns.match:
                        if frag in (c.title or ""):
                            if frag not in best or tkey > best[frag][0]:
                                best[frag] = (tkey, c)
                            break
                keep = [c for _, c in best.values()]
                print(f"[pub] 过滤: {len(cards)} 卡 → 白名单 {len(keep)} 卡:")
                for c in keep:
                    print(f"      - [{getattr(c, 'time_text', '')}] "
                          f"{c.title[:44]}")
                return keep

            pub._parse_cards = filtered
            if not ns.go:
                # dry-run: 只解析打印, 不发布
                pub._open_draft_box()
                filtered()
                print("[pub] DRY-RUN 完 (未发布). 加 --go 真发")
                return 0
            t0 = time.time()
            results = pub.publish_article_drafts()
            ok = [r for r in results if r.ok]
            bad = [r for r in results if not r.ok]
            print(f"[pub] 发布完成 {time.time()-t0:.0f}s: "
                  f"{len(ok)} 成功 / {len(bad)} 失败")
            for r in results:
                mark = "OK " if r.ok else "ERR"
                print(f"      [{mark}] {r.item.title[:40]} | {r.detail[:60]}")
            return 0 if not bad else 1
        finally:
            try:
                session.stop()
            except Exception:
                pass
    finally:
        _release_run_lock()


if __name__ == "__main__":
    sys.exit(main())
