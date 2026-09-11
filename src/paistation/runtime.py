"""整机装配（提案 4.2 总装 / M6）：把各里程碑引擎接成 7×24 服务。

Runtime = FsWatcher→Ingester→MemoryStore（感知入库链）
        + 首扫上帝时刻（每 data_dir 一次）
        + DailyReview→Outbox 每日 PDCA（pdca_time 后当日一次）。
所有外部依赖（client/channel/watcher/时钟）可注入；client 缺席时
全链路降级为规则模板——服务不因模型故障停摆（附录 P 底线）。
"""
import datetime
import json
import logging
import os
import time
from pathlib import Path

from . import config
from .learn.pdca import DailyReview
from .memory.store import MemoryStore
from .proactive.first_scan import run_first_scan
from .proactive.outbox import Outbox
from .security.audit import AuditLog
from .security.file_guard import FileGuard
from .sense.deepread_engine import DeepReadEngine
from .sense.fs_watcher import EventFilter, FsWatcher
from .sense.incremental import IncrementalScanner
from .sense.ingest import Ingester

_log = logging.getLogger("paistation.runtime")

# 入库后缀白名单：纯文本友好格式（docx 等二进制走首扫陈述，不入 FTS）
_SUFFIXES = {".md", ".txt", ".json", ".csv", ".py", ".log", ".html", ".xml",
             ".ini"}


class _NullChannel:
    """无通知通道时的占位：发送必失败 → 消息落抽屉而非崩溃。"""

    def send(self, title, body):  # noqa: ARG002 - 占位通道只回失败
        return {"ok": False, "errcode": -1, "errmsg": "未配置通知通道"}


def _mins(now) -> int:
    """datetime 与 time.struct_time 通吃的当日分钟数。"""
    if hasattr(now, "tm_hour"):
        return now.tm_hour * 60 + now.tm_min
    return now.hour * 60 + now.minute


def _date_str(now) -> str:
    if hasattr(now, "tm_year"):
        return f"{now.tm_year:04d}-{now.tm_mon:02d}-{now.tm_mday:02d}"
    return now.strftime("%Y-%m-%d")


def _as_datetime(now) -> datetime.datetime:
    """struct_time → datetime：老路径双轨通吃，新引擎（深读/进化）契约
    是 datetime（.hour/.isocalendar）——生产默认时钟 time.localtime 在
    边界处归一，注入的 datetime 假钟原样通过。"""
    if isinstance(now, time.struct_time):
        return datetime.datetime(*now[:6])
    return now


def _hhmm(text: str) -> int:
    h, m = text.strip().split(":")
    return int(h) * 60 + int(m)


class Runtime:
    """感知-记忆-推送-复盘整机。start/stop 管监听，daily_tick 管复盘闸门。"""

    def __init__(self, cfg: dict, client=None, channel=None,
                 watcher_factory=None, now_fn=None, audit: AuditLog | None = None,
                 station_root=None, deepread_reader=None):
        sense, prov, learn = cfg["sense"], cfg["proactive"], cfg["learn"]
        data = cfg["privacy"]["data_dir"]
        self._dirs = list(sense["watch_dirs"])
        self._now = now_fn or time.localtime
        self._client = client
        self._deep = client.deep if client is not None else None
        self._channel = channel

        self._own_audit = audit is None
        self.audit = audit or AuditLog(os.path.join(data, "audit.db"))
        self.guard = FileGuard(self._dirs, self.audit)
        self.store = MemoryStore(os.path.join(data, "memory.db"))
        self.ingester = Ingester(client, self.guard, self.store)
        self.outbox = Outbox(
            max_push_per_day=prov["max_push_per_day"],
            quiet_hours=prov["quiet_hours"],
            state_path=os.path.join(data, "outbox.json"),
            now_fn=self._now,
            retention_days=prov.get("drawer_retention_days", 7))

        filt = EventFilter(_SUFFIXES, sense["ignore_patterns"])
        factory = watcher_factory or FsWatcher
        self._watcher = factory(self._dirs, filt, self.on_batch,
                                audit=self.audit)

        self._pdca_time = _hhmm(learn["pdca_time"])
        self._pdca_state = os.path.join(data, "pdca.state.json")
        self._first_scan_marker = os.path.join(data, "first-scan.done")
        self._inc_time = _hhmm(learn.get("incremental_time", "01:00"))
        self._inc_state = os.path.join(data, "incremental.state.json")
        self._incremental = IncrementalScanner(
            self._dirs, self.on_batch, self._inc_state,
            ignore_patterns=sense["ignore_patterns"])
        # M10 微信深读（PROPOSAL_V2.md 第 6 章 + R13：夜间窗口+启动提醒；
        # deepread_reader 注入 V1 纯视觉读取器（零注入/即读即删/缺席空转），
        # 缺席时 = 调度/提醒链上线而零读屏（安全默认）
        self._deepread = DeepReadEngine(
            state_path=os.path.join(data, "deepread.state.json"),
            channel=channel if channel is not None else None,
            reader_fn=deepread_reader)
        # M12 进化提案（每周，用户 2026-09-11 裁决）：R15 系统永不自批
        self._evolution = None
        if station_root is not None:
            from .evolve.proposer import EvolutionEngine
            self._evolution = EvolutionEngine(station_root=station_root,
                                              channel=channel,
                                              now_fn=lambda: _as_datetime(
                                                  self._now()))
        self._started = False

    # ---------- 感知入库链 ----------

    def on_batch(self, paths: list) -> list:
        """FsWatcher 整批回调：逐文件入库，单文件失败不挡批。"""
        results = []
        for path in paths:
            try:
                results.append(self.ingester.ingest_file(path))
            except Exception as exc:  # noqa: BLE001 - 单文件异常隔离
                _log.warning("入库失败 %s: %s", path, exc)
                results.append({"ok": False, "path": path, "reason": str(exc)})
        return results

    # ---------- 生命周期 ----------

    def start(self) -> None:
        self._watcher.start()
        self._started = True
        if not os.path.exists(self._first_scan_marker):
            self._first_scan()

    def _first_scan(self) -> None:
        """上帝时刻：空库首扫 + 镜像报告投递；完成后落 marker 永不重复。"""
        try:
            report = run_first_scan(watch_dirs=self._dirs, deep_fn=self._deep,
                                    channel=self._channel, outbox=self.outbox)
            delivered = bool(report.get("delivery", {}).get("delivered"))
            self.audit.record("first_scan", module="runtime",
                              files=report.get("meta", {}).get("files", 0),
                              delivered=delivered)
        except Exception as exc:  # noqa: BLE001 - 首扫失败不挡服务起转
            self.audit.record("first_scan", module="runtime", ok=False,
                              error=str(exc)[:300])
            _log.warning("首扫失败（服务继续）: %s", exc)
            return
        with open(self._first_scan_marker, "w", encoding="utf-8") as fh:
            fh.write(_date_str(self._now()))

    def stop(self) -> None:
        if self._started:
            self._watcher.stop()
            self._started = False

    def close(self) -> None:
        self.stop()
        self.store.close()
        if self._own_audit:
            self.audit.close()

    # ---------- 每日 PDCA ----------

    def daily_tick(self) -> dict | None:
        """pdca_time 之后、勿扰结束后当日首次调用执行复盘并投递。

        勿扰中跳过且不消耗当日名额（默认 pdca_time=02:00 落在勿扰时段，
        复盘属"明早可执行"建议，应在早晨送达而非沉入抽屉）。
        另含 01:00 增量补扫（先于 PDCA）：mtime 兜底补 watcher 停机窗口
        漏报，静默维护、勿扰不限（不产生任何推送）。
        """
        now = self._now()
        self._incremental_step(now)
        self._deepread_step(now)
        self._evolution_step()
        if _mins(now) < self._pdca_time or self.outbox.is_quiet():
            return None
        today = _date_str(now)
        if self._last_pdca() == today:
            return None
        self._set_pdca(today)
        review = DailyReview(self.audit, self.outbox.stats(),
                             self.store.stats(), deep_fn=self._deep).review()
        body = "\n".join(f"【{k}】{v}" for k, v in review.items())
        channel = self._channel if self._channel is not None else _NullChannel()
        delivery = self.outbox.push(channel, "PAI 每日复盘", body)
        self.audit.record("pdca.review", module="learn",
                          delivered=delivery.get("delivered", False))
        return delivery

    def _incremental_step(self, now) -> None:
        """incremental_time 后当日一次：mtime 增量补扫（静默维护）。"""
        if _mins(now) < self._inc_time:
            return
        today = _date_str(now)
        try:
            with open(self._inc_state, encoding="utf-8") as fh:
                if json.load(fh).get("date") == today:
                    return
        except (OSError, ValueError):
            pass
        try:
            out = self._incremental.run(now_fn=self._now)
            self.audit.record("incremental.scan", module="sense",
                              changed=out.get("changed", 0),
                              ingested=out.get("ingested", 0))
        except Exception as exc:  # noqa: BLE001 - 补扫失败不挡复盘
            _log.warning("增量补扫失败（服务继续）: %s", exc)

    def _deepread_step(self, now) -> None:
        """微信深读状态机（每拍过闸：窗口/提醒/熔断/让路内部幂等）。"""
        try:
            self._deepread.tick(_as_datetime(now))
        except Exception as exc:  # noqa: BLE001 - 深读故障不杀主循环
            _log.warning("深读 tick 异常（服务继续）: %s", exc)

    def refresh_presence(self) -> None:
        """刷用户在场探测（只读系统输入空闲；失败按不在场，绝不抛）。"""
        try:
            from .sense.presence import last_input_at
            self._deepread.set_presence(last_input_at())
        except Exception as exc:  # noqa: BLE001 - 在场探测故障不杀主循环
            _log.warning("在场探测异常（服务继续）: %s", exc)

    def _evolution_step(self) -> None:
        """每周提案闸（ISO 周内幂等；零信号周发心跳不编造）。"""
        if self._evolution is None:
            return
        try:
            self._evolution.maybe_weekly()
        except Exception as exc:  # noqa: BLE001 - 进化环故障不杀主循环
            _log.warning("进化提案步异常（服务继续）: %s", exc)

    def _last_pdca(self) -> str:
        try:
            with open(self._pdca_state, encoding="utf-8") as fh:
                return json.load(fh).get("last", "")
        except (OSError, ValueError):
            return ""

    def _set_pdca(self, day: str) -> None:
        tmp = self._pdca_state + ".tmp"
        with open(tmp, "w", encoding="utf-8") as fh:
            json.dump({"last": day}, fh)
        os.replace(tmp, self._pdca_state)

    # ---------- 观察 ----------

    def stats(self) -> dict:
        return {"watch_dirs": list(self._dirs),
                "store_files": self.store.stats()["total"],
                "drawer_items": self.outbox.stats()["drawer_items"],
                "started": self._started}

    @classmethod
    def from_config(cls, cfg: dict, audit: AuditLog | None = None,
                    station_root=None) -> "Runtime":
        """生产装配：密钥/密文缺席一律降级，不抛。"""
        client = None
        try:
            from .llm.zhipu_client import ZhipuClient
            key = config.resolve_api_key(cfg)
            client = ZhipuClient(
                key, [cfg["llm"]["fast_model"], cfg["llm"]["deep_model"]],
                vision_model=cfg["llm"]["vision_model"])
        except Exception as exc:  # noqa: BLE001 - 无密钥→规则降级
            _log.warning("LLM 客户端不可用（规则降级）: %s", exc)
        channel = None
        webhook = _wecom_webhook()
        if webhook:
            from .channels.wecom import WeComChannel
            channel = WeComChannel(webhook)
        # M10.2a：深读 V1 纯视觉读取器（client 缺席/开关关 → None 零读屏）
        reader = None
        try:
            from .sense.wechat_vision import build_reader
            reader = build_reader(
                client, station_root or Path.cwd(),
                enabled=bool(cfg["sense"].get("deepread_enabled", True)))
        except Exception as exc:  # noqa: BLE001 - 装配失败→调度链照常
            _log.warning("深读读取器装配失败（零读屏，调度照常）: %s", exc)
        return cls(cfg, client=client, channel=channel, audit=audit,
                   station_root=station_root, deepread_reader=reader)


def _wecom_webhook() -> str:
    """企微 webhook：环境变量 PAI_WECOM_WEBHOOK 优先，其次 secret ini。"""
    import configparser
    hook = os.environ.get("PAI_WECOM_WEBHOOK", "")
    if hook:
        return hook
    root = os.path.dirname(os.path.dirname(os.path.dirname(
        os.path.abspath(__file__))))
    parser = configparser.ConfigParser()
    parser.read(os.path.join(root, "config", "wecom.secret.ini"),
                encoding="utf-8")
    return parser.get("wecom", "webhook", fallback="")
