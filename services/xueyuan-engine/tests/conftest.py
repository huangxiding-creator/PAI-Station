# -*- coding: utf-8 -*-
"""测试夹具——全套隔离（tmp DB/内容区/secrets/dev 双闸），密钥全用 fixture 假值。

试点数据形态按「≥1 且含试点」断言（A 线铺量后不翻红）；夹具内容区为独立
tmp 目录，不触真实 zongbao 产物（A 线只读红线）。
"""
from __future__ import annotations

import json
import sys
from pathlib import Path
from types import SimpleNamespace

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

PILOT = "js-shuiwang-2026"
SECOND = "gd-gangkou-2026"   # 筛选可区分报告（广东/交通/港口工程）
THIRD = "zj-hangyun-2026"    # 与试点同省同业主（三维关联推荐命中位）
FAKE_APPSECRET = "fixture-appsecret-0123456789"


def _chapters(prefix: str, n: int, trial_html_from: int = 3) -> list[dict]:
    """n 章：前 trial_html_from 章带正文，其后空壳（包内形态）。"""
    return [
        {
            "id": f"ch{i:02d}", "title": f"{prefix}第{i}章 标题{i}",
            "html": (f"<h1>{prefix}第{i}章</h1><p>" + "江苏水网正文内容。" * 20) if i <= trial_html_from else "",
        }
        for i in range(1, n + 1)
    ]


def _full_of(chaps: list[dict]) -> list[dict]:
    """全集形态：付费章补正文（引擎侧 chapters_full.json）。"""
    return [
        {**c, "html": c["html"] or (f"<h1>{c['title']}</h1><p>付费正文{c['id']}。" + "数据论证 " * 80)}
        for c in chaps
    ]


def _entry(rid: str, title: str, price: int, n_ch: int, **kw) -> dict:
    return {
        "id": rid, "title": title, "summary": f"{title}——总包创研院出品。",
        "price": price, "chapterCount": n_ch, "source": "总包创研院",
        "publishedAt": kw.pop("published_at", "2026-09-27"), **kw,
    }


def build_content(pkg: Path, full: Path) -> None:
    """夹具内容区：3 报告（试点含省份/行业结构化字段，价格原样=990 试点期值）。"""
    pilot_ch = _chapters("水网", 6)
    second_ch = _chapters("港口", 4)
    third_ch = _chapters("航运", 4)
    for rid, chaps in ((PILOT, pilot_ch), (SECOND, second_ch), (THIRD, third_ch)):
        d = pkg / "reports" / rid
        d.mkdir(parents=True)
        (d / "chapters.json").write_text(json.dumps(chaps, ensure_ascii=False), encoding="utf-8")
        f = full / "reports" / rid
        f.mkdir(parents=True)
        (f / "chapters_full.json").write_text(
            json.dumps(_full_of(chaps), ensure_ascii=False), encoding="utf-8")
    catalog = {"reports": [
        _entry(PILOT, "江苏省水网工程商机研究", 990, 6, province="江苏",
               ownerType="水利", industry="水网工程", tags=["水网", "江苏"]),
        _entry(SECOND, "广东港口航道商机研究", 49800, 4, province="广东",
               ownerType="交通", industry="港口工程", tags=["港口"],
               published_at="2026-09-26"),
        _entry(THIRD, "浙江航运枢纽商机研究", 49800, 4, province="江苏",
               ownerType="水利", industry="航运工程", tags=["航运"],
               published_at="2026-09-25"),
    ]}
    (pkg / "catalog.json").write_text(json.dumps(catalog, ensure_ascii=False), encoding="utf-8")


@pytest.fixture()
def engine(tmp_path, monkeypatch):
    """隔离环境：tmp DB/PDF/secrets/内容区 + dev 登录闸；启动即进库。"""
    from xueyuan_engine import chapters as chapters_mod
    from xueyuan_engine import config, store

    pkg, full = tmp_path / "content", tmp_path / "server_content"
    build_content(pkg, full)
    monkeypatch.setattr(config, "DATA_DIR", tmp_path)
    monkeypatch.setattr(config, "DB_PATH", tmp_path / "t.sqlite")
    monkeypatch.setattr(config, "PDF_DIR", tmp_path / "pdfs")
    monkeypatch.setattr(config, "POSTER_DIR", tmp_path / "posters")
    monkeypatch.setattr(config, "CONTENT_DIR", pkg)
    monkeypatch.setattr(config, "SERVER_CONTENT_DIR", full)
    monkeypatch.setattr(config, "VIRTUAL_PAY_FILE", tmp_path / "virtual_pay_xueyuan.secret")
    monkeypatch.setattr(config, "MP_SECRET_FILE", tmp_path / "xueyuan_mp.secret")
    monkeypatch.setattr(config, "ENGINE_TOKEN_FILE", tmp_path / "hmac.key")
    (tmp_path / "xueyuan_mp.secret").write_text(
        f"appid=wxfake\nappsecret={FAKE_APPSECRET}\n", encoding="utf-8")
    monkeypatch.setenv("XY_DEV_LOGIN", "1")
    chapters_mod._LIMITER._hits.clear()
    store._init_done = False
    store.sync_from_catalog(pkg, full)
    ns = SimpleNamespace(
        tmp=tmp_path, pkg=pkg, full=full, pilot=PILOT, second=SECOND, third=THIRD,
        pay_secret=tmp_path / "virtual_pay_xueyuan.secret",
        mp_secret=tmp_path / "xueyuan_mp.secret",
    )
    yield ns
    store._init_done = False
    chapters_mod._LIMITER._hits.clear()
    # join 泄漏的评分 daemon（criticize xy-score-*）：跨测试写已替换的 DB →
    # sqlite3.OperationalError 假归因到下一测试（E4 期两现 flake，2026-09-28 根治）
    import threading as _th
    for _t in _th.enumerate():
        if _t.name.startswith("xy-score-"):
            _t.join(timeout=5)


@pytest.fixture()
def client(engine):
    from fastapi.testclient import TestClient

    from xueyuan_engine.app import app

    with TestClient(app) as c:
        yield c


@pytest.fixture()
def buyer(client):
    """已登录买家头（dev openid→uid 短 ID）。"""
    r = client.post("/api/v1/auth/login", json={"code": "buyer"})
    assert r.status_code == 200
    d = r.json()
    return {"Authorization": f"Bearer {d['token']}", "uid": d["uid"], "token": d["token"]}


@pytest.fixture()
def pay_on(engine):
    """假支付配置（fixture 假值；真值由用户回传后主会话写入）。"""
    engine.pay_secret.write_text(
        "offer_id=test\nproduct_id=xy_report_unlock\nenv=1\n", encoding="utf-8")
    return engine.pay_secret
