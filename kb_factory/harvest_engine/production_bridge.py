# -*- coding: utf-8 -*-
"""产线渠道桥 production_bridge — KB-HARVEST E1（已收官收割引擎 → 研报产线调研渠道，1023 令）。

侦察锚点（2026-10-23 实测）：
- 产线渠道体系：``ammo_pool/<战役>/`` 三件——channel_matrix.json（C 轴传感器
  reforge_factory/completeness/channel_matrix.py 的 verify 镜像）、
  channel_invocations.jsonl（1022 宪法调用台账：绿判据=每渠道有调用记录即绿，
  收获另计零豁免，行 schema {channel,ts,tool,queries,yield,note}）、
  manifest.jsonl（弹药行，权威 schema = reforge_factory/ammo_pool.py ingest()）。
- 渠道注册：ResearchFactory-Eng/channel_manifest.json 的 named_channels
  （{id,name,runner,note}，建渠器 channel_builder 的 enlist 步入列）。
- 引擎出口（真符号）：adapters/{wenku,book118,doc88}.search(query, limit)
  → list[FileMeta]——wenku=syncmrecall 免登录（WenkuMetaAdapter 内置频控
  3s/日500，env KB_WENKU_*）；book118=.shtm 渲染需真浏览器过 SafeLine
  （匿名登录墙如实 []+reason，浏览器生命周期归调用方）；doc88=选品端点未定
  （search 抛 NotImplementedError）——如实跳过，零造假。

四件（任务卡口径）：
  ① ``search_channel(topic, limit) → list[FileMeta]``  三站检索聚合（频控复用
     RateLimiter 真符号：注入腿自带频控纪律；桥自建 book118 腿配桥级频控，
     env KB_BOOK118_MIN_INTERVAL/KB_BOOK118_DAILY_LIMIT，缺省 5s/日200）。
  ② ``to_pool_evidence(meta) → dict``  manifest 兼容线索行（键集对齐 ingest()
     恒有 15 键；dedup_key/url_norm 复用 ammo_pool 真符号逐字相等；黄线件
     perm=yellow 带 wall_status=WALL_PAID + form 形态标注）。线索行去重键走
     c:标题指纹支路——不占 u:URL 位，全文腿收割后同 URL ingest 不被线索行挡道。
  ③ ``channel_registration_row()`` 注册行生成（打印给建渠器 enlist 消费，本件
     不写 channel_manifest.json / channel_matrix.json）+
     ``append_invocation()`` 调用台账追加器（ammo_pool 只追加不改不删）。
  ④ CLI：``py -3 -m kb_factory.harvest_engine.production_bridge search "主题词"
     --pool EPC-OVERSEAS [--limit N] [--tree Q1-E1] [--commit]``——默认 dry-run，
     --commit 前 diff 预览；``register`` 子命令打印注册行。

纪律：ammo_pool 既有文件只追加不改动不删除（manifest 追加行不动 pool_state
计数器——门槛账只认 judge 判 valid，线索行恒 pending 不计账；pool_state 由
judge/rebuild 阶段从 manifest 全量重算）。judge 扫掠对 source_path="" 的线索行
如实落 file_missing 保持 pending（_judge_locked 既定语义，无碰撞）。
"""
from __future__ import annotations

import argparse
import contextlib
import json
import os
import re
import sys
import time
from dataclasses import dataclass, field
from pathlib import Path

_REPO_ROOT = Path(__file__).resolve().parents[2]           # E:\AI-Station
for _p in (str(_REPO_ROOT), str(_REPO_ROOT / "reforge_factory")):
    if _p not in sys.path:                                  # ammo_pool 同目录件(gates_loader/syndicate)绝对导入
        sys.path.insert(0, _p)

from kb_factory.channel_adapters.base import FileMeta, RateLimiter
from kb_factory.harvest_engine.adapters.base import WALL_PAID
from reforge_factory import ammo_pool as _pool_mod
from reforge_factory.ammo_pool import BUDGET_BANDS, authority, dedup_key, grade_authority, norm_url

#: 战役池名尺度（对齐 ammo_pool._camp_dir 在役池名口径）
_CAMPAIGN_RE = re.compile(r"[A-Za-z0-9_\-]{3,40}")

#: 渠道 id（C 轴传感器 resolve_engine 直接命中：引擎标签 "kb_harvest:wenku" 含
#: 本 id → 注册入列后即点亮；:后缀为站名，engine_detail 同构）。
CHANNEL_ID = "kb_harvest"
SITES = ("wenku", "book118", "doc88")
AMMO_ROOT = _REPO_ROOT / "ammo_pool"

LEAD_JUDGE_REASON = "kb_harvest检索线索: 元数据面, 待全文腿收割后另入池"


@dataclass
class BridgeReport:
    """单次聚合检索的逐站账（数字零造假：count=站实吐数，reason=站原话）。"""

    topic: str
    limit: int
    per_site: dict = field(default_factory=dict)   # site → {status,count,reason,elapsed_ms}
    total: int = 0                                 # 跨站去重后合并数


class ProductionBridge:
    """三站检索聚合桥（适配器/频控/浏览器全注入面，离线绝不真触网——scout_inject 先例）。

    - adapters：逐站注入（鸭子型 ``.search(query, limit)``）——注入即收窄站点集
      （离线单测零触网）；全缺省=三站全跑真件（wenku=WenkuDownloadAdapter，
      book118=Book118Adapter(browser=…)），doc88 真件 search 抛
      NotImplementedError（选品端点未定），如实跳过）。
    - browser：book118 真浏览器（调用方管 launch/close——适配器生命周期纪律，
      桥不自启浏览器；缺席则 book118 如实 no_browser 零请求）。
    - site_limiters：逐站频控注入；桥自建 book118 腿自动配桥级 RateLimiter
      （env 可调），注入腿默认不套桥级频控（自带频控纪律）。
    """

    def __init__(self, *, adapters: dict | None = None,
                 site_limiters: dict | None = None, browser=None):
        self._adapters = dict(adapters) if adapters else {}
        #: 注入即收窄站点集（离线零触网）；全缺省=三站全跑（CLI/实弹口径）。
        self._sites: tuple = tuple(self._adapters) or SITES
        self._limiters = dict(site_limiters) if site_limiters else {}
        self._browser = browser
        self.last_report: BridgeReport | None = None

    # ---- 适配器解析（惰性重导入：离线全注入用例零网络零重依赖） ----
    def _adapter(self, site: str):
        got = self._adapters.get(site)
        if got is not None:
            return got
        if site == "wenku":
            from kb_factory.harvest_engine.adapters.wenku import WenkuDownloadAdapter
            return WenkuDownloadAdapter()          # 内置频控: WenkuMetaAdapter limiter(env KB_WENKU_*)
        if site == "book118":
            from kb_factory.harvest_engine.adapters.book118 import Book118Adapter
            if "book118" not in self._limiters:    # 桥自建腿配桥级频控（频控复用真符号）
                self._limiters["book118"] = RateLimiter(
                    min_interval=float(os.environ.get("KB_BOOK118_MIN_INTERVAL", "5")),
                    daily_limit=int(os.environ.get("KB_BOOK118_DAILY_LIMIT", "200")),
                    name="book118_search")
            return Book118Adapter(browser=self._browser)
        if site == "doc88":
            from kb_factory.harvest_engine.adapters.doc88 import Doc88DownloadAdapter
            return Doc88DownloadAdapter()          # search 端点未定：零请求即抛，如实跳过
        raise KeyError(f"未知站点: {site!r}（合法={SITES}）")

    def search_channel(self, topic: str, limit: int = 10) -> list[FileMeta]:
        """三站检索聚合：逐站 search → 站点标注 → 跨站 URL/标题去重 → 合并列表。

        单站异常/未实装不炸链：doc88 NotImplementedError → skipped（端点未定，
        零请求）；他站异常 → error 如实留因；空结果 → empty + 适配器 reason 原话。
        """
        limit_n = max(1, int(limit))
        per_site: dict[str, dict] = {}
        merged: list[FileMeta] = []
        seen_urls: set[str] = set()
        seen_titles: set[str] = set()
        for site in self._sites:
            t0 = time.monotonic()
            adapter = self._adapter(site)
            limiter = self._limiters.get(site)
            try:
                if limiter is not None:
                    limiter.acquire()
                metas = list(adapter.search(topic, limit_n) or [])
            except NotImplementedError as exc:      # doc88 选品端点未定（既定形态）
                per_site[site] = {"status": "skipped", "count": 0,
                                  "reason": f"{type(exc).__name__}: {exc}"[:160],
                                  "elapsed_ms": int((time.monotonic() - t0) * 1000)}
                continue
            except Exception as exc:                # noqa: BLE001 —— 单站故障隔离，如实留因
                per_site[site] = {"status": "error", "count": 0,
                                  "reason": f"{type(exc).__name__}: {exc}"[:160],
                                  "elapsed_ms": int((time.monotonic() - t0) * 1000)}
                continue
            reason = ""
            if not metas:
                # 适配器 reason 鸭子型两态：ChannelAdapter.reason() 方法 /
                # Book118Adapter.reason property——一律取站原话，不冒充
                r = getattr(adapter, "reason", "")
                if callable(r):
                    r = r()
                reason = str(r) or "empty_result"
            for m in metas:
                if isinstance(m.extra, dict):
                    m.extra["kb_harvest_site"] = site
                u = norm_url(m.source_url) if m.source_url else ""
                t = (m.title or "").strip()
                if u:
                    if u in seen_urls:
                        continue                     # 跨站同 URL 镜像去重
                    seen_urls.add(u)
                else:
                    if t and t in seen_titles:
                        continue
                    if t:
                        seen_titles.add(t)
                merged.append(m)
            per_site[site] = {"status": "ok" if metas else "empty", "count": len(metas),
                              "reason": reason,
                              "elapsed_ms": int((time.monotonic() - t0) * 1000)}
        self.last_report = BridgeReport(topic=topic, limit=limit_n,
                                        per_site=per_site, total=len(merged))
        return merged


def search_channel(topic: str, limit: int = 10, **bridge_kwargs) -> list[FileMeta]:
    """模块级便捷口：一次性三站聚合（逐站账在 ``ProductionBridge().last_report``）。"""
    return ProductionBridge(**bridge_kwargs).search_channel(topic, limit)


# ---------------------------------------------------------------- ② 入池线索行

def to_pool_evidence(meta: FileMeta, *, tree_node: str = "", stance: str = "support",
                     band: str = "", ts: str | None = None) -> dict:
    """FileMeta → ammo_pool manifest 兼容线索行（judge=pending 不计账——池铁律 3）。

    - 键集对齐 ingest() 恒有键；dedup_key/url_norm 复用 ``reforge_factory.ammo_pool``
      真符号逐字相等（绝不禁公式分叉）。线索行去重键走 c:标题指纹支路
      （标题=检索面唯一真实内容），不占 u:URL 位——全文腿收割后同 URL ingest
      不被本行挡道。
    - 黄线件（perm=yellow）带 wall_status=WALL_PAID（NFR1 统一标记映射）+ form
      形态标注（search_lead=检索级线索，meta_fmt/pages/badge 如实转记，渠道
      无字段如实 None）。
    - source_path=""（无本地文件）：judge 扫掠如实落 file_missing 保持 pending。
    - band：预算分档三档真符号校验（BUDGET_BANDS 直引；非法值归 ""=未归档）。
    """
    site = str((meta.extra or {}).get("kb_harvest_site") or "_untagged")
    url = (meta.source_url or "").strip()
    title = (meta.title or "").strip()
    row = {
        "ts": ts or time.strftime("%Y-%m-%dT%H:%M:%S"),
        "engine": f"{CHANNEL_ID}:{site}",
        "source_path": "",
        "url_norm": norm_url(url) if url else "",
        "chars": 0,                                # 检索级线索零内容（数字零造假）
        "credibility": "unknown",
        "dedup_key": dedup_key(None, title or url or f"{site}:untitled"),
        "judge": "pending",
        "judge_reason": LEAD_JUDGE_REASON,
        "judge_engine": "",
        "tree_node": tree_node,
        "stance": stance,
        "budget_band": band if band in BUDGET_BANDS else "",   # 真符号直引（ingest 同款口径）
        "text_head": title[:500],                  # FT-4: 标题=唯一真实内容
        "wall_status": WALL_PAID if (meta.perm or "").lower() == "yellow" else None,
        "form": "search_lead",                     # 形态标注: 检索级线索（非全文）
        "meta_fmt": meta.fmt,
        "meta_pages": meta.pages,
        "meta_badge": meta.badge,
        "engine_detail": f"{CHANNEL_ID}:{site}:search",
    }
    if authority is not None:                      # FT-5 两键（缺件缺键不炸——ingest 同款）
        score = int(authority(url or title).get("score", 3))
        row["authority_score"] = score
        row["authority_grade"] = grade_authority(score)
    return row


# ---------------------------------------------------------------- ③ 注册行 + 调用台账

def channel_registration_row() -> dict:
    """channel 注册行生成器：{id,name,runner,note} 对齐建渠器 RECIPES manifest 底稿。

    本件只生成不落盘——入列（enlist，幂等只增）归 reforge_factory/channel_builder.py；
    C 轴传感器分母读 ResearchFactory-Eng/channel_manifest.json 的 named_channels。
    """
    return {
        "id": CHANNEL_ID,
        "name": "KB-HARVEST 收割引擎检索(wenku/book118/doc88 三站聚合)",
        "runner": ("kb_factory/harvest_engine/production_bridge.py::search_channel "
                   "(wenku syncmrecall免登录+book118 .shtm真浏览器渲染+doc88端点未定如实跳过)"),
        "note": ("E1产线桥(1023): 检索级线索入池(judge=pending不计账,全文腿收割后另入池); "
                 "调用即绿收获另计(1022宪法); 频控复用RateLimiter(wenku内置,book118桥级5s/日200)"),
    }


def invocation_row(topic: str, report: BridgeReport) -> dict:
    """调用台账行：{channel,ts,tool,queries,yield,note} 六键对齐 1022 宪法台账。"""
    parts = "/".join(f"{s}:{report.per_site.get(s, {}).get('count', 0)}" for s in SITES)
    notes = []
    for s in SITES:
        st = report.per_site.get(s, {})
        if st.get("status") != "ok":
            notes.append(f"{s}={st.get('status', 'absent')}:{str(st.get('reason', ''))[:60]}")
    return {
        "channel": CHANNEL_ID,
        "ts": time.strftime("%Y-%m-%d %H:%M:%S"),
        "tool": "kb_factory.harvest_engine.production_bridge search_channel(三站聚合)",
        "queries": topic,
        "yield": f"{report.total}条检索线索({parts})",
        "note": "; ".join(notes),
    }


def append_invocation(row: dict, *, ledger: Path, commit: bool = False) -> bool:
    """调用台账追加器：只增一行不改不删；dry-run（commit=False）零落盘。"""
    if not commit:
        return False
    ledger = Path(ledger)
    ledger.parent.mkdir(parents=True, exist_ok=True)
    with ledger.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(row, ensure_ascii=False) + "\n")
    return True


@contextlib.contextmanager
def default_browser_scope():
    """CLI 缺省浏览器腿：无头 Chromium 直连（book118 实测先例：裸 args
    ``--proxy-server=direct://`` 防本机系统代理劫持）。启动失败如实 yield None
    （book118 退 no_browser 零请求，不造假）；生命周期本 scope 管。"""
    pw = browser = None
    try:
        from playwright.sync_api import sync_playwright
        pw = sync_playwright().start()
        browser = pw.chromium.launch(headless=True, args=["--proxy-server=direct://"])
    except Exception as exc:                       # noqa: BLE001 —— 浏览器缺席如实降级
        print(f"[bridge] 浏览器腿缺席(如实): {type(exc).__name__}: {exc}", file=sys.stderr)
        if pw is not None:
            with contextlib.suppress(Exception):
                pw.stop()
        pw = browser = None
    try:
        yield browser
    finally:
        if browser is not None:
            with contextlib.suppress(Exception):
                browser.close()
        if pw is not None:
            with contextlib.suppress(Exception):
                pw.stop()


# ---------------------------------------------------------------- ④ CLI

def _run_search(bridge: ProductionBridge, args: argparse.Namespace) -> int:
    metas = bridge.search_channel(args.topic, args.limit)
    report = bridge.last_report
    rows = [to_pool_evidence(m, tree_node=args.tree, band=args.band) for m in metas]

    print(f"[bridge] 三站聚合 topic={args.topic!r} limit={args.limit}")
    for site in SITES:
        st = report.per_site.get(site, {"status": "absent", "count": 0,
                                        "reason": "", "elapsed_ms": 0})
        print(f"[bridge]   {site:<8} {st.get('status'):<8} count={st.get('count', 0)}"
              f"  {st.get('reason', '')}  ({st.get('elapsed_ms', 0)}ms)")
    print(f"[bridge] 合并去重后 {report.total} 条")

    pool_dir = (Path(args.pool_root) if args.pool_root else AMMO_ROOT) / args.pool
    mp = pool_dir / "manifest.jsonl"
    ledger = pool_dir / "channel_invocations.jsonl"

    # diff 预览（纪律：--commit 前必打）
    existing: set = set()
    if mp.is_file():
        with contextlib.suppress(OSError, json.JSONDecodeError):
            existing = {json.loads(x).get("dedup_key")
                        for x in mp.read_text(encoding="utf-8").splitlines() if x.strip()}
    fresh = [r for r in rows if r["dedup_key"] not in existing]
    print(f"[bridge] 入池预览: 新增 {len(fresh)} 行 / 查重跳过 {len(rows) - len(fresh)} 行 → {mp}")
    for r in fresh:
        print("  + " + json.dumps(r, ensure_ascii=False))
    inv = invocation_row(args.topic, report)
    print(f"[bridge] 台账预览: +1 行 → {ledger}")
    print("  + " + json.dumps(inv, ensure_ascii=False))

    if not args.commit:
        print("[bridge] dry-run: 未落盘（--commit 才追加）")
        return 0
    if not pool_dir.is_dir():
        print(f"[bridge] 拒写: 战役池不存在 {pool_dir}（不静默建池，产线资产纪律）",
              file=sys.stderr)
        return 2

    # 落盘（ammo_pool 只追加：manifest 持池锁查重追加；台账每次调用如实一行）
    with _pool_mod._pool_lock(pool_dir):           # 跨进程池锁真符号复用（O_EXCL 范式）
        keys = _pool_mod._manifest_keys(pool_dir)
        fresh = [r for r in rows if r["dedup_key"] not in keys]
        with mp.open("a", encoding="utf-8") as f:
            for r in fresh:
                f.write(json.dumps(r, ensure_ascii=False) + "\n")
    append_invocation(inv, ledger=ledger, commit=True)
    print(f"[bridge] 已落盘: manifest +{len(fresh)} 行"
          f"（查重跳过 {len(rows) - len(fresh)}）/ 台账 +1 行")
    return 0


def _build_parser() -> argparse.ArgumentParser:
    ap = argparse.ArgumentParser(
        prog="py -3 -m kb_factory.harvest_engine.production_bridge",
        description="KB-HARVEST E1 产线桥：收割引擎三站检索 → 研报产线调研渠道")
    sub = ap.add_subparsers(dest="cmd", required=True)
    sp = sub.add_parser("search", help="三站聚合检索（默认 dry-run，--commit 才追加）")
    sp.add_argument("topic", help="检索主题词")
    sp.add_argument("--pool", required=True, help="战役池名（ammo_pool/<pool>）")
    sp.add_argument("--limit", type=int, default=10, help="单站检索上限（缺省 10）")
    sp.add_argument("--tree", default="", help="挂树节点（question_tree 如 Q23-E1）")
    sp.add_argument("--band", default="", choices=[""] + list(BUDGET_BANDS),
                    help="预算分档（S2-2 三档；缺省空=未归档）")
    sp.add_argument("--commit", action="store_true",
                    help="落盘（manifest 线索行+调用台账；默认 dry-run 零落盘）")
    sp.add_argument("--pool-root", default=None,
                    help="ammo_pool 根覆盖（测试/演练用；缺省 E:\\AI-Station\\ammo_pool）")
    rp = sub.add_parser("register", help="打印渠道注册行（建渠器 enlist 消费）")
    rp.add_argument("--json", action="store_true", help="单行 JSON 输出（机读）")
    return ap


def main(argv: list | None = None, *, bridge: ProductionBridge | None = None) -> int:
    """CLI 入口（bridge 注入口=单测确定性；缺席则真三站+缺省浏览器腿）。"""
    if sys.stdout:                                  # pythonw 无控制台守卫（ammo_pool 先例）
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    args = _build_parser().parse_args(argv)
    if args.cmd == "register":
        row = channel_registration_row()
        print(json.dumps(row, ensure_ascii=False) if args.json
              else json.dumps(row, ensure_ascii=False, indent=1))
        return 0
    if not _CAMPAIGN_RE.fullmatch(args.pool):
        print(f"[bridge] 非法池名: {args.pool!r}（合法=[A-Za-z0-9_-]{{3,40}}）",
              file=sys.stderr)
        return 2
    if bridge is not None:
        return _run_search(bridge, args)
    with default_browser_scope() as browser:
        return _run_search(ProductionBridge(browser=browser), args)


if __name__ == "__main__":
    raise SystemExit(main())
