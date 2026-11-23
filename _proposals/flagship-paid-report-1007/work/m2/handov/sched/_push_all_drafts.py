# -*- coding: utf-8 -*-
"""_push_all_drafts — 批量投稿: 逐号起 Chrome → DrissionPage 原生输入 → 保存 → 落箱验证.
用法: py -X utf8 _push_all_drafts.py
"""
import json
import os
import re
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
PROFILE = r"F:\We-AIPO\autopub\data\browser_profiles"
PROMO = r"E:\AI-Station\report_platform\promo"
POSTER = PROMO + r"\posters"
KB = r"E:\AI-Station\电力KB收割"

JOBS = [
    {"acct": "acct05", "port": 9395, "md": PROMO + r"\2026-11-20_zbzs_jes2_launch.md",
     "title": "发布| 《建工司法解释二逐条实务与多立场应对实战研究报告》",
     "img": POSTER + r"\JES2-2026.png", "verify_key": "司法解释二逐条实务"},
    {"acct": "acct05", "port": 9395, "md": PROMO + r"\2026-11-21_zbzs_tax_launch.md",
     "title": "发布| 《EPC工程税务实务与跨境税务实战研究报告》",
     "img": POSTER + r"\TAX-2026.png", "verify_key": "EPC工程税务实务与跨境税务"},
    {"acct": "acct01", "port": 9396, "md": PROMO + r"\2026-11-21_zbshuo_tax_clause.md",
     "title": "合同里一个「含」字，结算时差出一笔税",
     "img": POSTER + r"\TAX-2026.png", "verify_key": "含」字，结算时差出"},
    {"acct": "acct07", "port": 9397, "md": PROMO + r"\2026-11-21_dt_tax_invoice.md",
     "title": "业主说「先开票后付款」，法院支持吗？",
     "img": POSTER + r"\TAX-2026.png", "verify_key": "先开票后付款"},
]


def md_to_html(md_path):
    import html as H
    md = open(md_path, encoding="utf-8").read()
    out = []
    title = ""
    for ln in md.splitlines():
        s = ln.strip()
        if ln.startswith("# "):
            title = ln[2:].strip()
            continue
        if s.startswith("## "):
            out.append(f"<h2>{H.escape(s[3:])}</h2>")
        elif s.startswith("> "):
            out.append(f"<p><em>{H.escape(s[2:])}</em></p>")
        elif s.startswith("!["):
            continue
        elif s:
            import re as R
            t = R.sub(r"\*\*(.+?)\*\*", r"<strong>\1</strong>", H.escape(s))
            out.append(f"<p>{t}</p>")
    return "\n".join(out)


def kill_acct(acct):
    subprocess.run(["powershell", "-NoProfile", "-Command",
                    f"Get-CimInstance Win32_Process -Filter \"Name='chrome.exe'\" | "
                    f"Where-Object {{$_.CommandLine -match '{acct}'}} | "
                    "ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }"],
                   capture_output=True, timeout=30)


def push_one(job):
    acct = job["acct"]
    port = job["port"]
    kill_acct(acct)
    time.sleep(3)
    co = ChromiumOptions()
    co.set_local_port(port)
    co.set_paths(user_data_path=os.path.join(PROFILE, acct))
    co.set_argument("--disable-blink-features=AutomationControlled")
    co.set_argument("--no-first-run")
    co.set_argument("--no-default-browser-check")
    co.set_argument("--disable-infobars")
    co.set_argument("--window-size=1280,850")
    page = ChromiumPage(co)
    try:
        # 登录态检查
        page.get("https://mp.weixin.qq.com/")
        time.sleep(6)
        src = page.html or ""
        if "登录超时" in src or "请重新登录" in src:
            # 用 cred 兜底
            cred = json.load(open(os.path.join(KB, f"mp_cred_{acct}.json"), encoding="utf-8"))
            cookies = cred.get("cookies") or {}
            pairs = [{"name": k, "value": v} for k, v in cookies.items()] if isinstance(cookies, dict) else cookies
            page.set.cookies(pairs)
            time.sleep(1)
            page.get("https://mp.weixin.qq.com/")
            time.sleep(5)
        m = re.search(r"token=(\d+)", page.url or "") or re.search(r"token=(\d+)", page.html or "")
        tok = m.group(1) if m else ""
        if not tok:
            print(f"[{acct}] 未登录", flush=True)
            return False
        print(f"[{acct}] token={tok}", flush=True)
        # 打开编辑器
        page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_edit_v2&action=edit&isNew=1&type=77&token={tok}")
        time.sleep(8)
        # 等编辑器就绪
        for _ in range(20):
            r = page.run_js("return document.getElementById('title') ? 1 : 0;")
            if r == 1:
                break
            time.sleep(1.5)
        else:
            print(f"[{acct}] 编辑器未就绪", flush=True)
            return False
        # 标题
        page.run_js("""
document.getElementById('title').focus();
document.execCommand('selectAll', false, null);
document.execCommand('insertText', false, arguments[0]);
""", job["title"])
        time.sleep(1)
        # 正文
        html = md_to_html(job["md"])
        page.run_js("""
var ed = document.querySelector('.ProseMirror, [contenteditable=true], .edui-body-container');
if (ed) {
  ed.focus();
  var sel = window.getSelection();
  sel.selectAllChildren(ed);
  document.execCommand('insertHTML', false, arguments[0]);
}
""", html)
        time.sleep(2)
        blen = page.run_js("var ed=document.querySelector('.ProseMirror,[contenteditable=true],.edui-body-container'); return ed?(ed.innerText||'').length:0;")
        print(f"[{acct}] 正文长度={blen}", flush=True)
        # 海报图
        img_ele = page.ele("tag:input[type=file]", timeout=3)
        if img_ele:
            img_ele.input(job["img"])
            time.sleep(5)
            print(f"[{acct}] 海报已上传", flush=True)
        else:
            print(f"[{acct}] 海报上传入口未找到(跳过)", flush=True)
        # 保存
        title_check = page.run_js("return document.getElementById('title') ? document.getElementById('title').value : '';")
        print(f"[{acct}] 保存前标题检查: '{title_check[:30]}'", flush=True)
        if not title_check or len(title_check) < 4:
            print(f"[{acct}] 标题为空! 用 JS 补填", flush=True)
            page.run_js("document.getElementById('title').focus(); document.execCommand('selectAll', false, null); document.execCommand('insertText', false, arguments[0]);", job["title"])
            time.sleep(1)
        save = page.ele("text:保存为草稿", timeout=5)
        if save:
            save.click()
            print(f"[{acct}] 已点保存", flush=True)
        else:
            print(f"[{acct}] 保存按钮未找到", flush=True)
            return False
        time.sleep(15)   # 保存需要时间
        # 截图看保存后状态
        try:
            page.get_screenshot(os.path.join(os.environ.get("TEMP", "/tmp"), f"save_{acct}.png"))
            print(f"[{acct}] 保存后截图已存", flush=True)
        except Exception:
            pass
        # 落箱验证
        page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&lang=zh_CN&token={tok}")
        time.sleep(4)
        raw = page.run_js("""
return (function(){
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/cgi-bin/appmsg?action=list_ex&type=77&token=%s&lang=zh_CN&begin=0&count=30', false);
  xhr.withCredentials = true; xhr.send(); return xhr.responseText;
})()
""" % tok)
        items = json.loads(raw or "{}").get("app_msg_list") or []
        hit = any(job["verify_key"] in (it.get("title") or "") for it in items)
        print(f"[{acct}] 落箱: {'PASS' if hit else 'FAIL'}", flush=True)
        return hit
    except Exception as e:
        print(f"[{acct}] 异常: {str(e)[:120]}", flush=True)
        return False
    finally:
        try:
            page.quit()
        except Exception:
            pass


def main():
    results = []
    for job in JOBS:
        print(f"\n=== {job['acct']} {job['title'][:30]} ===", flush=True)
        ok = push_one(job)
        results.append((job["acct"], job["title"][:20], ok))
        time.sleep(3)
    print("\n=== 汇总 ===")
    for acct, t, ok in results:
        print(f"  {acct} {'✓' if ok else '✗'} {t}")
    return 0 if all(ok for _, _, ok in results) else 1


if __name__ == "__main__":
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    raise SystemExit(main())
