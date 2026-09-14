#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""探测v4：页内 fetch/XHR 钩子记录请求（免疫 CDP 监听失效）。"""
import json
import time
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from upload_metaso import MetasoClient, SUBJECT_ID, TARGET_CFID, STATE

HOOK = """
window.__reqs = [];
(function(){
  const _f = window.fetch;
  window.fetch = function(input, init){
    try {
      const url = typeof input === 'string' ? input : (input && input.url) || '';
      const method = ((init && init.method) || (input && input.method) || 'GET') + '';
      let body = (init && init.body) || '';
      if (body && typeof body !== 'string') { try { body = JSON.stringify(body); } catch(e) { body = String(body); } }
      window.__reqs.push({url: String(url), method: method, body: String(body).slice(0,300)});
    } catch(e) {}
    return _f.apply(this, arguments);
  };
  const _open = XMLHttpRequest.prototype.open;
  const _send = XMLHttpRequest.prototype.send;
  XMLHttpRequest.prototype.open = function(m, u){
    this.__m = m; this.__u = u;
    return _open.apply(this, arguments);
  };
  XMLHttpRequest.prototype.send = function(b){
    try {
      let body = b || '';
      if (body && typeof body !== 'string') { try { body = JSON.stringify(body); } catch(e) { body = String(body); } }
      window.__reqs.push({url: String(this.__u), method: String(this.__m), body: String(body).slice(0,300), via: 'xhr'});
    } catch(e) {}
    return _send.apply(this, arguments);
  };
})();
"""

cli = MetasoClient()
cli.ensure_browser()
if not cli.ensure_login():
    sys.exit(1)

tab = cli.tab
tab.get(f"https://metaso.cn/subject-v2/{SUBJECT_ID}/manage?cfid={TARGET_CFID}")
time.sleep(6)
print("[0] 页面就绪，注入钩子...")
tab.run_js(HOOK)
time.sleep(0.5)

btn = tab.ele("text=新建文件夹", timeout=4)
if not btn:
    print("找不到 新建文件夹 按钮")
    sys.exit(2)
btn.click()
time.sleep(2)
print("[2] 已点击 新建文件夹")

name = f"_probe_{int(time.time())}"
inp = None
for e in tab.eles("css:input"):
    try:
        if e.rect.viewport_midpoint:
            inp = e
            break
    except Exception:
        pass
if not inp:
    print("[!] 无可见 input，弹窗未开")
else:
    inp.clear()
    inp.input(name)
    print(f"[3] 已输入 {name}")
    time.sleep(0.5)
    clicked = False
    for b in tab.eles("css:button"):
        try:
            t = (b.text or "").strip().replace(" ", "").replace("　", "")
            if t in ("确定", "创建", "新建", "保存") and b.rect.viewport_midpoint:
                b.click(by_js=True)
                clicked = True
                print(f"[4] 已点确认: {t!r}")
                break
        except Exception:
            pass
    if not clicked:
        inp.input("\n")
        print("[4] 已回车提交")
time.sleep(4)

raw = tab.run_js("return JSON.stringify(window.__reqs || [])")
reqs = json.loads(raw) if raw else []
# 只看非 GET / 含 dir|folder|file|create 关键词的
interesting = [r for r in reqs
               if r.get("method", "").upper() not in ("GET", "")
               or any(k in r.get("url", "").lower() for k in ("dir", "folder", "create", "mkdi"))]
print(f"\n共记录 {len(reqs)} 个请求，其中写操作/相关 {len(interesting)} 个：")
print(json.dumps(interesting, ensure_ascii=False, indent=1))
(STATE / "metaso-dir-probe4.json").write_text(
    json.dumps({"all_count": len(reqs), "interesting": interesting}, ensure_ascii=False, indent=1),
    encoding="utf-8")
print("已存 state/metaso-dir-probe4.json")
