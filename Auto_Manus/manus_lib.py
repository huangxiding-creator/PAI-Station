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
    # 人机验证智能等待 (最长 ~50s) — 冒烟实测通常自动通过
    pw = None
    for _ in range(5):
        pw = page.ele("@placeholder=输入密码", timeout=2)
        if pw:
            break
        cont = page.ele("text=继续", timeout=2)
        if cont:
            cont.click()
            time.sleep(2)
            continue
        try:
            el = page.ele("input[type='checkbox']", timeout=1)
            if el:
                el.click()
                time.sleep(3)
        except Exception:
            pass
        time.sleep(3)
    if not pw:
        pw = page.ele("@placeholder=输入密码", timeout=5)
    if not pw:
        print("[lib] 密码框未出现 (人机验证未过)", flush=True)
        page.listen.stop()
        return None
    pw.clear()
    pw.input(password)
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


def ensure_login(page, email: str, password: str, timeout_s: int = 150):
    """登录态优先: 已登录直接复用 (零登出零重登); 仅未登录才走完整登录.

    返回 sessions 列表; 失败 None. 已登录但身份不符时才切换账号
    (切账号 = 一次完整登录, 这是多账号轮转的最小必要动作).
    """
    sessions = check_login(page)
    if sessions is not None:
        # 身份核对: 用已存 token 查 user_info, 不符才切换
        import manus_api as api
        tok = api.load_token(email)
        if tok:
            try:
                st, text = api.api_call(
                    page, "POST", "/user.v1.UserService/UserInfo", tok,
                    body={})
                if st == 200:
                    import json as _json
                    info = _json.loads(text)
                    logged = info.get("email") or info.get("data", {}).get("email", "")
                    if logged and logged.lower() != email.lower():
                        print(f"[lib] 登录态身份不符 ({logged} ≠ {email}) → 切换",
                              flush=True)
                        return login(page, email, password, timeout_s)
            except Exception:
                pass  # 查不到身份就按已登录复用 (宁可少登录)
        print(f"[lib] 登录态有效, 复用会话 (零重登): {email}", flush=True)
        return sessions
    print("[lib] 无登录态 → 完整登录一次", flush=True)
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

    路径 (DOM 实证 2026-09-22): 主界面 composer = contenteditable div →
    input(prompt) → 最后一个 button 发送 (Enter 兜底) → URL 跳 /app/<sid>.
    监听同步开着: 抓新建会话的真实 API 契约 (CLI 化素材).
    """
    import re
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
    sent = False
    # 发送按钮 = composer 祖先容器内最后一个 button (实证 div.contents)
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
            sent = True
        except Exception:
            pass
    sid_probe_deadline = time.time() + 8
    import re as _re
    while time.time() < sid_probe_deadline:
        m = _re.search(r"/app/([A-Za-z0-9_-]{8,})", page.url or "")
        if m:
            break
        time.sleep(1)
    if not sent:
        box = _composer(page)
        if box:
            page.actions.key_down("enter").key_up("enter")  # Enter 兜底

    sid = None
    deadline = time.time() + create_timeout_s
    while time.time() < deadline:
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
                "3）给出章节间的逻辑主线说明。成果文件名：research_plan.md。")
    elif use_case == "survey_plan":
        task = ("生成一份调研规划：1）不少于40个按主题分组的调研问题清单；"
                "2）公开信息渠道地图（按权威度分级，指出每类渠道适合回答哪些问题）；"
                "3）专家访谈提纲（若有）；4）调研优先级与风险点。"
                "成果文件名：survey_plan.md。")
    elif use_case == "collect":
        task = ("搜集整理该课题的公开资料并汇编：1）按主题分组的资料汇编，"
                "每条注明来源与可信度；2）关键数据表格（含来源标注）；"
                "3）指出尚无法从公开渠道获得的信息缺口。"
                "成果文件名：collected_materials.md。")
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
