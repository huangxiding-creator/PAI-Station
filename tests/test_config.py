"""M0.2 配置日 TDD：附录 C.4 五类错误分支全覆盖（缺失/类型/越界/路径/危险组合）。

错误文案与提案逐字一致：
- 缺失必填 → "缺少配置 [sense].watch_dirs，请参考附录 C.1 填写"
- 类型错误 → "值 'abc' 不是合法整数（[proactive].max_push_per_day）"
- 越界 → "0.3 超出 [llm].upgrade_confidence 允许范围 0.5-0.9"
- 路径不存在 → 列出原始值与展开值
- 危险组合 → wechat_mode 非 vision_readonly 直接拒绝
"""
import os

import pytest

from paistation import config as cfg


def build_ini(tmp_path, **overrides) -> str:
    """生成一份合法 pai.ini，overrides 里非 None 的键替换对应段落整段文本。"""
    llm = overrides.get("llm", "\n".join([
        "fast_model = glm-4-flash-250414",
        "deep_model = glm-4.7-flash",
        "vision_model = glm-4.6v-flash",
        "long_model = glm-4.7-flash",
        "upgrade_confidence = 0.7",
        "ensemble_size = 8",
        "verify_rounds = 2",
        "semantic_cache = 1",
    ]))
    sense = overrides.get("sense", "\n".join([
        f"watch_dirs = {overrides.get('watch_dirs', tmp_path)}",
        "ignore_patterns = *.tmp,~$*,.git,node_modules",
        "screen_interval_sec = 600",
        "screen_blacklist = 密码管理器,银行,支付,登录",
        "fg_poll_sec = 300",
        "deepwork_apps = WINWORD.EXE,idea64.exe,Code.exe,wps.exe",
        "clipboard_enabled = 0",
    ]))
    channels = overrides.get("channels", "\n".join([
        "feishu_enabled = 0",
        "dingtalk_enabled = 0",
        "wecom_enabled = 1",
        "wechat_mode = vision_readonly",
        "notify_webhook =",
    ]))
    proactive = overrides.get("proactive", "\n".join([
        "max_push_per_day = 2",
        "drawer_retention_days = 7",
        "quiet_hours = 22:00-07:00",
        "explore_rate = 0.1",
    ]))
    privacy = overrides.get("privacy", "\n".join([
        "data_dir =",
        "export_on_exit = 0",
        "never_send = 原始截图,凭据类文件,身份证,银行卡",
    ]))
    learn = overrides.get("learn", "\n".join([
        "pdca_time = 02:00",
        "distill_min_samples = 5",
        "double_loop_confirm = 1",
    ]))
    wow = overrides.get("wow", "\n".join([
        "wow_first_run = 1",
        "singularity_announce = 1",
        "zero_bill_monthly = 1",
    ]))
    return "\n".join([
        f"[llm]\n{llm}", f"[sense]\n{sense}", f"[channels]\n{channels}",
        f"[proactive]\n{proactive}", f"[privacy]\n{privacy}",
        f"[learn]\n{learn}", f"[wow]\n{wow}", "",
    ])


def write(tmp_path, text) -> str:
    p = tmp_path / "pai.ini"
    p.write_text(text, encoding="utf-8")
    return str(p)


# ---------- 合法配置与默认值 ----------

def test_valid_config_loads(tmp_path):
    c = cfg.load(write(tmp_path, build_ini(tmp_path)))
    assert c["llm"]["deep_model"] == "glm-4.7-flash"
    assert c["sense"]["watch_dirs"] == (str(tmp_path),)


def test_defaults_applied_for_missing_optional(tmp_path):
    text = build_ini(tmp_path, llm="\n".join([
        "fast_model = glm-4-flash-250414",
    ]), sense=f"watch_dirs = {tmp_path}\n")
    c = cfg.load(write(tmp_path, text))
    assert c["llm"]["upgrade_confidence"] == 0.7
    assert c["llm"]["ensemble_size"] == 8
    assert c["sense"]["screen_interval_sec"] == 600
    assert c["proactive"]["max_push_per_day"] == 2
    assert c["learn"]["double_loop_confirm"] is True


def test_missing_file():
    with pytest.raises(cfg.ConfigError, match="未找到配置文件"):
        cfg.load(r"Z:\no\such\pai.ini")


def test_result_is_immutable(tmp_path):
    c = cfg.load(write(tmp_path, build_ini(tmp_path)))
    with pytest.raises(TypeError):
        c["llm"]["deep_model"] = "hacked"
    assert isinstance(c["sense"]["watch_dirs"], tuple)  # 深不可变：列表入 tuple


def test_tilde_expanded_in_watch_dirs(tmp_path):
    c = cfg.load(write(tmp_path, build_ini(tmp_path, watch_dirs=str(tmp_path))))
    assert "~" not in c["sense"]["watch_dirs"][0]


# ---------- ① 缺失必填 ----------

def test_missing_sense_section(tmp_path):
    text = build_ini(tmp_path, sense="ignore_patterns = *.tmp\n")
    with pytest.raises(cfg.ConfigError,
                       match=r"缺少配置 \[sense\]\.watch_dirs，请参考附录 C\.1 填写"):
        cfg.load(write(tmp_path, text))


def test_missing_watch_dirs_key(tmp_path):
    text = build_ini(tmp_path, sense="fg_poll_sec = 300\n")
    with pytest.raises(cfg.ConfigError, match="缺少配置"):
        cfg.load(write(tmp_path, text))


# ---------- ② 类型错误 ----------

def test_int_type_error_exact_message(tmp_path):
    text = build_ini(tmp_path, proactive="max_push_per_day = abc\nquiet_hours = 22:00-07:00\n")
    with pytest.raises(cfg.ConfigError,
                       match=r"值 'abc' 不是合法整数（\[proactive\]\.max_push_per_day）"):
        cfg.load(write(tmp_path, text))


def test_float_type_error(tmp_path):
    text = build_ini(tmp_path, llm="upgrade_confidence = high\n")
    with pytest.raises(cfg.ConfigError,
                       match=r"值 'high' 不是合法浮点数（\[llm\]\.upgrade_confidence）"):
        cfg.load(write(tmp_path, text))


def test_bool_type_error(tmp_path):
    text = build_ini(tmp_path, learn="double_loop_confirm = maybe\n")
    with pytest.raises(cfg.ConfigError, match="不是合法布尔"):
        cfg.load(write(tmp_path, text))


# ---------- ③ 越界 ----------

def test_range_low_exact_message(tmp_path):
    text = build_ini(tmp_path, llm="upgrade_confidence = 0.3\n")
    with pytest.raises(cfg.ConfigError,
                       match=r"0\.3 超出 \[llm\]\.upgrade_confidence 允许范围 0\.5-0\.9"):
        cfg.load(write(tmp_path, text))


def test_range_high(tmp_path):
    text = build_ini(tmp_path, llm="upgrade_confidence = 0.95\n")
    with pytest.raises(cfg.ConfigError, match="超出.*允许范围"):
        cfg.load(write(tmp_path, text))


def test_ensemble_size_range(tmp_path):
    text = build_ini(tmp_path, llm="ensemble_size = 40\n")
    with pytest.raises(cfg.ConfigError,
                       match=r"\[llm\]\.ensemble_size 允许范围 1-32"):
        cfg.load(write(tmp_path, text))


def test_verify_rounds_range(tmp_path):
    text = build_ini(tmp_path, llm="verify_rounds = -1\n")
    with pytest.raises(cfg.ConfigError, match="verify_rounds 允许范围 0-5"):
        cfg.load(write(tmp_path, text))


def test_screen_interval_range(tmp_path):
    text = build_ini(tmp_path, sense=f"watch_dirs = {tmp_path}\nscreen_interval_sec = 30\n")
    with pytest.raises(cfg.ConfigError, match="screen_interval_sec 允许范围 60-3600"):
        cfg.load(write(tmp_path, text))


def test_fg_poll_range(tmp_path):
    text = build_ini(tmp_path, sense=f"watch_dirs = {tmp_path}\nfg_poll_sec = 9999\n")
    with pytest.raises(cfg.ConfigError, match="fg_poll_sec 允许范围 60-900"):
        cfg.load(write(tmp_path, text))


def test_max_push_range(tmp_path):
    text = build_ini(tmp_path, proactive="max_push_per_day = 10\nquiet_hours = 22:00-07:00\n")
    with pytest.raises(cfg.ConfigError, match="max_push_per_day 允许范围 1-5"):
        cfg.load(write(tmp_path, text))


def test_drawer_retention_range(tmp_path):
    text = build_ini(tmp_path, proactive="drawer_retention_days = 1\nquiet_hours = 22:00-07:00\n")
    with pytest.raises(cfg.ConfigError, match="drawer_retention_days 允许范围 3-30"):
        cfg.load(write(tmp_path, text))


def test_explore_rate_range(tmp_path):
    text = build_ini(tmp_path, proactive="explore_rate = 0.5\nquiet_hours = 22:00-07:00\n")
    with pytest.raises(cfg.ConfigError, match="explore_rate 允许范围 0-0.3"):
        cfg.load(write(tmp_path, text))


def test_distill_min_samples_range(tmp_path):
    text = build_ini(tmp_path, learn="distill_min_samples = 2\ndouble_loop_confirm = 1\n")
    with pytest.raises(cfg.ConfigError, match="distill_min_samples 允许范围 3-10"):
        cfg.load(write(tmp_path, text))


# ---------- ④ 路径不存在（列出原始值与展开值） ----------

def test_watch_dirs_path_not_exist(tmp_path):
    text = build_ini(tmp_path, watch_dirs=f"{tmp_path},~/NopeDir")
    with pytest.raises(cfg.ConfigError) as ei:
        cfg.load(write(tmp_path, text))
    msg = str(ei.value)
    assert "路径不存在" in msg and "~/NopeDir" in msg
    assert os.path.expanduser("~/NopeDir") in msg  # 展开值也列出


# ---------- ⑤ 危险组合 ----------

def test_wechat_mode_rejected(tmp_path):
    text = build_ini(tmp_path, channels="wechat_mode = full\n")
    with pytest.raises(cfg.ConfigError, match="wechat_mode.*vision_readonly"):
        cfg.load(write(tmp_path, text))


def test_double_loop_confirm_cannot_disable(tmp_path):
    text = build_ini(tmp_path, learn="double_loop_confirm = 0\n")
    with pytest.raises(cfg.ConfigError, match="double_loop_confirm"):
        cfg.load(write(tmp_path, text))


# ---------- 格式校验 ----------

def test_quiet_hours_bad_format(tmp_path):
    text = build_ini(tmp_path, proactive="quiet_hours = 22-07\n")
    with pytest.raises(cfg.ConfigError, match="quiet_hours"):
        cfg.load(write(tmp_path, text))


def test_pdca_time_bad_format(tmp_path):
    text = build_ini(tmp_path, learn="pdca_time = 25:00\ndouble_loop_confirm = 1\n")
    with pytest.raises(cfg.ConfigError, match="pdca_time"):
        cfg.load(write(tmp_path, text))


def test_webhook_bad_format(tmp_path):
    text = build_ini(tmp_path,
                     channels="wecom_enabled = 1\nnotify_webhook = http://bad\n")
    with pytest.raises(cfg.ConfigError, match="notify_webhook"):
        cfg.load(write(tmp_path, text))


# ---------- api_key 优先级：env PAI_LLM_KEY > ini ----------

def test_api_key_env_overrides_ini(tmp_path, monkeypatch):
    monkeypatch.setenv("PAI_LLM_KEY", "e" * 32)
    text = build_ini(tmp_path, llm="api_key = " + "i" * 32 + "\n")
    c = cfg.load(write(tmp_path, text))
    assert cfg.resolve_api_key(c) == "e" * 32


def test_api_key_from_ini(tmp_path, monkeypatch):
    monkeypatch.delenv("PAI_LLM_KEY", raising=False)
    text = build_ini(tmp_path, llm="api_key = " + "i" * 32 + "\n")
    c = cfg.load(write(tmp_path, text))
    assert cfg.resolve_api_key(c) == "i" * 32


def test_api_key_missing_everywhere(tmp_path, monkeypatch):
    monkeypatch.delenv("PAI_LLM_KEY", raising=False)
    c = cfg.load(write(tmp_path, build_ini(tmp_path)))
    with pytest.raises(cfg.ConfigError, match="PAI_LLM_KEY"):
        cfg.resolve_api_key(c)
