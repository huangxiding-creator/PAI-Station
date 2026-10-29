# -*- coding: utf-8 -*-
"""THUOCL 领域词表 loader（六库种子 v2.6 #1，波1）

巨人源：thunlp/THUOCL（MIT License，github.com/thunlp/THUOCL），11 领域词表，
每行「词<TAB>DF」；数据位 kb_factory/seeds/thuocl/<领域>.json（由
seeds/thuocl/_work/build_seeds.py 从 GitHub 官方直链 _raw/ 生成，字节数已对账）。
定位：只提供 API+数据，供引擎命名排序/命中加权用；不改 engine.py 既有逻辑，
波2 schema 立法时再接，避免冲突。
"""
from __future__ import annotations

import json
from pathlib import Path
from typing import Dict, List, Optional, Tuple

# 数据位：catalog_engine/../seeds/thuocl/（下划线开头文件为台账，不进词表）
SEEDS_DIR = Path(__file__).resolve().parents[1] / "seeds" / "thuocl"

# THUOCL 11 领域 → 中文名（对齐上游 README；与 seeds/thuocl/_work/build_seeds.py 同步维护）
DOMAIN_CN: Dict[str, str] = {
    "IT": "信息科技", "animal": "动物", "caijing": "财经", "car": "汽车",
    "chengyu": "成语", "diming": "地名", "food": "食品", "law": "法律",
    "lishimingren": "历史名人", "medical": "医学", "poem": "唐诗宋词",
}

# 11 领域 → 六库 49 分组就近映射（目标名逐字取自 taxonomy.SIX_DOMAINS；
# 原则：law→法规资讯 / caijing→财务研报 / IT→AI信息化 / medical→学术文献 /
# car→工程总承包 / diming→区域市场 / lishimingren→人物档案 /
# animal/food/chengyu/poem 文化类→综合资料通用位；与 build_seeds.py 同步维护）
DOMAIN_GROUP_MAP: Dict[str, List[str]] = {
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


def load_thuocl(seeds_dir: Optional[Path] = None) -> Dict[str, List[Tuple[str, int]]]:
    """全量读入：{领域: [(词, df), ...]}，领域内 df 降序、域内去重。

    幂等：每次调用独立读盘重建，不共享可变状态，重复调用结果相等；
    供引擎命名排序/命中加权取材（波1 只供 API，不接入 engine.py）。
    """
    d = Path(seeds_dir) if seeds_dir is not None else SEEDS_DIR
    out: Dict[str, List[Tuple[str, int]]] = {}
    for path in sorted(d.glob("*.json")):
        if path.name.startswith("_"):        # _summary.json 等台账不进词表
            continue
        payload = json.loads(path.read_text(encoding="utf-8"))
        dom = payload["domain_en"]
        out[dom] = [(item["w"], int(item["df"])) for item in payload["words"]]
    return out


def word_df_index(lex: Optional[Dict[str, List[Tuple[str, int]]]] = None) -> Dict[str, Dict[str, int]]:
    """倒排索引：词 → {领域: df}，命中加权时一次查词跨域取权重。"""
    lex = lex if lex is not None else load_thuocl()
    idx: Dict[str, Dict[str, int]] = {}
    for dom, words in lex.items():
        for w, df in words:
            idx.setdefault(w, {})[dom] = df
    return idx


def total_word_count(lex: Optional[Dict[str, List[Tuple[str, int]]]] = None) -> int:
    """词总数（域内去重后合计，跨域重复各计一次），词量门实测口径。"""
    lex = lex if lex is not None else load_thuocl()
    return sum(len(ws) for ws in lex.values())
