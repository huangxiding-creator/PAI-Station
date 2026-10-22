# -*- coding: utf-8 -*-
"""doc88 收割适配器·配置发现腿（T24）：URL/p_code 定位 + key2 info XML / key1 页面 m_main 双路解密
（DOC88_SPEC §1.1/§1.2/§1.3；FR4.1；ADR-3 方案B 机制重写，零 GPL 码）。

本任务落地件（任务卡路径纪律，同文件后续波次续建）：
- ``extract_p_code``：裸 p_code / ``p-{code}.html`` / ``doc.php?act=info|download`` 三形态定位；
- ``parse_info_xml``：方法1 明文 XML（key2 已解）→ ``Doc88Config``（层头表+每页定位表）；
- ``parse_m_main``：方法2 明文 JSON（key1 已解，71 键）→ ``Doc88Config``（pageInfo 为 key1
  内层二段编码，本件解为页表；headerInfo 带引号逗号表）；
- ``discover_config``：方法1 ``doc.php?act=info`` 优先（curl_cffi impersonate="chrome"
  + Referer + 浏览器 UA，§3 防御性指纹），失败回退文档页 ``m_main.init`` 挖载荷
  （parse/inline_var.extract_m_main T03 件）；WAF 特征字命中经 envelope.judge_doc88
  （T02 件）判 ``blocked_waf`` 硬拒——**禁第三方镜像域自动回退（R20/FR4.AC2）**；
  ``p_404=1`` → 文档不存在硬拒；两法皆折如实抛错（per-leg 明细进 detail，零造假）；
- ``Doc88DownloadAdapter``：DownloadAdapter 子类骨架 channel="doc88"：段2 plan=配置发现
  （配置平铺落 ``meta.extra["doc88_config"]``，实测页数回填 ``meta.pages``；WAF 落
  ``wall_status`` 标记位后重抛）；段1 选品端点未定（§5：首页 JS 动态无直链）、
  段3 ebt 下载切片属 T27、段3/4 SWF→FFDec→PDF 全链属 T32、等价抽取阈值门属 T39。

现场校准（2026-10-22 活探，doc88 站内 5 发 ≤8 预算，证据固化在本件测试 docstring）：
- key2 码表 2026 新件未轮换：/list-1022.html 分类页取样 93243737771803（71 页单层）、
  60390909156220（56 页单层）info 路全通，XML 与 2011 件逐字段同构；
- XML 路常缺 ``p_download``（免费直下判定归 JSON 路/T36，如实 None 不造假）；
- 71 键 m_main JSON 实测无 ``p_allow_page_count``（仅 XML 有；JSON 路如实 None）。

T27 落地件（2026-10-22，同文件续建·只增不改；DOC88_SPEC §1.4/§2/§3 R14）：
- 资产名/URL：``ph_asset_name``/``pk_asset_name``/``ebt_asset_url``——文件名=key2 编码
  「层号-偏移-长度-{p_swf}[-{页码}-{p_code}]」，与站方资产逐字复现（69091550288
  PH L1 实测 ``getebt-0rUX…==.ebt``，§5 探针实录；URL 保留 =/!/+ 原样）；
- ``fetch_ebt_asset``：单资产**整文件**下载（ebt CDN 忽略 Range 头，R14——只整下不
  续传，请求永不带 Range）→ 判件（长度==配置口径 + PH 魔数 YBD\\x01 + PK zlib 成流，
  R16 只认字节）→ ``Store.put_asset`` 整文件字节缓存（doc=p_code 自动落 progress
  分块；判件不过不落缓存，坏字节不进库）；
- ``decompress_ebt_slice``：PH[40:]/PK[32:] 切片解压（try_decompress_zlib 真符号
  严格偏移优先 + zlib 头族级别无关判定 + find_zlib_streams 回扫兜底，Adler-32 天然
  防伪；流实际起点如实入账）；
- ``harvest_ebt_assets``：逐层 PH+逐页 PK 收割编排（page_nos 页子集 / ph_levels
  附加层头，探针预算友好；层头集=所选页所在层∪ph_levels）；产物=PageSlice
  （swf_head+swf_body 即 zlib×2 解压拼接；``\\x40\\x00\\x00\\x00`` 终止符+长度补丁+
  帧 RECT 修正归 T32 SWF 合成）；全页模式硬断言切片数==页表页数（数字零造假）；
- 段3 fetch_ladder 编排接线归 T32（SWF→FFDec→PDF 全链就绪时一并收口；T24 契约
  测试钉住裸 meta 调用须 NotImplementedError，本波不动该桩）；
- ebt CDN 实弹补遗（2026-10-22）：站方无条件回 ``Content-Encoding: compress`` 而
  body 实为原始字节——curl_cffi/libcurl 拒收（curl 61），网络腿自动降级 plain
  requests（同 Referer/UA；即原工具 CDN 走普通 requests 的机制原因，DOC88_SPEC §3）；
- EBT 新格式实锤（2026-10-22，93243737771803）：PH 魔数 ``YBD\\x02``（2011 件
  ``\\x01`` 之版本演化）、zlib 为 0x78da 最高压缩级（2011 件 0x789c）——魔数判
  ``YBD`` 前缀族、解压加 zlib 头族级别无关判定（T05 真符号 789c 限定保留在前）。

T32 落地件（2026-10-22，同文件续建·只增+接线 fetch_ladder 桩；DOC88_SPEC
§1.6/§1.7/§6 复刻落地顺序 4→5）：
- ``synthesize_page_swf``：§1.6 三行公式（swf_raw+``\\x40\\x00\\x00\\x00`` 终止符+
  ``swf[4:8]`` 长度补丁）→ ``swf_resize_if_needed`` 帧 RECT 修正/帧数 0 检测
  （pdf.swf_toolchain 真符号，T27 报告第1条接线口径）；
- ``swf_chain_to_pdf``：FFDec frame:pdf 分组双导出（每组一 JVM）→ presse merge
  （≥2 输入才 merge，单页直用 frames.pdf）→ pypdfium2 实测页数/字数 +
  quality_gate manifest 落盘（expected_pages/ref_chars/ref_chars_source=doc88）；
  参照口径实锤（FFDec 26.4.0 ``-help export`` 全格式清单）：无 ``frame:text`` 格式、
  doc88 页文字全住 DefineSprite 内（CLI ``-export text`` 实弹零文件，顶层
  DefineEditText 合成对照可导出=导出器无恙）→ 「FFDec frame:text 同源参照」落为
  同 SWF 集 frame:pdf **双导出**第二腿逐页抽字（实弹 4 页 376==376，比例 1.000）；
- ``Doc88DownloadAdapter.fetch_ladder``：段3 L1 主径实装——发现(T24)+收割(T27)+
  全链(T32) 三真件编排；异常族 Doc88WAFBlocked（wall_status 标记位）/Doc88DocNotFound
  /Doc88AssetError 及 T32 新增 Doc88ChainError/ToolchainError/SwfError → ok=False 的
  LadderResult（页数/字数全实测，数字零造假）。

T36 落地件（2026-10-22，同文件续建·只增+verify 桩实装；DOC88_SPEC §3/§1.8 +
R20/FR4.AC2/FR4.AC3 + T32 下游2/下游3）：
- 镜像禁令（FR4.AC2/R20）：``MIRROR_DOMAIN_BLACKLIST``（piglin.eu.org=原工具作者自建
  镜像域）+ ``is_mirror_url``/``reject_mirror_url``/``Doc88MirrorBlocked``——镜像域 URL
  **请求前**硬拒（blocked_mirror_policy），接进三条网络路径（文本腿/二进制腿/
  fetch_ebt_asset）：即便上游「配置了」镜像域（ebthost 投毒/URL 直喂），网络层零触碰；
- 免费直下分支（FR4.AC3，§1.8）：``download_url``/``sniff_document_magic``/
  ``fetch_free_download``——p_download==1 门开先走 ``doc.php?act=download&pcode=``：
  PDF 魔数短路成件（pypdfium2 实测页数/字数），非文档体（登录墙/404）如实挂账回退
  ebt L1；``free_probe`` 选通=XML 路缺 p_download 时补一发页面 JSON 路判定（默认关，
  请求预算纪律）。**挂账注记：免费直下接口登录态需求未验证**（2026-10-22 抽样总体
  4 件全 p_download="2" 无免费件可实证；付费件端点实测 404 空体——台账见测试 docstring）；
- ``verify`` 桩实装（T32 下游2/下游3）：``meta.extra["doc88_chain"]["manifest_path"]``
  直连 quality_gate 四门 CLI（退出码 0=质检门全过）；manifest_path=None（纯图件
  ref_chars=0 不落 manifest/免费直下件无 FFDec 参照）判空路=字数门空真（ref=0）+
  ①页/③水印/④完整性三门对产物实测——内存 manifest 不落盘（不伪造 schema 要求的
  ref_chars≥1，数字零造假）；判定明细入 ``last_verify_detail``。

T41P0 落地件（2026-10-23，PentAGI 研判 P0 清偿·FR10.1 发布硬门）：
- P0-1（TLS 双态切换）+ P0-5（compress 谎报）：两条默认腿显式声明
  ``Accept-Encoding: identity``（PentAGI ⑤ 建议参数表）；curl(61) 兜底改为
  **同栈**低级 ``curl_cffi.Curl`` 原样取回（impersonate 保留、关自动解码）——
  **绝不降级 urllib3/plain requests**（原降级腿已删除：JA3 Chrome↔Python-urllib3
  切换=研判判定最直接封号触发点）；字节判件维持 R16 只认字节不认 header（压缩体
  进不来库：魔数/长度/zlib 三重门 fail-closed）；
- P0-2（零间隔无频控）：``NetworkPacer`` 进程级显式频控接线**默认腿**（单发
  800~1500ms 随机抖动·下限 500ms + info 端点独立间隔 ≥2s + 文档间冷却 5~15s +
  每 8 文档会话冷却 30~60s + 日配额 2000 熔断）——注入腿零接线零等待（确定性
  测试不受影响），不再依赖 FFDec 隐式节流；
- P0-3（info 双发）：``ConfigCache`` p_code 级配置缓存（会话 TTL+FIFO 有界），
  ``plan``/``fetch_ladder`` 段间共享 1 发 info/文档；只缓存成功配置（WAF/404
  fail-closed 不入缓存）；
- P0-4（free_probe 法律面）：``FREE_PROBE_DEFAULT=False`` 常量化默认关（生产
  保持关闭）；上线前合规验证挂账在案（doc88_assessment 清偿注记）。
"""
from __future__ import annotations

import json
import random
import re
import tempfile
import time
import urllib.parse
import xml.etree.ElementTree as ET
import zlib
from dataclasses import dataclass
from pathlib import Path
from typing import Callable, Mapping, Sequence

from kb_factory.channel_adapters.base import FileMeta
from kb_factory.harvest_engine.adapters.base import (
    HarvestPlan, LadderResult, WALL_BLOCKED_WAF, DownloadAdapter, mark_wall_status)
from kb_factory.harvest_engine.assets.magic_check import (
    find_zlib_streams, sniff_format, try_decompress_zlib)
from kb_factory.harvest_engine.codec.variant_b64 import (
    DOC88_KEY1_NAME, DOC88_KEY2_NAME, VariantB64Error, decode as vb_decode,
    encode as vb_encode)
from kb_factory.harvest_engine.envelope import DOC88_WAF_MARKER, EnvelopeFail, judge_doc88
from kb_factory.harvest_engine.parse.inline_var import extract_m_main
from kb_factory.harvest_engine.pdf.swf_toolchain import (
    SwfError, presse_merge, run_ffdec_frame_pdf, swf_resize_if_needed)
from kb_factory.harvest_engine.quality_gate import count_chars
from kb_factory.harvest_engine.store.ledger import Store
from kb_factory.harvest_engine.tools.fetch_toolchain import ToolchainError

__all__ = [
    "DOC88_BASE", "DOC88_REFERER", "DOC88_UA", "IMPERSONATE", "DEFAULT_TIMEOUT",
    "P_CODE_RE", "DOC88_HOST_RE", "info_url", "page_url", "extract_p_code",
    "PageLoc", "Doc88Config", "parse_info_xml", "parse_m_main",
    "Doc88Error", "Doc88WAFBlocked", "Doc88DocNotFound", "Doc88ConfigError",
    "discover_config", "Doc88DownloadAdapter",
    # T27：ebt 资产下载+整文件字节缓存+PH/PK 分层切片（FR4.AC1）
    "PH_KIND", "PK_KIND", "PH_HEAD_LEN", "PK_HEAD_LEN", "BytesFetch",
    "Doc88AssetError", "EbtAsset", "PageSlice", "EbtHarvest",
    "ph_asset_name", "pk_asset_name", "ebt_asset_url",
    "fetch_ebt_asset", "decompress_ebt_slice", "harvest_ebt_assets",
    # T32：SWF 合成 + FFDec/presse 全链 + 段3 fetch_ladder 接线（FR4.AC1）
    "SWF_TERMINATOR", "SWF_ZOOM", "FFDEC_GROUP_SIZE", "FFDEC_TIMEOUT_S",
    "DOC88_REF_CHARS_SOURCE", "Doc88ChainError", "synthesize_page_swf",
    "plan_swf_groups", "merge_frames_pdfs", "Doc88PdfChain", "swf_chain_to_pdf",
    # T36：镜像禁令（FR4.AC2/R20）+ 免费直下分支（FR4.AC3）+ 段4 verify 实装
    "MIRROR_DOMAIN_BLACKLIST", "Doc88MirrorBlocked", "is_mirror_url",
    "reject_mirror_url", "DOCUMENT_MAGICS", "sniff_document_magic",
    "download_url", "FreeDownloadAttempt", "fetch_free_download",
    # T41P0：PentAGI 研判 P0 清偿（TLS 单态/显式频控/info 缓存合并/free_probe 常量关）
    "ACCEPT_ENCODING_IDENTITY", "FREE_PROBE_DEFAULT", "Doc88RateBudgetError",
    "JITTER_MIN_S", "JITTER_MAX_S", "JITTER_FLOOR_S", "INFO_ENDPOINT_MIN_GAP_S",
    "DOC_COOLDOWN_MIN_S", "DOC_COOLDOWN_MAX_S", "SESSION_DOC_INTERVAL",
    "SESSION_COOLDOWN_MIN_S", "SESSION_COOLDOWN_MAX_S", "DAILY_REQUEST_LIMIT",
    "NetworkPacer", "CONFIG_CACHE_TTL_S", "CONFIG_CACHE_MAX_ENTRIES", "ConfigCache",
]

DOC88_BASE = "https://www.doc88.com"    # 站点基址（info/文档页/下载接口均在此域）
DOC88_REFERER = DOC88_BASE + "/"        # DOC88_SPEC §1.2：info 请求须带首页 Referer
DOC88_UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
            "Chrome/129.0.0.0 Safari/537.36")
IMPERSONATE = "chrome"                  # §3：防御性 TLS 指纹（非当前硬门槛，成本为零顺手带上）
#: T41P0（P0-1/P0-5）：默认腿显式声明的不压缩编码——主动告知 CDN 别回 ``compress``
#: （古董 LZW 名，libcurl 不识即 curl(61)）；本地实测 0.16.3：该头可覆写 impersonate
#: 默认值（服务端实测收到的就是 identity），但 CDN 若仍谎报 compress 则由同栈低级
#: 兜底腿收原样字节（见 ``_curl_cffi_raw_get``），全程不换 TLS 栈。
ACCEPT_ENCODING_IDENTITY = "identity"
#: T41P0（P0-4）：free_probe 生产保持关闭（研判修法原文；开前须合规验证 download
#: 端点鉴权门槛——2026-10-22 抽样总体无 p_download==1 件可实证，挂账在案）。
FREE_PROBE_DEFAULT = False
DEFAULT_TIMEOUT = 20.0

# p_code=纯数字（实测 11 位 2011 件 / 14 位 2026 件；6~20 宽域兼容）
P_CODE_RE = re.compile(r"^[0-9]{6,20}$")
_P_PAGE_PATH_RE = re.compile(r"^/p-([0-9]{6,20})(?:\.html)?/?$")
DOC88_HOST_RE = re.compile(r"^(?:[a-z0-9-]+\.)*doc88\.com$", re.I)  # 主站及子域（含 ebt CDN）

INFO_XML_SOURCE = "info_xml"        # 方法1（doc.php?act=info → key2 → XML）
PAGE_M_MAIN_SOURCE = "page_m_main"  # 方法2（文档页 m_main.init → key1 → JSON）

#: 网络腿注入点签名：(url, timeout) -> (http_status, body_text)——确定性测试注入用（任务卡明示）
Fetch = Callable[[str, float], tuple[int, str]]


# ---------------- 异常族（wall_status 属性对齐 NFR1 标记位词表） ----------------

class Doc88Error(Exception):
    """doc88 配置发现基础异常（wall_status=None：非墙类失败）。"""

    wall_status: str | None = None


class Doc88WAFBlocked(Doc88Error):
    """WAF 特征字「网络环境安全验证」双路命中 → 硬拒（FR4.AC2；禁第三方镜像 R20）。"""

    wall_status = WALL_BLOCKED_WAF


class Doc88DocNotFound(Doc88Error):
    """p_404=1 文档不存在（envelope.judge_doc88 判 doc_not_found）。"""


class Doc88ConfigError(Doc88Error):
    """配置不可得/不可解（双路皆折或输入无 p_code；detail 携 per-leg 实测明细）。"""


class Doc88RateBudgetError(Doc88Error):
    """默认网络腿日请求配额熔断（T41P0/P0-2：研判 ⑤ 日配额 1000~2000 发取上限，
    超限即停不再发——总量可控；wall_status=None：非墙类，属我方自律熔断）。"""


# ---------------- 数据类 ----------------

@dataclass(frozen=True)
class PageLoc:
    """单页定位（p_struct/<p> 或 pageInfo 单条）：层-宽-高-起始偏移-长度。"""

    level: int     # 所属层（e 字段；>50 页老文档分层，以表为准勿自行推算）
    width: int     # 页宽 px（SWF 帧 RECT 修正用，twip=px*20，归 T32）
    height: int    # 页高 px
    offset: int    # 层内字节偏移（PK 切片用，归 T27）
    length: int    # 页体字节长度


@dataclass(frozen=True)
class Doc88Config:
    """doc88 单文档配置（两法统一内表；FR4.1 解出字段全集）。

    - ``p_allow_page_count``：XML 路有/71 键 JSON 路实测无 → 如实 None；
    - ``p_download``：站方原值（"1"=免费直下件，FR4.AC3 分支归 T36）；两路均常缺省 None；
    - ``header_sizes``：层头表（每层 PH 文件字节数，层号升序）；
    - ``pages``：每页定位表（页码升序 1..N）。
    """

    p_code: str
    p_name: str | None
    p_pagecount: int
    p_ebthost: str
    p_swf: str
    header_sizes: tuple[int, ...]
    pages: tuple[PageLoc, ...]
    source: str
    p_allow_page_count: int | None = None
    p_download: str | None = None
    p_404: str | None = None

    @property
    def is_free_download(self) -> bool:
        """p_download=="1" 判免费直下（envelope 同口径 _is_one）。"""
        return self.p_download is not None and self.p_download.strip() == "1"

    def to_mapping(self) -> dict:
        """平铺事实映射：envelope.judge_doc88/ledger/orchestrator 直接消费。"""
        return {
            "p_code": self.p_code, "p_name": self.p_name,
            "p_pagecount": self.p_pagecount, "p_allow_page_count": self.p_allow_page_count,
            "p_ebthost": self.p_ebthost, "p_swf": self.p_swf, "p_download": self.p_download,
            "p_404": self.p_404, "header_sizes": list(self.header_sizes),
            "pages": len(self.pages), "source": self.source,
        }


# ---------------- URL / p_code 定位（纯解析零网络） ----------------

def info_url(p_code: str) -> str:
    """方法1 端点：doc.php?act=info&p_code=（§1.2）。"""
    return f"{DOC88_BASE}/doc.php?act=info&p_code={p_code}"


def page_url(p_code: str) -> str:
    """文档页端点：p-{p_code}.html（方法2 回退路输入）。"""
    return f"{DOC88_BASE}/p-{p_code}.html"


def extract_p_code(url_or_id: str) -> str | None:
    """裸 p_code / 文档页 URL / doc.php 参数 URL → p_code；解不出如实 None（不猜）。

    接受形态：裸 6~20 位纯数字；doc88.com（含子域，路径相对形态亦可）的
    ``/p-{code}.html``；``/doc.php`` 的 ``p_code``/``pcode`` query（info/download 两用）。
    """
    if url_or_id is None:
        return None
    s = str(url_or_id).strip()
    if P_CODE_RE.match(s):
        return s
    split = urllib.parse.urlsplit(s)
    host = (split.hostname or "").lower()
    if host and not DOC88_HOST_RE.match(host):
        return None  # 非 doc88 域不按 doc88 规则提取
    m = _P_PAGE_PATH_RE.match(split.path or "")
    if m:
        return m.group(1)
    if host and (split.path or "").rstrip("/") == "/doc.php":
        qs = urllib.parse.parse_qs(split.query)
        for key in ("p_code", "pcode"):
            for value in qs.get(key, []):
                if P_CODE_RE.match(value):
                    return value
    return None


# ---------------- 方法1：info XML 解析（纯解析零网络） ----------------

def parse_info_xml(xml: bytes | str) -> Doc88Config:
    """key2 解密后的 info XML 明文 → Doc88Config（source=info_xml）。

    结构（§1.3 实测）：根下 CDATA 标量字段 + ``<p_struct>`` 层头表（``<h n="层号">``）
    与每页定位表（``<p n="页码"><e>层</e><w>宽</w><h>高</h><p>偏移</p><l>长度</l></p>``；
    注意页内嵌套 ``<h>``/``<p>`` 与层头/页码同名不同义，按父子层级取，不按全局搜索）。
    """
    data = xml if isinstance(xml, (bytes, bytearray)) else str(xml).encode("utf-8")
    try:
        root = ET.fromstring(data)
    except ET.ParseError as exc:
        raise Doc88ConfigError(f"info XML 解析失败：{exc}") from exc
    scalars: dict[str, str] = {}
    for child in root:  # 仅取叶子标量（p_struct 整枝跳过；annotate_time 等非 CDATA 标量同收）
        if child.tag != "p_struct" and len(child) == 0 and child.text is not None:
            scalars[child.tag] = child.text.strip()
    for key in ("p_code", "p_pagecount", "p_ebthost", "p_swf"):
        if key not in scalars:
            raise Doc88ConfigError(f"info XML 缺必得字段 {key}（实测字段集见 DOC88_SPEC §1.3）")
    struct = root.find("p_struct")
    if struct is None:
        raise Doc88ConfigError("info XML 缺 p_struct（层头表+每页定位表）")
    heads = _struct_layer_heads(struct)
    pages = _struct_pages(struct)
    return Doc88Config(
        p_code=scalars["p_code"], p_name=scalars.get("p_name"),
        p_pagecount=_req_int(scalars, "p_pagecount"),
        p_ebthost=scalars["p_ebthost"], p_swf=scalars["p_swf"],
        header_sizes=heads, pages=pages, source=INFO_XML_SOURCE,
        p_allow_page_count=_opt_int(scalars.get("p_allow_page_count")),
        p_download=scalars.get("p_download"), p_404=scalars.get("p_404"))


def _struct_layer_heads(struct: ET.Element) -> tuple[int, ...]:
    """p_struct 直接子层头 <h n="层号">大小</h> → 层号升序大小表（页内嵌套 h 不入）。"""
    heads: list[tuple[int, int]] = []
    for h in struct.findall("h"):
        no, size = h.attrib.get("n", ""), (h.text or "").strip()
        if not no.isdigit() or not size.isdigit():
            raise Doc88ConfigError(f"层头表条目不成形：<h n={no!r}>{size!r}</h>")
        heads.append((int(no), int(size)))
    if not heads:
        raise Doc88ConfigError("层头表空（p_struct 无 <h n=...> 直接子节点）")
    heads.sort()
    return tuple(size for _, size in heads)


def _struct_pages(struct: ET.Element) -> tuple[PageLoc, ...]:
    """p_struct 直接子页 <p n="页码"> → 页码升序定位表（页内嵌套 p=偏移 不混入）。"""
    pages: list[tuple[int, PageLoc]] = []
    for p in struct.findall("p"):
        no = p.attrib.get("n", "")
        vals = {c.tag: (c.text or "").strip() for c in p}
        if not no.isdigit():
            raise Doc88ConfigError(f"每页定位表页码不成形：n={no!r}")
        for key in ("e", "w", "h", "p", "l"):
            if not vals.get(key, "").isdigit():
                raise Doc88ConfigError(f"第 {no} 页定位字段 {key!r} 不成形：{vals.get(key)!r}")
        pages.append((int(no), PageLoc(int(vals["e"]), int(vals["w"]), int(vals["h"]),
                                       int(vals["p"]), int(vals["l"]))))
    if not pages:
        raise Doc88ConfigError("每页定位表空（p_struct 无 <p n=...> 直接子节点）")
    pages.sort()
    return tuple(loc for _, loc in pages)


def _req_int(scalars: Mapping[str, str], key: str) -> int:
    try:
        return int(scalars[key])
    except ValueError as exc:
        raise Doc88ConfigError(f"字段 {key} 非整数：{scalars[key]!r}") from exc


def _opt_int(value: str | None) -> int | None:
    if value is None or value == "":
        return None
    try:
        return int(value)
    except ValueError as exc:
        raise Doc88ConfigError(f"可选整数字段不成形：{value!r}") from exc


def _xml_p404(xml: bytes) -> bool:
    """p_404 容错预判（404 件 XML 常缺 p_struct 等结构）：只找根下 p_404==1 标量。"""
    try:
        root = ET.fromstring(xml)
    except ET.ParseError:
        return False
    for child in root:
        if child.tag == "p_404" and len(child) == 0 and (child.text or "").strip() == "1":
            return True
    return False


# ---------------- 方法2：页面 m_main JSON 解析（纯解析零网络） ----------------

def parse_m_main(payload: Mapping) -> Doc88Config:
    """key1 解密后的 m_main JSON（71 键）→ Doc88Config（source=page_m_main）。

    字段换名（§1.3 两法等价表）：``ebt_host``→p_ebthost；``headerInfo``="带引号逗号表"
    →层头表；``pageInfo``=key1 内层二段编码的 ``层-宽-高-偏移-长度,...`` 串→每页定位表；
    ``p_allow_page_count`` 实测不在 71 键内 → 如实 None。
    """
    def need(key: str):
        if key not in payload:
            raise Doc88ConfigError(f"m_main JSON 缺必得字段 {key}（71 键实测字段集见测试留档）")
        return payload[key]

    header_sizes = _quoted_int_list(str(need("headerInfo")))
    pages = _page_info_entries(vb_decode(DOC88_KEY1_NAME, str(need("pageInfo")),
                                         expect=lambda b: b"-" in b))
    p_code = str(need("p_code"))
    p_pagecount = _json_int(payload, ("p_pagecount", "pageCount"), len(pages))
    p_404 = payload.get("p_404")
    return Doc88Config(
        p_code=p_code, p_name=_opt_str(payload.get("p_name")), p_pagecount=p_pagecount,
        p_ebthost=str(need("ebt_host")), p_swf=str(need("p_swf")),
        header_sizes=header_sizes, pages=pages, source=PAGE_M_MAIN_SOURCE,
        p_allow_page_count=_opt_int(_opt_str(payload.get("p_allow_page_count"))),
        p_download=_opt_str(payload.get("p_download")),
        p_404=None if p_404 is None else str(p_404).strip())


def _quoted_int_list(value: str) -> tuple[int, ...]:
    """headerInfo 形如 '"455235","453032","454972"' → 整数表（引号剥离，非数字即拒）。"""
    items = [p.strip().strip("\"'") for p in value.split(",")]
    out = []
    for item in items:
        if not item.isdigit():
            raise Doc88ConfigError(f"headerInfo 条目非数字：{item!r}（原文 {value[:80]!r}）")
        out.append(int(item))
    if not out:
        raise Doc88ConfigError("headerInfo 空")
    return tuple(out)


def _page_info_entries(decoded: bytes) -> tuple[PageLoc, ...]:
    """pageInfo 内层明文 ``层-宽-高-偏移-长度,...`` → 每页定位表（页序即串序）。"""
    text = decoded.decode("utf-8", errors="strict").strip()
    if not text:
        raise Doc88ConfigError("pageInfo 解码后为空")
    pages = []
    for i, chunk in enumerate(text.split(","), start=1):
        parts = chunk.split("-")
        if len(parts) != 5 or not all(p.isdigit() for p in parts):
            raise Doc88ConfigError(f"pageInfo 第 {i} 条不成形：{chunk!r}")
        pages.append(PageLoc(*(int(p) for p in parts)))
    return tuple(pages)


def _json_int(payload: Mapping, keys: tuple[str, ...], default: int) -> int:
    """按序取首个可整化的键（p_pagecount 主、pageCount 兜底、页表长度垫底）。"""
    for key in keys:
        try:
            return int(payload[key])
        except (KeyError, TypeError, ValueError):
            continue
    return default


def _opt_str(value) -> str | None:
    if value is None:
        return None
    s = str(value).strip()
    return s or None


# ---------------- 网络腿（curl_cffi 默认；注入点可换） ----------------

def _curl_cffi_get(url: str, timeout: float) -> tuple[int, str]:
    """默认文本网络腿：curl_cffi impersonate="chrome" + Referer + 浏览器 UA（§1.2/§3）。

    T41P0（P0-1/P0-2/P0-5）：+显式 ``Accept-Encoding: identity``（主动声明编码，防
    CDN 回 ``compress`` 触发 curl(61)）；+默认腿显式频控（``_pace_network_request``）；
    curl(61) 类内容编码错走**同栈**低级兜底腿（``_curl_cffi_raw_get``，JA3 全程锁
    Chrome）——绝不降级 urllib3。
    """
    reject_mirror_url(url)  # T36/R20：镜像域 URL 请求前硬拒（网络层零触碰）
    _pace_network_request(url)  # T41P0/P0-2：默认腿显式频控（注入腿零接线）
    from curl_cffi import requests as curl_requests  # 延迟导入：纯解析路径零依赖
    headers = {"Referer": DOC88_REFERER, "User-Agent": DOC88_UA,
               "Accept-Encoding": ACCEPT_ENCODING_IDENTITY}
    try:
        r = curl_requests.get(url, impersonate=IMPERSONATE, timeout=timeout,
                              headers=headers)
        return r.status_code, r.content.decode("utf-8", errors="replace")
    except Exception as exc:
        if not _is_content_encoding_error(exc):
            raise
        status, data = _curl_cffi_raw_get(url, timeout)  # P0-1：同栈兜底，不换 TLS
        return status, data.decode("utf-8", errors="replace")


# ---------------- discover_config：双路编排 ----------------

def _leg_info(p_code: str, fetch: Fetch, timeout: float) -> tuple[Doc88Config | None, str, bool]:
    """方法1 单腿：info 端点 → WAF 判 → key2 解（expect '<?xml'）→ XML 解 → p_404/错件门。

    返回 (config|None, 实测明细, waf_hit)；p_404=1 直接抛 Doc88DocNotFound（判死不回退）。
    """
    try:
        status, body = fetch(info_url(p_code), timeout)
    except Exception as exc:  # 网络异常如实降级到方法2（含超时/复位/指纹拒）
        return None, f"方法1 info 网络异常 {type(exc).__name__}: {exc}", False
    if DOC88_WAF_MARKER in body:
        return None, f"方法1 info 命中 WAF 特征字（HTTP {status}）", True
    if status != 200:
        return None, f"方法1 info HTTP {status}", False
    try:
        xml_bytes = vb_decode(DOC88_KEY2_NAME, body.strip(),
                              expect=lambda b: b.startswith(b"<?xml"))
    except VariantB64Error as exc:
        return None, f"方法1 info key2 解密失败：{exc}", False
    try:
        config = parse_info_xml(xml_bytes)
    except Doc88ConfigError as exc:
        if _xml_p404(xml_bytes):  # 404 件 XML 常缺 p_struct：先于全量校验判死，不回退
            raise Doc88DocNotFound(f"p_404=1 文档不存在：{p_code}") from None
        return None, f"方法1 info {exc}", False
    verdict = judge_doc88(config.to_mapping())
    if isinstance(verdict, EnvelopeFail):
        if verdict.kind == "doc_not_found":
            raise Doc88DocNotFound(f"p_404=1 文档不存在：{p_code}")
        return None, f"方法1 info 信封判败 {verdict.kind}: {verdict.detail}", False
    if config.p_code != p_code:
        return None, f"方法1 info 错件配置：请求 {p_code} 得 {config.p_code}", False
    return config, "方法1 info OK", False


def _leg_page(p_code: str, fetch: Fetch, timeout: float) -> tuple[Doc88Config | None, str, bool]:
    """方法2 单腿：文档页 → WAF 判 → m_main.init 挖载荷（T03 件）→ key1 解 → JSON 解。

    返回 (config|None, 实测明细, waf_hit)；p_404=1（JSON 侧偶现键）同判死。
    """
    try:
        status, body = fetch(page_url(p_code), timeout)
    except Exception as exc:
        return None, f"方法2 页面网络异常 {type(exc).__name__}: {exc}", False
    if DOC88_WAF_MARKER in body:
        return None, f"方法2 页面命中 WAF 特征字（HTTP {status}）", True
    if status != 200:
        return None, f"方法2 页面 HTTP {status}", False
    payload = extract_m_main(body)
    if payload is None:
        return None, "方法2 页面无 m_main.init 载荷", False
    try:
        raw = vb_decode(DOC88_KEY1_NAME, payload,
                        expect=lambda b: b.lstrip().startswith(b"{"))
        data = json.loads(raw)
        config = parse_m_main(data)
    except (VariantB64Error, json.JSONDecodeError, Doc88ConfigError) as exc:
        return None, f"方法2 m_main 解密/解析失败：{exc}", False
    if config.p_404 == "1":
        raise Doc88DocNotFound(f"p_404=1 文档不存在：{p_code}")
    if config.p_code != p_code:
        return None, f"方法2 m_main 错件配置：请求 {p_code} 得 {config.p_code}", False
    return config, "方法2 m_main OK", False


def discover_config(url_or_p_code: str, *, fetch: Fetch | None = None,
                    timeout: float = DEFAULT_TIMEOUT) -> Doc88Config:
    """配置发现主入口（FR4.1）：方法1 优先，失败回退方法2；WAF 双中 → blocked_waf 硬拒。

    - 方法1（§1.2 推荐）：``doc.php?act=info`` → key2 变体 base64 密文 → XML；
    - 方法2（回退）：文档页 ``m_main.init`` → key1 → JSON（两法字段等价，§1.3）；
    - 任一腿命中 WAF 特征字不立即熔断（对侧腿仍可能是端点级拦截），双路皆无配置
      且有 WAF 命中 → ``Doc88WAFBlocked``（R20：不自动走第三方镜像域）；
    - ``p_404=1`` → ``Doc88DocNotFound``；其余皆折 → ``Doc88ConfigError``（明细逐腿如实）。
    """
    p_code = extract_p_code(url_or_p_code)
    if p_code is None:
        raise Doc88ConfigError(f"无法从输入解出 doc88 p_code：{url_or_p_code!r}")
    fetch = fetch or _curl_cffi_get
    config, reason1, waf1 = _leg_info(p_code, fetch, timeout)
    if config is not None:
        return config
    config, reason2, waf2 = _leg_page(p_code, fetch, timeout)
    if config is not None:
        return config
    if waf1 or waf2:
        raise Doc88WAFBlocked(
            "doc88 配置发现双路皆折且命中 WAF 特征字「" + DOC88_WAF_MARKER + "」"
            "（blocked_waf 硬拒；按 R20 禁第三方镜像域自动回退）。明细：\n  "
            + reason1 + "\n  " + reason2)
    raise Doc88ConfigError("doc88 配置发现双路皆折。明细：\n  " + reason1 + "\n  " + reason2)


# ---------------- DownloadAdapter 子类骨架 ----------------

class Doc88DownloadAdapter(DownloadAdapter):
    """doc88 收割适配器：段2 plan（T24）+段3 fetch_ladder L1 主径（T32 接线）已落地；
    段1 search/段4 verify 留后续波次同文件续建。

    - 注册名 ``channel = site = "doc88"``（orchestrator/T40 注册表消费）；
    - plan：FileMeta（``source_url`` 或 ``extra["p_code"]``）→ ``discover_config`` →
      配置平铺落 ``extra["doc88_config"]``、p_code 落 ``extra["p_code"]``、
      实测页数回填 ``meta.pages``（原 None 时）；WAF 硬拒先落 ``wall_status`` 标记位再抛；
    - fetch_ladder（T32）：L1 主径=发现+收割+SWF→PDF 全链编排，产物事实落
      ``extra["doc88_chain"]``；异常族映射 ok=False 的 LadderResult（见方法 docstring）。
    """

    site = "doc88"
    channel = "doc88"

    def __init__(self, timeout: float = DEFAULT_TIMEOUT, fetch: Fetch | None = None, *,
                 store: Store | None = None, work_dir: str | Path | None = None,
                 fetch_bytes: BytesFetch | None = None, java_exe: str | None = None,
                 ffdec_jar: str | None = None, presse_exe: str | None = None,
                 zoom: float | None = None, group_size: int | None = None,
                 page_nos: Sequence[int] | None = None,
                 ffdec_timeout_s: int | None = None,
                 free_probe: bool = FREE_PROBE_DEFAULT,
                 config_cache: "ConfigCache | None" = None):
        """T24 原两参不变（后向兼容）；T32 接线新增件全关键字缺省：

        - ``store``/``work_dir``：断点台账与产物工作区（均未给=fetch_ladder 临时目录
          自建，artifact_path 可寻迹）；``fetch_bytes``：ebt 二进制腿（默认 curl_cffi
          同栈件，curl(61) 低级兜底不换 TLS 栈，T41P0）；``java_exe``/``ffdec_jar``/
          ``presse_exe``/``zoom``/``group_size``/``ffdec_timeout_s``：FFDec/presse
          子进程定位与编排参数（透传 swf_chain_to_pdf，缺省=SWF_ZOOM/FFDEC_GROUP_SIZE/
          FFDEC_TIMEOUT_S）；``page_nos``：子集收割（默认全页）；``free_probe``：T36
          免费直下门探针（True=XML 路缺 p_download 时补一发页面 JSON 路判定；
          **默认关=``FREE_PROBE_DEFAULT``（T41P0/P0-4：生产保持关闭，开前须合规验证
          download 端点鉴权门槛，挂账见 doc88_assessment 清偿注记）**）；
          ``config_cache``：p_code 级配置缓存（T41P0/P0-3：plan/fetch_ladder 段间
          共享 1 发 info/文档；缺省=适配器实例自建 ``ConfigCache()``）。
        """
        self.timeout = timeout
        self._fetch: Fetch = fetch or _curl_cffi_get
        self._fetch_bytes: BytesFetch = fetch_bytes or _curl_cffi_get_bytes
        self._store = store
        self._work_dir = work_dir
        self._java_exe, self._ffdec_jar, self._presse_exe = java_exe, ffdec_jar, presse_exe
        self._zoom = SWF_ZOOM if zoom is None else zoom
        self._group_size = FFDEC_GROUP_SIZE if group_size is None else group_size
        self._page_nos = page_nos
        self._ffdec_timeout_s = FFDEC_TIMEOUT_S if ffdec_timeout_s is None else ffdec_timeout_s
        self._free_probe = bool(free_probe)
        self._config_cache = config_cache if config_cache is not None else ConfigCache()
        self.last_meta: FileMeta | None = None        # T36：verify 段消费（fetch_ladder 落）
        self.last_verify_detail = ""                  # T36：verify 判定明细（audit 用）

    def _discover_cached(self, p_code: str) -> Doc88Config:
        """T41P0（P0-3）：plan/fetch_ladder 段间共享配置缓存——同 p_code 会话 TTL 内
        1 发 info（缓存命中零网络）；只缓存成功解出的配置（WAF/404/解析败不入缓存，
        fail-closed 下次如实重探）。"""
        cached = self._config_cache.get(p_code)
        if cached is not None:
            return cached
        config = discover_config(p_code, fetch=self._fetch, timeout=self.timeout)
        self._config_cache.put(p_code, config)
        return config

    def search(self, query: str, limit: int) -> list[FileMeta]:
        """段1 骨架：选品端点未定（DOC88_SPEC §5：首页 JS 动态无直链；分类页
        /list-*.html 可产 p_code 但非检索 API）——待后续任务定端点后落地。"""
        raise NotImplementedError("doc88 段1 search 选品端点未定（§5 首页 JS 动态无直链），待后续任务")

    def plan(self, meta: FileMeta) -> HarvestPlan:
        """段2（本任务）：配置发现腿——meta → p_code → 双路解密 → 配置入 extra。"""
        p_code = extract_p_code(str(meta.extra.get("p_code") or "")) \
            or extract_p_code(meta.source_url or "")
        if p_code is None:
            raise Doc88ConfigError(
                f"FileMeta 无法定位 doc88 p_code（source_url/extra.p_code 均无）：{meta.title!r}")
        meta.extra["p_code"] = p_code
        try:
            config = self._discover_cached(p_code)  # T41P0/P0-3：段间共享缓存
        except Doc88WAFBlocked:
            mark_wall_status(meta, WALL_BLOCKED_WAF)  # NFR1 统一落点（ledger 行由调用方写）
            raise
        meta.extra["doc88_config"] = config.to_mapping()
        if meta.pages is None:
            meta.pages = config.p_pagecount  # 实测回填（数字零造假）
        return HarvestPlan(meta=meta)

    def fetch_ladder(self, plan: HarvestPlan) -> LadderResult:
        """段3 L1 主径（T32 接线）：配置发现(T24)→ebt 收割(T27)→SWF 合成→FFDec
        frame:pdf 分组双导出→presse merge→PDF（§6 复刻落地顺序 3→4→5）。

        - 编排即 ``discover_config``+``harvest_ebt_assets``+``swf_chain_to_pdf`` 三真件；
        - 异常族映射→ok=False 的 LadderResult（不向编排层裸抛）：Doc88WAFBlocked→
          wall_status=blocked_waf（NFR1 标记位同步落 meta）；Doc88DocNotFound/
          Doc88AssetError/Doc88ConfigError/Doc88ChainError/ToolchainError/SwfError→
          detail 如实带类型与明细；
        - ``page_nos`` 子集收割（默认全页）→ coverage="实收页/配置页"（部分收割
          如实标注）；全页模式 T27 硬门仍内生于 harvest_ebt_assets（切片数==页表页数）；
        - work_dir 未给=临时目录；store 未给=work_dir 下自建（编排层传持久库即复用）。
        """
        meta = plan.meta
        p_code = extract_p_code(str(meta.extra.get("p_code") or "")) \
            or extract_p_code(meta.source_url or "")
        if p_code is None:
            return LadderResult(ok=False, detail=(
                f"FileMeta 无法定位 doc88 p_code（source_url/extra.p_code 均无）：{meta.title!r}"))
        meta.extra["p_code"] = p_code
        base = Path(self._work_dir) if self._work_dir else Path(
            tempfile.mkdtemp(prefix="doc88_l1_"))
        store = self._store if self._store is not None else Store(str(base / "store"))
        self.last_meta = meta                  # T36：verify 段经 meta.extra["doc88_chain"] 消费
        free_note = ""                         # T36：免费直下分支注记（成/折均如实入 detail）
        try:
            config = self._discover_cached(p_code)  # T41P0/P0-3：段间共享缓存
            meta.extra["doc88_config"] = config.to_mapping()
            if meta.pages is None:
                meta.pages = config.p_pagecount  # 实测回填（数字零造假）
            if config.p_download is None and self._free_probe:
                # T36 free_probe：XML 路常缺 p_download（T24 实测）→ 补一发页面 JSON 路
                # 判定（§1.3 两法字段等价，JSON 路携 p_download）；失败如实保持门关。
                probed, _reason, _waf = _leg_page(p_code, self._fetch, self.timeout)
                if probed is not None:
                    config = probed
                    meta.extra["doc88_config"] = config.to_mapping()
            if config.is_free_download:
                # FR4.AC3（§1.8）：p_download==1 免费件先走下载接口（挂账注记=登录态
                # 需求未验证；非文档体/解析败如实回退 ebt L1 主径，不降级不造假）。
                free = fetch_free_download(p_code, fetch_bytes=self._fetch_bytes,
                                           timeout=self.timeout)
                meta.extra["doc88_free_download"] = free.to_mapping()
                if free.is_document and free.fmt == "pdf":
                    base.mkdir(parents=True, exist_ok=True)  # 短路边自建工作区（链路件未触）
                    pdf_path = base / f"doc88_{p_code}_free.pdf"
                    pdf_path.write_bytes(free.data)
                    try:
                        pages, chars = _pdf_pages_and_chars(pdf_path)
                    except Exception as exc:  # 魔数过但不可解析：如实挂账回退主径
                        meta.extra["doc88_free_download"]["parse_error"] = \
                            f"{type(exc).__name__}: {exc}"
                        free_note = (f"；免费直下分支折（PDF 魔数过但 pypdfium2 不可解析：{exc}）")
                    else:
                        meta.extra["doc88_chain"] = {
                            "pdf_path": str(pdf_path), "pages": pages, "chars": chars,
                            "ref_chars": 0, "ref_chars_source": DOC88_REF_CHARS_SOURCE,
                            "manifest_path": None, "source": "free_download",
                            "groups": 0, "fixes": 0, "merged": False, "slices": 0,
                            "downloads": 1, "cache_hits": 0}
                        return LadderResult(
                            ok=True, ladder_used="L1", artifact_path=str(pdf_path),
                            pages=pages, chars=chars,
                            coverage=f"{pages}/{config.p_pagecount}",
                            detail=(f"L1 免费直下分支（p_download=1）{p_code}："
                                    f"doc.php?act=download → {len(free.data)}B PDF（魔数实测），"
                                    f"pypdfium2 实测 {pages} 页/{chars} 字；无 FFDec 同源参照→"
                                    f"ref_chars=0（字数门空真，verify 走 manifest_path=None "
                                    f"判空路）；登录态需求未验证（挂账，DOC88_SPEC §1.8）"))
                else:
                    free_note = (f"；免费直下分支折（{free.detail}；登录态需求未验证挂账，"
                                 f"DOC88_SPEC §1.8）→ ebt L1 兜底")
            harvest = harvest_ebt_assets(config, store=store, fetch=self._fetch_bytes,
                                         timeout=self.timeout, page_nos=self._page_nos)
            chain = swf_chain_to_pdf(harvest, base / p_code, java_exe=self._java_exe,
                                     ffdec_jar=self._ffdec_jar, presse_exe=self._presse_exe,
                                     zoom=self._zoom, group_size=self._group_size,
                                     timeout_s=self._ffdec_timeout_s)
        except Doc88WAFBlocked as exc:
            mark_wall_status(meta, WALL_BLOCKED_WAF)  # NFR1 统一落点（ledger 行由调用方写）
            return LadderResult(ok=False, wall_status=WALL_BLOCKED_WAF, detail=(
                f"配置发现 WAF 硬拒（R20 禁第三方镜像回退）：{exc}"))
        except Doc88MirrorBlocked as exc:  # T36：镜像域硬拒（ebthost 投毒等配置面假设）
            mark_wall_status(meta, WALL_BLOCKED_MIRROR_POLICY)
            return LadderResult(ok=False, wall_status=WALL_BLOCKED_MIRROR_POLICY, detail=(
                f"第三方镜像域硬拒（R20/FR4.AC2 禁自动回退，网络零触碰）：{exc}"))
        except Doc88DocNotFound as exc:
            return LadderResult(ok=False, detail=f"{type(exc).__name__}: {exc}")
        except (Doc88Error, SwfError, ToolchainError) as exc:
            return LadderResult(ok=False, detail=(
                f"L1 主径 {type(exc).__name__}: {exc}" + free_note))
        meta.extra["doc88_chain"] = {
            "pdf_path": str(chain.pdf_path), "pages": chain.pages, "chars": chain.chars,
            "ref_chars": chain.ref_chars, "ref_chars_source": chain.ref_chars_source,
            "manifest_path": None if chain.manifest_path is None else str(chain.manifest_path),
            "groups": len(chain.swf_groups), "fixes": len(chain.fixes),
            "merged": chain.merged, "slices": len(harvest.pages),
            "downloads": harvest.downloads, "cache_hits": harvest.cache_hits}
        detail = (f"L1 全链 {p_code}：切片 {len(harvest.pages)}/{config.p_pagecount} 页"
                  f"（缓存 {harvest.cache_hits}/下载 {harvest.downloads}），"
                  f"FFDec {len(chain.swf_groups)} 组×双导出，"
                  f"{'presse merge' if chain.merged else '单页直用 frames.pdf'}，"
                  f"实测 {chain.pages} 页/{chain.chars} 字，同源参照 {chain.ref_chars} 字"
                  f"（ref_chars_source={chain.ref_chars_source}），帧修正 {len(chain.fixes)} 处，"
                  f"manifest={'在位' if chain.manifest_path else '不落（ref_chars=0，schema 需 ≥1）'}"
                  + free_note)
        return LadderResult(ok=True, ladder_used="L1", artifact_path=str(chain.pdf_path),
                            pages=chain.pages, chars=chain.chars,
                            coverage=f"{len(harvest.pages)}/{config.p_pagecount}",
                            detail=detail)

    def verify(self, result: LadderResult) -> bool:
        """段4 实装（T36；T32 下游2/下游3）：quality_gate 四门核验产物。

        - 主路：``meta.extra["doc88_chain"]["manifest_path"]``（T32 全链落盘 manifest，
          ref_chars≥1）直连 quality_gate 四门 CLI（``quality_gate.main``，退出码 0=
          质检门全过的唯一定义；manifest 缺/坏 → 退出码 1 → False）；
        - ``manifest_path=None`` 判空路（T32 下游3）：纯图件（ref_chars=0 不落 manifest，
          schema 要求 ≥1）与免费直下件（无 FFDec 同源参照）→ 字数门空真（ref=0）+
          ①页/③水印/④完整性三门对产物实测——**内存 manifest 不落盘**（不伪造 schema
          要求的 ref_chars≥1，数字零造假）；页参照=doc88_config.p_pagecount，缺位退
          chain.pages 再退 result.pages（verify 独立调用的降级自洽路）；
        - 判定明细入 ``self.last_verify_detail``（audit/编排层消费；不回写 result）。
        """
        self.last_verify_detail = ""
        if not result.ok or not result.artifact_path:
            self.last_verify_detail = "无可核验产物（ok=False 或 artifact_path 缺）"
            return False
        meta = self.last_meta
        chain = meta.extra.get("doc88_chain") if meta is not None else None
        chain = dict(chain) if isinstance(chain, dict) else {}
        manifest_path = chain.get("manifest_path")
        if manifest_path:
            exit_code = _quality_gate.main([str(manifest_path)])
            self.last_verify_detail = (f"四门 CLI {manifest_path} → 退出码 {exit_code}"
                                       f"（0=质检门全过）")
            return exit_code == 0
        cfg_facts = meta.extra.get("doc88_config") if meta is not None else None
        expected = None
        if isinstance(cfg_facts, dict):
            expected = cfg_facts.get("p_pagecount") or chain.get("pages")
        expected = expected or result.pages
        if not expected or int(expected) < 1:
            self.last_verify_detail = ("无页数参照（doc88_config.p_pagecount/"
                                       "chain.pages/result.pages 均缺）")
            return False
        outcomes = _quality_gate.run_gate({
            "pdf_path": result.artifact_path, "expected_pages": int(expected),
            "ref_chars": 0, "ref_chars_source": DOC88_REF_CHARS_SOURCE})
        self.last_verify_detail = ("manifest_path=None 判空路（字数门空真 ref=0）："
                                   + "；".join(f"{o.label}{'过' if o.passed else '不过'}"
                                              for o in outcomes))
        return all(o.passed for o in outcomes)


# ---------------- T27：ebt 资产下载 + 整文件字节缓存 + PH/PK 分层切片 ----------------
# DOC88_SPEC §1.4（逐页资产 URL 模式）/§2（EBT 格式真相：SWF 切两段各 zlib 压缩+填充头）/
# §3 R14（ebt CDN 忽略 Range 头→只整下不续传）。复用真符号：variant_b64.encode（key2
# 资产名）/ store.ledger.Store（整文件字节缓存）/ assets.magic_check（sniff_format/
# try_decompress_zlib/find_zlib_streams）。SWF 合成（终止符+长度补丁+帧 RECT 修正）→
# FFDec → presse 归 T32；本段止于「每页字节块 + 解压拼接产物（swf_head+swf_body）」。

#: 二进制网络腿注入点签名：(url, timeout) -> (http_status, body_bytes)——确定性测试注入用
BytesFetch = Callable[[str, float], tuple[int, bytes]]

PH_KIND = "ph"      # 层头资产（魔数 YBD 前缀族，[40:] 起 zlib 流）
PK_KIND = "pk"      # 页体资产（无固定魔数、前 32B 随机填充，[32:] 起 zlib 流）
PH_HEAD_LEN = 40    # §2 PH 自有头字节数
PK_HEAD_LEN = 32    # §2 PK 自有头字节数
#: PH 魔数前缀族：2011 件 ``YBD\\x01``（T05 EBT_PH_MAGIC 实锤）、2026 件 ``YBD\\x02``
#: （93243737771803 实弹实测）——第 4 字节=格式版本，判件认 ``YBD`` 前缀不钉死版本。
EBT_PH_PREFIX = b"YBD"


class Doc88AssetError(Doc88Error):
    """ebt 资产下载/判件失败（wall_status=None：非墙类；HTTP 状态/长度差/魔数/zlib 明细如实入 message）。"""


@dataclass(frozen=True)
class EbtAsset:
    """单个 .ebt 资产（PH/PK）的下载/缓存事实（字节与计数全实测，数字零造假）。"""

    kind: str                  # PH_KIND / PK_KIND
    level: int                 # 所属层
    name: str                  # key2 加密文件名（Store 缓存键，URL basename）
    url: str                   # 完整资产 URL
    expected_bytes: int        # 配置口径字节数（header_size / 页表 length）
    data: bytes                # 整文件原始字节
    page_no: int | None = None # PK 页码（PH=None）
    cache_hit: bool = False    # True=本地字节缓存命中（零网络）


@dataclass(frozen=True)
class PageSlice:
    """单页切片产物：PH[40:]/PK[32:] 两段 zlib 解压后拼接所需的全部事实。

    ``swf_head+swf_body`` 即 §1.6 前半（zlib×2 解压拼接）；T32 再补 ``\\x40\\x00\\x00\\x00``
    终止符与 swf[4:8] 长度补丁、帧 RECT/帧数修正后成完整每页 SWF。
    """

    page_no: int              # 页码（=页表位序，1 起）
    level: int                # 所属层
    loc: PageLoc              # 页表定位（含层内偏移/长度/宽高——T32 帧修正用）
    swf_head: bytes           # zlib 解压 PH[40:]（SWF 文件头+起始 tags）
    swf_body: bytes           # zlib 解压 PK[32:]（该页剩余 tags）
    head_stream_offset: int   # zlib 流在 PH 件内实际起点（严格路径==40；回扫命中如实记）
    body_stream_offset: int   # 同上（严格路径==32）

    @property
    def swf_raw(self) -> bytes:
        """zlib×2 解压拼接产物（§1.6 前半）：head+body。"""
        return self.swf_head + self.swf_body

    @property
    def head_signature(self) -> str | None:
        """解压头魔数真身（sniff_format：FWS/CWS/ZWS→"swf"；未知 None 不猜，R16）。"""
        return sniff_format(self.swf_head)


@dataclass(frozen=True)
class EbtHarvest:
    """单文档 ebt 收割结果：资产序（先 PH 层号升序、后 PK 页序）+ 逐页切片产物。"""

    config: Doc88Config
    assets: tuple[EbtAsset, ...]
    pages: tuple[PageSlice, ...]
    cache_hits: int
    downloads: int

    @property
    def asset_files(self) -> int:
        """本次涉及资产文件数（命中+下载；探针预算口径）。"""
        return len(self.assets)


def ph_asset_name(level: int, header_size: int, p_swf: str) -> str:
    """层头 PH 文件名（§1.4）：key2 编码「层号-0-层头大小-{p_swf}」（offset=0 即层流起点）。"""
    return vb_encode(DOC88_KEY2_NAME, f"{int(level)}-0-{int(header_size)}-{p_swf}")


def pk_asset_name(loc: PageLoc, p_swf: str, page_no: int, p_code: str) -> str:
    """页体 PK 文件名（§1.4）：key2 编码「层号-偏移-长度-{p_swf}-{页码}-{p_code}」。

    偏移=层内偏移（T24 实证：L2 首页 offset==L2 层头 453032；层内逐页连续）。
    """
    return vb_encode(DOC88_KEY2_NAME,
                     f"{loc.level}-{loc.offset}-{loc.length}-{p_swf}-{int(page_no)}-{p_code}")


def ebt_asset_url(ebthost: str, name: str) -> str:
    """ebt 资产 URL（§1.4）：{p_ebthost}/getebt-{key2 名}.ebt——=/!/+ 原样保留（实测可直下）。"""
    return f"{str(ebthost).rstrip('/')}/getebt-{name}.ebt"


def _curl_cffi_get_bytes(url: str, timeout: float) -> tuple[int, bytes]:
    """ebt 二进制网络腿（整文件）：curl_cffi impersonate="chrome" + Referer + 浏览器 UA。

    §1.4 实测裸 UA 亦 200、无需 Referer——任务卡口径防御性全带（成本为零）；
    **绝不带 Range 头**（R14：CDN 忽略 Range，断点续传不可依赖服务端）。

    2026-10-22 实弹实锤（本任务探针）：ebt CDN 无条件回 ``Content-Encoding: compress``
    （古董 LZW 名）而 body 实为原始字节（Content-Length==真实文件大小）——libcurl
    不识该编码直接 curl(61) Unrecognized content encoding 拒收。

    T41P0（P0-1/P0-5 清偿，2026-10-23）：原「降级 plain requests（urllib3）」腿
    **已删除**——同文档收割内 JA3 在 Chrome↔Python-urllib3 间切换（伴随 h2→1.1）
    是研判判定最直接的封号触发点。现口径=①显式 ``Accept-Encoding: identity`` 让
    CDN 别回 compress；②仍撞 curl(61)（CDN 谎报无视声明）时走 ``_curl_cffi_raw_get``
    **同栈低级兜底**（curl_cffi.Curl + impersonate 保留、关自动解码原样收字节），
    TLS/HTTP2 指纹全程单态；③判件维持 R16 只认字节不认 Content-Encoding header
    （真压缩体过不了魔数/长度/zlib 三重门，fail-closed 不落缓存）。
    """
    reject_mirror_url(url)  # T36/R20：镜像域 URL 请求前硬拒（网络层零触碰）
    _pace_network_request(url)  # T41P0/P0-2：默认腿显式频控（注入腿零接线）
    headers = {"Referer": DOC88_REFERER, "User-Agent": DOC88_UA,
               "Accept-Encoding": ACCEPT_ENCODING_IDENTITY}
    try:
        from curl_cffi import requests as curl_requests  # 延迟导入：纯解析路径零依赖
        r = curl_requests.get(url, impersonate=IMPERSONATE, timeout=timeout,
                              headers=headers)
        return r.status_code, r.content
    except Exception as exc:  # curl(61) 内容编码谎报 → 同栈低级 Curl 兜底（P0-1）
        if not _is_content_encoding_error(exc):
            raise
        return _curl_cffi_raw_get(url, timeout)


def _zlib_stream_at(data: bytes, start: int) -> bytes | None:
    """级别无关的严格解压：合法 zlib 头（CMF 低半字节=8 deflate + CMF/FLG 整除校验
    31）+ 完整流（eof，Adler-32 天然校验）——789c/78da/7801 等 zlib 头族通吃。

    T05 真符号（try_decompress_zlib/find_zlib_streams）按 DOC88_SPEC §2 钉死只认
    0x789c（2011 件默认压缩级；防隐藏页扫描误切）；2026 件（YBD\\x02）实测为 0x78da
    最高压缩级属规格外头——本件切片位已知（40/32）无误切面，故宽头判定自持于此。
    """
    if start < 0 or start + 2 > len(data):
        return None
    b0, b1 = data[start], data[start + 1]
    if b0 & 0x0F != 8 or ((b0 << 8) | b1) % 31 != 0:
        return None
    dec = zlib.decompressobj()
    try:
        out = dec.decompress(data[start:])
    except zlib.error:
        return None
    return out if dec.eof else None


def _zlib_header_positions(data: bytes) -> list[int]:
    """全件扫合法 zlib 头候选位（级别无关，供回扫兜底；Adler 由 _zlib_stream_at 把关）。"""
    return [i for i in range(len(data) - 1)
            if data[i] & 0x0F == 8 and ((data[i] << 8) | data[i + 1]) % 31 == 0]


def decompress_ebt_slice(data: bytes, head_len: int, *, what: str, name: str) -> tuple[bytes, int]:
    """PH[40:]/PK[32:] 切片解压（§2）：严格偏移优先，未成流回退全件扫首个成流。

    - 严格路①：``try_decompress_zlib(data[head_len:])``（T05 真符号；0x789c 规格钉死
      头 + Adler-32 天然校验；尾随多余字节容忍）——2011 件实测级；
    - 严格路②：``_zlib_stream_at(data, head_len)``（zlib 头族级别无关，2026 件 78da）；
    - 回扫路③：``find_zlib_streams(data)``（T05 真符号，789c 限定）全件扫 + ④ 头族
      通用扫描（填充头超长/偏移漂移兜底）；流实际起点如实返回（不静默吞偏移差）；
    - 全路皆败 → ``Doc88AssetError``（R16 字节判件：解不开即坏资产，不降级不造假）。
    """
    out = try_decompress_zlib(data[head_len:])
    if out is not None:
        return out, head_len
    out = _zlib_stream_at(data, head_len)
    if out is not None:
        return out, head_len
    spans = find_zlib_streams(data)
    if spans:
        return spans[0].decompressed, spans[0].start
    for start in _zlib_header_positions(data):
        out = _zlib_stream_at(data, start)
        if out is not None:
            return out, start
    raise Doc88AssetError(
        f"{what} 切片无完整 zlib 流：head_len={head_len} 严格切片不成流、全件回扫亦无成流"
        f"（资产 {name[:32]}…，R16 字节判件）")


def fetch_ebt_asset(*, name: str, url: str, kind: str, level: int, expected_bytes: int,
                    p_code: str, store: Store, fetch: BytesFetch,
                    timeout: float = DEFAULT_TIMEOUT,
                    page_no: int | None = None) -> EbtAsset:
    """单资产整文件获取（R14 只整下不续传）+ Store 字节缓存复用。

    - 命中：``store.get_asset`` 非 None → 零网络原字节复用（首写时已判件）；
    - miss：``fetch`` 整文件下载（请求永不带 Range）→ 判件（HTTP 200 + 实测字节数==
      配置口径 + PH 魔数 YBD\\x01 / PK zlib 成流，R16 只认字节不认 Content-Type）→
      ``store.put_asset(name, data, doc=p_code)`` 落整文件缓存并自动记 progress 分块；
    - 判件不过**不落缓存**（坏字节不进库），明细如实入异常 message。
    """
    reject_mirror_url(url)  # T36/R20：镜像域 URL 请求前硬拒（缓存查询前，网络零触碰）
    cached = store.get_asset(name)
    if cached is not None:
        return EbtAsset(kind=kind, level=level, name=name, url=url,
                        expected_bytes=expected_bytes, data=cached,
                        page_no=page_no, cache_hit=True)
    status, data = fetch(url, timeout)
    if status != 200:
        raise Doc88AssetError(
            f"{kind.upper()} 资产 HTTP {status}（层 {level}"
            + (f" 第 {page_no} 页" if page_no is not None else "")
            + f"，URL {url}）")
    if len(data) != expected_bytes:
        raise Doc88AssetError(
            f"{kind.upper()} 资产实测 {len(data)}B ≠ 配置口径 {expected_bytes}B"
            f"（层 {level}，资产 {name[:32]}…——零造假如实报差）")
    if kind == PH_KIND and not data.startswith(EBT_PH_PREFIX):
        raise Doc88AssetError(
            f"PH 资产魔数非 {EBT_PH_PREFIX!r} 前缀族：实测 {data[:4]!r}"
            f"（层 {level}，R16 只认字节；YBD 后第 4 字节=格式版本）")
    if kind == PK_KIND:
        decompress_ebt_slice(data, PK_HEAD_LEN,
                             what=f"PK 层 {level} 第 {page_no} 页", name=name)
    store.put_asset(name, data, doc=p_code)
    return EbtAsset(kind=kind, level=level, name=name, url=url,
                    expected_bytes=expected_bytes, data=data,
                    page_no=page_no, cache_hit=False)


def harvest_ebt_assets(config: Doc88Config, *, store: Store,
                       fetch: BytesFetch | None = None,
                       timeout: float = DEFAULT_TIMEOUT,
                       page_nos: Sequence[int] | None = None,
                       ph_levels: Sequence[int] | None = None) -> EbtHarvest:
    """T27 主入口（FR4.AC1）：逐层 PH + 逐页 PK 整文件下载 → 缓存复用 → 分层切片。

    - ``page_nos=None`` 全页（逐层 PH=页表全部层）；给子集只下所选页+所涉层 PH
      （探针预算纪律：实弹可 1 页 1 层试跑）；``ph_levels`` 附加层头采集（与所选页
      所在层取并集，子集模式仍可单采层头）；
    - 页码=页表位序（1 起，与 p_struct n / pageInfo 串序一致）；越界/重复页号、
      越界层号如实拒（Doc88AssetError）；
    - 切片：每层 PH 解压一次（层内共享），逐页 PK 解压拼接（PageSlice 族字段）；
    - 全页模式硬断言**切片数==页表页数**（结构性护栏，回归即炸；数字零造假）。
    """
    fetch = fetch or _curl_cffi_get_bytes
    total = len(config.pages)
    if page_nos is None:
        selected: tuple[int, ...] = tuple(range(1, total + 1))
    else:
        nos = tuple(int(n) for n in page_nos)
        if not nos and not ph_levels:
            raise Doc88AssetError("空收割清单：page_nos 与 ph_levels 均空")
        seen: set[int] = set()
        for n in nos:
            if not 1 <= n <= total:
                raise Doc88AssetError(f"页号越界：{n}（页表共 {total} 页）")
            if n in seen:
                raise Doc88AssetError(f"重复页号：{n}")
            seen.add(n)
        selected = tuple(sorted(seen))
    levels = {config.pages[n - 1].level for n in selected}
    for lv in (ph_levels or ()):
        lv_n = int(lv)
        if not 1 <= lv_n <= len(config.header_sizes):
            raise Doc88AssetError(
                f"层号越界：{lv_n}（层头表共 {len(config.header_sizes)} 层）")
        levels.add(lv_n)

    assets: list[EbtAsset] = []
    ph_assets: dict[int, EbtAsset] = {}
    for lv in sorted(levels):
        size = config.header_sizes[lv - 1]
        name = ph_asset_name(lv, size, config.p_swf)
        asset = fetch_ebt_asset(name=name, url=ebt_asset_url(config.p_ebthost, name),
                                kind=PH_KIND, level=lv, expected_bytes=size,
                                p_code=config.p_code, store=store,
                                fetch=fetch, timeout=timeout)
        assets.append(asset)
        ph_assets[lv] = asset

    slices: list[PageSlice] = []
    for n in selected:
        loc = config.pages[n - 1]
        name = pk_asset_name(loc, config.p_swf, n, config.p_code)
        pk = fetch_ebt_asset(name=name, url=ebt_asset_url(config.p_ebthost, name),
                             kind=PK_KIND, level=loc.level, page_no=n,
                             expected_bytes=loc.length, p_code=config.p_code,
                             store=store, fetch=fetch, timeout=timeout)
        assets.append(pk)
        ph = ph_assets[loc.level]
        head, head_off = decompress_ebt_slice(
            ph.data, PH_HEAD_LEN, what=f"PH L{loc.level}", name=ph.name)
        body, body_off = decompress_ebt_slice(
            pk.data, PK_HEAD_LEN, what=f"PK 第 {n} 页", name=pk.name)
        slices.append(PageSlice(page_no=n, level=loc.level, loc=loc,
                                swf_head=head, swf_body=body,
                                head_stream_offset=head_off,
                                body_stream_offset=body_off))

    if page_nos is None and len(slices) != len(config.pages):  # 结构性护栏（回归即炸）
        raise Doc88AssetError(
            f"切片数 {len(slices)} ≠ 页表页数 {len(config.pages)}（全页模式硬断言）")
    return EbtHarvest(config=config, assets=tuple(assets), pages=tuple(slices),
                      cache_hits=sum(1 for a in assets if a.cache_hit),
                      downloads=sum(1 for a in assets if not a.cache_hit))


# ---------------- T32：SWF 合成 + FFDec/presse 全链 + 段3 fetch_ladder 接线 ----------------
# DOC88_SPEC §1.6（合成三行公式+swf_resize 帧修正）/§1.7（FFDec frame:pdf 子进程+
# presse merge）/§6（复刻落地顺序 4 合成器→5 转换器）。真符号接线：pdf.swf_toolchain
# （swf_resize_if_needed 帧 RECT 修正/帧数 0 检测、run_ffdec_frame_pdf 每组一 JVM、
# presse_merge）/ quality_gate.count_chars（门②字数同口径）。
#
# 参照口径实锤（2026-10-22 本任务实测，FFDec 26.4.0 ``-help export`` 全格式清单）：
# FFDec 无 ``frame:text`` 格式（frame 族仅 png/apng/gif/avi/svg/canvas/pdf/bmp/webp）；
# doc88 页文字全部住在 DefineSprite 内（93243737771803 页 1 sprite 内 5×DefineText2、
# 顶层 0 个）→ CLI ``-export text``（text:plain/text:formatted 双格式）实弹零文件，
# 而顶层 DefineEditText 合成对照件可导出=导出器本身无恙、不递归 sprite 是根因——
# 故「FFDec frame:text 同源参照」落为**同 SWF 集 FFDec frame:pdf 双导出**：参照腿
# 独立导出的逐页 frames.pdf 经 pypdfium2 抽字数（count_chars 同口径），与产线腿
# （第一腿导出→presse merge→pypdfium2）构成两口径同源比对（实弹 4 页 376==376 字，
# 比例 1.000；71 页全量见 test_doc88_swf 实弹用例）。

SWF_TERMINATOR = b"\x40\x00\x00\x00"   # §1.6 合成终止符（ShowFrame+End 尾，探针实测）
SWF_ZOOM = 1.0                          # §1.7 -zoom {pdf_scale}（1px=1pt 实测，T12 同锚）
FFDEC_GROUP_SIZE = 24                   # 分组编排：每组一 JVM（实测 JVM 启动 ~2.5s、页均 ~3.2s）
FFDEC_TIMEOUT_S = 900                   # 单组 JVM 超时（与 run_ffdec_frame_pdf 缺省同值）
DOC88_REF_CHARS_SOURCE = "doc88"        # quality_gate.REF_CHARS_SOURCES 词表名（门②参照源）


class Doc88ChainError(Doc88Error):
    """SWF→PDF 全链编排失败（FFDec 缺页/零页合并/页数结构不符；wall_status=None）。"""


def synthesize_page_swf(page: PageSlice) -> tuple[bytes, tuple[str, ...]]:
    """§1.6 三行公式接线（T27 报告第1条口径）：swf_raw+终止符 → 长度补丁 → 帧修正。

    - ``swf[4:8]=uint32_LE(len)`` 先行（干净件也要补——PH 头声明长度随切片重组可能失真）；
    - ``swf_resize_if_needed(data, loc.width, loc.height)``：帧数 0→1（FFDec 静默零输出
      坑，§1.6）+帧 RECT→页表 w-h（twip=px*20）；有因才改写，已修原因清单如实返回；
    - 非 FWS/截断件 → ``Doc88AssetError``（SwfError 包装修正件口径，R16 只认字节）。
    """
    raw = bytearray(page.swf_raw + SWF_TERMINATOR)
    raw[4:8] = len(raw).to_bytes(4, "little")  # 长度补丁：声明==实际（check_swf 复核位）
    try:
        fixed, reasons = swf_resize_if_needed(bytes(raw), page.loc.width, page.loc.height)
    except SwfError as exc:
        raise Doc88AssetError(
            f"第 {page.page_no} 页 SWF 合成件不可解析（zlib×2 拼接产物非合法 FWS）：{exc}"
        ) from exc
    return fixed, tuple(reasons)


def plan_swf_groups(page_nos: Sequence[int], group_size: int) -> tuple[tuple[int, ...], ...]:
    """页序分组（§1.7 分组编排的确定性版）：每组一 JVM，顺序切片不漏页不重页。"""
    size = int(group_size)
    if size < 1:
        raise ValueError(f"非法组宽 {group_size}（须 ≥1）")
    nos = list(page_nos)
    return tuple(tuple(nos[i:i + size]) for i in range(0, len(nos), size))


def merge_frames_pdfs(pdf_map: Mapping[int, "str | Path"], out_pdf: "str | Path", *,
                      presse_exe: str | None = None,
                      timeout_s: int = 600) -> Path:
    """§1.7 收口合并：≥2 输入 presse merge（页序=页码升序，--optimize）；单页直用
    frames.pdf（任务卡口径：不为 1→1 产无谓 merge）；零页如实拒（不产 0 页 PDF）。"""
    if not pdf_map:
        raise Doc88ChainError("零页产物：无 frames.pdf 可合并")
    ordered = [Path(pdf_map[n]) for n in sorted(pdf_map)]
    if len(ordered) == 1:
        return ordered[0]
    return presse_merge(ordered, out_pdf, presse_exe=presse_exe, timeout_s=timeout_s)


@dataclass(frozen=True)
class Doc88PdfChain:
    """单文档 SWF→PDF 全链事实（页数/字数全 pypdfium2 实测，数字零造假）。"""

    pdf_path: Path                      # 最终 PDF（merge 产物或单页直用 frames.pdf）
    pages: int                          # 实测页数（结构门内校==切片数）
    chars: int                          # 产线腿实测字数（非空白字符，count_chars 同口径）
    ref_chars: int                      # 同源参照腿实测字数（同 SWF 集 FFDec 双导出第二腿）
    ref_chars_source: str               # 恒 "doc88"（quality_gate 门②参照源词表名）
    manifest_path: Path | None          # 质检门 manifest（ref_chars=0 不落：schema 需 ≥1）
    swf_groups: tuple[tuple[int, ...], ...]  # 分组编排事实（每组一 JVM）
    fixes: tuple[tuple[int, str], ...]  # (页码, 修正原因)——帧数 0/RECT 修正逐页入账
    merged: bool                        # True=presse merge；False=单页直用 frames.pdf
    pdf_dir: Path | None = None         # 产线腿 frames.pdf 导出根（留档）
    ref_dir: Path | None = None         # 参照腿 frames.pdf 导出根（留档）


def _collect_frame_pdfs(run, group: Sequence[int], *, what: str) -> dict[int, Path]:
    """单组导出产物收敛：produced 键（swf stem=页码 04d）→页码映射；缺页如实炸。"""
    out: dict[int, Path] = {}
    missing = []
    for n in group:
        pdf = run.produced.get(f"{n:04d}")
        if pdf is None or not Path(pdf).is_file():
            missing.append(n)
        else:
            out[n] = Path(pdf)
    if missing:
        tail = (run.stderr_tail or "")[-300:]
        raise Doc88ChainError(
            f"FFDec {what} 导出缺页 {missing}（本组 {list(group)}，returncode="
            f"{run.returncode}；帧数 0 件 returncode=0 且零产物=§1.6 静默坑；"
            f"stderr 尾：{tail!r}）")
    return out


def _pdf_pages_and_chars(pdf_path: Path) -> tuple[int, int]:
    """产物实测（NFR2 零 fitz）：pypdfium2 页数 + quality_gate.count_chars 字数（同口径）。"""
    import pypdfium2 as pdfium  # 延迟导入：纯解析/网络路径零 PDF 依赖
    doc = pdfium.PdfDocument(str(pdf_path))
    try:
        return len(doc), count_chars(doc)
    finally:
        doc.close()


def swf_chain_to_pdf(harvest: EbtHarvest, out_dir: "str | Path", *,
                     java_exe: str | None = None, ffdec_jar: str | None = None,
                     presse_exe: str | None = None, zoom: float = SWF_ZOOM,
                     group_size: int = FFDEC_GROUP_SIZE,
                     timeout_s: int = FFDEC_TIMEOUT_S) -> Doc88PdfChain:
    """T32 主入口（FR4.AC1）：EbtHarvest 切片 → 每页 SWF（合成+帧修正）→ FFDec
    frame:pdf 分组双导出（产线腿+参照腿，每组一 JVM）→ presse merge/单页直用 →
    实测页数/字数 + quality_gate manifest 落盘。

    - 分组：``plan_swf_groups``（默认 24 页/组）；SWF 文件名 ``{页码:04d}.swf``
      （FFDec produced 键=stem，T12 实测口径）；产线腿/参照腿各导一遍=「同 SWF 集
      FFDec 双导出」（参照口径实锤见本段头注释）；
    - 结构门（数字零造假）：任一腿缺页、合并后实测页数≠切片数 → Doc88ChainError；
    - manifest：``{pdf_path, expected_pages=p_pagecount, ref_chars, ref_chars_source=
      "doc88"}``（quality_gate.load_manifest 兼容；ref_chars=0 不落文件——schema 要求
      参照 ≥1，零文字文档字数门空真，如实不造假）。
    """
    if not harvest.pages:
        raise Doc88ChainError("空切片集：harvest.pages 为空，无页可合成")
    out = Path(out_dir)
    swf_root = out / "swf"
    swf_root.mkdir(parents=True, exist_ok=True)
    page_swfs: dict[int, bytes] = {}
    fixes: list[tuple[int, str]] = []
    for s in harvest.pages:
        data, reasons = synthesize_page_swf(s)
        page_swfs[s.page_no] = data
        fixes.extend((s.page_no, r) for r in reasons)
    groups = plan_swf_groups(sorted(page_swfs), group_size)
    pdf_map: dict[int, Path] = {}
    ref_map: dict[int, Path] = {}
    for gi, group in enumerate(groups, start=1):
        gdir = swf_root / f"g{gi:02d}"
        gdir.mkdir(parents=True, exist_ok=True)
        for n in group:
            (gdir / f"{n:04d}.swf").write_bytes(page_swfs[n])
        kwargs = dict(java_exe=java_exe, ffdec_jar=ffdec_jar, zoom=zoom, timeout_s=timeout_s)
        run = run_ffdec_frame_pdf(gdir, out / "pdf" / f"g{gi:02d}", **kwargs)
        pdf_map.update(_collect_frame_pdfs(run, group, what="产线腿 frame:pdf"))
        ref_run = run_ffdec_frame_pdf(gdir, out / "ref" / f"g{gi:02d}", **kwargs)
        ref_map.update(_collect_frame_pdfs(ref_run, group, what="参照腿 frame:pdf"))
    final = merge_frames_pdfs(
        pdf_map, out / f"doc88_{harvest.config.p_code}.pdf", presse_exe=presse_exe)
    pages, chars = _pdf_pages_and_chars(final)
    if pages != len(harvest.pages):
        raise Doc88ChainError(
            f"合并产物实测 {pages} 页 ≠ 切片数 {len(harvest.pages)}（结构门，数字零造假）")
    ref_chars = 0
    for n in sorted(ref_map):
        _, c = _pdf_pages_and_chars(ref_map[n])
        ref_chars += c
    manifest_path: Path | None = None
    if ref_chars >= 1:
        manifest_path = out / "manifest.json"
        manifest_path.write_text(json.dumps({
            "pdf_path": final.name,
            "expected_pages": harvest.config.p_pagecount,
            "ref_chars": ref_chars,
            "ref_chars_source": DOC88_REF_CHARS_SOURCE,
        }, ensure_ascii=False, indent=1), encoding="utf-8")
    return Doc88PdfChain(
        pdf_path=final, pages=pages, chars=chars, ref_chars=ref_chars,
        ref_chars_source=DOC88_REF_CHARS_SOURCE, manifest_path=manifest_path,
        swf_groups=tuple(groups), fixes=tuple(fixes), merged=len(pdf_map) > 1,
        pdf_dir=out / "pdf", ref_dir=out / "ref")


# ---------------- T36：镜像域黑名单硬拒（FR4.AC2/R20）+ 免费直下分支（FR4.AC3） ----------------
# DOC88_SPEC §3（WAF=JA3/行为指纹检测，特征字「网络环境安全验证」；作者第三方镜像域
# doc88.piglin.eu.org 不可作自动回退——信任面外扩，R20 引擎层禁止）+ §1.8（免费文档
# 直下：p_download=="1" 时 GET doc.php?act=download&pcode=，原工具已注释保留——登录态
# 需求未验证）。真符号接线：quality_gate.main/run_gate（四门 CLI+判件）、sniff 魔数
# 自持表（T05 sniff_format 词表无 pdf/office 族，本件按 R16 只认字节自表）。

from kb_factory.harvest_engine import quality_gate as _quality_gate
from kb_factory.harvest_engine.adapters.base import WALL_BLOCKED_MIRROR_POLICY

#: R20 第三方镜像域黑名单（doc88_extractor 作者自建镜像域；判据=宿主==域或任意子域，
#: 前缀撞名不误伤；新镜像域随时可增，DISCARD 面非封闭面）。
MIRROR_DOMAIN_BLACKLIST = frozenset({"piglin.eu.org"})


class Doc88MirrorBlocked(Doc88Error):
    """第三方镜像域硬拒（R20/FR4.AC2）：wall_status=blocked_mirror_policy（NFR1 词表）。"""

    wall_status = WALL_BLOCKED_MIRROR_POLICY


def is_mirror_url(url: str) -> bool:
    """URL 宿主 ∈ 镜像黑名单域或其任意子域（纯解析零网络；host 小写归一，空/畸形不误伤）。"""
    host = (urllib.parse.urlsplit(str(url or "")).hostname or "").lower()
    return any(host == d or host.endswith("." + d) for d in MIRROR_DOMAIN_BLACKLIST)


def reject_mirror_url(url: str) -> None:
    """镜像域 URL **请求前**硬拒（FR4.AC2/R20）：即便上游「配置了」镜像域（ebthost 投毒/
    URL 直喂/未来引入的镜像配置面），也在任何网络触碰与缓存查询之前抛 ``Doc88MirrorBlocked``
    ——blocked_mirror_policy 标记位由调用方落 FileMeta.extra.wall_status（NFR1）。"""
    if is_mirror_url(url):
        raise Doc88MirrorBlocked(
            "第三方镜像域硬拒（R20/FR4.AC2，禁自动回退作者镜像）："
            + str(url)[:120] + "——信任面外扩域零触碰，blocked_mirror_policy")


def download_url(p_code: str) -> str:
    """FR4.AC3 免费直下端点（§1.8）：doc.php?act=download&pcode=（pcode 无下划线）。"""
    return f"{DOC88_BASE}/doc.php?act=download&pcode={p_code}"


#: 直下产物文档魔数表（R16 只认字节；T05 sniff_format 词表为 gif/png/swf/ebt_ph/zlib
#: 资产族，无文档族，故本件自持表）。ooxml=zip 容器（docx/pptx/xlsx 同头不可分型）、
#: ole=OLE2 复合文档（doc/ppt/xls 老格式）。
DOCUMENT_MAGICS: tuple[tuple[str, bytes], ...] = (
    ("pdf", b"%PDF-"),
    ("ooxml", b"PK\x03\x04"),
    ("ole", b"\xd0\xcf\x11\xe0\xa1\xb1\x1a\xe1"),
)


def sniff_document_magic(data: bytes) -> str | None:
    """按魔数判直下响应是否文档体（R16：不看 Content-Type/文件名；未知 None 不猜——
    登录墙 HTML 等「能答 200 的非文档体」如实 None，即免费直下分支的挂账回退判据）。"""
    for name, magic in DOCUMENT_MAGICS:
        if bytes(data).startswith(magic):
            return name
    return None


@dataclass(frozen=True)
class FreeDownloadAttempt:
    """§1.8 免费直下单发尝试事实（FR4.AC3；状态/字节/魔数全实测，数字零造假）。

    **挂账注记（T36）**：该接口登录态需求未验证——2026-10-22 抽样总体（分类页
    /list-1022.html 前 3 件+2011 件）p_download 全="2" 无免费件可实证；付费件端点实测
    HTTP 404 空体。若真免费件需登录 cookie，响应为登录墙 HTML → fmt=None/
    is_document=False → fetch_ladder 如实回退 ebt L1 主径（不降级不造假）。
    """

    p_code: str
    url: str
    http_status: int     # 0=网络异常（无 HTTP 层结果）
    data: bytes
    fmt: str | None      # sniff_document_magic（pdf/ooxml/ole；None=非文档体）
    is_document: bool    # HTTP 200 且魔数认文档体
    detail: str

    def to_mapping(self) -> dict:
        """平铺事实映射（fetch_ladder 落 meta.extra["doc88_free_download"]）。"""
        return {"p_code": self.p_code, "url": self.url,
                "http_status": self.http_status, "bytes": len(self.data),
                "fmt": self.fmt, "is_document": self.is_document, "detail": self.detail}


def fetch_free_download(p_code_or_url: str, *, fetch_bytes: BytesFetch | None = None,
                        timeout: float = DEFAULT_TIMEOUT) -> FreeDownloadAttempt:
    """FR4.AC3（§1.8）：免费直下端点单发尝试（零状态、可独立实弹）。

    - ``p_code_or_url``：裸 p_code 或任意可解出 p_code 的 doc88 URL（extract_p_code 口径）；
    - 响应判件 R16 只认字节：HTTP 200 且魔数∈文档族 → is_document=True；404/登录墙
      HTML/截断件 → False（挂账回退判据）；网络异常如实 http_status=0 不上抛（分支
      语义=尝试，败则回退 ebt 主径）；
    - 镜像域 URL（DOC88_BASE 被改配等假设面）请求前硬拒（R20，经默认二进制腿护栏）；
    - 挂账注记见 FreeDownloadAttempt docstring（登录态需求未验证）。
    """
    p_code = extract_p_code(str(p_code_or_url))
    if p_code is None:
        raise Doc88ConfigError(f"无法解出 doc88 p_code：{p_code_or_url!r}")
    url = download_url(p_code)
    reject_mirror_url(url)  # R20：镜像域假设面护栏（默认腿亦有同护栏，双保险）
    try:
        status, data = (fetch_bytes or _curl_cffi_get_bytes)(url, timeout)
    except Exception as exc:  # 网络异常如实记零状态（分支回退语义）
        return FreeDownloadAttempt(p_code=p_code, url=url, http_status=0, data=b"",
                                   fmt=None, is_document=False,
                                   detail=f"网络异常 {type(exc).__name__}: {exc}")
    fmt = sniff_document_magic(data) if status == 200 else None
    is_document = status == 200 and fmt is not None
    why = ("文档体（魔数=%s）" % fmt) if is_document else (
        f"HTTP {status} {len(data)}B" if status != 200 else
        f"HTTP 200 {len(data)}B 非文档体（魔数 None——登录墙/运营页形态，登录态未验证挂账）")
    return FreeDownloadAttempt(p_code=p_code, url=url, http_status=status, data=data,
                               fmt=fmt, is_document=is_document, detail=why)


# ---------------- T41P0：PentAGI P0 清偿件（2026-10-23；FR10.1 发布硬门） ----------------
# doc88_assessment.md（PentAGI flow 9）P0 五项的落地：P0-1/P0-5=TLS 单态+显式编码声明；
# P0-2=默认腿显式频控；P0-3=配置缓存合并 info 双发；P0-4=free_probe 常量默认关。
# 频控参数全部取自研判 ②/⑤ 节（平衡档 40~60 发/分钟），阈值常量化便于巡检对账。

def _is_content_encoding_error(exc: Exception) -> bool:
    """curl(61) 类内容编码错判定（libcurl 不识 ``Content-Encoding`` 值时抛出）。"""
    text = str(exc)
    return "(61)" in text or "content encoding" in text.lower()


def _curl_cffi_raw_get(url: str, timeout: float) -> tuple[int, bytes]:
    """curl_cffi **同栈**低级兜底腿（P0-1 核心）：``Curl`` 对象 ``impersonate("chrome")``
    保留 Chrome TLS/HTTP2 指纹、**不设 ``ACCEPT_ENCODING``**（关自动解码）——CDN 谎报
    ``Content-Encoding: compress`` 时 body 原样收下（本地实测 0.16.3：status 200、
    原始字节完整），不再出现 curl(61)；头集合自管（含 ``Accept-Encoding: identity``）。

    - 与原降级腿（plain requests/urllib3）的本质差异：**全程单一 TLS 栈**——同一文档
      收割内 JA3 不再 Chrome↔Python-urllib3 切换（研判 ③ 节「最强机器特征」根除）；
    - 字节判件归调用方（R16 只认字节：fetch_ebt_asset 魔数/长度/zlib 三重门 fail-closed）；
    - ``default_headers=False``：impersonate 只落 TLS/HTTP2 层，HTTP 头由本件显式给
      （UA/Referer/Accept-Encoding 与 requests 腿逐字一致，头序差异属兜底路固有）。
    """
    from curl_cffi import Curl, CurlInfo, CurlOpt  # 延迟导入：纯解析路径零依赖
    buf = bytearray()
    curl = Curl()
    try:
        curl.setopt(CurlOpt.URL, url.encode("utf-8"))
        curl.setopt(CurlOpt.WRITEFUNCTION, buf.extend)
        curl.setopt(CurlOpt.TIMEOUT_MS, int(max(1, round(timeout * 1000))))
        curl.setopt(CurlOpt.FOLLOWLOCATION, 1)
        curl.setopt(CurlOpt.MAXREDIRS, 10)
        curl.impersonate(IMPERSONATE, default_headers=False)
        curl.setopt(CurlOpt.HTTPHEADER, [
            b"User-Agent: " + DOC88_UA.encode("ascii"),
            b"Referer: " + DOC88_REFERER.encode("ascii"),
            b"Accept: */*",
            b"Accept-Encoding: " + ACCEPT_ENCODING_IDENTITY.encode("ascii"),
        ])
        curl.perform()
        return int(curl.getinfo(CurlInfo.RESPONSE_CODE)), bytes(buf)
    finally:
        curl.close()


# ------ P0-2：默认网络腿进程级显式频控（NetworkPacer；研判 ② 平衡档） ------

#: 单发随机抖动区间（秒）：800~1500ms（研判 ② 平衡档「单发 ≥800ms jitter，杜绝零间隔」）
JITTER_MIN_S = 0.8
JITTER_MAX_S = 1.5
#: 抖动有效下限（秒）：抽取值低于 500ms 抬到此值（研判 ② 关键结论 1「下限 500ms」）
JITTER_FLOOR_S = 0.5
#: info 端点（``doc.php?act=info``，参数化敏感端点）独立间隔（研判 ② 关键结论 2「≥2s」）
INFO_ENDPOINT_MIN_GAP_S = 2.0
#: 文档间冷却区间（秒）：模拟翻页/阅读节奏（研判 ② 关键结论 3）
DOC_COOLDOWN_MIN_S = 5.0
DOC_COOLDOWN_MAX_S = 15.0
#: 会话冷却：每 N 文档一次 30~60s 长歇（打破长会话连续流量特征；研判 ② 关键结论 3）
SESSION_DOC_INTERVAL = 8
SESSION_COOLDOWN_MIN_S = 30.0
SESSION_COOLDOWN_MAX_S = 60.0
#: 日请求配额（每出口 IP，发；研判 ⑤ 建议区间 1000~2000 取上限），超限熔断
DAILY_REQUEST_LIMIT = 2000


class NetworkPacer:
    """doc88 默认网络腿进程级显式频控（P0-2 清偿件）。

    - 四层节流取最不利：单发抖动（800~1500ms·下限 500ms）/ info 端点独立 ≥2s /
      文档间冷却 5~15s / 每 8 文档会话冷却 30~60s——**替换对 FFDec 隐式节流的依赖**
      （研判 P2-4「FFDec 一旦并行化节流消失」的前置清偿）；
    - 日配额熔断（每出口 IP）：``DAILY_REQUEST_LIMIT`` 发/日，超限抛
      ``Doc88RateBudgetError``（fail-closed，发不出去）；
    - clock/sleep/rng 可注入（确定性测试注入点）；**只接线默认腿**（``_curl_cffi_get``
      /``_curl_cffi_get_bytes``/raw 兜底前的 ``_pace_network_request``）——注入腿
      （Fetch/BytesFetch 测试面）零接线零等待，离线测试确定性不受影响；
    - p_code 归属从 URL 现解（``extract_p_code``：info/文档页/download 三形态通吃；
      ebt 资产名密文解不出→只吃单发抖动不吃文档冷却，如实不猜）；
    - 线程口径同 RateLimiter：进程级单线程顺序调用，不加锁。
    """

    def __init__(self, *, clock: Callable[[], float] | None = None,
                 sleep: Callable[[float], None] | None = None,
                 rng: random.Random | None = None,
                 daily_limit: int = DAILY_REQUEST_LIMIT):
        self._clock: Callable[[], float] = clock or time.monotonic
        self._sleep: Callable[[float], None] = sleep or time.sleep
        self._rng = rng or random.Random()
        self.daily_limit = int(daily_limit)
        self._last_request: float | None = None   # 上一发时刻（抖动/冷却基准）
        self._last_info: float | None = None      # 上一发 info 端点时刻
        self._last_doc: str | None = None         # 上一发所属 p_code
        self._docs_seen: int = 0                  # 本会话已见文档数（会话冷却档位）
        self._day = self._today()
        self._count_today = 0

    @staticmethod
    def _today() -> str:
        return time.strftime("%Y-%m-%d", time.localtime())

    def stats(self) -> dict:
        """频控台账（零造假：计数/归属全实测，供 audit/巡检消费）。"""
        return {"count_today": self._count_today, "daily_limit": self.daily_limit,
                "docs_seen": self._docs_seen, "last_doc": self._last_doc}

    def pace(self, url: str) -> None:
        """发请求前调用：算齐四层等待取最不利值 sleep，再落时间戳与计数。"""
        now = self._clock()
        day = self._today()
        if day != self._day:                       # 自然日切：日计数归零（同 RateLimiter 口径）
            self._day, self._count_today = day, 0
        if self._count_today >= self.daily_limit:
            raise Doc88RateBudgetError(
                f"doc88 日请求配额熔断：{self._count_today}/{self.daily_limit}"
                f"（每出口 IP，超限即停——T41P0/P0-2）")
        doc = extract_p_code(url)
        is_info = "act=info" in url
        waits: list[float] = []
        if self._last_request is not None:         # ① 单发随机抖动（替换 FFDec 隐式节流）
            jitter = max(self._rng.uniform(JITTER_MIN_S, JITTER_MAX_S), JITTER_FLOOR_S)
            waits.append(self._last_request + jitter - now)
        if is_info and self._last_info is not None:  # ② info 敏感端点独立间隔
            waits.append(self._last_info + INFO_ENDPOINT_MIN_GAP_S - now)
        if doc is not None and self._last_doc is not None and doc != self._last_doc:
            waits.append(self._last_request + self._rng.uniform(  # ③ 文档间冷却
                DOC_COOLDOWN_MIN_S, DOC_COOLDOWN_MAX_S) - now)
            if (self._docs_seen + 1) % SESSION_DOC_INTERVAL == 0:  # ④ 会话冷却
                waits.append(self._last_request + self._rng.uniform(
                    SESSION_COOLDOWN_MIN_S, SESSION_COOLDOWN_MAX_S) - now)
        wait = max((w for w in waits if w > 0.0), default=0.0)
        if wait > 0.0:
            self._sleep(wait)
        now = self._clock()                        # sleep 后重取（注入 clock 场景已推进）
        self._count_today += 1
        self._last_request = now
        if is_info:
            self._last_info = now
        if doc is not None and doc != self._last_doc:
            self._last_doc = doc
            self._docs_seen += 1


#: 进程级默认 pacer（懒建：首个默认腿请求时成形；测试可整体替换）
_PACER: "NetworkPacer | None" = None


def _pace_network_request(url: str) -> None:
    """默认腿发请求前的显式频控入口（P0-2）——注入腿不经此（零接线零等待）。"""
    global _PACER
    if _PACER is None:
        _PACER = NetworkPacer()
    _PACER.pace(url)


# ------ P0-3：p_code 级配置缓存（ConfigCache；plan/fetch_ladder 段间共享） ------

#: 会话级 TTL（秒）：单文档收割会话内 plan→fetch_ladder 共享 1 发 info
CONFIG_CACHE_TTL_S = 3600.0
#: 缓存条目上限（FIFO 逐出）：防长跑进程无界增长
CONFIG_CACHE_MAX_ENTRIES = 256


class ConfigCache:
    """p_code → ``Doc88Config`` 进程内缓存（P0-3 清偿件：info 端点 3.5→1 发/文档）。

    - TTL 会话级 + FIFO 有界（插入序逐出最老条目）；
    - **只缓存成功解出的配置**：WAF/404/解析败不入缓存（fail-closed——坏件下次如实
      重探，不固化瞬态故障）；
    - clock 可注入（TTL 判定确定性测试注入点）；hits/misses 如实计数（``stats()``）。
    """

    def __init__(self, ttl_s: float = CONFIG_CACHE_TTL_S,
                 *, clock: Callable[[], float] | None = None):
        self._ttl = float(ttl_s)
        self._clock: Callable[[], float] = clock or time.monotonic
        self._entries: dict[str, tuple[float, Doc88Config]] = {}
        self._hits = 0
        self._misses = 0

    def get(self, p_code: str) -> Doc88Config | None:
        entry = self._entries.get(p_code)
        if entry is None:
            self._misses += 1
            return None
        ts, config = entry
        if self._clock() - ts > self._ttl:         # TTL 过期：逐出如实 miss
            self._entries.pop(p_code, None)
            self._misses += 1
            return None
        self._hits += 1
        return config

    def put(self, p_code: str, config: Doc88Config) -> None:
        if p_code not in self._entries and len(self._entries) >= CONFIG_CACHE_MAX_ENTRIES:
            self._entries.pop(next(iter(self._entries)))   # FIFO 逐出最老
        self._entries[p_code] = (self._clock(), config)

    def stats(self) -> dict:
        """缓存台账（hits/misses/在位条目数，零造假口径）。"""
        return {"hits": self._hits, "misses": self._misses,
                "entries": len(self._entries), "ttl_s": self._ttl}
