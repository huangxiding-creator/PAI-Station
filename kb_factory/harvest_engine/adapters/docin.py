# -*- coding: utf-8 -*-
"""docin（豆丁）收割适配器 T34：L2 同会话资产直下 + 复活实证（FR6.AC1/FR6.1）。

施工唯一依据 = engine/SPECS/DOCIN_SPEC.md（T21，2026-10-22 活探+阅读器 JS 静态全解）：
- **L2 主径**（SPEC §6/§7.3）：Playwright 开真实文档页 /p-{pid}.html → 页内
  readerConfig 直采（sid=flash_param_hzq 明文（探针真身实测 64 字符，SPEC §1.5「80 字符」为误记）、零登录）+ 同会话 cookie →
  同一 context 内直下资产：page.douding.cn/docinfile2/{des,ddes}/page_{pid}_{e}.docin
  容器（Fish 2021 page_%s_%d.docin 模式换域+sid 存活，§1.6）与
  page.douding.cn/huangke/docxinshi/doc/{pid}/jpg/page-{n}.jpg 页图（0 基页号）。
  **页图主机实测修正**：SPEC §1.4 的 t.docin.com/build/… 系阅读器 JS 局部变量
  ``t`` 被误读为主机名（真身=huangke/docxinshi 家族）；t.docin.com 形态对浏览器
  与 httpx 一律 nginx 403（探针 E7/E8 + T34 两跑三腿实锤），不可用。
- **L1 复现验证点①**（§6）：httpx 携带「同一次 /p-*.html 访问所获 cookie+页内 sid」
  直打资产（置信 medium）——本适配器以 2 发探针实证并如实落档（通/闸两态都算定论）。
- **容器取样验证点②**（§6，.docin 容器格式置信 low-medium）：首跑按 e 候选取样 1 份，
  只落档 magic/长度/sha1/分型（响应即 JSON→svgbyjson 优先探测），**不臆测容器结构**。
- **成品链**：页图 jpg → pdf/image_pdf 像素拼 PDF → render/ocr OCR 文字层回注 →
  quality_gate manifest（ref_chars_source=type2[OCR 全文]，L3 兜底 T28 同参口径；
  quality_gate 五型词表暂无 docin 型，编排层收编时可改登记）→ 退出码 0=「复活」。
- **降级矩阵**（§7.5）：L2 资产腿失败事件流 → FR1.2 should_degrade 判真 →
  render/fallback.render_fallback L3 截图+OCR 兜底（自带质检门）。
- **墙语义**：资产腿全 ≥400（SPEC §2 实测 nginx 静态 403 闸）→ blocked_waf；
  readLeft.do code=201=登录墙（read_left_url/parse_read_left 已备，账号池腿勿硬闯）。

**T34 实弹校准实录（2026-10-22，样本 p-1508316827；SPEC 出入如实落档）**：
1. sid 实测 64 字符（SPEC §1.5「80 字符」误记）；
2. 页图主机=page.douding.cn/huangke/docxinshi 家族（SPEC §1.4 的 t.docin.com 系 JS
   局部变量误读，该域一律 nginx 403）；
3. width=1000 回 64B 桩（JPEG 魔数都不全）；790（Fish 遗产宽幅）全分辨率可用；176 原生；
4. wm=0 整页空白（尾部空页 ink=0.0000）→ wm=1 站方变体入带（0.0205 实测）；
5. **L1 复现实锤（强于 SPEC medium 置信）**：独立 httpx 仅凭 URL sid 直打页图=200 且
   与会话内取回字节一致（91915B 对拍）——页图闸=sid 参数本身，无需会话 cookie；
6. 容器格式实测：page_e0 12KB / head_e0 1.87MB，magic=01000000.. 自定义二进制，
   content-type=application/x-shockwave-flash（标签遗留非 SWF），结构未解析（如实）；
7. svgbyjson 腿实测在场：被动捕获 doc/{pid}/svgbyjson/page-0.json.z.b64——矢量 JSON
   重组最易路径，下游优先于 jpg 腿；
8. **jpg 缓存内容错位实测**：该 pid 文档页声明「2012考研政治…」而 jpg 缓存 4 页全文
   =「内江师范学院2011年工作总结」——站方缓存键位复用/陈旧疑点；下游收割 docin 须
   内容抽查（或走 svgbyjson/容器腿）后方可入编目，防张冠李戴。

注入点（工人公约 §3 网络/管线确定性缝，同 book118 page_loader/transport 先例）：
- ``session_factory(doc_url) -> session``：开页腿（缺省 Playwright 同会话实现）；
  session 协议 = ``.html``（页内容）/``.captured``（被动拦截资产 dict）/
  ``.fetch(url) -> (status, content_type, body, leg)``/``.close()``。
- ``l1_fetch(page_url, asset_url) -> (asset_status, asset_bytes, page_status)``：L1 探针腿。
- ``assemble(jpg_paths, out_dir, cfg, expected, truncated) -> (pdf_path, pages, chars,
  gate_exit)``：拼 PDF+OCR+质检门成品腿。
- ``fallback_runner(url, out_dir, history) -> LadderResult|None``：L3 兜底腿。

数字零造假：页数/字数/请求计数/容器字节数全实测；每请求 audit 如实一行；
实弹预算 max_requests=15 码内强制（含开页/资产/L1 探针，被动拦截不计——零额外请求）。
礼貌性：资产串行+页间 sleep（SPEC §7.6）；sid 单文档生命周期内复用（§7.2）。
"""
from __future__ import annotations

import base64
import hashlib
import io
import json
import re
import time
from dataclasses import dataclass
from pathlib import Path
from urllib.parse import quote

from PIL import Image

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名（同 book118.py）
    from kb_factory.channel_adapters.base import FileMeta
    from kb_factory.harvest_engine.adapters.base import (
        AttemptEvent, HarvestPlan, LadderResult, WALL_BLOCKED_WAF, DownloadAdapter,
        mark_wall_status, should_degrade)
    from kb_factory.harvest_engine.browser.kit import pick_desktop_ua
    from kb_factory.harvest_engine.pdf.image_pdf import build_image_pdf
    from kb_factory.harvest_engine.quality_gate import (
        INK_RATIO_MIN, image_ink_ratio, main as quality_gate_main)
    from kb_factory.harvest_engine.render.ocr import (
        DEFAULT_DPI, build_searchable_pdf, ocr_image, render_pages)
except ImportError:  # pragma: no cover - worktree 阶段路径
    from channel_adapters.base import FileMeta  # type: ignore
    from harvest_engine.adapters.base import (  # type: ignore
        AttemptEvent, HarvestPlan, LadderResult, WALL_BLOCKED_WAF, DownloadAdapter,
        mark_wall_status, should_degrade)
    from harvest_engine.browser.kit import pick_desktop_ua  # type: ignore
    from harvest_engine.pdf.image_pdf import build_image_pdf  # type: ignore
    from harvest_engine.quality_gate import (  # type: ignore
        INK_RATIO_MIN, image_ink_ratio, main as quality_gate_main)
    from harvest_engine.render.ocr import (  # type: ignore
        DEFAULT_DPI, build_searchable_pdf, ocr_image, render_pages)

__all__ = [
    "SITE", "DOCIN_HOME", "SEARCH_URL", "MAX_REQUESTS_DEFAULT", "PAGE_JPG_WIDTH_DEFAULT",
    "PAGE_JPG_WIDTH_FALLBACK", "JPG_BASE_CANDIDATES", "CONTAINER_E_CANDIDATES",
    "READER_SETTLE_MS", "ASSET_SLEEP_S", "DocinError", "DocinBudgetError", "DocPageConfig",
    "extract_pid", "doc_url", "parse_reader_config", "container_page_url",
    "container_head_url", "svgbyjson_file_url", "svgbyjson_doc_url", "page_jpg_url",
    "read_left_url", "parse_read_left", "harvest_plan_pages", "classify_asset",
    "parse_search_links", "DocinAdapter",
]

SITE = "docin"
DOCIN_HOME = "https://www.docin.com"
SEARCH_URL = DOCIN_HOME + "/search.do?searchcat=1003&searchType_banner=p&nkey="  # SPEC §1.1

MAX_REQUESTS_DEFAULT = 15   # 实弹预算（任务卡）：开页+资产+L1 探针合计 ≤15 发
NAV_TIMEOUT_MS = 30_000
READER_SETTLE_MS = 5_000    # 开页后渲染器自拉资产的静置窗（被动拦截零额外请求）
ASSET_SLEEP_S = 0.5         # 资产串行页间隔（SPEC §7.6 礼貌性）
HTTP_TIMEOUT_S = 20.0

#: 页图自适应候选（宽幅优先供 OCR：790=Fish 790x420 遗产宽幅实测全分辨率可用；
#: width=1000 实测回 64B 桩不可用；176=阅读器 addThumbImg 原生缩略宽；
#: 索引 0 基优先——addThumbImg(e){e=e-1} 实参即 0 基，meta_{pid}_0.docin 旁证）
PAGE_JPG_WIDTH_DEFAULT = 790
PAGE_JPG_WIDTH_FALLBACK = 176
JPG_WIDTH_CANDIDATES = (PAGE_JPG_WIDTH_DEFAULT, PAGE_JPG_WIDTH_FALLBACK)
JPG_BASE_CANDIDATES = (0, 1)

#: 容器 e 候选（渲染内核 headURLFun/pageURLFun 实参语义未公开；0 基优先=getMeta 同族旁证）
CONTAINER_E_CANDIDATES = ("0", "1", "2")

#: JPEG 魔数（E4 实测缩略图同族校验口径）
JPEG_MAGIC = b"\xff\xd8\xff"   # JPEG 魔数（E4 实测缩略图同族校验口径）


def _ink_of(jpeg_bytes: bytes) -> float:
    """JPEG 字节 → 非空白油墨比（quality_gate.image_ink_ratio 同口径实测；坏图 0.0）。"""
    try:
        with Image.open(io.BytesIO(jpeg_bytes)) as im:
            return image_ink_ratio(im)
    except Exception:
        return 0.0


#: 被动拦截资产形态（SPEC §7.3：page.douding.cn 容器/JSON/页图；t.docin.com 形态留匹配）
ASSET_CAPTURE_RE = re.compile(
    r"(docinfile2/.*\.docin\?|svgbyjson/.*\.json|huangke/docxinshi(-dev)?/doc/\d+/jpg/page-\d+\.jpg|t\.docin\.com/build/doc/.*/jpg/page-\d+\.jpg)")

_DEFAULT_UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
               "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")


class DocinError(Exception):
    """docin 收割链失败（kind 机器可读：no_doc_id/no_browser/no_reader_config/
    doc_not_ready/convert_failed_image_doc/pid_mismatch）。"""

    def __init__(self, kind: str, detail: str = ""):
        super().__init__(f"{kind}: {detail}")
        self.kind = kind
        self.detail = detail


class DocinBudgetError(DocinError):
    """实弹预算耗尽（≤15 发码内强制；如实失败不静默加发）。"""


# ---------------------------------------------------------------- 配置直采（SPEC §1.2/§4）

@dataclass(frozen=True)
class DocPageConfig:
    """文档页 readerConfig 直采产物（FileMeta/收割计划映射见 SPEC §4 字段表）。"""

    product_id: int
    sid: str                      # flash_param_hzq：全部正文 URL 的 ?sid=（≥6h，会话绑定）
    all_page: int                 # 总页数（FileMeta.pages 质检门基准）
    load_url: str = ""            # MaJun 型资产基址（无 scheme，拼 https://）
    preview_num: int = 0          # 预览页数（0=无限制；<allPage=截断+黄标）
    is_buy: int = 0
    is_login: int = 0
    doc_type: int = 0             # 0=正常 1=企业工具 2=建筑 3=转换失败图片文档
    pic_style: int = 2            # 1=HuangKe(SVG) 2=MaJun(canvas)
    doc_status: int = 0           # 0=普通 1=转换中 2=审核中 3=转换失败
    file_postfix: str = ""        # FileMeta.fmt
    product_name: str = ""        # FileMeta.title
    picture_base: str = ""        # picture_image_path_v1（静态资源基址）
    canvas_version: str = ""      # 渲染内核版本
    stat_page: int | None = None  # statJson.page（与 allPage 交叉校验）


def _extract_js_object(html: str, varname: str) -> str | None:
    """``var <name> = {...};`` → 花括号配平块（字符串感知；JS 行注释内的伪引号/伪括号
    以字符串态跳过——真身样本注释均为纯中文无引号，如实形态）。"""
    m = re.search(r"var\s+%s\s*=\s*\{" % re.escape(varname), html)
    if m is None:
        return None
    i = m.end() - 1
    depth = 0
    instr = ""
    j = i
    n = len(html)
    while j < n:
        c = html[j]
        if instr:
            if c == "\\":        # 转义对：跳过下一字符
                j += 2
                continue
            if c == instr:
                instr = ""
        elif c in "\"'":
            instr = c
        elif c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
            if depth == 0:
                return html[i:j + 1]
        j += 1
    return None


def _key_str(block: str, key: str) -> str:
    """块内取单/双引号字符串键值（缺失空串，不猜）。"""
    m = re.search(r"%s\s*:\s*([\"'])((?:\.|(?!\1).)*)\1" % re.escape(key), block)
    if m is None:
        return ""
    return m.group(2).replace("\'", "'").replace('\\"', '"').replace("\\\\", "\\")


def _key_int(block: str, key: str, default: int = 0) -> int:
    """块内取数值键值（容忍带引号形态 "2"；缺失=default，不猜）。"""
    m = re.search(r"%s\s*:\s*[\"']?(-?\d+)" % re.escape(key), block)
    return int(m.group(1)) if m else default


def parse_reader_config(html: str) -> DocPageConfig | None:
    """文档页 HTML → DocPageConfig（readerConfig 明文内嵌，零接口调用；无有效配置 None）。

    同步直采两段全局：picture_image_path_v1/canvas_version + statJson（page 与 allPage
    交叉校验口径留字段，不达标不在此硬拒——留 detail 如实记录）。
    """
    if not html:
        return None
    block = _extract_js_object(html, "readerConfig")
    if block is None:
        return None
    sid = _key_str(block, "flash_param_hzq")
    if not sid:                       # 无 sid=无正文访问形态（如实 None，不猜）
        return None
    stat_page = None
    stat_block = _extract_js_object(html, "statJson")
    if stat_block:
        try:
            stat_page = int(json.loads(stat_block).get("page"))
        except (ValueError, TypeError):
            stat_page = None
    m_pic = re.search(r"var\s+picture_image_path_v1\s*=\s*[\"']([^\"']+)[\"']", html)
    m_cv = re.search(r"var\s+canvas_version\s*=\s*[\"']([^\"']+)[\"']", html)
    return DocPageConfig(
        product_id=_key_int(block, "productId"),
        sid=sid,
        all_page=_key_int(block, "allPage"),
        load_url=_key_str(block, "load_url"),
        preview_num=_key_int(block, "previewNum"),
        is_buy=_key_int(block, "isBuy"),
        is_login=_key_int(block, "isLogin"),
        doc_type=_key_int(block, "docType"),
        pic_style=_key_int(block, "getPicStyle", default=2),
        doc_status=_key_int(block, "docstatus"),
        file_postfix=_key_str(block, "filepostfix"),
        product_name=_key_str(block, "productName"),
        picture_base=m_pic.group(1) if m_pic else "",
        canvas_version=m_cv.group(1) if m_cv else "",
        stat_page=stat_page)


def extract_pid(text: str) -> str | None:
    """输入（/p-{pid}.html 链接/裸 productId）→ productId 串；不可解析 None（不猜）。"""
    s = (text or "").strip()
    if not s:
        return None
    if s.isdigit():
        return s
    m = re.search(r"docin\.com/p-(\d+)(?:\.html)?", s)
    return m.group(1) if m else None


def doc_url(pid: str) -> str:
    """productId → 文档页 URL（SPEC §1.1）。"""
    return f"{DOCIN_HOME}/p-{pid}.html"


def harvest_plan_pages(cfg: DocPageConfig) -> tuple[list[int], bool]:
    """可收割页规划（SPEC §4 可收割性门/§7.6 预览截断）：

    - docstatus!=0 / docType==3 → 黄标降级拒收（显式 DocinError，不吞）；
    - 0<previewNum<allPage → 只收前 previewNum 页（truncated=True，黄标+coverage 部分形态）；
    - 其余（previewNum=0 或 ≥allPage）→ 全页。
    """
    if cfg.doc_status != 0:
        raise DocinError("doc_not_ready", f"docstatus={cfg.doc_status}（1转换中/2审核中/3失败）")
    if cfg.doc_type == 3:
        raise DocinError("convert_failed_image_doc", "docType=3 转换失败图片文档")
    total = max(int(cfg.all_page), 0)
    if 0 < cfg.preview_num < total:
        return list(range(1, cfg.preview_num + 1)), True
    return list(range(1, total + 1)), False


# ---------------------------------------------------------------- URL 组装（SPEC §1.4 JS 原文口径）

_SVG_CONTAINER_BASE = "https://page.douding.cn/docinfile2/des"      # initDocinSVGRender 硬编码
_SVG_BYJSON_BASE = "https://page.douding.cn/huangke/docxinshi"      # supportEbookCanvas 硬编码


def _container_base(cfg: DocPageConfig) -> str:
    """容器基址：SVG 型（getPicStyle=1）固定 des；MaJun 型（=2）= readerConfig.load_url。"""
    if cfg.pic_style == 1:
        return _SVG_CONTAINER_BASE
    return "https://" + cfg.load_url.lstrip("/")


def container_page_url(cfg: DocPageConfig, e) -> str:
    """正文分页容器 URL（Fish page_%s_%d.docin 模式换域+sid 存活，SPEC §1.6）。"""
    return f"{_container_base(cfg)}/page_{cfg.product_id}_{e}.docin?sid={cfg.sid}"


def container_head_url(cfg: DocPageConfig, e) -> str:
    """容器头件 URL（渲染内核 headURLFun 原文）。"""
    return f"{_container_base(cfg)}/head_{cfg.product_id}_{e}.docin?sid={cfg.sid}"


def svgbyjson_file_url(pid, sid: str, n: int) -> str:
    """svgbyjson 文件型（txt）：JS supportEbookCanvas pageURLFun 原文参数序。"""
    return (f"{_SVG_BYJSON_BASE}/file/{pid}/svgbyjson/page-{n}.json"
            f"?id={pid}&ext=txt&sid={sid}&width=800&height=1000&font-size=14")


def svgbyjson_doc_url(pid, sid: str, n: int, *, watermark: int = 0) -> str:
    """svgbyjson 文档型（.json.z.b64）：JS b64dataFun 原文参数序。"""
    return (f"{_SVG_BYJSON_BASE}/doc/{pid}/svgbyjson/page-{n}.json.z.b64"
            f"?sid={sid}&watermark={int(watermark)}")


def page_jpg_url(pid, sid: str, n: int, width: int = PAGE_JPG_WIDTH_DEFAULT,
                  *, watermark: int = 0) -> str:
    """页图 URL（阅读器 addThumbImg 原文真身=page.douding.cn/huangke/docxinshi 家族，
    n 为 0 基页号；width 可调）。

    **实测修正（2026-10-22 T34 实弹）**：DOCIN_SPEC §1.4/§1.5 把页图归到
    t.docin.com/build/…——系阅读器 JS 里局部变量 ``t`` 被误读为主机名（真身
    ``t="https://page.douding.cn/huangke/docxinshi[-dev]"``，与 svgbyjson 同族）；
    t.docin.com 形态对浏览器/httpx 一律 nginx 403（探针 E7/E8+T34 两跑实锤）。
    """
    return (f"{_SVG_BYJSON_BASE}/doc/{pid}/jpg/page-{n}.jpg"
            f"?sid={sid}&width={int(width)}&watermark={int(watermark)}")


def read_left_url(pid, *, free: bool = False) -> str:
    """sid 刷新端点（半页解锁；code 201=登录墙→账号池，勿硬闯，SPEC §1.4）。"""
    return f"{DOCIN_HOME}/newEnd/readLeft.do?pid={pid}" + ("&free=1" if free else "")


def parse_read_left(text: str) -> tuple[int | None, str | None]:
    """readLeft.do 响应 → (code, sid)；201=登录墙（账号池腿）/200+sid=刷新；坏响应 原样 None 对。"""
    try:
        payload = json.loads(text)
        return int(payload.get("code")), payload.get("sid")
    except (ValueError, TypeError):
        return None, None


def classify_asset(content_type: str, body: bytes) -> str:
    """资产分型：响应即 JSON 优先探测 svgbyjson（txt/ebook 型）；否则 container（.docin）。"""
    if body:
        head = body[:64].lstrip()
        if head[:1] in (b"{", b"[") or "json" in (content_type or "").lower():
            return "svgbyjson"
    return "container"


def parse_search_links(html: str) -> list[FileMeta]:
    """搜索渲染页 → FileMeta 列表（/p-{pid}.html 结果链接；去重保序；0 命中如实 []）。"""
    metas: list[FileMeta] = []
    seen: set[str] = set()
    for m in re.finditer(
            r'<a\b[^>]*href="(?:https?://www\.docin\.com)?(/p-(\d+)\.html)"[^>]*>(.*?)</a>',
            html, re.S):
        path, pid, inner = m.group(1), m.group(2), m.group(3)
        if pid in seen:
            continue
        seen.add(pid)
        text = re.sub(r"<[^>]+>", " ", inner)
        text = re.sub(r"\s+", " ", text).strip()
        title = text or pid
        suffix = title.rsplit(".", 1)[-1].lower() if "." in title else ""
        metas.append(FileMeta(
            title=title, fmt=suffix or "doc",
            source_url=DOCIN_HOME + path, extra={"docin_pid": pid}))
    return metas


# ---------------------------------------------------------------- 缺省会话（Playwright 同会话）

#: 同会话页内 fetch（跨域资产直下腿：浏览器 TLS+cookie；CORS 拒收时由 ctx_request 腿兜底）
_INPAGE_FETCH_JS = (
    "async (url) => {"
    "  const r = await fetch(url, {credentials: 'omit'});"
    "  const buf = await r.arrayBuffer();"
    "  const bytes = new Uint8Array(buf);"
    "  let bin = '';"
    "  const CH = 0x8000;"
    "  for (let i = 0; i < bytes.length; i += CH)"
    "    bin += String.fromCharCode.apply(null, bytes.subarray(i, i + CH));"
    "  return {status: r.status, type: r.headers.get('content-type') || '', b64: btoa(bin)};"
    "}")


#: cookie 值 token 安全白名单（Playwright APIRequestContext 头序列化口径；超出即除垢）
_SAFE_COOKIE_RE = re.compile(r"^[0-9A-Za-z._:\-+/= ]*$")


class _PlaySession:
    """缺省开页腿：一个 browser context = 一次同会话（cookie+sid 生命周期单元，SPEC §7.2）。

    - ``html``：文档页内容（goto→networkidle 尽力→静置→content；readerConfig 明文在内）；
    - ``captured``：开页期间渲染器自拉资产的被动拦截（``ASSET_CAPTURE_RE`` 命中才留，
      零额外请求——SPEC §7.3 路由拦截主径的零成本形态）；
    - ``fetch(url)``：同会话资产直下（腿1 context.request 共享 cookie；403/空再试
      腿2 页内 fetch 浏览器 TLS）→ ``(status, content_type, body, leg)``。
    """

    def __init__(self, browser, url: str, *, ua: str = _DEFAULT_UA,
                 settle_ms: int = READER_SETTLE_MS, nav_timeout_ms: int = NAV_TIMEOUT_MS):
        self.url = url
        self.captured: dict = {}
        self.context = browser.new_context(user_agent=ua,
                                           viewport={"width": 1280, "height": 900})
        self.page = self.context.new_page()
        self.page.on("response", self._on_response)
        try:
            self.page.goto(url, timeout=nav_timeout_ms, wait_until="domcontentloaded")
            try:
                self.page.wait_for_load_state("networkidle", timeout=settle_ms)
            except Exception:
                pass  # 长连页永不 idle：静置窗兜底
            self.page.wait_for_timeout(min(settle_ms, 2000))
            self.html = self.page.content()
        except Exception:
            self.close()
            raise

    def _on_response(self, response) -> None:
        try:
            url = response.url
            if not ASSET_CAPTURE_RE.search(url):
                return
            body = response.body()
        except Exception:
            return  # 已跳转/流关闭等：如实放弃该被动样本
        self.captured[url] = (response.status,
                              (response.headers or {}).get("content-type", ""), body)

    def _ctx_get(self, url: str):
        """腿1：context.request（共享 cookie，无 CORS 限制）；头序列化异常（Playwright
        对 cookie 值内 $ 等字符过敏——2026-10-22 实弹 _ga_ZYR13KTSXC 实锤）→除垢分析类
        cookie 重试一次；仍败如实 None。"""
        try:
            return self._ctx_get_once(url)
        except Exception:
            if self._sanitize_cookies():
                try:
                    return self._ctx_get_once(url)
                except Exception:
                    return None
            return None

    def _ctx_get_once(self, url: str):
        resp = self.context.request.get(url, headers={"Referer": self.url},
                                        fail_on_status_code=False)
        ctype = (resp.headers or {}).get("content-type", "")
        try:
            body = resp.body()
        except Exception:
            body = b""
        return resp.status, ctype, body

    def _sanitize_cookies(self) -> int:
        """除垢 cookie 值含非 token 安全字符的条目（GA 类分析 cookie；docin 自有
        cookie 值全为 hex/数字/单词，不受影响）；返回清除条数（实测计数）。"""
        dropped = 0
        for c in self.context.cookies():
            value = c.get("value") or ""
            if value and not _SAFE_COOKIE_RE.match(value):
                try:
                    self.context.clear_cookies(name=c.get("name"),
                                               domain=c.get("domain"),
                                               path=c.get("path"))
                    dropped += 1
                except Exception:
                    pass
        return dropped

    def _inpage_fetch(self, url: str):
        """腿2：页内 fetch（浏览器网络栈+同源凭证；跨域资产须站方 CORS 放行，拒收如实 None）。"""
        try:
            got = self.page.evaluate(_INPAGE_FETCH_JS, url)
            if got and got.get("b64"):
                return int(got.get("status", 0)), got.get("type", ""), base64.b64decode(got["b64"])
        except Exception:
            return None
        return None

    def _img_fetch(self, url: str):
        """腿2：页内 ``<img>`` 注入（图类资产跨域免 CORS——站方本以 <img> 消费；
        onload=body 已到位，response 监听器同窗收 body；10s 超时如实 None）。"""
        try:
            loaded = self.page.evaluate(
                "async (url) => {"
                "  return await new Promise((resolve) => {"
                "    const img = new Image();"
                "    const t = setTimeout(() => resolve(false), 10000);"
                "    img.onload = () => { clearTimeout(t); resolve(true); };"
                "    img.onerror = () => { clearTimeout(t); resolve(false); };"
                "    img.src = url;"
                "  });"
                "}", url)
        except Exception:
            return None
        if not loaded:
            return None
        for _ in range(20):            # onload 与 response 事件微小竞态：≤2s 轮询收 body
            hit = self.captured.get(url)
            if hit is not None:
                return hit[0], hit[1], hit[2]
            self.page.wait_for_timeout(100)
        hit = self.captured.get(url)
        return hit if hit is not None else None

    def fetch(self, url: str):
        """同会话直下三腿链：腿1 ctx_request（共享 context cookie）→ 腿2 页内 <img> 注入
        （浏览器网络栈+同源凭证+图类跨域免 CORS）→ 腿3 页内 fetch（须站方 CORS 放行）。
        皆败如实回最优一腿结果（全败=0/fetch_error）。

        实弹口径（2026-10-22 两跑+诊断探针实锤）：t.docin.com 响应链路触发 Playwright
        APIRequestContext「Invalid header value char」解析异感（除垢 cookie 后仍在，病灶
        在响应侧）；www.docin.com→t.docin.com 页内 fetch 被 CORS 拒（站方以 <img> 消费
        页图）——故图类走腿2。预算口径：调用方每 URL 计 1 发；腿级恢复 leg 字段如实入
        audit。
        """
        resp = self._ctx_get(url)
        if resp is not None and resp[0] < 400 and resp[2]:
            return resp[0], resp[1], resp[2], "ctx_request"
        img = self._img_fetch(url)
        if img is not None and img[0] < 400 and img[2]:
            return img[0], img[1], img[2], "img_inject"
        inpage = self._inpage_fetch(url)
        if inpage is not None and inpage[0] < 400 and inpage[2]:
            return inpage[0], inpage[1], inpage[2], "page_fetch"
        if img is not None:
            return img[0], img[1], img[2], "img_inject"
        if resp is not None:
            return resp[0], resp[1], resp[2], "ctx_request"
        if inpage is not None:
            return inpage[0], inpage[1], inpage[2], "page_fetch"
        return 0, "", b"", "fetch_error"

    def close(self) -> None:
        try:
            self.context.close()
        except Exception:
            pass


def _default_l1_fetch(page_url: str, asset_url: str) -> tuple[int, int, int]:
    """L1 复现探针腿（SPEC §6 验证点①）：独立 httpx 会话=「同一次 /p-*.html 访问收
    cookie+页内 sid」直打资产。trust_env=False 硬口径（Windows 系统代理吞请求坑，
    book118 2026-10-22 实弹实锤）。返回 (asset_status, asset_bytes, page_status)。"""
    import httpx
    with httpx.Client(timeout=HTTP_TIMEOUT_S, trust_env=False, follow_redirects=True,
                      headers={"User-Agent": _DEFAULT_UA,
                               "Accept-Language": "zh-CN,zh;q=0.9"}) as client:
        r1 = client.get(page_url)
        r2 = client.get(asset_url, headers={"Referer": page_url})
        return r2.status_code, len(r2.content), r1.status_code


# ---------------------------------------------------------------- 适配器四段

class DocinAdapter(DownloadAdapter):
    """docin 四段适配器（T34 落地件）：search/plan/fetch_ladder(L2 主径+L1 探针+L3 降级)/verify。

    生命周期纪律（browser/kit 同款）：browser 由调用方 launch/close；本件每次开页自开
    context、finally 必关（零泄漏）。预算 ``max_requests`` 码内强制（默认 15，任务卡实弹
    上限），被动拦截零额外请求不计；``requests_used`` 如实回读。
    """

    site = SITE
    channel = SITE

    def __init__(self, *, browser=None, audit=None, out_root=None,
                 session_factory=None, l1_fetch=None, assemble=None,
                 fallback_runner=None, sleep=time.sleep,
                 max_requests: int = MAX_REQUESTS_DEFAULT, ua: str | None = None):
        self._browser = browser
        self._audit = audit
        self._out_root = Path(out_root) if out_root else None
        self._session_factory = session_factory   # 注入点①：开页腿（网络）
        self._l1_fetch = l1_fetch                 # 注入点②：L1 探针腿（网络）
        self._assemble = assemble                 # 注入点③：拼 PDF+OCR+质检门成品腿（管线）
        self._fallback_runner = fallback_runner   # 注入点④：L3 兜底腿（管线）
        self._sleep = sleep
        self._max_requests = int(max_requests)
        self._ua = ua or pick_desktop_ua()
        self._requests_used = 0

    # ---- 预算与审计 ------------------------------------------------------
    @property
    def requests_used(self) -> int:
        """实弹请求计数（开页+资产+L1 探针；被动拦截不计——零额外请求）。"""
        return self._requests_used

    def _spend(self, n: int = 1) -> None:
        if self._requests_used + n > self._max_requests:
            raise DocinBudgetError(
                "budget_exhausted",
                f"requests {self._requests_used}+{n} > max {self._max_requests}")
        self._requests_used += n

    def _audit_row(self, event: str, docid: str, count: int, status: str,
                   detail: str) -> None:
        if self._audit is not None:
            self._audit.request(site=SITE, event=event, query_or_docid=str(docid),
                                count=int(count), status=status, detail=detail)

    # ---- 段1 search ------------------------------------------------------
    def search(self, query: str, limit: int) -> list[FileMeta]:
        """按查询词检 ≤limit 条 FileMeta（search.do 渲染页 /p-*.html 链接解析；SPEC §1.1）。

        搜索端点本波未活探（T21 预算用于文档页链）；匿名墙/空结果如实 []（不造假）。
        """
        url = SEARCH_URL + quote(query)
        try:
            session = self._open_session(url)
        except DocinError as exc:
            self._audit_row("search", query, 0, "fail", exc.kind)
            return []
        try:
            metas = parse_search_links(session.html)[:max(1, int(limit))]
            self._audit_row("search", query, len(metas),
                            "ok" if metas else "fail", f"hits={len(metas)}")
            return metas
        finally:
            session.close()

    # ---- 段2 plan --------------------------------------------------------
    def plan(self, meta: FileMeta) -> HarvestPlan:
        """单文档 → 收割计划：slot=productId；梯队序 L2→L3（L1 裸协议 SPEC §2 实测 403
        不进尝试序，同会话直下内嵌于 L2）。"""
        pid = meta.extra.get("docin_pid") or extract_pid(meta.source_url or "")
        return HarvestPlan(meta=meta, slot=str(pid or ""), ladder_try=("L2", "L3"))

    # ---- 段3 fetch_ladder ------------------------------------------------
    def fetch_ladder(self, plan: HarvestPlan) -> LadderResult:
        """L2 主径（同会话页图+容器取样+L1 探针→拼 PDF+OCR→质检门）→ 失败按 FR1.2
        数值化降级判 L3 截图兜底；墙/预算/降级形态全如实入 LadderResult。"""
        meta = plan.meta
        pid = str(meta.extra.get("docin_pid") or extract_pid(meta.source_url or "") or "")
        if not pid:
            raise DocinError("no_doc_id",
                             f"meta 无 docin_pid 且 source_url 不可解析: {meta!r}")
        meta.extra["docin_pid"] = pid
        out_dir = self._out_dir(pid)
        history: list[AttemptEvent] = []
        l2: LadderResult | None = None
        if "L2" in tuple(plan.ladder_try or ()):
            try:
                l2 = self._l2_run(meta, pid, out_dir, history)
            except DocinError as exc:
                l2 = LadderResult(ok=False, pages=0, coverage="0/?",
                                  detail=f"l2_error kind={exc.kind} {exc.detail}")
                self._audit_row("fetch_ladder", pid, 0, "fail", f"kind={exc.kind}")
        if l2 is not None and l2.ok:
            return l2
        decision = should_degrade(history)
        if "L3" in tuple(plan.ladder_try or ()) and decision.degrade:
            l3 = self._run_l3(doc_url(pid), out_dir, history)
            if l3 is not None:
                return l3
        return l2 if l2 is not None else LadderResult(ok=False, detail="no_ladder_level_ran")

    # ---- 段4 verify ------------------------------------------------------
    def verify(self, result: LadderResult) -> bool:
        """结构质检门：ok + 实测页数≥1 + coverage got==pages + 产物在盘 + 质检门退出码
        0 明细锚（gate_exit=0；重门已由 fetch_ladder 内 NFR-GATE 实测执行）。"""
        if not result.ok or not result.pages or result.pages < 1:
            return False
        m = re.fullmatch(r"(\d+)/(\d+|\?)", result.coverage or "")
        if m is None or int(m.group(1)) != result.pages:
            return False
        if "gate_exit=0" not in (result.detail or ""):
            return False
        if result.artifact_path and not Path(result.artifact_path).exists():
            return False
        return True


    # ---- 内部：开页/目录 ---------------------------------------------------
    def _open_session(self, url: str):
        """开页腿（注入点①优先；缺省 Playwright 同会话；1 发预算）。"""
        if self._session_factory is not None:
            session = self._session_factory(url)
            self._spend(1)
            return session
        if self._browser is None:
            raise DocinError("no_browser", "未注入 browser/session_factory，无法开页")
        self._spend(1)
        try:
            return _PlaySession(self._browser, url, ua=self._ua)
        except Exception as exc:
            raise DocinError("open_failed",
                             f"{type(exc).__name__}: {str(exc)[:160]}") from exc

    def _out_dir(self, pid: str) -> Path:
        base = Path(self._out_root) if self._out_root else Path(
            __import__("tempfile").gettempdir()) / "docin_harvest"
        out = base / f"docin_{pid}"
        out.mkdir(parents=True, exist_ok=True)
        return out

    def _session_fetch(self, session, url: str, history: list) -> tuple:
        """一次主动资产请求（1 发预算+audit 一行+失败事件入 history；被动命中走 _get）。"""
        self._spend(1)
        status, ctype, body, leg = session.fetch(url)
        ok = status == 200 and bool(body)
        self._audit_row("asset_fetch", url.split("?")[0].rsplit("/", 1)[-1],
                        len(body) if ok else 0, "ok" if ok else "fail",
                        f"http={status} leg={leg} bytes={len(body)}")
        history.append(AttemptEvent(http_status=int(status), pages=1))
        return status, ctype, body, leg

    def _get(self, session, url: str, history: list) -> tuple:
        """资产获取：被动拦截命中优先（零额外请求），未命中主动直下。"""
        hit = session.captured.get(url)
        if hit is not None:
            return hit[0], hit[1], hit[2], "passive_capture"
        return self._session_fetch(session, url, history)

    # ---- 内部：L2 主径 ----------------------------------------------------
    def _l2_run(self, meta: FileMeta, pid: str, out_dir: Path,
                history: list) -> LadderResult:
        session = self._open_session(doc_url(pid))
        self._audit_row("open_doc_page", pid, len(session.html or ""), "ok",
                        f"url={doc_url(pid)}")
        try:
            cfg = parse_reader_config(session.html or "")
            if cfg is None:
                return LadderResult(ok=False, pages=0, coverage="0/?",
                                    detail="no_reader_config（无 flash_param_hzq：访问受限/结构变更）")
            if str(cfg.product_id) != str(pid):
                raise DocinError("pid_mismatch",
                                 f"readerConfig.productId={cfg.product_id} != {pid}")
            meta.pages = cfg.all_page
            if cfg.file_postfix:
                meta.fmt = cfg.file_postfix
            meta.extra.update({"docin_sid": cfg.sid, "docin_all_page": cfg.all_page,
                               "docin_preview_num": cfg.preview_num,
                               "docin_pic_style": cfg.pic_style,
                               "docin_doc_status": cfg.doc_status,
                               "docin_title": cfg.product_name})
            try:
                pages, truncated = harvest_plan_pages(cfg)
            except DocinError as exc:   # docstatus!=0 / docType==3：黄标降级拒收
                meta.perm = "yellow"
                meta.extra["docin_degrade"] = exc.kind
                return LadderResult(ok=False, pages=0,
                                    coverage=f"0/{cfg.all_page}",
                                    detail=f"yellow_degrade kind={exc.kind} {exc.detail}")
            if truncated:               # previewNum<allPage：预览截断+黄标（SPEC §7.6）
                meta.perm = "yellow"
                meta.extra["docin_partial_preview"] = True
            sample = self._sample_container(session, cfg, history)
            if sample is not None:
                meta.extra["docin_container_sample"] = sample
            jpg_paths, misses, wm1_pages = self._fetch_page_jpgs(
                session, cfg, pages, history, out_dir)
            if wm1_pages:
                meta.extra["docin_page_wm1"] = wm1_pages   # 空白页水印变体升级台账
            l1 = self._l1_probe(cfg)
            meta.extra["docin_l1_probe"] = l1
            if misses:
                wall = self._maybe_wall(meta, history)
                return LadderResult(ok=False, pages=len(jpg_paths), wall_status=wall,
                                    coverage=f"{len(jpg_paths)}/{cfg.all_page}",
                                    detail=f"jpg_missing={misses} "
                                           f"requests={self._requests_used}")
            pdf, n_pages, chars, gate = self._assemble_pages(
                jpg_paths, out_dir, cfg, expected=len(pages), truncated=truncated)
            meta.extra["docin_gate_exit"] = gate
            ok = gate == 0 and n_pages == len(pages)
            detail = (f"requests={self._requests_used} pages={n_pages}/{len(pages)} "
                      f"chars={chars} gate_exit={gate} truncated={truncated} "
                      f"l1_asset={l1['asset_status']} "
                      f"container={(sample or {}).get('status')}")
            self._audit_row("fetch_ladder", pid, n_pages, "ok" if ok else "fail", detail)
            return LadderResult(ok=ok, ladder_used="L2" if ok else None,
                                artifact_path=pdf, pages=n_pages, chars=chars,
                                coverage=f"{len(pages)}/{cfg.all_page}", detail=detail)
        finally:
            session.close()


    def _sample_container(self, session, cfg: DocPageConfig, history: list) -> dict | None:
        """容器取样（SPEC §6 验证点②，Fish page_%s_%d.docin 蓝本；e 候选≤3 发，
        被动命中零成本优先）：只落档 magic/长度/sha1/分型，容器结构不臆测（low-medium
        置信）；全败如实 None（不阻断页图主链）。"""
        for want in (r"docinfile2/(?:page|head)_.*\.docin\?",
                    r"docinfile2/.*\.docin\?"):
            for url, hit in session.captured.items():    # 被动拦截优先：渲染器自拉容器
                if not re.search(want, url):
                    continue
                status, ctype, body = hit
                if status == 200 and body:
                    e = re.search(r"_%s_(\w+)\.docin\?" % cfg.product_id, url)
                    return self._container_sample_dict(cfg, url, e.group(1) if e else "?",
                                                       status, ctype, body, "passive_capture")
            break    # want 梯队：page_/head_ 命中即出；仅 meta_ 在场亦如实取样
        for e in CONTAINER_E_CANDIDATES:
            url = container_page_url(cfg, e)
            status, ctype, body, leg = self._get(session, url, history)
            if status == 200 and body:
                return self._container_sample_dict(cfg, url, str(e), status, ctype,
                                                   body, leg)
        return None

    @staticmethod
    def _container_sample_dict(cfg: DocPageConfig, url: str, e: str, status: int,
                               ctype: str, body: bytes, leg: str) -> dict:
        kind = classify_asset(ctype, body)
        return {"url": url, "sid": cfg.sid, "e": str(e), "status": status,
                "kind": kind, "bytes": len(body), "magic_hex": body[:16].hex(),
                "sha1": hashlib.sha1(body).hexdigest(),
                "content_type": ctype, "leg": leg,
                "note": "Fish 蓝本取样留档；容器内部结构未解析（SPEC 置信 low-medium）"}

    def _fetch_page_jpgs(self, session, cfg: DocPageConfig, pages: list,
                         history: list, out_dir: Path) -> tuple[list, list, list]:
        """页图收割（同会话 page.douding.cn/huangke 家族）：首页自适应发现
        (索引基,宽度) 候选→锁定参数逐页直下；JPEG 魔数 ffd8ff 实测校验；
        整页空白（ink<质检门③下界）→站方 watermark=1 合法变体重取（油墨入带）；
        缺页如实入 misses（不造假页）。返回 (页文件序, 缺页号, wm1 升级页号)。"""
        pages_dir = out_dir / "pages"
        pages_dir.mkdir(parents=True, exist_ok=True)
        base = None
        width = None
        discovery_failed = False
        paths: list[Path] = []
        misses: list[int] = []
        wm1_pages: list[int] = []

        def try_url(url: str) -> bytes | None:
            status, ctype, body, leg = self._get(session, url, history)
            return body if status == 200 and body[:3] == JPEG_MAGIC else None

        for i, n in enumerate(pages):
            if i:
                self._sleep(ASSET_SLEEP_S)
            if discovery_failed:        # 首页全候选失败：同参重扫必同败，余页直接记缺（预算纪律）
                misses.append(n)
                continue
            if base is None:            # 首页发现：0 基索引×宽幅优先（候选 4 发内）
                for b in JPG_BASE_CANDIDATES:
                    for w in JPG_WIDTH_CANDIDATES:
                        body = try_url(page_jpg_url(cfg.product_id, cfg.sid,
                                                    n if b == 1 else n - 1, w))
                        if body is not None:
                            base, width = b, w
                            break
                    if base is not None:
                        break
                if base is None:
                    discovery_failed = True
                    misses.append(n)
                    continue
            else:
                body = try_url(page_jpg_url(cfg.product_id, cfg.sid,
                                            n if base == 1 else n - 1, width))
                if body is None:
                    misses.append(n)
                    continue
            body, wm = self._wm_upgrade(session, cfg,
                                        n - 1 if base == 0 else n, width, body, history)
            if wm:
                wm1_pages.append(n)
            target = pages_dir / ("page_%03d.jpg" % n)
            target.write_bytes(body)
            paths.append(target)
        return paths, misses, wm1_pages

    def _wm_upgrade(self, session, cfg: DocPageConfig, idx: int, width: int,
                    body: bytes, history: list) -> tuple[bytes, int]:
        """wm=0 命中但整页空白（ink<质检门③下界，如尾部空页）→ watermark=1 站方合法
        变体重取（2026-10-22 实测 p3：wm0 ink=0.0000 → wm1 ink=0.0205 入带）；无改善
        如实用 wm=0（门③将如实判）。返回 (body, watermark)。"""
        if _ink_of(body) >= INK_RATIO_MIN:
            return body, 0
        status, ctype, body1, leg = self._get(
            session, page_jpg_url(cfg.product_id, cfg.sid, idx, width, watermark=1),
            history)
        if status == 200 and body1[:3] == JPEG_MAGIC and _ink_of(body1) > _ink_of(body):
            return body1, 1
        return body, 0

    def _l1_probe(self, cfg: DocPageConfig) -> dict:
        """L1 复现探针（SPEC §6 验证点①，2 发）：独立 httpx「页 cookie+sid」直打资产；
        通/闸两态都是定论（200=独立协议可复现；403=会话绑定实锤），如实落档。"""
        page_url = doc_url(str(cfg.product_id))
        asset_url = page_jpg_url(cfg.product_id, cfg.sid, 1, PAGE_JPG_WIDTH_DEFAULT)
        if self._l1_fetch is not None:
            asset_status, asset_bytes, page_status = self._l1_fetch(page_url, asset_url)
        else:
            self._spend(2)
            asset_status, asset_bytes, page_status = _default_l1_fetch(page_url, asset_url)
        self._audit_row("l1_probe", str(cfg.product_id), asset_bytes,
                        "ok" if asset_status == 200 else "fail",
                        f"page={page_status} asset={asset_status} bytes={asset_bytes}"
                        f"（200=独立 httpx 复现通；403=同会话绑定实锤）")
        return {"page_status": int(page_status), "asset_status": int(asset_status),
                "asset_bytes": int(asset_bytes)}

    @staticmethod
    def _maybe_wall(meta: FileMeta, history: list) -> str | None:
        """资产腿全 ≥400（nginx 静态 403 闸形态，SPEC §2）→ blocked_waf 统一标记落位。"""
        statuses = [e.http_status for e in history if e.http_status]
        if statuses and all(s >= 400 for s in statuses):
            mark_wall_status(meta, WALL_BLOCKED_WAF)
            return WALL_BLOCKED_WAF
        return None

    # ---- 内部：成品链与 L3 -------------------------------------------------
    def _assemble_pages(self, jpg_paths: list, out_dir: Path, cfg: DocPageConfig,
                        *, expected: int, truncated: bool):
        """成品腿（注入点③优先）：像素拼 PDF→OCR 文字层→NFR-GATE manifest→退出码。"""
        if self._assemble is not None:
            return self._assemble(jpg_paths, out_dir, cfg, expected, truncated)
        title = cfg.product_name or ("docin_%s" % cfg.product_id)
        assemble_dir = out_dir / "assemble"
        raw_pdf = build_image_pdf(list(jpg_paths), assemble_dir / "docin_raw.pdf",
                                  title=title)
        # OCR 文字层（T13 二级管线三步走；空文本行过滤——paddle 偶发空行，回注件拒空串）
        frames = render_pages(str(raw_pdf), dpi=DEFAULT_DPI)
        pages_lines = [[ln for ln in ocr_image(frame) if ln.text] for frame in frames]
        final_pdf = assemble_dir / "docin_searchable.pdf"
        stats = build_searchable_pdf(frames, pages_lines, str(final_pdf), dpi=DEFAULT_DPI)
        manifest = {"pdf_path": str(final_pdf),
                    "ref_chars": max(int(stats.chars), 1),
                    "ref_chars_source": "type2"}   # OCR 全文口径（L3 T28 同参；词表暂无 docin 型）
        manifest["preview_limit" if truncated else "expected_pages"] = int(expected)
        mpath = out_dir / "docin_manifest.json"
        mpath.write_text(json.dumps(manifest, ensure_ascii=False, indent=2),
                         encoding="utf-8")
        gate = quality_gate_main([str(mpath)])
        return str(final_pdf), stats.pages, stats.chars, gate

    def _run_l3(self, url: str, out_dir: Path, history: list) -> LadderResult | None:
        """L3 兜底腿（SPEC §7.5 降级矩阵；缺省接线 render/fallback T28 全链+自带质检门）。"""
        if self._fallback_runner is not None:
            return self._fallback_runner(url, out_dir, list(history))
        if self._browser is None:
            self._audit_row("fetch_ladder_L3", url, 0, "fail", "no_browser")
            return None
        try:
            self._spend(1)   # L3 首跳导航 1 发（预算内强制）
        except DocinBudgetError as exc:
            self._audit_row("fetch_ladder_L3", url, 0, "fail", exc.kind)
            return None
        from kb_factory.harvest_engine.browser.kit import BrowserKit
        from kb_factory.harvest_engine.render.fallback import render_fallback
        kit = BrowserKit(self._browser, user_agent=self._ua)
        outcome = render_fallback(url, Path(out_dir) / "l3", kit=kit,
                                  failure_history=list(history))
        self._audit_row("fetch_ladder_L3", url, outcome.pages,
                        "ok" if outcome.ok else "fail", (outcome.detail or "")[:200])
        ladder = outcome.to_ladder_result()
        if outcome.gate_exit == 0:
            ladder.detail += " gate_exit=0"   # verify 段统一口径锚
        return ladder
