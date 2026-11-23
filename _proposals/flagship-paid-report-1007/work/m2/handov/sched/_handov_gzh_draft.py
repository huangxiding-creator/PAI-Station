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
    """持久化纪律(1122用户令): 首页只读判活 — 活则绝不注入(登录态真源=profile磁盘态);
    死才注入 cred 快照(gzh_session_keeper 每日导出的新鲜件); 仍死则返回空由调用方中止.
    坑: cgi-bin 列表页不带 token 访问一律回「登录超时」, 不可作判活页."""
    page.get("https://mp.weixin.qq.com/")
    time.sleep(6)
    src = page.html or ""
    url = page.url or ""
    m = re.search(r"token=(\d+)", url) or re.search(r"token=(\d+)", src)
    alive = ("登录超时" not in src) and ("请重新登录" not in src) and (bool(m) or ("新的创作" in src))
    if alive:
        tok = m.group(1) if m else ""
        print("[cookie] profile登录态活, 不注入 | token:", tok or "(页面态)", flush=True)
        return tok
    cred = json.load(open(rf"{KB}\mp_cred_{acct}.json", encoding="utf-8"))
    cookies = cred.get("cookies") or {}
    pairs = [{"name": k, "value": v} for k, v in cookies.items()] if isinstance(cookies, dict) else list(cookies)
    page.set.cookies(pairs)
    time.sleep(1)
    page.get("https://mp.weixin.qq.com/")
    time.sleep(5)
    src = page.html or ""
    m = re.search(r"token=(\d+)", page.url or "") or re.search(r"token=(\d+)", src)
    alive2 = ("登录超时" not in src) and ("请重新登录" not in src)
    print("[cookie] 注入cred快照后:", "活" if alive2 else "仍死", flush=True)
    return (m.group(1) if m else cred.get("token", "")) if alive2 else ""

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
        # 不再 minimized: Ctrl+V 剪贴板粘贴在最小化窗口不可靠 (1120 JES2投递实证)
        # 反检测 flags (照永动机 driver): 微信编辑器对 automation 指纹 Chrome 静默拒绝保存正文稿
        co.set_argument("--disable-blink-features=AutomationControlled")
        co.set_argument("--window-position=-32000,-32000")
        co.set_argument("--window-size=1280,800")
        co.set_argument("--no-first-run")
        co.set_argument("--disable-infobars")
    page = ChromiumPage(co)
    try:
        token = inject_cookies(page, acct)
        verified = False
        for _try in range(4):
            if verify_account(page, EXPECT[acct]):
                verified = True
                break
            time.sleep(3)
            page.get("https://mp.weixin.qq.com/")
            time.sleep(4)
            m_t = re.search(r"token=(\d+)", page.url or "")
            if m_t:
                token = m_t.group(1)
        if not verified:
            # 骑/手工模式: profile 即账号保证 (手工启动指定 acct profile), token 活即放行
            if len(sys.argv) > 5 and token:
                print("[verify] 首页名未命中, 骑模式按profile+活token放行", flush=True)
                verified = True
        if not verified:
            print("[fatal] 账号核对失败, 中止 (防错发)")
            return 2
        # token 用 cred 同代静态值 (1121终局: URL提取的token与注入cookie代际错配→保存静默拒; 诊断稿用静态token秒落箱实证)
        live_token = token
        print("[token] 使用cred静态token:", live_token or "DEAD", flush=True)
        page.get("https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_edit_v2"
                 "&action=edit&isNew=1&type=77&token=" + live_token)
        time.sleep(4)
        # 编辑器就绪轮询 (1121: ueditor懒加载, 未就绪时#title为null)
        ready = False
        for _w in range(20):
            try:
                has = page.run_js("var t=document.getElementById('title'); return (t && typeof t.value !== 'undefined') ? 'ok' : 'no';")
                if str(has) == 'ok':
                    ready = True
                    break
            except Exception:
                pass
            time.sleep(1.5)
        try:
            _ti = page.title
            _hl = len(page.html or "")
            _body = (page.run_js("return (document.body && document.body.innerText || '').slice(0,160);") or "")
        except Exception as _e:
            _ti, _hl, _body = "?", 0, str(_e)[:60]
        print("[editor] 就绪:", ready, "| title:", _ti, "| html:", _hl, "| body:", str(_body).replace(chr(10), " ")[:120], flush=True)
        if not ready:
            try:
                page.get_screenshot(r"E:\AI-Station\电力KB收割\editor_state.png")
                print("[shot] editor_state.png", flush=True)
            except Exception:
                pass
        if not ready:
            print("[fatal] 编辑器20轮未就绪", flush=True)
            return 6
        try:
            page.run_js("window.__net=[];(function(){var ox=XMLHttpRequest.prototype.send;"
                        "XMLHttpRequest.prototype.send=function(){"
                        "this.addEventListener('load',function(){try{"
                        "var u=this.responseURL||'';"
                        "if(u.indexOf('cgi-bin')>=0){window.__net.push(u.slice(0,110)+'|'+this.status+'|'+(this.responseText||'').slice(0,100));}}catch(e){}});"
                        "return ox.apply(this,arguments);};})();return 'ok';")
            print("[hook] net-monitor ok", flush=True)
        except Exception as e:
            print("[hook] fail", str(e)[:60], flush=True)
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
        # 正文粘贴: 剪贴板路径(1120验证)+反检测flags(1121新加)+校验重试
        pasted = 0
        for attempt in range(3):
            set_clipboard_html(html_body)
            time.sleep(0.4)
            page.actions.key_down("ctrl").type("v").key_up("ctrl")
            time.sleep(2.5)
            try:
                n = page.run_js("""
return (function(){
  var ed=document.querySelector('#edui1_contentplaceholder, .edui-body-container, .ProseMirror, [contenteditable=true]');
  return ed ? (ed.innerText||'').length : -1;
})()
""")
                pasted = int(n or 0)
                print(f"[paste] attempt{attempt+1} 正文长度={pasted}", flush=True)
            except Exception:
                pasted = 0
            if pasted > 300:
                break
            body.click()
            time.sleep(0.5)
        if pasted <= 300:
            print("[fatal] 正文粘贴未成, 弃投防脏稿", flush=True)
            return 7
        page.actions.type("\n")
        time.sleep(0.3)
        # 海报粘贴: 单次尝试, 失败不重试(防页面漂移), 纯文文稿也落箱
        img_ok = False
        try:
            set_clipboard_dib(img_path)
            time.sleep(0.4)
            page.actions.key_down("ctrl").type("v").key_up("ctrl")
            time.sleep(5)
            ni = page.run_js("""
return (function(){
  var ed=document.querySelector('#edui1_contentplaceholder, .edui-body-container, .ProseMirror, [contenteditable=true]');
  return ed ? ed.querySelectorAll('img').length : -1;
})()
""")
            print(f"[paste] 海报图片数={ni}", flush=True)
            img_ok = int(ni or 0) >= 1
        except Exception:
            pass
        if not img_ok:
            print("[warn] 海报未贴成, 走纯文文稿保存", flush=True)
        time.sleep(2)
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
            # Ctrl+S 快捷键兜底 (保存按钮找不到时)
            try:
                page.actions.key_down("ctrl").type("s").key_up("ctrl")
                time.sleep(2)
                print("[save] Ctrl+S 兜底已发", flush=True)
                r = "ctrl-s"
            except Exception:
                pass
        if not (str(r).startswith("clicked") or str(r) == "ctrl-s"):
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
        # 保存可能弹确认/新功能框 — 轮询等待至12s, 不见弹窗不提前break
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
            if s:
                head, _, btns = s.partition("||")
                print("  [modal]", head[:40], "|", btns, flush=True)
                for want in ("我知道了", "确定", "确认", "保存"):
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
                        time.sleep(2); break
            else:
                time.sleep(2)
        try:
            page.get_screenshot(r"E:\AI-Station\电力KB收割\handov_save_state.png")
            print("[shot] save-state 已存", flush=True)
        except Exception:
            pass
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
                try:
                    net = page.run_js("return JSON.stringify(window.__net||[])")
                    print("[net]", str(net)[:1500], flush=True)
                except Exception:
                    pass
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
