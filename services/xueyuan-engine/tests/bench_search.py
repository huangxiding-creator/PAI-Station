# -*- coding: utf-8 -*-
"""NFR-01 检索基准：真实库 100 采样 P95<500ms（可重复跑，结果自打印）。

用法：.venv/Scripts/python.exe tests/bench_search.py [--samples 100]
口径：直接调 store 层 fts.search(q)——不起 8872 HTTP 影子进程（免端口生命
周期；HTTP 层契约由 test_search 覆盖），计时含三层降级全管线+热词聚合。
热身 3 查不计入采样（jieba 首切建词典为一次性进程成本，常驻服务口径）。
词表四类混采：L1 标题命中词/L2 长尾（章节标题）词/L3 关键词/省份词/无命中词。
"""
from __future__ import annotations

import argparse
import json
import sqlite3
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from xueyuan_engine import config, fts, store  # noqa: E402

L1_WORDS = [  # 报告标题/摘要命中（真库 38 份标题实词）
    "水利工程", "商机研究", "商机汇总", "水网工程", "水利和湖泊局", "水利局",
    "研究报告", "商机", "研究", "水网", "港口", "航道", "湖泊", "鄂州市",
    "驻马店市", "黄石市", "自治州", "20260807",
]
L2_WORDS = [  # 长尾：仅章节标题命中（真库章节标题实词）
    "时间窗口", "行动节奏", "风险评估", "缓释建议", "市场切入", "核心结论",
    "行动指南", "技术趋势", "产业创新", "市场全景", "政策环境", "规划体系",
    "研究概述", "方法论", "执行摘要", "核心发现", "宏观战略", "投资规模",
    "资金流向", "机遇挑战", "附录",
]
L3_WORDS = ["政府", "水利部门"]  # 仅 keyword_toks（owner_type=政府水利部门）
PROVINCE_WORDS = ["江苏", "浙江", "甘肃", "西藏", "河南", "湖北", "新疆", "武汉"]
NOHIT_WORDS = ["量子比特", "火星移民", "不存在词", "xyzzy", "苍蝇拍", "元宇宙炒房"]


def build_samples(n: int) -> list[str]:
    """四类混采（L1:L2:L3+省份:无命中 ≈ 35:30:15:20），轮转交错排定。"""
    pools = [
        L1_WORDS,
        L2_WORDS,
        L3_WORDS + PROVINCE_WORDS,
        NOHIT_WORDS,
    ]
    out, i = [], 0
    while len(out) < n:
        for p in pools:
            if len(out) < n:
                out.append(p[i % len(p)])
        i += 1
    return out


def pct(times_ms: list[float], p: float) -> float:
    """P 分位（times_ms 已为毫秒）。"""
    return sorted(times_ms)[max(0, -(-int(len(times_ms) * p) // 100) - 1)]


def ensure_fts() -> None:
    """索引在位校验：fts_docs 覆盖全部在架报告，缺则全量重建（幂等）。"""
    store.init()
    with store._db() as c:
        try:
            n_docs = c.execute("SELECT COUNT(*) n FROM fts_docs").fetchone()["n"]
        except sqlite3.OperationalError:
            n_docs = -1
        n_reports = c.execute(
            "SELECT COUNT(*) n FROM reports WHERE status='on'").fetchone()["n"]
    if n_docs != n_reports:
        print(f"[ensure_fts] fts_docs={n_docs} != reports_on={n_reports} → rebuild_all")
        print(f"[ensure_fts] rebuilt {fts.rebuild_all()} reports")
    else:
        print(f"[ensure_fts] index ok: {n_docs} docs")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--samples", type=int, default=100)
    args = ap.parse_args()
    print(f"[bench] db={config.DB_PATH}")
    with store._db() as c:
        print(f"[bench] reports={c.execute('SELECT COUNT(*) n FROM reports').fetchone()['n']}"
              f" chapters={c.execute('SELECT COUNT(*) n FROM chapters').fetchone()['n']}")
    ensure_fts()

    for w in ("水利工程", "时间窗口", "xyzzy"):  # 热身（jieba 建词典，不计采样）
        fts.search(w)

    samples = build_samples(args.samples)
    times, layers, rows = [], {}, []
    for q in samples:
        t0 = time.perf_counter()
        body = fts.search(q)
        ms = (time.perf_counter() - t0) * 1000
        times.append(ms)
        layers[body["layer_used"]] = layers.get(body["layer_used"], 0) + 1
        rows.append((q, body["layer_used"], len(body["items"]), round(ms, 2)))

    print(f"\n[bench] {len(samples)} 采样  layer 分布: {layers}")
    print(f"[bench] P50={pct(times, 50):.1f}ms  P90={pct(times, 90):.1f}ms"
          f"  P95={pct(times, 95):.1f}ms  P99={pct(times, 99):.1f}ms"
          f"  max={max(times):.1f}ms")
    p95 = pct(times, 95)
    verdict = "PASS" if p95 < 500 else "FAIL"
    print(f"[bench] NFR-01 判定: P95 {p95:.1f}ms < 500ms → {verdict}")

    print("\n[bench] 三层真实查询示例（响应关键字段）:")
    for q, want in (("水网工程", "L1"), ("时间窗口", "L2"), ("政府", "L3")):
        body = fts.search(q)
        assert body["layer_used"] == want, (q, body["layer_used"])
        slim = {
            "layer_used": body["layer_used"], "layer": body["layer"],
            "fallback_hint": body["fallback_hint"],
            "hot_words": body["hot_words"][:5],
            "items": [{**{k: it[k] for k in ("id", "title", "province", "industry")},
                       **({"hit_chapters": it["hit_chapters"][:2]}
                          if it.get("hit_chapters") else {})}
                      for it in body["items"][:2]],
            "total_items": len(body["items"]),
        }
        print(f"  q={q!r} → {json.dumps(slim, ensure_ascii=False)}")

    print("\n[bench] 最慢 5 采样:")
    for q, layer, n, ms in sorted(rows, key=lambda r: -r[3])[:5]:
        print(f"  {ms:8.2f}ms  layer={layer:4s} hits={n:3d}  q={q}")
    return 0 if verdict == "PASS" else 1


if __name__ == "__main__":
    raise SystemExit(main())
