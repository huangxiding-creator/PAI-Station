# -*- coding: utf-8 -*-
"""T-03 config+secrets 加载器测试（covers FR9 安全 / ADR4 密钥布局）。

自举：本测试可从仓库根目录直接运行
    e:/AI-Station/.venv/Scripts/python.exe -m pytest zhipu-quota-guard/tests/test_config.py -q
无需 conftest/安装（避免与其他 worker 的 tests/ 共享文件冲突）。
"""
import json
import sys
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]  # zhipu-quota-guard/
sys.path.insert(0, str(ROOT))

from zqg.config import (  # noqa: E402
    Config,
    ConfigError,
    Secrets,
    load_config,
    resolve_secrets,
    MASK,
)

EXAMPLE_YAML = ROOT / "config.example.yaml"

# ---------------- load_config：SCHEMAS §3 契约 ----------------

def test_t03_fr9_example_yaml_equals_code_defaults():
    """验收：config.example.yaml 与默认值全量一致。"""
    cfg = load_config(EXAMPLE_YAML)
    assert cfg == Config()
    # 逐字段点名（防止 dataclass eq 掩盖字段遗漏）
    assert cfg.poll.idle_min == 10 and cfg.poll.busy_min == 2
    assert cfg.poll.threshold_pct == 90
    assert cfg.policy.reserve_cards == 1 and cfg.policy.lead_time_min == 30
    assert cfg.policy.fifo_by_expiry is True
    assert cfg.policy.mode == "dry_run"  # 首次部署默认安全模式（FR9）
    assert cfg.notify.wecom is True
    assert cfg.daemon.heartbeat_min == 15
    assert cfg.daemon.peak_factor.peak == 1.0   # KB V3：高峰 1x
    assert cfg.daemon.peak_factor.offpeak == 0.5  # 非高峰 0.5x
    # 双站 enabled，zai 主、bigmodel 备（W0：双域同源故障转移）
    assert list(cfg.providers) == ["zai", "bigmodel"]
    assert cfg.providers["zai"].enabled and cfg.providers["bigmodel"].enabled
    assert cfg.providers["zai"].base_url == "https://api.z.ai"
    assert cfg.providers["bigmodel"].base_url == "https://open.bigmodel.cn"


def test_t03_fr9_missing_fields_filled_with_defaults(tmp_path):
    """验收：缺字段按 SCHEMAS §3 默认补齐。"""
    p = tmp_path / "minimal.yaml"
    p.write_text("poll:\n  idle_min: 20\n", encoding="utf-8")
    cfg = load_config(p)
    assert cfg.poll.idle_min == 20          # 覆盖生效
    assert cfg.poll.busy_min == 2           # 缺省补齐
    assert cfg.policy.mode == "dry_run"
    assert cfg.daemon.peak_factor.offpeak == 0.5


def test_t03_fr9_empty_providers_gets_default_dual_site(tmp_path):
    p = tmp_path / "p.yaml"
    p.write_text("providers:\n  zai:\n    enabled: false\n", encoding="utf-8")
    cfg = load_config(p)
    assert cfg.providers["zai"].enabled is False          # 覆盖生效
    assert cfg.providers["zai"].plan_key_ref == "zai"     # 缺省=站名
    assert cfg.providers["bigmodel"].enabled is True      # 缺省整站补齐


def test_t03_fr9_missing_config_file_clear_error(tmp_path):
    with pytest.raises(ConfigError, match="config"):
        load_config(tmp_path / "nope.yaml")


# ---------------- 非法值 → 带字段名的 ConfigError ----------------

def _write(tmp_path, text):
    p = tmp_path / "c.yaml"
    p.write_text(text, encoding="utf-8")
    return p


def test_t03_fr9_threshold_pct_above_100_raises_with_field_name(tmp_path):
    p = _write(tmp_path, "poll:\n  threshold_pct: 101\n")
    with pytest.raises(ConfigError) as ei:
        load_config(p)
    assert "poll.threshold_pct" in str(ei.value)


def test_t03_fr9_threshold_pct_non_positive_raises(tmp_path):
    for bad in (0, -5):
        p = _write(tmp_path, f"poll:\n  threshold_pct: {bad}\n")
        with pytest.raises(ConfigError) as ei:
            load_config(p)
        assert "poll.threshold_pct" in str(ei.value)


def test_t03_fr9_wrong_mode_raises_with_field_and_allowed_values(tmp_path):
    p = _write(tmp_path, 'policy:\n  mode: "autopilot"\n')
    with pytest.raises(ConfigError) as ei:
        load_config(p)
    msg = str(ei.value)
    assert "policy.mode" in msg
    for allowed in ("auto", "dry_run", "notify_only"):
        assert allowed in msg


def test_t03_fr9_idle_min_below_busy_min_raises(tmp_path):
    p = _write(tmp_path, "poll:\n  idle_min: 1\n  busy_min: 2\n")
    with pytest.raises(ConfigError) as ei:
        load_config(p)
    assert "poll.idle_min" in str(ei.value) and "busy_min" in str(ei.value)


def test_t03_fr9_unknown_key_typo_raises_with_field_name(tmp_path):
    """拼错字段不得静默落默认（配额守卫安全语义）。"""
    p = _write(tmp_path, "poll:\n  thresold_pct: 95\n")
    with pytest.raises(ConfigError) as ei:
        load_config(p)
    assert "thresold_pct" in str(ei.value) and "poll" in str(ei.value)


# ---------------- resolve_secrets：引用名 → 实际值 ----------------

SETTINGS_ENV_TOKEN = "sk-live-plan-key-SENTINEL-8dzV"


def _settings_file(tmp_path, token=SETTINGS_ENV_TOKEN):
    p = tmp_path / "settings.json"
    p.write_text(json.dumps({"env": {"ANTHROPIC_AUTH_TOKEN": token}}), encoding="utf-8")
    return p


def _secrets_file(tmp_path, with_plan_key=False):
    d = {"bigmodel": {"login_url": "https://bigmodel.cn/login",
                      "phone": "13800000000",
                      "password": "pw-SENTINEL"}}
    if with_plan_key:
        d["plan_keys"] = {"zai": "sk-from-secrets-file-8dzV"}
    p = tmp_path / "zhipu_secrets.json"
    p.write_text(json.dumps(d), encoding="utf-8")
    return p


def test_t03_fr9_resolve_secrets_plan_key_falls_back_to_settings_env(tmp_path):
    """现网事实：secrets 文件只有 bigmodel 登录，套餐 Key 在 settings.json env。"""
    cfg = load_config(EXAMPLE_YAML)
    sec = resolve_secrets(cfg, secrets_path=_secrets_file(tmp_path),
                          settings_path=_settings_file(tmp_path))
    assert isinstance(sec, Secrets)
    assert sec.plan_key == SETTINGS_ENV_TOKEN
    assert sec.login["phone"] == "13800000000"
    assert sec.login["login_url"].startswith("https://")


def test_t03_fr9_resolve_secrets_file_entry_wins_over_settings(tmp_path):
    """DoD：plan_key_ref 解析以 secrets 文件取值为先。"""
    d = tmp_path / "d2"
    d.mkdir()
    cfg = load_config(EXAMPLE_YAML)
    sec = resolve_secrets(cfg, secrets_path=_secrets_file(d, with_plan_key=True),
                          settings_path=_settings_file(d))
    assert sec.plan_key == "sk-from-secrets-file-8dzV"


def test_t03_fr9_missing_secrets_file_error_names_ref_not_value(tmp_path):
    """验收：secrets 文件缺失时错误信息含 ref 名、不含值。"""
    cfg = load_config(EXAMPLE_YAML)
    with pytest.raises(ConfigError) as ei:
        resolve_secrets(cfg, secrets_path=tmp_path / "absent.json",
                        settings_path=_settings_file(tmp_path))
    msg = str(ei.value)
    assert "zai" in msg and "bigmodel" in msg
    assert SETTINGS_ENV_TOKEN not in msg  # 绝不带值


def test_t03_fr9_unresolvable_plan_key_error_names_ref(tmp_path):
    d = tmp_path / "d4"
    d.mkdir()
    cfg = load_config(EXAMPLE_YAML)
    with pytest.raises(ConfigError) as ei:
        resolve_secrets(cfg, secrets_path=_secrets_file(d),
                        settings_path=_settings_file(d, token=""))
    msg = str(ei.value)
    assert "zai" in msg            # ref 名在场
    assert "8dzV" not in msg       # 值不在场


# ---------------- redacted_view：日志全量脱敏（FR9） ----------------

def test_t03_fr9_redacted_view_masks_every_credential():
    sec = Secrets(plan_key=SETTINGS_ENV_TOKEN,
                  login={"login_url": "https://bigmodel.cn/login",
                         "phone": "13800000000",
                         "password": "pw-SENTINEL"})
    view = json.dumps(sec.redacted_view(), ensure_ascii=False)
    assert SETTINGS_ENV_TOKEN not in view
    assert "13800000000" not in view
    assert "pw-SENTINEL" not in view
    assert MASK in view


# ---------------- ADR4：config.yaml 只含引用名，不含密钥 ----------------

def test_t03_adr4_example_yaml_holds_refs_only_no_secrets():
    text = EXAMPLE_YAML.read_text(encoding="utf-8")
    assert "plan_key_ref" in text          # 引用名机制在场
    for banned in ("password", "phone", "ANTHROPIC_AUTH_TOKEN", "sk-"):
        assert banned not in text, f"config 疑似泄密字段: {banned}"
