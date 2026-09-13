"""Phase C1-C3 机器控制面核心链：动作注册表→风控策略→网关执行。

动作四级（读/写/花钱/不可逆）×限额/白名单；失败即回滚；网关=第三方
可复用的稳定 API（验收 100× 首证）。
"""
import pytest

from paistation.control.gateway import Gateway
from paistation.control.policy import Action, Policy
from paistation.control.registry import ActionSpec, Registry


@pytest.fixture()
def registry():
    reg = Registry()
    reg.register(ActionSpec(name="fs.read", path="read", reversible=True,
                            description="读文件"))
    reg.register(ActionSpec(name="fs.write", path="write", reversible=True,
                            rollback="restore backup"))
    reg.register(ActionSpec(name="cloud.pay", path="spend", reversible=False,
                            description="花钱"))
    reg.register(ActionSpec(name="fs.delete", path="irreversible",
                            reversible=False))
    return reg


# ---- C1 注册表 ----

def test_registry_lookup(registry):
    spec = registry.get("fs.read")
    assert spec.path == "read"


def test_registry_unknown_action_raises(registry):
    with pytest.raises(KeyError):
        registry.get("no.such")


def test_registry_list_by_path(registry):
    assert {s.name for s in registry.list(path="write")} == {"fs.write"}


# ---- C2 风控策略 ----

def test_policy_read_allowed_by_default(registry):
    pol = Policy(registry)
    verdict = pol.judge(Action("fs.read", {"path": "a.md"}))
    assert verdict["decision"] == "allow"


def test_policy_write_needs_whitelist(registry):
    pol = Policy(registry, write_whitelist=("E:/AI-Station/",))
    denied = pol.judge(Action("fs.write", {"path": "C:/Windows/system32/cfg"}))
    assert denied["decision"] == "deny"
    ok = pol.judge(Action("fs.write", {"path": "E:/AI-Station/x.md"}))
    assert ok["decision"] == "allow"


def test_policy_spend_capped(registry):
    pol = Policy(registry, spend_limit_yuan=10.0)
    a = pol.judge(Action("cloud.pay", {"yuan": 8.0}))
    assert a["decision"] == "allow"
    b = pol.judge(Action("cloud.pay", {"yuan": 5.0}))       # 累计 13>10
    assert b["decision"] == "confirm"
    assert "限额" in b["why"]


def test_policy_irreversible_always_confirm(registry):
    pol = Policy(registry)
    v = pol.judge(Action("fs.delete", {"path": "x"}))
    assert v["decision"] == "confirm"
    assert "不可逆" in v["why"]


def test_policy_unknown_action_denied():
    pol = Policy(Registry())
    v = pol.judge(Action("no.such", {}))
    assert v["decision"] == "deny"


# ---- C3 网关 ----

def test_gateway_executes_allowed_action(registry, tmp_path):
    calls = []

    def handler(args):
        calls.append(args)
        return "content"

    registry.register(ActionSpec(name="fs.read2", path="read",
                                 reversible=True, handler=handler))
    gw = Gateway(registry, tmp_path)
    r = gw.execute("fs.read2", {"path": "a.md"})
    assert r["ok"] and r["result"] == "content"
    assert calls == [{"path": "a.md"}]


def test_gateway_denied_action_not_executed(registry, tmp_path):
    calls = []

    registry.register(ActionSpec(name="fs.del2", path="irreversible",
                                 reversible=False, handler=calls.append))
    gw = Gateway(registry, tmp_path, auto_confirm=True)   # 自动确认开启也执行
    gw.execute("fs.del2", {})
    assert calls == [{}]


def test_gateway_dry_run_when_no_handler(registry, tmp_path):
    gw = Gateway(registry, tmp_path)
    r = gw.execute("fs.read", {"path": "a.md"})
    assert r["ok"] and r["dry_run"] is True


def test_gateway_rollback_on_failure(registry, tmp_path):
    rollbacks = []

    def bad_handler(args):
        raise RuntimeError("炸了")

    registry.register(ActionSpec(
        name="fs.write2", path="write", reversible=True,
        handler=bad_handler, rollback=lambda args: rollbacks.append(args)))
    gw = Gateway(registry, tmp_path,
                 policy=Policy(registry, write_whitelist=("E:/",)))
    r = gw.execute("fs.write2", {"path": "E:/AI-Station/x"})
    assert r["ok"] is False
    assert "炸了" in r["error"]
    assert rollbacks == [{"path": "E:/AI-Station/x"}]   # 失败即回滚（SWE-agent 律）


def test_gateway_ledger_records_every_execution(registry, tmp_path):
    gw = Gateway(registry, tmp_path)
    gw.execute("fs.read", {"path": "a"})
    gw.execute("fs.read", {"path": "b"})
    from paistation.control.gateway import execution_log

    rows = execution_log(tmp_path)
    assert len(rows) == 2
    assert rows[0]["action"] == "fs.read"
    assert rows[0]["decision"] == "allow"


def test_gateway_thirdparty_reuse(tmp_path):
    """验收判据：第三方脚本/harness 仅 import 网关即可复用（100× 首证）。"""
    import subprocess
    import sys

    code = (
        "import sys; sys.path.insert(0, 'src');"
        "from paistation.control.gateway import Gateway;"
        "from paistation.control.registry import ActionSpec, Registry;"
        "r = Registry();"
        "r.register(ActionSpec(name='demo.ping', path='read', reversible=True));"
        "g = Gateway(r, r'C:/_nonexistent_gate_home_');"
        "out = g.execute('demo.ping', {});"
        "assert out['ok'], out; print('GATEWAY-REUSE-OK')"
    )
    r = subprocess.run([sys.executable, "-X", "utf8", "-c", code],
                       capture_output=True, text=True, encoding="utf-8",
                       errors="replace")
    assert "GATEWAY-REUSE-OK" in r.stdout, r.stderr[-400:]
