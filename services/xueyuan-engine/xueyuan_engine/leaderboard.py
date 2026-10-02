# -*- coding: utf-8 -*-
"""榜单/一周故事/K 看板域 [3c]——引擎③周更新闻化裂变+引擎④故事+验收判据⑤⑥。

三榜单从库内自动生成（人工零干预）；「周更」=rank_week ISO 周首访冻结快照
（节奏触发器语义：周内数据再变榜单不动，跨周自动翻新；快照写入仅当三榜
至少一榜非空，防内容区未就位把空周钉死）：
- 省级商机热度：score = 卡数×1 + 近7日扫码×2（公式随 payload 透明下发；
  扫码按 scene→report→province 归省，poster_code/card_code 双码表还原）；
- 最大单（库内 TOP-N 按金额）：卡数据无时间戳支撑月度口径，诚实降级为
  库内全量口径（A 线后续带时间字段可升「本月」，payload label 同口径）；
- 新入榜业主：最新 published_at 报告中出现且不出现在更早报告的业主
  （catalog published_at 真时间轴，非伪造「新」；首发周=全量新，诚实）。
一周商机故事：金额 TOP-12 候选池按 ISO 周序号确定性轮换（零模型调用，
免费模型铁律；Jev 判断层选条位留槽属 EPC100 线），三段式（背景→项目→
谁能吃）全部由卡行真实字段模板拼装，不造一句无出处的句子。
K 看板：四级漏斗 曝光(share_event)→扫码(scan_visit)→有效阅读(
invite_relation effective)→付费(orders 成交态)+换算率；运营令牌闸
（X-Operator-Token 对 secrets 文件常时比较；文件未配=403 安全缺省，
绝不因缺配置放开业务数据）。
"""
from __future__ import annotations

import hmac
import json
import logging
import re
from datetime import datetime, timedelta

from fastapi import APIRouter, Request
from fastapi.responses import Response

from . import cards, config, store
from .errors import ApiError

router = APIRouter(tags=["leaderboard"])   # 无 prefix：装饰器自写全路径（poster.py 式）

logger = logging.getLogger("xueyuan.leaderboard")

# 金额文本→亿元：数字（可含 , ， .）+可选 万/亿 单位；「面议」/空→None
_AMOUNT_RE = re.compile(r"([0-9][0-9,，.]*)(?:\s*(亿|万))?")
_PAID_STATES = ("paid", "delivered", "transferred")   # 付费级=成交态（转赠不除权）


def amount_yi(text: object) -> float | None:
    """金额文本 → 亿元数值（榜单排序口径）；无数字→None（不猜不造）。"""
    m = _AMOUNT_RE.search(str(text or ""))
    if not m or not m.group(1):
        return None
    try:
        n = float(m.group(1).replace(",", "").replace("，", ""))
    except ValueError:
        return None
    unit = m.group(2)
    if unit == "亿":
        return n
    if unit == "万":
        return n / 10000
    return n / 100000000          # 裸数字按元


def iso_week(now: datetime | None = None) -> tuple[str, int]:
    """(ISO 周键, 周序号)——周序号=故事轮换指针（确定性，可测注入 now）。"""
    dt = datetime.now(store._TZ8) if now is None else now
    iy, iw, _ = dt.isocalendar()
    return f"{iy}-W{iw:02d}", iy * 53 + iw


def _report_map() -> dict[str, dict]:
    """在架报告 id→行（title/published_at/province；榜单富化与归省共用）。"""
    with store._db() as c:
        rows = c.execute(
            "SELECT id,title,published_at,province FROM reports WHERE status='on'"
        ).fetchall()
    return {r["id"]: dict(r) for r in rows}


def _scans_by_province(days: int = 7) -> dict[str, int]:
    """近 N 日扫码按省归集（scene→rid 双码表→reports.province；查不到不计）。"""
    since = (datetime.now(store._TZ8) - timedelta(days=days)).isoformat()
    with store._db() as c:
        scans = c.execute(
            "SELECT scene_code FROM scan_visit WHERE ts>=?", (since,)).fetchall()
        prov = {r["id"]: (r["province"] or "").strip()
                for r in c.execute("SELECT id,province FROM reports").fetchall()}
        code2rid: dict[str, str] = {}
        for r in c.execute("SELECT scene_code,report_id FROM poster_code").fetchall():
            code2rid[r["scene_code"]] = r["report_id"]
        for r in c.execute("SELECT short_code,report_id FROM card_code").fetchall():
            code2rid["s=" + r["short_code"]] = r["report_id"]
    out: dict[str, int] = {}
    for s in scans:
        p = prov.get(code2rid.get(s["scene_code"] or "") or "")
        if p:
            out[p] = out.get(p, 0) + 1
    return out


def _province_heat(scans: dict[str, int]) -> list[dict]:
    """省级热度榜：score = 卡数 + 2×近7日扫码（top N，同分省名稳定序）。"""
    counts: dict[str, int] = {}
    for card in cards.all_cards():
        p = str(card.get("province") or "").strip()
        if p:
            counts[p] = counts.get(p, 0) + 1
    rows = [{"province": p, "cards": n, "scans_7d": scans.get(p, 0),
             "score": n + 2 * scans.get(p, 0)} for p, n in counts.items()]
    rows.sort(key=lambda r: (-r["score"], r["province"]))
    return [{**r, "rank": i} for i, r in enumerate(rows[:config.RANK_PROVINCE_TOP], 1)]


def _amount_cards() -> list[tuple[float, dict]]:
    """有金额卡的 (亿元, 卡行) 全集（最大单榜与故事候选池共用）。"""
    out = []
    for card in cards.all_cards():
        yi = amount_yi(card.get("amount") or card.get("amount_raw"))
        if yi is not None:
            out.append((yi, card))
    out.sort(key=lambda t: (-t[0], str(t[1].get("id") or "")))
    return out


def _deal_out(rank: int, yi: float, card: dict, rmap: dict[str, dict]) -> dict:
    rep = rmap.get(str(card.get("report_id") or ""), {})
    return {
        "rank": rank, "card_id": str(card.get("id") or ""),
        "title": str(card.get("title") or ""),
        "amount": str(card.get("amount") or card.get("amount_raw") or ""),
        "amount_yi": yi,
        "province": str(card.get("province") or ""),
        "owner": str(card.get("owner") or ""),
        "report_id": str(card.get("report_id") or ""),
        "report_title": str(rep.get("title") or ""),
    }


def _max_deals(rmap: dict[str, dict]) -> list[dict]:
    """最大单榜：库内金额 TOP-N（口径诚实标注，见模块文档）。"""
    return [_deal_out(i, yi, c, rmap)
            for i, (yi, c) in enumerate(_amount_cards()[:config.RANK_MAX_DEALS_TOP], 1)]


def _rising_owners(rmap: dict[str, dict]) -> list[dict]:
    """新入榜业主：仅出现在最新 published_at 报告的业主（真时间轴口径）。"""
    if not rmap:
        return []
    newest = max(r["published_at"] or "" for r in rmap.values())
    new_rids = {rid for rid, r in rmap.items() if (r["published_at"] or "") == newest}
    old_owners: set[str] = set()
    fresh: list[tuple[float, str, dict]] = []
    for card in cards.all_cards():
        owner = str(card.get("owner") or "").strip()
        rid = str(card.get("report_id") or "")
        if not owner or rid not in rmap:
            continue
        yi = amount_yi(card.get("amount") or card.get("amount_raw")) or 0.0
        if rid in new_rids:
            fresh.append((yi, owner, card))
        else:
            old_owners.add(owner)
    rows = [t for t in fresh if t[1] not in old_owners]
    rows.sort(key=lambda t: (-t[0], t[1]))
    out = []
    for i, (yi, owner, card) in enumerate(rows[:config.RANK_NEW_OWNERS_TOP], 1):
        rep = rmap.get(str(card.get("report_id") or ""), {})
        out.append({"rank": i, "owner": owner,
                    "amount": str(card.get("amount") or card.get("amount_raw") or ""),
                    "amount_yi": yi, "province": str(card.get("province") or ""),
                    "report_id": str(card.get("report_id") or ""),
                    "report_title": str(rep.get("title") or "")})
    return out


def _story(week_no: int, rmap: dict[str, dict]) -> dict | None:
    """一周商机故事：金额 TOP-12 池按周序号取模轮换；三段式全真实字段拼装。"""
    pool = _amount_cards()[:config.RANK_STORY_POOL]
    if not pool:
        return None
    yi, card = pool[week_no % len(pool)]
    rep = rmap.get(str(card.get("report_id") or ""), {})
    province = str(card.get("province") or "").strip()
    owner = str(card.get("owner") or "").strip()
    # stage 占位 '-' 与空串归一为 ''（同 cards._norm_stage 口径——生产实锤
    # 「项目处于-阶段」泄漏后补的边界归一，两域共用一判据）
    stage = str(card.get("stage") or "").strip()
    if stage == "-":
        stage = ""
    window = str(card.get("window") or "").strip()
    amount = str(card.get("amount") or card.get("amount_raw") or "")
    # 三段式：背景（谁在哪）→ 项目（多大何时）→ 谁能吃（去哪读完整拆解）。
    # 字段缺席即略句——宁可短，不造无出处的话（C14 不编造）。
    bg = " ".join(p for p in (
        f"本周商机焦点落在{province}。" if province else "",
        f"业主方为{owner}，" if owner else "",
        f"项目处于{stage}阶段。" if stage else "",
    ) if p).strip()
    if bg.endswith("，"):
        bg = bg[:-1] + "。"
    proj = " ".join(p for p in (
        str(card.get("title") or ""),
        f"投资规模约{amount}。" if amount else "",
        f"窗口期{window}。" if window else "",
    ) if p).strip() or "（项目信息待补）"
    eat = " ".join(p for p in (
        f"该商机出自《{rep.get('title') or card.get('report_id')}》"
        f"{card.get('source_chapter') or ''}，".strip(),
        "完整拆解含切入策略与对接建议，小程序内可免费试读。",
    ) if p)
    return {
        "card_id": str(card.get("id") or ""), "title": str(card.get("title") or ""),
        "amount": amount, "amount_yi": yi, "province": province, "owner": owner,
        "stage": stage, "window": window,
        "report_id": str(card.get("report_id") or ""),
        "report_title": str(rep.get("title") or ""),
        "paragraphs": [bg, proj, eat],
    }


def _compute(week: str, week_no: int) -> dict:
    rmap = _report_map()
    return {
        "week": week,
        "generated_at": store.now(),
        "province_heat": _province_heat(_scans_by_province()),
        "max_deals": _max_deals(rmap),
        "rising_owners": _rising_owners(rmap),
        "story": _story(week_no, rmap),
        "formula": {
            "province_heat": "score = 省内商机卡数×1 + 近7日扫码×2（本周快照冻结）",
            "max_deals": "库内全量口径（卡数据无时间戳，月度口径待 A 线时间字段）",
            "rising_owners": "仅出现在最新 published_at 报告中的业主（真时间轴）",
            "story": f"金额 TOP{config.RANK_STORY_POOL} 池按 ISO 周序号确定性轮换（零模型）",
        },
    }


def rankings() -> dict:
    """三榜+故事（公开）：本周快照命中直回；跨周自动重算冻结。"""
    week, week_no = iso_week()
    with store._db() as c:
        row = c.execute("SELECT payload_json FROM rank_week WHERE week=?",
                        (week,)).fetchone()
    if row:
        try:
            return json.loads(row["payload_json"])
        except ValueError:
            logger.warning("rank_week 坏行，重算覆盖: %s", week)
    payload = _compute(week, week_no)
    if any((payload["province_heat"], payload["max_deals"], payload["rising_owners"])):
        with store._LOCK, store._db() as c:
            c.execute(
                "INSERT OR REPLACE INTO rank_week(week,payload_json,generated_at)"
                " VALUES(?,?,?)",
                (week, json.dumps(payload, ensure_ascii=False), store.now()))
    return payload


def _markdown(d: dict) -> str:
    """公众号出稿（text/markdown）：运营复制即发，判据⑤人工零干预管线。"""
    lines = [f"# 总包学园商机周报（{d.get('week') or ''}）", ""]

    story = d.get("story")
    if story:
        lines += ["## 本周商机故事", ""]
        lines += [p for p in story.get("paragraphs") or [] if p]
        lines += [""]
    heat = d.get("province_heat") or []
    if heat:
        lines += ["## 省级商机热度榜", "",
                  "| 省份 | 商机卡 | 近7日扫码 | 热度 |", "|---|---|---|---|"]
        lines += [f"| {r['province']} | {r['cards']} | {r['scans_7d']} | {r['score']} |"
                  for r in heat]
        lines += [""]
    deals = d.get("max_deals") or []
    if deals:
        lines += ["## 最大商机单（库内）", "",
                  "| # | 项目 | 金额 | 区域 | 业主 |", "|---|---|---|---|---|"]
        lines += [f"| {r['rank']} | {r['title']} | {r['amount']} | "
                  f"{r['province']} | {r['owner']} |" for r in deals]
        lines += [""]
    owners = d.get("rising_owners") or []
    if owners:
        lines += ["## 新入榜业主", ""]
        lines += [f"{r['rank']}. {r['owner']}（{r['province']}，{r['amount']}）"
                  for r in owners]
        lines += [""]
    lines += ["完整商机情报与来源研报见「总包学园」小程序。", "",
              "行业研究，非投资建议；决策自担。"]
    return "\n".join(lines)


@router.get("/api/v1/rankings")
def get_rankings():
    """三榜+故事（公开无鉴权：纯信息分享无利益诱导——红线自查项⑦）。"""
    return rankings()


@router.get("/api/v1/rankings/export")
def rankings_export():
    """公众号 markdown 出稿（公开：出稿内容同 /rankings，无增量信息）。"""
    return Response(content=_markdown(rankings()),
                    media_type="text/markdown; charset=utf-8")


# ── K 看板（验收判据⑥：曝光→扫码→有效阅读→付费四级数字可拉）──────────
def _operator_ok(request: Request) -> bool:
    """运营令牌闸：X-Operator-Token 对 secrets 文件常时比较（缺配=拒）。"""
    tok = (request.headers.get("X-Operator-Token") or "").strip()
    if not tok:
        return False
    f = config.OPERATOR_TOKEN_FILE
    if not f.exists():
        return False
    try:
        want = f.read_text(encoding="utf-8").strip()
    except OSError:
        return False
    return bool(want) and hmac.compare_digest(tok, want)


@router.get("/api/v1/k/dashboard")
def k_dashboard(request: Request):
    """K 漏斗看板（运营令牌闸）：四级 total+近7日 + 换算率（诚实：只报实测数）。"""
    if not _operator_ok(request):
        raise ApiError(403, "OPERATOR_DENIED", "K 看板需运营令牌（X-Operator-Token）")
    since = (datetime.now(store._TZ8) - timedelta(days=7)).isoformat()
    with store._db() as c:
        shares_t = c.execute("SELECT COUNT(*) n FROM share_event").fetchone()["n"]
        shares_w = c.execute(
            "SELECT COUNT(*) n FROM share_event WHERE ts>=?", (since,)).fetchone()["n"]
        scans_t = c.execute("SELECT COUNT(*) n FROM scan_visit").fetchone()["n"]
        scans_w = c.execute(
            "SELECT COUNT(*) n FROM scan_visit WHERE ts>=?", (since,)).fetchone()["n"]
        eff_t = c.execute(
            "SELECT COUNT(*) n FROM invite_relation WHERE status='effective'"
        ).fetchone()["n"]
        paid = c.execute(
            f"SELECT COUNT(*) n, COALESCE(SUM(price_fen),0) s FROM orders"
            f" WHERE status IN ({','.join('?' * len(_PAID_STATES))})",
            _PAID_STATES).fetchone()
        paid_w = c.execute(
            f"SELECT COUNT(*) n FROM orders WHERE status IN"
            f" ({','.join('?' * len(_PAID_STATES))}) AND paid_at>=?",
            (*_PAID_STATES, since)).fetchone()["n"]
    funnel = [
        {"stage": "曝光", "key": "shares", "total": shares_t, "last_7d": shares_w,
         "note": "share_event 海报/卡分享次数"},
        {"stage": "扫码", "key": "scans", "total": scans_t, "last_7d": scans_w,
         "note": "scan_visit 扫码进入次数"},
        {"stage": "有效阅读", "key": "effective", "total": eff_t, "last_7d": None,
         "note": "invite_relation effective（读腿/停留腿达标）"},
        {"stage": "付费", "key": "paid", "total": paid["n"], "last_7d": paid_w,
         "gmv_fen": paid["s"], "note": "orders 成交态（paid/delivered/transferred）"},
    ]

    def _ratio(a: int, b: int) -> float | None:
        return round(a / b, 4) if b else None

    return {
        "cards_total": cards.total_cards(),
        "funnel": funnel,
        "conversion": {
            "scan_per_share": _ratio(scans_t, shares_t),
            "effective_per_scan": _ratio(eff_t, scans_t),
            "paid_per_effective": _ratio(paid["n"], eff_t),
        },
        "note": "K 因子=换算率乘积的运营侧估计（本端点只报实测数，不做 vanity 外推）",
    }
