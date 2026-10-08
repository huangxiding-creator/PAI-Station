# -*- coding: utf-8 -*-
"""submit_v080.py — v0.8.0 提审三步向导（1002 配方 + 1008 实况适配）。

用法:
  python submit_v080.py nav        # 进版本管理页，dump 开发版本记录块（找 v0.8.0 行）
  python submit_v080.py step1      # 点 v0.8.0 块内「提交审核」→ 须知 checkbox 勾选（单独 eval）
  python submit_v080.py step1b     # 验证 checkbox 勾上 → 点「下一步」
  python submit_v080.py step2      # 安全测试提醒弹窗 → 点「继续提交」
  python submit_v080.py form       # 到达主表单后 dump 全部字段（textarea/counter/按钮面）
  python submit_v080.py fill       # 填版本描述（§4 setter）+ dump 计数器
  python submit_v080.py commit     # scrollIntoView + 点提交（a.btn_primary），回读终验

铁律（mp-console-automation.md）：
  - 自有文本节点找真按钮（翻译扩展 span 包裹坑）
  - checkbox 与「下一步」绝不连点（Vue digest）
  - 每步 click 后回读 DOM 验证
"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402

CMD = sys.argv[1] if len(sys.argv) > 1 else "nav"

FIND_BTN = """
function findBtn(doc, depth, word) {
  if (!doc || depth > 3) return null;
  var els = null;
  try { els = doc.querySelectorAll('span, a, button, div'); } catch (e) { return null; }
  var hit = null;
  for (var i = 0; i < els.length; i++) {
    var el = els[i];
    var own = '';
    try {
      for (var k = 0; k < el.childNodes.length; k++) {
        var n = el.childNodes[k];
        if (n.nodeType === 3) own += n.textContent;
      }
    } catch (e) {}
    if (own.trim() === word) {
      var real = el.closest('button') || el.closest('a');
      if (real) hit = real;
    }
  }
  if (hit) return hit;
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) {
      var r = findBtn(frs[j].contentDocument, depth + 1, word);
      if (r) return r;
    }
  } catch (e) {}
  return null;
}
"""

page = attach_or_launch()
tab = page.latest_tab
tok = live_token(tab)
if not tok:
    print(json.dumps({"state": "ERROR", "msg": "not logged in"}))
    raise SystemExit(1)


def run_js(code):
    return tab.run_js("return (function(){" + code + "})()")


if CMD == "nav":
    tab.get(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?lang=zh_CN&token={tok}")
    time.sleep(6)
    shot(tab, "sub_nav")
    info = run_js("""
var logs = document.querySelectorAll('.code_version_log');
var out = [];
for (var i = 0; i < Math.min(logs.length, 8); i++) {
  out.push(logs[i].textContent.replace(/\\s+/g, ' ').slice(0, 220));
}
return JSON.stringify({url: location.href.slice(0, 120), n: logs.length, rows: out});
""")
    print(info)
elif CMD == "step1":
    r = run_js(FIND_BTN + """
var blk = null;
var logs = document.querySelectorAll('.code_version_log');
for (var i = 0; i < logs.length; i++) {
  if (logs[i].textContent.indexOf('0.8.0') >= 0) { blk = logs[i]; break; }
}
if (!blk) return JSON.stringify({found: false, step: 'block'});
var btn = findBtn(blk.contentDocument || document, 0, '提交审核') || findBtn(blk, 1, '提交审核');
if (!btn) {
  var els = blk.querySelectorAll('a,button');
  for (var i2 = 0; i2 < els.length; i2++) {
    if (els[i2].textContent.replace(/\\s+/g,'').indexOf('提交审核') >= 0) { btn = els[i2]; break; }
  }
}
if (!btn) return JSON.stringify({found: false, step: 'btn', blocktext: blk.textContent.replace(/\\s+/g,' ').slice(0,200)});
btn.click();
return JSON.stringify({found: true, clicked: '提交审核'});
""")
    print(r)
    time.sleep(3)
    shot(tab, "sub_step1_click")
    cb = run_js("""
var cb = document.querySelector('input[type=checkbox]');
if (!cb) return JSON.stringify({checkbox: false});
cb.click();
return JSON.stringify({checkbox: true});
""")
    print(cb)
elif CMD == "step1b":
    v = run_js("""
var cb = document.querySelector('input[type=checkbox]');
return JSON.stringify({checked: cb ? cb.checked : null});
""")
    print("checkbox:", v)
    if '"checked":true' not in v:
        print("checkbox NOT checked — 不点下一步")
        raise SystemExit(1)
    r = run_js(FIND_BTN + """
var btn = findBtn(document, 0, '下一步');
if (!btn) return JSON.stringify({found: false});
btn.click();
return JSON.stringify({found: true});
""")
    print(r)
    time.sleep(3)
    shot(tab, "sub_step1b")
elif CMD == "step2":
    r = run_js(FIND_BTN + """
var btn = findBtn(document, 0, '继续提交');
if (!btn) return JSON.stringify({found: false});
btn.click();
return JSON.stringify({found: true});
""")
    print(r)
    time.sleep(5)
    shot(tab, "sub_step2")
    print("url:", (tab.url or "")[:160])
elif CMD == "form":
    time.sleep(2)
    shot(tab, "sub_form")
    info = run_js("""
var tas = document.querySelectorAll('textarea');
var out = [];
for (var i = 0; i < tas.length; i++) {
  var t = tas[i];
  out.push({i: i, ph: (t.placeholder||'').slice(0,40), len: (t.value||'').length,
            max: t.maxLength > 0 ? t.maxLength : (t.getAttribute('maxlength')||'')});
}
var counters = [];
var cs = document.querySelectorAll('.counter,.text-counter,.textarea-counter');
for (var j = 0; j < cs.length; j++) counters.push(cs[j].textContent.trim().slice(0,20));
var radios = document.querySelectorAll('input[type=radio]');
var rlabels = [];
for (var k = 0; k < radios.length; k++) {
  var lb = radios[k].closest('label');
  rlabels.push({name: radios[k].name, value: radios[k].value, text: lb ? lb.textContent.replace(/\\s+/g,' ').slice(0,30) : ''});
}
return JSON.stringify({url: location.href.slice(0,140), textareas: out, counters: counters, radios: rlabels.slice(0,15)});
""")
    print(info)
else:
    print("unknown cmd:", CMD)
