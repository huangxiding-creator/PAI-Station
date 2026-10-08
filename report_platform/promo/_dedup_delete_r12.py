# -*- coding: utf-8 -*-
"""_dedup_delete_r12 — 定点删除 09:26 重复条 (r12 误发), 保 09:31 (r13 原创审核中).

背景: r12/r13 同内容双发 (verify 按标题搜索=永远miss 的bug 导致 r13 重发).
本脚本唯一目标: 删除时间戳精确 = '2026年10月08日 09:26' 的那一条.

护栏:
  G1 全帧精确匹配 '2026年10月08日 09:26' 必须恰好 1 处 (否则中止)
  G2 '2026年10月08日 09:31' (r13, 保留条) 必须存在 (否则中止)
  G3 行容器 innerText 须同时含 删除+09:26+设计+施工合并了 (确认是视频行)
  G4 删后复扫: 09:26 消失 ∧ 09:31 仍在
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
KEEP_TS = "2026年10月08日 09:31"
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
        if DEL_TS in (body or "") or KEEP_TS in (body or ""):
            return fr
    return None


async def run() -> int:
    up = mod.TencentVideo(
        title="dedup", file_path=PROMO / "videos" / "cnnec_v1.mp4",
        tags=["EPC"], publish_date=None, account_file=STATE_FILE,
        category=None, is_draft=False)
    await up.init_browser()
    try:
        # r12 同款坑根治: 原生 confirm() 无 handler = 自动「取消」= 删除被
        # 平台静默撤销. 全部 accept (本脚本只对 09:26 行点过删除, 无误伤面).
        def _on_dialog(d):
            print(f"[dedup] JS原生弹窗({d.type})→accept: "
                  f"{(d.message or '')[:80]!r}")
            asyncio.ensure_future(d.accept())
        up.page.on("dialog", _on_dialog)
        # 按钮在行最右侧 (实测 x=1349 > 默认视口1280 = 点击落屏外静默无效)
        try:
            await up.page.set_viewport_size({"width": 1600, "height": 900})
            print("[dedup] 视口 → 1600×900 (右缘操作键入屏)")
        except Exception as exc:
            print(f"[dedup] 视口调整失败(忽略): {exc}")

        await up.page.goto(LIST_URL, timeout=30000, wait_until="domcontentloaded")
        fr = None
        for _ in range(10):                    # 帧加载抖动 → 30s 重试梯
            await asyncio.sleep(3)
            fr = await _list_frame(up.page)
            if fr is not None:
                break
        if fr is None:
            print(f"[dedup] ✗ 30s 找不到列表帧 "
                  f"(frames={len(up.page.frames)}) — 中止")
            await up.page.screenshot(path=str(PROMO / "videos" / "dedup_noframe.png"))
            return 1
        # G2: 保留条必须在
        if KEEP_TS not in (await fr.evaluate(
                "document.body?(document.body.innerText||''):''")):
            print(f"[dedup] ✗ G2: 保留条 {KEEP_TS} 不在列表 — 中止")
            return 1
        # G1+G3: JS 全扫叶子节点定位行 → 打标记属性 (选择器定位不怕 stale)
        # + hover/删除键/点击 整体三重试 (列表会重渲染节点)
        async def _abs_rect(kind: str):
            """主页面侧跨 iframe 测绝对坐标: 标记行或行内删除键."""
            return await up.page.evaluate(
                """kind => {
                    for (const ifr of document.querySelectorAll('iframe')) {
                        let doc = null;
                        try { doc = ifr.contentDocument; } catch (e) {}
                        if (!doc) continue;
                        const row = doc.querySelector('[data-dedup-target]');
                        if (!row) continue;
                        const off = ifr.getBoundingClientRect();
                        if (kind === 'row') {
                            const r = row.getBoundingClientRect();
                            return {x: off.x + r.x, y: off.y + r.y,
                                    w: r.width, h: r.height};
                        }
                        for (const x of row.querySelectorAll('*')) {
                            const own = Array.from(x.childNodes)
                                .filter(n => n.nodeType === 3)
                                .map(n => n.textContent.trim()).join('');
                            if (own === '删除') {
                                const r = x.getBoundingClientRect();
                                return {x: off.x + r.x, y: off.y + r.y,
                                        w: r.width, h: r.height,
                                        pe: getComputedStyle(x)
                                            .pointerEvents,
                                        op: getComputedStyle(x).opacity,
                                        vis: getComputedStyle(x).visibility};
                            }
                        }
                        return null;
                    }
                    return null;
                }""", kind)

        clicked_row_delete = False
        for attempt in range(1, 5):
            try:
                mark = await fr.evaluate(
                    """delTs => {
                        const walker = document.createTreeWalker(
                            document.body, NodeFilter.SHOW_ELEMENT);
                        let hits = [], el;
                        while ((el = walker.nextNode())) {
                            const own = Array.from(el.childNodes)
                                .filter(n => n.nodeType === 3)
                                .map(n => n.textContent.trim()).join('');
                            if (own === delTs) hits.push(el);
                        }
                        if (hits.length !== 1) return -1;
                        let p = hits[0];
                        while (p && p.parentElement) {
                            const t = p.innerText || '';
                            if (t.includes('删除')
                                    && t.includes('设计+施工合并了')) {
                                document.querySelectorAll('[data-dedup-target]')
                                    .forEach(e => e.removeAttribute(
                                        'data-dedup-target'));
                                p.setAttribute('data-dedup-target', '1');
                                return 1;
                            }
                            p = p.parentElement;
                        }
                        return -2;
                    }""", DEL_TS)
                if mark == -1:
                    print("[dedup] ✗ G1: 时间戳精确匹配 ≠1 — 中止")
                    return 1
                if mark == -2:
                    print("[dedup] ✗ G3: 行容器不匹配 — 中止")
                    return 1
                row_r = await _abs_rect("row")
                if not row_r or row_r["w"] <= 0:
                    print(f"[dedup] 重试{attempt}: 行绝对坐标无效 {row_r}")
                    await asyncio.sleep(2)
                    continue
                # 真鼠标悬停行 (CDP, 触发 CSS :hover 浮出操作键)
                await up.page.mouse.move(
                    row_r["x"] + row_r["w"] / 2, row_r["y"] + row_r["h"] / 3)
                await asyncio.sleep(1.5)
                # r14 根因: .action-content「删除」只是 hover 标签, 真宿主是
                # 同 .opr-item-wrap 里的兄弟节点 .opr-item (图标) — 点标签
                # 永不触发. 定位: 标签 → wrap → .opr-item → 坐标返回主侧.
                jsr = await fr.evaluate(
                    """() => {
                        const row = document.querySelector(
                            '[data-dedup-target]');
                        if (!row) return {err: 'row-gone'};
                        let label = null;
                        for (const x of row.querySelectorAll('*')) {
                            const own = Array.from(x.childNodes)
                                .filter(n => n.nodeType === 3)
                                .map(n => n.textContent.trim()).join('');
                            if (own === '删除') { label = x; break; }
                        }
                        if (!label) return {err: 'label-none'};
                        const wrap = label.closest('.opr-item-wrap')
                                     || label.parentElement;
                        const item = (wrap && (wrap.querySelector('.opr-item')
                                     || wrap.querySelector(':scope > div')))
                                     || label;
                        const r = item.getBoundingClientRect();
                        document.querySelectorAll('[data-dedup-item]')
                            .forEach(e => e.removeAttribute('data-dedup-item'));
                        item.setAttribute('data-dedup-item', '1');
                        return {x: r.x, y: r.y, w: r.width, h: r.height,
                                itemCls: (item.className || '').toString()
                                    .slice(0, 40),
                                itemTag: item.tagName};
                    }""")
                print(f"[dedup] r14 宿主(.opr-item): {jsr}")
                if not jsr or jsr.get("w", 0) <= 0:
                    print(f"[dedup] 重试{attempt}: .opr-item 无包围盒")
                    await asyncio.sleep(2)
                    continue
                # 真鼠标点 .opr-item 中心 (信任态 CDP 点击, 穿 iframe)
                await up.page.mouse.click(
                    jsr["x"] + jsr["w"] / 2, jsr["y"] + jsr["h"] / 2)
                print("[dedup] 已真鼠标点 .opr-item — 等确认弹窗")
                await up.page.screenshot(
                    path=str(PROMO / "videos" / "dedup_js_click.png"))
                await asyncio.sleep(2)
                still = DEL_TS in (await fr.evaluate(
                    "document.body?(document.body.innerText||''):''"))
                if still:
                    # 追补: wrap 整块 + JS 指针序列双保险
                    jsr2 = await fr.evaluate(
                        """() => {
                            const item = document.querySelector(
                                '[data-dedup-item]');
                            if (!item) return {err: 'item-gone'};
                            const r = item.getBoundingClientRect();
                            const cx = r.x + r.width / 2,
                                  cy = r.y + r.height / 2;
                            const o = {bubbles: true, cancelable: true,
                                       view: window, clientX: cx,
                                       clientY: cy, button: 0, buttons: 1};
                            for (const [t, C] of [
                                    ['pointerdown', PointerEvent],
                                    ['mousedown', MouseEvent],
                                    ['pointerup', PointerEvent],
                                    ['mouseup', MouseEvent]]) {
                                item.dispatchEvent(new C(t, o));
                            }
                            item.click();
                            const wrap = item.closest('.opr-item-wrap')
                                         || item.parentElement;
                            if (wrap) {
                                const wr = wrap.getBoundingClientRect();
                                return {x: wr.x, y: wr.y,
                                        w: wr.width, h: wr.height,
                                        js: true};
                            }
                            return {x: r.x, y: r.y, w: r.width, h: r.height,
                                    js: true};
                        }""")
                    if jsr2 and jsr2.get("w", 0) > 0:
                        print(f"[dedup] 追补 JS序列+wrap真鼠标 "
                              f"{jsr2['x']:.0f},{jsr2['y']:.0f} "
                              f"w={jsr2['w']:.0f}")
                        await up.page.mouse.click(
                            jsr2["x"] + jsr2["w"] / 2,
                            jsr2["y"] + jsr2["h"] / 2)
                        await asyncio.sleep(1)
                print("[dedup] 已点「删除」 — 等确认弹窗")
                await up.page.screenshot(
                    path=str(PROMO / "videos" / "dedup_before.png"))
                clicked_row_delete = True
                break
            except Exception as exc:
                print(f"[dedup] 重试{attempt}: {type(exc).__name__}: "
                      f"{str(exc)[:100]}")
                await asyncio.sleep(2)
        if not clicked_row_delete:
            print("[dedup] ✗ 四次未点上「删除」 — 中止 (未删任何东西)")
            return 1
        await asyncio.sleep(2)
        await up.page.screenshot(path=str(PROMO / "videos" / "dedup_dialog.png"))
        # 确认弹窗可能渲染在主页面或任一 iframe — 全帧扫 确定/删除/确认
        clicked = False
        for fr2 in up.page.frames:
            for sel in (".weui-desktop-dialog__wrp:visible "
                        "button:has-text('确定')",
                        ".weui-desktop-dialog__wrp:visible "
                        "button:has-text('删除')",
                        ".weui-desktop-dialog__wrp:visible "
                        "button:has-text('确认')",
                        "[class*='dialog']:visible >> text='确定'",
                        "[class*='modal']:visible >> text='确定'"):
                try:
                    loc = fr2.locator(sel)
                except Exception:
                    continue
                try:
                    if await loc.count() > 0:
                        bb2 = await loc.first.bounding_box()
                        if bb2:
                            await up.page.mouse.click(
                                bb2["x"] + bb2["width"] / 2,
                                bb2["y"] + bb2["height"] / 2)
                        else:
                            await loc.first.click(timeout=5000, force=True)
                        print(f"[dedup] ✓ 确认弹窗已点 "
                              f"({(fr2.url or 'blank')[:40]} {sel[-8:]})")
                        clicked = True
                        break
                except Exception:
                    continue
            if clicked:
                break
        if not clicked:
            print("[dedup] ✗ 未见确认弹窗 — 状态未知, 复扫判定")
        await asyncio.sleep(4)
        await up.page.screenshot(path=str(PROMO / "videos" / "dedup_after.png"))
        # G4: 复扫
        await up.page.reload(wait_until="domcontentloaded")
        await asyncio.sleep(6)
        fr2 = await _list_frame(up.page)
        body2 = (await fr2.evaluate(
            "document.body?(document.body.innerText||''):''")
            if fr2 else "")
        gone, kept = DEL_TS not in body2, KEEP_TS in body2
        print(f"[dedup] G4 复扫: 09:26已删={gone} 09:31仍在={kept}")
        return 0 if (gone and kept) else 1
    finally:
        await up.close_browser()


if __name__ == "__main__":
    sys.exit(asyncio.run(run()))
