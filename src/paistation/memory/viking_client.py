"""OpenViking 侧车 IPC 客户端（提案第 5 章⑤/第 22 章许可证隔离）。

OpenViking 为 AGPLv3-core：以独立 sidecar 进程 + 本地 HTTP（回环）隔离，
进程边界阻断许可证传染，主程序 MIT 不受影响（开源合规标准做法）。
侧车缺席是常态（未安装/未启动）→ 全接口优雅降级，主程序零感知不崩。
"""
import json
import logging
import urllib.error
import urllib.parse
import urllib.request

_log = logging.getLogger("paistation.memory.viking")

_LOOPBACK = ("127.0.0.1", "localhost", "::1")
_OPENER = urllib.request.build_opener(urllib.request.ProxyHandler({}))


class VikingClient:
    """viking:// 分层记忆 sidecar 的本地 HTTP 客户端（只走回环）。"""

    def __init__(self, base_url: str = "http://127.0.0.1:17777",
                 timeout: float = 2.0, _opener=None):
        host = urllib.parse.urlsplit(base_url).hostname or ""
        if host not in _LOOPBACK:
            raise ValueError(f"侧车 IPC 仅允许回环地址（实际 {host}）："
                             "AGPL 隔离边界，禁止指向远程进程")
        self._base = base_url.rstrip("/")
        self._timeout = timeout
        self._opener = _opener or _OPENER
        self._available: bool | None = None  # None = 未探测

    # ---------- 基础请求 ----------

    def _call(self, method: str, path: str, payload: dict | None = None):
        """返回 (status, 解析后 body)；任何网络/解析故障 → None。"""
        data = None
        headers = {"Accept": "application/json"}
        if payload is not None:
            data = json.dumps(payload, ensure_ascii=False).encode("utf-8")
            headers["Content-Type"] = "application/json"
        req = urllib.request.Request(self._base + path, data=data,
                                     headers=headers, method=method)
        try:
            with self._opener.open(req, timeout=self._timeout) as resp:
                raw = resp.read().decode("utf-8")
            return getattr(resp, "status", 200), json.loads(raw)
        except (urllib.error.URLError, OSError, ValueError) as exc:
            _log.debug("侧车调用失败 %s%s: %s", method, path, exc)
            return None

    # ---------- 对外接口（全部优雅降级） ----------

    def health(self) -> bool:
        code, body = (self._call("GET", "/health") or (None, None))
        ok = code == 200 and isinstance(body, dict) \
            and body.get("status") in ("ok", "healthy")
        self._available = bool(ok)
        return bool(ok)

    def is_available(self) -> bool:
        """带探测缓存的可用性；首次探测后不再重复发请求。"""
        if self._available is None:
            self.health()
        return bool(self._available)

    def upsert(self, doc_id: str, text: str, meta: dict | None = None) -> bool:
        """写入/更新一条记忆（L0 原文，侧车自管 L1/L2 分层）。"""
        result = self._call("POST", "/memory/upsert",
                            {"id": doc_id, "text": text, "meta": meta or {}})
        return bool(result and result[0] == 200)

    def search(self, query: str, top_k: int = 5) -> list:
        """语义召回；侧车缺席/响应劣化 → 空结果（FTS5 兜底）。"""
        result = self._call("POST", "/memory/search",
                            {"query": query, "top_k": top_k})
        if not result or result[0] != 200:
            return []
        hits = (result[1] or {}).get("results")
        return hits if isinstance(hits, list) else []
