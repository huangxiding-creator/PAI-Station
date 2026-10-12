# -*- coding: utf-8 -*-
"""v0.9.15 报告互动三件（用户令 1011：有用/分享给同行 赠次 + 研报转化海报）。

覆盖：
- 有用：首次赠 1 次（bonus_left=1）→ 重复 400 已点过；未知 sku 404
- 分享：首次静默赠 1 次 → 重复幂等 granted=False 不报错（运营 3.2.1：零诱导文案）；
  未知 sku 404
- 两动作独立记账：同一报告 useful + share 各 +1（rewards UNIQUE(openid,aid,action)，
  aid=report:<sku>）
- 海报：未知 sku 404；首次生成 PNG（b64 可解码、PNG 魔数）；缓存命中（二次调用
  零重绘零重出码）；小程序码 scene="s=r&i={sku}" 指向 pages/ask/ask；
  出码失败仍 200（无码兜底）
- 版式铁律（用户令）：全图文字零价格（¥/价格缺席）、「免费试读」在图且显眼
运行：python -m pytest tests/test_report_social.py -q
"""
from __future__ import annotations

import base64
import io
import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from qianwen_engine import config, poster, report_catalog, wechat  # noqa: E402


def _mk_content(cdir: Path) -> None:
    """迷你目录：A（可售，含价格/徽标/5 章——海报版式的全部素材位）；
    B（14 章——v0.9.16 一级目录 ≤12 章上限的裁切位）。"""
    (cdir / "full").mkdir(parents=True)
    (cdir / "sample").mkdir(parents=True)
    r = {
        "reports": [
            {
                "sku": "SKU-A", "title": "甲报告怎么干EPC", "subtitle": "副题拆解",
                "price": 498, "price_label": "¥498", "words_wan": 5,
                "badges": [{"k": "全渠道", "v": "对标"}, {"k": "深度", "v": "14章"}],
                "cat": "ent", "cat_name": "企业研究",
                "intro_lede": "导语", "intro": "简介" * 10, "audience": "工程总承包从业者",
                "chapters": [{"id": i, "title": f"第{i}章 拆解{i}", "desc": "章述"}
                             for i in (1, 2, 3, 4, 5)],
                "sample_file": "sku-a.md", "sample_label": "试读",
            },
            {
                "sku": "SKU-B", "title": "乙报告十四章", "subtitle": "目录裁切位",
                "price": 598, "price_label": "¥598", "words_wan": 8,
                "badges": [], "cat": "ent", "cat_name": "企业研究",
                "intro_lede": "导语", "intro": "简介", "audience": "工程总承包从业者",
                "chapters": [{"id": i, "title": f"第{i}章 章题{i}", "desc": ""}
                             for i in range(1, 15)],
                "sample_file": "sku-b.md", "sample_label": "试读",
            },
        ]
    }
    (cdir / "report.json").write_text(json.dumps(r, ensure_ascii=False), encoding="utf-8")
    (cdir / "full" / "SKU-A.pdf").write_bytes(b"%PDF-1.4 " + b"a" * 40)
    (cdir / "sample" / "sku-a.md").write_text("# 试读\n正文", encoding="utf-8")
    (cdir / "sample" / "sku-b.md").write_text("# 试读\n正文", encoding="utf-8")


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
    with TestClient(app_mod.app) as c:
        c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-t1")})
        yield c
    store._init_done = False


def _fake_qr_png() -> bytes:
    """合法 1×1 PNG（build_report 内 Image.open 校验通过 → 走贴码分支）。"""
    from PIL import Image
    buf = io.BytesIO()
    Image.new("RGB", (430, 430), (0, 0, 0)).save(buf, format="PNG")
    return buf.getvalue()


# ── 有用 / 分享给同行：赠次与幂等 ──

def test_useful_grants_once_then_400(client):
    r = client.post("/api/report/SKU-A/useful")
    assert r.status_code == 200
    d = r.json()
    assert d["granted"] is True and d["quota"]["bonus_left"] == 1
    # 重复 → 400 已点过（每报告每人一次）
    r2 = client.post("/api/report/SKU-A/useful")
    assert r2.status_code == 400
    assert client.post("/api/report/NOPE/useful").status_code == 404


def test_share_silent_idempotent(client):
    r = client.post("/api/report/SKU-A/share")
    assert r.status_code == 200 and r.json()["granted"] is True
    assert r.json()["quota"]["bonus_left"] == 1
    # 重复分享：幂等不报错（静默落账语义，客户端零提示）
    r2 = client.post("/api/report/SKU-A/share")
    assert r2.status_code == 200 and r2.json()["granted"] is False
    assert r2.json()["quota"]["bonus_left"] == 1
    assert client.post("/api/report/NOPE/share").status_code == 404


def test_useful_and_share_independent_rewards(client):
    """同一报告两动作各 +1（rewards UNIQUE(openid,aid,action) 三元组去重）。"""
    from qianwen_engine import store
    assert client.post("/api/report/SKU-A/useful").json()["quota"]["bonus_left"] == 1
    assert client.post("/api/report/SKU-A/share").json()["quota"]["bonus_left"] == 2
    assert store.reward_exists("open-t1", "report:SKU-A", "report_useful")
    assert store.reward_exists("open-t1", "report:SKU-A", "report_share")
    # 第二份报告独立计数（每 sku 一记）
    assert client.post("/api/report/SKU-A/useful").status_code == 400  # 本报告仍限一次


# ── 研报转化海报 ──

def test_poster_404_and_png(client, monkeypatch):
    assert client.get("/api/report/NOPE/poster").status_code == 404
    calls = {"qr": []}
    monkeypatch.setattr(wechat, "wxacode_unlimited",
                        lambda scene, page, **k: (calls["qr"].append((scene, page)),
                                                  _fake_qr_png())[1])
    r = client.get("/api/report/SKU-A/poster")
    assert r.status_code == 200
    png = base64.b64decode(r.json()["b64"])
    assert png.startswith(b"\x89PNG")                # 真海报字节
    assert calls["qr"] == [("s=r&i=SKU-A", "pages/ask/ask")]   # 深链码契约


def test_poster_cached_second_call(client, monkeypatch):
    builds = {"n": 0}
    real_build = poster.build_report
    monkeypatch.setattr(poster, "build_report",
                        lambda *a, **k: (builds.__setitem__("n", builds["n"] + 1),
                                         real_build(*a, **k))[1])
    qr_calls = {"n": 0}
    monkeypatch.setattr(wechat, "wxacode_unlimited",
                        lambda *a, **k: (qr_calls.__setitem__("n", qr_calls["n"] + 1),
                                         _fake_qr_png())[1])
    b1 = client.get("/api/report/SKU-A/poster").json()["b64"]
    b2 = client.get("/api/report/SKU-A/poster").json()["b64"]
    assert b1 == b2                                 # 缓存恒同图
    assert builds["n"] == 1 and qr_calls["n"] == 1  # 二次调用零重绘零重出码


def test_poster_no_qr_fallback_still_200(client, monkeypatch):
    """出码失败（无码兜底：搜一搜引导）——海报零失败姿态。"""
    def boom(*a, **k):
        raise RuntimeError("test: wxacode down")
    monkeypatch.setattr(wechat, "wxacode_unlimited", boom)
    r = client.get("/api/report/SKU-A/poster")
    assert r.status_code == 200
    assert base64.b64decode(r.json()["b64"]).startswith(b"\x89PNG")


def _texts_of_build(d: dict) -> tuple:
    """驱动 build_report 并录制全部 draw.text 字串（版式断言的取证腿）。"""
    from PIL import ImageDraw as _draw_mod

    texts: list = []
    real_draw = _draw_mod.Draw

    class Rec:
        def __init__(self, im, *a, **k):
            self._d = real_draw(im, *a, **k)

        def __getattr__(self, name):
            return getattr(self._d, name)

        def text(self, xy, s, *a, **k):
            texts.append(str(s))
            return self._d.text(xy, s, *a, **k)

    _draw_mod.Draw = Rec
    try:
        png = poster.build_report(d, qr_png=_fake_qr_png(), catalog_count=9)
    finally:
        _draw_mod.Draw = real_draw
    return png, texts


def test_build_report_layout_doctrine(client):
    """版式铁律（用户令）：①零价格（¥/price_label 全域缺席）②「免费试读」显眼且
    **全域仅一次**（1012 用户令去重）③一级目录完整呈现（≤12 章全展示）。
    直接驱动 build_report + 录制全部 draw.text 字串断言。"""
    from qianwen_engine import report_catalog as rc

    png, texts = _texts_of_build(rc.get_report("SKU-A"))
    assert png.startswith(b"\x89PNG")
    joined = "|".join(texts)
    # ① 零价格：货币符与价格数值/标签缺席（498 只可能来自 price）
    assert "¥" not in joined and "498" not in joined
    # ② 试读显眼且仅一次：橙药丸（fb34 白字）+副行在图，数据行第三组已删（去重）
    assert "免费试读" in texts                       # 橙药丸（fb34 白字）
    assert "试读章节免费开放" in texts and "进入小程序即可阅读" in texts
    assert joined.count("免费试读") == 1 and "支持" not in texts
    # ③ 一级目录完整：SKU-A 5 章 ≤12 → 全部在图且无省略注记
    for i in (1, 2, 3, 4, 5):
        assert f"拆解{i}" in joined
    assert "完整目录在小程序内" not in joined
    # 品牌与行动卡在图（转化三件：品牌/试读/扫码）
    assert "总包AI顾问" in texts and "扫码读报告试读" in texts
    assert "研究报告库 · 9 份深度报告" in texts       # catalog_count 注入
    # 章去冠词：台账序号 01/02 自绘，「第1章」前缀不重复占行宽
    assert not any(t.startswith("第") for t in texts)


def test_build_report_toc_cap_12(client):
    """一级目录 ≤12 章上限（1012 用户令：最多前 12 章）：SKU-B 14 章 →
    前 12 章在图、13/14 章缺席、注记「共 14 章·完整目录在小程序内」补位。"""
    from qianwen_engine import report_catalog as rc

    _, texts = _texts_of_build(rc.get_report("SKU-B"))
    joined = "|".join(texts)
    for i in range(1, 13):
        assert f"章题{i}" in joined, f"第{i}章应在前 12 章呈现"
    assert "章题13" not in joined and "章题14" not in joined
    assert "共 14 章" in joined and "完整目录在小程序内" in joined
