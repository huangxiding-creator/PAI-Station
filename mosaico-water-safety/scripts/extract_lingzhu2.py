# -*- coding: utf-8 -*-
"""补采: bot 人设引用的其余工作流 canvas (只读)。会话已新鲜(昨日刚登)。"""
import importlib.util
import json
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location("ex1", os.path.join(HERE, "extract_lingzhu.py"))
ex1 = importlib.util.module_from_spec(spec)
spec.loader.exec_module(ex1)  # 注意: 不运行 main

WIDS = [
    "7569942610605768704",  # SafetyAssistant
    "7571764975648112640",  # SendNotice
    "7575087561329082368",
    "7574741782013935616",
    "7574740552873148416",
    "7574740930570223616",
    "7574741387862605824",
    "7574742486862528512",
]


def main() -> int:
    n0 = ex1.chrome_count()
    print(f"[hygiene] chrome 基线 {n0}")
    br = ex1.launch(headless=True)
    ok = False
    try:
        br.get(ex1.DEVELOP_URL)
        url = br.url()
        logged = "login" not in url and "account-web" not in url
        print(f"[session] {'已登录' if logged else 'headless失效→可见窗口重登'} {url[:80]}")
        if not logged:
            try:
                br._c.quit()
            except Exception:
                pass
            ex1.kill_our_browser()
            import time as _t
            _t.sleep(2)
            from linzhu.auth import login
            from linzhu.config import get_config

            br2 = ex1.launch(headless=False)

            class _Shim:
                pass

            cfg = get_config()
            shim = _Shim()
            shim.get = br2.get
            shim.url = br2.url
            shim.tab = br2.tab
            shim.screenshot = lambda *a, **k: None
            shim.wait_url_contains = br2.wait_url_contains
            if not login(shim, cfg):
                print("[session] ✘ 登录失败")
                return 3
            br = br2
        tab = br.tab
        for wid in WIDS:
            try:
                cv = ex1.page_fetch(tab, "workflow_api/canvas", {"workflow_id": wid, "space_id": ex1.SPACE_ID})
                ex1.save(f"canvas_{wid}.json", cv)
                wf = (cv.get("data") or {}).get("workflow") or {}
                sj = wf.get("schema_json")
                nn = len(json.loads(sj).get("nodes", [])) if sj else -1
                print(f"[canvas] {wid} name={wf.get('name')} nodes={nn} status={wf.get('status')}")
            except Exception as e:
                print(f"[canvas] {wid} 失败: {str(e)[:120]}")
        ok = True
    finally:
        try:
            br._c.quit()
        except Exception:
            pass
        import time as _t
        _t.sleep(1)
        ex1.kill_our_browser()
        print(f"[hygiene] 结束 {ex1.chrome_count()}")
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
