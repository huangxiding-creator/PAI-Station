# -*- coding: utf-8 -*-
"""决策账本 (Engine C / KB-DECISION-LEDGER-SPEC, T-005, REQ-040).

主权决策七域八决策点落账 + 结果回填. 账本文件:

    ammo_pool/<campaign>/decision_ledger.jsonl   (追加式, 只增不删)

schema (KB-DECISION-LEDGER-SPEC 逐字段):
    {"id":"D-0001","ts":"...","decision_type":"research_rounds|...",
     "context":{...},"options":[{"k":..,"v":..},..],"chosen":"...",
     "rationale":"...","budget_used":{...}|null,
     "outcome":null,"outcome_ts":null,"score":null}

八枚举 decision_type (REQ-040 清单, 枚举外拒记):
    research_rounds / channel_dispatch / channel_new / depth_alloc /
    report_scope / chapter_budget / topic_select / pricing_suggest

回填方案选择 (任务指定二选一并说明): fill_outcome 采用「整文件重写、其余行
逐行字节保真」方案 —— 以二进制读入全部行, 仅替换目标行, 且目标行只动
outcome / outcome_ts / score 三字段, 其余行按原字节写回. 相比尾注补偿记录,
该方案查询侧零合并逻辑 (每条决策恒为一行), diff 审计只看单行变更, 可审计性
更强; 「只增不删」语义由四条约束守住:
    ① 其余行字节保真 (重写不等于改写);
    ② 目标行仅回填三字段, id/ts/rationale 等记录字段不可再改;
    ③ 已回填记录拒绝二次回填 (历史不可翻改);
    ④ 正常路径只追加 (record_decision), 重写仅发生在 fill_outcome 单行回填.

score 口径 (KB 问责回路): 好/中/差 = 1 / 0 / -1.

纯标准库, 无第三方依赖. 测试一律走 tmp 夹具, 不碰真实战役池.
"""
from __future__ import annotations

import json
import re
import sys
from datetime import datetime
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

#: 七域八决策点全枚举 (REQ-040 / KB-DECISION-LEDGER-SPEC)
DECISION_TYPES: tuple[str, ...] = (
    "research_rounds",    # 轮次与停时 (边际增益主规则)
    "channel_dispatch",   # 渠道优先级与编队
    "channel_new",        # 新建渠道 (建渠器)
    "depth_alloc",        # EEI 追深 L4/L5 分配
    "report_scope",       # 篇幅/章数/框架
    "chapter_budget",     # 章预算
    "topic_select",       # 选题排序建议
    "pricing_suggest",    # 定价/调价建议
)

#: score 合法档 (KB: 好/中/差 = 1/0/-1)
VALID_SCORES = (-1, 0, 1)

#: 真实池根 (测试传 pool_root=tmp 夹具覆盖)
DEFAULT_POOL_ROOT = Path(__file__).resolve().parents[1] / "ammo_pool"

LEDGER_NAME = "decision_ledger.jsonl"
_ID_RE = re.compile(r"^D-(\d{4,})$")
_TS_RE = re.compile(r"^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}$")


def _now_ts() -> str:
    return datetime.now().isoformat(timespec="seconds")


def ledger_path(campaign: str, pool_root=None) -> Path:
    """战役 → 账本绝对路径. campaign 拒绝空名/路径穿越."""
    if (not isinstance(campaign, str) or not campaign.strip()
            or "/" in campaign or "\\" in campaign
            or campaign in (".", "..")):
        raise ValueError(f"非法战役名: {campaign!r}")
    root = Path(pool_root) if pool_root is not None else DEFAULT_POOL_ROOT
    return root / campaign / LEDGER_NAME


def _next_seq(path: Path) -> int:
    """扫现有账本取最大 D-#### 序号 +1 (id 自增, 起始 1)."""
    n = 0
    if not path.exists():
        return 1
    with open(path, "r", encoding="utf-8") as fh:
        for line in fh:
            line = line.strip()
            if not line:
                continue
            try:
                rec = json.loads(line)
            except ValueError:
                continue                       # 脏行不阻塞自增, 但 load_records 会拦
            m = _ID_RE.match(str(rec.get("id") or ""))
            if m:
                n = max(n, int(m.group(1)))
    return n + 1


def _validate_options(options, chosen) -> None:
    if not isinstance(options, list) or not options:
        raise ValueError("options 须为非空 list")
    keys = []
    for opt in options:
        if not isinstance(opt, dict) or not str(opt.get("k") or "").strip():
            raise ValueError(f"option 须含非空 'k' 字段: {opt!r}")
        keys.append(opt["k"])
    if chosen not in keys:
        raise ValueError(f"chosen={chosen!r} 不在 options.k={keys}")


def record_decision(campaign, decision_type, context, options, chosen,
                    rationale, budget_used=None, pool_root=None) -> dict:
    """追加一条决策记录, 返回落盘 record.

    - decision_type 必须在八枚举内, 否则 ValueError 拒记 (账本零残留);
    - options=[{"k":..,"v":..},..] 非空且 chosen 须命中某 k;
    - id 自增 D-0001 起, ts 本地秒级 ISO;
    - budget_used 缺省 None → 落键为 null (KB schema 键位恒在);
    - 追加写 (只增不删), 父目录自动创建.
    """
    if decision_type not in DECISION_TYPES:
        raise ValueError(
            f"decision_type={decision_type!r} 不在八枚举 {DECISION_TYPES}")
    if not isinstance(context, dict):
        raise ValueError("context 须为 dict")
    if not isinstance(rationale, str) or not rationale.strip():
        raise ValueError("rationale 须为非空 str")
    _validate_options(options, chosen)

    path = ledger_path(campaign, pool_root)
    record = {
        "id": f"D-{_next_seq(path):04d}",
        "ts": _now_ts(),
        "decision_type": decision_type,
        "context": context,
        "options": options,
        "chosen": chosen,
        "rationale": rationale,
        "budget_used": budget_used,
        "outcome": None,
        "outcome_ts": None,
        "score": None,
    }
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "a", encoding="utf-8") as fh:
        fh.write(json.dumps(record, ensure_ascii=False, separators=(",", ":")) + "\n")
    return record


def load_records(campaign, pool_root=None) -> list[dict]:
    """读全账本 (严格模式: 脏行 ValueError —— 账本损坏要响亮, 不静默吞)."""
    path = ledger_path(campaign, pool_root)
    if not path.exists():
        return []
    records = []
    with open(path, "r", encoding="utf-8") as fh:
        for lineno, line in enumerate(fh, 1):
            line = line.strip()
            if not line:
                continue
            try:
                records.append(json.loads(line))
            except ValueError as exc:
                raise ValueError(f"{path}:{lineno} 脏行无法解析: {exc}") from exc
    return records


def fill_outcome(campaign, decision_id, outcome, score,
                 pool_root=None) -> dict:
    """回填一条决策的结果 (outcome/outcome_ts/score 三字段, 其余不可动).

    安全回填实现 (docstring 顶注方案): 二进制整文件重写 ——
      1. read_bytes 后按行切分 (keepends), 逐行定位 decision_id;
      2. 未回填行以原字节写回 (字节保真);
      3. 目标行仅置 outcome/outcome_ts/score, 其余字段原样序列化;
      4. 已回填 (outcome 非 null) 记录拒绝二次回填.
    score 口径: 好/中/差 = 1/0/-1, 越界/布尔/非数值拒.
    """
    if not isinstance(outcome, str) or not outcome.strip():
        raise ValueError("outcome 须为非空 str")
    if isinstance(score, bool) or not any(
            isinstance(score, int) and score == v for v in VALID_SCORES):
        raise ValueError(f"score 须为 {VALID_SCORES} (好/中/差), 实得 {score!r}")

    path = ledger_path(campaign, pool_root)
    if not path.exists():
        raise ValueError(f"账本不存在: {path}")
    lines = path.read_bytes().splitlines(keepends=True)
    target_idx = None
    for i, raw in enumerate(lines):
        text = raw.decode("utf-8", errors="replace").strip()
        if not text:
            continue
        try:
            rec = json.loads(text)
        except ValueError:
            continue
        if str(rec.get("id") or "") == str(decision_id):
            target_idx = i
            break
    if target_idx is None:
        raise ValueError(f"决策 {decision_id} 不在账本 {path}")

    old = json.loads(lines[target_idx].decode("utf-8"))
    if old.get("outcome") is not None:
        raise ValueError(f"决策 {decision_id} 已回填, 拒绝二次回填 (历史不可翻改)")

    new = dict(old)                                  # 其余字段原样携带
    new["outcome"] = outcome
    new["outcome_ts"] = _now_ts()
    new["score"] = score
    lines[target_idx] = (json.dumps(new, ensure_ascii=False,
                                    separators=(",", ":")) + "\n").encode("utf-8")
    path.write_bytes(b"".join(lines))
    return new
