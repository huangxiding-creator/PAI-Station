# -*- coding: utf-8 -*-
"""T03 单测：parse/inline_var 内联变量挖掘三态（FR2.1 / FR3.1 / FR4.1 解析基座）。

- wenku 态（FR2.1）：WENKU_SPEC §3.1 extractPageData 逻辑——锚点 'var pageData' + 花括号配平
  （引号/转义感知扫描）。wenku view 页无实测 HTML 留档（活探针即 403 WAF 页，未归档），
  样本按 WENKU_SPEC §5.1 readerInfo 字段形状合成，断言全部针对算法行为。
- book118 态（FR3.1）：金样逐字取自 _repos/book118 DocumentBrowserTest.java 的 PREVIEW_PAGE
  （与线上格式一致：非严格 JSON——parseInt('...') 包裹、单引号、无引号键）；另读
  _repos/book118 实测留档（NewView 对 curl 空 body 指纹墙证据 / 已删除文档 404 页）作真实负样本。
- doc88 态（FR4.1）：读 _repos/doc88/_probe/p_69091550288.html 实测留档（含真实
  m_main.init 载荷，实测 10320 字符），DOC88_SPEC §1.2 方法2 正则捕获。
- 真实留档读取=离线确定性读取（非实弹网络）；留档缺失环境（worktree/CI）显式 skip 并在输出明示。
"""
import re
import sys
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine.parse.inline_var import (  # noqa: E402
        BOOK118_ANCHOR, DOC88_M_MAIN_PATTERN, WENKU_ANCHOR, extract_m_main,
        extract_page_data, extract_preview_data)
except ImportError:
    from harvest_engine.parse.inline_var import (  # noqa: E402
        BOOK118_ANCHOR, DOC88_M_MAIN_PATTERN, WENKU_ANCHOR, extract_m_main,
        extract_page_data, extract_preview_data)

_STATION_DIR = _KB_DIR.parents[0]  # E:/AI-Station/
_REPOS = _STATION_DIR / "07 任务" / "自动建库Agent" / "engine" / "SPECS" / "_repos"
_requires_book118_archive = pytest.mark.skipif(
    not (_REPOS / "book118" / "_probe_shtm_113657916.html").exists(),
    reason="SPECS/_repos/book118 实测留档不在本检出（worktree/CI 环境）；主树在位必跑")
_requires_doc88_archive = pytest.mark.skipif(
    not (_REPOS / "doc88" / "_probe" / "p_69091550288.html").exists(),
    reason="SPECS/_repos/doc88 实测留档不在本检出（worktree/CI 环境）；主树在位必跑")

# ---------------------------------------------------------------- wenku 态样本

#: 按 WENKU_SPEC §5.1 readerInfo 字段形状合成（类型3 JSON+PNG+TTF 分支消费面）：
#: 字符串内嵌花括号 / 转义引号 / 转义反斜杠，全部必须不干扰配平。
_WENKU_VIEW_HTML = (
    "<!DOCTYPE html><html><head><title>水利枢纽验收手册 - 百度文库</title></head><body>"
    "<script>var commonCfg = {debug:false};</script>"
    "<script>var pageData = {"
    '"title":"含\\"引号\\"与反斜杠C:\\\\dir的标题",'
    '"readerInfo":{"docId":"ab12cd34ef","tplKey":"normal_view",'
    '"page":30,"showPage":8,"freePage":8,"rtcsRangeInfo":[],'
    '"htmlUrls":{'
    '"json":[{"pageIndex":1,"pageLoadUrl":"https://wkrtcs.bdimg.com/j1?cb={x}&t=1"},'
    '{"pageIndex":2,"pageLoadUrl":"https://wkrtcs.bdimg.com/j1?cb={y}&t=2"}],'
    '"png":[],"ttf":[]}}}'
    "};</script>"
    "<script>var afterData = {pollution:true};</script></body></html>"
)

_WENKU_EXPECTED_READER_INFO = {
    "docId": "ab12cd34ef", "tplKey": "normal_view",
    "page": 30, "showPage": 8, "freePage": 8, "rtcsRangeInfo": [],
    "htmlUrls": {
        "json": [
            {"pageIndex": 1, "pageLoadUrl": "https://wkrtcs.bdimg.com/j1?cb={x}&t=1"},
            {"pageIndex": 2, "pageLoadUrl": "https://wkrtcs.bdimg.com/j1?cb={y}&t=2"},
        ],
        "png": [], "ttf": [],
    },
}

# -------------------------------------------------------------- book118 态样本

#: 金样逐字取自 _repos/book118/src/test/java/me/rainking/DocumentBrowserTest.java
#: 的 PREVIEW_PAGE 常量（与线上 NewView 页 PREVIEW_DATA 格式一致）。
_BOOK118_GOLD_PREVIEW_PAGE = (
    "var PREVIEW_DATA = { project_id: 1, aid: parseInt('188244482'), "
    "view_token: 'Bw_2kzdPgXts68EgVwn_mM4e8ALH_opi', aid_encode: '5134312044001323'}; //1:max站"
)


def _read_archive(rel: str) -> str:
    return (_REPOS / rel).read_text(encoding="utf-8", errors="replace")


# ------------------------------------------------------------------ wenku 态

def test_fr2_1_page_data_brace_balanced_quote_escape_aware():
    """FR2.1：锚点+花括号配平，引号/转义感知——字符串内 {}、\\"、\\\\ 均不干扰深度。"""
    assert WENKU_ANCHOR == "var pageData"
    page = extract_page_data(_WENKU_VIEW_HTML)
    assert page is not None
    assert page["title"] == '含"引号"与反斜杠C:\\dir的标题'
    assert page["readerInfo"] == _WENKU_EXPECTED_READER_INFO  # 含 {x} 的 URL 原样存活
    # 配平止于 pageData 自身的闭括号：后续 afterData 变量不得混入
    assert "pollution" not in str(page)


def test_fr2_1_page_data_anchor_missing_returns_none():
    """FR2.1：无锚点（含 403 WAF 页形态）/锚点后无 '{' → None（SPEC §8 错误分支 #1 的上游）。"""
    assert extract_page_data("<html><body>403 Forbidden</body></html>") is None
    assert extract_page_data("") is None
    assert extract_page_data("var pageData = 1;") is None


def test_fr2_1_page_data_unbalanced_returns_none():
    """FR2.1：花括号不配平（页面截断）→ None（JS 原件扫到尾亦返回 null）。"""
    truncated = "<script>var pageData = {\"title\":\"x\",\"readerInfo\":{\"page\":3"
    assert extract_page_data(truncated) is None


def test_fr2_1_page_data_strict_json_only():
    """FR2.1：配平切片必须是严格 JSON（JS 原件走 JSON.parse）——JS 字面量（单引号/无引号键）→ None。

    偏离说明：JS 原件此处会抛 SyntaxError；本件统一返回 None，
    由调用方（adapters/wenku 件）映射为 SPEC §8 #1 的『failed to extract pageData from HTML』。
    """
    js_literal = "<script>var pageData = {title: '单引号值'};</script>"
    assert extract_page_data(js_literal) is None


def test_fr2_1_page_data_first_anchor_wins():
    """FR2.1：多锚点时取首个（JS indexOf 语义）；首个配平体即结果。"""
    html = ("var pageData = {\"first\":true}; ... var pageData = {\"second\":true};")
    assert extract_page_data(html) == {"first": True}


# ---------------------------------------------------------------- book118 态

def test_fr3_1_preview_data_gold_sample_from_archive():
    """FR3.1：金样（线上格式一致）四字段全提取——parseInt('...') 包裹按单引号取值。"""
    assert BOOK118_ANCHOR == "PREVIEW_DATA"
    data = extract_preview_data(_BOOK118_GOLD_PREVIEW_PAGE)
    assert data == {
        "project_id": 1,
        "aid": "188244482",
        "view_token": "Bw_2kzdPgXts68EgVwn_mM4e8ALH_opi",
        "aid_encode": "5134312044001323",
    }


def test_fr3_1_preview_data_aid_prefix_guard():
    """FR3.1 核心：键定位校验（key 后紧跟冒号）——aid 不得误配 aid_encode / aider 前缀。"""
    only_encode = "var PREVIEW_DATA = { project_id: 2, aid_encode: '513', view_token: 'tk' };"
    assert extract_preview_data(only_encode) is None  # aid 键缺失≠aid_encode 顶替
    decoy = "var PREVIEW_DATA = { project_id: 3, aider: 'not-aid', view_token: 'tk', aid_encode: 'e' };"
    assert extract_preview_data(decoy) is None  # aider 后非冒号，跳过


def test_fr3_1_preview_data_whitespace_between_key_and_colon():
    """FR3.1：键与冒号间允许空白（含换行）——PREVIEW_DATA 非严格 JSON 的排版容忍。"""
    loose = ("var PREVIEW_DATA = {\n  project_id : 9,\n  aid\n  :  parseInt('42'),\n"
             "  view_token\t: 'tk',\n  aid_encode : 'enc'\n};")
    assert extract_preview_data(loose) == {
        "project_id": 9, "aid": "42", "view_token": "tk", "aid_encode": "enc"}


def test_fr3_1_preview_data_project_id_brace_terminated():
    """FR3.1：project_id 为末字段时以 '}' 结束取值（Java 原作注释明示的边界）。"""
    last_field = ("var PREVIEW_DATA = { aid: '1', view_token: 'tk', "
                  "aid_encode: 'e', project_id: 7 };")
    data = extract_preview_data(last_field)
    assert data is not None and data["project_id"] == 7


def test_fr3_1_preview_data_missing_field_returns_none():
    """FR3.1：四字段缺一即 None（Java getPreviewData 全有才拼 openapi URL）。"""
    assert extract_preview_data("var PREVIEW_DATA = { project_id: 2 };") is None
    assert extract_preview_data("var PREVIEW_DATA = { aid: 1 };") is None  # 金样同款负例
    assert extract_preview_data("<html></html>") is None  # 无 PREVIEW_DATA 锚点


@_requires_book118_archive
def test_fr3_1_preview_data_real_empty_body_returns_none():
    """FR3.1 实测留档：NewView 对 curl 返回 200+空 body（指纹墙证据）→ 无 PREVIEW_DATA。"""
    empty_html = _read_archive("book118/_probe_newview_5134312044001323.html")
    assert len(empty_html) == 0
    assert extract_preview_data(empty_html) is None


@_requires_book118_archive
def test_fr3_1_preview_data_real_deleted_doc_returns_none():
    """FR3.1 实测留档：已删除文档 404 页（_probe_shtm_113657916.html）无 PREVIEW_DATA。"""
    deleted_html = _read_archive("book118/_probe_shtm_113657916.html")
    assert "PREVIEW_DATA" not in deleted_html
    assert extract_preview_data(deleted_html) is None


# ------------------------------------------------------------------ doc88 态

@_requires_doc88_archive
def test_fr4_1_m_main_capture_real_archived_page():
    """FR4.1 实测留档：真实文档页 m_main.init 载荷捕获（唯一一处，10320 字符，头尾钉选）。"""
    html = _read_archive("doc88/_probe/p_69091550288.html")
    matches = DOC88_M_MAIN_PATTERN.findall(html)
    assert len(matches) == 1  # 页面仅一处 m_main.init 调用（grep 'm_main' 三处、init 一处）
    payload = extract_m_main(html)
    assert payload is not None and len(payload) == 10320  # 实测留档长度（2026-10-22 探针）
    assert payload.startswith("GTxSGu0i1kPc3gtZCL363meXBqDUCOjX0kNlCqNUFIJZ0qJgFg3XCqvQ3iRi")
    assert payload.endswith("JcCp360LRiHo5YBgleBWtSuWvi1kJ9")


def test_fr4_1_m_main_regex_semantics():
    """FR4.1：DOC88_SPEC §1.2 方法2 正则 m_main\\.init\\("([^"]*)"\\); 语义。"""
    assert DOC88_M_MAIN_PATTERN.pattern == r'm_main\.init\("([^"]*)"\);'
    assert extract_m_main('<script>m_main.init("abc");</script>') == "abc"
    assert extract_m_main("<html>无配置页面</html>") is None
    assert extract_m_main('<script>m_main.init("abc")</script>') is None  # 缺分号不匹配（照抄原件正则）
    assert extract_m_main('<script>m_main.init("");</script>') is None    # 空载荷=无数据
    # 捕获必须锚定在 m_main.init 调用上，不吃任意双引号串
    assert extract_m_main('var x = "m_main.init(\\"fake\\");"') is None
