"""NotebookLM 可选外脑（M7.5 / PROPOSAL_M7 §3.5）——默认关，零外部依赖。

主脑 = GLM 免费链；外脑 = NotebookLM（重调研资料外部合成）。
宪法纪律：不依赖外部路径；未配置时给出中文指引而非静默失败。
"""

_ON_VALUES = ("on", "1", "true", "yes")


def is_enabled(config: dict) -> bool:
    """config 为 INI 转 dict（[foundry] nblm=on|off，默认 off）。"""
    foundry = config.get("foundry", {}) if isinstance(config, dict) else {}
    return str(foundry.get("nblm", "off")).strip().lower() in _ON_VALUES


class NotebookBrain:
    """外脑适配器骨架。M8 接 NotebookLM 导入-合成流程后启用真实现。"""

    def __init__(self, config: dict):
        self._enabled = is_enabled(config)

    def synthesize(self, corpus: str) -> str:
        """外脑合成。未启用/未实现时抛出中文指引（不假完成）。"""
        if not self._enabled:
            raise RuntimeError(
                "NotebookLM 外脑未启用：在 config/pai.ini [foundry] 设 nblm=on "
                "并完成 NotebookLM 接入配置（M8 里程碑）后再调用。")
        raise RuntimeError(
            "NotebookLM 外脑已启用但适配器尚未接入（M8 里程碑），"
            "当前请使用主脑 GLM 链生成。")
