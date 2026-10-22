# -*- coding: utf-8 -*-
"""观澜后台实拍 — Playwright 登录并截取 11 屏 + 官网 hero 备份帧.
产出: material/console/<screen>.png (2560x1440@1.5x) + material/site/*.png
"""
import asyncio
import io
import json
import sys
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
from playwright.async_api import async_playwright

ROOT = Path(__file__).resolve().parent
MAT = ROOT / "material"
CONSOLE = MAT / "console"
SITE = MAT / "site"
CONSOLE.mkdir(parents=True, exist_ok=True)
SITE.mkdir(parents=True, exist_ok=True)

BASE = "http://47.120.43.20:8090"
SCREENS = ["overview", "trend", "closure", "hazards", "patrol",
           "coverage", "analytics", "ai", "expert", "service", "projects"]


async def main() -> int:
    async with async_playwright() as pw:
        browser = await pw.chromium.launch(headless=True)
        ctx = await browser.new_context(
            viewport={"width": 2560, "height": 1440},
            device_scale_factor=1.5,
            locale="zh-CN",
        )
        page = await ctx.new_page()
        errors = []
        page.on("pageerror", lambda e: errors.append(str(e)))

        # ---- 登录 ----
        await page.goto(f"{BASE}/console/login", wait_until="networkidle")
        await page.fill('input[placeholder="管理员账号"]', "15838272889")
        await page.fill('input[placeholder="密码"]', "ohwork4408")
        await page.click("button.go")
        try:
            await page.wait_for_url("**/overview", timeout=15000)
        except Exception:
            shot = CONSOLE / "_login_stuck.png"
            await page.screenshot(path=str(shot))
            print(f"[cap] 登录未跳转, 存证 {shot.name} url={page.url}")
            return 1
        print("[cap] 登录 OK ->", page.url)

        # ---- 11 屏 ----
        for s in SCREENS:
            await page.goto(f"{BASE}/console/{s}", wait_until="networkidle")
            await page.wait_for_timeout(4500)   # 图表动画落定
            await page.screenshot(path=str(CONSOLE / f"{s}.png"))
            print(f"[cap] {s}.png")

        # ---- 官网 hero 备份帧 (宽幅) ----
        await page.goto(f"{BASE}/", wait_until="networkidle")
        await page.wait_for_timeout(2500)
        await page.screenshot(path=str(SITE / "site_hero_top.png"))
        for anchor, name in (("#mechanism", "site_mechanism.png"),
                             ("#quant", "site_quant.png"),
                             ("#scenes", "site_scenes.png")):
            await page.evaluate(f"document.querySelector('{anchor}')"
                                ".scrollIntoView()")
            await page.wait_for_timeout(1200)
            await page.screenshot(path=str(SITE / name))
            print(f"[cap] {name}")

        await browser.close()
        if errors:
            (MAT / "page_errors.json").write_text(
                json.dumps(errors, ensure_ascii=False, indent=1),
                encoding="utf-8")
            print(f"[cap] 页面错误 {len(errors)} 条已存 page_errors.json")
        print("[cap] DONE")
        return 0


if __name__ == "__main__":
    sys.exit(asyncio.run(main()))
