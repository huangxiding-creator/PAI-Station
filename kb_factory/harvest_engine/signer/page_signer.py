# -*- coding: utf-8 -*-
"""页面签名器 signer/page_signer.py（T17；paris_2030 通用化——支撑 FR2.2 补页签名腿）。

伤心文库 ACS 签名器的 Playwright 复刻（ADR-1：签名器用 Playwright 而非 Electron，同内核零
Electron 运维面；ADR-2：签名窗常驻池化——一个 PageSigner=一个专属上下文+一张常驻隐藏页，
跨多次 sign/fetch 复用，close() 收口；「每站一 partition、队列串行」的站点级池化归编排层，
本件以实例级 threading.Lock 兜底串行）。

协议口径（WENKU_SPEC §4.1/§4.2 + §3.2，置信度 high）：
- 隐藏页：``BrowserKit.wenku_context``（随机桌面 UA 全程复用 + cookie 逐条注入 .baidu.com +
  流量闸门三组正则——T07 已就位）内开一页 goto ``init_url``（缺省 https://wenku.baidu.com/，
  A:104-236 同型）；
- 就绪轮询：500ms×40/20s——evaluate ``!!(window.paris_2030 && window.paris_2030._acsInited)``
  （§4.1-5），超时抛「ACS 初始化超时」（§8-11）；开窗失败即收口，不留半开上下文；
- sign：evaluate 把 ``getAcsToken(urlStr, cb)`` 包 Promise（calls 偏移 7396）——payload=完整
  URL 字符串（JSON 编码内联，§3.2），cb 收 string → resolve；非 string → reject
  ``getAcsToken err: {...}``（§8-12）；Acs-Token 不进 query，只进请求头；
- 带签请求：页面上下文 fetch（同源+页面 cookie 自动携带），``Acs-Token`` 头 + 显式
  ``Referer: view/{docId}.html``（§3.2 原样；同源下 Chromium 对手工 Referer 走禁改头规则，
  自然 Referer=页面 URL，语义等价）。

信封判定（envelope.py 三态收口）：readerinfo 响应经 ``judge_wenku`` 分派；in-page fetch
null/非 2xx（§8-4）映射 ``EnvelopeFail(kind="fetch_null")``。

预期管理（编制裁定 2026-10-22）：匿名（无登录 cookie）下带签 readerinfo 实测仍可能触发
tri_cap 信封（§6.3 活探针实证）——EnvelopeOK 与 EnvelopeNeedVerify(tri_cap) 均算「信封路径
被验证」；账号登录态获取归 T29 账号池，本件无登录流程（cookie 只运行时注入、不读凭据文件；
原作内置 BDUSS 登录态禁止复用——§4.2）。

确定性纪律：sleep/clock 可注入（就绪轮询节拍的确定性注入点）；page_hook 可注入（开窗后、
goto 前的页面级配置缝——离线单测装本地路由零外网，实弹不传）。计数全实测（零造假）：
ready_polls/sign_calls/fetch_calls/elapsed_ms 均如实产出。
"""
from __future__ import annotations

import json
import threading
import time
from collections.abc import Callable
from dataclasses import dataclass
from typing import Any

from playwright.sync_api import BrowserContext, Error as PlaywrightError, Page

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名（同 tests 双导入法）
    from kb_factory.harvest_engine.browser.kit import NAV_TIMEOUT_MS, BrowserKit
    from kb_factory.harvest_engine.envelope import EnvelopeFail, EnvelopeVerdict, judge_wenku
except ImportError:
    from harvest_engine.browser.kit import NAV_TIMEOUT_MS, BrowserKit
    from harvest_engine.envelope import EnvelopeFail, EnvelopeVerdict, judge_wenku

__all__ = [
    "PageSignerError", "SignerReadyTimeout", "AcsTokenError",
    "SignedFetch", "ReaderInfoResult",
    "WENKU_INIT_URL", "POLL_INTERVAL_S", "READY_TIMEOUT_S", "READY_EXPR",
    "READERINFO_ENDPOINT", "READERINFO_RN", "GETACS_TIMEOUT_S", "WENKU_REFERER_BASE",
    "build_readerinfo_url", "build_sign_js", "judge_readerinfo", "PageSigner",
]

# ---------------------------------------------------------------- 协议口径常量（WENKU_SPEC §4.1/§3.2）

WENKU_INIT_URL = "https://wenku.baidu.com/"   # initUrl 缺省（§4.1-4 loadURL 同型）
POLL_INTERVAL_S = 0.5                          # 就绪轮询 500ms 一次（§4.1-5）
READY_TIMEOUT_S = 20.0                         # 20s 超时（§4.1-5；500ms×40 轮）
READY_EXPR = "!!(window.paris_2030 && window.paris_2030._acsInited)"  # 就绪判定式（原文）
READERINFO_ENDPOINT = "https://wenku.baidu.com/ndocview/readerinfo"   # 补页端点（§6.3）
READERINFO_RN = 50                             # 每批 50 页（§3.2 rn=50）
WENKU_REFERER_BASE = "https://wenku.baidu.com/"
GETACS_TIMEOUT_S = 15.0                        # getAcsToken 回调超时（防御位：原作无此超时）
BODY_HEAD_LIMIT = 400                          # 非 2xx/解析失败时的诊断截断（前 400 字符）

READY_TIMEOUT_MSG = "ACS 初始化超时"           # §8-11 原文报错语


# ---------------------------------------------------------------- 异常子类

class PageSignerError(RuntimeError):
    """签名器错误基类（开窗/签名/收口语义共用）。"""


class SignerReadyTimeout(PageSignerError):
    """ACS 初始化超时（§8-11）：20s 内 window.paris_2030._acsInited 未就绪。"""


class AcsTokenError(PageSignerError):
    """getAcsToken 失败（§8-12 回调非 string；防御位=回调超时/空 token）。"""


# ---------------------------------------------------------------- URL 组装（§3.2 逐段）

def build_readerinfo_url(doc_id: str, *, pn: int, rn: int = READERINFO_RN,
                         t_ms: int | None = None) -> str:
    """补页 URL 逐段组装（§3.2 已逐段核验的原文模板）。

    ``https://wenku.baidu.com/ndocview/readerinfo?doc_id={docId}&docId={docId}&type=html&
    clientType=1&pn={pn}&t={Date.now()}&isFromBdSearch=0&srcRef=&rn=50&powerId=2&bizName=mainPc``

    t_ms 缺省=当前毫秒（Date.now() 同型）；可注入=测试确定性。doc_id/pn/rn 非法即硬拒。
    """
    if not doc_id or not str(doc_id).strip():
        raise ValueError("doc_id 不可为空")
    if int(pn) < 1 or int(rn) < 1:
        raise ValueError(f"pn/rn 须≥1（got pn={pn!r} rn={rn!r}）")
    now_ms = int(time.time() * 1000) if t_ms is None else int(t_ms)
    return (f"{READERINFO_ENDPOINT}?doc_id={doc_id}&docId={doc_id}&type=html"
            f"&clientType=1&pn={int(pn)}&t={now_ms}&isFromBdSearch=0&srcRef="
            f"&rn={int(rn)}&powerId=2&bizName=mainPc")


def build_sign_js(timeout_ms: int) -> str:
    """sign 的 in-page 脚本：getAcsToken(urlStr, cb) 包 Promise（calls 偏移 7396 原型）。

    payload=JSON 编码的完整 URL 字符串（JSON.parse 还原后原样传 getAcsToken）；
    cb 收 string → resolve；非 string → reject ``getAcsToken err: {...}``；
    setTimeout 超时 reject 为本件防御位（原作无超时——防回调永不达挂死）。
    """
    ms = int(timeout_ms)
    return (
        "(urlJson) => new Promise((resolve, reject) => {"
        f"  const timer = setTimeout(() => reject(new Error('getAcsToken timeout: {ms}ms 无回调')),"
        f"    {ms});"
        "  window.paris_2030.getAcsToken(JSON.parse(urlJson), (tokenOrErr) => {"
        "    clearTimeout(timer);"
        "    if (typeof tokenOrErr === 'string') resolve(tokenOrErr);"
        "    else reject(new Error('getAcsToken err: ' + JSON.stringify(tokenOrErr)));"
        "  });"
        "})"
    )


#: 带签 fetch 的 in-page 脚本（§3.2 原型 ``r.ok ? r.json() : null`` 的超集——多记 status/bodyHead
#: 供信封 facts/诊断；payload 语义不变：仅 r.ok 且 JSON 可解析时非空，网络错/非 2xx/坏体=None）。
FETCH_SIGNED_JS = (
    "async ([urlJson, token, referer]) => {\n"
    "  try {\n"
    "    const r = await fetch(JSON.parse(urlJson), "
    "{ headers: { \"Acs-Token\": token, \"Referer\": referer } });\n"
    "    const body = await r.text();\n"
    "    let payload = null;\n"
    "    if (r.ok) { try { payload = JSON.parse(body); } catch (e) { payload = null; } }\n"
    f"    return {{ ok: r.ok, status: r.status, payload: payload, "
    f"bodyHead: body.slice(0, {BODY_HEAD_LIMIT}) }};\n"
    "  } catch (err) {\n"
    "    return { ok: false, status: null, payload: null, bodyHead: \"\", err: String(err) };\n"
    "  }\n"
    "}")


# ---------------------------------------------------------------- 结果产物（字段全实测）

@dataclass(frozen=True)
class SignedFetch:
    """一次带签页面上下文 fetch 的事实（零造假：status/payload/耗时如实）。"""

    url: str
    token: str
    ok: bool                        # r.ok（HTTP 2xx 且请求完成）
    status: int | None              # HTTP 状态码；None=连接级失败（fetch 抛错）
    payload: Any                    # r.ok 且 JSON 可解析 → dict/list；其余 None（§3.2 null 同型）
    body_head: str = ""             # 响应体前 400 字符（诊断；非 2xx/坏体时定位用）
    detail: str = ""
    elapsed_ms: int = 0             # evaluate 往返实测毫秒


@dataclass(frozen=True)
class ReaderInfoResult:
    """一次带签 readerinfo 补页请求的完整产物：fetch 事实 + 信封判定三态。"""

    doc_id: str
    url: str
    token: str
    fetch: SignedFetch
    verdict: EnvelopeVerdict        # EnvelopeOK | EnvelopeNeedVerify(tri_cap) | EnvelopeFail


def judge_readerinfo(fetch: SignedFetch) -> EnvelopeVerdict:
    """readerinfo 信封分派（envelope.judge_wenku 三态收口 + §8-4 fetch_null 缺席态）。

    - payload 到手（dict）→ ``judge_wenku``（tri_cap/htmlUrls/status/no_page_data 四分支）；
    - payload=None（非 2xx / 连接失败 / 坏 JSON）→ ``EnvelopeFail(fetch_null)``——等价原作
      「in-page fetch null → 未知错误中断补页循环」（§8-4）。
    """
    if isinstance(fetch.payload, dict):
        return judge_wenku(fetch.payload)
    detail = (f"http={fetch.status} bodyHead={fetch.body_head[:160]!r}"
              if fetch.status is not None else f"连接级失败: {fetch.detail}")
    return EnvelopeFail("wenku", "fetch_null", detail,
                        facts={"http_status": fetch.status, "body_head": fetch.body_head[:160]})


# ---------------------------------------------------------------- 签名窗（ADR-2 常驻）

class PageSigner:
    """paris_2030 页面签名器：专属上下文 + 常驻隐藏页，跨多次 sign 复用，close() 收口。

    生命周期：``__init__`` 即开窗（wenku_context → new_page → [page_hook] → goto → 就绪轮询）；
    开窗任一步失败即收口后抛错（不留半开上下文）。``close()`` 幂等：关页+关上下文+出 kit 台账；
    收口后再 sign/fetch 抛 RuntimeError。线程纪律（ADR-2 队列串行）：实例级 Lock 包住每次
    evaluate——同步 Playwright 非线程安全，跨线程共用一个签名窗必须串行。

    参数化注入点（公约 §3）：sleep/clock=就绪轮询节拍确定性；page_hook=开窗后 goto 前的
    页面级配置缝（离线单测装本地路由，实弹不传）。
    """

    def __init__(self, kit: BrowserKit, cookie_str: str = "", *,
                 init_url: str = WENKU_INIT_URL,
                 poll_interval_s: float = POLL_INTERVAL_S,
                 ready_timeout_s: float = READY_TIMEOUT_S,
                 goto_timeout_ms: int = NAV_TIMEOUT_MS,
                 page_hook: Callable[[Page], None] | None = None,
                 sleep: Callable[[float], None] = time.sleep,
                 clock: Callable[[], float] = time.monotonic):
        if poll_interval_s <= 0 or ready_timeout_s <= 0:
            raise ValueError("poll_interval_s/ready_timeout_s 须>0")
        self.kit = kit
        #: 随机桌面 UA 全程复用（kit 级；原作 require('user-agents') 每运行随机一个——§4.1-1）
        self.user_agent = kit.user_agent
        self.init_url = init_url
        self.poll_interval_s = float(poll_interval_s)
        self.ready_timeout_s = float(ready_timeout_s)
        self.cookie_injected = bool(cookie_str)
        # —— 实测计数（零造假）——
        self.ready_polls = 0            # 就绪轮询 evaluate 次数（轮询真循环的证据）
        self.ready_elapsed_s = 0.0      # 就绪耗时（clock 实测）
        self.sign_calls = 0
        self.fetch_calls = 0
        self._sleep = sleep
        self._clock = clock
        self._lock = threading.Lock()
        self._closed = False
        self.context: BrowserContext = kit.wenku_context(cookie_str)
        self.page: Page = self.context.new_page()
        try:
            if page_hook is not None:
                page_hook(self.page)
            self.page.goto(init_url, timeout=goto_timeout_ms)
            self.wait_ready()
        except Exception:
            self.close()  # 开窗失败即收口（finally 语义；幂等）
            raise

    # ------------------------------------------------------------ 就绪轮询（§4.1-5）

    def wait_ready(self) -> None:
        """轮询 window.paris_2030._acsInited 就绪；超时抛「ACS 初始化超时」（500ms×40/20s）。"""
        max_polls = max(1, round(self.ready_timeout_s / self.poll_interval_s))
        started = self._clock()
        polls = 0
        while True:
            polls += 1
            if bool(self.page.evaluate(READY_EXPR)):
                self.ready_polls = polls
                self.ready_elapsed_s = self._clock() - started
                return
            if polls >= max_polls:
                self.ready_polls = polls
                raise SignerReadyTimeout(
                    f"{READY_TIMEOUT_MSG}（{self.ready_timeout_s:g}s/{max_polls} 轮内 "
                    f"window.paris_2030._acsInited 未就绪，init_url={self.init_url}）")
            self._sleep(self.poll_interval_s)

    @property
    def ready(self) -> bool:
        """就绪标记（wait_ready 成功过即 True）。"""
        return self.ready_polls > 0

    @property
    def closed(self) -> bool:
        return self._closed

    def _ensure_open(self) -> None:
        if self._closed:
            raise RuntimeError("签名窗已收口（close() 后不得再 sign/fetch；ADR-2 常驻窗=显式收口）")

    # ------------------------------------------------------------ sign（§4.1/§3.2）

    def sign(self, url: str, *, timeout_s: float = GETACS_TIMEOUT_S) -> str:
        """getAcsToken(urlStr, cb) 包 Promise 签出 token（payload=完整 URL 字符串）。

        返回非空 string；回调非 string → AcsTokenError（消息含 ``getAcsToken err: …``，
        §8-12）；回调超时/空 token → AcsTokenError（防御位）。
        """
        self._ensure_open()
        script = build_sign_js(int(timeout_s * 1000))
        with self._lock:
            self.sign_calls += 1  # 实发尝试计数（成功/失败都算，零造假）
            try:
                token = self.page.evaluate(script, json.dumps(url))
            except PlaywrightError as exc:  # in-page reject → PlaywrightError（消息=原 Error 文本）
                raise AcsTokenError(str(exc)) from exc
        if not isinstance(token, str) or not token.strip():
            raise AcsTokenError(f"getAcsToken 返回非字符串/空值: {token!r}")
        return token

    # ------------------------------------------------------------ 带签 fetch（§3.2）

    def fetch_signed(self, url: str, *, referer: str = WENKU_REFERER_BASE,
                     token: str | None = None) -> SignedFetch:
        """页面上下文 fetch（同源+页面 cookie 自动携带），Acs-Token 进请求头（不进 query）。

        token 缺省=现场 sign(url)；产物语义对齐原作 ``r.ok ? r.json() : null``（§3.2）——
        非 2xx/连接失败/坏 JSON 一律 payload=None（§8-4 fetch null 同型）。
        """
        self._ensure_open()
        if token is None:
            token = self.sign(url)  # 先拿锁签出，再单独拿锁 fetch（Lock 非重入，分两段）
        with self._lock:
            started = self._clock()
            try:
                got = self.page.evaluate(FETCH_SIGNED_JS,
                                         [json.dumps(url), token, referer])
            except PlaywrightError as exc:
                got = {"ok": False, "status": None, "payload": None, "bodyHead": "",
                       "err": f"{type(exc).__name__}: {exc}"}
            elapsed_ms = int(round((self._clock() - started) * 1000))
            self.fetch_calls += 1
        return SignedFetch(
            url=url, token=token, ok=bool(got.get("ok")),
            status=got.get("status"), payload=got.get("payload"),
            body_head=str(got.get("bodyHead") or ""),
            detail=str(got.get("err") or ("http ok" if got.get("ok") else "http not-ok")),
            elapsed_ms=elapsed_ms)

    def fetch_readerinfo(self, doc_id: str, *, pn: int = 1, rn: int = READERINFO_RN,
                         t_ms: int | None = None,
                         referer: str | None = None) -> ReaderInfoResult:
        """带签补页请求（§3.2/§6.3）：URL 组装 → sign → in-page fetch → 信封三态判定。

        referer 缺省=``view/{doc_id}.html``（§3.2 原文）。verdict=EnvelopeOK（htmlUrls 到手）
        或 EnvelopeNeedVerify(tri_cap)（匿名+签名仍触发验证码——§6.3 探针实证，如实上报）
        或 EnvelopeFail（fetch_null/status/no_page_data）。
        """
        url = build_readerinfo_url(doc_id, pn=pn, rn=rn, t_ms=t_ms)
        if referer is None:
            referer = f"{WENKU_REFERER_BASE}view/{doc_id}.html"
        fetch = self.fetch_signed(url, referer=referer)
        return ReaderInfoResult(doc_id=doc_id, url=url, token=fetch.token,
                                fetch=fetch, verdict=judge_readerinfo(fetch))

    # ------------------------------------------------------------ 收口（ADR-2）

    def close(self) -> bool:
        """收口签名窗（幂等）：关页 → 关上下文 → 出 kit 台账；返回本次是否实际收口。"""
        if self._closed:
            return False
        self._closed = True
        for closer in (lambda: self.page.close(), lambda: self.context.close()):
            try:
                closer()
            except PlaywrightError:
                pass  # 页随上下文已亡等幂等场景
        ledger = getattr(self.kit, "_contexts", None)  # 同包台账：出册保持 open_context_count 如实
        if isinstance(ledger, list) and self.context in ledger:
            ledger.remove(self.context)
        return True

    def __enter__(self) -> "PageSigner":
        return self

    def __exit__(self, exc_type, exc, tb) -> None:
        self.close()
