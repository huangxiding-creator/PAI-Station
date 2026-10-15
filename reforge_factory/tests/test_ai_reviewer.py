# -*- coding: utf-8 -*-
"""ai_reviewer 单测 — AI 审稿人固定清单机检 (T-013A / REQ-028).

覆盖 (父指令三点 + 接线):
  ① 合成好稿 → 过线 (verdict=pass, 总分≥75, 十项全在且逐项带依据)
  ② 合成水稿 (套话+无引用+超长段) → 不及格且逐项依据在
  ③ 红队 unanswered → 总分再高也拦 (在档产物读取 / 现场 dry 跑两条路)
附加:
  ④ 权重表与及格线常量对拍 (十项 / 权重归一 / PASS_LINE=75)
  ⑤ 确定性: 同稿两跑逐项同分 (零 LLM 调用, 全机检可复跑)
  ⑥ 框架在场 → 结构项以框架章数为标; 缺席 → ≥3 章下限
  ⑦ 空稿/无正文稿 → 不炸且必不及格 (防空转过线)
  ⑧ 真章只读冒烟 (3-1-hunan.md, 输出落 tmp; 真稿字节不变)
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import ai_reviewer as AR                                     # noqa: E402
import redteam_run as RT                                     # noqa: E402

# ------------------------------------------------------------ 合成好稿
# 要素: ≥3 章 / 数字句>50% / (源N+P锚) 引用>30% / 反证标记≥8 /
# 判断三件套 / 术语首现带定义线索 (EPC→括注, 「两新一重」→括注) / 段落<500字 / 无套话
_GOOD_BODY = []
for i in range(1, 13):
    _GOOD_BODY.append(
        f"第{i}节实测：湖南 EPC 项目 2024 年投资额 {i * 37} 亿元（源1 P{300000 + i * 7}）。"
        f"证据强度评级 B，反证检验：风险信号 {i} 条，然而复核后仍支持主判断。"
        f"结论{i}：市场增速 {i + 2}%，瓶颈可控。")
GOOD_DRAFT = "\n\n".join([
    "# 合成好稿：某省 EPC 总承包市场实测",
    "",
    "EPC（工程总承包）是本章主口径，「两新一重」（新型基础设施+新型城镇化+重大工程）为政策面变量。",
    "",
    "## 一、市场规模", "", "\n\n".join(_GOOD_BODY[:4]),
    "", "## 二、竞争格局", "", "\n\n".join(_GOOD_BODY[4:8]),
    "", "## 三、风险反证", "", "\n\n".join(_GOOD_BODY[8:12]),
    "", "## 四、结论",
    "", "证据强度综合 B+；反证检验通过（风险 11 条均已复核）；结论：进入可行（源2 P400001）。",
])

# ------------------------------------------------------------ 合成水稿
_SLOP_SENT = ("综上所述，值得注意的是，随着建筑行业的不断发展，EPC 赋能平台作为重要抓手，"
              "起到了重要作用，为高质量发展奠定了坚实基础，迈上新台阶，形成完整闭环。")
SLOP_DRAFT = "\n\n".join([
    "# 水稿",
    _SLOP_SENT * 9,                      # 超长段(>500字) × 套话堆砌 × 无数字无引用
    _SLOP_SENT * 9,
])

_REAL_CHAPTER = (Path("E:/AI-Station/_proposals/flagship-paid-report-1007")
                 / "bluebook" / "vol3" / "3-1-hunan.md")


def _review(draft, campaign="SYN-RV", *, framework=None, work_dir, pool_root,
            reject_log=False, source_file=None):
    return AR.review(draft, campaign, framework=framework,
                     work_dir=work_dir, pool_root=pool_root,
                     reject_log=reject_log, source_file=source_file)


def _item(rep, key):
    return next(x for x in rep["checklist"] if x["key"] == key)


# ---- ① 合成好稿 → 过线 -------------------------------------------------------

def test_good_draft_passes(tmp_path):
    rep = _review(GOOD_DRAFT, work_dir=tmp_path / "w", pool_root=tmp_path)
    assert rep["verdict"] == "pass"
    assert rep["total_score"] >= 75.0
    assert len(rep["checklist"]) == 10                     # 固定清单十项
    for it in rep["checklist"]:
        assert 0.0 <= it["score"] <= 10.0
        assert isinstance(it["basis"], str) and it["basis"]  # 逐项依据在
        assert it["weight"] == AR.WEIGHTS[it["key"]]
    assert _item(rep, "redteam")["score"] == 10.0          # 无池+无框架→降级自动回应
    assert (tmp_path / "w" / "ai_review_SYN-RV.json").is_file()


def test_good_draft_reject_log_not_written(tmp_path):
    log = tmp_path / "rejects.jsonl"
    _review(GOOD_DRAFT, work_dir=tmp_path / "w", pool_root=tmp_path,
            reject_log=log)
    assert not log.exists()                                # 过线不打回


# ---- ② 合成水稿 → 不及格且逐项依据在 ---------------------------------------

def test_sloppy_draft_rejected_all_basis_present(tmp_path):
    log = tmp_path / "rejects.jsonl"
    rep = _review(SLOP_DRAFT, work_dir=tmp_path / "w", pool_root=tmp_path,
                  reject_log=log)
    assert rep["verdict"] == "reject"
    assert rep["total_score"] < 75.0
    for it in rep["checklist"]:
        assert isinstance(it["basis"], str) and it["basis"]  # 逐项依据在
    assert _item(rep, "citation")["score"] == 0.0           # 无引用锚
    assert _item(rep, "numeric")["score"] == 0.0            # 无数字句
    assert _item(rep, "slop")["score"] == 0.0               # 套话密度爆表
    assert _item(rep, "paragraph")["score"] <= 2.0          # 超长段惩罚
    assert log.is_file()
    rec = json.loads(log.read_text(encoding="utf-8").strip().splitlines()[-1])
    assert rec["campaign"] == "SYN-RV" and rec["verdict"] == "reject"
    assert rec["total_score"] == rep["total_score"]         # 打回记录可查 (AC1)
    assert (tmp_path / "w" / "ai_review_SYN-RV.json").is_file()


# ---- ③ 红队 unanswered → 总分再高也拦 ---------------------------------------

def test_redteam_product_unanswered_blocks(tmp_path):
    # 好稿 + 在档红队产物含 unanswered → 红队项 0 分, verdict=reject
    w = tmp_path / "w"
    w.mkdir()
    product = w / "redteam_SYN-RV.json"
    product.write_text(json.dumps({
        "campaign": "SYN-RV", "unanswered": ["FP-1", "FP-2"],
        "exit_code": 2, "framework_degraded": False,
        "failure_paths": [{"id": "FP-1"}, {"id": "FP-2"}]}, ensure_ascii=False),
        encoding="utf-8")
    rep = _review(GOOD_DRAFT, work_dir=w, pool_root=tmp_path)
    assert _item(rep, "redteam")["score"] == 0.0
    assert rep["verdict"] == "reject"                      # 总分再高也拦
    assert rep["redteam"]["unanswered"] == ["FP-1", "FP-2"]
    assert any("红队" in r for r in rep["reject_reasons"])
    # 审稿人只读红队产物, 不改写
    assert "FP-1" in product.read_text(encoding="utf-8")


def test_redteam_live_dry_run_unanswered_blocks(tmp_path):
    # 池+框架在场 → 现场 dry 跑红队 → 未回应失败路径 → 拦; 且不落红队产物
    pool = tmp_path / "SYN-RV2"
    pool.mkdir()
    (pool / "question_tree.json").write_text(json.dumps({
        "campaign": "SYN-RV2", "topic": "某省EPC",
        "hypotheses": [{"id": "H1", "text": "扩张", "prior": 0.4}],
        "subquestions": [], "stats": {}}, ensure_ascii=False), encoding="utf-8")
    (pool / "manifest.jsonl").write_text(json.dumps({
        "ts": "2026-12-31T00:00:00", "engine": "rss:x", "chars": 100,
        "judge": "valid", "tree_node": "Q1", "stance": "support"},
        ensure_ascii=False) + "\n", encoding="utf-8")
    (pool / "pool_state.json").write_text("{}", encoding="utf-8")
    rep = _review(GOOD_DRAFT, campaign="SYN-RV2",
                  framework="# 战役\n## 第一章 规模\n## 第二章 风险\n",
                  work_dir=tmp_path / "w", pool_root=tmp_path)
    assert _item(rep, "redteam")["score"] == 0.0
    assert rep["redteam"]["unanswered"]
    assert rep["verdict"] == "reject"
    assert not (tmp_path / "w" / "redteam_SYN-RV2.json").exists()  # dry 不落盘


def test_redteam_answered_product_passes_item(tmp_path):
    w = tmp_path / "w"
    w.mkdir()
    (w / "redteam_SYN-RV.json").write_text(json.dumps({
        "campaign": "SYN-RV", "unanswered": [], "exit_code": 0,
        "framework_degraded": False, "failure_paths": []}, ensure_ascii=False),
        encoding="utf-8")
    rep = _review(GOOD_DRAFT, work_dir=w, pool_root=tmp_path)
    assert _item(rep, "redteam")["score"] == 10.0
    assert rep["verdict"] == "pass"


# ---- ④ 权重表与及格线常量对拍 ------------------------------------------------

def test_weights_and_pass_line_constants():
    assert len(AR.WEIGHTS) == 10
    assert AR.WEIGHT_SUM == pytest.approx(
        0.10 + 0.20 + 0.15 + 0.15 + 0.10 + 0.05 + 0.05 + 0.10 + 0.10 + 0.10)
    assert AR.PASS_LINE == 75.0
    assert [k for k, _, _ in AR.CHECKLIST] == list(AR.WEIGHTS)
    # 归一加权: 总分 = Σ(score×w)/Σw×100, 好稿各 10 → 恰 100
    assert AR._weighted_total([10.0] * 10) == pytest.approx(100.0)


# ---- ⑤ 确定性: 同稿两跑逐项同分 ---------------------------------------------

def test_deterministic_rerun_same_scores(tmp_path):
    r1 = _review(GOOD_DRAFT, work_dir=tmp_path / "w1", pool_root=tmp_path)
    r2 = _review(GOOD_DRAFT, work_dir=tmp_path / "w2", pool_root=tmp_path)
    assert r1["total_score"] == r2["total_score"]
    assert [(i["key"], i["score"]) for i in r1["checklist"]] == \
           [(i["key"], i["score"]) for i in r2["checklist"]]


# ---- ⑥ 框架在场 → 结构项以框架章数为标 -------------------------------------

def test_structure_target_follows_framework(tmp_path):
    # extract_chapters 口径: 框架标题含 H1 主题行 + 4 个章标题 = 目标 5
    fw = "# 战役\n" + "\n".join(f"## 第{i}章 X" for i in range(1, 5))
    thin = "# 稿\n\n## 仅一章\n\n正文（源1 P000001）数字 1 亿元，风险 1 条。"
    rep = _review(thin, framework=fw, work_dir=tmp_path / "w", pool_root=tmp_path)
    assert _item(rep, "structure")["score"] == pytest.approx(4.0)   # 2/5×10
    rep2 = _review(thin, work_dir=tmp_path / "w2", pool_root=tmp_path)
    assert _item(rep2, "structure")["score"] == pytest.approx(6.7, abs=0.05)   # 2/3×10


# ---- ⑦ 空稿 → 不炸且必不及格 ------------------------------------------------

def test_empty_draft_rejected_no_crash(tmp_path):
    rep = _review("", work_dir=tmp_path / "w", pool_root=tmp_path)
    assert rep["verdict"] == "reject"
    assert rep["total_score"] < 75.0
    assert all(isinstance(i["basis"], str) for i in rep["checklist"])


# ---- ⑧ 真章只读冒烟 (3-1-hunan.md; 真稿字节不变) ---------------------------

@pytest.mark.skipif(not _REAL_CHAPTER.exists(), reason="真章缺席, 跳过实盘冒烟")
def test_real_chapter_readonly_smoke(tmp_path):
    before = _REAL_CHAPTER.read_bytes()
    rep = _review(_REAL_CHAPTER.read_text(encoding="utf-8"),
                  campaign="EPC-BID26-DEMO", work_dir=tmp_path / "w",
                  pool_root=RT.POOL_ROOT)
    assert _REAL_CHAPTER.read_bytes() == before            # 真稿只读
    assert (tmp_path / "w" / "ai_review_EPC-BID26-DEMO.json").is_file()
    # 实测标定回归: 真章数字锚/引用锚/密度/反证位均为高分区
    assert _item(rep, "numeric")["score"] >= 8.0
    assert _item(rep, "citation")["score"] >= 8.0
    assert _item(rep, "density")["score"] >= 8.0
    assert _item(rep, "counter")["score"] >= 8.0
