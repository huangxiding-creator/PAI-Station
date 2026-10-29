# -*- coding: utf-8 -*-
"""MP公众号发布: 接管9336已登录浏览器 → 新建图文 → 填标题正文 → 存草稿 → 尝试发布.
永动机做法(attach logged-in browser)。每步截图留证 data/mp_publish/."""
import time
from pathlib import Path

from playwright.sync_api import sync_playwright

CDP = "http://127.0.0.1:9336"
OUT = Path(r"E:\AI-Station\planchief\data\mp_publish")
OUT.mkdir(parents=True, exist_ok=True)
TITLE = "水利总包策划官上线：项目前期资料进，高质量管理策划方案出"
BODY_HTML = Path(r"E:\AI-Station\09 发布\策划官首发\mp正文.html").read_text(encoding="utf-8")
COVER = r"E:\AI-Station\09 发布\策划官首发\mp封面.png"


def shot(pg, name):
    pg.screenshot(path=str(OUT / f"{name}.png"), full_page=False)
    print(f"  📸 {name}")


def main():
    with sync_playwright() as pw:
        browser = pw.chromium.connect_over_cdp(CDP)
        ctx = browser.contexts[0]
        # 找已登录的mp tab拿token
        token = None
        for t in ctx.pages:
            if "mp.weixin.qq.com" in t.url and "token=" in t.url:
                token = t.url.split("token=")[1].split("&")[0]
                break
        assert token, "未找到已登录mp token"
        print(f"token: {token}")

        pg = ctx.new_page()
        pg.goto(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_edit&action=edit&type=77&token={token}&lang=zh_CN",
                wait_until="networkidle", timeout=60000)
        time.sleep(6)
        shot(pg, "01_editor_open")

        # 标题
        try:
            pg.fill("#title", TITLE)
            print("  标题已填")
        except Exception as e:
            print(f"  标题fill失败({e}), 尝试textarea")
            pg.evaluate(f"() => {{ const el = document.querySelector('#title') || document.querySelector('textarea'); el.focus(); el.value = {TITLE!r}; el.dispatchEvent(new Event('input', {{bubbles:true}})); }}")
        time.sleep(2)

        # 正文: 焦点进编辑器 → execCommand insertHTML (UEditor兼容)
        body_js = f"""
        () => {{
            const ed = document.querySelector('.edui-body-container') || document.querySelector('#edui1_contentplaceholder');
            if (!ed) return 'NO_EDITOR';
            ed.focus();
            const sel = window.getSelection();
            const range = document.createRange();
            range.selectNodeContents(ed);
            range.collapse(false);
            sel.removeAllRanges(); sel.addRange(range);
            document.execCommand('insertHTML', false, {BODY_HTML!r});
            return 'INSERTED';
        }}
        """
        r = pg.evaluate(body_js)
        print(f"  正文插入: {r}")
        time.sleep(3)
        shot(pg, "02_content_filled")

        # 草稿自动保存确认（等自动保存提示或手动ctrl+s不可用——MP自动保存）
        time.sleep(8)
        shot(pg, "03_autosave")

        # 群发/发表按钮 → 各种新版旧版路径
        clicked = False
        for sel in ["text=发表", "text=群发", ".weui-desktop-btn_primary", "#js_send",
                    "css:.tool-bar .weui-desktop-btn", "text=保存为草稿"]:
            try:
                el = pg.locator(sel).first
                if el.is_visible():
                    el.click()
                    clicked = True
                    print(f"  点击: {sel}")
                    break
            except Exception:
                continue
        time.sleep(4)
        shot(pg, "04_after_button")

        # 若出现封面选择弹窗 → 选"从正文选择"或自动裁剪确认
        for sel in ["text=自动裁剪", "text=从正文选择", ".weui-desktop-btn_primary:has-text('确定')",
                    "text=下一步", "text=确定"]:
            try:
                el = pg.locator(sel).first
                if el.is_visible(timeout=3000):
                    el.click()
                    print(f"  弹窗点击: {sel}")
                    time.sleep(3)
            except Exception:
                continue
        shot(pg, "05_dialog")

        # 最终状态截图（是否出现群发确认/二维码）
        time.sleep(5)
        shot(pg, "06_final")
        pg.evaluate("() => window.scrollTo(0, 0)")
        time.sleep(1)
        shot(pg, "07_top")

        print("完成——检查 06_final.png 判断是否需要手机确认")


if __name__ == "__main__":
    main()
