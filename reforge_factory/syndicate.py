# -*- coding: utf-8 -*-
"""辛迪加转载检测 (FT-4 饱和门独立性升级) — 一稿多投不算多源共识.

对标 hyperresearch#2: 辛迪加转载不算共识, 5 份通稿 = 1 票.
ammo_pool.coverage() 的 hosts={netloc} 判独立源, 同文多站转发会被
当成多源共识, 直接威胁「>=2 独立源」饱和门 — 本件用字符 8-gram +
确定性 MinHash (估计相似度 >=0.8) 并查集聚类, 把转载家族折叠成
单一证据源后再参与计数.

确定性铁律 (禁 random): 基散列 = FNV 多项式滚动 + 雪崩混合,
哈希族 h_i(x) = (i*31+7)*x mod (2^61-1 Mersenne 素数) — 不用内置
hash(str) (其跨进程加盐), 同输入任意次运行签名一致, 测试可复现.
"""
from __future__ import annotations

import re
from pathlib import Path
from urllib.parse import urlsplit

MERSENNE = (1 << 61) - 1        # 大素数模 (2^61-1, Mersenne)
NHASH = 16                      # MinHash 签名默认位数
SHINGLE_N = 8                   # 字符 n-gram 宽度
SIM_THRESHOLD = 0.8             # 同文判定阈值 (估计 Jaccard)
HEAD_CHARS = 500                # 归一化取头部长度 (对齐 dedup_key 口径)

_STRIP_RE = re.compile(r"[\W_]+")   # 非词字符 = 空白 + 标点 (CJK 保留)


def normalize_for_sim(text: str) -> str:
    """相似度归一化: 小写 + 剥空白/标点, 取头 500 字."""
    return _STRIP_RE.sub("", (text or "").lower())[:HEAD_CHARS]


def shingle_set(text: str, n: int = SHINGLE_N) -> frozenset[str]:
    """字符 n-gram 集合 (先归一化); 短于 n 的非空文本退化为单元素."""
    norm = normalize_for_sim(text)
    if not norm:
        return frozenset()
    if len(norm) <= n:
        return frozenset({norm})
    return frozenset(norm[i:i + n] for i in range(len(norm) - n + 1))


def _base_hash(sh: str) -> int:
    """确定性基散列: FNV-1a 多项式滚动 + 黄金比乘子雪崩."""
    h = 2166136261
    for ch in sh:
        h = ((h ^ ord(ch)) * 16777619) % MERSENNE
    return ((h ^ (h >> 31)) * 0x9E3779B97F4A7C15) % MERSENNE


def minhash_sig(shingles: "frozenset[str] | set[str]",
                k: int = NHASH) -> tuple:
    """确定性 MinHash: 逐位 min_i h_i(x); 空集给空签名 (永不相似)."""
    bases = [_base_hash(s) for s in shingles]
    if not bases:
        return ()
    return tuple(min((i * 31 + 7) * b % MERSENNE for b in bases)
                 for i in range(k))


def sim_estimate(a_sig: tuple, b_sig: tuple) -> float:
    """签名一致位比例 (= 估计 Jaccard); 空签名/长度不齐按可比位算."""
    if not a_sig or not b_sig:
        return 0.0
    n = min(len(a_sig), len(b_sig))
    same = sum(1 for i in range(n) if a_sig[i] == b_sig[i])
    return same / n


HOST_PREFIXES = ("www.", "old.", "m.")   # 主机噪声前缀 (与 fusion_station 同口径)


def row_host(row: dict) -> str:
    """行信源键: URL host 优先, 本地件用 stem — 与 coverage() 原逻辑同源.

    域名级折叠铁律 (E2): netloc 保留 www./端口 → 同站 www/bare 双形态
    被算成 2 独立源, 饱和门被站型噪声灌水; 改用 hostname (已小写剥端口)
    并循环剥 www./old./m. 站前缀 — 同站任意形态恒 1 源."""
    u = row.get("url_norm") or ""
    try:
        host = urlsplit(u).hostname if u else ""
    except ValueError:
        host = ""
    if not host:
        return Path(row.get("source_path") or "").stem
    while True:
        nxt = next((host[len(p):] for p in HOST_PREFIXES
                    if host.startswith(p) and len(host) > len(p)), None)
        if not nxt:
            return host
        host = nxt


def _row_sig(row: dict) -> tuple:
    """行签名: 有 text_head 才可比 (缺字段行不参与折叠 — fail-soft)."""
    head = row.get("text_head")
    return minhash_sig(shingle_set(head)) if head else ()


def syndicate_groups(rows: list[dict]) -> "list[str | None]":
    """并查集聚类: 估计相似度 >=0.8 判同文, 每行返回所属组 id.

    单元素组 id=None (不折叠); 组 id = "syn-<组内最小行下标>" —
    由输入顺序决定, 确定性. 缺 text_head 的行永不相似, 恒单元素.
    """
    n = len(rows)
    parent = list(range(n))                      # 并查集 (路径压缩)

    def find(x: int) -> int:
        while parent[x] != x:
            parent[x] = parent[parent[x]]
            x = parent[x]
        return x

    sigs = [_row_sig(r) for r in rows]
    for i in range(n):
        if not sigs[i]:
            continue
        for j in range(i + 1, n):
            if sigs[j] and sim_estimate(sigs[i], sigs[j]) >= SIM_THRESHOLD:
                ra, rb = find(i), find(j)        # 根钉最小下标 → id 稳定
                if ra != rb:
                    parent[max(ra, rb)] = min(ra, rb)
    sizes: dict[int, int] = {}
    for i in range(n):
        sizes[find(i)] = sizes.get(find(i), 0) + 1
    return [f"syn-{find(i)}" if sizes[find(i)] > 1 else None
            for i in range(n)]


def effective_hosts(ev_rows: list[dict]) -> frozenset[str]:
    """独立源计数键: 多主机同文组折叠成组 id (5 份通稿 = 1 票).

    组内不同 host 数 <=1 的组不折叠 (同站多件本来就是 1 源);
    单元素行与缺字段行照常贡献自身 host. 纯函数, 不改传入 rows.
    """
    gids = syndicate_groups(ev_rows)
    hosts_by_gid: dict[str, list[str]] = {}
    for gid, row in zip(gids, ev_rows):
        if gid is not None:
            hosts_by_gid.setdefault(gid, []).append(row_host(row))
    eff: set[str] = set()
    for gid, row in zip(gids, ev_rows):
        h = row_host(row)
        if gid is None or len({*hosts_by_gid[gid]}) <= 1:
            eff.add(h)
        else:
            eff.add(gid)
    return frozenset(eff)
