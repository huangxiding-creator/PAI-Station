# -*- coding: utf-8 -*-
"""收口波 engine 统一接线门禁测试（波A）——五开关 + SKOS 留位逐条固化。

接线对应（engine.py 收口波统一接线，全 env 开关默认关=逐字节零漂移）：
  w1 默认零漂移：全开关关 → canonical_json sha256 与 test_guided_layer.PINNED
     钉子逐一相等（接线前后逐字节不变是最高优先级硬门）
  w2 KB_PURPOSE=1：一句话(水利) → provenance.purpose 落三元组+seed_routes+
     structure_lint（冒烟口径），str 入参经 suggest_need 桥接为引擎 need
  w3 KB_PURPOSE 关=不跑：无 purpose 键；开 + dict 入参 → 原 need 原样不替换
  w4 KB_COLD_EXPAND=1：冷门词（22 大类相关分全零自证）→ L2 供弹换入
     ①clc_layer.clc_expand 真实层（包在位环境）/ ②dendron.expand 模板兜底
     （clc_expand fail-soft 模拟缺席），provenance.cold_expand 如实记账；
     强匹配域（six_domains）不触发=输出与开关关逐字节一致
  w5 KB_TAXONOMY_GATE=1：真库 0 错放行；坏库错误 → ValueError 拒产蓝图+明细；
     首跑缓存 + reset_taxonomy_gate_cache
  w6 KB_VIEWS 三态：views=True / env KB_VIEWS=1 → provenance.views_available
     + stage_log S10 行；默认关不写键；显式 False 压过 env 开
  w7 SKOS 留位：engine.py 源内 KB_SKOS_EXPORT 接线注释在场（留位不丢）
"""
import hashlib
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

from catalog_engine import build_blueprint                       # noqa: E402
from catalog_engine import clc_layer, dendron, engine, taxonomy  # noqa: E402
from catalog_engine.blueprint import canonical_json              # noqa: E402

NEED_LAW = {"domain": "律师事务所知识库", "keywords": ["民法典", "诉讼", "合规", "尽职调查", "劳动争议"],
            "intent": "诉讼与合规", "size_hint": "medium"}
NEED_WATER = {"domain": "水利EPC工程", "keywords": ["水利水电", "EPC总承包", "施工组织设计", "工程监理", "工程造价"],
              "intent": "施工与项目管理", "size_hint": "large"}
# 冷门词样例（构造时核对：domain/intent/keywords 均不含 22 大类别名与六域强别名，
# 测试内再以 _clc_scores 全零自证——词表若日后扩容，此夹具自警不静默漂移）
NEED_COLD = {"domain": "民间剪纸纹样库", "keywords": ["窗花剪纸", "熏样翻刻"],
             "intent": "纹样收集", "size_hint": "small"}
SENT_WATER = "给水利工程公司建一个EPC行业知识库"   # 一句话需求（purpose 桥接冒烟）

ALL_SWITCHES = ("KB_PURPOSE", "KB_COLD_EXPAND", "KB_TAXONOMY_GATE",
                "KB_VIEWS", "KB_GUIDED_LAYER")

# 零漂移钉子：与 catalog_engine/tests/test_guided_layer.py PINNED 同源同值
# （tax-law-None / tax-water-None 两枚，1025 采集；如因获准变更需刷新，两处同步注明）
PINNED_LAW_NONE = "dc2f8e5488321748db48bbabfd52776c2a641cd750a990fe91fab93467ea8fd5"
PINNED_WATER_NONE = "c666c0253dba9ff1b4ba39c36a4b433a38e9eaee63f80b469054b8f05553fc4c"


@pytest.fixture(autouse=True)
def _clean_switches(monkeypatch):
    """开关隔离：每用例前清空五开关 + 门禁缓存复位，测后复位缓存防外泄。"""
    for k in ALL_SWITCHES:
        monkeypatch.delenv(k, raising=False)
    engine.reset_taxonomy_gate_cache()
    yield
    engine.reset_taxonomy_gate_cache()


def _sha(bpd):
    return hashlib.sha256(canonical_json(bpd).encode("utf-8")).hexdigest()


def _l2_names(l1_node):
    return [l2["name"] for l2 in l1_node["l2"]]


# ── w1 默认零漂移（最高优先级硬门）──────────────────────────────────────────

def test_w1_default_all_off_byte_identical():
    """全开关关：law/water 双域 taxonomy 输出与收口波接线前钉子逐字节相等。"""
    assert _sha(build_blueprint(NEED_LAW, mode="taxonomy")) == PINNED_LAW_NONE
    assert _sha(build_blueprint(NEED_WATER, mode="taxonomy")) == PINNED_WATER_NONE
    # 新开关键一律不落（缺省不写键=零漂移的键级自证）
    prov = build_blueprint(NEED_LAW, mode="taxonomy")["provenance"]
    for key in ("purpose", "cold_expand", "views_available"):
        assert key not in prov, f"默认关仍写 {key} 键"


def test_w1_gate_switch_alone_no_output_drift(monkeypatch):
    """KB_COLD_EXPAND/KB_TAXONOMY_GATE 单开但未命中条件 → 输出与全关逐字节一致
    （门禁只拦错库；冷门兜底只对弱匹配生效，强匹配域零波及）。"""
    monkeypatch.setenv("KB_COLD_EXPAND", "1")
    monkeypatch.setenv("KB_TAXONOMY_GATE", "1")
    base = build_blueprint(NEED_WATER, mode="taxonomy")
    monkeypatch.delenv("KB_COLD_EXPAND")
    monkeypatch.delenv("KB_TAXONOMY_GATE")
    off = build_blueprint(NEED_WATER, mode="taxonomy")
    assert canonical_json(base) == canonical_json(off)
    assert "cold_expand" not in base["provenance"]   # six_domains 强匹配不触发


# ── w2/w3 KB_PURPOSE（purpose 前置 + 结构 lint 后置）────────────────────────

def test_w2_purpose_on_water_sentence_smoke(monkeypatch):
    """冒烟口径：KB_PURPOSE=1 水利一句话 → 蓝图 provenance.purpose 有值
    （三元组+seed_routes+structure_lint 全在场），str 经 suggest_need 桥接成引擎
    need（六域强别名命中原样有效）。"""
    monkeypatch.setenv("KB_PURPOSE", "1")
    bpd = build_blueprint(SENT_WATER, mode="taxonomy")
    pu = bpd["provenance"]["purpose"]
    assert pu["text"] == SENT_WATER
    assert pu["domain_guess"]["name"] == "工程建设"      # 三元组：域猜
    assert pu["intent"]["action"] == "build"             # 三元组：意图动词
    assert pu["keywords"]                                # 三元组：关键词非空
    assert pu["mode_hint"] == "six_domains"              # 路由参考（match_seed 同口径）
    seeds = {r["seed"]: r for r in pu["seed_routes"]}    # 种子路由：主域+骨架兜底
    assert "six_domains" in seeds and "clc_22" in seeds
    assert seeds["six_domains"]["role"] == "主域种子"
    assert seeds["clc_22"]["role"] == "骨架兜底"
    sl = pu["structure_lint"]                            # ④ 结构体检报告落点
    assert sl["passed"] is True and sl["critical"] == 0 and sl["summary"]
    assert pu["need_suggested"] == bpd["need"]           # str 入参桥接产出即引擎实需
    assert bpd["tree"]["mode"] == "six_domains"
    assert any(str(x).startswith("S7c purpose 意图层") for x in bpd["provenance"]["stage_log"])


def test_w2_purpose_lint_module_qualified():
    """接线用模块限定名防互踩：purpose.lint_blueprint 与 lint.lint_blueprint
    同名不同义，engine 源内引用必须是 purpose 限定（源码级钉子）。"""
    src = Path(engine.__file__).read_text(encoding="utf-8")
    assert "_purpose.lint_blueprint(bp_dict)" in src


def test_w3_purpose_off_or_dict_need(monkeypatch):
    """开关关=不跑（无 purpose 键、输出与全关逐字节一致）；开 + dict 入参 →
    原 need 原样喂引擎不替换（桥接产出仅作参考入档）。"""
    monkeypatch.setenv("KB_PURPOSE", "0")
    off = build_blueprint(NEED_LAW, mode="taxonomy")
    assert "purpose" not in off["provenance"]
    monkeypatch.setenv("KB_PURPOSE", "1")
    on = build_blueprint(NEED_LAW, mode="taxonomy")
    assert on["need"] == off["need"]                     # dict 入参不被 suggest_need 替换
    assert on["provenance"]["purpose"]["need_suggested"] != on["need"]  # 参考件照记
    assert on["provenance"]["purpose"]["text"].startswith(NEED_LAW["domain"])


# ── w4 KB_COLD_EXPAND（冷门域兜底：clc 真实层优先 / dendron 模板兜底）────────

def test_w4_cold_expand_real_layer_first(monkeypatch):
    """冷门词 + 包在位：①clc_layer.clc_expand 真实层优先供弹（l1_source 全为
    clc_expand），L2 组名=中图法真实二级类名，provenance.cold_expand 如实记账。"""
    if not clc_layer._get_data():                        # 包缺席环境如实跳过本例
        pytest.skip("chinese-library-classification 未安装（真实层用例不适用）")
    monkeypatch.setenv("KB_COLD_EXPAND", "1")
    assert -taxonomy._clc_scores(NEED_COLD)[0][0] == 0   # 夹具自证：22 大类零命中=冷门
    bpd = build_blueprint(NEED_COLD, mode="taxonomy")
    ce = bpd["provenance"]["cold_expand"]
    assert ce["enabled"] is True and ce["l1_source"]
    assert all(s.endswith(":clc_expand") for s in ce["l1_source"])   # ①优先实证
    expect = [ch["name"] for grp in clc_layer.clc_expand("A")["l1"]
              for ch in grp.get("l2", [])][:10]          # plan l2=small=10
    assert _l2_names(bpd["tree"]["l1"][0])[:len(expect)] == expect
    assert any(str(x).startswith("S2c 冷门域兜底") for x in bpd["provenance"]["stage_log"])


def test_w4_cold_expand_dendron_fallback(monkeypatch):
    """冷门词 + clc_expand fail-soft（模拟 pip 缺席→None）：②dendron.expand
    模板兜底供弹（l1_source 全为 dendron_expand），首 L1 组名与 SCHEMA_22["A"]
    模板组逐一相符（冒烟：冷门词→dendron 树）；①②互斥不混入。"""
    monkeypatch.setenv("KB_COLD_EXPAND", "1")
    monkeypatch.setattr(clc_layer, "clc_expand", lambda code, max_depth=None: None)
    bpd = build_blueprint(NEED_COLD, mode="taxonomy")
    ce = bpd["provenance"]["cold_expand"]
    assert all(s.endswith(":dendron_expand") for s in ce["l1_source"])  # ②兜底实证
    ddr = [g["name"] for g in dendron.SCHEMA_22["A"]["groups"]]
    names = _l2_names(bpd["tree"]["l1"][0])
    assert names[:len(ddr)] == ddr                       # 模板组名优先入树
    assert len(names) == 10                              # 原题补位保扇出计划（small=10）


def test_w4_cold_expand_off_keeps_current_topics():
    """开关关：同一冷门词走既有 build_l2_topics 原题（现状即最终兜底，零漂移）。"""
    off = build_blueprint(NEED_COLD, mode="taxonomy")
    assert "cold_expand" not in off["provenance"]
    spec = taxonomy._clc_spec(taxonomy.CLC_22[0])
    assert _l2_names(off["tree"]["l1"][0]) == taxonomy.build_l2_topics(
        spec, engine.validate_need(NEED_COLD), 10)


# ── w5 KB_TAXONOMY_GATE（校验器门禁：首跑缓存 + 非 0 错拒产）─────────────────

def test_w5_gate_real_library_passes(monkeypatch):
    """真库 0 错放行：KB_TAXONOMY_GATE=1 下真跑 validate_library（yaml 全库），
    build 正常产图且首跑缓存落账（errors=[]）。"""
    monkeypatch.setenv("KB_TAXONOMY_GATE", "1")
    bpd = build_blueprint(NEED_LAW, mode="taxonomy")
    assert bpd["stats"]["files"] > 0
    assert engine._TAXONOMY_GATE_CACHE["errors"] == []   # 首跑缓存实证


def test_w5_gate_bad_library_refuses(monkeypatch, tmp_path):
    """坏库拒产：真校验器对 tmp 坏库（YAML 解析失败）产出非空错误 → 注入门禁
    缓存 → build 抛 ValueError 带明细（非 0 错拒产蓝图+明确报错）。"""
    (tmp_path / "bad.yaml").write_text("tree: [unclosed\n", encoding="utf-8")
    ct = engine._load_check_taxonomy()
    errors = ct.validate_library(tmp_path)
    assert errors                                        # 真校验器实证坏库有错
    engine._TAXONOMY_GATE_CACHE["errors"] = errors       # 模拟首跑遇错缓存
    monkeypatch.setenv("KB_TAXONOMY_GATE", "1")
    with pytest.raises(ValueError, match="KB_TAXONOMY_GATE 门禁拒产蓝图"):
        build_blueprint(NEED_LAW, mode="taxonomy")
    engine.reset_taxonomy_gate_cache()                   # 复位后放行（清缓存即重校）
    assert build_blueprint(NEED_LAW, mode="taxonomy")["stats"]["files"] > 0


def test_w5_gate_off_by_default():
    """默认关=零调用：不清缓存/不装载校验器即产图（性能与零漂移考虑）。"""
    assert build_blueprint(NEED_LAW, mode="taxonomy")
    assert "errors" not in engine._TAXONOMY_GATE_CACHE and "module" not in engine._TAXONOMY_GATE_CACHE


# ── w6 KB_VIEWS 三态开关（照 KB_GUIDED_LAYER 模式）──────────────────────────

def test_w6_views_flag_and_env(monkeypatch):
    """views=True（参数）与 KB_VIEWS=1（env）皆挂 attach_views：
    provenance.views_available 三视图在场 + S10 日志行 + 原树零改动自证。"""
    bpd = build_blueprint(NEED_LAW, mode="taxonomy", views=True)
    va = bpd["provenance"]["views_available"]
    assert tuple(va["views"]) == ("by_topic", "by_phase", "by_type")
    assert va["tree_touched"] is False                   # 原树零改动（实测口径）
    assert va["files"] == bpd["stats"]["files"]          # 文件引用守恒
    assert any(str(x).startswith("S10 视图层") for x in bpd["provenance"]["stage_log"])
    monkeypatch.setenv("KB_VIEWS", "1")                  # env 三态：默认看环境变量
    bpd2 = build_blueprint(NEED_LAW, mode="taxonomy")
    assert "views_available" in bpd2["provenance"]


def test_w6_views_explicit_false_beats_env(monkeypatch):
    """三态优先级：显式 views=False 压过 env 开（同 guided 口径）。"""
    monkeypatch.setenv("KB_VIEWS", "1")
    bpd = build_blueprint(NEED_LAW, mode="taxonomy", views=False)
    assert "views_available" not in bpd["provenance"]


def test_w6_views_off_no_key():
    """默认关：无 views_available 键、无 S10 日志行（w1 键级断言的日志面）。"""
    bpd = build_blueprint(NEED_LAW, mode="taxonomy")
    assert "views_available" not in bpd["provenance"]
    assert not any(str(x).startswith("S10 视图层") for x in bpd["provenance"]["stage_log"])


# ── w7 SKOS 可选导出位（接线注释留位钉子）──────────────────────────────────

def test_w7_skos_export_placeholder_pinned():
    """build 是内存函数不强改签名：engine 源内 KB_SKOS_EXPORT 留位注释在场
    （export_blueprint 一站式导出 + 默认关 + provenance 记账归落盘侧三要点齐）。"""
    src = Path(engine.__file__).read_text(encoding="utf-8")
    assert "KB_SKOS_EXPORT" in src
    assert "export_blueprint(bp, out_dir)" in src
    assert "S11 SKOS导出" in src


# ── w8 组合矩阵：全开关齐开确定性 + 日志序 ─────────────────────────────────

def test_w8_all_switches_on_deterministic(monkeypatch):
    """KB_PURPOSE+KB_COLD_EXPAND+KB_TAXONOMY_GATE+KB_VIEWS+KB_GUIDED_LAYER 齐开：
    同输入两次 build canonical_json 逐字节相等（确定性纪律不因接线破）；日志序
    S2c < S7c < S8 < S10（冷门兜底 → purpose 体检 → 导览 → 三视图）。"""
    for k in ("KB_PURPOSE", "KB_COLD_EXPAND", "KB_TAXONOMY_GATE", "KB_VIEWS",
              "KB_GUIDED_LAYER"):
        monkeypatch.setenv(k, "1")
    a = build_blueprint(NEED_COLD, mode="taxonomy")
    b = build_blueprint(NEED_COLD, mode="taxonomy")
    assert canonical_json(a) == canonical_json(b)
    log = [str(x) for x in a["provenance"]["stage_log"]]
    order = [i for i, x in enumerate(log)
             if x.startswith(("S2c ", "S7c ", "S8 ", "S10 "))]
    assert order == sorted(order) and len(order) == 4
    assert "purpose" in a["provenance"] and "cold_expand" in a["provenance"]
    assert "views_available" in a["provenance"] and "guided_layer" in a["provenance"]
