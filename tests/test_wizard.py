"""M6.2 首启向导：3 步（档位/大脑/授权），密钥永不落盘。"""
import json

from paistation.dist.wizard import FirstRunWizard


def _answers(**overrides):
    seq = {
        "tier": "auto",                    # 检测即所用
        "base_url": "https://open.bigmodel.cn/api/paas/v4",
        "model": "glm-4.7-flash",
        "key_env": "PAI_LLM_KEY",          # 只记环境变量名，不记密钥本身
        "scopes": "1,2,6",
    }
    seq.update(overrides)
    return seq


def test_three_steps_write_config(tmp_path):
    wiz = FirstRunWizard(data_dir=tmp_path)
    result = wiz.run(answers=_answers())
    assert result["done"] is True
    cfg = json.loads((tmp_path / "wizard.json").read_text(encoding="utf-8"))
    assert cfg["tier"] in ("low", "mid", "high")
    assert cfg["llm"]["base_url"].startswith("https://")
    assert cfg["llm"]["key_env"] == "PAI_LLM_KEY"
    assert "voice.read" in cfg["scopes"]      # 选项 1
    assert "clipboard.read" in cfg["scopes"]  # 选项 6
    # 红线：向导产物里不得出现密钥本体
    raw = (tmp_path / "wizard.json").read_text(encoding="utf-8")
    assert "api_key_value" not in raw and "sk-" not in raw


def test_secret_never_stored_even_if_pasted(tmp_path):
    """用户误把密钥粘进向导：拒收并引导改用环境变量。"""
    wiz = FirstRunWizard(data_dir=tmp_path)
    result = wiz.run(answers=_answers(key_env="sk-abc123SECRETVALUE456"))
    assert result["done"] is True             # 仍完成（降级记 env 默认名）
    raw = (tmp_path / "wizard.json").read_text(encoding="utf-8")
    assert "abc123SECRETVALUE" not in raw


def test_done_wizard_is_idempotent(tmp_path):
    wiz = FirstRunWizard(data_dir=tmp_path)
    wiz.run(answers=_answers())
    again = wiz.run(answers=_answers(tier="high"))   # 二次跑直接跳过
    assert again["skipped"] is True


def test_invalid_scope_rejected(tmp_path):
    wiz = FirstRunWizard(data_dir=tmp_path)
    result = wiz.run(answers=_answers(scopes="1,99"))
    assert result["done"] is True
    cfg = json.loads((tmp_path / "wizard.json").read_text(encoding="utf-8"))
    assert "voice.read" in cfg["scopes"]
    assert len(cfg["scopes"]) == 1            # 99 无效被丢弃
