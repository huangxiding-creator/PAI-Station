"""全测试会话夹具密封：隔离宿主机环境耦合。

本机装有 Everything 时（09-16 起），Indexer 默认 auto-discover 会拿真
es.exe 查询全新 tmp 目录——USN 传播延迟内返回空，测试结果随机器漂移
（与 bdpan.exe PATH 泄漏同族）。默认全禁；walk 的发现路径测试自行
再 monkeypatch 覆盖。

注意：只替换 walk 模块内的名字绑定（打桩对象），绝不改全局 shutil
模块属性——autouse 作用域覆盖全部测试，动全局会误伤 doctor/bundle
等依赖 shutil.which 的用例。
"""
import types

import pytest

from paistation.sense.localfiles import walk


@pytest.fixture(autouse=True)
def _no_real_es(monkeypatch):
    """禁止一切测试触碰真实 es.exe（显式注入 es_exe 的假件不受影响）。"""
    monkeypatch.setattr(walk, "shutil",
                        types.SimpleNamespace(which=lambda name: None))
    monkeypatch.setattr(walk, "ES_FALLBACKS", ())
