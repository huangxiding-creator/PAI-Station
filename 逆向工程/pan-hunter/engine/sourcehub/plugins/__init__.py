# -*- coding: utf-8 -*-
"""PAN-HUNTER 本地凭据插件框架（W2 · 法务原则#3 正面件）

铁律（PROPOSAL §七-3 凭据零托管）：
  1. 插件默认关闭——config.json 的 enabled 列表为空即全关；ph.py 启动**不加载任何凭据**；
  2. 凭据文件永不入仓（路径只指向用户本地自供文件，本框架只做「存在性检查」，不读内容）；
  3. 插件只本地调 CLI（subprocess），零上传零遥测；
  4. 本包 import 时零副作用：不读凭据文件、不起进程、不联网。

接口（BasePlugin）：
  name / tier(黄盘名) / cli(本地命令) / cred_path(用户自供凭据文件)
  status()  → 插件态字典（ph doctor 显示用；只查 enabled 配置+凭据文件存在性）
  run(args) → 仅当 enabled 且凭据在位才执行本地 CLI（显式调用才跑，doctor 不自动跑）
"""
from __future__ import annotations

import json
import subprocess
from pathlib import Path

PLUGINS_DIR = Path(__file__).resolve().parent
CONFIG_PATH = PLUGINS_DIR / "config.json"


class PluginDisabled(RuntimeError):
    """插件未启用（默认态）——调用 run() 前必须显式启用。"""


class BasePlugin:
    name: str = "base"
    tier: str = ""                       # 所属黄盘（baidu/123/...）
    cred_path: Path | None = None        # 用户自供凭据（本地文件，永不入仓）
    cli: list[str] = []                  # 本地 CLI 命令行（只本地执行）
    note: str = ""

    def status(self) -> dict:
        cfg = load_config()
        enabled = self.name in cfg.get("enabled", [])
        return {
            "plugin": self.name, "tier": self.tier, "enabled": enabled,
            "cred_file": str(self.cred_path) if self.cred_path else "",
            "cred_present": bool(self.cred_path and self.cred_path.exists()),
            "note": self.note,
        }

    def run(self, args: list[str] | None = None, timeout: int = 120) -> dict:
        """本地执行插件 CLI（需显式 enabled + 凭据在位）。返回进程结果摘要。"""
        st = self.status()
        if not st["enabled"]:
            raise PluginDisabled(f"插件 {self.name} 未启用（默认关；改 plugins/config.json）")
        if not st["cred_present"]:
            raise PluginDisabled(f"插件 {self.name} 凭据文件不在位：{st['cred_file']}")
        cmd = [*self.cli, *(args or [])]
        p = subprocess.run(cmd, capture_output=True, text=True,
                           encoding="utf-8", errors="replace", timeout=timeout,
                           cwd=str(Path(self.cli[1]).parent) if len(self.cli) > 1 else None)
        out = (p.stdout or "") + (p.stderr or "")
        return {"returncode": p.returncode, "masked_output": _mask(out[-2000:])}


def _mask(text: str) -> str:
    """输出掩码：凭据样式（长字母数字串）一律打码，零明文外泄。"""
    import re
    text = re.sub(r"[A-Za-z0-9_-]{28,}", "<MASKED>", text)
    return text


def load_config() -> dict:
    try:
        return json.loads(CONFIG_PATH.read_text(encoding="utf-8"))
    except FileNotFoundError:
        return {"enabled": [], "note": "config.json 缺失=全关（默认态）"}


def plugin_states() -> list[dict]:
    """ph doctor 用：全部插件态（零凭据读取，只查存在性）。"""
    return [p().status() for p in _REGISTRY.values()]


from .baidu_bdn import BaiduBdnPlugin          # noqa: E402
from .pan123_slot import Pan123SlotPlugin      # noqa: E402

_REGISTRY: dict[str, type[BasePlugin]] = {
    BaiduBdnPlugin.name: BaiduBdnPlugin,
    Pan123SlotPlugin.name: Pan123SlotPlugin,
}
