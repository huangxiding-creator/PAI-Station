# -*- coding: utf-8 -*-
"""djyanbao_login_probe — 改版页面结构探测 + 交互扫码等待 (浏览器保持开).

步骤: 起可见持久 profile 浏览器 → 开首页 → 点登录入口 → dump 登录区
DOM 轮廓 (tab/按钮/二维码元素/placeholder) 到 stdout 供适配 → 尝试切到
扫码 tab → 轮询登录态 (--wait 秒, 用户扫码) → 成功后停 5s 存会话退出。

用法: py -3.11 reforge_factory/djyanbao_login_probe.py [--wait 600]
"""
from __future__ import annotations

import argparse
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
PROFILE = REPO / "data" / "harvest" / "_djyanbao_profile"

from DrissionPage import ChromiumOptions, ChromiumPage   # noqa: E402


def is_logged_in(page) -> bool:
    try:
        head = (page.ele("tag:body").text or "")[:300]
    except Exception:
        return False
    return ("登录" not in head) or ("退出" in head)


def dump_login_dom(page) -> None:
    """登录区轮廓: 可见 input/含'登录|扫码|微信|二维码'文本节点/img 画布."""
    try:
        info = page.run_js('''
            var out = [];
            document.querySelectorAll('input').forEach(function(i){
                if (i.offsetParent !== null)
                    out.push('input ph=' + (i.getAttribute('placeholder')||'')
                             + ' type=' + i.type);
            });
            var walker = document.createTreeWalker(
                document.body, NodeFilter.SHOW_TEXT);
            var texts = [];
            while (walker.nextNode()) {
                var t = walker.currentNode.textContent.trim();
                if (t && t.length <= 14 &&
                    /登录|扫码|微信|二维码|手机|验证|注册|密码|切换/.test(t))
                    texts.push(t);
            }
            out.push('TEXTS: ' + Array.from(new Set(texts)).join(' | '));
            document.querySelectorAll('img,canvas,iframe').forEach(function(el){
                if (el.offsetParent !== null) {
                    var r = el.getBoundingClientRect();
                    if (r.width > 80 && r.height > 80)
                        out.push((el.tagName) + ' ' + Math.round(r.width) + 'x'
                                 + Math.round(r.height)
                                 + (el.src ? ' src=' + el.src.slice(0, 60) : ''));
                }
            });
            return out.join('\\n');
        ''')
        print("[probe] 登录区 DOM 轮廓:\n" + str(info))
    except Exception as e:
        print(f"[probe] DOM dump 失败: {e}")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--wait", type=int, default=600)
    ns = ap.parse_args()
    co = ChromiumOptions()
    co.headless(False)
    co.set_argument("--window-position=80,60")
    co.set_argument("--window-size=1100,860")
    co.set_argument("--disable-blink-features=AutomationControlled")
    co.set_user_data_path(str(PROFILE))
    co.set_local_port(9533)
    page = ChromiumPage(co)                     # 已开着则接管同 profile 会话
    page.get("https://www.djyanbao.com/index", timeout=25)
    time.sleep(3)
    if is_logged_in(page):
        print("[probe] 已登录 — 会话有效")
        return 0
    # 开登录入口
    for t in ("登录 / 注册", "登录"):
        try:
            page.ele(f"text:{t}", timeout=4).click()
            time.sleep(2)
            break
        except Exception:
            continue
    dump_login_dom(page)
    # 扫码 tab 尝试 (新结构文本待 dump 后人工适配, 这里尽力而为)
    for t in ("扫码登录", "微信扫码", "二维码登录", "微信登录", "扫码"):
        try:
            page.ele(f"text:{t}", timeout=2).click()
            print(f"[probe] 已点击 {t}")
            time.sleep(1.5)
            break
        except Exception:
            continue
    dump_login_dom(page)
    print(f"[probe] ⏳ 请扫码 (等待 {ns.wait}s)...")
    deadline = time.time() + ns.wait
    while time.time() < deadline:
        time.sleep(5)
        if is_logged_in(page):
            print("[probe] ✅ 扫码登录成功 — 会话已入持久 profile")
            time.sleep(5)
            return 0
    print("[probe] 超时未登录")
    return 2


if __name__ == "__main__":
    sys.exit(main())
