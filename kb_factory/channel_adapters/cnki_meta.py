# -*- coding: utf-8 -*-
"""知网(CNKI)学术源渠道适配器（元数据层，渠道编排池新增复刻件适配）。

复刻件照抄 逆向工程/cnki-reverse/replica/cnki_api.py（勿改端点/契约）：
老版免登录通道 search.cnki.com.cn（预热 GET /Search/Result 拿 SID_search 会话 +
POST /search/listresult 题录列表，~19-20 条/页）→ FileMeta(fmt=pdf)。

学术付费墙源铁律（任务指定）：perm=yellow 只进题录层——题录/摘要片段免费面可用，
全文在付费墙内，本适配器不碰 fetch_abstract 详情腿（题录层自带 snippet 足矣），
并在 extra["cautious"] 落谨慎标注原文。
徽章说明：badge 用渠道显式值 "cnki_academic"（非 catalog_engine.metadata.BADGES
闭集成员）——刻意不占 "wenku_vip"，因 harvest_engine BADGE_SITE_ROUTES 会把
wenku_vip 徽章路由到百度文库站点，学术题录误路由=假事实；cnki_academic 无站点
路由（其余靠槽位显式 site 字段），如实表示「学术源·黄档·题录层」。
频控：RateLimiter 4s/200（学术源从严；可配 KB_CNKI_MIN_INTERVAL /
KB_CNKI_DAILY_LIMIT）；复刻件自带 throttle(1s) 构造时置 0，频控统一归本适配器，
渠道编排池内一线程串行调用。预热腿+POST 腿各占一额度（如实记账：腿数=请求口径）。
降级：复刻件缺失/requests 缺失/403 熔断/网络失败 → fail-soft 返回已得部分
（或 []）+审计一行，绝不崩溃；题录无页数字段如实 pages=None。
"""
import os
import time

from kb_factory.channel_adapters.base import ChannelAdapter, FileMeta, RateLimiter

_REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", ".."))
_REPLICA_PATH = os.path.join(_REPO_ROOT, "逆向工程", "cnki-reverse", "replica", "cnki_api.py")
_MAX_PAGES = 5      # 检索翻页安全上限（~20 题录/页×5 页远超 per_q 需求）
_CAUTIOUS = "学术源(知网)付费墙：只进题录层元数据，全文不在免费层（perm=yellow）"


def _default_client_factory(timeout: float):
    """惰性加载复刻件 CnkiApi（模块级不 import：requests/路径缺失不炸本适配器）。

    throttle=0.0：复刻件内置节流（默认 1s）置零——频控由本适配器 RateLimiter 统一
    承担（4s/200，学术源从严），避免双重睡眠且测试可注入确定性时钟。
    verbose=False：复刻件 stderr 日志关闭（适配器侧 audit.jsonl 统一记账）。
    sys.modules 先注册再 exec：复刻件 @dataclass 带字符串注解，dataclasses
    _is_type 会查 sys.modules[cls.__module__]，缺席即 AttributeError（1026 池
    实跑实证）；加载失败如实弹出不留半截模块。
    """
    import importlib.util
    import sys
    if not os.path.isfile(_REPLICA_PATH):
        raise FileNotFoundError(f"replica missing: {_REPLICA_PATH}")
    spec = importlib.util.spec_from_file_location("cnki_replica_api", _REPLICA_PATH)
    mod = importlib.util.module_from_spec(spec)
    sys.modules["cnki_replica_api"] = mod
    try:
        spec.loader.exec_module(mod)
    except Exception:
        sys.modules.pop("cnki_replica_api", None)
        raise
    return mod.CnkiApi(throttle=0.0, timeout=int(timeout), verbose=False)


def _to_meta(rec) -> FileMeta:
    """题录 Record → FileMeta（学术文献主体归一 pdf；perm=yellow 学术付费墙源）。"""
    return FileMeta(
        title=(getattr(rec, "title", "") or "").strip(),
        fmt="pdf",                       # 学术文献主体归一 pdf（题录层无格式字段，任务口径）
        pages=None,                      # 题录无页数字段，如实 None（零造假）
        badge="cnki_academic",           # 渠道显式徽章（见模块 docstring：防 wenku_vip 误路由）
        perm="yellow",                   # 学术付费墙源：只进题录层（任务铁律）
        source_url=getattr(rec, "detail_url", None) or None,
        extra={"authors": list(getattr(rec, "authors", None) or []),
               "journal": getattr(rec, "journal", "") or "",
               "year_issue": getattr(rec, "year_issue", "") or "",
               "doc_type": getattr(rec, "doc_type", "") or "",
               "keywords": list(getattr(rec, "keywords", None) or []),
               "snippet": (getattr(rec, "snippet", "") or "")[:150],
               "cautious": _CAUTIOUS})


class CnkiAdapter(ChannelAdapter):
    channel = "cnki"

    def __init__(self, limiter: RateLimiter | None = None, timeout: float = 25.0,
                 retries: int = 1, audit=None, client_factory=None):
        if limiter is None:
            limiter = RateLimiter(
                min_interval=float(os.environ.get("KB_CNKI_MIN_INTERVAL", "4")),
                daily_limit=int(os.environ.get("KB_CNKI_DAILY_LIMIT", "200")),
                name="cnki")
        self.limiter = limiter
        self.timeout = timeout
        self.retries = retries        # 单页失败重试 1 次（含首次共 2 次尝试）
        self.audit = audit            # None=不记审计（单测注入 tmp 审计时才落盘）
        self._client_factory = client_factory or _default_client_factory

    def _log(self, event, query, t0, count, detail=""):
        if self.audit is not None:
            self.audit.log(channel=self.channel, event=event, query=query,
                           elapsed_ms=int((time.monotonic() - t0) * 1000), count=count,
                           detail=detail)

    def available(self) -> bool:
        s = self.limiter.status()
        if s["circuit_open"] or s["count_today"] >= s["daily_limit"]:
            return False
        return os.path.isfile(_REPLICA_PATH)

    def metadata(self, query: str, limit: int = 12) -> list:
        metas: list = []
        try:
            try:
                client = self._client_factory(self.timeout)
            except Exception as e:  # 复刻件/requests/路径缺失：fail-soft 返回[] + 审计一行
                self.limiter.record_error()
                self._reason = f"replica load failed: {type(e).__name__}"
                self._log("error", query, time.monotonic(), 0, f"{type(e).__name__}: {e}")
                return metas
            recs, page = [], 1
            while len(recs) < limit and page <= _MAX_PAGES:
                warm = page == 1       # 仅首页预热（复刻件口径：同会话后续页免预热）
                for _ in range(2 if warm else 1):
                    self.limiter.acquire()   # 预热腿+POST 腿各占一额度（腿数=请求口径）
                t0 = time.monotonic()
                res, err = None, None
                for _attempt in range(self.retries + 1):
                    try:
                        res = client.search(query, page=page, warm=warm)
                        break
                    except Exception as e:  # 403 熔断/网络/形变：重试 1 次
                        err = e
                if res is None:
                    self.limiter.record_error()
                    self._reason = f"{type(err).__name__}: {err}"
                    self._log("error", query, t0, 0, f"page={page} {self._reason[:200]}")
                    break          # 本页如实降级，返回已得部分
                self.limiter.record_success()
                got = list(getattr(res, "records", None) or [])
                total = getattr(res, "total_count", 0)
                self._log("request", query, t0, len(got), f"page={page} total={total}")
                if not got:
                    break          # 空页停
                recs.extend(got)
                page += 1
            metas = [_to_meta(r) for r in recs[:limit]]
            return metas
        except Exception as e:     # RateLimitExceeded/CircuitOpenError：契约绝不崩溃
            self._reason = f"{type(e).__name__}: {e}"
            self._log("degraded", query, time.monotonic(), len(metas), self._reason)
            return metas           # 已取得部分照实返回（零增量时为 []）
