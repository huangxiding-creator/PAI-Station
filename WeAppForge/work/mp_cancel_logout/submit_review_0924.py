# -*- coding: utf-8 -*-
"""submit_review_0924.py — 0.9.24 提审向导驱动（9336 通道，分阶段状态机；蓝本 0915）。

用法: python submit_review_0915.py <stage>
  recon   只读侦察：appid 体检 + 0.9.24 开发版行 + 提交审核按钮在位（零点击）
  open    点「提交审核」进向导 → 第1步须知弹窗（不勾不点）
  step1   勾须知 checkbox + 点「下一步」
  step2   点「继续提交」→ 主表单整页 dump（不填）
  fill    填版本描述 + 单选三件（绝不勾加急）→ 停在提交键前（dump+截图取证）
  submit  点提交键 → 终验 getcodepage 0.9.24 行「审核中」+ 截图存档

红线（沿用 0912/0914）：不加急；只提交一次；fill 先跑验证 dump 再放 submit。
1011 侦察前置已满足：线上版本=0.9.14（1010 16:29 已发布），审核队列空，无需撤审。
"""
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

VER = "0.9.24"
APPID = "wx5cee1574ce45819b"
DESC = ("工程行业AI问答工具。本次更新：研究报告详情页免费体验升级——免费问报告"
        "每日6问、免费试读入口前置、解锁后无限问；问答答案引用报告章节原文。"
        "所有AI生成内容均有显著标识（含导出海报），接内容安全检测并提供举报入口。"
        "仅收集微信openid与提问内容，无需测试账号。")

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
          return JSON.stringify({depth:d, rowText:t.slice(0,180).replace(/\n/g,'|'),
            submitBtn: btn ? (btn.className + '|' + (btn.innerText||'').trim()) : null});
        }
        row = row.parentElement;
      }
      return JSON.stringify({depth:-1, err:'no-row-with-submit'});
    }
  }
  return JSON.stringify({err:'no-anchor'});
})();
"""

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

JS_FORM_DUMP = r"""
return (function(){
  var tas = document.querySelectorAll('textarea');
  var out = [];
  for (var i=0;i<tas.length;i++){
    var el = tas[i];
    if (el.offsetParent === null) continue;
    out.push({idx:i, ph: (el.getAttribute('placeholder')||'').slice(0,60), len: (el.value||'').length, head: (el.value||'').slice(0,30)});
  }
  var radios = document.querySelectorAll('input[type=radio]');
  var rlabels = [];
  for (var j=0;j<radios.length;j++){
    if (radios[j].offsetParent === null) continue;
    var lb = radios[j].closest('label');
    rlabels.push({idx:j, name: radios[j].name, val: radios[j].value,
      txt: lb ? (lb.innerText||'').replace(/\s+/g,'').slice(0,30) : '', checked: radios[j].checked});
  }
  return JSON.stringify({textareas: out, radios: rlabels.slice(0,24)});
})();
"""


def get_live_tab(page):
    """取活会话 getcodepage 标签（html 含 wx5cee 且非登录超时态）。"""
    for t in page.get_tabs():
        u = t.url or ""
        if "getcodepage" in u:
            try:
                html = t.html or ""
                body = t.run_js("return (document.body.innerText||'').slice(0,200);") or ""
                if APPID in html and "重新登录" not in body:
                    return t
            except Exception:
                continue
    return None


def main() -> None:
    stage = sys.argv[1] if len(sys.argv) > 1 else "recon"
    assert len(DESC) <= 200, f"版本描述超长: {len(DESC)}"
    print(f"[DESC len={len(DESC)}] {DESC}")
    page = attach_or_launch()
    ct = get_live_tab(page)
    if ct is None:
        print("NO_LIVE_GETCODEPAGE_TAB（先跑 recon_0915.py 开标签）")
        sys.exit(1)

    html = ct.html or ""
    if APPID not in html:
        print("APPID_MISMATCH（错号灾难防线）: 页面无", APPID)
        sys.exit(1)
    print("appid_ok; url:", (ct.url or "")[:100])

    if stage == "recon":
        print("row:", ct.run_js(JS_RECON_ROW))
        print("dlg:", ct.run_js(JS_DUMP_DIALOG))
        ct.get_screenshot(r"E:\AI-Station\WeAppForge\filing\review_0915_recon.png")
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
        ct.get_screenshot(r"E:\AI-Station\WeAppForge\filing\review_0915_open.png")
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
        ct.get_screenshot(r"E:\AI-Station\WeAppForge\filing\review_0915_step1.png")
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
        print("url:", (ct.url or "")[:120])
        print("form:", ct.run_js(JS_FORM_DUMP))
        ct.get_screenshot(r"E:\AI-Station\WeAppForge\filing\review_0915_step2.png")
        return

    if stage == "fill":
        gc = None
        for t in page.get_tabs():
            if "get_class" in (t.url or ""):
                gc = t
                break
        target = gc if gc is not None else ct
        print("form_tab:", (target.url or "")[:100])
        print("pre_form:", target.run_js(JS_FORM_DUMP))
        r = target.run_js(r"""
return (function(){
  var DESC = """ + repr(DESC).replace("'", '"', 2)[::1] + r""";
  var tas = Array.prototype.filter.call(document.querySelectorAll('textarea'), function(el){return el.offsetParent !== null;});
  if (!tas.length) return JSON.stringify({err:'no-textarea'});
  var ta = null;
  for (var i=0;i<tas.length;i++){
    var ph = tas[i].getAttribute('placeholder')||'';
    if (ph.indexOf('版本描述')>=0 || ph.indexOf('描述')>=0){ ta = tas[i]; break; }
  }
  if (!ta) ta = tas[0];
  var setter = Object.getOwnPropertyDescriptor(window.HTMLTextAreaElement.prototype, 'value').set;
  setter.call(ta, DESC);
  ta.dispatchEvent(new Event('input', {bubbles:true}));
  ta.dispatchEvent(new Event('change', {bubbles:true}));
  var radios = document.querySelectorAll('input[type=radio]');
  var clicked = [];
  for (var j=0;j<radios.length;j++){
    var rd = radios[j];
    if (rd.offsetParent === null || rd.checked) continue;
    var lb = rd.closest('label');
    var txt = lb ? (lb.innerText||'').replace(/\s+/g,'') : '';
    if (!txt) continue;
    var want = (txt.indexOf('无需')>=0 && txt.indexOf('测试')>=0)
             || (txt.indexOf('不使用')>=0 && txt.indexOf('企业微信')>=0)
             || txt === '否'
             || (txt.indexOf('采集')>=0 && txt.indexOf('用户隐私')>=0 && txt.indexOf('不')<0);
    if (want){ rd.scrollIntoView({block:'center'}); rd.click(); clicked.push(txt.slice(0,20)); }
  }
  return JSON.stringify({desc_len: ta.value.length, desc_head: ta.value.slice(0,24), clicked: clicked});
})();
""")
        print("fill:", r)
        time.sleep(1.5)
        print("post_form:", target.run_js(JS_FORM_DUMP))
        target.get_screenshot(r"E:\AI-Station\WeAppForge\filing\review_0915_fill.png")
        print("FILL_DONE（人工/断言核 dump 后再跑 submit）")
        return

    if stage == "submit":
        gc = None
        for t in page.get_tabs():
            if "get_class" in (t.url or ""):
                gc = t
                break
        target = gc if gc is not None else ct
        chk = target.run_js(JS_FORM_DUMP)
        print("pre_submit_form:", chk)
        r = target.run_js(r"""
return (function(){
  var els = document.querySelectorAll('button');
  for (var i=0;i<els.length;i++){
    var b = els[i];
    var txt = (b.innerText||'').trim();
    if (txt === '提交审核' && b.offsetParent !== null && !b.disabled){
      b.scrollIntoView({block:'center'}); b.click(); return 'submit-clicked';
    }
  }
  return 'no-submit-btn';
})();
""")
        print("submit:", r)
        time.sleep(6)
        print("dlg_after:", target.run_js(JS_DUMP_DIALOG))
        cr = target.run_js(r"""
return (function(){
  var els = document.querySelectorAll('button, a, span');
  for (var i=0;i<els.length;i++){
    var el = els[i];
    var txt = (el.innerText||'').trim();
    if (txt === '确定' && el.offsetParent !== null){
      var real = el.closest('button')||el.closest('a')||el;
      real.click(); return 'ok-clicked:' + real.tagName;
    }
  }
  return 'no-confirm';
})();
""")
        print("confirm:", cr)
        time.sleep(3)
        ct.run_js("location.reload();")
        time.sleep(8)
        v = ct.run_js(r"""
return (function(){
  var body = document.body.innerText || '';
  var out = {ver_row_has_reviewing: false};
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    var el = els[i]; var own=false;
    for (var k=0;k<el.childNodes.length;k++){
      var n = el.childNodes[k];
      if (n.nodeType===3 && n.textContent.trim()==='""" + VER + r"""'){own=true;break;}
    }
    if (own){
      var node = el;
      for (var d=0; d<8 && node; d++){
        node = node.parentElement;
        if (!node) break;
        var t2 = node.innerText||'';
        if (t2.length>20 && t2.length<600 && t2.indexOf('""" + VER + r"""')>=0){
          out.row = t2.replace(/\n/g,'|').slice(0,220);
          out.ver_row_has_reviewing = t2.indexOf('审核中')>=0;
          return JSON.stringify(out);
        }
      }
    }
  }
  return JSON.stringify(out);
})();
""")
        print("version_row:", v)
        ct.get_screenshot(r"E:\AI-Station\WeAppForge\filing\review_0915_submitted.png")
        print("SUBMIT_DONE")
        return

    print("UNKNOWN_STAGE:", stage)
    sys.exit(1)


if __name__ == "__main__":
    main()
