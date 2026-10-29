import sys, time, re
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)
tok = ""
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    m = re.search(r"token=(\d+)", t.url or "")
    if m: tok = m.group(1); page = t; break

def find_tab(kw):
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if kw in (t.url or ""): return t

# 看所有 tab 的 URL
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    print(f"tab: {(t.url or '')[:80]}")

# 查看是否有 get_class tab（提审表单页）
ft = find_tab("get_class")
if ft:
    print("FOUND get_class tab!")
    body = ft.run_js("return (document.body.innerText || '').slice(0, 300)")
    print(f"form page: {body[:200]}")
else:
    print("NO get_class tab")

# 查看当前 tab 的对话框
gt = find_tab("getcodepage") or page
mods = gt.run_js("""
return (function(){
  var out = [];
  var mods = document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, [class*=modal], [class*=dialog]');
  for (var i = 0; i < mods.length; i++) {
    var txt = (mods[i].innerText || '').replace(/\\s+/g, ' ').trim();
    if (txt && txt.length > 5) {
      var btns = mods[i].querySelectorAll('button');
      var bl = [];
      for (var b = 0; b < btns.length; b++) {
        var t = (btns[b].innerText || '').trim();
        if (t) bl.push(t);
      }
      out.push({text: txt.slice(0, 100), buttons: bl.join(',')});
    }
  }
  return JSON.stringify(out.slice(0, 5));
})()
""")
print(f"dialogs: {mods}")

# 截屏
page.get_screenshot(path=r"E:\AI-Station\kb_rev\submit_state.png")
print("screenshot saved")
