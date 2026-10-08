# -*- coding: utf-8 -*-
"""wizard_run.py — v0.8.0 提审向导一体化驱动（1008 实况配方：可见弹窗过滤版）。

用法:
  python wizard_run.py nav      # 进版本管理页，dump 0.8.0 开发版本块
  python wizard_run.py step1    # 点 0.8.0 块「提交审核」（弹须知 dialog）
  python wizard_run.py step1b   # 可见须知弹窗：勾 checkbox（勾后复验）→ 下一步
  python wizard_run.py step2    # 安全测试提醒弹窗 → 继续提交
  python wizard_run.py form     # dump 主表单字段状态（textarea/radio/按钮）
  python wizard_run.py fill     # 版本描述 setter 填入 + 复验计数器
  python wizard_run.py commit   # scrollIntoView + 点 a.btn_primary 提交审核 → 终验
铁律：自有文本节点找真按钮；checkbox 勾后必复验；每步回读 DOM。
"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402

CMD = sys.argv[1] if len(sys.argv) > 1 else "nav"

VERSION_DESC = (
    "新增导出：安卓端问答可导出Word/PDF/Markdown，0.1元/条虚拟支付，"
    "解锁后可反复导出，iOS不展示付费入口；咨询/追问/锅圈/智库全免费。"
    "测试：咨询页提问出AI解答→回答页追问/要点/依据→安卓点导出按提示支付→"
    "我的页批量导出。内容均由AI检索知识库生成，三页常驻AI生成标识，"
    "导出文件附声明。收集openid、提问内容、自愿共享问答、支付订单号。"
)

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
function visible(el) {
  if (!el) return false;
  var st = getComputedStyle(el);
  var r = el.getBoundingClientRect();
  return st.display !== 'none' && st.visibility !== 'hidden' && r.width > 60 && r.height > 20;
}
function visDialog(anchor) {
  var cands = document.querySelectorAll('.weui-dialog, .dialog, .modal, [class*=dialog], [class*=modal], [class*=Dialog]');
  var out = [];
  for (var i = 0; i < cands.length; i++) {
    var el = cands[i];
    if (!visible(el)) continue;
    if (anchor && el.textContent.indexOf(anchor) < 0) continue;
    out.push(el);
  }
  // 兜底：可见 dialog 类不中时，按锚文本全文档找可见容器
  if (!out.length && anchor) {
    var all = document.querySelectorAll('div');
    for (var j = 0; j < all.length; j++) {
      var d = all[j];
      if (!visible(d)) continue;
      var t = d.textContent || '';
      if (t.indexOf(anchor) >= 0 && t.length < 3000) { out.push(d); break; }
    }
  }
  return out.length ? out[0] : null;
}
"""

page = attach_or_launch()
tab = page.latest_tab
# 钉定 getcodepage 标签（nav 的 tab.get 可能开新页，latest_tab 漂移到首页）
try:
    for _tid in page.tab_ids:
        _t = page.get_tab(_tid)
        if _t and "wacodepage/getcodepage" in (_t.url or ""):
            tab = _t
            break
except Exception:
    pass
tok = live_token(tab)
if not tok:
    print(json.dumps({"state": "ERROR", "msg": "not logged in"}, ensure_ascii=False))
    raise SystemExit(1)


def run_js(code):
    return tab.run_js("return (function(){" + code + "})()")


if CMD == "nav":
    tab.get(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?lang=zh_CN&token={tok}")
    time.sleep(6)
    shot(tab, "wz_nav")
    print(run_js("""
var logs = document.querySelectorAll('.code_version_log');
var out = [];
for (var i = 0; i < Math.min(logs.length, 6); i++) {
  out.push(logs[i].textContent.replace(/\\s+/g, ' ').slice(0, 200));
}
return JSON.stringify({url: location.href.slice(0, 120), n: logs.length, rows: out});
"""))
elif CMD == "step1":
    print(run_js(FIND_BTN + """
var blk = null;
var logs = document.querySelectorAll('.code_version_log');
for (var i = 0; i < logs.length; i++) {
  if (logs[i].textContent.indexOf('0.8.0') >= 0) { blk = logs[i]; break; }
}
if (!blk) return JSON.stringify({found: false, step: 'block'});
var btn = findBtn(blk, 1, '提交审核');
if (!btn) {
  var els = blk.querySelectorAll('a,button');
  for (var i2 = 0; i2 < els.length; i2++) {
    if (els[i2].textContent.replace(/\\s+/g,'').indexOf('提交审核') >= 0) { btn = els[i2]; break; }
  }
}
if (!btn) return JSON.stringify({found: false, step: 'btn', blocktext: blk.textContent.replace(/\\s+/g,' ').slice(0,200)});
btn.click();
return JSON.stringify({found: true, clicked: '提交审核'});
"""))
    time.sleep(3)
    shot(tab, "wz_step1")
elif CMD == "step1b":
    # 阶段A：找可见须知弹窗 + 勾 checkbox
    print(run_js(FIND_BTN + """
var dlg = visDialog('提交审核的相关须知');
if (!dlg) return JSON.stringify({dialog: false});
var cbs = dlg.querySelectorAll('input[type=checkbox]');
if (!cbs.length) return JSON.stringify({dialog: true, checkbox: 0});
var cb = cbs[0];
if (!cb.checked) cb.click();
return JSON.stringify({dialog: true, checkbox: 1, was: cb.checked});
"""))
    time.sleep(1.5)
    # 阶段B：复验勾选态，true 才点下一步
    v = run_js(FIND_BTN + """
var dlg = visDialog('提交审核的相关须知');
if (!dlg) return JSON.stringify({dialog: false});
var cb = dlg.querySelector('input[type=checkbox]');
return JSON.stringify({checked: cb ? cb.checked : null});
""")
    print("checkbox:", v)
    if '"checked":true' not in v:
        print("checkbox NOT checked — 停，不点下一步")
        raise SystemExit(1)
    print(run_js(FIND_BTN + """
var dlg = visDialog('提交审核的相关须知');
if (!dlg) return JSON.stringify({dialog: false});
var btn = findBtn(dlg, 1, '下一步');
if (!btn) return JSON.stringify({dialog: true, next: false});
btn.click();
return JSON.stringify({dialog: true, next: true});
"""))
    time.sleep(3)
    shot(tab, "wz_step1b")
elif CMD == "step2":
    print(run_js(FIND_BTN + """
var btn = findBtn(document, 0, '继续提交');
if (!btn) return JSON.stringify({found: false});
btn.click();
return JSON.stringify({found: true});
"""))
    time.sleep(5)
    shot(tab, "wz_step2")
    print("url:", (tab.url or "")[:170])
elif CMD == "form":
    time.sleep(2)
    shot(tab, "wz_form")
    print(run_js("""
var out = {url: location.href.slice(0, 150)};
var tas = document.querySelectorAll('textarea');
out.textareas = [];
for (var i = 0; i < tas.length; i++) {
  var t = tas[i];
  out.textareas.push({i: i, ph: (t.placeholder||'').slice(0,30), len: (t.value||'').length,
    val_head: (t.value||'').slice(0, 40), max: t.maxLength > 0 ? t.maxLength : (t.getAttribute('maxlength')||'')});
}
var radios = document.querySelectorAll('input[type=radio]');
out.radios = [];
for (var k = 0; k < radios.length; k++) {
  var lb = radios[k].closest('label') || radios[k].parentElement;
  out.radios.push({name: radios[k].name, value: radios[k].value, checked: radios[k].checked,
    text: lb ? lb.textContent.replace(/\\s+/g,' ').slice(0,26) : ''});
}
var oc = [];
var labels = document.querySelectorAll('label, .form_item, div[class*=title]');
for (var m = 0; m < labels.length; m++) {
  var tx = (labels[m].textContent||'').replace(/\\s+/g,' ');
  if (tx.indexOf('订单中心') >= 0 && tx.length < 120) oc.push(tx);
}
out.order_center_ctx = oc.slice(0,3);
return JSON.stringify(out);
"""))
elif CMD == "fill":
    import urllib.parse
    desc_param = urllib.parse.quote(VERSION_DESC)
    print(run_js("""
var desc = decodeURIComponent('""" + desc_param + """');
var ta = null;
var tas = document.querySelectorAll('textarea');
for (var i = 0; i < tas.length; i++) {
  if ((tas[i].placeholder||'').indexOf('功能') >= 0 || (tas[i].value||'').length > 20 || tas[i].maxLength === 200) { ta = tas[i]; break; }
}
if (!ta && tas.length) ta = tas[0];
if (!ta) return JSON.stringify({found: false});
var setter = Object.getOwnPropertyDescriptor(window.HTMLTextAreaElement.prototype, 'value').set;
setter.call(ta, desc);
ta.dispatchEvent(new Event('input', {bubbles: true}));
ta.dispatchEvent(new Event('change', {bubbles: true}));
return JSON.stringify({found: true, len: ta.value.length, head: ta.value.slice(0, 30), tail: ta.value.slice(-20)});
"""))
    time.sleep(1.5)
    shot(tab, "wz_fill")
elif CMD == "commit":
    # 先 dump 表单终态快照（提交前证据）
    print("pre-commit snapshot:")
    print(run_js("""
var ta = document.querySelectorAll('textarea')[0];
var r = {desc_len: ta ? ta.value.length : -1};
var radios = document.querySelectorAll('input[type=radio]');
for (var k = 0; k < radios.length; k++) if (radios[k].checked) {
  r[(radios[k].name||'radio') + '=' + radios[k].value] = true;
}
return JSON.stringify(r);
"""))
    print(run_js(FIND_BTN + """
var btns = document.querySelectorAll('a.btn_primary, a.btn.btn_primary, .btn_primary');
var btn = null;
for (var i = 0; i < btns.length; i++) {
  var t = (btns[i].textContent||'').replace(/\\s+/g,'');
  if (t.indexOf('提交审核') >= 0 && visible(btns[i])) { btn = btns[i]; break; }
}
if (!btn) { btn = findBtn(document, 0, '提交审核'); }
if (!btn || !visible(btn)) return JSON.stringify({found: false});
if (btn.scrollIntoView) btn.scrollIntoView({block: 'center'});
return JSON.stringify({found: true, tag: btn.tagName, cls: btn.className.slice(0,60), text: (btn.textContent||'').trim().slice(0,20)});
"""))
    time.sleep(1)
    print(run_js(FIND_BTN + """
var btns = document.querySelectorAll('a.btn_primary, a.btn.btn_primary, .btn_primary');
var btn = null;
for (var i = 0; i < btns.length; i++) {
  var t = (btns[i].textContent||'').replace(/\\s+/g,'');
  if (t.indexOf('提交审核') >= 0 && visible(btns[i])) { btn = btns[i]; break; }
}
if (!btn) { btn = findBtn(document, 0, '提交审核'); }
if (!btn) return JSON.stringify({found: false, phase: 'click'});
btn.click();
return JSON.stringify({found: true, clicked: true});
"""))
    time.sleep(5)
    shot(tab, "wz_commit")
    # 终验：已提交审核 toast / 跳版本页
    print(run_js("""
var t = (document.body.textContent||'');
var hits = [];
['已提交审核', '提交成功', '审核中'].forEach(function(k){ if (t.indexOf(k)>=0) hits.push(k); });
return JSON.stringify({url: location.href.slice(0, 150), hits: hits});
"""))
else:
    print("unknown cmd:", CMD)
