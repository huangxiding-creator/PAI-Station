# -*- coding: utf-8 -*-
"""submit_v150.py — v1.5.0 提审件（撤1.4.0→提1.5.0）。三次教训内化：
①run_js 参数注入(arguments)不生效→全部纯字符串拼接字面量
②modal 快照必须过滤可见性(rect.width>0)，模板框不可混入
③插件确认框可能层叠多个，循环逐个消。
链路：插件确认→(须知已过)→表单tab→DESC→提交审核→终审确定→TRUTH。"""
import sys, time, re, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

DESC = ("知识库工厂升级：蓝图新增三种浏览视图与导览索引层，接入更多公开行业资料源，"
        "支持生成可预览站点与交付清单；本地生成体验优化。"
        "知识库定制服务，支付走微信支付（安卓），iOS 隐藏付费入口。")

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)

def js_click_modal(kw, label):
    s = ("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');"
         "for(var i=0;i<mods.length;i++){var r=mods[i].getBoundingClientRect();if(r.width<=0)continue;"
         "var txt=mods[i].innerText||'';if('" + kw + "'&&txt.indexOf('" + kw + "')<0)continue;"
         "var bs=mods[i].querySelectorAll('button');"
         "for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='" + label + "'){bs[b].click();return 'OK';}}}"
         "return 'NO';})()")
    return page.run_js(s)

def js_vis_modals():
    s = ("return JSON.stringify((function(){var out=[];"
         "var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');"
         "for(var i=0;i<mods.length;i++){var r=mods[i].getBoundingClientRect();if(r.width<=0)continue;"
         "var txt=(mods[i].innerText||'').replace(/\\s+/g,' ').trim();if(!txt)continue;"
         "var bs=mods[i].querySelectorAll('button');var bl=[];"
         "for(var b=0;b<bs.length;b++){var t=(bs[b].innerText||'').trim();if(t)bl.push(t);}"
         "out.push({txt:txt.slice(0,90),btns:bl});}return out;})())")
    try:
        return json.loads(page.run_js(s) or "[]")
    except Exception:
        return []

def js_notice_next():
    s = ("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');"
         "for(var i=0;i<mods.length;i++){var r=mods[i].getBoundingClientRect();if(r.width<=0)continue;"
         "var txt=mods[i].innerText||'';if(txt.indexOf('须知')<0)continue;"
         "var cb=mods[i].querySelector('input[type=checkbox]');if(cb&&!cb.checked)cb.click();"
         "var bs=mods[i].querySelectorAll('button');"
         "for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='下一步'){bs[b].click();return 'NOTICE_NEXT';}}}"
         "return 'NO';})()")
    return page.run_js(s)

def find_tab(kw):
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if kw in (t.url or ""):
            return t
    return None


# ── 撤回 1.4.0 审核中版本（如有）──
r0 = page.run_js("""return (function(){
  var blocks = document.querySelectorAll('.code_version_log, .weui-desktop-card');
  for (var b = 0; b < blocks.length; b++) {
    var txt = (blocks[b].innerText || '').replace(/\s+/g, ' ');
    if (txt.indexOf('1.4.0') >= 0 && txt.indexOf('审核中') >= 0) {
      var btns = blocks[b].querySelectorAll('button');
      for (var i = 0; i < btns.length; i++) {
        var t = (btns[i].innerText || '').trim();
        if (t === '撤回' || t === '撤销审核') { btns[i].click(); return 'WITHDRAW_OPENED'; }
      }
      return 'AUDITING_NO_BTN:' + txt.slice(0, 50);
    }
  }
  return 'NO_OLD_AUDITING';
})()""")
print(f"[2] 撤回1.4.0: {r0}")
if "WITHDRAW_OPENED" in str(r0):
    time.sleep(3)
    page.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='确定'){bs[b].click();return 'CONFIRMED';}}}return 'NO_CONFIRM_BTN';})()")
    time.sleep(8)
    page.run_js("location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token=" + tok + "&lang=zh_CN'")
    time.sleep(12)

# ── 舞步主循环：插件确认(层叠逐消)→须知→继续提交→删除取消 + 表单tab并行 ──
FORM = None
for tick in range(400):
    time.sleep(1.5)
    FORM = find_tab("get_class")
    if FORM:
        print(f"[{tick}s] FORM TAB OPEN"); break
    ms = js_vis_modals()
    if not ms:
        if tick % 20 == 0:
            print(f"[{tick}s] 无可见框（等待流程推进）")
        continue
    m = ms[0]
    head = m["txt"]; btns = str(m["btns"])
    acted = "-"
    if "插件" in head and "确认" in btns:
        acted = js_click_modal("插件", "确认")
    elif "须知" in head and "下一步" in btns:
        acted = js_notice_next()
    elif "继续提交" in btns:
        acted = js_click_modal("", "继续提交")
    elif "删除" in head and "取消" in btns:
        acted = js_click_modal("删除", "取消")
    print(f"[{tick}s] {head[:52]} | {btns[:36]} → {acted}")

if not FORM:
    print("[!] 表单页 400s 未达"); sys.exit(4)

# ── 表单页：DESC + 提交 ──
time.sleep(3)
dj = json.dumps(DESC, ensure_ascii=False)
r = FORM.run_js('return (function(){var ta=document.querySelector("textarea");if(!ta)return "NO_TA";'
                'ta.value=' + dj + ';ta.dispatchEvent(new Event("input",{bubbles:true}));return "FILLED";})()')
print("[form-desc]", r)
time.sleep(2)
r = FORM.run_js("return (function(){var els=document.querySelectorAll('button,a.btn_primary,.weui-desktop-btn_primary');"
                "for(var i=0;i<els.length;i++){var t=(els[i].innerText||'').trim();"
                "var r=els[i].getBoundingClientRect();"
                "if(t==='提交审核'&&r.width>0){els[i].click();return 'SUBMITTED';}}return 'NO_BTN';})()")
print("[form-submit]", r)
time.sleep(4)

# ── 终审弹窗 ──
for tk in range(90):
    time.sleep(1)
    c = FORM.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.dialog,.modal');"
                    "for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button');"
                    "for(var b=0;b<bs.length;b++){var t=(bs[b].innerText||'').trim();"
                    "if(t==='确定，继续提交'||t==='确定，继续提交审核'){bs[b].click();return 'FINAL';}}}"
                    "return '';})()")
    if c:
        print(f"[final] {tk}s {c}"); break
    # 兜底：弹其他框（如再次插件）
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if "getcodepage" in (t.url or ""):
            ms2 = js_vis_modals()
            if ms2:
                m2 = ms2[0]
                if "插件" in m2["txt"]:
                    print(f"  [final-{tk}s] 插件框再现→确认: {js_click_modal('插件', '确认')}")
            break

# ── TRUTH ──
time.sleep(10)
gt = find_tab("getcodepage")
if gt:
    gt.run_js("location.reload()"); time.sleep(10)
    blocks = gt.run_js("return JSON.stringify(Array.from(document.querySelectorAll('.code_version_log'))"
                       ".map(function(b){return (b.innerText||'').split(String.fromCharCode(10)).join(' ')}).slice(0,3))")
    for line in json.loads(blocks or "[]"):
        print("[TRUTH]", line[:230])
print("[done]")