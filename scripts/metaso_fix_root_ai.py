"""一次性修复：早期平铺在根目录的 3 个 AI DOCX 补传进「AI课程」子目录。
并输出云端各子目录文件数（终验对账）。
"""
import json
import os
import sys
import time

sys.path.insert(0, "scripts")
sys.path.insert(0, ".")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from metaso_upload_batch import (  # noqa: E402
    CFID, SID, URL, _ensure_login, _creds, _get_token, _list_files,
    _norm, _upload_docx)

from DrissionPage import ChromiumOptions, ChromiumPage  # noqa: E402

AI_CFID = "2097575451932459008"  # 云端「AI课程」子目录


def main() -> int:
    prog = json.load(open("data/hundun/_recon/metaso_progress.json",
                          encoding="utf-8"))
    flat_three = [p for p in prog["uploaded"][:3]]
    print("早期平铺的 3 个文件：")
    for p in flat_three:
        print("  ", os.path.basename(p))

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
            print("[fix] 登录失败"); return 1
        page.get(URL, timeout=30); time.sleep(3)
        token = _get_token(page)
        # 1) 补传 3 个进 AI课程/
        for p in flat_three:
            good, detail = _upload_docx(page, p, AI_CFID)
            print(f"  [fix] {'OK' if good else 'FAIL'} "
                  f"{os.path.basename(p)[:40]}: {detail}")
            time.sleep(1.5)
        # 2) 各子目录文件数对账
        print("\n[verify] 云端各目录文件数：")
        root_items = _list_files(page, token, CFID)
        folders = {"(根目录)": root_items}
        for it in root_items:
            if isinstance(it, dict) and it.get("fileName"):
                fid = str(it.get("cfid") or it.get("id") or "")
                if fid:
                    folders[it["fileName"]] = _list_files(page, token, fid)
        for name, items in folders.items():
            files = [i for i in items if isinstance(i, dict)
                     and (i.get("fileName") or i.get("name"))]
            print(f"  {name}: {len(files)}")
        return 0
    finally:
        page.quit()


if __name__ == "__main__":
    sys.exit(main())
