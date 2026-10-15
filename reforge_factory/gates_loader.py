# -*- coding: utf-8 -*-
"""gates.json 单一权威源 loader (百倍V3 / T-002, REQ-002 & REQ-011).

四消费点契约 (ammo_pool / epc50_start_gate / collection_gate /
superline.contracts 全部改读本件, 见 T-002R/T-002B):
    1. reforge_factory/ammo_pool.py — T1_MIN/T12_MIN/T3_CAP/AMMO_GATE 常量改自本件
    2. reforge_factory/epc50_start_gate.py — GATE_CHARS 与分层门改自本件
    3. _proposals/flagship-paid-report-1007/work/collection_gate.py — v5 硬编码门改自本件
    4. reforge_factory/superline/contracts.py gate_defaults() — 动态 import 改自本件

失败语义 (不炸产线): 缺文件 / 坏 JSON / 顶层非 object → 回退内置 DEFAULTS
    并向 stderr 告警一次 (同一 path+reason 进程内去重)。

回滚路径 (REQ-002): flags 三旗默认 false = 新口径在役; 翻 true 即回开旧门
    legacy_t12_gate / legacy_total_gate / legacy_chapter_band。

无缓存设计: 每次 load_gates() 现读磁盘 — 临时改 gates.json 即时生效
    (REQ-010.AC2 的 test_gates_source 依赖此行为, 勿加缓存)。
纯标准库, 无第三方依赖。
"""
import copy
import json
import sys
from pathlib import Path

DEFAULT_CONFIG_PATH = Path(__file__).resolve().parent / "config" / "gates.json"

# 内置默认 = reforge_factory/config/gates.json 的逐字节语义镜像 (test_gates_loader 对拍);
# 权威源不可读时的产线兜底, 语义永不落后于 v3 口径.
DEFAULTS: dict = {
    "version": 3,
    "effective_date": "2026-10-15",
    "t1_min_chars": 10000000,          # REQ-011: T1 ≥ 1000万
    "t12_total_gate": None,            # REQ-011: T1+T2 总门关闭 (旧 3000万门退役)
    "t3_reference_cap_ratio": 1.5,     # T3 封顶 = 1.5 × T1 实测 (旧 5000万硬帽退役)
    "legacy_total_budget_reference": 200000000,  # 旧 2亿总量门 → 仅参考线
    "report_length": {"max": None, "min_chapters": 3, "note": "篇幅自定，密度门主判"},
    "chapter_band": {
        "mode": "density",
        "floor_per_type": {"精编": 3000, "融合": 5000, "原创": 4000},
    },
    "completeness_gate": {
        "required_axes": ["T", "B", "D", "P", "C"],
        "pass_rule": "all_green_or_waived",
    },
    "saturation_gate": {"min_evidence": 2, "min_hosts": 2, "min_pct": 80},
    "release_protocol": {
        "articles_min": 3,
        "videos_min": 3,
        "videos_h3_min": 1,
        "upper": "autonomous_by_funnel",
    },
    # gain_threshold 短键 = REQ-041.AC1 口径别名 (值恒同 gain_threshold_pct, T-005 增补)
    "stopping": {"gain_threshold_pct": 2.0, "gain_threshold": 2.0,
                 "rounds": 3, "fuse_hours": 72},
    "flags": {                          # REQ-002 三回开旗标, 默认全 false
        "legacy_t12_gate": False,
        "legacy_total_gate": False,
        "legacy_chapter_band": False,
    },
}

_warned: set = set()  # {(path, reason)} 已告警键 — 进程内去重


def _warn_once(path, reason: str) -> None:
    """同一 (path, reason) 只向 stderr 告警一次; 缺件是常态而非异常, 不抛不炸."""
    key = (str(path), reason)
    if key in _warned:
        return
    _warned.add(key)
    print(
        f"[gates_loader] WARN 读取门参数权威源失败 path={path} ({reason}) "
        f"→ 回退内置 DEFAULTS, 产线不中断",
        file=sys.stderr,
    )


def load_gates(config_path=None) -> dict:
    """读 gates.json 权威源, 返回整个 gates dict (现读现返回, 无缓存).

    config_path=None 时读 reforge_factory/config/gates.json;
    缺文件/坏 JSON/顶层非 object → 返回 DEFAULTS 深拷贝 + stderr 告警一次.
    """
    path = Path(config_path) if config_path is not None else DEFAULT_CONFIG_PATH
    try:
        with open(path, "r", encoding="utf-8") as fh:
            gates = json.load(fh)
        if not isinstance(gates, dict):
            raise ValueError(f"顶层须为 JSON object, 实得 {type(gates).__name__}")
        return gates
    except (OSError, ValueError) as exc:  # 缺件/权限/编码/解析/形状 一律兜底
        _warn_once(path, f"{type(exc).__name__}: {exc}")
        return copy.deepcopy(DEFAULTS)


def get(key, default=None):
    """便捷读单键: get("t1_min_chars") 等价 load_gates().get(key, default)."""
    return load_gates().get(key, default)
