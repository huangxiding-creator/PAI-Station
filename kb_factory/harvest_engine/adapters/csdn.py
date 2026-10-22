# -*- coding: utf-8 -*-
"""csdn 适配器：URL 分类 + PDF 分支 blog/answer/column（T20；FR5.1/FR5.AC2）。

规格依据 CSDN_SPEC §1.1（parseCsdnUrl 六形态分类）/§1.2（webPageToPdf 选器流）/
§5（Electron→Playwright 1:1 映射表）；蓝本=冰点文库 bingdian_v2 electron/csdn.js（可读反混淆版）。

PDF 分支无 VIP 依赖（公开页匿名渲染；csdnCookie 可选注入位=PDF 分支按原作注入 .csdn.net 30 天）。
download/doc 分支（DOM 嗅探 VIP 免费判定 + paid_wall 硬拒 + expect_download 接管）=T25 实装（本文件下半段）；
付费闸门与原作逐字对齐，且判定经 envelope.judge_csdn 真符号（付费闸门只适用 download/doc 形态——
PDF 形态公开匿名渲染，不咨询该闸门；column_download 一律拒=合规门原样移植）。

Electron→Playwright 映射（§5 表 + 实测修正）：
- session.fromPartition('persist:csdn') → kit.csdn_context（storage_state 持久化，browser/kit.py T07 已就位）
- cookies.set 循环 → kit.inject_cookies（.csdn.net + expires=now+30 天）
- 追踪域 onBeforeRequest cancel → kit.install_route_blocklist（CSDN_AD_DOMAINS substring）
- will-navigate 防跳走 → page.route 主文档导航闸（跨域导航 abort；Playwright 无 preventDefault，
  同域 30x/锚点放行——比原作全串等值比较略宽，防误杀站内跳转；已开页首闸=后注册者先跑，fallback 归 kit 闸）
- executeJavaScript 点击/嗅探 → page.evaluate（逐段 try/except 吞错=原作 .catch(()=>{})）
- printToPDF({printBackground,preferCSSPageSize,margins:0}) → pdf/html_print_pdf.html_to_pdf
  （print-CSS 隐藏清单经其 extra_css 注入钩子——任务卡基座接线；打印快照剥 script/iframe/广告图，
  打印态本就不执行脚本，剥除防 file:// 重载时脚本再截断/再跳转）
- 时序照抄：goto 后 2000ms → 点阅读全文(.read-all-content-btn,.open-btn,.lowerBtn) → 1000ms →
  点代码展开(.hide-preCode-bt) → 1000ms → print DOM 净化(.set-code-hide 剥除等) → 标题门 → 打印

与原作的实证性偏离（数字零造假，如实记账）：
1. 标题 404 门照抄；另增「内容选择器空→fail-fast」（原作会静默产验证页/空壳 PDF，质检门无法
   构参照；WAF 验证页实证见下）。
2. 2026-10-22 探针 P1-P3（预算 ≤6 次页面加载用尽）：blog.csdn.net 匿名无头可渲染
   （样本实测 4012 非空白字符）；wenku.csdn.net answer/column 匿名无头命中「网站安全验证」
   WAF 验证码墙（30s 不自解 + waf_captcha_marker cookie，非 VIP/付费墙）——
   storage_state/csdnCookie 注入位已留（kit.csdn_context），供给后复跑即可。
"""
from __future__ import annotations

import configparser
import os
import re
import threading
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Callable
from urllib.parse import urlparse

import pypdfium2
from playwright.sync_api import Error as PlaywrightError
from playwright.sync_api import TimeoutError as PlaywrightTimeoutError
from playwright.sync_api import BrowserContext, Page

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine.adapters.base import (
        WALL_PAID, DownloadAdapter, HarvestPlan, LadderResult, mark_wall_status)
    from kb_factory.harvest_engine.browser.kit import (
        CSDN_AD_DOMAINS, DOWNLOAD_TIMEOUT_MS, NAV_TIMEOUT_MS, BrowserKit,
        capture_download, save_download)
    from kb_factory.harvest_engine.envelope import EnvelopeFail, judge_csdn
    from kb_factory.harvest_engine.pdf.html_print_pdf import html_to_pdf
except ImportError:
    from harvest_engine.adapters.base import (
        WALL_PAID, DownloadAdapter, HarvestPlan, LadderResult, mark_wall_status)
    from harvest_engine.browser.kit import (
        CSDN_AD_DOMAINS, DOWNLOAD_TIMEOUT_MS, NAV_TIMEOUT_MS, BrowserKit,
        capture_download, save_download)
    from harvest_engine.envelope import EnvelopeFail, judge_csdn
    from harvest_engine.pdf.html_print_pdf import html_to_pdf

__all__ = [
    "PDF_URL_TYPES", "DOWNLOAD_URL_TYPES", "CONTENT_SELECTORS", "parse_csdn_url",
    "build_print_css", "sanitize_filename", "dir_name_for", "CsdnPdfOutcome",
    "web_page_to_pdf", "web_page_to_pdf_flow", "CsdnAdapter",
    "CsdnUnsupportedUrlError", "CsdnColumnDownloadError", "CsdnPage404Error",
    "CsdnContentMissingError", "CsdnPageLoadError",
    "CsdnPaidWallError", "CsdnDownloadButtonMissingError", "CsdnDownloadTimeoutError",
    "CsdnDownloadOutcome", "DEFAULT_CREDENTIALS_FILE", "KB_CSDN_COOKIE_ENV",
    "load_csdn_cookie", "sniff_resource_dom", "download_resource_flow",
    "download_resource",
]


# ---------------------------------------------------------------- 错误类（文案=原作原文）

class CsdnUnsupportedUrlError(ValueError):
    """未知 CSDN 链接格式（原作 parseCsdnUrl null → 无法识别 CSDN 链接格式）。"""


class CsdnColumnDownloadError(ValueError):
    """图文专栏一律拒（CSDN_SPEC §1.1/§4 合规闸门：图文专栏暂不支持下载）。"""


class CsdnPage404Error(ValueError):
    """标题 404/为空（CSDN_SPEC §1.2-6：页面不存在(404)，请检查链接是否正确）。"""


class CsdnContentMissingError(ValueError):
    """内容选择器空/缺失（WAF 验证页或结构变更——fail-fast 不产空壳 PDF，T20 实证性增补）。"""


# ------------- download/doc 分支错误类（T25；文案=原作 csdn.js 内联主链原文）-------------

class CsdnPageLoadError(RuntimeError):
    """嗅探脚本拿不到页面（原作 executeJavaScript().catch(()=>null) → 页面加载失败，请检查链接）。"""


class CsdnPaidWallError(RuntimeError):
    """付费墙硬拒（原作 isPaid || !isVipFree → 该资源需要额外收费，暂不支持下载）。

    facts 携带 judge_csdn 判定事实（is_paid/is_vip_free/has_paid）；wall_status=WALL_PAID。
    """

    def __init__(self, detail: str, *, facts: dict | None = None):
        super().__init__(detail)
        self.facts = dict(facts or {})
        self.wall_status = WALL_PAID


class CsdnDownloadButtonMissingError(RuntimeError):
    """点击阶段按钮不在场（原作：未找到下载按钮，请确认 Cookie 有效）。"""


class CsdnDownloadTimeoutError(RuntimeError):
    """下载整体超时（原作 setTimeout 0x7530=30s：下载超时，请检查 VIP 权限）。"""


# ---------------------------------------------------------------- URL 分类（§1.1 parseCsdnUrl 1:1）

PDF_URL_TYPES = ("blog", "answer", "column")
DOWNLOAD_URL_TYPES = ("doc", "download")  # 归 T25

#: 三 PDF 形态内容选择器（§1.1 表逐字）
CONTENT_SELECTORS = {
    "blog": "#content_views",
    "answer": ".content-view",
    "column": ".article-box",
}

#: id 提取（§1.1：仅用于输出目录命名，不参与任何请求构造）
_ID_PATTERNS = {
    "blog": re.compile(r"article/details/(\d+)"),
    "answer": re.compile(r"answer/([a-z0-9]+)", re.IGNORECASE),
    "column": re.compile(r"column/([a-z0-9]+)", re.IGNORECASE),
    "doc": re.compile(r"doc/([a-z0-9]+)", re.IGNORECASE),
    "download": re.compile(r"download/[^/]+/(\d+)"),
}

_URL_RULES = (  # 判序=原作序（blog→answer→column→column_download→doc→download）
    ("blog", re.compile(r"blog\.csdn\.net/.+/article/details/\d+")),
    ("answer", re.compile(r"wenku\.csdn\.net/answer/")),
    ("column", re.compile(r"wenku\.csdn\.net/column/")),
    ("column_download", re.compile(r"download\.csdn\.net/blog/column/")),
    ("doc", re.compile(r"wenku\.csdn\.net/doc/")),
    ("download", re.compile(r"download\.csdn\.net/download/")),
)


def parse_csdn_url(url: str) -> dict | None:
    """完整页面 URL → ``{"type", "url"}``（六形态；未知 None=原作 null）。"""
    u = url.strip()
    for t, pattern in _URL_RULES:
        if pattern.search(u):
            return {"type": t, "url": u}
    return None


def dir_name_for(url_type: str, url: str, *, now_ms: int | None = None) -> str:
    """输出目录名：blog_<id>/answer_<id>/column_<id>/resource_<id>（无 id 兜底毫秒时间戳=原作 Date.now）。"""
    m = _ID_PATTERNS[url_type].search(url) if url_type in _ID_PATTERNS else None
    rid = m.group(1) if m else str(now_ms if now_ms is not None else int(time.time() * 1000))
    prefix = "resource" if url_type in DOWNLOAD_URL_TYPES else url_type
    return prefix + "_" + rid


# ---------------------------------------------------------------- print-CSS（§1.2-5 原作 0x292 段逐字移植）

#: 隐藏清单（工具栏/侧栏/推荐/水印等；原作字符串逐字）
_PRINT_HIDDEN = (
    "#toolbarBox,aside,.aside,.breadcrumb-wrap,.column-vote-panel,.recommend-right,"
    ".nav-bottom-wrap,.space,.box-wrap,.layout-right,.recommend-right1,.more-toolbox-new,"
    ".blog-footer-bottom,.comment-box,.directory-boxshadow-dialog,#copyright-box,#csdn-toolbar,"
    ".csdn-side-toolbar,.passport-login-container,.first-recommend-box,.second-recommend-box,"
    ".recommend-box,#blogColumnPayAdvert,#blogHuaweiyunAdvert,.article-bar-top,.blog-tags-box,"
    ".article-header-box,.print_watermark,.print_watermark_info,.column-group,"
    ".vip-limited-time-offer-box-new"
)


def build_print_css(content_selector: str) -> str:
    """打印 CSS 构造器（纯函数）：@media print 内隐藏清单 + 内容选器 display:block 撑满 + pre 强制换行。

    经 pdf/html_print_pdf.html_to_pdf 的 extra_css 注入钩子生效（打印态=Chromium print 媒体）。
    """
    return (
        "@media print{body{margin:5mm;}"
        + _PRINT_HIDDEN + "{display:none!important}"
        + content_selector
        + "{display:block!important;width:100%!important;overflow:hidden!important;padding:10px}"
        + ".blog-content-box,.article_content,.main_father,.container,#mainBox,main,article"
        "{padding:0!important;margin:0!important;width:100%!important}"
        + "pre{white-space:pre-wrap!important;word-break:break-all!important;"
        "overflow:hidden!important}"
        + "img{max-width:100%!important;height:auto!important}"
        + ".set-code-height{max-height:none!important}"
        + ".layout{width:1200px!important}.layout-center{width:100%!important}}"
    )


_FILENAME_ILLEGAL = re.compile(r'[\\/:*?"<>|]')  # 原作 [\/:*?"<>|]→_
_TITLE_MAX = 50  # 原作 slice(0, 0x50)


def sanitize_filename(title: str, *, fallback: str = "csdn") -> str:
    """标题清洗：非法字符→_ + 截断 50（空标题兜底 'csdn'=原作；.pdf 后缀由调用方拼）。"""
    name = _FILENAME_ILLEGAL.sub("_", title.strip() or fallback)
    return name[:_TITLE_MAX]


# ---------------------------------------------------------------- 选器流 JS（§1.2 原作逐字）

_JS_CLICK_READ_ALL = (
    "(function(){document.querySelectorAll('.read-all-content-btn,.open-btn,.lowerBtn')"
    ".forEach(function(e){try{e.click()}catch(err){}});})()"
)
_JS_CLICK_CODE_EXPAND = (
    "(function(){document.querySelectorAll('.hide-preCode-bt')"
    ".forEach(function(e){try{e.click()}catch(err){}});})()"
)
#: print DOM 净化（原作注入脚本前半：剥 set-code-hide 类 + 移除代码展开按钮盒）
_JS_PREPARE_PRINT_DOM = (
    "(function(){document.querySelectorAll('.set-code-hide')"
    ".forEach(function(e){e.classList.remove('set-code-hide')});"
    "document.querySelectorAll('.hide-preCode-box,.hljs-button')"
    ".forEach(function(e){e.remove()});})()"
)
#: 标题提取（h1.title-article,h1 优先；回退 document.title 去「 - CSDN...」后缀）
_JS_TITLE = (
    r'(function(){var h=document.querySelector("h1.title-article,h1");'
    r'return h?h.textContent.trim():document.title.replace(/-\s*CSDN.*$/,"").trim();})()'
)
#: 打印快照净化：剥 script/noscript/iframe + 广告域图（打印态不执行脚本；防 file:// 重载再截断/再跳转）
#: 打印快照剥除选择器（Python 侧拼好，经 evaluate 参数传入——避免引号嵌套炸 JS 串，实测教训）
_STRIP_SELECTOR = ",".join(
    ["script", "noscript", "iframe"] + ["img[src*='%s']" % d for d in CSDN_AD_DOMAINS])
_JS_STRIP_FOR_PRINT = (
    "sel => {document.querySelectorAll(sel)"
    ".forEach(function(e){e.remove()});return true}"
)

_WS_RE = re.compile(r"\s+")

# 时序（§1.2 原文：2000ms → 阅读全文 → 1000ms → 代码展开 → 1000ms）
LOAD_SETTLE_MS = 2000
READ_ALL_SETTLE_MS = 1000
CODE_EXPAND_SETTLE_MS = 1000


def _swallow(action) -> None:
    """执行一段 evaluate，PlaywrightError 一律吞掉（=原作 executeJavaScript().catch(()=>{})）。"""
    try:
        action()
    except PlaywrightError:
        pass


def _install_stay_gate(page: Page, target_url: str) -> None:
    """will-navigate 防跳走的等价闸：主文档跨域导航 abort，其余 fallback 归 kit 广告闸。

    Playwright 无 preventDefault；原作 preventDefault(url!==目标串) 在 Playwright 路由层
    会连站内 30x（如追加 spm 参数）一并误杀，故收窄为「跨域才拦」（同域放行，见模块头映射注记）。
    """
    origin_netloc = urlparse(target_url).netloc

    def _stay(route) -> None:
        try:
            req = route.request
            if req.is_navigation_request():
                u = urlparse(req.url)
                if u.scheme in ("http", "https") and u.netloc and u.netloc != origin_netloc:
                    route.abort()
                    return
        except Exception:
            pass
        route.fallback()

    page.route("**/*", _stay)


@dataclass(frozen=True)
class CsdnPdfOutcome:
    """PDF 分支单文档产物（实测字段，数字零造假）。"""

    pdf_path: Path
    html_path: Path          # 打印快照（剥脚本后的 file:// 源）
    title: str               # h1 优先实测标题
    url_type: str            # blog/answer/column
    dom_chars: int           # 内容选择器 innerText 非空白字符数（质检门 ref_chars 参照）


def _print_pdf_offmain(html_path: Path, pdf_path: Path, *, extra_css: str) -> Path:
    """html_to_pdf 独立工作线程调起（Playwright sync 禁在活动 sync 驱动内再起 sync_playwright：
    实测 2026-10-22 外层 kit 上下文内直调报「Sync API inside asyncio loop」；线程内合法）。

    print-CSS 仍经 pdf/html_print_pdf.html_to_pdf 的 extra_css 注入钩子生效（任务卡基座接线不变）。
    """
    box: dict = {}

    def _run() -> None:
        try:
            box["pdf"] = html_to_pdf(html_path, pdf_path, extra_css=extra_css)
        except BaseException as exc:  # 原样回抛主线程（不吞错）
            box["err"] = exc

    t = threading.Thread(target=_run, name="csdn-print-pdf", daemon=True)
    t.start()
    t.join()
    if "err" in box:
        raise box["err"]
    return box["pdf"]


def web_page_to_pdf_flow(kit: BrowserKit, page_url: str, *, content_selector: str,
                         fallback_name: str, out_dir: Path | str,
                         cookie_str: str = "", storage_path: str | Path | None = None,
                         nav_timeout_ms: int = NAV_TIMEOUT_MS) -> CsdnPdfOutcome:
    """选器流执行体（§1.2 webPageToPdf 1:1）：加载→点击链→标题门→参照实测→快照→print-CSS 转 PDF。

    web_page_to_pdf 负责 URL 分类后委派本件；本件不判 URL 形态（data:/file: 离线全链测试由此驱动）。
    上下文生命周期归 kit（调用方 close_all 收口，T07 契约）。
    """
    out = Path(out_dir)
    out.mkdir(parents=True, exist_ok=True)
    ctx: BrowserContext = kit.csdn_context(cookie_str=cookie_str, storage_path=storage_path)
    page = ctx.new_page()
    _install_stay_gate(page, page_url)
    try:
        try:  # 原作 loadURL().catch(()=>{})：加载失败吞掉，靠 404 标题门兜底
            page.goto(page_url, timeout=nav_timeout_ms)
        except PlaywrightError:
            pass
        page.wait_for_timeout(LOAD_SETTLE_MS)
        _swallow(lambda: page.evaluate(_JS_CLICK_READ_ALL))      # 点「阅读全文」类按钮
        page.wait_for_timeout(READ_ALL_SETTLE_MS)
        _swallow(lambda: page.evaluate(_JS_CLICK_CODE_EXPAND))   # 点代码展开
        page.wait_for_timeout(CODE_EXPAND_SETTLE_MS)
        _swallow(lambda: page.evaluate(_JS_PREPARE_PRINT_DOM))   # print DOM 净化
        try:
            title = page.evaluate(_JS_TITLE)
        except PlaywrightError:
            title = None
        title = str(title or fallback_name or "").strip()
        if not title or title == "404" or "404" in title:
            raise CsdnPage404Error("页面不存在(404)，请检查链接是否正确")
        try:  # 参照字数实测：内容选择器 innerText 非空白字符数
            dom_text = page.eval_on_selector(content_selector, "el => el.innerText") or ""
        except PlaywrightError:
            dom_text = ""
        dom_chars = len(_WS_RE.sub("", dom_text))
        if dom_chars <= 0:
            raise CsdnContentMissingError(
                "内容选择器 %s 文本为空（疑似 WAF「网站安全验证」验证码墙或页面结构变更）；"
                "页面标题=%r" % (content_selector, title))
        _swallow(lambda: page.evaluate(_JS_STRIP_FOR_PRINT, _STRIP_SELECTOR))  # 打印快照净化
        html_path = out / (fallback_name + "_print_snapshot.html")
        html_path.write_text(page.content(), encoding="utf-8")
        pdf_path = out / (sanitize_filename(title, fallback=fallback_name) + ".pdf")
        pdf_path = _print_pdf_offmain(html_path, pdf_path,
                                  extra_css=build_print_css(content_selector))
        return CsdnPdfOutcome(pdf_path=pdf_path, html_path=html_path, title=title,
                              url_type="", dom_chars=dom_chars)
    finally:
        try:
            page.close()
        except PlaywrightError:
            pass


def web_page_to_pdf(kit: BrowserKit, url: str, *, out_dir: Path | str | None,
                    cookie_str: str = "",
                    storage_path: str | Path | None = None
                    ) -> CsdnPdfOutcome | CsdnDownloadOutcome:
    """URL 分类入口（§1.1）：PDF 三形态走选器流；column_download 一律拒；
    download/doc 走点击下载流（T25 实装，返回 CsdnDownloadOutcome——产物形态不同，见类注记）。
    """
    parsed = parse_csdn_url(url)
    if parsed is None:
        raise CsdnUnsupportedUrlError("无法识别 CSDN 链接格式")
    t, target = parsed["type"], parsed["url"]
    if t == "column_download":
        raise CsdnColumnDownloadError("图文专栏暂不支持下载")
    if t in DOWNLOAD_URL_TYPES:
        return download_resource(kit, url, out_dir=out_dir,
                                 cookie_str=cookie_str, storage_path=storage_path)
    if out_dir is None:
        raise ValueError("out_dir 必填（产物目录，拒绝路径注入式落盘）")
    stem = dir_name_for(t, target)
    outcome = web_page_to_pdf_flow(kit, target, content_selector=CONTENT_SELECTORS[t],
                                   fallback_name=stem, out_dir=Path(out_dir) / stem,
                                   cookie_str=cookie_str, storage_path=storage_path)
    return CsdnPdfOutcome(pdf_path=outcome.pdf_path, html_path=outcome.html_path,
                          title=outcome.title, url_type=t, dom_chars=outcome.dom_chars)


# ================================================================ download/doc 分支（T25；CSDN_SPEC §1.3/§2/§4）
# 原作 = csdn.js 内联主链（非 §1.4 死代码 downloadResource）：DOM 嗅探 .el-button--warning 按钮文案
# 判 VIP 免费/付费 → 闸门只放 VIP 免费件 → 点击 + 确认弹窗循环 10×1s → will-download 接管落盘。

# ---- 凭据（只读 _credentials/*.secret.ini 的 csdn 段；管理端下发式整串 cookie，CSDN_SPEC §2）----

KB_CSDN_COOKIE_ENV = "KB_CSDN_COOKIE"  # 测试/运行期供给位（供给后实弹用例自动转 live）
CREDENTIALS_FILENAME = "csdn.secret.ini"
CREDENTIALS_SECTION = "csdn"
CREDENTIALS_KEY = "cookie"
#: 默认凭据文件（07 任务/自动建库Agent/_credentials/csdn.secret.ini；只读，不存在=如实 ""）
DEFAULT_CREDENTIALS_FILE = (Path(__file__).resolve().parents[3] / "07 任务" / "自动建库Agent"
                            / "_credentials" / CREDENTIALS_FILENAME)


def load_csdn_cookie(credentials_file: Path | str | None = None, *,
                     env: dict | None = None) -> str:
    """解析 csdn VIP cookie 整串（优先级：显式 env KB_CSDN_COOKIE > secret.ini [csdn] cookie）。

    未供=如实返回 ""（不造假跳过、不抛错——挂账判定由调用方如实落账）；凭据值永不入日志/异常文案。
    """
    value = str((env if env is not None else os.environ).get(KB_CSDN_COOKIE_ENV, "")).strip()
    if value:
        return value
    ini = Path(credentials_file) if credentials_file is not None else DEFAULT_CREDENTIALS_FILE
    if not ini.is_file():
        return ""
    parser = configparser.ConfigParser()
    parser.read(ini, encoding="utf-8")
    if not parser.has_section(CREDENTIALS_SECTION):
        return ""
    return parser.get(CREDENTIALS_SECTION, CREDENTIALS_KEY, fallback="").strip()


# ---- 选器流 JS（原作逐字；仅嗅探脚本增补 btnText 返回字段供 judge_csdn 真符号对齐）----

#: DOM 嗅探（原作 MuamM 串逐字 + btnText 增补）：title=h1,.resource-title,.dl-title 回退 document.title；
#: btn=.el-button--warning；isVipFree=含「VIP专享下载|立即下载」且不含「会员价」；isPaid=含「会员价」
_JS_SNIFF_RESOURCE = (
    '(function(){'
    'var title=(document.querySelector("h1,.resource-title,.dl-title")||{}).textContent'
    '||document.title;'
    'var btn=document.querySelector(".el-button--warning");'
    'var btnText=btn?btn.textContent.trim():"";'
    'var isVipFree=btn&&(btnText.indexOf("VIP专享下载")>-1||btnText.indexOf("立即下载")>-1)'
    '&&btnText.indexOf("会员价")<0;'
    'var isPaid=btnText.indexOf("会员价")>-1;'
    'return{title:title.trim(),isVipFree:isVipFree,isPaid:isPaid,btnText:btnText}})()'
)
#: 点击下载按钮（原作逐字；false=按钮不在场 → 未找到下载按钮，请确认 Cookie 有效）
_JS_CLICK_WARNING_BUTTON = (
    '(function(){var btn=document.querySelector(".el-button--warning");'
    'if(btn){btn.click();return true}return false})()'
)
#: 确认弹窗循环点击（原作 oggxI 串逐字）：.el-dialog__footer 内 button，点中返回 true
_JS_CLICK_CONFIRM_DIALOG = (
    '(function(){var dlg=document.querySelector(".el-dialog__footer");'
    'if(dlg){var btn=dlg.querySelector("button");if(btn){btn.click();return true}}return false})()'
)

#: 时序（CSDN_SPEC §1.3 原文：goto 后静默 2000ms；确认弹窗 10 次 × 1000ms；整体超时 30s=0x7530）
DOWNLOAD_SETTLE_MS = 2000
CONFIRM_DIALOG_MAX_TRIES = 10
CONFIRM_DIALOG_INTERVAL_MS = 1000
#: 30s 整体超时=kit.DOWNLOAD_TIMEOUT_MS 同值（单源以 kit 为准，此处显名供断言/文档）


def sniff_resource_dom(page: Page) -> dict | None:
    """页面上执行原作嗅探脚本；PlaywrightError 一律吞 → None（=原作 .catch(()=>null)）。"""
    try:
        return page.evaluate(_JS_SNIFF_RESOURCE)
    except PlaywrightError:
        return None


@dataclass(frozen=True)
class CsdnDownloadOutcome:
    """download/doc 分支单资源产物（实测字段，数字零造假；文件名=服务器 suggested_filename）。"""

    file_path: Path
    filename: str        # 服务器原文件名（等价 Electron item.getFilename()，本地不重命名）
    title: str           # h1,.resource-title,.dl-title 回退 document.title
    url_type: str        # download/doc
    file_size: int       # 落盘字节数实测


def download_resource_flow(kit: BrowserKit, page_url: str, *, url_type: str,
                           out_dir: Path | str, cookie_str: str = "",
                           storage_path: str | Path | None = None,
                           nav_timeout_ms: int = NAV_TIMEOUT_MS,
                           download_timeout_ms: int = DOWNLOAD_TIMEOUT_MS,
                           confirm_interval_ms: int = CONFIRM_DIALOG_INTERVAL_MS,
                           page_hook: Callable[[Page], None] | None = None,
                           ) -> CsdnDownloadOutcome:
    """download/doc 点击流执行体（§1.3 内联主链 1:1）：加载→嗅探→judge_csdn 闸门→点击→弹窗→接管落盘。

    - 付费闸门= envelope.judge_csdn 真符号（本形态专用）：isPaid 或 非 isVipFree → paid_wall 硬拒
      （标题 404 一并按 page_404 拒——judge_csdn 词面同一拒绝序）；
    - 下载接管= kit.capture_download（先挂 expect_download 再点击，30s 整体超时）+
      kit.save_download（suggested_filename 落盘，本地不重命名）；
    - page_hook=离线测试注入位（page 建立后、goto 前回调：route 本地 fulfill 触发真下载事件，T07 手法；
      生产路径传 None=零介入）；
    - confirm_interval_ms=时间注入位（测试确定性；生产默认 1000ms=原作时序）。
    """
    out = Path(out_dir)
    out.mkdir(parents=True, exist_ok=True)
    ctx: BrowserContext = kit.csdn_context(cookie_str=cookie_str, storage_path=storage_path)
    page = ctx.new_page()
    if page_hook is not None:
        page_hook(page)
    try:
        try:  # 原作 loadURL().catch(()=>{})：加载失败吞掉，靠嗅探 null 兜底
            page.goto(page_url, timeout=nav_timeout_ms)
        except PlaywrightError:
            pass
        page.wait_for_timeout(DOWNLOAD_SETTLE_MS)
        facts = sniff_resource_dom(page)
        if facts is None:
            raise CsdnPageLoadError("页面加载失败，请检查链接")
        # 付费闸门（真符号对齐）：DOM 事实 → judge_csdn 判定（付费闸门只适用 download/doc 形态）
        verdict = judge_csdn({"url_type": url_type, "title": facts.get("title"),
                              "button_text": str(facts.get("btnText") or "")})
        if isinstance(verdict, EnvelopeFail):
            if verdict.kind == "paid_wall":
                raise CsdnPaidWallError(verdict.detail, facts=dict(verdict.facts))
            if verdict.kind == "page_404":
                raise CsdnPage404Error(verdict.detail)
            raise CsdnPageLoadError(verdict.detail)  # bad_payload 等防御位（正常不可达）

        def _trigger() -> None:  # 在 expect_download 挂好后执行：点击→确认弹窗循环（§1.3-8/9）
            clicked = page.evaluate(_JS_CLICK_WARNING_BUTTON)
            if not clicked:
                raise CsdnDownloadButtonMissingError("未找到下载按钮，请确认 Cookie 有效")
            for _ in range(CONFIRM_DIALOG_MAX_TRIES):
                page.wait_for_timeout(confirm_interval_ms)
                try:
                    if page.evaluate(_JS_CLICK_CONFIRM_DIALOG):
                        break
                except PlaywrightError:
                    continue  # 原作 .catch(()=>false) 等价

        try:
            download = capture_download(page, _trigger, timeout_ms=download_timeout_ms)
        except PlaywrightTimeoutError:
            raise CsdnDownloadTimeoutError("下载超时，请检查 VIP 权限") from None
        saved = save_download(download, out)  # suggested_filename 落盘（本地不重命名）
        return CsdnDownloadOutcome(
            file_path=saved, filename=download.suggested_filename,
            title=str(facts.get("title") or ""), url_type=url_type,
            file_size=saved.stat().st_size)
    finally:
        try:
            page.close()
        except PlaywrightError:
            pass


def download_resource(kit: BrowserKit, url: str, *, out_dir: Path | str | None,
                      cookie_str: str = "",
                      storage_path: str | Path | None = None,
                      page_hook: Callable[[Page], None] | None = None
                      ) -> CsdnDownloadOutcome:
    """download/doc 分支 URL 分类入口（§1.1）：column_download 一律拒（合规门原样移植）；
    download/doc 走点击流；PDF 三形态请走 web_page_to_pdf（本入口不受理）。
    page_hook=离线确定性注入位（透传 flow；生产 None）。
    """
    if out_dir is None:
        raise ValueError("out_dir 必填（产物目录，拒绝路径注入式落盘）")
    parsed = parse_csdn_url(url)
    if parsed is None:
        raise CsdnUnsupportedUrlError("无法识别 CSDN 链接格式")
    t, target = parsed["type"], parsed["url"]
    if t == "column_download":  # §4 合规闸门：图文专栏一律拒（页面都不开）
        raise CsdnColumnDownloadError("图文专栏暂不支持下载")
    if t in PDF_URL_TYPES:
        raise CsdnUnsupportedUrlError(
            "PDF 形态（%s）请走 web_page_to_pdf 选器流；本入口只受理 download/doc" % t)
    stem = dir_name_for(t, target)
    return download_resource_flow(kit, target, url_type=t, out_dir=Path(out_dir) / stem,
                                  cookie_str=cookie_str, storage_path=storage_path,
                                  page_hook=page_hook)


def _pdf_pages(pdf: Path) -> int:
    """pypdfium2 实测页数（数字零造假；解析失败抛错由调用方归因）。"""
    doc = pypdfium2.PdfDocument(str(pdf))
    try:
        return len(doc)
    finally:
        doc.close()


class CsdnAdapter(DownloadAdapter):
    """csdn 收割适配器（T20 骨架 + T25 download/doc 实装）：channel/site="csdn"。

    - search：CSDN_SPEC 无站内检索协议（输入=完整页面 URL），段 1 不适用——显式 NotImplementedError；
    - plan：URL 分类入 meta.extra（url_type/dir_name）；全形态梯队=纯 L2（浏览器渲染/点击流，
      CSDN_SPEC §5 纯 requests 不可行 → 无 L1；文件下载无 OCR 语义 → 无 L3）；
    - fetch_ladder：PDF 三形态走选器流；download/doc 走点击流（T25：凭据闸门→嗅探→
      judge_csdn 付费闸门→点击→expect_download 接管）；column_download 合规拒（ok=False，非墙标）；
      paid_wall 硬拒落 wall_status=WALL_PAID + mark_wall_status（NFR1 统一落点）；
    - 凭据：cookie_str=None（默认）→ KB_CSDN_COOKIE 环境变量 → _credentials/csdn.secret.ini [csdn]
      cookie 段（load_csdn_cookie 单源）；download/doc 未供凭据=如实挂账拒（零网络）；
    - verify：.pdf 产物 pypdfium2 数值化（在盘+可解析+≥1 页）；download/doc 服务器原文件
      （任意类型）=在盘+非空（深度四门全检归编排层 quality_gate，T40 接线）。
    """

    site = "csdn"
    channel = "csdn"

    def __init__(self, kit: BrowserKit, *, download_dir: Path | str,
                 cookie_str: str | None = None,
                 storage_path: str | Path | None = None,
                 credentials_file: Path | str | None = None,
                 page_hook: Callable[[Page], None] | None = None,
                 log=None):
        self.kit = kit
        self.download_dir = Path(download_dir)
        # cookie_str=None → 凭据单源解析（env KB_CSDN_COOKIE > secret.ini [csdn] cookie > ""）；
        # 显式 "" =强制匿名（PDF 分支原语义）；download/doc 分支无凭据即挂账拒（不触网）
        self.cookie_str = (load_csdn_cookie(credentials_file) if cookie_str is None
                           else cookie_str)
        self.storage_path = storage_path        # persist:csdn 等价载入位（原作 §1.2-1；可替代 cookie）
        self.page_hook = page_hook              # 离线确定性注入位（route 本地 fulfill；生产 None）
        self.log = log or (lambda msg: None)

    # ---- 段 1：search（不适用，显式拒）
    def search(self, query: str, limit: int) -> list:
        raise NotImplementedError(
            "csdn 输入=完整页面 URL（CSDN_SPEC §1.1 无站内检索协议），search 段不适用")

    # ---- 段 2：plan（URL 分类）
    def plan(self, meta) -> HarvestPlan:
        url = meta.source_url or ""
        parsed = parse_csdn_url(url)
        if parsed is None:
            raise CsdnUnsupportedUrlError("无法识别 CSDN 链接格式")
        t = parsed["type"]
        meta.extra["url_type"] = t
        meta.extra["dir_name"] = dir_name_for(t, url)
        ladder_try = ("L2",)  # 全形态纯 L2（PDF 选器流/download-doc 点击流均浏览器层；无 L1/L3 语义）
        return HarvestPlan(meta=meta, slot=meta.extra["dir_name"],
                           ladder_try=ladder_try, red_check=True)

    # ---- 段 3：fetch_ladder（PDF 选器流 + download/doc 点击流；column_download 合规拒）
    def fetch_ladder(self, plan: HarvestPlan) -> LadderResult:
        url = plan.meta.source_url or ""
        parsed = parse_csdn_url(url)
        if parsed is None:
            raise CsdnUnsupportedUrlError("无法识别 CSDN 链接格式")
        t = parsed["type"]
        if t == "column_download":  # §1.1/§4 合规闸门：一律拒（墙标不适用）
            return LadderResult(ok=False, detail="图文专栏暂不支持下载")
        if t in DOWNLOAD_URL_TYPES:
            if not (self.cookie_str or self.storage_path):  # 凭据未供=如实挂账拒（零网络，不造假跳过）
                return LadderResult(ok=False, detail=(
                    "CSDN 凭据未供（%s 环境变量与 %s 的 [%s] %s 段均未供给）；"
                    "download/doc 分支挂账，待 VIP cookie 供给后补跑"
                    % (KB_CSDN_COOKIE_ENV, DEFAULT_CREDENTIALS_FILE.name,
                       CREDENTIALS_SECTION, CREDENTIALS_KEY)))
            try:
                outcome = download_resource(self.kit, url, out_dir=self.download_dir,
                                            cookie_str=self.cookie_str,
                                            storage_path=self.storage_path,
                                            page_hook=self.page_hook)
            except CsdnPaidWallError as exc:  # FR5.1 付费墙硬拒：wall_status 双落（结果位+NFR1 统一落点）
                mark_wall_status(plan.meta, WALL_PAID)
                return LadderResult(ok=False, wall_status=WALL_PAID, detail=str(exc))
            except (CsdnPage404Error, CsdnPageLoadError, CsdnDownloadTimeoutError,
                    CsdnDownloadButtonMissingError) as exc:
                return LadderResult(ok=False, detail=str(exc))
            self.log("csdn %s: %s -> %s" % (t, outcome.title, outcome.file_path))
            return LadderResult(
                ok=True, ladder_used="L2", artifact_path=str(outcome.file_path),
                detail="%s 点击流下载：文件名=%r；%d 字节（落盘实测，服务器原名不重命名）"
                       % (t, outcome.filename, outcome.file_size))
        try:
            outcome = web_page_to_pdf(self.kit, url, out_dir=self.download_dir,
                                      cookie_str=self.cookie_str,
                                      storage_path=self.storage_path)
        except CsdnPage404Error as exc:
            return LadderResult(ok=False, detail=str(exc))
        except CsdnContentMissingError as exc:
            return LadderResult(ok=False, detail=str(exc))
        self.log("csdn %s: %s -> %s" % (t, outcome.title, outcome.pdf_path))
        return LadderResult(
            ok=True, ladder_used="L2", artifact_path=str(outcome.pdf_path),
            pages=_pdf_pages(outcome.pdf_path), chars=outcome.dom_chars,
            detail="%s 选器流 PDF：标题=%r；chars=%d（内容选择器 innerText 非空白实测）"
                   % (t, outcome.title, outcome.dom_chars))

    # ---- 段 4：verify（.pdf=pypdfium2 数值化；download/doc 服务器原文件=在盘+非空；四门全检归 quality_gate）
    def verify(self, result: LadderResult) -> bool:
        if not result.ok or not result.artifact_path:
            return False
        artifact = Path(result.artifact_path)
        if not artifact.is_file() or artifact.stat().st_size < 1:
            return False
        if artifact.suffix.lower() != ".pdf":
            return True  # download/doc 点击流产物（zip/docx/…服务器原名）：在盘+非空即过
        try:
            doc = pypdfium2.PdfDocument(str(artifact))
        except Exception:
            return False
        try:
            return len(doc) >= 1
        finally:
            doc.close()
