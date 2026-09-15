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
MAX_DEPTH = 3  # 递归深度上限（防失控下钻）
MAX_DIRS = 50  # 单轮最多列目录数（节流边界）
NO_WINDOW = 0x08000000  # CREATE_NO_WINDOW（Windows 不弹窗铁律）


def _make_runner(exe: str):
    """bdpan CLI 子进程薄壳工厂：绑定解析后的可执行体路径。"""
    def _runner(argv: list[str], timeout: float = 20.0) -> tuple[int, str]:
        try:
            r = subprocess.run([exe] + argv, capture_output=True, timeout=timeout,
                               creationflags=NO_WINDOW)
            return r.returncode, r.stdout.decode("utf-8", errors="replace")
        except (OSError, subprocess.SubprocessError) as exc:
            _log.warning("bdpan %s 失败: %s", argv[:1], exc)
            return 1, ""
    return _runner


class BaiduDriveConnector(CloudConnector):
    name = "cloud.baidu-drive"
    scopes = ("cloud.drive.read",)

    def __init__(self, cli_path: str | None = None, runner=None):
        self._cli = cli_path if cli_path is not None else shutil.which("bdpan")
        self._run = runner or _make_runner(self._cli or "bdpan")

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
        current = self._walk()
        if current is None:
            return [], since_watermark  # 未登录/故障：水位线原地踏步
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

    def _walk(self) -> dict[str, int] | None:
        """有界 BFS：ROOT 起，目录入队下钻（MAX_DEPTH/MAX_DIRS 封顶），
        文件入快照。任一 ls 失败=整轮失败（水位线原地踏步）。"""
        snap: dict[str, int] = {}
        queue: list[tuple[str, int]] = [(ROOT, 0)]
        listed: set[str] = set()
        while queue and len(listed) < MAX_DIRS:
            directory, depth = queue.pop(0)
            if directory in listed:
                continue
            rc, out = self._run(["ls", directory, "--json", "--order", "time"])
            if rc != 0:
                return None
            items = self._items(out, directory)
            if items is None:
                return None
            listed.add(directory)
            for item in items:
                if item.get("isdir") in (1, True, "1"):
                    if depth < MAX_DEPTH:
                        queue.append((item["path"], depth + 1))
                else:
                    snap[item["path"]] = int(item.get("size") or 0)
        return snap

    @staticmethod
    def _items(out: str, parent: str = "") -> list[dict] | None:
        """ls --json 输出 → 条目列表；裸名按父目录拼接防跨目录撞键。"""
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
        items: list[dict] = []
        for entry in data:
            if not isinstance(entry, dict):
                continue
            path = str(entry.get("path") or "")
            if not path:
                name = entry.get("server_filename") or entry.get("name")
                if not name:
                    continue
                path = f"{parent}/{name}" if parent else str(name)
            items.append({"path": path, "isdir": entry.get("isdir"),
                          "size": entry.get("size") or 0})
        return items
