# -*- coding: utf-8 -*-
"""forge/glm_json.py — GLM JSON 鸭子客户端（W4.1）。

对齐 ideadig.analysis.stages 的 llm.chat_json(system, user, temperature=,
timeout=) 接口，供 IdeaDig 阶段函数直接调用；urllib 直连（国内端点不吃
系统代理，同 tools/feedback_revision_loop.glm 范式），多密钥轮换，
JSON 解析复用 ideadig.llm_client.parse_json（容错去围栏）。
密钥位: data/secrets/zhipu.secret（api_key= 行，gitignored）——密钥不进仓不进日志。
"""
from __future__ import annotations

import json
import sys
import urllib.request
from pathlib import Path

IDEADIG_ROOT = Path("E:/AI-Station/IdeaDig")
if str(IDEADIG_ROOT) not in sys.path:
    sys.path.insert(0, str(IDEADIG_ROOT))
from ideadig.llm_client import parse_json          # noqa: E402 — 复用容错解析

SECRET = Path("E:/AI-Station/data/secrets/zhipu.secret")
ENDPOINT = "https://open.bigmodel.cn/api/paas/v4/chat/completions"
DEFAULT_MODEL = "glm-4-flash"      # 便宜基线；--model 可换高档（避峰令照旧）


def load_keys(secret_file: Path | str = SECRET) -> list[str]:
    out: list[str] = []
    p = Path(secret_file)
    if p.is_file():
        for line in p.read_text(encoding="utf-8", errors="replace").splitlines():
            line = line.strip()
            for k in ("api_key_2=", "api_key=", "key="):
                if line.startswith(k) and len(line) > len(k) + 8:
                    out.append(line[len(k):])
    return list(dict.fromkeys(out))


class GlmJson:
    """chat_json 鸭子件：返回解析后的 JSON 对象/数组；多密钥轮换逐个试。"""

    def __init__(self, model: str = DEFAULT_MODEL, keys: list[str] | None = None):
        self.model = model
        self.keys = keys if keys is not None else load_keys()
        self.calls = 0

    def chat_json(self, system: str, user: str, temperature: float = 0.2,
                  timeout: int = 60):
        if not self.keys:
            raise RuntimeError("无可用智谱密钥（data/secrets/zhipu.secret）")
        last_err = ""
        opener = urllib.request.build_opener(
            urllib.request.ProxyHandler({}))          # 直连
        for key in self.keys:
            body = json.dumps({"model": self.model, "temperature": temperature,
                               "messages": [{"role": "system", "content": system},
                                            {"role": "user", "content": user}]},
                              ensure_ascii=False).encode("utf-8")
            req = urllib.request.Request(
                ENDPOINT, data=body, method="POST",
                headers={"Authorization": f"Bearer {key}",
                         "Content-Type": "application/json"})
            try:
                with opener.open(req, timeout=timeout) as r:
                    txt = json.loads(r.read())["choices"][0]["message"]["content"]
                self.calls += 1
                return parse_json(txt)
            except Exception as e:                    # noqa: BLE001 — 换键重试
                last_err = str(e)[:160]
        raise RuntimeError(f"GLM 全密钥失败: {last_err}")
