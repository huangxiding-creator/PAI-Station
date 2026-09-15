# -*- coding: utf-8 -*-
"""M9b 百度网盘连接器：bdpan CLI 只读列表 → cloud.drive.change 事件。

安全边界：连接器只做只读（whoami/ls），登录授权必须由用户人工走
skill 的 login.sh（bdpan 安全约束第 1 条），CLI 不在位=未激活。
runner 可注入（测试不打真 CLI）。

增量语义：水位线=上轮 {路径: 大小} 快照——新增/变更出事件，
消失不报（只增不删精神），天然幂等且不依赖平台时间字段。
"""
from __future__ import annotations

import json
import logging
import shutil
import subprocess

from paistation.sense.cloud.base import CloudConnector

_log = logging.getLogger("paistation.sense.cloud.bdpan")

ROOT = "/apps/bdpan"
NO_WINDOW = 0x08000000  # CREATE_NO_WINDOW（Windows 不弹窗铁律）


def _default_runner(argv: list[str], timeout: float = 20.0) -> tuple[int, str]:
    """bdpan CLI 子进程薄壳：CREATE_NO_WINDOW，异常按失败返回。"""
    try:
        r = subprocess.run(["bdpan"] + argv, capture_output=True, timeout=timeout,
                           creationflags=NO_WINDOW)
        return r.returncode, r.stdout.decode("utf-8", errors="replace")
    except (OSError, subprocess.SubprocessError) as exc:
        _log.warning("bdpan %s 失败: %s", argv[:1], exc)
        return 1, ""


class BaiduDriveConnector(CloudConnector):
    name = "cloud.baidu-drive"
    scopes = ("cloud.drive.read",)

    def __init__(self, cli_path: str | None = None, runner=None):
        self._cli = cli_path if cli_path is not None else shutil.which("bdpan")
        self._run = runner or _default_runner

    def login_flow(self) -> bool:
        """授权走用户人工 login.sh，连接器不代登（永远返回未登录态）。"""
        return False

    def test_session(self) -> bool:
        if not self._cli:
            return False
        rc, _ = self._run(["whoami"])
        return rc == 0

    def collect(self, since_watermark):
        if not self._cli:
            return [], since_watermark  # CLI 未装=未激活
        rc, out = self._run(["ls", ROOT, "--json", "--order", "time"])
        if rc != 0:
            return [], since_watermark  # 未登录/故障：水位线原地踏步
        current = self._parse(out)
        if current is None:
            return [], since_watermark
        previous = since_watermark.get("files", {}) if isinstance(
            since_watermark, dict) else {}
        events: list[dict] = []
        for path, size in sorted(current.items()):
            old = previous.get(path)
            if old == size:
                continue
            verb = "新文件" if old is None else "已更新"
            events.append({
                "type": "cloud.drive.change",
                "text": f"百度网盘{verb}：{path}",
                "evidence": {"path": path, "size": size,
                             "previous_size": old},
            })
        return events, {"files": current}

    @staticmethod
    def _parse(out: str) -> dict[str, int] | None:
        """ls --json 输出 → {路径: 大小}；容错 list/{"list":[]}/坏档。"""
        try:
            data = json.loads(out)
        except ValueError:
            return None
        if isinstance(data, dict):
            for key in ("list", "files", "data"):
                if isinstance(data.get(key), list):
                    data = data[key]
                    break
            else:
                return None
        snap: dict[str, int] = {}
        for item in data:
            if not isinstance(item, dict):
                continue
            path = item.get("path") or item.get("server_filename") or item.get("name")
            if not path:
                continue
            if item.get("isdir") in (1, True, "1"):
                continue  # 目录不入快照（其子文件自身会出现在列表里）
            snap[str(path)] = int(item.get("size") or 0)
        return snap
