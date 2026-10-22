# -*- coding: utf-8 -*-
"""T29 单测+实弹：账号池 account_pool/pool.py（FR8.1 轮换/健康/熔断；R13 tri_cap 即熔断退避）。

被测物 = kb_factory.harvest_engine.account_pool.pool（纯单测零网络 + live 实弹各半）：
- FR8.AC2（降单测，第二账号待供）：单账号池——acquire 稳定出同一槽、第二账号位留空
  不炸、未配站 None 不炸；轮换机制以合成第二账号（tmp ini，非真凭据）单测
  round-robin 回绕 + 冷却槽跳过 + 全冷却 None；
- FR8 多站点隔离：wenku/csdn/docin（任意站键通用）独立槽/独立 limiter，一站熔断不外溢；
- R13 熔断退避：NeedVerify(tri_cap) 事件驱动退避梯度 60s→300s→1800s（升梯/顶格/OK 复位
  重新起梯）+ RateLimiter（channel_adapters.base 真符号）连续错误熔断为第二道闸；
- 凭据纪律（公约 §7）：只扫 *.secret.ini；health()/repr 不回显任何凭据值（合成标记串
  全文检索断言）；坏 ini 记台账不炸；
- T41P0（2026-10-23，PentAGI 研判 P0 三项清偿·FR10.1 发布硬门）：
  P0-1（g）POSIX 权限门+敏感键 SecretStr 降敏+vars/asdict 纪律测试；
  P0-2（c）egress 出口抽象+同 egress 单活跃槽锁+health「同 IP 隔离不成立」标记；
  P0-3（a）单 OK 衰减-2+连续 3 次才真清零（间歇软封不再穿透升级梯）；
- 实弹用例（@pytest.mark.live）= FR8.AC1：真凭据槽 → PageSigner 匿名（无登录 cookie）
  → **不带 Acs-Token** 真调 ndocview/readerinfo（WENKU_SPEC §6.3 实证匿名即 tri_cap 信封）
  → AccountPool.report(NeedVerify/tri_cap) → 槽冷却三连（60→300→1800 实测）+ acquire None；
  KB_HARVEST_SKIP_LIVE=1 时跳过（skip reason 明示，公约第 4 条）。

实弹浏览器口径同 test_page_signer：module 唯一 fixture、--no-proxy-server 直连
（让路收窄令 1018：wenku 国内腿 24h 不间断）；进率节流走槽上真 RateLimiter.acquire()。
"""
import json
import os
import random
import re
import sys
import time
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    # worker worktree：kb_factory 未入 git → channel_adapters 只读复用主仓真身（供 kb_factory. 前缀解析）
    for _anc in _KB_DIR.parents:
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.channel_adapters.base import CircuitOpenError, RateLimiter
    from kb_factory.harvest_engine.account_pool.pool import (
        BACKOFF_LADDER_S, CREDENTIALS_DIR_DEFAULT, OK_CLEAR_RUN, OK_DECAY_K,
        OK_HOLD_S, SENSITIVE_LOGIN_KEYS, SecretStr, AccountPool, AccountSlot)
    from kb_factory.harvest_engine.account_pool import pool as pool_mod
    from kb_factory.harvest_engine.envelope import (
        EnvelopeFail, EnvelopeNeedVerify, EnvelopeOK)
except ImportError:
    from channel_adapters.base import CircuitOpenError, RateLimiter  # type: ignore
    from harvest_engine.account_pool.pool import (  # type: ignore
        BACKOFF_LADDER_S, CREDENTIALS_DIR_DEFAULT, OK_CLEAR_RUN, OK_DECAY_K,
        OK_HOLD_S, SENSITIVE_LOGIN_KEYS, SecretStr, AccountPool, AccountSlot)
    from harvest_engine.account_pool import pool as pool_mod  # type: ignore
    from harvest_engine.envelope import (  # type: ignore
        EnvelopeFail, EnvelopeNeedVerify, EnvelopeOK)

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"
_WENKU_SECRET_INI = CREDENTIALS_DIR_DEFAULT / "wenku.secret.ini"


# ---------------------------------------------------------------- 离线基建（tmp 凭据 + 确定性时钟）

class FakeClock:
    """可推进单调钟（冷却判定的确定性注入点；池与各槽 limiter 共用同一实例）。"""

    def __init__(self, start: float = 1000.0):
        self.now = float(start)

    def __call__(self) -> float:
        return self.now

    def advance(self, seconds: float) -> None:
        self.now += float(seconds)


def _no_sleep(_seconds: float) -> None:
    """limiter.acquire() 间隔等待的零等待替身（时间注入点，非被测物）。"""


def _write_secret_ini(directory: Path, filename: str, sections: dict) -> Path:
    """写一节=一账号的合成凭据 ini（tmp_path；值全为合成标记串，非真凭据——公约 §7）。"""
    directory.mkdir(parents=True, exist_ok=True)
    path = directory / filename
    lines = []
    for section, options in sections.items():
        lines.append(f"[{section}]")
        lines.extend(f"{key} = {value}" for key, value in options.items())
        lines.append("")
    path.write_text("\n".join(lines), encoding="utf-8")
    return path


def _make_pool(tmp_path, sections, *, clock=None, sites_config=None, filename="main.secret.ini"):
    """tmp 凭据目录 + 注入时钟的池（离线用例统一入口）。"""
    _write_secret_ini(tmp_path, filename, sections)
    return AccountPool(sites_config, credentials_dir=tmp_path,
                       clock=clock, sleep=_no_sleep)


# ---------------------------------------------------------------- FR8.AC2（降单测）

def test_fr8_ac2_single_account_acquire_second_slot_absent_no_crash(tmp_path):
    """FR8.AC2：单账号（第二账号待供）——acquire 稳定出同一槽；第二账号位留空不炸。"""
    clock = FakeClock()
    pool = _make_pool(tmp_path, {"wenku": {"username": "SYNTH_U1", "password": "SYNTH_P1"}},
                      clock=clock, sites_config={"wenku": {}})
    slot = pool.acquire("wenku")
    assert slot is not None and slot.name == "wenku#1"
    assert isinstance(slot.limiter, RateLimiter)          # channel_adapters.base 真符号
    assert slot.limiter.name == "account:wenku#1" and slot.limiter.min_interval == 3.0
    assert slot.cookie == ""                               # ini 无 cookie 键 → 匿名槽如实留空
    assert slot.source == "main.secret.ini"
    for _ in range(5):                                     # 轮换游标单账号安全回绕：次次同一槽
        assert pool.acquire("wenku") is slot
    health = pool.health()["sites"]["wenku"]
    assert health["slots_total"] == 1 and health["slots_available"] == 1
    assert pool.acquire("csdn") is None                    # 未供凭据站 → None（不炸）
    assert pool.acquire("docin") is None                   # 任意未知站键 → None（不炸）


def test_fr8_pool_rotation_round_robin_wrap_and_skip_cooldown(tmp_path):
    """FR8：槽位轮换 round-robin——合成第二账号（tmp ini，**两槽独立 egress**——T41P0/P0-2
    同 egress 多槽受单活跃锁，隔离出口下轮换语义才成立）证回绕；冷却槽被跳过、全冷却 None。"""
    clock = FakeClock()
    pool = _make_pool(tmp_path, {"wenku:primary": {"cookie": "SYNTH_COOKIE_A=1",
                                                   "egress": "egress-a"},
                                 "wenku:secondary": {"cookie": "SYNTH_COOKIE_B=2",
                                                     "egress": "egress-b"}},
                      clock=clock, sites_config={"wenku": {}})
    a = pool.acquire("wenku")
    b = pool.acquire("wenku")
    assert a.name == "wenku#1" and b.name == "wenku#2"     # 同站两节=两槽（:别名契约）
    assert a.cookie == "SYNTH_COOKIE_A=1" and b.cookie == "SYNTH_COOKIE_B=2"
    assert a.egress == "egress-a" and b.egress == "egress-b"  # ini egress 键入槽（非凭据）
    assert "egress" not in a.login_creds                    # egress 不入凭据内存态
    assert a.limiter is not b.limiter                       # 每槽独立 limiter
    assert pool.acquire("wenku") is a                       # 游标回绕
    pool.report("wenku", a, EnvelopeNeedVerify("wenku", "tri_cap"))
    assert pool.acquire("wenku") is b                       # a 冷却 → 轮换跳过
    pool.report("wenku", b, EnvelopeNeedVerify("wenku", "tri_cap"))
    assert pool.acquire("wenku") is None                    # 全冷却 → None（不炸）
    wenku = pool.health()["sites"]["wenku"]
    assert wenku["egress_isolation"] is True and wenku["egress_shared_warning"] == ""


# ---------------------------------------------------------------- R13 熔断退避梯度

def test_fr8_ac1_tri_cap_needverify_backoff_ladder_60_300_1800(tmp_path):
    """R13/FR8.AC1（离线梯度账）：NeedVerify(tri_cap) → 冷却 60→300→1800 升梯、顶格；
    OK 复位=T41P0/P0-3 新契约（衰减-2+短冷却保留，连续 3 次 OK 才真清零）。"""
    clock = FakeClock(start=1000.0)
    pool = _make_pool(tmp_path, {"wenku": {}}, clock=clock, sites_config={"wenku": {}})
    slot = pool.acquire("wenku")
    tri = EnvelopeNeedVerify("wenku", "tri_cap", "need to verify pop-up window!",
                             facts={"tri_reason": "ymg"})
    # 第 1 次：60s
    r1 = pool.report("wenku", slot, tri)
    assert r1["action"] == "cooldown+60s" and r1["state"] == "need_verify"
    assert slot.cooldown_until == pytest.approx(1000.0 + 60.0)
    assert pool.acquire("wenku") is None                    # 冷却中 acquire=None
    # 冷却期满复活，第 2 次：300s
    clock.advance(60.0)
    assert pool.acquire("wenku") is slot
    r2 = pool.report("wenku", slot, tri)
    assert r2["action"] == "cooldown+300s"
    assert slot.cooldown_until == pytest.approx(1060.0 + 300.0)
    # 第 3 次：1800s；第 4 次：顶格仍 1800s
    clock.advance(300.0)
    r3 = pool.report("wenku", slot, tri)
    assert r3["action"] == "cooldown+1800s"
    clock.advance(1800.0)
    r4 = pool.report("wenku", slot, tri)
    assert r4["action"] == "cooldown+1800s"                 # 顶格封顶
    assert slot.verify_streak == 4 and slot.need_verify_count == 4
    # OK 复位（T41P0/P0-3 新契约）：第 1 次 OK=衰减 4-2=2+短冷却 30s（不真清零）
    clock.advance(1800.0)                                   # t=4960
    rok1 = pool.report("wenku", slot, EnvelopeOK("wenku", facts={"show_page": 50}))
    assert rok1["action"] == "record_success+hold30s" and rok1["ok_run"] == 1
    assert slot.verify_streak == 2 and slot.cooldown_until == pytest.approx(4960.0 + 30.0)
    # 第 2 次连续 OK：梯级衰减至 0、仍不清零（再 hold）
    clock.advance(30.0)
    assert pool.acquire("wenku") is slot
    rok2 = pool.report("wenku", slot, EnvelopeOK("wenku"))
    assert rok2["action"] == "record_success+hold30s" and slot.ok_run == 2
    assert slot.verify_streak == 0 and slot.cooldown_until == pytest.approx(4990.0 + 30.0)
    # 第 3 次连续 OK：真清零（全面复位）；再 NeedVerify 重新起梯 60s
    clock.advance(30.0)
    assert pool.acquire("wenku") is slot
    rok3 = pool.report("wenku", slot, EnvelopeOK("wenku"))
    assert rok3["action"] == "record_success+clear" and slot.cooldown_until == 0.0
    assert slot.verify_streak == 0 and slot.ok_run == 3
    r5 = pool.report("wenku", slot, tri)
    assert r5["action"] == "cooldown+60s"                   # 真清零后重新起梯
    # health 报表如实（计数/剩余冷却/真 limiter status）
    wenku_health = pool.health()["sites"]["wenku"]["slots"][0]
    assert wenku_health["need_verify"] == 5 and wenku_health["ok"] == 3
    assert wenku_health["verify_streak"] == 1 and wenku_health["ok_run"] == 0
    assert wenku_health["state"] == "cooldown" and wenku_health["cooldown_remaining_s"] > 0
    assert wenku_health["limiter"]["name"] == "account:wenku#1"
    assert wenku_health["limiter"]["consecutive_errors"] == 1  # tri_cap 计连错闸；OK 复位后重计


def test_fr8_fail_events_drive_real_rate_limiter_circuit_open(tmp_path):
    """FR8：Fail → limiter.record_error——达阈值真符号熔断（circuit_open→acquire 跳过；reset 复活）。"""
    clock = FakeClock()
    pool = _make_pool(tmp_path, {"csdn": {"cookie": "SYNTH_COOKIE_C=1"}},
                      clock=clock, sites_config={"csdn": {"error_threshold": 3}})
    slot = pool.acquire("csdn")
    fail = EnvelopeFail("csdn", "paid_wall", "收费资源")
    for i in range(2):
        pool.report("csdn", slot, fail)
    assert pool.acquire("csdn") is slot                     # 2<3 未熔断
    pool.report("csdn", slot, fail)                          # 第 3 次连续错误
    assert slot.limiter.status()["circuit_open"] is True     # RateLimiter 真符号熔断
    assert pool.acquire("csdn") is None                      # 熔断槽被池跳过
    with pytest.raises(CircuitOpenError):                    # 真符号语义：熔断期 acquire() 抛
        slot.limiter.acquire()
    health = pool.health()["sites"]["csdn"]["slots"][0]
    assert health["state"] == "circuit_open" and health["fail"] == 3
    slot.limiter.reset()                                     # 运维复位 → 槽复活
    assert pool.acquire("csdn") is slot
    pool.report("csdn", slot, EnvelopeOK("csdn"))            # record_success 清连错
    assert slot.limiter.status()["consecutive_errors"] == 0


def test_fr8_report_rejects_foreign_slot_and_unknown_state(tmp_path):
    """FR8：report 防串槽（他站槽/野槽 ValueError）+ 未知三态 ValueError（事件契约硬拒）。"""
    clock = FakeClock()
    pool = _make_pool(tmp_path, {"wenku": {"cookie": "SYNTH_COOKIE_W=1"},
                                 "csdn": {"cookie": "SYNTH_COOKIE_C=1"}}, clock=clock)
    w = pool.acquire("wenku")
    c = pool.acquire("csdn")
    with pytest.raises(ValueError, match="不属于站点"):
        pool.report("csdn", w, EnvelopeOK("csdn"))           # wenku 槽回报到 csdn
    with pytest.raises(ValueError, match="不属于站点"):
        pool.report("wenku", c, EnvelopeOK("wenku"))
    with pytest.raises(ValueError, match="不属于站点"):
        pool.report("wenku", AccountSlot(site="wenku", name="wenku#9",
                                         _cookie=SecretStr(""),
                                         limiter=RateLimiter(name="ghost")),
                   EnvelopeOK("wenku"))                      # 池外野槽
    with pytest.raises(ValueError, match="未知信封三态"):
        pool.report("wenku", w, object())                    # 无 state 属性的野事件


# ---------------------------------------------------------------- 多站点隔离

def test_fr8_multisite_isolation_wenku_csdn_docin_independent(tmp_path):
    """FR8：多站点隔离——wenku/csdn/docin 独立槽/独立 limiter，一站 tri_cap 熔断不外溢。"""
    clock = FakeClock()
    pool = _make_pool(tmp_path, {"wenku": {"cookie": "SYNTH_COOKIE_W=1"},
                                 "csdn": {"cookie": "SYNTH_COOKIE_C=1"},
                                 "docin": {"cookie": "SYNTH_COOKIE_D=1"}},
                      clock=clock, sites_config={"wenku": {"min_interval": 6.0}})
    w = pool.acquire("wenku")
    c = pool.acquire("csdn")
    d = pool.acquire("docin")                                # 未配站键 → 通用缺省（任意站键通用）
    assert {w.name, c.name, d.name} == {"wenku#1", "csdn#1", "docin#1"}
    assert w.limiter is not c.limiter is not d.limiter
    assert w.limiter.name != c.limiter.name != d.limiter.name
    assert w.limiter.min_interval == 6.0                     # sites_config 站级覆写生效
    assert d.limiter.min_interval == 3.0                     # 未配站走通用缺省
    pool.report("wenku", w, EnvelopeNeedVerify("wenku", "tri_cap"))
    assert pool.acquire("wenku") is None                     # wenku 冷却
    assert pool.acquire("csdn") is c                         # csdn 不受外溢
    assert pool.acquire("docin") is d                        # docin 不受外溢
    sites = pool.health()["sites"]
    assert sites["wenku"]["slots_available"] == 0
    assert sites["csdn"]["slots_available"] == 1 and sites["docin"]["slots_available"] == 1


# ---------------------------------------------------------------- 凭据纪律（公约 §7）

def test_fr8_credentials_only_secret_ini_scanned_and_health_masks_values(tmp_path):
    """FR8/公约 §7：只扫 *.secret.ini（诱饵文件不进池）；health()/repr 零凭据值回显。"""
    clock = FakeClock()
    _write_secret_ini(tmp_path, "wenku.secret.ini",
                      {"wenku": {"cookie": "SYNTH_REAL_COOKIE_9f3a=zz", "password": "SYNTH_PW_7c"}})
    _write_secret_ini(tmp_path, "wenku.ini",                # 非 .secret.ini 诱饵：不得入池
                      {"wenku": {"cookie": "SYNTH_DECOY_COOKIE=1"}})
    (tmp_path / "broken.secret.ini").write_text(
        "[wenku\ncookie = SYNTH_BROKEN\n", encoding="utf-8")  # 坏 ini：记台账不炸
    pool = AccountPool({"wenku": {}}, credentials_dir=tmp_path,
                       clock=clock, sleep=_no_sleep)
    assert pool._files_scanned == ["broken.secret.ini", "wenku.secret.ini"]  # 排序稳定（仅 secret.ini）
    assert len(pool._load_errors) == 1 and "broken.secret.ini" in pool._load_errors[0]
    slot = pool.acquire("wenku")
    assert slot is not None and slot.cookie == "SYNTH_REAL_COOKIE_9f3a=zz"  # 值只进内存槽
    assert slot.login_creds == {"password": "SYNTH_PW_7c"}   # 其余键原样内存态（不落日志）
    snapshot = json.dumps(pool.health(), ensure_ascii=False)
    for marker in ("SYNTH_REAL_COOKIE_9f3a", "SYNTH_PW_7c", "SYNTH_DECOY_COOKIE", "SYNTH_BROKEN"):
        assert marker not in snapshot, f"health() 泄漏凭据值: {marker}"
    assert "SYNTH_REAL_COOKIE_9f3a" not in repr(slot) and "SYNTH_REAL_COOKIE_9f3a" not in str(slot)
    assert '"has_cookie": true' in snapshot                  # 只报布尔事实
    # T41P0/P0-1（g）②：敏感键降敏 SecretStr（等值比较消费兼容+repr 掩蔽）
    assert isinstance(slot.login_creds["password"], SecretStr)
    assert slot.login_creds["password"] == "SYNTH_PW_7c"     # 等值比较（登录腿兼容面）
    assert slot.login_creds["password"].get_secret_value() == "SYNTH_PW_7c"
    assert "SYNTH_PW_7c" not in repr(slot.login_creds)       # dict repr 面掩蔽
    assert "SYNTH_REAL_COOKIE_9f3a" not in repr(vars(slot))  # vars 面：cookie 字段=SecretStr
    assert isinstance(vars(slot)["_cookie"], SecretStr)


def test_fr8_default_credentials_dir_contract_and_bad_backoff_rejected():
    """FR8：缺省凭据目录=仓库 ``07 任务/自动建库Agent/_credentials``（只读路径契约）；坏梯度硬拒。"""
    assert CREDENTIALS_DIR_DEFAULT.name == "_credentials"
    assert CREDENTIALS_DIR_DEFAULT.parent.name == "自动建库Agent"
    assert CREDENTIALS_DIR_DEFAULT.is_dir()                  # 主树在位（worktree 缺目录=load_error 不炸）
    with pytest.raises(ValueError, match="backoff_s"):
        AccountPool(credentials_dir="Z:/nonexistent", backoff_s=())
    with pytest.raises(ValueError, match="backoff_s"):
        AccountPool(credentials_dir="Z:/nonexistent", backoff_s=(60.0, -1.0))


def test_fr8_missing_credentials_dir_records_load_error_no_crash(tmp_path):
    """FR8：凭据目录缺位 → load_error 台账 + 全站 None（不炸；worktree/CI 场景）。"""
    pool = AccountPool({"wenku": {}}, credentials_dir=tmp_path / "absent",
                       clock=FakeClock(), sleep=_no_sleep)
    assert pool.acquire("wenku") is None
    health = pool.health()
    assert health["sites"]["wenku"]["slots_total"] == 0
    assert any("凭据目录不存在" in e for e in health["load_errors"])


# ---------------------------------------------------------------- T41P0：PentAGI P0 三项清偿
# 研判原文=engine/PENTAGI/account_pool_assessment.md；P0-1（g）凭据面 / P0-2（c）同 IP
# 连坐 / P0-3（a）单 OK 全复位穿透。三条均「多账号设计面前瞻 P0」（研判工人注⑤）——
# 本节为接入前清偿：fail-closed 护栏落地+纪律测试固化。

def test_p0_1_secret_ini_mode_gate_posix(tmp_path, monkeypatch):
    """P0-1（g）①：POSIX 权限门——group/other 任一位可读写（0644/0640）拒载记
    load_errors（整文件不解析）；0600 放行。os_name/stat_fn 注入点确定性模拟；
    Windows 原生无 POSIX mode 位（研判工人注①：ACL 面归部署侧）——真 chmod 腿仅 POSIX 跑。"""
    ini = _write_secret_ini(tmp_path, "wenku.secret.ini",
                            {"wenku": {"cookie": "SYNTH_COOKIE_M=1"}})

    def _stat(mode: int):
        return lambda p: os.stat_result((mode, 0, 0, 1, 0, 0, 99, 0, 0, 0))

    assert pool_mod._secret_file_mode_error(
        ini, os_name="posix", stat_fn=_stat(0o100644)) is not None   # 0644：group/other 可读
    assert pool_mod._secret_file_mode_error(
        ini, os_name="posix", stat_fn=_stat(0o100640)) is not None   # 0640：group 可读
    assert pool_mod._secret_file_mode_error(
        ini, os_name="posix", stat_fn=_stat(0o100600)) is None       # 0600：合格
    assert pool_mod._secret_file_mode_error(ini, os_name="nt") is None  # Windows：不拦（如实）
    # 接线：装载腿对全文件生效（注入桩替身模拟权限过宽 → 拒载+零槽+台账）
    monkeypatch.setattr(pool_mod, "_secret_file_mode_error",
                        lambda p, **kw: f"{p.name}: 权限过宽 0o644（测试注入）")
    pool = AccountPool({"wenku": {}}, credentials_dir=tmp_path,
                       clock=FakeClock(), sleep=_no_sleep)
    assert pool.acquire("wenku") is None                    # 整文件拒载：零槽
    assert any("权限过宽" in e for e in pool.health()["load_errors"])


@pytest.mark.skipif(os.name != "posix", reason="POSIX 实测腿（chmod 600/644；Windows 跳过明示）")
def test_p0_1_secret_ini_mode_gate_real_chmod_posix(tmp_path):
    """P0-1（g）① 实测腿（仅 POSIX）：真 chmod 0644 拒载 / 0600 放行。"""
    ini = _write_secret_ini(tmp_path, "wenku.secret.ini", {"wenku": {"cookie": "SYNTH_C=1"}})
    ini.chmod(0o644)
    pool = AccountPool({"wenku": {}}, credentials_dir=tmp_path,
                       clock=FakeClock(), sleep=_no_sleep)
    assert pool.acquire("wenku") is None and any("权限过宽" in e for e in pool._load_errors)
    ini.chmod(0o600)
    pool2 = AccountPool({"wenku": {}}, credentials_dir=tmp_path,
                        clock=FakeClock(), sleep=_no_sleep)
    assert pool2.acquire("wenku") is not None and pool2._load_errors == []


def test_p0_1_secretstr_masking_vars_asdict_repr_leak_free(tmp_path):
    """P0-1（g）②③纪律测试：vars()/asdict()/repr()/health() 全面零凭据回显（研判修法
    ③原文口径）；敏感键清单锚；cookie 消费接口保持 str 契约。"""
    import copy
    import dataclasses
    pool = _make_pool(tmp_path, {"wenku": {"cookie": "SYNTH_COOKIE_Z=9",
                                           "username": "SYNTH_USER",
                                           "password": "SYNTH_PW_Z",
                                           "bduss": "SYNTH_BD_Z",
                                           "note": "plain-note"}},
                      clock=FakeClock(), sites_config={"wenku": {}})
    slot = pool.acquire("wenku")
    assert slot.cookie == "SYNTH_COOKIE_Z=9"                 # 消费接口 str（属性=短暂解出点）
    assert isinstance(slot._cookie, SecretStr) and str(slot._cookie) == "***"
    assert slot.login_creds["password"] == "SYNTH_PW_Z"      # 等值比较兼容
    assert slot.login_creds["username"] == "SYNTH_USER"      # 非敏感键原样明文
    assert slot.login_creds["note"] == "plain-note"
    assert SENSITIVE_LOGIN_KEYS == frozenset(
        {"password", "passwd", "pwd", "secret", "token", "bduss"})   # 研判清单锚
    blob = (repr(slot) + repr(vars(slot)) + repr(dataclasses.asdict(slot))
            + json.dumps(pool.health(), ensure_ascii=False) + repr(copy.deepcopy(slot)))
    for marker in ("SYNTH_COOKIE_Z=9", "SYNTH_PW_Z", "SYNTH_BD_Z"):
        assert marker not in blob, f"凭据值泄漏面: {marker}"
    assert "SYNTH_USER" in repr(vars(slot))                  # 非敏感键如实可见（只降敏敏感键）


def test_p0_2_same_egress_single_active_slot_lock(tmp_path):
    """P0-2（c）：同 egress（同出口 IP）最多 1 活跃槽——他槽在途时不出借（同槽续用不
    受限）；report 清账后轮换放行；独立 egress 两槽可同时在途；health 显式标记
    「同 IP 隔离不成立」。"""
    clock = FakeClock()
    shared = _make_pool(tmp_path, {"wenku:a": {"cookie": "SYNTH_CA=1"},
                                   "wenku:b": {"cookie": "SYNTH_CB=2"}},
                        clock=clock, sites_config={"wenku": {}})
    a = shared.acquire("wenku")
    assert a.name == "wenku#1" and a.egress == ""            # 未配 egress=共享默认出口
    again = shared.acquire("wenku")
    assert again is a                                        # 同 egress 他槽(b)在途锁 → b 不出借，a 续用
    shared.report("wenku", a, EnvelopeOK("wenku"))           # 清账
    b = shared.acquire("wenku")
    assert b is not None and b.name == "wenku#2"             # 账清后轮换放行
    shared.report("wenku", b, EnvelopeOK("wenku"))
    wenku = shared.health()["sites"]["wenku"]
    assert wenku["egress_isolation"] is False                # 多槽共享出口：隔离不成立
    assert "同 IP 隔离不成立" in wenku["egress_shared_warning"]
    assert wenku["outstanding"] == 0
    # 独立 egress（每槽独立出口）：单活跃锁自然解除——两槽可同时在途
    isolated = _make_pool(tmp_path / "iso", {"wenku:a": {"cookie": "SYNTH_CA=1",
                                                         "egress": "egress-a"},
                                             "wenku:b": {"cookie": "SYNTH_CB=2",
                                                         "egress": "egress-b"}},
                          clock=clock, sites_config={"wenku": {}})
    ia = isolated.acquire("wenku")
    ib = isolated.acquire("wenku")
    assert ia.name == "wenku#1" and ib.name == "wenku#2"     # 两槽同时在途（隔离成立）
    iso_health = isolated.health()["sites"]["wenku"]
    assert iso_health["egress_isolation"] is True and iso_health["outstanding"] == 2
    assert iso_health["egress_shared_warning"] == ""
    # 单槽站（现网形态）：天然隔离，无告警
    single = _make_pool(tmp_path / "one", {"wenku": {"cookie": "SYNTH_C1=1"}},
                        clock=clock, sites_config={"wenku": {}})
    assert single.health()["sites"]["wenku"]["egress_isolation"] is True


def test_p0_3_single_ok_no_longer_resets_ladder_intermittent_softban():
    """P0-3（a）主断言：持续软封+间歇放行（研判 ① a 推演场景）——单次 OK 后下一次
    NeedVerify 走**升级档**（原实现清零穿透回 60s 首档）；连续 OK_CLEAR_RUN 次才真清零。"""
    clock = FakeClock(start=100.0)
    pool = AccountPool({"wenku": {"min_interval": 3.0}}, credentials_dir=Path(
        "Z:/nonexistent-dir-t41p0"), clock=clock, sleep=_no_sleep)
    assert OK_DECAY_K == 2 and OK_CLEAR_RUN == 3 and OK_HOLD_S == 30.0   # 参数锚
    slot = AccountSlot(site="wenku", name="wenku#1", _cookie=SecretStr(""),
                       limiter=RateLimiter(name="t41p0", clock=clock, sleep=_no_sleep))
    pool._slots["wenku"].append(slot)
    tri = EnvelopeNeedVerify("wenku", "tri_cap")
    # 三连 tri_cap：60→300→1800（升梯）；每档期满复活再打（间歇放行=OK 穿插）
    for cooldown in (60.0, 300.0, 1800.0):
        assert pool.acquire("wenku") is slot
        r = pool.report("wenku", slot, tri)
        assert r["action"] == f"cooldown+{cooldown:g}s"
        clock.advance(cooldown)                              # 软封间歇放行窗口
    assert slot.verify_streak == 3
    # 间歇放行：一次 OK ——衰减 3-2=1、短冷却 30s，**梯级不清零**
    rok = pool.report("wenku", slot, EnvelopeOK("wenku"))
    assert rok["action"] == "record_success+hold30s" and slot.verify_streak == 1
    clock.advance(OK_HOLD_S)
    # 再触发 tri_cap：原实现此处回 60s 首档（穿透）；新契约走升级档 300s
    assert pool.acquire("wenku") is slot
    r2 = pool.report("wenku", slot, tri)
    assert r2["action"] == "cooldown+300s" and slot.verify_streak == 2   # 升级梯持续生效
    # 恢复路径：冷却期满后连续 3 次 OK（每间隔 OK_HOLD_S 可再借）→ 真清零
    clock.advance(300.0)
    for i in range(OK_CLEAR_RUN):
        assert pool.acquire("wenku") is slot                 # OK 后短冷却期满即可再借
        pool.report("wenku", slot, EnvelopeOK("wenku"))
        clock.advance(OK_HOLD_S)
    assert slot.verify_streak == 0 and slot.cooldown_until == 0.0 and slot.ok_run == OK_CLEAR_RUN
    r3 = pool.report("wenku", slot, tri)                     # 真清零后重新起梯首档
    assert r3["action"] == "cooldown+60s"


# ---------------------------------------------------------------- 实弹（真实网络，FR8.AC1）

@pytest.fixture(scope="module")
def chromium():
    """module 级唯一浏览器（公约：禁止测试并行开多浏览器）；直连口径同 test_page_signer。"""
    from playwright.sync_api import sync_playwright
    with sync_playwright() as pw:
        args = [] if os.environ.get("KB_HARVEST_KEEP_PROXY") == "1" else ["--no-proxy-server"]
        browser = pw.chromium.launch(headless=True, args=args)
        yield browser
        browser.close()


#: 匿名**不带签名** fetch（WENKU_SPEC §6.3 探针同型：无 Acs-Token 头、无 Referer 手工头；
#: 浏览器自然 Referer=就绪页 URL，同源 cookie 自动携带——与 §3.2 带签腿唯一差异=无签名头）
_NO_SIGN_FETCH_JS = """async (urlJson) => {
  try {
    const r = await fetch(JSON.parse(urlJson));
    const body = await r.text();
    let payload = null;
    if (r.ok) { try { payload = JSON.parse(body); } catch (e) { payload = null; } }
    return { ok: r.ok, status: r.status, payload: payload, bodyHead: body.slice(0, 400) };
  } catch (err) {
    return { ok: false, status: null, payload: null, bodyHead: "", err: String(err) };
  }
}"""


def _discover_doc_id(kit, signer):
    """live doc_id 发现腿（test_page_signer 同型紧凑版）：stdlib syncmrecall → in-page
    syncmrecall（无闸门 generic 页）→ 就绪页 HTML 正则兜底；sellType∈{2,5}=VIP 优先免费件。"""
    from kb_factory.harvest_engine.signer.page_signer import WENKU_INIT_URL
    _syncmrecall_js = """async (bodyJson) => {
      try {
        const r = await fetch("/gsula/sula/syncmrecall", {
          method: "POST", headers: {"Content-Type": "application/json;charset=utf-8"},
          body: JSON.parse(bodyJson)});
        const j = await r.json();
        const items = ((((j || {}).data || {}).items || {}).PCSearch || {}).result || {};
        const out = [];
        for (const it of (items.items || [])) {
          const d = it.data || {};
          if (d.docID) out.push([String(d.docID), d.sellType]);
        }
        return out.slice(0, 20);
      } catch (e) { return []; }
    }"""
    try:
        from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter
        metas = WenkuMetaAdapter().metadata("施工方案", limit=12)
        with_id = [m for m in metas if m.extra.get("doc_id")]
        free = [m for m in with_id if m.perm == "green"]
        if with_id:
            return (free or with_id)[0].extra["doc_id"], "syncmrecall(stdlib)"
    except Exception:
        pass
    try:
        page = kit.generic_context().new_page()
        try:
            page.goto(WENKU_INIT_URL, timeout=45_000)
            body = {"requests": [{"sceneID": "PCSearch", "params": {
                "word": "施工方案", "pn": 1, "noCacheMembershipCard": True}}]}
            rows = page.evaluate(_syncmrecall_js, json.dumps(body, ensure_ascii=False))
            non_vip = [r for r in rows if r[1] not in (2, 5)]
            if non_vip or rows:
                return (non_vip or rows)[0][0], "syncmrecall(in-page)"
        finally:
            page.context.close()
    except Exception:
        pass
    m = re.search(r"view/([0-9A-Za-z_-]{6,})\.html", signer.page.content())
    if m:
        return m.group(1), "首页 HTML 正则兜底"
    raise AssertionError("doc_id 发现腿全败（stdlib/in-page/正则三腿）")


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason="KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（公约第 4 条，CI 场景明示）")
@pytest.mark.skipif(not _WENKU_SECRET_INI.is_file(),
                    reason=f"wenku.secret.ini 未就位（{_WENKU_SECRET_INI}；凭据缺位，FR8.AC1 实弹挂账）")
def test_live_fr8_ac1_wenku_anonymous_tri_cap_circuit_backoff_gradient(chromium):
    """FR8.AC1 实弹（R13）：匿名不带签名打 ndocview/readerinfo → tri_cap 信封 →
    AccountPool 收到 NeedVerify(tri_cap) 即槽冷却，三连退避梯度 60s→300s→1800s 实测。

    链路全真：真凭据 ini（wenku.secret.ini，pyeyeye 现无 cookie 键→匿名槽）→ PageSigner
    匿名签名窗（§4.1 就绪轮询）→ 匿名**无 Acs-Token** in-page fetch readerinfo（§6.3 探针
    同型：匿名即 tri_cap 信封）→ judge_wenku 三态判定 → pool.report 三连（每次真请求，
    节流走槽上真 RateLimiter.acquire()）→ 每连冷却剩余≈梯度档位 + acquire None + health
    如实（need_verify 计数/verify_streak/连错闸）。数字零造假：剩余秒数实测断言（±5s 容差）。
    """
    from kb_factory.harvest_engine.browser.kit import BrowserKit
    from kb_factory.harvest_engine.signer.page_signer import (
        PageSigner, build_readerinfo_url, judge_readerinfo)
    from kb_factory.harvest_engine.signer.page_signer import SignedFetch

    pool = AccountPool({"wenku": {}}, credentials_dir=CREDENTIALS_DIR_DEFAULT)
    slot = pool.acquire("wenku")
    assert slot is not None, "wenku.secret.ini 在位但池无槽（装载腿异常）"
    assert isinstance(slot.limiter, RateLimiter)             # 真符号挂槽
    kit = BrowserKit(chromium, rng=random.Random(20261022))  # 种子固定=UA 确定性
    signer = PageSigner(kit, slot.cookie)                    # 匿名（真 ini 无 cookie 键=匿名槽）
    try:
        assert signer.ready                                  # ① 匿名签名窗就绪（§4.1 轮询）
        doc_id, doc_src = _discover_doc_id(kit, signer)
        remaining_expected = [60.0, 300.0, 1800.0]           # R13 退避梯度（BACKOFF_LADDER_S 前三档）
        tri_reasons = []
        for round_no, expect_s in enumerate(remaining_expected, start=1):
            url = build_readerinfo_url(doc_id, pn=1, rn=50)  # 每轮新鲜 t（防缓存）
            slot.limiter.acquire()                           # ② 真符号节流（min_interval 起步）
            got = signer.page.evaluate(_NO_SIGN_FETCH_JS, json.dumps(url))
            fetch = SignedFetch(url=url, token="", ok=bool(got.get("ok")),
                                status=got.get("status"), payload=got.get("payload"),
                                body_head=str(got.get("bodyHead") or ""),
                                detail="anonymous no-sign fetch（§6.3 探针同型）")
            verdict = judge_readerinfo(fetch)
            # ③ §6.3 实证：匿名无 Acs-Token → tri_cap 信封（不判死，熔断归池）
            assert isinstance(verdict, EnvelopeNeedVerify) and verdict.kind == "tri_cap", (
                f"第{round_no}轮匿名不带签名未触发 tri_cap: state={verdict.state} "
                f"http={fetch.status} bodyHead={fetch.body_head[:120]!r}")
            tri_reasons.append(verdict.facts.get("tri_reason"))
            # ④ AccountPool 收到 NeedVerify(tri_cap) → 槽冷却
            receipt = pool.report("wenku", slot, verdict)
            cooldown_left = slot.cooldown_until - time.monotonic()
            assert expect_s - 5.0 <= cooldown_left <= expect_s + 5.0, (
                f"第{round_no}档退避实测 {cooldown_left:.1f}s ≠ 梯度 {expect_s}s")
            assert pool.acquire("wenku") is None, "冷却中 acquire 应 None（R13 熔断退避）"
            assert receipt["action"] == f"cooldown+{expect_s:g}s"
            print(f"\n[live] 第{round_no}轮 doc_id={doc_id}({doc_src}) http={fetch.status} "
                  f"tri_reason={verdict.facts.get('tri_reason')!r} → 槽冷却 +{expect_s:g}s"
                  f"（剩余 {cooldown_left:.1f}s）")
        # ⑤ 收口前总账：三连 NeedVerify 计数/梯级/连错闸/健康态（零造假实测值）
        wenku = pool.health()["sites"]["wenku"]
        assert wenku["slots_available"] == 0
        slot_health = wenku["slots"][0]
        assert slot_health["need_verify"] == 3 and slot_health["verify_streak"] == 3
        assert slot_health["state"] == "cooldown" and slot_health["last_kind"] == "tri_cap"
        assert slot_health["limiter"]["consecutive_errors"] == 3   # tri_cap 计入连错闸（第二道）
        assert slot_health["limiter"]["count_today"] == 3          # 三次真节流实发
        snapshot = json.dumps(pool.health(), ensure_ascii=False)
        if slot.cookie:  # 若真账号带 cookie：其值不得进报表（空串恒为子串，匿名槽跳过）
            assert slot.cookie not in snapshot
        assert "password" not in snapshot.lower() and "username" not in snapshot.lower()
        assert signer.close() is True
        kit.close_all()
        assert chromium.contexts == [], "live 收口后浏览器仍有未关上下文"
        print(f"[live] FR8.AC1 实弹收官：三连 tri_cap → 60→300→1800 退避全实测；"
              f"tri_reason 序列={tri_reasons}；rate/冷却账={slot_health['limiter']['name']}")
    finally:
        signer.close()
        kit.close_all()
