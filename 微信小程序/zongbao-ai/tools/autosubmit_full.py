# -*- coding: utf-8 -*-
"""autosubmit_full.py — 小程序提审/放量全自动一条龙（常令：以后全自动提审）。
模式：
  py -3 -X utf8 tools/autosubmit_full.py submit   # 提审最新开发版本（全舞步+TRUTH）
  py -3 -X utf8 tools/autosubmit_full.py watch    # 轮询审核版本：过审→自动放量发布；驳回→企微报因
固化坑账：精确匹配防「提交审核时间」文本陷阱/原生CDP点击/舞步(插件含更新→确认/须知/安全测试提醒/继续提交)/modal可见性过滤/平台锁前置校验。"""
import sys, time, json, re
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")

def connect_and_token(wait_qr_seconds=0):
    page = ChromiumPage(addr_or_opts=opts)
    m = re.search(r"token=(\d+)", page.url or "")
    if not m:
        page.get("https://mp.weixin.qq.com/")
        for i in range(max(3, wait_qr_seconds // 3)):
            time.sleep(3)
            mm = re.search(r"token=(\d+)", page.url or "")
            if mm and "scanlogin" not in (page.url or ""): m = mm; break
    return page, (m.group(1) if m else None)

def read_blocks(page):
    return json.loads(page.run_js("return JSON.stringify(Array.from(document.querySelectorAll('.code_version_log')).map(function(b){return (b.innerText||'').split(String.fromCharCode(10)).join(' ')}).slice(0,3))") or "[]")

def go_version_page(page, tok):
    page.run_js("location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token=" + tok + "&lang=zh_CN'")
    time.sleep(12)
    for tid in list(page.browser.tab_ids)[1:]:
        try: page.browser.get_tab(tid).close()
        except Exception: pass
    time.sleep(1)
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if "getcodepage" in (t.url or ""): return t
    return page

mode = sys.argv[1] if len(sys.argv) > 1 else "watch"

if mode == "watch":
    page, tok = connect_and_token()
    if not tok: print("LOGIN_DEAD"); sys.exit(1)
    t = go_version_page(page, tok)
    blocks = read_blocks(t)
    online = next((b for b in blocks if b.startswith("版本号") and "发布时间" in b), "")
    audit = ""
    for b in blocks:
        if "审核中" in b or "审核不通过" in b: audit = b; break
    if "审核中" in audit:
        print("AUDITING " + audit[:80]); sys.exit(0)
    if "审核不通过" in audit:
        print("AUDIT_REJECT " + audit[:150]); sys.exit(2)
    # 无审核版本：检查最新开发版本是否已=线上版本（过审后开发版本转正即需放量? 线上块看版本号）
    # 微信过审后需手动「发布」：查审核版本区的「发布」按钮
    r = t.run_js("""return (function(){
      var bs = document.querySelectorAll('button, a, .weui-desktop-btn');
      for (var i = 0; i < bs.length; i++) {
        var txt = (bs[i].innerText || '').trim();
        var rr = bs[i].getBoundingClientRect();
        if ((txt === '发布' || txt === '全量发布' || txt === '提交发布') && rr.width > 0) { bs[i].click(); return 'RELEASE_CLICKED'; }
      }
      return 'NO_RELEASE_BTN';
    })()""")
    print("[release]", r)
    time.sleep(5)
    c = t.run_js("""return (function(){
      var mods = document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
      for (var i = 0; i < mods.length; i++) {
        var rr = mods[i].getBoundingClientRect();
        if (rr.width <= 0) continue;
        var bs = mods[i].querySelectorAll('button');
        for (var b = 0; b < bs.length; b++) {
          var txt = (bs[b].innerText || '').trim();
          if (txt === '发布' || txt === '确定') { bs[b].click(); return 'CONFIRMED:' + txt; }
        }
      }
      return 'NO_CONFIRM';
    })()""")
    print("[release-confirm]", c)
    time.sleep(8)
    t.run_js("location.reload()"); time.sleep(10)
    for line in read_blocks(t): print("[TRUTH]", line[:200])
    sys.exit(0)

# ── submit 模式：提审最新开发版本 ──
page, tok = connect_and_token(wait_qr_seconds=600)
if not tok: print("LOGIN_TIMEOUT"); sys.exit(1)
print("[1] token=", tok)
t = go_version_page(page, tok)
body = t.run_js("return (document.body.innerText||'').replace(/[\\s]+/g,' ')") or ""
if re.search(r"审核版本[^开]{0,60}\d\.\d\.\d 审核中", body) or " 审核中 " in body.split("开发版本")[0]:
    print("[SKIP] 已有审核中版本——平台锁，改跑 watch 模式"); sys.exit(0)

hit = None
for b in t.eles('tag:button'):
    try:
        if (b.text or '').strip() == '提交审核' and b.rect.location[1] > 0: hit = b; break
    except Exception: pass
if not hit: print("[E] 无可见提交审核钮"); sys.exit(2)
hit.click()
print("[3] 原生点击 ok"); time.sleep(8)

def get_gt():
    for tid in page.browser.tab_ids:
        tt = page.browser.get_tab(tid)
        if "getcodepage" in (tt.url or ""): return tt
    return t

def vis():
    tt = get_gt()
    return tt.run_js("""return JSON.stringify((function(){
  var out = [];
  var mods = document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i = 0; i < mods.length; i++) {
    var r = mods[i].getBoundingClientRect();
    if (r.width <= 0) continue;
    var txt = (mods[i].innerText || '').replace(/\\s+/g, ' ').trim();
    if (!txt) continue;
    var bs = mods[i].querySelectorAll('button');
    var bl = [];
    for (var b = 0; b < bs.length; b++) { var x = (bs[b].innerText || '').trim(); if (x) bl.push(x); }
    out.push({txt: txt.slice(0, 90), btns: bl});
  }
  return out;
})())""")

def native_click(label):
    tt = get_gt()
    for e in tt.eles('tag:button'):
        try:
            if (e.text or '').strip() == label and e.rect.location[1] > 0: e.click(); return 'OK:' + label
        except Exception: pass
    return 'NO'

def js_click_visible(label):
    """JS 兜底：可见 modal 内精确点（原生点击幽灵时的第二保险）。"""
    tt = get_gt()
    return tt.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var r=mods[i].getBoundingClientRect();if(r.width<=0)continue;var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='" + label + "'){bs[b].click();return 'JS';}}}return 'NO';})()")

_stuck = {}
def smart_click(kw, label):
    """原生优先；同框连点 8 轮未消失 → JS click 兜底。"""
    key = kw or label
    acted = native_click(label)
    _stuck[key] = _stuck.get(key, 0) + 1
    if _stuck[key] >= 8:
        _stuck[key] = 0
        return js_click_visible(label)
    return acted

FORM = None
for tick in range(300):
    time.sleep(1.5)
    for tid in page.browser.tab_ids:
        t2 = page.browser.get_tab(tid)
        if "get_class" in (t2.url or ""): FORM = t2; break
    if FORM: print(f"[{tick}s] FORM OPEN"); break
    try: ms = json.loads(vis() or "[]")
    except Exception: ms = []
    if not ms: continue
    m0 = ms[0]; head = m0["txt"]; btns = str(m0["btns"])
    acted = "-"
    if "插件" in head and "确认" in btns: acted = smart_click("插件", "确认")
    elif "须知" in head and "下一步" in btns:
        acted = get_gt().run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var r=mods[i].getBoundingClientRect();if(r.width<=0)continue;var txt=mods[i].innerText||'';if(txt.indexOf('须知')<0)continue;var cb=mods[i].querySelector('input[type=checkbox]');if(cb&&!cb.checked)cb.click();var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='下一步'){bs[b].click();return 'NOTICE_CB_NEXT';}}}return 'NO';})()")
    elif "继续提交" in btns: acted = smart_click("继续", "继续提交")
    elif "删除" in head and "取消" in btns: acted = smart_click("删除", "取消")
    print(f"[{tick}s] {head[:50]} | {btns[:36]} → {acted}")
if not FORM: print("[!] FORM 未达"); sys.exit(3)

time.sleep(3)
DESC = ("功能优化与体验升级：内容浏览视图更丰富，资料来源更广，生成更稳定。"
        "知识库定制服务，支付走微信支付（安卓），iOS 隐藏付费入口。")
dj = json.dumps(DESC, ensure_ascii=False)
FORM.run_js('return (function(){var ta=document.querySelector("textarea");if(!ta)return "NO_TA";ta.value=' + dj + ';ta.dispatchEvent(new Event("input",{bubbles:true}));return "FILLED";})()')
time.sleep(2)
FORM.run_js("return (function(){var els=document.querySelectorAll('button,a.btn_primary,.weui-desktop-btn_primary');for(var i=0;i<els.length;i++){var t=(els[i].innerText||'').trim();var r=els[i].getBoundingClientRect();if(t==='提交审核'&&r.width>0){els[i].click();return 'SUBMITTED';}}return 'NO';})()")
print("[6] form submit js"); time.sleep(4)
for tk in range(90):
    time.sleep(1)
    c = FORM.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.dialog,.modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){var t=(bs[b].innerText||'').trim();if(t==='确定，继续提交'||t==='确定，继续提交审核'){bs[b].click();return 'FINAL';}}}return '';})()")
    if c: print(f"[7] {tk}s {c}"); break
time.sleep(10)
gt = get_gt()
gt.run_js("location.reload()"); time.sleep(10)
for line in read_blocks(gt): print("[TRUTH]", line[:220])
print("[done]")