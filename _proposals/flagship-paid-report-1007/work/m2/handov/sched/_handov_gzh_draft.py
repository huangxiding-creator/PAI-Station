# -*- coding: utf-8 -*-
"""handov_gzh_draft — 第20份EPC-HANDOV 3篇宣传稿 UI 剪贴板投递入草稿箱.

照 gzh-autopublish 技能 (1118/1119 实战): cookie重注入免扫码 + 首页核号防错发 +
JS注入标题 + CF_HTML正文 + DIB海报图 + 保存草稿. 仅入箱不发表(发表留发表腿).
profile 真身映射 (1119实测): acct05@9341=总包之声 | acct01@9342=总包说 | acct07@9343=工程行业大脑
用法: py -X utf8 _handov_gzh_draft.py <acct01|acct05|acct07> <md路径> <标题> <图路径>
"""
import ctypes
import html as H
import io
import json
import re
import sys
import time

import win32clipboard as clip
from PIL import Image
from DrissionPage import ChromiumPage, ChromiumOptions

KB = r"E:\AI-Station\电力KB收割"
PROFILE_DIR = r"F:\We-AIPO\autopub\data\browser_profiles"
PORTS = {"acct01": 9342, "acct05": 9341, "acct07": 9343}
EXPECT = {"acct01": "总包说", "acct05": "总包之声", "acct07": "工程行业大脑"}


def set_clipboard_html(html: str):
    cf_html = clip.RegisterClipboardFormat("HTML Format")
    header = ("Version:0.9\r\nStartHTML:{sh:010d}\r\nEndHTML:{eh:010d}\r\n"
              "StartFragment:{sf:010d}\r\nEndFragment:{ef:010d}\r\n")
    pre = "<html><body>\r\n<!--StartFragment-->"
    post = "<!--EndFragment-->\r\n</body></html>"
    h0 = header.encode("utf-8")
    sh = len(h0)
    sf = sh + len(pre.encode("utf-8"))
    ef = sf + len(html.encode("utf-8"))
    eh = ef + len(post.encode("utf-8"))
    hdr = header.format(sh=sh, eh=eh, sf=sf, ef=ef).encode("utf-8")
    data = hdr + pre.encode("utf-8") + html.encode("utf-8") + post.encode("utf-8")
    clip.OpenClipboard()
    clip.EmptyClipboard()
    clip.SetClipboardData(cf_html, data)
    clip.CloseClipboard()


def set_clipboard_dib(path: str):
    img = Image.open(path)
    if img.mode != "RGB":
        img = img.convert("RGB")
    buf = io.BytesIO()
    img.save(buf, "BMP")
    dib = buf.getvalue()[14:]
    clip.OpenClipboard()
    clip.EmptyClipboard()
    clip.SetClipboardData(clip.CF_DIB, dib)
    clip.CloseClipboard()


def md_to_html(md_path: str) -> str:
    md = open(md_path, encoding="utf-8").read()
    out = []
    title = None
    for ln in md.splitlines():
        s = ln.strip()
        if ln.startswith("# "):
            title = ln[2:].strip()
            continue  # 标题走输入框, 不入正文
        if s.startswith("## "):
            out.append(f"<p><strong>{H.escape(ln[3:].strip())}</strong></p>")
        elif s.startswith("> "):
            out.append(f"<p><em>{H.escape(ln[2:].strip())}</em></p>")
        elif s.startswith("!["):
            continue  # 图由 DIB 粘贴
        elif s.startswith("- "):
            out.append(f"<p>• {H.escape(ln[2:].strip())}</p>")
        elif s:
            t = re.sub(r"\*\*(.+?)\*\*", r"<strong>\1</strong>", H.escape(s))
            out.append(f"<p>{t}</p>")
    return ("\n".join(out), title)


def inject_cookies(page, acct: str):
    cred = json.load(open(rf"{KB}\mp_cred_{acct}.json", encoding="utf-8"))
    cookies = cred.get("cookies") or {}
    pairs = []
    if isinstance(cookies, dict):
        pairs = [{"name": k, "value": v} for k, v in cookies.items()]
    else:
        pairs = cookies
    page.get("https://mp.weixin.qq.com/")
    time.sleep(2)
    page.set.cookies(pairs)
    time.sleep(1)
    page.get("https://mp.weixin.qq.com/")
    time.sleep(3)
    return cred.get("token", "")


def verify_account(page, expect: str) -> bool:
    """发表前必须读首页账号名核对身份 (技能红线: 错号=文章发错公众号)."""
    src = page.html or ""
    if expect in src:
        return True
    m = re.search(r'nickname[\"\x27:>]\s*([^\"\x27<]{2,20})', src)
    got = m.group(1) if m else "?"
    print(f"[verify] 期望 {expect} 实际首页含: {got}")
    return False


def main() -> int:
    acct, md_path, title, img_path = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
    port = PORTS[acct]
    if len(sys.argv) > 5:
        port = int(sys.argv[5])  # 骑活会话端口 (如永动机 19556)
    co = ChromiumOptions()
    co.set_local_port(port)
    if len(sys.argv) <= 5:
        co.set_paths(user_data_path=rf"{PROFILE_DIR}\{acct}")
        co.set_argument("--start-minimized")
    page = ChromiumPage(co)
    try:
        token = inject_cookies(page, acct)
        if not verify_account(page, EXPECT[acct]):
            print("[fatal] 账号核对失败, 中止 (防错发)")
            return 2
        # 从当前 URL 拿活 token (cookie+活页混浆=陈账, 技能坑表)
        m = re.search(r"token=(\d+)", page.url or "")
        live_token = m.group(1) if m else token
        page.get("https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_edit_v2"
                 "&action=edit&isNew=1&type=77&token=" + live_token)
        time.sleep(4)
        # 标题 JS 注入 (坑表: .input() 不生效)
        page.run_js(f'e=document.getElementById("title");'
                    f'e.value={json.dumps(title, ensure_ascii=False)};'
                    f'e.dispatchEvent(new Event("input",{{bubbles:true}}))')
        time.sleep(1)
        body = (page.ele("css:#edui1_contentplaceholder,.edui-body-container,css:.ProseMirror", timeout=8)
                or page.ele("@contenteditable=true", timeout=5))
        if not body:
            print("[fatal] 未找到正文编辑器")
            return 3
        body.click()
        time.sleep(0.5)
        html_body, _ = md_to_html(md_path)
        set_clipboard_html(html_body)
        page.actions.key_down("ctrl").type("v").key_up("ctrl")
        time.sleep(2)
        page.actions.type("\n")
        time.sleep(0.3)
        set_clipboard_dib(img_path)
        page.actions.key_down("ctrl").type("v").key_up("ctrl")
        time.sleep(4)
        # 保存为草稿: JS 全文匹配 + 兜底模糊, 保存后处理确认弹窗
        r = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var els=document.querySelectorAll('button, .weui-desktop-btn, [role=button], a');
  var names=[];
  for (var i=0;i<els.length;i++){
    var t=(els[i].innerText||'').trim();
    if(!t) continue; names.push(t);
    if(t==='保存为草稿' && vis(els[i])){ els[i].click(); return 'clicked:保存为草稿'; }
  }
  return 'notfound:'+names.slice(0,14).join(',');
})()
""")
        print("[save]", str(r)[:120], flush=True)
        if not str(r).startswith("clicked"):
            # 兜底: 模糊找含保存的可见按钮
            r2 = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var els=document.querySelectorAll('button, .weui-desktop-btn, [role=button]');
  for (var i=0;i<els.length;i++){
    var t=(els[i].innerText||'').trim();
    if(t.indexOf('保存')>=0 && t.indexOf('发布')<0 && vis(els[i])){ els[i].click(); return 'clicked-fuzzy:'+t; }
  }
  return '';
})()
""")
            print("[save-fuzzy]", str(r2)[:80], flush=True)
        time.sleep(3)
        # 保存可能弹确认框 (如「确认保存草稿」) — 自动点确定/确认
        for _ in range(6):
            s = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var bs=mods[i].querySelectorAll('button');
    var names=[]; for (var b=0;b<bs.length;b++){ if(vis(bs[b])){var t=(bs[b].innerText||'').trim(); if(t)names.push(t);} }
    var txt=(mods[i].innerText||'').replace(/\\s+/g,' ').slice(0,60);
    if (txt) return txt+'||'+names.join(',');
  }
  return '';
})()
""")
            if not s:
                break
            head, _, btns = s.partition("||")
            print("  [modal]", head[:40], "|", btns, flush=True)
            done = False
            for want in ("确定", "确认", "保存"):
                if want in (btns or ""):
                    page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var bs=mods[i].querySelectorAll('button');
    for (var b=0;b<bs.length;b++){
      var t=(bs[b].innerText||'').trim();
      if (t==='%WANT%' && vis(bs[b])){ bs[b].click(); return 'ok'; }
    }
  }
  return '';
})()
""".replace("%WANT%", want))
                    time.sleep(2); done = True; break
            if not done:
                break
        time.sleep(4)
        # 落箱验证: 活会话同源拉 list_ex
        m2 = re.search(r"token=(\d+)", page.url or "")
        vtok = m2.group(1) if m2 else live_token
        try:
            page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&token={vtok}&lang=zh_CN")
            time.sleep(2)
            raw = page.run_js("""
return (function(){
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/cgi-bin/appmsg?action=list_ex&type=77&token=%s&lang=zh_CN&begin=0&count=10', false);
  xhr.withCredentials = true; xhr.send(); return xhr.responseText;
})()
""" % vtok)
            dd = json.loads(raw or "{}")
            items = dd.get("app_msg_list") or []
            in_box = any(title[:12] in (it.get("title") or "") for it in items)
            print(f"[verify] {acct} 落箱验证: {'PASS' if in_box else 'FAIL'} (箱内近10条已比对)")
            if not in_box:
                for it in items[:5]:
                    print("   -", (it.get("title") or "")[:40])
            return 0 if in_box else 5
        except Exception as e:
            print(f"[verify] 验证异常: {str(e)[:60]}")
            return 5
    finally:
        if len(sys.argv) <= 5:  # 自起浏览器才关; 骑活会话不动
            try:
                page.quit()
            except Exception:
                pass


if __name__ == "__main__":
    raise SystemExit(main())
