"""M6.2 首启向导（dist/）：3 步——档位 / 大脑 / 授权。

- 档位：自动探测给出建议，用户可改
- 大脑：LLM base_url+model；密钥只记「环境变量名」，本体永不落盘
  （用户误粘密钥=拒收并降级记默认环境变量名）
- 授权：opt-in 分层授权（隐私红线），按编号勾选，无效项丢弃
- 幂等：wizard.json 已 done 再跑直接跳过
"""
from __future__ import annotations

import json
import re
from pathlib import Path

from .tiers import detect

# 授权目录（编号→(scope, 中文说明)）：默认全不勾，勾了才采
SCOPE_CATALOG = [
    ("voice.read", "语音转写（会议/口述）"),
    ("screen.title", "窗口标题（判断在做什么）"),
    ("type.keystroke", "打字内容"),
    ("screen.ocr", "屏幕内容识别"),
    ("file.watch", "文件变化监听"),
    ("clipboard.read", "剪贴板（仅手动复制时）"),
    ("cloud.docs.read", "云文档（需另行登录授权）"),
]
_DEFAULT_SCOPES = ("voice.read", "screen.title", "file.watch")
_SECRET_SHAPE = re.compile(r"(sk-[A-Za-z0-9]{8,}|[A-Za-z0-9]{32,})")


class FirstRunWizard:

    def __init__(self, data_dir: str | Path):
        self._dir = Path(data_dir)
        self._path = self._dir / "wizard.json"

    def run(self, answers: dict) -> dict:
        if self._done():
            return {"skipped": True, "done": True}
        tier, settings = detect()
        wanted = str(answers.get("tier", "auto")).strip().lower()
        if wanted in ("low", "mid", "high"):
            tier = wanted
        cfg = {
            "tier": tier,
            "settings": settings,
            "llm": self._brain(answers),
            "scopes": self._scopes(answers),
            "done": True,
        }
        self._dir.mkdir(parents=True, exist_ok=True)
        self._path.write_text(json.dumps(cfg, ensure_ascii=False, indent=1),
                              encoding="utf-8")
        return {"done": True, "tier": tier, "scopes": cfg["scopes"]}

    def _done(self) -> bool:
        if not self._path.is_file():
            return False
        try:
            return bool(json.loads(
                self._path.read_text(encoding="utf-8")).get("done"))
        except (OSError, ValueError):
            return False

    def _brain(self, answers: dict) -> dict:
        key_env = str(answers.get("key_env", "PAI_LLM_KEY")).strip()
        if _SECRET_SHAPE.search(key_env):
            # 误粘密钥本体：拒收，降级记默认环境变量名（红线：密钥零落盘）
            key_env = "PAI_LLM_KEY"
        return {
            "base_url": str(answers.get(
                "base_url", "https://open.bigmodel.cn/api/paas/v4")).strip(),
            "model": str(answers.get("model", "glm-4.7-flash")).strip(),
            "key_env": key_env,
        }

    def _scopes(self, answers: dict) -> list[str]:
        valid = {str(i + 1): scope for i, (scope, _cn) in
                 enumerate(SCOPE_CATALOG)}
        picked = []
        for token in str(answers.get("scopes", "1,2,5")).replace(
                "，", ",").split(","):
            scope = valid.get(token.strip())
            if scope and scope not in picked:
                picked.append(scope)
        return picked or list(_DEFAULT_SCOPES)
