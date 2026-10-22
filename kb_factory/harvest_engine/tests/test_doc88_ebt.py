# -*- coding: utf-8 -*-
"""T27 单测：doc88 ebt 资产下载+整文件字节缓存+PH/PK 分层切片（FR4.AC1）。

被测物 = kb_factory.harvest_engine.adapters.doc88 之 T27 增量件（harvest_ebt_assets 族）：
- 资产名/URL（DOC88_SPEC §1.4）：ph_asset_name/pk_asset_name/ebt_asset_url——文件名=key2
  编码「层号-偏移-长度-{p_swf}[-{页码}-{p_code}]」，与站方资产逐字复现（69091550288
  PH L1/PK 第1页实测 URL 全文内嵌为锚，§5 探针实录 getebt-0rUX…==）；
- 整文件下载（R14：ebt CDN 忽略 Range 头——只整下不续传）+ Store 整文件字节缓存复用
  （miss→下载→判件→put_asset 自动落 progress 分块；判件不过不落缓存，坏字节不进库）；
- 按页偏移切片（页偏移=层内偏移：层首页 offset==层头大小、层内逐页连续——T24 实测
  119 页 3 层数据离线复证）+ zlib×2 解压拼接（PH[40:]/PK[32:]，try_decompress_zlib
  严格偏移优先、find_zlib_streams 回扫兜底）；全页模式切片数==页表页数硬断言。

实测字节锚（DOC88_SPEC §5 探针 2026-10-22，_probe/ 不入 git 故 sha1/URL 内嵌）：
- 69091550288 PH L1 全件 455235B sha1=36f9e390…，魔数 YBD\\x01、[40:] 0x789c、
  解压 488468B=SWF 头（FWS 签名）；
- 69091550288 PK 第 1 页全件 3936B sha1=a6a45884…，[32:] 0x789c、解压 7298B 页体；
- PH 解压头+PK 解压体 拼接 + \\x40\\x00\\x00\\x00 + 长度补丁 == page1_synthesized.swf
  （495770B FWS v9）逐字节一致（§1.6 复现；补丁属 T32，拼接产物本任务出）。

实弹预算纪律（任务卡 ≤6 资产文件）：A=93243737771803（71 页单层 2026 件）PH L1+PK
第 1 页=2 件；B=69091550288（三层 2011 件对照）PH L1+PH L2+PK 第 1 页+PK 第 51 页
（L2 首页 offset==453032 live 复核）=4 件；缓存二次命中零网络不计新件。

实弹新发现（本任务 2026-10-22 探针固化，实现侧已适配）：
- ebt CDN 无条件回 ``Content-Encoding: compress`` 而 body 实为原始字节——curl_cffi/
  libcurl 拒收（curl 61），网络腿降级 plain requests（原工具 CDN 走普通 requests 的
  机制原因）；
- 2026 件 EBT 新格式：PH 魔数 ``YBD\\x02``（2011 件 \\x01 之版本演化）、zlib 头
  0x78da 最高压缩级（2011 件 0x789c）——判件认 YBD 前缀族+头族级别无关解压
  （T05 真符号 789c 限定路保留在前）。

测试纪律（WORKER_CONVENTIONS）：离线单测零网络（二进制网络腿经 BytesFetch 注入点喂
确定性 (status, bytes)，任务卡明示注入点）；实弹用例（@pytest.mark.live）=真实网络
zero-mock，KB_HARVEST_SKIP_LIVE=1 时跳过并明示。
"""
import hashlib
import importlib.util
import json
import os
import sys
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
    from kb_factory.harvest_engine.adapters.doc88 import (
        EBT_PH_PREFIX, PK_HEAD_LEN, PK_KIND, PH_HEAD_LEN, PH_KIND, Doc88AssetError,
        Doc88Config, EbtHarvest, PageLoc, PageSlice, decompress_ebt_slice,
        ebt_asset_url, harvest_ebt_assets, ph_asset_name, pk_asset_name,
        _curl_cffi_get, _curl_cffi_get_bytes, discover_config)
    from kb_factory.harvest_engine.assets.magic_check import sniff_format
    from kb_factory.harvest_engine.codec import variant_b64 as vb
    from kb_factory.harvest_engine.codec.variant_b64 import DOC88_KEY2_NAME
    from kb_factory.harvest_engine.store.ledger import Store
except ImportError:  # pragma: no cover - worktree 阶段回退导入
    from harvest_engine.adapters.doc88 import (
        EBT_PH_PREFIX, PK_HEAD_LEN, PK_KIND, PH_HEAD_LEN, PH_KIND, Doc88AssetError,
        Doc88Config, EbtHarvest, PageLoc, PageSlice, decompress_ebt_slice,
        ebt_asset_url, harvest_ebt_assets, ph_asset_name, pk_asset_name,
        _curl_cffi_get, _curl_cffi_get_bytes, discover_config)
    from harvest_engine.assets.magic_check import sniff_format
    from harvest_engine.codec import variant_b64 as vb
    from harvest_engine.codec.variant_b64 import DOC88_KEY2_NAME
    from harvest_engine.store.ledger import Store


def _load_t24():
    """载入 T24 兄弟测试模块（其实测密文/常量内嵌件）作离线数据源——只 exec 不收集。"""
    p = Path(__file__).resolve().parent / "test_doc88_info.py"
    spec = importlib.util.spec_from_file_location("_t24_doc88_info", p)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


_t24 = _load_t24()

SAMPLE_P_CODE = _t24.SAMPLE_P_CODE      # 69091550288（119 页 3 层，2011 件）
NEW_P_CODE_A = _t24.NEW_P_CODE_A        # 93243737771803（71 页单层，2026 件）

# ---- 探针实测锚（2026-10-22，_probe/ph1_head.bin + pk1_head.bin + §5 URL 实录）----
PH1_SHA1 = "36f9e3907f9de4e0c0a98b1f41584ad480be169a"
PK1_SHA1 = "a6a4588415c68e9ce602e5b36eb75fa0d126ee96"
PH1_URL = ("https://ebt143.doc88.com/getebt-"
           "0rUXzqvV1q3T1rUW0SUS0LMR0LkR0iUS0LMR0LkR0jMQ1qsU0V8QsU9YvTnQCn==.ebt")
PK1_URL = ("https://ebt143.doc88.com/getebt-"
           "0rUU1qsS0Tsd0TkT1iUW0SUS0LMR0LkR0iUS0LMR0LkR0jMQ1qsU0V8QsU9YvTnQCiURzqH50LkR1qsX0jn!.ebt")

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"


class _BytesRecorder:
    """确定性二进制网络注入件（BytesFetch 注入点）：完整 URL→(200, bytes)；未登记→404；计数 calls。"""

    def __init__(self, routes):
        self.routes = dict(routes)
        self.calls = []

    def __call__(self, url, timeout):
        self.calls.append(url)
        if url in self.routes:
            return 200, self.routes[url]
        return 404, b"not-found"


class _CountingFetch:
    """实弹零网络复核用计数腿：包裹真网络腿，数请求次数。"""

    def __init__(self, inner):
        self.inner = inner
        self.calls = 0

    def __call__(self, url, timeout):
        self.calls += 1
        return self.inner(url, timeout)


def _synth_world(pages_per_level=(2, 2, 1)):
    """合成三层小世界（离线全链零网络）：PH=魔数+40B 头+zlib(假 SWF 头)、PK=32B 确定性
    伪随机头+zlib(假页体)；页表偏移按层内不变量推（层首页 offset=层头大小、层内逐页
    连续）。格式混排新旧两代：L1=YBD\\x01+0x789c（2011 件实测级）、L2=0x78da（级别
    无关头族）、L3=YBD\\x02+0x78da（2026 件实测新格式）。返回 (config, {URL: 原始字节})。"""
    p_code, p_swf, host = "123456", "63-synth", "https://ebt999.doc88.com"
    flavors = {1: (b"YBD\x01", 6), 2: (b"YBD\x01", 9), 3: (b"YBD\x02", 9)}
    header_sizes, pages, routes = [], [], {}
    page_no = 0
    for level, count in enumerate(pages_per_level, start=1):
        magic, zlvl = flavors[level]
        head_plain = f"FWS-fake-layer-{level}-swf-head".encode()
        ph = magic + b"\x00" * (PH_HEAD_LEN - 4) + zlib.compress(head_plain, zlvl)
        header_sizes.append(len(ph))
        routes[ebt_asset_url(host, ph_asset_name(level, len(ph), p_swf))] = ph
        offset = len(ph)
        for i in range(count):
            page_no += 1
            body_plain = f"body-L{level}-P{page_no}-{'x' * (i * 7)}".encode()
            pk = bytes((page_no * 31 + j) & 0xFF for j in range(PK_HEAD_LEN)) \
                + zlib.compress(body_plain, zlvl)
            pages.append(PageLoc(level, 100, 200, offset, len(pk)))
            routes[ebt_asset_url(host, pk_asset_name(pages[-1], p_swf, page_no, p_code))] = pk
            offset += len(pk)
    cfg = Doc88Config(p_code=p_code, p_name="合成件", p_pagecount=len(pages),
                      p_ebthost=host, p_swf=p_swf, header_sizes=tuple(header_sizes),
                      pages=tuple(pages), source="info_xml")
    return cfg, routes


def _ph_url_of(cfg, level):
    return ebt_asset_url(cfg.p_ebthost,
                         ph_asset_name(level, cfg.header_sizes[level - 1], cfg.p_swf))


# ---------- 资产名/URL：站方资产逐字复现（§1.4 + §5 探针实录锚） ----------

def test_fr4ac1_asset_urls_reproduce_site_names():
    """key2 编码名+URL 与站方资产逐字一致（PH1_URL/PK1_URL=探针实录全文，非推导拼凑）。"""
    cfg = _t24._sample_xml_config()   # 69091550288 实测配置（T24 内嵌密文解出）
    ph_name = ph_asset_name(1, cfg.header_sizes[0], cfg.p_swf)
    assert ebt_asset_url(cfg.p_ebthost, ph_name) == PH1_URL
    assert ph_name.endswith("==")                       # 探针实录尾（= 填充原样保留）
    assert vb.decode(DOC88_KEY2_NAME, ph_name) == f"1-0-455235-{cfg.p_swf}".encode()
    pk_name = pk_asset_name(cfg.pages[0], cfg.p_swf, 1, cfg.p_code)
    assert ebt_asset_url(cfg.p_ebthost, pk_name) == PK1_URL
    assert vb.decode(DOC88_KEY2_NAME, pk_name) == \
        f"1-455235-3936-{cfg.p_swf}-1-{cfg.p_code}".encode()


def test_fr4ac1_page_offset_layout_invariants():
    """按页偏移切片的语义地基（T24 实测 119 页 3 层数据离线复证）：层首页 offset==层头
    大小；层内逐页 offset[n+1]==offset[n]+length[n]（层流连续——PK 即层流字节切片）。"""
    cfg = _t24._sample_xml_config()
    by_level = {}
    for loc in cfg.pages:
        by_level.setdefault(loc.level, []).append(loc)
    assert sorted(by_level) == [1, 2, 3]
    for level, locs in by_level.items():
        assert locs[0].offset == cfg.header_sizes[level - 1]
        for a, b in zip(locs, locs[1:]):
            assert b.offset == a.offset + a.length
    assert by_level[2][0].offset == 453032              # T24 实证数字锚


# ---------- decompress_ebt_slice：纯函数（PH[40:]/PK[32:] 切片解压） ----------

def test_fr4ac1_decompress_slice_strict_and_fallback():
    good = zlib.compress(b"FWS-strict-head")                     # 0x789c（T05 真符号路）
    out, off = decompress_ebt_slice(b"YBD\x01" + b"\x00" * 36 + good, PH_HEAD_LEN,
                                    what="PH", name="n")
    assert out == b"FWS-strict-head" and off == PH_HEAD_LEN      # 严格路①
    good9 = zlib.compress(b"FWS-78da-head", 9)                   # 0x78da（级别无关头族路）
    assert good9[:2] == b"\x78\xda"
    out, off = decompress_ebt_slice(b"YBD\x02" + b"\x00" * 36 + good9, PH_HEAD_LEN,
                                    what="PH", name="n")
    assert out == b"FWS-78da-head" and off == PH_HEAD_LEN        # 严格路②（2026 件实测级）
    out, off = decompress_ebt_slice(bytes(range(32)) + b"\x01\x02" + zlib.compress(b"b"),
                                    PK_HEAD_LEN, what="PK", name="n")
    assert out == b"b" and off == PK_HEAD_LEN + 2                # 严格不成流→回扫命中，偏移如实
    out, off = decompress_ebt_slice(                            # 78da 位移→头族通用扫描兜底
        b"YBD\x01" + b"\x00" * 36 + b"\xaa\xbb" + zlib.compress(b"drift", 9),
        PH_HEAD_LEN, what="PH", name="n")
    assert out == b"drift" and off == PH_HEAD_LEN + 2
    with pytest.raises(Doc88AssetError, match="zlib"):
        decompress_ebt_slice(b"\x78\x9c" + b"\x00" * 9, PH_HEAD_LEN, what="PH", name="n")


# ---------- harvest_ebt_assets：全页/子集/缓存/判件（离线零网络） ----------

def test_fr4ac1_harvest_full_document_synthetic(tmp_path):
    """全页收割：3 PH（层号升序先行）+5 PK 全下载；切片数==页表页数；swf_raw==head+body。"""
    cfg, routes = _synth_world()
    rec = _BytesRecorder(routes)
    result = harvest_ebt_assets(cfg, store=Store(str(tmp_path / "store")), fetch=rec)
    assert isinstance(result, EbtHarvest)
    assert [a.kind for a in result.assets] == [PH_KIND] * 3 + [PK_KIND] * 5
    assert result.asset_files == 8 and result.downloads == 8 and result.cache_hits == 0
    assert len(result.pages) == len(cfg.pages) == cfg.p_pagecount   # 切片数==页表页数
    ph_of = {a.level: a for a in result.assets if a.kind == PH_KIND}
    for s in result.pages:
        assert isinstance(s, PageSlice)
        assert s.swf_raw == s.swf_head + s.swf_body                   # zlib×2 解压拼接
        assert s.head_stream_offset == PH_HEAD_LEN
        assert s.body_stream_offset == PK_HEAD_LEN
        assert s.head_signature == "swf"                              # FWS 假头被 sniff 认出
        assert s.swf_head == zlib.decompress(ph_of[s.level].data[PH_HEAD_LEN:])
        assert s.swf_body.startswith(b"body-L")
    l1 = [s for s in result.pages if s.level == 1]                    # 同层共享 PH 解压头
    assert l1[0].swf_head == l1[1].swf_head
    assert all(u.startswith("https://ebt999.doc88.com/getebt-") for u in rec.calls)


def test_fr4ac1_store_cache_reuse_and_progress_chunks(tmp_path):
    """R14 整文件字节缓存：miss→下载→put_asset（progress 分块自动落、bytes=盘上实测）；
    同库二次收割全命中零网络，切片产物逐字节一致。"""
    cfg, routes = _synth_world()
    store = Store(str(tmp_path / "store"))
    rec = _BytesRecorder(routes)
    first = harvest_ebt_assets(cfg, store=store, fetch=rec, page_nos=[1, 2])
    assert len(rec.calls) == 3                                        # PH L1 + PK1 + PK2
    prog_path = tmp_path / "store" / "progress" / f"{cfg.p_code}.json"
    prog = json.loads(prog_path.read_text(encoding="utf-8"))
    assert len(prog["chunks"]) == 3
    for a in first.assets:
        assert prog["chunks"][a.name]["bytes"] == len(a.data)         # 零造假：实测字节数
    rec2 = _BytesRecorder(routes)
    second = harvest_ebt_assets(cfg, store=store, fetch=rec2, page_nos=[1, 2])
    assert rec2.calls == []                                           # 全命中零网络
    assert second.cache_hits == 3 and second.downloads == 0
    assert second.pages == first.pages                                # 切片产物一致
    assert prog["chunks"] == json.loads(prog_path.read_text(encoding="utf-8"))["chunks"]


def test_fr4ac1_bad_assets_rejected_and_not_cached(tmp_path):
    """判件门（R16 只认字节）：HTTP 非 200/长度≠配置口径/PH 魔数坏/PK zlib 坏——
    一律 Doc88AssetError 且坏字节不落缓存（Store 空检索）。"""
    cfg, routes = _synth_world((1,))

    def expect_error(store_dir, routes_override, match):
        store = Store(str(tmp_path / store_dir))
        with pytest.raises(Doc88AssetError, match=match):
            harvest_ebt_assets(cfg, store=store, fetch=_BytesRecorder(routes_override),
                               page_nos=[1])
        return store

    ph_url = _ph_url_of(cfg, 1)
    bad_magic = dict(routes)
    bad_magic[ph_url] = b"XXXX" + routes[ph_url][4:]                  # ① PH 魔数非 YBD\x01
    expect_error("s1", bad_magic, "魔数")

    bad_len = dict(routes)                                            # ② 长度≠配置口径
    bad_len[ph_url] = routes[ph_url][:10]
    expect_error("s2", bad_len, "≠ 配置口径")

    pk_url = ebt_asset_url(cfg.p_ebthost,
                           pk_asset_name(cfg.pages[0], cfg.p_swf, 1, cfg.p_code))
    pk_len = len(routes[pk_url])

    def _pad_to(data, size):  # 坏件保持原长（长度门先于 zlib 门，短件测不到目标路径）
        return data + b"\x00" * (size - len(data))

    bad_zlib = dict(routes)                                           # ③ PK zlib 坏/断流
    bad_zlib[pk_url] = _pad_to(bytes(range(32)) + b"\x78\x9c" + b"\x00garbage", pk_len)
    expect_error("s3", bad_zlib, "zlib")
    bad_trunc = dict(routes)
    bad_trunc[pk_url] = _pad_to(bytes(range(32)) + zlib.compress(b"y" * 100)[:8], pk_len)
    expect_error("s4", bad_trunc, "zlib")

    no_route = {u: v for u, v in routes.items() if u != pk_url}       # ④ HTTP 404
    store = expect_error("s5", no_route, "HTTP 404")

    ph_name = ph_asset_name(1, cfg.header_sizes[0], cfg.p_swf)
    pk_name = pk_asset_name(cfg.pages[0], cfg.p_swf, 1, cfg.p_code)
    for s, bad_key in (("s1", ph_name), ("s2", ph_name), ("s3", pk_name),
                       ("s4", pk_name), ("s5", pk_name)):             # 坏字节不进库
        assert Store(str(tmp_path / s)).get_asset(bad_key) is None
    assert store.get_asset(ph_name) is not None                       # ④：好 PH 先成功已落库（如实）


def test_fr4ac1_subset_pages_and_extra_ph_levels(tmp_path):
    """子集纪律：page_nos=[3]（L2 首页）只下 PH L2+PK3；ph_levels=[1] 附加层头；
    越界/重复页号、越界层号如实拒。"""
    cfg, routes = _synth_world()
    rec = _BytesRecorder(routes)
    result = harvest_ebt_assets(cfg, store=Store(str(tmp_path / "s")), fetch=rec,
                                page_nos=[3], ph_levels=[1])
    assert len(rec.calls) == 3
    assert [a.kind for a in result.assets] == [PH_KIND, PH_KIND, PK_KIND]
    assert [a.level for a in result.assets if a.kind == PH_KIND] == [1, 2]
    assert len(result.pages) == 1 and result.pages[0].page_no == 3
    assert result.pages[0].level == 2
    for kwargs, match in ((dict(page_nos=[0]), "页号越界"), (dict(page_nos=[6]), "页号越界"),
                          (dict(page_nos=[1, 1]), "重复页号"),
                          (dict(page_nos=[1], ph_levels=[4]), "层号越界"),
                          (dict(page_nos=[], ph_levels=[]), "空收割清单")):
        with pytest.raises(Doc88AssetError, match=match):
            harvest_ebt_assets(cfg, store=Store(str(tmp_path / "s")), fetch=rec, **kwargs)


def test_fr4ac1_ph_only_probe_mode(tmp_path):
    """「先 1 层试跑」模式：page_nos 空+ph_levels=[2] 只采单层头，零切片。"""
    cfg, routes = _synth_world()
    rec = _BytesRecorder(routes)
    result = harvest_ebt_assets(cfg, store=Store(str(tmp_path / "s")), fetch=rec,
                                page_nos=[], ph_levels=[2])
    assert len(rec.calls) == 1
    assert result.assets[0].kind == PH_KIND and result.assets[0].level == 2
    assert result.pages == () and sniff_format(result.assets[0].data) == "ebt_ph"


# ---------- 实弹（真实网络 zero-mock；KB_HARVEST_SKIP_LIVE=1 跳过；预算 ≤6 资产文件） ----------

_LIVE_REASON = "KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（真实网络未跑，公约第4条）"


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason=_LIVE_REASON)
def test_fr4ac1_live_71page_single_layer(tmp_path):
    """FR4.AC1 实弹 A：93243737771803（71 页单层 2026 件，最简）PH L1+PK 第 1 页=2 资产文件。"""
    cfg = discover_config(NEW_P_CODE_A, fetch=_curl_cffi_get, timeout=30.0)
    assert cfg.p_code == NEW_P_CODE_A and cfg.p_pagecount == 71      # T24 活探固化口径
    assert len(cfg.pages) == 71 and len(cfg.header_sizes) == 1
    assert {p.level for p in cfg.pages} == {1}
    store = Store(str(tmp_path / "live_a"))
    result = harvest_ebt_assets(cfg, store=store, fetch=_curl_cffi_get_bytes,
                                timeout=30.0, page_nos=[1])
    assert len(result.assets) == 2 and result.downloads == 2 and result.cache_hits == 0
    ph, pk = result.assets
    assert ph.kind == PH_KIND and ph.data[:3] == EBT_PH_PREFIX       # YBD 前缀族（版本字节不钉死）
    assert len(ph.data) == cfg.header_sizes[0]                       # 整文件：长度==层头表
    assert pk.kind == PK_KIND and pk.page_no == 1
    assert len(result.pages) == 1
    s = result.pages[0]
    assert s.loc.offset == cfg.header_sizes[0]                       # 页偏移=层内偏移（L1 首页=层头）
    assert s.head_stream_offset == PH_HEAD_LEN and s.body_stream_offset == PK_HEAD_LEN
    assert s.head_signature == "swf" and len(s.swf_body) > 0         # 解压头=SWF 头、页体非空
    assert s.swf_raw == s.swf_head + s.swf_body
    # R14 复用：同库二次收割全命中零网络（缓存不增资产文件，不计预算）
    counting = _CountingFetch(_curl_cffi_get_bytes)
    second = harvest_ebt_assets(cfg, store=store, fetch=counting,
                                timeout=30.0, page_nos=[1])
    assert counting.calls == 0 and second.cache_hits == 2 and second.downloads == 0
    assert second.pages == result.pages


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason=_LIVE_REASON)
def test_fr4ac1_live_3layer_control_sha1_anchors(tmp_path):
    """FR4.AC1 实弹 B：69091550288（三层对照）PH L1（sha1 探针锚逐字节）+PK 第 1 页
    （sha1 锚）+PH L2+PK 第 51 页（L2 首页 offset==453032 live 复核）=4 资产文件。"""
    cfg = discover_config(SAMPLE_P_CODE, fetch=_curl_cffi_get, timeout=30.0)
    assert cfg.p_pagecount == 119
    assert cfg.header_sizes == (455235, 453032, 454972)              # T24 实证层头表
    store = Store(str(tmp_path / "live_b"))
    result = harvest_ebt_assets(cfg, store=store, fetch=_curl_cffi_get_bytes,
                                timeout=30.0, page_nos=[1, 51])
    assert len(result.assets) == 4 and result.downloads == 4         # PH L1+PH L2+PK1+PK51
    ph1 = next(a for a in result.assets if a.kind == PH_KIND and a.level == 1)
    ph2 = next(a for a in result.assets if a.kind == PH_KIND and a.level == 2)
    pk1 = next(a for a in result.assets if a.kind == PK_KIND and a.page_no == 1)
    pk51 = next(a for a in result.assets if a.kind == PK_KIND and a.page_no == 51)
    assert hashlib.sha1(ph1.data).hexdigest() == PH1_SHA1            # 与 _probe/ph1_head.bin 逐字节一致
    assert hashlib.sha1(pk1.data).hexdigest() == PK1_SHA1            # 与 _probe/pk1_head.bin 逐字节一致
    assert len(ph2.data) == 453032 and ph2.data[:3] == EBT_PH_PREFIX
    assert len(result.pages) == 2
    assert result.pages[0].loc == cfg.pages[0]
    assert result.pages[1].page_no == 51 and result.pages[1].level == 2
    assert result.pages[1].loc.offset == 453032 == cfg.header_sizes[1]   # T24 实证数字 live 复核
    for s in result.pages:
        assert s.head_signature == "swf" and len(s.swf_body) > 0
        assert s.swf_raw == s.swf_head + s.swf_body
