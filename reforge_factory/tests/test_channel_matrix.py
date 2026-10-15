# -*- coding: utf-8 -*-
"""C 轴传感器 channel_matrix 测试 (T-007E / REQ-020 & REQ-029 前半 / KB-COMPLETENESS-SPEC C 轴).

覆盖:
  1. tmp 夹具 28 渠道 / by_engine 命中 20 → miss_list == 8, green False
  2. 前缀映射: cross:wechat_rss:bidcut → 微信生态(≈搜狗微信/sougo, 近似注明)
     rss:* → RSS 常年收割(族级, 不点亮 named 渠道); f1full:cross:cnki → cnki 直采
  3. 全命中 → green True
  4. 缺口全部转新建队列(C_axis_queue.json) → green True; 部分转 → 仍红
  5. 别名优先级: kb:ima_public 点亮 ima_public 不误吞 ima
  6. 渠道清单读不到 → fail-soft 退化用池 by_engine 引擎清单
  7. 双产物落盘: completeness/C_axis.json + 战役根 channel_matrix.json
  8. 真实池 BID26 只读扫描冒烟(池缺席则 skip, 不造假)
"""
import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from completeness import channel_matrix as cm  # noqa: E402

# ---- 夹具 ---------------------------------------------------------------

GENERIC_IDS = [f"chan{i:02d}" for i in range(1, 29)]  # chan01..chan28 等长防子串互吞


def make_manifest(path, ids, extra=()):
    """28 个 named 渠道清单: ids 为主 + extra 追加 (id, name)."""
    chans = [{"id": i, "name": f"渠道{i}", "runner": "-", "note": "-"} for i in ids]
    for cid, name in extra:
        chans.append({"id": cid, "name": name, "runner": "-", "note": "-"})
    path.write_text(
        json.dumps({"version": 1, "named_channels": chans}, ensure_ascii=False),
        encoding="utf-8",
    )
    return path


def make_pool(path, by_engine):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(
        json.dumps({"campaign": "T", "by_engine": by_engine}, ensure_ascii=False),
        encoding="utf-8",
    )
    return path


@pytest.fixture
def lab(tmp_path):
    """实验室: manifest + pool_state 同目录, 返回 scan 快捷调用."""
    manifest = make_manifest(tmp_path / "channel_manifest.json", GENERIC_IDS)
    pool = tmp_path / "ammo" / "Camp" / "pool_state.json"
    st = {
        "manifest": manifest,
        "pool": pool,
        "root": tmp_path / "ammo",
        "scan": lambda: cm.scan(
            "Camp", pool_root=tmp_path / "ammo", manifest_path=manifest
        ),
    }
    return st


# ---- 1. 20/28 命中 → miss 8 ---------------------------------------------

def test_scan_miss_eight(lab):
    by = {f"eng:{GENERIC_IDS[i]}": 1000 * (i + 1) for i in range(20)}  # 20 渠道直采
    make_pool(lab["pool"], by)
    r = lab["scan"]()
    assert r["channels_total"] == 28
    assert r["channels_hit"] == 20
    assert len(r["miss_list"]) == 8
    assert r["green"] is False
    assert r["hit_ratio"] == round(20 / 28, 4)
    # miss 的是无引擎那 8 个 (chan21..chan28 的名字)
    assert r["miss_list"] == [f"渠道{c}" for c in GENERIC_IDS[20:]]
    assert r["fail_soft"] is False


def test_zero_char_engine_not_hit(lab):
    by = {f"eng:{GENERIC_IDS[0]}": 500, f"eng:{GENERIC_IDS[1]}": 0}
    make_pool(lab["pool"], by)
    r = lab["scan"]()
    assert r["channels_hit"] == 1
    assert r["channels_total"] == 28


# ---- 2. 前缀/基名映射 ----------------------------------------------------

def test_prefix_cross_wechat_rss_maps_wechat_ecosystem(lab):
    res = cm.resolve_engine("cross:wechat_rss:bidcut")
    assert "sougo" in res["channels"]                       # 微信生态≈搜狗微信(近似)
    assert any("微信生态" in n for n in res["notes"])       # 近似已注明


def test_prefix_rss_is_fleet_no_named_channel(lab):
    res = cm.resolve_engine("rss:bid26deep")
    assert res["channels"] == []
    assert any("RSS 常年收割" in n for n in res["notes"])


def test_prefix_cross_nested_direct(lab):
    assert "cnki" in cm.resolve_engine("f1full:cross:cnki")["channels"]
    assert "metaso" in cm.resolve_engine("cross:metaso")["channels"]
    assert "weread" in cm.resolve_engine("f1full:cross:weread")["channels"]
    # 建渠缺口基名不硬点亮: 学术/专利留给 T-015
    assert cm.resolve_engine("f1full:cross:academic_en")["channels"] == []
    assert cm.resolve_engine("cross:patents")["channels"] == []


def test_direct_alias_and_stock_prefix(lab):
    assert "manus" in cm.resolve_engine("manus:corps")["channels"]
    assert "sougo" in cm.resolve_engine("wechat:sogou")["channels"]
    assert "cnki" in cm.resolve_engine("paper:cnki")["channels"]
    assert "lark" in cm.resolve_engine("50_飞书语料")["channels"]
    st = cm.resolve_engine("stock:corpus")
    assert "corpus_stores" in st["channels"]                # 存量收割≈存量语料库(近似)
    ws = cm.resolve_engine("search:web")
    assert "websearch" in ws["channels"]                    # 近似


# ---- 3. 全命中 green -----------------------------------------------------

def test_all_hit_green(lab):
    by = {f"eng:{c}": 1234 for c in GENERIC_IDS}
    make_pool(lab["pool"], by)
    r = lab["scan"]()
    assert r["channels_hit"] == r["channels_total"] == 28
    assert r["miss_list"] == []
    assert r["green"] is True
    assert r["hit_ratio"] == 1.0


# ---- 4. 队列转化 green ---------------------------------------------------

def _miss_pool(lab):
    by = {f"eng:{GENERIC_IDS[i]}": 900 for i in range(20)}
    make_pool(lab["pool"], by)


def test_queue_covers_all_miss_turns_green(lab):
    _miss_pool(lab)
    qdir = lab["root"] / "Camp" / "completeness"
    qdir.mkdir(parents=True, exist_ok=True)
    (qdir / "C_axis_queue.json").write_text(
        json.dumps(
            [{"name": f"渠道{c}", "sop_step": 1} for c in GENERIC_IDS[20:]],
            ensure_ascii=False,
        ),
        encoding="utf-8",
    )
    r = lab["scan"]()
    assert len(r["miss_list"]) == 8
    assert r["miss_not_in_queue"] == []
    assert len(r["new_channel_queue"]) == 8
    assert r["green"] is True                                 # 缺口全部转队列 → green


def test_queue_partial_stays_red(lab):
    _miss_pool(lab)
    qdir = lab["root"] / "Camp" / "completeness"
    qdir.mkdir(parents=True, exist_ok=True)
    (qdir / "C_axis_queue.json").write_text(
        json.dumps([{"name": f"渠道{c}", "sop_step": 2} for c in GENERIC_IDS[20:27]],
                   ensure_ascii=False),
        encoding="utf-8",
    )
    r = lab["scan"]()
    assert r["green"] is False
    assert len(r["miss_not_in_queue"]) == 1


def test_queue_accepts_plain_strings_and_ids(lab):
    _miss_pool(lab)
    qdir = lab["root"] / "Camp" / "completeness"
    qdir.mkdir(parents=True, exist_ok=True)
    (qdir / "C_axis_queue.json").write_text(
        json.dumps([GENERIC_IDS[20], f"渠道{GENERIC_IDS[21]}"], ensure_ascii=False),
        encoding="utf-8",
    )
    r = lab["scan"]()
    assert len(r["miss_in_queue"]) == 2
    assert r["green"] is False                                 # 其余 6 个未转


# ---- 5. 别名优先级 -------------------------------------------------------

def test_ima_public_not_swallowed_by_ima(lab):
    assert cm.resolve_engine("kb:ima_public")["channels"] == ["ima_public"]
    assert cm.resolve_engine("kb:ima")["channels"] == ["ima"]
    assert cm.resolve_engine("51_ima知识库")["channels"] == ["ima"]


# ---- 6. 渠道清单 fail-soft ----------------------------------------------

def test_manifest_missing_failsoft_to_engines(lab):
    _miss_pool(lab)
    r = cm.scan("Camp", pool_root=lab["root"],
                manifest_path=lab["root"] / "nope.json")
    assert r["fail_soft"] is True
    # 退化口径: 在役渠道 = 池 by_engine 已见引擎清单(全部命中, 近似注明)
    assert r["channels_total"] == 20
    assert r["channels_hit"] == 20
    assert r["green"] is True
    assert r["miss_list"] == []


def test_manifest_broken_failsoft(lab):
    _miss_pool(lab)
    bad = lab["root"] / "bad.json"
    bad.write_text("{not json", encoding="utf-8")
    r = cm.scan("Camp", pool_root=lab["root"], manifest_path=bad)
    assert r["fail_soft"] is True
    assert r["channels_total"] == 20


def test_pool_state_missing_raises(lab):
    with pytest.raises(FileNotFoundError):
        cm.scan("NoSuchCamp", pool_root=lab["root"], manifest_path=lab["manifest"])


# ---- 7. 双产物落盘 -------------------------------------------------------

def test_write_outputs_both_files(lab):
    _miss_pool(lab)
    r = lab["scan"]()
    out = cm.write(r, "Camp", pool_root=lab["root"])
    c_axis = json.loads(Path(out["c_axis"]).read_text(encoding="utf-8"))
    mirror = json.loads(Path(out["mirror"]).read_text(encoding="utf-8"))
    assert Path(out["c_axis"]).name == "C_axis.json"
    assert Path(out["c_axis"]).parent.name == "completeness"
    assert Path(out["mirror"]).name == "channel_matrix.json"
    for payload in (c_axis, mirror):
        assert payload["axis"] == "C"
        assert payload["sensor"] == "channel_matrix"
        assert {"channels_hit", "channels_total", "miss_list",
                "new_channel_queue", "green"} <= set(payload)
    assert c_axis["miss_list"] == r["miss_list"]


# ---- 8. 真实池 BID26 冒烟 (只读) -----------------------------------------

_REAL_POOL = cm.REPO_ROOT / "ammo_pool" / "EPC-BID26" / "pool_state.json"
_REAL_MANIFEST = cm.DEFAULT_MANIFEST_PATH


@pytest.mark.skipif(not (_REAL_POOL.exists() and _REAL_MANIFEST.exists()),
                    reason="真实池/渠道清单缺席, 跳过实盘冒烟")
def test_real_bid26_readonly_smoke():
    r = cm.scan("EPC-BID26")
    assert r["channels_total"] == 28                    # 实测 named 渠道 28 个
    assert r["fail_soft"] is False
    assert 0 < r["channels_hit"] < 28                   # 传感器非空且非满分(缺口在案)
    assert "manus" in {c["id"] for c in r["hit_channels"]}   # manus:corps 实盘在池
