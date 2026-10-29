# -*- coding: utf-8 -*-
"""THUOCL 原始词表 → 六库种子 JSON（v2.6 #1）

输入：seeds/thuocl/_raw/THUOCL_<领域>.txt（每行「词<TAB>DF」，GitHub API 官方
      直链下载，字节数已与 contents listing 对账，零造假）
输出：seeds/thuocl/<领域>.json（每词带 df 权重）+ seeds/thuocl/_summary.json
映射：DOMAIN_GROUP_MAP 就近映射到 taxonomy.SIX_DOMAINS 六库 49 分组（显式 dict）
口径：df<1 的词零权重无意义（实测 animal 13734 条 df=0），如实计数后剔除
"""
from __future__ import annotations
import hashlib
import json
import sys
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]          # kb_factory/
sys.path.insert(0, str(ROOT))
from catalog_engine.taxonomy import SIX_DOMAINS     # 只读引用，不改 taxonomy

THUOCL_DIR = Path(__file__).resolve().parents[1]    # seeds/thuocl/
RAW_DIR = THUOCL_DIR / "_raw"

# THUOCL 11 领域 → 中文名（对齐上游 README 命名；与 thuocl_lex.py 同步维护）
DOMAIN_CN = {
    "IT": "信息科技", "animal": "动物", "caijing": "财经", "car": "汽车",
    "chengyu": "成语", "diming": "地名", "food": "食品", "law": "法律",
    "lishimingren": "历史名人", "medical": "医学", "poem": "唐诗宋词",
}

# 11 领域 → 六库 49 分组就近映射（目标名逐字取自 taxonomy.SIX_DOMAINS；
# 原则：law→法规资讯 / caijing→财务研报 / IT→AI信息化 / medical→学术文献 /
# car→工程总承包 / diming→区域市场 / lishimingren→人物档案 /
# animal/food/chengyu/poem 文化类→综合资料通用位）
DOMAIN_GROUP_MAP = {
    "IT": ["AI技术与应用"],
    "animal": ["综合资料"],
    "caijing": ["券商研报精选", "公司公告与年报"],
    "car": ["工程总承包"],
    "chengyu": ["综合资料"],
    "diming": ["区域市场报告"],
    "food": ["综合资料"],
    "law": ["政策法规资讯"],
    "lishimingren": ["专家百人档案", "标杆专访"],
    "medical": ["学术论文"],
    "poem": ["综合资料"],
}


def parse_raw(path: Path):
    """解析「词<TAB>DF」；坏行/df<1 如实计数（skipped/dropped），域内重复词取较大 DF。"""
    words, skipped, dropped = {}, 0, 0
    for line in path.read_text(encoding="utf-8-sig").splitlines():
        parts = line.split()
        if len(parts) < 2:
            if parts:
                skipped += 1
            continue
        try:
            df = int(parts[-1])
        except ValueError:
            skipped += 1
            continue
        if df < 1:                 # 零/负 DF 无权重意义，剔且如实计数
            dropped += 1
            continue
        w = parts[0]
        words[w] = max(words.get(w, 0), df)
    return words, skipped, dropped


def main():
    groups49 = {g for v in SIX_DOMAINS for g in v["groups"]}
    assert len(groups49) == 49, f"49分组实读异常: {len(groups49)}"
    assert set(DOMAIN_CN) == set(DOMAIN_GROUP_MAP), "映射表未覆盖全部11领域"
    for dom, gs in DOMAIN_GROUP_MAP.items():
        for g in gs:
            assert g in groups49, f"映射目标不在49分组: {dom} -> {g}"

    rows, total, skipped_sum, dropped_sum = [], 0, 0, 0
    for dom in sorted(DOMAIN_CN):
        raw = RAW_DIR / f"THUOCL_{dom}.txt"
        words, skipped, dropped = parse_raw(raw)
        ordered = sorted(words.items(), key=lambda kv: (-kv[1], kv[0]))
        payload = {
            "source": "THUOCL",
            "license": "MIT",
            "upstream": "https://github.com/thunlp/THUOCL",
            "raw_file": raw.name,
            "raw_sha256": hashlib.sha256(raw.read_bytes()).hexdigest(),
            "domain_en": dom,
            "domain_cn": DOMAIN_CN[dom],
            "mapped_groups": DOMAIN_GROUP_MAP[dom],
            "word_count": len(ordered),
            "skipped_lines": skipped,
            "dropped_df_le1": dropped,
            "words": [{"w": w, "df": d} for w, d in ordered],
        }
        (THUOCL_DIR / f"{dom}.json").write_text(
            json.dumps(payload, ensure_ascii=False, separators=(",", ":")),
            encoding="utf-8")
        total += len(ordered)
        skipped_sum += skipped
        dropped_sum += dropped
        rows.append({"domain_en": dom, "domain_cn": DOMAIN_CN[dom],
                     "word_count": len(ordered), "skipped_lines": skipped,
                     "dropped_df_le1": dropped,
                     "mapped_groups": DOMAIN_GROUP_MAP[dom]})

    hit = sorted({g for gs in DOMAIN_GROUP_MAP.values() for g in gs})
    summary = {
        "source": "THUOCL",
        "upstream": "https://github.com/thunlp/THUOCL",
        "license": "MIT",
        "built_at": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "domain_count": len(DOMAIN_CN),
        "total_word_count": total,
        "skipped_lines": skipped_sum,
        "dropped_df_le1": dropped_sum,
        "groups_total": len(groups49),
        "groups_hit": len(hit),
        "map_valid_pct": 100,
        "hit_groups": hit,
        "domains": rows,
    }
    (THUOCL_DIR / "_summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"BUILT domains={len(DOMAIN_CN)} total_words={total} skipped={skipped_sum} dropped_df_le1={dropped_sum} hit_groups={len(hit)}/49")
    for r in rows:
        print(f"  {r['domain_en']:>12} {r['domain_cn']} words={r['word_count']} dropped={r['dropped_df_le1']}")


if __name__ == "__main__":
    main()
