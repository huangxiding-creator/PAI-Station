# -*- coding utf-8 -*-
"""video_relogin — 视频号助手登录态重取（video_account_state.json 过期后用）。

有头 Playwright 开 channels.weixin.qq.com → 等管理员扫码（≤3min，URL 离开 login
或出现头像即成功）→ storage_state 落 video_account_state.json。不做任何其他操作。
用法: E:/CPOPC/We-AIPO/.venv/Scripts/python.exe -X utf8 video_relogin.py
"""
import asyncio
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
STATE = Path(__file__).parent / "video_account_state.json"


async def main() -> int:
    from playwright.async_api import async_playwright
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=False)
        ctx = await browser.new_context()
        page = await ctx.new_page()
        await page.goto("https://channels.weixin.qq.com/")
        print("== 浏览器已开：请用微信扫页面二维码登录视频号助手 ==", flush=True)
        ok = False
        for i in range(180):
            await asyncio.sleep(1)
            url = page.url or ""
            if "login" not in url.lower():
                try:
                    if await page.locator(".user-info, .account-manage, .avatar, .main-content").count() > 0:
                        ok = True
                except Exception:
                    ok = True
                if ok or i > 30:
                    ok = "login" not in url.lower()
                    if ok:
                        break
            if i % 20 == 0 and i:
                print(f"等扫码... {i}s (URL: {url[:60]})", flush=True)
        if not ok:
            print("TIMEOUT 未登录", flush=True)
            await browser.close()
            return 2
        await asyncio.sleep(4)
        cookies = await ctx.cookies()
        if not cookies:
            print("无 Cookie，失败", flush=True)
            await browser.close()
            return 3
        await ctx.storage_state(path=str(STATE))
        print(f"STATE_SAVED {STATE} cookies={len(cookies)}", flush=True)
        await browser.close()
        return 0


if __name__ == "__main__":
    raise SystemExit(asyncio.run(main()))
