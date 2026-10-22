# -*- coding: utf-8 -*-
"""T26 单测：wenku 类型3 重组（JSON+PNG+TTF）→printToPDF（FR2.2/FR2.AC2）。

被测物 = kb_factory.harvest_engine.adapters.wenku 的 T26 增量段（T18/T22 已锁契约只增不改）：
- 三型分派 ``judge_doc_type``（WENKU_SPEC §5.2 唯一权威序：htmlUrls 对象且 json>0=type3 /
  数组=type2 / rtcsRangeInfo=type1 / 皆不中=unknown §8-9）+ fetch_ladder 接线（T22 报告
  下游注意1：入口=collect_reader_info→ReaderInfoLegResult）；
- 类型3 三条资产腿（§5.4/§6.2/§6.5/§6.6）：pageLoadUrl 每页文字层 JSONP（parse/jsonp
  真符号剥壳，失败跳页 §8-6）+ PNG 底图（assets/magic_check.judge_page_png 真符号四步链，
  占位图<2KB 丢弃 §8-7）+ wkretype 字体 CSS（@font-face 替换注入 ascent-override:80%;
  descent-override:20%——pdf/html_print_pdf.build_font_face_css 真符号为比例唯一源）；
- 重组 HTML（§7.2 页容器/文字层 span 绝对定位+行高=高/图片层 div 背景裁剪公式
  scale=w/iw）→ html_to_pdf（printToPDF：页几何权威=@page）→ pypdfium2 实测
  页数==重组页数、逐页尺寸==pageInfo px→pt（FR2.AC2 验收口径）；
- 类型判定记 ledger（recon_dispatch：tplKey+三分支命中）。

现场校准（2026-10-22 实弹探针，证据=_t26_probe_type3.json/_t26_type3_full_sample.json）：
- tplKey=html_view 件 8/8 为类型3；pageInfo 实弹为字符串小数（"892.979"）→ parseFloat 语义；
- 底图以 **body 节点** t=='pic' 携带（c={ix,iy,iw,ih} 裁剪框），pics[] 键可缺席——两源并集；
- wkretype 实弹为 gzip 编码 CSS、@font-face src=data:font 内嵌（httpx 自动解压）；
  pageLoadUrl 预签名直链含 x-bce-range → 状态码 206 也算 2xx 幸存。

测试纪律（WORKER_CONVENTIONS）：
- 离线单测零网络：资产腿经 asset_fetch 注入点（网络腿，确定性）；初始腿经 fetch_html
  注入点（T22 同缝）；打印腿=本地 Chromium 加载本地 HTML（file:// 零网络）。
- 实弹用例（@pytest.mark.live）= 真实网络 zero-mock：syncmrecall 多取几件逐一 ndview 挖
  readerInfo 判型（每件 1 请求，≤8 件，找到即收）→ 全链重组 → pypdfium2 实测；
  KB_HARVEST_SKIP_LIVE=1 时跳过（跳过时明示）。
- Playwright sync API 不可嵌套：实弹打印腿在无外层 sync_playwright 上下文时执行
  （发现腿纯 httpx；缺 signer 的全免费件路径不 Chromium 采集）。
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
    from kb_factory.harvest_engine.adapters.wenku import (Type3Page,
                                                          WenkuDownloadAdapter,
                                                          WenkuUnknownTypeError,
                                                          fetch_type3_assets,
                                                          font_override_inject,
                                                          judge_doc_type,
                                                          page_info_dims,
                                                          render_html_view)
    from kb_factory.harvest_engine.audit import HarvestAudit
    from kb_factory.harvest_engine.pdf.html_print_pdf import (PX_PER_PT_CSS,
                                                              build_font_face_css)
except ImportError:
    from channel_adapters.base import FileMeta
    from harvest_engine.adapters.base import LadderResult
    from harvest_engine.adapters.wenku import (Type3Page, WenkuDownloadAdapter,
                                               WenkuUnknownTypeError,
                                               fetch_type3_assets, font_override_inject,
                                               judge_doc_type, page_info_dims,
                                               render_html_view)
    from harvest_engine.audit import HarvestAudit
    from harvest_engine.pdf.html_print_pdf import PX_PER_PT_CSS, build_font_face_css

import pypdfium2 as pdfium  # noqa: E402  （NFR6：pypdfium2 实测，禁 fitz）

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"
DOC_ID = "ccfe3c6a8a9951e79b89680203d8ce2f006665f8"  # 实弹探针类型3 全免费件（2/2，tplKey=html_view）
PAGE_W_STR, PAGE_H_STR = "892.979", "1262.879"       # 实弹 pageInfo（字符串小数）
PAGE_W, PAGE_H = 892.979, 1262.879
EXP_W_PT, EXP_H_PT = PAGE_W / PX_PER_PT_CSS, PAGE_H / PX_PER_PT_CSS  # 669.73×947.16pt
_TOL_PT = 0.6


# ---------------- fixture 工厂（实弹形态校准） ----------------

def _png_bytes(width: int, height: int, filler: int) -> bytes:
    """合成 PNG：魔数+IHDR 宽高（BE u32 @0x10/0x14）+ 填充凑字节（CRC 不参与判件）。"""
    return (b"\x89PNG\r\n\x1a\n" + (13).to_bytes(4, "big") + b"IHDR"
            + width.to_bytes(4, "big") + height.to_bytes(4, "big")
            + b"\x08\x05\x00\x00\x00" + b"\x00\x00\x00\x00" + b"\x7f" * filler)


def _jsonp(payload: dict, name: str = "wenku_1") -> str:
    return f"{name}({json.dumps(payload, ensure_ascii=False)});"


def _page_json(words=None, pic=None, pw=PAGE_W, ph=PAGE_H) -> dict:
    """pageJson（§5.4；实弹形态：style.c=数字 id 列表、body 节点 t=word/pic）。"""
    body = list(words if words is not None else [
        {"t": "word", "c": "水利工程施工组织设计", "r": [0],
         "p": {"x": 171.03, "y": 119.585, "w": 288.0, "h": 23.598}},
        {"t": "word", "c": "<b>引水&\"隧洞\"'</b>", "r": [1],
         "s": {"color": "#ff0000", "bold": "true", "letter-spacing": "0.5"},
         "p": {"x": 100.0, "y": 200.0, "w": 50.0, "h": 24.0}},
    ])
    if pic is not None:
        body.append(pic)
    return {"page": {"pw": pw, "ph": ph},
            "style": [{"t": "style", "c": [0], "s": {"font-size": "18"}},
                      {"t": "style", "c": [1, 2],
                       "s": {"color": "#000000",
                             "font-family": "f92543b0a8956bec0875e3ca0010001"}}],
            "body": body}


def _type3_reader_info(pages: int = 2, png_pages=(), page: int | None = None,
                       show: int | None = None) -> dict:
    n = pages if page is None else page
    return {
        "showPage": show if show is not None else n, "page": n, "tplKey": "html_view",
        "storeId": "1e5e558e86c24028915f804d2b160b4e",
        "pageInfo": {"pageWidth": PAGE_W_STR, "pageHeight": PAGE_H_STR},
        "htmlUrls": {
            "json": [{"pageIndex": i, "pageLoadUrl": f"https://bos.example/json/{i}"}
                     for i in range(1, pages + 1)],
            "png": [{"pageIndex": i, "pageLoadUrl": f"https://bos.example/png/{i}"}
                    for i in png_pages],
            "ttf": [{"pageIndex": 1, "param": "&md5sum=abc&range=0-78500&sign=s1"},
                    {"pageIndex": 2, "param": "&md5sum=abc&range=1-2&sign=s2"}]}}


def _ndview_html(page_data: dict) -> str:
    return ("<html><head><meta charset='utf-8'></head><body><script>\n"
            "var pageData = " + json.dumps(page_data, ensure_ascii=False) + ";\n"
            "</script></body></html>")


_TTF_CSS_OK = "@font-face {font-family:'f92543b0a8956bec0875e3ca0010001';" \
              "src:url(data:font/opentype;base64,AAEAAAARAQAABAAQ);}"


def _asset_fetch_spy(calls, *, jsonp_by_page, ttf_by_pn=None, png_by_page=None):
    """资产腿网络注入点（任务卡明示）：按 URL 分派记录 (url,binary,headers) 并应答。"""
    def fetch(url, headers, timeout, *, binary=False):
        calls.append({"url": url, "binary": binary, "headers": dict(headers)})
        if "/retype/pipe/" in url:
            m = re.search(r"[?&]pn=(\d+)", url)
            body = (ttf_by_pn or {}).get(int(m.group(1)), "not-fontface-css")
            return 200, body
        if "/json/" in url:
            pn = int(url.rsplit("/", 1)[-1])
            return 200, jsonp_by_page.get(pn, "WAF 拦截纯文案")
        if "/png/" in url:
            pn = int(url.rsplit("/", 1)[-1])
            data = (png_by_page or {}).get(pn)
            return (200, data) if data is not None else (404, b"")
        raise AssertionError(f"未预期的资产 URL: {url}")
    return fetch


def _meta(doc_id=DOC_ID, title="类型3样例-百度文库") -> FileMeta:
    return FileMeta(title=title, fmt="doc", pages=2, perm="green",
                    source_url=f"https://wenku.baidu.com/view/{doc_id}.html",
                    extra={"doc_id": doc_id})


def _audit_lines(path) -> list:
    p = Path(path)
    if not p.exists():
        return []
    return [json.loads(line) for line in p.read_text(encoding="utf-8").splitlines() if line]


# ---------------- 纯函数：三型判定 / 页几何 / 字体注入 ----------------

def test_fr2_ac2_judge_doc_type_three_branches():
    """§5.2 三分支唯一权威序：htmlUrls 对象且 json>0=type3；数组=type2；rtcs=type1；
    dict 但 json 空（png-only）不算 type3（如实落入后继判定）；皆不中=unknown。"""
    assert judge_doc_type(_type3_reader_info()) == "type3"
    assert judge_doc_type({"htmlUrls": ["https://x.bdimg.com/1.png?pn=1"]}) == "type2"
    assert judge_doc_type({"htmlUrls": [], "rtcsRangeInfo": [{"page": 1, "range": "r"}]}) == "type1"
    png_only = _type3_reader_info()
    png_only["htmlUrls"]["json"] = []  # json 空：非类型3（§5.2 判据=对象且 json.length>0）
    assert judge_doc_type(png_only) == "unknown"
    assert judge_doc_type({}) == "unknown" and judge_doc_type(None) == "unknown"


def test_fr2_ac2_page_info_dims_parsefloat_defaults():
    """§5.1/W:821：pageWidth/pageHeight parseFloat（实弹字符串小数）；缺省 892×1262。"""
    assert page_info_dims(_type3_reader_info()) == (PAGE_W, PAGE_H)
    assert page_info_dims({"pageInfo": {}}) == (892.0, 1262.0)
    assert page_info_dims({}) == (892.0, 1262.0)
    assert page_info_dims({"pageInfo": {"pageWidth": "", "pageHeight": "x"}}) == (892.0, 1262.0)


def test_fr2_ac2_font_override_inject_sourced_from_build_font_face_css():
    """§6.5/W:497：@font-face 替换片段的 80%/20% 唯一源=build_font_face_css 真符号
    （正则提取对等），不另写死数字；替换对多规则/空白形态生效。"""
    inject = font_override_inject()
    m = re.search(r"ascent-override:([^;}]+);descent-override:([^;}]+);",
                  build_font_face_css())
    assert m, "源符号 build_font_face_css 缺 override 对（口径漂移）"
    assert inject == f"@font-face {{ascent-override:{m.group(1)};descent-override:{m.group(2)};"
    assert "ascent-override:80%" in inject and "descent-override:20%" in inject
    css = _TTF_CSS_OK + "\n@font-face\n{font-family:'b';src:url(data:font/x;base64,QQ);}"
    out = re.sub(r"@font-face\s*\{", inject, css)
    assert out.count("ascent-override:80%") == 2 and "@font-face {ascent" in out


# ---------------- 资产腿：json JSONP / png 占位丢弃 / ttf §8-5 ----------------

def test_fr2_ac2_fetch_type3_assets_placeholder_png_dropped():
    """§6.6 四步链（judge_page_png 真符号）：占位图（宽高>0.8×页、<2KB）丢弃仅文字层；
    合法小图 data URI 内嵌；ttf 无 @font-face 跳过（§8-5）；json 非 JSONP 跳页（§8-6）；
    三腿 Referer=wenku；json/ttf 腿带 §3.1 全套头、png 腿只 Referer+UA（§6.6 原作口径）。"""
    ri = _type3_reader_info(pages=3, png_pages=(1, 2, 3))
    jsonp_by_page = {1: _jsonp(_page_json()), 2: _jsonp(_page_json()),
                     3: "forbidden"}  # 页3 非 JSONP → §8-6 跳页
    png_by_page = {1: _png_bytes(800, 1100, 500),   # >0.8×页宽高 且 <2048B → 占位丢弃
                   2: _png_bytes(100, 100, 300),    # 小图幸存（>200B）
                   3: _png_bytes(100, 100, 300)}    # 页3 json 已跳 → png 不拉（原作同序）
    calls: list = []
    leg = _asset_fetch_spy(calls, jsonp_by_page=jsonp_by_page,
                           ttf_by_pn={1: _TTF_CSS_OK, 2: "ttf 无效数据"},
                           png_by_page=png_by_page)
    assets = fetch_type3_assets(ri, asset_fetch=leg, min_interval=0)
    assert [pg.p for pg in assets.pages] == [1, 2]        # 页3 跳过：页库存只收幸存页
    assert assets.pages[0].png_url is None                # 占位图丢弃 → 无底图
    assert assets.pages[1].png_url.startswith("data:image/png;base64,")
    assert (assets.pages[1].png_w, assets.pages[1].png_h) == (100, 100)
    assert assets.stats == {"requests": 7, "ttf_ok": 1, "ttf_skip": 1, "json_ok": 2,
                            "json_skip": 1, "png_kept": 1, "png_drop": 1}
    assert "ascent-override:80%;descent-override:20%;" in assets.font_css
    by_kind = {}
    for c in calls:
        kind = ("ttf" if "/retype/pipe/" in c["url"]
                else "json" if "/json/" in c["url"] else "png")
        by_kind.setdefault(kind, []).append(c)
        assert c["headers"]["Referer"] == "https://wenku.baidu.com/"
    assert "Sec-Ch-Ua" in by_kind["json"][0]["headers"]       # §3.1 全套头
    assert "Sec-Ch-Ua" in by_kind["ttf"][0]["headers"]
    assert "Sec-Ch-Ua" not in by_kind["png"][0]["headers"]     # §6.6 原作 png 腿只 Referer
    assert by_kind["ttf"][0]["url"].startswith(
        "https://wkretype.bdimg.com/retype/pipe/1e5e558e86c24028915f804d2b160b4e?pn=1"
        "&t=ttf&rn=1&v=6&md5sum=abc&range=0-78500&sign=s1")     # §6.5 URL 模板逐段
    assert not [c for c in calls if "/png/3" in c["url"]]      # json 跳页则 png 不拉


def test_fr2_ac2_fetch_type3_assets_min_interval_paced():
    """资产腿间节流（§9 速率自律）：min_interval>0 时逐腿间隔 sleep（注入点计数）。"""
    ri = _type3_reader_info(pages=1, png_pages=(1,))
    slept: list = []
    fetch_type3_assets(ri, asset_fetch=_asset_fetch_spy(
        [], jsonp_by_page={1: _jsonp(_page_json())}, ttf_by_pn={1: _TTF_CSS_OK},
        png_by_page={1: _png_bytes(100, 100, 300)}),
        min_interval=0.25, sleep=slept.append)
    assert len(slept) == 3  # 4 腿（ttf×2+json+png）：首腿不睡，后三腿各 0.25s


# ---------------- 重组 HTML（§7.2） ----------------

def test_fr2_ac2_render_html_view_layers_and_geometry():
    """§7.2：@page=pageInfo 文档级尺寸；页容器宽高=pageJson pw/ph（缺省回落 pageInfo）；
    文字层 span 绝对定位+行高=高+white-space:nowrap+color:#000 与 r 引用/内联覆盖
    （font-size 裸数字补 px、bold=='true'、color 后置覆盖）；图片层 div 背景裁剪
    scale=w/iw 取整；文字与 title 全转义；字体 CSS 注入同一 <style>。"""
    pic = {"t": "pic", "c": {"ix": 100, "iy": 40, "iw": 2000, "ih": 1600},
           "p": {"x": 10, "y": 20, "w": 1000, "h": 800}}
    page1 = Type3Page(p=1, page_json=_page_json(pic=pic),
                      png_url="data:image/png;base64,QUJD", png_w=2000, png_h=1600)
    page2_json = _page_json()                            # 页级 page 缺省 → 回落 pageInfo
    page2_json["page"] = {}
    page2 = Type3Page(p=2, page_json=page2_json, png_url=None, png_w=0, png_h=0)
    html = render_html_view('标题<b>&"\'</b>', _type3_reader_info(),
                            [page1, page2], font_css=_TTF_CSS_OK)
    assert f"@page{{size:{PAGE_W}px {PAGE_H}px;margin:0}}" in html
    assert "body{margin:0;font-family:sans-serif}" in html
    assert ".page{page-break-after:always;background:#fff}" in html
    assert ".page:last-child{page-break-after:auto}" in html
    assert "<title>标题&lt;b&gt;&amp;&quot;&#39;&lt;/b&gt;</title>" in html  # title 转义
    assert "&lt;b&gt;引水&amp;&quot;隧洞&quot;&#39;&lt;/b&gt;" in html          # 文字节点转义
    # 文字层 span：几何+行高=高+nowrap+#000 底色+覆盖色后置
    assert 'left:171.03px;top:119.585px;height:23.598px;line-height:23.598px' in html
    assert "white-space:nowrap;color:#000;color:#ff0000;" in html
    assert "font-size:18px;" in html                       # 裸数字 → Npx
    assert "font-weight:bold;" in html                     # bold=='true'（字符串）
    assert "letter-spacing:0.5px;" in html
    # 字体族名在 style 属性内以实体引号呈现（浏览器解码后即 font-family:'X',sans-serif）
    assert "font-family:&#39;f92543b0a8956bec0875e3ca0010001&#39;,sans-serif;" in html
    # 图片层：scale=1000/2000=0.5 → bg=1000x800px、偏移=50px 20px、高=round(1600*0.5)
    assert ("background:url(&#39;data:image/png;base64,QUJD&#39;) 50px 20px no-repeat;"
            "background-size:1000px 800px") in html
    assert "left:10.0px;top:20.0px;width:1000.0px;height:800px;overflow:hidden" in html
    # 页容器：页1 pw/ph 原值；页2 缺省回落 pageInfo
    assert f'width:{PAGE_W}px;height:{PAGE_H}px;position:relative;overflow:hidden' in html
    assert html.count('class="page"') == 2
    assert _TTF_CSS_OK in html                              # 字体 CSS 注入同一 <style>


# ---------------- 段3 全链：三型分派接线 + printToPDF ----------------

def test_fr2_ac2_fetch_ladder_type3_pdf_geometry_equals_pageinfo(tmp_path):
    """FR2.AC2 主验收（离线全链）：ndview 初始腿+三腿资产（注入）→renderHtmlView→
    printToPDF → pypdfium2 实测页数==重组页数、逐页尺寸==pageInfo px→pt（±0.6pt）；
    ledger 三事件（init/recon_dispatch/recon_type3）tplKey+三分支命中落账；临时 HTML
    用毕即删；chars=word 码点实测；wall_status/coverage 透传。"""
    ri = _type3_reader_info(pages=2, png_pages=(1,))  # 页1 带合法底图、页2 png 404→弃
    fetch_html = lambda url, headers, timeout: (200, _ndview_html({  # noqa: E731
        "title": "类型3样例-百度文库", "readerInfo": ri}))
    calls: list = []
    leg = _asset_fetch_spy(calls, jsonp_by_page={1: _jsonp(_page_json()),
                                                 2: _jsonp(_page_json())},
                           ttf_by_pn={1: _TTF_CSS_OK, 2: _TTF_CSS_OK},
                           png_by_page={1: _png_bytes(100, 100, 300)})
    audit_path = tmp_path / "audit.jsonl"
    adapter = WenkuDownloadAdapter(audit=HarvestAudit(path=str(audit_path)))
    result = adapter.fetch_ladder(adapter.plan(_meta()), fetch_html=fetch_html,
                                  asset_fetch=leg, out_dir=tmp_path / "out")
    assert isinstance(result, LadderResult) and result.ok is True
    assert result.ladder_used == "L1" and result.coverage == "2/2"
    assert result.wall_status is None and result.artifact_path and Path(result.artifact_path).is_file()
    doc = pdfium.PdfDocument(result.artifact_path)
    try:
        sizes = [(pg.get_width(), pg.get_height()) for pg in doc]
    finally:
        doc.close()
    assert len(sizes) == 2 == result.pages
    for w, h in sizes:
        assert abs(w - EXP_W_PT) <= _TOL_PT and abs(h - EXP_H_PT) <= _TOL_PT, (
            f"PDF 页尺寸 {w}x{h}pt != pageInfo {EXP_W_PT:.2f}x{EXP_H_PT:.2f}pt")
    expected_chars = 2 * (len("水利工程施工组织设计") + len('<b>引水&"隧洞"\'</b>'))  # 50（码点实测）
    assert result.chars == expected_chars
    lines = _audit_lines(audit_path)
    assert [l["event"] for l in lines] == ["readerinfo_init", "recon_dispatch", "recon_type3"]
    assert lines[1]["status"] == "type3" and "tplKey=html_view" in lines[1]["detail"]
    assert lines[1]["count"] == 2 and "branch=type3" in lines[1]["detail"]
    assert lines[2]["status"] == "ok" and f"chars={expected_chars}" in lines[2]["detail"]
    assert not list((tmp_path / "out").glob("_render_type3_*.html"))  # 临时件即删（W:683）


def test_fr2_ac2_fetch_ladder_dispatch_placeholders_and_unknown(tmp_path):
    """三型分派接线：类型2→T31 已实装（占位钉兑现：404 注入=零可用页如实失败）、类型1→
    T35 已实装（占位钉兑现：params error 桶注入=XML 降级零桶如实失败）；皆不中→
    WenkuUnknownTypeError §8-9；「T26/T31/T35」组字样仅存 verify 段4 占位。"""
    adapter = WenkuDownloadAdapter()
    ri2 = _type3_reader_info()
    ri2["htmlUrls"] = ["https://x.bdimg.com/1.png?pn=1"]  # 类型2
    result2 = adapter.fetch_ladder(adapter.plan(_meta()),
                                   fetch_html=lambda u, h, t: (
                                       200, _ndview_html({"title": "t", "readerInfo": ri2})),
                                   asset_fetch=lambda u, h, t, *, binary=False: (404, b""),
                                   asset_min_interval=0)
    assert result2.ok is False and "零可用页" in result2.detail  # 404=如实失败（不产空件）
    ri1 = _type3_reader_info()
    ri1["htmlUrls"] = []
    ri1["rtcsRangeInfo"] = [{"page": 1, "range": "r0"}]  # 类型1
    result1 = adapter.fetch_ladder(adapter.plan(_meta()), fetch_html=lambda u, h, t: (
        200, _ndview_html({"title": "t", "readerInfo": ri1})),
        asset_fetch=lambda u, h, t, *, binary=False: (   # T35 实装：XML 降级腿（零网络注入）
            200, 'rtcs({"status":{"code":200002,"error":"params error"}})'))
    assert result1.ok is False and "零可用桶" in result1.detail   # 空桶=如实失败（不产空件）
    with pytest.raises(NotImplementedError, match=r"T26/T31/T35") as ei1:
        adapter.verify(result1)                          # verify 半仍钉（占位组字样）
    assert "T35" in str(ei1.value)
    riu = _type3_reader_info()
    riu["htmlUrls"] = {}
    with pytest.raises(WenkuUnknownTypeError, match="未知文档类型"):
        adapter.fetch_ladder(adapter.plan(_meta()), fetch_html=lambda u, h, t: (
            200, _ndview_html({"title": "t", "readerInfo": riu})))


def test_fr2_ac2_fetch_ladder_zero_pages_honest_fail(tmp_path):
    """全部页 json 解析失败 → 零可用页如实 ok=False（不产空 PDF 不虚报页数）；
    coverage/wall 语义从采集腿透传（部分收割如实，§5.3）。"""
    ri = _type3_reader_info(pages=2)
    ri["showPage"], ri["page"] = 5, 5  # 免补页（本用例聚焦零可用页归因，不触发 signer 硬报）
    fetch_html = lambda url, headers, timeout: (  # noqa: E731
        200, _ndview_html({"title": "x", "readerInfo": ri}))
    leg = _asset_fetch_spy([], jsonp_by_page={1: "WAF", 2: "纯文案"},
                           ttf_by_pn={1: _TTF_CSS_OK, 2: _TTF_CSS_OK})
    audit_path = tmp_path / "audit.jsonl"
    adapter = WenkuDownloadAdapter(audit=HarvestAudit(path=str(audit_path)))
    result = adapter.fetch_ladder(adapter.plan(_meta()), fetch_html=fetch_html,
                                  asset_fetch=leg, out_dir=tmp_path / "out")
    assert result.ok is False and result.pages == 0 and result.artifact_path is None
    assert result.coverage == "5/5" and "零可用页" in result.detail
    lines = _audit_lines(audit_path)
    assert lines[-1]["event"] == "recon_type3" and lines[-1]["status"] == "fail"


# ---------------- 实弹（真实网络 zero-mock；KB_HARVEST_SKIP_LIVE=1 跳过） ----------------

_LIVE_REASON = "KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（真实网络未跑，公约第 4 条）"
_LIVE_AUDIT = Path(__file__).resolve().parent / "fixtures" / "_t26_live_audit.jsonl"
_LIVE_QUERIES = ("水利施工组织设计", "项目管理制度", "工程监理细则")  # 探针 8/8 type3 校准用词
_LIVE_MAX_PROBE = 8  # 任务卡口径：每件 1 请求，≤8 件


def _discover_type3_doc():
    """实弹发现腿（任务卡口径）：syncmrecall 多取几件 → 逐一 ndview 挖 readerInfo 判型
    （每件 1 请求，≤8 件），找到即收；优先全免费（showPage>=page，免 signer/免 Chromium
    采集——Playwright sync 不可嵌套：打印腿需无外层 sync 上下文），否则取最小件（两段式：
    signer 采集→收口→重组）。"""
    from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter
    from kb_factory.harvest_engine.adapters.wenku import fetch_page_data
    candidates, seen = [], set()
    for query in _LIVE_QUERIES:
        for m in WenkuMetaAdapter().metadata(query, 12):
            did = m.extra.get("doc_id")
            if did and did not in seen:
                seen.add(did)
                candidates.append({"doc_id": did, "title": m.title, "pages": m.pages})
    if not candidates:
        # syncmrecall 空结果（2026-10-22 软封前科）：退回已落档校准 docId（实弹探针
        # fixtures/_t26_type3_full_sample.json 全免费 2/2 件）——1 请求探型，勿打墙。
        candidates = [{"doc_id": DOC_ID, "title": "类型3校准件(落档)", "pages": 2}]
    candidates.sort(key=lambda c: (c["pages"] or 999))
    full, partial = [], []
    for cand in candidates[:_LIVE_MAX_PROBE]:
        try:
            page_data = fetch_page_data(cand["doc_id"])
        except Exception:
            continue
        ri = page_data["readerInfo"]
        if judge_doc_type(ri) != "type3":
            continue
        entry = {"meta": _meta(doc_id=cand["doc_id"], title=str(page_data.get("title") or "")),
                 "page_data": page_data}
        n_page = ri.get("page") or ri.get("originalPage") or ri.get("freePage") or 0
        n_show = ri.get("showPage") or 0
        (full if n_show >= n_page > 0 else partial).append(entry)
        if full:
            break  # 找到即收（任务卡口径）
        time.sleep(1.0)
    if not full and not partial:
        raise AssertionError(f"探针 {_LIVE_MAX_PROBE} 件未发现类型3 文档（syncmrecall 判型全 miss）")
    return full[0] if full else partial[0], bool(full)


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason=_LIVE_REASON)
def test_fr2_ac2_live_type3_full_chain(tmp_path):
    """FR2.AC2 实弹主验收：1 份类型3 全链——syncmrecall+ndview 判型（每件1请求≤8件，
    tplKey 落 ledger recon_dispatch）→ pageLoadUrl 每页文字层 JSONP + PNG 底图（占位
    <2KB 丢弃）+ wkretype 字体 CSS（ascent-override 注入）→ 重组 HTML → printToPDF →
    pypdfium2 实测页数==重组页数、逐页尺寸==pageInfo px→pt。台账追加写、零删除。"""
    entry, is_full = _discover_type3_doc()
    meta = entry["meta"]
    adapter = WenkuDownloadAdapter(audit=HarvestAudit(path=str(_LIVE_AUDIT)))
    plan = adapter.plan(meta)
    before = len(_audit_lines(_LIVE_AUDIT))
    if is_full:
        result = adapter.fetch_ladder(plan, out_dir=tmp_path)  # 全免费：零 signer 零嵌套
    else:
        # 两段式：signer 补页（Chromium）→ 收口后重组（打印腿独立开浏览器，避免 sync 嵌套）
        from kb_factory.harvest_engine.browser.kit import BrowserKit
        from kb_factory.harvest_engine.signer.page_signer import PageSigner
        from playwright.sync_api import sync_playwright
        with sync_playwright() as pw:
            browser = pw.chromium.launch(
                headless=True, args=[] if os.environ.get("KB_HARVEST_KEEP_PROXY") == "1"
                else ["--no-proxy-server"])
            try:
                kit = BrowserKit(browser)
                signer = PageSigner(kit)
                assert signer.ready, "ACS 签名窗未就绪（T17 件在位为前提）"
                adapter.collect_reader_info(meta.extra["doc_id"], meta=meta, signer=signer)
            finally:
                signer.close()
                kit.close_all()
                browser.close()
        result = adapter.dispatch_reconstruction(adapter.last_reader_info, out_dir=tmp_path)
    bundle = adapter.last_reader_info
    assert result.ok is True, f"实弹重组未过门: {result.detail}"
    assert result.artifact_path and Path(result.artifact_path).is_file()
    exp_w, exp_h = page_info_dims(bundle.reader_info)
    doc = pdfium.PdfDocument(result.artifact_path)
    try:
        sizes = [(pg.get_width(), pg.get_height()) for pg in doc]
    finally:
        doc.close()
    assert len(sizes) == result.pages >= 1
    for w, h in sizes:
        assert abs(w - exp_w / PX_PER_PT_CSS) <= _TOL_PT, f"页宽 {w}pt != pageInfo {exp_w}px"
        assert abs(h - exp_h / PX_PER_PT_CSS) <= _TOL_PT, f"页高 {h}pt != pageInfo {exp_h}px"
    lines = _audit_lines(_LIVE_AUDIT)[before:]
    dispatch = [l for l in lines if l["event"] == "recon_dispatch"]
    assert dispatch and dispatch[0]["status"] == "type3"
    assert f"tplKey={bundle.reader_info.get('tplKey')}" in dispatch[0]["detail"]
    recon = [l for l in lines if l["event"] == "recon_type3"]
    assert recon and recon[0]["status"] == "ok" and recon[0]["count"] == result.pages
    assert result.chars >= 1  # word 码点实测（数字零造假）
    print(f"\n[live] doc={bundle.doc_id} page={bundle.page} showPage={bundle.show_page} "
          f"pages={result.pages} chars={result.chars} geo={sizes[0][0]:.1f}x{sizes[0][1]:.1f}pt "
          f"tplKey={bundle.reader_info.get('tplKey')} full_free={is_full} "
          f"title={bundle.title_clean[:24]}")
