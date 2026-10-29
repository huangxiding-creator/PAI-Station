# -*- coding: utf-8 -*-
"""T34 单测：docin 豆丁适配器接入+复活实证（FR6.AC1）。

被测物 = kb_factory.harvest_engine.adapters.docin（DOCIN_SPEC §6/§7 施工：L2 主径
Playwright 开真实文档页→同会话 cookie+页内 sid（flash_param_hzq 明文）→
page.douding.cn/docinfile2 容器直下（L1 同会话复现验证点①）+ t.docin.com 页图
→像素拼 PDF→OCR 文字层→NFR-GATE 质检门=「复活」定义）。

REVIVAL_LEDGER 口径声明（任务卡授权的「已复活站点清单参数化」形态）：
- 「复活」唯一定义（REQUIREMENTS FR6.1）=该站 ≥1 份真实下载过质检门；
- level="full"=已达复活定义；level="partial"=站链路部分实证（如实计入证据、不计入复活数）；
- 本日 full 计数=1（docin，本文件 live 用例 test_fr6_ac1_live_download_passes_quality_gate）；
  book118（T19 预览页清单链实弹全通，tests/test_book118_preview.py live）/doc88（T24 配置
  发现腿实弹，tests/test_doc88_info.py live）/wenku（T18 docId 侧门检索实弹，
  tests/test_wenku_docid.py live）为 partial——book118 PDF/质检门腿归 T23、doc88 ebt/FFDec
  腿归 T27/T32、wenku 下载链归 T22+，彼时转 full 由编排层收编后更新本表；
- 站点域存活侧证零网络取 FISH_PROBE_VERDICTS（probe/health.py 2026-10-22 实测镜像）。

测试纪律（WORKER_CONVENTIONS）：
- 离线零网络：session_factory/l1_fetch/assemble/fallback_runner 四注入点喂确定性替身
  （网络/成品管线注入点，adapters/docin.py 模块 docstring 声明，同 book118 先例）；
- 实弹用例（@pytest.mark.live）=真实网络 zero-mock；实弹请求预算 ≤15（适配器
  max_requests 码内强制，每请求 audit 如实一行）；KB_HARVEST_SKIP_LIVE=1 跳过并明示。
"""
import io
import os
import sys
import tempfile
from pathlib import Path

import pytest
from PIL import Image

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
        DownloadAdapter, HarvestPlan, LadderResult, WALL_BLOCKED_WAF)
    from kb_factory.harvest_engine.adapters.docin import (
        CONTAINER_E_CANDIDATES, DOCIN_HOME, JPG_BASE_CANDIDATES,
        PAGE_JPG_WIDTH_DEFAULT, DocinAdapter, DocinError, DocPageConfig,
        classify_asset, container_page_url, doc_url, extract_pid,
        harvest_plan_pages, page_jpg_url, parse_reader_config, parse_read_left,
        parse_search_links, read_left_url, svgbyjson_doc_url, svgbyjson_file_url)
    from kb_factory.harvest_engine.audit import HarvestAudit
    from kb_factory.harvest_engine.probe.health import FISH_PROBE_VERDICTS
except ImportError:
    from channel_adapters.base import FileMeta  # type: ignore
    from harvest_engine.adapters.base import (  # type: ignore
        DownloadAdapter, HarvestPlan, LadderResult, WALL_BLOCKED_WAF)
    from harvest_engine.adapters.docin import (  # type: ignore
        CONTAINER_E_CANDIDATES, DOCIN_HOME, JPG_BASE_CANDIDATES,
        PAGE_JPG_WIDTH_DEFAULT, DocinAdapter, DocinError, DocPageConfig,
        classify_asset, container_page_url, doc_url, extract_pid,
        harvest_plan_pages, page_jpg_url, parse_reader_config, parse_read_left,
        parse_search_links, read_left_url, svgbyjson_doc_url, svgbyjson_file_url)
    from harvest_engine.audit import HarvestAudit  # type: ignore
    from harvest_engine.probe.health import FISH_PROBE_VERDICTS  # type: ignore

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"

# ---- 2026-10-22 活探针真身锚（_probe/docin/doc_page_1508316827.html；探针件为 GBK
# ---- 误读形态，此处即浏览器 page.content() 解码后结构，逐键同构）----
PID = "1508316827"
SID = "FiaAOchSlaYxPlTZbvd2c4pgA9Z5X3NNQvTARlpHKPVkSiug4La3iuxey1BsO1BG"
READER_HTML = (
    "<!DOCTYPE html><html><head><title>2012考研政治法律基础复习方法归纳-豆丁网</title></head><body>\n"
    "<script>\n"
    "var clickTabNumbers = {\"copy_btn\":7069,\"search_btn\":7068};\n"
    "var readerConfig = {\n"
    "\tallPage:4,\n"
    "\tproductId:1508316827,\n"
    "\thtLoadurl:['https://page.douding.cn/docinpage1/htm/des/',\"http://221.122.117.73/pdf2html.jsp?file=\"],\n"
    "\tbookMark:0,\n"
    "\tisLogin:0,\n"
    "\tbookmarkid:0,\n"
    "\tpreviewNum:0,\n"
    "\tisBuy:1,\n"
    "\tshowStyle:1,\n"
    "\tshowAd:true,\n"
    "\tdocstatus:0,//1:转换中  2：审核中  3：转换失败 0：普通\n"
    "\treferer:0,\n"
    "\tappCanRead:\"1\",\n"
    "\tflash_param_hzq:\"FiaAOchSlaYxPlTZbvd2c4pgA9Z5X3NNQvTARlpHKPVkSiug4La3iuxey1BsO1BG\",\n"
    "    pubInt:\"0\",\n"
    "    userId:\"146430132\",\n"
    "    productName:\"2012年考研政治法律基础复习方法归纳\",\n"
    "    userName:\"351dc7c0\",\n"
    "    docType:\"0\", // 1 企业工具 2 建筑 0 普通文档 3:转换失败图片文档\n"
    "    getPicStyle:\"2\",\t// 1 HuangKe 2 MaJun\n"
    "\trandom:'20261012',\n"
    "\tload_url:'page.douding.cn/docinfile2/ddes',\n"
    "    filepostfix:'docx'\n"
    "};\n"
    "var picture_image_path_v1 = \"https://hs.douding.cn\";\n"
    "var canvas_version = \"jgcw2024-08-29160535-02\";\n"
    "var statJson = {\"inf\":0,\"docType\":0,\"pid\":1508316827,\"suffix\":\"docx\",\"ua\":\"chrome\",\"pc\":1,\"page\":4};\n"
    "</script></body></html>")

LIVE_DOC_URL = f"https://www.docin.com/p-{PID}.html"


def _jpeg_bytes(width: int = 60, height: int = 80) -> bytes:
    """离线确定性 JPEG（PIL 合成；魔数 ffd8ff 实测可过 JPEG 判定）。"""
    buf = io.BytesIO()
    Image.new("RGB", (width, height), (180, 180, 180)).save(buf, format="JPEG")
    return buf.getvalue()


JPEG_BYTES = _jpeg_bytes()

#: 手汇复活台账（任务卡授权形态；口径见模块 docstring）
REVIVAL_LEDGER = {
    "docin": {"level": "full",
              "evidence": "T34 实弹：p-1508316827 同会话 4 页页图真实下载（790 宽全分辨率）"
                          "→像素拼 PDF→OCR 文字层→NFR-GATE 质检门全过（test_fr6_ac1_live_"
                          "download_passes_quality_gate，8 发/预算 15）；L1 独立 httpx 复现 "
                          "200 全字节一致；容器取样（page_e0 12KB/head_e0 1.87MB，magic "
                          "01000000..）落档。**内容核验警示（如实）**：该 pid jpg 缓存 4 页"
                          "全文=「内江师范学院2011年工作总结」≠文档页声明「2012考研政治…」"
                          "（站方缓存键位错位，L3 渲染腿对拍实锤 canvas 真身=考研政治）——"
                          "入编目前须走 svgbyjson/容器腿或加内容抽查"},
    "book118": {"level": "partial",
                "evidence": "T19 预览页清单链实弹全通（62/62 页清单+verify；"
                            "tests/test_book118_preview.py live）；PDF/质检门腿归 T23 未落"},
    "doc88": {"level": "partial",
              "evidence": "T24 配置发现腿实弹（key2 info XML/key1 m_main 双路；"
                          "tests/test_doc88_info.py live）；ebt 下载/FFDec→PDF 腿归 T27/T32 未落"},
    "wenku": {"level": "partial",
              "evidence": "T18 docId 侧门检索实弹（syncmrecall 免登录 12 条；"
                          "tests/test_wenku_docid.py live）；下载链归 T22/T26/T31/T35 未落"},
}


class StubSession:
    """session_factory 注入替身：页 HTML 预置 + 资产表驱动（网络注入点，零真实网络）。"""

    def __init__(self, html: str, assets: dict | None = None, captured: dict | None = None):
        self.html = html
        self.assets = assets or {}
        self.captured = captured or {}
        self.fetched: list[str] = []
        self.closed = False

    def fetch(self, url: str):
        self.fetched.append(url)
        status, ctype, body = self.assets.get(url, (403, "text/html", b"forbidden"))
        return status, ctype, body, "stub"

    def close(self):
        self.closed = True


def _stub_assemble_ok(tmp_path: Path):
    """assemble 注入替身：写真实占位 PDF + 实测口径返回值（管线注入点）。"""
    pdf = tmp_path / "stub_out" / "docin_searchable.pdf"
    pdf.parent.mkdir(parents=True, exist_ok=True)
    pdf.write_bytes(b"%PDF-1.4 stub")

    def assemble(jpg_paths, out_dir, cfg, expected, truncated):
        return str(pdf), len(jpg_paths), 1234, 0
    return assemble


def _meta() -> FileMeta:
    return FileMeta(title="2012年考研政治法律基础复习方法归纳", fmt="docx",
                    source_url=LIVE_DOC_URL)


# ---------------------------------------------------------------- FR6.AC1 纯函数层

def test_fr6_ac1_extract_pid_forms():
    """pid 定位：/p-{pid}.html 全形态 + 裸数字；非豆丁域/无数字如实 None。"""
    assert extract_pid(LIVE_DOC_URL) == PID
    assert extract_pid("https://www.docin.com/p-1508316827.html?recid=1") == PID
    assert extract_pid("http://www.docin.com/p-996237502.html") == "996237502"
    assert extract_pid(PID) == PID
    assert extract_pid("https://www.docin.com/search.do?nkey=x") is None
    assert extract_pid("https://example.com/p-123.html") is None
    assert extract_pid("") is None


def test_fr6_ac1_parse_reader_config_real_block():
    """文档页 readerConfig 直采（探针真身锚，结构逐键断言；SPEC §1.2/§4）。"""
    cfg = parse_reader_config(READER_HTML)
    assert isinstance(cfg, DocPageConfig)
    assert cfg.product_id == 1508316827 and cfg.all_page == 4
    assert cfg.sid == SID and len(cfg.sid) == 64  # 实测 64（SPEC §1.5「80」误记，真身为准）
    assert cfg.load_url == "page.douding.cn/docinfile2/ddes"
    assert cfg.pic_style == 2 and cfg.doc_type == 0 and cfg.doc_status == 0
    assert cfg.preview_num == 0 and cfg.is_buy == 1 and cfg.is_login == 0
    assert cfg.file_postfix == "docx"
    assert cfg.product_name == "2012年考研政治法律基础复习方法归纳"
    assert cfg.picture_base == "https://hs.douding.cn"
    assert cfg.canvas_version == "jgcw2024-08-29160535-02"
    assert cfg.stat_page == 4  # statJson.page 与 allPage 同值（SPEC §4 交叉校验）
    assert parse_reader_config("<html>无 readerConfig</html>") is None
    assert parse_reader_config("") is None


def test_fr6_ac1_url_builders_spec_shapes():
    """URL 组装（SPEC §1.4 阅读器 JS 原文口径）：MaJun=load_url 直用、SVG=des 固定基址、
    svgbyjson 两变体、页图 t.docin 带 sid/width/watermark、readLeft。"""
    cfg = parse_reader_config(READER_HTML)
    assert doc_url(PID) == LIVE_DOC_URL
    # MaJun 主型（getPicStyle=2）：基址=readerConfig.load_url 原样拼 https://
    assert container_page_url(cfg, 1) == (
        f"https://page.douding.cn/docinfile2/ddes/page_1508316827_1.docin?sid={SID}")
    # SVG 型（getPicStyle=1）：硬编码 des 基址（JS initDocinSVGRender 原文）
    svg_cfg = DocPageConfig(product_id=123, sid="S1", all_page=2, load_url="x/y",
                            pic_style=1)
    assert container_page_url(svg_cfg, 2) == (
        "https://page.douding.cn/docinfile2/des/page_123_2.docin?sid=S1")
    # svgbyjson ebook/txt 型两变体（JS supportEbookCanvas/b64dataFun 原文）
    assert svgbyjson_file_url(123, "S1", 3) == (
        "https://page.douding.cn/huangke/docxinshi/file/123/svgbyjson/page-3.json"
        "?id=123&ext=txt&sid=S1&width=800&height=1000&font-size=14")
    assert svgbyjson_doc_url(123, "S1", 3, watermark=0) == (
        "https://page.douding.cn/huangke/docxinshi/doc/123/svgbyjson/page-3.json.z.b64"
        "?sid=S1&watermark=0")
    # 页图真身（T34 实弹修正：SPEC §1.4 的 t.docin.com 系 JS 局部变量 t 误读为主机名，
    # 真身=page.douding.cn/huangke/docxinshi 家族；t.docin.com 形态一律 nginx 403）
    assert page_jpg_url(PID, SID, 2, 1000) == (
        f"https://page.douding.cn/huangke/docxinshi/doc/{PID}/jpg/page-2.jpg?sid={SID}"
        f"&width=1000&watermark=0")
    assert read_left_url(PID) == f"https://www.docin.com/newEnd/readLeft.do?pid={PID}"
    assert read_left_url(PID, free=True) == (
        f"https://www.docin.com/newEnd/readLeft.do?pid={PID}&free=1")


def test_fr6_ac1_harvest_plan_pages_full_truncate_degrade():
    """可收割页规划：previewNum=0 全页；0<previewNum<allPage 截断+partial；docstatus!=0/
    docType==3 黄标降级拒收（SPEC §4 可收割性门）。"""
    cfg = parse_reader_config(READER_HTML)
    pages, truncated = harvest_plan_pages(cfg)
    assert pages == [1, 2, 3, 4] and truncated is False
    cfg2 = parse_reader_config(READER_HTML.replace("previewNum:0", "previewNum:2"))
    pages2, truncated2 = harvest_plan_pages(cfg2)
    assert pages2 == [1, 2] and truncated2 is True
    with pytest.raises(DocinError, match="docstatus"):
        harvest_plan_pages(parse_reader_config(
            READER_HTML.replace("docstatus:0", "docstatus:1")))
    with pytest.raises(DocinError, match="docType"):
        harvest_plan_pages(parse_reader_config(
            READER_HTML.replace('docType:"0"', 'docType:"3"')))


def test_fr6_ac1_classify_asset_and_read_left():
    """资产分型：JSON 响应即 svgbyjson 优先探测（任务卡口径）；readLeft code201=登录墙。"""
    assert classify_asset("application/json", b'{"page":1}') == "svgbyjson"
    assert classify_asset("text/html", b'{"a":1}') == "svgbyjson"       # 响应体即 JSON 优先
    assert classify_asset("application/octet-stream", b"\x00\x01docin") == "container"
    assert classify_asset("", b"") == "container"
    assert parse_read_left('{"code":201}') == (201, None)
    assert parse_read_left('{"code":200,"sid":"NEW"}') == (200, "NEW")
    assert parse_read_left("not json") == (None, None)


def test_fr6_ac1_search_parse_links():
    """search 段渲染页解析（离线注入构造页；匿名墙=0 命中如实 []）。"""
    html = ('<div class="search_result"><a href="/p-111111111.html" title="水利施工方案">'
            '水利施工方案.docx</a></div>'
            '<a href="/p-222222222.html">造价指标.pdf</a>')
    metas = parse_search_links(html)
    assert [m.extra["docin_pid"] for m in metas] == ["111111111", "222222222"]
    assert metas[0].fmt == "docx" and metas[1].fmt == "pdf"
    assert all(m.source_url == f"{DOCIN_HOME}/p-{m.extra['docin_pid']}.html" for m in metas)
    assert parse_search_links("<html>登录后操作</html>") == []


# ---------------------------------------------------------------- FR6.AC1 段3/4 编排（注入替身）

#: 容器样本字节（首字节 NUL 用 bytes([0]) 构造，源码不落 NUL 字面量——bash heredoc 坑）
CONTAINER_BODY = bytes([0]) + b"docin-container-sample"

def test_fr6_ac1_adapter_contract_and_plan():
    """DownloadAdapter 子类注册 channel=docin；plan=pid 槽位+L2→L3 梯队序（L1 裸协议
    SPEC §2 实测 403，不进尝试序）。"""
    adapter = DocinAdapter()
    assert issubclass(DocinAdapter, DownloadAdapter)
    assert adapter.site == "docin" and adapter.channel == "docin"
    plan = adapter.plan(_meta())
    assert plan.slot == PID and plan.ladder_try == ("L2", "L3")


def test_fr6_ac1_fetch_ladder_offline_full_chain(tmp_path):
    """L2 编排离线全链：开页→配置直采→容器取样（e 候选首中）→4 页页图→assemble→
    LadderResult(ok/L2/4 页/4/4/chars/gate_exit=0)+meta.extra 落档+audit 每请求一行。"""
    jpg_assets = {page_jpg_url(PID, SID, n, PAGE_JPG_WIDTH_DEFAULT):
                  (200, "image/jpeg", JPEG_BYTES) for n in (1, 2, 3, 4)}
    container = {container_page_url(parse_reader_config(READER_HTML),
                                    int(CONTAINER_E_CANDIDATES[0])):
                 (200, "application/octet-stream", CONTAINER_BODY)}
    session = StubSession(READER_HTML, {**jpg_assets, **container})
    audit_path = tmp_path / "harvest_audit.jsonl"
    adapter = DocinAdapter(session_factory=lambda url: session,
                           assemble=_stub_assemble_ok(tmp_path),
                           l1_fetch=lambda page_url, asset_url: (200, 4096, 200),
                           audit=HarvestAudit(str(audit_path)), out_root=tmp_path)
    meta = _meta()
    result = adapter.fetch_ladder(adapter.plan(meta))
    assert result.ok is True, result.detail
    assert result.ladder_used == "L2" and result.pages == 4 and result.chars == 1234
    assert result.coverage == "4/4" and "gate_exit=0" in result.detail
    assert Path(result.artifact_path).exists()
    assert adapter.verify(result) is True
    assert session.closed is True
    extra = meta.extra
    assert extra["docin_pid"] == PID and extra["docin_all_page"] == 4
    assert extra["docin_sid"] == SID
    assert extra["docin_container_sample"]["status"] == 200
    assert extra["docin_container_sample"]["bytes"] == len(CONTAINER_BODY)
    assert extra["docin_container_sample"]["magic_hex"].startswith("00")
    assert extra["docin_l1_probe"] == {"page_status": 200, "asset_status": 200,
                                       "asset_bytes": 4096}
    lines = audit_path.read_text(encoding="utf-8").splitlines()
    assert any('"event": "open_doc_page"' in ln for ln in lines)
    assert sum('"event": "asset_fetch"' in ln for ln in lines) >= 5  # 1 容器+4 页图
    assert any('"event": "l1_probe"' in ln for ln in lines)


def test_fr6_ac1_fetch_ladder_partial_preview_yellow(tmp_path):
    """previewNum<allPage 预览截断：只收 preview 页+黄标+coverage 部分形态+manifest 走
    preview_limit 参照（gate① 预览上限=部分收割合法形态）。"""
    html = READER_HTML.replace("previewNum:0", "previewNum:2")
    cfg = parse_reader_config(html)
    jpg_assets = {page_jpg_url(PID, SID, n, PAGE_JPG_WIDTH_DEFAULT):
                  (200, "image/jpeg", JPEG_BYTES) for n in (1, 2)}
    session = StubSession(html, {**jpg_assets,
                                 container_page_url(cfg, int(CONTAINER_E_CANDIDATES[0])):
                                 (200, "application/octet-stream", b"c")})
    seen = {}

    def assemble(jpg_paths, out_dir, cfg_, expected, truncated):
        seen["expected"], seen["truncated"] = expected, truncated
        pdf = tmp_path / "p.pdf"
        pdf.write_bytes(b"%PDF-1.4 partial")   # verify 结构门要求产物在盘
        return str(pdf), len(jpg_paths), 99, 0

    adapter = DocinAdapter(session_factory=lambda url: session, assemble=assemble,
                           l1_fetch=lambda p, a: (403, 0, 200), out_root=tmp_path)
    meta = _meta()
    result = adapter.fetch_ladder(adapter.plan(meta))
    assert result.ok is True and result.pages == 2 and result.coverage == "2/4"
    assert seen == {"expected": 2, "truncated": True}
    assert meta.perm == "yellow" and meta.extra["docin_partial_preview"] is True
    assert adapter.verify(result) is True


def test_fr6_ac1_fetch_ladder_wall_403_blocked_waf(tmp_path):
    """资产腿全 403（SPEC §2 实测 nginx 静态闸形态）：ok=False+wall_status=blocked_waf
    落 FileMeta.extra.wall_status（L2-only 计划隔离降级腿）。"""
    session = StubSession(READER_HTML, {})  # 全资产 403
    adapter = DocinAdapter(session_factory=lambda url: session,
                           assemble=_stub_assemble_ok(tmp_path),
                           l1_fetch=lambda p, a: (403, 0, 200), out_root=tmp_path)
    meta = _meta()
    plan = HarvestPlan(meta=meta, ladder_try=("L2",))
    result = adapter.fetch_ladder(plan)
    assert result.ok is False
    assert result.wall_status == WALL_BLOCKED_WAF
    assert meta.extra.get("wall_status") == WALL_BLOCKED_WAF
    assert result.coverage == "0/4"


def test_fr6_ac1_fetch_ladder_budget_guard(tmp_path):
    """≤15 请求预算码内强制：超预算→如实 fail 结果（不静默加发）。"""
    session = StubSession(READER_HTML, {})
    adapter = DocinAdapter(session_factory=lambda url: session,
                           assemble=_stub_assemble_ok(tmp_path),
                           l1_fetch=lambda p, a: (403, 0, 200),
                           out_root=tmp_path, max_requests=2)
    plan = HarvestPlan(meta=_meta(), ladder_try=("L2",))
    result = adapter.fetch_ladder(plan)
    assert result.ok is False and "budget" in result.detail


def test_fr6_ac1_fetch_ladder_degrades_to_l3(tmp_path):
    """L2 全 403→FR1.2 数值化降级真→L3 兜底腿接线（fallback_runner 注入替身验证）。"""
    sentinel = LadderResult(ok=False, ladder_used="L3", detail="l3-stub")
    session = StubSession(READER_HTML, {})
    calls = []

    def fallback_runner(url, out_dir, history):
        calls.append((url, list(history)))
        return sentinel

    adapter = DocinAdapter(session_factory=lambda url: session,
                           assemble=_stub_assemble_ok(tmp_path),
                           l1_fetch=lambda p, a: (403, 0, 200),
                           fallback_runner=fallback_runner, out_root=tmp_path)
    result = adapter.fetch_ladder(adapter.plan(_meta()))
    assert result is sentinel
    assert calls and calls[0][0] == LIVE_DOC_URL
    assert any(e.http_status >= 400 for e in calls[0][1])  # 降级信号=实测 403 事件


def test_fr6_ac1_verify_gate_shapes():
    """verify 段结构门：ok+页数≥1+coverage got==pages+产物在盘+gate_exit=0 明细。"""
    adapter = DocinAdapter()
    ok_pdf = Path(tempfile.gettempdir()) / "docin_verify_probe.pdf"
    ok_pdf.write_bytes(b"%PDF-1.4")
    good = LadderResult(ok=True, ladder_used="L2", artifact_path=str(ok_pdf),
                        pages=4, chars=10, coverage="4/4", detail="gate_exit=0")
    assert adapter.verify(good) is True
    assert adapter.verify(LadderResult(ok=True, pages=4, coverage="3/4",
                                       detail="gate_exit=0")) is False
    assert adapter.verify(LadderResult(ok=True, pages=4, coverage="4/4",
                                       detail="gate_exit=1")) is False   # 质检门未过不算复活
    assert adapter.verify(LadderResult(ok=False, pages=0, coverage="0/4")) is False


def test_fr6_ac1_jpg_base_candidates_ordered():
    """页图索引/宽度自适应候选序（0 基优先——addThumbImg(e){e=e-1} 实参即 0 基；宽幅优先；
    实测发现后锁定）。790=Fish 790x420 遗产宽幅（T34 实测全分辨率可用）；width=1000
    实测回 64B 桩（探针实锤）不入候选。"""
    assert JPG_BASE_CANDIDATES == (0, 1)
    assert PAGE_JPG_WIDTH_DEFAULT == 790  # OCR 可用宽幅（L3 等价抽取同参；790 实测上限）


def test_fr6_ac1_fetch_ladder_blank_page_wm1_upgrade(tmp_path):
    """整页空白页（ink<质检门③下界）→ watermark=1 站方合法变体重取入带 +
    docin_page_wm1 台账落 meta（2026-10-22 实测 p3：wm0 ink=0.0000→wm1 0.0205）。"""
    html = READER_HTML.replace("allPage:4", "allPage:1")
    cfg = parse_reader_config(html)
    buf0, buf1 = io.BytesIO(), io.BytesIO()
    Image.new("RGB", (60, 80), (255, 255, 255)).save(buf0, format="JPEG")  # 纯白=ink 0
    Image.new("RGB", (60, 80), (200, 200, 200)).save(buf1, format="JPEG")  # 有墨
    assets = {
        page_jpg_url(PID, SID, 0, PAGE_JPG_WIDTH_DEFAULT): (200, "image/jpeg", buf0.getvalue()),
        page_jpg_url(PID, SID, 0, PAGE_JPG_WIDTH_DEFAULT, watermark=1):
            (200, "image/jpeg", buf1.getvalue()),
        container_page_url(cfg, int(CONTAINER_E_CANDIDATES[0])):
            (200, "application/octet-stream", b"c"),
    }
    session = StubSession(html, assets)
    adapter = DocinAdapter(session_factory=lambda url: session,
                           assemble=_stub_assemble_ok(tmp_path),
                           l1_fetch=lambda p, a: (200, 10, 200), out_root=tmp_path)
    meta = _meta()
    result = adapter.fetch_ladder(adapter.plan(meta))
    assert result.ok is True, result.detail
    assert meta.extra.get("docin_page_wm1") == [1]
    saved = (tmp_path / "docin_1508316827" / "pages" / "page_001.jpg").read_bytes()
    assert saved == buf1.getvalue()   # 落盘=水印变体（升级生效）


# ---------------------------------------------------------------- FR6.AC1 复活汇总（口径见模块 docstring）

def test_fr6_ac1_revival_ledger_at_least_three_sites():
    """≥3 站复活实证汇总：台账 ≥3 站、≥1 站达「复活」定义（full）；各站域存活零网络
    侧证 FISH_PROBE_VERDICTS（probe/health.py 实测镜像）。partial 不计入复活数（零造假）。"""
    assert len(REVIVAL_LEDGER) >= 3
    full = [s for s, v in REVIVAL_LEDGER.items() if v["level"] == "full"]
    assert len(full) >= 1 and "docin" in full
    hosts = {"docin": "www.docin.com", "book118": "max.book118.com",
             "doc88": "www.doc88.com", "wenku": "wenku.baidu.com"}
    for site, entry in REVIVAL_LEDGER.items():
        assert entry["evidence"], f"{site} 证据为空（零造假）"
        host = hosts.get(site)
        if host in FISH_PROBE_VERDICTS:
            assert FISH_PROBE_VERDICTS[host] in ("alive", "redirect")


# ---------------------------------------------------------------- FR6.AC1 实弹（真实网络 zero-mock）

_LIVE_REASON = "KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（真实网络未跑，公约第4条）"


@pytest.fixture(scope="module")
def chromium():
    """module 级唯一浏览器：fixture 管 launch/close（公约：禁止测试并行开多浏览器）；
    direct:// 直连（本机系统代理死口教训，同 test_book118_preview 实测口径）。"""
    from playwright.sync_api import sync_playwright
    with sync_playwright() as pw:
        browser = pw.chromium.launch(headless=True, args=["--proxy-server=direct://"])
        yield browser
        browser.close()


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason=_LIVE_REASON)
def test_fr6_ac1_live_download_passes_quality_gate(chromium, tmp_path):
    """FR6.AC1 主验收=「复活」定义：豆丁 ≥1 份真实下载过质检门。

    实弹链（预算 ≤15 码内强制）：Playwright 开 p-1508316827（1 发）→页内 sid+同会话
    cookie→容器取样（被动拦截优先）→page.douding.cn/huangke 页图 4 页（790 宽，
    索引/宽度/watermark 自适应）→httpx L1 复现探针（2 发）→像素拼 PDF→OCR 文字层→
    NFR-GATE manifest（ref_chars_source=type2[OCR 全文]，L3 兜底同参口径）退出码 0。

    内容核验警示（2026-10-22 实测如实落档）：该 pid jpg 缓存内容与文档页声明不符
    （缓存=「内江师范学院2011年工作总结」，声明=「2012考研政治…」）；L3 渲染腿对拍
    （capture_page_shots+build_fallback_pdf 直测，969 字 OCR）实锤 canvas 真身=考研政治
    ——本用例证明的是「下载链路+质检门」复活，内容忠实路径须走 svgbyjson/容器腿
    （被动捕获已见 doc/{pid}/svgbyjson/page-0.json.z.b64 在场）或 L3。
    """
    if _LIVE_SKIP:
        print("[live-skip] KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（CI 场景明示）")
        pytest.skip("[live-skip] KB_HARVEST_SKIP_LIVE=1 实弹下载跳过")
    audit_path = tmp_path / "harvest_audit.jsonl"
    adapter = DocinAdapter(browser=chromium, audit=HarvestAudit(str(audit_path)),
                           out_root=tmp_path)
    meta = _meta()
    result = adapter.fetch_ladder(adapter.plan(meta))
    assert result.ok is True, result.detail
    assert result.ladder_used == "L2"
    assert result.pages == 4 and result.coverage == "4/4"
    assert result.chars and result.chars > 0
    assert Path(result.artifact_path).exists()
    assert "gate_exit=0" in result.detail
    assert adapter.verify(result) is True
    assert adapter.requests_used <= 15
    extra = meta.extra
    assert extra["docin_pid"] == PID and extra["docin_all_page"] == 4
    assert len(extra.get("docin_sid", "")) >= 40  # 会话 sid 现取（80 字符型）
    sample = extra.get("docin_container_sample")
    assert isinstance(sample, dict) and "url" in sample  # 容器取样如实落档（含全败形态）
    if sample.get("status") == 200:  # 容器格式 low-medium 置信：成功即如实留档不猜格式
        assert sample["bytes"] > 0 and sample["magic_hex"]
        assert sample["kind"] in ("container", "svgbyjson")
    l1 = extra.get("docin_l1_probe")
    assert isinstance(l1, dict) and l1.get("asset_status") in (200, 206, 403)  # 通/闸两态如实落档
    lines = audit_path.read_text(encoding="utf-8").splitlines()
    assert any('"event": "open_doc_page"' in ln for ln in lines)
    assert any('"event": "asset_fetch"' in ln for ln in lines)
    print(f"[live] docin 复活实证: pages={result.pages} chars={result.chars} "
          f"requests={adapter.requests_used} sample={sample} l1={l1}")
