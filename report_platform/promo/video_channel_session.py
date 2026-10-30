# -*- coding: utf-8 -*-
"""video_channel_session — 视频号后台会话件 (1030 借永动机法, 免扫码链 v2).

架构实证 (1025+1030 侦察落账):
  1. 登录态真源 = 永动机 9222 常驻 Chrome + channels profile
     (chrome_guard 守护, cookie 落盘长命: 1030 实测 sessionid/wxuin 剩 ~400 天;
      产线旧链「两日过期」死局只存在于独立 Playwright storage_state 自建会话)
  2. 同 profile 第二实例违反 Chrome 单例 (9222 常驻占用中) → 「独立端口开
     同一 profile」路线不可行; 正确姿势 = attach 9222: 探测走 CDP 只读,
     操作走新 tab 用毕即关 (永动机 publisher 同款模式)
  3. 登录态移植独立实例不可行 (1025 实证: session 绑定 live profile)
     → 发布腿走 attach 9222 live context 新 tab (video_upload_live 模式)
  4. 免扫码复活 = 永动机 S366/S367 快捷登录法移植: login.html 内
     open.weixin.qq.com iframe XHR localhost.weixin.qq.com:14013
     (PC微信 WeChatAppEx handler) /api/check-login → /api/authorize →
     Weixin.exe Qt 弹窗自动点「允许」(窗口枚举检测 + 绿色像素/锁屏
     PostMessage 兜底) → redirect_url 经 iframe 信使交换 code → cookie
     落 profile。全程零扫码零人工, 唯一前提 = PC 微信在登录。

铁律 (1030 用户令):
  - 绝不 kill/重启 9222, 不动永动机既有 tab; 探测=只读, 操作=自家新 tab
  - 永动机发布中 (channels_publish.lock 持有者活) → 不碰, 让路
  - 本件永不弹码; 扫码仅快捷登录也失败时由人工跑 video_relogin.py

用法 (We-AIPO venv — DrissionPage/websocket-client/scipy 全在那):
  F:/We-AIPO/.venv/Scripts/python.exe -X utf8 video_channel_session.py --probe
      弱探测(CDP 只读 cookie) + 强探测(新 tab 页面级校验, 用毕即关)
  ... --ensure   探测 → 死则快捷登录复活 → 复验 (keeper/upload 前置件)
  ... --snapshot 只读 cookie 快照 → video_account_state.json (诊断账, 不再作发布凭据)
"""
from __future__ import annotations

import argparse
import ctypes
import json
import subprocess
import sys
import threading
import time
import urllib.request
from pathlib import Path

PROMO = Path(__file__).resolve().parent
STATE_FILE = PROMO / "video_account_state.json"
SESSION_LEDGER = PROMO / "video_session_state.json"      # keeper 台账
WEAIPO_LOCK = Path(r"F:\We-AIPO\data\state\channels_publish.lock")

CDP_BASE = "http://127.0.0.1:9222"
LOGIN_URL = "https://channels.weixin.qq.com/login.html"
HOME_URL = "https://channels.weixin.qq.com/platform/home"
HOME_STEM = "https://channels.weixin.qq.com"

# WeChat QR Connect 本地 handler 端口 (Widget 代码 W 列表, 永动机同款)
_WECHAT_PORTS = (14013, 14014, 14015, 13013, 13014, 13015)
_WECHAT_APPID = "wx20d84d087938fd46"
_REDIRECT_URI = ("https://channels.weixin.qq.com/platform/"
                 "oauth-callback.html?dark=1")

# ---- 窗口点击 (S367 法移植; 锁屏 PostMessage 固定点=0812-0819 三轮重现) ----
_POPUP_FALLBACK_XY = (213, 425)


def _log(msg: str) -> None:
    print(f"[vcs {time.strftime('%H:%M:%S')}] {msg}", flush=True)


# ══════════════════════════════════════════════════════════════
# CDP 只读层 (零 tab 操作, 免打扰红线)
# ══════════════════════════════════════════════════════════════

def _cdp_http(path: str, timeout: float = 5):
    with urllib.request.urlopen(f"{CDP_BASE}{path}", timeout=timeout) as r:
        return json.loads(r.read().decode("utf-8"))


def _cdp_ws(method: str, params: dict | None = None, timeout: float = 15):
    """一次 websocket CDP 调用 (browser 级, 如 Storage.getCookies)."""
    from websocket import create_connection
    ver = _cdp_http("/json/version")
    ws = create_connection(ver["webSocketDebuggerUrl"], timeout=timeout,
                           suppress_origin=True)
    try:
        ws.send(json.dumps({"id": 1, "method": method,
                            "params": params or {}}))
        return json.loads(ws.recv())
    finally:
        try:
            ws.close()
        except Exception:
            pass


def cdp_9222_alive() -> bool:
    try:
        ver = _cdp_http("/json/version")
        return bool(ver.get("Browser"))
    except Exception:
        return False


def probe_weak() -> dict:
    """弱探测: CDP Storage.getCookies 只读 — sessionid/wxuin 在场即弱活.

    零 tab 操作零导航。cookie 在场≠服务端 session 活 (强判走 probe_strong),
    但 cookie 缺席=必死, 且剩寿数据是 keeper 台账的账面资产。
    """
    out = {"ok": False, "alive": False, "sessionid_left_h": None,
           "channels_cookies": 0, "error": ""}
    try:
        resp = _cdp_ws("Storage.getCookies")
        cookies = resp.get("result", {}).get("cookies", [])
    except Exception as exc:
        out["error"] = f"cdp_fail: {exc}"
        return out
    ch = [c for c in cookies
          if "channels.weixin.qq.com" in (c.get("domain") or "")]
    names = {c["name"]: c for c in ch}
    out["ok"] = True
    out["channels_cookies"] = len(ch)
    now = time.time()
    sid = names.get("sessionid")
    if sid:
        exp = sid.get("expires", -1)
        if exp and exp > now:
            out["sessionid_left_h"] = round((exp - now) / 3600, 1)
    out["alive"] = ("sessionid" in names and "wxuin" in names)
    return out


def snapshot_state() -> int:
    """只读 cookie 快照 → video_account_state.json (诊断账, 不作发布凭据).

    1025 实证移植独立实例不可行 → 本落盘仅留 cookie 计数/剩寿审计用途。
    """
    try:
        resp = _cdp_ws("Storage.getCookies")
        cookies = resp.get("result", {}).get("cookies", [])
    except Exception as exc:
        _log(f"snapshot 失败: {exc}")
        return 1
    keep = [c for c in cookies
            if "channels.weixin.qq.com" in (c.get("domain") or "")]

    def slim(c):
        o = {"name": c["name"], "value": c["value"],
             "domain": c["domain"], "path": c.get("path", "/")}
        if c.get("expires", -1) > 0:
            o["expires"] = c["expires"]
        return o
    STATE_FILE.write_text(
        json.dumps({"cookies": [slim(c) for c in keep], "origins": []},
                   ensure_ascii=False, indent=1), encoding="utf-8")
    _log(f"snapshot: {len(keep)} channels cookies → {STATE_FILE.name}")
    return 0


# ══════════════════════════════════════════════════════════════
# 让路锁 (永动机发布中不碰 9222)
# ══════════════════════════════════════════════════════════════

def weaipo_busy() -> bool:
    """channels_publish.lock 持有进程活 = 永动机在发布视频 → 让路."""
    try:
        if not WEAIPO_LOCK.exists():
            return False
        pid = WEAIPO_LOCK.read_text().strip()
        if not pid.isdigit():
            return False
        r = subprocess.run(["tasklist", "/FI", f"PID eq {pid}"],
                           capture_output=True, text=True, timeout=10,
                           errors="replace")
        return pid in (r.stdout or "")
    except Exception:
        return False                                    # 读失败=保守不拦


# ══════════════════════════════════════════════════════════════
# 强探测 (DrissionPage attach 9222 新 tab, 页面级校验, 用毕即关)
# ══════════════════════════════════════════════════════════════

def _url_logged(url: str) -> bool:
    u = url or ""
    return ("channels.weixin.qq.com" in u
            and "/login" not in u.lower()
            and "oauth-callback" not in u)


def _is_logged_in_strong(tab, settle_s: float = 6.0) -> bool:
    """FIX-0816v2 强校验移植: 防 localStorage 缓存壳假阳性.

    死会话的 SPA 外壳会从 localStorage 缓存渲染 3-6s 后才跳 login —
    纯 URL 检查必假阳性。强证据 = 沉降后 URL 合法 且 (wujie-app 挂载
    或 存在≥1 个已认证 cgi-bin 资源调用)。
    """
    try:
        url = tab.url or ""
        if "channels.weixin.qq.com" not in url:
            return False
        if "/login" not in url:
            time.sleep(settle_s)                # 给假壳跳 login 留窗口
        url = tab.url or ""
        if not _url_logged(url):
            return False
        ev = tab.run_js(
            'var m = !!document.querySelector("wujie-app");'
            'var c = performance.getEntriesByType("resource")'
            '.filter(function(e){return e.name.indexOf("cgi-bin")>-1;}).length;'
            'return m + ":" + c;')
        parts = str(ev or "0:0").split(":")
        mounted = parts[0] == "True"
        calls = 0
        try:
            calls = int(parts[1])
        except Exception:
            pass
        return mounted or calls > 0
    except Exception:
        return False


def probe_strong(timeout_s: float = 45) -> dict:
    """强探测: attach 9222 → 自家新 tab → home 实测服务端 session → 关 tab.

    不动永动机既有 tab; 全程零扫码零输入。
    """
    out = {"ok": False, "alive": False, "url": "", "error": ""}
    if not cdp_9222_alive():
        out["error"] = "9222_down"
        return out
    tab = None
    try:
        from DrissionPage import Chromium
        b = Chromium(addr_or_opts="127.0.0.1:9222")
        tab = b.new_tab(HOME_URL)
        deadline = time.monotonic() + timeout_s
        logged = False
        url = ""
        while time.monotonic() < deadline:
            time.sleep(2)
            try:
                url = tab.url or ""
            except Exception:
                url = ""
            if _url_logged(url):
                # 再给强校验的沉降/渲染窗口 (内部自带 6s settle)
                if _is_logged_in_strong(tab, settle_s=4.0):
                    logged = True
                    break
            elif "/login" in (url or "").lower():
                break                                   # 明确被踢 = 死
        out["url"] = (url or "")[:80]
        out["alive"] = logged
        out["ok"] = True
    except Exception as exc:
        out["error"] = f"probe_fail: {exc}"
    finally:
        if tab is not None:
            try:
                tab.close()
            except Exception:
                pass
    return out


# ══════════════════════════════════════════════════════════════
# 快捷登录复活 (S366/S367 法移植, 全程零扫码)
# ══════════════════════════════════════════════════════════════

try:
    ctypes.windll.shcore.SetProcessDpiAwareness(2)     # 截图坐标必须 DPI 感知
except Exception:
    pass


class _LASTINPUTINFO(ctypes.Structure):
    _fields_ = [("cbSize", ctypes.c_uint), ("dwTime", ctypes.c_uint)]


def _idle_seconds() -> float:
    """用户键鼠空闲秒数 (不与用户抢鼠标的最小礼让)."""
    try:
        lii = _LASTINPUTINFO()
        lii.cbSize = ctypes.sizeof(lii)
        if ctypes.windll.user32.GetLastInputInfo(ctypes.byref(lii)):
            return max(0.0, (ctypes.windll.kernel32.GetTickCount()
                             - lii.dwTime) / 1000.0)
    except Exception:
        pass
    return 0.0


def _wait_user_idle(timeout: float = 8.0, threshold: float = 1.0) -> None:
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline and _idle_seconds() < threshold:
        time.sleep(0.5)


def _screen_locked() -> bool:
    """FIX-0819e: LogonUI 在场=锁屏 → 像素方案死路, 走 PostMessage."""
    try:
        r = subprocess.run(
            ["tasklist", "/FI", "IMAGENAME eq LogonUI.exe", "/FO", "CSV"],
            capture_output=True, text=True, timeout=5, errors="replace")
        return "LogonUI.exe" in (r.stdout or "")
    except Exception:
        return False


def _find_weixin_pids() -> set:
    try:
        r = subprocess.run(
            ["tasklist", "/FI", "IMAGENAME eq Weixin.exe", "/FO", "CSV",
             "/NH"], capture_output=True, text=True, timeout=8,
            errors="replace")
    except Exception:
        return set()
    pids = set()
    for line in (r.stdout or "").splitlines():
        if "Weixin" not in line:
            continue
        parts = line.strip('"').split('","')
        if len(parts) >= 2:
            try:
                pids.add(int(parts[1]))
            except ValueError:
                pass
    return pids


def _visible_windows() -> dict:
    import win32gui
    import win32process
    out = {}

    def cb(hwnd, _):
        if win32gui.IsWindowVisible(hwnd):
            try:
                _, pid = win32process.GetWindowThreadProcessId(hwnd)
            except Exception:
                pid = 0
            out[hwnd] = ((win32gui.GetWindowText(hwnd) or ""),
                         win32gui.GetClassName(hwnd) or "", pid)
    win32gui.EnumWindows(cb, None)
    return out


def _detect_wechat_popup(baseline: set, weixin_pids: set,
                         timeout: float = 15):
    """S367: 窗口枚举差集检测 Weixin.exe 新 Qt 弹窗 (比像素扫描可靠百倍)."""
    import win32gui
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        cur = _visible_windows()
        for hwnd in set(cur) - baseline:
            title, cls, pid = cur[hwnd]
            if pid in weixin_pids and "Qt" in cls:
                try:
                    rect = win32gui.GetWindowRect(hwnd)
                except Exception:
                    continue
                if rect[0] > -10000:                    # 排除最小化
                    return hwnd, rect
        time.sleep(0.5)
    return None, None


def _postmsg_click(hwnd, cx: int, cy: int) -> bool:
    """锁屏可用: WM_LBUTTONDOWN/UP 直接投递 (相对弹窗客户区坐标)."""
    import win32api
    import win32con
    import win32gui
    lparam = win32api.MAKELONG(cx, cy)
    for _ in range(3):
        if not win32gui.IsWindow(hwnd):
            time.sleep(0.3)
            continue
        try:
            win32gui.PostMessage(hwnd, win32con.WM_MOUSEMOVE, 0, lparam)
            time.sleep(0.05)
            win32gui.PostMessage(hwnd, win32con.WM_LBUTTONDOWN,
                                 win32con.MK_LBUTTON, lparam)
            time.sleep(0.08)
            win32gui.PostMessage(hwnd, win32con.WM_LBUTTONUP, 0, lparam)
            time.sleep(0.5)
            return True
        except Exception:
            time.sleep(0.3)
    return False


def _click_allow_button(hwnd, rect) -> bool:
    """点弹窗绿色「允许」: 锁屏→PostMessage 固定点; 否则前台+像素定位."""
    import win32con
    import win32gui
    if _screen_locked():
        _log("锁屏态 → PostMessage 点允许(固定坐标)")
        return _postmsg_click(hwnd, *_POPUP_FALLBACK_XY)
    try:
        win32gui.ShowWindow(hwnd, win32con.SW_RESTORE)
        win32gui.SetForegroundWindow(hwnd)
        time.sleep(1.5)
        rect = win32gui.GetWindowRect(hwnd)
    except Exception:
        pass
    try:
        import numpy as np
        import pyautogui
        ss = pyautogui.screenshot().crop(rect)
        arr = np.array(ss)
        h, w = arr.shape[:2]
        r = arr[:, :, 0].astype(int)
        g = arr[:, :, 1].astype(int)
        b = arr[:, :, 2].astype(int)
        green = ((g > 140) & (g < 240) & (r < 100) & (b > 40) & (b < 150)
                 & (g > r + 60))
        n = int(np.sum(green))
        if n > 200:
            try:
                from scipy import ndimage
                lab, num = ndimage.label(green)
                sizes = ndimage.sum(green, lab, range(1, num + 1))
                biggest = int(np.argmax(sizes)) + 1
                cy, cx = ndimage.center_of_mass(green, lab, biggest)
            except Exception:
                ys, xs = np.where(green)
                cy, cx = float(ys.mean()), float(xs.mean())
            sx, sy = int(rect[0] + cx), int(rect[1] + cy)
            _wait_user_idle()
            pyautogui.click(sx, sy)
            _log(f"已点绿色允许按钮 @({sx},{sy}) px={n}")
            return True
        _log(f"弹窗无绿色像素(px={n}) → 底部中心兜底")
    except Exception as exc:
        _log(f"像素定位失败({exc}) → PostMessage 兜底")
    fx = int(rect[0] + (rect[2] - rect[0]) * 0.5)
    fy = int(rect[1] + (rect[3] - rect[1]) * 0.75)
    if _screen_locked():
        return _postmsg_click(hwnd, *_POPUP_FALLBACK_XY)
    try:
        import pyautogui
        _wait_user_idle()
        pyautogui.click(fx, fy)
        return True
    except Exception:
        return _postmsg_click(hwnd, *_POPUP_FALLBACK_XY)


def _find_login_iframe(tab):
    for fr in tab.get_frames():
        if "open.weixin.qq.com" in (fr.url or ""):
            return fr
    return None


def _find_wechat_port(fr):
    """扫 WeChat 本地 handler 端口, 返回 (port, check-login 响应文本)."""
    for port in _WECHAT_PORTS:
        js = f'''
            return new Promise(function(resolve) {{
                var xhr = new XMLHttpRequest();
                xhr.open("POST",
                    "https://localhost.weixin.qq.com:{port}/api/check-login",
                    true);
                xhr.timeout = 3000;
                xhr.setRequestHeader("Content-Type", "application/json");
                xhr.onload = function() {{
                    try {{
                        var d = JSON.parse(xhr.responseText);
                        if (d.errcode === 0) resolve(xhr.responseText);
                        else resolve("PORT_OK_ERR:" + d.errcode);
                    }} catch(e) {{ resolve("PARSE_ERR"); }}
                }};
                xhr.onerror = function() {{ resolve("FAIL"); }};
                xhr.ontimeout = function() {{ resolve("TIMEOUT"); }};
                xhr.send(JSON.stringify({{
                    apiname: "qrconnectchecklogin",
                    jsdata: {{
                        appid: "{_WECHAT_APPID}",
                        scope: "snsapi_login",
                        redirect_uri: "{_REDIRECT_URI}",
                        state: "undefined"
                    }}
                }}));
            }});
        '''
        try:
            result = fr.run_js(js, timeout=8)
        except Exception:
            result = None
        if result and result not in ("FAIL", "TIMEOUT", "PARSE_ERR"):
            _log(f"handler 端口 {port} 可用")
            return port, result
    return None, None


def quick_login(max_retries: int = 3) -> bool:
    """免扫码复活 (S367 窗口检测版移植): PC 微信在场即全自动.

    在 9222 自家新 tab 里完成, 用毕关 tab; 让路锁由调用方 (ensure) 前置。
    """
    if not cdp_9222_alive():
        _log("9222 不在 — 无法快捷登录 (chrome_guard 守护缺位)")
        return False
    if not _find_weixin_pids():
        _log("PC 微信未运行 — 快捷登录前提不满足 (扫码兜底走 video_relogin)")
        return False
    from DrissionPage import Chromium
    b = Chromium(addr_or_opts="127.0.0.1:9222")
    tab = b.new_tab(LOGIN_URL)
    try:
        time.sleep(3)
        for attempt in range(1, max_retries + 1):
            _log(f"快捷登录第 {attempt}/{max_retries} 轮")
            fr = _find_login_iframe(tab)
            if not fr:
                _log("未见 open.weixin.qq.com iframe — 刷新重试")
                tab.get(LOGIN_URL)
                time.sleep(3)
                continue
            port, check_resp = _find_wechat_port(fr)
            if not port:
                _log("WeChat handler 端口全不可达 — 重试")
                time.sleep(5)
                continue
            try:
                check = json.loads(check_resp)
            except Exception:
                _log("check-login 解析失败 — 重试")
                continue
            auth_uuid = (check.get("jsdata") or {}).get("authorize_uuid", "")
            nickname = (check.get("jsdata") or {}).get("nickname", "")
            if not auth_uuid:
                _log("authorize_uuid 空 — 重试")
                time.sleep(5)
                continue
            _log(f"check-login OK nickname={nickname!r}")

            weixin_pids = _find_weixin_pids()
            baseline = set(_visible_windows())
            auth_result = [None]

            def _send_authorize():
                js_code = f'''
                    return new Promise(function(resolve) {{
                        var xhr = new XMLHttpRequest();
                        xhr.open("POST",
                            "https://localhost.weixin.qq.com:{port}"
                            + "/api/authorize", true);
                        xhr.timeout = 60000;
                        xhr.setRequestHeader(
                            "Content-Type", "application/json");
                        xhr.onload = function() {{
                            resolve(xhr.responseText); }};
                        xhr.onerror = function() {{
                            resolve("ERROR:" + xhr.status); }};
                        xhr.ontimeout = function() {{ resolve("TIMEOUT"); }};
                        xhr.send(JSON.stringify({{
                            apiname: "qrconnectfastauthorize",
                            jsdata: {{
                                data: JSON.stringify({{x: 360, y: 263}}),
                                appid: "{_WECHAT_APPID}",
                                scope: "snsapi_login",
                                redirect_uri: "{_REDIRECT_URI}",
                                state: "undefined",
                                authorize_uuid: "{auth_uuid}"
                            }}
                        }}));
                    }});
                '''
                try:
                    auth_result[0] = fr.run_js(js_code, timeout=65)
                except Exception as exc:
                    auth_result[0] = f"EXCEPTION:{exc}"

            th = threading.Thread(target=_send_authorize, daemon=True)
            th.start()
            _log("authorize 已发 — 等微信弹窗")
            hwnd, rect = _detect_wechat_popup(baseline, weixin_pids,
                                              timeout=15)
            if not hwnd:
                _log("弹窗未出现")
                th.join(timeout=5)
                time.sleep(5)
                continue
            if not _click_allow_button(hwnd, rect):
                _log("允许按钮点击失败")
                th.join(timeout=5)
                continue
            th.join(timeout=20)
            if not auth_result[0]:
                _log("authorize 无响应")
                continue
            try:
                auth = json.loads(auth_result[0])
            except Exception:
                _log(f"authorize 响应异常: {str(auth_result[0])[:120]}")
                continue
            redirect = (auth.get("jsdata") or {}).get("redirect_url", "")
            if auth.get("errcode") != 0 or not redirect:
                _log(f"authorize errcode={auth.get('errcode')} — 重试")
                continue
            # FIX-0819g: oauth-callback 是 iframe 信使页, 顶层打开时 code
            # 永不交换 — 必须导航 qrconnect iframe 本身, login.html 的
            # handleOAuthMessage 收 wx-oauth-code → 顶层自跳 platform/
            try:
                fr.get(redirect)
            except Exception:
                try:
                    fr.run_js(f"location.href = '{redirect}'",
                              as_expr=True)
                except Exception:
                    pass
            for _ in range(20):
                time.sleep(1)
                try:
                    u = tab.url or ""
                except Exception:
                    u = ""
                if (_url_logged(u)
                        and u.rstrip("/") != HOME_STEM):
                    break
            time.sleep(3)                       # cookie 收尾
            if _url_logged(tab.url or "") and \
                    _is_logged_in_strong(tab, settle_s=3.0):
                _log("快捷登录成功 (iframe 信使→顶层自跳)")
                return True
            tab.get(HOME_URL)                   # 兜底首页再验
            time.sleep(5)
            if _is_logged_in_strong(tab, settle_s=3.0):
                _log("快捷登录成功 (首页验证)")
                return True
            _log(f"仍未登录 (url={str(tab.url)[:60]}) — 下轮")
        return False
    finally:
        try:
            tab.close()
        except Exception:
            pass


# ══════════════════════════════════════════════════════════════
# ensure — keeper/upload 共用前置件
# ══════════════════════════════════════════════════════════════

def write_ledger(entry: dict) -> None:
    """video_session_state.json 台账 (merge 单键, 结构同永动机活检账本)."""
    old = {}
    try:
        old = json.loads(SESSION_LEDGER.read_text(encoding="utf-8"))
    except Exception:
        pass
    old.update(entry)
    SESSION_LEDGER.write_text(
        json.dumps(old, ensure_ascii=False, indent=1), encoding="utf-8")


def ensure(allow_quick_login: bool = True) -> dict:
    """探测 → 死则(让路检查)快捷登录复活 → 复验。永不弹码.

    返回 {"alive": bool, "via": "probe"|"quick_login"|"busy"|"dead", ...}
    """
    weak = probe_weak()
    _log(f"弱探测: alive={weak['alive']} cookies={weak['channels_cookies']} "
         f"sessionid_left_h={weak['sessionid_left_h']} err={weak['error']}")
    strong = probe_strong()
    _log(f"强探测: alive={strong['alive']} url={strong['url'][:60]} "
         f"err={strong['error']}")
    if strong["alive"]:
        return {"alive": True, "via": "probe", "weak": weak}
    if not allow_quick_login:
        return {"alive": False, "via": "dead", "weak": weak,
                "strong": strong}
    if weaipo_busy():
        _log("永动机发布中 (channels_publish.lock 活) — 让路不复活")
        return {"alive": False, "via": "busy", "weak": weak,
                "strong": strong}
    _log("登录态死 — 启动免扫码快捷登录复活")
    ok = quick_login()
    if ok:
        strong2 = probe_strong()
        if strong2["alive"]:
            weak2 = probe_weak()
            return {"alive": True, "via": "quick_login", "weak": weak2}
        return {"alive": False, "via": "login_but_probe_dead",
                "weak": weak, "strong": strong2}
    return {"alive": False, "via": "dead", "weak": weak, "strong": strong}


def main() -> int:
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass
    ap = argparse.ArgumentParser()
    ap.add_argument("--probe", action="store_true",
                    help="弱+强探测 (只读+自家tab, 不登录)")
    ap.add_argument("--ensure", action="store_true",
                    help="探测→死则快捷登录复活→复验")
    ap.add_argument("--snapshot", action="store_true",
                    help="只读 cookie 快照落盘 (诊断账)")
    ns = ap.parse_args()
    if ns.probe or ns.ensure or ns.snapshot:
        pass
    else:
        ns.probe = True
    rc = 0
    if ns.probe:
        weak = probe_weak()
        strong = probe_strong()
        _log(json.dumps({"weak": weak, "strong": strong},
                        ensure_ascii=False))
        rc = 0 if (weak["ok"] and strong["alive"]) else 1
    if ns.ensure:
        res = ensure()
        _log(f"ensure → alive={res['alive']} via={res['via']}")
        write_ledger({
            "last_run": time.strftime("%Y-%m-%d %H:%M:%S"),
            "alive": res["alive"],
            "via": res["via"],
            "sessionid_left_h": (res.get("weak") or {}).get(
                "sessionid_left_h"),
        })
        rc = 0 if res["alive"] else 1
    if ns.snapshot:
        rc = snapshot_state() or rc
    return rc


if __name__ == "__main__":
    sys.exit(main())
