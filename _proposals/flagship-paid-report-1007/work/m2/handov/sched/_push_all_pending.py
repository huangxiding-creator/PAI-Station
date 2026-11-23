# -*- coding: utf-8 -*-
"""_push_all_pending — 批量投稿全部待发稿 (一次性完成).
步骤: 逐号起Chrome→探活→查草稿箱→投稿→验证.
"""
import json, os, re, subprocess, sys, time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
PROFILE = r"F:\We-AIPO\autopub\data\browser_profiles"
KB = r"E:\AI-Station\电力KB收割"
PROMO = r"E:\AI-Station\report_platform\promo"
POSTERS = PROMO + r"\posters"

JOBS = [
    {"acct": "acct05", "port": 9405, "name": "总包之声",
     "md": PROMO + r"\2026-11-20_zbzs_jes2_launch.md",
     "title": "发布| 《建工司法解释二逐条实务与多立场应对实战研究报告》",
     "img": POSTERS + r"\JES2-2026.png", "key": "司法解释二逐条实务"},
    {"acct": "acct05", "port": 9405, "md": PROMO + r"\2026-11-21_zbzs_tax_launch.md",
     "title": "发布| 《EPC工程税务实务与跨境税务实战研究报告》",
     "img": POSTERS + r"\TAX-2026.png", "key": "EPC工程税务实务与跨境税务"},
    {"acct": "acct01", "port": 9406, "md": PROMO + r"\2026-11-21_zbshuo_tax_clause.md",
     "title": "合同里一个「含」字，结算时差出一笔税",
     "img": POSTERS + r"\TAX-2026.png", "key": "含」字，结算时差出"},
    {"acct": "acct07", "port": 9407, "md": PROMO + r"\2026-11-21_dt_tax_invoice.md",
     "title": "业主说「先开票后付款」，法院支持吗？",
     "img": POSTERS + r"\TAX-2026.png", "key": "先开票后付款"},
]


def md_to_html(md_path):
    import html as H, re as R
    md = open(md_path, encoding="utf-8").read()
    out, title = [], ""
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
            t = R.sub(r"\*\*(.+?)\*\*", r"<strong>\1</strong>", H.escape(s))
            out.append(f"<p>{t}</p>")
    return "\n".join(out), title


def push_one(acct, port, md_path, title, img, key):
    proc = subprocess.Popen(
        [CHROME, f"--remote-debugging-port={port}",
         f"--user-data-dir={os.path.join(PROFILE, acct)}",
         "--window-size=1280,850", "--window-position=60,60",
         "--disable-blink-features=AutomationControlled", "--no-first-run",
         "--no-default-browser-check", "--disable-infobars",
         "https://mp.weixin.qq.com/"],
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    time.sleep(8)
    try:
        co = ChromiumOptions(); co.set_local_port(port)
        page = ChromiumPage(co)
        src = page.html or ""
        if "登录超时" in src or "请重新登录" in src:
            cred = json.load(open(os.path.join(KB, f"mp_cred_{acct}.json"), encoding="utf-8"))
            cookies = cred.get("cookies") or {}
            pairs = [{"name": k, "value": v} for k, v in cookies.items()] if isinstance(cookies, dict) else cookies
            page.set.cookies(pairs)
            time.sleep(1)
            page.get("https://mp.weixin.qq.com/")
            time.sleep(5)
        src = page.html or ""
        m = re.search(r"token=(\d+)", page.url or "") or re.search(r"token=(\d+)", src)
        tok = m.group(1) if m else ""
        if not tok:
            print(f"[{acct}] 未登录"); return False
        # 账号核对
        hits = [c for c in ("总包之声","总包说","工程行业大脑") if c in src]
        if len(hits) == 1:
            print(f"[{acct}] 登录账号: {hits[0]}", flush=True)
        # 打开编辑器
        page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_edit_v2&action=edit&isNew=1&type=77&token={tok}")
        time.sleep(8)
        for _ in range(15):
            r = page.run_js("return document.getElementById('title') ? 1 : 0;")
            if r == 1: break
            time.sleep(1.5)
        else:
            print(f"[{acct}] 编辑器未就绪"); return False
        # 标题
        page.run_js("document.getElementById('title').focus(); document.execCommand('selectAll', false, null); document.execCommand('insertText', false, arguments[0]);", title)
        time.sleep(1)
        # 正文: DrissionPage 原生输入
        html, _ = md_to_html(md_path)
        page.run_js("""
var ed = document.querySelector('.ProseMirror, [contenteditable=true], .edui-body-container');
if (ed) { ed.focus(); var sel = window.getSelection(); sel.selectAllChildren(ed);
  document.execCommand('insertHTML', false, arguments[0]); }
""", html)
        time.sleep(2)
        blen = page.run_js("var ed=document.querySelector('.ProseMirror,[contenteditable=true],.edui-body-container'); return ed?(ed.innerText||'').length:0;")
        print(f"[{acct}] 正文长度={blen}", flush=True)
        # 海报
        img_ele = page.ele("tag:input[type=file]", timeout=3)
        if img_ele:
            img_ele.input(img)
            time.sleep(5)
            print(f"[{acct}] 海报已上传", flush=True)
        else:
            print(f"[{acct}] 海报上传入口未找到(跳过)", flush=True)
        # 保存
        save = page.ele("text:保存为草稿", timeout=5)
        if save:
            save.click()
            print(f"[{acct}] 已点保存", flush=True)
        else:
            print(f"[{acct}] 保存按钮未找到"); return False
        time.sleep(15)
        # 落箱验证
        page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&lang=zh_CN&token={tok}")
        time.sleep(5)
        raw = page.run_js("""
return (function(){
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/cgi-bin/appmsg?action=list_ex&type=77&token=%s&lang=zh_CN&begin=0&count=30', false);
  xhr.withCredentials = true; xhr.send(); return xhr.responseText;
})()
""" % tok)
        items = json.loads(raw or "{}").get("app_msg_list") or []
        hit = any(key in (it.get("title") or "") for it in items)
        print(f"[{acct}] 落箱: {'PASS' if hit else 'FAIL'} | 箱内 {len(items)} 条", flush=True)
        return hit
    except Exception as e:
        print(f"[{acct}] 异常: {str(e)[:120]}", flush=True)
        return False
    finally:
        try:
            page.quit()
        except Exception:
            pass
        try:
            proc.terminate()
        except Exception:
            pass
        time.sleep(2)


def main():
    results = []
    for job in JOBS:
        print(f"\n=== {job['acct']} {job['title'][:36]} ===", flush=True)
        ok = push_one(job["acct"], job["port"], job["md"], job["title"], job["img"], job["key"])
        results.append((job["acct"], job["title"][:24], ok))
        time.sleep(3)
    print("\n=== 汇总 ===")
    all_ok = True
    for acct, t, ok in results:
        mark = "✓" if ok else "✗"
        print(f"  {mark} {acct} {t}")
        if not ok: all_ok = False
    return 0 if all_ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
