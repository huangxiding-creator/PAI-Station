# -*- coding: utf-8 -*-
"""wizard_stage2_submit.py — get_class 主表单: 填版本描述+清订单path → 一次提交 → 终验。
红线：只提交一次；绝不加急；成功后不再点任何提交类按钮。"""
import json
import sys
import time
import urllib.parse

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402

DESC = ("总包科技产品矩阵展示小程序本次更新：1.首页新增旗舰直达卡片，可跳转同主体小程序"
        "「总包AI顾问」（免费咨询/研报商城）；2.新增总包AI顾问眼镜产品介绍页（获取方式三步指南）；"
        "3.品牌更名为总包科技。纯展示内容，无支付无登录，不采集用户信息。"
        "测试：首页点「立即进入」验证跳转弹窗，产品页正常浏览。")
QDESC = urllib.parse.quote(DESC)

page = attach_or_launch()
form = None
for tid in page.tab_ids:
    t = page.get_tab(tid)
    if "get_class" in (t.url or ""):
        form = t
        break
if not form:
    print(json.dumps({"form_tab": False}))
    raise SystemExit(1)

html = form.html or ""
if "wxfdb55b184756e89e" not in html and "gh_5ebe2155780f" not in html and "总包科技" not in html:
    print(json.dumps({"guard": "APPID_MISMATCH"}))
    raise SystemExit(1)
if "你正在提交开发版 1.2.0" not in (form.run_js("return document.body.innerText") or ""):
    print(json.dumps({"guard": "NOT_120"}))
    raise SystemExit(1)

# 1) 填版本描述（原生 setter + input 事件 + 回读验证）
r1 = form.run_js("""
return (function(){
  var ta = document.querySelector('textarea.weui-desktop-form__textarea');
  if (!ta) return JSON.stringify({step: 'no_ta'});
  var q = decodeURIComponent('""" + QDESC + r"""');
  var setter = Object.getOwnPropertyDescriptor(window.HTMLTextAreaElement.prototype, 'value').set;
  setter.call(ta, q);
  ta.dispatchEvent(new Event('input', {bubbles: true}));
  ta.dispatchEvent(new Event('change', {bubbles: true}));
  var counter = (document.querySelector('.counter,.text-counter') || {}).textContent || '';
  return JSON.stringify({step: 'filled', len: ta.value.length, back: ta.value.slice(0, 24), counter: counter});
})()
""")
print("fill:", r1)

# 2) 清空订单中心 path（陈旧死路径 page/order/list 必须清）
r2 = form.run_js(r"""
return (function(){
  var ips = document.querySelectorAll('input[type="text"], input:not([type])');
  var out = [];
  for (var i = 0; i < ips.length; i++) {
    if (ips[i].offsetParent !== null && (ips[i].value || '').indexOf('page/order') >= 0) {
      var setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;
      setter.call(ips[i], '');
      ips[i].dispatchEvent(new Event('input', {bubbles: true}));
      ips[i].dispatchEvent(new Event('change', {bubbles: true}));
      out.push({cleared: true, now: ips[i].value});
    }
  }
  return JSON.stringify({steps: out.length, out: out});
})()
""")
print("order_path:", r2)
time.sleep(1)
shot(form, "wiz_form_filled")

# 3) 提交（scrollIntoView 与 click 分离；唯一一次）
r3 = form.run_js(r"""
return (function(){
  var as = document.querySelectorAll('a.btn');
  for (var i = 0; i < as.length; i++) {
    var t = (as[i].innerText || '').trim();
    if (t === '提交审核' && as[i].offsetParent !== null) {
      as[i].scrollIntoView({block: 'center'});
      return JSON.stringify({step: 'scrolled', t: t});
    }
  }
  return JSON.stringify({step: 'no_btn'});
})()
""")
print("scroll:", r3)
time.sleep(1)

r4 = form.run_js(r"""
return (function(){
  var as = document.querySelectorAll('a.btn');
  for (var i = 0; i < as.length; i++) {
    var t = (as[i].innerText || '').trim();
    if (t === '提交审核' && as[i].offsetParent !== null) {
      as[i].click();
      return JSON.stringify({step: 'submitted'});
    }
  }
  return JSON.stringify({step: 'no_btn'});
})()
""")
print("submit:", r4)
time.sleep(3)
shot(form, "wiz_after_submit")

# 4) 可能的确认弹窗「确定，继续提交」
r5 = form.run_js(r"""
return (function(){
  var btns = document.querySelectorAll('button');
  for (var i = 0; i < btns.length; i++) {
    var t = (btns[i].innerText || '').replace(/\s+/g, '');
    if (t.indexOf('确定，继续提交') >= 0 && btns[i].offsetParent !== null) {
      btns[i].click();
      return JSON.stringify({step: 'confirm_clicked'});
    }
  }
  var bt = (document.body.innerText || '');
  return JSON.stringify({step: 'no_confirm', body_has_submitted: bt.indexOf('已提交') >= 0 || bt.indexOf('提交成功') >= 0});
})()
""")
print("confirm:", r5)
time.sleep(5)
shot(form, "wiz_final")

# 5) 终验：表单页文本 或 成功弹窗
r6 = form.run_js(r"""
return (function(){
  var t = (document.body.innerText || '');
  return JSON.stringify({submitted: t.indexOf('已提交审核') >= 0 || t.indexOf('提交成功') >= 0 || t.indexOf('审核中') >= 0,
    snippet: t.replace(/\s+/g, ' ').slice(0, 260)});
})()
""")
print("verify_form:", r6)
