"""M2.4 分层加载：L0 目录清单/L1 摘要卡/L2 片段+预算内打包+凭据脱敏。"""
from pathlib import Path

from paistation.memory.hybrid import Hit
from paistation.memory.layers import LayeredLoader


def _make_tree(root: Path) -> Path:
    docs = root / "08 成果" / "EPC 调研"
    docs.mkdir(parents=True)
    (docs / "报告.md").write_text("# EPC 调研报告\n\n" + "正文" * 200,
                                  encoding="utf-8")
    (docs / "数据.xlsx").write_bytes(b"\0" * 100)
    other = root / "00 愿景"
    other.mkdir()
    (other / "transcript.md").write_text("语音转写" * 50, encoding="utf-8")
    return root


def test_l0_lists_names_only(tmp_path):
    _make_tree(tmp_path)
    loader = LayeredLoader()
    listing = loader.l0(str(tmp_path))
    assert "08 成果" in listing and "00 愿景" in listing


def test_l2_snippet_truncated(tmp_path):
    _make_tree(tmp_path)
    loader = LayeredLoader()
    path = str(tmp_path / "08 成果" / "EPC 调研" / "报告.md")
    snippet = loader.l2(path, max_chars=100)
    assert len(snippet) <= 120 and "EPC" in snippet


def test_l1_summary_card_cached(tmp_path):
    loader = LayeredLoader(data_dir=tmp_path)
    docs = tmp_path / "项目X"
    docs.mkdir()
    (docs / "a.md").write_text("内容甲", encoding="utf-8")
    (docs / "b.md").write_text("内容乙", encoding="utf-8")
    card1 = loader.l1(docs)
    assert "项目X" in card1 and "a.md" in card1
    card2 = loader.l1(docs)  # 缓存命中：mtime 未变不重扫
    assert card1 == card2


def test_pack_respects_budget(tmp_path):
    _make_tree(tmp_path)
    loader = LayeredLoader(data_dir=tmp_path)
    hits = [Hit(path=str(tmp_path / "08 成果" / "EPC 调研" / "报告.md"),
                layer="L2", score=1.0, snippet="", source="fts")]
    pack_small = loader.pack(hits, budget_tokens=150)
    pack_big = loader.pack(hits, budget_tokens=5000)
    assert len(pack_big) > len(pack_small)
    assert "报告.md" in pack_big
    assert "##" in pack_big  # 包结构：markdown 标题+路径+片段


def test_pack_private_dirs_redacted(tmp_path):
    """凭据目录硬编码黑名单（NFR2）：绝不进上下文包。"""
    cred = tmp_path / "09 发布" / "_credentials"
    cred.mkdir(parents=True)
    secret = cred / "chain.jsonl"
    secret.write_text('{"password": "hunter2"}', encoding="utf-8")
    loader = LayeredLoader()
    hits = [Hit(path=str(secret), layer="L2", score=1.0, snippet="", source="fts")]
    pack = loader.pack(hits, budget_tokens=8000)
    assert "hunter2" not in pack
    assert "_credentials" not in pack or "[已脱敏]" in pack
