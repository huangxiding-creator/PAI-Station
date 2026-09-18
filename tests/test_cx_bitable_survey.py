# -*- coding: utf-8 -*-
"""cx_bitable_survey：多维表盘点纯函数（凭据过滤/分层/时间窗/要点）。"""
from __future__ import annotations

import importlib.util
from pathlib import Path

SCRIPT = Path(__file__).resolve().parent.parent / "tools" / "cx_bitable_survey.py"


def load_module():
    spec = importlib.util.spec_from_file_location("bitable_survey", SCRIPT)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def test_credential_filter():
    m = load_module()
    assert m.is_credential("公众号管理API密钥")
    assert m.is_credential("登录密码表")
    assert not m.is_credential("水利安全助手AI眼镜数据后台")
    assert not m.is_credential("Manus执行-总包50强")


def test_tier_of():
    m = load_module()
    assert m.tier_of("水利稽察助手AI眼镜数据后台") == "probe"
    assert m.tier_of("隐患信息台账") == "probe"
    assert m.tier_of("Manus执行-总包50强") == "meta"


def test_date_window():
    m = load_module()
    rows = [["a", "2026-06-30T18:04:43.000+08:00"],
            ["b", "2026-08-14T10:58:05.000+08:00"],
            ["c", None]]
    lo, hi = m.date_window(rows, ["意见", "时间"], ["text", "created_at"])
    assert (lo, hi) == ("2026-06-30", "2026-08-14")


def test_date_window_empty():
    m = load_module()
    assert m.date_window([["x"]], ["f"], ["text"]) == ("", "")


def test_gist_rows_first_text():
    m = load_module()
    rows = [[None, ["识别不准确"], "2026-07-01"],
            ["模型调用失败了。", None, "2026-08-14"]]
    g = m.gist_rows(rows, ["意见", "标签", "时间"])
    assert g[0] == "识别不准确"
    assert g[1] == "模型调用失败了。"
    assert len(g) == 2


def test_gist_filters_noise():
    m = load_module()
    rows = [["2025-11-26T00:00:00.000+08:00", "什么是扣件式脚手架的主节点？"],
            ["2", "满意度评语样例文本"],
            ["~", None]]
    g = m.gist_rows(rows, ["时间", "意见"])
    assert g == ["什么是扣件式脚手架的主节点？", "满意度评语样例文本"]


def test_gist_rows_limit():
    m = load_module()
    rows = [[f"第{i}条意见样例"] for i in range(5)]
    assert len(m.gist_rows(rows, ["意见"], limit=3)) == 3
