# -*- coding: utf-8 -*-
"""live_progress —— 真调研任务实时进度件（KB-FACTORY 2.0 轴⑤·D 直播升级配套）。

背景（1026 用户全批「直接开发到 2.0」）：kb_server 三段直播原只有段位布尔
（researching/structuring/done），段一收割阻塞期间前端拿不到任何渠道计数——
本件补齐两条真值进度线（接线方=kb_server._make_staged_harvest，惰性载入）：

  ① channels_live（段一收割期间，轮询式）：收割腿阻塞运行时，每 interval 秒
     （生产 5s）从渠道编排池共用的审计 jsonl 尾部**增量**读取本任务查询词命中
     的 pool_query 行，按渠道累加 count → {channel: n}。
       - 增量口径：收割起点字节偏移之后追加的行才计（历史旧行/别次收割一概
         不计，起点偏移=收割调用前的文件 EOF）；
       - 行属主判定：行内 query ∈ 本任务查询词集（并发任务查询词不同即不串账；
         同文并发任务理论上可能交叉计数——段一计数为直播预览性质，终值以收割
         返回实测为准，kb_server 侧 provenance 照实记终值，如实注明不冒充）；
       - 只认 event=pool_query 行（count=该次查询实收件数，可加总）；
         stopped/timeout/degrade 等行 count 为累计口径不可加，一概不认；
       - 尾部无换行的残行不计（偏移停在残行起点，下次补齐后整行入账）。
  ② clusters_forming（段二建树期间，预览式）：收割返回瞬间用真实池跑
     evidence_tree.cluster_pool（与建树同一确定性聚类纯函数，同池同簇零漂移）
     取簇名列表——done 前的「正在形成 N 个主题分组」预览（N=列表长度）。

纪律（逐条在案）：
  - 零造假：计数只来自实测事实（审计行 count 实数/真实池聚类结果），拿不到
    如实不带（返回空/None），禁一切手填；
  - 只读不改：本件绝不写审计文件、不改收割结果、不碰 engine.py 既有开关；
  - 直播腿绝不影响主链：一切内部异常如实吞并降级（停线/无预览），不上抛；
  - 纯 stdlib（json/os/threading/time），云端 python:3-slim 零三方包同口径。
"""
from __future__ import annotations

import json
import os
import threading
import time

__all__ = ["read_audit_tail", "aggregate_live_counts", "flatten_pool_result",
           "clusters_preview", "default_audit_path", "LiveAuditPoller"]

LIVE_PROGRESS_VERSION = "live-progress/1.0.0"

# 轮询间隔下限（秒）：测试可注入更小间隔提速，但不允许零/负值忙转
MIN_POLL_INTERVAL = 0.05


def _p(text: str) -> None:
    """统一打印（Windows 控制台编码受限时降级替换不崩，口径同 evidence_cli）。"""
    try:
        print(text)
    except UnicodeEncodeError:
        print(text.encode("ascii", "replace").decode("ascii"))


def default_audit_path():
    """渠道编排池默认审计文件位（生产链 pool.harvest_pool 不注 audit 时写此处）。
    双导入形态同 evidence_cli 契约候选：包全路径优先，sys.path 直挂兜底；
    两形态都缺席如实返回 None（直播腿降级）。"""
    try:
        from kb_factory.channel_adapters.base import AUDIT_DEFAULT_PATH
        return AUDIT_DEFAULT_PATH
    except ImportError:
        try:
            from channel_adapters.base import AUDIT_DEFAULT_PATH
            return AUDIT_DEFAULT_PATH
        except ImportError:
            return None


def read_audit_tail(path: str, start_offset: int):
    """审计文件尾部增量读取：自 start_offset 起的完整 JSONL 行 → (rows, new_offset)。

    - 只收完整行（换行收尾）；尾部残行不计且偏移停在残行起点（下次补读）；
    - 逐行 JSON 解析，坏行跳过不抛（并发写半行的窗口期如实跳过）；
    - 文件缺失/读失败如实返回 ([], start_offset)（直播腿降级不抛——绝不动主链）。
    """
    if not path:
        return [], start_offset
    try:
        if not os.path.isfile(path):
            return [], start_offset
        with open(path, "rb") as f:
            f.seek(max(0, int(start_offset)))
            data = f.read()
    except OSError:
        return [], start_offset
    last_nl = data.rfind(b"\n")
    if last_nl < 0:
        return [], start_offset                    # 全是残行：一行都不计
    rows = []
    for line in data[:last_nl + 1].splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            rec = json.loads(line.decode("utf-8", "replace"))
        except (UnicodeDecodeError, json.JSONDecodeError):
            continue                               # 坏行如实跳过（不抛不计数）
        if isinstance(rec, dict):
            rows.append(rec)
    return rows, start_offset + last_nl + 1


def aggregate_live_counts(rows, queries) -> dict:
    """审计行 → 本任务渠道实时计数 {channel: n}（零造假口径）：

    - 只认 event=pool_query 行（count=该次查询实收件数，按渠道累加）；
    - 行内 query 必须命中本任务查询词集（别任务/历史行不串账）；查询词集为空
      如实返回 {}（无属主判据宁可不计）；
    - count 非 int（bool 排除）/channel 缺失的行如实跳过。
    """
    qset = {str(q) for q in (queries or []) if str(q or "").strip()}
    if not qset:
        return {}
    counts: dict = {}
    for r in rows:
        if not isinstance(r, dict) or r.get("event") != "pool_query":
            continue
        ch = r.get("channel")
        if not ch:
            continue
        if str(r.get("query") or "") not in qset:
            continue
        n = r.get("count")
        if isinstance(n, bool) or not isinstance(n, int):
            continue
        key = str(ch)
        counts[key] = counts.get(key, 0) + n
    return counts


def flatten_pool_result(pool_result) -> list:
    """收割返回 {channel: [FileMeta dict]} → 拍平元数据列表（簇名预览入参形态）。

    口径同 evidence_cli 扁平化：补注入 top-level channel 锚（已有 channel/
    extra.channel 键不覆写）；非 dict 形状如实剔除（不进预览不抛错）。
    """
    out: list = []
    if not isinstance(pool_result, dict):
        return out
    for ch, lst in pool_result.items():
        if not isinstance(lst, list):
            continue
        for m in lst:
            if not isinstance(m, dict):
                continue
            if m.get("channel") or (isinstance(m.get("extra"), dict)
                                    and m["extra"].get("channel")):
                out.append(m)
            else:
                flat = dict(m)
                flat["channel"] = ch
                out.append(flat)
    return out


def clusters_preview(tree_mod, metas):
    """真实池 → 簇名列表预览（段二直播线）：tree_mod.cluster_pool 与建树同一
    确定性聚类纯函数复用（同池同簇，零漂移预览——建树产出的 L2 证据组名即本
    列表）。契约模块缺席/无 cluster_pool/空池/异常 → None（如实无预览不编造）。
    """
    fn = getattr(tree_mod, "cluster_pool", None) if tree_mod is not None else None
    if not callable(fn) or not metas:
        return None
    try:
        clusters = fn(metas)
    except Exception as e:                          # 预览腿异常如实降级（不阻主链）
        _p(f"[live] 警告: 簇名预览聚类异常（如实无预览）: {type(e).__name__}: {e}")
        return None
    if not isinstance(clusters, list):
        return None
    names = [str(c.get("name")) for c in clusters
             if isinstance(c, dict) and c.get("name")]
    return names or None


class LiveAuditPoller:
    """收割期渠道计数轮询器（daemon 线程，直播腿绝不影响收割主链）。

    - start()：收割调用**前**起线并记零点偏移（收割前的历史行一概不计）；
    - 线程体：每 interval 秒增量读审计尾部 → 按本任务查询词聚合 → counts 非空
      才回调 on_live(counts)（拿不到不发——服务端没给=前端不显示）；
    - stop()：幂等收线（收割返回/异常均由调用方 finally 收线）；
    - path=None/queries 空：start() 直接不起线（如实无直播，不报错）；
    - 轮询/回调异常：如实打印一行后停线（直播腿自灭，主链照跑）。
    """

    def __init__(self, audit_path, queries, on_live, interval: float = 5.0):
        self.path = audit_path
        self.queries = [str(q) for q in (queries or []) if str(q or "").strip()]
        self.on_live = on_live
        self.interval = max(MIN_POLL_INTERVAL, float(interval or 5.0))
        self._stop = threading.Event()
        self._thread = None
        self._offset = 0
        self._totals: dict = {}                         # 渠道累计数（跨 tick 累加）

    def start(self) -> None:
        if not self.path or not self.queries or self._thread is not None:
            return
        try:
            self._offset = os.path.getsize(self.path)   # 零点=收割前 EOF（旧行不计）
        except OSError:
            self._offset = 0                            # 文件未生作物：从 0 起算
        self._thread = threading.Thread(target=self._loop,
                                        name="kb-live-poller", daemon=True)
        self._thread.start()

    def poll_once(self) -> dict:
        """单次增量轮询（测试确定性针位：不起线程直读一回）→ 本任务渠道**累计**数
        （本轮新增行聚合进 _totals 后的整体快照；直播口径=开割以来累计实收件数）。"""
        rows, self._offset = read_audit_tail(self.path, self._offset)
        delta = aggregate_live_counts(rows, self.queries)
        for ch, n in delta.items():
            self._totals[ch] = self._totals.get(ch, 0) + n
        return dict(self._totals)

    def _loop(self) -> None:
        while not self._stop.wait(self.interval):
            try:
                before = dict(self._totals)
                totals = self.poll_once()
                if totals and totals != before and callable(self.on_live):
                    self.on_live(totals)                # 有新计数才回调（真值变化才播）
            except Exception as e:                      # 直播腿异常自灭（不殃及收割）
                _p(f"[live] 轮询线异常停线（如实）: {type(e).__name__}: {e}")
                return

    def stop(self) -> None:
        self._stop.set()
        t = self._thread
        if t is not None and t.is_alive() and t is not threading.current_thread():
            t.join(timeout=self.interval + 2.0)
