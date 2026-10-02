# -*- coding: utf-8 -*-
"""商机情报卡域（w3a-2-E）——content/cards/*.json 3104 张卡只读域：单卡公开 /
by-report 两态（未购前 3 张锁定 / 已购全量分页）/ scene 反解 + H5 长尾页（SEO）。

数据（cards_extract v1 产物，只读）：{report_id,generated_at,source,cards:[...]}；
懒加载+进程内缓存（按 CONTENT_DIR 键控；单进程 ARCHITECTURE A1，更新=部署重启
生效，同 startup sync 口径）。
边界归一化（引擎负责）：stage 占位 '-' 与空串归 ''；amount 原样透传（可空串）；
source_chapter 富化 ch11 → 「第 11 章 · 标题」（chapters 库查不到 slug 原样透传
不失败）。
卡 scene 冻结格式 c=<card_id>&i=<uid>（poster.parse_card_scene 纯解析；
invite.parse_scene 经本域索引把 card_id 反查为 report_id——首触/有效带新判据
全部复用，不新建归因路径）。
H5 长尾页不在 /api/v1 下（公开 SEO 面）：无 JS 依赖静态 HTML，全部动态文本
HTML 转义（卡 title 注入 <script> 不得活），尾部同域 /h5/cards/ 互链。
"""
from __future__ import annotations

import html
import json
import logging
import re
import sqlite3
import uuid

from fastapi import APIRouter, Request
from fastapi.responses import HTMLResponse

from . import config, poster, store, wechat
from .catalog import chapter_rows, get_report
from .errors import ApiError

logger = logging.getLogger("xueyuan.cards")

router = APIRouter(prefix="/api/v1", tags=["cards"])
h5_router = APIRouter(tags=["cards"])   # H5 长尾页（前缀外公开路由）

# 懒加载索引缓存：str(cards dir) -> {"by_id": {card_id: raw}, "by_report": {rid: [raw]}}
_CACHE: dict[str, dict] = {}


def _cards_dir():
    """卡数据区 = CONTENT_DIR/cards（ECS 随内容区走；夹具同位可替换）。"""
    return config.CONTENT_DIR / "cards"


def _load(root) -> dict:
    """38 文件 → 双索引（by_id 全库 / by_report 保序）；坏文件跳过不失败。"""
    by_id: dict[str, dict] = {}
    by_report: dict[str, list[dict]] = {}
    if root.is_dir():
        for f in sorted(root.glob("*.json")):
            try:
                d = json.loads(f.read_text(encoding="utf-8"))
            except (OSError, ValueError):
                logger.warning("cards 文件不可读，跳过: %s", f.name)
                continue
            rid = str(d.get("report_id") or "")
            cards = d.get("cards")
            if not rid or not isinstance(cards, list):
                continue
            bucket = by_report.setdefault(rid, [])
            for card in cards:
                if isinstance(card, dict) and card.get("id"):
                    row = {**card, "report_id": rid}   # 文件级 report_id 注入行
                    by_id[str(card["id"])] = row
                    bucket.append(row)
    return {"by_id": by_id, "by_report": by_report}


def _index() -> dict:
    root = _cards_dir()
    key = str(root)
    hit = _CACHE.get(key)
    if hit is None:
        hit = _load(root)
        _CACHE[key] = hit
    return hit


def find_card(card_id: str) -> dict | None:
    """card_id → 原始卡行（含 report_id；查不到 None）——invite/poster 共用反查位。"""
    return _index()["by_id"].get(str(card_id or ""))


def total_cards() -> int:
    """全库卡总数（H5 CTA 文案「完整 N 条商机情报」口径）。"""
    return len(_index()["by_id"])


def all_cards() -> list[dict]:
    """全库卡行快照（榜单域聚合用；行含 report_id，顺序=index 装载序稳定）。"""
    return list(_index()["by_id"].values())


# ── 卡维短码（官方 scene ≤32 上限的根治通道；与 poster_code 溢出对称）──
def ensure_card_code(card_id: str, inviter_uid: str) -> str:
    """(card, inviter) → s=<8hex> 短码 scene（幂等：UNIQUE(card_id,inviter_uid)）。

    根因：真实卡 id（<rid>-cNNN≈20-24 字符）使直拼 c=<card_id>&i=<uid> 全量
    超 32（3104/3104 实测）——报告码 poster_code 同款溢出通道的卡维版。
    同卡同人恒同码：QR 码池 / resolve 反解 / invite 归因三处共用一致。
    重试 3 撞后返回 ""（调用方按占位降级，不 raise 拖挂海报主链）。
    """
    card = find_card(card_id)
    if not card or not inviter_uid:
        return ""
    with store._db() as c:
        row = c.execute(
            "SELECT short_code FROM card_code WHERE card_id=? AND inviter_uid=?",
            (card_id, inviter_uid)).fetchone()
        if row:
            return f"s={row['short_code']}"
    for _ in range(3):  # PK 撞码重试（8 hex 随机，撞率可忽略）
        code = uuid.uuid4().hex[:8]
        try:
            with store._LOCK, store._db() as c:
                c.execute(
                    "INSERT INTO card_code(short_code,card_id,inviter_uid,report_id,"
                    "created_at) VALUES(?,?,?,?,?)",
                    (code, card_id, inviter_uid, str(card["report_id"]), store.now()))
            return f"s={code}"
        except sqlite3.IntegrityError:
            with store._db() as c:  # 并发同 (card,inviter) 先入：取回即幂等命中
                row = c.execute(
                    "SELECT short_code FROM card_code WHERE card_id=? AND inviter_uid=?",
                    (card_id, inviter_uid)).fetchone()
                if row:
                    return f"s={row['short_code']}"
    logger.warning("卡短码分配 3 撞未果（card_id=%s uid=%s）", card_id, inviter_uid)
    return ""


def card_qr_scene(card_id: str, uid: str) -> str:
    """卡 QR scene：直拼 c= 合法（短 rid 夹具/未来短卡号）优先，超限落短码。"""
    direct = f"c={card_id}&i={uid}"
    if poster.scene_legal(direct):
        return direct
    return ensure_card_code(card_id, uid)


def card_code_lookup(scene_code: str) -> tuple[str, str] | None:
    """s= 短码 → (report_id, inviter_uid)；查不到 None（invite 归因 s= 回落位）。"""
    code = scene_code[2:] if scene_code.startswith("s=") else scene_code
    with store._db() as c:
        row = c.execute(
            "SELECT report_id,inviter_uid FROM card_code WHERE short_code=?",
            (code,)).fetchone()
    return (row["report_id"], row["inviter_uid"]) if row else None


def _norm_stage(v) -> str:
    """stage 占位 '-' 与空串归一为 ''（引擎侧边界归一化职责）。"""
    s = str(v or "").strip()
    return "" if s == "-" else s


def _chapter_map(rid: str) -> dict[str, str]:
    """slug → 章标题（单报告一次 DB 查询，N 卡序列化不放大查询）。"""
    return {ch["id"].split("/")[-1]: ch["title"] for ch in chapter_rows(rid)}


def _card_out(card: dict, chmap: dict[str, str]) -> dict:
    """契约卡形状（冻结字段名）+ 归一化 + source_chapter 富化。"""
    slug = str(card.get("source_chapter") or "")
    label = slug
    m = re.fullmatch(r"ch(\d+)", slug)
    if m and slug in chmap:
        label = f"第 {int(m.group(1))} 章 · {chmap[slug]}"
    return {
        "id": str(card.get("id") or ""),
        "report_id": str(card.get("report_id") or ""),
        "title": str(card.get("title") or ""),
        "amount": str(card.get("amount") or ""),
        "amount_raw": str(card.get("amount_raw") or ""),
        "owner": str(card.get("owner") or ""),
        "stage": _norm_stage(card.get("stage")),
        "window": str(card.get("window") or ""),
        "province": str(card.get("province") or ""),
        "source_chapter": label,
        "summary": str(card.get("summary") or ""),
    }


def _report_block(report: dict) -> dict:
    """report 块五字段（cover 空串同 catalog.item_of 口径）。"""
    return {"id": report["id"], "title": report["title"], "price_fen": report["price_fen"],
            "cover": "", "trial_chapters": report["trial_chapters"]}


def _entitled(uid: str | None, rid: str) -> bool:
    """权益判定（服务端真源；同 chapters._entitled 口径）。"""
    if not uid:
        return False
    with store._db() as c:
        return c.execute(
            "SELECT 1 FROM entitlements WHERE user_id=? AND report_id=? LIMIT 1",
            (uid, rid)).fetchone() is not None


# ── 端点（冻结契约；resolve 须先于 /cards/{card_id} 注册防路径吞并）─────
@router.get("/cards/resolve")
def resolve_card(scene: str = ""):
    """卡 scene → {card_id}；解析失败/查不到恒 200 空串（同 invite/scan 降级哲学）。

    两形态：c=<card_id>[&i=<uid>] 直拼（短 rid 可容）与 s=<8hex> 卡短码
    （真实卡的常态形态，ensure_card_code 分配）。
    """
    card_id = ""
    s = (scene or "").strip()
    if s.startswith("s="):
        with store._db() as c:
            row = c.execute("SELECT card_id FROM card_code WHERE short_code=?",
                            (s[2:],)).fetchone()
        if row and find_card(row["card_id"]):
            card_id = row["card_id"]
    else:
        parsed = poster.parse_card_scene(scene)
        if parsed and find_card(parsed[0]):
            card_id = parsed[0]
    return {"card_id": card_id}


@router.get("/cards/by-report/{rid}")
def cards_by_report(rid: str, request: Request, page: int = 1,
                    page_size: int = config.CARD_PAGE_SIZE_DEFAULT):
    """两态（冻结契约）：未购=前 3 张+locked:true+total；已购=全量分页 locked:false。"""
    report = get_report(rid)
    if not report:
        raise ApiError(404, "REPORT_NOT_FOUND", "报告不存在或已下架")
    all_cards = _index()["by_report"].get(rid, [])
    openid = wechat.bearer_openid(request)
    uid = store.get_or_create_user(openid)["id"] if openid else None
    chmap = _chapter_map(rid)
    if not _entitled(uid, rid):
        return {"cards": [_card_out(c, chmap) for c in all_cards[:config.CARD_TEASER_COUNT]],
                "total": len(all_cards), "locked": True, "page": 1,
                "page_size": config.CARD_TEASER_COUNT}
    page = max(1, page)
    page_size = min(config.CARD_PAGE_SIZE_MAX, max(1, page_size))
    start = (page - 1) * page_size
    return {"cards": [_card_out(c, chmap) for c in all_cards[start:start + page_size]],
            "total": len(all_cards), "locked": False, "page": page, "page_size": page_size}


@router.get("/cards/{card_id}")
def get_card(card_id: str):
    """单卡公开（无 Bearer 也可）；下架报告的卡同 404 CARD_NOT_FOUND。"""
    card = find_card(card_id)
    report = get_report(str(card.get("report_id") or "")) if card else None
    if not card or not report:
        raise ApiError(404, "CARD_NOT_FOUND", "商机卡不存在")
    return {"card": _card_out(card, _chapter_map(report["id"])),
            "report": _report_block(report)}


# ── H5 长尾页（SEO；公开 text/html，无 JS 依赖，动态文本全转义）──────────
def _esc(s) -> str:
    return html.escape(str(s or ""), quote=True)


def _more_cards(current_id: str) -> list[dict]:
    """「更多商机」内链候选：有金额卡优先、跳过自身与下架报告（防链向 404）。"""
    out: list[dict] = []
    idx = _index()
    seen_on: dict[str, bool] = {}
    for rid in sorted(idx["by_report"]):
        if rid not in seen_on:
            seen_on[rid] = get_report(rid) is not None
        if not seen_on[rid]:
            continue
        for card in idx["by_report"][rid]:
            cid = str(card.get("id") or "")
            if str(card.get("amount") or "") and cid != current_id:
                out.append({"id": cid, "title": str(card.get("title") or ""),
                            "amount": str(card.get("amount") or "")})
                if len(out) >= config.CARD_H5_MORE_LINKS:
                    return out
    return out


def _h5_attrs(c: dict) -> list[tuple[str, str]]:
    """卡属性行（有值才出；金额缺省回退 amount_raw）。"""
    amount = c["amount"] or c["amount_raw"]
    pairs = [("金额", amount)] if amount else []
    pairs += [("区域", c["province"] or "—"), ("来源", c["source_chapter"] or "—")]
    for key, val in (("业主", c["owner"]), ("阶段", c["stage"]), ("窗口", c["window"])):
        if val:
            pairs.append((key, val))
    return pairs


_H5_CSS = (
    "body{font-family:system-ui,-apple-system,'PingFang SC','Microsoft YaHei',sans-serif;"
    "margin:0;background:#f6f7f9;color:#2a3542;line-height:1.7}"
    "header{background:#113a66;color:#fff;padding:14px 20px;font-size:18px}"
    "header .sub{opacity:.75;margin-left:10px;font-size:14px}"
    "main{max-width:640px;margin:0 auto;padding:20px 16px}"
    "h1{font-size:22px;margin:8px 0 14px;color:#113a66}"
    ".hero{font-size:28px;font-weight:700;color:#113a66;margin:6px 0}"
    ".row{display:flex;gap:10px;padding:7px 0;border-bottom:1px dashed #e3e7ec}"
    ".row .k{color:#5a6b7f;min-width:3.2em}"
    ".summary{background:#fff;border-radius:10px;padding:14px;margin:16px 0}"
    ".report{font-size:14px;color:#5a6b7f}"
    ".cta{background:#113a66;color:#fff;border-radius:10px;padding:16px;margin-top:16px}"
    ".cta .tip{font-size:13px;opacity:.8;margin:6px 0 0}"
    ".more{max-width:640px;margin:8px auto 0;padding:0 16px 20px}"
    ".more h2{font-size:16px;color:#113a66}"
    ".more li{list-style:none;padding:8px 0;border-bottom:1px dashed #e3e7ec;"
    "display:flex;justify-content:space-between;gap:12px}"
    ".more a{color:#113a66;text-decoration:none}"
    ".more .amt{color:#f0a93b;font-weight:600;white-space:nowrap}"
    "footer{text-align:center;color:#9aa6b5;font-size:12px;padding:16px}"
)


def _h5_page(c: dict, report: dict, more: list[dict], total: int) -> str:
    rows = "".join(
        f'<div class="row"><span class="k">{_esc(k)}</span>'
        f'<span class="v">{_esc(v)}</span></div>'
        for k, v in _h5_attrs(c))
    more_html = ""
    if more:
        links = "".join(
            f'<li><a href="/h5/cards/{_esc(m["id"])}">{_esc(m["title"])}</a>'
            f'<span class="amt">{_esc(m["amount"])}</span></li>'
            for m in more)
        more_html = (f'<section class="more"><h2>更多商机</h2><ul>{links}</ul>'
                     f'<p style="font-size:13px;color:#5a6b7f">共 {_esc(total)} 条商机情报，'
                     f'小程序内按省份/金额/阶段筛选</p></section>')
    return f"""<!doctype html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>{_esc(c['title'])} · 总包学园</title>
<meta name="description" content="{_esc(c['summary'] or c['title'])}">
<style>{_H5_CSS}</style>
</head>
<body>
<header>总包学园<span class="sub">商机情报</span></header>
<main>
<h1>{_esc(c['title'])}</h1>
<p class="hero">{_esc(c['amount'] or c['amount_raw']
                     or ' · '.join(p for p in (c['province'], c['stage']) if p))}</p>
<div class="attrs">{rows}</div>
<p class="summary">{_esc(c['summary'])}</p>
<p class="report">所属研报：《{_esc(report['title'])}》共 {_esc(report['chapter_count'])} 章，
前 {_esc(report['trial_chapters'])} 章免费试读</p>
<div class="cta">
<p>完整 {_esc(total)} 条商机情报见总包学园小程序</p>
<p class="tip">请在微信中打开（搜索「总包学园」小程序，或长按识别分享海报上的小程序码）</p>
</div>
</main>
{more_html}
<footer>总包创研院 出品</footer>
</body>
</html>"""


_H5_404 = """<!doctype html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>商机卡不存在 · 总包学园</title>
<style>body{font-family:system-ui,sans-serif;text-align:center;padding:60px 20px;
color:#2a3542}a{color:#113a66}</style>
</head>
<body>
<h1>商机卡不存在或已下架</h1>
<p>完整商机情报请前往「总包学园」小程序（微信内打开）</p>
</body>
</html>"""


@h5_router.get("/h5/cards/{card_id}")
def h5_card(card_id: str):
    """H5 卡长尾页（公开 SEO 面）：单卡属性+报告 CTA+同域互链；404 卡=404+HTML 体。"""
    card = find_card(card_id)
    report = get_report(str(card.get("report_id") or "")) if card else None
    if not card or not report:
        return HTMLResponse(_H5_404, status_code=404)
    c = _card_out(card, _chapter_map(report["id"]))
    return HTMLResponse(_h5_page(c, report, _more_cards(str(card["id"])), total_cards()))
