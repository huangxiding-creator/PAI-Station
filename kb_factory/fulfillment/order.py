# -*- coding: utf-8 -*-
"""W7 履约流水线：订单与订单箱。

契约：付费触发履约。订单 = inbox/ 下 *.json，落盘即认领；
处理完 os.rename 移 done/，失败移 failed/ 并写 <stem>.reason.txt。
铁律：任何分支绝不删除文件（failed 也只移动）。
"""
import json
import os
import time
from dataclasses import dataclass, asdict, fields
from pathlib import Path

VERSIONS = ("original", "markdown", "ima_pack")


@dataclass
class Order:
    """付费订单（字段与小程序下单回执对齐）。"""
    id: str
    need_text: str = ""
    blueprint_ref: str = ""          # 蓝图 JSON 路径（编目引擎产物）
    email: str = ""                  # 交付邮箱
    version_selection: str = "original"  # original|markdown|ima_pack
    price: str = ""
    paid_at: str = ""
    status: str = "paid"

    def __post_init__(self):
        if not self.id:
            raise ValueError("订单缺少 id")
        if not self.email or "@" not in self.email:
            raise ValueError(f"订单 {self.id} 缺少合法 email")
        if not self.blueprint_ref:
            raise ValueError(f"订单 {self.id} 缺少 blueprint_ref")
        if self.version_selection not in VERSIONS:
            raise ValueError(f"订单 {self.id} version_selection 越界: {self.version_selection}")

    @classmethod
    def from_dict(cls, d: dict) -> "Order":
        known = {f.name for f in fields(cls)}
        return cls(**{k: v for k, v in (d or {}).items() if k in known})

    @classmethod
    def from_json(cls, path) -> "Order":
        p = Path(path)
        try:
            d = json.loads(p.read_text(encoding="utf-8"))
        except (OSError, ValueError) as e:
            raise ValueError(f"订单文件不可读/非法 JSON: {p.name}: {e}") from e
        try:
            return cls.from_dict(d)
        except TypeError as e:
            raise ValueError(f"订单字段非法: {p.name}: {e}") from e

    def to_dict(self) -> dict:
        return asdict(self)


class OrderInbox:
    """订单箱：inbox/ 认领 → done/ 或 failed/（只 rename，绝不删除）。"""

    def __init__(self, base_dir):
        base = Path(base_dir)
        self.base = base
        self.inbox_dir = base / "inbox"
        self.done_dir = base / "done"
        self.failed_dir = base / "failed"

    def ensure_dirs(self):
        for d in (self.inbox_dir, self.done_dir, self.failed_dir):
            d.mkdir(parents=True, exist_ok=True)

    def pending(self) -> list:
        """inbox/ 下待认领订单（按文件名排序，确定性）。"""
        if not self.inbox_dir.is_dir():
            return []
        return sorted(self.inbox_dir.glob("*.json"), key=lambda p: p.name)

    def _rename_in(self, path, dest_dir: Path) -> Path:
        dest_dir.mkdir(parents=True, exist_ok=True)
        src = Path(path)
        dst = dest_dir / src.name
        if dst.exists():  # 极端重名：加时间戳后缀，仍不覆盖不删除
            dst = dest_dir / f"{src.stem}.{time.strftime('%H%M%S')}{src.suffix}"
        os.rename(src, dst)  # 同卷 rename：认领即移走，防 --watch 重复处理
        return dst

    def complete(self, path) -> Path:
        """处理成功：移 done/。"""
        return self._rename_in(path, self.done_dir)

    def fail(self, path, reason: str) -> Path:
        """处理失败：移 failed/ + 原因 sidecar（不删除原订单文件）。"""
        dst = self._rename_in(path, self.failed_dir)
        ts = time.strftime("%Y-%m-%dT%H:%M:%S")
        sidecar = dst.with_name(dst.stem + ".reason.txt")
        sidecar.write_text(f"[{ts}] {reason}\n", encoding="utf-8")
        return dst
