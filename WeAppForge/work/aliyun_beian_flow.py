# -*- coding: utf-8 -*-
"""ICP备案向导驱动（DrissionPage，附加既有浏览器）。
modes:
  step1  选服务类型=网站 + 填网站域名 gcbrain.top + 存cookies快照（不点下一步，先校验态）
  dump   只做全景侦察（输入框/按钮/单选 清单+截图）
"""
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from DrissionPage import ChromiumPage, ChromiumOptions

SHOTS = Path(r"E:\AI-Station\WeAppForge\work\beian_shots")
SHOTS.mkdir(exist_ok=True)
COOKIES = Path(r"E:\AI-Station\data\state\aliyun_beian_cookies.json")


def attach():
    co = ChromiumOptions()
    co.set_browser_path(r"C:\Program Files\Google\Chrome\Application\chrome.exe")
    co.set_user_data_path(r"E:\AI-Station\data\state\aliyun_beian_profile")
    co.set_local_port(9335)
    return ChromiumPage(co)


def ctext(c):
    try:
        return c.text or ""
    except Exception:
        try:
            b = c.ele("xpath://body", timeout=2)
            return (b.text or "") if b else ""
        except Exception:
            return ""


def ctxs(page):
    out = [page]
    try:
        for f in page.eles("tag:iframe"):
            try:
                out.append(page.get_frame(f))
            except Exception:
                pass
    except Exception:
        pass
    return out


def shot(page, tag):
    try:
        p = SHOTS / f"{tag}_{int(time.time())}.png"
        page.get_screenshot(str(p))
        print("[shot]", p.name)
    except Exception as e:
        print("[shot-fail]", repr(e)[:100])


def save_cookies(page):
    try:
        data = page.cookies()
        COOKIES.write_text(json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")
        print(f"[cookies] saved {len(data)} 条 -> {COOKIES}")
    except Exception as e:
        print("[cookies-fail]", repr(e)[:100])


def inventory(page):
    for i, c in enumerate(ctxs(page)):
        try:
            for e in c.eles("tag:input")[:14]:
                print(f" ctx{i} input:", e.attr("id"), "| ph=", (e.attr("placeholder") or "")[:34],
                      "| type=", e.attr("type"), "| checked=", e.attr("checked"))
        except Exception:
            pass
        try:
            for e in c.eles("tag:button")[:14]:
                t = (e.text or "").strip().replace("\n", " ")[:26]
                if t:
                    print(f" ctx{i} button:", t)
        except Exception:
            pass


def do_step1(page):
    save_cookies(page)
    # 1) 服务类型选「网站」（单选/页签）
    done = False
    for c in ctxs(page):
        for sel in ("xpath://label[contains(.,'网站')]",
                    "xpath://*[self::span or self::div][text()='网站']",
                    "xpath://input[@type='radio'][@value='web' or contains(@value,'site')]/.."):
            try:
                e = c.ele(sel, timeout=1)
            except Exception:
                e = None
            if e:
                try:
                    e.click()
                    print("[click] 服务类型-网站:", sel)
                    done = True
                    break
                except Exception:
                    pass
        if done:
            break
    if not done:
        print("[warn] 未点到「网站」选择器（可能已默认选中）")
    time.sleep(1)
    # 2) 填网站域名
    dom = None
    for c in ctxs(page):
        for sel in ("xpath://input[contains(@placeholder,'域名')]",
                    "xpath://input[contains(@placeholder,'aliyun.com')]",
                    "xpath://input[contains(@name,'domain') or contains(@id,'domain')]",
                    "xpath://input[not(@type='password') and not(@type='radio')]"):
            try:
                e = c.ele(sel, timeout=1)
            except Exception:
                e = None
            if e and e.tag == "input":
                ph = e.attr("placeholder") or ""
                dom = e
                print("[domain-input] placeholder=", ph[:40], "id=", e.attr("id"))
                break
        if dom:
            break
    if not dom:
        print("STATUS=NO_DOMAIN_INPUT")
        shot(page, "s1_nodomain")
        return
    try:
        cur = dom.run_js("return this.value") or ""
    except Exception:
        cur = ""
    if "gcbrain.top" not in cur:
        dom.clear()
        dom.input("gcbrain.top")
        time.sleep(0.5)
    try:
        v = dom.run_js("return this.value") or ""
    except Exception:
        v = ""
    print("[verify] domain value =", v)
    shot(page, "s1_filled")
    print("STATUS=STEP1_FILLED（未点下一步，先看截图确认）")


def do_dump(page):
    print("url=", page.url, "title=", page.title)
    for i, c in enumerate(ctxs(page)):
        t = ctext(c).replace("\n", " | ")
        if t.strip():
            print(f"ctx{i} text[:1200]:", t[:1200])
    inventory(page)
    shot(page, "dump")


def do_next(page):
    """点「下一步」并侦察跳转后的页面。"""
    for c in ctxs(page):
        for sel in ("xpath://button[contains(.,'下一步')]", "text=下一步",
                    "xpath://span[text()='下一步']/.."):
            try:
                e = c.ele(sel, timeout=1)
            except Exception:
                e = None
            if e:
                try:
                    e.click()
                    print("[click] 下一步 ok")
                    time.sleep(6)
                    do_dump(page)
                    return
                except Exception as ex:
                    print("[click-fail]", repr(ex)[:80])
    print("STATUS=NO_NEXT_BUTTON")


def do_step3a(page):
    """第3步：填网站名称+备注；逐个点开下拉框dump选项（点网站名称输入框收起）。"""
    name = None
    for c in ctxs(page):
        for sel in ("xpath://input[contains(@placeholder,'需包含中文')]",):
            try:
                e = c.ele(sel, timeout=1)
                if e:
                    name = e
                    break
            except Exception:
                pass
        if name:
            break
    if not name:
        print("STATUS=NO_NAME_INPUT")
        shot(page, "s3_noname")
        return
    try:
        cur = name.run_js("return this.value") or ""
    except Exception:
        cur = ""
    if "工程知识学习笔记" not in cur:
        name.clear()
        name.input("工程知识学习笔记")
        time.sleep(0.5)
    try:
        print("[verify] 网站名称 =", name.run_js("return this.value"))
    except Exception:
        pass
    # 备注 textarea
    for c in ctxs(page):
        try:
            ta = c.ele("tag:textarea", timeout=1)
            if ta:
                ta.clear()
                ta.input("个人工程知识学习笔记与问答工具网站，用于建设工程行业技术知识的学习记录与整理，非经营性，不涉及前置审批项目。")
                print("[fill] 备注 ok")
                break
        except Exception:
            pass
    # 逐个下拉框
    for sid in ("rc_select_4", "rc_select_5", "rc_select_6", "rc_select_7", "rc_select_9", "rc_select_8"):
        for c in ctxs(page):
            try:
                s = c.ele(f"#{sid}", timeout=1)
            except Exception:
                s = None
            if not s:
                continue
            try:
                s.click()
                time.sleep(1.2)
                opts = []
                for oc in ctxs(page):
                    try:
                        for oe in oc.eles("xpath://div[contains(@class,'ant-select-item-option')]", timeout=0.5)[:14]:
                            t = (oe.text or "").strip().replace("\n", " ")[:40]
                            if t:
                                opts.append(t)
                    except Exception:
                        pass
                print(f"[dropdown {sid}] opts={opts}")
                shot(page, f"s3_dd_{sid}")
            except Exception as ex:
                print(f"[dropdown {sid}] fail {repr(ex)[:60]}")
            # 收起：点名称输入框
            try:
                name.click()
                time.sleep(0.5)
            except Exception:
                pass
            break
    print("STATUS=STEP3A_DONE")


def do_pick(page, sid, text):
    """打开 rc_select_N 下拉并点可见dropdown中的指定选项。"""
    s = None
    for c in ctxs(page):
        try:
            e = c.ele(f"#{sid}", timeout=1)
            if e:
                s = e
                break
        except Exception:
            pass
    if not s:
        print(f"[pick] {sid} not found")
        return False
    try:
        s.click()
        time.sleep(1.2)
        xp = ("xpath://div[contains(@class,'ant-select-dropdown') "
              "and not(contains(@class,'ant-select-dropdown-hidden'))]"
              f"//div[contains(@class,'ant-select-item-option')][normalize-space()='{text}']")
        opt = page.ele(xp, timeout=3)
        if not opt:
            xp = ("xpath://div[contains(@class,'ant-select-dropdown') "
                  "and not(contains(@class,'ant-select-dropdown-hidden'))]"
                  f"//div[contains(@class,'ant-select-item-option')][contains(normalize-space(),'{text}')]")
            opt = page.ele(xp, timeout=3)
        if opt:
            opt.click()
            time.sleep(0.8)
            print(f"[pick] {sid} -> {text} ok")
            return True
        print(f"[pick] {sid} option '{text}' not visible")
        return False
    except Exception as ex:
        print(f"[pick] {sid} fail {repr(ex)[:80]}")
        return False


def do_step3b(page):
    do_pick(page, "rc_select_4", "其他")
    do_pick(page, "rc_select_5", "中文简体")
    # 快速填写负责人（订单内负责人，第一个含姓名的按钮）
    for c in ctxs(page):
        try:
            b = c.ele("xpath://button[contains(.,'快速填写')]", timeout=1)
            if not b:
                b = c.ele("xpath://button[contains(.,'黄细丁')]", timeout=1)
            if b:
                b.click()
                print("[click] 快速填写-负责人 ok")
                time.sleep(2)
                break
        except Exception:
            pass
    time.sleep(1)
    shot(page, "s3b_filled")
    # 负责人区字段值侦察（打印除证件号外的值概况）
    for c in ctxs(page):
        try:
            for e in c.eles("tag:input")[:20]:
                try:
                    v = e.run_js("return this.value") or ""
                except Exception:
                    v = ""
                if v and e.attr("type") != "password":
                    ph = (e.attr("placeholder") or "")[:20]
                    print(f"  filled: ph={ph!r} len={len(v)}")
        except Exception:
            pass
    print("STATUS=STEP3B_DONE")


def open_select(page, sid):
    """点 rc_select_N（先点输入框，失败点其ant-select-selector父层）。"""
    for c in ctxs(page):
        try:
            s = c.ele(f"#{sid}", timeout=1)
        except Exception:
            s = None
        if not s:
            continue
        for target in (s,):
            try:
                target.click()
                time.sleep(1.2)
                return True
            except Exception:
                pass
        try:
            p = s.parent(1)
            if p:
                p.click()
                time.sleep(1.2)
                return True
        except Exception:
            pass
    return False


def visible_opts(page):
    opts = []
    xp = ("xpath://div[contains(@class,'ant-select-dropdown') "
          "and not(contains(@class,'ant-select-dropdown-hidden'))]"
          "//div[contains(@class,'ant-select-item-option')]")
    try:
        for oe in page.eles(xp, timeout=1)[:14]:
            t = (oe.text or "").strip().replace("\n", " ")[:48]
            if t and t not in opts:
                opts.append(t)
    except Exception:
        pass
    return opts


def do_step3c(page):
    """云服务+服务码两个下拉：逐个尝试打开，dump选项；含ECS字样自动选。"""
    for sid in ("rc_select_6", "rc_select_7", "rc_select_9"):
        ok = open_select(page, sid)
        opts = visible_opts(page) if ok else []
        print(f"[probe {sid}] open={ok} opts={opts}")
        shot(page, f"s3c_{sid}")
        if opts:
            target = None
            for o in opts:
                if "ECS" in o or "云服务器" in o:
                    target = o
                    break
            if target:
                do_pick(page, sid, target)
                time.sleep(1)
                continue
        # 收起
        try:
            page.ele("xpath://input[contains(@placeholder,'需包含中文')]", timeout=1).click()
            time.sleep(0.6)
        except Exception:
            pass
    shot(page, "s3c_final")
    print("STATUS=STEP3C_DONE")


def do_click(page, label):
    """按文字点按钮，然后侦察结果页。"""
    sels = (f"xpath://button[normalize-space()='{label}']",
            f"xpath://button[contains(.,'{label}')]",
            f"text={label}",
            f"xpath://span[text()='{label}']/..")
    for c in ctxs(page):
        for sel in sels:
            try:
                e = c.ele(sel, timeout=1)
            except Exception:
                e = None
            if e:
                try:
                    e.click()
                    print(f"[click] {label} ok")
                    time.sleep(6)
                    do_dump(page)
                    return True
                except Exception as ex:
                    print("[click-fail]", repr(ex)[:80])
    print(f"STATUS=NO_BUTTON_{label}")
    return False


def main():
    page = attach()
    mode = sys.argv[1] if len(sys.argv) > 1 else "dump"
    if mode == "step1":
        do_step1(page)
    elif mode == "next":
        do_next(page)
    elif mode == "click":
        do_click(page, sys.argv[2] if len(sys.argv) > 2 else "")
    elif mode == "step3a":
        do_step3a(page)
    elif mode == "step3b":
        do_step3b(page)
    elif mode == "step3c":
        do_step3c(page)
    else:
        do_dump(page)


if __name__ == "__main__":
    main()
