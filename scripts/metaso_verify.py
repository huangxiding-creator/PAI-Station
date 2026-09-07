"""验证 metaso 01、混沌学园 目录内容：原始 API 响应转储（诊断用）。"""
import json
import os
import sys
import time

from DrissionPage import ChromiumOptions, ChromiumPage

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA = os.path.join(ROOT, "data", "hundun")
SID = "8673582927558737920"
CFID = "2096794656849395712"
URL = f"https://metaso.cn/subject-v2/{SID}/manage?cfid={CFID}"

JS = f"""
return (async () => {{
    const out = {{}};
    try {{
        const r1 = await fetch('/api/knowledge/{SID}/search?s=&parentId={CFID}'
            + '&pageSize=200&pageIndex=0&sort=updateTime&sortDirection=desc');
        out.search = await r1.text();
    }} catch(e) {{ out.search = 'ERR ' + e.message; }}
    try {{
        const r2 = await fetch('/api/knowledge/{SID}/folder/count?parentId={CFID}');
        out.count = await r2.text();
    }} catch(e) {{ out.count = 'ERR ' + e.message; }}
    try {{
        const r3 = await fetch('/api/knowledge/{SID}/folder?parentId={CFID}');
        out.folder = await r3.text();
    }} catch(e) {{ out.folder = 'ERR ' + e.message; }}
    return JSON.stringify(out);
}})();
"""


def main():
    co = ChromiumOptions()
    co.headless(False)
    co.set_user_data_path(os.path.join(ROOT, "data", "browser_profile"))
    co.set_local_port(9333)
    co.set_argument("--no-first-run")
    page = ChromiumPage(co)
    try:
        page.get(URL, timeout=30)
        time.sleep(4)
        raw = page.run_js(JS, timeout=60)
        out = os.path.join(DATA, "_recon", "verify_apis.json")
        with open(out, "w", encoding="utf-8") as fh:
            fh.write(str(raw))
        for k, v in json.loads(raw).items():
            print(f"[{k}] {str(v)[:400]}")
        page.get_screenshot(os.path.join(DATA, "_recon", "verify_page.png"))
        return 0
    finally:
        page.quit()


if __name__ == "__main__":
    sys.exit(main())
