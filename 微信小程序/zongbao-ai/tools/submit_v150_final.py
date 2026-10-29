# -*- coding: utf-8 -*-
"""submit_v150_final.py — 1.5.0 提审接力件（值守触发：1.4.0 出结果后跑）。
今日全坑固化：①精确匹配 tag:button+text=='提交审核'（防「提交审核时间」文本陷阱）
②原生 CDP 点击（run_js btn.click() 对 React 间歇失效）③舞步=插件确认→须知→
安全测试提醒→继续提交 ④modal 可见性过滤 ⑤DESC 直填 ⑥TRUTH。"""
import sys, time, json, re
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

DESC = ("知识库工厂升级：蓝图新增三种浏览视图与导览索引层，接入更多公开行业资料源，"
        "支持生成可预览站点与交付清单；本地生成体验优化。"
        "知识库定制服务，支付走微信支付（安卓），iOS 隐藏付费入口。")

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)

def get_gt():
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if "getcodepage" in (t.url or ""): return t
    return None

# 登录态
tok = ""
m = re.search(r"token=(\d+)", page.url or "")
if not m:
    page.get("https://mp.weixin.qq.com/")
    for i in range(120):
        time.sleep(3)
        mm = re.search(r"token=(\d+)", page.url or "")
        if mm and "scanlogin" not in (page.url or ""): m = mm; break
    if not m: print("LOGIN_TIMEOUT"); sys.exit(1)
tok = m.group(1)
print("[1] token=", tok)
page.run_js("location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token=" + tok + "&lang=zh_CN'")
time.sleep(12)

# 前置校验：审核版本区必须空（1.4.0 已出结果）
body = page.run_js("return (document.body.innerText||'').replace(/[\\s]+/g,' ')") or ""
if re.search(r"审核版本[^开]{0,40}1\.4\.0 审核中", body) or "1.4.0 审核中" in body:
    print("[SKIP] 1.4.0 仍在审核中——平台锁未开，值守下轮再来"); sys.exit(0)

# 关陈旧同名 tab 只留一
ids = list(page.browser.tab_ids)
for tid in ids[1:]:
    try: page.browser.get_tab(tid).close()
    except Exception: pass
time.sleep(1)
t = get_gt() or page.browser.get_tab(list(page.browser.tab_ids)[0])

# 原生点击 1.5.0 提交审核（精确）
hit = None
for b in t.eles('tag:button'):
    try:
        if (b.text or '').strip() == '提交审核' and b.rect.location[1] > 0: hit = b; break
    except Exception: pass
if not hit: print("[E] 无可见提交审核钮"); sys.exit(2)
hit.click()
print("[3] 原生点击 ok")
time.sleep(8)

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

def native_click_text(kw, label):
    tt = get_gt()
    for e in tt.eles('tag:button'):
        try:
            txt = (e.text or '').strip()
            y = e.rect.location[1]
            if txt == label and y > 0:
                e.click(); return 'OK:' + label
        except Exception: pass
    return 'NO'

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
    if "插件" in head and "确认" in btns: acted = native_click_text("插件", "确认")
    elif "须知" in head and "下一步" in btns: acted = native_click_text("须知", "下一步")
    elif "安全测试" in head and "继续提交" in btns: acted = native_click_text("安全测试", "继续提交")
    elif "继续提交" in btns: acted = native_click_text("", "继续提交")
    elif "删除" in head and "取消" in btns: acted = native_click_text("删除", "取消")
    print(f"[{tick}s] {head[:50]} | {btns[:36]} → {acted}")
if not FORM: print("[!] FORM 未达"); sys.exit(3)

time.sleep(3)
dj = json.dumps(DESC, ensure_ascii=False)
FORM.run_js('return (function(){var ta=document.querySelector("textarea");if(!ta)return "NO_TA";ta.value=' + dj + ';ta.dispatchEvent(new Event("input",{bubbles:true}));return "FILLED";})()')
time.sleep(2)
sub = None
for e in FORM.eles('tag:button'):
    try:
        if (e.text or '').strip() == '提交审核' and e.rect.location[1] > 0: sub = e; break
    except Exception: pass
if sub: sub.click()
print("[6] form submit native")
time.sleep(3)
for tk in range(90):
    time.sleep(1)
    fin = None
    for e in FORM.eles('tag:button'):
        try:
            txt = (e.text or '').strip()
            if txt in ('确定，继续提交', '确定，继续提交审核') and e.rect.location[1] > 0: fin = e; break
        except Exception: pass
    if fin: fin.click(); print(f"[7] {tk}s FINAL"); break
time.sleep(10)
gt = get_gt()
gt.run_js("location.reload()"); time.sleep(10)
blocks = gt.run_js("return JSON.stringify(Array.from(document.querySelectorAll('.code_version_log')).map(function(b){return (b.innerText||'').split(String.fromCharCode(10)).join(' ')}).slice(0,3))")
for line in json.loads(blocks or "[]"): print("[TRUTH]", line[:230])
print("[done]")