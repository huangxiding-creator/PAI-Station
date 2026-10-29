# -*- coding: utf-8 -*-
"""corpus_align 测试（KB-FACTORY v2.7 #14）。

三层验收：
  A. fail-soft 必绿（离线保证）：重依赖缺席 → {available: False, reason}，绝不抛。
     依赖在场时用幽灵包注入探测名单强制走同一路径——两种环境都全绿。
  B. 纯函数对齐逻辑（零依赖）：L2 展平/词面相似/簇↔L2 裁定/文档取值。
  C. 真聚类 smoke（条件跳过）：依赖+模型都可得才跑小语料真 BERTopic；
     缺席/网络受限一律 skip 并如实记录——skip 不算失败（fail-soft 已单测覆盖）。
"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

import pytest

from corpus_align import DEFAULT_MODEL, align_corpus, probe_deps
from corpus_align import aligner
from corpus_align.aligner import bigram_jaccard, doc_name, doc_text, iter_l2, match_clusters_to_l2

from catalog_engine import build_blueprint  # stdlib 引擎，离线可跑，出真蓝图

LAW_NEED = {"domain": "律师事务所知识库", "keywords": ["民法典", "诉讼", "合规", "尽职调查", "劳动争议"],
            "intent": "诉讼与合规", "size_hint": "small"}


@pytest.fixture(scope="module")
def law_bp():
    return build_blueprint(LAW_NEED)


@pytest.fixture(scope="module")
def law_l2(law_bp):
    return iter_l2(law_bp)


def _docs(n=8, title="民法典合同编案例", text="民法典 合同编 合同效力 违约责任 司法解释 实务"):
    return [{"title": f"{title}{i}", "text": f"{text} 第{i}辑"} for i in range(n)]


# ── A. fail-soft 必绿（离线保证） ──────────────────────────────────────────
def test_failsoft_deps_absent_natural(law_bp):
    """依赖真缺席 → 自然 fail-soft（本机当前即此态，必绿）；在场则让位幽灵包用例。"""
    probe = probe_deps()
    if probe["available"]:
        pytest.skip("重依赖在场：自然缺席路径不适用（幽灵包用例已覆盖同一路径）")
    res = align_corpus(_docs(), law_bp)
    assert res["available"] is False
    assert res["stage"] == "deps"
    assert res["reason"] and "缺席" in res["reason"]
    assert set(res["missing"]) == set(aligner.REQUIRED_DEPS)
    assert res["doc_count"] == 8 and res["l2_count"] > 0


def test_failsoft_ghost_dep_forced(monkeypatch, law_bp):
    """幽灵包注入探测名单 → 无论依赖装没装都强制 fail-soft（CI 双环境全绿腿）。"""
    ghost = "kb_ghost_pkg_zzz"
    monkeypatch.setattr(aligner, "REQUIRED_DEPS",
                        ("bertopic", "sentence_transformers", "torch", ghost))
    res = align_corpus(_docs(), law_bp)
    assert res["available"] is False
    assert res["stage"] == "deps"
    assert ghost in res["missing"] and ghost in res["reason"]


def test_failsoft_bad_blueprint():
    """蓝图无 L2 → input 档 fail-soft（纯规则，不触依赖）。"""
    res = align_corpus(["文档文本"] * 6, {"tree": {}})
    assert res["available"] is False
    assert res["stage"] == "input" and "L2" in res["reason"]
    assert res["l2_count"] == 0


def test_failsoft_too_few_docs(law_bp):
    res = align_corpus([{"title": "孤件"}], law_bp)
    assert res["available"] is False
    assert res["stage"] == "input" and "语料不足" in res["reason"]
    assert res["doc_count"] == 1


def test_failsoft_no_text(law_bp):
    """文档全无可聚类文本 → fail-soft 拒跑（绝不硬跑出空聚类）。"""
    res = align_corpus([{"size_kb": 1}] * 6, law_bp)
    assert res["available"] is False
    assert res["stage"] == "input" and "可聚类文本" in res["reason"]


# ── B. 纯函数对齐逻辑（零依赖，离线可测） ──────────────────────────────────
def test_iter_l2_flattens_blueprint(law_bp, law_l2):
    """展平数=蓝图 stats.l2_count；每条带 code/name/l1_name/text 描述面。"""
    assert len(law_l2) == law_bp["stats"]["l2_count"]
    for x in law_l2:
        assert {"code", "dir", "path", "name", "theme", "l1_code", "l1_name", "text"} <= set(x)
        assert x["name"] and x["text"] and x["l1_name"]


def test_iter_l2_tolerates_bad_shapes():
    """蓝图形状异常宽容：None → []；l1 混入非 dict → 跳过不炸。"""
    assert iter_l2(None) == []
    assert iter_l2({}) == []
    out = iter_l2({"tree": {"l1": [None, "垃圾", {"l2": [None, {"name": "劳动法律"}]}]}})
    assert len(out) == 1 and out[0]["name"] == "劳动法律"


def test_bigram_jaccard():
    assert bigram_jaccard("民法典", "民法典合同编") == pytest.approx(2 / 5)  # 交2个bigram，并5
    assert bigram_jaccard("同文", "同文") == 1.0
    assert bigram_jaccard("刑法", "量子力学") == 0.0
    assert bigram_jaccard("", "任何") == 0.0
    # 近义对必须显著高于无关对（词面相似度的判别力下限）
    assert bigram_jaccard("劳动合同争议", "劳动合同纠纷") > bigram_jaccard("劳动合同争议", "量子力学实验")


def test_match_clusters_to_l2_thresholding():
    sims = [[0.9, 0.2], [0.1, 0.3]]  # 簇0 强命中 l2_0；簇1 最高 0.3 < 0.45 → 盲区
    v = match_clusters_to_l2(sims, threshold=0.45)
    assert v["assignments"][0]["matched"] is True
    assert v["assignments"][0]["l2_index"] == 0
    assert v["assignments"][0]["similarity"] == pytest.approx(0.9)
    assert v["blind"] == [1]
    assert v["covered_l2"] == [0] and v["uncovered_l2"] == [1]


def test_match_clusters_tie_and_empty():
    v = match_clusters_to_l2([[0.5, 0.5]], threshold=0.4)
    assert v["assignments"][0]["l2_index"] == 0  # 并列取小下标（确定性）
    assert match_clusters_to_l2([[]])["assignments"][0]["l2_index"] is None
    assert match_clusters_to_l2([[]])["blind"] == [0]  # 空 L2 面全簇皆盲区


def test_doc_helpers_shapes():
    class _DocFile:  # 仿 catalog_engine.document_engine.DocFile（对象形态）
        title = "对象形态标题"
    assert doc_text({"text": "甲", "title": "乙"}) == "甲"
    assert doc_text({"title": "乙"}) == "乙"
    assert doc_text({"name": "n.pdf", "path": "D-01/01/n.pdf"}) == "n.pdf"
    assert doc_text("纯字符串文档") == "纯字符串文档"
    assert doc_text(_DocFile()) == "对象形态标题"
    assert doc_name({"name": "n.pdf", "title": "t"}) == "n.pdf"
    assert doc_name("s") == "s"
    assert doc_name({"size_kb": 1}) == ""


def test_result_json_serializable_shape(law_bp):
    """fail-soft 结果全 JSON 可序列化（cloudfn 传输面），键面齐整。"""
    monkey = pytest.MonkeyPatch()
    monkey.setattr(aligner, "REQUIRED_DEPS", ("kb_ghost_pkg_zzz",))
    try:
        res = align_corpus(_docs(), law_bp)
    finally:
        monkey.undo()
    assert res["available"] is False
    assert set(res) >= {"available", "stage", "reason", "doc_count", "l2_count"}
    json.dumps(res, ensure_ascii=False)


# ── C. 真聚类 smoke（条件跳过：依赖缺席/模型网络受限 → skip 如实记录） ─────
SMOKE_ENV_LADDER = (
    {},  # 部署默认形态：直连 huggingface.co
    {"HF_HUB_OFFLINE": "1"},  # 离线形态：模型已缓存（免网络检查直取本地缓存）
    {"HF_ENDPOINT": "https://hf-mirror.com"},  # 网络受限形态：hf-mirror 镜像
)
_SMOKE_BASE_ENV = {"HF_HUB_DOWNLOAD_TIMEOUT": "30", "HF_HUB_ETAG_TIMEOUT": "20",
                   "HF_HUB_DISABLE_TELEMETRY": "1"}


def _run_smoke_subprocess(env_extra):
    """干净子进程真跑（HF 网络开关在 huggingface_hub import 时定格，进程内改无效——
    三档环境必须各自独立进程，如实还原部署侧形态；结果经 ASCII-JSON 管道回传）。"""
    import os
    import subprocess
    env = dict(os.environ, **_SMOKE_BASE_ENV, **env_extra)
    runner = Path(__file__).with_name("_smoke_runner.py")
    proc = subprocess.run([sys.executable, "-I", str(runner)], capture_output=True,
                          text=True, encoding="utf-8", errors="replace", env=env,
                          timeout=420, cwd=str(Path(__file__).resolve().parents[2]))
    for line in (proc.stdout or "").splitlines():
        if line.startswith("KBA_SMOKE_RESULT "):
            return json.loads(line[len("KBA_SMOKE_RESULT "):])
    raise RuntimeError(f"smoke 子进程无结果行 rc={proc.returncode} stderr尾="
                       f"{(proc.stderr or '')[-400:]}")


def test_smoke_real_clustering():
    """小语料真 BERTopic：三档环境梯子（默认/离线缓存/镜像），全堵才 skip 如实记录。"""
    if not probe_deps()["available"]:
        pytest.skip(f"bertopic 链缺席（fail-soft 路径已单测覆盖）：{probe_deps()['reason']}")
    last, tried = None, []
    for env_extra in SMOKE_ENV_LADDER:
        tried.append("default" if not env_extra else "+".join(f"{k}={v}" for k, v in env_extra.items()))
        last = _run_smoke_subprocess(env_extra)
        if last["available"]:
            break
        assert last["stage"] != "input", f"smoke input 档失败（非网络面，先修）：{last['reason']}"
    if not last["available"]:
        pytest.skip(f"真跑不可得（依赖在场但模型不可得；fail-soft 路径已单测覆盖）。"
                    f"环境梯子 {tried} 全堵。最后 reason：{last['reason'][:200]}")
    res = last
    assert res["model"] == DEFAULT_MODEL and res["doc_count"] == 63
    assert res["topic_count"] >= 1
    # 文档守恒：入簇数 + 离群数 = 总数
    assert sum(c["count"] for c in res["clusters"]) + res["outliers"]["count"] == 63
    # 盲区 ⊆ 簇集；每簇有词面与匹配裁定
    assert {b["cluster"] for b in res["blind_spots"]} <= {c["topic"] for c in res["clusters"]}
    for c in res["clusters"]:
        assert c["top_words"] and c["count"] >= 1
        assert c["matched_l2"] is None or "code" in c["matched_l2"]
    # L2 覆盖面守恒：matched + unmatched = l2_total
    cov = res["coverage"]
    assert cov["l2_matched"] + len(res["l2_coverage"]["unmatched"]) == cov["l2_total"] == res["l2_count"]
    assert 0.0 <= cov["outlier_ratio"] <= 1.0
    assert res["hierarchy"]["fine_topic_count"] >= res["hierarchy"]["coarse_topic_count"] >= 1
    # 全结果 JSON 可序列化（cloudfn/落盘传输面）
    json.dumps(res, ensure_ascii=False)
