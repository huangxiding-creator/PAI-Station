# -*- coding: utf-8 -*-
"""诊断探针4 — shadow DOM 深穿透定位 Turnstile + 坐标点击复选框.

实锤链 (09-22):
  - 视觉: Turnstile 复选框可见未勾选, 「继续」灰色禁用;
  - DOM: page.eles('tag:iframe') 找不到 challenges.cloudflare.com
    → widget 挂在 shadow root 内, 常规定位失效.
方案: JS 深穿透 (querySelectorAll + shadowRoot 递归) 拿 iframe rect
→ actions 坐标点击复选框区 (左侧 ~22px) → 等「继续」真解禁 → 完整登录.
"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_api as api
import manus_lib as lib

EMAIL, PASSWORD = lib.load_accounts("账号列表 - 调试.txt")[0]

_JS_FIND_TS = """
function() {
  function walk(root, acc) {
    root.querySelectorAll('iframe').forEach(function(f){acc.push(f);});
    root.querySelectorAll('*').forEach(function(el){
      if (el.shadowRoot) walk(el.shadowRoot, acc);
    });
    return acc;
  }
  var frames = walk(document, []);
  for (var i = 0; i < frames.length; i++) {
    var src = frames[i].src || '';
    if (src.indexOf('challenges.cloudflare.com') >= 0) {
      var r = frames[i].getBoundingClientRect();
      return JSON.stringify({x: r.left, y: r.top, w: r.width, h: r.height,
                             src: src.slice(0, 70)});
    }
  }
  return 'NONE';
}
"""

_JS_BTN_STATE = """
function() {
  var btns = document.querySelectorAll('button');
  for (var i = 0; i < btns.length; i++) {
    var t = (btns[i].textContent || '').trim();
    if (t === '继续') {
      return JSON.stringify({disabled: btns[i].disabled,
                             aria: btns[i].getAttribute('aria-disabled'),
                             cls: btns[i].className.slice(0, 60)});
    }
  }
  return 'NOBTN';
}
"""


def find_ts(page):
    raw = page.run_js(_JS_FIND_TS)
    if not raw or raw == "NONE":
        return None
    return json.loads(raw)


page = lib.make_page()
print(f"[probe] 出口: {lib.ensure_network(page)}", flush=True)

page.get(lib.LOGIN_URL)
time.sleep(4)
email_input = page.ele("#email", timeout=15)
email_input.clear()
email_input.input(EMAIL)
time.sleep(2)

ts = find_ts(page)
print(f"[probe] 深穿透 Turnstile: {ts}", flush=True)
print(f"[probe] 按钮初始态: {page.run_js(_JS_BTN_STATE)}", flush=True)
if ts is None:
    print("[probe] 深穿透也没找到 — 再等 5s 重试", flush=True)
    time.sleep(5)
    ts = find_ts(page)
    print(f"[probe] 重试: {ts}", flush=True)

if ts:
    cx = ts["x"] + 22          # 复选框在 widget 左侧
    cy = ts["y"] + ts["h"] / 2
    page.actions.click(cx, cy)
    print(f"[probe] 已坐标点击 ({cx:.0f},{cy:.0f})", flush=True)
    time.sleep(7)
    page.get_screenshot("probe_ts4_clicked.png")
    print(f"[probe] 点击后按钮态: {page.run_js(_JS_BTN_STATE)}", flush=True)

    # 没解禁再点一次 (首次点击可能只是聚焦)
    state = page.run_js(_JS_BTN_STATE) or ""
    if '"disabled":true' in state or '"aria":"true"' in state:
        page.actions.click(cx, cy)
        time.sleep(7)
        print(f"[probe] 二次点击后: {page.run_js(_JS_BTN_STATE)}", flush=True)
        page.get_screenshot("probe_ts4_clicked2.png")

state = page.run_js(_JS_BTN_STATE) or ""
ok = '"disabled":false' in state and '"aria"' not in state.replace('"aria":null', '')
print(f"[probe] 按钮可点判定: {ok} ({state})", flush=True)

cont = page.ele("text=继续", timeout=3)
if cont:
    cont.click()
print("[probe] 已点继续, 等密码框…", flush=True)
pw = None
deadline = time.time() + 20
while time.time() < deadline:
    cand = page.ele("css:input[type='password']", timeout=2)
    if cand and cand.states.is_displayed:
        pw = cand
        break
    time.sleep(2)
print(f"[probe] 密码框可见: {bool(pw)}", flush=True)
if not pw:
    page.get_screenshot("probe_ts4_no_pw.png")
    print("[probe] FAIL: 密码框仍未出现", flush=True)
    sys.exit(1)

pw.clear()
pw.input(PASSWORD)
time.sleep(1)
btn = page.ele("text=继续", timeout=3)
if btn:
    btn.click()
print("[probe] 已提交密码, 等登录…", flush=True)

page.listen.start(lib.LIST_SESSIONS)
got = None
deadline = time.time() + 60
while time.time() < deadline:
    url = page.url or ""
    if "/app" in url and "/login" not in url:
        got = "url:" + url[:60]
        break
    try:
        packet = page.listen.wait(timeout=3)
    except Exception:
        continue
    if packet and not packet.is_failed:
        try:
            if isinstance(packet.response.body, dict) and \
                    "sessions" in packet.response.body:
                got = "sessions:" + str(
                    len(packet.response.body["sessions"]))
                break
        except Exception:
            continue
page.listen.stop()
print(f"[probe] 登录结果: {got}", flush=True)
page.get_screenshot("probe_ts4_result.png")
if got:
    tok = api.capture_token(page)
    api.save_token(EMAIL, tok)
    print(f"[probe] token 已存: {EMAIL} — 修复方案成立!", flush=True)
print("[probe] done", flush=True)
