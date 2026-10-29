# -*- coding: utf-8 -*-
"""submit_v140.py — 总包AI顾问 v1.4.0 控制台提审（撤1.3.0→提1.4.0 舞步版）。
mp-autosubmit 技能制式：9338 专属 profile；插件更新框自动点（1023 常令）；
按钮一律 innerText 精确匹配（1023 坑#2）；TRUTH=审核中+提交审核时间。"""
import sys, time, re, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

VER = "1.4.0"
OLD = "1.3.0"
DESC = ("知识库蓝图升级：新增深度三档（标准/专业/旗舰）供选择；文件清单接入更多公开行业资料源"
        "（研报/工程统计/范本）；云端实时生成，网络不佳时自动降级本地演示。"
        "知识库定制服务，支付走微信支付（安卓），iOS 隐藏付费入口。")

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
opts.set_argument("--window-size=1200,900")
opts.set_argument("--no-first-run")
page = ChromiumPage(addr_or_opts=opts)

page.get("https://mp.weixin.qq.com/")
tok = ""
for i in range(200):
    time.sleep(3)
    u = page.url or ""
    m = re.search(r"token=(\d+)", u)
    if m and "scanlogin" not in u:
        tok = m.group(1); print(f"[1] token={tok}"); break
else:
    print("LOGIN_TIMEOUT（QR 待扫）"); sys.exit(1)

# 坑#3：必须是小程序控制台
title = page.run_js("return document.title") or ""
print(f"[1b] title={title[:30]}")
if "小程序" not in title:
    print("NOT_MINIPROGRAM_CONSOLE"); sys.exit(2)

page.run_js(f"location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={tok}&lang=zh_CN'")
time.sleep(12)  # 坑#4 ContextLostError 缓冲

def js(code):
    return page.run_js("return (function(){" + code + "})()")

def click_btn_exact(label):
    """innerText 精确匹配点击（坑#2：绝不按 class 选）。"""
    return js(f"""
      var els = document.querySelectorAll('button, a, .weui-desktop-btn, view');
      for (var i = 0; i < els.length; i++) {{
        var t = (els[i].innerText || '').trim();
        var r = els[i].getBoundingClientRect ? els[i].getBoundingClientRect() : {{width: 1}};
        if (t === '{label}' && r.width > 0) {{
          els[i].dispatchEvent(new MouseEvent('click', {{bubbles: true, cancelable: true, view: window}}));
          return 'CLICKED';
        }}
      }}
      return 'NOT_FOUND';
    """)

# ── 2. 撤回 1.3.0 审核中版本（如有）──
r = js(f"""
  var blocks = document.querySelectorAll('.code_version_log, .weui-desktop-card');
  for (var b = 0; b < blocks.length; b++) {{
    var txt = (blocks[b].innerText || '').replace(/\\s+/g, ' ');
    if (txt.indexOf('{OLD}') >= 0 && txt.indexOf('审核中') >= 0) {{
      var btns = blocks[b].querySelectorAll('button, a');
      for (var i = 0; i < btns.length; i++) {{
        var t = (btns[i].innerText || '').trim();
        if (t === '撤回' || t === '撤销审核') {{ btns[i].click(); return 'WITHDRAW_OPENED'; }}
      }}
      return 'AUDITING_NO_WITHDRAW_BTN:' + txt.slice(0, 60);
    }}
  }}
  return 'NO_OLD_AUDITING';
""")
print(f"[2] 撤回{OLD}: {r}")
if "WITHDRAW_OPENED" in str(r):
    time.sleep(3)
    c = click_btn_exact("确定")
    print(f"[2b] 撤回确认: {c}")
    time.sleep(8)
    page.run_js(f"location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={tok}&lang=zh_CN'")
    time.sleep(12)

# ── 3. 点 1.4.0 开发版本行「提交审核」──
r = js(f"""
  var els = document.querySelectorAll('*');
  for (var i = 0; i < els.length; i++) {{
    var own = Array.prototype.filter.call(els[i].childNodes || [], function(n) {{
      return n.nodeType === 3;
    }}).map(function(n) {{ return n.nodeValue.trim(); }}).join(' ');
    if (own === '{VER}') {{
      var row = els[i];
      for (var d = 0; d < 14 && row; d++) {{
        var it = (row.innerText || '');
        if (it.indexOf('提交审核') >= 0 && it.indexOf('{VER}') >= 0) {{
          var btns = row.querySelectorAll('button, .weui-desktop-btn_primary');
          for (var bi = 0; bi < btns.length; bi++) {{
            if ((btns[bi].innerText || '').trim() === '提交审核') {{
              btns[bi].dispatchEvent(new MouseEvent('click', {{bubbles: true, cancelable: true, view: window}}));
              return 'CLICKED';
            }}
          }}
        }}
        row = row.parentElement;
      }}
    }}
  }}
  return 'NOT_FOUND';
""")
print(f"[3] 点{VER}提交审核: {r}")
if "NOT_FOUND" in str(r): sys.exit(3)
time.sleep(8)

# ── 4. 对话舞步事件循环（插件更新自动点=常令）+ 表单页并行扫描 ──
def dlg_state():
    return js("""
      var mods = document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .weui-desktop-dialog__wrp');
      for (var i = 0; i < mods.length; i++) {
        var txt = (mods[i].innerText || '').replace(/\\s+/g, ' ').trim();
        if (!txt || txt.length < 5) continue;
        var btns = mods[i].querySelectorAll('button');
        var bl = [];
        for (var b = 0; b < btns.length; b++) { var t = (btns[b].innerText || '').trim(); if (t) bl.push(t); }
        if (bl.length) return txt.slice(0, 60) + '||' + bl.join(',');
      }
      return '';
    """)

def dlg_click(label, head_kw=None):
    """f-string 花括号坑根修：js 文本用纯字符串+参数注入。"""
    js_body = (
        "var mods = document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');"
        "for (var i = 0; i < mods.length; i++) {"
        "  var txt = mods[i].innerText || '';"
        "  if (arguments[1] && txt.indexOf(arguments[1]) < 0) continue;"
        "  var bs = mods[i].querySelectorAll('button');"
        "  for (var b = 0; b < bs.length; b++) {"
        "    if ((bs[b].innerText || '').trim() === arguments[0]) { bs[b].click(); return; }"
        "  }"
        "}"
    )
    try:
        page.run_js(js_body, label, head_kw or "")
    except Exception:
        pass

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
                t.run_js('return (function(){var ta=document.querySelector("textarea");if(!ta)return;ta.value=' + dj + ';ta.dispatchEvent(new Event("input",{bubbles:true}));})()')
                time.sleep(2)
                t.run_js("(function(){var els=document.querySelectorAll('button,a.btn_primary,.weui-desktop-btn_primary');for(var i=0;i<els.length;i++){var t=(els[i].innerText||'').trim();if(t==='提交审核'){els[i].dispatchEvent(new MouseEvent('click',{bubbles:true,cancelable:true,view:window}));return;}}})()")
                print("[6] form submit")
                time.sleep(3)
                for tk in range(60):
                    time.sleep(1)
                    c = t.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.dialog,.modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){var t=(bs[b].innerText||'').trim();if(t==='确定，继续提交'){bs[b].click();return 'FINAL';}}}return '';})()")
                    if c:
                        print(f"[7] {tk}s {c}"); break
                FORM_DONE = True
                break
    except Exception:
        pass
    if FORM_DONE: break

    # 对话框舞步
    try:
        s = dlg_state()
    except Exception:
        s = ""
    if not s:
        continue
    head, _, btns_s = s.partition("||")
    print(f"  [{tick}s] dlg: {head[:50]} | {btns_s}")
    if "插件" in head and "确认" in btns_s:          # 含「插件有更新」（1023常令：自动点）
        dlg_click("确认", "插件"); print(f"  [{tick}s] 插件(含更新)→确认")
    elif "须知" in head:
        page.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){if((mods[i].innerText||'').indexOf('须知')<0)continue;var cb=mods[i].querySelector('input[type=checkbox]');if(cb&&!cb.checked)cb.click();var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){var t=(bs[b].innerText||'').trim();if(t==='下一步'){bs[b].click();return;}}}})()")
        print(f"  [{tick}s] 须知→下一步")
    elif "继续提交" in btns_s:
        dlg_click("继续提交"); print(f"  [{tick}s] 继续提交")
    elif "撤回" in head and "取消" in btns_s:
        dlg_click("取消", "撤回")  # 撤回确认兜底（若步骤2的确认没弹到位）
    elif "删除" in head and "取消" in btns_s:
        dlg_click("取消", "删除")  # 坑#5 删除误触防护

if not FORM_DONE:
    print("[!] 表单页未达（600s）"); sys.exit(4)

# ── 8. TRUTH 验证 ──
time.sleep(10)
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if "getcodepage" in (t.url or ""):
        t.run_js("location.reload()"); time.sleep(10)
        blocks = t.run_js("return JSON.stringify(Array.from(document.querySelectorAll('.code_version_log')).map(function(b){return (b.innerText||'').split(NL).join(' ')}).slice(0,3))".replace("NL", "String.fromCharCode(10)"))
        for line in json.loads(blocks or "[]"):
            print("[8] TRUTH:", line[:200])
        break
else:
    page.run_js(f"location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={tok}&lang=zh_CN'")
    time.sleep(12)
    body = page.run_js("return (document.body.innerText||'').replace(/\\s+/g,' ').slice(0,900)")
    print("[8] TRUTH(重跳):", body[:400])
print("[done]")