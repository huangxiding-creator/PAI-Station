# -*- coding: utf-8 -*-
"""video_state_probe_cdp — attach 9222 live Chrome (CDP) + 新context注cookies/localStorage 只读探活 (1025)."""
import asyncio, json, sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

STATE = r'E:/AI-Station/report_platform/promo/video_account_state.json'

async def main():
    from playwright.async_api import async_playwright
    pw = await async_playwright().start()
    browser = await pw.chromium.connect_over_cdp('http://127.0.0.1:9222')
    print('cdp contexts:', len(browser.contexts), '(live默认context不碰)')
    st = json.load(open(STATE, encoding='utf-8'))
    ctx = await browser.new_context(proxy={"server": "http://127.0.0.1:7890"})  # 绕开live浏览器已死的7890代理
    await ctx.add_cookies(st['cookies'])
    pg = await ctx.new_page()
    await pg.goto('https://channels.weixin.qq.com/login.html', timeout=30000, wait_until='domcontentloaded')
    # 注入 localStorage (origin 已就位)
    ls = st.get('origins', [{}])[0].get('localStorage', [])
    if ls:
        await pg.evaluate("(entries)=>{for(const [k,v] of entries){try{localStorage.setItem(k,v)}catch(e){}}}",
                          [[e['name'], e['value']] for e in ls])
    await pg.goto('https://channels.weixin.qq.com/platform/post/list', timeout=30000, wait_until='domcontentloaded')
    await asyncio.sleep(6)
    body = ''
    try: body = await pg.inner_text('body')
    except Exception: pass
    alive = 'login' not in (pg.url or '').lower() and any(k in body for k in ('发表', '内容', '管理'))
    print('final url:', (pg.url or '')[:80])
    print('ALIVE:', alive)
    await ctx.close()
    await pw.stop()

asyncio.run(main())
