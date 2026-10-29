# -*- coding: utf-8 -*-
"""kb_server —— 蓝图异步服务端（A 案服务端件，纯 stdlib，可本地可 ECS）。

背景（1026 证据树已落地）：kb_factory.evidence_cli 全链真跑通（expand→pool
并发真检索→evidence_tree 建树），本件把它包成 HTTP 异步任务 API，供小程序
三段直播（researching→structuring→done）轮询消费。

两端点（ThreadingHTTPServer，每请求一线程）：
    POST /api/kb/blueprint            body={"text","depth?","guided?"}
                                      → 202 {"task_id"}（登记任务表 dict +
                                      后台 daemon 线程跑真链）
    GET  /api/kb/blueprint/<task_id>  → 200 {"status","stage","elapsed",
                                      "bp"(done 时),"error"(failed 时),
                                      "channels_live"(段一直播真值，可选),
                                      "clusters_forming"(段二直播真值，可选)}
                                      未知/已过期 task_id → 404

直播升级（KB-FACTORY 2.0 轴⑤·D，2.0 版）：段位之外再带两条真值进度线——
    - 段一 researching：收割阻塞期间每 LIVE_POLL_INTERVAL_SEC 秒从渠道编排池
      共用审计 jsonl 尾部**增量**聚合本任务查询词命中的 pool_query 行 → 回执带
      channels_live={channel:n}（收割返回后收线不再带）；
    - 段二 structuring：收割返回瞬间以真实池预演 evidence_tree.cluster_pool
      （与建树同一确定性聚类，零漂移）取簇名列表 → 回执带 clusters_forming=
      [簇名…]（done 前的「正在形成 N 个主题分组」预览；终态不带——done 的
      完整账在 bp.provenance，不重复不冒充）。
    实现件=kb_factory.live_progress（新文件；本模块惰性载入，缺位如实降级不带
    直播键，主链不受影响）。计数全部来自实测事实（审计行 count 实数/真实池
    聚类），拿不到不带——零造假。

真链（后台线程，pool.harvest_pool 全渠道并发 → evidence_tree.build_evidence_tree，
复用 kb_factory.evidence_cli.build_evidence_blueprint 全链口径不另造轮子）：
    stage=researching   expand_queries + harvest_pool 渠道并发真检索；
    stage=structuring   收割返回瞬间切换（扁平化+建树+provenance 记账）；
    stage=done          蓝图入任务表；异常 → status=failed 带 error 原因如实。

零造假纪律（逐条在案）：
    - 进度状态如实：收割腿异常时 stage 停留在 researching（如实反映失败点位）；
      渠道超时由 pool 自身如实降级（卡死渠道 [] + audit 记账，researching 段
      照常完成，不挂死不虚报）；
    - 检索 0 件 → status=failed，error 如实带实测 pool_size（证据树拒空树，
      不产树不编造）；
    - depth/guided 入参如实记账入 provenance.server：guided=True 真挂导览层
      （catalog_engine.blueprint.attach_guided_layer 纯函数）；depth 现行不
      参与 evidence 链槽位缩放（真实检索供弹决定槽位）——如实记 note 不冒充
      生效，不静默吞。
    - 任务保留 30 分钟（终态起算）后清；running 任务不清理（在飞任务不丢）。

CORS：全部响应带 Access-Control-Allow-Origin: * + JSON UTF-8（小程序
wx.request / 浏览器直连两用）；OPTIONS 预检 → 204。

绑定：默认仅 127.0.0.1（本地面板/小程序开发工具本机联调）；--host 0.0.0.0
可选供 ECS 公网/内网暴露（暴露责任在运维侧）。

渠道集：默认快速三渠道 wenku,djyanbao,doc88（实测约 40s 量级）；--full 开
七渠道全家桶（pool.DEFAULT_CHANNELS：+chinca/dangdang/cnki/ima）。

CLI 真入口：
    py -3 -m kb_factory.kb_server [--port 8097] [--host 127.0.0.1]
                                  [--full | --channels wenku,djyanbao,doc88]
                                  [--retention 30]

测试针位（生产禁设）：
    make_server(harvest=<fn>)   收割函数直注（unittest mock 链用，签名
                                harvest(queries, channels=None) →
                                {channel: [FileMeta dict]}，同 evidence_cli 契约）；
    KB_EVIDENCE_HARVEST_MODULE  兼容 evidence_cli 既有 env 针位（子进程注入用）。
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import threading
import time
import uuid
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import urlsplit

KB_SERVER_VERSION = "kb-server/1.0.0"

# ── 任务态与渠道集（常量集中，测试可注入覆盖）───────────────────────────────

STAGE_RESEARCHING = "researching"   # 段一：扩词 + 渠道并发真检索
STAGE_STRUCTURING = "structuring"   # 段二：扁平化 + 建树 + 记账
STAGE_DONE = "done"                 # 终态一：蓝图就绪
STATUS_RUNNING = "running"
STATUS_DONE = "done"
STATUS_FAILED = "failed"

TASK_RETENTION_SEC = 30 * 60.0      # 终态任务保留 30 分钟后清
MAX_RUNNING_TASKS = 32              # 并发任务上限（防刷；超限 503 如实告知）
MAX_TEXT_LEN = 2000                 # 一句话需求长度上限（超出 400 如实拒）
MAX_BODY_BYTES = 1 << 20            # 请求体上限 1MB（防御性，超出 413）
LIVE_POLL_INTERVAL_SEC = 5.0        # 段一直播轮询间隔（审计尾部聚合；测试可注入缩小）

# 快速三渠道（免登录在役头部渠道，实测 ~40s 量级）；--full → None=pool 全家桶
DEFAULT_FAST_CHANNELS = ("wenku", "djyanbao", "doc88")

# depth 合法档（口径同 catalog_engine.blueprint.DEPTH_MODES；非法值 400 如实拒，
# 不静默按 standard 冒充通过）
VALID_DEPTH = ("standard", "pro", "flagship")

# 路由（POST 建任务 / GET 查任务；task_id=uuid4().hex 32 位十六进制）
_RE_POST = re.compile(r"^/api/kb/blueprint/?$")
_RE_GET = re.compile(r"^/api/kb/blueprint/([0-9a-fA-F]{32})/?$")


class TaskLimitError(RuntimeError):
    """并发任务上限熔断（POST 侧 503 如实告知，不静默排队假装受理）。"""


def _p(text: str) -> None:
    """统一打印（Windows 控制台编码受限时降级替换不崩，口径同 evidence_cli）。"""
    try:
        print(text)
    except UnicodeEncodeError:
        print(text.encode("ascii", "replace").decode("ascii"))


# ── 任务板（任务表 dict + 锁 + 后台线程；HTTP 层只做薄壳）────────────────────

class KBTaskBoard:
    """异步任务板：任务表 dict（内存态）+ 行级锁 + 每任务一 daemon 线程跑真链。

    - channels：收割渠道白名单（None=pool 全家桶七渠道；缺省快速三渠道）；
    - harvest：收割函数直注测试针位（None=生产链 pool.harvest_pool，兼容
      KB_EVIDENCE_HARVEST_MODULE env 针位）；
    - retention_sec：终态任务保留期（默认 1800s；测试可缩）；
    - audit_path：段一直播轮询的审计文件位（None=live_progress 生产默认位
      惰性解析；测试可注入临时文件）；
    - live_interval：段一直播轮询间隔秒（默认 5s；测试可缩）；
    - 进度两段推进 researching→structuring→done，异常 failed+error 如实；
    - 直播真值两键（轴⑤·D）：任务表记 channels_live/clusters_forming，
      快照按段位收放（段一带渠道计数/段二带簇名预览/终态不带）。
    """

    def __init__(self, channels=None, harvest=None,
                 retention_sec: float = TASK_RETENTION_SEC,
                 max_running: int = MAX_RUNNING_TASKS,
                 audit_path=None, live_interval: float = LIVE_POLL_INTERVAL_SEC):
        self._lock = threading.Lock()
        self._tasks: dict = {}                       # task_id -> 任务 dict（任务表）
        self.channels = list(channels) if channels else None
        self.harvest_override = harvest
        self.retention_sec = float(retention_sec)
        self.max_running = int(max_running)
        self.audit_path = audit_path                 # 直播轮询审计位（None=生产默认位）
        self.live_interval = float(live_interval)    # 段一直播轮询间隔（秒）
        self._stop_sweeper = threading.Event()

    # ── 登记与启动 ────────────────────────────────────────────────────────

    def create_task(self, text: str, depth=None, guided: bool = False) -> str:
        """登记任务（不起线程；submit=create_task+起线程，单测可只登记不打链）。"""
        task_id = uuid.uuid4().hex
        with self._lock:
            running = sum(1 for t in self._tasks.values()
                          if t["status"] == STATUS_RUNNING)
            if running >= self.max_running:
                raise TaskLimitError(
                    f"并发任务已达上限 {self.max_running}（在飞 {running}），请稍后重试")
            self._tasks[task_id] = {
                "task_id": task_id, "status": STATUS_RUNNING,
                "stage": STAGE_RESEARCHING,          # 受理即进入段一（如实）
                "text": text, "depth": depth, "guided": bool(guided),
                "bp": None, "error": None,
                # 直播真值两键（轴⑤·D）：默认无（拿不到不带——零造假）
                "channels_live": None,               # 段一：{channel: n}（审计尾部聚合）
                "clusters_forming": None,            # 段二：[簇名…]（真实池聚类预览）
                "t_submit": time.monotonic(), "t_finish": None,
                "wall_submit": time.strftime("%Y-%m-%dT%H:%M:%S", time.localtime()),
            }
        return task_id

    def submit(self, text: str, depth=None, guided: bool = False) -> str:
        """登记 + 后台 daemon 线程跑真链（POST 侧入口；线程异常兜底 fail 不静默死）。"""
        task_id = self.create_task(text, depth=depth, guided=guided)
        t = threading.Thread(target=self._run_wrapper, args=(task_id,),
                             name=f"kbtask-{task_id[:8]}", daemon=True)
        with self._lock:
            self._tasks[task_id]["thread"] = t
        t.start()
        return task_id

    # ── 状态推进（锁内小步写，HTTP 轮询永不见中间撕裂态）────────────────────

    def set_stage(self, task_id: str, stage: str) -> None:
        with self._lock:
            t = self._tasks.get(task_id)
            if t is not None and t["status"] == STATUS_RUNNING:
                t["stage"] = stage

    def update_live(self, task_id: str, counts: dict) -> None:
        """段一直播真值：收割轮询聚合的渠道计数 {channel:n} 写入任务（仅 running
        且非空才写——拿不到不带，零造假；收割收线后不再更新）。"""
        with self._lock:
            t = self._tasks.get(task_id)
            if t is not None and t["status"] == STATUS_RUNNING and counts:
                t["channels_live"] = dict(counts)

    def set_clusters_forming(self, task_id: str, names) -> None:
        """段二直播真值：聚类簇名列表预览写入任务（仅 running 且非空；建树若
        失败，预览滞留任务表但终态快照不带——不冒充成果）。"""
        with self._lock:
            t = self._tasks.get(task_id)
            if t is not None and t["status"] == STATUS_RUNNING and names:
                t["clusters_forming"] = list(names)

    def finish(self, task_id: str, bp: dict) -> None:
        with self._lock:
            t = self._tasks.get(task_id)
            if t is not None:
                t.update(status=STATUS_DONE, stage=STAGE_DONE, bp=bp,
                         t_finish=time.monotonic())

    def fail(self, task_id: str, error: str) -> None:
        """失败如实：status=failed + error 带原因；stage 停在失败点位（不虚报进展）。"""
        with self._lock:
            t = self._tasks.get(task_id)
            if t is not None:
                t.update(status=STATUS_FAILED, error=str(error),
                         t_finish=time.monotonic())

    def snapshot(self, task_id: str):
        """GET 侧任务快照：{"status","stage","elapsed"} + bp(done)/error(failed)
        + 直播真值两键（轴⑤·D，段位收放）：researching 带 channels_live/
        structuring 带 clusters_forming（缺真值不带）；终态不带直播键（done 的
        完整账在 bp.provenance，不重复不冒充）。未知任务返回 None（HTTP 层译
        404）。elapsed 实测单调钟（running=已运行秒数；终态=受理→终态耗时）。"""
        with self._lock:
            t = self._tasks.get(task_id)
            if t is None:
                return None
            end = t["t_finish"] if t["t_finish"] is not None else time.monotonic()
            out = {"task_id": task_id, "status": t["status"],
                   "stage": t["stage"], "elapsed": round(end - t["t_submit"], 3)}
            if t["status"] == STATUS_RUNNING:
                # 直播真值按段位收放（拿不到如实不带）
                if t["stage"] == STAGE_RESEARCHING and t.get("channels_live"):
                    out["channels_live"] = dict(t["channels_live"])
                elif t["stage"] == STAGE_STRUCTURING and t.get("clusters_forming"):
                    out["clusters_forming"] = list(t["clusters_forming"])
            if t["status"] == STATUS_DONE:
                out["bp"] = t["bp"]
            elif t["status"] == STATUS_FAILED:
                out["error"] = t["error"]
            return out

    # ── 保留期清理（终态起算 retention_sec 后清；running 在飞不清理）────────

    def sweep_expired(self) -> int:
        """清理过期终态任务，返回清除数（每请求顺手一扫 + CLI 模式后台巡扫线程）。"""
        now = time.monotonic()
        with self._lock:
            expired = [tid for tid, t in self._tasks.items()
                       if t["status"] != STATUS_RUNNING and t["t_finish"] is not None
                       and now - t["t_finish"] > self.retention_sec]
            for tid in expired:
                del self._tasks[tid]
        return len(expired)

    def start_sweeper(self) -> threading.Thread:
        """后台巡扫线程（CLI 常驻模式用；interval=min(60, retention/10) 下限 1s）。"""
        interval = max(1.0, min(60.0, self.retention_sec / 10.0))

        def _loop():
            while not self._stop_sweeper.wait(interval):
                n = self.sweep_expired()
                if n:
                    _p(f"[kb_server] 保留期清理: {n} 个终态任务已出清"
                       f"（保留 {self.retention_sec:.0f}s）")

        t = threading.Thread(target=_loop, name="kb-sweeper", daemon=True)
        t.start()
        return t

    def close(self) -> None:
        """停巡扫（进程退出/测试收尾用；在飞任务线程 daemon 不阻塞退出）。"""
        self._stop_sweeper.set()

    # ── 真链执行（后台线程体）────────────────────────────────────────────

    def _run_wrapper(self, task_id: str) -> None:
        """线程体：跑真链；_execute 内已 try/except，此处兜底防线程静默死。"""
        try:
            self._execute(task_id)
        except BaseException as e:                 # 防御性双保险（如实 fail 不吞）
            self.fail(task_id, f"worker 未捕获异常: {type(e).__name__}: {e}")

    def _execute(self, task_id: str) -> None:
        with self._lock:
            task = self._tasks.get(task_id)
        if task is None:                             # 防御：任务已被清（理论不到）
            return
        text, depth, guided = task["text"], task["depth"], task["guided"]
        try:
            bp = self._run_chain(task_id, text, depth=depth, guided=guided)
        except Exception as e:
            self.fail(task_id, f"{type(e).__name__}: {e}")
            _p(f"[kb_server] 任务 {task_id[:8]} 失败（如实）: {type(e).__name__}: {e}")
            return
        self.finish(task_id, bp)
        _p(f"[kb_server] 任务 {task_id[:8]} 完成: stage=done "
           f"（pool 供弹见 provenance.evidence）")

    def _resolve_harvest(self, evidence_cli, pool_mod):
        """收割函数解析（次序如实）：直注针位 → env 针位 → 生产 pool.harvest_pool。"""
        if self.harvest_override is not None:
            return self.harvest_override
        fn = evidence_cli._load_harvest_override()   # KB_EVIDENCE_HARVEST_MODULE env
        if fn is not None:
            return fn
        if pool_mod is None:
            raise RuntimeError("契约模块 pool 缺席（W2）且无收割注入，evidence 链无法跑")
        return pool_mod.harvest_pool

    def _live_progress_mod(self):
        """live_progress 惰性载入（本体保持纯 stdlib；缺位如实 None=直播腿降级，
        主链照跑不报错）。"""
        try:
            from kb_factory import live_progress
            return live_progress
        except ImportError:
            try:
                import live_progress          # sys.path 直挂 kb_factory/ 形态
                return live_progress
            except ImportError:
                return None

    def _resolve_audit_path(self):
        """直播轮询审计位：显式注入优先 → live_progress 生产默认位（渠道编排池
        共用审计文件）；解析不到返回 None（不起直播线）。"""
        if self.audit_path:
            return self.audit_path
        lp = self._live_progress_mod()
        return lp.default_audit_path() if lp is not None else None

    def _make_staged_harvest(self, task_id: str, harvest_fn, box: dict, tree_mod=None, depth=None):
        """段位收割包装：收割函数返回瞬间把任务切到 structuring 段——
        build_evidence_blueprint 拿到返回值后的下一步就是扁平化+建树（段二），
        段位切换与真实执行点严丝合缝；收割腿抛异常则段位停留 researching（如实）。
        box 侧袋记实测收割总数（零造假：失败消息里的 pool_size 来自实测非手填）。

        直播升级（轴⑤·D，接线说明）：收割阻塞期间起 live_progress.LiveAuditPoller
        轮询审计尾部 → box['channels_live'] 侧袋 + 任务板 channels_live（GET 段一
        真值）；返回瞬间以真实池预演 tree_mod.cluster_pool 取簇名列表 →
        box['clusters_forming'] + 任务板预览（GET 段二真值）。两线全实测折算，
        拿不到如实不带；live_progress 缺位/轮询未起=直播腿降级不阻主链。
        """

        def staged_harvest(queries, channels=None):
            # 宪法令（1026 用户宪法「蓝图设计必须基于全面深度的调研」）：
            # 收割预算 90s 全面档（七渠道并发，慢渠道到点如实返部分——
            # pool 契约：stopped 渠道保留已得，宁多勿缺）。
            lp = None
            poller = None
            try:
                lp = self._live_progress_mod()
                if lp is not None:
                    def _on_live(counts):
                        box["channels_live"] = counts          # 侧袋（终局对账用）
                        self.update_live(task_id, counts)      # 任务板（GET 直播真值）

                    poller = lp.LiveAuditPoller(
                        self._resolve_audit_path(), queries, _on_live,
                        interval=self.live_interval)
                    poller.start()
            except Exception as e:          # 直播线未起：如实降级（不带直播键）
                _p(f"[kb_server] 直播轮询线未起（如实降级）: {type(e).__name__}: {e}")
                poller = None
            # 深度分档（用户令件量×5）：flagship=深挖 330s+真翻页 pages=3（24词×3页墙钟~4-5分钟）
            # pro=中档 150s 单页（24词）；standard=快档 90s 不翻页（速度优先）。
            _df = (depth or "standard").lower()
            _to, _pg = (330, 3) if _df == "flagship" else ((150, 1) if _df == "pro" else (90, None))
            try:
                try:
                    result = (harvest_fn(queries, channels=channels, timeout=_to, pages=_pg) if channels
                              else harvest_fn(queries, timeout=_to, pages=_pg))
                except TypeError:
                    try:
                        result = (harvest_fn(queries, channels=channels, timeout=_to) if channels
                                  else harvest_fn(queries, timeout=_to))
                    except TypeError:
                        # 收割针位不支持 timeout 形参（测试桩等）——按原签名兜底
                        result = (harvest_fn(queries, channels=channels) if channels
                                  else harvest_fn(queries))
            finally:
                if poller is not None:
                    poller.stop()           # 收割返回（含异常）即收线：段一直播线停
            try:
                box["pool"] = sum(len(v) for v in result.values())
            except Exception:
                box["pool"] = None
            if lp is not None:              # 段二簇名预览：真实池与建树同一聚类
                names = lp.clusters_preview(
                    tree_mod, lp.flatten_pool_result(result))
                if names:
                    box["clusters_forming"] = names
                    self.set_clusters_forming(task_id, names)
            self.set_stage(task_id, STAGE_STRUCTURING)
            return result
        return staged_harvest

    def _run_chain(self, task_id: str, text: str, depth=None, guided: bool = False) -> dict:
        """真链主体：evidence_cli.build_evidence_blueprint 全链复用（expand→
        harvest→tree→provenance 记账，口径与 CLI 零漂移），段位经收割包装推进；
        guided=True 真挂导览层；depth/guided/channels 等服务端事实入
        provenance.server 如实记账。返回蓝图 dict（失败上抛由 _execute 转 failed）。"""
        from kb_factory import evidence_cli       # 惰性载入：本模块本体保持纯 stdlib
        pool_mod, tree_mod, _chain_note = evidence_cli.load_chain()
        if tree_mod is None:
            raise RuntimeError("契约模块 evidence_tree 缺席（W1），无法建树（如实失败）")
        harvest_fn = self._resolve_harvest(evidence_cli, pool_mod)
        box: dict = {}
        bp = evidence_cli.build_evidence_blueprint(
            text, channels=self.channels,
            harvest=self._make_staged_harvest(task_id, harvest_fn, box, tree_mod, depth))
        if bp is None:
            # evidence_cli 零造假契约：检索不足/建树无果返回 None（已打印原因）
            raise RuntimeError(f"检索不足（pool_size={box.get('pool', 0)}）："
                               "证据树拒空树，未产出编目树（如实计 0 不编造）")

        if guided:                                  # 导览层真挂（纯函数，provenance 自记）
            try:
                from kb_factory.catalog_engine.blueprint import attach_guided_layer
            except ImportError:                     # sys.path 直挂 kb_factory/ 形态
                from catalog_engine.blueprint import attach_guided_layer
            attach_guided_layer(bp, True)

        # provenance.server 服务端事实记账（setdefault 合并，不覆写链上真实键值）
        prov = bp.setdefault("provenance", {})
        if not isinstance(prov, dict):
            prov = {}
            bp["provenance"] = prov
        srv = prov.setdefault("server", {})
        if not isinstance(srv, dict):
            srv = {}
            prov["server"] = srv
        srv.update({"version": KB_SERVER_VERSION, "task_id": task_id,
                    "depth": depth, "guided": bool(guided),
                    "channels": (list(self.channels) if self.channels
                                 else "pool_default_full"),
                    "pool_harvested": box.get("pool"),
                    "retention_sec": self.retention_sec})
        if depth is not None:
            srv["depth_note"] = ("depth 已收讫记账；evidence 链文件槽由真实检索供弹"
                                 "决定，现行不按档位缩放（如实不冒充生效）")
        log = prov.get("stage_log")
        if isinstance(log, list):
            log.append(f"Ssrv kb_server: task={task_id[:8]} "
                       f"depth={depth or 'standard'} guided={bool(guided)} "
                       f"channels={srv['channels']} "
                       f"stage {STAGE_RESEARCHING}→{STAGE_STRUCTURING}→{STAGE_DONE} "
                       f"pool={box.get('pool')} "
                       f"live_channels={box.get('channels_live') or '-'} "
                       f"clusters_forming={len(box.get('clusters_forming') or [])}")
        return bp


# ── HTTP 层（ThreadingHTTPServer 薄壳：路由/校验/CORS/JSON UTF-8）────────────

class KBBlueprintHandler(BaseHTTPRequestHandler):
    """两端点处理器：POST 建任务（202+task_id）/ GET 查任务（快照/404）。"""

    server_version = KB_SERVER_VERSION
    protocol_version = "HTTP/1.1"                   # keep-alive（Content-Length 恒准）

    # ── 通用响应件 ────────────────────────────────────────────────────────

    def _cors(self) -> None:
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type")
        self.send_header("Access-Control-Max-Age", "86400")

    def _send_json(self, code: int, obj: dict) -> None:
        body = json.dumps(obj, ensure_ascii=False).encode("utf-8")
        self.send_response(code)
        self._cors()
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, fmt, *args):              # 控制台一行简账（时间戳保留）
        sys.stderr.write("[kb_server] %s %s\n"
                         % (self.log_date_time_string(), fmt % args))

    @property
    def board(self) -> KBTaskBoard:
        return self.server.kb_board

    def _path(self) -> str:
        return urlsplit(self.path).path             # 剥 query 串，只认路径

    # ── OPTIONS 预检（浏览器直连用；小程序 wx.request 不发预检）─────────────

    def do_OPTIONS(self):                           # noqa: N802（http.server 命名契约）
        self.send_response(204)                      # 204 本身无body，依 RFC 7230
        self._cors()                                 # 不发 Content-Length
        self.end_headers()

    # ── POST /api/kb/blueprint ────────────────────────────────────────────

    def do_POST(self):                              # noqa: N802
        try:
            self._do_post()
        except TaskLimitError as e:
            self._send_json(503, {"error": str(e)})
        except Exception as e:                      # 处理器绝不带崩服务（如实 500）
            self._send_json(500, {"error": f"{type(e).__name__}: {e}"})

    def _do_post(self) -> None:
        self.board.sweep_expired()                  # 每请求顺手一扫（无流量外的兜底）
        if not _RE_POST.match(self._path()):
            self._send_json(404, {"error": "路径不存在（POST /api/kb/blueprint）"})
            return
        try:
            length = int(self.headers.get("Content-Length") or 0)
        except ValueError:
            length = -1
        if length <= 0:
            self._send_json(400, {"error": "缺请求体（Content-Length 空）"})
            return
        if length > MAX_BODY_BYTES:
            self._send_json(413, {"error": f"请求体超限（>{MAX_BODY_BYTES} 字节）"})
            return
        raw = self.rfile.read(length)
        try:
            body = json.loads(raw.decode("utf-8"))
        except (UnicodeDecodeError, json.JSONDecodeError) as e:
            self._send_json(400, {"error": f"body 非合法 JSON UTF-8: {e}"})
            return
        if not isinstance(body, dict):
            self._send_json(400, {"error": "body 必须是 JSON 对象 "
                                        '{"text","depth?","guided?}'} )
            return

        text = body.get("text")
        if not isinstance(text, str) or not text.strip():
            self._send_json(400, {"error": "text 必填（非空字符串）"})
            return
        text = text.strip()
        if len(text) > MAX_TEXT_LEN:
            self._send_json(400, {"error": f"text 过长（>{MAX_TEXT_LEN} 字）"})
            return

        depth = body.get("depth")                   # 档位严格校验：非法 400 不冒充
        if depth is not None:
            if isinstance(depth, bool) or not isinstance(depth, str) \
                    or depth.strip().lower() not in VALID_DEPTH:
                self._send_json(400, {"error": f"depth 非法（可选 {list(VALID_DEPTH)}）"})
                return
            depth = depth.strip().lower()

        guided = body.get("guided")                 # 三态宽容：缺省 False；bool/
        if guided is None:                          # "true"/"false" 字符串均收（如实
            guided = False                          # 归一，其余 400 拒）
        elif isinstance(guided, bool):
            pass
        elif isinstance(guided, str) and guided.strip().lower() in ("true", "false"):
            guided = guided.strip().lower() == "true"
        else:
            self._send_json(400, {"error": 'guided 非法（bool 或 "true"/"false"）'})
            return

        task_id = self.board.submit(text, depth=depth, guided=guided)
        self._send_json(202, {"task_id": task_id})

    # ── GET /api/kb/blueprint/<task_id> ───────────────────────────────────

    def do_GET(self):                               # noqa: N802
        try:
            self._do_get()
        except Exception as e:
            self._send_json(500, {"error": f"{type(e).__name__}: {e}"})

    def _do_get(self) -> None:
        self.board.sweep_expired()
        m = _RE_GET.match(self._path())
        if not m:
            self._send_json(404, {"error": "路径不存在（GET /api/kb/blueprint/<task_id>）"})
            return
        snap = self.board.snapshot(m.group(1).lower())
        if snap is None:
            self._send_json(404, {"error": "任务不存在或已过保留期"
                                        f"（{int(self.board.retention_sec / 60)} 分钟）"})
            return
        self._send_json(200, snap)


class KBThreadingServer(ThreadingHTTPServer):
    """ThreadingHTTPServer + 任务板挂载（daemon_threads=进程退出不挂死）。"""
    daemon_threads = True

    def __init__(self, addr, handler, board: KBTaskBoard):
        super().__init__(addr, handler)
        self.kb_board = board


def make_server(host: str = "127.0.0.1", port: int = 8097,
                channels=DEFAULT_FAST_CHANNELS, harvest=None,
                retention_sec: float = TASK_RETENTION_SEC,
                audit_path=None,
                live_interval: float = LIVE_POLL_INTERVAL_SEC) -> KBThreadingServer:
    """造服务（默认仅 127.0.0.1 + 快速三渠道；ECS 暴露走 --host 0.0.0.0 显式令）。
    port=0 → 系统分配空闲口（测试用，srv.server_address[1] 取实口）；
    channels=None 显式传入=pool 全家桶七渠道（--full 语义）；
    audit_path/live_interval：段一直播轮询审计位与间隔（测试针位；缺省=生产
    默认审计位 + 5s 间隔，见 KBTaskBoard 直播真值两键说明）。"""
    board = KBTaskBoard(channels=channels,
                        harvest=harvest, retention_sec=retention_sec,
                        audit_path=audit_path, live_interval=live_interval)
    srv = KBThreadingServer((host, port), KBBlueprintHandler, board)
    return srv


# ── CLI ─────────────────────────────────────────────────────────────────

def main(argv=None) -> int:
    try:                                           # Windows 控制台 utf-8 宽容
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
        sys.stderr.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass
    ap = argparse.ArgumentParser(
        prog="kb_factory.kb_server",
        description="蓝图异步服务端：POST 建任务 / GET 轮询（researching→"
                    "structuring→done 三段直播；零造假：失败如实带原因）")
    ap.add_argument("--port", type=int, default=8097, help="监听口（默认 8097）")
    ap.add_argument("--host", default="127.0.0.1",
                    help="绑定地址（默认仅 127.0.0.1；ECS 暴露显式 0.0.0.0）")
    ap.add_argument("--full", action="store_true", default=True,
                    help="七渠道全家桶（宪法令：缺省即全面深调研）")
    ap.add_argument("--fast", action="store_true",
                    help="快速三渠道档（wenku,djyanbao,doc88，宪法前的快速默认）")
    ap.add_argument("--channels", default=None,
                    help="渠道白名单逗号分隔（覆盖缺省三渠道；与 --full 互斥后者优先）")
    ap.add_argument("--retention", type=float, default=30.0,
                    help="终态任务保留分钟数（默认 30）")
    ns = ap.parse_args(argv)

    if ns.fast:
        channels = ['wenku', 'djyanbao', 'doc88']
    elif ns.full:
        channels = None                            # None=pool 全家桶（七渠道）
    elif ns.channels:
        channels = [c.strip() for c in ns.channels.split(",") if c.strip()]
    else:
        channels = list(DEFAULT_FAST_CHANNELS)

    srv = make_server(host=ns.host, port=ns.port, channels=channels,
                      retention_sec=ns.retention * 60.0)
    board: KBTaskBoard = srv.kb_board
    board.start_sweeper()
    host_s, port_s = srv.server_address[0], srv.server_address[1]
    _p(f"[kb_server] {KB_SERVER_VERSION} 已起: http://{host_s}:{port_s}")
    _p(f"[kb_server] 端点: POST /api/kb/blueprint | GET /api/kb/blueprint/<task_id>"
       f"（CORS *；任务保留 {ns.retention:.0f} 分钟）")
    _p(f"[kb_server] 渠道集: {channels if channels else 'pool 全家桶（七渠道）'}")
    if host_s == "0.0.0.0":
        _p("[kb_server] 警告: 0.0.0.0 全网卡暴露（ECS 场景；安全组自行收口）")
    try:
        srv.serve_forever()
    except KeyboardInterrupt:
        _p("[kb_server] 收到中断，退出")
    finally:
        board.close()
        srv.server_close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
