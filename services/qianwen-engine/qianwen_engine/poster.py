# -*- coding: utf-8 -*-
"""分享海报（v0.9.8 转发欲重设计）：瑞士制图风编辑排版 + 解答摘录正文区。

用户令（1009）：「海报要让人愿意转发」+「除问题、要点外，显示约 200 字回复内容，
海报长度可以适当延长」——海报从「广告位」变成「干货本体」：
  - 新增 解答摘录区：完整解答开头连续段落（约 200 字），前两行加粗导语（报纸
    lead 段手法），左侧藏青竖线 = 文档引文身份，截断优先停在句末标点（读感完整）
  - 流式排版：各区块高度按内容实测流动（问题 1-4 行 / 要点 0-3 条 / 摘录
    7-10 行），画布高随之伸缩（1500-1850），短内容呼吸、长内容不挤
  - 行动卡瘦身（252→208px）：从版面主角退为收尾配角，内容成为主角
  - 设计语言不变：图纸边框+角十字 / 双字重字阶纪律 / 橙色仅三处
    （问题标度条、行动卡眉标、底缘安全条）/ AI 申明仅页脚一处
  - LAYOUT_VERSION 进海报缓存键（app.py 拼接）：版式改动自动失效旧缓存
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

W = 750                    # 画布宽（固定）
M = 72                     # 版心边距
H_MIN, H_MAX = 1500, 1850  # 画布高随内容伸缩区间（v0.9.8：摘录区入场；用户令允许加长）
_QR_SIZE = 160             # 小程序码贴片边长（430 源图缩放，保扫码清晰度）

LAYOUT_VERSION = "v4"      # 版式版本（进 app.py 海报缓存键：改版自动失效旧缓存）


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
          meta: dict | None = None, answer: str = "") -> bytes:
    """渲染海报 PNG 字节。bullets=要点速览（≤3 条）；answer=解答摘录（完整解答
    开头连续段落，约 200 字，空串则整区省略）；qr_png=None → 无码兜底；
    meta={"chars": 全文字数, "cites": 依据条数} → 数据行。
    v0.9.8 流式排版：各区高度按内容实测流动，画布高随内容伸缩（H_MIN-H_MAX），
    行动卡+页脚恒底锚——短内容呼吸留白，长内容不挤压。"""
    try:
        from PIL import Image, ImageDraw
    except ImportError as exc:  # noqa: F401
        raise LayoutError("服务器未安装 Pillow") from exc
    fr, fb = _font_pair()

    f_brand = fb(40)
    f_meta_s = fr(20)
    f_label = fr(21)
    f_num_s = fb(20)        # 要点台账序号 01/02/03
    f_q = fb(44)
    f_bullet = fr(27)
    f_bullet_b = fb(27)     # 要点锚词前缀（冒号前加粗——扫读锚点）
    f_lead = fb(28)           # 摘录导语（前两行加粗——报纸 lead 段手法）
    f_exc = fr(28)
    f_num = fb(30)
    f_unit = fr(23)
    f_cta = fb(40)
    f_cta_sub = fr(23)
    f_cap = fr(20)
    f_foot = fr(19)

    q = question or "工程咨询问题"
    bl = (bullets or [])[:3]
    exc_src = (answer or "").strip()
    m = meta or {}

    # ── 内容实测（先量后排：画布高与各区位置由内容行数决定）──
    meas = ImageDraw.Draw(Image.new("RGB", (8, 8)))
    q_all = _wrap(meas, q, f_q, W - M * 2)
    q_lines = q_all[:4]
    if len(q_all) > 4:
        q_lines[-1] = q_lines[-1][:-1] + "…"
    bl_lines = []
    for b in bl:
        b_all = _wrap(meas, b, f_bullet, W - M * 2 - 34)
        ln = b_all[:2]
        if len(b_all) > 2:
            ln[-1] = ln[-1][:-1] + "…"
        bl_lines.append(ln)
    exc_all = _wrap(meas, exc_src, f_lead, W - M * 2 - 26) if exc_src else []

    # 底部锚栈：行动卡 208 + 卡→页脚 56 + 页脚文字 26 + 页脚→底框 6 …
    # 页脚文字 H-56 起（文字底 H-30 < 底框线 H-24 < 橙条 H-8，互不压线）
    card_h, stack_bottom = 208, 320

    exc_max = 10
    while True:
        exc_lines = exc_all[:exc_max]
        q_bottom = 226 + len(q_lines) * 62
        y_key = q_bottom + 76              # 问题后大呼吸（hero 让位感）
        bullets_bottom = y_key + 46 + sum(len(ln) * 46 + 18 for ln in bl_lines)
        y_exc = (bullets_bottom if bl else q_bottom) + 42   # 要点紧接摘录=干货带
        exc_bottom = y_exc + 46 + len(exc_lines) * 46
        anchor = exc_bottom if exc_lines else (bullets_bottom if bl else q_bottom)
        meta_bottom = anchor + 48 + 40   # 发丝线上松下紧（数据行节奏）
        need = meta_bottom + 34 + stack_bottom
        if need <= H_MAX or exc_max <= 7 or not exc_lines:
            break
        exc_max -= 1                       # 超高时先减摘录行（底线 7 行保干货）
    H = max(need, H_MIN)
    cy0 = H - stack_bottom
    y_meta = cy0 - 34 - 40                 # 数据行数字基位（与 meta_bottom 对齐）
    foot_y = H - 56

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
    d.text((W - M - d.textlength("SHT 01 · OPEN ACCESS", font=f_meta_s), 92),
           "SHT 01 · OPEN ACCESS", font=f_meta_s, fill=INK_SOFT)
    d.line([(M, 124), (W - M, 124)], fill=NAVY, width=3)

    # ── 问题主区（主角：Bold 44，最多 4 行）──
    d.rectangle([M, 172, M + 10, 182], fill=ORANGE)          # 橙 #1（与栏目标同构）
    _track(d, (M + 26, 168), "工程咨询 · CONSULTATION", f_label, INK_SOFT, 5)
    yy = 226
    for ln in q_lines:
        d.text((M, yy), ln, font=f_q, fill=NAVY)
        yy += 62

    # ── 要点速览（台账体：序号 01/02/03 + 行间发丝线；无要点则整区省略）──
    if bl:
        d.rectangle([M, y_key + 8, M + 10, y_key + 18], fill=NAVY)
        _track(d, (M + 26, y_key), "要点速览 · KEY POINTS", f_label, INK_SOFT, 5)
        yy = y_key + 46
        for idx, ln in enumerate(bl_lines):
            d.text((M, yy + 4), f"{idx + 1:02d}", font=f_num_s, fill=NAVY)
            for sub in ln:
                # 锚词双字重：冒号前缀（结论：/依据：/操作：）加粗藏青——扫读锚点
                head, sep, tail = sub.partition("：")
                if sep and 2 <= len(head) <= 6:
                    d.text((M + 34, yy), head + sep, font=f_bullet_b, fill=NAVY)
                    hx = M + 34 + d.textlength(head + sep, font=f_bullet_b)
                    d.text((hx, yy), tail, font=f_bullet, fill=INK)
                else:
                    d.text((M + 34, yy), sub, font=f_bullet, fill=INK)
                yy += 46
            yy += 18
            if idx < len(bl_lines) - 1:
                d.line([(M, yy - 9), (W - M, yy - 9)], fill=HAIR, width=1)

    # ── 解答摘录（v0.9.8 灵魂区：正文即干货；前两行加粗导语+藏青引文线）──
    if exc_lines:
        d.rectangle([M, y_exc + 8, M + 10, y_exc + 18], fill=NAVY)
        _track(d, (M + 26, y_exc), "解答摘录 · ANSWER EXCERPT", f_label, INK_SOFT, 5)
        _src_note = "摘自完整解答"
        d.text((W - M - d.textlength(_src_note, font=f_cap), y_exc),
               _src_note, font=f_cap, fill=INK_SOFT)
        shown = exc_lines[:]
        if len(exc_all) > len(exc_lines):
            # 截断收口：回退到已展示文本内最后一个句末标点（话说完整=专业严谨，
            # 不在逗号上吊悬念）；整段无句读才退分句标点；仍无则省略号
            joined = "".join(shown)
            cut = max(joined.rfind(p) for p in "。！？")
            if cut < 4:
                cut = max(joined.rfind(p) for p in "；：，、")
            if cut >= 4:
                shown = _wrap(d, joined[:cut + 1], f_lead, W - M * 2 - 26)
                if len(shown) > 1 and len(shown[-1]) <= 2:   # 孤字行（「。」独占行）并回上行
                    shown[-2] += shown[-1]
                    shown.pop()
            else:
                shown[-1] = shown[-1][:-1] + "……"
        body_top = y_exc + 46
        d.line([(M, body_top + 8), (M, body_top + len(shown) * 46 - 10)],
               fill=NAVY, width=3)
        yy = body_top
        for i, ln in enumerate(shown):
            d.text((M + 26, yy), ln, font=(f_lead if i < 2 else f_exc), fill=INK)
            yy += 46

    # ── 数据行（单行内联排版：数字重/单位轻，留白作分隔）──
    d.line([(M, y_meta - 26), (W - M, y_meta - 26)], fill=HAIR, width=2)

    def _num(v):
        return f"{v:,}" if isinstance(v, int) else str(v or "—")

    x = M
    for num, unit, last in ((_num(m.get("chars")), " 字全文", False),
                            (_num(m.get("cites")), " 条依据", False),
                            ("支持", "继续追问", True)):
        d.text((x, y_meta), num, font=f_num, fill=NAVY)
        x += d.textlength(num, font=f_num) + 4
        d.text((x, y_meta + 7), unit, font=f_unit, fill=INK_SOFT)
        if not last:
            x += d.textlength(unit, font=f_unit) + 44   # 组间距>词间距，三组各自成块

    # ── 行动卡（藏青收尾卡；左文右码，两栏互不越界）──
    d.rounded_rectangle([56, cy0, W - 56, cy0 + card_h], radius=24, fill=NAVY_DEEP)
    _track(d, (104, cy0 + 22), "长按识别 · SCAN TO READ", f_cap, ORANGE, 6)  # 橙 #2
    d.text((104, cy0 + 56), "扫码读完整解答", font=f_cta, fill=WHITE)
    # v0.9.6（用户令 1009）：免费次数宣传行不回潮（规则不变，文字全域下线）
    # v0.9.5（1009 用户令「海报 AI 申明最多一次」）：行动卡短版申明不回潮——
    # 全海报只保留页脚合规全句（含「不构成正式法律意见」，标识位不变不弃合规）
    d.text((104, cy0 + 120), "支持继续追问 · 解答更完整", font=f_cta_sub, fill=MIST)

    if qr_png:
        try:
            qr = Image.open(io.BytesIO(qr_png)).convert("RGB")
            qr = qr.resize((_QR_SIZE, _QR_SIZE), Image.LANCZOS)
            px, py = 462, cy0 + 12
            d.rounded_rectangle([px, py, px + _QR_SIZE + 24, py + _QR_SIZE + 24],
                                radius=14, fill=WHITE)
            img.paste(qr, (px + 12, py + 12))
        except Exception:  # noqa: BLE001 — 码贴失败不废海报
            qr_png = None
    if not qr_png:
        d.text((462, cy0 + 64), "微信搜一搜", font=f_cta_sub, fill=WHITE)
        d.text((462, cy0 + 96), "「总包AI顾问」", font=f_cta_sub, fill=ORANGE)

    # ── 页脚注记 + 底缘安全橙条（橙 #3；页脚文字在底框线内，离橙条留一口气）──
    d.text((M, foot_y), "内容由 AI 生成 · 仅供参考，不构成正式法律意见",
           font=f_foot, fill=INK_SOFT)
    d.rectangle([0, H - 8, W, H], fill=ORANGE)

    out = io.BytesIO()
    img.save(out, format="PNG", optimize=True)
    return out.getvalue()
