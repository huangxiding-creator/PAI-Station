# -*- coding: utf-8 -*-
"""submit_review_0911.py — 0.9.11 提审向导驱动（9336 通道，分阶段状态机）。

用法: python submit_review_0911.py <stage>
  recon   只读侦察：appid 体检 + 0.9.11 开发版行 + 提交审核按钮在位（零点击）
  open    点「提交审核」进向导 → 第1步须知弹窗（不勾不点）
  step1   勾须知 checkbox + 点「下一步」（两段式 eval，§3 铁律）
  step2   点「继续提交」→ 主表单整页 dump（不填）
  fill    填版本描述 + 单选三件 + 加急 → 停在提交键前（不提交，先给用户证材料）
  submit  点提交键 → 终验「已提交审核」+ 截图

红线：fill/submit 两段独立跑，人工看过 fill 的 DOM dump 再放 submit。
"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

VER = "0.9.12"
APPID = "wx5cee1574ce45819b"
DESC = ("本小程序为工程行业AI问答咨询工具：微信登录后首页可见免费额度与平台统计，"
        "输入工程问题（如“EPC合同工期延误怎么索赔”）AI流式生成解答；要点速览、依据来源、"
        "继续追问均免费，文件导出为可选付费。锅圈为用户自愿共享的公开问答展区，带分类标签，"
        "接内容安全检测并提供举报入口。所有AI生成内容均有显著标识（含导出海报）。"
        "仅收集微信openid与提问内容，无需测试账号。")

JS_READ_TRIAL = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i]) === '体验版'){
      var node = els[i];
      for (var d=0; d<8 && node; d++){
        node = node.parentElement;
        if (!node) break;
        var t = node.innerText || '';
        if (t.length > 20 && t.length < 600){
          var m = t.match(/\d+\.\d+\.\d+/);
          if (m) return JSON.stringify({ver: m[0], ctx: t.slice(0,80).replace(/\n/g,'|')});
        }
      }
    }
  }
  return JSON.stringify({ver: null});
})();
"""

# 0.9.11 开发版行内结构 dump + 提交审核按钮在位（零点击）
JS_RECON_ROW = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i]) === '""" + VER + r"""'){
      var row = els[i];
      for (var d=0; d<8 && row; d++){
        var t = row.innerText || '';
        if (t.indexOf('提交审核') >= 0){
          var btn = row.querySelector('button.weui-desktop-btn_primary, .weui-desktop-btn_primary');
          var arrow = row.querySelector('.arrowBtn');
          return JSON.stringify({depth:d, rowText:t.slice(0,180).replace(/\n/g,'|'),
            submitBtn: btn ? (btn.className + '|' + (btn.innerText||'').trim()) : null,
            arrow: !!arrow});
        }
        row = row.parentElement;
      }
      return JSON.stringify({depth:-1, err:'no-row-with-submit'});
    }
  }
  return JSON.stringify({err:'no-anchor'});
})();
"""

# 当前可见弹窗 dump（须知/安全测试等，§2 可见性判据）
JS_DUMP_DIALOG = r"""
return (function(){
  var out = [];
  var sels = ['.weui-desktop-dialog', '.weui-desktop-modal', '.dialog', '[class*="dialog"]', '[class*="modal"]'];
  var seen = {};
  for (var s=0; s<sels.length; s++){
    var els;
    try { els = document.querySelectorAll(sels[s]); } catch(e){ continue; }
    for (var i=0;i<els.length;i++){
      var el = els[i];
      if (el.offsetParent === null) continue;
      var key = el.className || '';
      if (seen[key]) continue;
      seen[key] = 1;
      var txt = (el.innerText || '').replace(/\s+/g,' ').slice(0, 200);
      if (txt) out.push({cls: key.slice(0,80), txt: txt});
    }
  }
  var cb = document.querySelector('input[type=checkbox]');
  return JSON.stringify({dialogs: out.slice(0,5), checkbox: cb ? !!cb.checked : null});
})();
"""


def get_tab(page):
    for t in page.get_tabs():
        if "mp.weixin.qq.com" in (t.url or "") and "token=" in (t.url or ""):
            return t
    return None


def main() -> None:
    stage = sys.argv[1] if len(sys.argv) > 1 else "recon"
    assert len(DESC) <= 200, f"版本描述超长: {len(DESC)}"
    page = attach_or_launch()
    tab = get_tab(page)
    if tab is None:
        print("NO_LOGGED_IN_TAB")
        sys.exit(1)
    token = re.search(r"token=(\d{8,})", tab.url or "").group(1)

    # 复用既有 getcodepage 标签（fill/submit 阶段向导在同一标签推进）
    ct = None
    for t in page.get_tabs():
        if "getcodepage" in (t.url or ""):
            ct = t
            break
    if ct is None:
        ct = page.new_tab(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={token}&lang=zh_CN")
        time.sleep(6)

    html = ct.html or ""
    if APPID not in html:
        print("APPID_MISMATCH（错号灾难防线）: 页面无", APPID)
        sys.exit(1)
    print("appid_ok; live_trial:", ct.run_js(JS_READ_TRIAL))

    if stage == "recon":
        print("row:", ct.run_js(JS_RECON_ROW))
        print("dlg:", ct.run_js(JS_DUMP_DIALOG))
        ct.get_screenshot(r"E:\AI-Station\WeAppForge\filing\review_0911_recon.png")
        print("RECON_DONE")
        return

    if stage == "open":
        r = ct.run_js(r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i]) === '""" + VER + r"""'){
      var row = els[i];
      for (var d=0; d<8 && row; d++){
        var btns = row.querySelectorAll('button.weui-desktop-btn_primary');
        if (btns.length){
          btns[0].scrollIntoView({block:'center'});
          btns[0].click();
          return 'submit-clicked@depth'+d;
        }
        row = row.parentElement;
      }
      return 'no-btn';
    }
  }
  return 'no-anchor';
})();
""")
        print("click:", r)
        time.sleep(4)
        print("dlg:", ct.run_js(JS_DUMP_DIALOG))
        ct.get_screenshot(r"E:\AI-Station\WeAppForge\filing\review_0911_open.png")
        return

    if stage == "step1":
        cb = ct.run_js("var cb=document.querySelector('input[type=checkbox]'); if(cb && !cb.checked){cb.click(); return 'clicked';} return cb ? ('already:'+cb.checked) : 'no-cb';")
        print("checkbox:", cb)
        time.sleep(1.5)
        chk = ct.run_js("var cb=document.querySelector('input[type=checkbox]'); return cb ? JSON.stringify({checked:cb.checked}) : 'no-cb';")
        print("checkbox_verify:", chk)
        r = ct.run_js(r"""
return (function(){
  var els = document.querySelectorAll('span, a, button');
  var hit = null;
  for (var i=0;i<els.length;i++){
    var el = els[i]; var own=false;
    for (var k=0;k<el.childNodes.length;k++){
      var n = el.childNodes[k];
      if (n.nodeType===3 && n.textContent.trim()==='下一步'){own=true;break;}
    }
    if (own){ var real = el.closest('button')||el.closest('a'); if (real && real.offsetParent!==null) hit = real; }
  }
  if (hit){ hit.scrollIntoView({block:'center'}); hit.click(); return 'next-clicked'; }
  return 'no-next';
})();
""")
        print("next:", r)
        time.sleep(3)
        print("dlg:", ct.run_js(JS_DUMP_DIALOG))
        ct.get_screenshot(r"E:\AI-Station\WeAppForge\filing\review_0911_step1.png")
        return

    if stage == "step2":
        r = ct.run_js(r"""
return (function(){
  var els = document.querySelectorAll('span, a, button');
  var hit = null;
  for (var i=0;i<els.length;i++){
    var el = els[i]; var own=false;
    for (var k=0;k<el.childNodes.length;k++){
      var n = el.childNodes[k];
      if (n.nodeType===3 && n.textContent.trim()==='继续提交'){own=true;break;}
    }
    if (own){ var real = el.closest('button')||el.closest('a'); if (real && real.offsetParent!==null) hit = real; }
  }
  if (hit){ hit.scrollIntoView({block:'center'}); hit.click(); return 'cont-clicked'; }
  return 'no-cont';
})();
""")
        print("cont:", r)
        time.sleep(5)
        url = ct.url or ""
        form = ct.run_js(r"""
return (function(){
  var tas = document.querySelectorAll('textarea');
  var out = [];
  for (var i=0;i<tas.length;i++){
    var el = tas[i];
    if (el.offsetParent === null) continue;
    out.push({ph: (el.getAttribute('placeholder')||'').slice(0,60), len: (el.value||'').length});
  }
  var radios = document.querySelectorAll('input[type=radio]');
  var rlabels = [];
  for (var j=0;j<radios.length;j++){
    if (radios[j].offsetParent === null) continue;
    var lb = radios[j].closest('label');
    rlabels.push({name: radios[j].name, val: radios[j].value, txt: lb ? (lb.innerText||'').replace(/\s+/g,'').slice(0,30) : '', checked: radios[j].checked});
  }
  return JSON.stringify({textareas: out, radios: rlabels.slice(0,20), urlHasGetClass: location.href.indexOf('get_class')>=0});
})();
""")
        print("url:", url[:120])
        print("form:", form)
        ct.get_screenshot(r"E:\AI-Station\WeAppForge\filing\review_0911_step2.png")
        return

    print("UNKNOWN_STAGE:", stage)
    sys.exit(1)


if __name__ == "__main__":
    main()
