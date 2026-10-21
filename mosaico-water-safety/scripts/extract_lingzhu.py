# -*- coding: utf-8 -*-
"""灵珠只读提取: 水利安全AI助手 bot 7695017028100292608 + 工作流 7687555664029155328。

纪律:
- 独立调试端口 9340 (不碰 9222/9336/9337)
- 复用 Linzhu-Auto/.chrome-profile 持久会话(2026-10-20 刚用过)
- 全程只读: 仅 get_draft_bot_info / canvas / workflow_list / knowledge_list / library_resource_list
- 结束后按端口找 PID 杀进程树 (Chrome 进程守门)
"""
from __future__ import annotations

import json
import os
import re
import subprocess
import sys
import time

LINZHU_AUTO = r"E:\AI-Station\Linzhu-Auto"
sys.path.insert(0, LINZHU_AUTO)

from DrissionPage import Chromium, ChromiumOptions  # noqa: E402

PORT = 9340
SPACE_ID = "7569942055279919104"
BOT_ID = "7695017028100292608"
WF_ID = "7687555664029155328"
API = "https://rcs.rokid.com/aiPlatform/api"
GW = {"Content-Type": "application/json", "x-requested-with": "XMLHttpRequest", "Agw-Js-Conv": "str"}
OUT_DIR = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "RESEARCH_DOCKET", "lingzhu_extract")

DEVELOP_URL = f"https://agent-develop.rokid.com/space/{SPACE_ID}/develop"


class MiniBr:
    """auth 兼容的极薄浏览器封装(自定义端口)。"""

    def __init__(self, chromium):
        self._c = chromium
        self.tab = chromium.latest_tab

    def get(self, url, wait=3.0):
        self.tab.get(url, timeout=wait)
        time.sleep(1.5)

    def url(self):
        return self.tab.url or ""

    def wait_url_contains(self, frag, timeout=30.0):
        t0 = time.time()
        while time.time() - t0 < timeout:
            if frag in (self.url() or ""):
                return True
            time.sleep(1.0)
        return frag in (self.url() or "")


def chrome_count() -> int:
    try:
        out = subprocess.run(["powershell", "-NoProfile", "-Command",
                              "(Get-Process chrome -ErrorAction SilentlyExit | Measure-Object).Count"],
                             capture_output=True, text=True, timeout=15)
        return int(out.stdout.strip() or 0)
    except Exception:
        return -1


def launch(headless: bool):
    co = ChromiumOptions()
    co.set_user_data_path(os.path.join(LINZHU_AUTO, ".chrome-profile"))
    co.set_local_port(PORT)
    co.set_argument("--no-first-run")
    co.set_argument("--no-default-browser-check")
    co.set_argument("--disable-blink-features=AutomationControlled")
    if headless:
        co.headless(True)
    co.set_argument("--window-size=1280,900")
    return MiniBr(Chromium(co))


def page_fetch(tab, path: str, payload: dict):
    body_json = json.dumps(payload, ensure_ascii=False)
    gh = json.dumps(GW)
    js = (
        "async (payloadStr) => {\n"
        f"  const r = await fetch('{API}/{path}', {{method:'POST', headers:{gh}, credentials:'include', body:payloadStr}});\n"
        "  const t = await r.text();\n"
        "  return JSON.stringify({status:r.status, text:t});\n"
        "}"
    )
    out = tab.run_js(js, body_json)
    if out is None:
        raise RuntimeError(f"fetch {path} 返回 None(未登录或页面上下文异常)")
    o = json.loads(out)
    if o.get("status") != 200:
        raise RuntimeError(f"API {path} HTTP {o['status']}: {o.get('text','')[:300]}")
    return json.loads(o["text"])


def save(name: str, data) -> str:
    os.makedirs(OUT_DIR, exist_ok=True)
    p = os.path.join(OUT_DIR, name)
    with open(p, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=1)
    return p


def kill_our_browser():
    """只杀监听 9340 的 chrome 进程树,绝不动其他浏览器。"""
    try:
        out = subprocess.run(["netstat", "-ano"], capture_output=True, text=True, timeout=15).stdout
        pids = set()
        for line in out.splitlines():
            if f":{PORT}" in line and "LISTENING" in line:
                m = re.search(r"\s(\d+)$", line.strip())
                if m:
                    pids.add(m.group(1))
        for pid in pids:
            subprocess.run(["taskkill", "/PID", pid, "/T", "/F"], capture_output=True, timeout=20)
            print(f"[cleanup] killed chrome tree PID={pid}")
        if not pids:
            print("[cleanup] 9340 无监听进程(可能已退出)")
    except Exception as e:
        print(f"[cleanup] ⚠ {e}")


def main() -> int:
    n0 = chrome_count()
    print(f"[hygiene] chrome.exe 基线: {n0}")
    if n0 > 80:
        print("[hygiene] ✘ chrome 进程过多,中止")
        return 2

    br = launch(headless=True)
    ok = False
    try:
        br.get(DEVELOP_URL)
        url = br.url()
        print(f"[session] 落地 URL: {url[:90]}")
        logged = "login" not in url and "account-web" not in url
        if not logged:
            print("[session] headless 会话失效 → 切可见窗口重登")
            try:
                br._c.quit()
            except Exception:
                pass
            kill_our_browser()
            time.sleep(2)
            from linzhu.auth import login  # noqa: E402
            from linzhu.config import get_config  # noqa: E402
            br2 = launch(headless=False)
            class _Shim:  # 让 linzhu.auth.login 可用我们的实例
                pass
            cfg = get_config()
            # login() 需要 Browser 对象;构造替代 shim
            shim = _Shim()
            shim.get = br2.get; shim.url = br2.url; shim.tab = br2.tab
            shim.screenshot = lambda *a, **k: None
            shim.wait_url_contains = br2.wait_url_contains
            if not login(shim, cfg):
                print("[session] ✘ 登录失败")
                return 3
            br = br2
        tab = br.tab
        # 确保在 develop 域(登录流程可能停在别的页)
        if "agent-develop.rokid.com" not in (br.url() or ""):
            br.get(DEVELOP_URL)

        # 1. bot 定义
        bot = page_fetch(tab, "playground_api/draftbot/get_draft_bot_info",
                         {"bot_id": BOT_ID, "space_id": SPACE_ID})
        save("bot_info.json", bot)
        bi = (bot.get("data") or {}).get("bot_info") or {}
        print(f"[bot] name={bi.get('name')} prompt_len={len(((bi.get('prompt_info') or {}).get('prompt') or ''))}")
        print(f"[bot] 绑定工作流: {[w.get('workflow_id') for w in (bi.get('workflow_info_list') or [])]}")

        # 2. 目标工作流 canvas (+ bot 绑定的所有工作流)
        wids = {WF_ID}
        for w in (bi.get("workflow_info_list") or []):
            if w.get("workflow_id"):
                wids.add(str(w["workflow_id"]))
        for wid in wids:
            cv = page_fetch(tab, "workflow_api/canvas", {"workflow_id": wid, "space_id": SPACE_ID})
            save(f"canvas_{wid}.json", cv)
            wf = (cv.get("data") or {}).get("workflow") or {}
            sj = wf.get("schema_json")
            n_nodes = len(json.loads(sj).get("nodes", [])) if sj else -1
            print(f"[canvas] {wid} name={wf.get('name')} nodes={n_nodes} status={wf.get('status')}")

        # 3. 空间工作流清单
        wl = page_fetch(tab, "workflow_api/workflow_list", {"space_id": SPACE_ID})
        save("workflow_list.json", wl)
        items = (wl.get("data") or {}).get("workflow_list") or (wl.get("data") or {}).get("list") or []
        print(f"[wf_list] {len(items)} 条")

        # 4. 知识库清单
        kl = page_fetch(tab, "knowledge/list", {"space_id": SPACE_ID})
        save("knowledge_list.json", kl)
        print(f"[kb_list] {json.dumps(kl, ensure_ascii=False)[:200]}")

        # 5. 资源库清单(插件/工作流资源)
        lr = page_fetch(tab, "plugin_api/library_resource_list", {"space_id": SPACE_ID, "page_no": 1, "page_size": 100})
        save("library_resource_list.json", lr)
        rl = (lr.get("data") or {}).get("resource_list") or []
        print(f"[resources] {len(rl)} 条")
        ok = True
    finally:
        try:
            br._c.quit()
        except Exception:
            pass
        time.sleep(1)
        kill_our_browser()
        n1 = chrome_count()
        print(f"[hygiene] 结束后 chrome.exe: {n1} (基线 {n0})")
    print("[done]" if ok else "[failed]")
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
