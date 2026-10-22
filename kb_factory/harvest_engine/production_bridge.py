# -*- coding: utf-8 -*-
"""production_bridge — E1 产线渠道桥：收割引擎接入研报产线调研渠道（1023 用户令）。

把已收官的 KB-HARVEST 收割引擎（wenku/book118/doc88 三站 search 段）接入
ammo_pool 调研渠道体系，四件套：

①``search_channel(topic, limit)`` → ``list[FileMeta]``：三站检索聚合（fail-soft
  逐站；envelope/频控复用引擎内建——wenku syncmrecall 免登录 + WenkuMetaAdapter
  自带 RateLimiter（间隔/日上限/熔断）；book118 匿名登录墙如实 ``[]``+reason；
  doc88 段1未建如实 NotImplementedError 记因不炸链）。黄线件（perm=yellow，
  wenku sellType VIP 实测口径）统一落 ``wall_status=paid_wall``（NFR1 落点）。
②``to_pool_evidence(meta)`` → ammo_pool manifest 兼容条目：与
  ``reforge_factory/ammo_pool.py::ingest`` 行 15 核心键逐键同构（真符号
  ``norm_url``/``dedup_key``/``BUDGET_BANDS`` 直引不复制）；检索线索=元数据层
  （chars=0、judge=pending、source_path 空——全文未取零造假，门槛账零污染）；
  黄线件加性键 wall_status+form 形态标注。侦察实证（2026-10-23，EPC-OVERSEAS
  25035 行在役账）：manifest 行**无**行级 tier/axis 键——tier 由 tiers.json 词表
  ×标题在 tier_report 读时派生、axis 在 completeness/C_axis.json 传感账，本桥
  不发明行级键（防双源漂移）。
③``registration_row()``（named_channels 底稿，channel_builder enlist 同格式
  {id,name,runner,note}，入列归编排层/建渠器）+ ``invocation_row()``/
  ``append_invocations()``（channel_invocations.jsonl 追加器，对齐
  ``legs/constitution_invoke_sweep.py::log_inv`` 键序 {channel,ts,tool,queries,
  yield,note}——1022 宪法：调用是义务，收获另计，yield=0 也算调用）。
④CLI：``py -3 -m kb_factory.harvest_engine.production_bridge search "主题词"
  --pool EPC-OVERSEAS``——检索→证据条目打印；默认 dry-run（零落盘），``--commit``
  才追加 manifest/channel 账，且**只追加不改动不删除**（产线在役资产铁律），
  追加前打印 diff 预览。

纪律：ammo_pool 既有文件只追加；战役池不存在时 --commit 拒写（不静默建池）；
ammo_pool 真符号经 reforge_factory 路径惰性导入（同 harvest_lark 等产线腿先例）。
"""
from __future__ import annotations

import argparse
import contextlib
import json
import re
import sys
import time
from dataclasses import dataclass, asdict
from pathlib import Path

_REPO = Path(__file__).resolve().parents[2]
_DEFAULT_POOL_ROOT = _REPO / "ammo_pool"

try:                                    # 合并树正名 kb_factory.*；worktree 阶段回退
    from kb_factory.channel_adapters.base import FileMeta
    from kb_factory.harvest_engine.adapters.base import (WALL_PAID,
                                                         mark_wall_status)
except ImportError:                     # pragma: no cover - worktree 路径
    from channel_adapters.base import FileMeta  # type: ignore
    from harvest_engine.adapters.base import (WALL_PAID,  # type: ignore
                                              mark_wall_status)

#: 渠道 id（named_channels 注册名；engine 标签 ``kb_harvest:<site>`` 经 C 轴
#: 传感器别名表子串命中点亮本渠道——与 lark:docs 先例同构）。
CHANNEL_ID = "kb_harvest"
#: 三站检索聚合面（wenku=免登录实弹；book118=匿名墙态；doc88=段1未建）。
SITES = ("wenku", "book118", "doc88")

_CAMPAIGN_RE = re.compile(r"[A-Za-z0-9_\-]{3,40}")   # 与 ammo_pool._camp_dir 同尺

_AMMO = None                            # 惰性真符号缓存


def _ammo_pool():
    """产线真符号惰性装载（reforge_factory 入 sys.path 后 import，腿先例同构）。"""
    global _AMMO
    if _AMMO is None:
        p = str(_REPO / "reforge_factory")
        if p not in sys.path:
            sys.path.insert(0, p)
        import ammo_pool
        _AMMO = ammo_pool
    return _AMMO


# ---------------------------------------------------------------- 数据形态

@dataclass
class SiteOutcome:
    """单站检索结果账（零造假：n=实得条数；reason=墙/未建/异常如实记）。"""

    site: str
    ok: bool            # 检索调用完成（0 条=收获另计，非失败）
    n: int
    reason: str         # ""=正常；login_gated/empty_result/not_implemented:…/异常名


@dataclass
class SearchReport:
    """三站聚合报告（CLI/调用账消费；outcomes 逐站一行）。"""

    topic: str
    limit: int
    outcomes: list
    total: int = 0


# ---------------------------------------------------------------- 段1 检索聚合

def build_search_adapters(sites=SITES, *, browser=None):
    """按站点集构造适配器注册表（orchestrator default_adapters 三件同款真身）。"""
    try:
        from kb_factory.harvest_engine.adapters.book118 import Book118Adapter
        from kb_factory.harvest_engine.adapters.doc88 import Doc88DownloadAdapter
        from kb_factory.harvest_engine.adapters.wenku import WenkuDownloadAdapter
    except ImportError:                 # pragma: no cover - worktree 路径
        from harvest_engine.adapters.book118 import Book118Adapter  # type: ignore
        from harvest_engine.adapters.doc88 import Doc88DownloadAdapter  # type: ignore
        from harvest_engine.adapters.wenku import WenkuDownloadAdapter  # type: ignore
    out = {}
    for site in sites:
        if site == "wenku":
            out[site] = WenkuDownloadAdapter()      # syncmrecall 免登录+内建频控
        elif site == "book118":
            out[site] = Book118Adapter(browser=browser)   # 无 browser→no_browser 墙态
        elif site == "doc88":
            out[site] = Doc88DownloadAdapter()      # 段1未建（search 抛 NotImplementedError）
    return out


def search_channel(topic, limit=10, *, adapters=None, sites=SITES, report=None):
    """三站检索聚合 → list[FileMeta]（fail-soft 逐站；envelope/频控复用内建）。

    - 每站恰一次 ``search(topic, limit)``（频控/信封在适配器内建，本层不重写）；
    - ``meta.extra["site"]`` 标注来源站；黄线件（perm=yellow）统一
      ``mark_wall_status(meta, WALL_PAID)``（NFR1 统一落点，已有墙标不覆盖）；
    - report（可选 out 参数）：SearchReport——逐站 SiteOutcome，CLI 调用账消费；
    - 站点墙/未建/熔断不炸链：结果如实进 outcomes（调用已发生，收获另计）。
    """
    if adapters is None:
        adapters = build_search_adapters(sites)
    metas: list = []
    outcomes: list = []
    for site in sites:
        ad = adapters.get(site) if adapters else None
        if ad is None:
            outcomes.append(SiteOutcome(site, False, 0, "adapter_not_registered"))
            continue
        try:
            got = list(ad.search(topic, limit) or [])
        except NotImplementedError as exc:
            outcomes.append(
                SiteOutcome(site, False, 0, f"not_implemented:{str(exc)[:60]}"))
            continue
        except Exception as exc:        # 频控熔断/网络异常——调用尝试如实记因
            outcomes.append(
                SiteOutcome(site, False, 0, f"{type(exc).__name__}:{str(exc)[:60]}"))
            continue
        reason = str(getattr(ad, "_reason", "") or getattr(ad, "reason", "") or "")
        for m in got:
            m.extra.setdefault("site", site)
            if getattr(m, "perm", "green") == "yellow" and "wall_status" not in m.extra:
                mark_wall_status(m, WALL_PAID)
            metas.append(m)
        outcomes.append(SiteOutcome(site, True, len(got), reason))
    rep = SearchReport(topic=topic, limit=limit, outcomes=outcomes, total=len(metas))
    if isinstance(report, dict):
        report.update({"topic": rep.topic, "limit": rep.limit,
                       "outcomes": rep.outcomes, "total": rep.total})
    elif report is not None:
        report.append(rep)
    return metas


# ---------------------------------------------------------------- 段2 证据条目

def to_pool_evidence(meta, *, tree="", stance="support", band="", ts=None):
    """FileMeta → ammo_pool manifest 兼容条目（ingest 行 15 核心键逐键同构）。

    - engine = ``kb_harvest:<site>``（C 轴传感器子串命中渠道，lark:docs 先例）；
    - 检索线索=元数据层：chars=0/judge=pending/source_path=""（全文未取零造假；
      门槛账只认 valid，pending 零污染；judge 轮对缺失文件如实 file_missing 留审）；
    - url_norm/dedup_key/BUDGET_BANDS 直引产线真符号（跨引擎去重不漂移）；
    - 加性键：form="search_lead"（形态标注）；黄线件另带 wall_status（统一标记）。
    """
    ap = _ammo_pool()
    site = str(meta.extra.get("site") or meta.extra.get("site_name") or "unknown")
    url = meta.extra.get("canonical_url") or meta.source_url or None
    if getattr(meta, "perm", "green") == "yellow" and "wall_status" not in meta.extra:
        mark_wall_status(meta, WALL_PAID)   # 转换层自足（未经 search_channel 亦标注）
    row = {
        "ts": ts or time.strftime("%Y-%m-%dT%H:%M:%S"),
        "engine": f"{CHANNEL_ID}:{site}",
        "source_path": "",                       # 检索线索无本地文件（不造假路径）
        "url_norm": ap.norm_url(url) if url else "",
        "chars": 0,                              # 元数据层：全文未取，零字如实
        "credibility": "unknown",                # 未验证（judge 轮再定级）
        "dedup_key": ap.dedup_key(url, meta.title or ""),
        "judge": "pending",                      # 入池即待审（门槛账零污染铁律）
        "judge_reason": "",
        "judge_engine": "",
        "tree_node": tree,
        "stance": stance,
        "budget_band": band if band in ap.BUDGET_BANDS else "",
        "text_head": (meta.title or "")[:500],   # 唯一实有文本=标题（不造内容）
        "form": "search_lead",                   # 形态标注（任务卡：黄线件带形态）
    }
    wall = meta.extra.get("wall_status")
    if wall:
        row["wall_status"] = wall                # 黄线件统一墙标（WALL_STATUS_MARKERS）
    return row


# ---------------------------------------------------------------- 段3 注册行/调用账

def registration_row():
    """named_channels 注册行底稿（channel_builder enlist 同格式；入列归编排层）。"""
    return {
        "id": CHANNEL_ID,
        "name": "KB-HARVEST 收割引擎(文库/book118/doc88 检索聚合)",
        "runner": ("kb_factory/harvest_engine/production_bridge.py::search_channel "
                   "(三站 search 段聚合; 频控/信封/审计复用引擎内建)"),
        "note": ("E1 产线桥(1023令): 检索线索入池(judge=pending,chars=0,门槛账零污染); "
                 "全文收割走引擎 orchestrator 四段; 入列走 channel_builder enlist"),
    }


def invocation_row(topic, report, *, new_count=0, ts=None, tool=None):
    """channel_invocations.jsonl 行（log_inv 键序同构；调用是义务收获另计）。"""
    if not isinstance(report, SearchReport):
        report = SearchReport(topic=str(report.get("topic", topic)),
                              limit=int(report.get("limit", 0)),
                              outcomes=list(report.get("outcomes", ())),
                              total=int(report.get("total", 0)))
    parts = ", ".join(f"{o.site}:{o.n}" for o in report.outcomes)
    note = "; ".join(f"{o.site}:{o.reason}" for o in report.outcomes
                     if (not o.ok) or o.reason)
    return {
        "channel": CHANNEL_ID,
        "ts": ts or time.strftime("%Y-%m-%dT%H:%M:%S").replace("T", " "),
        "tool": tool or ("production_bridge.search_channel "
                         "(wenku+book118+doc88 三站检索聚合)"),
        "queries": topic,
        "yield": (f"{report.total}件检索线索({parts}); "
                  f"新增入池{new_count}行(元数据层pending,门槛账零污染)"),
        "note": note,
    }


# ---------------------------------------------------------------- 段4 追加器（只追加）

def _pool_dir(pool_root, campaign):
    if not _CAMPAIGN_RE.fullmatch(campaign or ""):
        raise ValueError(f"非法 campaign_id: {campaign!r}（ammo_pool 同尺）")
    return Path(pool_root) / campaign


def filter_new(entries, manifest_path):
    """manifest 既有 dedup_key 查重 + 批内查重 → (新条目, 跳过数)。"""
    mp = Path(manifest_path)
    seen: set = set()
    if mp.is_file():
        for line in mp.read_text(encoding="utf-8").splitlines():
            if not line.strip():
                continue
            try:
                k = json.loads(line).get("dedup_key", "")
            except json.JSONDecodeError:
                continue
            if k:
                seen.add(k)
    new, skipped = [], 0
    for e in entries:
        k = e.get("dedup_key", "")
        if k and k in seen:
            skipped += 1
            continue
        if k:
            seen.add(k)
        new.append(e)
    return new, skipped


def append_manifest(pool_dir, entries, *, skipped=0, dry_run=True):
    """manifest.jsonl 追加器：diff 预览先行；只追加不改动（dry_run=True 零落盘）。"""
    pool_dir = Path(pool_dir)
    mp = pool_dir / "manifest.jsonl"
    n_before = 0
    if mp.is_file():
        n_before = sum(1 for x in mp.read_text(encoding="utf-8").splitlines()
                       if x.strip())
    print(f"[bridge] manifest 追加预览: {mp} 现有 {n_before} 行 → "
          f"拟追加 {len(entries)} 行 (查重跳过 {skipped})")
    for e in entries:
        print("+ " + json.dumps(e, ensure_ascii=False))
    if dry_run:
        return {"appended": 0, "skipped": skipped, "path": str(mp),
                "lines_before": n_before}
    if entries:
        with mp.open("a", encoding="utf-8") as f:      # 与 ammo_pool.ingest 同开法
            for e in entries:
                f.write(json.dumps(e, ensure_ascii=False) + "\n")
    return {"appended": len(entries), "skipped": skipped, "path": str(mp),
            "lines_before": n_before}


def append_invocations(pool_dir, rows, *, dry_run=True):
    """channel_invocations.jsonl 追加器：预览先行；只追加（1022 宪法调用账）。"""
    pool_dir = Path(pool_dir)
    ip = pool_dir / "channel_invocations.jsonl"
    print(f"[bridge] 调用账预览: {ip} +{len(rows)} 行")
    for r in rows:
        print("+ " + json.dumps(r, ensure_ascii=False))
    if dry_run:
        return {"appended": 0, "path": str(ip)}
    with ip.open("a", encoding="utf-8") as f:
        for r in rows:
            f.write(json.dumps(r, ensure_ascii=False) + "\n")
    return {"appended": len(rows), "path": str(ip)}


# ---------------------------------------------------------------- 段5 CLI

def _parse(argv):
    ap = argparse.ArgumentParser(
        prog="py -3 -m kb_factory.harvest_engine.production_bridge",
        description="E1 产线渠道桥：收割引擎三站检索 → ammo_pool 调研渠道")
    ap.add_argument("cmd", choices=["search"], help="子命令")
    ap.add_argument("topic", help="检索主题词")
    ap.add_argument("--pool", default="EPC-OVERSEAS", help="战役池名")
    ap.add_argument("--pool-root", default=str(_DEFAULT_POOL_ROOT),
                    help="ammo_pool 根（测试注入用）")
    ap.add_argument("--limit", type=int, default=10, help="每站检索上限")
    ap.add_argument("--sites", default=",".join(SITES),
                    help="站点集（逗号分隔，默认三站）")
    ap.add_argument("--commit", action="store_true",
                    help="落盘追加（默认 dry-run 零落盘）")
    ap.add_argument("--tree", default="", help="挂树 EEI id（如 Q23-E1）")
    ap.add_argument("--stance", default="support",
                    choices=["support", "against", "contradict"], help="ACH 立场")
    ap.add_argument("--band", default="",
                    choices=["", "outline_wide", "section_narrow", "gap"],
                    help="预算分档（S2-2 三档）")
    ap.add_argument("--no-browser", action="store_true",
                    help="不起 Playwright（book118 检索记 no_browser 墙态）")
    return ap.parse_args(argv)


@contextlib.contextmanager
def _launch_search_browser():
    """CLI 自起 Playwright headless（book118 真浏览器腿；失败 fail-soft 降 None）。"""
    pw = browser = None
    try:
        from playwright.sync_api import sync_playwright
        pw = sync_playwright().start()
        browser = pw.chromium.launch(headless=True)
    except Exception as exc:
        print(f"[bridge] Playwright 自起失败（book118 将记墙态）: "
              f"{type(exc).__name__}")
        browser = None
    try:
        yield browser
    finally:
        if browser is not None:
            with contextlib.suppress(Exception):
                browser.close()
        if pw is not None:
            with contextlib.suppress(Exception):
                pw.stop()


def _run(args, sites, adapters) -> int:
    report: dict = {}
    metas = search_channel(args.topic, args.limit, adapters=adapters,
                           sites=sites, report=report)
    for o in report["outcomes"]:
        state = "ok" if o.ok else "fail"
        wall = f" [{o.reason}]" if o.reason or not o.ok else ""
        print(f"[bridge] {o.site} {state} {o.n}条{wall}")
    entries = [to_pool_evidence(m, tree=args.tree, stance=args.stance,
                                band=args.band) for m in metas]
    for e in entries:
        print("[evidence] " + json.dumps(e, ensure_ascii=False))
    print("[bridge] 渠道注册行(named_channels 底稿, 入列走 channel_builder): "
          + json.dumps(registration_row(), ensure_ascii=False))

    try:
        pool_dir = _pool_dir(args.pool_root, args.pool)
    except ValueError as exc:
        print(f"[bridge] {exc}")
        return 2
    if args.commit and not pool_dir.is_dir():
        print(f"[bridge] 拒写: 战役池不存在 {pool_dir}（不静默建池，产线资产纪律）")
        return 2
    new, skipped = filter_new(entries, pool_dir / "manifest.jsonl")
    stats = append_manifest(pool_dir, new, skipped=skipped,
                            dry_run=not args.commit)
    inv = invocation_row(args.topic, report, new_count=len(new))
    append_invocations(pool_dir, [inv], dry_run=not args.commit)
    if not args.commit:
        print("[bridge] dry-run: 未落盘（--commit 才追加 manifest/channel 账）")
    else:
        print(f"[bridge] 已追加 manifest +{stats['appended']} 行 / "
              f"channel_invocations +1 行 (只追加不改动)")
    return 0


def main(argv=None, *, adapters=None) -> int:
    """CLI 入口（adapters 注入口=测试确定性；缺省三站真身+book118 自起浏览器）。"""
    if sys.stdout:                       # Windows cp936 控制台守卫（pytest 捕获安全）
        with contextlib.suppress(Exception):
            sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    args = _parse(argv)
    sites = tuple(s.strip() for s in args.sites.split(",") if s.strip())
    if adapters is not None:
        return _run(args, sites, adapters)
    if "book118" in sites and not args.no_browser:
        with _launch_search_browser() as browser:
            built = build_search_adapters(sites, browser=browser)
            return _run(args, sites, built)
    return _run(args, sites, build_search_adapters(sites))


if __name__ == "__main__":
    raise SystemExit(main())
