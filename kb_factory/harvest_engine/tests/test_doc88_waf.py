# -*- coding: utf-8 -*-
"""T36 单测：doc88 WAF 分支+镜像禁令（FR4.AC2/R20）+ 免费直下分支（FR4.AC3）+ 段4 verify 实装。

被测物 = kb_factory.harvest_engine.adapters.doc88 之 T36 增量件：
- ``MIRROR_DOMAIN_BLACKLIST``/``is_mirror_url``/``reject_mirror_url``/``Doc88MirrorBlocked``：
  R20 第三方镜像域黑名单**请求前**硬拒（FR4.AC2；piglin.eu.org=原工具作者自建镜像域，
  DOC88_SPEC §1.2/§3）。核心断言：**即便「配置了」镜像域（注入腿路由里摆着能答 200 的
  镜像域可用路 / curl_cffi 网络腿挂诱饵桩），镜像域 URL 也零 fetch**——网络腿被触碰即
  AssertionError 证伪；
- ``download_url``/``sniff_document_magic``/``fetch_free_download``：FR4.AC3 p_download==1
  免费直下分支（DOC88_SPEC §1.8 端点 ``doc.php?act=download&pcode=``）。fetch_ladder 接线
  三态：门开→先走下载接口（PDF 魔数短路成件，pypdfium2 实测页数/字数；非文档体=登录墙/
  404 如实挂账回退 ebt L1 主径）；门关（p_download 缺/≠1）→零触碰端点；
  ``free_probe`` 选通=XML 路缺 p_download 时补一发页面 JSON 路判定（默认关，请求预算纪律）；
- ``Doc88DownloadAdapter.verify`` 段4 桩实装（T32 下游2/下游3）：
  ``meta.extra["doc88_chain"]["manifest_path"]`` 直连 quality_gate 四门 CLI（main 退出码
  0=质检门全过）；``manifest_path=None``（纯图件 ref_chars=0 不落 manifest / 免费直下件
  无 FFDec 同源参照）判空路=字数门空真（ref=0）+①页/③水印/④完整性三门对产物实测，
  **内存 manifest 不落盘**（不伪造 schema 要求的 ref_chars≥1，数字零造假）。

实弹台账（2026-10-22，doc88 域 8 发全零登录：探针 6 发+本件实弹 2 发，逐发留档）：
- /list-1022.html 分类页前 3 件（60880707471842/60390909156220/93243737771803）页面路
  m_main JSON 实测 p_download 全="2"（付费件）；2011 件 69091550288 亦="2"（T24 密文留档）
  → **抽样总体（4 件）未寻得 p_download==1 免费件**；
- ``doc.php?act=download&pcode=60390909156220``（付费件）实测 **HTTP 404 空体**（nginx，
  无重定向无登录页）：非免费件端点直拒——fetch_free_download 如实 is_document=False；
- **免费直下接口的登录态需求未验证=挂账**（DOC88_SPEC §1.8 原口径；抽样无免费件无从
  实证）：分支三态由本件 fixture 覆盖（免费 PDF 短路/登录墙挂账回退/门关零触碰）；
- WAF 分支无法实弹强制触发（SPEC §3：2026-10-22 五连发未触发 WAF），离线注入覆盖。

测试纪律（WORKER_CONVENTIONS）：离线单测零网络（Fetch/BytesFetch 注入点喂确定性应答，
任务卡明示注入点；curl_cffi 诱饵桩=sys.modules 注入，触碰即 AssertionError）；实弹用例
（@pytest.mark.live）=真实网络 zero-mock，KB_HARVEST_SKIP_LIVE=1 时跳过并明示。
"""
import importlib.util
import json
import os
import sys
import types
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
        HarvestPlan, LadderResult, WALL_BLOCKED_MIRROR_POLICY, WALL_BLOCKED_WAF)
    from kb_factory.harvest_engine.adapters.doc88 import (
        DOC88_KEY1_NAME, DOC88_KEY2_NAME, Doc88ConfigError, Doc88DownloadAdapter,
        Doc88Error, Doc88WAFBlocked, MIRROR_DOMAIN_BLACKLIST, Doc88MirrorBlocked,
        P_CODE_RE, _curl_cffi_get, _curl_cffi_get_bytes, _leg_page,
        discover_config, download_url, fetch_ebt_asset, fetch_free_download,
        is_mirror_url, reject_mirror_url, sniff_document_magic)
    from kb_factory.harvest_engine.codec import variant_b64 as vb
    from kb_factory.harvest_engine.quality_gate import count_chars
    from kb_factory.harvest_engine.store.ledger import Store
except ImportError:  # pragma: no cover - worktree 阶段回退导入
    from channel_adapters.base import FileMeta
    from harvest_engine.adapters.base import (
        HarvestPlan, LadderResult, WALL_BLOCKED_MIRROR_POLICY, WALL_BLOCKED_WAF)
    from harvest_engine.adapters.doc88 import (
        DOC88_KEY1_NAME, DOC88_KEY2_NAME, Doc88ConfigError, Doc88DownloadAdapter,
        Doc88Error, Doc88WAFBlocked, MIRROR_DOMAIN_BLACKLIST, Doc88MirrorBlocked,
        P_CODE_RE, _curl_cffi_get, _curl_cffi_get_bytes, _leg_page,
        discover_config, download_url, fetch_ebt_asset, fetch_free_download,
        is_mirror_url, reject_mirror_url, sniff_document_magic)
    from harvest_engine.codec import variant_b64 as vb
    from harvest_engine.quality_gate import count_chars
    from harvest_engine.store.ledger import Store

import pypdfium2 as pdfium

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"
_LIVE_REASON = "KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（真实网络未跑，公约第4条）"

WAF_BODY = "<html><body>网络环境安全验证，请稍后再试。</body></html>"
MIRROR_HOST = "doc88.piglin.eu.org"          # R20 黑名单域的作者镜像子域（SPEC §1.2）
FREE_P_CODE = "123456"                       # 离线世界 p_code（与 _swf_world 同源）


def _load_sibling(name: str):
    """载入兄弟测试模块复用其确定性构造件（只 exec 不收集；T32 载 T24 同手法）。"""
    p = Path(__file__).resolve().parent / name
    spec = importlib.util.spec_from_file_location("_t36_" + name.replace(".py", ""), p)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


_swf = _load_sibling("test_doc88_swf.py")     # _swf_world/_world_info_xml/工具链就绪位
_qgt = _load_sibling("test_quality_gate.py")  # _build_minimal_pdf 确定性文字层 PDF 生成器
_CHAIN_READY = _swf._CHAIN_READY
_SKIP_CHAIN = _swf._SKIP_CHAIN


class _Recorder:
    """确定性文本网络注入件（Fetch 注入点）：URL 前缀→(status, body)；记录全部请求。"""

    def __init__(self, routes, default=(404, "")):
        self.routes = routes
        self.default = default
        self.urls = []

    def __call__(self, url, timeout):
        self.urls.append(url)
        for prefix, resp in self.routes.items():
            if url.startswith(prefix):
                return resp
        return self.default


class _BytesRecorder:
    """确定性二进制网络注入件（BytesFetch 注入点）：完整 URL→bytes（应答恒 200）或
    (status, bytes) 元组；未登记 URL→(404, 空体)；记录全部请求。"""

    def __init__(self, routes):
        self.routes = dict(routes)
        self.calls = []

    def __call__(self, url, timeout):
        self.calls.append(url)
        if url in self.routes:
            v = self.routes[url]
            return v if isinstance(v, tuple) else (200, v)
        return 404, b""


def _text_pdf(path: Path, pages: int = 3) -> Path:
    """确定性文字层 PDF（真符号复用 test_quality_gate 生成器；ASCII Helvetica 文字层）。"""
    return _qgt._build_minimal_pdf(
        path, [["T36 DOC88 WAF FREE DOWNLOAD SAMPLE PAGE %02d LINE ONE" % i,
                "HARVEST ENGINE T36 DETERMINISTIC FIXTURE LINE TWO"] for i in range(1, pages + 1)])


def _world_xml(p_download: str | None = "1", p_code: str = FREE_P_CODE,
               pages: int = 3, ebthost: str = "https://ebt999.doc88.com") -> str:
    """T36 离线世界 info XML（p_download 可选注入=免费直下门输入；ebthost 可投毒）。"""
    page_rows = "".join(
        '<p n="%d"><e>1</e><w>595</w><h>841</h><p>%d</p><l>100</l></p>' % (i, 1000 + i * 100)
        for i in range(1, pages + 1))
    dl = ('<p_download><![CDATA[%s]]></p_download>' % p_download) if p_download is not None else ""
    return ('<?xml version="1.0" encoding="UTF-8"?><doc>'
            f'<p_code><![CDATA[{p_code}]]></p_code><p_name><![CDATA[T36 离线件]]></p_name>'
            f'<p_pagecount><![CDATA[{pages}]]></p_pagecount><p_swf><![CDATA[63-t36]]></p_swf>'
            f'<p_ebthost><![CDATA[{ebthost}]]></p_ebthost><p_404><![CDATA[0]]></p_404>{dl}'
            f'<p_struct><h n="1">1000</h>{page_rows}</p_struct></doc>')


def _mmain_payload(p_download: str = "1", pages: int = 3) -> dict:
    """最小 m_main JSON 载荷（free_probe 路输入；pageInfo=key1 内层二段编码）。"""
    info = ",".join("1-595-841-%d-100" % (1000 + i * 100) for i in range(1, pages + 1))
    return {"p_code": FREE_P_CODE, "p_name": "T36 探针件", "p_pagecount": pages,
            "ebt_host": "https://ebt999.doc88.com", "p_swf": "63-t36",
            "p_download": p_download, "headerInfo": '"1000"',
            "pageInfo": vb.encode(DOC88_KEY1_NAME, info)}


def _adapter(tmp_path, txt, binr, **kwargs) -> Doc88DownloadAdapter:
    return Doc88DownloadAdapter(fetch=txt, fetch_bytes=binr,
                                store=Store(str(tmp_path / "store")),
                                work_dir=str(tmp_path / "work"), **kwargs)


def _meta(p_code: str = FREE_P_CODE) -> FileMeta:
    meta = FileMeta(title="T36 件", fmt="pdf")
    meta.extra["p_code"] = p_code
    return meta


# ================================ FR4.AC2：WAF 分支 + 镜像域黑名单硬拒（R20） ================================

def test_fr4ac2_mirror_blacklist_hard_reject():
    """黑名单域及其任意子域 → Doc88MirrorBlocked（wall_status=blocked_mirror_policy）；
    官方域/无关域/前缀撞名域不误伤（纯解析零网络）。"""
    assert MIRROR_DOMAIN_BLACKLIST == frozenset({"piglin.eu.org"})   # R20 黑名单现值锚
    for url in (f"https://{MIRROR_HOST}/p-69091550288.html",
                "https://piglin.eu.org/p-123456.html",
                "https://edge.piglin.eu.org/getebt-x.ebt",
                "http://deep.sub.piglin.eu.org/a.ebt"):
        assert is_mirror_url(url), url
        with pytest.raises(Doc88MirrorBlocked, match="R20") as ei:
            reject_mirror_url(url)
        assert ei.value.wall_status == WALL_BLOCKED_MIRROR_POLICY   # NFR1 标记位词表
        assert isinstance(ei.value, Doc88Error)
    for url in ("https://www.doc88.com/doc.php?act=info&p_code=1",
                "https://ebt143.doc88.com/getebt-x.ebt",
                "https://www.baidu.com/p-123456.html",
                "https://notpiglin.eu.org/p-123456.html",           # 前缀撞名非子域
                "", "not-a-url"):
        assert not is_mirror_url(url), url
        reject_mirror_url(url)                                      # 不抛


def test_fr4ac2_mirror_configured_never_fetched_network_legs(monkeypatch):
    """即便网络腿「配置」了镜像域（curl_cffi 挂诱饵桩）→ 双默认腿请求前硬拒零触碰。"""
    calls = []

    def _booby_get(url, **kw):
        calls.append(url)
        raise AssertionError(f"网络腿被触碰（镜像域禁令破约）：{url}")

    fake = types.ModuleType("curl_cffi")
    fake.requests = types.SimpleNamespace(get=_booby_get)
    monkeypatch.setitem(sys.modules, "curl_cffi", fake)
    for url in (f"https://{MIRROR_HOST}/p-123456.html",
                "https://edge.piglin.eu.org/getebt-x.ebt",
                "http://piglin.eu.org/doc.php?act=download&pcode=123456"):
        with pytest.raises(Doc88MirrorBlocked, match="R20"):
            _curl_cffi_get(url, 5.0)          # 文本腿（discover 双路默认腿）
        with pytest.raises(Doc88MirrorBlocked, match="R20"):
            _curl_cffi_get_bytes(url, 5.0)    # 二进制腿（ebt/免费直下默认腿）
    assert calls == []                         # 镜像域 URL 零 fetch（诱饵桩未被触碰）


def test_fr4ac2_mirror_configured_never_fetched_ebt_asset(tmp_path):
    """ebthost 被投毒指向镜像域（配置面假设）→ fetch_ebt_asset 请求前硬拒，注入腿零调用。"""
    from dataclasses import replace
    cfg, routes, _ = _swf._swf_world(1)
    poisoned = replace(cfg, p_ebthost=f"https://{MIRROR_HOST}")
    binr = _BytesRecorder(routes)               # 真资产路由在位（若被触碰即 200 应答）
    with pytest.raises(Doc88MirrorBlocked, match="R20") as ei:
        fetch_ebt_asset(name="whatever", url=f"https://{MIRROR_HOST}/getebt-x.ebt",
                        kind="ph", level=1, expected_bytes=10, p_code=cfg.p_code,
                        store=Store(str(tmp_path / "s")), fetch=binr)
    assert ei.value.wall_status == WALL_BLOCKED_MIRROR_POLICY
    assert binr.calls == []                     # 镜像域零 fetch（缓存查询前即拒）


def test_fr4ac2_waf_both_legs_never_mirror_fallback():
    """FR4.AC2 主断言：双路命中「网络环境安全验证」→ blocked_waf 硬拒；**镜像域路由
    在位能答 200（=「配置了镜像域」）也不被 fetch**——全程仅 www.doc88.com 两发。"""
    mirror_ok_html = ('<script>m_main.init("%s");</script>'
                      % vb.encode(DOC88_KEY1_NAME, json.dumps(_mmain_payload())))  # 能答的诱饵
    fetch = _Recorder({
        "https://www.doc88.com/doc.php?act=info": (200, WAF_BODY),
        "https://www.doc88.com/p-": (200, WAF_BODY),
        "https://piglin.eu.org/": (200, mirror_ok_html),          # 镜像域「配置」在位
        f"https://{MIRROR_HOST}/": (200, mirror_ok_html)})
    with pytest.raises(Doc88WAFBlocked, match="blocked_waf") as ei:
        discover_config(FREE_P_CODE, fetch=fetch)
    assert ei.value.wall_status == WALL_BLOCKED_WAF
    assert fetch.urls == ["https://www.doc88.com/doc.php?act=info&p_code=" + FREE_P_CODE,
                          "https://www.doc88.com/p-" + FREE_P_CODE + ".html"]
    assert not any("piglin" in u for u in fetch.urls)             # R20：零第三方镜像请求


def test_fr4ac2_fetch_ladder_waf_maps_blocked_waf(tmp_path):
    """段3 映射：WAF 双中 → ok=False + wall_status=blocked_waf + NFR1 标记位落 meta。"""
    adapter = _adapter(tmp_path, _Recorder({"https://www.doc88.com/": (200, WAF_BODY)}),
                       _BytesRecorder({}))
    meta = FileMeta(title="被墙件", fmt="pdf",
                    source_url=f"https://www.doc88.com/p-{FREE_P_CODE}.html")
    result = adapter.fetch_ladder(HarvestPlan(meta=meta))
    assert isinstance(result, LadderResult)
    assert result.ok is False and result.wall_status == WALL_BLOCKED_WAF
    assert meta.extra["wall_status"] == WALL_BLOCKED_WAF


def test_fr4ac2_fetch_ladder_mirror_maps_blocked_mirror_policy(tmp_path):
    """段3 映射：镜像域硬拒（ebthost 投毒）→ ok=False + wall_status=blocked_mirror_policy
    + NFR1 标记位落 meta（任务卡 brief：两标记均落 FileMeta.extra.wall_status）。"""
    xml = _world_xml(ebthost=f"https://{MIRROR_HOST}")            # 配置面投毒假设
    adapter = _adapter(tmp_path,
                       _Recorder({"https://www.doc88.com/doc.php?act=info":
                                  (200, vb.encode(DOC88_KEY2_NAME, xml))}),
                       _BytesRecorder({}))
    meta = _meta()
    result = adapter.fetch_ladder(HarvestPlan(meta=meta))
    assert result.ok is False
    assert result.wall_status == WALL_BLOCKED_MIRROR_POLICY
    assert meta.extra["wall_status"] == WALL_BLOCKED_MIRROR_POLICY
    assert "R20" in result.detail or "镜像" in result.detail


# ================================ FR4.AC3：p_download=1 免费直下分支（§1.8） ================================

def test_fr4ac3_download_url_builder_and_sniff_magic():
    """§1.8 端点形态 + pcode 参数 p_code 回提；文档魔数表（R16 只认字节）。"""
    assert download_url(FREE_P_CODE) == \
        f"https://www.doc88.com/doc.php?act=download&pcode={FREE_P_CODE}"
    assert P_CODE_RE.match(FREE_P_CODE)
    from kb_factory.harvest_engine.adapters.doc88 import extract_p_code
    assert extract_p_code(download_url(FREE_P_CODE)) == FREE_P_CODE   # doc.php pcode 回提
    assert sniff_document_magic(b"%PDF-1.7\n...") == "pdf"
    assert sniff_document_magic(b"PK\x03\x04 rest") == "ooxml"        # docx/pptx/xlsx 同头
    assert sniff_document_magic(b"\xd0\xcf\x11\xe0\xa1\xb1\x1a\xe1rest") == "ole"  # doc/ppt 老格式
    assert sniff_document_magic(b"<html>login</html>") is None        # 登录墙=非文档体
    assert sniff_document_magic(b"") is None


def test_fr4ac3_free_branch_pdf_short_circuit(tmp_path):
    """门开（p_download=1）+端点答 PDF 魔数 → 短路成件：只打下载端点零 ebt 请求，
    页数/字数 pypdfium2 实测；extra 落分支事实；verify 判空路四门闭环。"""
    pdf = _text_pdf(tmp_path / "free.pdf", 3)
    dl_url = download_url(FREE_P_CODE)
    txt = _Recorder({"https://www.doc88.com/doc.php?act=info":
                     (200, vb.encode(DOC88_KEY2_NAME, _world_xml(p_download="1")))})
    binr = _BytesRecorder({dl_url: pdf.read_bytes()})
    adapter = _adapter(tmp_path, txt, binr)
    meta = _meta()
    result = adapter.fetch_ladder(HarvestPlan(meta=meta))
    assert result.ok and result.ladder_used == "L1"
    assert Path(result.artifact_path).is_file()
    doc = pdfium.PdfDocument(result.artifact_path)
    try:
        assert len(doc) == 3                                        # 独立复核实测页数
    finally:
        doc.close()
    assert result.pages == 3 and result.chars and result.chars > 0
    assert result.coverage == "3/3"
    assert binr.calls == [dl_url]                                   # 只打下载端点，零 ebt 资产
    free = meta.extra["doc88_free_download"]
    assert free["http_status"] == 200 and free["fmt"] == "pdf"
    assert free["is_document"] and free["bytes"] == pdf.stat().st_size
    chain = meta.extra["doc88_chain"]
    assert chain["source"] == "free_download"
    assert chain["manifest_path"] is None and chain["ref_chars"] == 0   # 无 FFDec 参照（如实）
    assert adapter.verify(result) is True                            # 判空路：字数门空真+三门实测
    assert "manifest_path=None 判空" in adapter.last_verify_detail


def test_fr4ac3_free_branch_login_wall_falls_back(tmp_path):
    """门开+端点答登录墙 HTML（挂账形态）→ is_document=False 如实挂账 → 回退 ebt L1
    （离线世界资产缺 → ok=False，分支先走下载端点的事实留 extra）。"""
    dl_url = download_url(FREE_P_CODE)
    txt = _Recorder({"https://www.doc88.com/doc.php?act=info":
                     (200, vb.encode(DOC88_KEY2_NAME, _world_xml(p_download="1")))})
    binr = _BytesRecorder({dl_url: "<html>请登录后下载</html>".encode("utf-8")})
    adapter = _adapter(tmp_path, txt, binr)
    meta = _meta()
    result = adapter.fetch_ladder(HarvestPlan(meta=meta))
    assert result.ok is False and result.wall_status is None          # ebt 兜底亦折（资产 404）
    assert dl_url in binr.calls                                      # 分支确实先走了下载接口
    free = meta.extra["doc88_free_download"]
    assert free["is_document"] is False and free["fmt"] is None       # R16：HTML 非文档体
    assert "免费直下" in result.detail and "挂账" in result.detail


def test_fr4ac3_free_branch_paid_404_falls_back(tmp_path):
    """门开+端点 404（2026-10-22 付费件实测形态，nginx 空体）→ 同挂账回退路。"""
    dl_url = download_url(FREE_P_CODE)
    txt = _Recorder({"https://www.doc88.com/doc.php?act=info":
                     (200, vb.encode(DOC88_KEY2_NAME, _world_xml(p_download="1")))})
    binr = _BytesRecorder({})                                        # 下载端点亦 404
    adapter = _adapter(tmp_path, txt, binr)
    meta = _meta()
    result = adapter.fetch_ladder(HarvestPlan(meta=meta))
    assert result.ok is False
    assert dl_url in binr.calls
    assert meta.extra["doc88_free_download"]["http_status"] == 404
    assert meta.extra["doc88_free_download"]["is_document"] is False


def test_fr4ac3_gate_closed_never_hits_download_endpoint(tmp_path):
    """门关（XML 缺 p_download）→ 分支零触碰下载端点（零 act=download 请求）。"""
    txt = _Recorder({"https://www.doc88.com/doc.php?act=info":
                     (200, vb.encode(DOC88_KEY2_NAME, _world_xml(p_download=None)))})
    binr = _BytesRecorder({})
    adapter = _adapter(tmp_path, txt, binr)
    meta = _meta()
    result = adapter.fetch_ladder(HarvestPlan(meta=meta))
    assert result.ok is False                                        # ebt 资产缺（离线世界）
    assert binr.calls and all("/getebt-" in u for u in binr.calls)   # 只走资产路
    assert not any("act=download" in u for u in binr.calls)          # 下载端点零触碰
    assert "doc88_free_download" not in meta.extra


def test_fr4ac3_free_probe_fills_p_download(tmp_path):
    """free_probe=True：XML 路缺 p_download → 补一发页面 JSON 路判定（§1.3 两法等价）→
    门开走下载接口；默认关=零页面请求（预算纪律）。"""
    pdf = _text_pdf(tmp_path / "probe.pdf", 3)
    page_html = ('<script>m_main.init("%s");</script>'
                 % vb.encode(DOC88_KEY1_NAME, json.dumps(_mmain_payload(p_download="1"))))
    dl_url = download_url(FREE_P_CODE)
    txt = _Recorder({
        "https://www.doc88.com/doc.php?act=info":
            (200, vb.encode(DOC88_KEY2_NAME, _world_xml(p_download=None))),
        f"https://www.doc88.com/p-{FREE_P_CODE}": (200, page_html)})
    binr = _BytesRecorder({dl_url: pdf.read_bytes()})
    adapter = _adapter(tmp_path, txt, binr, free_probe=True)
    meta = _meta()
    result = adapter.fetch_ladder(HarvestPlan(meta=meta))
    assert result.ok and Path(result.artifact_path).is_file()
    assert meta.extra["doc88_config"]["source"] == "page_m_main"      # 探针采纳 JSON 路配置
    assert f"https://www.doc88.com/p-{FREE_P_CODE}.html" in txt.urls
    assert binr.calls == [dl_url]
    # 默认关（预算纪律）：同一世界只打 info，门关不探页面
    txt2 = _Recorder({
        "https://www.doc88.com/doc.php?act=info":
            (200, vb.encode(DOC88_KEY2_NAME, _world_xml(p_download=None)))})
    adapter2 = _adapter(tmp_path / "d2", txt2, _BytesRecorder({}))
    meta2 = _meta()
    result2 = adapter2.fetch_ladder(HarvestPlan(meta=meta2))
    assert result2.ok is False                                       # ebt 资产缺
    assert txt2.urls == [f"https://www.doc88.com/doc.php?act=info&p_code={FREE_P_CODE}"]
    assert "doc88_free_download" not in meta2.extra


@pytest.mark.skipif(not _CHAIN_READY, reason=_SKIP_CHAIN)
def test_fr4ac3_free_branch_fallback_full_chain(tmp_path):
    """门开+登录墙 → 挂账回退 ebt L1 全链成件（FR4.AC1 主径不受分支影响）。"""
    cfg, routes, _ = _swf._swf_world(2, frame_count=0)
    xml = _swf._world_info_xml(cfg).replace(
        "</doc>", '<p_download><![CDATA[1]]></p_download></doc>')
    dl_url = download_url(cfg.p_code)
    routes2 = dict(routes)
    routes2[dl_url] = b"<html>login</html>"                          # 登录墙（挂账形态）
    txt = _Recorder({"https://www.doc88.com/doc.php?act=info":
                     (200, vb.encode(DOC88_KEY2_NAME, xml))})
    adapter = _adapter(tmp_path, txt, _BytesRecorder(routes2))
    meta = _meta(cfg.p_code)
    result = adapter.fetch_ladder(HarvestPlan(meta=meta))
    assert result.ok and result.ladder_used == "L1"
    assert result.pages == 2 and Path(result.artifact_path).is_file()
    assert "免费直下" in result.detail and "折" in result.detail       # 分支折如实入账
    assert meta.extra["doc88_free_download"]["is_document"] is False


# ================================ 段4 verify 实装（T32 下游2/下游3） ================================

def _verify_world(tmp_path, *, with_manifest: bool, pdf_pages: int = 3,
                  expected_pages: int | None = None, blank: bool = False):
    """verify 离线世界：文字层/空白 PDF + meta（doc88_config.p_pagecount + doc88_chain）。

    manifest 路参照值全实测（ref_chars=count_chars 现算，数字零造假）。
    """
    adapter = Doc88DownloadAdapter(fetch=_Recorder({}), fetch_bytes=_BytesRecorder({}))
    lines = [None] * pdf_pages if blank else None
    if lines is None:
        lines = [["T36 VERIFY SAMPLE PAGE %02d LINE ONE" % i,
                  "T36 VERIFY SAMPLE PAGE %02d LINE TWO" % i] for i in range(1, pdf_pages + 1)]
    pdf = _qgt._build_minimal_pdf(tmp_path / "v.pdf", lines)
    doc = pdfium.PdfDocument(str(pdf))
    try:
        measured = count_chars(doc)
    finally:
        doc.close()
    expected = expected_pages if expected_pages is not None else pdf_pages
    meta = FileMeta(title="verify 件", fmt="pdf")
    meta.extra["doc88_config"] = {"p_pagecount": expected}
    if with_manifest:
        mpath = tmp_path / "manifest.json"
        mpath.write_text(json.dumps({
            "pdf_path": pdf.name, "expected_pages": expected,
            "ref_chars": measured, "ref_chars_source": "doc88"},
            ensure_ascii=False, indent=1), encoding="utf-8")
        meta.extra["doc88_chain"] = {"manifest_path": str(mpath), "pages": pdf_pages}
    else:
        meta.extra["doc88_chain"] = {"manifest_path": None, "pages": pdf_pages}
    adapter.last_meta = meta
    return adapter, pdf, measured


def _result(pdf: Path, pages: int, chars: int) -> LadderResult:
    return LadderResult(ok=True, ladder_used="L1", artifact_path=str(pdf),
                        pages=pages, chars=chars, coverage=f"{pages}/{pages}")


def test_fr4ac1_verify_manifest_path_runs_four_gate_cli(tmp_path):
    """T32 下游2：manifest_path 直连 quality_gate 四门 CLI——好件退出码 0→True；
    页参照不符→False；manifest 文件缺→False。"""
    adapter, pdf, measured = _verify_world(tmp_path, with_manifest=True)
    assert adapter.verify(_result(pdf, 3, measured)) is True
    assert "退出码 0" in adapter.last_verify_detail
    # 页数参照不符（expected=5）：门①不过 → CLI 退出码 1 → False
    adapter2, pdf2, measured2 = _verify_world(tmp_path / "b", with_manifest=True,
                                              expected_pages=5)
    assert adapter2.verify(_result(pdf2, 3, measured2)) is False
    assert "退出码 1" in adapter2.last_verify_detail
    # manifest 文件被移走：CLI 判不合格 → False
    (tmp_path / "manifest.json").unlink()
    assert adapter.verify(_result(pdf, 3, measured)) is False


def test_fr4ac1_verify_manifest_none_pure_image(tmp_path):
    """T32 下游3：manifest_path=None 判空路——纯图件字数门空真（ref=0），页/水印/
    完整性三门实测：好件 True；空白页件（ink=0 越下带）False；坏字节件 False。"""
    adapter, pdf, _ = _verify_world(tmp_path, with_manifest=False)
    assert adapter.verify(_result(pdf, 3, 0)) is True                 # 判空路四门（字数空真）
    assert "判空" in adapter.last_verify_detail
    blank_adapter, blank_pdf, _ = _verify_world(tmp_path / "blank",
                                                with_manifest=False, blank=True)
    assert blank_adapter.verify(_result(blank_pdf, 3, 0)) is False    # 水印门拦整页空白
    corrupt = tmp_path / "corrupt.pdf"
    corrupt.write_bytes(b"NOT-A-PDF-AT-ALL")
    assert adapter.verify(_result(corrupt, 3, 0)) is False            # 门④不可解析


def test_fr4ac1_verify_degraded_and_fast_fail(tmp_path):
    """ok=False/无产物 → 快失败 False；meta 缺位（独立调用）→ result.pages 降级参照。"""
    adapter, pdf, measured = _verify_world(tmp_path, with_manifest=True)
    assert adapter.verify(LadderResult(ok=False)) is False
    assert adapter.verify(LadderResult(ok=True)) is False             # artifact_path 缺
    standalone = Doc88DownloadAdapter(fetch=_Recorder({}), fetch_bytes=_BytesRecorder({}))
    assert standalone.verify(_result(pdf, 3, measured)) is True       # 降级路：自洽参照
    assert standalone.verify(_result(pdf, 4, measured)) is False      # 页数不符即红


# ================================ 实弹（真实网络 zero-mock；KB_HARVEST_SKIP_LIVE=1 跳过） ================================

LIVE_PAID_P_CODE = "60390909156220"   # /list-1022.html 分类页取样（T24 手法）；
# 2026-10-22 实测：56 页 PPTX，页面路 m_main p_download="2"（付费件）


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason=_LIVE_REASON)
def test_fr4ac3_live_gate_input_and_download_endpoint():
    """FR4.AC3 实弹（2 发零登录）：①页面路实测 p_download（门输入真值，漂移即红）；
    ②下载端点对付费件实测 HTTP 404 空体 → fetch_free_download 如实 is_document=False。
    免费件（p_download==1）抽样总体未寻得（docstring 台账）→ 登录态需求挂账（§1.8）。"""
    cfg, reason, waf = _leg_page(LIVE_PAID_P_CODE, _curl_cffi_get, 30.0)
    assert cfg is not None and not waf, reason
    assert cfg.p_download == "2"                                     # 实测门输入（付费件）
    assert cfg.is_free_download is False                             # 门关：不触碰下载端点
    attempt = fetch_free_download(LIVE_PAID_P_CODE, timeout=30.0)
    assert attempt.url == download_url(LIVE_PAID_P_CODE)
    assert attempt.http_status == 404                                # 2026-10-22 实测：付费件端点 404 空体
    assert attempt.is_document is False and attempt.fmt is None
    assert attempt.data == b""
    print(f"[live] {attempt.url} → HTTP {attempt.http_status} {len(attempt.data)}B "
          f"fmt={attempt.fmt!r}（付费件直拒；免费件登录态挂账 DOC88_SPEC §1.8）")
