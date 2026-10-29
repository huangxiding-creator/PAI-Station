# -*- coding: utf-8 -*-
"""captcha_live2 — v2 实弹：v2 识别 + 点击前瞬时重定位（动态字对策）+ 成功即收 JWT。"""
from __future__ import annotations

import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))
ROOT = Path(__file__).resolve().parents[1]
STATE = ROOT / "state"
from captcha_solver2 import find_boxes, classify_box, template_score, template_locate  # noqa: E402

from PIL import Image  # noqa: E402
from DrissionPage import ChromiumOptions, ChromiumPage  # noqa: E402

BM = json.loads((ROOT / "secrets" / "zhipu_secrets.json").read_text(encoding="utf-8"))["bigmodel"]
LOGIN_URL = BM["login_url"]
USAGE_URL = "https://www.bigmodel.cn/coding-plan/personal/usage"


def shot_area(page):
    area = page.ele("css:.tencent-captcha-dy__image-area", timeout=4)
    STATE.mkdir(exist_ok=True)
    area.get_screenshot(path=str(STATE / "w2_live2.png"))
    img = Image.open(STATE / "w2_live2.png").convert("RGB")
    loc, size = area.rect.location, area.rect.size
    return area, img, loc, img.width / size[0]


def pick_targets(img, targets):
    boxes = find_boxes(img)
    cands = [{"box": b, "ocr": classify_box(img, b)} for b in boxes]
    picked, used = [], set()
    for t in targets:
        best, bs = None, -9.0
        for i, c in enumerate(cands):
            if i in used:
                continue
            so = 1.0 if t == c["ocr"] else (0.6 if t in c["ocr"] or c["ocr"] in t else 0.0)
            s = so * 1.2 + template_score(t, img, c["box"])
            if s > bs:
                bs, best = s, i
        if best is not None and bs >= 0.9:
            used.add(best)
            picked.append((t, cands[best]["box"]))
            continue
        # OCR 缺失 → 模板全图定位兜底（不刷新换题，用户令）
        peaks = template_locate(img, t)
        if peaks and peaks[0][0] >= 0.55 and (len(peaks) < 2 or peaks[0][0] - peaks[1][0] > 0.03):
            s, cx, cy = peaks[0]
            picked.append((t, (int(cx - 80), int(cy - 80), int(cx + 80), int(cy + 80))))
            print(f"  [tpl-locate] {t} @({cx:.0f},{cy:.0f}) score={s:.2f}")
    return picked, cands


def relocate_and_click(page, target, last_box, area_info, tries=6):
    """点击前瞬时重定位：现截图→局部模板峰→立刻点（应对动态字漂移）。"""
    for _ in range(tries):
        area, img, loc, scale = shot_area(page)
        x1, y1, x2, y2 = last_box
        cx, cy = (x1 + x2) / 2, (y1 + y2) / 2
        best, bs = (cx, cy), -9.0
        for dx in range(-72, 73, 12):
            for dy in range(-48, 49, 12):
                bx = (cx + dx - (x2 - x1) / 2, cy + dy - (y2 - y1) / 2,
                      cx + dx + (x2 - x1) / 2, cy + dy + (y2 - y1) / 2)
                s = template_score(target, img, bx)
                if s > bs:
                    bs, best = s, (cx + dx, cy + dy)
        css = (loc[0] + best[0] / scale, loc[1] + best[1] / scale)
        page.actions.move_to(css, duration=0.6)     # 慢移入（拟人）
        time.sleep(0.15)
        page.actions.click()
        print(f"  [click] {target} @img({best[0]:.0f},{best[1]:.0f}) tpl={bs:.2f}")
        return True
    return False


def harvest(page) -> str | None:
    jwt = None
    page.listen.start(["coding-plan/reset", "reset/status"])
    page.get(USAGE_URL)
    time.sleep(2)
    for pkt in page.listen.steps(timeout=18):
        try:
            auth = dict(pkt.request.headers).get("authorization", "")
            if auth.lower().startswith("bearer") and len(auth) > 40:
                jwt = auth
                break
        except Exception:                        # noqa: BLE001
            continue
    page.listen.stop()
    if jwt:
        (STATE / "zcode_jwt.txt").write_text(jwt, encoding="utf-8")
    return jwt


def main() -> int:
    page = ChromiumPage(ChromiumOptions().set_local_port(9341)
                        .set_user_data_path(str(ROOT / ".chrome-profile")))
    try:
        # 已登录直接收
        page.get(USAGE_URL)
        time.sleep(2.5)
        if "login" not in page.url:
            jwt = harvest(page)
            print("[live2] 已登录态，JWT", "✅" if jwt else "未捕获")
            return 0 if jwt else 3
        # 登录流
        page.get(LOGIN_URL)
        time.sleep(2.5)
        tab = page.ele("text:账号登录", timeout=3)
        if tab:
            tab.click()
            time.sleep(1.2)
        page.ele("css:input[placeholder='请输入用户名/邮箱/手机号']", timeout=4).clear().input(BM["phone"])
        page.ele("css:input[placeholder='请输入密码']", timeout=3).clear().input(BM["password"])
        try:
            for cb in page.eles("css:input[type=checkbox]"):
                if cb.states.is_displayed and not cb.states.is_checked:
                    cb.click()
                    time.sleep(0.3)
        except Exception:                        # noqa: BLE001
            pass
        btn = page.ele("xpath://button[normalize-space()='登录']", timeout=3)
        btn.click()
        time.sleep(3)
        for rnd in range(6):
            hdr = page.ele("css:.tencent-captcha-dy__header-text", timeout=2)
            if "login" not in page.url:
                break
            prompt = (hdr.text if hdr else "") or ""
            targets = re.findall(r"[一-鿿]", prompt.split("：")[-1]) if "：" in prompt else []
            print(f"[live2] r{rnd} 题面={prompt!r}")
            if not targets:
                return 5
            area, img, loc, scale = shot_area(page)
            picked, cands = pick_targets(img, targets)
            print(f"  识别={[c['ocr'] for c in cands]} 命中={[p[0] for p in picked]}")
            if len(picked) != len(targets):
                # 用户令：不刷新。降阈值模板重找缺的字
                for t in targets:
                    if any(p[0] == t for p in picked):
                        continue
                    peaks = template_locate(img, t)
                    if peaks and peaks[0][0] >= 0.42:
                        s, cx, cy = peaks[0]
                        picked.append((t, (int(cx - 80), int(cy - 80), int(cx + 80), int(cy + 80))))
                        print(f"  [tpl-retry] {t} @({cx:.0f},{cy:.0f}) score={s:.2f}")
            if len(picked) != len(targets):
                print("  仍缺字，等待 2s 后原地重试（不刷新）")
                time.sleep(2)
                continue
            import random as _rnd
            for t, box in picked:
                relocate_and_click(page, t, box, (area, loc, scale))
                time.sleep(_rnd.uniform(1.2, 2.6))   # 人类节奏（速度风控：太快=机器）
            time.sleep(0.6)
            cb = page.ele("css:.tencent-captcha-dy__verify-confirm-btn", timeout=2)
            if cb:
                cb.click()
            time.sleep(4)
            if "login" not in page.url:
                print("[live2] ✅ 验证码通过")
                break
            time.sleep(2)                          # 未过也不刷新，等下一轮自然出题
        if "login" in page.url:
            print("[live2] ❌ 6 轮未过")
            return 4
        jwt = harvest(page)
        print("[live2] 登录成功 JWT", "✅" if jwt else "未捕获")
        return 0 if jwt else 3
    finally:
        if "login" not in getattr(page, "url", "login"):
            try:
                page.quit()
            except Exception:                    # noqa: BLE001
                pass


if __name__ == "__main__":
    raise SystemExit(main())
