# -*- coding: utf-8 -*-
"""T32 单测：doc88 SWF 合成→FFDec→presse→PDF 全链 + 段3 fetch_ladder 接线（FR4.AC1）。

被测物 = kb_factory.harvest_engine.adapters.doc88 之 T32 增量件：
- ``synthesize_page_swf``：§1.6 三行公式接线（swf_raw 补 ``\\x40\\x00\\x00\\x00`` 终止符 +
  ``swf[4:8]`` 长度补丁 + 帧 RECT 修正/帧数 0 检测——pdf/swf_toolchain.py 真符号，
  T27 报告第1条接线口径）；
- ``swf_chain_to_pdf``：FFDec frame:pdf 子进程分组编排（每组一 JVM）+ 同 SWF 集
  **双导出**同源参照 + presse merge（≥2 输入才 merge，单页直用 frames.pdf）+
  quality_gate manifest 落盘（expected_pages/ref_chars/ref_chars_source=doc88）；
- ``Doc88DownloadAdapter.fetch_ladder``：段3 L1 主径实装——配置发现(T24)+ebt 收割(T27)
  +SWF 全链(T32) 编排；异常族映射 Doc88WAFBlocked/Doc88DocNotFound/Doc88AssetError
  （含 T32 新增 Doc88ChainError/ToolchainError/SwfError）→ ok=False 的 LadderResult。

参照口径实锤（2026-10-22 本任务实测，FFDec 26.4.0 ``-help export`` 全格式清单）：
- FFDec **无 ``frame:text`` 格式**（frame 族只有 png/apng/gif/avi/svg/canvas/pdf/bmp/
  webp/webp_animated）；
- doc88 页文字全部住在 DefineSprite 内（93243737771803 第 1 页 sprite 内 5×DefineText2、
  顶层 0 个）→ CLI ``-format text:plain|formatted -export text`` 双格式实测**零文件**
  （顶层 DefineEditText 合成对照件可导出=导出器本身无恙，不递归 sprite 是差异根因）；
- 故「FFDec frame:text 同源参照」落为**同 SWF 集 FFDec frame:pdf 双导出**：第二腿独立
  导出的逐页 frames.pdf 经 pypdfium2 抽字数（quality_gate.count_chars 同口径真符号），
  与产线腿（第一腿导出→presse merge→pypdfium2）构成两口径同源比对——活样本页 1-4
  实测 376 字==376 字（比例 1.000），71 页全量见实弹用例。

离线合成世界（零网络零子进程注入）：最小合法 FWS（FileAttributes+SetBackgroundColor，
帧数 0=§1.6 修正路实锚；设备字体的 DefineEditText 会让 FFDec FontNormalizer NPE，
如实不用）经真 zlib 装入 PH/PK 走 harvest_ebt_assets 全真路——文字层为 0
（chars==ref==0，字数门在实弹用例验真值）。

实弹口径：93243737771803（71 页单层 2026 件）全文档全链；网络腿（info+72 资产整下）
=@pytest.mark.live（KB_HARVEST_SKIP_LIVE=1 跳过并明示）；SWF/FFDec/presse=本地算力
（rea-tools JDK21+FFDec 26.4.0+presse，非网络），缺位 skip 并明示补救命令；
Store 缓存在位后零网络复核（计数腿注入 AssertionError 证伪任何网络触碰）。
"""
import importlib.util
import json
import os
import struct
import sys
import time
import zlib
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    for _anc in _KB_DIR.parents:  # worker worktree：channel_adapters 只读复用主仓真身
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.channel_adapters.base import FileMeta
    from kb_factory.harvest_engine.adapters.base import (
        HarvestPlan, LadderResult, WALL_BLOCKED_WAF)
    from kb_factory.harvest_engine.adapters.doc88 import (
        DOC88_KEY2_NAME, Doc88AssetError, Doc88ChainError, Doc88Config, Doc88DocNotFound,
        Doc88DownloadAdapter, Doc88WAFBlocked, FFDEC_GROUP_SIZE, PageLoc, PageSlice,
        SWF_TERMINATOR, SWF_ZOOM, ebt_asset_url, harvest_ebt_assets,
        merge_frames_pdfs, ph_asset_name, pk_asset_name, plan_swf_groups,
        swf_chain_to_pdf, synthesize_page_swf, _curl_cffi_get)
    from kb_factory.harvest_engine.codec import variant_b64 as vb
    from kb_factory.harvest_engine.pdf.swf_toolchain import (
        REASON_FRAME_COUNT_ZERO, parse_swf_header)
    from kb_factory.harvest_engine.quality_gate import load_manifest
    from kb_factory.harvest_engine.store.ledger import Store
    from kb_factory.harvest_engine.tools.fetch_toolchain import (
        default_toolchain_root, locate_ffdec, locate_java, locate_presse)
except ImportError:  # pragma: no cover - worktree 阶段回退导入
    from channel_adapters.base import FileMeta
    from harvest_engine.adapters.base import (
        HarvestPlan, LadderResult, WALL_BLOCKED_WAF)
    from harvest_engine.adapters.doc88 import (
        DOC88_KEY2_NAME, Doc88AssetError, Doc88ChainError, Doc88Config, Doc88DocNotFound,
        Doc88DownloadAdapter, Doc88WAFBlocked, FFDEC_GROUP_SIZE, PageLoc, PageSlice,
        SWF_TERMINATOR, SWF_ZOOM, ebt_asset_url, harvest_ebt_assets,
        merge_frames_pdfs, ph_asset_name, pk_asset_name, plan_swf_groups,
        swf_chain_to_pdf, synthesize_page_swf, _curl_cffi_get)
    from harvest_engine.codec import variant_b64 as vb
    from harvest_engine.pdf.swf_toolchain import (
        REASON_FRAME_COUNT_ZERO, parse_swf_header)
    from harvest_engine.quality_gate import load_manifest
    from harvest_engine.store.ledger import Store
    from harvest_engine.tools.fetch_toolchain import (
        default_toolchain_root, locate_ffdec, locate_java, locate_presse)

import pypdfium2 as pdfium

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"
_LIVE_REASON = "KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（真实网络未跑，公约第4条）"

_ROOT = default_toolchain_root()
_FFDEC_READY = bool(locate_java(_ROOT) and locate_ffdec(_ROOT))
_PRESSE_READY = bool(locate_presse(_ROOT))
_CHAIN_READY = _FFDEC_READY and _PRESSE_READY
_SKIP_CHAIN = ("FFDec/JDK/presse 未落位（rea-tools 或 KB_HARVEST_JAVA/KB_HARVEST_FFDEC_JAR/"
               "KB_HARVEST_PRESSE）：先 py -3 -m kb_factory.harvest_engine.tools.fetch_toolchain "
               "--ensure ffdec,presse")

LIVE_P_CODE = "93243737771803"      # 71 页单层 2026 件（T24 活探固化口径）
LIVE_EXPECTED_PAGES = 71
WAF_BODY = "<html><body>网络环境安全验证，请稍后再试。</body></html>"


# ---------------- 离线合成世界（最小合法 FWS；零网络零子进程注入） ----------------

def _rect(xmax: int, ymax: int) -> bytes:
    """SWF RECT 序列化（xmin=ymin=0；位域 MSB 对齐，与 swf_toolchain._pack_rect 同构）。"""
    nbits = max(v.bit_length() + 1 for v in (0, xmax, 0, ymax))
    acc, used = nbits, 5
    for v in (0, xmax, 0, ymax):
        acc = (acc << nbits) | (v & ((1 << nbits) - 1))
        used += nbits
    bl = (used + 7) // 8
    acc <<= bl * 8 - used
    return acc.to_bytes(bl, "big")


def _tag(code: int, body: bytes) -> bytes:
    if len(body) < 63:
        return struct.pack("<H", (code << 6) | len(body)) + body
    return struct.pack("<H", (code << 6) | 0x3F) + struct.pack("<I", len(body)) + body


def _swf_world(page_count: int = 3, width: int = 100, height: int = 200,
               frame_count: int = 0):
    """离线全链合成世界：PH=YBD\\x02+4B 填充+zlib(FWS v9 头：FileAttributes+
    SetBackgroundColor，帧数 0=§1.6 修正路实锚/帧数 1=干净件)；PK=32B 确定性填充+
    zlib(每页异色 SetBackgroundColor)。返回 (Doc88Config, {资产URL: 原始字节}, info XML)。"""
    p_code, p_swf, host = "123456", "63-t32-synth", "https://ebt999.doc88.com"
    head_tags = _tag(69, b"\x01\x00\x00\x00") + _tag(9, b"\xff\xff\xff")
    head_plain = (b"FWS" + bytes([9]) + struct.pack("<I", 0) + _rect(width * 20, height * 20)
                  + b"\x00\x40" + struct.pack("<H", frame_count) + head_tags)
    ph = b"YBD\x02" + b"\x00\x00\x00\x00" + zlib.compress(head_plain, 9)
    routes = {ebt_asset_url(host, ph_asset_name(1, len(ph), p_swf)): ph}
    pages, offset = [], len(ph)
    for n in range(1, page_count + 1):
        body = _tag(9, bytes(((0x10 * n) & 0xFF, (0x20 * n) & 0xFF, (0x40 * n) & 0xFF)))
        pad = bytes((n * 31 + j) & 0xFF for j in range(32))
        pk = pad + zlib.compress(body, 9)
        pages.append(PageLoc(1, width, height, offset, len(pk)))
        routes[ebt_asset_url(host, pk_asset_name(pages[-1], p_swf, n, p_code))] = pk
        offset += len(pk)
    cfg = Doc88Config(p_code=p_code, p_name="T32 合成件", p_pagecount=page_count,
                      p_ebthost=host, p_swf=p_swf, header_sizes=(len(ph),),
                      pages=tuple(pages), source="info_xml")
    return cfg, routes, _world_info_xml(cfg)


def _world_info_xml(cfg: Doc88Config) -> str:
    """合成世界的 info XML（discover_config 文本腿注入物；key2 加密由用例做）。"""
    parts = ['<?xml version="1.0" encoding="UTF-8"?><doc>']
    for key, val in (("p_code", cfg.p_code), ("p_name", cfg.p_name),
                     ("p_pagecount", cfg.p_pagecount), ("p_swf", cfg.p_swf),
                     ("p_ebthost", cfg.p_ebthost), ("p_404", "0")):
        parts.append(f"<{key}><![CDATA[{val}]]></{key}>")
    parts.append(f'<p_struct><h n="1">{cfg.header_sizes[0]}</h>')
    for i, loc in enumerate(cfg.pages, 1):
        parts.append('<p n="%d"><e>%d</e><w>%d</w><h>%d</h><p>%d</p><l>%d</l></p>'
                     % (i, loc.level, loc.width, loc.height, loc.offset, loc.length))
    parts.append("</p_struct></doc>")
    return "".join(parts)


class _Recorder:
    """确定性文本网络注入件（Fetch 注入点）：URL 前缀→(status, body)。"""

    def __init__(self, routes, default=(404, "")):
        self.routes = routes
        self.default = default

    def __call__(self, url, timeout):
        for prefix, resp in self.routes.items():
            if url.startswith(prefix):
                return resp
        return self.default


class _BytesRecorder:
    """确定性二进制网络注入件（BytesFetch 注入点）：完整 URL→(200, bytes)；未登记→404。"""

    def __init__(self, routes):
        self.routes = dict(routes)
        self.calls = []

    def __call__(self, url, timeout):
        self.calls.append(url)
        if url in self.routes:
            return 200, self.routes[url]
        return 404, b"not-found"


def _world_adapter(tmp_path, world=None, **kwargs):
    """合成世界适配器（fetch_ladder 离线接线用）：文本腿喂 info XML、二进制腿喂资产路由。"""
    cfg, routes, xml = world or _swf_world(2)
    txt = _Recorder({"https://www.doc88.com/doc.php?act=info": (200, vb.encode(DOC88_KEY2_NAME, xml))})
    adapter = Doc88DownloadAdapter(fetch=txt, fetch_bytes=_BytesRecorder(routes),
                                   store=Store(str(tmp_path / "store")),
                                   work_dir=str(tmp_path / "work"), **kwargs)
    meta = FileMeta(title="T32 离线件", fmt="pdf")
    meta.extra["p_code"] = cfg.p_code
    return adapter, HarvestPlan(meta=meta), cfg


def _load_t24():
    """载入 T24 兄弟测试模块（其实测密文内嵌件）作离线数据源——只 exec 不收集。"""
    p = Path(__file__).resolve().parent / "test_doc88_info.py"
    spec = importlib.util.spec_from_file_location("_t24_doc88_info", p)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


_t24 = _load_t24()


# ---------------- 纯字节：SWF 合成（§1.6 三行公式接线） ----------------

def test_fr4ac1_synthesize_terminator_lenpatch_and_fix(tmp_path):
    """§1.6 合成主路：终止符+长度补丁+帧数 0 修正（真符号 swf_resize_if_needed）。"""
    cfg, routes, _ = _swf_world(1, frame_count=0)
    result = harvest_ebt_assets(cfg, store=Store(str(tmp_path / "s")), fetch=_BytesRecorder(routes))
    fixed, reasons = synthesize_page_swf(result.pages[0])
    assert fixed.endswith(SWF_TERMINATOR)                       # \x40\x00\x00\x00 终止符
    h = parse_swf_header(fixed)
    assert h.signature == "FWS" and h.version == 9
    assert h.length_ok and h.declared_len == len(fixed)         # swf[4:8] 长度补丁
    assert h.frame_count == 1                                   # 帧数 0→1（FFDec 静默零输出坑）
    assert (h.width_px, h.height_px) == (100, 200)              # RECT==页表 w-h（twip=px*20）
    assert reasons == (REASON_FRAME_COUNT_ZERO,)                # 缺陷检测如实入账


def test_fr4ac1_synthesize_clean_swf_passthrough(tmp_path):
    """干净件零改写：帧数 1+RECT 一致 → 无修正原因，字节仅含终止符+长度补丁。"""
    cfg, routes, _ = _swf_world(1, frame_count=1)
    result = harvest_ebt_assets(cfg, store=Store(str(tmp_path / "s")), fetch=_BytesRecorder(routes))
    fixed, reasons = synthesize_page_swf(result.pages[0])
    assert reasons == ()
    h = parse_swf_header(fixed)
    assert h.frame_count == 1 and (h.width_px, h.height_px) == (100, 200)
    assert h.length_ok and fixed.endswith(SWF_TERMINATOR)


def test_fr4ac1_synthesize_garbage_raises():
    """坏字节显式拒（R16 只认字节）：非 SWF 切片 → Doc88AssetError（SwfError 包装修正件口径）。"""
    bad = PageSlice(page_no=1, level=1, loc=PageLoc(1, 100, 200, 0, 10),
                    swf_head=b"NOT-SWF!", swf_body=b"",
                    head_stream_offset=40, body_stream_offset=32)
    with pytest.raises(Doc88AssetError, match="SWF 合成件不可解析"):
        synthesize_page_swf(bad)


# ---------------- 分组纯函数 + merge 决策 ----------------

def test_fr4ac1_plan_swf_groups():
    """分组编排（每组一 JVM）：顺序切片不漏页；组宽 <1 如实拒。"""
    assert plan_swf_groups([1, 2, 3, 4, 5], 2) == ((1, 2), (3, 4), (5,))
    assert plan_swf_groups([7], 24) == ((7,),)
    assert plan_swf_groups([], 24) == ()
    assert FFDEC_GROUP_SIZE >= 1 and SWF_ZOOM == 1.0
    with pytest.raises(ValueError):
        plan_swf_groups([1], 0)


def test_fr4ac1_merge_single_page_direct(tmp_path):
    """单页直用 frames.pdf（任务卡：≥2 输入才 merge）——bogus presse 若被调即炸，证未调用。"""
    dummy = tmp_path / "frames.pdf"
    dummy.write_bytes(b"%PDF-1.4-dummy")
    out = merge_frames_pdfs({1: dummy}, tmp_path / "final.pdf",
                            presse_exe=tmp_path / "nope.exe")
    assert out == dummy and not (tmp_path / "final.pdf").exists()


def test_fr4ac1_merge_empty_raises(tmp_path):
    with pytest.raises(Doc88ChainError, match="零页"):
        merge_frames_pdfs({}, tmp_path / "final.pdf")


# ---------------- 离线全链（真 FFDec/presse 本机件，非网络） ----------------

@pytest.mark.skipif(not _CHAIN_READY, reason=_SKIP_CHAIN)
def test_fr4ac1_chain_offline_multi_group(tmp_path):
    """离线全链：3 页 2 组（多 JVM 编排）→ 每页 frames.pdf → presse merge 3 页；
    双导出同源参照（ref 腿独立导出）；chars/ref 同口径计数；帧数 0 修正逐页入账。"""
    cfg, routes, _ = _swf_world(3, frame_count=0)
    harvest = harvest_ebt_assets(cfg, store=Store(str(tmp_path / "store")),
                                 fetch=_BytesRecorder(routes))
    chain = swf_chain_to_pdf(harvest, tmp_path / "chain", group_size=2)
    assert chain.swf_groups == ((1, 2), (3,))                   # 分组编排：2 组=2 JVM
    assert len(chain.fixes) == 3                                # 3 页全触发帧数 0 修正
    assert all(r == REASON_FRAME_COUNT_ZERO for _, r in chain.fixes)
    assert chain.merged and chain.pdf_path.is_file()            # ≥2 输入走 presse merge
    assert chain.pages == 3                                     # pypdfium2 实测页数
    doc = pdfium.PdfDocument(str(chain.pdf_path))
    try:
        assert len(doc) == 3
        sizes = {doc[i].get_size() for i in range(3)}
        assert sizes == {(100.0, 200.0)}                        # 页几何==页表 w-h
    finally:
        doc.close()
    assert chain.chars >= 0.9 * chain.ref_chars                 # 字数门（合成世界 0==0，实弹验真值）
    assert chain.ref_chars_source == "doc88"
    assert chain.ref_dir is not None and chain.pdf_dir is not None
    ref_pdfs = sorted(Path(chain.ref_dir).rglob("frames.pdf"))
    assert len(ref_pdfs) == 3                                   # 双导出第二腿独立产物
    assert chain.manifest_path is None                          # ref_chars=0 不落 manifest（schema 要求 ≥1，如实）


# ---------------- fetch_ladder 接线（离线注入；异常族映射） ----------------

@pytest.mark.skipif(not _CHAIN_READY, reason=_SKIP_CHAIN)
def test_fr4ac1_fetch_ladder_ok_offline(tmp_path):
    """段3 L1 主径离线全通：FileMeta(p_code)→发现→收割→合成→FFDec→merge→LadderResult。"""
    adapter, plan, cfg = _world_adapter(tmp_path, world=_swf_world(2, frame_count=0))
    result = adapter.fetch_ladder(plan)
    assert result.ok and result.ladder_used == "L1"
    assert isinstance(result, LadderResult)
    assert result.pages == 2 and Path(result.artifact_path).is_file()
    assert result.coverage == "2/2"
    assert plan.meta.pages == 2                                  # 实测页数回填
    assert plan.meta.extra["doc88_config"]["p_code"] == cfg.p_code
    chain = plan.meta.extra["doc88_chain"]
    assert chain["ref_chars_source"] == "doc88" and chain["slices"] == 2
    doc = pdfium.PdfDocument(result.artifact_path)
    try:
        assert len(doc) == 2                                     # 产物独立复核
    finally:
        doc.close()


def test_fr4ac1_fetch_ladder_no_p_code_maps_result():
    """裸 meta（无 p_code）→ ok=False 结果（不再抛桩错——T32 接线后的契约）。"""
    adapter = Doc88DownloadAdapter(fetch=_Recorder({}))
    result = adapter.fetch_ladder(HarvestPlan(meta=FileMeta(title="x", fmt="pdf")))
    assert isinstance(result, LadderResult) and result.ok is False
    assert result.wall_status is None and "p_code" in result.detail


def test_fr4ac1_fetch_ladder_waf_maps_result(tmp_path):
    """Doc88WAFBlocked→ok=False+wall_status=blocked_waf+NFR1 标记位（零子进程）。"""
    adapter = Doc88DownloadAdapter(
        fetch=_Recorder({"https://www.doc88.com/": (200, WAF_BODY)}),
        fetch_bytes=_BytesRecorder({}), store=Store(str(tmp_path / "s")),
        work_dir=str(tmp_path / "w"))
    meta = FileMeta(title="被墙件", fmt="pdf",
                    source_url=f"https://www.doc88.com/p-123456789.html")
    result = adapter.fetch_ladder(HarvestPlan(meta=meta))
    assert result.ok is False and result.wall_status == WALL_BLOCKED_WAF
    assert meta.extra["wall_status"] == WALL_BLOCKED_WAF         # NFR1 统一落点
    assert isinstance(Doc88WAFBlocked(), Exception)


def test_fr4ac1_fetch_ladder_notfound_maps_result(tmp_path):
    """Doc88DocNotFound（p_404=1）→ ok=False 如实结果（判死不回退）。"""
    xml404 = ('<?xml version="1.0"?><doc><p_code><![CDATA[000000]]></p_code>'
              '<p_pagecount><![CDATA[0]]></p_pagecount><p_swf><![CDATA[x]]></p_swf>'
              '<p_ebthost><![CDATA[https://ebt1.doc88.com]]></p_ebthost>'
              '<p_404><![CDATA[1]]></p_404></doc>')
    adapter = Doc88DownloadAdapter(
        fetch=_Recorder({"https://www.doc88.com/doc.php?act=info":
                         (200, vb.encode(DOC88_KEY2_NAME, xml404))}),
        fetch_bytes=_BytesRecorder({}), store=Store(str(tmp_path / "s")),
        work_dir=str(tmp_path / "w"))
    meta = FileMeta(title="404 件", fmt="pdf")
    meta.extra["p_code"] = "000000"
    result = adapter.fetch_ladder(HarvestPlan(meta=meta))
    assert result.ok is False and result.wall_status is None
    assert "p_404" in result.detail


def test_fr4ac1_fetch_ladder_asset_error_maps_result(tmp_path):
    """Doc88AssetError（真 119 页配置+资产路由缺→HTTP 404）→ ok=False；中间事实如实入账。"""
    adapter = Doc88DownloadAdapter(
        fetch=_Recorder({"https://www.doc88.com/doc.php?act=info":
                         (200, _t24._INFO_CIPHERTEXT)}),
        fetch_bytes=_BytesRecorder({}), store=Store(str(tmp_path / "s")),
        work_dir=str(tmp_path / "w"))
    meta = FileMeta(title="资产缺件", fmt="pdf")
    meta.extra["p_code"] = _t24.SAMPLE_P_CODE
    result = adapter.fetch_ladder(HarvestPlan(meta=meta))
    assert result.ok is False and result.wall_status is None
    assert "404" in result.detail or "Doc88AssetError" in result.detail
    assert meta.extra["doc88_config"]["p_pagecount"] == 119      # 发现腿成果如实保留
    assert meta.pages == 119


def test_fr4ac1_fetch_ladder_toolchain_error_maps_result(tmp_path):
    """工具缺位（java_exe 指空）→ ToolchainError 映射 ok=False（快失败零 JVM）。"""
    adapter, plan, _ = _world_adapter(tmp_path, world=_swf_world(2, frame_count=0),
                                      java_exe=str(tmp_path / "nojava.exe"))
    result = adapter.fetch_ladder(plan)
    assert result.ok is False and result.wall_status is None
    assert "工具未落位" in result.detail or "ToolchainError" in result.detail


# ---------------- 实弹（真实网络 zero-mock；KB_HARVEST_SKIP_LIVE=1 跳过） ----------------

@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason=_LIVE_REASON)
@pytest.mark.skipif(not _CHAIN_READY, reason=_SKIP_CHAIN)
def test_fr4ac1_live_full_chain_71pages(tmp_path):
    """FR4.AC1 实弹主验收：93243737771803 全文档 L1 全链（发现→72 资产整下→71 SWF 合成
    →FFDec frame:pdf 分组双导出→presse merge→71 页 PDF）；字数门 chars≥0.9×同源参照；
    质检门 manifest（expected_pages=71/ref_chars_source=doc88/ref_chars=实测）；
    Store 缓存在位后零网络复核（注入 AssertionError 腿证伪任何网络触碰）。"""
    t0 = time.time()
    adapter = Doc88DownloadAdapter(store=Store(str(tmp_path / "store")),
                                   work_dir=str(tmp_path / "work"), timeout=30.0)
    meta = FileMeta(title="doc88 实弹件", fmt="ppt",
                    source_url=f"https://www.doc88.com/p-{LIVE_P_CODE}.html")
    result = adapter.fetch_ladder(HarvestPlan(meta=meta))
    assert result.ok, result.detail
    assert result.ladder_used == "L1"
    assert meta.extra["doc88_config"]["p_pagecount"] == LIVE_EXPECTED_PAGES
    assert result.pages == LIVE_EXPECTED_PAGES                   # pypdfium2 实测（质检门①参照）
    chain = meta.extra["doc88_chain"]
    assert chain["slices"] == LIVE_EXPECTED_PAGES                # 切片数==页表页数（T27 硬门同源）
    assert chain["downloads"] == LIVE_EXPECTED_PAGES + 1         # 1 PH + 71 PK 全新下载
    assert chain["fixes"] == 0                                   # 2026 件头自洽：零修正（实测如实）
    # 产物独立复核：71 页、几何 720×540
    doc = pdfium.PdfDocument(result.artifact_path)
    try:
        assert len(doc) == LIVE_EXPECTED_PAGES
        assert doc[0].get_size() == (720.0, 540.0)
    finally:
        doc.close()
    # 字数门（两口径同源：同 SWF 集 FFDec 双导出，参照实测值零造假）
    assert chain["ref_chars"] > 0, "FFDec 同源参照实测为 0：字数门失去意义，如实拒"
    assert result.chars >= 0.9 * chain["ref_chars"]
    ratio = result.chars / chain["ref_chars"]
    # 质检门 manifest：quality_gate.load_manifest 真符号兼容
    mpath = Path(chain["manifest_path"])
    assert mpath.is_file()
    manifest = json.loads(mpath.read_text(encoding="utf-8"))
    assert manifest["expected_pages"] == LIVE_EXPECTED_PAGES
    assert manifest["ref_chars_source"] == "doc88"
    assert manifest["ref_chars"] == chain["ref_chars"]
    loaded = load_manifest(mpath)
    assert loaded["expected_pages"] == LIVE_EXPECTED_PAGES and loaded["ref_chars"] > 0
    # Store 缓存在位零网络复核：全命中零网络（R14 整文件字节缓存复用）
    from kb_factory.harvest_engine.adapters.doc88 import discover_config
    cfg = discover_config(LIVE_P_CODE, fetch=_curl_cffi_get, timeout=30.0)

    def _no_net(url, timeout):
        raise AssertionError(f"零网络复核被破约：{url}")

    again = harvest_ebt_assets(cfg, store=Store(str(tmp_path / "store")), fetch=_no_net,
                               timeout=30.0)
    assert again.cache_hits == LIVE_EXPECTED_PAGES + 1 and again.downloads == 0
    assert len(again.pages) == LIVE_EXPECTED_PAGES
    assert again.pages[0].swf_raw[:3] == b"FWS"
    print(f"[live] 71页全链 chars={result.chars} ref_chars={chain['ref_chars']} "
          f"ratio={ratio:.4f} groups={chain['groups']} 耗时 {time.time() - t0:.0f}s "
          f"pdf={result.artifact_path}")
