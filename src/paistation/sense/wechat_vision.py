"""V1 微信纯视觉读取器（M10.2a，PROPOSAL_V2.md 第 6 章）：零注入。

链路：ScreenSource 抓屏（内存 bytes，绝不落盘）→ GLM 视觉模型理解 →
文本摘要入 01 用户 画像日志 → R14 凭证落链 → 水位字符串回引擎。
安全件全由 DeepReadEngine 注入（夜间窗口/提醒/硬顶/熔断/串行）。

红线语义：
- 即读即删：截图 bytes 用后即弃，仅文本摘要留存（隐私红线）
- 缺席不熔断：首屏无微信窗口 = 成功空转（应用没开 ≠ 故障）
- V1 只读可见内容；回溯滚动/多会话翻页属 V2（见 06 技能 血缘图）
"""
from __future__ import annotations

import io
import logging
from datetime import datetime
from pathlib import Path

from ..organ import credential as cred_mod
from ..organ.registry import find_by_name

_log = logging.getLogger("paistation.wechat_vision")

# 视觉理解契约：一张屏 → 左侧会话列表 + 当前会话消息
SCHEMA = {
    "window": "wechat（PC 微信窗口可见）或 other",
    "chats": [{"title": "会话名", "last_msg": "最新一条消息", "ts_hint": "时间提示"}],
    "current_chat": {"title": "当前打开会话", "messages": ["可见消息"]},
}

_PROMPT = (
    "这是电脑屏幕截图。请判断是否可见 PC 微信窗口。若可见，提取左侧会话"
    "列表（标题+最新消息+时间提示）和当前打开会话的可见消息；只依据画面"
    "可见内容，不要推测。严格按 schema 返回 JSON。"
)


class PilScreenSource:
    """PIL 全屏（或区域）截屏 → PNG bytes（仅内存，不写盘）。"""

    def __init__(self, region: tuple | None = None):
        self.region = region

    def grab(self) -> bytes | None:
        try:
            from PIL import ImageGrab
            img = ImageGrab.grab(bbox=self.region)
            buf = io.BytesIO()
            img.save(buf, format="PNG", optimize=True)
            img.close()
            return buf.getvalue()
        except Exception as exc:  # noqa: BLE001 - 抓屏失败按无帧处理
            _log.warning("截屏失败（按缺席处理）: %s", exc)
            return None


class WeChatVisionReader:
    """reader_fn 契约实现：reader(guard, watermark) -> 水位字符串 dict。"""

    def __init__(self, client, source, journal_root: Path,
                 station_root: Path, now_fn=None, digest_head: int = 120):
        self.client = client
        self.source = source
        self.journal_root = Path(journal_root)
        self.station_root = Path(station_root)
        self._now = now_fn or datetime.now
        self._digest_head = digest_head

    # -- 主链 -------------------------------------------------------------

    def __call__(self, guard, watermark: dict) -> dict:
        if not guard.allow_add(1):          # 硬顶已满：不抓屏不烧模型
            return {}
        image = self.source.grab()
        if image is None:                   # 无帧（抓屏失败）→ 成功空转
            return {}
        try:
            parsed = self.client.vision(image, SCHEMA)["json"]
        finally:
            del image                       # 即读即删：bytes 用后即弃
        if parsed.get("window") != "wechat":
            return {}                       # 缺席不熔断：应用没开 ≠ 故障
        guard.add(1)
        return self._persist(parsed)

    def _persist(self, parsed: dict) -> dict:
        chats = parsed.get("chats") or []
        current = parsed.get("current_chat") or {}
        now = self._now()
        day = now.strftime("%Y-%m-%d")
        lines = [f"## {now.strftime('%H:%M')} 深读摘要"]
        for chat in chats:
            lines.append(f"- {chat.get('title', '')}：{chat.get('last_msg', '')}"
                         f"（{chat.get('ts_hint', '')}）")
        if current.get("title"):
            lines.append(f"当前会话 {current['title']}："
                         + " / ".join(current.get("messages") or []))
        digest = "\n".join(lines)

        journal = self.journal_root / f"{day}.md"
        journal.parent.mkdir(parents=True, exist_ok=True)
        with open(journal, "a", encoding="utf-8") as fh:
            fh.write(digest + "\n\n")

        # R14：微信深读 → 01 用户画像，流转必落凭证
        spec = find_by_name("用户")
        cred = cred_mod.issue(
            kind="deepread_digest", upstream="sense.deepread",
            downstream=spec.dirname,
            payload={"date": day, "chats": len(chats), "chars": len(digest),
                     "journal": str(journal.relative_to(self.station_root))
                     if journal.is_relative_to(self.station_root) else str(journal)})
        cred_mod.append_to_chain(self.station_root, spec.dirname, cred)

        top = chats[0] if chats else {}
        return {"wechat_top_chat": str(top.get("title", "")),
                "wechat_ts": str(top.get("ts_hint", "")),
                "wechat_digest_head": digest[:self._digest_head]}


def build_reader(client, station_root, enabled: bool = True):
    """生产装配工厂：client 缺席 / 开关关 → None（安全默认零动作）。"""
    if not enabled or client is None:
        return None
    spec = find_by_name("用户")
    journal_root = Path(station_root) / spec.dirname / "profile" / "deepread"
    return WeChatVisionReader(client=client, source=PilScreenSource(),
                              journal_root=journal_root,
                              station_root=Path(station_root))
