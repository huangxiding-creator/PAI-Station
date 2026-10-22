# -*- coding: utf-8 -*-
"""T20 单测+实弹：csdn 适配器 URL 分类 + PDF 分支 blog/answer/column（FR5.1/FR5.AC2）。

被测物 = kb_factory.harvest_engine.adapters.csdn（真 Playwright Chromium，sync API）：
- 离线单测零外网：parseCsdnUrl 六形态/序位、print-CSS 构造器、文件名清洗、
  column_download/未知格式「开页前拒绝」（零上下文断言）+ envelope 口径交叉核；
  data: URL 全链（真浏览器+真点击链+真 PDF 产出，zero-mock）：
  标题 404 门 / 内容缺失 fail-fast / 快照剥脚本 / print-CSS 经 html_to_pdf extra_css 真隐藏。
- 实弹（@pytest.mark.live）= 真实网络 3 份（探针 2026-10-22 选定）：
  blog 1 份全链过 NFR-GATE 质检门（manifest CLI 退出码 0）；
  wenku answer/column 各 1 带 xfail(strict=False)：
  2026-10-22 探针 P2/P3 实证 wenku.csdn.net 匿名无头命中「网站安全验证」WAF 验证码墙
  （30s 不自解 + waf_captcha_marker cookie；探针预算 ≤6 次页面加载已用尽：
  2 次发现+3 次验证+1 次挑战观察）——非 VIP/付费墙（FR5.1 闸门不涉），
  待 storage_state/csdnCookie 供给后同用例应转 XPASS（kit.csdn_context 注入位已就位）；
  KB_HARVEST_SKIP_LIVE=1 时实弹整体跳过（skip reason 明示，公约第 4 条）。
- 禁止测试并行开多浏览器：全模块共用一个 module 级 chromium fixture
  （html_to_pdf 自起自灭浏览器为既定件，串行复用，与 T08 同）。
"""
import json
import os
import random
import subprocess
import sys
import tempfile
from pathlib import Path
from urllib.parse import quote

import pypdfium2
import pytest
from playwright.sync_api import Error as PlaywrightError
from playwright.sync_api import sync_playwright

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
_REPO_ROOT = _KB_DIR.parent                    # 仓根（kb_factory.* 解析）
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    for _anc in _KB_DIR.parents:
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine.adapters.base import LadderResult
    from kb_factory.harvest_engine.adapters.csdn import (
        CONTENT_SELECTORS, CsdnAdapter, CsdnColumnDownloadError, CsdnContentMissingError,
        CsdnPage404Error, CsdnUnsupportedUrlError, build_print_css, dir_name_for,
        parse_csdn_url, sanitize_filename, web_page_to_pdf, web_page_to_pdf_flow)
    from kb_factory.harvest_engine.browser.kit import BrowserKit
    from kb_factory.harvest_engine.envelope import judge_csdn
except ImportError:
    from harvest_engine.adapters.base import LadderResult
    from harvest_engine.adapters.csdn import (
        CONTENT_SELECTORS, CsdnAdapter, CsdnColumnDownloadError, CsdnContentMissingError,
        CsdnPage404Error, CsdnUnsupportedUrlError, build_print_css, dir_name_for,
        parse_csdn_url, sanitize_filename, web_page_to_pdf, web_page_to_pdf_flow)
    from harvest_engine.browser.kit import BrowserKit
    from harvest_engine.envelope import judge_csdn

from kb_factory.channel_adapters.base import FileMeta  # 产线真符号（元数据层口径）

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"

# 实弹文档（探针 2026-10-22 选定；加载失败按探针纪律换篇，探针预算 ≤6 次页面加载已用尽）
BLOG_URL = "https://blog.csdn.net/blogdevteam/article/details/126135357"
ANSWER_URL = "https://wenku.csdn.net/answer/4fg8ohu1wu"
COLUMN_URL = "https://wenku.csdn.net/column/0squu120op1"

_LIVE_DIR = Path(tempfile.gettempdir()) / "kb_t20_csdn_live"  # 运行时产物目录（不入 git，可复跑）


@pytest.fixture(scope="module")
def chromium():
    """module 级唯一浏览器：fixture 管 launch/close（公约：禁止测试并行开多浏览器）。"""
    # --no-proxy-server：目标全为国内 csdn.net，不走系统代理（2026-10-22 实测系统代理
    # 127.0.0.1:7892 间歇性下线会让 Chromium 全导航 ERR_PROXY_CONNECTION_FAILED；直连更稳）
    with sync_playwright() as pw:
        browser = pw.chromium.launch(headless=True, args=["--no-proxy-server"])
        yield browser
        browser.close()


@pytest.fixture
def kit(chromium):
    """每测一个 BrowserKit（同一浏览器内开上下文）；teardown 收口断言零泄漏。"""
    k = BrowserKit(chromium, rng=random.Random(20261022))
    yield k
    k.close_all()
    assert chromium.contexts == [], "生命周期泄漏：kit 收口后浏览器仍有未关上下文"


# ---------------------------------------------------------------- FR5.1 离线：URL 分类

def test_fr5_1_parse_csdn_url_six_forms_and_order():
    """FR5.1/CSDN_SPEC §1.1：六形态分类逐条 + trim + 未知 None + 序位证据。"""
    cases = {
        "blog": "https://blog.csdn.net/blogdevteam/article/details/126135357",
        "answer": "https://wenku.csdn.net/answer/4fg8ohu1wu",
        "column": "https://wenku.csdn.net/column/0squu120op1",
        "column_download": "https://download.csdn.net/blog/column/abc123",
        "doc": "https://wenku.csdn.net/doc/9x2wk1tq",
        "download": "https://download.csdn.net/download/someuser/10385999",
    }
    for expected, url in cases.items():
        assert parse_csdn_url(url) == {"type": expected, "url": url}, url
    # 序位证据：download.csdn.net/blog/column/... 不得被 column/blog 误吃（原作判序）
    assert parse_csdn_url("https://download.csdn.net/blog/column/abc123")["type"] == "column_download"
    # trim（原作 url.trim()）
    assert parse_csdn_url("  " + cases["blog"] + "\n")["url"] == cases["blog"]
    # 未知/近形 URL 一律 None（含 wenku 首页也出现的 download.csdn.net/answer/ 变体——原作同样不识别）
    for bad in ("", "https://example.com/a", "https://blog.csdn.net/nav/other",
                "https://wenku.csdn.net/other", "https://download.csdn.net/answer/e9c66ae9aa3"):
        assert parse_csdn_url(bad) is None, bad


def test_fr5_1_content_selectors_map():
    """FR5.1/CSDN_SPEC §1.1 表：三 PDF 形态内容选择器逐字对齐。"""
    assert CONTENT_SELECTORS == {"blog": "#content_views", "answer": ".content-view",
                                 "column": ".article-box"}


def test_fr5_1_dir_name_for():
    """FR5.1/CSDN_SPEC §1.1：id 只用于输出目录命名（blog_<id>/answer_<id>/column_<id>/resource_<id>）。"""
    assert dir_name_for("blog", BLOG_URL) == "blog_126135357"
    assert dir_name_for("answer", ANSWER_URL) == "answer_4fg8ohu1wu"
    assert dir_name_for("column", COLUMN_URL) == "column_0squu120op1"
    assert dir_name_for("download", "https://download.csdn.net/download/u1/10385999") == "resource_10385999"
    assert dir_name_for("doc", "https://wenku.csdn.net/doc/9x2wk1tq") == "resource_9x2wk1tq"
    assert dir_name_for("blog", "https://blog.csdn.net/x/article/details/", now_ms=123) == "blog_123"


def test_fr5_1_sanitize_filename():
    """FR5.1/CSDN_SPEC §1.2-7：非法字符替换 + 截断 50 + 空标题兜底。"""
    assert sanitize_filename("a/b" + chr(92) + "c:d*e?f" + chr(34) + "g<h>i|j") == "a_b_c_d_e_f_g_h_i_j"
    assert sanitize_filename("正" * 80) == "正" * 50
    assert sanitize_filename("") == "csdn"  # 原作空标题兜底 'csdn'


# ---------------------------------------------------------------- FR5.1 离线：print-CSS 与拒绝路径

def test_fr5_1_build_print_css_selector_stream():
    """FR5.1/CSDN_SPEC §1.2-5（原作 0x292 段逐字移植）：@media print+隐藏清单+选器撑满+pre 换行。"""
    css = build_print_css("#content_views")
    assert css.startswith("@media print{") and css.endswith("}")
    for frag in ("body{margin:5mm;}",           # 原作首条
                 "#toolbarBox", ".print_watermark", ".vip-limited-time-offer-box-new",  # 隐藏清单抽查
                 "#content_views{display:block!important;width:100%!important;"
                 "overflow:hidden!important;padding:10px}",
                 "pre{white-space:pre-wrap!important;word-break:break-all!important;overflow:hidden!important}",
                 ".set-code-height{max-height:none!important}", ".layout{width:1200px!important}"):
        assert frag in css, frag
    assert ".content-view" not in css  # 选器按形态注入，不串味
    css_answer = build_print_css(".content-view")
    assert css_answer != css and ".content-view{display:block" in css_answer


def test_fr5_1_column_download_and_unknown_rejected_before_any_context(kit):
    """FR5.1/CSDN_SPEC §1.1/§4：column_download 一律拒 + 未知格式拒——均在开页前（零上下文证据）。"""
    with pytest.raises(CsdnColumnDownloadError, match="图文专栏暂不支持下载"):
        web_page_to_pdf(kit, "https://download.csdn.net/blog/column/abc123", out_dir=None)
    assert kit.open_context_count == 0  # 拒绝发生在开任何浏览器上下文之前（不烧页面加载）
    with pytest.raises(CsdnUnsupportedUrlError, match="无法识别 CSDN 链接格式"):
        web_page_to_pdf(kit, "https://example.com/a", out_dir=None)
    assert kit.open_context_count == 0
    # envelope 口径交叉核（T02 已就位）：column_download → fail/column（同一拒绝事实，两件一致）
    verdict = judge_csdn({"url_type": "column_download"})
    assert verdict.state == "fail" and verdict.kind == "column"


def test_fr5_1_adapter_four_stage_skeleton(kit, tmp_path):
    """FR5.1：DownloadAdapter 子类骨架——plan 分类/fetch_ladder 拒绝与占位/verify 数值化。"""
    adapter = CsdnAdapter(kit, download_dir=tmp_path)
    plan = adapter.plan(FileMeta(title="图文专栏", fmt="pdf",
                                 source_url="https://download.csdn.net/blog/column/abc123"))
    assert plan.meta.extra["url_type"] == "column_download"
    res = adapter.fetch_ladder(plan)
    assert isinstance(res, LadderResult) and res.ok is False
    assert res.detail == "图文专栏暂不支持下载" and res.wall_status is None  # 合规拒非墙标
    with pytest.raises(CsdnUnsupportedUrlError):
        adapter.plan(FileMeta(title="x", fmt="pdf", source_url="https://example.com/a"))
    # T25 已实装 download/doc 分支：显式 cookie_str=""（免环境串扰）→ 凭据闸门如实挂账拒（零网络）
    gated = CsdnAdapter(kit, download_dir=tmp_path, cookie_str="")
    res2 = gated.fetch_ladder(gated.plan(FileMeta(
        title="doc", fmt="pdf", source_url="https://wenku.csdn.net/doc/9x2wk1tq")))
    assert res2.ok is False and "凭据未供" in res2.detail and res2.wall_status is None
    assert kit.open_context_count == 0  # 以上全部未触网络/未开上下文
    assert adapter.verify(LadderResult(ok=True, artifact_path=None)) is False  # 空产物核不过


# ---------------------------------------------------------------- FR5.1 离线：data: URL 全链（zero-mock）

def _data_url(html: str) -> str:
    return "data:text/html;charset=utf-8," + quote(html)


_OFFLINE_ARTICLE = """<!DOCTYPE html><html><head><title>离线标题 - CSDN博客</title></head><body>
<div class="recommend-box">RECOMMEND_NOISE_MARKER 侧栏推荐噪声不应入正文参照</div>
<h1 class="title-article">离线全链测试文章</h1>
<div id="content_views">
<p>正文第一段：选器流端到端证据 ARTICLE_BODY_MARKER。</p>
<pre><code>def hello():
    return "world"</code></pre>
<p>第二段正文内容，凑足字符量用于字数参照实测。</p>
</div>
<script>document.getElementById("content_views").insertAdjacentHTML("beforeend","<p>JS_RAN_MARKER 动态段落。</p>");</script>
</body></html>"""


def test_fr5_ac2_offline_full_chain_pdf_via_data_url(kit, tmp_path):
    """FR5.AC2 全链离线复现：点击链(无按钮即无害)→标题门→参照实测→剥脚本→print-CSS→真 PDF。"""
    outcome = web_page_to_pdf_flow(kit, _data_url(_OFFLINE_ARTICLE),
                                   content_selector="#content_views",
                                   fallback_name="blog_offline", out_dir=tmp_path)
    assert outcome.title == "离线全链测试文章"  # h1.title-article 优先于 document.title
    assert outcome.dom_chars >= 40  # 内容选择器 innerText 非空白字符实测（数字零造假）
    assert outcome.pdf_path.is_file() and outcome.html_path.is_file()
    snapshot = outcome.html_path.read_text(encoding="utf-8")
    assert "JS_RAN_MARKER" in snapshot     # 脚本执行过的 DOM 痕迹在（动态段落已落 DOM）
    assert "<script" not in snapshot       # 但 <script> 节点已被剥（打印快照纪律）
    doc = pypdfium2.PdfDocument(str(outcome.pdf_path))
    try:
        n_pages = len(doc)
        text = "".join(doc[i].get_textpage().get_text_range() for i in range(n_pages))
    finally:
        doc.close()
    assert n_pages >= 1
    assert "ARTICLE_BODY_MARKER" in text            # 正文进 PDF 文字层
    assert "RECOMMEND_NOISE_MARKER" not in text     # print-CSS 经 html_to_pdf extra_css 真隐藏


def test_fr5_1_title_404_gate_offline(kit, tmp_path):
    """FR5.1/CSDN_SPEC §1.2-6：标题含 404/为空 → 硬拒（页面不存在）。"""
    with pytest.raises(CsdnPage404Error, match=r"页面不存在\(404\)"):
        web_page_to_pdf_flow(kit, _data_url("<html><head><title>页面404错误</title></head>"
                                            "<body></body></html>"),
                             content_selector="#content_views", fallback_name="blog_x",
                             out_dir=tmp_path)


def test_fr5_1_content_missing_failfast(kit, tmp_path):
    """FR5.1：内容选择器空/缺失 → fail-fast（WAF 验证页/结构变更如实暴露，不产空壳 PDF）。"""
    with pytest.raises(CsdnContentMissingError, match="content_views"):
        web_page_to_pdf_flow(kit, _data_url("<html><head><title>正常标题</title></head>"
                                            "<body><h1 class='title-article'>正常标题</h1></body></html>"),
                             content_selector="#content_views", fallback_name="blog_y",
                             out_dir=tmp_path)


# ---------------------------------------------------------------- FR5.AC2 实弹（真实网络）

def _pdf_pages(pdf: Path) -> int:
    doc = pypdfium2.PdfDocument(str(pdf))
    try:
        return len(doc)
    finally:
        doc.close()


def _run_quality_gate(pdf: Path, ref_chars: int, work_dir: Path, url: str,
                      url_type: str) -> subprocess.CompletedProcess:
    """写 manifest（参照值=实测，出处随行声明）+ 调 quality_gate manifest CLI（退出码两态）。"""
    work_dir.mkdir(parents=True, exist_ok=True)
    manifest = {
        "pdf_path": str(pdf),
        "expected_pages": _pdf_pages(pdf),  # 网页无源声明页：实测产物页数入参照（出处随行声明）
        "ref_chars": ref_chars,             # 内容选择器 innerText 非空白字符数
        "ref_chars_source": "type1",        # 五型词表内借用 type1=editor DOM 文本（csdn 未入词表，见交卷报告）
        "pages_render_dir": str(work_dir / "render"),
        "provenance": {"url": url, "url_type": url_type, "task": "T20/FR5.AC2",
                       "expected_pages_source": "产物 PDF pypdfium2 实测（网页无源声明页）",
                       "ref_chars_source_note": "内容选择器 innerText 非空白字符数，借 type1=DOM 文本口径"},
    }
    mpath = work_dir / "gate_manifest.json"
    mpath.write_text(json.dumps(manifest, ensure_ascii=False, indent=2), encoding="utf-8")
    env = dict(os.environ, PYTHONPATH=os.pathsep.join([str(_REPO_ROOT), str(_KB_DIR)]),
               PYTHONIOENCODING="utf-8")
    cp = subprocess.run([sys.executable, "-m", "kb_factory.harvest_engine.quality_gate", str(mpath)],
                        capture_output=True, text=True, encoding="utf-8", errors="replace", env=env)
    print(f"\n[gate] {url_type} {url}\n{cp.stdout}{cp.stderr}")
    return cp


def _primed_storage_state(kit, tmp_path: Path) -> Path:
    """csdn.net 首跳预热登录态（persist:csdn 语义的 storage_state 载入位；对 WAF 验证码墙未必足）。"""
    ctx = kit.csdn_context()
    page = ctx.new_page()
    try:
        page.goto("https://www.csdn.net/", timeout=45_000)
        page.wait_for_timeout(2000)
    except PlaywrightError:
        pass  # 预热失败不阻断：主流程照跑，墙态由 xfail 口径如实呈现
    return kit.persist_storage_state(ctx, tmp_path / "csdn_prime_state.json")


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason="KB_HARVEST_SKIP_LIVE=1：实弹跳过（公约第 4 条，CI 场景明示）")
def test_fr5_ac2_live_blog_pdf_passes_quality_gate(kit):
    """FR5.AC2 实弹 1/3：blog 公开博文 → 选器流 PDF → NFR-GATE manifest CLI 退出码 0。"""
    outcome = web_page_to_pdf(kit, BLOG_URL, out_dir=_LIVE_DIR)
    assert outcome.url_type == "blog" and outcome.dom_chars >= 300  # 探针实测 4012，下限保守
    cp = _run_quality_gate(outcome.pdf_path, outcome.dom_chars, _LIVE_DIR / "blog", BLOG_URL, "blog")
    assert cp.returncode == 0, f"quality_gate CLI rc={cp.returncode}"


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason="KB_HARVEST_SKIP_LIVE=1：实弹跳过（公约第 4 条，CI 场景明示）")
@pytest.mark.xfail(strict=False, raises=(CsdnContentMissingError, PlaywrightError),
                   reason="wenku.csdn.net 匿名无头命中「网站安全验证」WAF 验证码墙"
                          "（2026-10-22 探针 P2/P3：30s 不自解+waf_captcha_marker；非 VIP/付费墙）——"
                          "storage_state/csdnCookie 供给后同用例应转 XPASS")
def test_fr5_ac2_live_answer_pdf_passes_quality_gate(kit, tmp_path):
    """FR5.AC2 实弹 2/3：wenku answer（storage_state 注入位=kit persist 等价；WAF 墙见 xfail 账）。"""
    outcome = web_page_to_pdf(kit, ANSWER_URL, out_dir=_LIVE_DIR,
                              storage_path=_primed_storage_state(kit, tmp_path))
    assert outcome.url_type == "answer" and outcome.dom_chars >= 150
    cp = _run_quality_gate(outcome.pdf_path, outcome.dom_chars, _LIVE_DIR / "answer", ANSWER_URL, "answer")
    assert cp.returncode == 0, f"quality_gate CLI rc={cp.returncode}"


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason="KB_HARVEST_SKIP_LIVE=1：实弹跳过（公约第 4 条，CI 场景明示）")
@pytest.mark.xfail(strict=False, raises=(CsdnContentMissingError, PlaywrightError),
                   reason="同 answer：wenku.csdn.net WAF 验证码墙（探针实证，storage_state 供给后应 XPASS）")
def test_fr5_ac2_live_column_pdf_passes_quality_gate(kit, tmp_path):
    """FR5.AC2 实弹 3/3：wenku column（选器 .article-box；WAF 墙见 xfail 账）。"""
    outcome = web_page_to_pdf(kit, COLUMN_URL, out_dir=_LIVE_DIR,
                              storage_path=_primed_storage_state(kit, tmp_path))
    assert outcome.url_type == "column" and outcome.dom_chars >= 100
    cp = _run_quality_gate(outcome.pdf_path, outcome.dom_chars, _LIVE_DIR / "column", COLUMN_URL, "column")
    assert cp.returncode == 0, f"quality_gate CLI rc={cp.returncode}"
