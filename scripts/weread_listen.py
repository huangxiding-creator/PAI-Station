"""微信读书流量侦察（协议漂移应急工具，勘误表 §8 配套）。

附着已登录浏览器（9333，data/browser_profile），真实交互并抓取
weread.qq.com 域 API 调用（方法/路径/参数/请求体/响应摘要）。
端点契约再漂移时：先跑本工具看新版前端真实调用，再改客户端。

用法:
  python scripts/weread_listen.py                          # 打开书架页抓 10s
  python scripts/weread_listen.py "https://weread.qq.com/web/reader/xxx"  # 指定页
"""
import sys
import time
from urllib.parse import urlparse

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage  # noqa: E402

URL = sys.argv[1] if len(sys.argv) > 1 else "https://weread.qq.com/#shelf"
WAIT = 10

page = ChromiumPage(addr_or_opts="127.0.0.1:9333")
page.listen.start("weread.qq.com")
page.get(URL)
print(f"URL: {page.url}  (抓取 {WAIT}s …)", flush=True)
pkts = []
deadline = time.time() + WAIT
while time.time() < deadline:
    for pkt in page.listen.steps(timeout=2):
        pkts.append(pkt)
page.listen.stop()

api = [p for p in pkts
       if urlparse(p.url).hostname == "weread.qq.com"
       and not urlparse(p.url).path.endswith((".js", ".css", ".png", ".woff"))]
for pkt in api:
    u = urlparse(pkt.url)
    print(f"{pkt.method:6} {u.path}?{u.query[:110]}")
    try:
        body = pkt.request.postData
        if body:
            print(f"       REQ  {str(body)[:180]}")
    except Exception:                                 # noqa: BLE001 - 无体忽略
        pass
    try:
        print(f"       RESP {str(pkt.response.body)[:180]}")
    except Exception:                                 # noqa: BLE001 - 无体忽略
        pass
print(f"\nTOTAL {len(api)}")
