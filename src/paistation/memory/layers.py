"""M2.4 分层加载（02 卷）：L0 名/L1 卡/L2 片段 + 预算内打包 + 凭据脱敏。

无限上下文的经济学：硬盘即记忆，但模型窗口稀缺——按需分层加载
（L0 只看名字，L1 目录摘要卡，L2 才碰正文片段），pack() 把命中集
在 token 预算内打成 markdown 上下文包。凭据目录硬编码黑名单
（NFR2）：没有任何命令行参数能让 _credentials 下的内容进包。
"""
from __future__ import annotations

import logging
from pathlib import Path

from paistation.memory.hybrid import Hit, approx_tokens

_log = logging.getLogger("paistation.memory.layers")

REDACTED_MARK = "[已脱敏]"
# 路径含这些片段即判敏感（大小写不敏感）
BLACKLIST_PARTS = ("_credentials", "credentials", "_secrets", "secrets",
                   ".ssh", "authkey")
# 文件名精确匹配即判敏感
BLACKLIST_NAMES = ("pipe.authkey", ".env", "credentials.json")

DEFAULT_SNIPPET_CHARS = 800
MIN_ALLOC_CHARS = 60


def _is_sensitive(path: str) -> bool:
    lowered = path.replace("/", "\\").lower()
    return (any(part in lowered for part in BLACKLIST_PARTS)
            or Path(path).name.lower() in BLACKLIST_NAMES)


class LayeredLoader:
    """L0/L1/L2 三层按需加载 + pack 上下文打包（L1 卡内存缓存）。"""

    def __init__(self, data_dir: str | Path | None = None):
        self._data_dir = Path(data_dir) if data_dir else None
        self._l1_cache: dict[str, tuple[float, str]] = {}  # 路径→(签名, 卡)

    # ---- L0：目录清单（名字级，零正文）----

    def l0(self, path: str | Path) -> str:
        try:
            entries = sorted(e.name for e in Path(path).iterdir())
        except OSError:
            return ""
        return "\n".join(entries)

    # ---- L1：目录摘要卡（mtime 签名未变即缓存命中，不重扫）----

    def _dir_signature(self, p: Path) -> float:
        try:
            sig = p.stat().st_mtime
            for child in p.iterdir():
                sig = max(sig, child.stat().st_mtime)
        except OSError:
            return -1.0
        return sig

    def l1(self, dir_path: str | Path) -> str:
        p = Path(dir_path)
        try:
            key = str(p.resolve())
        except OSError:
            key = str(p)
        sig = self._dir_signature(p)
        cached = self._l1_cache.get(key)
        if cached is not None and cached[0] == sig:
            return cached[1]
        try:
            entries = sorted(p.iterdir(), key=lambda e: e.name)
        except OSError:
            return ""
        lines = [f"# {p.name}（{len(entries)} 项）"]
        for e in entries:
            try:
                size = e.stat().st_size
                mark = "📁" if e.is_dir() else "📄"
                lines.append(f"- {mark} {e.name}{'/' if e.is_dir() else f'（{size}B）'}")
            except OSError:
                lines.append(f"- {e.name}")
        card = "\n".join(lines)
        self._l1_cache[key] = (sig, card)
        return card

    # ---- L2：文件片段（utf-8 优先，gbk 兜底，二进制退空）----

    def l2(self, path: str | Path, max_chars: int = DEFAULT_SNIPPET_CHARS) -> str:
        try:
            data = Path(path).read_bytes()
        except OSError:
            return ""
        text = data.decode("utf-8", errors="replace")
        if text.count("�") > len(text) * 0.05:  # 疑似非 utf-8
            text = data.decode("gbk", errors="ignore")
            if not text.strip():
                return ""
        return text[:max_chars]

    # ---- pack：命中集→预算内 markdown 上下文包 ----

    def pack(self, hits: list[Hit], budget_tokens: int = 4000) -> str:
        lines = [f"## 上下文包（{len(hits)} 条 / 预算 {budget_tokens} tokens）", ""]
        remaining = budget_tokens
        for i, hit in enumerate(hits, start=1):
            if _is_sensitive(hit.path):
                lines += [f"### {i}. {REDACTED_MARK} 敏感路径不进上下文"
                          f"（source={hit.source}）", ""]
                continue
            alloc = max(MIN_ALLOC_CHARS, remaining)  # 剩余预算换算字符额度
            snippet = (hit.snippet[:alloc] if hit.snippet
                       else self.l2(hit.path, max_chars=alloc))
            remaining -= approx_tokens(snippet)
            lines += [
                f"### {i}. {Path(hit.path).name} "
                f"[{hit.layer} | {hit.source} | {hit.score:.3f}]",
                f"- 路径: {hit.path}",
                "- 片段:",
                snippet,
                "",
            ]
            if remaining <= 0:
                break  # 预算用尽（首条保底已含）
        return "\n".join(lines)
