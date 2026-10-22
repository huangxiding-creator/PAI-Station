# -*- coding: utf-8 -*-
"""FR3.1 单测：book118 适配器预览链 T19（PREVIEW_DATA→openapi getPreview 预览页清单）。

- 离线用例=本地确定性注入（page_loader/transport/sleep 三注入点，零网络零 mock 框架）；
  .shtm 样本取自 2026-10-22 活探针留档（tests/fixtures/_probe_t19_*.html，构造形态处注明）。
- 实弹用例（@pytest.mark.live）=真实网络（NewView 指纹墙→.shtm SafeLine 首跳→openapi 分批）；
  KB_HARVEST_SKIP_LIVE=1 时跳过并在输出明示（公约第 4 条）。
- envelope 口径回执：expect_first_page=i 实测成立（新方言 data 首键==page 参数），T02/T06 零改动；
  adapter 层为 page≥7 批补 callback=jsonpReturn（不带则空 URL 形态，探针 step17 实证）。
"""
import json
import os
import sys
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    # worker worktree：kb_factory 未入 git → channel_adapters 只读复用主仓真身（供 kb_factory. 前缀解析）
    for _anc in _KB_DIR.parents:
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.channel_adapters.base import FileMeta
    from kb_factory.harvest_engine.adapters.book118 import (  # noqa: E402
        CALLBACK, Book118Adapter, Book118PreviewError, PreviewParams, extract_shtm_config,
        parse_document_id, preview_list_complete)
    from kb_factory.harvest_engine.audit import HarvestAudit
    from kb_factory.harvest_engine.store.ledger import Store
except ImportError:
    from channel_adapters.base import FileMeta  # type: ignore
    from harvest_engine.adapters.book118 import (  # type: ignore
        CALLBACK, Book118Adapter, Book118PreviewError, PreviewParams, extract_shtm_config,
        parse_document_id, preview_list_complete)
    from harvest_engine.audit import HarvestAudit  # type: ignore
    from harvest_engine.store.ledger import Store  # type: ignore

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"
_FIX = Path(__file__).resolve().parent / "fixtures"

# ---- 2026-10-22 活探针留档样本（.shtm 内联配置真身；探针脚本同目录 _probe_t19_*.py 可复核）----
SHTM_62P = _FIX / "_probe_t19_shtm_5110103104004213.html"   # 煤炭投标报告：aid=458293028 62/124 docx
SHTM_3P_RAW = _FIX / "_probe_t19_shtm_raw.html"             # 督导制度(初始响应)：aid=517914739 3/7 docx
SEARCH_GATED = _FIX / "_probe_t19_search_q_rendered.html"   # 匿名搜索页（登录弹窗在页，0 结果）

LIVE_DOC_URL = "https://max.book118.com/html/2022/0414/5110103104004213.shtm"   # 62/124 多批证明档
LIVE_DOC_ID = "5110103104004213"
LIVE_AID, LIVE_PID = 458293028, 1
LIVE_TOKEN = "wfZV4VXfSSBLwX9PNXmmdBXRXeRC2XTAESreymXodihoe9_y5a@cmhIs41pkqgDZZVE="
LIVE_T = "55e7ca585863afca4c85b22898726b81"
# 任务卡「实弹选一个真实免费文档」主档：督导制度（详情页「免费下载」按钮实测在页；3/7 单批）
FREE_DOC_URL = "https://max.book118.com/html/2022/1214/6115103231005025.shtm"
FREE_DOC_ID, FREE_AID = "6115103231005025", 517914739
FREE_PREVIEW, FREE_ACTUAL = 3, 7
# NewView 遗产链金样（BOOK118_SPEC §1 / 上游 DocumentBrowserTest.PREVIEW_PAGE 原文）
NEWVIEW_GOLD = ("<html><script>var PREVIEW_DATA = { project_id: 1, aid: parseInt('188244482'), "
                "view_token: 'Bw_2kzdPgXts68EgVwn_mM4e8ALH_opi', "
                "aid_encode: '5134312044001323'}; //1:max站</script></html>")


def _batch_body(first: int, limit: int, *, preview: int | None = None, actual: int | None = None,
                filetype: str = "docx", empty_urls: bool = False) -> str:
    r"""构造与线上同形的 openapi 批响应（jsonpReturn 壳+\/转义由 json.dumps ensure_ascii 逼近；
    键=数字字符串、值 //view-cache 绝对路径——形态取自 _probe_openapi_p1.txt/step16 实测）。"""
    last = min(first + 5, limit)
    data = {str(i): ("" if empty_urls else f"//view-cache.book118.com/view1/M04/{i}.png")
            for i in range(first, last + 1)}
    pages = {"preview": str(preview if preview is not None else limit),
             "actual": str(actual if actual is not None else limit), "filetype": filetype}
    payload = json.dumps({"status": 200, "message": "ok", "data": data, "pages": pages},
                         ensure_ascii=False)
    return f"{CALLBACK}({payload});"


class Recorder:
    """确定性注入包：记录 sleep/请求页序（零真实等待）。"""

    def __init__(self):
        self.sleeps: list[float] = []
        self.pages: list[int] = []
        self.calls = 0

    def sleep(self, seconds: float) -> None:
        self.sleeps.append(round(seconds, 6))

    def make_transport(self, limit: int, *, fail_pages: dict | None = None,
                       fail_times: int = 0, permanent_fail_page: int | None = None,
                       actual: int | None = None, filetype: str = "docx"):
        """openapi 仿真：fail_pages={页:次数} 瞬态空 data（频控形态）；permanent 恒空 URL（闸形态）。"""
        fail_pages = dict(fail_pages or {})
        rec = self

        def transport(params: dict) -> tuple[int, str]:
            rec.calls += 1
            page = int(params["page"])
            rec.pages.append(page)
            if permanent_fail_page is not None and page == permanent_fail_page:
                return 200, _batch_body(page, limit, empty_urls=True,
                                        actual=actual, filetype=filetype)
            if fail_pages.get(page, 0) > 0:
                fail_pages[page] -= 1
                empty = json.dumps({"status": 200, "message": "ok", "data": {},
                                    "pages": {"preview": str(limit),
                                              "actual": str(actual or limit),
                                              "filetype": filetype}}, ensure_ascii=False)
                return 200, f"{CALLBACK}({empty});"
            return 200, _batch_body(page, limit, actual=actual, filetype=filetype)
        return transport


# ---------------------------------------------------------------- FR3.1 纯函数层

def test_fr3_1_parse_document_id_java_semantics():
    """BOOK118_SPEC §1① Java parseDocumentId 语义移植 + NewView aid= 扩展。"""
    assert parse_document_id("7124155114002001") == "7124155114002001"
    assert (parse_document_id(
        "https://max.book118.com/html/2019/0113/7124155114002001.shtm#anchor?q=1")
        == "7124155114002001")
    assert (parse_document_id(
        "https://max.book118.com/index.php?g=Home&m=NewView&a=index&aid=5134312044001323")
        == "5134312044001323")
    assert parse_document_id("https://max.book118.com/") is None
    assert parse_document_id("") is None
    assert parse_document_id("   ") is None


def test_fr3_1_extract_shtm_config_two_live_samples():
    """.shtm 内联配置挖掘：两份活探针真身样本（62 页批样本+3 页初始响应样本）锚点全命中。"""
    cfg62 = extract_shtm_config(SHTM_62P.read_text(encoding="utf-8"))
    assert cfg62 is not None
    assert cfg62["aid"] == LIVE_AID and cfg62["preview_page"] == 62 \
        and cfg62["actual_page"] == 124 and cfg62["t"] == LIVE_T
    assert cfg62["view_token"] == LIVE_TOKEN and cfg62["filetype"] == "docx"
    assert cfg62["title"].endswith(".docx")
    cfg3 = extract_shtm_config(SHTM_3P_RAW.read_text(encoding="utf-8"))
    assert cfg3 is not None and cfg3["aid"] == 517914739 \
        and cfg3["preview_page"] == 3 and cfg3["actual_page"] == 7
    assert extract_shtm_config("<html>无预览文档页</html>") is None   # 无 view_token=无预览
    assert extract_shtm_config("") is None


def test_fr3_1_preview_params_request_params_dialects():
    """openapi 方言自动：有 t 走新方言（2026-10-22 现行），否则 aid_encode 旧方言；
    callback=jsonpReturn 恒带（page≥7 批不带则空 URL 形态，探针 step17 实证）。"""
    new = PreviewParams(doc_id=LIVE_DOC_ID, project_id=1, aid=LIVE_AID,
                        view_token=LIVE_TOKEN, t=LIVE_T, aid_encode=LIVE_DOC_ID)
    p = new.request_params(7)
    assert p == {"project_id": 1, "aid": LIVE_AID, "view_token": LIVE_TOKEN,
                 "page": 7, "callback": CALLBACK, "t": LIVE_T}
    old = PreviewParams(doc_id="5134312044001323", project_id=1, aid=188244482,
                        view_token="Bw_2kzdPgXts68EgVwn_mM4e8ALH_opi",
                        aid_encode="5134312044001323")
    q = old.request_params(1)
    assert q["aid_encode"] == "5134312044001323" and "t" not in q
    assert q["callback"] == CALLBACK and q["page"] == 1


def test_fr3_1_preview_list_complete_gate():
    """页清单完整性门：1..limit 连续无缺；缺页/空清单/字典序坑形态全拒。"""
    assert preview_list_complete(list(range(1, 63)), 62) is True
    assert preview_list_complete(list(range(1, 63)), None) is True     # limit 未知只验连续
    assert preview_list_complete([1, 2, 4, 5, 6], 6) is False          # 缺页
    assert preview_list_complete([1, 10, 11, 2], 4) is False           # "10"<"2" 字典序坑形态
    assert preview_list_complete([], 3) is False
    assert preview_list_complete(list(range(1, 7)), 62) is False       # 短收


# ---------------------------------------------------------------- FR3.1 fetch_ladder 离线全链

def _meta_62p() -> FileMeta:
    return FileMeta(title="煤炭设备项目投标报告.docx", fmt="doc",
                    source_url=LIVE_DOC_URL, extra={})


def test_fr3_1_fetch_ladder_full_chain_62_pages_offline():
    """主链离线全跑：.shtm 首跳挖参数→11 批 6 页步进（1,7,...,61）→页清单==preview=62，
    actual=124/filetype/页 URL 清单入 FileMeta.extra；批间 sleep 每批一次（≥1s 语义）。"""
    rec = Recorder()
    html = SHTM_62P.read_text(encoding="utf-8")
    adapter = Book118Adapter(page_loader=lambda url: html,
                             transport=rec.make_transport(62, actual=124),
                             sleep=rec.sleep)
    plan = adapter.plan(_meta_62p())
    result = adapter.fetch_ladder(plan)
    assert result.ok is True and result.pages == 62 and result.coverage == "62/62"
    assert rec.pages == [1, 7, 13, 19, 25, 31, 37, 43, 49, 55, 61]     # 对齐批（page=2 不发）
    assert adapter.verify(result) is True
    extra = plan.meta.extra
    assert extra["book118_doc_id"] == LIVE_DOC_ID
    assert extra["book118_aid"] == LIVE_AID and extra["book118_project_id"] == LIVE_PID
    assert extra["book118_pages_preview"] == 62 and extra["book118_pages_actual"] == 124
    assert extra["book118_filetype"] == "docx"
    assert extra["book118_partial_preview"] is True                    # 62<124=收费预览形态标注
    urls = extra["book118_page_urls"]
    assert sorted(urls) == list(range(1, 63))
    assert all(v.startswith("//view-cache.book118.com/") for v in urls.values())
    assert len(rec.sleeps) >= len(rec.pages) - 1                       # 批间节流在位
    assert "retries=0" in result.detail


def test_fr3_1_fetch_ladder_tail_single_page_when_limit_mod6_eq_1():
    """BOOK118_SPEC §1⑤/§5-7：limit%6==1 末批单页特判（preview=7→批 1(6页)+批 7(1页)）。"""
    html = SHTM_62P.read_text(encoding="utf-8").replace(
        "preview_page: 62", "preview_page: 7")
    rec = Recorder()
    adapter = Book118Adapter(page_loader=lambda url: html,
                             transport=rec.make_transport(7, actual=100), sleep=rec.sleep)
    result = adapter.fetch_ladder(adapter.plan(_meta_62p()))
    assert result.ok is True and result.pages == 7
    assert rec.pages == [1, 7] and result.coverage == "7/7"
    assert adapter.verify(result) is True


def test_fr3_1_fetch_ladder_transient_empty_data_retries_within_5():
    """§3 频控形态（status 200 空 data=empty_data 数据错，T41 P0-2 归数据类 ≤2 次）：
    page=7 两连败后成功，retries=2 不跳页（每次重试均真发经 transport=计数入预算）。"""
    html = SHTM_62P.read_text(encoding="utf-8")
    rec = Recorder()
    adapter = Book118Adapter(page_loader=lambda url: html,
                             transport=rec.make_transport(62, actual=124,
                                                          fail_pages={7: 2}, fail_times=2),
                             sleep=rec.sleep)
    result = adapter.fetch_ladder(adapter.plan(_meta_62p()))
    assert result.ok is True and result.pages == 62
    assert "retries=2(data=2,net=0)" in result.detail and rec.calls == 13  # 11 批+2 数据类重试
    assert adapter.verify(result) is True


def test_fr3_1_fetch_ladder_gated_empty_url_exhausts_retries():
    """闸形态（data 键在、值空串——2026-08 token 过期/缺 callback 形态=missing_first_key
    数据错）恒败：T41 P0-2 数据错不进网络重试层——上限 2 次（原 5 次同层重试=61% 冗余
    风暴），耗尽即 fetch_failed 停拉，LadderResult 如实 False，envelope 首键闸门不放行。"""
    html = SHTM_62P.read_text(encoding="utf-8")
    rec = Recorder()
    adapter = Book118Adapter(page_loader=lambda url: html,
                             transport=rec.make_transport(62, actual=124,
                                                          permanent_fail_page=7),
                             sleep=rec.sleep)
    result = adapter.fetch_ladder(adapter.plan(_meta_62p()))
    assert result.ok is False and result.pages == 6                    # 只收第 1 批
    assert result.coverage == "6/62" and adapter.verify(result) is False
    assert "retries=2(data=2,net=0)" in result.detail
    assert "fetch_failed" in result.detail and "data_retries=2/2" in result.detail
    assert rec.pages.count(7) == 3                                     # 1+2=3 次尝试上限（数据错≤2）


def test_fr3_1_ledger_hit_skips_first_hop(tmp_path):
    """token 台账（store/ledger.py put_token/get_token）命中免首跳：page_loader 哨兵不触发，
    既往 FileMeta.extra 携带 aid/project_id 即整链零浏览器（view_token 跨月稳定，SPEC §2）。"""
    store = Store(str(tmp_path))
    store.put_token(LIVE_TOKEN, site="book118", aid=LIVE_AID, project_id=LIVE_PID,
                    aid_encode=LIVE_DOC_ID, t=LIVE_T, title="煤炭设备项目投标报告.docx",
                    filetype="docx", preview_page=62, actual_page=124)

    def sentinel(url: str) -> str:
        raise AssertionError("台账命中后不该发生浏览器首跳")

    rec = Recorder()
    adapter = Book118Adapter(page_loader=sentinel, store=store,
                             transport=rec.make_transport(62, actual=124), sleep=rec.sleep)
    meta = _meta_62p()
    meta.extra.update({"book118_doc_id": LIVE_DOC_ID, "book118_aid": LIVE_AID,
                       "book118_project_id": LIVE_PID})
    result = adapter.fetch_ladder(adapter.plan(meta))
    assert result.ok is True and result.pages == 62
    assert "params=ledger" in result.detail and adapter.verify(result) is True
    rec2 = store.get_token(site="book118", aid=LIVE_AID, project_id=LIVE_PID)
    assert rec2 is not None and rec2["aid_encode"] == LIVE_DOC_ID      # 复用留痕（last_used 回写）


def test_fr3_1_newview_legacy_fallback_dialect():
    """NewView 遗产链回退（BOOK118_SPEC §1②/§2）：无 .shtm 时 PREVIEW_DATA 四字段照挖，
    旧方言 aid_encode 进 openapi；首响应发现 limit（preview_page 未知形态）。"""
    calls: list[str] = []

    def loader(url: str) -> str:
        calls.append(url)
        return NEWVIEW_GOLD if "NewView" in url else "<html>empty</html>"

    rec = Recorder()
    adapter = Book118Adapter(page_loader=loader,
                             transport=rec.make_transport(13, actual=100), sleep=rec.sleep)
    meta = FileMeta(title="max站样例.pdf", fmt="pdf",
                    source_url="https://max.book118.com/index.php?g=Home&m=NewView&a=index"
                               "&aid=5134312044001323", extra={})
    result = adapter.fetch_ladder(adapter.plan(meta))
    assert result.ok is True and result.pages == 13 and result.coverage == "13/13"
    assert rec.pages == [1, 7, 13]                                     # 13%6==1 末批单页
    assert any("NewView" in u for u in calls)
    assert meta.extra["book118_aid"] == 188244482
    assert "params=newview" in result.detail


def test_fr3_1_doc_deleted_and_no_preview_branches():
    """删除文档（404「该文档已经被删除了」）与无预览（无 view_token）显式分支，不异常吞没。"""
    adapter = Book118Adapter(page_loader=lambda url: "<html><title>很抱歉，该文档已经被删除了"
                                                     "</title></html>")
    result = adapter.fetch_ladder(adapter.plan(_meta_62p()))
    assert result.ok is False and "kind=doc_deleted" in result.detail
    adapter2 = Book118Adapter(page_loader=lambda url: "<html><body>无预览配置</body></html>")
    result2 = adapter2.fetch_ladder(adapter2.plan(_meta_62p()))
    assert result2.ok is False and "kind=no_preview_data" in result2.detail


def test_fr3_1_no_doc_id_raises():
    """meta 无编号且 source_url 不可解析 → no_doc_id 硬错（调用方契约违规不吞）。"""
    adapter = Book118Adapter(page_loader=lambda url: "")
    with pytest.raises(Book118PreviewError) as ei:
        adapter.fetch_ladder(adapter.plan(FileMeta(title="空", fmt="doc")))
    assert ei.value.kind == "no_doc_id"


def test_fr3_1_search_results_parse_and_login_wall():
    """search：渲染结果页→FileMeta（doc_id/source_url/fmt 映射）；匿名登录墙如实 []+reason
    （真实 gated 样本 2026-10-22：tdsearch 被 examine.js+登录弹窗闸死，0 结果链接）。"""
    # 结果页形态=线上 .shtm 锚结构构造（匿名不可得结果，构造形态处注明；解析只认 /html/YYYY/MMDD/编号.shtm）
    rendered = ('<div class="detail"><ul>'
                '<li><a href="/html/2022/0414/5110103104004213.shtm" target="_blank">'
                "煤炭设备项目投标报告（煤炭参考）.docx</a></li>"
                '<li><a href="/html/2021/0906/5022244004004001.shtm" target="_blank">'
                "某工程安全文明施工方案.pdf</a></li></ul></div>")
    adapter = Book118Adapter(page_loader=lambda url: rendered)
    metas = adapter.search("施工方案", 5)
    assert len(metas) == 2 and metas[0].fmt == "doc" and metas[1].fmt == "pdf"
    assert metas[0].extra["book118_doc_id"] == "5110103104004213"
    assert metas[0].source_url.endswith("/html/2022/0414/5110103104004213.shtm")
    assert adapter.reason == ""
    # 真实匿名墙样本：0 结果 + login_gated（活探针留档，非构造）
    walled = Book118Adapter(page_loader=lambda url: SEARCH_GATED.read_text(encoding="utf-8"))
    assert walled.search("施工方案", 5) == []
    assert walled.reason == "login_gated"


def test_fr3_1_verify_gate_coverage_shapes():
    """verify 质检门：coverage got!=limit/短收/非数值形态全拒。"""
    good = type("R", (), {"ok": True, "pages": 62, "coverage": "62/62"})()
    assert Book118Adapter().verify(good) is True
    short = type("R", (), {"ok": True, "pages": 6, "coverage": "6/62"})()
    assert Book118Adapter().verify(short) is False
    bad_count = type("R", (), {"ok": True, "pages": 61, "coverage": "62/62"})()
    assert Book118Adapter().verify(bad_count) is False
    assert Book118Adapter().verify(
        type("R", (), {"ok": False, "pages": 62, "coverage": "62/62"})()) is False


# ---------------- T41 P0 清偿守门（重试分层 P0-2 / preview 漂移二次校验 P0-3）----------------

def test_fr3_1_p0_2_net_error_class_backoff_then_success(tmp_path):
    """T41 P0-2 网络类错（传输异常）：≤3 次指数退避（1s/3s/9s+jitter±50%）后恢复=不跳页
    正常收满；openapi_retry 审计行逐次在账（class=net）；数据/网络两类重试分列计数。"""
    html = SHTM_62P.read_text(encoding="utf-8")
    audit = HarvestAudit(str(tmp_path / "p02_audit.jsonl"))
    calls = {"n": 0}

    def transport(params: dict) -> tuple[int, str]:
        calls["n"] += 1
        page = int(params["page"])
        if page == 7 and calls["n"] <= 3:        # 页7 批两连网络异常后恢复
            raise ConnectionError("simulated net failure")
        return 200, _batch_body(page, 62, actual=124)

    adapter = Book118Adapter(page_loader=lambda url: html, transport=transport,
                             sleep=lambda s: None, audit=audit)
    plan = adapter.plan(_meta_62p())
    result = adapter.fetch_ladder(plan)
    assert result.ok is True and result.pages == 62 and result.coverage == "62/62"
    assert "retries=2(data=0,net=2)" in result.detail
    assert calls["n"] == 13                                        # 11 批+2 网络类重试
    lines = (tmp_path / "p02_audit.jsonl").read_text(encoding="utf-8").splitlines()
    retries_rows = [ln for ln in lines if '"event": "openapi_retry"' in ln
                    or '"event":"openapi_retry"' in ln]
    assert len(retries_rows) == 2 and all("class=net" in ln for ln in retries_rows)


def test_fr3_1_p0_2_net_error_exhausts_at_3(tmp_path):
    """T41 P0-2 网络类错恒败：1+3=4 次尝试上限（原 5 次同层重试废除）→ fetch_failed
    如实停；retries=3(data=0,net=3) 分列如实。"""
    html = SHTM_62P.read_text(encoding="utf-8")
    calls = {"n": 0}

    def transport(params: dict) -> tuple[int, str]:
        calls["n"] += 1
        raise ConnectionError("permanent net failure")

    adapter = Book118Adapter(page_loader=lambda url: html, transport=transport,
                             sleep=lambda s: None)
    result = adapter.fetch_ladder(adapter.plan(_meta_62p()))
    assert result.ok is False and result.pages == 0
    assert "retries=3(data=0,net=3)" in result.detail and "fetch_failed" in result.detail
    assert calls["n"] == 4                                         # 1+3=4 次尝试上限


def test_fr3_1_p0_3_preview_drift_openapi_is_sole_fact_source(tmp_path):
    """T41 P0-3：shtm 声明 preview=10 vs openapi 实测=6 → openapi 唯一事实源：首响应定
    limit=6、单批即止（不追声明 10——absorb max() 锁死声明值即 T37 missing_first_key
    风暴根因）；book118_pages_preview=实测 6（声明值不得覆盖）+preview_drift 双值留档
    +preview_drift 审计告警+partial 标注。"""
    html = SHTM_62P.read_text(encoding="utf-8").replace(
        "preview_page: 62", "preview_page: 10")
    rec = Recorder()
    audit = HarvestAudit(str(tmp_path / "p03_audit.jsonl"))
    adapter = Book118Adapter(page_loader=lambda url: html,
                             transport=rec.make_transport(6, actual=124),
                             sleep=rec.sleep, audit=audit)
    plan = adapter.plan(_meta_62p())
    result = adapter.fetch_ladder(plan)
    assert result.ok is True and result.pages == 6 and result.coverage == "6/6"
    assert rec.pages == [1]                                        # cursor 7>实测 6 → 单批止
    extra = plan.meta.extra
    assert extra["book118_pages_preview"] == 6                     # 实测值（非声明 10）
    assert extra["book118_preview_drift"] == {"shtm_declared": 10,
                                              "openapi_measured": 6}
    assert extra["book118_partial_preview"] is True                # 6<124 收费形态
    lines = (tmp_path / "p03_audit.jsonl").read_text(encoding="utf-8").splitlines()
    assert any('"event": "preview_drift"' in ln or '"event":"preview_drift"' in ln
               for ln in lines) and any("shtm声明" in ln for ln in lines)


def test_fr3_1_p0_3_shortfall_degrades_page_ref_to_received(tmp_path):
    """T41 P0-3②：openapi 上限=10 但实吐 6（页7 批 missing_first_key 数据错耗尽）→
    实吐=唯一事实源：页参照降级为 6+partial+preview_drift(openapi_limit/received) 留档；
    complete/coverage 如实按 6/10 报（fetch_failed 不虚标）。"""
    html = SHTM_62P.read_text(encoding="utf-8").replace(
        "preview_page: 62", "preview_page: 10")
    rec = Recorder()
    adapter = Book118Adapter(page_loader=lambda url: html,
                             transport=rec.make_transport(10, actual=124,
                                                          permanent_fail_page=7),
                             sleep=rec.sleep)
    plan = adapter.plan(_meta_62p())
    result = adapter.fetch_ladder(plan)
    assert result.ok is False and result.pages == 6                # fetch_failed 如实
    assert result.coverage == "6/10"
    extra = plan.meta.extra
    assert extra["book118_pages_preview"] == 6                     # 降级=实吐页数
    assert extra["book118_partial_preview"] is True
    assert extra["book118_preview_drift"]["openapi_limit"] == 10
    assert extra["book118_preview_drift"]["received"] == 6


def test_fr3_1_p0_1_budget_counts_subresources_and_doc_cap(tmp_path):
    """T41 P0-1 预算口径（e2e/book118_accept.py Net 账房，离线仿真零浏览器）：单文档
    全链路硬顶（--doc-cap）与本轮净发超顶（--budget）双闸如约熔断；current_doc 切换
    doc_net 清零；缺省 DOC_NET_CAP=150（研判⑤ browser≤60+openapi≤12+图=页数 收纳值）。"""
    import importlib.util
    e2e_path = _KB_DIR / "harvest_engine" / "e2e" / "book118_accept.py"
    spec = importlib.util.spec_from_file_location("b118_accept_p01", e2e_path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    assert mod.DOC_NET_CAP == 150
    net = mod.Net(tmp_path / "led.jsonl", tmp_path / "memo.json", cap=10, doc_cap=5)
    net.current_doc = "docA"
    net._spend(3, "test")
    assert net.net == 3 and net.doc_net == 3
    with pytest.raises(mod.BudgetExceeded, match="doc_cap=5"):
        net._spend(3, "test2")                                   # 3+3=6>5 单文档硬顶
    net.current_doc = "docB"                                     # 换件清零
    assert net.doc_net == 0 and net.net == 6
    with pytest.raises(mod.BudgetExceeded, match="本轮净发超顶"):
        net._spend(5, "test3")                                   # 6+5-1=10>10 本轮超顶


# ---------------------------------------------------------------- FR3.1 实弹（真实网络，zero-mock）

@pytest.fixture(scope="module")
def chromium():
    """module 级唯一浏览器：fixture 管 launch/close（公约：禁止测试并行开多浏览器）。"""
    from playwright.sync_api import sync_playwright
    # 本机 Clash 注册表代理(127.0.0.1:7892)时死时活：Chromium 缺省跟系统代理→ERR_PROXY_CONNECTION_FAILED；
    # launch(proxy=direct://) 形态实测无效，须裸 args --proxy-server=direct://（探针 step21 对照）；
    # 部署侧代理决策归 orchestrator，测试件只锚定「直连可行」这一实测事实。
    with sync_playwright() as pw:
        browser = pw.chromium.launch(headless=True, args=["--proxy-server=direct://"])
        yield browser
        browser.close()


@pytest.mark.live
def test_fr3_1_live_free_doc_full_chain_and_ledger_reuse(chromium, tmp_path):
    """实弹 1 份免费档全链（FR3.1 验收主证据，任务卡口径）：.shtm 首跳 Playwright 过
    SafeLine 指纹墙挖参数→openapi getPreview→页清单==preview=3、actual=7 入 FileMeta.extra；
    随后台账复用免首跳二跑（page_loader 哨兵守门）。"""
    if _LIVE_SKIP:
        print("[live-skip] KB_HARVEST_SKIP_LIVE=1：实弹免费档全链用例跳过（CI 场景明示）")
        pytest.skip("[live-skip] KB_HARVEST_SKIP_LIVE=1 实弹免费档全链跳过")
    store = Store(str(tmp_path))
    audit = HarvestAudit(str(tmp_path / "harvest_audit.jsonl"))
    adapter = Book118Adapter(browser=chromium, store=store, audit=audit)
    meta = FileMeta(title="某培训学院教学督导制度.docx", fmt="doc",
                    source_url=FREE_DOC_URL, extra={})
    result = adapter.fetch_ladder(adapter.plan(meta))
    assert result.ok is True, result.detail
    assert result.pages == FREE_PREVIEW and result.coverage == f"{FREE_PREVIEW}/{FREE_PREVIEW}"
    assert adapter.verify(result) is True
    extra = meta.extra
    assert extra["book118_doc_id"] == FREE_DOC_ID
    assert extra["book118_aid"] == FREE_AID
    assert extra["book118_pages_preview"] == FREE_PREVIEW
    assert extra["book118_pages_actual"] == FREE_ACTUAL
    assert extra["book118_filetype"] == "docx"
    urls = extra["book118_page_urls"]
    assert sorted(urls) == list(range(1, FREE_PREVIEW + 1))
    assert all(str(v).startswith("//view-cache.book118.com/") for v in urls.values())
    assert "stopped=exhausted" in result.detail and "complete=True" in result.detail
    lines = (tmp_path / "harvest_audit.jsonl").read_text(encoding="utf-8").splitlines()
    assert any('"event": "first_hop"' in ln or '"event":"first_hop"' in ln for ln in lines)
    # 台账复用免首跳：同 store 新适配器，page_loader 哨兵=零浏览器整链
    def sentinel(url: str) -> str:
        raise AssertionError("台账命中后不该发生浏览器首跳")

    rec = Recorder()
    again = Book118Adapter(page_loader=sentinel, store=store,
                           transport=rec.make_transport(FREE_PREVIEW, actual=FREE_ACTUAL),
                           sleep=rec.sleep)
    meta2 = FileMeta(title="某培训学院教学督导制度.docx", fmt="doc",
                     source_url=FREE_DOC_URL, extra={})
    meta2.extra.update({"book118_doc_id": extra["book118_doc_id"],
                        "book118_aid": extra["book118_aid"],
                        "book118_project_id": extra["book118_project_id"]})
    result2 = again.fetch_ladder(again.plan(meta2))
    assert result2.ok is True and "params=ledger" in result2.detail


@pytest.mark.live
def test_fr3_1_live_multi_batch_62_pages(chromium):
    """实弹多批证明档（preview=62/actual=124）：6 页/批 11 批对齐步进 + 实弹频控形态
    （missing_first_key 重试自愈，单批≤5）——免费档单批盖不住的批间语义在此档实证。"""
    if _LIVE_SKIP:
        print("[live-skip] KB_HARVEST_SKIP_LIVE=1：实弹多批档用例跳过（CI 场景明示）")
        pytest.skip("[live-skip] KB_HARVEST_SKIP_LIVE=1 实弹多批档跳过")
    adapter = Book118Adapter(browser=chromium)
    meta = _meta_62p()
    result = adapter.fetch_ladder(adapter.plan(meta))
    assert result.ok is True, result.detail
    assert result.pages == 62 and result.coverage == "62/62"
    assert adapter.verify(result) is True
    assert "stopped=exhausted" in result.detail and "complete=True" in result.detail
    assert meta.extra["book118_pages_preview"] == 62
    assert meta.extra["book118_pages_actual"] == 124
    assert sorted(meta.extra["book118_page_urls"]) == list(range(1, 63))


@pytest.mark.live
def test_fr3_1_live_search_anonymous(chromium):
    """实弹 search：匿名=登录墙如实 []+reason（2026-10-22 形态）；账号 cookie 到位后同路复活。"""
    if _LIVE_SKIP:
        print("[live-skip] KB_HARVEST_SKIP_LIVE=1：实弹 search 用例跳过（CI 场景明示）")
        pytest.skip("[live-skip] KB_HARVEST_SKIP_LIVE=1 实弹 search 跳过")
    adapter = Book118Adapter(browser=chromium)
    metas = adapter.search("施工方案", 5)
    if not metas:
        assert adapter.reason in ("login_gated", "empty_result"), adapter.reason
        print(f"[live-wall] 匿名搜索墙如实上报: {adapter.reason}")
        return
    for m in metas:
        assert m.extra.get("book118_doc_id") and m.source_url.endswith(".shtm")
        assert m.title
