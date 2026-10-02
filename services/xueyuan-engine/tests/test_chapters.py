# -*- coding: utf-8 -*-
"""章节权益裁剪契约单测（T-P0-07）：空壳字段缺席/试读免登录/已购全量/限流。"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT  # noqa: E402

from xueyuan_engine import virtual_pay  # noqa: E402


def test_trial_chapters_free_without_login(engine, client):
    r = client.get(f"/api/v1/reports/{PILOT}/chapters")
    assert r.status_code == 200
    body = r.json()
    assert body["trial_chapters"] == 2
    trial = [ch for ch in body["chapters"] if ch["is_trial"] == 1]
    paid = [ch for ch in body["chapters"] if ch["is_trial"] == 0]
    assert len(trial) == 2 and all(ch["html"].startswith("<h1>") for ch in trial)
    for ch in paid:  # 未购付费章：html 字段缺席（非空串）+元数据在
        assert "html" not in ch
        assert ch["html_len"] > 0 and "title" in ch and "idx" in ch


def test_with_content_all_still_trimmed_without_entitlement(engine, client, buyer):
    """with_content=all 仅表示请求付费正文——权益判定在服务端，未购仍裁剪。"""
    r = client.get(f"/api/v1/reports/{PILOT}/chapters",
                   params={"with_content": "all"}, headers=buyer)
    assert r.status_code == 200
    paid = [ch for ch in r.json()["chapters"] if ch["is_trial"] == 0]
    assert paid and all("html" not in ch for ch in paid)


def test_entitled_gets_full_html(engine, client, buyer):
    virtual_pay.grant_entitlement(buyer["uid"], PILOT, "purchase", "fake_order_1")
    r = client.get(f"/api/v1/reports/{PILOT}/chapters",
                   params={"with_content": "all"}, headers=buyer)
    paid = [ch for ch in r.json()["chapters"] if ch["is_trial"] == 0]
    assert paid and all(ch["html"].startswith("<h1>") for ch in paid)  # 全量正文


def test_read_log_written_when_logged_in(engine, client, buyer):
    from xueyuan_engine import store

    client.get(f"/api/v1/reports/{PILOT}/chapters", headers=buyer)
    with store._db() as c:
        n = c.execute("SELECT COUNT(*) n FROM read_log WHERE user_id=?",
                      (buyer["uid"],)).fetchone()["n"]
    assert n >= 1
    guest_client_r = client.get(f"/api/v1/reports/{PILOT}/chapters")  # 游客不落
    assert guest_client_r.status_code == 200


def test_invalid_with_content_and_404(engine, client):
    assert client.get(f"/api/v1/reports/{PILOT}/chapters",
                      params={"with_content": "everything"}).status_code == 400
    assert client.get("/api/v1/reports/no-such/chapters").status_code == 404


def test_paid_fetch_rate_limited(engine, client, buyer, monkeypatch):
    from xueyuan_engine import config

    monkeypatch.setattr(config, "RATE_LIMIT_PER_MIN", 3)
    codes = [
        client.get(f"/api/v1/reports/{PILOT}/chapters",
                   params={"with_content": "all"}, headers=buyer).status_code
        for _ in range(5)
    ]
    assert codes[:3] == [200, 200, 200] and codes[3] == 429 and codes[4] == 429
    body = client.get(f"/api/v1/reports/{PILOT}/chapters",
                      params={"with_content": "all"}, headers=buyer).json()
    assert body["code"] == "RATE_LIMITED"
    trial_only = client.get(f"/api/v1/reports/{PILOT}/chapters", headers=buyer)
    assert trial_only.status_code == 200        # 试读态不受付费章限流牵连


def test_bad_bearer_401(engine, client):
    r = client.get(f"/api/v1/reports/{PILOT}/chapters",
                   headers={"Authorization": "Bearer forged.token.x"})
    assert r.status_code == 401 and r.json()["code"] == "UNAUTHORIZED"


# ── P0-6 POST /reports/{id}/chapters/{cid}（防泄漏主闸+限流主落点）──────
def _paid_cid(client, rid=PILOT):
    chs = client.get(f"/api/v1/reports/{rid}/chapters").json()["chapters"]
    return next(c["id"] for c in chs if c["is_trial"] == 0)


def test_single_chapter_unentitled_html_absent(engine, client, buyer):
    """未购拉付费单章：403 NOT_ENTITLED 且响应体不含 html 字段（主闸判据）。"""
    cid = _paid_cid(client)
    r = client.post(f"/api/v1/reports/{PILOT}/chapters/{cid}", headers=buyer)
    assert r.status_code == 403 and r.json()["code"] == "NOT_ENTITLED"
    assert "html" not in r.json()
    anon = client.post(f"/api/v1/reports/{PILOT}/chapters/{cid}")
    assert anon.status_code == 401 and "html" not in anon.json()


def test_single_chapter_entitled_full_and_trial_free(engine, client, buyer):
    """已购拉付费单章：200 全量正文+契约字段齐；试读章免登录同端点可取。"""
    virtual_pay.grant_entitlement(buyer["uid"], PILOT, "purchase", "fake_order_2")
    cid = _paid_cid(client)
    r = client.post(f"/api/v1/reports/{PILOT}/chapters/{cid}", headers=buyer)
    assert r.status_code == 200
    body = r.json()
    assert body["chapter_id"] == cid and body["is_trial"] == 0
    assert body["html"].startswith("<h1>") and body["pages"] >= 1  # 全量+超集字段
    trial = client.post(f"/api/v1/reports/{PILOT}/chapters/ch01")  # 试读免登录
    assert trial.status_code == 200 and trial.json()["is_trial"] == 1
    assert trial.json()["html"].startswith("<h1>")


def test_single_chapter_404_shape_and_rate_limit(engine, client, buyer, monkeypatch):
    """不存在 cid/报告 404 形状；付费单章拉取计入限流计数（主落点）。"""
    from xueyuan_engine import config, store

    virtual_pay.grant_entitlement(buyer["uid"], PILOT, "purchase", "fake_order_3")
    ghost = client.post(f"/api/v1/reports/{PILOT}/chapters/ghost", headers=buyer)
    assert ghost.status_code == 404 and ghost.json()["code"] == "CHAPTER_NOT_FOUND"
    assert client.post(f"/api/v1/reports/no-such/chapters/ch01").status_code == 404
    cid = _paid_cid(client)
    with store._db() as c:  # read_log 落库（本章 slug）
        before = c.execute("SELECT COUNT(*) n FROM read_log WHERE user_id=? AND chapter_id=?",
                           (buyer["uid"], f"{PILOT}/{cid}")).fetchone()["n"]
    monkeypatch.setattr(config, "RATE_LIMIT_PER_MIN", 3)
    codes = [client.post(f"/api/v1/reports/{PILOT}/chapters/{cid}",
                         headers=buyer).status_code for _ in range(5)]
    assert codes[:3] == [200, 200, 200] and codes[3] == 429
    with store._db() as c:
        after = c.execute("SELECT COUNT(*) n FROM read_log WHERE user_id=? AND chapter_id=?",
                          (buyer["uid"], f"{PILOT}/{cid}")).fetchone()["n"]
    assert after == before + 3  # 429 不计阅读；每次成功拉取一条
