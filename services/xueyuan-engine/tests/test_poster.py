# -*- coding: utf-8 -*-
"""海报域单测（T-P1-07）：四分区出图/scene 三态/短码溢出/share_event 落表/字体降级/码池。

零网络零真微信：QR 字节用固定假图 fixture；字体走仓库自托 assets（生产同路径）。
"""
from __future__ import annotations

import sys
from io import BytesIO
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

import pytest  # noqa: E402
from PIL import Image, ImageDraw, ImageFont  # noqa: E402

from tests.conftest import PILOT  # noqa: E402

from xueyuan_engine import config, poster, store  # noqa: E402
from xueyuan_engine.catalog import get_report  # noqa: E402


@pytest.fixture()
def penv(engine, monkeypatch):
    """海报域隔离：码池目录进 tmp（conftest 未覆盖的 POSTER_* 运行时落位）。"""
    monkeypatch.setattr(config, "POSTER_QR_DIR", engine.tmp / "qrs")
    yield engine


def _fake_qr_png(color=(20, 40, 80)) -> bytes:
    """固定假码 fixture（零网络）：双色方块图，供码池命中断言。"""
    img = Image.new("RGB", (120, 120), color)
    ImageDraw.Draw(img).rectangle([30, 30, 90, 90], fill="white")
    buf = BytesIO()
    img.save(buf, format="PNG")
    return buf.getvalue()


def _qr_origin() -> tuple[int, int, int, int]:
    """码位白盒在画布上的像素区（与 _draw_strip 同口径：右下规范位+白边）。"""
    t = poster.TEMPLATE
    box = t["qr_size"] + 2 * t["qr_pad"]
    bx1 = config.POSTER_WIDTH - t["margin"] - box
    by1 = config.POSTER_HEIGHT - t["strip_bottom"] - box
    return bx1, by1, t["qr_pad"], t["qr_size"]


# ── 端点契约（API_DESIGN P1-6 字段逐字）────────────────────────────────
def test_poster_requires_login(penv, client):
    assert client.get(f"/api/v1/poster/{PILOT}").status_code == 401


def test_poster_unknown_report(penv, client, buyer):
    r = client.get("/api/v1/poster/no-such-report", headers=buyer)
    assert r.status_code == 404 and r.json()["code"] == "REPORT_NOT_FOUND"


def test_poster_full_flow(penv, client, buyer):
    r = client.get(f"/api/v1/poster/{PILOT}", headers=buyer)
    assert r.status_code == 200
    d = r.json()
    assert set(d) == {"poster_url", "width", "height", "scene_code", "poster_version"}
    assert (d["width"], d["height"]) == (1080, 1440)
    assert d["poster_version"] == config.POSTER_VERSION == "v1"
    expect_scene = f"r={PILOT}&i={buyer['uid']}"
    assert d["scene_code"] == expect_scene and len(d["scene_code"]) <= 32
    with store._db() as c:  # poster_code 映射已落表（E1 invite_relation.scene_code FK 依赖）
        row = c.execute("SELECT * FROM poster_code WHERE scene_code=?", (expect_scene,)).fetchone()
    assert row and row["report_id"] == PILOT and row["inviter_uid"] == buyer["uid"]
    img_r = client.get(d["poster_url"])
    assert img_r.status_code == 200 and img_r.headers["content-type"] == "image/png"
    assert img_r.content[:8] == b"\x89PNG\r\n\x1a\n"
    with Image.open(BytesIO(img_r.content)) as im:
        assert im.size == (1080, 1440)
    again = client.get(f"/api/v1/poster/{PILOT}", headers=buyer).json()
    assert again["poster_url"] == d["poster_url"]  # (user,report,version) 复用缓存图


def test_share_event_per_request_and_channel(penv, client, buyer):
    assert client.get(f"/api/v1/poster/{PILOT}?channel=bogus",
                      headers=buyer).status_code == 400
    client.get(f"/api/v1/poster/{PILOT}", headers=buyer)
    client.get(f"/api/v1/poster/{PILOT}?channel=moments", headers=buyer)
    with store._db() as c:
        rows = c.execute("SELECT user_id,report_id,channel,poster_version FROM share_event"
                         " WHERE user_id=?", (buyer["uid"],)).fetchall()
    assert sorted(r["channel"] for r in rows) == ["moments", "poster"]
    assert all(r["report_id"] == PILOT and r["poster_version"] == "v1" for r in rows)


def test_font_missing_explicit_error(penv, client, buyer, monkeypatch):
    monkeypatch.setattr(config, "POSTER_FONT_REGULAR", penv.tmp / "nope.otf")
    r = client.get(f"/api/v1/poster/{PILOT}", headers=buyer)
    assert r.status_code == 500 and r.json()["code"] == "POSTER_FONT_MISSING"
    with store._db() as c:  # 出图失败不落 share_event（分享行为未发生）
        assert c.execute("SELECT COUNT(*) n FROM share_event").fetchone()["n"] == 0


def test_poster_file_route_guards(penv, client):
    assert client.get("/posters/nope.png").status_code == 404
    assert client.get("/posters/name%20with%20space.png").status_code == 404
    assert client.get("/posters/db.sqlite").status_code == 404


# ── scene 三态：正常直拼 / 超限短码 / 解析失败降级 None ──────────────────
def test_parse_scene_three_states():
    assert poster.parse_scene("r=abc&i=u1") == ("abc", "u1")
    assert poster.parse_scene("r=abc") == ("abc", None)
    assert poster.parse_scene("  r=abc&i=u1 ") == ("abc", "u1")
    assert poster.parse_scene("") is None                      # 空
    assert poster.parse_scene("garbage") is None               # 垃圾
    assert poster.parse_scene("i=u1") is None                  # 缺 r=
    assert poster.parse_scene("r=" + "x" * 40) is None         # 超 32 官方上限
    assert poster.parse_scene("r=a%b") is None                 # % 非法（官方字符集外）
    assert poster.parse_scene("r=a&i=b&i=c") is None           # 重复键
    assert poster.parse_scene(None) is None                    # 非字符串兜底
    assert poster.parse_scene("s=Xk29fA") is None              # 短码无 lookup → 降级
    assert poster.parse_scene("s=Xk29fA", code_lookup=lambda s: ("abc", None)) == ("abc", None)
    assert poster.parse_scene("s=zzzz", code_lookup=lambda s: None) is None  # 映射查不到


def test_scene_overflow_short_code(penv, client, buyer, monkeypatch):
    monkeypatch.setattr(config, "POSTER_SCENE_MAX", 8)   # 强制直拼超限走短码
    r = client.get(f"/api/v1/poster/{PILOT}", headers=buyer)
    scene = r.json()["scene_code"]
    assert scene.startswith("s=") and len(scene) <= 32
    assert poster.parse_scene(scene) is None              # 纯函数无 lookup 不解短码
    assert poster.parse_scene(scene, code_lookup=poster.lookup_code) == (PILOT, buyer["uid"])
    with store._db() as c:
        row = c.execute("SELECT * FROM poster_code WHERE scene_code=?", (scene,)).fetchone()
    assert row and row["report_id"] == PILOT and row["inviter_uid"] == buyer["uid"]


def test_natural_overflow_long_report_id(penv):
    # 真实形态：hubei-shuili-1786519550(23)+uid(11)+定界 5=39>32 → 自动短码兜底
    scene = poster.ensure_scene("hubei-shuili-1786519550", "u1234567890")
    assert scene.startswith("s=") and len(scene) <= 32
    assert poster.lookup_code(scene) == ("hubei-shuili-1786519550", "u1234567890")


def test_short_code_reuse_idempotent(penv):
    """生产码池首灌实锤回归：同一 (report,inviter) 重复 ensure_scene 恒同码——
    首版漏复用查→每次请求新掷一枚（码池永不命中+poster_code 无界膨胀）；
    短码是归因键：一人一报告一枚，跨渠道（poster/moments）也复用。"""
    rid, uid = "hubei-shuili-1786519550", "u1234567890"
    s1 = poster.ensure_scene(rid, uid)
    s2 = poster.ensure_scene(rid, uid, channel="moments")
    assert s1 == s2 and s1.startswith("s=")
    with store._db() as c:
        n = c.execute(
            "SELECT COUNT(*) n FROM poster_code WHERE report_id=? AND inviter_uid=?",
            (rid, uid)).fetchone()["n"]
    assert n == 1


# ── 渲染：四分区像素判据 + 码池命中 + CJK 非豆腐块 ──────────────────────
def test_render_four_zones_and_qr_placeholder(penv):
    img = poster.render_poster(get_report(PILOT), None)
    t = poster.TEMPLATE
    assert img.size == (1080, 1440)
    assert img.getpixel((10, 10))[:3] == t["navy"]            # ①封面块（顶部≈40%）
    assert img.getpixel((540, 300))[:3] == t["navy"]
    assert img.getpixel((80, 700))[:3] == t["amber"]          # ②大字区左侧强调条
    assert img.getpixel((540, 1050))[:3] == t["bg"]           # ③结论区留白底
    assert img.getpixel((540, 1200))[:3] == t["navy"]         # ④品牌条（底部）
    bx1, by1, pad, size = _qr_origin()
    assert img.getpixel((bx1 + 10, by1 + 10))[:3] == (255, 255, 255)   # 码位白盒
    assert img.getpixel((bx1 + pad + 120, by1 + pad + 60))[:3] == (238, 240, 243)  # 占位底色


def test_render_qr_pool_bytes_drawn(penv):
    img = poster.render_poster(get_report(PILOT), _fake_qr_png((20, 40, 80)))
    bx1, by1, pad, _ = _qr_origin()
    assert img.getpixel((bx1 + pad + 8, by1 + pad + 8))[:3] == (20, 40, 80)


def test_qr_pool_file_naming(penv):
    p = poster.qr_pool_path("r=ab&i=u1")
    assert p.name == "r%3Dab%26i%3Du1.png" and p.parent == config.POSTER_QR_DIR


def test_qr_pool_hit_through_endpoint(penv, client, buyer):
    scene = f"r={PILOT}&i={buyer['uid']}"
    pool = poster.qr_pool_path(scene)
    pool.parent.mkdir(parents=True, exist_ok=True)
    pool.write_bytes(_fake_qr_png((10, 20, 30)))
    r = client.get(f"/api/v1/poster/{PILOT}", headers=buyer)
    assert r.status_code == 200
    with Image.open(BytesIO(client.get(r.json()["poster_url"]).content)) as im:
        bx1, by1, pad, _ = _qr_origin()
        assert im.getpixel((bx1 + pad + 8, by1 + pad + 8))[:3] == (10, 20, 30)


def test_cjk_font_renders_non_tofu():
    # 自托字体防豆腐块：江（必有字形）与 PUA 必缺字渲染结果必须不同
    font = ImageFont.truetype(str(config.POSTER_FONT_REGULAR), 40)
    a = Image.new("L", (60, 60), 0)
    ImageDraw.Draw(a).text((5, 5), "江", font=font, fill=255)
    b = Image.new("L", (60, 60), 0)
    ImageDraw.Draw(b).text((5, 5), chr(0xE000), font=font, fill=255)
    assert a.getextrema()[1] > 0 and a.tobytes() != b.tobytes()


# ── 文案：sidecar 覆写 + 默认推导 + 防泄漏红线 ─────────────────────────
def test_poster_content_defaults(penv):
    content = poster.poster_content(get_report(PILOT))
    assert content["title"] == "江苏省水网工程商机研究"
    assert content["hero_stat"] == "6章"                    # chapter_count 推导（夹具 6 章）
    assert "总包创研院" in content["meta"]
    assert content["conclusion"] and content["conclusion"] != content["title"]


def test_poster_content_sidecar_override(penv):
    (penv.pkg / "reports" / PILOT / "poster.json").write_text(
        '{"hero_stat": "3,200 亿", "hero_caption": "「十五五」投资窗口",'
        ' "conclusion": "江苏水网骨干工程已全面开工，窗口期就在未来三年。"}', encoding="utf-8")
    content = poster.poster_content(get_report(PILOT))
    assert content["hero_stat"] == "3,200 亿"
    assert content["hero_caption"] == "「十五五」投资窗口"
    assert content["conclusion"].startswith("江苏水网骨干工程")


def test_poster_content_never_touches_chapters(penv):
    # 防泄漏红线：文案五件套只读 report 行+sidecar，绝不携带章正文（结构判据）
    content = poster.poster_content(get_report(PILOT))
    assert set(content) == {"title", "hero_stat", "hero_caption", "conclusion", "meta"}
    assert all("付费正文" not in v and "<h1>" not in v for v in content.values())
