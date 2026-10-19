# -*- coding: utf-8 -*-
"""浏览器内探测 viewGb 原生 PDF 下载通道"""
import time, os, sys
from DrissionPage import ChromiumPage, ChromiumOptions
PORT = 9411
DATA = r"E:\AI-Station\逆向工程\std-samr\data"

def main():
    hcno = sys.argv[1] if len(sys.argv) > 1 else "E1F1DD8E28B8A4B51C13AF0495582755"
    co = ChromiumOptions(); co.set_local_port(PORT)
    co.set_argument('--window-size=1400,1000')
    page = ChromiumPage(addr_or_opts=co)
    import subprocess
    out = subprocess.run(['netstat', '-ano'], capture_output=True, text=True).stdout
    pids = [l.strip().split()[-1] for l in out.splitlines() if f':{PORT}' in l and 'LISTENING' in l]
    try:
        page.listen.start('viewGb')
        page.get(f"https://openstd.samr.gov.cn/bzgk/std/newGbInfo?hcno={hcno}")
        time.sleep(2)
        # 点击下载按钮 (xz_btn)
        try:
            page.ele('c:xz_btn', timeout=5).click.by_js()
            time.sleep(4)
        except Exception as e:
            print('xz click err:', type(e).__name__)
        for packet in page.listen.steps(timeout=3):
            print('PKT', packet.url[:100], 'frame=', getattr(packet.response, 'raw', None) and 'has-raw' or '')
            try:
                b = packet.response.body
                if isinstance(b, (bytes, bytearray)) and len(b) > 100:
                    fn = os.path.join(DATA, 'native_dl.bin')
                    open(fn, 'wb').write(b)
                    print('SAVED', len(b), '->', fn, 'head:', b[:8])
            except Exception as e:
                print('body err', e)
        print('tabs:', len(page.tab_ids))
    finally:
        try: page.quit()
        except Exception: pass
        for pid in pids: os.system(f'taskkill /F /PID {pid} >nul 2>&1')
        print('cleaned', pids)

if __name__ == '__main__':
    main()
