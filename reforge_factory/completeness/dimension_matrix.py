# -*- coding: utf-8 -*-
"""D 轴九维矩阵传感器 dimension_matrix (T-007C / REQ-022 / KB-COMPLETENESS-SPEC D 轴).

REQ-022 [MUST]: 维度矩阵评估按九维域包逐格定深度级，缺格必须显式降级+理由，
禁止隐身缺格。

九维 = 行业 / 政策 / 财务 / 技术 / 组织人事 / 司法风险 / 招投标 / 市场客户 / ESG国际。
默认词表内置 DIMENSION_PACKS；register_dimension(name, keywords) 可扩展域包。

V4 (REQ-024 / 百倍V4): 出厂即注册三域包 做空审计/法务穿透/调查叙事 —
九维升十二维 (九维基线 + _EXTRA 三域包)；reset_dimensions 恢复 12 维出厂
基线。三域方法卡四件套见 reforge_factory/crossdisc/method_cards.py (REQ-025)。

深度级（近似口径，行 tier/源多样性合成）:
  L0  hits==0            → downgraded + reason="无命中资料"，计入 open_gaps
  L1  0<hits<3           → downgraded + reason=未达门槛（薄料，仅记提及）
  L1  hits>=3 无 T1 权威  → downgraded + reason=无 T1 权威词/官方源（仅记提及）
  L2  hits>=3 且含 T1 权威信号（战役 tiers.json T1 词表 ∪ 模块兜底权威词，
      或行 credibility ∈ {official, gov}）
  L3  L2 基础上双源（该维命中行跨 >=2 个 engine）或 stance 多样 → 近似深研

T1 权威词来源: `ammo_pool/<战役>/tiers.json` 的 T1 词表（工厂自有分层词汇）∪
模块 T1_FALLBACK_KEYWORDS；campaign 无 tiers.json 时用兜底词表。

双产物落盘（真实池 manifest 只读，只写评估产物）:
  1. `ammo_pool/<战役>/dimension_matrix.json` — REQ-022.AC1 权威件（cells 九格）
  2. `ammo_pool/<战役>/completeness/D_axis.json` — 完备性账本 D 轴节（同载荷）

CLI:
  py reforge_factory/completeness/dimension_matrix.py <战役> [--ammo-root DIR] [--dry-run]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from datetime import datetime, timezone
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_AMMO_ROOT = REPO_ROOT / "ammo_pool"

SENSOR = "dimension_matrix"
AXIS = "D"

#: 默认九维域包（可被 register_dimension 扩展；每维词表按需增补，勿删词）
DIMENSION_PACKS: dict[str, list[str]] = {
    "行业": [
        "行业", "产业链", "上下游", "市场规模", "市场格局", "集中度", "产能",
        "龙头企业", "赛道", "行业分析", "产业研究", "渗透率", "产业周期",
    ],
    "政策": [
        "政策", "法规", "法律法规", "规范性文件", "条例", "实施条例", "管理办法",
        "指导意见", "部委", "监管", "合规", "规划", "征求意见", "部委令", "政府令",
    ],
    "财务": [
        "财务", "营收", "营业收入", "利润", "成本", "现金流", "资产负债",
        "财报", "年报", "审计", "预算", "造价", "报价", "单价", "毛利率",
        "融资", "应收账款", "净利率", "财务指标",
    ],
    "技术": [
        "技术", "工艺", "工法", "专利", "技术方案", "技术路线", "设计优化",
        "BIM", "数字化", "智能化", "施工技术", "技术标准", "技术经济",
    ],
    "组织人事": [
        "组织", "人事", "任命", "董事长", "总经理", "高管", "团队", "人员",
        "架构", "分工", "项目经理", "项目部", "劳务", "用工", "简历", "履历",
        "人才", "组织架构",
    ],
    "司法风险": [
        "诉讼", "裁判文书", "判决", "仲裁", "纠纷", "争议", "违约", "处罚",
        "行政处罚", "失信", "被执行", "司法", "案件", "开庭", "再审", "执行案",
    ],
    "招投标": [
        "招标", "投标", "招投标", "中标", "开标", "评标", "定标", "资格预审",
        "标书", "竞标", "询价", "邀标", "挂牌", "招标文件", "投标文件",
        "评标委员会", "废标", "流标",
    ],
    "市场客户": [
        "客户", "业主", "甲方", "市场", "订单", "需求", "竞争对手", "份额",
        "营销", "销售", "客源", "合作方", "潜在客户", "客户结构", "在手订单",
    ],
    "ESG国际": [
        "ESG", "环保", "环境", "双碳", "碳排放", "碳中和", "绿色", "可持续",
        "社会责任", "公司治理", "国际", "海外", "一带一路", "出海", "国际化",
        "ESG评级",
    ],
}

#: 九维固定顺序（评估输出 dims/cells 均按此序）
DEFAULT_DIMENSIONS: list[str] = list(DIMENSION_PACKS)

#: T1 权威词兜底（campaign 无 tiers.json 时使用；与 tiers.json T1 词表取并集）
T1_FALLBACK_KEYWORDS: list[str] = [
    "官方", "政府", "部委", "发改委", "住建部", "财政部", "工信部",
    "最高人民法院", "裁判文书", "年度报告", "年报", "审计报告", "中标公告",
    "公告", "白皮书", "蓝皮书", "官方发布",
]

#: 行级权威源标记（视同 T1 权威信号）
T1_CREDIBILITIES = {"official", "gov"}

L2_MIN_HITS = 3

#: register_dimension 扩展域包（模块级可变状态；reset_dimensions 清空）
_EXTRA_DIMENSIONS: dict[str, list[str]] = {}


def register_dimension(name: str, keywords: list[str]) -> str:
    """注册自定义维度域包（覆盖同名注册；进 scan 的 dims/cells）."""
    if not isinstance(name, str) or not name.strip():
        raise ValueError("维度名必须为非空字符串")
    if not isinstance(keywords, list) or not keywords:
        raise ValueError(f"维度 {name} 词表必须为非空列表")
    kws = [k for k in keywords if isinstance(k, str) and k.strip()]
    if not kws:
        raise ValueError(f"维度 {name} 词表无有效关键词")
    _EXTRA_DIMENSIONS[name] = kws
    return name


#: V4 三域包词表 (REQ-024): 做空审计 / 法务穿透 / 调查叙事 — 九维升十二维.
#: 方法卡四件套 (源权威表/独立性键/假设模板/黄金四问) 同名注册在
#: crossdisc/method_cards.py — 维度包与方法卡同名同域, 指纹可回溯 (REQ-001).
CROSSDISC_DIMENSIONS: dict[str, list[str]] = {
    "做空审计": ["关联方", "利益输送", "资金流向", "审计意见", "内控",
               "红旗", "隐瞒", "伪造", "做空"],
    "法务穿透": ["股权穿透", "实控人", "代持", "抽逃", "担保链",
               "诉讼风险", "行政处罚", "司法"],
    "调查叙事": ["时间线交叉", "信源动机", "利益冲突", "选择性披露", "内幕", "叙事"],
}


def _register_crossdisc_dimensions() -> None:
    """出厂三域包注册 (REQ-024): 直接调用 register_dimension 统一校验入口."""
    register_dimension("做空审计", list(CROSSDISC_DIMENSIONS["做空审计"]))
    register_dimension("法务穿透", list(CROSSDISC_DIMENSIONS["法务穿透"]))
    register_dimension("调查叙事", list(CROSSDISC_DIMENSIONS["调查叙事"]))


_register_crossdisc_dimensions()   # 出厂即 12 维 (九维 + V4 三域包)


def reset_dimensions() -> None:
    """清空会话自定义维并恢复出厂基线 (九维 + V4 三域包 = 12 维; 测试卫生)."""
    _EXTRA_DIMENSIONS.clear()
    _register_crossdisc_dimensions()


def _active_dimensions() -> dict[str, list[str]]:
    packs = dict(DIMENSION_PACKS)
    packs.update(_EXTRA_DIMENSIONS)
    return packs


def _t1_keywords(pool_dir: Path) -> list[str]:
    """T1 权威词 = 战役 tiers.json T1 词表 ∪ 模块兜底词."""
    kws = list(T1_FALLBACK_KEYWORDS)
    tiers = pool_dir / "tiers.json"
    if tiers.is_file():
        try:
            cfg = json.loads(tiers.read_text(encoding="utf-8"))
            for k in cfg.get("T1") or []:
                if isinstance(k, str) and k.strip() and k not in kws:
                    kws.append(k)
        except (json.JSONDecodeError, OSError):
            pass  # tiers.json 损坏 → 退回兜底词表（不阻断评估）
    return kws


def _compile(keywords: list[str]) -> re.Pattern[str]:
    return re.compile("|".join(re.escape(k.lower()) for k in keywords))


def analyze(campaign: str, ammo_root: Path | str | None = None) -> dict:
    """扫池算九维矩阵（纯计算不落盘）。manifest 只读；池缺失显式报错禁隐身."""
    root = Path(ammo_root) if ammo_root is not None else DEFAULT_AMMO_ROOT
    pool_dir = root / campaign
    manifest = pool_dir / "manifest.jsonl"
    if not manifest.is_file():
        raise FileNotFoundError(f"弹药池 manifest 不存在: {manifest}")

    packs = _active_dimensions()
    dims = list(packs)
    dim_res = {d: _compile(packs[d]) for d in dims}
    t1_res = _compile(_t1_keywords(pool_dir))

    cells: dict[str, dict] = {}
    lines_total = 0
    lines_json_ok = 0
    with manifest.open(encoding="utf-8", errors="replace") as fh:
        for raw in fh:
            line = raw.strip()
            if not line:
                continue
            lines_total += 1
            low = line.lower()
            try:
                rec = json.loads(line)
                lines_json_ok += 1
                engine = str(rec.get("engine") or "")
                stance = str(rec.get("stance") or "")
                cred = str(rec.get("credibility") or "")
            except json.JSONDecodeError:
                engine, stance, cred = "", "", ""
            t1_hit = (t1_res.search(low) is not None
                      or cred in T1_CREDIBILITIES)
            for d in dims:
                if dim_res[d].search(low) is None:
                    continue
                c = cells.setdefault(d, {"hits": 0, "t1_lines": 0,
                                         "engines": set(), "stances": set()})
                c["hits"] += 1
                if t1_hit:
                    c["t1_lines"] += 1
                if engine:
                    c["engines"].add(engine)
                if stance:
                    c["stances"].add(stance)

    out_cells: dict[str, dict] = {}
    open_gaps: list[str] = []
    downgraded = 0
    for d in dims:
        acc = cells.get(d, {"hits": 0, "t1_lines": 0, "engines": set(), "stances": set()})
        hits, t1n = acc["hits"], acc["t1_lines"]
        engines = sorted(acc["engines"])
        stances = sorted(acc["stances"])
        if hits == 0:
            depth, dg, reason = "L0", True, "无命中资料"
            open_gaps.append(d)
        elif hits < L2_MIN_HITS:
            depth, dg, reason = "L1", True, (
                f"仅{hits}条命中，未达L2门槛(需≥{L2_MIN_HITS}条且含T1权威信号)")
        elif t1n == 0:
            depth, dg, reason = "L1", True, (
                f"{hits}条命中但无T1权威词/官方源命中，仅记提及")
        elif len(engines) >= 2 or len(stances) >= 2:
            depth, dg, reason = "L3", False, None
        else:
            depth, dg, reason = "L2", False, None
        if dg:
            downgraded += 1
        out_cells[d] = {
            "hits": hits,
            "depth": depth,
            "downgraded": dg,
            "reason": reason,
            "t1_lines": t1n,
            "engines": engines,
            "stances": stances,
        }

    return {
        "axis": AXIS,
        "sensor": SENSOR,
        "campaign": campaign,
        "generated_at": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "manifest": str(manifest),
        "lines_total": lines_total,
        "lines_json_ok": lines_json_ok,
        "dims": dims,
        "cells": out_cells,
        "open_gaps": open_gaps,
        "downgraded_count": downgraded,
        "green": not open_gaps,
    }


def _dump(record: dict) -> str:
    return json.dumps(record, ensure_ascii=False, indent=1) + "\n"


def scan(campaign: str, ammo_root: Path | str | None = None,
         write: bool = True) -> dict:
    """analyze + 双产物落盘: dimension_matrix.json (REQ-022.AC1) 与
    completeness/D_axis.json (同载荷)。manifest/pool_state 全程只读."""
    record = analyze(campaign, ammo_root)
    if write:
        pool_dir = (Path(ammo_root) if ammo_root is not None
                    else DEFAULT_AMMO_ROOT) / campaign
        (pool_dir / "dimension_matrix.json").write_text(
            _dump(record), encoding="utf-8")
        comp_dir = pool_dir / "completeness"
        comp_dir.mkdir(parents=True, exist_ok=True)
        (comp_dir / "D_axis.json").write_text(_dump(record), encoding="utf-8")
    return record


def _print_table(record: dict) -> None:
    print(f"║ D 轴九维矩阵 · {record['campaign']} "
          f"(manifest {record['lines_total']:,} 行 / JSON {record['lines_json_ok']:,})")
    print(f"║ {'维度':<6} {'hits':>6}  {'深度':<4} {'T1':>4} {'源':>3}  降级/理由")
    for d in record["dims"]:
        c = record["cells"][d]
        flag = "↓降级" if c["downgraded"] else ""
        reason = c["reason"] or ""
        print(f"║ {d:<6} {c['hits']:>6}  {c['depth']:<4} {c['t1_lines']:>4} "
              f"{len(c['engines']):>3}  {flag} {reason}")
    gaps = record["open_gaps"]
    print(f"║ open_gaps={gaps if gaps else '无'}  "
          f"downgraded={record['downgraded_count']}  green={record['green']}")


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description="D 轴九维矩阵传感器 (REQ-022): 九维定深+缺格显式降级")
    ap.add_argument("campaign", help="战役名 (ammo_pool/<战役>)")
    ap.add_argument("--ammo-root", default=None,
                    help="ammo_pool 根目录 (默认仓库内 ammo_pool)")
    ap.add_argument("--dry-run", action="store_true",
                    help="只算只印不落盘（真实池只读）")
    args = ap.parse_args(argv)

    try:  # GBK 控制台下也输出 UTF-8，防表格中文乱码
        sys.stdout.reconfigure(encoding="utf-8")
    except (AttributeError, OSError):
        pass

    record = scan(args.campaign, ammo_root=args.ammo_root, write=not args.dry_run)
    _print_table(record)
    print("║ " + ("dry-run 未落盘" if args.dry_run else
                  "已落盘 dimension_matrix.json + completeness/D_axis.json"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
