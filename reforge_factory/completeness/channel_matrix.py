# -*- coding: utf-8 -*-
"""C 轴传感器 channel_matrix 渠道×主题命中矩阵 (T-007E / REQ-020 & REQ-029 前半 /
KB-COMPLETENESS-SPEC C 轴).

REQ-029 前半: 当渠道×主题命中矩阵检测到未命中渠道时 → miss_list + 新建队列判定;
建渠执行器(SOP 四步法)是 T-015 的活, 本件只做传感器, 不建渠不写队列。

在役渠道清单 (分母): `ResearchFactory-Eng/channel_manifest.json` 的 named_channels
(实测 28 个)。读不到时 fail-soft: 分母退化 = 池 by_engine 已见引擎清单(全命中,
近似口径, 输出标 fail_soft=true)。

命中账 (分子): `ammo_pool/<战役>/pool_state.json` 的 by_engine 引擎→字符账。
引擎→渠道映射 (内置映射表, 全部近似已注明):
  1. 直接命中: 引擎标签含渠道 id/别名/中文名 (最长别名优先, 防止 `ima` 误吞
     `ima_public` 这类包含式别名);
  2. 前缀基名: `cross:*` / `rss:*` 段取基名查 BASE_TO_CHANNEL 表 ——
     wechat_rss → 微信生态 ≈ 搜狗微信(sougo), rss → RSS 常年收割(rss_fleet 族,
     named 渠道无对应不点亮), academic_en/arxiv/patents → 学术/专利缺口(留给 T-015);
  3. 个别整标签/前缀近似: search:web ≈ WebSearch, stock:* ≈ 存量语料库 等, 注明近似。

green = miss_list 空 或 miss_list 全部已在新建队列
`ammo_pool/<战役>/completeness/C_axis_queue.json`(KB 口径 [{"name","sop_step"}],
也兼容纯字符串; 文件缺席 → 队列空, 有 miss 即红)。

双产物落盘 (真实池/清单只读, 只写评估产物):
  1. `ammo_pool/<战役>/completeness/C_axis.json` — 完备性账本 C 轴节
  2. `ammo_pool/<战役>/channel_matrix.json` — taskgraph T-007E verify 权威件(同载荷镜像)

CLI:
  py reforge_factory/completeness/channel_matrix.py <战役> [--ammo-root DIR]
      [--manifest PATH] [--dry-run]
"""
from __future__ import annotations

import argparse
import json
import sys
from datetime import datetime, timezone
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_AMMO_ROOT = REPO_ROOT / "ammo_pool"
DEFAULT_MANIFEST_PATH = REPO_ROOT / "ResearchFactory-Eng" / "channel_manifest.json"
QUEUE_RELPATH = Path("completeness") / "C_axis_queue.json"

SENSOR = "channel_matrix"
AXIS = "C"

#: 渠道别名表 (小写; 渠道 id 与清单 name 会自动并入, 此处只补引擎标签里的变体拼写)。
#: 「最长别名优先」规则处理包含式别名 (ima ⊂ ima_public)。
CHANNEL_ALIASES: dict[str, list[str]] = {
    "manus": ["manus"],
    "sougo": ["sougo", "sogou", "搜狗微信", "微信文章"],
    "metaso": ["metaso", "秘塔"],
    "djyanbao": ["djyanbao", "洞见研报"],
    "website": ["website", "官网"],
    "video": ["video", "视频"],
    "ima": ["ima"],
    "ima_public": ["ima_public"],
    "weread": ["weread", "微信读书"],
    "lark": ["lark", "feishu", "飞书"],
    "wechat_local": ["wechat_local", "微信本地"],
    "wechat4": ["wechat4", "微信4"],
    "browser360": ["browser360", "360浏览器"],
    "localfiles": ["localfiles", "本地文件"],
    "websearch": ["websearch"],
    "court": ["court", "wenshu", "涉诉", "裁判文书"],
    "cnki": ["cnki", "知网"],
    "corpus_stores": ["corpus_stores", "存量语料"],
    "govlist": ["govlist", "政府名录"],
    "eoscar": ["eoscar", "e-oscar"],
    "cli_stack": ["cli_stack"],
    "pansou": ["pansou", "网盘聚合"],
    "chinatextbook": ["chinatextbook", "教材语料"],
    "zh_search_pro": ["zh_search_pro", "zhsearchpro", "免key中文"],
    "ebook_library": ["ebook_library", "电子书渠道"],
    "search_library": ["search_library"],
    "quark_pan": ["quark_pan", "夸克网盘"],
    "anysearch": ["anysearch"],
}

#: cross:*/rss:* 基名 → 渠道 (None = 有基名语义但无 named 渠道对应, 不硬点亮)。
BASE_TO_CHANNEL: dict[str, tuple[str | None, str]] = {
    "wechat_rss": ("sougo", "微信生态公众号RSS≈搜狗微信内容面（近似）"),
    "sogou_wechat": ("sougo", "搜狗微信直采"),
    "rss": (None, "RSS 常年收割（rss_fleet 族，未列 named 渠道）"),
    "cnki": ("cnki", ""),
    "metaso": ("metaso", ""),
    "weread": ("weread", ""),
    "zhsearchpro": ("zh_search_pro", ""),
    "video": ("video", ""),
    "websearch_en": ("websearch", "英文 web 搜索≈WebSearch 面（近似）"),
    "ebook": ("ebook_library", "电子书渠道族（近似）"),
    "dangdang": ("ebook_library", "当当=电子书渠道族成员（近似）"),
    "academic_en": (None, "学术英文（OpenAlex/S2/arXiv 待建渠 T-015）"),
    "arxiv": (None, "arXiv（待建渠 T-015）"),
    "patents": (None, "专利（待建渠 T-015）"),
}

#: 个别整标签近似 (键为小写整标签)。
LABEL_TO_CHANNEL: dict[str, tuple[str, str]] = {
    "search:web": ("websearch", "网页搜索≈WebSearch 面（近似）"),
    "fulltext:web": ("website", "网页全文≈官网爬虫面（近似）"),
}

#: 前缀近似 (引擎标签第一段 → 渠道)。
PREFIX_TO_CHANNEL: dict[str, tuple[str, str]] = {
    "stock": ("corpus_stores", "存量池收割≈存量语料库（近似）"),
}


def _norm(s: str) -> str:
    """队列/缺口匹配用的归一化: 去空白 + 小写 (id 与中文名皆可对上)."""
    return "".join(str(s).split()).lower()


def load_channels(manifest_path: Path) -> list[dict]:
    """读 named 渠道清单; 读不到返回 [] (fail-soft 由 scan 落地)."""
    try:
        data = json.loads(Path(manifest_path).read_text(encoding="utf-8"))
        chans = data.get("named_channels") or []
        return [c for c in chans if isinstance(c, dict) and c.get("id")]
    except Exception:
        return []


def _alias_table(channels: list[dict]) -> dict[str, list[str]]:
    """渠道 id + 清单 name + 内置别名 → 每渠道别名集 (全小写去重)."""
    table: dict[str, list[str]] = {}
    for c in channels:
        cid = str(c["id"])
        names = {cid.lower()}
        if c.get("name"):
            names.add(str(c["name"]).lower())
        names.update(a.lower() for a in CHANNEL_ALIASES.get(cid, []))
        # 长别名在前, 便于「最长优先」抑制包含式别名
        table[cid] = sorted(names, key=len, reverse=True)
    return table


def resolve_engine(label: str, table: dict[str, list[str]] | None = None) -> dict:
    """单引擎标签 → {channels, notes, bases}. 近似/族级语义都在 notes 注明."""
    if table is None:
        table = _alias_table(
            [{"id": k, "name": ""} for k in CHANNEL_ALIASES]
            + [{"id": i, "name": n} for i, n in (
                ("sougo", "搜狗微信"), ("metaso", "秘塔学术"), ("weread", "微信读书"),
                ("lark", "飞书语料"), ("cnki", "CNKI 论文"), ("manus", "Manus 军团"),
                ("website", "官网爬虫"), ("video", "视频文稿"), ("websearch", "WebSearch"),
                ("court", "涉诉检索"), ("corpus_stores", "存量语料库"),
                ("ebook_library", "电子书渠道族"), ("ima", "ima 知识库"),
                ("ima_public", "ima 公开知识库"),
            )]
        )
    low = str(label).lower()
    notes: list[str] = []
    bases: list[str] = []

    # 1) 直接命中 (含渠道 id/别名/中文名)
    matched: dict[str, set[str]] = {}
    for cid, aliases in table.items():
        hits = {a for a in aliases if a in low}
        if hits:
            matched[cid] = hits
    # 「最长别名优先」: 渠道 X 的全部命中别名都是别的渠道更长别名的子串 → X 让位
    def _shadowed(cid: str, alias: str) -> bool:
        for c2, aliases2 in matched.items():
            if c2 != cid and any(alias in a2 for a2 in aliases2):
                return True
        return False

    for cid in list(matched):
        if all(_shadowed(cid, a) for a in matched[cid]):
            del matched[cid]
    channels = set(matched)

    # 2) cross:*/rss:* 前缀基名
    for marker in ("cross:", "rss:"):
        if marker in low:
            base = low.split(marker, 1)[1].split(":", 1)[0]
            if base:
                bases.append(base)
                cid, note = BASE_TO_CHANNEL.get(base, (None, ""))
                if cid:
                    channels.add(cid)
                if note:
                    notes.append(note)
                elif not cid and marker == "rss:":
                    notes.append("RSS 常年收割（rss_fleet 族，未列 named 渠道）")

    # 3) 整标签 / 前缀近似
    whole = LABEL_TO_CHANNEL.get(low)
    if whole:
        channels.add(whole[0])
        if whole[1]:
            notes.append(whole[1])
    head = low.split(":", 1)[0]
    pref = PREFIX_TO_CHANNEL.get(head)
    if pref:
        channels.add(pref[0])
        if pref[1]:
            notes.append(pref[1])

    # 只留在渠道清单内的命中 (别名表可能含清单外残留)
    channels &= set(table)
    return {"channels": sorted(channels), "notes": notes, "bases": sorted(set(bases))}


def _load_queue(path: Path) -> list[dict]:
    """读新建队列: [{"name","sop_step"}] 兼容纯字符串; 缺席/坏文件 → []."""
    try:
        data = json.loads(Path(path).read_text(encoding="utf-8"))
    except Exception:
        return []
    if not isinstance(data, list):
        return []
    out = []
    for it in data:
        if isinstance(it, str):
            out.append({"name": it})
        elif isinstance(it, dict) and it.get("name"):
            out.append({"name": str(it["name"]), "sop_step": it.get("sop_step")})
    return out


def scan(campaign: str, *, pool_root: Path | str | None = None,
         manifest_path: Path | str | None = None,
         queue_path: Path | str | None = None) -> dict:
    """扫描一战役 C 轴: 只读 pool_state/清单/队列, 返回账本节 dict (不落盘)."""
    root = Path(pool_root) if pool_root else DEFAULT_AMMO_ROOT
    manifest = Path(manifest_path) if manifest_path else DEFAULT_MANIFEST_PATH
    pool_state_path = root / campaign / "pool_state.json"
    if not pool_state_path.exists():
        raise FileNotFoundError(f"pool_state 不存在: {pool_state_path}")

    state = json.loads(pool_state_path.read_text(encoding="utf-8"))
    by_engine = state.get("by_engine") or {}

    channels = load_channels(manifest)
    fail_soft = not channels
    if fail_soft:  # 清单读不到 → 退化用池已见引擎清单 (全命中, 近似)
        channels = [{"id": k, "name": k} for k in sorted(by_engine)]

    table = _alias_table(channels)
    hit_chars: dict[str, int] = {}
    hit_engines: dict[str, list[str]] = {}
    engine_map: dict[str, dict] = {}
    zero_engines: list[str] = []
    for label, chars in by_engine.items():
        try:
            n = int(chars)
        except (TypeError, ValueError):
            n = 1 if chars else 0
        if n <= 0:
            zero_engines.append(str(label))
            continue
        res = resolve_engine(label, table)
        engine_map[str(label)] = res
        for cid in res["channels"]:
            hit_chars[cid] = hit_chars.get(cid, 0) + n
            hit_engines.setdefault(cid, []).append(str(label))

    hit_channels = [
        {"id": c["id"], "name": c.get("name", c["id"]),
         "chars": hit_chars[c["id"]], "engines": sorted(hit_engines[c["id"]])}
        for c in channels if c["id"] in hit_chars
    ]
    miss_detail = [{"id": c["id"], "name": c.get("name", c["id"])}
                   for c in channels if c["id"] not in hit_chars]
    miss_list = [m["name"] for m in miss_detail]
    total = len(channels)
    hitn = len(hit_channels)

    qpath = Path(queue_path) if queue_path else root / campaign / QUEUE_RELPATH
    queue = _load_queue(qpath)
    queue_keys = {_norm(q["name"]) for q in queue}
    # 队列里写渠道 id 也能对上 (miss 名/id 双口径匹配)
    miss_in_queue = [m["name"] for m in miss_detail
                     if _norm(m["name"]) in queue_keys or _norm(m["id"]) in queue_keys]
    miss_not_in_queue = [n for n in miss_list if n not in miss_in_queue]
    green = (not miss_list) or (not miss_not_in_queue)

    approx_notes = sorted({
        n for res in engine_map.values() for n in res["notes"]
    })
    unmapped_engines = sorted(
        l for l, res in engine_map.items() if not res["channels"]
    )

    return {
        "axis": AXIS,
        "sensor": SENSOR,
        "campaign": campaign,
        "channels_hit": hitn,
        "channels_total": total,
        "hit_ratio": round(hitn / total, 4) if total else 0.0,
        "hit_channels": hit_channels,
        "miss_list": miss_list,
        "miss_detail": miss_detail,
        "new_channel_queue": queue,
        "miss_in_queue": miss_in_queue,
        "miss_not_in_queue": miss_not_in_queue,
        "queue_path": str(qpath),
        "queue_present": Path(qpath).exists(),
        "green": green,
        "engine_map": engine_map,
        "unmapped_engines": unmapped_engines,
        "zero_char_engines": zero_engines,
        "approx_notes": approx_notes,
        "manifest": str(manifest),
        "fail_soft": fail_soft,
        "fail_soft_note": ("渠道清单不可读, 分母退化=池 by_engine 已见引擎清单(近似)"
                           if fail_soft else ""),
        "generated_at": datetime.now().astimezone().isoformat(timespec="seconds"),
    }


def write(result: dict, campaign: str, *, pool_root: Path | str | None = None) -> dict:
    """双产物落盘: completeness/C_axis.json (账本节) + 战役根 channel_matrix.json
    (taskgraph verify 镜像). 只增不删, 目录缺席则建."""
    root = Path(pool_root) if pool_root else DEFAULT_AMMO_ROOT
    cdir = root / campaign / "completeness"
    cdir.mkdir(parents=True, exist_ok=True)
    c_axis = cdir / "C_axis.json"
    mirror = root / campaign / "channel_matrix.json"
    text = json.dumps(result, ensure_ascii=False, indent=1)
    c_axis.write_text(text, encoding="utf-8", newline="\n")
    mirror.write_text(text, encoding="utf-8", newline="\n")
    return {"c_axis": str(c_axis), "mirror": str(mirror)}


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description="C 轴传感器: 渠道×主题命中矩阵与缺口清单 (只读扫描)")
    ap.add_argument("campaign", help="战役名, 如 EPC-BID26")
    ap.add_argument("--ammo-root", default=None, help="ammo_pool 根 (默认仓库默认)")
    ap.add_argument("--manifest", default=None, help="channel_manifest.json 路径覆盖")
    ap.add_argument("--queue", default=None, help="C_axis_queue.json 路径覆盖")
    ap.add_argument("--dry-run", action="store_true", help="只打印不落盘")
    args = ap.parse_args(argv)

    try:
        result = scan(args.campaign, pool_root=args.ammo_root,
                      manifest_path=args.manifest, queue_path=args.queue)
    except FileNotFoundError as e:
        print(f"[C轴] FAIL {e}", file=sys.stderr)
        return 2

    summary = {
        "campaign": result["campaign"],
        "channels_hit": result["channels_hit"],
        "channels_total": result["channels_total"],
        "hit_ratio": result["hit_ratio"],
        "green": result["green"],
        "miss_list": result["miss_list"],
        "miss_not_in_queue": result["miss_not_in_queue"],
        "fail_soft": result["fail_soft"],
    }
    print("[C轴] " + json.dumps(summary, ensure_ascii=False))
    print("[C轴] 缺口清单(前10): " + "、".join(result["miss_list"][:10]))

    if args.dry_run:
        print("[C轴] dry-run: 未落盘")
        return 0
    out = write(result, args.campaign, pool_root=args.ammo_root)
    print(f"[C轴] 落盘 {out['c_axis']} + 镜像 {out['mirror']}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
