# -*- coding: utf-8 -*-
"""send_task 现场取证器 — 复现 corps 调用链并逐步取证:
1) APP_URL 落位 2) composer 存在性+输入是否注册 3) 按钮清单(disabled 态)
4) 点击后 URL/网络包 (CreateSession 是否发出) 5) 弹窗/Toast 扫描.
浏览器 = 现役 9333 (fill 刚登录完的账号), 不新开实例.
"""
import json
import sys
import time

sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_lib as lib

page = lib.make_page()   # 连接现役 9333, 不接管别的实例
print("start URL:", page.url, flush=True)
if "manus.im" not in (page.url or ""):
    page.get(lib.APP_URL)
    time.sleep(4)
else:
    page.get(lib.APP_URL)   # 统一回主界面
    time.sleep(4)
print("at APP:", page.url, flush=True)

# ---- 弹窗/对话框扫描
for sel in ("xpath://*[contains(@class,'modal') or contains(@class,'Modal')]",
            "xpath://*[@role='dialog']"):
    try:
        els = page.eles(sel, timeout=1)
        vis = [e for e in els if e.states.is_displayed]
        if vis:
            print(f"[modal] {sel[:40]} 可见 {len(vis)} 个: "
                  f"{(vis[0].text or '')[:60]!r}", flush=True)
    except Exception:
        pass

# ---- composer
box = page.ele("xpath://*[@contenteditable='true']", timeout=8)
if not box:
    print("FAIL: 无 composer", flush=True)
    page.get_screenshot(r"E:\AI-Station\Auto_Manus\probe_forensic.png")
    sys.exit(1)
print("[composer] 找到, tag=", box.tag, flush=True)

prompt = ("请搜集整理「中石化南京工程有限公司」EPC总承包业务的公开资料："
          "每条含来源名称、URL、发布时间与原文摘录。")
box.click()
time.sleep(0.5)
try:
    box.clear()
except Exception as e:
    print("[clear] 异常", type(e).__name__, flush=True)
box.input(prompt)
time.sleep(1.5)
# 输入是否注册 (tiptap: 文本应出现在 composer text 或内部 p)
registered = prompt[:15] in (box.text or "")
print(f"[composer] 输入注册={registered} 文本len={len(box.text or '')}", flush=True)
if not registered:
    try:
        html = box.html[:500]
        print("[composer.html]", html, flush=True)
    except Exception:
        pass

# ---- 按钮清单: 走祖先 (复现 send_task 逻辑) + 全局底部按钮
anc = box
for i in range(6):
    try:
        anc = anc.parent()
    except Exception:
        break
    btns = anc.eles("tag:button")
    if btns:
        print(f"[btns] L{i+1} 共{len(btns)}:", flush=True)
        for j, b in enumerate(btns):
            try:
                aria = b.attr("aria-label") or ""
                dis = b.attr("disabled")
                inner = (b.html or "")[:70].replace("\n", " ")
                print(f"  [{j}] aria={aria!r} disabled={dis} html={inner!r}",
                      flush=True)
            except Exception as e:
                print(f"  [{j}] 读失败 {type(e).__name__}", flush=True)
        break

# ---- 监听 + 点击发送
page.listen.start("api.manus.im")
sent_btn = None
anc2 = box
for _ in range(6):
    try:
        anc2 = anc2.parent()
    except Exception:
        break
    btns = anc2.eles("tag:button")
    if btns:
        sent_btn = btns[-1]
        break
clicked = False
if sent_btn:
    try:
        aria = sent_btn.attr("aria-label") or ""
        dis = sent_btn.attr("disabled")
        print(f"[send] 点 btns[-1] aria={aria!r} disabled={dis}", flush=True)
        sent_btn.click()
        clicked = True
    except Exception as e:
        print("[send] 点击异常", type(e).__name__, str(e)[:60], flush=True)
time.sleep(6)
url = page.url or ""
print("[after-click] URL:", url, flush=True)

# 网络包取证
hits = []
deadline = time.time() + 6
while time.time() < deadline:
    try:
        pk = page.listen.wait(timeout=1)
    except Exception:
        break
    if pk and not pk.is_failed:
        hits.append(pk.url.split("?")[0])
page.listen.stop()
print("[net] api.manus.im 包:", json.dumps(hits, ensure_ascii=False), flush=True)

# Enter 兜底 (若 URL 未跳)
if "/app/" not in url or url.rstrip("/").endswith("manus.im/app"):
    box2 = page.ele("xpath://*[@contenteditable='true']", timeout=3)
    if box2:
        page.listen.start("api.manus.im")
        box2.click()
        from DrissionPage.common import Keys
        page.actions.key_down(Keys.ENTER).key_up(Keys.ENTER)
        time.sleep(6)
        print("[after-enter] URL:", page.url, flush=True)
        hits2 = []
        dl = time.time() + 4
        while time.time() < dl:
            try:
                pk = page.listen.wait(timeout=1)
            except Exception:
                break
            if pk and not pk.is_failed:
                hits2.append(pk.url.split("?")[0])
        page.listen.stop()
        print("[net2]:", json.dumps(hits2, ensure_ascii=False), flush=True)

time.sleep(2)
page.get_screenshot(r"E:\AI-Station\Auto_Manus\probe_forensic.png")
print("截图落盘", flush=True)

# ---- Toast 正经扫描: 全 div 找含 toast/alert/msg 类名且可见
try:
    for d in page.eles("tag:div", timeout=2):
        try:
            cls = (d.attr("class") or "")
            if any(k in cls.lower() for k in ("toast", "alert", "notice", "message")) \
               and d.states.is_displayed:
                t = (d.text or "").strip()
                if t:
                    print("[toast]", t[:100], flush=True)
        except Exception:
            continue
except Exception:
    pass
print("取证完成", flush=True)
