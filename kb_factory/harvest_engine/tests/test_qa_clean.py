# -*- coding: utf-8 -*-
"""qa_clean（全文质检清洗器 C1/轴④）域内测试——全离线、零网络、纯夹具造数。

覆盖：广告页正例（尾注/站点水印行）/页码行/联系方式块/乱码自愈(ops记账)/
      无脏不动(ops==[] 且字节不变)/空白规整/防误伤/件级原件保留与同目录回写。
"""
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))  # E:\AI-Station 入 sys.path
from kb_factory.harvest_engine.qa_clean import clean_text, clean_file  # noqa: E402

# 干净正文夹具（模拟收割全文的正常两章结构）
CONTENT = (
    "第一章 工程总承包模式概述\n"
    "\n"
    "工程总承包是指承包单位按照与建设单位签订的合同，对工程设计、采购、施工等阶段实行全过程承包。\n"
    "\n"
    "第二章 计价依据与调价机制\n"
    "\n"
    "人工费、材料费按造价管理机构发布的信息价逐月调差，税金按现行标准计取。\n"
)


def test_ad_footer_and_watermark_removed():
    """广告页正例：尾注免责行 + 站点水印行 + 转载声明行剔除，正文无伤。"""
    dirty = CONTENT + "\n本文档来自网络整理，仅供学习参考。\n来源：道客巴巴 www.doc88.com\n转载请注明出处\n"
    cleaned, ops = clean_text(dirty, "doc88")
    assert "仅供学习参考" not in cleaned
    assert "道客巴巴" not in cleaned
    assert "www.doc88.com" not in cleaned
    assert "转载请注明出处" not in cleaned
    assert "工程总承包是指" in cleaned and "逐月调差" in cleaned  # 正文保留
    names = {o["op"]: o["count"] for o in ops}
    assert names.get("footer_removed", 0) >= 1
    assert names.get("watermark_removed", 0) >= 2


def test_page_marker_removed():
    dirty = "总则\n\n第 3 页/共 10 页\n承包人应履行合同约定的各项义务。\n"
    cleaned, ops = clean_text(dirty, "wenku")
    assert "第 3 页" not in cleaned and "共 10 页" not in cleaned
    assert "承包人应履行" in cleaned
    names = {o["op"]: o["count"] for o in ops}
    assert names.get("page_marker_removed", 0) == 1


def test_contact_block_removed_prose_kept():
    """联系方式块（连续两行）成块剔除；正文句中提到微信不误伤。"""
    dirty = CONTENT + "\n电话：010-62101234\n微信：kbzixun888\n\n客户可通过微信联系项目负责人。\n"
    cleaned, ops = clean_text(dirty, "wenku")
    assert "010-62101234" not in cleaned
    assert "kbzixun888" not in cleaned
    assert "客户可通过微信联系项目负责人。" in cleaned
    names = {o["op"]: o["count"] for o in ops}
    assert names.get("contact_removed", 0) == 2


def test_mojibake_selfheal_roundtrip():
    """乱码自愈：utf8 字节被按 GBK 误读→回编码自愈回原文，且幂等。"""
    original = "工程造价实务"
    moji = original.encode("utf-8").decode("gbk")  # 复现双解码误码
    text = "# 目录\n\n" + moji + "\n"
    cleaned, ops = clean_text(text, "wenku")
    assert original in cleaned
    assert moji not in cleaned
    names = {o["op"]: o["count"] for o in ops}
    assert names.get("mojibake_fixed", 0) == 1
    _, ops2 = clean_text(cleaned, "wenku")  # 幂等：再洗无 mojibake 操作
    assert all(o["op"] != "mojibake_fixed" for o in ops2)


def test_clean_text_untouched_when_no_dirt():
    """无脏不动：cleaned 与原文逐字节相同，且 ops == []。"""
    cases = (
        CONTENT,
        "单行文本",
        "代码围栏保留：\n\n```python\nprint(1)\n```\n",
    )
    for clean in cases:
        cleaned, ops = clean_text(clean, "wenku")
        assert cleaned == clean
        assert ops == []


def test_whitespace_normalized():
    dirty = "标题\r\n\r\n\r\n正文\xa0一段\u3000测试  内容。\r\n"
    cleaned, ops = clean_text(dirty, "wenku")
    assert "\r" not in cleaned and "\xa0" not in cleaned and "\u3000" not in cleaned
    assert "正文 一段 测试 内容。" in cleaned
    names = {o["op"]: o["count"] for o in ops}
    assert names.get("crlf_normalized", 0) >= 2
    assert names.get("blank_lines_collapsed", 0) >= 1
    assert names.get("nbsp_normalized", 0) >= 2


def test_no_false_positive_on_prose():
    """防误伤：事实性来源行/书名行/正文联系方式句一律保留。"""
    keep = (
        "数据来源：交通运输部2026年统计公报。\n"
        "《百度文库商业模式分析》读后感\n"
        "如有疑问请与招标代理机构联系，联系电话详见招标文件附件。\n"
    )
    cleaned, ops = clean_text(keep, "wenku")
    for line in keep.strip().splitlines():
        assert line in cleaned
    assert all(o["op"] not in ("watermark_removed", "footer_removed", "contact_removed")
               for o in ops)


def test_clean_file_preserves_original():
    """件级：同目录回写 .cleaned.md；原件字节不变（禁删禁改）。"""
    with tempfile.TemporaryDirectory() as td:
        src = Path(td) / "sample.md"
        src.write_text(CONTENT + "\n来源：道客巴巴 www.doc88.com\n", encoding="utf-8")
        before = src.read_bytes()
        res = clean_file(src, source="doc88")
        assert src.read_bytes() == before                    # 原件保留
        out = Path(res["out_path"])
        assert out.exists() and out.parent == src.parent     # 同目录
        assert out.name == "sample.cleaned.md"
        body = out.read_text(encoding="utf-8")
        assert "道客巴巴" not in body and "工程总承包是指" in body
        assert res["changed"] is True
        names = {o["op"]: o["count"] for o in res["ops"]}
        assert names.get("watermark_removed", 0) >= 1
