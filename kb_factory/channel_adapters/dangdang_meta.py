# -*- coding: utf-8 -*-
"""当当图书渠道适配器（元数据层，渠道编排池新增复刻件适配）。

复刻件照抄 逆向工程/dangdang-reverse/replica/dangdang_api.py（勿改端点/契约）：
- 搜索层 GET search.dangdang.com SERP（60 题录/页，免登录）→ FileMeta(fmt=ebook)；
- m 站详情层 product.m.dangdang.com/detail<pid>-0-1.html（移动端免 WAF 挑战）→
  目录层 toc_lines 进 extra（每查询最多 toc_top 条，默认 3，可配 KB_DANGDANG_TOC_TOP）。
铁律：免费层只取元数据（题录+目录框架）——零下载/零落盘/不碰 join；
复刻件自带 Throttle(2.5s+抖动) 在构造客户端时置 0，频控统一归本适配器
RateLimiter（2s/300，可配 KB_DANGDANG_MIN_INTERVAL / KB_DANGDANG_DAILY_LIMIT），
渠道编排池内一线程串行调用（线程内频控口径单一定义点，防双重睡眠）。
零造假：「search 零题录」为合法空结果 → 如实 count=0 停页不计连错；
SERP 形变/网络失败/复刻件缺失 → fail-soft 返回已得部分（或 []）+审计一行，绝不崩溃。
映射：图书题录一律 fmt=ebook；badge=green_free/perm=green（题录层免费口径，同 doc88，
不判书价付费墙——价格/折扣等原始事实进 extra 如实保留）。
"""
import os
import time

from kb_factory.channel_adapters.base import ChannelAdapter, FileMeta, RateLimiter

_REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", ".."))
_REPLICA_PATH = os.path.join(_REPO_ROOT, "逆向工程", "dangdang-reverse", "replica", "dangdang_api.py")
_MAX_PAGES = 5          # 搜索翻页安全上限（60 题录/页×5 页远超 per_q 需求）
_PAGE_SIZE = 60         # 复刻件实测页大小（短页=末页：省一次零结果探测额度）
_ZERO_HINT = "零题录"    # 复刻件零结果异常特征串（合法空结果，不熔断不计数）


def _default_client_factory(timeout: float):
    """惰性加载复刻件 DangdangClient（模块级不 import：requests/路径缺失不炸本适配器）。

    throttle_base=0.0：复刻件内置 Throttle（默认 2.5s+抖动）置零——频控由本适配器
    RateLimiter 统一承担（2s/300），避免双重睡眠且测试可注入确定性时钟。
    sys.modules 先注册再 exec：与 cnki_meta 同法（importlib 裸 exec 下
    dataclass/注解查 sys.modules 的坑统一防御）；失败如实弹出不留半截模块。
    """
    import importlib.util
    import sys
    if not os.path.isfile(_REPLICA_PATH):
        raise FileNotFoundError(f"replica missing: {_REPLICA_PATH}")
    spec = importlib.util.spec_from_file_location("dangdang_replica_api", _REPLICA_PATH)
    mod = importlib.util.module_from_spec(spec)
    sys.modules["dangdang_replica_api"] = mod
    try:
        spec.loader.exec_module(mod)
    except Exception:
        sys.modules.pop("dangdang_replica_api", None)
        raise
    return mod.DangdangClient(throttle_base=0.0, timeout=timeout)


def _pos_int(v):
    """正整数语义化（m 站出版信息「页数」为字符串如 "456"）：非正/非数字 → None（零造假）。"""
    if isinstance(v, bool):
        return None
    if isinstance(v, int):
        return v if v > 0 else None
    if isinstance(v, str) and v.strip().isdigit():
        n = int(v.strip())
        return n if n > 0 else None
    return None


def _to_meta(x: dict) -> FileMeta:
    """搜索题录 → FileMeta（图书一律 fmt=ebook；题录层免费口径 green）。"""
    return FileMeta(
        title=x.get("title") or "",
        fmt="ebook",
        pages=None,                        # 搜索题录无页数：m 站详情层补，无则如实 None
        badge="green_free",
        perm="green",                      # 题录/目录框架属公开免费层（不判书价付费墙）
        source_url=x.get("url") or None,
        extra={"pid": x.get("pid"), "price": x.get("price"),
               "orig_price": x.get("orig_price"), "discount": x.get("discount"),
               "comments": x.get("comments"), "authors": x.get("authors") or [],
               "author_line": x.get("author_line"), "publisher": x.get("publisher"),
               "pubdate": x.get("pubdate")})


class DangdangAdapter(ChannelAdapter):
    channel = "dangdang"

    def __init__(self, limiter: RateLimiter | None = None, timeout: float = 30.0,
                 retries: int = 1, toc_top: int | None = None, audit=None,
                 client_factory=None):
        if limiter is None:
            limiter = RateLimiter(
                min_interval=float(os.environ.get("KB_DANGDANG_MIN_INTERVAL", "2")),
                daily_limit=int(os.environ.get("KB_DANGDANG_DAILY_LIMIT", "300")),
                name="dangdang")
        self.limiter = limiter
        self.timeout = timeout
        self.retries = retries        # 单页/单条失败重试 1 次（含首次共 2 次尝试）
        if toc_top is None:
            toc_top = int(os.environ.get("KB_DANGDANG_TOC_TOP", "3"))
        self.toc_top = max(0, int(toc_top))  # 每查询 m 站目录层拉取条数上限
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
            raw, page = [], 1
            while len(raw) < limit and page <= _MAX_PAGES:
                self.limiter.acquire()  # 日上限/熔断在此抛（外层兜底绝不崩溃）
                t0 = time.monotonic()
                items, err = None, None
                for _attempt in range(self.retries + 1):
                    try:
                        items = client.search(query, page)
                        break
                    except Exception as e:  # 网络/SERP 形变/零题录：重试 1 次
                        err = e
                if items is None:
                    msg = f"{type(err).__name__}: {err}"
                    if _ZERO_HINT in str(err):
                        # 零题录=合法空结果：如实 count=0 停页，不计连错（零造假）
                        self.limiter.record_success()
                        self._log("request", query, t0, 0, f"page={page} zero")
                        break
                    self.limiter.record_error()
                    self._reason = msg
                    self._log("error", query, t0, 0, f"page={page} {msg[:200]}")
                    break          # 本页如实降级，返回已得部分
                self.limiter.record_success()
                self._log("request", query, t0, len(items), f"page={page}")
                if not items:
                    break          # 空页停
                raw.extend(items)
                if len(items) < _PAGE_SIZE:
                    break          # 短页=末页（60/页复刻件口径）：省零结果探测额度
                page += 1
            metas = [_to_meta(x) for x in raw[:limit]]
            # m 站目录层：前 toc_top 条补 toc_lines（每条 1 次频控额度；失败 fail-soft 该条跳过）
            for meta in metas[:self.toc_top]:
                pid = meta.extra.get("pid")
                if not pid:
                    continue       # 题录缺 pid：如实跳过不硬凑
                self.limiter.acquire()
                t0 = time.monotonic()
                d, err = None, None
                for _attempt in range(self.retries + 1):
                    try:
                        d = client.detail(str(pid))
                        break
                    except Exception as e:  # m 站形变/下架/网络：重试 1 次
                        err = e
                if not isinstance(d, dict):
                    self.limiter.record_error()
                    self._log("toc_error", query, t0, 0,
                              f"pid={pid} {type(err).__name__}: {str(err)[:120]}")
                    continue      # 目录层缺席：题录照常返回（extra 不造 toc）
                self.limiter.record_success()
                meta.pages = _pos_int(d.get("pages")) or meta.pages
                meta.extra["isbn"] = d.get("isbn")
                meta.extra["pages_str"] = d.get("pages")
                meta.extra["toc_lines"] = list(d.get("toc_lines") or [])
                meta.extra["toc_missing"] = bool(d.get("toc_missing"))
                self._log("toc", query, t0, len(meta.extra["toc_lines"]), f"pid={pid}")
            return metas
        except Exception as e:     # RateLimitExceeded/CircuitOpenError：契约绝不崩溃
            self._reason = f"{type(e).__name__}: {e}"
            self._log("degraded", query, time.monotonic(), len(metas), self._reason)
            return metas           # 已取得部分照实返回（零增量时为 []）
