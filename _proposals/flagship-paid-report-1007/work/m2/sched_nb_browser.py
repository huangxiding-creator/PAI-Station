# -*- coding: utf-8 -*-
"""sched_nb_browser — 真浏览器 NB 编排器(学永动机做法).

不依赖 notebooklm-py API, 直接用 Playwright 操控已登录的 Chromium:
- 用 ~/.notebooklm/profiles/default/browser_profile(永动机同款, 有活Google登录态)
- 走 7890 代理(美国出口)
- 建本/传源/发chat/收回答 全走浏览器界面 → 零指纹识别问题
用法: py -X utf8 sched_nb_browser.py --phase chapters --chapters 2
"""
from __future__ import annotations

import argparse
import asyncio
import json
import re
import sys
import time
from pathlib import Path

M2 = Path(__file__).resolve().parent / "sched"
UPLOAD = M2 / "nblm_upload"
OUT = M2 / "nblm_out"
PROFILE = Path.home() / ".notebooklm" / "profiles" / "default" / "browser_profile"
PROXY = "http://127.0.0.1:7890"
NB_URL = "https://notebooklm.google.com"


async def new_page(playwright):
    browser = await playwright.chromium.launch_persistent_context(
        str(PROFILE), headless=False,
        proxy={"server": PROXY},
        args=["--disable-blink-features=AutomationControlled",
              "--disable-infobars", "--window-size=1400,900"])
    page = browser.pages[0] if browser.pages else await browser.new_page()
    return browser, page


async def goto_nb(page):
    await page.goto(NB_URL, wait_until="domcontentloaded", timeout=30000)
    # 等待 NotebookLM 界面出现
    for _ in range(20):
        url = page.url
        if "notebooklm.google.com" in url and "unsupported" not in url:
            return True
        await asyncio.sleep(2)
    print(f"[!] 未进入NB, 当前URL: {page.url[:80]}")
    return False


async def create_notebook(page, title: str) -> str:
    """点「创建笔记本」→ 返回笔记本URL"""
    # 点创建按钮
    btn = page.locator('button:has-text("创建"), button:has-text("Create"), '
                       'button[aria-label*="Create"], button[aria-label*="创建"]')
    if await btn.count() > 0:
        await btn.first.click()
        await asyncio.sleep(3)
    url = page.url
    # 重命名
    try:
        more = page.locator('button[aria-label*="More"], button[aria-label*="更多"]')
        if await more.count() > 0:
            await more.first.click()
            await asyncio.sleep(1)
            rename = page.locator('button:has-text("Rename"), menu-item:has-text("Rename")')
            if await rename.count() > 0:
                await rename.first.click()
                await asyncio.sleep(1)
                inp = page.locator('input[aria-label*="name"], input[placeholder*="name"]')
                if await inp.count() > 0:
                    await inp.fill(title)
                    await page.keyboard.press("Enter")
    except Exception:
        pass
    return url


async def upload_file(page, filepath: Path):
    """上传源文件"""
    # 点「添加来源」
    add = page.locator('button:has-text("添加"), button:has-text("Add source"), '
                       'button:has-text("Source"), button[aria-label*="source"]')
    if await add.count() > 0:
        await add.first.click()
        await asyncio.sleep(2)
    # 文件上传
    upload = page.locator('input[type="file"]')
    if await upload.count() > 0:
        await upload.set_input_files(str(filepath))
        await asyncio.sleep(5)  # 等上传


async def chat(page, prompt: str) -> str:
    """在chat框输入prompt并等待回复"""
    # 找chat输入框
    chat_input = page.locator(
        'div[contenteditable="true"], textarea[placeholder*="Ask"], '
        'div[role="textbox"], .chat-input, rich-textarea')
    if await chat_input.count() == 0:
        print("[!] 找不到chat输入框")
        return ""
    await chat_input.first.click()
    await chat_input.first.fill(prompt)
    await page.keyboard.press("Enter")
    # 等待回复(最多120秒)
    for _ in range(60):
        await asyncio.sleep(2)
        # 检查是否有新的回复消息
        msgs = page.locator('.chat-message, .response-message, '
                           '[class*="message"], [class*="response"]')
        cnt = await msgs.count()
        if cnt > 0:
            last = msgs.last
            text = await last.inner_text()
            if len(text) > 100:  # 回复足够长
                return text
    return ""


async def phase_chapters(nums: list[int]):
    from playwright.async_api import async_playwright
    chs = json.loads((M2 / "chapters.json").read_text(encoding="utf-8"))

    async with async_playwright() as pw:
        browser, page = await new_page(pw)
        if not await goto_nb(page):
            print("[!] 无法进入NotebookLM")
            return

        for ch in chs:
            if ch["no"] not in nums:
                continue
            out = OUT / f"ch{ch['no']:02d}_初稿.md"
            if out.exists() and out.stat().st_size > 20000:
                print(f"[skip] ch{ch['no']:02d} 已有稿")
                continue
            print(f"[nb] 第{ch['no']}章 开始...")
            # 创建新笔记本
            url = await create_notebook(page, f"SCHED-第{ch['no']}章")
            await asyncio.sleep(3)
            # 上传源文件
            d = UPLOAD / f"ch{ch['no']:02d}_笔记本"
            for f in sorted(d.glob("*.md"))[:8]:  # 最多8个源
                print(f"  上传: {f.name[:50]}")
                await upload_file(page, f)
                await asyncio.sleep(3)
            # 发chat prompt
            prompt = (f"你是资深工程咨询研究专家。基于本笔记本全部资料，"
                      f"撰写《工程工期管理与延误索赔实战指南·2026版》"
                      f"第{ch['no']}章「{ch['title']}」完整初稿。"
                      f"读者：施工企业项目经理/商务/造价/法务。"
                      f"要求数字与案例来自资料并注明来源。12000字以上。")
            answer = await chat(page, prompt)
            if answer:
                out.write_text(answer, encoding="utf-8")
                print(f"[✅] 第{ch['no']}章 {len(answer):,}字 → {out.name}")
            else:
                print(f"[!] 第{ch['no']}章 未获回复")
            await asyncio.sleep(10)

        await browser.close()


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--phase", default="chapters")
    ap.add_argument("--chapters", default="")
    ns = ap.parse_args()
    nums = [int(x) for x in ns.chapters.split(",") if x.strip()] \
        or list(range(1, 13))
    if ns.phase == "chapters":
        asyncio.run(phase_chapters(nums))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
