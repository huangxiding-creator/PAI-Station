#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""UI 驱动删除一个 docx 样本，fetch/XHR 钩子抓真实删除请求。"""
import json
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from upload_metaso import MetasoClient, SUBJECT_ID, TARGET_CFID, STATE
from probe_metaso_delete_api import list_dir  # 复用翻页列表

FNAME = "雪梅：吴恩达Transformer课程.docx"
CHAP_CFID = "2098612644141748224"

HOOK = """
window.__reqs = [];
(function(){
  const _f = window.fetch;
  window.fetch = function(input, init){
    try {
      const url = typeof input === 'string' ? input : (input && input.url) || '';
      const method = ((init && init.method) || (input && input.method) || 'GET') + '';
      let body = (init && init.body) || '';
      if (body && typeof body !== 'string') { try { body = JSON.stringify(body); } catch(e) {} }
      window.__reqs.push({url: String(url), method: method, body: String(body).slice(0,300)});
    } catch(e) {}
    return _f.apply(this, arguments);
  };
  const _open = XMLHttpRequest.prototype.open;
  const _send = XMLHttpRequest.prototype.send;
  XMLHttpRequest.prototype.open = function(m, u){ this.__m = m; this.__u = u; return _open.apply(this, arguments); };
  XMLHttpRequest.prototype.send = function(b){
    try {
      let body = b || '';
      if (body && typeof body !== 'string') { try { body = JSON.stringify(body); } catch(e) {} }
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
tab.get(f"https://metaso.cn/subject-v2/{SUBJECT_ID}/manage?cfid={CHAP_CFID}")
time.sleep(5)
tab.run_js(HOOK)
print("[1] 已进入章节夹并注入钩子")

# 找到目标行
row = tab.ele(f"text={FNAME}", timeout=5)
if not row:
    print("❌ 找不到目标行")
    sys.exit(2)
print("[2] 找到目标行")

# 策略A：行 hover → 勾选框
clicked = False
try:
    row.hover()
    time.sleep(0.8)
    for cb in tab.eles("css:input[type=checkbox]"):
        try:
            if cb.rect.viewport_midpoint:
                cb.click(by_js=True)
                clicked = True
                print("[3a] 已点勾选框")
                break
        except Exception:
            pass
except Exception as ex:
    print(f"  (策略A异常: {type(ex).__name__})")
time.sleep(1)

# 策略B：工具栏/行内 删除 按钮
for label in ("删除", "移除", "删 除"):
    try:
        for b in tab.eles(f"text={label}"):
            try:
                if b.rect.viewport_midpoint:
                    b.click(by_js=True)
                    print(f"[4] 已点 {label!r}")
                    clicked = True
                    break
            except Exception:
                pass
        if clicked:
            break
    except Exception:
        pass

time.sleep(1.5)
# 确认弹窗
for label in ("确 定", "确定", "删除", "确认"):
    try:
        for b in tab.eles(f"text={label}"):
            try:
                if b.rect.viewport_midpoint:
                    b.click(by_js=True)
                    print(f"[5] 已确认 {label!r}")
                    break
            except Exception:
                pass
    except Exception:
        pass
time.sleep(3)

raw = tab.run_js("return JSON.stringify(window.__reqs||[])")
reqs = json.loads(raw or "[]")
writes = [r for r in reqs if r.get("method", "").upper() not in ("GET", "HEAD")
          or any(k in r.get("url", "").lower() for k in ("del", "remove", "trash"))]
print(f"\n共 {len(reqs)} 请求，写操作 {len(writes)} 个：")
print(json.dumps(writes, ensure_ascii=False, indent=1))

# 复核
left = [it for it in list_dir(CHAP_CFID) if it.get("fileName") == FNAME]
print(f"\n复核：{FNAME} {'仍存在 ✗' if left else '已删除 ✓'}")
(STATE / "metaso-delete-ui-probe.json").write_text(
    json.dumps({"writes": writes, "gone": not left}, ensure_ascii=False, indent=1),
    encoding="utf-8")
