# -*- coding: utf-8 -*-
"""submit_v140_r2.py — v1.4.0 提审修复版：侦察→原生click→舞步(常令插件自点)→TRUTH。
今晚教训内化：①JS 全部原生 click()（dispatchEvent 对新版控制台不稳）②舞步循环里
删除框原生点取消 ③JS 无反斜杠无花括号拼接（文件法写入零转义）。"""
import sys, time, re, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

DESC = ("知识库蓝图升级：新增深度三档（标准/专业/旗舰）供选择；文件清单接入更多公开行业资料源"
        "（研报/工程统计/范本）；云端实时生成，网络不佳时自动降级本地演示。"
        "知识库定制服务，支付走微信支付（安卓），iOS 隐藏付费入口。")

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)

# ── 0. 登录态（应已活）──
u = page.url or ""
m = re.search(r"token=(\d+)", u)
if not m:
    page.get("https://mp.weixin.qq.com/")
    for i in range(200):
        time.sleep(3)
        mm = re.search(r"token=(\d+)", page.url or "")
        if mm and "scanlogin" not in (page.url or ""):
            m = mm; break
    if not m:
        print("LOGIN_TIMEOUT"); sys.exit(1)
tok = m.group(1)
print(f"[1] token={tok}")

# ── 1. 直跳版本管理（10s ContextLost 缓冲）──
page.run_js("location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token=" + tok + "&lang=zh_CN'")
time.sleep(12)

def get_tab_by(kw):
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if kw in (t.url or ""):
            return t
    return None

gt = get_tab_by("getcodepage") or page

# ── 2. 侦察 1.4.0 行按钮（真相版，先看后点）──
RECON = """return (function(){
  var els = document.querySelectorAll('*');
  for (var i = 0; i < els.length; i++) {
    var own = Array.prototype.filter.call(els[i].childNodes || [], function(n){
      return n.nodeType === 3;
    }).map(function(n){ return n.nodeValue.trim(); }).join(' ');
    if (own === '1.4.0') {
      var row = els[i];
      for (var d = 0; d < 14 && row; d++) {
        var it = row.innerText || '';
        if (it.indexOf('提交审核') >= 0 && it.indexOf('1.4.0') >= 0) {
          var btns = row.querySelectorAll('button');
          var out = [];
          for (var bi = 0; bi < btns.length; bi++) {
            var t2 = (btns[bi].innerText || '').trim();
            if (t2) out.push(t2 + ' :: ' + (btns[bi].className || '').slice(0, 45));
          }
          return 'depth=' + d + ' | ' + out.join('  |  ');
        }
      }
      row = row.parentElement;
    }
  }
  return 'ROW_NOT_FOUND';
})()"""
recon = gt.run_js(RECON)
print(f"[2] 侦察: {str(recon)[:400]}")

# ── 3. 原生 click「提交审核」──
CLICK = """return (function(){
  var els = document.querySelectorAll('*');
  for (var i = 0; i < els.length; i++) {
    var own = Array.prototype.filter.call(els[i].childNodes || [], function(n){
      return n.nodeType === 3;
    }).map(function(n){ return n.nodeValue.trim(); }).join(' ');
    if (own === '1.4.0') {
      var row = els[i];
      for (var d = 0; d < 14 && row; d++) {
        var it = row.innerText || '';
        if (it.indexOf('提交审核') >= 0 && it.indexOf('1.4.0') >= 0) {
          var btns = row.querySelectorAll('button');
          for (var bi = 0; bi < btns.length; bi++) {
            if ((btns[bi].innerText || '').trim() === '提交审核') {
              btns[bi].click();
              return 'CLICKED_NATIVE';
            }
          }
          return 'BTN_NOT_IN_ROW';
        }
      }
      row = row.parentElement;
    }
  }
  return 'NOT_FOUND';
})()"""
r = gt.run_js(CLICK)
print(f"[3] 提交审核(原生): {r}")
if "CLICKED" not in str(r):
    sys.exit(3)
time.sleep(8)

# ── 4. 舞步循环（原生click；插件含更新自动点=常令）──
def dlg_snapshot(t):
    return t.run_js("""return (function(){
  var mods = document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i = 0; i < mods.length; i++) {
    var txt = (mods[i].innerText || '').replace(/\\s+/g, ' ').trim();
    if (!txt || txt.length < 5) continue;
    var btns = mods[i].querySelectorAll('button');
    var bl = [];
    for (var b = 0; b < btns.length; b++) { var t = (btns[b].innerText || '').trim(); if (t) bl.push(t); }
    if (bl.length) return txt.slice(0, 55) + '||' + bl.join(',');
  }
  return '';
})()""")

def dlg_native_click(t, label, head_kw=None):
    return t.run_js("""return (function(){
  var mods = document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i = 0; i < mods.length; i++) {
    var txt = mods[i].innerText || '';
    if (arguments[1] && txt.indexOf(arguments[1]) < 0) continue;
    var bs = mods[i].querySelectorAll('button');
    for (var b = 0; b < bs.length; b++) {
      if ((bs[b].innerText || '').trim() === arguments[0]) { bs[b].click(); return 'CLICKED'; }
    }
  }
  return 'NO_BTN';
})()""", label, head_kw or "")

def notice_step(t):
    return t.run_js("""return (function(){
  var mods = document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i = 0; i < mods.length; i++) {
    var txt = mods[i].innerText || '';
    if (txt.indexOf('须知') < 0) continue;
    var cb = mods[i].querySelector('input[type=checkbox]');
    if (cb && !cb.checked) cb.click();
    var bs = mods[i].querySelectorAll('button');
    for (var b = 0; b < bs.length; b++) {
      if ((bs[b].innerText || '').trim() === '下一步') { bs[b].click(); return 'NOTICE_NEXT'; }
    }
  }
  return '';
})()""")

FORM_DONE = False
for tick in range(600):
    time.sleep(1)
    # 表单页扫描
    try:
        for tid in page.browser.tab_ids:
            t = page.browser.get_tab(tid)
            if "get_class" in (t.url or ""):
                print(f"[5] FORM @{tick}s")
                time.sleep(3)
                dj = json.dumps(DESC, ensure_ascii=False)
                t.run_js('return (function(){var ta=document.querySelector("textarea");if(!ta)return "NO_TA";ta.value=' + dj + ';ta.dispatchEvent(new Event("input",{bubbles:true}));return "FILLED";})()')
                time.sleep(2)
                t.run_js("""return (function(){
  var els = document.querySelectorAll('button, a.btn_primary, .weui-desktop-btn_primary');
  for (var i = 0; i < els.length; i++) {
    var t = (els[i].innerText || '').trim();
    if (t === '提交审核') { els[i].click(); return 'SUBMITTED'; }
  }
  return 'NO_SUBMIT_BTN';
})()""")
                print("[6] form submit")
                time.sleep(3)
                for tk in range(90):
                    time.sleep(1)
                    c = t.run_js("""return (function(){
  var mods = document.querySelectorAll('.weui-desktop-dialog, .dialog, .modal');
  for (var i = 0; i < mods.length; i++) {
    var bs = mods[i].querySelectorAll('button');
    for (var b = 0; b < bs.length; b++) {
      var t = (bs[b].innerText || '').trim();
      if (t === '确定，继续提交' || t === '确定，继续提交审核') { bs[b].click(); return 'FINAL'; }
    }
  }
  return '';
})()""")
                    if c:
                        print(f"[7] {tk}s {c}"); break
                FORM_DONE = True
                break
    except Exception:
        pass
    if FORM_DONE:
        break

    try:
        s = dlg_snapshot(gt)
    except Exception:
        s = ""
    if not s:
        continue
    head, _, btns_s = s.partition("||")
    print(f"  [{tick}s] dlg: {head[:50]} | {btns_s}")
    if "插件" in head and "确认" in btns_s:
        print(f"  [{tick}s] 插件(含更新)→确认: {dlg_native_click(gt, '确认', '插件')}")
    elif "须知" in head:
        print(f"  [{tick}s] 须知: {notice_step(gt)}")
    elif "继续提交" in btns_s:
        print(f"  [{tick}s] 继续提交: {dlg_native_click(gt, '继续提交')}")
    elif "删除" in head and "取消" in btns_s:
        print(f"  [{tick}s] 删除框→取消: {dlg_native_click(gt, '取消', '删除')}")
    elif "撤回" in head and "取消" in btns_s:
        print(f"  [{tick}s] 撤回框→取消: {dlg_native_click(gt, '取消', '撤回')}")
    time.sleep(1)

if not FORM_DONE:
    print("[!] 表单页未达（600s）")
    sys.exit(4)

# ── 8. TRUTH ──
time.sleep(10)
gt = get_tab_by("getcodepage")
if gt:
    gt.run_js("location.reload()")
    time.sleep(10)
    blocks = gt.run_js("return JSON.stringify(Array.from(document.querySelectorAll('.code_version_log')).map(function(b){return (b.innerText||'').split(String.fromCharCode(10)).join(' ')}).slice(0,3))")
    for line in json.loads(blocks or "[]"):
        print("[8] TRUTH:", line[:220])
print("[done]")