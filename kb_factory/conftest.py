# -*- coding: utf-8 -*-
"""kb_factory 全局测试隔离（1022 退信事故根修）：
任何测试进程内/子进程都不得看到真 SMTP/企微配置——autouse 钉死，
个别测试的显式隔离只是第二道，不再是唯一防线。"""
import os

import pytest


@pytest.fixture(autouse=True)
def _kb_isolate_network(monkeypatch):
    monkeypatch.setenv("KB_SMTP_SECRET", os.environ.get("KB_TEST_SMTP_SECRET", r"NUL:\nonexistent\smtp.test-only"))
    monkeypatch.setenv("KB_WECOM_NOTIFY", "0")
    yield
