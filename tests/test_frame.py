"""M9.2 框架提取与合成 TDD（PROPOSAL_V2.md 5.2①②）。

- parse_toc：目录文本（章/节两级）→ 节点树（频次占位 0）
- synthesize：多框架节点合并 → master_framework（频次=出现率，
  共识/独家标记）；无 GLM 时用字符相似度本地合并（服务不停摆底线）
"""
from paistation.foundry.frame_extract import parse_toc
from paistation.foundry.frame_synthesis import synthesize


TOC = """第一章 合同风险管理
1.1 风险识别
1.2 风险分担
第二章 索赔管理
2.1 索赔程序
2.2 索赔证据
"""


def test_parse_toc_chapter_section():
    nodes = parse_toc(TOC)
    assert [n["id"] for n in nodes] == [
        "ch1", "ch1.s1", "ch1.s2", "ch2", "ch2.s1", "ch2.s2"]
    assert nodes[0]["title"] == "合同风险管理"
    assert nodes[1]["level"] == "节"


def test_parse_toc_markdown_headings():
    md = "# 总论\n## 背景\n## 现状\n"
    nodes = parse_toc(md)
    assert len(nodes) == 3
    assert nodes[0]["level"] == "章"


def test_parse_toc_empty():
    assert parse_toc("") == []
    assert parse_toc("随便一段没有结构的文字") == []


def test_synthesize_consensus_and_unique():
    f1 = parse_toc(TOC)
    f2 = parse_toc("第一章 合同风险管控\n1.1 风险的识别\n1.2 风险分摊\n")
    master = synthesize([f1, f2])
    titles = {n["title"] for n in master}
    # 同义标题被合并为一簇（取规范代表名）
    assert any("风险识别" in t for t in titles)
    assert any("索赔" in t for n in master for t in [n["title"]])  # f1 独有
    # 频次：共识簇 = 1.0（2/2 框架出现），f1 独有簇 < 1.0
    cons = [n for n in master if "识别" in n["title"]]
    assert cons and cons[0]["frequency"] == 1.0
    uniq = [n for n in master if "索赔" in n["title"]]
    assert uniq and uniq[0]["frequency"] < 1.0


def test_synthesize_marks_sources():
    f1 = parse_toc(TOC)
    f2 = parse_toc("第一章 合同风险管理\n1.1 风险识别\n")
    master = synthesize([f1, f2])
    for node in master:
        assert node["sources"], f"{node['title']} 缺来源"


def test_synthesize_empty_rejected():
    import pytest
    with pytest.raises(ValueError):
        synthesize([])
