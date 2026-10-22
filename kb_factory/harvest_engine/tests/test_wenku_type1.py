# -*- coding: utf-8 -*-
"""T35 单测：wenku 类型1 重组（editor 滚动展开 + XML 降级 renderXmlHtml）+ 注记#5 字数参照。

被测物 = kb_factory.harvest_engine.adapters.wenku 的 T35 增量段（T18/T22/T26/T31 已锁契约
只增不改；类型1 占位钉本任务兑现）：
- 判型（§5.2 分支3）：rtcsRangeInfo.length>0 → type1（htmlUrls json 桶/数组优先序在前）；
- editor 腿=真浏览器（§7.4 全套时序照搬）：隐藏页载 view/{docId}.html（warmup+referer 过
  百度安全验证——T28 经验；签名窗 session 复用 signer.ses=signer.context 开页）→ 等5s →
  15 轮 scrollBy(0,2000) 每 500ms → 三文案展开点击（['查看剩余全文','继续阅读','展开全文']
  在 a,button,span,div 找文本命中点击）→ 等5s → 25 轮滚动 → 等3s → 抽 .ql-editor
  innerHTML → calls 偏移 510 A4 流式模板 → html_to_pdf（@page A4 补齐位）；
- XML 降级腿（rtcsRangeInfo 触发，§6.4/§7.5）：wkrtcs getbdjson 桶式拉取（3 项/桶、
  **md5sum 无键名直拼怪癖原样照抄**、range encodeURIComponent 以 _ 连接、callback 桶序号）→
  renderXmlHtml（A4 流式 .page、BOS docconvert896 图 src、onerror 隐藏、p/span/div 标签
  映射、span style 类引用）→ html_to_pdf；
- 注记#5（SPEC_REVIEW 残留#5 落地）：类型1 字数参照=editor DOM 文本字数
  （quality_gate ref_chars_source="type1"，词表词义钉死「editor DOM 文本」，不走 pageJson
  /OCR）；XML 降级径=同词（document.xml 页对象树=同一编辑器文档的服务端 DOM）；
- §8-8：.ql-editor 空 且 rtcsRangeInfo 空 → 「未找到 .ql-editor 内容且无 rtcsRangeInfo
  可降级」；零桶（端点 params error/缺 document.xml）→ 如实 ok=False 不产空件。

现场校准（2026-10-22 实弹探针，证据=fixtures/_t35_probe_type1.json：三轮 20 词族 60 探
60/60 全 type3）：今日站方检索面无类型1 件在架 → 实弹走任务卡明示的**组合口径**：
- editor 腿=离线 fixture 页（route 本地 fulfill 造 .ql-editor 页，真 Chromium 真节拍跑
  §7.4 全时序 5s+15×0.5s+5s+25×0.5s+3s，口径如实记录）；
- XML 腿=真实 wkrtcs 端点合成令牌实弹（2026-10-22 单发实测：HTTP 200 +
  rtcs({"status":{"code":200002,"error":"params error"}}) → 零桶如实失败，transport/信封
  实测在案；真 rtcs 件命中时自动切换全真桶令牌径）。

测试纪律（WORKER_CONVENTIONS）：
- 离线单测零网络：XML 腿经 asset_fetch 注入点（网络腿，任务卡明示）；初始腿经 fetch_html
  注入点（T22 同缝）；editor 腿=route 本地 fulfill（Chromium 真 页真 evaluate，零外网）；
  打印腿=本地 Chromium 加载本地 HTML（file:// 零网络，fixture 正文无外链资源）。
- 实弹用例（@pytest.mark.live）=真实网络 zero-mock；KB_HARVEST_SKIP_LIVE=1 时跳过
  （跳过时明示）。Playwright sync API 不可嵌套：打印腿在无外层 sync 上下文时执行。
"""
import json
import os
import re
import sys
import time
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
    from kb_factory.harvest_engine.adapters.base import LadderResult
    from kb_factory.harvest_engine.adapters.wenku import (
        A4_PAGE_CSS, BOS_DOCCONVERT_TMPL, EDITOR_EXPAND_JS, EDITOR_EXPAND_TEXTS,
        EDITOR_QL_HTML_JS, EDITOR_SCROLL_JS, GETBDJSON_CALLBACK_TMPL, RTCS_BUCKET_SIZE,
        TYPE1_EDITOR_CSS, TYPE1_REF_CHARS_SOURCE, TYPE1_XML_CSS, WKRTCS_GETBDJSON_BASE,
        EditorExtractResult, ReaderInfoLegResult, WenkuDownloadAdapter,
        WenkuEditorEmptyError, build_getbdjson_url, canonical_view_url,
        editor_dom_text_chars, fetch_xml_blocks, judge_doc_type, render_editor_html,
        render_xml_html, run_editor_sequence, xml_dom_text_chars)
    from kb_factory.harvest_engine.audit import HarvestAudit
    from kb_factory.harvest_engine.pdf.html_print_pdf import PX_PER_PT_CSS
    from kb_factory.harvest_engine.quality_gate import REF_CHARS_SOURCE_DESC
except ImportError:
    from channel_adapters.base import FileMeta
    from harvest_engine.adapters.base import LadderResult
    from harvest_engine.adapters.wenku import (
        A4_PAGE_CSS, BOS_DOCCONVERT_TMPL, EDITOR_EXPAND_JS, EDITOR_EXPAND_TEXTS,
        EDITOR_QL_HTML_JS, EDITOR_SCROLL_JS, GETBDJSON_CALLBACK_TMPL, RTCS_BUCKET_SIZE,
        TYPE1_EDITOR_CSS, TYPE1_REF_CHARS_SOURCE, TYPE1_XML_CSS, WKRTCS_GETBDJSON_BASE,
        EditorExtractResult, ReaderInfoLegResult, WenkuDownloadAdapter,
        WenkuEditorEmptyError, build_getbdjson_url, canonical_view_url,
        editor_dom_text_chars, fetch_xml_blocks, judge_doc_type, render_editor_html,
        render_xml_html, run_editor_sequence, xml_dom_text_chars)
    from harvest_engine.audit import HarvestAudit
    from harvest_engine.pdf.html_print_pdf import PX_PER_PT_CSS
    from harvest_engine.quality_gate import REF_CHARS_SOURCE_DESC

import pypdfium2 as pdfium  # noqa: E402  （NFR6：pypdfium2 实测，禁 fitz）

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"
DOC_ID = "5f31c0de11a1b2c3d4e5f60718293a4b5c6d7e8f"  # 40 位 hex 合成 docId（形态=新式实测）
VIEW_URL = canonical_view_url(DOC_ID)
#: A4 = 210×297mm（printToPDF 缺省页尺寸；Playwright pdf 缺省 Letter → extra_css @page 补齐）
A4_W_PT, A4_H_PT = 210 / 25.4 * 72, 297 / 25.4 * 72
_TOL_PT = 0.6


# ---------------- fixture 工厂（实弹形态校准） ----------------

def _rtcs_entry(page: int, range_: str) -> dict:
    return {"page": page, "range": range_}


def _type1_reader_info(entries, *, page=None, show=None, bucket="bx1", rsign="rs1",
                       md5="md5x") -> dict:
    n = page if page is not None else max((e["page"] for e in entries), default=1)
    return {"showPage": show if show is not None else n, "page": n, "tplKey": "editor",
            "htmlUrls": [], "rtcsRangeInfo": list(entries),
            "bucketNum": bucket, "rsign": rsign, "md5sum": md5}


def _ndview_html(page_data: dict) -> str:
    return ("<html><head><meta charset='utf-8'></head><body><script>\n"
            "var pageData = " + json.dumps(page_data, ensure_ascii=False) + ";\n"
            "</script></body></html>")


def _bucket_jsonp(blocks: list) -> str:
    """getbdjson 应答形态（§6.4）：JSONP 壳 + document.xml 页对象数组。"""
    return ("sf_edu_wenku_rtcs_doc_jsonp_1_N({\"document.xml\": "
            + json.dumps(blocks, ensure_ascii=False) + "})")


#: 端点 params error 实测形态（2026-10-22 合成令牌单发实弹：HTTP 200 + rtcs(...) 壳）
_PARAMS_ERR_JSONP = 'rtcs({"status":{"code":200002,"error":"params error","success":false}})'


def _xml_page_object(*nodes, style=None) -> dict:
    return {"c": list(nodes), "style": dict(style or {})}


def _asset_fetch_spy(calls, responses):
    """XML 腿网络注入点（任务卡明示）：按 URL 记录 (url,headers) 并按 callback 桶序号应答
    （responses={桶序号: jsonp 文本}；缺省=200 空体→解析失败=空桶）。"""
    def fetch(url, headers, timeout, *, binary=False):
        calls.append({"url": url, "binary": binary, "headers": dict(headers)})
        m = re.search(r"callback=sf_edu_wenku_rtcs_doc_jsonp_1_(\d+)", url)
        idx = int(m.group(1)) if m else -1
        body = responses.get(idx)
        return (200, body) if body is not None else (200, "")
    return fetch


def _meta(doc_id=DOC_ID, title="类型1样例-百度文库", pages=2) -> FileMeta:
    return FileMeta(title=title, fmt="doc", pages=pages, perm="green",
                    source_url=f"https://wenku.baidu.com/view/{doc_id}.html",
                    extra={"doc_id": doc_id})


def _bundle(ri: dict, *, doc_id=DOC_ID, title="类型1样例", page=None) -> ReaderInfoLegResult:
    return ReaderInfoLegResult(doc_id=doc_id, title_raw=title + "-百度文库",
                               title_clean=title, page=page if page is not None else ri.get("page", 1),
                               show_page=ri.get("showPage", 1), page_data={}, reader_info=ri,
                               fill_needed=False, fill=None, stop_kind="not_needed",
                               tri_cap_seen=False, html_urls_pages={}, wall_status=None,
                               coverage=f"{ri.get('showPage', 1)}/{ri.get('page', 1)}", detail="")


def _audit_lines(path) -> list:
    p = Path(path)
    if not p.exists():
        return []
    return [json.loads(line) for line in p.read_text(encoding="utf-8").splitlines() if line]


def _page_sizes(pdf_path) -> list:
    doc = pdfium.PdfDocument(str(pdf_path))
    try:
        return [(pg.get_width(), pg.get_height()) for pg in doc]
    finally:
        doc.close()


def _pdf_text(pdf_path) -> str:
    doc = pdfium.PdfDocument(str(pdf_path))
    try:
        parts = []
        for i in range(len(doc)):
            pg = doc[i]
            try:
                tp = pg.get_textpage()
                try:
                    parts.append(tp.get_text_range())
                finally:
                    tp.close()
            finally:
                pg.close()
        return "".join(parts)
    finally:
        doc.close()


# ---------------- editor fixture 页（route 本地 fulfill 口径） ----------------

_FIXTURE_PARA = "算法与数据结构基础：线性表、栈与队列、树与二叉树、图、查找与排序。"


def _editor_fixture_html() -> str:
    """离线 .ql-editor fixture 页（任务卡明示口径）：三文案展开按钮 + ql-editor + 滚动/
    展开计数器（时序证据：__scrolls_at_click 钉 §7.4 步序——点击时恰滚过 15 轮）。"""
    return f"""<!doctype html><html><head><meta charset="utf-8"><title>fixture</title></head>
<body>
<div id="banner"><span id="expand" style="display:block;cursor:pointer">查看剩余全文</span></div>
<div class="ql-editor" id="ql"><p>{_FIXTURE_PARA}</p><p>{_FIXTURE_PARA}</p></div>
<script>
  window.__scrolls = 0;
  const _sb = window.scrollBy.bind(window);
  window.scrollBy = function(x, y) {{ window.__scrolls += 1; return _sb(x, y); }};
  window.__expanded = false;
  window.__scrolls_at_click = -1;
  const _onExpand = function() {{
    if (!window.__expanded) {{
      window.__expanded = true;
      window.__scrolls_at_click = window.__scrolls;
      document.getElementById('ql').insertAdjacentHTML('beforeend', '<p>展开后新增段落</p>');
    }}
  }};
  // 展开点击挂容器+按钮双层（els[0]=文档序首个命中元素=外层容器——真实站点同型委托）
  document.getElementById('banner').addEventListener('click', _onExpand);
  document.getElementById('expand').addEventListener('click', _onExpand);
</script>
</body></html>"""


def _install_routes(context, seen: dict | None = None):
    """view+warmup 两条本地路由（零外网）；seen 在场则记录请求事实（url/referer）。"""

    def _view(route):
        if seen is not None:
            seen["url"] = route.request.url
            seen["referer"] = route.request.headers.get("referer")
        route.fulfill(status=200, content_type="text/html; charset=utf-8",
                      body=_editor_fixture_html())

    def _warmup(route):
        if seen is not None:
            seen["warmup"] = route.request.url
        route.fulfill(status=200, content_type="text/html; charset=utf-8",
                      body="<html><body>warmup</body></html>")

    context.route(VIEW_URL, _view)
    context.route("https://www.baidu.com/", _warmup)


# ---------------- 纯函数：判型 + getbdjson URL（§6.4 桶式+md5sum 怪癖） ----------------

def test_fr2_ac2_judge_doc_type_type1_branch_and_priority():
    """§5.2 分支3：rtcsRangeInfo.length>0 → type1；htmlUrls json 桶（type3）/数组（type2）
    优先在前（唯一权威序，rtcs 在场也不夺型）。"""
    assert judge_doc_type({"htmlUrls": [], "rtcsRangeInfo": [_rtcs_entry(1, "r0")]}) == "type1"
    assert judge_doc_type({"htmlUrls": {}, "rtcsRangeInfo": [_rtcs_entry(1, "r0"),
                                                             _rtcs_entry(2, "r1")]}) == "type1"
    assert judge_doc_type({"htmlUrls": {"json": [{"pageIndex": 1}]},
                           "rtcsRangeInfo": [_rtcs_entry(1, "r0")]}) == "type3"   # json 桶优先
    assert judge_doc_type({"htmlUrls": ["https://x/p.png?pn=1"],
                           "rtcsRangeInfo": [_rtcs_entry(1, "r0")]}) == "type2"   # 数组优先
    assert judge_doc_type({"htmlUrls": [], "rtcsRangeInfo": []}) == "unknown"


def test_fr2_ac2_build_getbdjson_url_buckets_and_md5sum_quirk():
    """§6.4 逐段核验模板：3 项/桶（5 项→2 桶）；pn=桶内首页.page；rn=3；
    range=encodeURIComponent(各项.range 以 _ 连接)；rsign/bucketNum 原样不转义；
    **md5sum 无键名直拼**（&dataType=rtcs&isWpNote=false{md5sum}&callback=…——原作怪癖
    原样照抄）；callback=sf_edu_wenku_rtcs_doc_jsonp_1_{桶序号 1 起}；_={now_ms}。"""
    from urllib.parse import quote
    entries = [_rtcs_entry(1, "r0"), _rtcs_entry(2, "r1"), _rtcs_entry(3, "r2"),
               _rtcs_entry(4, "r3"), _rtcs_entry(5, "r4")]
    ri = _type1_reader_info(entries, bucket="b77", rsign="sig1", md5="md507")
    enc_range = quote("r0_r1_r2", safe="-_.!~*'()")
    url1 = build_getbdjson_url(ri, entries[0:3], 1, now_ms=1700000000000)
    assert url1 == (f"{WKRTCS_GETBDJSON_BASE}?bucketNum=b77&pn=1&rn=3"
                    f"&range={enc_range}"
                    "&rsign=sig1&dataType=rtcs&isWpNote=falsemd507"
                    f"&callback={GETBDJSON_CALLBACK_TMPL.format(i=1)}&_=1700000000000")
    url2 = build_getbdjson_url(ri, entries[3:5], 2, now_ms=1700000000000)
    assert "&pn=4&rn=3&" in url2 and "range=r3_r4" in url2
    assert url2.endswith(f"&callback={GETBDJSON_CALLBACK_TMPL.format(i=2)}&_=1700000000000")
    # md5sum 缺席 → 直拼空串（&isWpNote=false&callback=…，服务端容错口径 SPEC medium）
    ri_nomd5 = _type1_reader_info(entries[:3], md5="")
    assert "&isWpNote=false&callback=" in build_getbdjson_url(ri_nomd5, entries[:3], 1, now_ms=1)
    # range 特殊字符走 encodeURIComponent（保留字集外全转义）
    ri_sp = _type1_reader_info([_rtcs_entry(2, "a+b/c?d")])
    assert "&range=a%2Bb%2Fc%3Fd&" in build_getbdjson_url(ri_sp, [_rtcs_entry(2, "a+b/c?d")],
                                                          1, now_ms=1)


def test_fr2_ac2_fetch_xml_blocks_bucket_pulls_referer_parse_and_empty():
    """桶式拉取（§6.4）：5 项→2 桶各一发（腿头 Referer=wenku 首页+UA）；JSONP 剥壳取
    document.xml 桶式并集（桶序）；端点 params error（实弹实测壳名 rtcs）/缺 document.xml/
    空体 → 空桶如实计数不中断；requests/buckets_ok/buckets_empty 全实测。"""
    entries = [_rtcs_entry(i, f"r{i}") for i in range(1, 6)]
    ri = _type1_reader_info(entries)
    b1 = _bucket_jsonp([_xml_page_object("第一页文字", {"t": "p", "c": ["段落甲"]})])
    b2 = _bucket_jsonp([_xml_page_object("第二页文字")])
    calls: list = []
    assets = fetch_xml_blocks(ri, asset_fetch=_asset_fetch_spy(calls, {1: b1, 2: b2}),
                              now_ms=7, min_interval=0)
    assert len(assets.blocks) == 2 and assets.stats == {"requests": 2, "buckets_ok": 2,
                                                        "buckets_empty": 0}
    assert len(calls) == 2 and calls[0]["binary"] is False
    for c in calls:
        assert c["headers"]["Referer"] == "https://wenku.baidu.com/"
        assert c["headers"]["User-Agent"] and "wkrtcs.bdimg.com/rtcs/getbdjson" in c["url"]
    # 空桶三态：params error（实弹实测壳名 rtcs）/缺 document.xml/空体 → 空桶如实
    calls2: list = []
    miss = _asset_fetch_spy(calls2, {1: _PARAMS_ERR_JSONP,
                                     2: 'sf_edu_wenku_rtcs_doc_jsonp_1_2({"status": {"code": 0}})'})
    assets2 = fetch_xml_blocks(ri, asset_fetch=miss, now_ms=7, min_interval=0)
    assert assets2.blocks == [] and assets2.stats == {"requests": 2, "buckets_ok": 0,
                                                      "buckets_empty": 2}
    # rtcs 缺席 → 零请求零桶（不发明请求）
    assets3 = fetch_xml_blocks({"rtcsRangeInfo": []}, asset_fetch=_asset_fetch_spy([], {}),
                               min_interval=0)
    assert assets3.blocks == [] and assets3.stats["requests"] == 0


def test_fr2_ac2_fetch_xml_blocks_min_interval_paced():
    """桶间节流（§9 速率自律）：min_interval>0 时逐桶 sleep（首桶不睡；注入点计数）。"""
    slept: list = []
    entries = [_rtcs_entry(i, f"r{i}") for i in range(1, 7)]            # 6 项→2 桶
    fetch_xml_blocks(_type1_reader_info(entries),
                     asset_fetch=_asset_fetch_spy([], {1: _bucket_jsonp([_xml_page_object("a")]),
                                                       2: _bucket_jsonp([_xml_page_object("b")])}),
                     min_interval=0.25, sleep=slept.append, now_ms=7)
    assert slept == [0.25]


# ---------------- 重组 HTML：§7.5 renderXmlHtml + calls 510 editor 模板（逐字） ----------------

def test_fr2_ac2_render_xml_html_spec_css_img_bos_span_tags():
    """§7.5 逐字模板：XML CSS 原文（body 无 padding/.page 210mm+20mm 18mm+page-break-after:
    always/last-child auto/p/span 规则）；页 ``<div class="page">`` 节点 ``\\n`` 连接、页间
    ``\\n``；img=BOS docconvert896/wk/{docId}/{c}+width:{w||auto}px+onerror 隐藏；span=
    style 类引用合成；标签映射 p→p、span→span、其余→div；字符串节点 esc。"""
    style = {"s1": {"font-size": "14px", "color": "#333"}}
    blocks = [
        _xml_page_object(
            {"t": "p", "c": ["段落<b>甲</b>"], "r": "s1"},
            {"t": "img", "c": "imgToken012", "w": 340},
            {"t": "img", "c": ""},                                    # c 空 → img 分支跳过
            {"t": "span", "c": "行内文字", "r": ["s1"]},
            {"t": "custom", "c": ["嵌套"]},
            "裸字符串节点&<>",
            style=style),
        _xml_page_object({"t": "p", "c": "第二页"}, style={})]
    html = render_xml_html('题<b>&"\'</b>', blocks, DOC_ID)
    assert ("<title>题&lt;b&gt;&amp;&quot;&#39;&lt;/b&gt;</title>\n<style>" + TYPE1_XML_CSS
            + "</style>\n</head><body>") in html                        # §7.5 模板逐字
    assert TYPE1_XML_CSS == (
        'body{font-family:"PingFang SC","Microsoft YaHei","微软雅黑","SimSun","宋体",Arial,'
        'sans-serif;margin:0;color:#000}\n'
        '.page{width:210mm;padding:20mm 18mm;box-sizing:border-box;page-break-after:always}\n'
        '.page:last-child{page-break-after:auto}p{margin:0;padding:0}span{white-space:pre-wrap}')
    assert html.count('<div class="page">') == 2
    seg0 = html.split('<div class="page">')[1]
    assert '<p style="font-size:14px;color:#333">段落&lt;b&gt;甲&lt;/b&gt;</p>' in seg0  # r 单值→类样式
    assert (f'<img src="{BOS_DOCCONVERT_TMPL.format(doc_id=DOC_ID, c="imgToken012")}"'
            ' style="max-width:100%;width:340px;height:auto;display:block;margin:8px auto" '
            "onerror=\"this.style.display='none'\"/>") in seg0
    assert seg0.count("wkbjcloudbos.bdimg.com/v1/docconvert896/wk/") == 1   # c 空的 img 不产 src
    assert '<span style="font-size:14px;color:#333">行内文字</span>' in seg0
    assert '<div style="">嵌套</div>' in seg0                              # 其余标签→div
    assert "裸字符串节点&amp;&lt;&gt;" in seg0
    assert render_xml_html("t", [], DOC_ID).endswith("<body></body></html>")  # 零页防御
    # w 缺席 → width:autopx（原作 node.w||'auto' 直拼+无空格原文怪癖：非法声明被浏览器
    # 丢弃回落 max-width——calls 28982/29015 段序实证 width:{w}px 紧贴）
    html_w = render_xml_html("t", [_xml_page_object({"t": "img", "c": "tok"})], DOC_ID)
    assert 'style="max-width:100%;width:autopx;' in html_w


def test_fr2_ac2_render_editor_html_calls510_template_verbatim():
    """editor 主径模板（calls 偏移 510 逐字）：body padding 20mm 18mm+max-width:210mm+
    box-sizing / p{margin:0;padding:0} / img max-width:100%；ql innerHTML **原样内联**
    （不清洗不转义——原作直接拼）；title esc；wrapper ``</title>\\n<style>`` 原文。"""
    ql = '<h1>标题</h1><p>第一段<em>强调</em></p><p><img src="data:image/png;base64,QUJD"/></p>'
    html = render_editor_html('题<b>&"\'</b>', ql)
    assert ("<title>题&lt;b&gt;&amp;&quot;&#39;&lt;/b&gt;</title>\n<style>" + TYPE1_EDITOR_CSS
            + "</style>\n</head><body>" + ql + "</body></html>") in html
    assert TYPE1_EDITOR_CSS == (
        'body{font-family:"PingFang SC","Microsoft YaHei","微软雅黑","SimSun","宋体",Arial,'
        'sans-serif;margin:0;padding:20mm 18mm;color:#000;max-width:210mm;box-sizing:border-box}\n'
        'p{margin:0;padding:0}img{max-width:100%;height:auto}')
    assert render_editor_html("t", "").endswith("<body></body></html>")   # 空 ql 防御
    assert A4_PAGE_CSS == "@page{size:A4;margin:0}"                       # 打印页几何补齐位


def test_fr2_ac2_editor_dom_text_chars_and_xml_dom_text_chars():
    """注记#5：类型1 字数参照=editor DOM 文本字数（剥标签+解实体+去空白；与 quality_gate
    门②非空白口径同构）；XML 降级径=同词（页对象树裸串+c 串递归合计）。"""
    ql = '<p>你好 <b>世界</b>&amp;朋友</p><p>第二&nbsp;段</p><img src="x.png"/>'
    assert editor_dom_text_chars(ql) == len("你好世界&朋友第二段")           # 标签剥离+实体解码+去空白
    assert editor_dom_text_chars("") == 0 and editor_dom_text_chars("<p>　</p>") == 0
    blocks = [_xml_page_object("第一页", {"t": "p", "c": ["甲乙丙"]},
                               {"t": "img", "c": "tok", "w": 10}),
              _xml_page_object({"t": "p", "c": ["丁", "戊"]})]
    assert xml_dom_text_chars(blocks) == len("第一页甲乙丙丁戊")             # img 节点不计字
    assert "editor DOM 文本" in REF_CHARS_SOURCE_DESC["type1"]               # 词表词义钉死（防漂移）
    assert TYPE1_REF_CHARS_SOURCE == "type1"


def test_fr2_ac2_editor_js_constants_verbatim():
    """§7.4 脚本原文钉死（calls 52176/52645 + scrollBy 原文）：三文案清单/选择器面
    a,button,span,div/首中即点击返文案；.ql-editor 抽取式；scrollBy(0, 2000)。"""
    assert EDITOR_EXPAND_TEXTS == ("查看剩余全文", "继续阅读", "展开全文")
    assert ("[...document.querySelectorAll('a,button,span,div')]"
            ".filter(el => el.textContent.includes(text))") in EDITOR_EXPAND_JS
    assert "els[0].click(); return text;" in EDITOR_EXPAND_JS
    assert ("const ql = document.querySelector('.ql-editor'); "
            "return ql ? ql.innerHTML : '';") in EDITOR_QL_HTML_JS
    assert EDITOR_SCROLL_JS == "window.scrollBy(0, 2000)"
    assert RTCS_BUCKET_SIZE == 3


# ---------------- editor 腿：§7.4 全时序（route 本地 fulfill 真 Chromium） ----------------

def test_fr2_ac2_extract_editor_html_full_sequence_via_route_fixture():
    """§7.4 全套时序（真 Chromium、route 本地 fulfill 零外网、sleep 注入确定性节拍）：
    warmup 先访（T28 口径）→ view/{docId}.html 带 referer → 5s→15 轮滚动→三文案命中点击
    （点击时 __scrolls==15 钉步序）→5s→25 轮滚动→3s→抽 .ql-editor innerHTML；
    总滚动 40 轮、展开生效、ql 含展开后新增段落；无 signer/page 注入=硬报（不静默）。"""
    from playwright.sync_api import sync_playwright
    seen: dict = {}
    with sync_playwright() as pw:
        browser = pw.chromium.launch(headless=True, args=["--no-proxy-server"])
        try:
            context = browser.new_context()
            _install_routes(context, seen)
            page = context.new_page()
            adapter = WenkuDownloadAdapter()
            with pytest.raises(RuntimeError, match="signer"):
                adapter.extract_editor_html(DOC_ID)                       # 双缺=硬报（§9 清单#2）
            got = adapter.extract_editor_html(DOC_ID, page=page,
                                              warmup_url="https://www.baidu.com/",
                                              sleep=lambda s: None)       # 节拍注入（live 用例跑真节拍）
            assert isinstance(got, EditorExtractResult)
            assert seen["url"] == VIEW_URL and seen["referer"] == "https://wenku.baidu.com/"
            assert seen["warmup"] == "https://www.baidu.com/" and got.warmup_used is True
            assert got.source == "caller_page" and got.clicked_text == "查看剩余全文"
            assert "<p>" in got.ql_html and "展开后新增段落" in got.ql_html
            assert page.evaluate("() => window.__scrolls") == 40          # 15+25 全轮滚动
            assert page.evaluate("() => window.__scrolls_at_click") == 15  # 步序钉死：点击在 15 轮后
            assert page.evaluate("() => window.__expanded") is True
        finally:
            browser.close()


def test_fr2_ac2_run_editor_sequence_no_expand_hit():
    """无命中文案（fixture 无按钮）→ clicked=None、ql 照抽（§7.4 步3 不依赖步2 命中）。"""
    from playwright.sync_api import sync_playwright
    with sync_playwright() as pw:
        browser = pw.chromium.launch(headless=True, args=["--no-proxy-server"])
        try:
            context = browser.new_context()
            context.route(VIEW_URL, lambda route: route.fulfill(
                status=200, content_type="text/html; charset=utf-8",
                body='<!doctype html><html><body><div class="ql-editor"><p>仅正文</p></div>'
                     '</body></html>'))
            page = context.new_page()
            page.goto(VIEW_URL)
            ql_html, clicked = run_editor_sequence(page, sleep=lambda s: None)
            assert ql_html == "<p>仅正文</p>" and clicked is None
        finally:
            browser.close()


# ---------------- 段3 全链：分派接线 + printToPDF + 注记#5 ----------------

def test_fr2_ac2_fetch_ladder_type1_xml_degrade_full_chain(tmp_path):
    """FR2.AC2 主验收（XML 降级腿，离线全链）：ndview 初始腿（注入）→ 判型 type1 →
    wkrtcs 桶式拉取（注入，2 桶全 document.xml）→ renderXmlHtml → printToPDF（@page A4
    补齐）→ pypdfium2 实测页数==桶页对象数、逐页尺寸==A4 595.28×841.89pt（±0.6pt）；
    注记#5：chars=xml_dom_text_chars（ref_chars_source=type1）→ manifest expected_pages
    （全桶==page）→ 质检门四门真跑；ledger 四事件；临时 HTML 用毕即删。"""
    entries = [_rtcs_entry(i, f"r{i}") for i in (1, 2, 3, 4)]
    ri = _type1_reader_info(entries, page=2, show=2)
    fetch_html = lambda url, headers, timeout: (  # noqa: E731
        200, _ndview_html({"title": "类型1样例-百度文库", "readerInfo": ri}))
    blocks = [_xml_page_object({"t": "p", "c": ["第一页正文甲乙丙丁戊己庚辛"]}, style={}),
              _xml_page_object({"t": "p", "c": ["第二页正文子丑寅卯辰巳午未"]}, style={})]
    calls: list = []
    leg = _asset_fetch_spy(calls, {1: _bucket_jsonp(blocks[:1]), 2: _bucket_jsonp(blocks[1:])})
    audit_path = tmp_path / "audit.jsonl"
    adapter = WenkuDownloadAdapter(audit=HarvestAudit(path=str(audit_path)))
    result = adapter.fetch_ladder(adapter.plan(_meta(pages=2)), fetch_html=fetch_html,
                                  asset_fetch=leg, out_dir=tmp_path / "out", now_ms=7)
    assert isinstance(result, LadderResult) and result.ok is True
    assert result.ladder_used == "L1" and result.coverage == "2/2"
    assert result.artifact_path and Path(result.artifact_path).is_file()
    assert result.pages == 2 and len(calls) == 2
    expected_chars = xml_dom_text_chars(blocks)
    assert result.chars == expected_chars                              # 注记#5：DOM 文本字数
    for w, h in _page_sizes(result.artifact_path):
        assert abs(w - A4_W_PT) <= _TOL_PT and abs(h - A4_H_PT) <= _TOL_PT, (
            f"PDF 页尺寸 {w}x{h}pt != A4 {A4_W_PT:.2f}x{A4_H_PT:.2f}pt")
    manifest = json.loads((tmp_path / "out" / "类型1样例_manifest.json").read_text(encoding="utf-8"))
    assert manifest["ref_chars_source"] == "type1"                     # 五型词表之 type1
    assert manifest["ref_chars"] == expected_chars
    assert manifest["expected_pages"] == 2 and "preview_limit" not in manifest
    lines = _audit_lines(audit_path)
    assert [l["event"] for l in lines] == ["readerinfo_init", "recon_dispatch",
                                           "recon_type1", "quality_gate"]
    assert lines[1]["status"] == "type1" and "branch=type1" in lines[1]["detail"]
    assert lines[2]["status"] == "ok" and "branch=xml_degrade" in lines[2]["detail"]
    assert lines[3]["status"] == "ok" and lines[3]["count"] == 4       # 四门全过
    assert not list((tmp_path / "out").glob("_render_type1_*.html"))   # 临时件即删（W:683 同型）


def test_fr2_ac2_dispatch_type1_editor_path_full_chain_and_note5(tmp_path):
    """FR2.AC2 editor 主径（离线全链）：extract_editor_html（route fixture，节拍注入）→
    dispatch(editor_html=…) → calls510 A4 流式 → printToPDF → A4 实测；注记#5：
    chars=editor DOM 文本字数（manifest ref_chars_source=type1；流式页数=涌现值无源声明
    参照 → preview_limit=实测页数如实）；PDF 文字层实测 ≥90% 参照（门②口径实证）。"""
    from playwright.sync_api import sync_playwright
    ql_html = ""
    with sync_playwright() as pw:
        browser = pw.chromium.launch(headless=True, args=["--no-proxy-server"])
        try:
            context = browser.new_context()
            _install_routes(context)
            page = context.new_page()
            got = WenkuDownloadAdapter().extract_editor_html(DOC_ID, page=page,
                                                             sleep=lambda s: None)
            ql_html = got.ql_html
            assert got.clicked_text == "查看剩余全文"
        finally:
            browser.close()
    entries = [_rtcs_entry(1, "r0")]
    adapter = WenkuDownloadAdapter()
    result = adapter.dispatch_reconstruction(_bundle(_type1_reader_info(entries), page=1),
                                             editor_html=ql_html, out_dir=tmp_path)
    assert result.ok is True and result.pages >= 1
    expected_chars = editor_dom_text_chars(ql_html)
    assert result.chars == expected_chars and expected_chars >= 20      # fixture 正文实测
    for w, h in _page_sizes(result.artifact_path):
        assert abs(w - A4_W_PT) <= _TOL_PT and abs(h - A4_H_PT) <= _TOL_PT
    text = _pdf_text(result.artifact_path)
    assert len(re.sub(r"\s+", "", text)) >= expected_chars * 0.9        # 门②口径实证（文字层真跑）
    manifest = json.loads((tmp_path / "类型1样例_manifest.json").read_text(encoding="utf-8"))
    assert manifest["ref_chars_source"] == "type1" and manifest["ref_chars"] == expected_chars
    assert manifest["preview_limit"] == result.pages and "expected_pages" not in manifest
    assert "branch=editor" in result.detail and "editor-dom" in result.detail


def test_fr2_ac2_dispatch_type1_xml_partial_bucket_preview_limit(tmp_path):
    """XML 降级部分桶（4 项 2 桶，1 桶 params error）→ 幸存 1<page 2 = 部分收割合法形态：
    manifest 走 preview_limit（quality_gate 门①命中口径）；产物几何仍 A4。"""
    entries = [_rtcs_entry(i, f"r{i}") for i in (1, 2, 3, 4)]
    ri = _type1_reader_info(entries, page=2, show=2)
    blocks = [_xml_page_object({"t": "p", "c": ["幸存页正文甲乙丙丁戊己庚"]}, style={})]
    leg = _asset_fetch_spy([], {1: _bucket_jsonp(blocks), 2: _PARAMS_ERR_JSONP})
    adapter = WenkuDownloadAdapter()
    result = adapter.dispatch_reconstruction(_bundle(ri), asset_fetch=leg, out_dir=tmp_path,
                                             now_ms=7)
    assert result.ok is True and result.pages == 1 and result.coverage == "2/2"
    manifest = json.loads((tmp_path / "类型1样例_manifest.json").read_text(encoding="utf-8"))
    assert manifest["preview_limit"] == 1 and "expected_pages" not in manifest


def test_fr2_ac2_type1_editor_empty_no_rtcs_error_branch():
    """§8-8：.ql-editor 空（editor_html 缺席/空）且 rtcsRangeInfo 空 → 抛「未找到
    .ql-editor 内容且无 rtcsRangeInfo 可降级」（中止，不产空件）。经 _reconstruct_type1
    直调（分派面上此态归 §8-9 WenkuUnknownTypeError——三型皆不中先于本分支，原作
    W:906 同为分支内防御位）；§8-9 兜底一并钉死。"""
    adapter = WenkuDownloadAdapter()
    with pytest.raises(WenkuEditorEmptyError,
                       match="未找到 .ql-editor 内容且无 rtcsRangeInfo 可降级"):
        adapter._reconstruct_type1(_bundle({"htmlUrls": [], "rtcsRangeInfo": []}),
                                   editor_html="")
    with pytest.raises(WenkuEditorEmptyError):
        adapter._reconstruct_type1(_bundle({"htmlUrls": [], "rtcsRangeInfo": []}))
    from kb_factory.harvest_engine.adapters.wenku import WenkuUnknownTypeError
    with pytest.raises(WenkuUnknownTypeError, match="未知文档类型"):
        adapter.dispatch_reconstruction(_bundle({"htmlUrls": [], "rtcsRangeInfo": []}))


def test_fr2_ac2_type1_xml_zero_blocks_honest_fail(tmp_path):
    """全部桶空（端点 params error）→ 零可用桶如实 ok=False（不产空 PDF 不虚报）；
    coverage/wall 语义从采集腿透传；ledger fail 行。"""
    entries = [_rtcs_entry(i, f"r{i}") for i in (1, 2, 3)]
    ri = _type1_reader_info(entries, page=1, show=1)
    audit_path = tmp_path / "audit.jsonl"
    adapter = WenkuDownloadAdapter(audit=HarvestAudit(path=str(audit_path)))
    result = adapter.dispatch_reconstruction(_bundle(ri), out_dir=tmp_path / "out",
                                             asset_fetch=_asset_fetch_spy([], {1: _PARAMS_ERR_JSONP}),
                                             now_ms=7)
    assert result.ok is False and result.pages == 0 and result.artifact_path is None
    assert result.coverage == "1/1" and "零可用桶" in result.detail
    lines = _audit_lines(audit_path)
    assert lines[-1]["event"] == "recon_type1" and lines[-1]["status"] == "fail"
    assert not list((tmp_path / "out").glob("*.pdf"))                    # 不产空件


# ---------------- 实弹（真实网络 zero-mock；KB_HARVEST_SKIP_LIVE=1 跳过） ----------------

_LIVE_REASON = "KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（真实网络未跑，公约第 4 条）"
_LIVE_AUDIT = Path(__file__).resolve().parent / "fixtures" / "_t35_live_audit.jsonl"
_LIVE_QUERIES = ("工作总结", "智能文档", "心得体会", "策划案")
_LIVE_MAX_PROBE = 8
_SYNTH_DOC_ID = "752032e54293daef5ef7ba0d4a7302768e996ff0"  # T31 落档基件（syncmrecall 软封兜底）


def _probe_type1_docs():
    """实弹发现腿：syncmrecall 多词 → 逐一 ndview 挖 readerInfo 判型（每件 1 请求 ≤8 件）。
    2026-10-22 三轮 20 词族 60 探 60/60 全 type3（_t35_probe_type1.json 在案）——真类型1
    今日大概率寻不得，返回如实由调用方走组合口径。"""
    try:
        from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter
        from kb_factory.harvest_engine.adapters.wenku import fetch_page_data
    except ImportError:
        from channel_adapters.wenku_meta import WenkuMetaAdapter
        from harvest_engine.adapters.wenku import fetch_page_data
    candidates, seen = [], set()
    for query in _LIVE_QUERIES:
        try:
            metas = WenkuMetaAdapter().metadata(query, 10)
        except Exception:
            continue  # syncmrecall 软封前科（DEVLOG 1014）：换词续试
        for m in metas:
            did = m.extra.get("doc_id")
            if did and did not in seen:
                seen.add(did)
                candidates.append({"doc_id": did})
    found, others = [], []
    for cand in candidates[:_LIVE_MAX_PROBE]:
        try:
            page_data = fetch_page_data(cand["doc_id"])
        except Exception:
            time.sleep(0.5)
            continue
        ri = page_data["readerInfo"]
        if judge_doc_type(ri) == "type1":
            found.append({"doc_id": cand["doc_id"], "page_data": page_data})
            break
        others.append({"doc_id": cand["doc_id"], "type": judge_doc_type(ri)})
        time.sleep(0.5)
    return found, others


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason=_LIVE_REASON)
def test_fr2_ac2_live_type1_combined(tmp_path):
    """FR2.AC2 实弹（组合口径，如实记录）：

    - 探针（≤8 探真网络）命中类型1 件 → XML 降级腿全真（真桶令牌 getbdjson 桶式拉取 →
      renderXmlHtml → printToPDF → 质检门四门）；
    - 未命中（2026-10-22 实况：60/60 type3）→ 组合口径（任务卡明示）：
      ① editor 腿=离线 fixture 页（route 本地 fulfill 造 .ql-editor）**真节拍**跑 §7.4
         全时序（5s+15×0.5s+5s+25×0.5s+3s≈30.5s）→ dispatch(editor_html=) 全链；
      ② XML 腿=真实 wkrtcs 端点合成令牌实弹（transport+信封实测：200+
         rtcs(params error) → 零桶如实失败，ledger 在案）。
    """
    from playwright.sync_api import sync_playwright
    adapter = WenkuDownloadAdapter(audit=HarvestAudit(path=str(_LIVE_AUDIT)))
    found, others = _probe_type1_docs()
    mode_bits = []
    if found:  # —— 全真径：XML 降级腿（真桶令牌）——
        page_data = found[0]["page_data"]
        ri = page_data["readerInfo"]
        n_page = ri.get("page") or ri.get("originalPage") or ri.get("freePage") or 0
        n_show = ri.get("showPage") or 0
        bundle = (adapter.collect_reader_info(found[0]["doc_id"])
                  if n_show >= n_page > 0 else None)
        if bundle is None:  # 需补页 → 两段式 signer（T31 同缝）；仍不可得如实记录
            mode_bits.append("probe-hit-but-fill-needed(需 signer 补页，本用例未续)")
        else:
            result = adapter.dispatch_reconstruction(bundle, out_dir=tmp_path)
            assert result.ok is True, f"实弹 XML 降级未过门: {result.detail}"
            assert result.artifact_path and Path(result.artifact_path).is_file()
            for w, h in _page_sizes(result.artifact_path):
                assert abs(w - A4_W_PT) <= _TOL_PT and abs(h - A4_H_PT) <= _TOL_PT
            mode_bits.append(f"real-rtcs(doc={found[0]['doc_id']} "
                             f"buckets={(len(ri.get('rtcsRangeInfo') or []) + 2) // 3})")
    else:
        mode_bits.append(f"probe-miss({len(others)} 探全非 type1；证据 _t35_probe_type1.json)")
        # —— ② XML 腿：真实端点合成令牌实弹（零造假：合成令牌如实标注）——
        probe_doc = (others or [{}])[0].get("doc_id") or _SYNTH_DOC_ID
        ri_synth = {"showPage": 1, "page": 1, "tplKey": "editor", "htmlUrls": [],
                    "rtcsRangeInfo": [_rtcs_entry(1, "t35-synthetic-range-a")],
                    "bucketNum": "t35synthetic", "rsign": "t35-synthetic-rsign",
                    "md5sum": "t35syntheticmd5"}
        result = adapter.dispatch_reconstruction(_bundle(ri_synth, doc_id=probe_doc),
                                                 out_dir=tmp_path)
        assert result.ok is False and "零可用桶" in result.detail  # 实测端点 params error 如实
        mode_bits.append(f"xml-transport-real(endpoint=200 rtcs(params-error) "
                         f"doc={probe_doc[:12]}…)")
    # —— ① editor 腿：fixture 页真节拍全时序（任务卡明示口径，两态共用）——
    with sync_playwright() as pw:
        browser = pw.chromium.launch(headless=True, args=["--no-proxy-server"])
        try:
            context = browser.new_context()
            _install_routes(context)
            page = context.new_page()
            started = time.monotonic()
            got = adapter.extract_editor_html(DOC_ID, page=page)   # 真节拍（sleep 缺省=time.sleep）
            elapsed = time.monotonic() - started
        finally:
            browser.close()
    assert got.ql_html and "展开后新增段落" in got.ql_html
    assert elapsed >= 30.0, f"§7.4 真节拍实测 {elapsed:.1f}s < 30s（时序未照搬）"
    bundle = _bundle(_type1_reader_info([_rtcs_entry(1, "r0")], page=1), page=1)
    result_e = adapter.dispatch_reconstruction(bundle, editor_html=got.ql_html,
                                              editor_clicked=got.clicked_text,
                                              out_dir=tmp_path / "editor")
    assert result_e.ok is True and result_e.pages >= 1
    for w, h in _page_sizes(result_e.artifact_path):
        assert abs(w - A4_W_PT) <= _TOL_PT and abs(h - A4_H_PT) <= _TOL_PT
    mode_bits.append(f"editor-fixture-full-timing({elapsed:.1f}s clicked={got.clicked_text} "
                     f"pages={result_e.pages} chars={result_e.chars})")
    print(f"\n[live] mode={' + '.join(mode_bits)}")
