# -*- coding: utf-8 -*-
"""无头浏览器生命周期四合一件 browser/kit.py（T07；支撑 FR2/FR3/FR5/FR7）。

四合一 = UA 策略 + cookie 逐条注入 + route 屏蔽清单 + expect_download 下载捕获，
一个 ``BrowserKit`` 生命周期内开上下文/收口全走本件（SYNTHESIS §2-9 第 9 件）。

三策略并存（任务卡 + 各 SPEC）：
- **wenku**（FR2，WENKU_SPEC §4.1）：每生命周期随机一个桌面 UA **全程复用**；
  cookie 串按 ';' 拆成 name/value **逐条注入** ``.baidu.com``（domain 带点，会话 cookie）；
  流量闸门**三组正则**（静态/埋点/业务噪声）只挂签名窗/首跳窗上下文——
  数据端点（view 页/pageLoadUrl/PNG/字体/readerinfo）纯 httpx 直连，不经此路由。
- **csdn**（FR5，CSDN_SPEC §1.2/§1.3）：硬编码伪装 UA（macOS Chrome 120）；
  persist 分区=``storage_state`` 持久化（等价原作 ``session.fromPartition('persist:csdn')``）；
  cookie 逐条注入 ``.csdn.net`` + ``expires=now+30天``；广告域 substring 屏蔽（URL 包含即拦）；
  下载=``expect_download`` 30s 超时 + ``suggested_filename`` 落盘（等价 will-download）。
- **book118**（FR3，BOOK118_SPEC §5）：**仅首跳**——真浏览器过 TLS/JA3 指纹墙取 NewView 页
  HTML 后立即收口；openapi/图床等数据层纯 http，不进本件。

通用上下文（generic）供 FR7 L3 无头渲染兜底（截图→拼PDF→OCR）复用同一生命周期纪律。
Playwright 统一 sync API；launch/close 由调用方 fixture 管理（测试公约：禁止并行开多浏览器）。
"""
from __future__ import annotations

import random
import re
import time
from pathlib import Path
from typing import Callable, Sequence

from playwright.sync_api import Browser, BrowserContext, Download, Page

# ---------------------------------------------------------------- UA 策略

#: 桌面 UA 池（wenku/book118/通用策略随机取一、生命周期内复用；仅桌面、无移动端混入）
DESKTOP_UA_POOL: tuple[str, ...] = (
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/139.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/135.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Windows NT 11.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/138.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/139.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/136.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0",
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/137.0.0.0 Safari/537.36",
)

#: csdn 策略=硬编码伪装 UA（CSDN_SPEC §3：刻意伪装，不随机）
CSDN_UA = ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 "
           "(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")


def pick_desktop_ua(rng: random.Random | None = None) -> str:
    """从桌面池随机取一个 UA（rng 可注入=测试确定性；None=真随机）。"""
    return (rng or random).choice(DESKTOP_UA_POOL)


# ---------------------------------------------------------------- cookie 逐条注入

WENKU_COOKIE_DOMAIN = ".baidu.com"    # 带点：覆盖 wenku.baidu.com 全子域（WENKU_SPEC §4.1-2）
CSDN_COOKIE_DOMAIN = ".csdn.net"      # 带点：覆盖全部 *.csdn.net（CSDN_SPEC §2-1）
CSDN_COOKIE_TTL_SECONDS = 30 * 24 * 3600  # expires=now+30 天（CSDN_SPEC §1.3-2）


def parse_cookie_str(cookie_str: str) -> list[tuple[str, str]]:
    """原始 ``k1=v1; k2=v2`` 串 → [(name, value)]。

    按 ';' 拆段、按**第一个** '=' 拆 name/value（值可含 '='，base64 安全），不过滤字段。
    畸形段（缺 '=' / name 空）fail-fast；错误信息**不回显段内容**（凭据永不入日志）。
    """
    pairs: list[tuple[str, str]] = []
    for pos, seg in enumerate(cookie_str.split(";"), start=1):
        seg = seg.strip()
        if not seg:
            continue
        name, eq, value = seg.partition("=")
        if not eq or not name:
            raise ValueError(
                f"cookie 串第 {pos} 段缺 '=' 或 name 为空（逐条解析失败即拒；段内容不回显防凭据泄漏）")
        pairs.append((name, value))
    return pairs


def inject_cookies(context: BrowserContext, cookie_str: str, *, domain: str,
                   ttl_seconds: int | None = None) -> int:
    """cookie 串**逐条**注入上下文（每对一次 add_cookies，等价原作 cookies.set 循环）。

    ttl_seconds=None → 会话 cookie（wenku 语义）；给值 → expires=now+ttl（csdn 30 天语义）。
    返回注入条数（如实计数）。
    """
    count = 0
    for name, value in parse_cookie_str(cookie_str):
        cookie = {"name": name, "value": value, "domain": domain, "path": "/"}
        if ttl_seconds is not None:
            cookie["expires"] = int(time.time()) + ttl_seconds
        context.add_cookies([cookie])
        count += 1
    return count


# ---------------------------------------------------------------- route 屏蔽清单（参数化）

#: wenku 闸门三组正则（WENKU_SPEC §4.1-3 原文，逐字符照抄；re.search 语义）
WENKU_BLOCKLIST_GROUPS: dict[str, tuple[str, ...]] = {
    "static": (
        r"\.(png|jpg|jpeg|gif|svg|woff|woff2|ttf|css)(\?|$)",  # 静态资源
    ),
    "tracking": (
        r"click\.gif|hmlog|fclog|sclog|pbslog|wkctj|hm\.baidu|hectorstatic",  # 埋点
    ),
    "business_noise": (
        r"wenku\.baidu\.com/(gsula|gdoc|goods|user|customer|"
        r"ndocview/(geteditedbydocids|incrview|interface))",  # 业务噪声
    ),
}

WENKU_BLOCKLIST_REGEXES: tuple[str, ...] = tuple(
    p for group in WENKU_BLOCKLIST_GROUPS.values() for p in group)

#: csdn 广告/追踪域清单（CSDN_SPEC §1.2-4 原文；substring 语义=URL 包含即拦）
CSDN_AD_DOMAINS: tuple[str, ...] = (
    "clarity.ms",
    "dup.baidustatic.com",
    "push.zhanzhang.baidu.com",
    "toutiao.com",
    "googlesyndication",
    "doubleclick",
)


def is_url_blocked(url: str, *, regexes: Sequence[str | re.Pattern[str]] = (),
                   substrings: Sequence[str] = ()) -> bool:
    """屏蔽判定（纯函数）：regexes 走 re.search，substrings 走包含匹配。"""
    for pattern in regexes:
        if re.search(pattern, url) if isinstance(pattern, str) else pattern.search(url):
            return True
    return any(s in url for s in substrings)


def install_route_blocklist(target: BrowserContext | Page, *,
                            regexes: Sequence[str | re.Pattern[str]] = (),
                            substrings: Sequence[str] = ()) -> None:
    """给上下文/页装参数化屏蔽闸门（等价原作 webRequest.onBeforeRequest cancel）。

    命中 → route.abort()（连接前拦截，零外网）；未命中 → route.continue_()。
    屏蔽清单由调用方参数化传入（wenku=三组正则 / csdn=广告域 substring / book118=不装）。
    """
    compiled = tuple(re.compile(p) if isinstance(p, str) else p for p in regexes)

    def _gate(route) -> None:
        if is_url_blocked(route.request.url, regexes=compiled, substrings=substrings):
            route.abort()
        else:
            route.continue_()

    target.route("**/*", _gate)


# ---------------------------------------------------------------- expect_download 下载捕获

DOWNLOAD_TIMEOUT_MS = 30_000  # csdn 下载整体 30s 超时（CSDN_SPEC §1.3-10）
NAV_TIMEOUT_MS = 30_000       # 首跳导航默认超时


def capture_download(page: Page, trigger: Callable[[], None],
                     *, timeout_ms: int = DOWNLOAD_TIMEOUT_MS) -> Download:
    """先挂 expect_download 再触发点击（顺序不可倒），超时抛 Playwright TimeoutError。

    等价映射：Electron ``session.once('will-download')`` + 30s 整体超时（CSDN_SPEC §5 表）。
    """
    with page.expect_download(timeout=timeout_ms) as dl_info:
        trigger()
    return dl_info.value


def save_download(download: Download, save_dir: str | Path) -> Path:
    """按服务器给的 ``suggested_filename``（等价 item.getFilename()）落盘并返回路径。

    本地不重命名（CSDN_SPEC §1.3-11）；save_dir 不存在则创建。
    """
    out_dir = Path(save_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    target = out_dir / download.suggested_filename
    download.save_as(str(target))
    return target


# ---------------------------------------------------------------- 生命周期四合一件

WENKU_VIEWPORT = {"width": 1400, "height": 900}  # 隐藏窗 1400×900（WENKU_SPEC §4.1-4）
CSDN_VIEWPORT = {"width": 1280, "height": 900}   # 隐藏窗 1280×900（CSDN_SPEC §1.2-3）


class BrowserKit:
    """无头浏览器生命周期四合一件：一个 kit = 一个随机桌面 UA + 该浏览器上的上下文台账。

    launch/close 由调用方（测试 fixture / orchestrator）管；本件只管上下文级生命周期
    （开上下文 → 注入 UA/cookie/闸门 → 用 → close_all 收口），``open_context_count``
    如实反映在册未收口上下文数。
    """

    def __init__(self, browser: Browser, *, user_agent: str | None = None,
                 rng: random.Random | None = None):
        self.browser = browser
        #: 每生命周期随机一个桌面 UA，全程复用（wenku 语义；csdn 上下文例外用 CSDN_UA）
        self.user_agent = user_agent or pick_desktop_ua(rng)
        self._contexts: list[BrowserContext] = []

    # ---- 台账 -------------------------------------------------------------
    @property
    def open_context_count(self) -> int:
        """在册上下文数（book118 首跳即出册；close_all 后应为 0）。"""
        return len(self._contexts)

    def close_all(self) -> int:
        """收口全部在册上下文（幂等），返回本次实际关闭数。"""
        closed = 0
        for ctx in self._contexts:
            ctx.close()
            closed += 1
        self._contexts.clear()
        return closed

    def _track(self, ctx: BrowserContext) -> BrowserContext:
        self._contexts.append(ctx)
        return ctx

    # ---- 三策略 + 通用 ----------------------------------------------------
    def wenku_context(self, cookie_str: str = "") -> BrowserContext:
        """wenku 策略：随机桌面 UA（kit 级复用）+ .baidu.com 逐条 cookie + 闸门三组正则。

        cookie_str 为空则不注入（匿名首跳）；闸门只挂本上下文（签名窗/首跳窗语义），
        数据端点纯 httpx 不经此路由（WENKU_SPEC §9）。
        """
        ctx = self.browser.new_context(user_agent=self.user_agent,
                                       viewport=dict(WENKU_VIEWPORT))
        self._track(ctx)
        install_route_blocklist(ctx, regexes=WENKU_BLOCKLIST_REGEXES)
        if cookie_str:
            inject_cookies(ctx, cookie_str, domain=WENKU_COOKIE_DOMAIN)  # 会话 cookie
        return ctx

    def csdn_context(self, cookie_str: str = "",
                     *, storage_path: str | Path | None = None) -> BrowserContext:
        """csdn 策略：硬编码伪装 UA + persist 分区（storage_state）+ 广告域屏蔽 + 可下载。

        storage_path 存在则载入（persist:csdn 等价：登录态跨次复用）；
        cookie_str 非空则逐条注入 .csdn.net（expires=now+30 天）。
        """
        kwargs: dict = {"user_agent": CSDN_UA, "viewport": dict(CSDN_VIEWPORT),
                        "accept_downloads": True}
        if storage_path is not None and Path(storage_path).exists():
            kwargs["storage_state"] = str(storage_path)
        ctx = self.browser.new_context(**kwargs)
        self._track(ctx)
        install_route_blocklist(ctx, substrings=CSDN_AD_DOMAINS)
        if cookie_str:
            inject_cookies(ctx, cookie_str, domain=CSDN_COOKIE_DOMAIN,
                           ttl_seconds=CSDN_COOKIE_TTL_SECONDS)
        return ctx

    def persist_storage_state(self, context: BrowserContext,
                              storage_path: str | Path) -> Path:
        """把上下文登录态（cookies/origins）持久化到 storage_state 文件并返回路径。"""
        path = Path(storage_path)
        path.parent.mkdir(parents=True, exist_ok=True)
        context.storage_state(path=str(path))
        return path

    def book118_first_hop(self, url: str, *, timeout_ms: int = NAV_TIMEOUT_MS) -> str:
        """book118 策略：仅首跳——真浏览器加载 NewView 页取 HTML，取完立即收口。

        无 cookie、无闸门（首跳只要真浏览器指纹过 TLS/JA3 墙，BOOK118_SPEC §3 指纹墙实证）；
        后续 openapi/图床属数据层纯 http，不进本件。导航失败同样收口（finally）后抛错。
        """
        ctx = self.browser.new_context(user_agent=self.user_agent)
        self._track(ctx)
        page = ctx.new_page()
        try:
            page.goto(url, timeout=timeout_ms)
            return page.content()
        finally:
            ctx.close()
            self._contexts.remove(ctx)

    def generic_context(self, *, viewport: dict | None = None,
                        accept_downloads: bool = True) -> BrowserContext:
        """通用策略：kit 级随机桌面 UA + 可选 viewport（FR7 L3 无头渲染兜底用）。"""
        ctx = self.browser.new_context(user_agent=self.user_agent, viewport=viewport,
                                       accept_downloads=accept_downloads)
        return self._track(ctx)
