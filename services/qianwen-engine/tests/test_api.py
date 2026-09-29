# -*- coding: utf-8 -*-
"""API 单测——TestClient + mock 引擎/微信（v0.5.0：赠次四动作/优化/批量导出/锅圈）。"""
from __future__ import annotations

import sys
import time
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from qianwen_engine import config, metaso_kb, wechat, zhipu  # noqa: E402


def _kb_answer(q):
    return metaso_kb.KbAnswer(
        question=q, answer="结论[[书†1]]" + "详" * 300,
        cid="123456789012345678",
        url="https://metaso.cn/x", citations=[],
        elapsed_sec=14.0)


@pytest.fixture()
def client(tmp_path, monkeypatch):
    from fastapi.testclient import TestClient
    from qianwen_engine import app as app_mod, store

    monkeypatch.setattr(config, "DB_PATH", tmp_path / "t.sqlite")
    monkeypatch.setattr(config, "DATA_DIR", tmp_path)
    store._init_done = False

    monkeypatch.setattr(wechat, "code2session",
                        lambda code: {"openid": f"open-{code}", "unionid": ""})
    monkeypatch.setattr(metaso_kb, "ask", lambda q, model="fast", sleep=None, on_event=None: _kb_answer(q))
    # 护栏不干扰
    monkeypatch.setattr(metaso_kb, "_guard_enter", lambda cost=3: None)
    monkeypatch.setattr(metaso_kb, "_record", lambda ok: None)
    # v0.5.1 智谱免费链：默认走"未配置"分支（KB 回落已被 mock，全离线），
    # 真实 zhipu.secret 存在也不许测试进程碰网络。
    monkeypatch.setattr(zhipu, "configured", lambda: False)
    monkeypatch.setattr(zhipu, "rewrite", lambda prompt: (_ for _ in ()).throw(
        RuntimeError("测试默认禁用 zhipu")))

    with TestClient(app_mod.app) as c:
        c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-t1")})
        yield c
    store._init_done = False


def _wait_ready(client, aid, tries=100):
    d = {}
    for _ in range(tries):
        d = client.get(f"/api/answer/{aid}").json()
        if d.get("status") != "pending":
            return d
        time.sleep(0.05)
    return d


def test_health(client):
    assert client.get("/api/health").json()["ok"] is True


def test_login(client):
    r = client.post("/api/login", json={"code": "c1"})
    assert r.status_code == 200 and "token" in r.json()


def test_ask_and_answer(client):
    r = client.post("/api/ask", json={"question": "旋挖硬岩怎么办"})
    assert r.status_code == 200
    assert r.json()["quota"]["total_left"] == 5
    d = _wait_ready(client, r.json()["id"])
    assert d["answer"].startswith("结论")
    # 次数用尽 → 402（免费 6 次问完，第 7 次拒绝）
    for _ in range(5):
        assert client.post("/api/ask", json={"question": "继续问"}).status_code == 200
    r2 = client.post("/api/ask", json={"question": "第七问"})
    assert r2.status_code == 402
    assert "有用" in r2.json()["detail"]      # 新 402 文案引导四动作


def test_like_grants_bonus(client):
    aid = client.post("/api/ask", json={"question": "问"}).json()["id"]
    r = client.post(f"/api/answer/{aid}/like")
    assert r.status_code == 200 and r.json()["granted"] is True
    assert r.json()["quota"]["bonus_left"] == 1
    r2 = client.post(f"/api/answer/{aid}/like")
    assert r2.status_code == 400


def test_share_and_export_reward(client):
    aid = client.post("/api/ask", json={"question": "问"}).json()["id"]
    _wait_ready(client, aid)
    r = client.post(f"/api/answer/{aid}/share")
    assert r.status_code == 200 and r.json()["granted"] is True
    r2 = client.post(f"/api/answer/{aid}/share")
    assert r2.status_code == 200 and r2.json()["granted"] is False   # 每答案一次
    e = client.post(f"/api/answer/{aid}/export", json={"fmt": "docx"})
    assert e.status_code == 200 and e.json()["filename"].endswith(".docx")
    assert client.get("/api/quota").json()["quota"]["bonus_left"] == 2


def test_criticism_with_text_rewards(client):
    aid = client.post("/api/ask", json={"question": "问"}).json()["id"]
    _wait_ready(client, aid)
    empty = client.post(f"/api/answer/{aid}/criticize", json={"text": "  "})
    assert empty.status_code == 400                      # 必须有具体意见
    r = client.post(f"/api/answer/{aid}/criticize", json={"text": "依据引用错了"})
    assert r.status_code == 200 and r.json()["granted"] is True
    r2 = client.post(f"/api/answer/{aid}/criticize", json={"text": "再批"})
    assert r2.status_code == 400


def test_answer_requires_owner(client):
    aid = client.post("/api/ask", json={"question": "问"}).json()["id"]
    ok = client.get(f"/api/answer/{aid}")
    assert ok.status_code == 200
    # 换人 token
    from qianwen_engine import wechat as w
    client.headers.update({"Authorization": "Bearer " + w.issue_token("open-other")})
    assert client.get(f"/api/answer/{aid}").status_code == 404
    client.headers.update({"Authorization": "Bearer " + w.issue_token("open-t1")})


def test_history(client):
    client.post("/api/ask", json={"question": "历史问题"})
    items = client.get("/api/history").json()["items"]
    assert len(items) == 1 and items[0]["question"] == "历史问题"


def test_question_optimize(client):
    r = client.post("/api/question/optimize", json={"question": "EPC 调价怎么弄"})
    assert r.status_code == 200 and len(r.json()["optimized"]) > 10
    assert r.json()["left"] == config.OPTIMIZE_DAILY_CAP - 1
    short = client.post("/api/question/optimize", json={"question": "问"})  # <2 字
    assert short.status_code == 400
    # 每日上限 → 429
    for _ in range(config.OPTIMIZE_DAILY_CAP - 1):
        assert client.post("/api/question/optimize", json={"question": "继续优化这个问题"}).status_code == 200
    cap = client.post("/api/question/optimize", json={"question": "超限的优化请求"})
    assert cap.status_code == 429


def test_question_optimize_zhipu(client, monkeypatch):
    """v0.5.1 智谱主链：成功 / 全链失败 502+退次 / 空结果 502+退次（全程 mock 不碰网）。"""
    monkeypatch.setattr(zhipu, "configured", lambda: True)
    monkeypatch.setattr(zhipu, "rewrite", lambda p: "一、定性结论如何？二、依据是哪条？三、操作步骤怎么走？")
    r = client.post("/api/question/optimize", json={"question": "EPC 调价怎么弄"})
    assert r.status_code == 200
    assert "递进" in r.json()["optimized"] or "一、" in r.json()["optimized"]
    assert r.json()["left"] == config.OPTIMIZE_DAILY_CAP - 1

    # 全链失败 → 502 且退次（下一次仍满额）
    def _boom(prompt):
        raise RuntimeError("智谱免费链全失败: GLM 429")
    monkeypatch.setattr(zhipu, "rewrite", _boom)
    r2 = client.post("/api/question/optimize", json={"question": "EPC 调价怎么弄"})
    assert r2.status_code == 502

    monkeypatch.setattr(zhipu, "rewrite", lambda p: "一、结论？二、依据？三、步骤？")
    r3 = client.post("/api/question/optimize", json={"question": "EPC 调价怎么弄"})
    assert r3.status_code == 200 and r3.json()["left"] == config.OPTIMIZE_DAILY_CAP - 2

    # 空结果（<10 字）→ 502 且退次
    monkeypatch.setattr(zhipu, "rewrite", lambda p: "太短")
    r4 = client.post("/api/question/optimize", json={"question": "EPC 调价怎么弄"})
    assert r4.status_code == 502
    monkeypatch.setattr(zhipu, "rewrite", lambda p: "一、结论？二、依据？三、步骤？")
    r5 = client.post("/api/question/optimize", json={"question": "EPC 调价怎么弄"})
    assert r5.status_code == 200 and r5.json()["left"] == config.OPTIMIZE_DAILY_CAP - 3


def test_export_all(client):
    for q in ("批量导出问题一", "批量导出问题二"):
        client.post("/api/ask", json={"question": q})
    empty = client.post("/api/answers/export_all", json={"fmt": "md"})
    assert empty.status_code in (200, 404)   # pending 未完成不计（竞态下可能 404）
    md = client.post("/api/answers/export_all", json={"fmt": "md"})
    if md.status_code == 200:
        assert "咨询档案" in md.json()["filename"] and md.json()["filename"].endswith(".md")
    docx = client.post("/api/answers/export_all", json={"fmt": "docx"})
    assert docx.status_code == 200 and docx.json()["filename"].endswith(".docx")
    bad = client.post("/api/answers/export_all", json={"fmt": "xls"})
    assert bad.status_code == 400


def test_pot_list_and_public_view(client):
    from qianwen_engine import store
    store.save_pot_answer("锅圈公开问题", "公开答案" * 100, [], sort=1)
    r = client.get("/api/pot/list")
    assert r.status_code == 200
    items = r.json()["items"]
    assert len(items) == 1 and items[0]["question"] == "锅圈公开问题"
    assert len(items[0]["preview"]) == 100          # 前 100 字预览
    # 详情页全员可见 + 互动赠次同样生效
    aid = items[0]["id"]
    d = client.get(f"/api/answer/{aid}")
    assert d.status_code == 200 and d.json()["is_pot"] is True
    assert d.json()["unlocked"] is True and len(d.json()["answer"]) > 100
    lk = client.post(f"/api/answer/{aid}/like")
    assert lk.status_code == 200 and lk.json()["granted"] is True
