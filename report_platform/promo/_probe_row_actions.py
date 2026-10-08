# -*- coding: utf-8 -*-
"""_probe_row_actions — 只读解剖: 09:26 行操作区 DOM 真实结构.

悬停行 → dump 操作区 outerHTML + 全部 own-text=删除 候选的计算样式
+ 最近 button/a/[role] 宿主 + 禁用态标志. 零点击零删除.
"""
from __future__ import annotations

import asyncio
import importlib.util
import io
import sys
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
PROMO = Path(__file__).resolve().parent
STATE_FILE = PROMO / "video_account_state.json"
VENDOR_ROOT = Path(r"E:\CPOPC\We-AIPO\src\vendor\video_autopub")
LIST_URL = "https://channels.weixin.qq.com/platform/post/list"
DEL_TS = "2026年10月08日 09:26"

sys.path.insert(0, str(VENDOR_ROOT))
mod_path = VENDOR_ROOT / "uploader" / "tencent_uploader" / "main.py"
spec = importlib.util.spec_from_file_location("tencent_main", mod_path)
mod = importlib.util.module_from_spec(spec)
spec.loader.exec_module(mod)


async def _list_frame(page):
    for fr in page.frames:
        try:
            body = await fr.evaluate(
                "document.body?(document.body.innerText||''):''")
        except Exception:
            continue
        if DEL_TS in (body or ""):
            return fr
    return None


async def run() -> int:
    up = mod.TencentVideo(
        title="probe", file_path=PROMO / "videos" / "cnnec_v1.mp4",
        tags=["EPC"], publish_date=None, account_file=STATE_FILE,
        category=None, is_draft=False)
    await up.init_browser()
    try:
        try:
            await up.page.set_viewport_size({"width": 1600, "height": 900})
        except Exception:
            pass
        await up.page.goto(LIST_URL, timeout=30000, wait_until="domcontentloaded")
        fr = None
        for _ in range(10):
            await asyncio.sleep(3)
            fr = await _list_frame(up.page)
            if fr is not None:
                break
        if fr is None:
            print("[probe] 找不到列表帧")
            return 1
        # 标记行 + 悬停 + 解剖 (一次 evaluate 全拿)
        info = await fr.evaluate(
            """delTs => {
                const walker = document.createTreeWalker(
                    document.body, NodeFilter.SHOW_ELEMENT);
                let hit = null, el;
                while ((el = walker.nextNode())) {
                    const own = Array.from(el.childNodes)
                        .filter(n => n.nodeType === 3)
                        .map(n => n.textContent.trim()).join('');
                    if (own === delTs) { hit = el; break; }
                }
                if (!hit) return {err: 'ts-not-found'};
                let row = hit;
                while (row && row.parentElement) {
                    const t = row.innerText || '';
                    if (t.includes('删除') && t.includes('设计+施工合并了')) break;
                    row = row.parentElement;
                }
                if (!row || !row.parentElement) return {err: 'row-not-found'};
                // 行内所有 own-text 候选 (不止第一个!)
                const cands = [];
                for (const x of row.querySelectorAll('*')) {
                    const own = Array.from(x.childNodes)
                        .filter(n => n.nodeType === 3)
                        .map(n => n.textContent.trim()).join('');
                    if (own !== '删除') continue;
                    const cs = getComputedStyle(x);
                    const host = x.closest(
                        "button,a,[role='button'],[class*='action'],[class*='btn']");
                    const hostCs = host ? getComputedStyle(host) : null;
                    cands.push({
                        tag: x.tagName, cls: (x.className || '').toString()
                            .slice(0, 60),
                        rect: [Math.round(x.getBoundingClientRect().x),
                               Math.round(x.getBoundingClientRect().y),
                               Math.round(x.getBoundingClientRect().width),
                               Math.round(x.getBoundingClientRect().height)],
                        vis: cs.visibility, op: cs.opacity,
                        disp: cs.display, pe: cs.pointerEvents,
                        hostTag: host ? host.tagName : null,
                        hostCls: host ? (host.className || '').toString()
                            .slice(0, 80) : null,
                        hostRect: host ? [Math.round(
                            host.getBoundingClientRect().width),
                            Math.round(host.getBoundingClientRect().height)]
                            : null,
                        hostDisabled: host ? ((host.disabled === true)
                            || (host.getAttribute('aria-disabled') || '')
                            || ((host.className || '').toString()
                                .match(/disable|lock/i) || [''])[0]) : null,
                        html: x.outerHTML.slice(0, 200),
                    });
                }
                return {
                    rowCls: (row.className || '').toString().slice(0, 80),
                    cands,
                    rowHtmlLen: row.outerHTML.length,
                    rowHtmlHead: row.outerHTML.slice(0, 2600),
                };
            }""", DEL_TS)
        import json as _j
        print(_j.dumps(info, ensure_ascii=False, indent=1)[:7000])
        await up.page.screenshot(
            path=str(PROMO / "videos" / "probe_actions.png"))
        return 0
    finally:
        await up.close_browser()


if __name__ == "__main__":
    sys.exit(asyncio.run(run()))
