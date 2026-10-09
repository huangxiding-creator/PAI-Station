# -*- coding: utf-8 -*-
"""分享海报（v0.7.4 世界级重设计）：瑞士制图风编辑排版。

用户令（1001）：「当前生成的海报这个排版，不美观，没有达到世界级的审美。」
设计语言（工程图纸 × 瑞士网格）：
  - 一条 1.5px 图纸边框 + 角部对位十字 = 制图身份，代替满版网格噪音
  - 字阶纪律：问题 Bold 46 主角 / CTA Bold 42 / 正文 Regular 28 / 注记 20
  - 橙色只出现三次：栏目标度条、行动卡标签、底缘安全条
  - 留白即层级：短问题自然生成呼吸空间，锚点（要点/行动卡）位置稳定
  - 双字重 Noto Sans SC（DATA_DIR/fonts pair）；缺 pair 自动退回单字体，
    缺字体仍抛 LayoutError → 503（零失败姿态不变，无码兜底不变）。
"""
from __future__ import annotations

import io
from datetime import date

from . import config

NAVY = (11, 31, 58)        # 藏青 #0B1F3A
NAVY_DEEP = (7, 22, 42)    # 行动卡深一阶 #07162A
PAPER = (247, 244, 236)    # 暖白纸 #F7F4EC
ORANGE = (240, 122, 40)    # 安全橙 #F07A28（全图仅三处）
GRID = (219, 228, 238)     # 制图蓝线 #DBE4EE
HAIR = (216, 209, 190)     # 暖发丝线 #D8D1BE
WHITE = (255, 255, 255)
INK = (26, 44, 70)         # 正文墨 #1A2C46
INK_SOFT = (90, 106, 126)  # #5A6A7E
MIST = (178, 194, 214)     # 藏青上的注记灰 #B2C2D6

W, H = 750, 1334
M = 72                     # 版心边距
_QR_SIZE = 160             # 小程序码贴片边长（430 源图缩放，保扫码清晰度）


class LayoutError(Exception):
    """海报渲染失败（Pillow/字体缺失/参数异常）。"""


def _wrap(d, text: str, font, max_w: int) -> list:
    """按像素宽度逐字折行（中文友好）；返回行列表。"""
    lines, buf = [], ""
    for ch in (text or "").replace("\n", ""):
        if d.textlength(buf + ch, font=font) <= max_w:
            buf += ch
        else:
            lines.append(buf)
            buf = ch
    if buf:
        lines.append(buf)
    return lines


def _block(d, text: str, font, max_w: int, max_lines: int, xy, fill, lh: int) -> int:
    """画一个截断文本块，返回下一行可用的 y。"""
    lines = _wrap(d, text, font, max_w)
    if len(lines) > max_lines:
        lines = lines[:max_lines]
        lines[-1] = lines[-1][:-1] + "…"
    x, y = xy
    for ln in lines:
        d.text((x, y), ln, font=font, fill=fill)
        y += lh
    return y


def _track(d, xy, text: str, font, fill, tracking: int = 4):
    """字距排版（栏目标签的小型大写字距感）；返回终点 x。"""
    x, y = xy
    for ch in text:
        d.text((x, y), ch, font=font, fill=fill)
        x += d.textlength(ch, font=font) + tracking
    return x


def _ttc_pair():
    """系统 NotoSansCJK ttc 双字重（ECS 免传输路线）：fontTools 定位 SC face index。
    ttc 是多语言合集，SC 字形与 NotoSansSC otf 同源（Source Han 同批母版）。
    返回 (regular_fn, bold_fn)；不可用返回 None（回落单字重，不炸）。"""
    try:
        from fontTools.ttLib import TTCollection
    except ImportError:
        return None
    from pathlib import Path
    base = Path("/usr/share/fonts/opentype/noto")
    reg, bold = base / "NotoSansCJK-Regular.ttc", base / "NotoSansCJK-Bold.ttc"
    if not (reg.is_file() and bold.is_file()):
        return None

    def _sc_index(path) -> int:
        try:
            for i, f in enumerate(TTCollection(str(path)).fonts):
                if (f["name"].getDebugName(4) or "").lower().endswith(" sc"):
                    return i
        except Exception:  # noqa: BLE001 — 定位失败退 index 0（jp 字形近似可用）
            pass
        return 0

    ri, bi = _sc_index(reg), _sc_index(bold)
    from PIL import ImageFont
    return ((lambda s: ImageFont.truetype(str(reg), s, index=ri)),
            (lambda s: ImageFont.truetype(str(bold), s, index=bi)))


def _font_pair():
    """加载双字重：DATA_DIR/fonts 里的 Noto pair 优先，系统 NotoSansCJK ttc 次之，
    最后退回 exporter 单字体。
    可用性判据恒为 exporter._font_path（None → LayoutError，503 契约不变）；
    pair 恒在 DATA_DIR/fonts 找——不随 base 字体落位漂移（本地 base=系统 simhei，
    ECS base=系统 Noto ttc，pair 统一由数据目录供给）。"""
    from .exporter import _font_path
    from PIL import ImageFont
    base = _font_path()
    if base is None:
        raise LayoutError("中文字体未配置（放置 TTF 到 data/qianwen/fonts/ 即启用）")
    from pathlib import Path
    reg = bold = base
    d = Path(config.DATA_DIR) / "fonts"
    r, b = d / "NotoSansSC-Regular.otf", d / "NotoSansSC-Bold.otf"
    if r.is_file() and b.is_file():
        reg, bold = r, b
        load = lambda p, s: ImageFont.truetype(str(p), s)  # noqa: E731
        return (lambda s: load(reg, s)), (lambda s: load(bold, s))
    pair = _ttc_pair()
    if pair is not None:
        return pair
    load = lambda p, s: ImageFont.truetype(str(p), s)  # noqa: E731
    return (lambda s: load(reg, s)), (lambda s: load(bold, s))


def build(question: str, bullets: list, qr_png: bytes | None,
          meta: dict | None = None) -> bytes:
    """渲染海报 PNG 字节。bullets=要点速览（≤3 条）；qr_png=None → 无码兜底；
    meta={"chars": 全文字数, "cites": 依据条数} → 中部数据行。"""
    try:
        from PIL import Image, ImageDraw
    except ImportError as exc:  # noqa: F401
        raise LayoutError("服务器未安装 Pillow") from exc
    fr, fb = _font_pair()

    f_brand = fb(40)
    f_meta_s = fr(20)
    f_label = fr(21)
    f_q = fb(46)
    f_bullet = fr(28)
    f_num = fb(30)
    f_unit = fr(23)
    f_cta = fb(42)
    f_cta_sub = fr(23)
    f_cap = fr(20)
    f_foot = fr(19)

    img = Image.new("RGB", (W, H), PAPER)
    d = ImageDraw.Draw(img)

    # ── 图纸边框 + 角部对位十字（制图身份；代替满版网格）──
    d.rectangle([24, 24, W - 24, H - 24], outline=GRID, width=2)
    for cx, cy in ((24, 24), (W - 24, 24), (24, H - 24), (W - 24, H - 24)):
        d.line([(cx - 12, cy), (cx + 12, cy)], fill=INK_SOFT, width=2)
        d.line([(cx, cy - 12), (cx, cy + 12)], fill=INK_SOFT, width=2)

    # ── 刊头：品牌 + 图签信息（工程图纸标题栏语汇；右侧两行收紧贴近规线）──
    d.text((M, 58), "总包AI顾问", font=f_brand, fill=NAVY)
    _today = date.today()
    d.text((W - M - d.textlength(_today.strftime("%Y.%m.%d"), font=f_meta_s), 60),
           _today.strftime("%Y.%m.%d"), font=f_meta_s, fill=INK_SOFT)
    d.text((W - M - d.textlength("SHT 01 · SCALE 1:1", font=f_meta_s), 86),
           "SHT 01 · SCALE 1:1", font=f_meta_s, fill=INK_SOFT)
    d.line([(M, 124), (W - M, 124)], fill=NAVY, width=3)

    # ── 问题主区（主角：Bold 46，最多 4 行）──
    d.rectangle([M, 172, M + 10, 182], fill=ORANGE)          # 橙 #1（与要点标同构）
    _track(d, (M + 26, 168), "工程咨询 · CONSULTATION", f_label, INK_SOFT, 5)
    q_end = _block(d, question or "工程咨询问题", f_q, W - M * 2, 4,
                   (M, 226), NAVY, 66)

    # ── 要点速览（锚点下限 520，短问题自然留白）──
    y_key = max(q_end + 52, 520)
    d.rectangle([M, y_key + 8, M + 10, y_key + 18], fill=NAVY)
    _track(d, (M + 26, y_key), "要点速览 · KEY POINTS", f_label, INK_SOFT, 5)
    y = y_key + 46
    for b in (bullets or [])[:3]:
        d.rectangle([M + 2, y + 15, M + 8, y + 21], fill=NAVY)
        y = _block(d, b, f_bullet, W - M * 2 - 34, 2, (M + 20, y), INK, 48) + 16

    # ── 数据行（单行内联排版，代替三格盒子；数字重/单位轻，留白作分隔）──
    y_meta = min(max(y + 30, 946), 976)
    d.line([(M, y_meta - 26), (W - M, y_meta - 26)], fill=HAIR, width=2)
    m = meta or {}

    def _num(v):
        return f"{v:,}" if isinstance(v, int) else str(v or "—")

    x = M
    for num, unit, last in ((_num(m.get("chars")), " 字全文", False),
                            (_num(m.get("cites")), " 条依据", False),
                            ("免费", "继续追问", True)):
        d.text((x, y_meta), num, font=f_num, fill=NAVY)
        x += d.textlength(num, font=f_num) + 4
        d.text((x, y_meta + 7), unit, font=f_unit, fill=INK_SOFT)
        if not last:
            x += d.textlength(unit, font=f_unit) + 44   # 组间距>词间距，三组各自成块

    # ── 行动卡（藏青大卡 = 版面锚；左文右码，两栏互不越界）──
    cy0 = 1016
    d.rounded_rectangle([56, cy0, W - 56, cy0 + 252], radius=24, fill=NAVY_DEEP)
    _track(d, (104, cy0 + 24), "免费开放 · FREE ACCESS", f_cap, ORANGE, 6)  # 橙 #2（眉标离 CTA 留一口气）
    d.text((104, cy0 + 64), "扫码读完整解答", font=f_cta, fill=WHITE)
    # v0.9.6（用户令 1009）：免费次数宣传行删除（页面/物料全域去免费次数文案，规则本身不变）
    d.text((104, cy0 + 132), "支持继续追问 · 同样免费", font=f_cta_sub, fill=MIST)
    # v0.9.5（1009 用户令「海报 AI 申明最多一次」）：行动卡区的短版申明删除——
    # 全海报只保留页脚合规全句（含「不构成正式法律意见」，标识位不变不弃合规）

    if qr_png:
        try:
            qr = Image.open(io.BytesIO(qr_png)).convert("RGB")
            qr = qr.resize((_QR_SIZE, _QR_SIZE), Image.LANCZOS)
            px, py = 454, cy0 + 18
            d.rounded_rectangle([px, py, px + _QR_SIZE + 24, py + _QR_SIZE + 24],
                                radius=14, fill=WHITE)
            img.paste(qr, (px + 12, py + 12))
            cap = "长按识别"
            d.text((px + 12 + (_QR_SIZE - d.textlength(cap, font=f_cap)) // 2,
                    py + _QR_SIZE + 30), cap, font=f_cap, fill=MIST)
        except Exception:  # noqa: BLE001 — 码贴失败不废海报
            qr_png = None
    if not qr_png:
        d.text((454, cy0 + 84), "微信搜一搜", font=f_cta_sub, fill=WHITE)
        d.text((454, cy0 + 116), "「总包AI顾问」", font=f_cta_sub, fill=ORANGE)

    # ── 页脚注记 + 底缘安全橙条（橙 #3；页脚离橙条/边框都留一口气）──
    d.text((M, 1276), "内容由 AI 生成 · 仅供参考，不构成正式法律意见",
           font=f_foot, fill=INK_SOFT)
    d.rectangle([0, H - 8, W, H], fill=ORANGE)

    out = io.BytesIO()
    img.save(out, format="PNG", optimize=True)
    return out.getvalue()
