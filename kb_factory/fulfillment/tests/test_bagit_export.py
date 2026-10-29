# -*- coding: utf-8 -*-
"""bagit_export 测试（v2.6 #2）：tmp 假库→导出→对账全过；篡改 1 字节→对账必败。
覆盖（对齐任务四条）：
1) 导出结构：data/ 三级树 + manifest/bag-info/quote/tagmanifest/bagit.txt 全套
2) 命名律：载荷无空格门（含空格即 ValueError）；包名助手=域名_ISO日期_序号补零
3) 数字零造假：文件数/总字数/Payload-Oxum 全部实测（测试内独立手算对账，不抄实现）
4) verify_bagit：全绿 (N+4, 0)；篡改 1 字节数据件→必败；篡改 tag 件→必败；夹带未登记件→必败
"""
import hashlib
import re
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))  # 仓库根入 sys.path

from kb_factory.fulfillment import bagit_export as bx

PDF_BYTES = b"%PDF-1.4 fake pdf body for bagit test"

# 手算字数基准（count_words 口径：CJK 逐字 + 西文连串）——独立于实现，防循环对账
_FAKE_FILES = {                                     # (内容, 类型, 期望字数)
    "RB-06/01/中国水电市场研究报告2026.pdf": (PDF_BYTES, "bytes", 0),
    "RB-06/01/_INDEX.md": ("# _INDEX\n正文说明\n", "text", 4 + 1),  # 正文说明4+INDEX1
    "RB-06/02/危险源辨识与风险评价方法.md": ("水利安全十处要点 water plan v2\n", "text", 8 + 3),
    "RB-07/01/重大事故隐患判定导则.md": ("正文\n", "text", 2),
    "RB-07/01/统计表.csv": ("项目,数量\n大坝,3\n", "text", 6 + 1),  # 项目数量大坝6+"3"1
    "使用与来源说明.md": ("免责声明\n", "text", 4),
}
_N = len(_FAKE_FILES)
_EXPECT_WORDS = 0 + 5 + 11 + 2 + 7 + 4   # 29：逐件手算之和
_QUOTE = {"库域名": "水利EPC", "订单号": "SMOKE-1022-001", "价格": "0.01", "序号": 1}


def make_fake_kb(tmp: Path) -> Path:
    """tmp 造假知识库（三级镜像树：库/栏目码/序号，6 件，含 1 件二进制 pdf）。"""
    root = tmp / "水利安全知识库W7假库"
    for rel, (content, kind, _) in _FAKE_FILES.items():
        dst = root.joinpath(*rel.split("/"))
        dst.parent.mkdir(parents=True, exist_ok=True)
        if kind == "text":
            dst.write_text(content, encoding="utf-8")
        else:
            dst.write_bytes(content)
    return root


def _flip_last_byte(path: Path):
    """负例工装：只翻 1 个字节（其余一字不动）。"""
    data = path.read_bytes()
    path.write_bytes(data[:-1] + bytes([data[-1] ^ 0x01]))


def test_bagit_export_roundtrip_measured(tmp_path):
    """导出→结构/manifest/bag-info/quote 全检 + 独立实测对账 + verify 全绿。"""
    kb = make_fake_kb(tmp_path)
    bag = tmp_path / "outbox" / bx.suggest_bag_name("水利EPC", 1)
    receipt = bx.export_bagit(kb, bag, _QUOTE)
    # 结构全套（三级树原样落 data/）
    assert (bag / "data" / "RB-06" / "01" / "中国水电市场研究报告2026.pdf").is_file()
    for name in ("manifest-sha256.txt", "bag-info.txt", "quote.txt",
                 "tagmanifest-sha256.txt", "bagit.txt"):
        assert (bag / name).is_file(), name
    assert (bag / "bagit.txt").read_text(encoding="utf-8").startswith("BagIt-Version: 0.97")
    # manifest：行格式「64 位哈希 + 两空格 + data/相对路径」+ 独立重算抽查
    lines = (bag / "manifest-sha256.txt").read_text(encoding="utf-8").splitlines()
    assert len(lines) == _N
    digests = {}
    for line in lines:
        m = re.fullmatch(r"([0-9a-f]{64})  (data/\S+)", line)
        assert m, line
        digests[m.group(2)] = m.group(1)
    probe = bag / "data" / "使用与来源说明.md"
    assert digests["data/使用与来源说明.md"] == hashlib.sha256(probe.read_bytes()).hexdigest()
    # bag-info：任务四要件全部实测（文件数/字数/字节测试内独立重算，不抄实现）
    info = (bag / "bag-info.txt").read_text(encoding="utf-8")
    total_bytes = sum(p.stat().st_size for p in (bag / "data").rglob("*") if p.is_file())
    assert "Library-Domain: 水利EPC" in info                     # 取自 quote_info 库域名
    assert f"Payload-Files: {_N}" in info
    assert f"Payload-Oxum: {total_bytes}.{_N}" in info
    assert f"Total-Word-Count: {_EXPECT_WORDS}" in info          # 手算 29，防实现自证
    assert re.search(r"Bagging-Date: \d{4}-\d{2}-\d{2}", info)   # 生成日期 ISO
    # 报价单 tag 文件：键值逐行 + 序号补零
    quote = (bag / "quote.txt").read_text(encoding="utf-8")
    assert "订单号: SMOKE-1022-001" in quote and "序号: 001" in quote
    # 回执同源实测 + 出厂自检全绿
    assert receipt["files"] == _N and receipt["words"] == _EXPECT_WORDS
    assert receipt["bytes"] == total_bytes and receipt["self_check"] == [_N + 4, 0]
    # 对账全绿：6 载荷 + 4 tag（bagit/bag-info/manifest/quote）= 10 ok / 0 bad
    assert bx.verify_bagit(bag) == (_N + 4, 0)


def test_bagit_tamper_one_byte_fails(tmp_path):
    """负例：篡改 1 字节数据件 → 全量重算对账必败（恰坏 1 件）。"""
    kb = make_fake_kb(tmp_path)
    bag = tmp_path / "bag"
    bx.export_bagit(kb, bag, _QUOTE)
    victim = bag / "data" / "RB-06" / "02" / "危险源辨识与风险评价方法.md"
    _flip_last_byte(victim)
    assert bx.verify_bagit(bag) == (_N + 3, 1)


def test_bagit_tamper_tag_file_fails(tmp_path):
    """负例：篡改 tag 件（quote.txt）→ tagmanifest 对账必败。"""
    kb = make_fake_kb(tmp_path)
    bag = tmp_path / "bag"
    bx.export_bagit(kb, bag, _QUOTE)
    _flip_last_byte(bag / "quote.txt")
    assert bx.verify_bagit(bag) == (_N + 3, 1)


def test_bagit_unlisted_payload_fails(tmp_path):
    """负例：data/ 夹带未登记件 → 完整性清点必败。"""
    kb = make_fake_kb(tmp_path)
    bag = tmp_path / "bag"
    bx.export_bagit(kb, bag, _QUOTE)
    (bag / "data" / "夹带未登记.txt").write_text("x", encoding="utf-8")
    assert bx.verify_bagit(bag) == (_N + 4, 1)


def test_bagit_naming_law_rejects_spaces(tmp_path):
    """命名律门：载荷路径含空格 → ValueError，且不留半成品包目录。"""
    kb = make_fake_kb(tmp_path)
    (kb / "RB-07" / "02").mkdir(parents=True)
    (kb / "RB-07" / "02" / "文件 名.md").write_text("x", encoding="utf-8")
    with pytest.raises(ValueError, match="空格"):
        bx.export_bagit(kb, tmp_path / "bag", _QUOTE)
    assert not (tmp_path / "bag").exists()


def test_bagit_refuses_overwrite_and_empty_src(tmp_path):
    """护栏：out_dir 非空即拒（不覆盖既有交付）；空树拒打空包。"""
    kb = make_fake_kb(tmp_path)
    bag = tmp_path / "bag"
    bx.export_bagit(kb, bag, _QUOTE)
    with pytest.raises(ValueError, match="非空"):
        bx.export_bagit(kb, bag, _QUOTE)
    empty = tmp_path / "empty"
    empty.mkdir()
    with pytest.raises(ValueError, match="空包"):
        bx.export_bagit(empty, tmp_path / "bag2", _QUOTE)


def test_bagit_quote_str_and_none(tmp_path):
    """报价单三种入参：str 原样 / dict 逐行 / None 不产 quote.txt（tag 数随之 -1）。"""
    kb = make_fake_kb(tmp_path)
    bag1 = tmp_path / "bag_str"
    bx.export_bagit(kb, bag1, "总价: 29 元\n有效期: 30 天")
    assert "总价: 29 元" in (bag1 / "quote.txt").read_text(encoding="utf-8")
    assert bx.verify_bagit(bag1) == (_N + 4, 0)
    bag2 = tmp_path / "bag_none"
    receipt = bx.export_bagit(kb, bag2, None)
    assert not (bag2 / "quote.txt").exists()
    assert receipt["tags"] == ["bag-info.txt", "bagit.txt", "manifest-sha256.txt"]
    assert bx.verify_bagit(bag2) == (_N + 3, 0)


def test_bagit_count_words_and_name_helper(tmp_path):
    """字数口径单检（CJK 逐字+西文连串；二进制如实 0）+ 包名助手（ISO 日期+序号补零）。"""
    f = tmp_path / "样例.md"
    f.write_text("水利安全十处要点 water plan v2", encoding="utf-8")
    assert bx.count_words(f) == 8 + 3
    p = tmp_path / "样例.pdf"
    p.write_bytes(PDF_BYTES)
    assert bx.count_words(p) == 0                     # 二进制如实 0，不编数
    assert bx.suggest_bag_name("水利 EPC", 7, date="2026-01-05") == "水利_EPC_2026-01-05_007"
    with pytest.raises(ValueError, match="ISO"):
        bx.suggest_bag_name("x", 1, date="2026/01/05")
