# -*- coding: utf-8 -*-
"""purpose 驱动路由 + 结构 Lint 增强测试（v2.7 #11，波B）。

判据对应：
tp1 三元组派生：水利/律所/财务三域正例（领域词典命中+置信度公式+关键词抽取）
tp2 意图动词映射：建/找/整理/管四动作 + 无动词兜底（低置信如实标注）
tp3 种子域路由：路由命中（six_domains/fibo/thuocl:*）+ 磁盘实存硬门
               （file 类种子缺席必跳过并记 unavailable_skipped）
tp4 lint 分级：critical 负例（空挂组/配比和≠100）与 warn 负例（digest 占比/
               README 槽缺失）逐级检出，健康引擎产出 passed=True
tp5 purpose.md 渲染：一句话使命/三元组/关键约束逐段在场；收口波接线冒烟
               （purpose → suggest_need → build_blueprint → lint 全链跑通）

确定性口径：纯规则零 LLM 零网络，两次调用深度相等；lint 纯读不改入参。
"""
import copy
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

from catalog_engine import purpose                                    # noqa: E402
from catalog_engine.engine import build_blueprint                     # noqa: E402

KB_ROOT = Path(__file__).resolve().parents[2]

# 三域正例句子（构造时已核对：跨域别名零误命中，置信度公式可手算对账）
SENT_WATER = "给水利工程公司建一个EPC行业知识库"      # 工程3命中→0.75
SENT_LAW = "帮律所整理合同范本与诉讼案例"             # 法律2命中→0.67
SENT_FIN = "为企业财务部建会计准则与税务报表库"        # 财务4命中→0.80


# ── tp1 三元组派生（三域正例 + 边界） ─────────────────────────────────────

def test_derive_water_domain():
    p = purpose.derive_purpose(SENT_WATER)
    assert p["domain_guess"]["key"] == "engineering"
    assert p["domain_guess"]["name"] == "工程建设"
    assert p["domain_guess"]["confidence"] == pytest.approx(0.75)   # 3/(3+0+1)
    assert set(p["domain_guess"]["hits"]) >= {"水利", "工程", "EPC"}
    assert p["keywords"][:3] == ["水利", "工程", "EPC"]             # 首现位置序


def test_derive_law_domain():
    p = purpose.derive_purpose(SENT_LAW)
    assert p["domain_guess"]["name"] == "法律律所"
    assert p["domain_guess"]["confidence"] == pytest.approx(0.67)   # 2/(2+0+1)
    assert "律所" in p["keywords"] and "诉讼" in p["keywords"]
    for noun in ("合同", "范本", "案例"):                            # 通用名词库兜底
        assert noun in p["keywords"]


def test_derive_finance_domain():
    p = purpose.derive_purpose(SENT_FIN)
    assert p["domain_guess"]["name"] == "财务会计"
    assert p["domain_guess"]["confidence"] == pytest.approx(0.8)    # 4/(4+0+1)
    assert p["keywords"] == ["财务", "会计", "税务", "报表"]
    assert p["domain_guess"]["clc_hint"] == "F"                     # CLC 兜底类号


def test_derive_edge_inputs_honest():
    # 空串/None：不抛异常，域如实 None、意图走缺省低置信
    for raw in ("", None, "   "):
        p = purpose.derive_purpose(raw)
        assert p["domain_guess"]["name"] is None
        assert p["domain_guess"]["confidence"] == 0.0
        assert p["keywords"] == []
    # 纯英文：拉丁 token 抽取照常（单字母剔除），中文域词典如实零命中
    p = purpose.derive_purpose("build a law knowledge base for my firm")
    assert p["domain_guess"]["name"] is None
    assert "law" in p["keywords"] and "build" in p["keywords"]
    assert all(len(k) >= 2 for k in p["keywords"])


def test_derive_deterministic_and_capped():
    a = purpose.derive_purpose(SENT_WATER)
    b = purpose.derive_purpose(SENT_WATER)
    assert a == b                                                    # 深度相等（确定性）
    long_text = "水利工程施工组织造价监理勘察设计防洪灌溉大坝水库水电站" \
                "市政公路铁路桥梁隧道EPC总承包标准规范模板手册指南台账范本"
    assert len(purpose.derive_purpose(long_text)["keywords"]) <= purpose.KEYWORD_CAP


# ── tp2 意图动词映射（建/找/整理/管 + 兜底） ─────────────────────────────

@pytest.mark.parametrize("sentence,action,verb", [
    (SENT_WATER, "build", "建"),
    ("帮我把水利工程行业标准找齐", "find", "找齐"),       # 同位长词优先于「找」
    (SENT_LAW, "organize", "整理"),
    ("日常管理这批财务档案", "manage", "管理"),           # 「管理」优先于「管」
])
def test_intent_verb_mapping(sentence, action, verb):
    intent = purpose.derive_purpose(sentence)["intent"]
    assert intent["action"] == action
    assert intent["verb"] == verb
    assert intent["confidence"] == pytest.approx(0.9)


def test_intent_fallback_low_confidence():
    p = purpose.derive_purpose("一份水利水电大坝安全监测资料集")     # 无任何动词
    assert p["intent"] == {"action": "build", "verb": None, "confidence": 0.2}


# ── tp3 种子域路由 ─────────────────────────────────────────────────────────

def test_route_water_hits_six_domains():
    routes = purpose.route_seeds(purpose.derive_purpose(SENT_WATER))
    assert routes["mode_hint"] == "six_domains"                     # 强别名口径同 match_seed
    assert routes["domain"] == "工程建设"
    seeds = {r["seed"]: r for r in routes["routes"]}
    assert seeds["six_domains"]["role"] == "主域种子"
    assert seeds["six_domains"]["confidence"] == pytest.approx(0.8)  # 0.5+0.4×0.75
    assert seeds["clc_22"]["role"] == "骨架兜底"
    assert "fibo" not in seeds and "thuocl:law" not in seeds         # 非主域不路由
    # 置信降序 + 同分字典序（确定性排序契约）
    pairs = [(r["confidence"], r["seed"]) for r in routes["routes"]]
    assert pairs == sorted(pairs, key=lambda x: (-x[0], x[1]))


def test_route_law_and_finance_hit_vertical_seeds():
    seeds_law = {r["seed"] for r in purpose.route_seeds(SENT_LAW)["routes"]}
    assert "thuocl:law" in seeds_law and "six_domains" not in seeds_law
    fin = purpose.route_seeds(SENT_FIN)
    seeds_fin = {r["seed"]: r["confidence"] for r in fin["routes"]}
    assert seeds_fin["fibo"] == pytest.approx(0.82)                  # 0.5+0.4×0.80
    assert seeds_fin["thuocl:caijing"] == pytest.approx(0.82)
    assert fin["mode_hint"] == "clc"


def test_route_file_seeds_exist_on_disk():
    """磁盘实存硬门：注册表里每个 file 类种子必须在位（数字零造假：不路由不存在者）。"""
    for entry in purpose.SEED_ROUTES:
        if entry["kind"] == "builtin":
            continue
        assert (KB_ROOT / entry["path"]).exists(), f"注册的种子缺席: {entry['path']}"
    for sentence in (SENT_WATER, SENT_LAW, SENT_FIN):
        routes = purpose.route_seeds(sentence)
        assert routes["unavailable_skipped"] == []                   # 三域正例全实存
        for r in routes["routes"]:
            if r["kind"] == "file":
                assert (KB_ROOT / r["path"]).exists()


def test_route_skips_unavailable_and_records():
    """file 种子缺席 → 跳过 + unavailable_skipped 如实记账；builtin 不受影响。"""
    fake = ({"seed": "six_domains", "kind": "builtin", "path": None,
             "domains": ("工程建设",), "reason": "r"},
            {"seed": "ghost", "kind": "file", "path": "seeds/__nope__",
             "domains": ("工程建设",), "reason": "r"})
    original = purpose.SEED_ROUTES
    purpose.SEED_ROUTES = fake
    try:
        routes = purpose.route_seeds(SENT_WATER)
    finally:
        purpose.SEED_ROUTES = original
    assert routes["unavailable_skipped"] == ["ghost"]
    assert [r["seed"] for r in routes["routes"]] == ["six_domains"]


def test_route_coercion_and_bad_input():
    assert purpose.route_seeds(SENT_LAW) == purpose.route_seeds(purpose.derive_purpose(SENT_LAW))
    with pytest.raises(ValueError):
        purpose.route_seeds(123)


# ── tp4 lint 分级：critical / warn 负例逐级检出 ───────────────────────────

def _slot(name, digest=None, digest_from=None):
    s = {"name": name, "tier": "core", "ext": "md"}
    if digest is not None:
        s["catalog"] = {"digest": digest, "digest_from": digest_from}
    return s


def _bp(ratio=None, l2=None, provenance=None):
    """最小合成蓝图（键族对齐引擎产出；l2 由用例注入负例形态）。"""
    return {"domain": "测试域", "need": {}, "ratio": ratio, "stats": {}, "quote": {},
            "provenance": provenance or {},
            "tree": {"mode": "clc", "root": "测试域", "l1": [
                {"code": "T", "dir": "T-01", "path": "T-01/", "name": "工业技术",
                 "theme": "t", "source": "clc_22", "l2": [l2]}]}}


GOOD_RATIO = {"core": 50, "field": 35, "guide": 15}


def _levels(bp):
    return {c.check_id: c.level for c in purpose.lint_blueprint(bp).checks}


def test_lint_critical_empty_group():
    l2 = {"code": "T-01/01", "path": "T-01/01/", "name": "空挂组", "files": []}
    report = purpose.lint_blueprint(_bp(ratio=GOOD_RATIO, l2=l2))
    assert not report.passed and report.critical >= 1
    assert _levels(_bp(ratio=GOOD_RATIO, l2=l2))["empty_groups"] == "critical"


def test_lint_critical_empty_split_dir():
    l2 = {"code": "T-01/01", "path": "T-01/01/", "name": "分拆组", "files": [],
          "split_dirs": [{"name": "分拆组-1", "path": "T-01/01/分拆组-1/", "files": []}]}
    report = purpose.lint_blueprint(_bp(ratio=GOOD_RATIO, l2=l2))
    detail = next(c.detail for c in report.checks if c.check_id == "empty_groups")
    assert report.critical >= 1 and "分拆空" in detail


@pytest.mark.parametrize("ratio", [
    {"core": 50, "field": 35, "guide": 14},   # 和=99
    {"core": 60, "field": 50},                # 和=110
    {"core": "x", "field": 35, "guide": 15},  # 非数值
])
def test_lint_critical_ratio_sum(ratio):
    l2 = {"code": "T-01/01", "path": "T-01/01/", "name": "组",
          "files": [_slot("a.md")]}
    assert _levels(_bp(ratio=ratio, l2=l2))["ratio_sum"] == "critical"


def test_lint_critical_ratio_missing():
    l2 = {"code": "T-01/01", "path": "T-01/01/", "name": "组", "files": [_slot("a.md")]}
    assert _levels(_bp(ratio=None, l2=l2))["ratio_sum"] == "critical"


def test_lint_warn_digest_ratio():
    l2 = {"code": "T-01/01", "path": "T-01/01/", "name": "组", "files": [
        _slot("a.md"), _slot("b.md"),                                # 无 catalog=缺失
        _slot("c.md", digest="真实渠道摘要若干字", digest_from="wenku")]}
    levels = _levels(_bp(ratio=GOOD_RATIO, l2=l2))
    assert levels["digest_ratio"] == "warn"                          # 2/3 > 50%
    # 边界：恰 50% 不亮黄（严格大于才 warn）
    l2["files"] = [_slot("a.md"), _slot("c.md", digest="真实摘要", digest_from="ima")]
    assert _levels(_bp(ratio=GOOD_RATIO, l2=l2))["digest_ratio"] == "pass"
    # 占位「待补充」同样计缺失（零造假口径）
    l2["files"] = [_slot("a.md", digest=purpose.DIGEST_PLACEHOLDER, digest_from="none")]
    assert _levels(_bp(ratio=GOOD_RATIO, l2=l2))["digest_ratio"] == "warn"


def test_lint_warn_readme_slot_missing_on_v2():
    need = purpose.suggest_need(purpose.derive_purpose(SENT_WATER))
    bp = build_blueprint(need, mode="taxonomy", schema="v2")
    assert _levels(bp)["readme_slots"] == "pass"                     # 立法后齐全
    victim = bp["tree"]["l1"][0]["l2"][0]
    victim.pop("readme_slot")
    check = next(c for c in purpose.lint_blueprint(bp).checks
                 if c.check_id == "readme_slots")
    assert check.level == "warn" and victim["code"] in check.detail


def test_lint_readme_guided_layer_exempt_and_v1_skipped():
    need = purpose.suggest_need(purpose.derive_purpose(SENT_WATER))
    # 导览层组（source=guided_layer）无 readme_slot 属设计形态，不亮黄
    bp = build_blueprint(need, mode="taxonomy", schema="v2", guided=True)
    assert bp["tree"]["l1"][0]["source"] == "guided_layer"           # 挂载前提自证
    assert _levels(bp)["readme_slots"] == "pass"
    # 旧 schema（非 v2）不查 README 槽
    bp_v1 = build_blueprint(need, mode="taxonomy")
    assert _levels(bp_v1)["readme_slots"] == "pass"


def test_lint_healthy_engine_output_passed():
    """健康引擎产出：零 critical（passed=True）；新蓝图全占位 → digest 如实亮黄。"""
    need = purpose.suggest_need(purpose.derive_purpose(SENT_WATER))
    bp = build_blueprint(need, mode="taxonomy")
    report = purpose.lint_blueprint(bp)
    assert report.passed and report.critical == 0
    levels = {c.check_id: c.level for c in report.checks}
    assert levels["empty_groups"] == "pass"
    assert levels["ratio_sum"] == "pass"                             # 50+35+15=100
    assert levels["digest_ratio"] == "warn"                          # 占位槽如实亮黄
    assert "总体通过" in report.summary


def test_lint_readonly_and_deterministic():
    need = purpose.suggest_need(purpose.derive_purpose(SENT_LAW))
    bp = build_blueprint(need, mode="taxonomy")
    snapshot = copy.deepcopy(bp)
    r1 = purpose.lint_blueprint(bp)
    assert bp == snapshot                                             # 纯读不改入参
    assert purpose.lint_blueprint(bp).as_dict() == r1.as_dict()       # 同输入同输出


def test_lint_malformed_blueprint_no_crash():
    for bad in ({}, None, {"tree": None}, {"ratio": []}):
        report = purpose.lint_blueprint(bad)                          # 防御：畸形不崩
        assert len(report.checks) == 4
        assert not report.passed                                      # ratio 契约键缺失=critical


# ── tp5 purpose.md 渲染 + 收口波接线冒烟 ──────────────────────────────────

def test_purpose_md_sections():
    md = purpose.derive_purpose(SENT_WATER)["purpose_md"]
    assert md.startswith("# purpose.md · 工程建设")
    assert "> 一句话使命：" in md and "为工程建设域从零建一座" in md
    assert "- domain_guess: 工程建设" in md and "- keywords: 水利、" in md
    assert "- intent: build/建库" in md
    assert "## 关键约束" in md
    assert "结构先行" in md                       # intent 约束（build）
    assert "标准为核" in md                        # 域约束（工程建设）
    assert "确定性：纯规则派生" in md and "零造假" in md
    # 域未定/动词缺席的兜底渲染也不缺段
    md2 = purpose.derive_purpose("")["purpose_md"]
    assert md2.startswith("# purpose.md · 未定域") and "未显式命中→兜底" in md2


def test_wiring_smoke_full_chain():
    """收口波接线冒烟：一句话 → purpose → 路由 → need → build → lint → provenance 落点。"""
    p = purpose.derive_purpose(SENT_LAW)
    routes = purpose.route_seeds(p)
    need = purpose.suggest_need(p)
    assert need["domain"] == "法律律所知识库"
    assert need["intent"] == "整理归档"                              # organize 桥接
    bp = build_blueprint(need, mode="taxonomy")
    report = purpose.lint_blueprint(bp)
    assert report.passed
    bp["provenance"]["purpose"] = {                                  # 建议落点形态
        "text": p["text"], "domain_guess": p["domain_guess"],
        "keywords": p["keywords"], "intent": p["intent"],
        "seed_routes": routes["routes"], "mode_hint": routes["mode_hint"],
        "structure_lint": report.as_dict()}
    assert bp["provenance"]["purpose"]["structure_lint"]["passed"] is True
    with pytest.raises(ValueError):
        purpose.suggest_need(p, size_hint="mega")                    # size_hint 越界如实拒
