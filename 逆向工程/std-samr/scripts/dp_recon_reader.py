# -*- coding: utf-8 -*-
"""DrissionPage 侦察: std.samr 阅读器真实网络行为
独立端口 9411 (绝不碰 9222 WeAIPO)
"""
import json, os, sys, time, re

DATA_DIR = r"E:\AI-Station\逆向工程\std-samr\data"
os.makedirs(DATA_DIR, exist_ok=True)

from DrissionPage import ChromiumPage, ChromiumOptions

PORT = 9411  # 独立端口, 避开 9222/9336/9337

def main():
    hcno = sys.argv[1] if len(sys.argv) > 1 else "E1F1DD8E28B8A4B51C13AF0495582755"
    url = f"https://openstd.samr.gov.cn/bzgk/std/showGb?type=online&hcno={hcno}&request_locale=zh_CN"

    co = ChromiumOptions()
    co.set_local_port(PORT)
    co.set_argument('--window-size=1280,900')
    co.set_argument('--disable-blink-features=AutomationControlled')
    co.set_argument('--disable-popup-blocking')
    # 不用无头, 保真
    page = ChromiumPage(addr_or_opts=co)
    spawned_pids = []
    try:
        # 记录本端口浏览器 PID (通过 page.driver 拿)
        import subprocess
        out = subprocess.run(['netstat', '-ano'], capture_output=True, text=True).stdout
        for line in out.splitlines():
            if f':{PORT}' in line and 'LISTENING' in line:
                spawned_pids.append(line.strip().split()[-1])
        print('browser pid:', spawned_pids)

        page.listen.start('viewGbImg')  # 监听大图请求
        # 必须先到详情页拿会话, 再进阅读器 (直跳会被弹回)
        info_url = f"https://openstd.samr.gov.cn/bzgk/std/newGbInfo?hcno={hcno}"
        page.get(info_url)
        time.sleep(3)
        print('INFO loaded:', page.url[:80])
        # 会话就绪后 location.href 跳转 (带 Referer)
        try:
            page.run_js(f"window.location.href='{url}'")
        except Exception as e:
            print('loc nav exc (ok):', type(e).__name__)
        time.sleep(5)
        print('READER URL:', page.url)
        ok = False
        for _ in range(3):
            try:
                ok = page.run_js('return !!document.getElementById("viewerContainer")')
                break
            except Exception as e:
                print('js err retry:', type(e).__name__)
                time.sleep(2)
        if not ok:
            with open(os.path.join(DATA_DIR, 'dp_page2.html'), 'w', encoding='utf-8') as f:
                f.write(page.html or 'EMPTY')
            print('reader not loaded, dumped dp_page2.html')
            return
        time.sleep(2)
        print('URL:', page.url)
        print('TITLE:', page.title)
        with open(os.path.join(DATA_DIR, 'dp_page.html'), 'w', encoding='utf-8') as f:
            f.write(page.html or 'EMPTY')
        has_viewer = page.run_js('return !!document.getElementById("viewerContainer")')
        print('has viewerContainer:', has_viewer)
        if not has_viewer:
            print('PAGE FAILED TO LOAD READER — dump above')
            return

        # 滚动到底, 触发所有懒加载块
        total_h = page.run_js('return document.getElementById("viewerContainer").scrollHeight')
        print('scrollHeight:', total_h)
        step = 600
        y = 0
        while y < total_h:
            page.run_js(f'document.getElementById("viewerContainer").scrollTop = {y}')
            time.sleep(0.25)
            y += step
            total_h = page.run_js('return document.getElementById("viewerContainer").scrollHeight')
        time.sleep(2)

        # 收包
        imgs = []
        for packet in page.listen.steps(timeout=2):
            try:
                u = packet.url
                body = packet.response.body
                if isinstance(body, (bytes, bytearray)):
                    fn = f"chunk_{len(imgs)}.webp"
                    with open(os.path.join(DATA_DIR, fn), 'wb') as f:
                        f.write(body)
                    imgs.append({'url': u, 'file': fn, 'size': len(body)})
                    print('IMG', u[:120], len(body))
            except Exception as e:
                print('pkt err', e)

        # DOM 快照: 所有 page div 的 span 全量
        dom = page.run_js('return document.getElementById("viewer").outerHTML')
        with open(os.path.join(DATA_DIR, 'viewer_dom.html'), 'w', encoding='utf-8') as f:
            f.write(dom)
        pages = re.findall(r'<div id="(\d+)" class="page"([^>]*)>', dom)
        print('pages in DOM:', len(pages))

        # 截图
        page.get_screenshot(os.path.join(DATA_DIR, 'reader_p0.png'), full_page=False)

        with open(os.path.join(DATA_DIR, 'recon_result.json'), 'w', encoding='utf-8') as f:
            json.dump({'hcno': hcno, 'images': imgs, 'pages': len(pages)}, f, ensure_ascii=False, indent=2)
        print('DONE imgs=', len(imgs))
    finally:
        try:
            page.quit()
        except Exception:
            pass
        for pid in spawned_pids:
            os.system(f'taskkill /F /PID {pid} >nul 2>&1')
        print('cleaned pids:', spawned_pids)

if __name__ == '__main__':
    main()
