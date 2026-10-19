# -*- coding: utf-8 -*-
"""浏览器渲染截图 page0 元素, 用于与重组图对比"""
import time, os, sys
from DrissionPage import ChromiumPage, ChromiumOptions

PORT = 9411
DATA = r"E:\AI-Station\逆向工程\std-samr\data"

def main():
    hcno = sys.argv[1] if len(sys.argv) > 1 else "E1F1DD8E28B8A4B51C13AF0495582755"
    co = ChromiumOptions(); co.set_local_port(PORT)
    co.set_argument('--window-size=1400,1000')
    co.set_argument('--disable-popup-blocking')
    page = ChromiumPage(addr_or_opts=co)
    import subprocess
    out = subprocess.run(['netstat', '-ano'], capture_output=True, text=True).stdout
    pids = [l.strip().split()[-1] for l in out.splitlines() if f':{PORT}' in l and 'LISTENING' in l]
    try:
        page.get(f"https://openstd.samr.gov.cn/bzgk/std/newGbInfo?hcno={hcno}")
        time.sleep(2)
        page.run_js(f"window.location.href='https://openstd.samr.gov.cn/bzgk/std/showGb?type=online&hcno={hcno}&request_locale=zh_CN'")
        time.sleep(5)
        # 等第一页瓦片出图
        for _ in range(20):
            has = page.run_js('return !!document.querySelector("[id=\'0\'] span[style*=background-image]")')
            if has: break
            time.sleep(0.5)
        # 滚回顶部
        page.run_js('document.getElementById("viewerContainer").scrollTop = 0')
        time.sleep(1)
        el = page.ele('@id=0')
        el.get_screenshot(os.path.join(DATA, 'browser_page0.png'))
        print('shot saved')
    finally:
        try: page.quit()
        except Exception: pass
        for pid in pids: os.system(f'taskkill /F /PID {pid} >nul 2>&1')
        print('cleaned', pids)

if __name__ == '__main__':
    main()
