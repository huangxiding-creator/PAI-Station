"""进化提案机制（M12，PROPOSAL_V2.md 第 9 章）：系统从被动防错到主动变异。

每周（用户 2026-09-11 裁决由月度提频）从信号生案：
  合一指数 U 分域报告 / 反馈流 / 被问倒记录 / 90 天零用清单
每案必附 before→after 证据 + 风险 + 回滚（宪法 C11）。
红线：
- R15 系统永不自批——status 恒 pending_user，land() 须用户显式批准
- 裁撤红线：安全件（深读参数/只读守卫/账号节流/熔断）永不出现在候选
"""
from __future__ import annotations

import json
import logging
import os
import tempfile
from datetime import datetime
from pathlib import Path

from ..organ import credential as cred_mod
from ..organ.registry import find_by_name, organ_dir
from .unity import SINGULARITY, load_snapshots

_log = logging.getLogger("paistation.evolve")

# 不可裁撤清单（提案第 9 章）：安全红线件永不做裁撤候选
NON_RETIREABLE = ("深读", "只读", "节流", "熔断", "守卫", "红线", "审计",
                  "凭证", "密码", "密钥")

_IDLE_DAYS = 90          # 90 天零用 → 裁撤候选（减法智能）


def _proposals_dir(root: Path) -> Path:
    return organ_dir(Path(root), find_by_name("进化")) / "proposals"


class EvolutionEngine:
    """每周提案引擎：信号 → 提案 → 企微卡片 → 落盘 pending_user。"""

    def __init__(self, station_root: Path, channel=None, now_fn=None):
        self.station_root = Path(station_root)
        self.channel = channel
        self._now = now_fn or datetime.now
        self._state_path = _proposals_dir(self.station_root) / "_engine.json"

    # -- 每周闸 -----------------------------------------------------------

    def _week(self, now: datetime | None = None) -> str:
        now = now or self._now()
        iso = now.isocalendar()
        return f"{iso[0]}-W{iso[1]:02d}"

    def due(self, last_week: str, now: datetime | None = None) -> bool:
        return last_week != self._week(now)

    def _last_week(self) -> str:
        try:
            return json.loads(
                self._state_path.read_text(encoding="utf-8")).get("last_week", "")
        except (OSError, json.JSONDecodeError):
            return ""

    def maybe_weekly(self) -> list[dict]:
        """周闸内首拍：生成 + 卡片投递 + 落盘；同周再拍静默。"""
        now = self._now()
        if not self.due(self._last_week(), now):
            return []
        props = self.generate()
        body = render_card(props) if props else \
            "【每周进化提案】本周零提案——信号稳定，无变异必要（零数据不编造）。"
        if self.channel is not None:
            delivery = self.channel.send("进化提案（每周）", body)
            if not (delivery or {}).get("ok"):
                _log.warning("进化提案卡片投递失败——提案仍已落盘待批")
        self.persist(props)
        self._set_last_week(self._week(now))
        return props

    def _set_last_week(self, week: str) -> None:
        self._state_path.parent.mkdir(parents=True, exist_ok=True)
        fd, tmp = tempfile.mkstemp(dir=str(self._state_path.parent), suffix=".tmp")
        try:
            with os.fdopen(fd, "w", encoding="utf-8") as fh:
                json.dump({"last_week": week}, fh)
            os.replace(tmp, self._state_path)
        finally:
            if os.path.exists(tmp):
                os.unlink(tmp)

    # -- 信号 → 提案 -------------------------------------------------------

    def generate(self, usage: dict | None = None) -> list[dict]:
        """纯函数式生案：零信号零提案（不编造）。"""
        props: list[dict] = []
        props += self._from_unity()
        props += self._from_usage(usage or {})
        for i, prop in enumerate(props, 1):
            prop["id"] = f"{self._week()}-{i:02d}"
            prop["status"] = "pending_user"
            prop["issued_at"] = self._now().isoformat(timespec="seconds")
        return props

    def _from_unity(self) -> list[dict]:
        rows = load_snapshots(self.station_root)
        by_domain: dict[str, list[dict]] = {}
        for row in rows:
            by_domain.setdefault(row["domain"], []).append(row)
        props = []
        for domain, history in by_domain.items():
            if len(history) < 2:
                continue
            prev, last = history[-2], history[-1]
            before, after = round(prev["u"]), round(last["u"])
            c_before = prev.get("components", {}).get("c_rate")
            c_last = last.get("components", {}).get("c_rate")
            if before < SINGULARITY <= after:
                props.append({
                    "kind": "method_evolve", "domain": domain,
                    "target": f"{domain} 方法升档（L1→L2 责任转移）",
                    "evidence": {"before": before, "after": after,
                                 "gate": f"跨过 {SINGULARITY} 分奇点"},
                    "risk": "域方法变更影响后续交付节奏，需一周观察期",
                    "rollback": "回滚至上一方法版本（器官链可追溯）"})
            elif isinstance(c_before, (int, float)) and \
                    isinstance(c_last, (int, float)) and c_last > c_before:
                props.append({
                    "kind": "profile_fix", "domain": domain,
                    "target": f"{domain} 画像修正（纠正频率回升）",
                    "evidence": {"before": round(c_before, 3),
                                 "after": round(c_last, 3),
                                 "gate": "C_rate 周环比上升"},
                    "risk": "画像改动可能过拟合单周样本",
                    "rollback": "画像快照回退（01 用户 diff 存档）"})
        return props

    def _from_usage(self, usage: dict) -> list[dict]:
        props = []
        for target, stat in sorted(usage.items()):
            if any(k in target for k in NON_RETIREABLE):
                continue                     # 安全红线件永不入裁撤候选
            if stat.get("days_idle", 0) >= _IDLE_DAYS and \
                    not stat.get("uses_90d"):
                props.append({
                    "kind": "retire", "domain": "全站", "target": target,
                    "evidence": {"before": stat.get("days_idle", 0),
                                 "after": 0, "gate": f"≥{_IDLE_DAYS} 天零使用"},
                    "risk": "可能有季节性使用场景",
                    "rollback": "从器官归档恢复（只增不删红线：归档不销毁）"})
        return props

    # -- 落盘 ---------------------------------------------------------------

    def persist(self, props: list[dict]) -> list[dict]:
        """提案落 11 进化/proposals/<周>-<序号>.json（pending_user）。"""
        folder = _proposals_dir(self.station_root)
        folder.mkdir(parents=True, exist_ok=True)
        out = []
        for prop in props:
            path = folder / f"{prop['id'].replace('-', '_')}.json"
            fd, tmp = tempfile.mkstemp(dir=str(folder), suffix=".tmp")
            try:
                with os.fdopen(fd, "w", encoding="utf-8") as fh:
                    json.dump(prop, fh, ensure_ascii=False, indent=1)
                os.replace(tmp, path)
            finally:
                if os.path.exists(tmp):
                    os.unlink(tmp)
            prop = {**prop, "file": str(path)}
            out.append(prop)
        return out


def render_card(props: list[dict]) -> str:
    """企微卡片文案：一案一行 + 批准/驳回/改期入口（C7 延伸到系统自身）。"""
    lines = ["【每周进化提案】请裁决："]
    kind_cn = {"method_evolve": "方法进化", "skill_rebirth": "技能重生",
               "profile_fix": "画像修正", "rule_update": "规则更新",
               "new_channel": "新渠道", "retire": "裁撤"}
    for prop in props:
        ev = prop.get("evidence", {})
        lines.append(
            f"- [{kind_cn.get(prop['kind'], prop['kind'])}] {prop['target']}"
            f"（{prop['id']}）证据 {ev.get('before')}→{ev.get('after')}"
            f" {ev.get('gate', '')}")
    lines.append("回复：批准 <id> / 驳回 <id> / 改期 <id>——系统永不自批（R15）")
    return "\n".join(lines)


def land(root: Path, prop: dict, approved_by: str = "") -> dict:
    """用户批准后落地：状态 approved + R14 凭证进 11 进化 链。

    系统侧调用（approved_by 为空）→ PermissionError（R15 永不自批）。
    """
    if not approved_by or approved_by.startswith("system"):
        raise PermissionError("R15 红线：进化提案必须用户显式批准，系统永不自批")
    landed = {**prop, "status": "approved", "approved_by": approved_by,
              "approved_at": datetime.now().isoformat(timespec="seconds")}
    path = Path(prop.get("file") or "")
    if path.is_file():
        fd, tmp = tempfile.mkstemp(dir=str(path.parent), suffix=".tmp")
        try:
            with os.fdopen(fd, "w", encoding="utf-8") as fh:
                json.dump(landed, fh, ensure_ascii=False, indent=1)
            os.replace(tmp, path)
        finally:
            if os.path.exists(tmp):
                os.unlink(tmp)
    spec = find_by_name("进化")
    cred = cred_mod.issue(
        kind="evolution_proposal", upstream="11 进化",
        downstream=spec.dirname,
        payload={"proposal": landed.get("id", ""),
                 "kind": landed.get("kind", ""),
                 "target": landed.get("target", "")[:120],
                 "approved_by": approved_by})
    cred_mod.append_to_chain(Path(root), spec.dirname, cred)
    return landed
