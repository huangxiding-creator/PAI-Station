# -*- coding: utf-8 -*-
"""video_state_probe — 只读探测: 两份视频号登录态哪个还活着 (1025).
headless 开 channels.weixin.qq.com → 看 URL 是否被弹回 login。
"""
import asyncio, json, sys
from pathlib import Path

async def probe(label, state_file):
    from playwright.async_api import async_playwright
    async with async_playwright() as p:
        b = await p.chromium.launch(headless=True)
        ctx = await b.new_context(storage_state=state_file)
        pg = await ctx.new_page()
        try:
            await pg.goto("https://channels.weixin.qq.com/platform/post/list",
                          timeout=30000, wait_until="domcontentloaded")
            await asyncio.sleep(5)
            url = pg.url or ""
            body = ""
            try:
                body = await pg.inner_text("body")
            except Exception:
                pass
            alive = "login" not in url.lower() and ("发表" in body or "内容" in body or "管理" in body)
            print(f"[probe] {label}: url={url[:70]} alive={alive}")
        except Exception as e:
            print(f"[probe] {label}: EXC {e}")
        finally:
            await b.close()

async def main():
    for label, f in [
        ("vendor_jul21", r"F:/We-AIPO/src/vendor/video_autopub/cookies/tencent_uploader/account.json"),
        ("rp_oct22", r"E:/AI-Station/report_platform/promo/video_account_state.json"),
    ]:
        await probe(label, f)

asyncio.run(main())
