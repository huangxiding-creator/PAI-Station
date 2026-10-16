# -*- coding: utf-8 -*-
"""channels_login_weaipo — 视频号登录·We-AIPO 复刻驱动 (1016 用户令).

直驱 F:/We-AIPO/scripts/channels_login_publish.py 的 ensure_chrome+auto_login
(生产级: 快捷登录 XHR 直连法 + 像素确认弹窗 + OAuth 回调等待), 成功即退。
登录态落 9222 常驻 Chrome (与 We-AIPO 生产共用)。

用法: F:/We-AIPO/.venv/Scripts/python.exe tools/channels_login_weaipo.py
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
WE_AIPO = Path(r"F:\We-AIPO")
sys.path.insert(0, str(WE_AIPO))
sys.path.insert(0, str(WE_AIPO / "scripts"))

SCRIPTS = WE_AIPO / "scripts"


def main() -> int:
    # channels_login_publish 的 auto_login/ensure_chrome 是模块级函数;
    # import 该脚本会执行其 main → 用 source 截取法只取函数定义段
    src = (SCRIPTS / "channels_login_publish.py").read_text(encoding="utf-8")
    i = src.find("def ensure_chrome")
    j = src.find("def main()")
    if i < 0 or j < 0:
        print("[login] 函数定位失败")
        return 2
    import time
    ns: dict = {"__name__": "clp_extracted", "__file__": str(SCRIPTS / "channels_login_publish.py")}
    header = src[:i]
    # 提取 import 段 (头部) + 函数段
    exec(compile(header + src[i:j], "clp_extract", "exec"), ns)
    b, tab = ns["ensure_chrome"]()
    logged = ns["auto_login"](tab)
    print(f"[login] auto_login → {logged}; url={ (tab.url or '')[:60] }")
    if not logged:
        return 2
    # OAuth 回调稳定窗 (同 main 流程)
    for k in range(30):
        time.sleep(1)
        u = tab.url or ""
        if "oauth-callback" not in u and "/login" not in u \
                and "channels.weixin.qq.com" in u:
            print(f"[login] ✅ OAuth 回调完成 ({k+1}s) → {u[:60]}")
            time.sleep(5)
            return 0
    print("[login] ⚠ OAuth 未跳转完, 但登录态已建 (发布前再验)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
