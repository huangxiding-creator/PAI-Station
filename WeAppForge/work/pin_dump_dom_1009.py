# -*- coding: utf-8 -*-
"""钉位验证 v6：dump 主文档+全部可达 iframe 的可见文本行，弄清当前页面真实状态。"""
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage

page = ChromiumPage("127.0.0.1:9336")
tab = next((t for t in page.get_tabs() if "mp.weixin.qq.com" in (t.url or "")), None)
if tab is None:
    raise SystemExit("no mp tab")
print("TAB_URL", (tab.url or "")[:140])

JS = r"""
(() => {
  const out = [];
  const visit = (doc, depth) => {
    if (!doc || depth > 4) return;
    let n = 0;
    try {
      const t = (doc.body ? doc.body.innerText : '') || '';
      n = t.split('\n').filter(x => x.trim()).length;
      out.push({depth, chars: t.length, lines: n, head: t.slice(0, 400)});
    } catch (e) { out.push({depth, err: String(e).slice(0, 80)}); return; }
    try {
      doc.querySelectorAll('iframe').forEach(f => {
        try { out.push({iframe: (f.src||'').slice(0,120)}); visit(f.contentDocument, depth+1); }
        catch (e) { out.push({iframe_blocked: (f.src||'').slice(0,120)}); }
      });
    } catch (e) {}
  };
  visit(document, 0);
  return JSON.stringify(out);
})()
"""
raw = tab.run_js(JS, as_expr=True)
import json
try:
    arr = json.loads(raw or "[]")
    for a in arr:
        print("----", json.dumps({k: v for k, v in a.items() if k != "head"}, ensure_ascii=False))
        if a.get("head"):
            print(a["head"][:400].replace("\n", " ⏎ "))
except Exception:
    print("RAW", (raw or "")[:2000])
