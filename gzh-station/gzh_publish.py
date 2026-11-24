# -*- coding: utf-8 -*-
"""gzh_publish.py — 独立公众号发布器（gzh-station，随时可发，零外部依赖）。
子命令:
  push   <acct> <md路径> [标题]        推草稿（区域分投+保存回读验证）
  publish <acct> [题名关键词]           草稿→发表（卡点击+确认链白名单+TRUTH）
  delete <acct> <题名关键词>            删草稿（垃圾桶→确认气泡→复核）
  status <acct>                         箱内清单+登录态
  list   <acct>                         发布记录
复活链: cookie 重注入(自有 creds) → 一键登录(裸「登录」钮) → 仍死=提示扫码。
窗口可见（本站独立窗口不上 -32000），CDP 悬停可触发 CSS:hover（删稿气泡可用）。"""
import sys, os, json, time, re

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from DrissionPage import ChromiumPage, ChromiumOptions

ACCOUNTS = {"acct01": ("总包说", 9361), "acct05": ("总包之声", 9362),
            "acct07": ("工程行业大脑", 9363)}
CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
CONFIRM_TEXTS = ("继续群发", "继续发表", "发表")


def _launch(acct):
    nick, port = ACCOUNTS[acct]
    prof = os.path.join(HERE, "profiles", acct)
    os.makedirs(prof, exist_ok=True)
    co = ChromiumOptions()
    co.set_local_port(port)
    co.set_user_data_path(prof)
    co.set_browser_path(CHROME)
    return ChromiumPage(co)


def is_logged_in(pg):
    u = pg.url or ""
    return "token=" in u and "login" not in u.lower()


def _revive(pg, acct):
    """cookie 重注入 → 一键登录。返回 True=活。"""
    cred_path = os.path.join(HERE, "creds", f"mp_cred_{acct}.json")
    if os.path.exists(cred_path):
        try:
            cred = json.load(open(cred_path, encoding="utf-8"))
            pg.get("https://mp.weixin.qq.com/")
            time.sleep(3)
            pg.set.cookies(cred.get("cookies") or {})
            tok = cred.get("token") or ""
            if tok:
                pg.get(f"https://mp.weixin.qq.com/cgi-bin/home?t=home/index&lang=zh_CN&token={tok}")
            else:
                pg.get("https://mp.weixin.qq.com/")
            time.sleep(6)
            if is_logged_in(pg):
                return True
        except Exception as e:
            print(f"[{acct}] cookie 复用失败: {str(e)[:60]}")
    # 一键登录（裸「登录」钮，沿用上次身份）
    pg.get("https://mp.weixin.qq.com/")
    time.sleep(5)
    r = pg.run_js("""
return (function(){
  function vis(e){var r=e.getBoundingClientRect();return r.width>2&&r.height>2;}
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ').trim();}
  var els=document.querySelectorAll('a, button, div, span');
  for (var i=0;i<els.length;i++){ var t=ownText(els[i]); if (t==='登录' && vis(els[i])){ els[i].click(); return true; } }
  return false;
})()
""")
    time.sleep(8)
    if is_logged_in(pg):
        print(f"[{acct}] 一键登录复活 ✓")
        return True
    print(f"[{acct}] 会话死且无法复活——请运行 gzh_login.py 扫码")
    return False


def _page(acct):
    pg = _launch(acct)
    if not is_logged_in(pg):
        if not _revive(pg, acct):
            return None
    m = re.search(r"token=(\d+)", pg.url or "")
    if not m:
        pg.get("https://mp.weixin.qq.com/cgi-bin/home?t=home/index&lang=zh_CN")
        time.sleep(6)
        m = re.search(r"token=(\d+)", pg.url or "")
    return pg if m else None


def _edit_regions(editor):
    ce = editor.eles("@contenteditable=true")
    tit_i = body_i = None
    for i, e in enumerate(ce):
        try:
            w, h = e.rect.size
        except Exception:
            continue
        if h > 100:
            body_i = i
        elif 0 < h < 60 and w > 100 and tit_i is None:
            tit_i = i
    return tit_i, body_i


def _save_draft(editor):
    editor.run_js("""
return (function(){
  function vis(e){var r=e.getBoundingClientRect();return r.width>0&&r.height>0;}
  var els=document.querySelectorAll('button, .weui-desktop-btn, a, span');
  for (var i=0;i<els.length;i++){ var x=(els[i].innerText||'').trim(); if(x==='保存为草稿'&&vis(els[i])){els[i].click(); return 'ok';} }
  return 'no';
})()
""")


def _vis_js():
    return """function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}"""


def cmd_push(acct, md_path, title):
    pg = _page(acct)
    if not pg:
        return 5
    m = re.search(r"token=(\d+)", pg.url or "")
    tok = m.group(1)
    pg.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_edit_v2&action=edit&isNew=1&type=77&token={tok}")
    time.sleep(6)
    tit_i, body_i = _edit_regions(pg)
    if tit_i is None or body_i is None:
        print(f"[{acct}] 编辑区识别失败"); return 4
    ce = pg.eles("@contenteditable=true")
    ce[tit_i].click()
    pg.actions.type(title)
    time.sleep(1)
    ce[body_i].click()
    time.sleep(0.5)
    set_clipboard_html(md_to_html(md_path))
    pg.actions.key_down("ctrl").type("v").key_up("ctrl")
    time.sleep(5)
    _save_draft(pg)
    time.sleep(6)
    raw = pg.run_js("""
return (function(){
  var x = new XMLHttpRequest();
  x.open('GET', '/cgi-bin/appmsg?action=list_ex&type=77&token=%s&lang=zh_CN', false);
  x.withCredentials = true; x.send(); return x.responseText;
})()
""" % tok)
    d = json.loads(raw or '{}')
    hit = any(title[:12] in (it.get("title") or "") for it in (d.get("app_msg_list") or []))
    print(f"[{acct}] 推稿落箱: {hit}")
    return 0 if hit else 4


def cmd_publish(acct, key):
    pg = _page(acct)
    if not pg:
        return 5
    m = re.search(r"token=(\d+)", pg.url or "")
    tok = m.group(1)
    pg.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?begin=0&count=10&type=77&action=list_card&token={tok}")
    time.sleep(6)
    r = pg.run_js("""
return (function(){
  %VIS%
  var cards=document.querySelectorAll('.weui-desktop-card, .js_draft_card, li[class*=draft]');
  for (var i=0;i<cards.length;i++){
    var c=cards[i];
    if ((c.innerText||'').indexOf('%KEY%')<0) continue;
    c.dispatchEvent(new MouseEvent('mouseover',{bubbles:true}));
    var bs=c.querySelectorAll('a, button, [role=button], .weui-desktop-btn, span');
    for (var b=0;b<bs.length;b++){
      var x=(bs[b].innerText||'').trim().replace(/[\\s]+/g,'');
      if (x==='发表' && vis(bs[b])){ bs[b].click(); return 'clicked'; }
    }
  }
  return 'not-found';
})()
""".replace('%VIS%', _vis_js()).replace('%KEY%', key))
    print(f"[{acct}] 卡内发表: {r[:40]}")
    if 'clicked' not in str(r):
        return 4
    final = ""
    for tick in range(30):
        time.sleep(2)
        r2 = pg.run_js("""
return (function(){
  %VIS%
  var ds=document.querySelectorAll('.weui-desktop-dialog, .new_mass_send_dialog, [class*=dialog]');
  for (var i=0;i<ds.length;i++){
    if (!vis(ds[i])) continue;
    var bs=ds[i].querySelectorAll('button');
    for (var b=0;b<bs.length;b++){
      var x=(bs[b].innerText||'').trim().replace(/[\\s]+/g,'');
      if (x==='继续群发'||x==='继续发表'||x==='发表'){ bs[b].click(); return 'clicked-'+x; }
    }
    return 'dialog:'+(ds[i].innerText||'').slice(0,50);
  }
  return '';
})()
""".replace('%VIS%', _vis_js()))
        if str(r2).startswith('clicked'):
            final = str(r2)
            print(f"  确认链: {r2}")
            time.sleep(3)
            continue
        if '群发成功' in str(r2) or '已发表' in str(r2):
            break
    time.sleep(6)
    pg.get(f"https://mp.weixin.qq.com/cgi-bin/appmsgpublish?sub=list&type=101_1_102_103&token={tok}&lang=zh_CN&f=json")
    time.sleep(4)
    body = pg.run_js('return (document.body.innerText||"")') or ''
    ok = key in body
    print(f"[{acct}] TRUTH 发布记录: {ok}")
    return 0 if ok else 6


def cmd_delete(acct, key):
    pg = _page(acct)
    if not pg:
        return 5
    m = re.search(r"token=(\d+)", pg.url or "")
    tok = m.group(1)
    pg.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?begin=0&count=10&type=77&action=list_card&token={tok}")
    time.sleep(6)
    # 垃圾桶图标坐标 → CDP 真实悬停（可见窗，:hover 可触发）→ 确认气泡 → 点删除
    pos = pg.run_js("""
return (function(){
  %VIS%
  var cards=document.querySelectorAll('.weui-desktop-card, .js_draft_card, li[class*=draft]');
  for (var i=0;i<cards.length;i++){
    var c=cards[i];
    if ((c.innerText||'').indexOf('%KEY%')<0) continue;
    var opr=c.querySelector('.weui-desktop-card__action, .weui-desktop-publish__opr');
    if (!opr) continue;
    var pops=opr.querySelectorAll('.weui-desktop-popover');
    var icon=null;
    for (var p=0;p<pops.length;p++){
      if ((pops[p].innerText||'').indexOf('确定删除')>=0){
        var wr=pops[p].closest('.weui-desktop-popover__wr')||pops[p].parentElement;
        icon=wr.querySelector('a, button')||wr; break;
      }
    }
    if (!icon){ var icons=opr.querySelectorAll('a[class*=icon]'); icon=icons[icons.length-1]||null; }
    if (icon){ var r=icon.getBoundingClientRect(); return JSON.stringify({x:Math.round(r.x+r.width/2), y:Math.round(r.y+r.height/2)}); }
    return '{}';
  }
  return '{}';
})()
""".replace('%VIS%', _vis_js()).replace('%KEY%', key))
    p = json.loads(pos or '{}')
    if not p.get('x'):
        print(f"[{acct}] 未找到目标卡/垃圾桶")
        return 4
    pg.actions.move_to((p['x'], p['y']), duration=0.5)
    time.sleep(2.5)
    dpos = pg.run_js("""
return (function(){
  %VIS%
  var pops=document.querySelectorAll('.weui-desktop-popover');
  for (var i=0;i<pops.length;i++){
    if ((pops[i].innerText||'').indexOf('确定删除')>=0){
      var r=pops[i].getBoundingClientRect();
      if (r.width<10) return '{}';
      var bs=pops[i].querySelectorAll('button, a, .weui-desktop-btn, span');
      for (var b=0;b<bs.length;b++){
        var x=(bs[b].innerText||'').trim().replace(/[\\s]+/g,'');
        if (x==='删除'){ var rr=bs[b].getBoundingClientRect(); return JSON.stringify({x:Math.round(rr.x+rr.width/2), y:Math.round(rr.y+rr.height/2)}); }
      }
    }
  }
  return '{}';
})()
""".replace('%VIS%', _vis_js()))
    d = json.loads(dpos or '{}')
    if not d.get('x'):
        print(f"[{acct}] 确认气泡未展开")
        return 5
    pg.actions.move_to((d['x'], d['y']), duration=0.3).click()
    time.sleep(4)
    r3 = pg.run_js("""
return (function(){
  var cards=document.querySelectorAll('.weui-desktop-card, .js_draft_card, li[class*=draft]');
  for (var i=0;i<cards.length;i++){
    if ((cards[i].innerText||'').indexOf('%KEY%')>=0) return 'STILL-THERE';
  }
  return 'GONE';
})()
""".replace('%KEY%', key))
    print(f"[{acct}] 删除复核: {r3}")
    return 0 if r3 == 'GONE' else 6


def cmd_status(acct):
    pg = _page(acct)
    if not pg:
        return 5
    m = re.search(r"token=(\d+)", pg.url or "")
    tok = m.group(1)
    raw = pg.run_js("""
return (function(){
  var x = new XMLHttpRequest();
  x.open('GET', '/cgi-bin/appmsg?action=list_ex&type=77&token=%s&lang=zh_CN', false);
  x.withCredentials = true; x.send(); return x.responseText;
})()
""" % tok)
    d = json.loads(raw or '{}')
    items = d.get('app_msg_list') or []
    print(f"[{acct}] 登录 ✓ · 箱内 {len(items)} 篇:")
    for it in items[:10]:
        print('  -', (it.get('title') or '')[:48])
    return 0


def cmd_list(acct):
    pg = _page(acct)
    if not pg:
        return 5
    m = re.search(r"token=(\d+)", pg.url or "")
    tok = m.group(1)
    pg.get(f"https://mp.weixin.qq.com/cgi-bin/appmsgpublish?sub=list&type=101_1_102_103&token={tok}&lang=zh_CN&f=json")
    time.sleep(4)
    body = pg.run_js('return (document.body.innerText||"")') or ''
    print(f"[{acct}] 发布记录含查询词: {('45 个专题库' in body) or ('超级总包' in body)}")


# ── 复用剪贴板 HTML（独立实现，不依赖外部模块）──
def set_clipboard_html(html):
    import win32clipboard as clip
    cf_html = clip.RegisterClipboardFormat("HTML Format")
    header = ("Version:0.9\r\nStartHTML:{sh:010d}\r\nEndHTML:{eh:010d}\r\n"
              "StartFragment:{sf:010d}\r\nEndFragment:{ef:010d}\r\n")
    pre = "<html><body>\r\n<!--StartFragment-->"
    post = "<!--EndFragment-->\r\n</body></html>"
    h0 = header.encode("utf-8")
    sf = len(h0) + len(pre.encode("utf-8"))
    ef = sf + len(html.encode("utf-8"))
    hdr = header.format(sh=len(h0), eh=ef + len(post.encode("utf-8")),
                        sf=sf, ef=ef).encode("utf-8")
    data = hdr + pre.encode("utf-8") + html.encode("utf-8") + post.encode("utf-8")
    clip.OpenClipboard()
    clip.EmptyClipboard()
    clip.SetClipboardData(cf_html, data)
    clip.CloseClipboard()


def md_to_html(md_path):
    import html as H
    out = []
    for ln in open(md_path, encoding="utf-8").read().splitlines():
        if ln.startswith("# "):
            out.append(f"<h2><strong>{H.escape(ln[2:])}</strong></h2>")
        elif ln.startswith("## "):
            out.append(f"<h3>{H.escape(ln[3:])}</h3>")
        elif ln.startswith("> "):
            out.append(f"<p><em>{H.escape(ln[2:])}</em></p>")
        elif ln.startswith("- "):
            out.append(f"<p>• {H.escape(ln[2:])}</p>")
        elif ln.strip():
            t = re.sub(r"\*\*(.+?)\*\*", r"<strong>\1</strong>", H.escape(ln))
            out.append(f"<p>{t}</p>")
    return "\n".join(out)


def main():
    cmd = sys.argv[1] if len(sys.argv) > 1 else ""
    if cmd == "push":
        acct, md = sys.argv[2], sys.argv[3]
        title = sys.argv[4] if len(sys.argv) > 4 else "发布| 超级总包知识库（动态更新）：45 个专题库全景目录"
        sys.exit(cmd_push(acct, md, title))
    elif cmd == "publish":
        acct = sys.argv[2]
        key = sys.argv[3] if len(sys.argv) > 3 else "45 个专题库全景目录"
        sys.exit(cmd_publish(acct, key))
    elif cmd == "delete":
        acct, key = sys.argv[2], sys.argv[3]
        sys.exit(cmd_delete(acct, key))
    elif cmd == "status":
        sys.exit(cmd_status(sys.argv[2]))
    elif cmd == "list":
        sys.exit(cmd_list(sys.argv[2]))
    else:
        print(__doc__)
        sys.exit(1)


if __name__ == "__main__":
    main()
