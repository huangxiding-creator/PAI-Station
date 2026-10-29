# -*- coding: utf-8 -*-
"""词林术语归一层（KB-FACTORY v2.7 #10，波B）——杂乱术语 → 词群标准词归一。

⚠️⚠️ 版权与合规标注（最高优先级，先于一切功能，商用必读）⚠️⚠️
======================================================================
《同义词词林（扩展版）》数据版权归 哈尔滨工业大学社会计算与信息检索研究中心
（HIT-SCIR）及 知网（CNKI）相关权利方；巨人仓 yaleimeng/Final_word_Similarity
（MIT）只是代码层 MIT，不改变词林数据本身的版权归属。
>> 商用前必须完成上游授权评估，或将数据整体替换为自建同义组。 <<
因此本层默认关闭（env 开关 KB_CILIN_NORM，缺省=关）：关态一切入口原样直通
（零漂移、连数据都不加载），机制就绪——授权评估通过后置 env 即生效。

======================================================================

数据位：seeds/cilin/cilin.json（{词: [编码,…]} 倒排；实测 77456 去重词 /
17809 唯一编码 / 9988 个 '=' 同义群，台账见 seeds/cilin/_summary.json，
零造假口径。任务简报所引 85777 = 该巨人 README 中「词林+HowNet 并集词汇量」，
非词林单库词数，已在台账如实记档）。

归一机制（同编码群 → 群代表标准词）：
  - 编码五层：大类/中类/小类/词群/原子词群（7 位）+ 第 8 位相似标记
    （'=' 同义 / '#' 相关 / '@' 独立）；
  - 只在「完整 8 位编码相同且标记 '='」的原子同义群内归一——
    '#' 仅相关不同义（如 安全帽/鸭舌帽 不并）、'@' 独立词无群，均不归一；
  - 群代表（标准词）选取，确定性规则：
      给 term_df → 群内成员 DF 最高者；平 DF 或无 DF → 最短词；仍平 → 码点序最小。
    代表取自全群成员而非输入子集：任意子集输入归一到同一代表（幂等、交换恒等）；
  - 一词多码（实测 8679 词）取数据序首个 '=' 码所在群（上游声明序，确定性）。

入口：
  normalize_terms(words, term_df=None, enabled=None) -> list[str]  顺序对齐归一
  normalize_map(...)  同参 → {原词: 标准词}（只收录命中词林同义群的）
  available() / last_error() / reset()  数据在位探针 / 缺席原因 / 清懒载（测试用）

【接线说明——收口波执行；本波纪律禁碰 engine.py / storm_breadth.py 既有行】
  env 开关：KB_CILIN_NORM（默认关=全链零漂移）。收口波三挂点共用同一开关：
  1. storm_breadth.breadth_expand()：kws 清洗行之后、_pick_industry 之前插一行
         from . import cilin_norm
         kws = cilin_norm.normalize_terms(kws)
     「挖掘关键词先归一再聚合」——视角命中与组名候选吃到的都是归一后标准词。
  2. enrich/种子池关键词侧（词表检索、频次聚合前）同样先过 normalize_terms；
     建议 term_df 传 THUOCL word_df_index 合并出的跨域 DF，让群代表取真实高频词
     （例：群 {混凝土, 砼} 无 DF 时代表=最短的「砼」，带 DF 则回到「混凝土」）。
  3. engine._build_blueprint_taxonomy 若直取需求 keywords 聚合，同位同开关接入；
     默认关保证既有回归零漂移，不需要新增第二套开关变量。
"""
from __future__ import annotations

import json
import os
import re
from pathlib import Path
from typing import Dict, List, Optional

__all__ = [
    "ENV_SWITCH", "SEEDS_DIR", "normalize_terms", "normalize_map",
    "normalization_enabled", "group_of", "group_representative",
    "available", "last_error", "reset",
]

ENV_SWITCH = "KB_CILIN_NORM"   # 合规开关：默认关（见模块 docstring 版权标注）
SEEDS_DIR = Path(__file__).resolve().parents[1] / "seeds" / "cilin"

# 懒载缓存：inverted=词→[编码…]；groups=编码→[成员…]；error=缺席/失败原因
_STATE: Dict[str, object] = {"inverted": None, "groups": None, "error": None}

_TRUTHY = {"1", "true", "on", "yes"}                    # env 开关真值口径
_CODE_RE = re.compile(r"^[A-Za-z]{2}[0-9]{2}[A-Za-z][0-9]{2}[=#@]$")


def normalization_enabled(enabled: Optional[bool] = None) -> bool:
    """开关判定：显式 enabled 参数优先；否则读 env KB_CILIN_NORM（缺省=关）。"""
    if enabled is not None:
        return bool(enabled)
    return os.environ.get(ENV_SWITCH, "").strip().lower() in _TRUTHY


def _load() -> Optional[tuple]:
    """懒载 seeds/cilin/cilin.json → (倒排, 群表)；缺席/损坏记 error 返回 None。

    fail-soft 纪律：数据问题绝不抛异常，上层一律原样直通（零漂移兜底）。
    """
    if _STATE["error"] is not None or _STATE["inverted"] is not None:
        return (_STATE["inverted"], _STATE["groups"]) if _STATE["inverted"] else None
    path = Path(SEEDS_DIR) / "cilin.json"
    try:
        payload = json.loads(path.read_text(encoding="utf-8"))
        inv = payload["words"]
        if not isinstance(inv, dict) or not inv:
            raise ValueError("words 键空或非对象")
        groups: Dict[str, List[str]] = {}
        for word, codes in inv.items():
            for code in codes:
                if _CODE_RE.match(code):                # 防御：坏码不入群表
                    groups.setdefault(code, []).append(word)
    except Exception as exc:                            # noqa: BLE001
        _STATE["error"] = f"cilin.json 载入失败({path.name}): {exc}"
        return None
    _STATE["inverted"] = inv
    _STATE["groups"] = groups
    return inv, groups


def reset() -> None:
    """清懒载缓存（测试用：换 seeds 目录/模拟缺席后重建状态）。"""
    _STATE.update(inverted=None, groups=None, error=None)


def available() -> bool:
    """数据在位且可载（True=可归一；False=缺席/损坏，入口自动直通）。"""
    return _load() is not None


def last_error() -> Optional[str]:
    """缺席/载入失败原因（无=None；排查用，不参与主流程）。"""
    if _STATE["error"] is None:
        _load()
    return _STATE["error"] if isinstance(_STATE["error"], str) else None


def group_of(word: str) -> Optional[str]:
    """词 → 归一所属的 8 位 '=' 码（首个同义群）；无群（'#'/'@'/未收录）=None。"""
    data = _load()
    if data is None:
        return None
    inv, _ = data
    for code in inv.get(word, ()):                      # 数据序，首个 '=' 码
        if code.endswith("="):
            return code
    return None


def group_representative(code: str, term_df: Optional[Dict[str, int]] = None) -> Optional[str]:
    """群代表（标准词）：DF 最高 → 最短 → 码点序最小（确定性，供检视/测试）。"""
    data = _load()
    if data is None:
        return None
    _, groups = data
    members = groups.get(code) or []
    if not members or not code.endswith("="):           # 只对 '=' 同义群取代表
        return None
    if term_df:
        ranked = sorted(
            (w for w in members if term_df.get(w) is not None),
            key=lambda w: (-term_df[w], len(w), w))
        if ranked:
            return ranked[0]
    return min(members, key=lambda w: (len(w), w))


def normalize_map(words, term_df: Optional[Dict[str, int]] = None,
                  enabled: Optional[bool] = None) -> Dict[str, str]:
    """杂乱术语 → {原词: 群代表}（只收录命中 '=' 同义群的词；关态/缺席={}）。"""
    ws = [w for w in (words or []) if isinstance(w, str)]
    if not normalization_enabled(enabled):              # 默认关：零漂移直通
        return {}
    data = _load()
    if data is None:                                    # 数据缺席：fail-soft 直通
        return {}
    rep_cache: Dict[str, str] = {}
    out: Dict[str, str] = {}
    for w in ws:
        if w in out:
            continue
        code = group_of(w)
        if code is None:
            continue
        if code not in rep_cache:
            rep_cache[code] = group_representative(code, term_df)
        out[w] = rep_cache[code]
    return out


def normalize_terms(words, term_df: Optional[Dict[str, int]] = None,
                    enabled: Optional[bool] = None) -> List[str]:
    """杂乱术语 → 词群标准词归一（顺序/长度对齐；关态与未命中词原样保留）。

    例：normalize_terms(["砼", "安全帽"], term_df={"混凝土": 9}, enabled=True)
        → ["混凝土", "安全帽"]   （砼→混凝土 同 'Bm05A02=' 群；
                                  安全帽 在 '#' 相关群，不归一如实保留）
    """
    ws = [w if isinstance(w, str) else "" for w in (words or [])]
    mapping = normalize_map(ws, term_df=term_df, enabled=enabled)
    return [mapping.get(w, w) for w in ws]
