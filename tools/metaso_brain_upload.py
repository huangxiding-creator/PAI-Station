# -*- coding: utf-8 -*-
"""metaso_brain_upload — 研报成果上传秘塔工程行业大脑 (1016 用户令, 复刻
F:/We-AIPO/src/plugins/process/metaso_uploader.py 生产法).

复刻要点 (We-AIPO 2026-07-27 关键修复):
  1. 用 **We-AIPO 生产 metaso profile** (F:/We-AIPO/data/browser_profile/metaso
     — 有工程行业大脑编辑权的账号会话), 非本仓 waytoagi profile;
  2. 页内 fetch PUT /api/file/{cfid}, **cookie 认证 credentials:'include'**,
     绝不带 meta-token 头 (只读 token 会覆盖 cookie 写权限 → "您没有权限");
  3. 成功判据 = HTTP 200 ∧ errCode∈{0,1} (1=已存在幂等);
  4. 只增不删; 2-4s 节流; 单件幂等可重跑。

用法: py -3.11 tools/metaso_brain_upload.py --cfid 8676827961374429184 \
        --sid 8673582927558737920 --file <报告md> [更多文件...]
"""
from __future__ import annotations

import argparse
import json
import random
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import Chromium, ChromiumOptions   # noqa: E402

WE_AIPO_PROFILE = Path(r"F:\We-AIPO\data\browser_profile\metaso")
LOGIN_MARKERS = ("text:退出登录", "text:个人中心", "text:我的会员", "text:账号信息")


def build_options() -> ChromiumOptions:
    co = ChromiumOptions()
    co.set_argument("--window-position=-32000,0")       # 离屏
    co.set_argument("--disable-blink-features=AutomationControlled")
    co.set_user_data_path(str(WE_AIPO_PROFILE))
    co.set_local_port(9327)
    return co


def is_logged_in(tab) -> bool:
    return any(True for m in LOGIN_MARKERS if tab.ele(m, timeout=1))


def upload_file(tab, cfid: str, fname: str, content: str) -> tuple[bool, str]:
    payload = json.dumps(content, ensure_ascii=False)
    fname_js = json.dumps(fname, ensure_ascii=False)
    js = f"""
    return (async () => {{
        try {{
            const blob = new Blob([{payload}], {{type: 'text/markdown'}});
            const form = new FormData();
            form.append('file', blob, {fname_js});
            form.append('fileName', {fname_js});
            form.append('type', 'md');
            const resp = await fetch('/api/file/{cfid}', {{
                method: 'PUT', body: form, credentials: 'include'
            }});
            const txt = await resp.text();
            return resp.status + '||' + txt;
        }} catch(e) {{ return '0||' + e.message; }}
    }})();
    """
    result = tab.run_js(js, timeout=120)
    status, _, body = str(result).partition("||")
    if status != "200":
        return False, f"HTTP {status}: {body[:80]}"
    try:
        d = json.loads(body)
    except json.JSONDecodeError:
        return False, f"非JSON响应: {body[:80]}"
    if d.get("errCode") in (0, 1):
        return True, ("已存在(幂等)" if d.get("errCode") == 1 else "ok")
    return False, f"errCode={d.get('errCode')}: {str(d.get('errMsg'))[:80]}"


def main() -> int:
    ap = argparse.ArgumentParser(description="研报上秘塔工程行业大脑(复刻法)")
    ap.add_argument("--cfid", required=True)
    ap.add_argument("--sid", required=True)
    ap.add_argument("--file", action="append", required=True)
    ns = ap.parse_args()
    browser = Chromium(build_options())
    tab = browser.latest_tab
    tab.get(f"https://metaso.cn/subject-v2/{ns.sid}", timeout=30)
    time.sleep(3)
    if not is_logged_in(tab):
        print("[brain] We-AIPO profile 登录态失效 — 需人工扫码/登录一次后重跑",
              file=sys.stderr)
        return 2
    print("[brain] 登录态有效 (We-AIPO 生产 profile)")
    n_ok = 0
    for fp in ns.file:
        p = Path(fp)
        if not p.is_file():
            print(f"[brain] 缺文件: {fp}")
            continue
        ok, info = upload_file(tab, ns.cfid, p.name,
                               p.read_text(encoding="utf-8"))
        print(f"[brain] {'✅' if ok else '✗'} {p.name}: {info}")
        n_ok += ok
        time.sleep(random.uniform(2, 4))
    print(f"[brain] 完成 {n_ok}/{len(ns.file)}")
    return 0 if n_ok == len(ns.file) else 1


if __name__ == "__main__":
    raise SystemExit(main())
