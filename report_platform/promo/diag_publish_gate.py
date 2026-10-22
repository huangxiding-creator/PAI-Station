# -*- coding: utf-8 -*-
"""diag_publish_gate — 只读诊断: 发表键为何禁用.
开新建页→传视频→填题/述→每15s转储: 发表键class+disabled / 预览区状态文本 /
含[转码|封面|失败|必填|分类]的可见文本 / 表单红字. 全程不点发表.
"""
import asyncio
import io
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
PROMO = Path(__file__).resolve().parent
STATE_FILE = PROMO / "video_account_state.json"
MP4 = PROMO / "videos" / "leqi_v1_am.mp4"
TITLE = "发现隐患、预判风险｜水利安全AI眼镜"
DESC = ("戴上水利安全AI眼镜，一句「扫描隐患」：单张照片测出 2.31m±0.08，越过 SL 398-2007 高处作业 "
        "2m 阈值，当场判「不符合」并引出条款，量化判定写入台账、企微推送，3 分钟闭环。管理端「观澜」后台"
        "同步预判下周新增隐患 130±25 宗——发现隐患在一线，预判风险在后台。V3.0 定量测距分析版：工程高频"
        "场景识别准确率 96.5%，单次巡检 4-6 小时压缩至 1-1.5 小时，单台成本降至 3000 元以下，六项机制一键"
        "闭环。实机演示预约：微信 w51817 #水利安全 #AI眼镜 #安全生产 #智慧水利 #工程管理")


async def main() -> int:
    from playwright.async_api import async_playwright
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=False)
        ctx = await browser.new_context(storage_state=str(STATE_FILE))
        page = await ctx.new_page()
        await page.goto("https://channels.weixin.qq.com/platform/post/create", timeout=60000)
        await page.wait_for_timeout(4000)
        # 上传
        for fr in page.frames:
            inp = fr.locator("input[type='file']")
            if await inp.count() > 0:
                await inp.first.set_input_files(str(MP4))
                print("[diag] 已选择视频文件")
                break
        await page.wait_for_timeout(8000)
        # 填标题
        for sel in ("textarea[placeholder*='标题']", "input[placeholder*='标题']", "input[placeholder*='好标题']"):
            loc = page.locator(sel)
            if await loc.count() > 0 and await loc.first.is_visible():
                await loc.first.fill(TITLE)
                print(f"[diag] 标题已填 ({sel[:30]})")
                break
        # 填描述
        for fr in page.frames:
            for sel in ("div[contenteditable='true'][data-placeholder*='描述']",
                        "div[contenteditable='true']"):
                loc = fr.locator(sel).first
                if await loc.count() == 0 or not await loc.is_visible():
                    continue
                await loc.click(timeout=3000)
                await page.keyboard.type(DESC, delay=8)
                print("[diag] 描述已填")
                break
            else:
                continue
            break
        await page.evaluate("window.scrollTo(0, 999999)")
        for rnd in range(16):
            await page.wait_for_timeout(15000)
            dump = await page.evaluate("""() => {
              const out = {btns: [], status: [], reds: []};
              document.querySelectorAll('button, [role=button], .weui-btn').forEach(b => {
                const txt = (b.innerText || '').trim();
                if (['发表', '存草稿', '预览'].includes(txt)) {
                  const r = b.getBoundingClientRect();
                  out.btns.push(txt + '|' + (b.disabled ? 'disabled' : 'ok')
                    + '|' + ((b.className || '') + '').slice(0, 60)
                    + '|y=' + Math.round(r.y + r.height / 2) + '/' + Math.round(innerHeight));
                }
              });
              const walk = el => {
                for (const n of el.querySelectorAll('*')) {
                  const t = (n.innerText || '').trim();
                  if (t && t.length < 40 && /转码|封面|失败|必填|请选择|分类|上传中|处理中/.test(t)
                      && n.children.length === 0) out.status.push(t);
                  const c = getComputedStyle(n).color;
                  if (c === 'rgb(245, 63, 63)' && t && t.length < 60 && n.children.length === 0) out.reds.push(t);
                }
              };
              for (const fr2 of document.querySelectorAll('iframe')) {
                try { walk(fr2.contentDocument.body); } catch (e) {}
              }
              walk(document.body);
              return {btns: [...new Set(out.btns)], status: [...new Set(out.status)].slice(0, 10), reds: [...new Set(out.reds)].slice(0, 8)};
            }""")
            print(f"[diag t={ (rnd + 1) * 15 }s] {dump}")
            if any('发表|ok' in b for b in dump['btns']):
                print("[diag] ★发表键已就绪!")
                await page.screenshot(path=str(PROMO / "videos" / "diag_ready.png"))
                break
        await page.screenshot(path=str(PROMO / "videos" / "diag_end.png"), full_page=True)
        await browser.close()
    return 0


if __name__ == "__main__":
    sys.exit(asyncio.run(main()))
