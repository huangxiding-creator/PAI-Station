"""一次性清理：合并重复的「AI课程」文件夹 + 删根目录旧副本。

逆向端点（chunk 71409）：
- 移动: PUT /api/file/{target}/move  {ids:[...]}
- 回收: POST /api/file/trash         {ids:[...]}
步骤：
1. 列出 AI课程#1(2097575145811836928) 的 3 个文件 → move 进 #2(…59008)
2. trash AI课程#1（空文件夹）
3. trash 根目录 3 个旧 AI 副本（A/B/C 早已补传进 #2）
4. 终验：#2 应为 100，根目录不应再有 AI 课程文件
"""
import json
import os
import sys
import time

sys.path.insert(0, "scripts")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from metaso_upload_batch import (  # noqa: E402
    CFID, URL, _ensure_login, _creds, _get_token, _list_files)

from DrissionPage import ChromiumOptions, ChromiumPage  # noqa: E402

AI1 = "2097575145811836928"  # 测试期误建
AI2 = "2097575451932459008"  # 全量正式
STALE_ROOT = ("100_可以落地的AI产品_方法论_如何用AI做出新产品.docx",
              "2025过去了三分之二_AI带来的15个Aha_Moments.docx",
              "60天_找到你的AI生态位.docx")


def item_id(it: dict) -> str:
    return str(it.get("id") or it.get("cfid") or "")


def item_name(it: dict) -> str:
    return str(it.get("fileName") or it.get("name") or "")


def api(page, method: str, path: str, token: str, body: dict) -> str:
    js = f"""
    return (async () => {{
        try {{
            const resp = await fetch('https://metaso.cn{path}', {{
                method: '{method}',
                headers: {{'Content-Type': 'application/json',
                          'token': {json.dumps(token)}}},
                body: JSON.stringify({json.dumps(body)})
            }});
            return resp.status + '||' + (await resp.text()).slice(0, 200);
        }} catch(e) {{ return '0||' + e.message; }}
    }})();
    """
    return str(page.run_js(js, timeout=30))


def main() -> int:
    account, password = _creds()
    co = ChromiumOptions()
    co.headless(False)
    co.set_user_data_path(os.path.join(os.getcwd(), "data", "browser_profile"))
    co.set_local_port(9333)
    co.set_argument("--no-first-run")
    co.set_argument("--window-size=1280,900")
    page = ChromiumPage(co)
    try:
        if not _ensure_login(page, account, password):
            print("[clean] 登录失败"); return 1
        page.get(URL, timeout=30); time.sleep(3)
        token = _get_token(page)

        # 1) #1 的文件移入 #2
        in1 = _list_files(page, token, AI1)
        ids1 = [item_id(it) for it in in1 if item_id(it)]
        print(f"[clean] AI课程#1 内 {len(ids1)} 个文件待移入 #2")
        if ids1:
            print("  move:", api(page, "PUT", f"/api/file/{AI2}/move",
                                token, {"ids": ids1}))
            time.sleep(2)
        # 2) 回收空的 #1
        print("  trash#1:", api(page, "POST", "/api/file/trash",
                               token, {"ids": [AI1]}))
        time.sleep(2)
        # 3) 回收根目录旧副本
        root = _list_files(page, token, CFID)
        stale = [item_id(it) for it in root
                 if item_name(it) in STALE_ROOT and item_id(it)]
        print(f"[clean] 根目录旧副本 {len(stale)} 个待回收")
        if stale:
            print("  trash:", api(page, "POST", "/api/file/trash",
                                 token, {"ids": stale}))
            time.sleep(2)
        # 4) 终验
        n2 = len(_list_files(page, token, AI2))
        root2 = _list_files(page, token, CFID)
        folders = [(item_name(it), item_id(it)) for it in root2
                   if isinstance(it, dict) and item_name(it)]
        print(f"\n[verify] AI课程#2 文件数 = {n2}（期望 100）")
        print(f"[verify] 根目录条目 = {len(folders)}: "
              f"{[n for n, _ in folders]}")
        return 0
    finally:
        page.quit()


if __name__ == "__main__":
    sys.exit(main())
