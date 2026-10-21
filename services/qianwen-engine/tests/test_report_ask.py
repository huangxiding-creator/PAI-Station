# -*- coding: utf-8 -*-
"""v0.9.20 报告对话官（1018 用户令 REQ-001..005 / REQ-011 引擎线）。

POST /api/report/{sku}/ask：检索章级 2-gram 打分 → 命中走智谱免费链（策略提示词），
未命中固定 no_answer 话术（不调 LLM）。v0.9.23 统一额度池：咨询+问报告共享
FREE_PER_DAY=6/日（先免费后赠次）；解锁该报告后无限问（left=999）。
GET /api/report/asks/history：本人提问记录倒序（title 由目录回填）。

测试法=形态断言（answer-policy.md：LLM 非确定性下只断言形态不比对全文）：
mock zhipu.deep_answer 返回固定多行文本，断言 conclusion/points/hint/left 形态。
运行：python -m pytest tests/test_report_ask.py -q
"""
from __future__ import annotations

import json
import sqlite3
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from qianwen_engine import config, report_catalog, wechat  # noqa: E402

ENGINE = Path(__file__).resolve().parents[1]

# mock 固定回答（REQ-001.AC1 形态断言素材：首行结论 + 两条「第N章：」论据）
FAKE_REPLY = "结论行\n第1章：论据一\n第2章：论据二"


def _mk_content(cdir: Path) -> None:
    """迷你目录：SKU-A 6 章互异主题（2-gram 检索的可辨语料）+ 试读摘要伪章素材。"""
    (cdir / "full").mkdir(parents=True)
    (cdir / "sample").mkdir(parents=True)
    chapters = [
        (1, "合同体系", "合同类型与条款要点"),
        (2, "计价规则", "计价方式与调价机制"),
        (3, "风险管理", "风险分担与应对措施"),
        (4, "结算流程", "进度结算与付款节点"),
        (5, "变更签证", "变更签证的办理流程"),
        (6, "索赔实务", "索赔证据与时效管理"),
    ]
    r = {"reports": [{
        "sku": "SKU-A", "title": "甲报告对话官测试", "subtitle": "副题",
        "price": 498, "price_label": "¥498", "words_wan": 5,
        "badges": [], "cat": "ent", "cat_name": "企业研究",
        "intro_lede": "导语", "intro": "简介", "audience": "从业者",
        "chapters": [{"id": i, "title": f"第{i}章 {kw}", "desc": desc}
                     for i, kw, desc in chapters],
        "sample_file": "sku-a.md", "sample_label": "试读",
    }]}
    (cdir / "report.json").write_text(json.dumps(r, ensure_ascii=False), encoding="utf-8")
    (cdir / "full" / "SKU-A.pdf").write_bytes(b"%PDF-1.4 " + b"a" * 40)
    (cdir / "sample" / "sku-a.md").write_text(
        "# 试读\n本报告围绕合同计价与变更签证展开。", encoding="utf-8")


@pytest.fixture()
def client(tmp_path, monkeypatch):
    from fastapi.testclient import TestClient
    from qianwen_engine import app as app_mod, store

    monkeypatch.setattr(config, "DB_PATH", tmp_path / "t.sqlite")
    monkeypatch.setattr(config, "DATA_DIR", tmp_path)
    _mk_content(tmp_path / "content")
    monkeypatch.setattr(config, "REPORT_CONTENT_DIR", tmp_path / "content")
    report_catalog._CACHE.update({"mtime": 0.0, "reports": [], "by_sku": {}})
    store._init_done = False
    monkeypatch.setattr(wechat, "code2session",
                        lambda code: {"openid": f"open-{code}", "unionid": ""})
    app_mod._RQA_RATE.clear()                                   # v0.9.23：限速字典隔离（防串测）
    with TestClient(app_mod.app) as c:
        c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-t1")})
        yield c
    store._init_done = False


def _mock_zhipu(monkeypatch, text: str = FAKE_REPLY):
    """mock 智谱免费链（记录调用数——限频/未命中分支必须零调用）。"""
    from qianwen_engine import zhipu
    calls = {"n": 0}
    def fake(system, prompt, **k):
        calls["n"] += 1
        return text
    monkeypatch.setattr(zhipu, "deep_answer", fake)
    return calls


def _ask(client, q: str, sku: str = "SKU-A"):
    return client.post(f"/api/report/{sku}/ask", json={"q": q})


# ── REQ-001.AC1 形态断言：conclusion/points/hint/left ──
def test_req_001_ac1_answer_shape(client, monkeypatch):
    calls = _mock_zhipu(monkeypatch)
    r1 = _ask(client, "变更签证怎么办理")
    assert r1.status_code == 200 and calls["n"] == 1
    d1 = r1.json()
    assert d1["conclusion"] == "结论行"                       # 首行=结论
    assert isinstance(d1["points"], list) and len(d1["points"]) == 2
    for p, want_ch in zip(d1["points"], (1, 2)):
        assert isinstance(p["ch"], int) and p["ch"] == want_ch
        assert p["text"] == "论据一" or p["text"] == "论据二"   # 1018 完美化：余文（角标/正文不重复）
    assert "第" in d1["hint"] and "章" in d1["hint"]
    assert d1["left"] == 5                                     # v0.9.23 统一池 6-1=5，递减
    d2 = _ask(client, "变更签证的流程是什么").json()
    assert d2["left"] == 4


# ── REQ-001.AC2 检索未命中 → 固定 no_answer 话术，不调 LLM 不编造 ──
def test_req_001_ac2_no_answer_without_llm(client, monkeypatch):
    calls = _mock_zhipu(monkeypatch)
    r = _ask(client, "量子纠缠是什么原理")
    assert r.status_code == 200 and calls["n"] == 0            # 零 LLM 调用
    d = r.json()
    assert d["conclusion"] == "这个问题报告里没有直接答案"
    assert d["points"] == []
    assert d["hint"]                                            # 附最接近章节指引
    assert d["left"] == 5                                       # 未命中也计一次（防探测刷）


# ── REQ-001.AC3 有论据 → hint 固定转化条话术 ──
def test_req_001_ac3_hint_conversion_wording(client, monkeypatch):
    _mock_zhipu(monkeypatch)
    d = _ask(client, "变更签证怎么办理").json()
    assert d["points"]                                          # 前提：有论据
    assert d["hint"] == "完整拆解在报告第5章"                   # 检索最优章=第5章


# ── REQ-001.AC4 v0.9.23 多段结论累积（千字回答分自然段不再腰斩）──
def test_req_001_ac4_multiparagraph_conclusion(client, monkeypatch):
    _mock_zhipu(monkeypatch, "第一段结论。\n第二段论证展开。\n第三段给出判断。\n第5章：要点一")
    d = _ask(client, "变更签证怎么办理").json()
    assert d["conclusion"] == "第一段结论。\n第二段论证展开。\n第三段给出判断。"   # 三段全保留（join \n）
    assert len(d["points"]) == 1


# ── REQ-001.AC5 v0.9.23 结论尾转场行剥离（「关键论据要点：」不混入结论）──
def test_req_001_ac5_transition_line_stripped(client, monkeypatch):
    _mock_zhipu(monkeypatch, "结论正文。\n关键论据要点：\n第5章：要点一")
    d = _ask(client, "变更签证怎么办理").json()
    assert d["conclusion"] == "结论正文。"                       # 转场行被剥
    assert len(d["points"]) == 1


# ── REQ-002.AC2 v0.9.23 并发双查兜底：consume_one 返回 False → 429（不调 LLM）──
def test_req_002_ac2_consume_false_race_guard(client, monkeypatch):
    from qianwen_engine import app as app_mod, store
    calls = _mock_zhipu(monkeypatch)
    monkeypatch.setattr(store, "consume_one", lambda openid: False)   # 模拟池被并发问掏空
    r = _ask(client, "变更签证怎么办理")
    assert r.status_code == 429
    assert r.json()["left"] == 0
    assert calls["n"] == 0                                       # 兜底腿零 LLM 消耗


# ── REQ-002.AC1 v0.9.23 统一池：第 7 问 429（不调 LLM）+ 跨日重置 ──
def test_req_002_ac1_daily_limit_and_rollover(client, monkeypatch):
    from qianwen_engine import store
    calls = _mock_zhipu(monkeypatch)
    for i in range(config.FREE_PER_DAY):                       # 6 问全部放行
        r = _ask(client, f"变更签证怎么办理{i}")
        assert r.status_code == 200 and r.json()["left"] == config.FREE_PER_DAY - 1 - i
    r7 = _ask(client, "变更签证怎么办理再问")
    assert r7.status_code == 429
    assert r7.json()["detail"] == "今日6问已用完，明日再来；解锁本报告即可无限问"
    assert r7.json()["left"] == 0
    assert calls["n"] == config.FREE_PER_DAY                   # 限频腿零 LLM 调用
    # 跨日重置：统一池 day 键换日 → 计数清零（北京时间 0 点口径同全站）
    monkeypatch.setattr(store, "_today", lambda: "2099-01-01")
    r5 = _ask(client, "变更签证怎么办")
    assert r5.status_code == 200 and r5.json()["left"] == config.FREE_PER_DAY - 1
    assert calls["n"] == config.FREE_PER_DAY + 1


# ── REQ-003.AC1 双方言表幂等自举 + mysql_schema.sql 同步锚 ──
def test_req_003_ac1_tables_idempotent_and_schema_sync(client):
    from qianwen_engine import store
    store._init_done = False
    store.init()                                                # 已有库上重复自举
    store._init_done = False
    store.init()
    conn = sqlite3.connect(config.DB_PATH)
    names = {r[0] for r in conn.execute(
        "SELECT name FROM sqlite_master WHERE type='table'")}
    conn.close()
    assert {"report_asks", "report_ask_log"} <= names
    sql = (ENGINE / "scripts" / "mysql_schema.sql").read_text(encoding="utf-8")
    assert "report_asks" in sql and "report_ask_log" in sql     # 部署镜像同步
    assert "report_unlocks" in sql                              # v0.9.23：解锁表镜像（审查补）


# ── REQ-004.AC1 LLM 失败静默降级 503（统一池下退款，不扣次数）；成功落历史行 ──
def test_req_004_ac1_llm_fail_503_and_success_logged(client, monkeypatch):
    from qianwen_engine import zhipu
    def boom(*a, **k):
        raise RuntimeError("GLM 全失败")
    monkeypatch.setattr(zhipu, "deep_answer", boom)
    r = _ask(client, "变更签证怎么办理")
    assert r.status_code == 503
    assert r.json()["detail"] == "问答稍后再试"
    # 503 退款不消耗统一池次数、不落历史
    calls = _mock_zhipu(monkeypatch)
    d = _ask(client, "变更签证怎么办理").json()
    assert d["left"] == config.FREE_PER_DAY - 1 and calls["n"] == 1
    h = client.get("/api/report/asks/history").json()["items"]
    assert len(h) == 1 and h[0]["conclusion"] == "结论行"       # 成功才有历史行


# ── REQ-005.AC1 策略常量可配置：FREE_PER_DAY 调整即行为变化 ──
def test_req_005_ac1_daily_limit_env_override(client, monkeypatch):
    monkeypatch.setattr(config, "FREE_PER_DAY", 1)
    calls = _mock_zhipu(monkeypatch)
    r1 = _ask(client, "变更签证怎么办理")
    assert r1.status_code == 200 and r1.json()["left"] == 0
    r2 = _ask(client, "变更签证又怎么办")
    assert r2.status_code == 429 and r2.json()["left"] == 0
    assert "今日1问已用完" in r2.json()["detail"]
    assert calls["n"] == 1


# ── REQ-006.AC1 v0.9.23 解锁后该报告无限问（left=999，越过免费池）──
def test_req_006_ac1_unlocked_sku_unlimited(client, monkeypatch):
    from qianwen_engine import store
    calls = _mock_zhipu(monkeypatch)
    store.init()                                                # 建齐 report_unlocks 等表
    conn = sqlite3.connect(config.DB_PATH)
    conn.execute("INSERT INTO report_unlocks(openid, sku) VALUES('open-t1','SKU-A')")
    conn.commit()
    conn.close()
    for i in range(config.FREE_PER_DAY + 2):                    # 越过 6/日上限仍放行
        r = _ask(client, f"变更签证怎么办理{i}")
        assert r.status_code == 200 and r.json()["left"] == 999
    assert calls["n"] == config.FREE_PER_DAY + 2


# ── REQ-011.AC1 提问历史：本人可见（含 title 回填）、他人不可见、未登录 401 ──
def test_req_011_ac1_history_owner_visibility(client, monkeypatch):
    _mock_zhipu(monkeypatch)
    assert _ask(client, "变更签证怎么办理").status_code == 200
    items = client.get("/api/report/asks/history").json()["items"]
    assert len(items) == 1
    it = items[0]
    assert it["sku"] == "SKU-A" and it["q"] == "变更签证怎么办理"
    assert it["conclusion"] == "结论行"
    assert it["title"] == "甲报告对话官测试"                     # 目录联查回填
    assert it["created_at"]
    # 他人不可见
    other = {"Authorization": "Bearer " + wechat.issue_token("open-t2")}
    assert client.get("/api/report/asks/history",
                      headers=other).json()["items"] == []
    # 未登录 401（全站同律）
    noauth = {"Authorization": ""}
    assert client.get("/api/report/asks/history",
                      headers=noauth).status_code == 401


# ── 边界：未知 sku 404；问题长度 2..200 之外 400 ──
def test_ask_404_unknown_sku(client, monkeypatch):
    _mock_zhipu(monkeypatch)
    assert _ask(client, "变更签证怎么办理", sku="NOPE").status_code == 404


def test_ask_400_short_q(client, monkeypatch):
    calls = _mock_zhipu(monkeypatch)
    assert _ask(client, "问").status_code == 400                # <2 字
    assert _ask(client, "字" * 201).status_code == 400          # >200 字
    assert calls["n"] == 0

# ── 1018 完美化三用例（markdown 剥离 / ch0 试读标签 / 无重复前缀）──
def test_perfect_markdown_stripped(client, monkeypatch):
    """LLM 带星号加粗 → 解析后零 markdown 记号（气泡直显观感缺陷根除）。"""
    _mock_zhipu(monkeypatch, text="**加粗结论**\n第1章：**星号论据**`代码`")
    d = _ask(client, "变更签证怎么办理").json()
    assert d["conclusion"] == "加粗结论"
    assert "*" not in d["points"][0]["text"] and "`" not in d["points"][0]["text"]
    assert d["points"][0]["text"].startswith("星号论据")


def test_perfect_ch0_labeled_digest(client, monkeypatch):
    """ch=0 试读伪章：LLM 输出「试读摘要：」→ ch=0；hint 用 FULL0 话术（第0章观感根除）。"""
    _mock_zhipu(monkeypatch, text="摘要结论\n试读摘要：摘要论据行")
    d = _ask(client, "合同计价与变更签证的关系").json()
    assert d["points"][0]["ch"] == 0
    assert d["hint"] == "完整拆解在报告正文"


def test_perfect_no_prefix_duplication(client, monkeypatch):
    """points.text 不再携带「第N章：」前缀（wxml 角标已渲染章号，重复显示根除）。"""
    _mock_zhipu(monkeypatch)
    d = _ask(client, "变更签证怎么办理").json()
    for p in d["points"]:
        assert not p["text"].startswith("第")



# ── 1021 根修回归锚：catalog 文件序=最新优先（新在头，禁止反转）──
def test_catalog_order_new_first(client):
    from qianwen_engine import report_catalog
    cat = report_catalog.catalog()
    assert cat, "catalog 非空"
    first = cat[0]["sku"]
    raw = report_catalog._load()
    assert first == raw[0].get("sku"), (
        "catalog() 必须保持 report.json 文件序（新在头约定）；"
        "若此断言挂了=有人又加了反转")
