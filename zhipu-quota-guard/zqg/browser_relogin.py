# -*- coding: utf-8 -*-
"""browser_relogin — 登录态自愈（W2 收官）：已有登录态则收割 JWT；无则账密登录+ddddocr 点选自动求解。

产物: state/zcode_jwt.txt（成功时）
退出码: 0=JWT到手 3=无需/浏览器忙 4=验证码多轮未过 5=登录凭据/结构异常
用法: python -m zqg.browser_relogin [--max-rounds 3]
"""
from __future__ import annotations

import argparse
import io
import json
import random
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[1]
STATE = ROOT / "state"

STEALTH = """
try{Object.defineProperty(navigator,'webdriver',{get:()=>undefined,configurable:true})}catch(e){}
try{Object.defineProperty(navigator,'languages',{get:()=>['zh-CN','zh','en'],configurable:true})}catch(e){}
try{Object.defineProperty(navigator,'plugins',{get:()=>[1,2,3,4,5],configurable:true})}catch(e){}
try{window.chrome={runtime:{},app:{isInstalled:false}}}catch(e){}
"""

LOGIN_URL = "https://bigmodel.cn/login?redirect=%2Fusercenter%2Fsettings%2Faccount"
USAGE_URL = "https://www.bigmodel.cn/coding-plan/personal/usage"


def _secrets() -> dict:
    return json.loads((ROOT / "secrets" / "zhipu_secrets.json").read_text(encoding="utf-8"))["bigmodel"]


def _attach():
    from DrissionPage import ChromiumOptions, ChromiumPage
    co = ChromiumOptions()
    co.set_local_port(9341)
    co.set_user_data_path(str(ROOT / ".chrome-profile"))
    return ChromiumPage(co)


def harvest_jwt(page) -> str | None:
    """用量页被动抓 Authorization（登录态在则一次拿到）。"""
    page.listen.start(["coding-plan/reset", "authorization"])
    page.get(USAGE_URL)
    time.sleep(2)
    jwt = None
    for pkt in page.listen.steps(timeout=18):
        try:
            hdrs = dict(pkt.request.headers)
            auth = hdrs.get("authorization", "")
            if auth.lower().startswith("bearer") and len(auth) > 40:
                jwt = auth
                break
        except Exception:  # noqa: BLE001
            continue
    page.listen.stop()
    if jwt:
        STATE.mkdir(exist_ok=True)
        (STATE / "zcode_jwt.txt").write_text(jwt, encoding="utf-8")
    return jwt


def fill_login(page) -> bool:
    bm = _secrets()
    page.get(LOGIN_URL)
    time.sleep(3)
    tab = page.ele("text:账号登录", timeout=3)
    if tab:
        tab.click()
        time.sleep(1.2)
    acct = page.ele("css:input[placeholder='请输入用户名/邮箱/手机号']", timeout=4)
    pwd = page.ele("css:input[placeholder='请输入密码']", timeout=3)
    if not acct or not pwd:
        print("[relogin] 登录表单结构异常")
        return False
    acct.clear().input(bm["phone"])
    pwd.clear().input(bm["password"])
    try:
        for cb in page.eles("css:input[type=checkbox]"):
            if cb.states.is_displayed and not cb.states.is_checked:
                cb.click()
                time.sleep(0.3)
    except Exception:  # noqa: BLE001
        pass
    btn = page.ele("xpath://button[normalize-space()='登录']", timeout=3)
    if not btn:
        return False
    try:
        btn.click()
    except Exception:  # noqa: BLE001
        btn.click(by_js=True)
    time.sleep(3)
    return True


def _grid_chars(img, cls, wins=(110, 140), stride_div=2):
    """网格滑窗分类：返回 [(char, cx, cy)]（NMS 去重）。对大字点选召回优于检测模型。"""
    import io
    W, H = img.size
    raw = []
    for win in wins:
        stride = max(30, win // stride_div)
        for y in range(0, max(1, H - win), stride):
            for x in range(0, max(1, W - win), stride):
                b = io.BytesIO()
                img.crop((x, y, x + win, y + win)).save(b, format="PNG")
                ch = (cls.classification(b.getvalue()) or "").strip()
                if len(ch) == 1 and "一" <= ch <= "鿿":
                    raw.append((ch, float(x + win / 2), float(y + win / 2)))
    keep = []
    for c in raw:                                   # NMS：80px 半径内只留先见者
        if all((c[1] - k[1]) ** 2 + (c[2] - k[2]) ** 2 > 80 ** 2 for k in keep):
            keep.append(c)
    return keep


def solve_click_captcha(page, max_rounds: int = 3) -> bool:
    """网格扫描识别点选验证码；每轮新题自动重试。"""
    import ddddocr
    from PIL import Image
    cls = ddddocr.DdddOcr(show_ad=False)
    for _round in range(max_rounds):
        area = page.ele("css:.tencent-captcha-dy__image-area", timeout=4)
        hdr = page.ele("css:.tencent-captcha-dy__header-text", timeout=2)
        if not area or "login" not in (page.url or "x"):
            return True  # 无验证码=已过
        prompt = (hdr.text if hdr else "") or ""
        targets = re.findall(r"[一-鿿]", prompt.split("：")[-1]) if "：" in prompt else []
        if not targets:
            print(f"[relogin] 题面异常: {prompt!r}")
            return False
        STATE.mkdir(exist_ok=True)
        area.get_screenshot(path=str(STATE / "w2_relogin_challenge.png"))
        img = Image.open(STATE / "w2_relogin_challenge.png").convert("RGB")
        cands = _grid_chars(img, cls)
        try:
            det = ddddocr.DdddOcr(det=True, show_ad=False)
            import io as _io
            from PIL import Image as _Img
            buf = _io.BytesIO(); img.save(buf, format="PNG")
            loc0, size0 = area.rect.location, area.rect.size
            for x1, y1, x2, y2 in det.detection(buf.getvalue()):
                cb = _io.BytesIO(); img.crop((x1, y1, x2, y2)).save(cb, format="PNG")
                ch = (cls.classification(cb.getvalue()) or "").strip()
                if ch:
                    cands.append((ch, (x1 + x2) / 2, (y1 + y2) / 2))
        except Exception:
            pass
        print(f"[relogin] r{_round} 题面={prompt!r} 识别={[c[0] for c in cands]}")
        picked = []
        for t in targets:                      # 按题面顺序点击（同字多候选取未用者）
            best = next((c for c in cands if t in c[0] and c not in picked), None)
            if best:
                picked.append(best)
        if len(picked) != len(targets):
            print("[relogin] 识别不足，刷新换题")
            _refresh(page)
            continue
        loc, size = area.rect.location, area.rect.size
        scale = img.width / size[0]
        for ch, cx, cy in picked:
            page.actions.move_to((loc[0] + cx / scale, loc[1] + cy / scale), duration=0.3)
            time.sleep(0.3)
            page.actions.click()
            time.sleep(0.5)
        time.sleep(0.8)
        btn = page.ele("css:.tencent-captcha-dy__verify-confirm-btn", timeout=2)
        if btn:
            btn.click()
        time.sleep(4)
        if "login" not in (page.url or ""):
            return True
        _refresh(page)
    return False


def _refresh(page):
    r = page.ele("css:.tencent-captcha-dy__footer-icon", timeout=2)
    if r:
        try:
            r.click()
        except Exception:  # noqa: BLE001
            pass
        time.sleep(2.5)


def main(argv=None) -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--max-rounds", type=int, default=3)
    args = ap.parse_args(argv)
    page = _attach()
    try:
        try:
            page.run_js(STEALTH)
        except Exception:  # noqa: BLE001 — 隐身失败不致命
            print("[relogin] stealth 注入跳过")
        # 已登录则直接收割
        page.get(USAGE_URL)
        time.sleep(2.5)
        if "login" not in (page.url or ""):
            jwt = harvest_jwt(page)
            print("[relogin] 已有登录态，JWT", "到手✅" if jwt else "未捕获（用量页无鉴权请求）")
            return 0 if jwt else 3
        if not fill_login(page):
            return 5
        if solve_click_captcha(page, args.max_rounds):
            jwt = harvest_jwt(page)
            print("[relogin] 登录成功，JWT", "到手✅" if jwt else "未捕获")
            return 0 if jwt else 3
        print("[relogin] 验证码未过（风控仍拒）")
        return 4
    finally:
        for cleanup in (lambda: page.quit(),):
            try:
                cleanup()
            except Exception:  # noqa: BLE001
                pass


if __name__ == "__main__":
    raise SystemExit(main())
