# -*- coding: utf-8 -*-
"""卷宗通道（dossier-first 路由）契约测试。"""

from __future__ import annotations

from pathlib import Path

from paistation.cx.dossier import (
    Section,
    load_dossiers,
    query_grams,
    split_sections,
)


def test_split_sections():
    md = "开头导语\n# 甲\n内容A\n## 乙\n内容B\n"
    secs = split_sections(md)
    assert [h for h, _ in secs] == ["", "甲", "乙"]
    assert "内容A" in secs[1][1] and "内容B" in secs[2][1]
    assert not secs[1][1].startswith("#")  # 原始体无前缀，load 统一加


def test_query_grams_bigrams_and_stops():
    grams = query_grams("我的主业单位与岗位是什么黄河院")
    assert "黄河" in grams and "河院" in grams
    assert "什么" not in grams  # 问句套话剔除
    assert query_grams("We-AIPO 仓库") == {"we-aipo", "仓库"}


def test_route_header_boost():
    from paistation.cx.dossier import DossierIndex
    idx = DossierIndex(sections=[
        Section(text="正文提到黄河院一次", dossier="a", header="其他"),
        Section(text="黄河院 黄河院 黄河院", dossier="b", header="主业单位"),
    ])
    top = idx.route("主业单位是哪个黄河院", k=1)
    assert top and top[0].dossier == "b"  # 标题命中 3 倍加成


def test_long_section_split(tmp_path: Path):
    """巨型 dump 节须被切分（~4k 字 → 2 节），不得整体吸走路由。"""
    (tmp_path / "dump.md").write_text(
        "# 已导入\n" + "\n\n".join(f"第{i}段 噪声词{i}" for i in range(300)),
        encoding="utf-8")
    idx = load_dossiers(tmp_path)
    assert len(idx.sections) == 2  # 3.9k 字按 2500 上限切两节
    assert all(len(s.text) <= 2600 for s in idx.sections)


def test_raw_repetition_is_signal():
    """实测判决（62 vs 50）：打分核用 raw 频次，合法重复=信号。

    防吸流由 _split_long 承担（见 test_long_section_split），
    频次饱和+密度归一已实证过度矫正，弃用。
    """
    from paistation.cx.dossier import DossierIndex
    a = Section(text="黄河院 " * 3, dossier="a", header="")
    b = Section(text="黄河院 黄河院 黄河院 黄河院 黄河院 黄河院",
                dossier="b", header="")
    idx = DossierIndex(sections=[a, b])
    top = idx.route("黄河院在哪", k=1)
    assert top and top[0].dossier == "b"  # 重复多者胜（raw 语义）


def test_load_dossiers_excludes_golden(tmp_path: Path):
    (tmp_path / "profile.md").write_text("# 画像\n黄河院", encoding="utf-8")
    gs = tmp_path / "golden_set"
    gs.mkdir()
    (gs / "golden_100_v1.md").write_text("# 答案\n泄漏", encoding="utf-8")
    idx = load_dossiers(tmp_path)
    assert idx.sections and all("泄漏" not in s.text for s in idx.sections)
