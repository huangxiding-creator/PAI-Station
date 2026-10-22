# -*- coding: utf-8 -*-
"""L3 渲染兜底 render/fallback.py（T28；FR7.1 渲染链 + FR7.AC1 实弹口径）。

链路（唯一权威序）：
  ①检测/降级（入口）：failure_history（L1/L2 失败事件流）→ FR1.2 数值化判定器
    should_degrade 判真才进 L3（无数值化降级信号=fail-fast 调用方 bug）；
  ②无头加载：BrowserKit.generic_context（kit 级随机桌面 UA 复用）+ goto（domcontentloaded）；
    可选暖启动（warmup_url 先访落 cookie）+ referer——过百度系行为墙（2026-10-22 实测
    裸 goto 撞「百度安全验证」，暖启动 baidu.com+referer 后真文档页加载成功）；
  ③懒加载滚动（稻壳教程「缩放最小+滚动加载」经验口径：逐视口 90% 步进滚到底+
    连续 3 次读数页高不变=稳定，networkidle 尽力而为不阻断）；
  ④整页截图按视口高切片：每图一页、页几何=像素（1px=1pt）；页高在截窗上限内走
    full_page 整页截图，超高/页数封顶=拉高视口到截窗高再整视口截图（clip 实测被
    Chromium 钳到视口高，弃）+ max_pages 封顶，末页保留余高不补白；
  ⑤像素拼 PDF：pdf/image_pdf.build_image_pdf（PNG 零重编码直嵌）；
  ⑥OCR 文字层：render/ocr.make_pdf_searchable（150dpi 抽帧+识别+回注，同 BOOK118 参）；
  ⑦质检门：quality_gate manifest（expected_pages=切片实测页数、ref_chars=OCR 实测
    字数、ref_chars_source=type2[OCR 全文]）→ 与 CLI 同一判定函数，退出码入账。

死站边界行为（FR7.AC1①）：目标不可达（TLS 瘫痪/DNS/拒连/超时——PlaywrightError 一律
捕获）→ 如实报 unreachable：ok=False、零页零字、不产 0 页 PDF、audit 记 fail 行。

数字零造假（NFR2）：pages=切片实测数、chars=OCR 实测统计、coverage=截窗像素占比原样记录。
浏览器 launch/代理策略归调用方（kit.py 公约：launch/close 由调用方管）；本件另提供
launch_l3_browser 便利口——默认 direct:// 直连（引擎数据层 httpx 全程直连零代理；
本机系统代理死口时 Chromium 默认走系统代理即瘫，直连与数据层口径一致；需代理环境
传 proxy_server 覆盖）。
"""
from __future__ import annotations

import json
import time
import urllib.parse
from dataclasses import dataclass
from pathlib import Path
from typing import Sequence

from PIL import Image
from playwright.sync_api import BrowserContext, Error as PlaywrightError

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名（同 tests 双导入法）
    from kb_factory.harvest_engine.adapters.base import (
        AttemptEvent, LadderResult, should_degrade)
    from kb_factory.harvest_engine.browser.kit import BrowserKit
    from kb_factory.harvest_engine.pdf.image_pdf import build_image_pdf
    from kb_factory.harvest_engine.quality_gate import main as quality_gate_main
    from kb_factory.harvest_engine.render.ocr import (
        DEFAULT_DPI, SearchablePdfStats, make_pdf_searchable)
except ImportError:
    from harvest_engine.adapters.base import (  # noqa: E402
        AttemptEvent, LadderResult, should_degrade)
    from harvest_engine.browser.kit import BrowserKit  # noqa: E402
    from harvest_engine.pdf.image_pdf import build_image_pdf  # noqa: E402
    from harvest_engine.quality_gate import main as quality_gate_main  # noqa: E402
    from harvest_engine.render.ocr import (  # noqa: E402
        DEFAULT_DPI, SearchablePdfStats, make_pdf_searchable)

__all__ = [
    "L3_VIEWPORT", "CaptureStats", "FallbackOutcome", "ScrollStats",
    "build_fallback_pdf", "capture_page_shots", "launch_l3_browser",
    "render_fallback", "scroll_to_load", "slice_full_page", "write_gate_manifest",
]

L3_VIEWPORT = {"width": 1280, "height": 900}   # L3 渲染视口（generic_context 用）
NAV_TIMEOUT_MS = 45_000                        # ② 首跳导航超时
WARMUP_SETTLE_MS = 1_500                       # ② 暖启动页静置（落 cookie 后再跳目标）
NETWORK_IDLE_MS = 5_000                        # ③ networkidle 尽力而为窗（长连页可超时放行）
SCROLL_STEP_RATIO = 0.9                        # ③ 每步滚 90% 视口高（10% 重叠防漏帧）
SETTLE_MS = 700                                # ③ 每步滚动后静置
STABLE_POLLS = 3                               # ③ 连续 3 次页高读数不变=懒加载稳定
MAX_SCROLL_STEPS = 200                         # ③ 滚动步数硬顶（防病态无限长页）
MAX_PAGES_DEFAULT = 8                          # ④ 默认截窗页数上限
FULLSHOT_PX_CEIL = 16_000                      # ④ 整页截图像素上限（16384 限内留余量）

REASON_RENDERED = "rendered"       # 全链成功且质检门全过
REASON_UNREACHABLE = "unreachable" # 目标不可达（死站边界行为，如实报）
REASON_GATE_FAIL = "gate_fail"     # 渲染成功但质检门未过（数字照实入账）
REASON_EMPTY = "empty_capture"     # 截图切不出页（几何异常）
REASON_PIPELINE = "pipeline_error" # 拼 PDF/OCR 链路故障

#: L3 产物固定文件名（out_dir 内；调用方按目录隔离，本件不重名防覆盖）
NAME_FULL_PNG = "l3_fullpage.png"
NAME_RAW_PDF = "l3_raw.pdf"
NAME_FINAL_PDF = "l3_searchable.pdf"
NAME_MANIFEST = "l3_manifest.json"


# ---------------------------------------------------------------- 数据类

@dataclass(frozen=True)
class ScrollStats:
    """③ 懒加载滚动实测：最终页高 / 实际步数 / 是否达到稳定判据。"""

    height_px: int
    steps: int
    stable: bool


@dataclass(frozen=True)
class CaptureStats:
    """④ 截图实测：整页截图路径 / 页面总高 / 实际截窗高 / 切片清单（页序=此序）+ 滚动实测。"""

    full_png: str
    total_height_px: int
    captured_px: int
    slices: tuple
    scroll_steps: int = 0      # ③ 懒加载滚动实际步数（数字零造假）
    scroll_stable: bool = False  # ③ 是否达到稳定判据（False=步数硬顶截断，如实记）


@dataclass(frozen=True)
class FallbackOutcome:
    """L3 兜底出口（比产线 LadderResult 详，供编排/测试断言；产线经 to_ladder_result 接入）。"""

    ok: bool
    reason: str                     # REASON_* 之一
    url: str = ""
    pdf_path: str | None = None     # 可搜索 PDF（可持久产物）；失败=None（不产 0 页 PDF）
    pages: int = 0                  # 实测切片页数（零造假：失败=0）
    chars: int = 0                  # OCR 实测字数
    gate_exit: int | None = None    # 质检门退出码（0=全过；未到该段=None）
    coverage: str | None = None     # 截窗部分收割形态 "captured/total px"；全量截窗=None
    detail: str = ""                # 原样事实（单行）

    def to_ladder_result(self) -> LadderResult:
        """→ 产线 LadderResult（adapters.base 契约字段；梯队全败 ladder_used=None）。"""
        return LadderResult(
            ok=self.ok,
            ladder_used="L3" if self.ok else None,
            artifact_path=self.pdf_path,
            pages=self.pages if self.ok else None,
            chars=self.chars if self.ok else None,
            wall_status=None,
            coverage=self.coverage if self.ok else None,
            detail="L3 渲染兜底[%s] %s" % (self.reason, self.detail),
        )


# ---------------------------------------------------------------- 便利启动口

def launch_l3_browser(pw, *, headless: bool = True,
                      proxy_server: str | None = "direct://"):
    """L3 便利启动口：默认 ``--proxy-server=direct://`` 直连（理由见模块 docstring）。

    调用方自管 launch/闭口时可不经过本函数（kit 只吃 Browser）。
    """
    if proxy_server:
        return pw.chromium.launch(headless=headless,
                                  args=["--proxy-server=%s" % proxy_server])
    return pw.chromium.launch(headless=headless)


# ---------------------------------------------------------------- ③④ 渲染腿

def scroll_to_load(page, *, step_ratio: float = SCROLL_STEP_RATIO,
                   settle_ms: int = SETTLE_MS, stable_polls: int = STABLE_POLLS,
                   max_steps: int = MAX_SCROLL_STEPS) -> ScrollStats:
    """懒加载滚动：逐视口步进滚到底+静置，连续 stable_polls 次页高不变且已滚过底=稳定。

    病态无限长页由 max_steps 硬顶（stable=False 如实返回，不阻断链路）。
    """
    try:
        page.wait_for_load_state("networkidle", timeout=NETWORK_IDLE_MS)
    except PlaywrightError:
        pass  # 长连页永不 idle：尽力而为（滚动静置窗兜底）
    height = int(page.evaluate("() => document.documentElement.scrollHeight"))
    stable = 0
    y = 0
    steps = 0
    while steps < max_steps:
        viewport_h = int(page.evaluate("() => window.innerHeight")) or 1
        y += max(int(viewport_h * step_ratio), 1)
        page.evaluate("(py) => window.scrollTo(0, py)", y)
        page.wait_for_timeout(settle_ms)
        steps += 1
        new_height = int(page.evaluate("() => document.documentElement.scrollHeight"))
        if new_height == height and y >= new_height:
            stable += 1
            if stable >= stable_polls:
                return ScrollStats(new_height, steps, True)
        else:
            stable = 0
        height = max(height, new_height)
    return ScrollStats(height, steps, False)


def slice_full_page(full_png: Path | str, out_dir: Path | str, *,
                    page_height_px: int, max_pages: int = MAX_PAGES_DEFAULT) -> list:
    """整页截图 → 按视口高切片（每图一页、页几何=像素；末页保留余高不补白）。

    :raises ValueError: page_height_px<1（视口高非法）或截图几何异常（0 宽/高）——
        显式拒绝而非产 0 页 PDF。
    """
    full_png = Path(full_png)
    out_dir = Path(out_dir)
    if page_height_px < 1:
        raise ValueError("page_height_px=%d 非法：须 ≥1（视口高，fail-fast 而非除零）" % page_height_px)
    out_dir.mkdir(parents=True, exist_ok=True)
    with Image.open(full_png) as im:
        width, height = im.size
    if width < 1 or height < 1:
        raise ValueError("整页截图几何异常: %dx%d" % (width, height))
    slices = []
    n_pages = min((height + page_height_px - 1) // page_height_px, max_pages)
    for i in range(n_pages):
        top = i * page_height_px
        bottom = min(height, top + page_height_px)
        if bottom <= top:
            break
        target = out_dir / ("l3_page_%03d.png" % (i + 1))
        with Image.open(full_png) as im:
            im.crop((0, top, width, bottom)).save(target, format="PNG")
        slices.append(target)
    return slices


def capture_page_shots(context: BrowserContext, url: str, out_dir: Path | str, *,
                       max_pages: int = MAX_PAGES_DEFAULT,
                       nav_timeout_ms: int = NAV_TIMEOUT_MS,
                       warmup_url: str | None = None,
                       referer: str | None = None) -> CaptureStats:
    """②③④：无头加载 → 懒加载滚动到底 → 整页截图（超高截窗）→ 按视口高切片。

    暖启动（warmup_url 先访落 cookie）+ referer=过百度系行为墙口径（2026-10-22 实测：
    裸 goto 撞「百度安全验证」滑块墙；暖启动 baidu.com + referer 后真文档页加载成功）。
    导航失败原样抛 PlaywrightError（不可达判定归 render_fallback 入口）。
    """
    out_dir = Path(out_dir)
    page = context.new_page()
    try:
        if warmup_url:
            page.goto(warmup_url, timeout=nav_timeout_ms, wait_until="domcontentloaded")
            page.wait_for_timeout(WARMUP_SETTLE_MS)
        page.goto(url, timeout=nav_timeout_ms, wait_until="domcontentloaded",
                  referer=referer)
        scroll = scroll_to_load(page)
        out_dir.mkdir(parents=True, exist_ok=True)
        viewport_w = int(page.evaluate("() => window.innerWidth")) or 1
        viewport_h = int(page.evaluate("() => window.innerHeight")) or 1
        full_png = out_dir / NAME_FULL_PNG
        capture_px = min(scroll.height_px, max_pages * viewport_h, FULLSHOT_PX_CEIL)
        if capture_px >= scroll.height_px:  # 全量整页截图（页高在截窗上限内）
            page.screenshot(path=str(full_png), full_page=True)
        else:  # 截窗（超高/页数封顶）：clip 实测被 Chromium 钳到当前视口高
            # （2026-10-22 实测 21258px 页 clip 1800px 只得 900px）——改「拉高视口到
            # 截窗高再整视口截图」（不动内容、动取景框，稻壳「缩放最小」同精神）
            page.set_viewport_size({"width": viewport_w, "height": capture_px})
            page.wait_for_timeout(SETTLE_MS)
            page.screenshot(path=str(full_png))
        slices = slice_full_page(full_png, out_dir, page_height_px=viewport_h,
                                 max_pages=max_pages)
        return CaptureStats(str(full_png), scroll.height_px, capture_px, tuple(slices),
                            scroll_steps=scroll.steps, scroll_stable=scroll.stable)
    finally:
        page.close()


# ---------------------------------------------------------------- ⑤⑥⑦ 成品腿

def build_fallback_pdf(slices: Sequence[Path], out_dir: Path | str, *,
                       title: str | None = None,
                       ocr_dpi: int = DEFAULT_DPI) -> tuple[Path, Path, SearchablePdfStats]:
    """⑤⑥：切片 → 像素拼 PDF（raw）→ OCR 文字层回注（searchable）；返回实测统计。"""
    out_dir = Path(out_dir)
    raw_pdf = build_image_pdf(list(slices), out_dir / NAME_RAW_PDF, title=title)
    final_pdf = out_dir / NAME_FINAL_PDF
    stats = make_pdf_searchable(str(raw_pdf), str(final_pdf), dpi=ocr_dpi)
    return raw_pdf, final_pdf, stats


def write_gate_manifest(out_dir: Path | str, pdf_path: Path | str, *,
                        expected_pages: int, ref_chars: int,
                        ref_chars_source: str = "type2") -> Path:
    """⑦ 写质检门 manifest（参照值载体：expected_pages=切片实测页数、ref_chars=OCR 实测字数）。

    ref_chars 下限 1=quality_gate schema 正整数约束（OCR 0 字时门②按 1 参照判 0 实测=不过，
    只会更严不放宽）；绝对路径落盘，CLI 相对解析兼容。
    """
    manifest = {
        "pdf_path": str(pdf_path),
        "expected_pages": int(expected_pages),
        "ref_chars": max(int(ref_chars), 1),
        "ref_chars_source": ref_chars_source,
    }
    path = Path(out_dir) / NAME_MANIFEST
    path.write_text(json.dumps(manifest, ensure_ascii=False, indent=2), encoding="utf-8")
    return path


# ---------------------------------------------------------------- ①-⑦ 入口

def _audit_line(outcome: FallbackOutcome, audit_path: str | Path | None,
                degrade_form: str, started: float) -> None:
    """audit 台账：每请求如实一行（audit_path=None 不落盘；默认位不碰——公约§10）。"""
    if audit_path is None:
        return
    try:
        from kb_factory.harvest_engine.audit import HarvestAudit
    except ImportError:  # worktree 阶段回退顶层名
        from harvest_engine.audit import HarvestAudit

    site = urllib.parse.urlsplit(outcome.url).netloc or outcome.url[:60]
    detail = (outcome.detail or "").replace("\n", " ")[:400]
    HarvestAudit(str(audit_path)).request(
        site=site, event="fetch_ladder_L3", query_or_docid=outcome.url,
        count=outcome.pages, status="ok" if outcome.ok else "fail",
        detail="reason=%s degrade=%s elapsed=%.1fs %s"
               % (outcome.reason, degrade_form or "-", time.time() - started, detail))


def render_fallback(url: str, out_dir: str | Path, *, kit: BrowserKit,
                    failure_history: Sequence[AttemptEvent],
                    max_pages: int = MAX_PAGES_DEFAULT,
                    nav_timeout_ms: int = NAV_TIMEOUT_MS,
                    viewport: dict | None = None,
                    warmup_url: str | None = None,
                    referer: str | None = None,
                    ocr_dpi: int = DEFAULT_DPI,
                    title: str | None = None,
                    audit_path: str | Path | None = None) -> FallbackOutcome:
    """L3 渲染兜底入口（①-⑦ 全链）：目标 URL + L1/L2 失败历史 → 检测/降级 → 渲染兜底。

    :param failure_history: L1/L2 失败事件流（AttemptEvent；空或无降级信号=fail-fast）。
    :param kit: BrowserKit（generic_context 复用 kit 级随机桌面 UA；launch 归调用方）。
    :param warmup_url: 可选暖启动页（先访落 cookie 再跳目标——过百度系行为墙口径）。
    :param referer: 可选目标跳转 referer（与暖启动配套；None=不带）。
    :param max_pages: 截窗页数上限（部分收割如实记 coverage）。
    :param audit_path: 可选 harvest_audit 台账路径（不传=不落盘）。
    :return: FallbackOutcome（reason=rendered/unreachable/gate_fail/…；数字全实测）。
    """
    started = time.time()
    history = list(failure_history)
    if not history:
        raise ValueError("failure_history 为空：L3 只承接 L1/L2 已失败目标（调用方 bug，fail-fast）")
    decision = should_degrade(history)  # ①检测：FR1.2 数值化降级判定
    if not decision.degrade:
        raise ValueError("失败历史无降级信号（%s）：不该进 L3（调用方 bug，fail-fast）"
                         % (decision.evidence or "全部界内"))

    out_dir = Path(out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    context = kit.generic_context(viewport=viewport or dict(L3_VIEWPORT),
                                  accept_downloads=False)
    try:  # ②③④
        cap = capture_page_shots(context, url, out_dir,
                                 max_pages=max_pages, nav_timeout_ms=nav_timeout_ms,
                                 warmup_url=warmup_url, referer=referer)
    except PlaywrightError as exc:  # 死站边界：不可达如实报（零页零字，不产 0 页 PDF）
        first_line = str(exc).splitlines()[0][:200] if str(exc) else type(exc).__name__
        outcome = FallbackOutcome(False, REASON_UNREACHABLE, url=url,
                                  detail="%s: %s" % (type(exc).__name__, first_line))
        _audit_line(outcome, audit_path, decision.form, started)
        return outcome
    finally:
        context.close()

    if not cap.slices:
        outcome = FallbackOutcome(False, REASON_EMPTY, url=url,
                                  detail="整页截图 %dpx 切不出页" % cap.total_height_px)
        _audit_line(outcome, audit_path, decision.form, started)
        return outcome

    try:  # ⑤⑥
        _, final_pdf, stats = build_fallback_pdf(cap.slices, out_dir,
                                                 title=title or url, ocr_dpi=ocr_dpi)
    except Exception as exc:  # 拼 PDF/OCR 链路故障：如实失败（不吞异常类型）
        outcome = FallbackOutcome(False, REASON_PIPELINE, url=url,
                                  detail="%s: %s" % (type(exc).__name__, str(exc)[:200]))
        _audit_line(outcome, audit_path, decision.form, started)
        return outcome

    manifest = write_gate_manifest(out_dir, final_pdf,       # ⑦
                                   expected_pages=len(cap.slices),
                                   ref_chars=stats.chars)
    gate_exit = quality_gate_main([str(manifest)])
    coverage = (None if cap.captured_px >= cap.total_height_px
                else "%d/%dpx" % (cap.captured_px, cap.total_height_px))
    outcome = FallbackOutcome(
        gate_exit == 0, REASON_RENDERED if gate_exit == 0 else REASON_GATE_FAIL,
        url=url, pdf_path=str(final_pdf), pages=len(cap.slices), chars=stats.chars,
        gate_exit=gate_exit, coverage=coverage,
        detail="降级信号=%s(%s)；滚动 %d 步(稳定=%s)页高 %dpx 截窗 %dpx；OCR %d 行 %d 字"
               % (decision.form, decision.evidence, cap.scroll_steps,
                  cap.scroll_stable, cap.total_height_px,
                  cap.captured_px, stats.lines, stats.chars))
    _audit_line(outcome, audit_path, decision.form, started)
    return outcome
