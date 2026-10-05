# -*- coding: utf-8 -*-
"""Auto_Manus 共用库 — 登录/广告清理/账号加载/任务下发提示词/安全原语.

整合定位 (2026-09-22 批准): Manus = 异步生成腿 (非采集渠道), 服务
研究规划/调研规划/搜集资料三用途; 产出单独落库防一手语料污染.

账号安全四件套内建 (P3):
  1. 节流: 账号间隔默认 30s (原 5s 收紧 — 收紧免问, 放宽须批);
  2. 冷却: CircuitBreaker 连续 3 账号登录失败 → 停批冷却;
  3. 熔断: 封号关键词命中 → 立即全局停 + 落盘事件;
  4. 日限额: DayBudget (每账号每日 1 次下发, 批次账号数帽).
"""
from __future__ import annotations

import json
import sys
import time
from pathlib import Path

LOGIN_URL = "https://manus.im/login?type=signIn"
APP_URL = "https://manus.im/app"
LIST_SESSIONS = "https://api.manus.im/session.v1.SessionService/ListSessions"
AD_TRIGGER = "双倍积分促销！"
PROFILE_DIR = r"E:\AI-Station\Auto_Manus\.chrome_profile"
PROXY = "http://127.0.0.1:7890"
BROWSER_PORT = 9333

# 封号/风控关键词 — 命中即全局熔断
BAN_KEYWORDS = ("账号已被", "账号已停用", "暂停使用", "Account suspended",
                "account has been blocked", "Access denied")

BETWEEN_ACCOUNTS_S = 30      # 节流: 账号间隔 (原 main.py 5s 收紧)
MAX_CONSECUTIVE_FAILURES = 3  # 冷却: 连续 3 账号失败停批


# ---------------------------------------------------------------- 网络预检
# 0922 深夜重构: 原 ipinfo.io 判据在本机 rule 表下系统性假阳性 —
# 所有 IP 回显服务 (ipinfo/ifconfig/ip.sb/myip.ipip.net...) 被规则
# 分流 DIRECT → 探测永远显示 CN → 收割链每腿 rc=1 全灭 (2min 节奏
# = 3 attempts × 60s). 真判据两件:
#   1. 可达性 = urllib 走 7890 GET api.manus.im — 任何 HTTP 状态码
#      (含 404/401) = 网络层通, 仅 URLError/超时 = 不通;
#   2. 出口国 = Clash 组链 (api.manus.im 无专属规则 → 🐟 漏网之鱼
#      MATCH 兜底 → 🚀 手动切换 → 节点名), 描述流量真实走向, 比
#      IP 回显直连假象可靠. 统一网络管理: 只读组链, 不动网络.
CLASH_SECRET = "d42f2047-3a9e-45a1-9e1c-b6a91441588f"


def clash_ports() -> list[int]:
    """controller 口候选: config.yaml + 已知口 + 7890 监听进程回环口.

    H11 (0924 夜): controller 口三漂 (20225→40233→15198), config.yaml
    记录也失真 — 唯一可靠判据 = 7890 监听进程自己的 127.0.0.1 监听口.
    """
    import re as _re
    import subprocess as _sp
    ports: list[int] = [15198, 29069, 11845, 20225]
    try:
        cfg = Path.home() / ".config" / "clash" / "config.yaml"
        ports += [int(q) for q in _re.findall(
            r"external-controller:\s*127\.0\.0\.1:(\d+)",
            cfg.read_text(encoding="utf-8", errors="replace"))]
    except Exception:
        pass
    try:
        out = _sp.check_output(["netstat", "-ano"], timeout=15,
                               text=True, errors="replace")
        pid = next((ln.split()[-1] for ln in out.splitlines()
                    if "LISTENING" in ln and ":7890 " in ln), None)
        if pid:
            for ln in out.splitlines():
                f = ln.split()
                if (len(f) >= 5 and f[3] == "LISTENING" and f[-1] == pid
                        and f[1].startswith("127.0.0.1:")):
                    ports.append(int(f[1].rsplit(":", 1)[1]))
    except Exception:
        pass
    return list(dict.fromkeys(ports))


def _clash_group_chain() -> str:
    """读 Clash 组链: 漏网之鱼 → (组) → 节点名. 只读不动网."""
    import re
    import urllib.request
    ports = clash_ports()
    hdr = {"Authorization": "Bearer " + CLASH_SECRET}

    def get(base, name):
        from urllib.parse import quote
        r = urllib.request.Request(
            base + "/proxies/" + quote(name), headers=hdr)
        return json.loads(urllib.request.urlopen(r, timeout=4).read())

    for p in dict.fromkeys(ports):
        base = "http://127.0.0.1:" + str(p)
        try:
            urllib.request.urlopen(
                urllib.request.Request(base + "/version",
                                       headers=hdr), timeout=2).read()
        except Exception:
            continue
        # 0925 实锤: Clash 配置被切到新订阅 (无「🚀 手动切换」/「🐟 漏网之鱼」组,
        # 主组=Proxy→Auto-UrlTest) → 404 恒「Clash API 不可达」假死.
        # 修复: 组名按序降级 (漏网之鱼 → Others → Proxy), 哪个存在读哪个.
        for gname in ("🐟 漏网之鱼", "Others", "Proxy"):
            try:
                node = get(base, gname).get("now") or "?"
                for _ in range(3):  # 组套组最多跟 3 层
                    info = get(base, node)
                    if info.get("type") not in ("Selector", "URLTest",
                                                "Fallback", "LoadBalance"):
                        return node
                    node = info.get("now") or node
                return node
            except Exception:
                continue
        # 0924 实锤: config.yaml 口漂移后可能命中另一活 core
        # (无此组名) — 续试下一口, 不能一口失败就判死
        continue
    return "Clash API 不可达"


def ensure_network(page=None, timeout_s: int = 15) -> str:
    """网络预检 — 用户令 (2026-09-22): 首先就要检查网络, 不要用户提醒.

    可达性判据 = urllib 走 7890 打 api.manus.im (任何 HTTP 状态=通);
    出口判据 = Clash 组链节点名 (IP 回显服务被 rule 表分流直连=假阳性,
    0922 实锤). 出口节点非海外名 → 拒 (账号安全: 出口国一致性).
    统一网络管理令: 只探测不动网, 仍死 raise 由人工处置.
    """
    import urllib.error
    import urllib.request
    proxy = urllib.request.ProxyHandler({"http": PROXY, "https": PROXY})
    opener = urllib.request.build_opener(proxy)

    last_err = None
    for attempt in range(3):
        try:  # 1) 可达性: api.manus.im 网络层通
            opener.open("https://api.manus.im/",
                        timeout=timeout_s).read(64)
        except urllib.error.HTTPError:
            pass  # 404/401 等也是通
        except Exception as e:
            last_err = ("api.manus.im 不可达 " + type(e).__name__
                        + " " + str(e)[:50])
            if attempt < 2:
                print("[net] " + last_err + " → 等 60s 重测 (只探测不自愈)",
                      flush=True)
                time.sleep(60)
            continue
        try:  # 2) 出口: Clash 组链
            chain = _clash_group_chain()
            if any(k in chain for k in ("美国", "香港", "日本", "新加坡",
                                        "台湾", "韩国", "US", "HK", "JP")):
                return chain + "/api通"
            last_err = "出口链非海外(" + chain + ")"
        except Exception as e:
            last_err = "组链读取异常 " + type(e).__name__
        if attempt < 2:
            print("[net] 出口异常(" + last_err + ") → 等 60s 重测 "
                  "(只探测不自愈, 统一网络管理令)", flush=True)
            time.sleep(60)
    raise RuntimeError("代理出口不可用: " + str(last_err)
                       + " (人工处置, 勿自动切网)")


# ---------------------------------------------------------------- 账号加载
def load_accounts(account_file: str, limit: int | None = None):
    """读账号文件在役账号 — 返回 [(email, password)], 密码仅进程内流转."""
    accounts = []
    for line in Path(account_file).read_text(encoding="utf-8",
                                             errors="replace").splitlines():
        s = line.strip()
        if not s or s.startswith("#"):
            continue
        parts = s.split("|")
        if len(parts) >= 2 and "@" in parts[0]:
            accounts.append((parts[0].strip(), parts[1].strip()))
        if limit and len(accounts) >= limit:
            break
    return accounts


# ---------------------------------------------------------------- 浏览器
def make_page(port: int = BROWSER_PORT, profile: str = PROFILE_DIR,
              proxy: str = PROXY):
    """独立实例 (端口+目录双隔离, 绝不接管 EPC100/opencli 桥浏览器)."""
    from DrissionPage import Chromium, ChromiumOptions
    co = ChromiumOptions()
    co.set_proxy(proxy)
    co.set_paths(local_port=port, user_data_path=profile)
    co.set_argument("--no-first-run")
    co.set_argument("--no-default-browser-check")
    co.set_argument("--start-minimized")   # 0924 不弹窗铁律: 出生即最小化
    # 1003 用户令 (浏览器全最小化): Chrome 新版常忽略 start-minimized,
    # 离屏坐标双保险 — 窗口建在屏幕外, 不抢焦点不挡操作; 尺寸保留
    # 正常值防零尺寸渲染异常
    co.set_argument("--window-position=-32000,-32000")
    co.set_argument("--window-size=1280,900")
    return Chromium(co).latest_tab


# ---------------------------------------------------------------- 广告
def dismiss_ads(page) -> list:
    """关闭弹窗广告 (用户令 2026-09-22: 避免影响后续操作)."""
    from DrissionPage.common import Keys
    closed = []
    try:
        if page.ele(AD_TRIGGER, timeout=2):
            page.refresh()
            time.sleep(3)
            closed.append("refresh:" + AD_TRIGGER)
        for sel in ("@@tag()=button@@aria-label=close",
                    "@@tag()=button@@aria-label=Close"):
            try:
                btn = page.ele(sel, timeout=1)
                if btn:
                    btn.click()
                    time.sleep(1)
                    closed.append(sel[:28])
                    break
            except Exception:
                continue
        page.actions.key_down(Keys.ESCAPE)
        page.actions.key_up(Keys.ESCAPE)
    except Exception as e:
        closed.append(f"err:{type(e).__name__}")
    return closed


# ---------------------------------------------------------------- 登录
_JS_TURNSTILE_HOST = """
function() {
  var els = document.querySelectorAll('[class*="turnstile" i]');
  for (var i = 0; i < els.length; i++) {
    var r = els[i].getBoundingClientRect();
    if (r.width > 100 && r.height > 30) {
      return JSON.stringify({x: r.left, y: r.top, w: r.width, h: r.height});
    }
  }
  return 'NONE';
}
"""

_JS_BTN_DISABLED = """
function() {
  var btns = document.querySelectorAll('button');
  for (var i = 0; i < btns.length; i++) {
    if ((btns[i].textContent || '').trim() === '继续') return btns[i].disabled;
  }
  return null;
}
"""


def _handle_turnstile(page) -> bool:
    """Cloudflare Turnstile 可见复选框 (09-22 风控升级形态).

    实锤: iframe 藏 closed shadow root, 常规定位全失效; 但宿主容器
    div.turnstile-container 在主 DOM. 坐标点击复选框区 (宿主 x+58,
    垂直中心) → 「继续」解禁. 已实测全链路登录成功 (probe_ts6).
    返回 True=点击过.
    """
    import json as _json
    try:
        raw = page.run_js(_JS_TURNSTILE_HOST)
        if not raw or raw == "NONE":
            return False
        host = _json.loads(raw)
        page.actions.click((host["x"] + 58, host["y"] + host["h"] / 2))
        time.sleep(8)
        print("[lib] Turnstile 复选框已点击", flush=True)
        return True
    except Exception as e:
        print(f"[lib] Turnstile 处理异常: {type(e).__name__}", flush=True)
        return False


def _btn_continue_disabled(page):
    """「继续」按钮真实 disabled 态 (states.is_enabled 对此按钮有假象)."""
    try:
        return page.run_js(_JS_BTN_DISABLED)
    except Exception:
        return None


def _page_ban_hit(page) -> str | None:
    try:
        body = page.ele("tag:body")
        txt = (body.text or "") if body else ""
    except Exception:
        return None
    for kw in BAN_KEYWORDS:
        if kw in txt:
            return kw
    return None


def login(page, email: str, password: str, timeout_s: int = 150):
    """登录到 app 主界面, 返回 ListSessions 的 sessions 列表; 失败返回 None.

    会触发全局熔断信号 (抛 BanHitError) 当页面出现封号关键词.
    """
    class BanHitError(RuntimeError):
        pass
    try:
        page.set.cookies.clear()
    except Exception:
        pass
    page.get(LOGIN_URL)
    time.sleep(3)
    email_input = page.ele("#email", timeout=15)
    if not email_input:
        print(f"[lib] 未找到邮箱输入框 (页面漂移?)", flush=True)
        return None
    email_input.clear()
    email_input.input(email)

    page.listen.start(LIST_SESSIONS)
    # Turnstile 智能等待 (09-22 升级形态): 复选框不勾 → 「继续」禁用
    # → 密码框永不出现. 判据 = input[type=password] 可见 (placeholder
    # 已漂移, 不再用 @placeholder=输入密码).
    pw = None
    for _ in range(6):
        cand = page.ele("css:input[type='password']", timeout=2)
        if cand and cand.states.is_displayed:
            pw = cand
            break
        if _btn_continue_disabled(page) is True:
            _handle_turnstile(page)
        else:
            cont = page.ele("text=继续", timeout=2)
            if cont:
                cont.click()
        time.sleep(3)
    if not pw:
        cand = page.ele("css:input[type='password']", timeout=5)
        if cand and cand.states.is_displayed:
            pw = cand
    if not pw:
        print("[lib] 密码框未出现 (Turnstile/人机验证未过)", flush=True)
        page.listen.stop()
        return None
    pw.clear()
    pw.input(password)
    if _btn_continue_disabled(page) is True:
        _handle_turnstile(page)
    btn = page.ele("text=继续", timeout=5)
    if btn:
        btn.click()

    got = None
    deadline = time.time() + timeout_s
    while time.time() < deadline:
        ban = _page_ban_hit(page)
        if ban:
            page.listen.stop()
            raise BanHitError(f"封号关键词命中: {ban} ({email})")
        try:
            packet = page.listen.wait(timeout=3)
        except Exception:
            continue
        if not packet or packet.is_failed:
            continue
        try:
            body = packet.response.body
        except Exception:
            continue
        if isinstance(body, dict) and "sessions" in body:
            got = body
            break
    page.listen.stop()
    if got is None:
        return None
    sessions = got.get("sessions", [])
    if not sessions:
        print(f"[lib] {email} 会话数为 0 (空账号)", flush=True)
    ad = dismiss_ads(page)
    if ad:
        print(f"[lib] 广告清理: {ad}", flush=True)
    # 0924 串号根治: 登录完成即固化 token + 归属实证 (不符 = 登录失败)
    import manus_api as api
    try:
        tok = api.capture_token(page)
        api.save_token(email, tok)
        real = whoami_browser(page)
        if real and real != email.lower():
            print(f"[lib] ✗ 登录后身份仍不符 ({real} ≠ {email}) — 拒绝派发",
                  flush=True)
            return None
        print(f"[lib] ✓ 登录实证 {real or email}", flush=True)
    except Exception as e:
        print(f"[lib] token 固化异常 {type(e).__name__}: {str(e)[:50]}",
              flush=True)
    return sessions


# ---------------------------------------------------------------- 登录态优先复用
def check_login(page, wait_s: int = 12):
    """探测当前登录态 — 返回 sessions 列表; 未登录返回 None.

    用户令 (2026-09-22): 登录成功后不要反复退出再登录. 本函数只开
    APP_URL 被动监听, 绝不触发任何登出/登录动作.
    """
    page.listen.start(LIST_SESSIONS)
    page.get(APP_URL)
    deadline = time.time() + wait_s
    got = None
    while time.time() < deadline:
        if "/login" in (page.url or ""):
            break  # 被重定向到登录页 = 未登录
        try:
            packet = page.listen.wait(timeout=2)
        except Exception:
            continue
        if not packet or packet.is_failed:
            continue
        try:
            body = packet.response.body
        except Exception:
            continue
        if isinstance(body, dict) and "sessions" in body:
            got = body.get("sessions", [])
            break
    page.listen.stop()
    return got


def whoami_browser(page) -> str:
    """浏览器现役身份实证 — capture_token(现役) + UserInfo(urllib).

    0924 串号根治: 唯一可信判据是浏览器当前 token 的主人是谁,
    绝不信「token 文件名 == 登录者」(token 库污染实锤: 110 文件
    仅 23 把真 token). 返回小写 email; 查不到返回 ''.
    """
    import manus_api as api
    try:
        tok = api.capture_token(page)
    except Exception:
        return ""
    try:
        st, text = api.api_call(
            None, "POST", "/user.v1.UserService/UserInfo", tok, body={})
        if st == 200:
            import json as _json
            info = _json.loads(text)
            return (info.get("email")
                    or info.get("data", {}).get("email", "")).lower()
    except Exception:
        pass
    return ""


def ensure_login(page, email: str, password: str, timeout_s: int = 150):
    """登录态优先 — 但身份判据 = 浏览器现役 token 实证 (0924 重写).

    旧版 bug: 用目标账号自己的 token 查身份 = 同义反复, 永远"符合"
    → 无 token/污染 token 的账号全部复用上一个登录者 → 单任务堆到
    单账号 (j2phz0tkfk 16 单实锤). 新判据: whoami_browser 实证
    现役主人; 符合才复用并顺手固化正确 token, 不符/查不到 = 完整登录.
    """
    import manus_api as api
    logged = whoami_browser(page)
    if logged == email.lower():
        try:
            tok = api.capture_token(page)
            api.save_token(email, tok)  # 固化正确归属 (治库污染)
            return api.list_sessions(None, tok)
        except Exception:
            pass  # 身份已证实, sessions 拿不到也不阻断派发
        return []  # 已登录但列不出会话 — 视作空账号 (可派发)
    if logged:
        print(f"[lib] 登录态身份不符 ({logged} ≠ {email}) → 切换",
              flush=True)
    else:
        print("[lib] 现役身份不明 → 完整登录一次", flush=True)
    return login(page, email, password, timeout_s)


# ---------------------------------------------------------------- 任务状态机
def check_status(page) -> str:
    """DOM 状态机 (main.py 747 行验证版移植):
    working → interrupted → waiting_reply → completed → error → topup.

    注意: 侧栏常驻「升级」按钮不是 topup 信号 (免费版 CTA 永在),
    真 topup 判据 = '请升级您的套餐以获取更多积分。' 文本.
    """
    if page.ele("思考中", timeout=2) or page.ele("Manus 正在思考", timeout=2):
        return "working"
    for sel in ("@@tag()=button@@text()=继续",
                "@@tag()=button@@text()=继承并继续",
                "Manus 已停止，因为上下文过长，请开始一个新的对话"):
        if page.ele(sel, timeout=2):
            return "interrupted"
    if page.ele("Manus 将在你回复后继续工作", timeout=2):
        return "waiting_reply"
    for sel in ("text=查看此任务中的所有文件", "Manus 已完成", "text=任务已完成"):
        if page.ele(sel, timeout=2):
            return "completed"
    # 注意: '终止任务并退还积分' 是常驻菜单项, 不能作 error 判据 (误报实锤)
    for sel in ("发生了内部服务器错误。请稍后再试",
                "@@tag()=button@@text()=重置电脑"):
        if page.ele(sel, timeout=2):
            return "error"
    if page.ele("请升级您的套餐以获取更多积分。", timeout=2):
        return "topup"
    return "unknown"


# ---------------------------------------------------------------- 新任务下发
def _composer(page, timeout_s: int = 8):
    """任务输入框 — 实证为 contenteditable div (tiptap ProseMirror),
    非 textarea (主页/会话页同款)."""
    box = page.ele("xpath://*[@contenteditable='true']", timeout=timeout_s)
    return box


def send_task(page, prompt: str, create_timeout_s: int = 90):
    """从 app 主界面新建任务并发送 — 返回 (sid, 命中的 api 端点清单).

    0924 夜修: 切号登录后页面可能停在 chrome://newtab (登录实证≠在站)
    → 入口自愈: 不在 manus.im 域则先导航 APP_URL (已登录态会话直达).

    路径 (DOM 实证 2026-09-22): 主界面 composer = contenteditable div →
    input(prompt) → 最后一个 button 发送 (Enter 兜底) → URL 跳 /app/<sid>.
    监听同步开着: 抓新建会话的真实 API 契约 (CLI 化素材).
    """
    import re
    if "manus.im" not in (page.url or ""):   # 0924 夜修: newtab 自愈导航
        try:
            page.get(APP_URL)
            time.sleep(3)
        except Exception:
            pass
    dismiss_ads(page)
    box = _composer(page)
    if not box:
        raise RuntimeError("未找到 composer (contenteditable)")

    page.listen.start("api.manus.im")
    box.click()
    try:
        box.clear()
    except Exception:
        page.actions.key_down("ctrl").type("a")
        page.actions.key_up("ctrl")
    box.input(prompt)
    time.sleep(1.5)
    # 0925 实锤 (Manus 1.6 Lite 改版): 发送键 (svg 上箭头, btns[-1] 定位
    # 本身没错) 对程序化 click 免疫 — 元素 click()/坐标点击只触发埋点包
    # batch_create_event_v2, 任务创建请求根本不发; 唯真实键序 Enter 触发
    # 创建 (probe2 实证 Enter→sid 直落). 发送顺序反转: Enter 优先,
    # click 沦为兜底 (防未来改版回滚).
    box.click()                       # 焦点钉在 composer
    page.actions.key_down("enter").key_up("enter")
    import re as _re
    sid_probe_deadline = time.time() + 8
    while time.time() < sid_probe_deadline:
        if _re.search(r"/app/([A-Za-z0-9_-]{8,})", page.url or ""):
            break
        time.sleep(1)
    if not _re.search(r"/app/([A-Za-z0-9_-]{8,})", page.url or ""):
        # Enter 未中 → 老路兜底: 发送按钮 click
        anc, btn = box, None
        for _ in range(6):
            try:
                anc = anc.parent()
            except Exception:
                break
            btns = anc.eles("tag:button")
            if btns:
                btn = btns[-1]
                break
        if btn:
            try:
                btn.click()
            except Exception:
                pass

    sid = None
    deadline = time.time() + create_timeout_s
    while time.time() < deadline:
        # 0924 夜实锤: 积分尽时点发送弹「获取更多积分」对话框, 任务不会
        # 创建 — 早退省 80s 空等 (corps 侧另有 GetAvailableCredits 预检)
        if page.ele("text=获取更多积分", timeout=0.5):
            print("[lib] 积分墙 (获取更多积分弹窗), 本单中止", flush=True)
            break
        url = page.url or ""
        m = re.search(r"/app/([A-Za-z0-9_-]{8,})", url)
        if m:
            sid = m.group(1)
            break
        time.sleep(2)
    api_hits: list[str] = []
    drain_deadline = time.time() + 5
    while time.time() < drain_deadline:
        try:
            packet = page.listen.wait(timeout=1)
        except Exception:
            break
        if packet and not packet.is_failed:
            u = packet.url.split("?")[0]
            if u not in api_hits:
                api_hits.append(u)
    page.listen.stop()
    return sid, api_hits


# ---------------------------------------------------------------- 成果下载
def download_files(page, files_body: dict | str, out_dir, max_files: int = 10):
    """getSessionFilesV2 响应 → 下载文件. 结构 (实证): data.files[].raw[]
    每条含 filename/url (manuscdn 直链). 返回路径清单."""
    import json as _json
    d = files_body
    if isinstance(d, str):
        d = _json.loads(d)
    entries = []
    for f in (d.get("data", {}).get("files", []) or []):
        entries.extend(f.get("raw", []) or [])
    out = Path(out_dir)
    out.mkdir(parents=True, exist_ok=True)
    saved = []
    for f in entries[:max_files]:
        url = f.get("url")
        name = f.get("filename") or f.get("name") or "file"
        if not url:
            continue
        try:
            target = out / name
            if target.exists():
                saved.append(str(target))
                continue
            page.download(url, str(out), name)
            time.sleep(2)
            saved.append(str(target))
        except Exception as e:
            print(f"[lib] 下载失败 {name}: {type(e).__name__}", flush=True)
    return saved


def list_file_entries(files_body: dict | str) -> list:
    """文件清单 → [(filename, title, size, content_type)] 供展示."""
    import json as _json
    d = files_body
    if isinstance(d, str):
        d = _json.loads(d)
    entries = []
    for f in (d.get("data", {}).get("files", []) or []):
        entries.extend(f.get("raw", []) or [])
    return [(e.get("filename") or "?", e.get("title") or "",
             e.get("contentLength") or e.get("size") or 0,
             e.get("contentType") or "") for e in entries]


# ---------------------------------------------------------------- 提示词模板
def build_prompt(use_case: str, topic: str, extra: str = "") -> str:
    """三用途任务模板 — 轻任务形态 (快交付, 控积分), Markdown 成果.

    use_case: research_plan (研究规划) / survey_plan (调研规划) /
              collect (搜集资料)
    """
    base = "请针对课题《{topic}》完成以下任务，以Markdown文件交付成果，{extra_sec}只产出要求的内容，不要展开长篇撰写。"
    if use_case == "research_plan":
        task = ("生成一份深度研究报告的完整研究规划：1）不少于15章的报告结构，"
                "每章给出专业标题、本章核心洞察假设、3-5个内容要点；"
                "2）每章列出所需关键数据与事实清单（注明建议来源渠道类型）；"
                "3）给出章节间的逻辑主线说明。注意：规划中不要编造任何具体"
                "数字或事实，数据需求只描述需要找什么。"
                "成果文件名：research_plan.md。")
    elif use_case == "survey_plan":
        task = ("生成一份调研规划：1）不少于40个按主题分组的调研问题清单；"
                "2）公开信息渠道地图（按权威度分级，指出每类渠道适合回答哪些问题）；"
                "3）专家访谈提纲（若有）；4）调研优先级与风险点。"
                "注意：问题设计基于真实信息需求，不要预设未经证实的事实。"
                "成果文件名：survey_plan.md。")
    elif use_case == "collect":
        task = ("搜集该课题的公开资料并汇编成资料库。只基于实际检索到的原始"
                "资料，严禁编造：1）按主题分组，每条资料必须包含：来源名称、"
                "原文链接（URL）、发布时间、原文关键段落摘录（照抄原文，"
                "不要改写）；2）关键数据表格：每个数据注明出处链接与年份，"
                "查不到出处的数据一律不写；3）严禁用自己的话改写事实，"
                "没有资料支撑的内容不写；4）最后列出尚无法从公开渠道获得的"
                "信息缺口。成果文件名：collected_materials.md。")
    else:
        raise ValueError(f"未知用途: {use_case}")
    extra_sec = f"附加要求：{extra}。" if extra else ""
    return base.format(topic=topic, extra_sec=extra_sec) + task


# ---------------------------------------------------------------- 安全门
class CircuitBreaker:
    """连续失败冷却 + 封号熔断 — 四件套之冷却/熔断."""

    def __init__(self, max_failures: int = MAX_CONSECUTIVE_FAILURES,
                 state_path: str = "dispatch_safety.json"):
        self.max_failures = max_failures
        self.state_path = Path(state_path)
        self.consecutive = 0
        self.banned: list[str] = []
        self.dispatched_today = 0
        self.day = time.strftime("%Y-%m-%d")
        self._load()

    def _load(self):
        if not self.state_path.is_file():
            return
        try:
            d = json.loads(self.state_path.read_text(encoding="utf-8"))
            if d.get("day") == self.day:
                self.dispatched_today = int(d.get("dispatched_today", 0))
                self.banned = list(d.get("banned", []))
        except Exception:
            pass

    def save(self):
        self.state_path.write_text(json.dumps({
            "day": self.day, "dispatched_today": self.dispatched_today,
            "banned": self.banned,
            "consecutive": self.consecutive,
        }, ensure_ascii=False, indent=1), encoding="utf-8")

    def record_ok(self):
        self.consecutive = 0
        self.save()

    def record_fail(self) -> bool:
        """返回 False=继续, True=触发冷却停批."""
        self.consecutive += 1
        self.save()
        return self.consecutive >= self.max_failures

    def record_ban(self, email: str):
        if email not in self.banned:
            self.banned.append(email)
        self.save()

    def record_dispatch(self):
        self.dispatched_today += 1
        self.save()
