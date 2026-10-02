# -*- coding: utf-8 -*-
"""商机情报卡域单测（w3a-2-E）：三契约端点/归一化富化/两态分页/404/H5 转义/
卡海报冒烟+QR 缓存/scene 纯解析。零网络零真微信（QR 字节 monkeypatch 假图）。"""
from __future__ import annotations

import json
import sys
from io import BytesIO
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

import pytest  # noqa: E402
from PIL import Image, ImageDraw  # noqa: E402

from tests.conftest import PILOT, SECOND  # noqa: E402

from xueyuan_engine import catalog, config, poster, store, virtual_pay  # noqa: E402
from xueyuan_engine import cards as cards_mod  # noqa: E402


def _card(rid: str, n: int, **kw) -> dict:
    base = {"id": f"{rid}-c{n:03d}", "title": f"测试商机{n}", "amount": "",
            "amount_raw": "", "owner": "", "stage": "", "window": "",
            "province": "江苏", "source_chapter": "ch01", "summary": f"摘要{n}"}
    return {**base, **kw}


def _pilot_cards() -> list[dict]:
    return [
        _card(PILOT, 1, title="5G机房建设", amount="1,200 万元", amount_raw="1200万元",
              owner="市水利局", stage="-", window="2022年", source_chapter="ch01",
              summary="5G机房建设项目。"),
        _card(PILOT, 2, owner="交通局", window="2023年5月", source_chapter="ch02"),
        _card(PILOT, 3, amount="3.2 亿", stage="立项", source_chapter="ch03"),
        _card(PILOT, 4, stage="-", source_chapter="ch99"),   # 未知 slug → 原样透传
        _card(PILOT, 5, amount="500 万元", stage="招标", source_chapter="ch02"),
        _card(PILOT, 6),
    ]


def _second_cards() -> list[dict]:
    return [
        _card(SECOND, 1, title="<script>alert(1)</script>", amount="800 万元",
              stage="施工", province="广东", source_chapter="ch01",
              summary="注入测试：包含<script>与\"引号'"),
        _card(SECOND, 2, stage="-", province="广东", source_chapter="ch01"),
        _card(SECOND, 3, amount="2,000 万元", province="广东", source_chapter="ch02"),
    ]


def _write_cards(pkg: Path, rid: str, cards: list[dict]) -> None:
    d = pkg / "cards"
    d.mkdir(exist_ok=True)
    (d / f"{rid}.json").write_text(json.dumps(
        {"report_id": rid, "generated_at": "2026-09-28T00:00:00", "source": "test",
         "cards": cards}, ensure_ascii=False), encoding="utf-8")


@pytest.fixture()
def cenv(engine, monkeypatch):
    """卡域隔离：夹具卡数据写入 CONTENT_DIR/cards（真实部署同位）+码池目录进 tmp。"""
    cards_mod._CACHE.clear()
    monkeypatch.setattr(config, "POSTER_QR_DIR", engine.tmp / "qrs")
    _write_cards(engine.pkg, PILOT, _pilot_cards())
    _write_cards(engine.pkg, SECOND, _second_cards())
    yield engine
    cards_mod._CACHE.clear()


def _fake_qr_png(color=(20, 40, 80)) -> bytes:
    img = Image.new("RGB", (120, 120), color)
    ImageDraw.Draw(img).rectangle([30, 30, 90, 90], fill="white")
    buf = BytesIO()
    img.save(buf, format="PNG")
    return buf.getvalue()


# ── 单卡公开：形状+富化+归一化 ─────────────────────────────────────────
def test_get_card_public_shape_and_enrichment(cenv, client):
    r = client.get(f"/api/v1/cards/{PILOT}-c001")   # 无 Bearer 公开
    assert r.status_code == 200
    d = r.json()
    assert set(d) == {"card", "report"}
    assert set(d["card"]) == {"id", "report_id", "title", "amount", "amount_raw",
                              "owner", "stage", "window", "province", "source_chapter",
                              "summary"}
    assert d["card"]["id"] == f"{PILOT}-c001" and d["card"]["report_id"] == PILOT
    assert d["card"]["stage"] == ""                    # 占位 '-' 归一为 ''
    assert d["card"]["amount"] == "1,200 万元"          # amount 原样透传
    assert d["card"]["source_chapter"] == "第 1 章 · 水网第1章 标题1"   # ch01 富化
    assert d["report"] == {"id": PILOT, "title": "江苏省水网工程商机研究",
                           "price_fen": 990, "cover": "", "trial_chapters": 2}


def test_get_card_normalizations(cenv, client):
    d2 = client.get(f"/api/v1/cards/{PILOT}-c002").json()["card"]
    assert d2["stage"] == "" and d2["amount"] == ""    # 空串保持空串
    d3 = client.get(f"/api/v1/cards/{PILOT}-c003").json()["card"]
    assert d3["stage"] == "立项"                        # 真实 stage 不动


def test_get_card_unknown_slug_passthrough(cenv, client):
    d = client.get(f"/api/v1/cards/{PILOT}-c004").json()["card"]
    assert d["source_chapter"] == "ch99"               # 查不到 slug 原样透传不失败


def test_get_card_not_found(cenv, client):
    r = client.get("/api/v1/cards/no-such-card")
    assert r.status_code == 404 and r.json()["code"] == "CARD_NOT_FOUND"


def test_off_report_card_404_both_api_and_h5(cenv, client):
    (cenv.pkg / "off.json").write_text(json.dumps({"off": [SECOND]}), encoding="utf-8")
    catalog.apply_off_sidecar(cenv.pkg)
    r = client.get(f"/api/v1/cards/{SECOND}-c001")
    assert r.status_code == 404 and r.json()["code"] == "CARD_NOT_FOUND"
    h5 = client.get(f"/h5/cards/{SECOND}-c001")
    assert h5.status_code == 404 and "总包学园" in h5.text


# ── by-report 两态（冻结契约）──────────────────────────────────────────
def test_by_report_locked_teaser_anonymous(cenv, client):
    r = client.get(f"/api/v1/cards/by-report/{PILOT}")   # 无 Bearer
    assert r.status_code == 200
    d = r.json()
    assert d["locked"] is True and d["total"] == 6
    assert [c["id"] for c in d["cards"]] == [f"{PILOT}-c001", f"{PILOT}-c002",
                                             f"{PILOT}-c003"]   # 前 3 张
    assert d["cards"][0]["source_chapter"].startswith("第 1 章 · ")  # 预览同样富化


def test_by_report_buyer_without_entitlement_locked(cenv, client, buyer):
    d = client.get(f"/api/v1/cards/by-report/{PILOT}", headers=buyer).json()
    assert d["locked"] is True and d["total"] == 6 and len(d["cards"]) == 3


def test_by_report_entitled_full_pagination(cenv, client, buyer):
    virtual_pay.grant_entitlement(buyer["uid"], PILOT, "purchase", "order-cards-1")
    d = client.get(f"/api/v1/cards/by-report/{PILOT}", headers=buyer).json()
    assert d["locked"] is False and d["total"] == 6 and len(d["cards"]) == 6
    assert d["page"] == 1 and d["page_size"] == 20          # 默认分页
    p2 = client.get(f"/api/v1/cards/by-report/{PILOT}?page=2&page_size=2",
                    headers=buyer).json()
    assert [c["id"] for c in p2["cards"]] == [f"{PILOT}-c003", f"{PILOT}-c004"]
    assert (p2["page"], p2["page_size"], p2["total"]) == (2, 2, 6)
    beyond = client.get(f"/api/v1/cards/by-report/{PILOT}?page=9", headers=buyer).json()
    assert beyond["cards"] == [] and beyond["total"] == 6    # 越页空集不报错


def test_by_report_page_size_clamped(cenv, client, buyer):
    virtual_pay.grant_entitlement(buyer["uid"], PILOT, "purchase", "order-cards-2")
    d = client.get(f"/api/v1/cards/by-report/{PILOT}?page_size=99",
                   headers=buyer).json()
    assert d["page_size"] == 50                              # 上限 50 同通例


def test_by_report_unknown_report_404(cenv, client):
    r = client.get("/api/v1/cards/by-report/no-such-report")
    assert r.status_code == 404 and r.json()["code"] == "REPORT_NOT_FOUND"


# ── resolve（恒 200）──────────────────────────────────────────────────
def test_resolve_hit_and_misses(cenv, client):
    hit = client.get("/api/v1/cards/resolve",
                     params={"scene": f"c={PILOT}-c001"})
    assert hit.status_code == 200 and hit.json() == {"card_id": f"{PILOT}-c001"}
    miss_unknown = client.get("/api/v1/cards/resolve",
                              params={"scene": "c=no-such-card&i=u0123456789"})
    assert miss_unknown.json() == {"card_id": ""}
    garbage = client.get("/api/v1/cards/resolve", params={"scene": "garbage"})
    assert garbage.status_code == 200 and garbage.json() == {"card_id": ""}
    empty = client.get("/api/v1/cards/resolve")
    assert empty.status_code == 200 and empty.json() == {"card_id": ""}


def test_resolve_scene_over_official_32_limit_degrades(cenv, client):
    # 官方契约边界：c=<card_id>&i=<uid> 超 32 可见字符 → 解析失败空串（非 bug，
    # getwxacodeunlimit 硬上限；全量卡场景见 RUN_LEDGER 遗留项）
    scene = f"c={PILOT}-c001&i=u0123456789"      # 37 字符
    assert len(scene) > 32
    r = client.get("/api/v1/cards/resolve", params={"scene": scene})
    assert r.status_code == 200 and r.json() == {"card_id": ""}


# ── H5 长尾页（SEO）：转义/404/内链/CTA ────────────────────────────────
def test_h5_escapes_script_injection(cenv, client):
    r = client.get(f"/h5/cards/{SECOND}-c001")
    assert r.status_code == 200 and r.headers["content-type"].startswith("text/html")
    assert "&lt;script&gt;alert(1)&lt;/script&gt;" in r.text
    assert "<script>alert" not in r.text                  # 原生标签不得存活
    assert "&lt;script&gt;" in r.text.split('name="description"')[1]  # 摘要同样转义


def test_h5_title_meta_and_cta(cenv, client):
    r = client.get(f"/h5/cards/{PILOT}-c001")
    assert f"<title>5G机房建设 · 总包学园</title>" in r.text
    assert 'name="description" content="5G机房建设项目。"' in r.text
    assert "商机情报见总包学园小程序" in r.text       # CTA 文案（冻结）
    assert "微信" in r.text                            # 引导在微信打开
    assert "1,200 万元" in r.text


def test_h5_not_found_404(cenv, client):
    r = client.get("/h5/cards/nope")
    assert r.status_code == 404
    assert r.headers["content-type"].startswith("text/html")
    assert "商机卡不存在" in r.text


def test_h5_more_links_internal(cenv, client):
    r = client.get(f"/h5/cards/{SECOND}-c002")           # 无金额卡页 → 尾部互链
    links = [ln for ln in r.text.split('href="/h5/cards/')[1:]]
    assert len(links) >= 2                                # 更多商业内链存在
    assert f'href="/h5/cards/{SECOND}-c002"' not in r.text   # 不自链
    assert "800 万元" in r.text and "2,000 万元" in r.text   # 有金额卡优先


# ── 卡海报（Bearer PNG bytes + QR 缓存复用）───────────────────────────
def test_card_poster_requires_login(cenv, client):
    r = client.post("/api/v1/posters/card", json={"card_id": f"{PILOT}-c001"})
    assert r.status_code == 401


def test_card_poster_unknown_card_404(cenv, client, buyer):
    r = client.post("/api/v1/posters/card", json={"card_id": "no-such"},
                    headers=buyer)
    assert r.status_code == 404 and r.json()["code"] == "CARD_NOT_FOUND"


def test_card_poster_smoke_png_and_qr_cache(cenv, client, buyer, monkeypatch):
    calls = {"n": 0}

    def fake_qr(card_id, uid):
        calls["n"] += 1
        return _fake_qr_png((10, 99, 30))

    monkeypatch.setattr(poster, "_card_qr_bytes", fake_qr)
    r1 = client.post("/api/v1/posters/card", json={"card_id": f"{PILOT}-c001"},
                     headers=buyer)
    assert r1.status_code == 200 and r1.headers["content-type"] == "image/png"
    assert r1.content[:8] == b"\x89PNG\r\n\x1a\n"         # PNG 魔数
    with Image.open(BytesIO(r1.content)) as im:
        assert im.size == (1080, 1440)
    r2 = client.post("/api/v1/posters/card", json={"card_id": f"{PILOT}-c001"},
                     headers=buyer)
    assert calls["n"] == 1 and r2.content == r1.content    # (card,uid) 缓存复用不重取
    with store._db() as c:                                 # 分享行为落表（rid=所属报告）
        row = c.execute("SELECT * FROM share_event WHERE user_id=?",
                        (buyer["uid"],)).fetchone()
    assert row["report_id"] == PILOT and row["channel"] == "poster"


def test_card_poster_long_scene_placeholder_degrades(cenv, client, buyer):
    # 真取码路径：PILOT 卡 scene 37 字符超官方上限 → None → 占位降级仍出图
    r = client.post("/api/v1/posters/card", json={"card_id": f"{PILOT}-c001"},
                    headers=buyer)
    assert r.status_code == 200 and r.content[:8] == b"\x89PNG\r\n\x1a\n"


# ── 渲染模板：分区像素判据 ────────────────────────────────────────────
def test_render_card_poster_zones(cenv):
    card = _pilot_cards()[0]
    img = poster.render_card_poster(card, _fake_qr_png((20, 40, 80)))
    t = poster.CARD_TEMPLATE
    assert img.size == (1080, 1440)
    assert img.getpixel((10, 10))[:3] == t["navy"]              # ①品牌头
    assert img.getpixel((80, 700))[:3] == t["amber"]            # ②金额大字侧强调条
    assert img.getpixel((540, 1200))[:3] == t["navy"]           # ③底部品牌条
    no_amount = poster.render_card_poster({**card, "amount": "", "stage": "-"}, None)
    assert no_amount.size == (1080, 1440)                       # 空金额→区域大字分支


# ── parse_card_scene 纯解析三态 ───────────────────────────────────────
def test_parse_card_scene_three_states():
    assert poster.parse_card_scene("c=ab-c001&i=u1") == ("ab-c001", "u1")
    assert poster.parse_card_scene("c=ab-c001") == ("ab-c001", None)   # i= 可选
    assert poster.parse_card_scene("  c=ab&i=u1 ") == ("ab", "u1")
    assert poster.parse_card_scene("") is None                 # 空
    assert poster.parse_card_scene("i=u1") is None              # 缺 c=
    assert poster.parse_card_scene("r=ab&i=u1") is None         # 报告码不归卡码
    assert poster.parse_card_scene("c=ab&i=b&i=c") is None      # 重复键
    assert poster.parse_card_scene("c=a%b") is None             # % 非官方字符集
    assert poster.parse_card_scene("c=" + "x" * 40) is None     # 超 32 官方上限
    assert poster.parse_card_scene(None) is None                # 非字符串兜底
    assert poster.parse_card_scene("s=Xk29fA") is None          # 短码无 lookup 降级
    assert poster.parse_card_scene("s=Xk29fA",
                                   code_lookup=lambda s: ("ab-c001", "u1")) == ("ab-c001", "u1")


# ── 索引健壮性：坏文件跳过不失败 ──────────────────────────────────────
def test_index_skips_broken_json(engine):
    cards_mod._CACHE.clear()
    _write_cards(engine.pkg, PILOT, _pilot_cards()[:1])
    (engine.pkg / "cards" / "broken.json").write_text("{not json", encoding="utf-8")
    assert cards_mod.find_card(f"{PILOT}-c001") is not None
    assert cards_mod.total_cards() == 1
    cards_mod._CACHE.clear()


# ── 卡维短码（scene ≤32 根治通道，2026-09-28 切片；与 poster_code 溢出对称）──
def test_card_qr_scene_direct_first_and_overflow_short_code(cenv):
    assert cards_mod.card_qr_scene("ab-c1", "u1") == "c=ab-c1&i=u1"  # 直拼合法优先
    scene = cards_mod.card_qr_scene(f"{PILOT}-c001", "u1234567890")   # 37 字符超限→短码
    assert scene.startswith("s=") and len(scene) <= 32
    assert cards_mod.card_qr_scene(f"{PILOT}-c001", "u1234567890") == scene  # 幂等同码


def test_ensure_card_code_row_and_lookup(cenv):
    scene = cards_mod.ensure_card_code(f"{PILOT}-c002", "u9")
    assert scene.startswith("s=") and len(scene[2:]) == 8
    with store._db() as c:
        row = c.execute("SELECT * FROM card_code WHERE short_code=?",
                        (scene[2:],)).fetchone()
    assert row["card_id"] == f"{PILOT}-c002" and row["inviter_uid"] == "u9"
    assert row["report_id"] == PILOT
    assert cards_mod.card_code_lookup(scene) == (PILOT, "u9")
    assert cards_mod.card_code_lookup("s=deadbee0") is None       # 查不到 None


def test_resolve_via_short_code_roundtrip(cenv, client):
    scene = cards_mod.ensure_card_code(f"{SECOND}-c001", "u7")
    d = client.get("/api/v1/cards/resolve", params={"scene": scene}).json()
    assert d["card_id"] == f"{SECOND}-c001"
    miss = client.get("/api/v1/cards/resolve", params={"scene": "s=deadbee0"}).json()
    assert miss == {"card_id": ""}                                # 恒 200 降级


def test_card_qr_bytes_pool_hit_via_short_code(cenv):
    scene = cards_mod.card_qr_scene(f"{PILOT}-c003", "u55")       # 超限→短码
    p = poster.qr_pool_path(scene)
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_bytes(_fake_qr_png((9, 9, 9)))
    got = poster._card_qr_bytes(f"{PILOT}-c003", "u55")
    assert got is not None and got[:8] == b"\x89PNG\r\n\x1a\n"    # 码池命中真字节
