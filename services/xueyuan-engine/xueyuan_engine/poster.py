# -*- coding: utf-8 -*-
"""情报卡海报域 [P1]——PIL 生成 1080×1440 + scene 短码机制 + poster_code/share_event 落表。

服务端生成三理由（KNOWLEDGE_BASE/viral_poster §2）：千机一面/模板改不发版/码可预生成。
四分区（§6 方法论）：封面块(顶部≈40%) → 最狠 1 数据大字+1 句结论(中部) → 品牌条(底部)
→ 小程序码右下规范位+「长按识别 免费读前 20 页」。海报只含标题/摘要级元素，
绝不含付费正文（防泄漏红线同引擎按权益下发纪律）。
小程序码只从预生成池取（tools/qr_pool.py --live 灌池；getUnlimited 限频 5000 次/分，
官方建议预生成）——运行时零实时微信调用；池未灌→占位框明确降级，绝不出乱码图。
invite_relation 归因主表属 E1 域：本域只产出 scene_code+映射（lookup_code 供其
/invite/scan 解短码用），不写该表；scene 解析失败降级 None（免费兜底优先于归因）。
"""
from __future__ import annotations

import json
import logging
import os
import re
import secrets
import tempfile
import urllib.parse
from io import BytesIO
from pathlib import Path

from fastapi import APIRouter, Request
from fastapi.responses import FileResponse, Response
from PIL import Image, ImageDraw, ImageFont
from pydantic import BaseModel

from . import config, store, wechat
from .catalog import get_report
from .errors import ApiError

router = APIRouter(tags=["poster"])

logger = logging.getLogger("xueyuan.poster")

# scene 官方字符集（getUnlimited 契约：数字+大小写英文+!#$&'()*+,/:;=?@-._~，无 %）
SCENE_CHARSET = set(
    "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!#$&'()*+,/:;=?@-._~"
)
_SCENE_OFFICIAL_MAX = 32   # 官方硬上限（parse_scene 判据；溢出门径用 config.POSTER_SCENE_MAX）
_B62 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
_CHANNELS = ("poster", "session", "moments")   # share_event.channel 词表（SCHEMAS §11）
_SAFE_PNG = re.compile(r"[A-Za-z0-9_-]+\.png")  # 海报文件名白名单（防路径穿越）


# ── scene 机制（直拼优先，溢出短码；解析失败降级 None）──────────────────
def parse_scene(scene: object, code_lookup=None):
    """纯函数：scene → (report_id, inviter_uid|None)；解析失败 None（免费兜底优先于归因）。

    直拼 'r=短ID&i=短ID' 纯解析；'s=短码' 经 code_lookup 回调还原（DB 查询由
    调用方注入——E1 的 /invite/scan 传 poster.lookup_code；查不到同样 None 降级）。
    判据全按官方契约：≤32 可见字符+合法字符集（% 非法）。
    """
    if not isinstance(scene, str):
        return None
    s = scene.strip()
    if not s or len(s) > _SCENE_OFFICIAL_MAX:
        return None
    if any(ch not in SCENE_CHARSET for ch in s):
        return None
    if s.startswith("s="):
        return code_lookup(s) if code_lookup else None
    params: dict[str, str] = {}
    for part in s.split("&"):
        k, sep, v = part.partition("=")
        if not sep or k not in ("r", "i") or not v or k in params:
            return None
        params[k] = v
    rid = params.get("r")
    return (rid, params.get("i")) if rid else None


def parse_card_scene(scene: object, code_lookup=None):
    """纯函数：卡 scene 'c=<card_id>&i=<uid>' → (card_id, inviter_uid|None)。

    报告码 parse_scene 的卡码兄弟版（官方契约同判据：≤32 可见字符+合法字符集，
    键白名单 c/i、不可重复、c= 必带）；**不做卡数据反查**——card_id→report_id
    的反查归 cards 索引层（invite.parse_scene 注入），本函数保持纯解析。
    非法返回 None（免费兜底优先于归因，同 scan 降级哲学）。
    """
    if not isinstance(scene, str):
        return None
    s = scene.strip()
    if not s or len(s) > _SCENE_OFFICIAL_MAX:
        return None
    if any(ch not in SCENE_CHARSET for ch in s):
        return None
    if s.startswith("s="):
        return code_lookup(s) if code_lookup else None
    params: dict[str, str] = {}
    for part in s.split("&"):
        k, sep, v = part.partition("=")
        if not sep or k not in ("c", "i") or not v or k in params:
            return None
        params[k] = v
    cid = params.get("c")
    return (cid, params.get("i")) if cid else None


def scene_legal(scene: str) -> bool:
    """直拼 scene 可用判据：≤config.POSTER_SCENE_MAX 且全字符在官方合法集。"""
    return 0 < len(scene) <= config.POSTER_SCENE_MAX and all(ch in SCENE_CHARSET for ch in scene)


def ensure_scene(rid: str, uid: str, channel: str = "poster") -> str:
    """产出归因 scene：直拼 r=..&i=.. 优先，超限/非法自动落 poster_code 短码（幂等）。"""
    direct = f"r={rid}&i={uid}"
    if scene_legal(direct):
        _insert_code(direct, rid, uid, channel, 0)
        return direct
    return _alloc_short_code(rid, uid, channel)


def lookup_code(scene_code: str):
    """poster_code 映射还原（parse_scene 的 code_lookup 注入件；查不到 None=降级）。"""
    with store._db() as c:
        row = c.execute(
            "SELECT report_id,inviter_uid FROM poster_code WHERE scene_code=?",
            (scene_code,)).fetchone()
    if not row or not row["report_id"]:
        return None
    return (row["report_id"], row["inviter_uid"] or None)


def _insert_code(scene_code: str, rid: str, uid: str, channel: str, pregenerated: int) -> None:
    with store._LOCK, store._db() as c:
        c.execute(
            "INSERT OR IGNORE INTO poster_code(scene_code,report_id,inviter_uid,channel,"
            "poster_version,pregenerated,created_at) VALUES(?,?,?,?,?,?,?)",
            (scene_code, rid, uid, channel, config.POSTER_VERSION, pregenerated, store.now()),
        )


def _alloc_short_code(rid: str, uid: str, channel: str) -> str:
    """溢出兜底：s=+8 位 Base62 随机短码（62^8 空间，撞库重试兜底）。

    (report,inviter) 已有短码先复用——短码是归因键，一人一报告一枚
    （ensure_scene 幂等语义；同 cards.ensure_card_code 口径。首版漏查复用，
    每次请求新掷一枚：码池永不命中+表无界膨胀，生产码池首灌实锤）。"""
    with store._db() as c:
        row = c.execute(
            "SELECT scene_code FROM poster_code WHERE report_id=? AND inviter_uid=?"
            " AND scene_code LIKE 's=%' LIMIT 1",
            (rid, uid)).fetchone()
        if row:
            return row["scene_code"]
    for _ in range(8):
        code = "s=" + "".join(secrets.choice(_B62) for _ in range(8))
        with store._LOCK, store._db() as c:
            cur = c.execute(
                "INSERT OR IGNORE INTO poster_code(scene_code,report_id,inviter_uid,channel,"
                "poster_version,pregenerated,created_at) VALUES(?,?,?,?,?,1,?)",
                (code, rid, uid, channel, config.POSTER_VERSION, store.now()),
            )
            if cur.rowcount == 1:
                return code
    raise ApiError(500, "POSTER_CODE_EXHAUSTED", "短码分配失败，请重试")


def qr_pool_path(scene: str) -> Path:
    """码池文件位：文件名=quote(scene)（&/= URL 安全化进文件名；qr_pool.py 同口径）。"""
    return config.POSTER_QR_DIR / (urllib.parse.quote(scene, safe="") + ".png")


def record_share(uid: str, rid: str, channel: str = "poster",
                 version: str | None = None) -> None:
    """分享行为落 share_event（谁在何时分享了哪份研报的哪版海报，SCHEMAS §11）。"""
    with store._LOCK, store._db() as c:
        c.execute(
            "INSERT INTO share_event(id,user_id,report_id,channel,poster_version,ts)"
            " VALUES(?,?,?,?,?,?)",
            ("sh" + secrets.token_hex(8), uid, rid, channel,
             version or config.POSTER_VERSION, store.now()),
        )


# ── 文案数据（只读 report 行+sidecar 覆写，绝不含付费正文）──────────────
def _sidecar(rid: str) -> dict:
    """per-report 文案覆写：content/reports/<id>/poster.json（运营可改，改文案不发版）。"""
    f = config.CONTENT_DIR / "reports" / rid / "poster.json"
    if not f.exists():
        return {}
    try:
        d = json.loads(f.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return {}
    return d if isinstance(d, dict) else {}


def poster_content(report: dict) -> dict:
    """海报文案五件套（「最狠 1 数据」优先 sidecar，缺省由 chapter_count 推导）。"""
    over = _sidecar(str(report.get("id") or ""))
    title = str(report.get("title") or report.get("id") or "")
    stat = str(over.get("hero_stat") or f"{report.get('chapter_count') or 0}章")
    caption = str(over.get("hero_caption") or "一手数据 · 章章可执行")
    first = re.split(r"[。．;；\n]", str(report.get("summary") or ""))[0].split("——")[0].strip()
    conclusion = str(
        over.get("conclusion") or (first if first and first != title else "")
        or "拆解区域工程商机与切入策略，读完直接进决策")
    meta = " · ".join(p for p in (
        str(report.get("source") or ""),
        f"{report.get('province') or ''}{report.get('industry') or ''}".strip(),
        f"{report.get('chapter_count') or 0}章",
    ) if p)
    return {"title": title, "hero_stat": stat, "hero_caption": caption,
            "conclusion": conclusion, "meta": meta}


# ── 模板与渲染（改模板不发版：改 TEMPLATE→升 config.POSTER_VERSION 即可）──
TEMPLATE = {  # 版式常量（四分区：封面/大字+结论/品牌条/码位右下）
    "bg": (246, 247, 249), "navy": (17, 58, 102), "navy_meta": (201, 216, 236),
    "amber": (240, 169, 59), "amber_light": (247, 203, 120),
    "ink": (42, 53, 66), "gray": (90, 107, 127),
    "margin": 72, "cover_h": 600,
    "chip": ("总包学园 · 商机情报卡", 34),
    "title_size": 84, "title_leading": 1.22, "title_top": 176, "title_lines": 3,
    "meta_size": 36,
    "stat_top": 648, "stat_size": 200, "stat_unit_size": 96, "stat_alt_size": 110,
    "caption_top": 900, "caption_size": 46,
    "concl_top": 976, "concl_size": 44, "concl_leading": 1.34, "concl_lines": 2,
    "strip_top": 1104, "strip_bottom": 56,
    "qr_size": 240, "qr_pad": 20,
    "brand_size": 48, "brand_sub_size": 32, "cta_size": 38,
}


class _FontKit:
    """字体套装（按 size 惶加载缓存；路径缺失=明确报错降级，绝不出豆腐块图）。"""

    def __init__(self) -> None:
        self._cache: dict[tuple[str, int], ImageFont.FreeTypeFont] = {}

    def regular(self, size: int) -> ImageFont.FreeTypeFont:
        return self._get(config.POSTER_FONT_REGULAR, size)

    def bold(self, size: int) -> ImageFont.FreeTypeFont:
        return self._get(config.POSTER_FONT_BOLD, size)

    def _get(self, path: Path, size: int) -> ImageFont.FreeTypeFont:
        key = (str(path), size)
        if key not in self._cache:
            if not Path(path).exists():
                raise ApiError(500, "POSTER_FONT_MISSING",
                               "海报字体未部署（assets/fonts），请补齐后重试")
            self._cache[key] = ImageFont.truetype(str(path), size)
        return self._cache[key]


def _wrap(d: ImageDraw.ImageDraw, text: str, font, max_w: int) -> list[str]:
    """CJK 逐字折行（无空格分词的诚实兜底；返回至少一行）。"""
    lines: list[str] = []
    cur = ""
    for ch in text:
        if not cur or d.textlength(cur + ch, font=font) <= max_w:
            cur += ch
        else:
            lines.append(cur)
            cur = ch
    if cur:
        lines.append(cur)
    return lines or [""]


def _ellipsize(lines: list[str], limit: int) -> list[str]:
    shown = lines[:limit]
    if len(lines) > limit and shown:
        shown[-1] = shown[-1][:-1] + "…"
    return shown


def _draw_cover(img: Image.Image, d: ImageDraw.ImageDraw, content: dict, kit: _FontKit,
                t: dict) -> None:
    W = config.POSTER_WIDTH
    d.rectangle([0, 0, W, t["cover_h"]], fill=t["navy"])
    ov = Image.new("RGBA", img.size, (0, 0, 0, 0))       # 封面软装饰（半透明需合成层）
    od = ImageDraw.Draw(ov)
    od.ellipse([W - 340, -180, W + 140, 300], fill=(255, 255, 255, 16))
    od.ellipse([-200, t["cover_h"] - 200, 240, t["cover_h"] + 240], fill=t["amber"] + (30,))
    img.paste(Image.alpha_composite(img.convert("RGBA"), ov).convert("RGB"), (0, 0))
    label, csize = t["chip"]
    f = kit.bold(csize)
    x0, y0 = t["margin"], 64
    d.rounded_rectangle([x0, y0, x0 + d.textlength(label, font=f) + 48, y0 + 62],
                        radius=31, fill=(40, 82, 128))
    d.text((x0 + 24, y0 + 31), label, font=f, fill="white", anchor="lm")
    f = kit.bold(t["title_size"])
    y = t["title_top"]
    for ln in _ellipsize(_wrap(d, content["title"], f, W - 2 * t["margin"]), t["title_lines"]):
        d.text((t["margin"], y), ln, font=f, fill="white")
        y += int(t["title_size"] * t["title_leading"])
    f = kit.regular(t["meta_size"])
    meta = _ellipsize(_wrap(d, content["meta"], f, W - 2 * t["margin"]), 1)[0]
    d.text((t["margin"], t["cover_h"] - 88), meta, font=f, fill=t["navy_meta"])


def _draw_hero(d: ImageDraw.ImageDraw, content: dict, kit: _FontKit, t: dict) -> None:
    x = t["margin"] + 48
    d.rectangle([t["margin"], t["stat_top"] - 8, t["margin"] + 12, t["stat_top"] + 190],
                fill=t["amber"])
    stat = content["hero_stat"]
    m = re.match(r"^([0-9][0-9.,]*)\s*(\S{0,4})$", stat)
    if m and m.group(1):
        head, unit = m.group(1), m.group(2)
        fb, fu = kit.bold(t["stat_size"]), kit.bold(t["stat_unit_size"])
        baseline = t["stat_top"] + fb.getmetrics()[0]     # 数字与单位共用基线
        d.text((x, baseline), head, font=fb, fill=t["navy"], anchor="ls")
        if unit:
            d.text((x + d.textlength(head, font=fb) + 12, baseline), unit,
                   font=fu, fill=t["navy"], anchor="ls")
    else:
        d.text((x, t["stat_top"]), stat[:10], font=kit.bold(t["stat_alt_size"]), fill=t["navy"])
    d.text((x, t["caption_top"]), content["hero_caption"],
           font=kit.regular(t["caption_size"]), fill=t["gray"])


def _draw_conclusion(d: ImageDraw.ImageDraw, content: dict, kit: _FontKit, t: dict) -> None:
    W = config.POSTER_WIDTH
    f = kit.regular(t["concl_size"])
    lines = _ellipsize(_wrap(d, content["conclusion"], f, W - 2 * t["margin"]), t["concl_lines"])
    line_h = int(t["concl_size"] * t["concl_leading"])
    d.rectangle([t["margin"], t["concl_top"], t["margin"] + 12,
                 t["concl_top"] + line_h * len(lines)], fill=t["amber"])
    y = t["concl_top"] - int(t["concl_size"] * 0.28)
    for ln in lines:
        d.text((t["margin"] + 48, y), ln, font=f, fill=t["ink"])
        y += line_h


def _draw_qr_placeholder(d: ImageDraw.ImageDraw, x: int, y: int, s: int, kit: _FontKit) -> None:
    """码池未灌的明确占位（降级可见可诊断，绝不冒充真码）。"""
    d.rectangle([x, y, x + s, y + s], fill=(238, 240, 243), outline=(196, 202, 210), width=2)
    d.text((x + s // 2, y + s // 2 - 28), "小程序码位", font=kit.bold(34),
           fill=(150, 158, 168), anchor="mm")
    d.text((x + s // 2, y + s // 2 + 18), "（码池未灌）", font=kit.regular(24),
           fill=(150, 158, 168), anchor="mm")


def _draw_strip(img: Image.Image, d: ImageDraw.ImageDraw, kit: _FontKit, t: dict,
                qr_bytes: bytes | None) -> None:
    W, H = config.POSTER_WIDTH, config.POSTER_HEIGHT
    d.rectangle([0, t["strip_top"], W, H], fill=t["navy"])
    size, pad = t["qr_size"], t["qr_pad"]
    box = size + 2 * pad                                  # 右下规范位（行业惯例+留白）
    bx1, by1 = W - t["margin"] - box, H - t["strip_bottom"] - box
    d.rounded_rectangle([bx1, by1, bx1 + box, by1 + box], radius=24, fill="white")
    if qr_bytes:
        with Image.open(BytesIO(qr_bytes)) as q:
            img.paste(q.convert("RGB").resize((size, size), Image.LANCZOS),
                      (bx1 + pad, by1 + pad))
    else:
        _draw_qr_placeholder(d, bx1 + pad, by1 + pad, size, kit)
    d.text((t["margin"], t["strip_top"] + 44), config.POSTER_BRAND,
           font=kit.bold(t["brand_size"]), fill="white")
    d.text((t["margin"], t["strip_top"] + 116), config.POSTER_BRAND_SUB,
           font=kit.regular(t["brand_sub_size"]), fill=t["navy_meta"])
    d.text((t["margin"], t["strip_top"] + 174), config.POSTER_CTA,
           font=kit.bold(t["cta_size"]), fill=t["amber_light"])


def render_poster(report: dict, qr_bytes: bytes | None) -> Image.Image:
    """合成 1080×1440 情报卡（四分区；模板=TEMPLATE 常量，改版式升 POSTER_VERSION）。"""
    kit = _FontKit()
    t = TEMPLATE
    content = poster_content(report)
    img = Image.new("RGB", (config.POSTER_WIDTH, config.POSTER_HEIGHT), t["bg"])
    d = ImageDraw.Draw(img)
    _draw_cover(img, d, content, kit, t)
    _draw_hero(d, content, kit, t)
    _draw_conclusion(d, content, kit, t)
    _draw_strip(img, d, kit, t, qr_bytes)
    return img


def _render_to_file(report: dict, scene: str, dst: Path) -> None:
    """出图落 data 目录（码池命中读池文件；临时文件+原子替换防并发写坏）。"""
    qr = qr_pool_path(scene)
    qr_bytes = qr.read_bytes() if qr.exists() else None
    img = render_poster(report, qr_bytes)
    dst.parent.mkdir(parents=True, exist_ok=True)
    fd, tmp = tempfile.mkstemp(dir=dst.parent, suffix=".tmp")
    os.close(fd)
    try:
        img.save(tmp, format="PNG")
        os.replace(tmp, dst)
    finally:
        if os.path.exists(tmp):
            os.unlink(tmp)


# ── 端点（API_DESIGN P1-6；海报图直出无鉴权：分享物料无付费正文）────────
@router.get("/api/v1/poster/{rid}")
def get_poster(rid: str, request: Request, channel: str = "poster"):
    """P1-6 情报卡（Bearer）：合成/复用 (user,report,version) 缓存图+落 share_event。"""
    openid = wechat.bearer_openid(request)
    if not openid:
        raise ApiError(401, "UNAUTHORIZED", "未登录或凭证过期")
    if channel not in _CHANNELS:
        raise ApiError(400, "INVALID_PARAM", "channel 仅支持 poster|session|moments")
    uid = store.get_or_create_user(openid)["id"]
    report = get_report(rid)
    if not report:
        raise ApiError(404, "REPORT_NOT_FOUND", "报告不存在或已下架")
    scene = ensure_scene(rid, uid, channel)
    version = config.POSTER_VERSION
    name = f"{rid}_{uid}_{version}.png"
    if not (config.POSTER_DIR / name).exists():
        _render_to_file(report, scene, config.POSTER_DIR / name)
    record_share(uid, rid, channel, version)   # 取海报即分享行为（channel 分海报/会话/朋友圈）
    return {
        "poster_url": f"/posters/{name}",
        "width": config.POSTER_WIDTH,
        "height": config.POSTER_HEIGHT,
        "scene_code": scene,
        "poster_version": version,
    }


@router.get("/posters/{name}")
def poster_file(name: str):
    """海报图直出（无鉴权：<image> 标签带不了 Bearer；物料只含标题/摘要级元素）。"""
    if not _SAFE_PNG.fullmatch(name):
        raise ApiError(404, "POSTER_NOT_FOUND", "海报不存在")
    p = config.POSTER_DIR / name
    if not p.is_file():
        raise ApiError(404, "POSTER_NOT_FOUND", "海报不存在")
    return FileResponse(p, media_type="image/png")


# ── 卡海报域（w3a-2-E；仅文件末尾追加段）──────────────────────────────
# 卡二维码 scene 冻结格式 c=<card_id>&i=<uid>（parse_card_scene 纯解析）；QR 只从
# 预生成码池取（同报告海报纪律：运行时零实时微信调用，qr_pool.py --page
# pages/cards/detail 灌池），码字节按 (card_id,uid)≡scene 磁盘复用。⚠ 已知边界：
# 卡 scene=5+len(card_id)+11，card_id>16 字符即超官方 32 上限且卡无短码通道——
# 超限场景明确占位降级+告警（不留乱码图），短码映射属后续切片。
CARD_TEMPLATE = {  # 卡版式常量（品牌头/title/金额大字/属性行/摘要/底部码条）
    "bg": (246, 247, 249), "navy": (17, 58, 102), "navy_meta": (201, 216, 236),
    "amber": (240, 169, 59), "amber_light": (247, 203, 120),
    "ink": (42, 53, 66), "gray": (90, 107, 127),
    "margin": 72, "head_h": 208,
    "chip": ("总包学园 · 商机情报", 38),
    "title_size": 76, "title_leading": 1.24, "title_top": 268, "title_lines": 3,
    "hero_top": 600, "hero_size": 150, "hero_unit_size": 84, "hero_alt_size": 96,
    "hero_caption_top": 792, "hero_caption_size": 42,
    "attrs_top": 880, "attrs_size": 40,
    "sum_top": 960, "sum_size": 40, "sum_leading": 1.4, "sum_lines": 2,
    "strip_top": 1104, "strip_bottom": 56,
    "qr_size": 240, "qr_pad": 20,
    "brand_size": 48, "brand_sub_size": 32, "cta_size": 38,
}


def card_scene(card_id: str, uid: str) -> str:
    """卡归因 scene（冻结格式；不做合法性兜底——超限由取码层降级占位）。"""
    return f"c={card_id}&i={uid}"


def _card_qr_bytes(card_id: str, uid: str) -> bytes | None:
    """卡码字节：码池命中读文件（(card_id,uid)≡scene 磁盘复用）；未灌→None。

    scene=直拼 c= 合法优先，超限自动落 cards.ensure_card_code 短码（真实卡
    3104/3104 直拼超 32 上限的根治通道，与报告码 poster_code 溢出对称）。
    """
    from . import cards as _cards  # 局部导入防环（cards→poster 顶层链）
    scene = _cards.card_qr_scene(card_id, uid)
    if not scene or not scene_legal(scene):
        logger.warning("卡 scene 不可用（短码分配失败/非法），占位降级（card_id=%s uid=%s）",
                       card_id, uid)
        return None
    p = qr_pool_path(scene)
    try:
        return p.read_bytes() if p.exists() else None
    except OSError:
        return None


def card_poster_content(card: dict) -> dict:
    """卡海报文案六件套（stage 占位 '-' 归一为空；amount 原样）。"""
    stage = str(card.get("stage") or "").strip()
    return {
        "title": str(card.get("title") or ""),
        "amount": str(card.get("amount") or ""),
        "province": str(card.get("province") or ""),
        "stage": "" if stage == "-" else stage,
        "owner": str(card.get("owner") or ""),
        "window": str(card.get("window") or ""),
        "summary": str(card.get("summary") or ""),
    }


def _draw_card_head(img: Image.Image, d: ImageDraw.ImageDraw, kit: _FontKit, t: dict) -> None:
    """品牌头「总包学园 · 商机情报」navy 带+软装饰（同封面装饰手法）。"""
    W = config.POSTER_WIDTH
    d.rectangle([0, 0, W, t["head_h"]], fill=t["navy"])
    ov = Image.new("RGBA", img.size, (0, 0, 0, 0))
    od = ImageDraw.Draw(ov)
    od.ellipse([W - 320, -170, W + 130, 280], fill=(255, 255, 255, 16))
    od.ellipse([-190, t["head_h"] - 170, 210, t["head_h"] + 190], fill=t["amber"] + (30,))
    img.paste(Image.alpha_composite(img.convert("RGBA"), ov).convert("RGB"), (0, 0))
    label, csize = t["chip"]
    f = kit.bold(csize)
    x0, y0 = t["margin"], 64
    d.rounded_rectangle([x0, y0, x0 + d.textlength(label, font=f) + 48, y0 + 62],
                        radius=31, fill=(40, 82, 128))
    d.text((x0 + 24, y0 + 31), label, font=f, fill="white", anchor="lm")


def _draw_card_hero(d: ImageDraw.ImageDraw, c: dict, kit: _FontKit, t: dict) -> None:
    """金额大字（数字+单位共用基线，同报告 hero 手法）；空金额→province+stage 大字。"""
    x = t["margin"] + 48
    d.rectangle([t["margin"], t["hero_top"] - 8, t["margin"] + 12, t["hero_top"] + 150],
                fill=t["amber"])
    if c["amount"]:
        m = re.match(r"^([0-9][0-9.,]*)\s*(\S{0,4})$", c["amount"])
        if m and m.group(1):
            head, unit = m.group(1), m.group(2)
            fb, fu = kit.bold(t["hero_size"]), kit.bold(t["hero_unit_size"])
            baseline = t["hero_top"] + fb.getmetrics()[0]
            d.text((x, baseline), head, font=fb, fill=t["navy"], anchor="ls")
            if unit:
                d.text((x + d.textlength(head, font=fb) + 12, baseline), unit,
                       font=fu, fill=t["navy"], anchor="ls")
        else:
            d.text((x, t["hero_top"]), c["amount"][:12],
                   font=kit.bold(t["hero_alt_size"]), fill=t["navy"])
        caption = "项目投资金额"
    else:
        hero = " · ".join(p for p in (c["province"], c["stage"]) if p) or c["province"]
        d.text((x, t["hero_top"]), hero[:12], font=kit.bold(t["hero_alt_size"]),
               fill=t["navy"])
        caption = "商机区域与推进阶段"
    d.text((x, t["hero_caption_top"]), caption,
           font=kit.regular(t["hero_caption_size"]), fill=t["gray"])


def _draw_card_attrs(d: ImageDraw.ImageDraw, c: dict, kit: _FontKit, t: dict) -> None:
    """属性行：业主/阶段/窗口（空值略过；整行单行省略）。"""
    W = config.POSTER_WIDTH
    f = kit.regular(t["attrs_size"])
    line = " · ".join(p for p in (
        f"业主 {c['owner']}" if c["owner"] else "",
        f"阶段 {c['stage']}" if c["stage"] else "",
        f"窗口 {c['window']}" if c["window"] else "",
    ) if p) or f"区域 {c['province']}"
    d.text((t["margin"], t["attrs_top"]),
           _ellipsize(_wrap(d, line, f, W - 2 * t["margin"]), 1)[0],
           font=f, fill=t["gray"])


def _draw_card_summary(d: ImageDraw.ImageDraw, c: dict, kit: _FontKit, t: dict) -> None:
    W = config.POSTER_WIDTH
    f = kit.regular(t["sum_size"])
    lines = _ellipsize(_wrap(d, c["summary"], f, W - 2 * t["margin"] - 48), t["sum_lines"])
    line_h = int(t["sum_size"] * t["sum_leading"])
    d.rectangle([t["margin"], t["sum_top"], t["margin"] + 12,
                 t["sum_top"] + line_h * len(lines)], fill=t["amber"])
    y = t["sum_top"] - int(t["sum_size"] * 0.28)
    for ln in lines:
        d.text((t["margin"] + 48, y), ln, font=f, fill=t["ink"])
        y += line_h


def _draw_card_strip(img: Image.Image, d: ImageDraw.ImageDraw, kit: _FontKit, t: dict,
                     qr_bytes: bytes | None) -> None:
    """底部品牌条+码位（同报告 strip 版式，CTA 换卡文案）。"""
    W, H = config.POSTER_WIDTH, config.POSTER_HEIGHT
    d.rectangle([0, t["strip_top"], W, H], fill=t["navy"])
    size, pad = t["qr_size"], t["qr_pad"]
    box = size + 2 * pad
    bx1, by1 = W - t["margin"] - box, H - t["strip_bottom"] - box
    d.rounded_rectangle([bx1, by1, bx1 + box, by1 + box], radius=24, fill="white")
    if qr_bytes:
        with Image.open(BytesIO(qr_bytes)) as q:
            img.paste(q.convert("RGB").resize((size, size), Image.LANCZOS),
                      (bx1 + pad, by1 + pad))
    else:
        _draw_qr_placeholder(d, bx1 + pad, by1 + pad, size, kit)
    d.text((t["margin"], t["strip_top"] + 44), config.POSTER_BRAND,
           font=kit.bold(t["brand_size"]), fill="white")
    d.text((t["margin"], t["strip_top"] + 116), config.POSTER_BRAND_SUB,
           font=kit.regular(t["brand_sub_size"]), fill=t["navy_meta"])
    d.text((t["margin"], t["strip_top"] + 174), config.CARD_POSTER_CTA,
           font=kit.bold(t["cta_size"]), fill=t["amber_light"])


def render_card_poster(card: dict, qr_bytes: bytes | None) -> Image.Image:
    """合成竖版卡海报（六分区：品牌头/title/金额大字/属性行/摘要/码条）。"""
    kit = _FontKit()
    t = CARD_TEMPLATE
    c = card_poster_content(card)
    W = config.POSTER_WIDTH
    img = Image.new("RGB", (W, config.POSTER_HEIGHT), t["bg"])
    d = ImageDraw.Draw(img)
    _draw_card_head(img, d, kit, t)
    f = kit.bold(t["title_size"])
    y = t["title_top"]
    for ln in _ellipsize(_wrap(d, c["title"], f, W - 2 * t["margin"]), t["title_lines"]):
        d.text((t["margin"], y), ln, font=f, fill=t["navy"])
        y += int(t["title_size"] * t["title_leading"])
    _draw_card_hero(d, c, kit, t)
    _draw_card_attrs(d, c, kit, t)
    _draw_card_summary(d, c, kit, t)
    _draw_card_strip(img, d, kit, t, qr_bytes)
    return img


_SAFE_CARD_ID = re.compile(r"[A-Za-z0-9_-]+")


def _card_poster_name(card_id: str, uid: str, version: str) -> str:
    """卡海报缓存文件名（(card_id,uid,version) 键控；非常规 id 走 quote 防穿越）。"""
    cid = card_id if _SAFE_CARD_ID.fullmatch(card_id) else urllib.parse.quote(card_id, safe="")
    return f"card_{cid}_{uid}_{version}.png"


def _render_card_to_file(card: dict, uid: str, dst: Path) -> None:
    """卡海报出图落 data 目录（临时文件+原子替换，同 _render_to_file 纪律）。"""
    img = render_card_poster(card, _card_qr_bytes(str(card.get("id") or ""), uid))
    dst.parent.mkdir(parents=True, exist_ok=True)
    fd, tmp = tempfile.mkstemp(dir=dst.parent, suffix=".tmp")
    os.close(fd)
    try:
        img.save(tmp, format="PNG")
        os.replace(tmp, dst)
    finally:
        if os.path.exists(tmp):
            os.unlink(tmp)


class CardPosterIn(BaseModel):
    card_id: str


@router.post("/api/v1/posters/card")
def card_poster(body: CardPosterIn, request: Request):
    """商机卡海报（Bearer）：竖版卡模板出 PNG bytes；(card,uid,version) 缓存复用
    +落 share_event（channel=poster，rid=卡所属报告——分享的是报告的卡物料）。"""
    openid = wechat.bearer_openid(request)
    if not openid:
        raise ApiError(401, "UNAUTHORIZED", "未登录或凭证过期")
    uid = store.get_or_create_user(openid)["id"]
    from . import cards as _cards  # 局部导入防环（cards→poster）
    card_id = (body.card_id or "").strip()
    card = _cards.find_card(card_id)
    report = get_report(str(card.get("report_id") or "")) if card else None
    if not card or not report:
        raise ApiError(404, "CARD_NOT_FOUND", "商机卡不存在")
    version = config.CARD_POSTER_VERSION
    dst = config.POSTER_DIR / _card_poster_name(card_id, uid, version)
    if not dst.exists():
        _render_card_to_file(card, uid, dst)
    record_share(uid, report["id"], "poster", version)
    return Response(content=dst.read_bytes(), media_type="image/png")
