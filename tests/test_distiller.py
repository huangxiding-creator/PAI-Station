"""M3.3 蒸馏器 PoC（提案 H1 核心自研）：初终稿 diff → 可复用偏好规则。"""
import json

from paistation.skills.distiller import Distiller

INITIAL = "本项目采用传统施工管理模式，通过人工巡检确保安全。"
FINAL = "本项目采用智能安全治理体系，通过传感器网络与 AI 预警实现韧性管控。"


class FakeClient:
    def __init__(self, payload=None, fail=False):
        self._payload = payload
        self._fail = fail
        self.prompts = []

    def fast(self, prompt, context="", json_mode=False):
        self.prompts.append({"prompt": prompt, "context": context, "json_mode": json_mode})
        if self._fail:
            raise RuntimeError("模型挂了")
        return {"text": json.dumps(self._payload, ensure_ascii=False), "usage": {},
                "confidence": 1.0}


class FakeStore:
    def __init__(self):
        self.upserts = []

    def upsert(self, **kw):
        self.upserts.append(kw)

    def search(self, query, limit=10):
        return []


def test_distill_extracts_preference_rule():
    client = FakeClient(payload={
        "preference": "用户偏好用'智能治理/韧性'话语体系替代'传统人工'表述",
        "evidence": "初稿'人工巡检'→终稿'传感器+AI预警'"})
    store = FakeStore()
    d = Distiller(client=client, store=store)
    r = d.distill(initial=INITIAL, final=FINAL, task="安全治理报告")
    assert "智能治理" in r["rule"]
    assert r["saved"] is True
    assert store.upserts and store.upserts[0]["title"].startswith("偏好规则")
    # 初终稿必须都进入上下文（diff 依据）
    assert "人工巡检" in client.prompts[0]["context"]
    assert "AI 预警" in client.prompts[0]["context"]


def test_distill_fallback_rule_on_failure():
    d = Distiller(client=FakeClient(fail=True), store=FakeStore())
    r = d.distill(initial=INITIAL, final=FINAL)
    assert r["saved"] is True
    assert "diff" in r["rule"].lower() or "改写" in r["rule"]  # 降级规则仍可复用
    assert len(r["diff"]["changed_terms"]) >= 1  # 词级变化被捕获


def test_distill_identical_texts_no_rule():
    d = Distiller(client=FakeClient(payload={"preference": "x", "evidence": "y"}),
                  store=FakeStore())
    r = d.distill(initial="完全相同", final="完全相同")
    assert r["saved"] is False        # 无差异不产出规则


def test_distill_diff_stats():
    d = Distiller(client=FakeClient(fail=True), store=FakeStore())
    r = d.distill(initial="甲乙丙丁", final="甲乙戊丁")
    assert r["diff"]["same_ratio"] == 0.75   # 4 字换 1 字
