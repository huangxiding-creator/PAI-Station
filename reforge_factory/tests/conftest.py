# -*- coding: utf-8 -*-
"""reforge_factory/tests 共享夹具 (T-002R / REQ-010.AC2).

gates_json: 把 gates_loader 权威源指到 tmp 副本 — 以真实 gates.json 为底,
按键覆盖后落盘并切换 DEFAULT_CONFIG_PATH; 消费点决策函数 (ammo_pool /
epc50_start_gate / superline.contracts) 全部无缓存现读 → 改副本即时生效.
"""
import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import gates_loader as GL                                # noqa: E402


@pytest.fixture
def gates_json(tmp_path, monkeypatch):
    """工厂: gates_json(**over) → 真底 + 覆盖键 → tmp gates.json + 切权威源."""
    real = GL.DEFAULT_CONFIG_PATH.read_text(encoding="utf-8")  # fixture 建立时快照真底

    def _set(**over):
        base = json.loads(real)
        base.update(over)
        p = tmp_path / "gates.json"
        p.write_text(json.dumps(base, ensure_ascii=False, indent=1),
                     encoding="utf-8")
        monkeypatch.setattr(GL, "DEFAULT_CONFIG_PATH", p)
        return base

    return _set
