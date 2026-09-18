# -*- coding: utf-8 -*-
"""卷宗向量缓存保鲜（随融合刷新链跑）。

融合链 00:10 重算画像卡 → 节文本变化 → data/cx/dossier_vecs.npz 键
失配，直到下次有人查询才懒重嵌。本工具在链尾主动重建：Ollama 在位
就增量重嵌（sha1 键，只嵌变化节），不在位静默跳过（不弹错不重试，
检索侧 hybrid_route 自会降级）。
用法：python tools/cx_dossier_vecs.py
"""
from __future__ import annotations

import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))


def main() -> int:
    from paistation.cx.dossier import load_dossiers
    from paistation.cx.semantic import SemanticIndex, text_key
    from paistation.sense.localfiles.embedder import make_ollama_embedder

    import numpy as np

    embedder = make_ollama_embedder()
    if embedder is None:
        print("嵌入服务不在位，跳过（缓存懒重嵌兜底）")
        return 0
    cache = REPO / "data" / "cx" / "dossier_vecs.npz"
    old_keys = set()
    if cache.exists():
        old_keys = set(np.load(cache, allow_pickle=False).files)
    idx = load_dossiers(REPO / "SELF_PROFILE")
    stale = sum(1 for s in idx.sections if text_key(s.text) not in old_keys)
    SemanticIndex.build(idx.sections, embedder, cache)
    print(f"卷宗向量：{len(idx.sections)} 节，重嵌 {stale}（缓存 {cache.name}）")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
