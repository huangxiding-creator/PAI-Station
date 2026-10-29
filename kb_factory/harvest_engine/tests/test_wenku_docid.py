# -*- coding: utf-8 -*-
"""T18 单测：wenku 适配器地基——URL 规范化 + docId 提取 + search 段挂 WenkuMetaAdapter。

被测物 = kb_factory.harvest_engine.adapters.wenku（FR2.1/FR2.AC1：当输入为 wenku URL
或 docId 时解析出 docId 并复用 WenkuMetaAdapter 检索；实弹 1 词→≥10 条 FileMeta）。

现场校准记录（2026-10-22 实测；WENKU_SPEC §2 置信 medium → 本日实证钉死）：
- syncmrecall 检索「水利施工组织设计」12/12 条 source_url 全部形如
  https://wenku.baidu.com/view/{docId}.html?fr=incomeN-doc-search，docId 全部为
  40 位 hex（SPEC §2「20~28 位 base62」为老式形态，新旧并存——提取正则取宽域
  [0-9A-Za-z_-]{16,64} 兼容两者）；
- ndview/{docId}.html 实测 HTTP 200 且含 var pageData（view 的有效别名端点，
  不重定向，docId 直接在路径上）；
- wapwenku.baidu.com/view/{docId}.html 实测 301 跳 wenku 首页（桌面 UA）/ 两跳
  wk.baidu.com?pcf=2（移动 UA），docId 在重定向后丢失 → docId 必须从原始路径
  纯解析直取，重定向跟随仅兜「路径无 id 的跳转壳」；
- view 页纯 httpx 直连 403（即使带全 Sec-Ch-Ua 头，WAF 指纹墙）——view 页抓取属
  T22（readerInfo），本任务零 view 页抓取。

测试纪律（WORKER_CONVENTIONS）：
- 离线单测零网络：重定向兜底经 fetch 注入点喂确定性跳链（网络注入点，任务卡明示）；
  search 委派用 wenku_meta 自留的 _fetch monkeypatch 注入点（网络腿注入）。
- 实弹用例（@pytest.mark.live）= 真实网络 zero-mock；KB_HARVEST_SKIP_LIVE=1 时跳过。
"""
import os
import sys
import urllib.parse
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
    from kb_factory.channel_adapters import wenku_meta
    from kb_factory.channel_adapters.base import FileMeta, RateLimiter
    from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter
    from kb_factory.harvest_engine.adapters.base import (FOUR_STAGES, DownloadAdapter,
                                                         HarvestPlan, LadderResult)
    from kb_factory.harvest_engine.adapters.wenku import (WenkuDownloadAdapter,
                                                          _httpx_redirect_chain,
                                                          canonical_view_url,
                                                          extract_doc_id,
                                                          normalize_wenku_url,
                                                          resolve_doc_id)
except ImportError:
    from channel_adapters import wenku_meta
    from channel_adapters.base import FileMeta, RateLimiter
    from channel_adapters.wenku_meta import WenkuMetaAdapter
    from harvest_engine.adapters.base import (FOUR_STAGES, DownloadAdapter,
                                              HarvestPlan, LadderResult)
    from harvest_engine.adapters.wenku import (WenkuDownloadAdapter,
                                               _httpx_redirect_chain,
                                               canonical_view_url,
                                               extract_doc_id,
                                               normalize_wenku_url,
                                               resolve_doc_id)

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"

# --- 校准实测真样本（2026-10-22 syncmrecall「水利施工组织设计」前 3 条，原文固化）---
REAL_ID_1 = "9c58877bceaedd3383c4bb4cf7ec4afe04a1b1a6"  # 40 位 hex（新式实测形态）
REAL_ID_2 = "6657e2beb84cf7ec4afe04a1b0717fd5360cb28e"
REAL_ID_3 = "d27531fe660e52ea551810a6f524ccbff021ca47"
REAL_URL_1 = f"https://wenku.baidu.com/view/{REAL_ID_1}.html?fr=income1-doc-search"
REAL_URL_2 = f"https://wenku.baidu.com/view/{REAL_ID_2}.html?fr=income2-doc-search"
REAL_URL_3 = f"https://wenku.baidu.com/view/{REAL_ID_3}.html?fr=income4-doc-search"

# 老式 base62 混排形态（SPEC §2：常见 20~28 位；任务卡点名覆盖，构造样本）
LEGACY_ID_20 = "12345678901234567890"          # 20 位纯数字
LEGACY_ID_24 = "Ab1-Zz_9yY8xx7Ww6Vv5Uu4"        # 24 位 base62 混排（含 - _）
LEGACY_ID_28 = "aB3xY9kQ2mNp7RsT5uVw1zC4"       # 28 位大小写数字混排

LIVE_QUERY = "水利施工组织设计"  # 校准日用词：syncmrecall 实测 12 条


# ---------------- 纯解析：extract_doc_id ----------------

def test_fr2_ac1_extract_view_regular_real_samples():
    """常规形态 view/{docId}.html（真实 source_url 样本，带 ?fr= 追踪参数）。"""
    for url, doc_id in ((REAL_URL_1, REAL_ID_1), (REAL_URL_2, REAL_ID_2), (REAL_URL_3, REAL_ID_3)):
        assert extract_doc_id(url) == doc_id


def test_fr2_ac1_extract_view_plain_no_query():
    assert extract_doc_id(f"https://wenku.baidu.com/view/{REAL_ID_1}.html") == REAL_ID_1
    assert extract_doc_id(f"http://wenku.baidu.com/view/{REAL_ID_1}.html") == REAL_ID_1


def test_fr2_ac1_extract_legacy_base62_20_to_28():
    """老式 docId：20~28 位 base62（含 - _）混排（SPEC §2，任务卡点名覆盖）。"""
    for doc_id in (LEGACY_ID_20, LEGACY_ID_24, LEGACY_ID_28):
        assert extract_doc_id(f"https://wenku.baidu.com/view/{doc_id}.html") == doc_id
        assert extract_doc_id(
            f"https://wapwenku.baidu.com/view/{doc_id}.html?fr=IncomeWapDoc") == doc_id


def test_fr2_ac1_extract_ndview_alias():
    """ndview/{docId}.html：view 的有效别名端点（实测 200+var pageData）。"""
    assert extract_doc_id(f"https://wenku.baidu.com/ndview/{REAL_ID_1}.html") == REAL_ID_1
    assert extract_doc_id(f"https://wenku.baidu.com/ndview/{REAL_ID_1}") == REAL_ID_1  # 无 .html 亦可


def test_fr2_ac1_extract_wapwenku_path_direct():
    """移动页 wapwenku：路径自带 docId → 纯解析直取（实测重定向会丢 id，直取是唯一稳路径）。"""
    url = f"https://wapwenku.baidu.com/view/{REAL_ID_2}.html?fr=income2-doc-search"
    assert extract_doc_id(url) == REAL_ID_2


def test_fr2_ac1_extract_query_url_param():
    """移动页 ?url= 跳转参数亦可解（SPEC §2）：内层 wenku view URL 解出 docId。"""
    inner = f"https://wapwenku.baidu.com/view/{REAL_ID_1}.html"
    shell = "https://wenku.baidu.com/search/url?wiseflowid=abc&url=" + urllib.parse.quote(inner)
    assert extract_doc_id(shell) == REAL_ID_1


def test_fr2_ac1_extract_bare_doc_id():
    """裸 docId 输入（新式 40 hex + 老式 base62）直接返回。"""
    assert extract_doc_id(REAL_ID_1) == REAL_ID_1
    assert extract_doc_id(LEGACY_ID_28) == LEGACY_ID_28


def test_fr2_ac1_extract_rejects_invalid():
    """非 wenku 域/短 id/超长/无关页 → 如实 None（不猜）。"""
    assert extract_doc_id(f"https://example.com/view/{REAL_ID_1}.html") is None   # 非 wenku 域
    assert extract_doc_id(f"https://tieba.baidu.com/view/{REAL_ID_1}.html") is None
    assert extract_doc_id("https://wenku.baidu.com/view/shortid123.html") is None  # 11 位 < 16
    assert extract_doc_id("https://wenku.baidu.com/view/" + "a" * 65 + ".html") is None  # > 64
    assert extract_doc_id("https://wenku.baidu.com/search?word=shigong") is None
    assert extract_doc_id("https://wenku.baidu.com/") is None
    assert extract_doc_id("") is None
    assert extract_doc_id("9c58") is None


# ---------------- URL 规范化：normalize_wenku_url ----------------

def test_fr2_ac1_normalize_strips_query_fr():
    """?fr= 等追踪参数剔除（真实样本：syncmrecall 12/12 条全带 ?fr=incomeN-doc-search）。"""
    assert normalize_wenku_url(REAL_URL_1) == f"https://wenku.baidu.com/view/{REAL_ID_1}.html"
    assert normalize_wenku_url(f"https://wenku.baidu.com/view/{REAL_ID_2}.html?fr=x&_=") == \
        f"https://wenku.baidu.com/view/{REAL_ID_2}.html"


def test_fr2_ac1_normalize_to_pc_canonical():
    """ndview/wapwenku/裸 id 全部归一 PC canonical view URL。"""
    canonical = f"https://wenku.baidu.com/view/{REAL_ID_1}.html"
    assert normalize_wenku_url(f"https://wenku.baidu.com/ndview/{REAL_ID_1}.html") == canonical
    assert normalize_wenku_url(
        f"https://wapwenku.baidu.com/view/{REAL_ID_1}.html?fr=IncomeWapDoc") == canonical
    assert normalize_wenku_url(REAL_ID_1) == canonical
    assert canonical_view_url(REAL_ID_1) == canonical


def test_fr2_ac1_normalize_none_on_invalid():
    assert normalize_wenku_url("https://example.com/view/whatever.html") is None
    assert normalize_wenku_url("not a wenku url at all") is None


# ---------------- 重定向兜底：resolve_doc_id ----------------

def test_fr2_ac1_resolve_redirect_fallback():
    """路径无 id 的跳转壳（如 /link?url=）→ 先跟随重定向再取（注入确定性跳链）。"""
    shell = "https://wenku.baidu.com/link?url=opaque-token"
    hops = [shell, f"https://wapwenku.baidu.com/view/{REAL_ID_1}.html?fr=x"]
    assert extract_doc_id(shell) is None  # 前提：壳路径确实无 id
    assert resolve_doc_id(shell, fetch=lambda url, timeout: hops) == REAL_ID_1


def test_fr2_ac1_resolve_network_error_returns_none():
    def boom(url, timeout):
        raise OSError("network down")
    assert resolve_doc_id("https://wenku.baidu.com/link?url=x", fetch=boom) is None


def test_fr2_ac1_resolve_path_hit_is_zero_network():
    """路径有 id（含 wapwenku）→ 纯解析直取，零网络调用（wapwenku 重定向丢 id 的实测对策）。"""
    calls = []

    def spy(url, timeout):
        calls.append(url)
        return []
    url = f"https://wapwenku.baidu.com/view/{REAL_ID_2}.html?fr=IncomeWapDoc"
    assert resolve_doc_id(url, fetch=spy) == REAL_ID_2
    assert calls == []


def test_fr2_ac1_resolve_no_id_in_chain_returns_none():
    shell = "https://wenku.baidu.com/link?url=opaque"
    assert resolve_doc_id(
        shell, fetch=lambda url, timeout: [shell, "https://wenku.baidu.com/"]) is None


# ---------------- WenkuDownloadAdapter 骨架契约 ----------------

def test_fr2_ac1_adapter_class_contract():
    """DownloadAdapter 子类注册 channel=wenku；四段契约：search 可用、后三段骨架留 T22/T26/T31/T35。"""
    adapter = WenkuDownloadAdapter(
        meta_adapter=WenkuMetaAdapter(limiter=RateLimiter(min_interval=0, daily_limit=10)))
    assert issubclass(WenkuDownloadAdapter, DownloadAdapter)
    assert adapter.site == "wenku" and adapter.channel == "wenku"
    assert FOUR_STAGES[0] == "search" and callable(adapter.search)
    meta = FileMeta(title="骨架样例", fmt="doc")
    with pytest.raises(NotImplementedError, match="T22"):
        adapter.plan(meta)
    with pytest.raises(NotImplementedError, match=r"T26/T31/T35"):
        adapter.fetch_ladder(HarvestPlan(meta=meta))
    with pytest.raises(NotImplementedError, match=r"T26/T31/T35"):
        adapter.verify(LadderResult(ok=True))


def test_fr2_ac1_search_delegates_and_enriches(monkeypatch):
    """段1 search 委派 WenkuMetaAdapter（syncmrecall）+ docId/canonical 对齐；source_url 原样保留。"""

    def fake_fetch(word, pn, timeout):  # 注入 wenku_meta 自留网络腿注入点（离线确定性）
        if pn > 1:
            return {"data": {"items": {"PCSearch": {"result": {"items": []}}}}}
        return {"data": {"items": {"PCSearch": {"result": {"items": [
            {"data": {"title": "离线样例施工组织设计", "fileType": 1, "pageNum": 30,
                      "sellType": 1, "url": REAL_URL_1, "docID": REAL_ID_1, "viewCount": 100}},
            {"data": {"title": "移动页样例", "fileType": 2, "pageNum": 8, "sellType": 2,
                      "url": f"https://wapwenku.baidu.com/view/{REAL_ID_2}.html?fr=IncomeWapDoc",
                      "docID": REAL_ID_2}},
        ]}}}}}

    monkeypatch.setattr(wenku_meta, "_fetch", fake_fetch)
    adapter = WenkuDownloadAdapter(
        meta_adapter=WenkuMetaAdapter(limiter=RateLimiter(min_interval=0, daily_limit=10)))
    metas = adapter.search("施工组织设计", 12)
    assert len(metas) == 2 and all(isinstance(m, FileMeta) for m in metas)
    m1, m2 = metas
    assert m1.extra["doc_id"] == REAL_ID_1
    assert m1.extra["canonical_url"] == f"https://wenku.baidu.com/view/{REAL_ID_1}.html"
    assert m1.source_url == REAL_URL_1  # 零造假：原始 URL 不被改写
    assert m2.extra["doc_id"] == REAL_ID_2  # wapwenku URL 亦提取归一
    assert m2.extra["canonical_url"] == f"https://wenku.baidu.com/view/{REAL_ID_2}.html"


# ---------------- 实弹（真实网络 zero-mock；KB_HARVEST_SKIP_LIVE=1 跳过） ----------------

_LIVE_REASON = "KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（真实网络未跑，公约第4条）"


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason=_LIVE_REASON)
def test_fr2_ac1_live_search_real_word():
    """FR2.AC1 主验收：1 检索词经 WenkuMetaAdapter（syncmrecall 免登录）≥10 条 FileMeta。"""
    adapter = WenkuMetaAdapter()
    metas = adapter.metadata(LIVE_QUERY, 12)
    assert len(metas) >= 10  # FR2.AC1
    for m in metas:
        assert isinstance(m, FileMeta)
        assert m.title and m.fmt in ("doc", "pdf", "ppt", "xls", "txt", "epub", "ebook")
        doc_id = extract_doc_id(m.source_url or "")
        assert doc_id is not None  # 校准：真实 source_url 12/12 可提取
        assert normalize_wenku_url(m.source_url) == f"https://wenku.baidu.com/view/{doc_id}.html"


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason=_LIVE_REASON)
def test_fr2_ac1_live_adapter_search_canonical():
    """实弹：WenkuDownloadAdapter.search 真链路（元数据+docId/canonical 对齐一站式）。"""
    adapter = WenkuDownloadAdapter()
    metas = adapter.search(LIVE_QUERY, 12)
    assert len(metas) >= 10
    for m in metas:
        doc_id = extract_doc_id(m.source_url)
        assert m.extra.get("doc_id") == doc_id
        assert m.extra.get("canonical_url") == normalize_wenku_url(m.source_url)


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason=_LIVE_REASON)
def test_fr2_ac1_live_ndview_alias_and_wapwenku_probe():
    """§2 置信修正实锤固化：ndview=view 别名端点（200+var pageData）；wapwenku 纯解析直取。"""
    import httpx
    r = httpx.get(f"https://wenku.baidu.com/ndview/{REAL_ID_1}.html", follow_redirects=True,
                  timeout=15.0, headers={"User-Agent": (
                      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
                      "(KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36")})
    assert r.status_code == 200
    assert "var pageData" in r.text[:60000]  # ndview 有效别名端点（不重定向、免登录首屏）
    wap_url = f"https://wapwenku.baidu.com/view/{REAL_ID_1}.html?fr=IncomeWapDoc"
    assert resolve_doc_id(wap_url) == REAL_ID_1  # 路径直取（重定向实测丢 id）
