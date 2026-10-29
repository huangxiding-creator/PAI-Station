# -*- coding: utf-8 -*-
"""T-03 config.yaml 加载器 + secrets 引用解析 + 脱敏视图。

契约（SCHEMAS §3 / FR9 / ADR4）：
- config.yaml 只持有引用名 plan_key_ref，绝不持有密钥明文；
- 实际值：套餐 Key 优先 secrets/zhipu_secrets.json（plan_keys.<ref>），
  缺席时回退 ~/.claude/settings.json env.ANTHROPIC_AUTH_TOKEN（W0 现网事实：
  secrets 文件只有 bigmodel 登录信息，套餐 Key 即 CC 认证 token）；
- bigmodel 登录信息只从 secrets 文件 bigmodel 节读取；
- 一切错误信息只带 ref 名/字段名，绝不带值；日志一律走 redacted_view()。
"""
from __future__ import annotations

import json
from dataclasses import dataclass, field, fields
from pathlib import Path

import yaml

MASK = "***"
VALID_MODES = ("auto", "dry_run", "notify_only")

DEFAULT_SECRETS_PATH = Path(__file__).resolve().parents[1] / "secrets" / "zhipu_secrets.json"
DEFAULT_SETTINGS_PATH = Path.home() / ".claude" / "settings.json"
DEFAULT_CONFIG_PATH = Path(__file__).resolve().parents[1] / "config.yaml"


class ConfigError(Exception):
    """配置/密钥解析错误；message 只含字段名或 ref 名，不含任何值。"""


# ---------------- 数据模型（SCHEMAS §3 逐字段） ----------------

@dataclass
class ProviderCfg:
    enabled: bool = True
    base_url: str = ""
    plan_key_ref: str = ""


@dataclass
class PollCfg:
    idle_min: int = 10
    busy_min: int = 2
    threshold_pct: int = 90


@dataclass
class PolicyCfg:
    reserve_cards: int = 1
    lead_time_min: int = 30
    fifo_by_expiry: bool = True
    mode: str = "dry_run"  # 首次部署默认安全模式（FR9）
    idle_grace_min: int = 10  # CC 空闲宽限：最近遥测超过此分钟数=空闲，不花卡（1023 用户令）


@dataclass
class NotifyCfg:
    wecom: bool = True


@dataclass
class PeakFactorCfg:
    peak: float = 1.0      # KB V3 结论：高峰 1x（周一至五 14:00-18:00 UTC+8）
    offpeak: float = 0.5   # 非高峰 0.5x


@dataclass
class DaemonCfg:
    heartbeat_min: int = 15
    peak_factor: PeakFactorCfg = field(default_factory=PeakFactorCfg)


@dataclass
class Config:
    providers: dict = field(default_factory=lambda: {
        "zai": ProviderCfg(base_url="https://api.z.ai", plan_key_ref="zai"),
        "bigmodel": ProviderCfg(base_url="https://open.bigmodel.cn",
                                plan_key_ref="bigmodel"),
    })  # 双站 enabled：zai 主，bigmodel 备（W0：双域同源，互为故障转移）
    poll: PollCfg = field(default_factory=PollCfg)
    policy: PolicyCfg = field(default_factory=PolicyCfg)
    notify: NotifyCfg = field(default_factory=NotifyCfg)
    daemon: DaemonCfg = field(default_factory=DaemonCfg)


_SECTION_FIELDS = {f.name: f.type for f in fields(Config)}


# ---------------- load_config ----------------

def _sub_fields(dc_cls) -> set:
    return {f.name for f in fields(dc_cls)}


def _merge_section(name: str, dc, raw: dict):
    """把 yaml dict 合并进 dataclass 实例；未知键/类型不符 → ConfigError 带字段名。"""
    if not isinstance(raw, dict):
        raise ConfigError(f"{name}: 应为映射，实为 {type(raw).__name__}")
    known = _sub_fields(type(dc))
    for k in raw:
        if k not in known:
            raise ConfigError(f"{name}: 未知字段 '{k}'（已知: {sorted(known)}）")
    for f in fields(type(dc)):
        if f.name in raw:
            v = raw[f.name]
            if isinstance(getattr(dc, f.name), bool) or f.type is bool:
                if not isinstance(v, bool):
                    raise ConfigError(f"{name}.{f.name}: 应为布尔，实为 {v!r}")
                setattr(dc, f.name, v)
            elif isinstance(getattr(dc, f.name), int) and not isinstance(v, bool):
                if not isinstance(v, int):
                    raise ConfigError(f"{name}.{f.name}: 应为整数，实为 {v!r}")
                setattr(dc, f.name, v)
            elif isinstance(getattr(dc, f.name), float):
                if not isinstance(v, (int, float)) or isinstance(v, bool):
                    raise ConfigError(f"{name}.{f.name}: 应为数值，实为 {v!r}")
                setattr(dc, f.name, float(v))
            elif isinstance(getattr(dc, f.name), str):
                if not isinstance(v, str):
                    raise ConfigError(f"{name}.{f.name}: 应为字符串，实为 {v!r}")
                setattr(dc, f.name, v)
    return dc


def _validate(cfg: Config) -> None:
    p = cfg.poll
    if p.idle_min < 1 or p.busy_min < 1:
        bad = "poll.idle_min" if p.idle_min < 1 else "poll.busy_min"
        raise ConfigError(f"{bad}: 必须 >= 1")
    if p.idle_min < p.busy_min:
        raise ConfigError(
            f"poll.idle_min({p.idle_min}) 不得小于 poll.busy_min({p.busy_min})：闲时轮询更疏、忙时更密")
    if not (0 < p.threshold_pct <= 100):
        raise ConfigError(f"poll.threshold_pct: 应为 (0,100]，实为 {p.threshold_pct}")
    pol = cfg.policy
    if pol.mode not in VALID_MODES:
        raise ConfigError(
            f"policy.mode: 非法值，允许 {'|'.join(VALID_MODES)}（字段名: policy.mode，值不入错误信息）")
    if pol.reserve_cards < 0:
        raise ConfigError(f"policy.reserve_cards: 应 >= 0，实为 {pol.reserve_cards}")
    if pol.lead_time_min < 1:
        raise ConfigError(f"policy.lead_time_min: 应 >= 1，实为 {pol.lead_time_min}")
    h = cfg.daemon.heartbeat_min
    if h < 1:
        raise ConfigError(f"daemon.heartbeat_min: 应 >= 1，实为 {h}")
    pf = cfg.daemon.peak_factor
    if not (0 < pf.peak <= 2) or not (0 < pf.offpeak <= 2):
        raise ConfigError("daemon.peak_factor.peak/offpeak: 应在 (0,2] 区间")
    for name, prov in cfg.providers.items():
        if not prov.base_url.startswith("http"):
            raise ConfigError(f"providers.{name}.base_url: 应为 http(s) URL")


def load_config(path=None) -> Config:
    """加载 config.yaml；缺字段按 SCHEMAS §3 默认补齐；非法值抛带字段名的 ConfigError。"""
    p = Path(path) if path is not None else DEFAULT_CONFIG_PATH
    if not p.exists():
        raise ConfigError(f"config 文件不存在: {p}")
    raw = yaml.safe_load(p.read_text(encoding="utf-8")) or {}
    if not isinstance(raw, dict):
        raise ConfigError(f"config 根节点应为映射: {p}")
    for k in raw:
        if k not in _SECTION_FIELDS:
            raise ConfigError(f"顶层未知节 '{k}'（已知: {sorted(_SECTION_FIELDS)}）")

    cfg = Config()
    prov_raw = raw.get("providers") or {}
    if not isinstance(prov_raw, dict):
        raise ConfigError("providers: 应为映射")
    for name, item in prov_raw.items():
        if name not in cfg.providers:
            cfg.providers[name] = ProviderCfg()
        if item is None:
            continue
        merged = _merge_section(f"providers.{name}", cfg.providers[name], item)
        if not merged.plan_key_ref:
            merged.plan_key_ref = name  # 缺省引用名=站名
    if "poll" in raw:
        cfg.poll = _merge_section("poll", cfg.poll, raw["poll"] or {})
    if "policy" in raw:
        cfg.policy = _merge_section("policy", cfg.policy, raw["policy"] or {})
    if "notify" in raw:
        cfg.notify = _merge_section("notify", cfg.notify, raw["notify"] or {})
    if "daemon" in raw:
        d = raw["daemon"] or {}
        pf_raw = d.pop("peak_factor", None)
        if pf_raw is not None:
            cfg.daemon.peak_factor = _merge_section(
                "daemon.peak_factor", cfg.daemon.peak_factor, pf_raw)
        cfg.daemon = _merge_section("daemon", cfg.daemon, d)
    _validate(cfg)
    return cfg


# ---------------- secrets 解析 + 脱敏视图 ----------------

@dataclass
class Secrets:
    """解析后的密钥集合；只经 redacted_view() 进日志。"""
    plan_key: str
    login: dict  # bigmodel 登录：login_url/phone/password

    def redacted_view(self) -> dict:
        return {
            "plan_key": MASK,
            "login": {k: (v if k == "login_url" else MASK)
                      for k, v in (self.login or {}).items()},
        }


def _load_json(path: Path) -> dict:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except FileNotFoundError:
        raise ConfigError(f"secrets 文件不存在: {path}") from None
    except json.JSONDecodeError as e:
        raise ConfigError(f"secrets 文件 JSON 解析失败: {path} ({e})") from None


def resolve_secrets(cfg: Config, *, secrets_path=None, settings_path=None) -> Secrets:
    """引用名 → 实际值。错误信息只含 ref 名，绝不含值（FR9/验收）。"""
    sec_path = Path(secrets_path) if secrets_path is not None else DEFAULT_SECRETS_PATH
    set_path = Path(settings_path) if settings_path is not None else DEFAULT_SETTINGS_PATH

    # 引用名集合（错误信息中具名）
    refs = sorted({p.plan_key_ref for p in cfg.providers.values() if p.plan_key_ref})
    if not sec_path.exists():
        raise ConfigError(
            f"secrets 文件缺失: {sec_path}；无法解析 plan_key_ref {refs} 与 bigmodel 登录"
            "（错误信息只含引用名，不含值）")

    data = _load_json(sec_path)

    # 套餐 Key：优先 secrets 文件（plan_keys.<ref> 或 <ref>.plan_key），回退 settings.json env
    plan_key = ""
    plan_keys_map = data.get("plan_keys") if isinstance(data.get("plan_keys"), dict) else {}
    primary_ref = cfg.providers["zai"].plan_key_ref if "zai" in cfg.providers else (refs[0] if refs else "")
    if primary_ref and primary_ref in plan_keys_map and plan_keys_map[primary_ref]:
        plan_key = str(plan_keys_map[primary_ref])
    else:
        env = (_load_json(set_path).get("env") or {}) if set_path.exists() else {}
        token = env.get("ANTHROPIC_AUTH_TOKEN") or ""
        if token:
            plan_key = str(token)
    if not plan_key:
        raise ConfigError(
            f"plan_key_ref '{primary_ref}': 套餐 Key 无从解析（secrets 文件无 plan_keys.{primary_ref}，"
            f"且 {set_path} env.ANTHROPIC_AUTH_TOKEN 缺失）——错误只带引用名，不带值")

    # bigmodel 登录（重置动作链路用）：只认 secrets 文件 bigmodel 节
    login = data.get("bigmodel") or {}
    if not isinstance(login, dict) or not all(login.get(k) for k in ("login_url", "phone", "password")):
        raise ConfigError(
            "secrets 'bigmodel' 节不完整（需 login_url/phone/password）："
            "错误信息只含引用名 'bigmodel'，不含任何值")

    return Secrets(plan_key=plan_key, login=dict(login))
