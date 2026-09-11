"""M10.2a V1 微信纯视觉读取器 TDD（PROPOSAL_V2.md 第 6 章，零注入红线）。

- ZhipuClient.vision 接受 bytes（即读即删：截图永不落盘）
- WeChatVisionReader：reader_fn(guard, watermark) 契约
  * 微信可见 → 文本摘要入 01 用户 画像日志 + R14 凭证落链 + 水位字符串
  * 缺席（首屏无微信）→ 成功空转 {}（不熔断——应用不在 ≠ 故障）
  * 预算尽 → 不抓屏不调模型
- build_reader 工厂：client 缺席 / 开关关 → None（安全默认）
"""
import base64
import json
from datetime import datetime

from paistation.organ.credential import read_chain
from paistation.sense.deepread import BudgetGuard
from paistation.sense.wechat_vision import (
    PilScreenSource,
    WeChatVisionReader,
    build_reader,
)

PNG = b"\x89PNG\r\n\x1a\n" + b"\x00" * 64

PARSED = {
    "window": "wechat",
    "chats": [
        {"title": "张三", "last_msg": "方案我看了，可以", "ts_hint": "昨天"},
        {"title": "项目群", "last_msg": "会议改期到周四", "ts_hint": "23:50"},
    ],
    "current_chat": {"title": "张三", "messages": ["好的", "收到，我更新一版"]},
}


class FakeSource:
    def __init__(self, frames):
        self.frames = list(frames)
        self.grabs = 0

    def grab(self):
        self.grabs += 1
        return self.frames.pop(0) if self.frames else None


class FakeClient:
    def __init__(self, parsed):
        self.parsed = parsed
        self.images = []
        self.calls = 0

    def vision(self, image, schema):
        self.calls += 1
        self.images.append(image)
        return {"json": self.parsed}


def make(tmp_path, parsed=PARSED):
    src = FakeSource([PNG])
    cli = FakeClient(parsed)
    reader = WeChatVisionReader(
        client=cli, source=src,
        journal_root=tmp_path / "journal", station_root=tmp_path,
        now_fn=lambda: datetime(2026, 9, 12, 0, 31))
    return reader, cli, src


def guard():
    g = BudgetGuard()
    g.start(datetime(2026, 9, 12, 0, 30))
    return g


# ---------------------------------------------------------------- 读取主链

def test_reader_reads_visible_wechat(tmp_path):
    reader, cli, src = make(tmp_path)
    out = reader(guard(), {})
    assert cli.calls == 1 and cli.images == [PNG]      # bytes 直传给视觉模型
    assert src.grabs == 1
    assert out["wechat_top_chat"] == "张三"
    assert isinstance(out["wechat_digest_head"], str) and "张三" in out["wechat_digest_head"]
    # 摘要入 01 用户 画像日志（gitignore 区）
    journal = tmp_path / "journal" / "2026-09-12.md"
    body = journal.read_text(encoding="utf-8")
    assert "张三" in body and "项目群" in body
    # R14：深读 → 用户画像 落凭证
    chain = read_chain(tmp_path, "用户")
    assert chain and chain[0].kind == "deepread_digest"
    assert chain[0].downstream == "01 用户"


def test_reader_absent_wechat_noop_success(tmp_path):
    reader, cli, src = make(tmp_path, parsed={"window": "other"})
    g = guard()
    out = reader(g, {})
    assert out == {}                                   # 成功空转：缺席不熔断
    assert cli.calls == 1 and g.screens == 0           # 不计预算、不落任何文件
    assert not (tmp_path / "journal").exists()
    assert read_chain(tmp_path, "用户") == []


def test_reader_budget_exhausted_skips_everything(tmp_path):
    reader, cli, src = make(tmp_path)
    g = guard()
    g.add(300)                                         # 硬顶已满
    assert reader(g, {}) == {}
    assert cli.calls == 0 and src.grabs == 0           # 不抓屏不烧模型


def test_reader_grab_failure_noop(tmp_path):
    reader, cli, src = make(tmp_path)
    src.frames = []                                    # 无帧可抓
    assert reader(guard(), {}) == {}
    assert cli.calls == 0


def test_no_screenshot_ever_on_disk(tmp_path):
    """即读即删红线：全程零截图文件（内存 bytes 用后即弃）。"""
    reader, cli, _ = make(tmp_path)
    reader(guard(), {})
    assert list(tmp_path.rglob("*.png")) == []
    assert list(tmp_path.rglob("*.jpg")) == []
    assert list(tmp_path.rglob("*.bmp")) == []


def test_reader_outcome_strings_only_for_watermark(tmp_path):
    """引擎水位合并只收字符串——reader 契约必须全 str。"""
    reader, _, _ = make(tmp_path)
    out = reader(guard(), {})
    assert all(isinstance(v, str) for v in out.values())


# ---------------------------------------------------------------- 工厂

def test_build_reader_disabled_or_no_client(tmp_path):
    cli = FakeClient(PARSED)
    assert build_reader(None, tmp_path) is None
    assert build_reader(cli, tmp_path, enabled=False) is None
    r = build_reader(cli, tmp_path)
    assert isinstance(r, WeChatVisionReader)
    assert "01 用户" in str(r.journal_root)            # 画像归 01 用户器官


def test_build_reader_uses_organ_profile_dir(tmp_path):
    r = build_reader(FakeClient(PARSED), tmp_path)
    assert r.journal_root.parts[-3:] == ("01 用户", "profile", "deepread")


# ---------------------------------------------------------------- 真实屏源

def test_pil_source_grab_returns_png_bytes():
    data = PilScreenSource().grab()
    assert data is not None and data[:4] == b"\x89PNG"


# ---------------------------------------------------------------- Zhipu bytes

def test_zhipu_vision_accepts_bytes():
    from paistation.llm.zhipu_client import ZhipuClient
    captured = {}

    def fake_post(url, headers, payload, timeout=120):
        captured.update(payload)
        return 200, json.dumps({"choices": [{"message": {"content": "{\"ok\": 1}"}}],
                                "usage": {}})

    client = ZhipuClient("k", ["glm-x"], _post=fake_post)
    out = client.vision(b"\x89PNGdata", {"a": 1})
    content = captured["messages"][0]["content"]
    img = next(p for p in content if p.get("type") == "image_url")
    raw = base64.b64decode(img["image_url"]["url"].split(",", 1)[1])
    assert raw == b"\x89PNGdata"
    assert out["json"] == {"ok": 1}


def test_zhipu_vision_still_accepts_path(tmp_path):
    from paistation.llm.zhipu_client import ZhipuClient
    png = tmp_path / "shot.png"
    png.write_bytes(PNG)
    captured = {}

    def fake_post(url, headers, payload, timeout=120):
        captured.update(payload)
        return 200, json.dumps({"choices": [{"message": {"content": "{\"ok\": 1}"}}],
                                "usage": {}})

    client = ZhipuClient("k", ["glm-x"], _post=fake_post)
    out = client.vision(str(png), {})
    img = next(p for p in captured["messages"][0]["content"]
               if p.get("type") == "image_url")
    assert base64.b64decode(img["image_url"]["url"].split(",", 1)[1]) == PNG
    assert out["json"] == {"ok": 1}
