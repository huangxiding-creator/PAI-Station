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
        save = page.ele("text=保存为草稿", timeout=5) or page.ele("text:保存", timeout=3)
        if save:
            save.click()
            time.sleep(3)
            print(f"[OK] {acct}({EXPECT[acct]}) 草稿已保存: {title}")
            return 0
        print(f"[warn] {acct} 未找到保存按钮")
        return 4
    finally:
        if len(sys.argv) <= 5:  # 自起浏览器才关; 骑活会话不动
            try:
                page.quit()
            except Exception:
                pass


if __name__ == "__main__":
    raise SystemExit(main())
