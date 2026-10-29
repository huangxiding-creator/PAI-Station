# -*- coding: utf-8 -*-
"""中国对外承包工程商会渠道适配器（W5，元数据层）。
复刻件照抄 逆向工程/chinca-reverse/replica/chinca_api.py（勿改端点/契约/正则）：
- 阿里云 WAF「acw_sc__v2」JS 挑战：solver.js 经 Node vm 原样执行站点 JS（版本免疫）；
  挑战识别/求解/重放全在复刻件 ChincaClient.get 闭环，本适配器不另起炉灶。
- 8 栏目；优先栏目=统计/资讯类（对口：对外承包工程统计序列 stats + 通知/行业等资讯题录）。
- chinca 无服务端搜索接口 → query 做题录侧标题过滤（零造假：不编造相关性排序）。
铁律：免费层只取元数据——只调 list_column（题录级）；get_article 正文/join/download/落盘一律禁入。
降级：复刻件缺失/requests 缺失/Node 不在/WAF 未过 → fail-soft 返回已得部分（或[]）+审计一行，绝不崩溃。
映射：stats 统计序列→xls；题录含 PDF 迹象→pdf；其余文章→doc；perm=green（公开统计/资讯题录）。
频控：间隔 5s、日上限 200（WAF solver 每调都要跑，从严；可配
KB_CHINCA_MIN_INTERVAL / KB_CHINCA_DAILY_LIMIT）。
"""
import os
import re
import time
from kb_factory.channel_adapters.base import (ChannelAdapter, FileMeta, RateLimiter)

_REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", ".."))
_REPLICA_DIR = os.path.join(_REPO_ROOT, "逆向工程", "chinca-reverse", "replica")
_BASE = "https://www.chinca.org"
# 优先栏目：统计序列居首（对口「对外承包工程统计序列」），其后资讯类，再研究/国际/项目
_COLUMNS = ("stats", "notice", "industry", "coc", "member", "intl", "research", "project")
_COLUMNS_ZH = {"notice": "通知公告", "industry": "行业新闻", "member": "会员动态",
               "coc": "商会新闻", "intl": "国际承包商", "stats": "统计分析",
               "research": "研究", "project": "项目信息"}
_MAX_PAGES_PER_COL = 3  # 每栏目翻页安全上限（8 栏目×3 页=24 请求 << 日上限 200，题录级从严）


def _default_client_factory(timeout: float):
    """惰性加载复刻件 ChincaClient（模块级不 import：requests/路径缺失不炸本适配器）。"""
    import importlib.util
    path = os.path.join(_REPLICA_DIR, "chinca_api.py")
    if not os.path.isfile(path):
        raise FileNotFoundError(f"replica missing: {path}")
    spec = importlib.util.spec_from_file_location("chinca_replica_api", path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod.ChincaClient(timeout=timeout)


def _to_meta(column: str, item: dict) -> FileMeta:
    title = re.sub(r"\s+", " ", (item.get("title") or "")).strip()
    url = (item.get("url") or "").strip()
    if column == "stats":
        fmt = "xls"  # 统计序列（对外承包工程统计）→ 表格序列归一 xls
    elif "pdf" in title.lower() or url.lower().endswith(".pdf"):
        fmt = "pdf"  # 题录含 PDF 迹象 → pdf
    else:
        fmt = "doc"  # 资讯/文章题录 → doc（原站多为网页文章，题录级如实归一）
    return FileMeta(
        title=title,
        fmt=fmt,
        pages=None,  # 题录无页数字段，如实 None
        badge="green_free",
        perm="green",  # 公开统计/资讯题录
        source_url=(_BASE + url) if url else None,
        extra={"column": column, "column_name": _COLUMNS_ZH.get(column, column),
               "date": item.get("date"),
               "origin_id": url.rsplit("/", 1)[-1] if url.startswith("/") else None},
    )


class ChincaAdapter(ChannelAdapter):
    channel = "chinca"

    def __init__(self, limiter: RateLimiter | None = None, timeout: float = 30.0,
                 retries: int = 1, audit=None, columns=None, client_factory=None):
        if limiter is None:
            limiter = RateLimiter(
                min_interval=float(os.environ.get("KB_CHINCA_MIN_INTERVAL", "5")),
                daily_limit=int(os.environ.get("KB_CHINCA_DAILY_LIMIT", "200")),
                name="chinca")
        self.limiter = limiter
        self.timeout = timeout
        self.retries = retries  # 单页失败重试 1 次（含首次共 2 次尝试）
        self.audit = audit      # None=不记审计（单测注入 tmp 审计时才落盘）
        self.columns = tuple(columns) if columns else _COLUMNS
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
        if not os.path.isfile(os.path.join(_REPLICA_DIR, "chinca_api.py")):
            self._reason = "replica missing"
            return False
        return True

    def metadata(self, query: str, limit: int = 20) -> list:
        out: list = []
        if limit <= 0:
            return out
        t0 = time.monotonic()
        try:
            client = self._client_factory(self.timeout)
        except Exception as e:  # 复刻件/requests/路径缺失：fail-soft 返回[] + 审计一行
            self.limiter.record_error()
            self._reason = f"replica load failed: {type(e).__name__}"
            self._log("error", query, t0, 0, f"{type(e).__name__}: {e}")
            return out
        for col in self.columns:
            if len(out) >= limit:
                break
            page = 1
            while len(out) < limit and page <= _MAX_PAGES_PER_COL:
                self.limiter.acquire()  # 日上限/熔断在此抛 RateLimitExceeded / CircuitOpenError
                t0 = time.monotonic()
                items, err = None, None
                for _attempt in range(self.retries + 1):
                    try:
                        items, max_pages = client.list_column(column=col, page=page)
                        break
                    except Exception as e:  # Node 缺席/WAF 未过/网络失败：重试 1 次
                        err = e
                if items is None:
                    self.limiter.record_error()
                    self._log("error", query, t0, 0,
                              f"col={col} p={page} {type(err).__name__}: {str(err)[:200]}")
                    break  # 本栏目如实降级，继续下一栏目
                self.limiter.record_success()
                self._log("request", query, t0, len(items),
                          f"col={col} p={page} solve={getattr(client, 'solve_count', 0)}")
                if not items:
                    break  # 空页停
                for it in items:
                    if query and query not in (it.get("title") or ""):
                        continue  # chinca 无服务端搜索 → 题录标题过滤（零造假）
                    out.append(_to_meta(col, it))
                    if len(out) >= limit:
                        break
                page += 1
                if page > max_pages:
                    break
        return out[:limit]
