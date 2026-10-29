# -*- coding: utf-8 -*-
"""T22 单测：wenku readerInfo 采集+ACS 补页+信封陷阱+无进展熔断（FR2.2/FR2.3）。

被测物 = kb_factory.harvest_engine.adapters.wenku（T18 地基只增不改；本任务续建
readerInfo 腿）：初始 readerInfo 纯 HTTP 免签挖取（**ndview 侧门**，view 页 403 勿撞）
→ parse/inline_var.extract_page_data → 免费额度不足（showPage<page）经
signer/PageSigner.fetch_readerinfo 补页（fetch/paged_fetcher.for_wenku 预设，rn=50
游标推进）→ 信封=envelope judge wenku（code:0 陷阱/tri_cap→NeedVerify 熔断退避不判死）
→ 无进展熔断（连续 3 轮零进展）触发 FR2.3 判据积累（+showPage<page+非 tri_cap →
needs_vip_candidate 经 mark_wall_status 落位；正式标记归 T38 验收）。

测试纪律（WORKER_CONVENTIONS）：
- 离线单测零网络：①初始腿经 fetch_html 注入点（网络腿，任务卡明示）；②补页腿注入
  _StubSigner——桩的是**签名窗这一外部网络依赖**（真身=Playwright 常驻隐藏页），
  非被测物本体；信封判定用真 judge_readerinfo/judge_wenku（信封陷阱真逻辑，不桩）。
- 实弹用例（@pytest.mark.live）= 真实网络 zero-mock：syncmrecall 找免费件（free/vip=0）
  → ndview 真取 pageData → PageSigner 真签名补页/探针（信封 OK 或 tri_cap 均算验证，
  T17 编制裁定同口径）→ ledger 如实记 showPage/page；KB_HARVEST_SKIP_LIVE=1 时跳过。
- 台账落 tests/fixtures/（公约第 10 条，不改 .gitignore）；live 台账追加写、零删除。
"""
import json
import os
import sys
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
    from kb_factory.harvest_engine.adapters.base import (LADDER_ORDER, HarvestPlan,
                                                         LadderResult)
    from kb_factory.harvest_engine.adapters.wenku import (WenkuDownloadAdapter,
                                                          WenkuPageDataError,
                                                          fetch_page_data,
                                                          html_urls_to_pages,
                                                          reader_show_pages,
                                                          reader_total_pages,
                                                          sanitize_title)
    from kb_factory.harvest_engine.audit import HarvestAudit
    from kb_factory.harvest_engine.envelope import EnvelopeNeedVerify, EnvelopeOK
    from kb_factory.harvest_engine.signer.page_signer import (ReaderInfoResult,
                                                              SignedFetch,
                                                              judge_readerinfo)
except ImportError:
    from channel_adapters.base import FileMeta
    from harvest_engine.adapters.base import LADDER_ORDER, HarvestPlan, LadderResult
    from harvest_engine.adapters.wenku import (WenkuDownloadAdapter, WenkuPageDataError,
                                               fetch_page_data, html_urls_to_pages,
                                               reader_show_pages, reader_total_pages,
                                               sanitize_title)
    from harvest_engine.audit import HarvestAudit
    from harvest_engine.envelope import EnvelopeNeedVerify, EnvelopeOK
    from harvest_engine.signer.page_signer import (ReaderInfoResult, SignedFetch,
                                                   judge_readerinfo)

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"
DOC_ID = "9c58877bceaedd3383c4bb4cf7ec4afe04a1b1a6"  # T18 校准实测 docId 形态（40 位 hex）
DOC_ID_2 = "6657e2beb84cf7ec4afe04a1b0717fd5360cb28e"
VIEW_URL = f"https://wenku.baidu.com/view/{DOC_ID}.html"
NDVIEW_URL = f"https://wenku.baidu.com/ndview/{DOC_ID}.html"


def _img_url(pn: int) -> str:
    """类型2 图片直链形态（含 pn= 页号，§3.2 去重键来源）。"""
    return f"https://wkbitmap.bdimg.com/thumbnails/{DOC_ID}?pn={pn}&s=1&r=0.1"


def _page_entry(kind: str, pn: int) -> dict:
    """类型3 单页条目形态（§5.1：pageIndex + pageLoadUrl/param）。"""
    base = {"pageIndex": pn}
    if kind == "ttf":
        return {**base, "param": f"ttf-param-{pn}"}
    return {**base, "pageLoadUrl": f"https://wkretype.bdimg.com/pipe/{pn}?kind={kind}"}


def _ndview_html(page_data: dict) -> str:
    """合成 ndview 页：var pageData 锚点 + JSON（extract_page_data 可解形态）。"""
    return ("<html><head><meta charset='utf-8'></head><body><script>\n"
            "var pageData = " + json.dumps(page_data, ensure_ascii=False) + ";\n"
            "</script></body></html>")


def _fetch_html_spy(html: str, status: int = 200):
    """初始腿网络注入点（任务卡明示）：捕获 (url, headers, timeout)，返回 (status, html)。"""
    captured = {"calls": []}

    def fetch(url, headers, timeout):
        captured["calls"].append({"url": url, "headers": dict(headers), "timeout": timeout})
        return status, html

    return fetch, captured


class _StubSigner:
    """补页腿网络注入点：真身=PageSigner（Playwright 常驻隐藏窗+paris_2030 签名），
    离线替身只吃预置 payload 列表逐个应答；信封判定走真 judge_readerinfo（不桩）。"""

    def __init__(self, payloads):
        self.payloads = list(payloads)
        self.calls = []

    def fetch_readerinfo(self, doc_id, *, pn=1, rn=50, t_ms=None, referer=None):
        self.calls.append({"doc_id": doc_id, "pn": pn, "rn": rn, "referer": referer})
        payload = self.payloads.pop(0)
        url = f"https://wenku.baidu.com/ndocview/readerinfo?doc_id={doc_id}&pn={pn}&rn={rn}"
        fetch = SignedFetch(url=url, token="STUB_TOKEN", ok=True, status=200,
                            payload=payload, elapsed_ms=1)
        return ReaderInfoResult(doc_id=doc_id, url=url, token="STUB_TOKEN",
                                fetch=fetch, verdict=judge_readerinfo(fetch))


def _ok_fill_payload(html_urls, show_page: int) -> dict:
    return {"status": {"code": 0, "msg": "success"},
            "data": {"showPage": show_page, "htmlUrls": html_urls}}


_TRI_CAP_PAYLOAD = {"status": {"code": 0, "msg": "need to verify pop-up window!"},
                    "data": {"tri_reason": "ymg", "tri_cap": True,
                             "svcp_url": "https://seccaptcha.baidu.com/v1/webapi/verint/"
                                         "svcp.html?ak=demo&subid=wenku_pc_readerinfo_bfe"}}
_NO_PAGE_PAYLOAD = {"status": {"code": 0, "msg": "ok"}, "data": {}}  # code:0 陷阱（R12）


def _adapter(tmp_path=None, **kw) -> WenkuDownloadAdapter:
    if tmp_path is not None:
        kw["audit"] = HarvestAudit(path=str(tmp_path / "audit.jsonl"))
    return WenkuDownloadAdapter(**kw)


def _audit_lines(path) -> list:
    p = Path(path)
    if not p.exists():
        return []
    return [json.loads(line) for line in p.read_text(encoding="utf-8").splitlines() if line]


def _meta_free(title="某水利施工组织设计-百度文库", doc_id=DOC_ID) -> FileMeta:
    return FileMeta(title=title, fmt="doc", pages=8, perm="green",
                    source_url=f"https://wenku.baidu.com/view/{doc_id}.html",
                    extra={"doc_id": doc_id})


# ---------------- 纯函数：文件名清洗（§5.1）/ 页字段优先级 ----------------

def test_fr2_2_sanitize_title_brand_suffix_and_illegal_chars():
    """§5.1/W:805：去「- 百度文库/百度文库」后缀+trim；非法字符 [\\/:*?"<>|]→_；空回落 fallback。"""
    assert sanitize_title("水电站施工组织设计-百度文库") == "水电站施工组织设计"
    assert sanitize_title("水电站施工组织设计 - 百度文库") == "水电站施工组织设计"
    assert sanitize_title("百度文库水利方案") == "水利方案"
    assert sanitize_title('2026<方案>/第*期:"引水"?|施工\\设/计') == "2026_方案__第_期__引水___施工_设_计"
    assert sanitize_title("  施工方案  ") == "施工方案"
    assert sanitize_title("-百度文库", fallback=DOC_ID_2) == DOC_ID_2  # 清洗后空 → docId 回落
    assert sanitize_title("", fallback=DOC_ID_2) == DOC_ID_2


def test_fr2_2_reader_page_fields_priority():
    """§3.2/W:789：总页数=page||originalPage||freePage||0（先命中）；showPage||0。"""
    assert reader_total_pages({"page": 12}) == 12
    assert reader_total_pages({"originalPage": 30, "freePage": 8}) == 30
    assert reader_total_pages({"freePage": 8}) == 8
    assert reader_total_pages({}) == 0
    assert reader_show_pages({"showPage": 5}) == 5
    assert reader_show_pages({}) == 0


def test_fr2_2_html_urls_to_pages_indexes_both_shapes():
    """初始页库存索引：类型2 数组按 /pn=(\\d+)/；类型3 对象按 pageIndex（json/png/ttf 并页）。"""
    pages2 = html_urls_to_pages([_img_url(1), _img_url(2), "https://x.bdimg.com/no-pn-here"])
    assert pages2 == {1: _img_url(1), 2: _img_url(2)}  # 无 pn= 项不占页号（如实不计）
    pages3 = html_urls_to_pages({"json": [_page_entry("json", 1), _page_entry("json", 2)],
                                 "png": [_page_entry("png", 1)], "ttf": []})
    assert sorted(pages3) == [1, 2]
    assert pages3[1]["json"]["pageLoadUrl"].endswith("kind=json")
    assert pages3[1]["png"]["pageLoadUrl"].endswith("kind=png")
    assert "ttf" not in pages3[1]  # ttf 空=该页无字体条目
    assert html_urls_to_pages([]) == {} and html_urls_to_pages(None) == {}


# ---------------- ① 初始 readerInfo：ndview 侧门（纯 HTTP 免签） ----------------

def test_fr2_2_ndview_side_door_free_doc_initial_readerinfo(tmp_path):
    """FR2.2①：ndview 侧门直连 200 含 var pageData（view 页 403 勿撞）→ 免费件 showPage>=page
    不补页（§5.3）、零 signer 调用、coverage/showPage-page 如实、§3.1 全套头。"""
    ri = {"showPage": 8, "page": 8, "tplKey": "normal",
          "htmlUrls": [_img_url(i) for i in range(1, 9)]}
    fetch, captured = _fetch_html_spy(_ndview_html({"title": "免费施工方案-百度文库",
                                                    "readerInfo": ri}))
    adapter = _adapter(tmp_path)
    out = adapter.collect_reader_info(DOC_ID, meta=_meta_free(), fetch_html=fetch,
                                      min_interval=0)
    assert captured["calls"][0]["url"] == NDVIEW_URL  # 侧门而非 view（403 勿撞）
    headers = captured["calls"][0]["headers"]
    # T41 P0-1（2026-10-23）：Sec-CH 三头与 UA 同源自洽（129/Windows/Not_A Brand）——
    # 旧「v=120 + macOS」互斥形态废除（自爆式指纹，研判 PENTAGI/wenku_assessment.md）
    assert headers["Sec-Ch-Ua"] == ('"Google Chrome";v="129","Chromium";v="129",'
                                    '"Not_A Brand";v="24"')
    assert headers["Sec-Ch-Ua-Mobile"] == "?0" and headers["Sec-Ch-Ua-Platform"] == '"Windows"'
    assert headers["Upgrade-Insecure-Requests"] == "1"
    assert headers["Accept-Language"] == "zh-CN,zh;q=0.9"
    assert out.page == 8 and out.show_page == 8 and out.coverage == "8/8"
    assert out.fill_needed is False and out.fill is None and out.stop_kind == "not_needed"
    assert out.tri_cap_seen is False and out.wall_status is None
    assert out.title_raw == "免费施工方案-百度文库" and out.title_clean == "免费施工方案"
    assert sorted(out.html_urls_pages) == list(range(1, 9))
    assert out.reader_info["htmlUrls"][0] == _img_url(1)  # readerInfo 原样保留（T26 三型分派吃它）
    lines = _audit_lines(tmp_path / "audit.jsonl")
    assert [l["event"] for l in lines] == ["readerinfo_init"]
    assert lines[0]["count"] == 8 and lines[0]["status"] == "ok"
    assert "showPage=8" in lines[0]["detail"] and "/8" in lines[0]["detail"]


def test_fr2_2_invalid_docid_403_raises_page_data_error():
    """FR2.AC3/§8-1：ndview 挖不出 var pageData（403 WAF/删除件同路）→ 报「无法提取 pageData」。"""
    fetch, _ = _fetch_html_spy("<html>WAF 拦截页</html>", status=403)
    with pytest.raises(WenkuPageDataError, match="无法提取 pageData"):
        fetch_page_data(DOC_ID, fetch_html=fetch)
    fetch2, _ = _fetch_html_spy("<html><script>var other = 1;</script></html>", status=200)
    with pytest.raises(WenkuPageDataError, match="无法提取 pageData"):
        fetch_page_data(DOC_ID, fetch_html=fetch2)  # 200 但无锚点同报（§8-1 原作口径）
    with pytest.raises(ValueError):
        fetch_page_data("short-id", fetch_html=fetch)  # docId 形态硬拒


# ---------------- ② 补页：签名腿 + 游标推进（§3.2） ----------------

def test_fr2_2_fill_signed_ok_exhausted_coverage_and_ledger(tmp_path):
    """FR2.2②：showPage=5<page=12 → pn=showPage+1、rn=50 带签补页；EnvelopeOK 批推进游标至
    12 → exhausted；coverage=12/12；htmlUrls 去重合并排序（§3.2）；ledger 如实两行。"""
    ri = {"showPage": 5, "page": 12, "htmlUrls": [_img_url(i) for i in range(1, 6)]}
    fetch, _ = _fetch_html_spy(_ndview_html({"title": "部分免费方案", "readerInfo": ri}))
    signer = _StubSigner([_ok_fill_payload([_img_url(i) for i in range(6, 13)], 12)])
    adapter = _adapter(tmp_path)
    out = adapter.collect_reader_info(DOC_ID, meta=_meta_free(), signer=signer,
                                      fetch_html=fetch, min_interval=0)
    assert out.fill_needed is True and out.fill is not None
    assert signer.calls == [{"doc_id": DOC_ID, "pn": 6, "rn": 50,
                             "referer": VIEW_URL}]  # pn=showPage+1、rn=50、Referer=view 页
    assert out.fill.stopped_reason == "exhausted" and out.fill.requests == 1
    assert out.stop_kind == "exhausted" and out.coverage == "12/12"
    assert out.show_page == 12 and out.reader_info["showPage"] == 12  # 游标回写 readerInfo（W:261）
    assert sorted(out.html_urls_pages) == list(range(1, 13))          # 初始 5 + 补页 7 合并
    assert len(out.reader_info["htmlUrls"]) == 12                     # 去重合并（原数组序）
    assert out.reader_info["htmlUrls"][0] == _img_url(1)
    lines = _audit_lines(tmp_path / "audit.jsonl")
    assert [l["event"] for l in lines] == ["readerinfo_init", "readerinfo_fill"]
    assert lines[1]["count"] == 1 and lines[1]["status"] == "ok"
    assert "showPage=12" in lines[1]["detail"] and "/12" in lines[1]["detail"]


def test_fr2_2_fill_merges_type3_dict_html_urls(tmp_path):
    """FR2.2②：类型3 补页批 htmlUrls={json,png,ttf} 按 pageIndex 三键分桶合并去重排序
    （W:207-259）；初始数组型缺省让位三桶结构（原作同语义）。"""
    ri = {"showPage": 5, "page": 12,
          "htmlUrls": {"json": [_page_entry("json", i) for i in range(1, 6)],
                       "png": [_page_entry("png", i) for i in range(1, 6)], "ttf": []}}
    fetch, _ = _fetch_html_spy(_ndview_html({"title": "类型3方案-百度文库", "readerInfo": ri}))
    batch = {"json": [_page_entry("json", i) for i in range(6, 13)],
             "png": [_page_entry("png", i) for i in range(6, 13)],
             "ttf": [_page_entry("ttf", 6)]}
    signer = _StubSigner([_ok_fill_payload(batch, 12)])
    adapter = _adapter(tmp_path)
    out = adapter.collect_reader_info(DOC_ID, meta=_meta_free(), signer=signer,
                                      fetch_html=fetch, min_interval=0)
    merged = out.reader_info["htmlUrls"]
    assert set(merged) == {"json", "png", "ttf"}
    assert [e["pageIndex"] for e in merged["json"]] == list(range(1, 13))  # 合并+pageIndex 排序
    assert merged["ttf"] == [_page_entry("ttf", 6)]
    assert sorted(out.html_urls_pages) == list(range(1, 13))
    assert out.html_urls_pages[6]["json"]["pageLoadUrl"].endswith("kind=json")
    assert out.stop_kind == "exhausted" and out.coverage == "12/12"


# ---------------- ③ 信封陷阱：code:0 / tri_cap（§6.3/R12） ----------------

def test_fr2_2_envelope_trap_code0_no_page_data_breaks_fill(tmp_path):
    """FR2.2③/R12：code:0 但无 htmlUrls → EnvelopeFail(no_page_data) → 中断补页循环（§8-4）；
    部分收割如实 coverage=5/12，不标 needs_vip_candidate。"""
    ri = {"showPage": 5, "page": 12, "htmlUrls": [_img_url(i) for i in range(1, 6)]}
    fetch, _ = _fetch_html_spy(_ndview_html({"title": "x", "readerInfo": ri}))
    signer = _StubSigner([_NO_PAGE_PAYLOAD])
    adapter = _adapter(tmp_path)
    meta = _meta_free()
    out = adapter.collect_reader_info(DOC_ID, meta=meta, signer=signer, fetch_html=fetch,
                                      min_interval=0)
    assert out.stop_kind == "envelope_fail" and out.fill.requests == 1  # 即断（max_retries=0）
    assert out.coverage == "5/12" and out.show_page == 5
    assert out.tri_cap_seen is False and out.wall_status is None
    assert "wall_status" not in meta.extra
    lines = _audit_lines(tmp_path / "audit.jsonl")
    assert lines[1]["event"] == "readerinfo_fill" and lines[1]["status"] == "fail"


def test_fr2_2_tri_cap_needverify_backoff_not_dead(tmp_path):
    """FR2.2③/§6.3：tri_cap=true → EnvelopeNeedVerify → 熔断退避不判死（R13/FR8 归 T29 消费）；
    不中止收割语义=部分收割如实+不标 needs_vip_candidate；ledger 记 need_verify。"""
    ri = {"showPage": 5, "page": 12, "htmlUrls": [_img_url(i) for i in range(1, 6)]}
    fetch, _ = _fetch_html_spy(_ndview_html({"title": "x", "readerInfo": ri}))
    signer = _StubSigner([_TRI_CAP_PAYLOAD])
    adapter = _adapter(tmp_path)
    meta = _meta_free()
    out = adapter.collect_reader_info(DOC_ID, meta=meta, signer=signer, fetch_html=fetch,
                                      min_interval=0)
    assert out.stop_kind == "tri_cap" and out.tri_cap_seen is True
    assert out.coverage == "5/12" and out.show_page == 5
    assert out.wall_status is None and "wall_status" not in meta.extra  # 不判死（非 FR2.3 判据）
    assert len(signer.calls) == 1  # 熔断即退避：不再连打
    lines = _audit_lines(tmp_path / "audit.jsonl")
    assert lines[1]["event"] == "readerinfo_fill" and lines[1]["status"] == "need_verify"
    assert "tri_cap" in lines[1]["detail"]


# ---------------- ④ 无进展熔断 → FR2.3 判据积累 ----------------

def test_fr2_3_no_progress_3rounds_marks_needs_vip_candidate(tmp_path):
    """FR2.3：连续 3 轮零进展（服务端 showPage 卡 5、htmlUrls 全重复）+ showPage<page + 非
    tri_cap → paged_fetcher 熔断（内置）→ mark_wall_status 落 needs_vip_candidate +
    FileMeta.perm 备注 + ledger wall_status 行（正式标记验收归 T38）。"""
    ri = {"showPage": 5, "page": 12, "htmlUrls": [_img_url(i) for i in range(1, 6)]}
    fetch, _ = _fetch_html_spy(_ndview_html({"title": "VIP 专享方案-百度文库", "readerInfo": ri}))
    stuck = _ok_fill_payload([_img_url(i) for i in range(1, 6)], 5)  # OK 批但零新页+游标不动
    signer = _StubSigner([dict(stuck), dict(stuck), dict(stuck), dict(stuck)])  # 第 4 轮不应发生
    adapter = _adapter(tmp_path)
    meta = _meta_free(title="VIP 专享方案-百度文库")
    out = adapter.collect_reader_info(DOC_ID, meta=meta, signer=signer, fetch_html=fetch,
                                      min_interval=0)
    assert out.fill.stopped_reason == "no_progress"
    assert out.fill.no_progress_rounds == 3 and out.fill.requests == 3  # 恰 3 轮熔断
    assert out.stop_kind == "no_progress" and out.coverage == "5/12"
    assert out.wall_status == "needs_vip_candidate"                     # NFR1 词表
    assert meta.extra["wall_status"] == "needs_vip_candidate"           # mark_wall_status 落位
    assert "needs_vip_candidate" in meta.perm                           # FR2.3 两字段之 perm 备注
    assert "推断" in meta.perm
    lines = _audit_lines(tmp_path / "audit.jsonl")
    wall = [l for l in lines if l["event"] == "wall_status"]
    assert len(wall) == 1 and wall[0]["status"] == "needs_vip_candidate"
    assert "showPage=5" in wall[0]["detail"] and "/12" in wall[0]["detail"]
    assert out.fill.pages == {}  # 全重复批零新页（页库存不虚增，数字零造假）


def test_fr2_3_tri_cap_path_not_marked_vip(tmp_path):
    """FR2.3 负判据：熔断若由 tri_cap 触发（验证码墙≠VIP 墙）→ 不标 needs_vip_candidate。"""
    ri = {"showPage": 5, "page": 12, "htmlUrls": [_img_url(i) for i in range(1, 6)]}
    fetch, _ = _fetch_html_spy(_ndview_html({"title": "x", "readerInfo": ri}))
    signer = _StubSigner([_TRI_CAP_PAYLOAD])
    adapter = _adapter(tmp_path)
    meta = _meta_free()
    out = adapter.collect_reader_info(DOC_ID, meta=meta, signer=signer, fetch_html=fetch,
                                      min_interval=0)
    assert out.stop_kind == "tri_cap" and out.wall_status is None
    assert "wall_status" not in meta.extra and "needs_vip_candidate" not in meta.perm
    assert not [l for l in _audit_lines(tmp_path / "audit.jsonl")
                if l["event"] == "wall_status"]


def test_fr2_3_page_over_400_limit_blocks_fill(tmp_path):
    """§8-2：page>400 → 「超出最大支持页数 400 页」中止；不进补页循环（signer 缺席也不报错）。"""
    ri = {"showPage": 8, "page": 500, "htmlUrls": [_img_url(i) for i in range(1, 9)]}
    fetch, _ = _fetch_html_spy(_ndview_html({"title": "大部头-百度文库", "readerInfo": ri}))
    adapter = _adapter(tmp_path)
    out = adapter.collect_reader_info(DOC_ID, meta=_meta_free(), fetch_html=fetch,
                                      min_interval=0)  # 无 signer：page_limit 先拦，无需签名窗
    assert out.stop_kind == "page_limit" and out.fill is None
    assert out.page == 500 and out.coverage == "8/500"
    assert "400" in out.detail and "超出最大支持页数" in out.detail
    assert out.wall_status is None


def test_fr2_2_fill_without_signer_fails_fast():
    """补页需要签名窗：showPage<page 且未注入 signer → 硬报（不静默跳过）。"""
    ri = {"showPage": 5, "page": 12, "htmlUrls": [_img_url(i) for i in range(1, 6)]}
    fetch, _ = _fetch_html_spy(_ndview_html({"title": "x", "readerInfo": ri}))
    adapter = WenkuDownloadAdapter()
    with pytest.raises(RuntimeError, match="signer"):
        adapter.collect_reader_info(DOC_ID, fetch_html=fetch)


# ---------------- 段2/段3 契约：T18 已锁契约保持 + T22 readerInfo 腿接驳 ----------------

def test_fr2_2_plan_and_fetch_ladder_wiring(tmp_path):
    """T18 锁定契约保持（无 docId → NotImplementedError 消息钉 T22/T26/T31/T35）+ T22 腿接驳：
    有 docId 时 plan 出 HarvestPlan；fetch_ladder 跑完 readerInfo 腿后按 §5.2 分派——
    类型2 重组 T31 已实装（占位钉兑现：404 全弃=如实失败，零网络注入）；类型1/verify 半
    仍钉 T26/T31/T35（T35 续建），采集结果落 adapter.last_reader_info。"""
    adapter = _adapter(tmp_path)
    bare = FileMeta(title="骨架样例", fmt="doc")
    with pytest.raises(NotImplementedError, match="T22"):
        adapter.plan(bare)
    with pytest.raises(NotImplementedError, match=r"T26/T31/T35"):
        adapter.fetch_ladder(HarvestPlan(meta=bare))  # 零网络（无 docId 即抛）
    meta = _meta_free()
    plan = adapter.plan(meta)
    assert isinstance(plan, HarvestPlan) and DOC_ID in plan.slot
    assert plan.ladder_try == LADDER_ORDER and plan.red_check is True

    ri = {"showPage": 8, "page": 8, "htmlUrls": [_img_url(i) for i in range(1, 9)]}
    fetch, _ = _fetch_html_spy(_ndview_html({"title": "免费施工方案-百度文库", "readerInfo": ri}))
    dead_leg = lambda url, headers, timeout, *, binary=False: (404, b"")  # noqa: E731
    result2 = adapter.fetch_ladder(plan, fetch_html=fetch, asset_fetch=dead_leg,
                                   asset_min_interval=0)  # T31 实装：类型2 分派入真重组
    assert result2.ok is False and result2.pages == 0    # 全 404=零可用页如实失败（不产空件）
    bundle = adapter.last_reader_info
    assert bundle.doc_id == DOC_ID and bundle.stop_kind == "not_needed"
    assert bundle.coverage == "8/8" and bundle.show_page == 8
    with pytest.raises(NotImplementedError, match=r"T26/T31/T35"):  # verify 未动（T26/T31/T35 契约）
        adapter.verify(LadderResult(ok=True))


# ---------------- T41 P0 清偿守门（指纹统一 P0-1 / 资产腿安全缺省 P0-3）----------------

def test_fr2_2_p0_1_fingerprint_snapshot_self_consistent():
    """T41 P0-1：浏览器指纹快照三头同源自洽——UA/Sec-Ch-Ua/Sec-Ch-Ua-Platform 版本对齐
    （Chrome 129）+平台对齐（Windows）+含 Not_A Brand 条目；旧「UA=129 Windows ↔ Sec-CH
    v=120 ↔ Platform macOS」三处互斥形态永久废除（互斥=主动自爆式指纹，规则引擎仅凭头
    即判死——PentAGI flow 11 判级 P0；守门防再犯：改版本只动模块级快照常量三处同源）。"""
    try:
        from kb_factory.harvest_engine.adapters import wenku as w
    except ImportError:
        from harvest_engine.adapters import wenku as w  # type: ignore  # pragma: no cover
    headers = w._view_headers(None, "")
    assert headers["User-Agent"] == w._DEFAULT_UA
    assert f"Chrome/{w._UA_VERSION}.0.0.0" in headers["User-Agent"]
    assert "Windows NT" in headers["User-Agent"]
    assert headers["Sec-Ch-Ua"] == w._SEC_CH_UA
    assert f'v="{w._UA_VERSION}"' in headers["Sec-Ch-Ua"]          # Sec-CH 版本==UA 版本
    assert "Not_A Brand" in headers["Sec-Ch-Ua"]                    # 真实 Chrome 必带条目
    assert headers["Sec-Ch-Ua-Platform"] == w._SEC_CH_UA_PLATFORM == '"Windows"'  # 平台对齐
    assert headers["Sec-Ch-Ua-Mobile"] == "?0"
    # 互斥形态回归守门：旧值（v=120 / macOS）不得回流任何快照头
    assert 'v="120"' not in headers["Sec-Ch-Ua"] and "macOS" not in headers["Sec-Ch-Ua-Platform"]
    # cookie 注入分支同快照
    with_cookie = w._view_headers(None, "BDUSS=x")
    assert with_cookie["Cookie"] == "BDUSS=x" and with_cookie["Sec-Ch-Ua"] == headers["Sec-Ch-Ua"]


def test_fr2_2_p0_3_asset_legs_default_throttle_on(tmp_path):
    """T41 P0-3：三条资产腿（type3 三腿/type2 图片腿/type1 XML 桶腿）min_interval 缺省
    =WENKU_ASSET_MIN_INTERVAL=0.5s 安全默认开启（旧缺省 0.0=节流默认关闭，新调用路径忘
    注入即无节流直连——PentAGI 判级 P0）；显式 min_interval=0 仍可关闭（确定性测试口径）。"""
    try:
        from kb_factory.harvest_engine.adapters.wenku import (WENKU_ASSET_MIN_INTERVAL,
                                                              fetch_type2_images,
                                                              fetch_type3_assets,
                                                              fetch_xml_blocks)
    except ImportError:
        from harvest_engine.adapters.wenku import (WENKU_ASSET_MIN_INTERVAL,  # type: ignore
                                                   fetch_type2_images, fetch_type3_assets,
                                                   fetch_xml_blocks)
    assert WENKU_ASSET_MIN_INTERVAL == 0.5
    dead = lambda url, headers, timeout, *, binary=False: (404, b"" if binary else "")  # noqa: E731
    # type2 图片腿：2 页→腿间 1 次缺省节流
    ri2 = {"htmlUrls": [_img_url(1), _img_url(2)]}
    slept2: list = []
    fetch_type2_images(ri2, asset_fetch=dead, sleep=slept2.append)
    assert slept2 == [0.5]
    # type3 三腿：json 2 页（无 png/ttf）→腿间 1 次缺省节流
    ri3 = {"htmlUrls": {"json": [_page_entry("json", 1), _page_entry("json", 2)],
                        "png": [], "ttf": []}}
    slept3: list = []
    fetch_type3_assets(ri3, asset_fetch=dead, sleep=slept3.append)
    assert slept3 == [0.5]
    # type1 XML 桶腿：9 项 3 桶（RTCS_BUCKET_SIZE=3）→桶间 2 次缺省节流
    ri1 = {"rtcsRangeInfo": [{"page": i, "range": f"r{i}"} for i in range(1, 10)]}
    slept1: list = []
    fetch_xml_blocks(ri1, asset_fetch=dead, now_ms=7, sleep=slept1.append)
    assert slept1 == [0.5, 0.5]
    # 显式 0=关闭（离线确定性口径不回归）
    slept0: list = []
    fetch_type2_images(ri2, asset_fetch=dead, min_interval=0, sleep=slept0.append)
    assert slept0 == []


# ---------------- 实弹（真实网络 zero-mock；KB_HARVEST_SKIP_LIVE=1 跳过） ----------------

_LIVE_REASON = "KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（真实网络未跑，公约第 4 条）"
_LIVE_AUDIT = Path(__file__).resolve().parent / "fixtures" / "_t22_live_audit.jsonl"
_LIVE_QUERY = "水利施工组织设计"  # T18 校准日用词（syncmrecall 12 条实测）


def _discover_free_doc() -> FileMeta:
    """实弹发现腿（任务卡点名：syncmrecall 找 free/vip=0 件）：WenkuMetaAdapter 免登录检索，
    sellType∉{2,5}=green 免费；空结果如实 AssertionError（不造假件）。"""
    from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter
    from kb_factory.harvest_engine.adapters.wenku import extract_doc_id
    metas = WenkuMetaAdapter().metadata(_LIVE_QUERY, 24)
    free = [m for m in metas if (m.extra.get("doc_id") or extract_doc_id(m.source_url or ""))
            and m.perm == "green"]
    assert free, f"syncmrecall 未发现免费件（perm=green；共 {len(metas)} 条）"
    pick = min(free, key=lambda m: (m.pages or 10 ** 6))  # 小文档优先（实弹提速）
    pick.extra["doc_id"] = pick.extra.get("doc_id") or extract_doc_id(pick.source_url)
    return pick


@pytest.fixture(scope="module")
def chromium():
    """module 级唯一浏览器（公约：禁止并行开多浏览器）；国内腿直连（--no-proxy-server，
    让路收窄令：wenku 不依赖国外网代理；T17 同口径）。"""
    from playwright.sync_api import sync_playwright
    with sync_playwright() as pw:
        args = [] if os.environ.get("KB_HARVEST_KEEP_PROXY") == "1" else ["--no-proxy-server"]
        browser = pw.chromium.launch(headless=True, args=args)
        yield browser
        browser.close()


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason=_LIVE_REASON)
def test_fr2_2_live_free_doc_full_readerinfo_chain(tmp_path):
    """FR2.2 主验收实弹：1 份免费文档（syncmrecall free/vip=0）全链——
    ①ndview 侧门真取初始 readerInfo（含 var pageData）②showPage<page 时经真 PageSigner
    带签补页（免费件预期 fill_needed=False，§5.3；另发 1 次带签 readerinfo 探针实证②③腿，
    EnvelopeOK 或 EnvelopeNeedVerify(tri_cap) 均算信封路径被验证——T17 编制裁定同口径）
    ④ledger 如实记 showPage/page（SYNTHESIS 缺口#3 校准数据）。台账追加写、零删除。

    T38 刷新（2026-10-23 授权改动点）：T26/T31/T35 三型重组实装后 fetch_ladder **返回
    LadderResult**（原 ``pytest.raises(NotImplementedError, match="T26/T31/T35")`` 钉已
    过时、必炸）——断言刷新为 isinstance(LadderResult)。打印腿（html_to_pdf 内开
    sync_playwright）不可嵌套任何在册 sync 上下文 → 本用例自管浏览器生命周期（不再吃
    module 级 chromium fixture——其 sync_playwright 上下文横跨全 module，收口前 dispatch
    必炸嵌套），两段式调用面：签名窗内 collect_reader_info → 浏览器收口 →
    dispatch_reconstruction；重组成败如实打印不断言 ok（readerInfo 腿为本用例主验面，
    重组验收归 e2e/wenku_accept.py T38 件）。"""
    from playwright.sync_api import sync_playwright

    from kb_factory.harvest_engine.adapters.wenku import WenkuDownloadAdapter as _A
    from kb_factory.harvest_engine.browser.kit import BrowserKit
    from kb_factory.harvest_engine.signer.page_signer import PageSigner

    meta = _discover_free_doc()
    doc_id = meta.extra["doc_id"]
    audit = HarvestAudit(path=str(_LIVE_AUDIT))
    adapter = _A(audit=audit)
    with sync_playwright() as pw:  # T38：本用例自管生命周期（module fixture 上下文收口前不可 dispatch）
        browser = pw.chromium.launch(
            headless=True,
            args=[] if os.environ.get("KB_HARVEST_KEEP_PROXY") == "1"
            else ["--no-proxy-server"])
        try:
            kit = BrowserKit(browser)
            signer = PageSigner(kit)  # 真签名窗：隐藏页加载 wenku 首页+就绪轮询（T17 件）
            assert signer.ready, "ACS 签名窗未就绪（T17 件在位为前提）"
            adapter.plan(meta)  # 段2 照跑（docId 对齐断言归 offline 用例）
            before = len(_audit_lines(_LIVE_AUDIT))
            bundle = adapter.collect_reader_info(doc_id, meta=meta, signer=signer)  # T22 腿
            # ① 初始 readerInfo 实测事实（数字零造假）
            assert bundle.doc_id == doc_id and bundle.page >= 1 and bundle.show_page >= 1
            assert bundle.page_data.get("readerInfo") and "百度文库" not in bundle.title_clean
            assert bundle.stop_kind in ("not_needed", "exhausted", "tri_cap",
                                        "envelope_fail", "no_progress")
            # ②/③ 签名补页腿：免费件未触发则单发带签探针（信封三态如实分派即验证）
            if not bundle.fill_needed:
                probe = signer.fetch_readerinfo(doc_id, pn=1, rn=50)
                audit.request("wenku", "readerinfo_probe", doc_id, 1, probe.verdict.state,
                              f"showPage/page={bundle.show_page}/{bundle.page} "
                              f"verdict={probe.verdict.state}/"
                              f"{getattr(probe.verdict, 'kind', '')} http={probe.fetch.status}")
                assert isinstance(probe.verdict, (EnvelopeOK, EnvelopeNeedVerify)), (
                    f"信封路径未被验证: {probe.verdict} http={probe.fetch.status} "
                    f"bodyHead={probe.fetch.body_head[:120]!r}")
            # ④ ledger 如实一行一事件，showPage/page 落账
            new_lines = _audit_lines(_LIVE_AUDIT)[before:]
            events = [l["event"] for l in new_lines]
            assert "readerinfo_init" in events
            assert "readerinfo_fill" in events or "readerinfo_probe" in events
            for line in new_lines:
                assert line["site"] == "wenku" and line["query_or_docid"] == doc_id
            detail = " ".join(l["detail"] for l in new_lines)
            assert f"showPage={bundle.show_page}" in detail and f"/{bundle.page}" in detail
            print(f"\n[live] doc={doc_id} page={bundle.page} showPage={bundle.show_page} "
                  f"stop={bundle.stop_kind} coverage={bundle.coverage} "
                  f"title={bundle.title_clean[:24]}… events={events}")
            signer.close()
            kit.close_all()
        finally:
            browser.close()
    # T38 两段式后半：浏览器收口后 dispatch（打印腿独立开浏览器，不可嵌套）
    result = adapter.dispatch_reconstruction(bundle, out_dir=tmp_path / "t38_out",
                                             min_interval=0.3)
    assert isinstance(result, LadderResult), (
        f"T38 刷新：三型实装后应返回 LadderResult，实得 {type(result).__name__}")
    print(f"[live] T38 全链 LadderResult: ok={result.ok} ladder={result.ladder_used} "
          f"pages={result.pages} chars={result.chars} wall={result.wall_status} "
          f"coverage={result.coverage}")
