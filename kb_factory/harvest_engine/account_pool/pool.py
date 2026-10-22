# -*- coding: utf-8 -*-
"""cookie 账号池 account_pool/pool.py（T29；FR8/R13；ARCHITECTURE 第 24 行槽位）。

职责（FR8.1，MUST）：当适配器请求登录态时，从池取凭据——轮换/健康/熔断三合一，
频控复用 ``channel_adapters.base.RateLimiter`` 真符号（不另造频控器）；凭据只读
``07 任务/自动建库Agent/_credentials/*.secret.ini``（configparser 标准库解析，
非 ``*.secret.ini`` 一律不扫——凭据文件形态即准入闸）。

信封三态事件驱动（envelope.py 统一三态，SYNTHESIS §2-10）：
- ``report(site, slot, EnvelopeOK)``         → limiter.record_success（复位连错/冷却）；
- ``report(site, slot, EnvelopeFail)``       → limiter.record_error（连续错误熔断由
  RateLimiter 真符号承担：达 error_threshold 即 circuit_open，槽被 acquire 跳过）；
- ``report(site, slot, EnvelopeNeedVerify)`` → **tri_cap 即熔断冷却**（R13，FR8.AC1）：
  槽位 ``cooldown_until`` 按退避梯度推进 ``60s→300s→1800s``（自事件时刻起算本档时长；
  连续 NeedVerify 升梯、顶格封顶、OK 复位后重新起梯），同时计入 limiter 连续错误
  （第二道闸）。

多站点隔离（FR8）：站点键=任意字符串（wenku/csdn/doc88/docin…通用），每站独立槽列表、
独立轮换游标、独立 RateLimiter 实例——一站熔断不外溢他站。

凭据 ini 契约：一节=一账号；节名=``{site}`` 或 ``{site}:{别名}``（第二账号同站多节即入池）；
``cookie`` 键=原始 cookie 串（空/缺=匿名槽，如实留空——wenku 现供账号 pyeyeye 只有
用户名/密码无 BDUSS，登录腿归下游任务）；``egress`` 键=槽出口标签（T41P0/P0-2，非凭据）；
其余键进内存 ``login_creds``（敏感键降敏 SecretStr，非敏感键原样；不落任何日志/报表——
零造假口径：health() 只报 has_cookie 布尔与计数，不回显任何凭据值）。

确定性纪律：clock/sleep 可注入（冷却判定与退避梯度的确定性注入点；与 RateLimiter 同款
注入参数，池与各槽 limiter 共用同一 clock）。线程口径同 RateLimiter：进程级单线程顺序
调用即可，不加锁。

T41P0 落地件（2026-10-23，PentAGI 研判 P0 三项清偿·FR10.1 发布硬门；研判原文=
engine/PENTAGI/account_pool_assessment.md）：
- P0-1（g 凭据安全面）：①ini 文件 POSIX 权限门（group/other 任一位可读写即拒载记
  load_errors；Windows 原生无 POSIX mode 位=部署侧 ACL 面，如实放行不拦——研判工人
  注①口径）；②``login_creds`` 敏感键（password/passwd/pwd/secret/token/bduss）降敏
  ``SecretStr``（repr/str 恒 ``***``，真值仅 ``get_secret_value()`` 解出）；③cookie
  字段本体降敏（``_cookie: SecretStr``，``cookie`` 属性=消费接口短暂解出点，保持 str
  契约）——vars()/asdict()/repr()/health() 全面零回显；
- P0-2（c 同 IP 连坐）：``egress`` 出口抽象（ini ``egress`` 键=每槽出口标签，代理/源
  IP 绑定面）+ 同 egress 最多 1 活跃槽锁（acquire 在途记账、report 清账；同槽重复取出
  =同账号续用不受限）+ health 显式标记「同 IP 隔离不成立」（多槽共享出口时）；
- P0-3（a 单 OK 全复位穿透）：OK 改「衰减-``OK_DECAY_K`` + 连续 ``OK_CLEAR_RUN``
  次才真清零」+ 未清零 OK 保留 ``OK_HOLD_S`` 短冷却——持续软封+间歇放行下升级梯
  （300s/1800s）不再被单次放行清零穿透（研判 ① a 推演场景根除）。
"""
from __future__ import annotations

import configparser
import os
import stat as stat_mod
import time
from collections.abc import Callable, Mapping, Sequence
from dataclasses import dataclass, field
from pathlib import Path

try:  # 合并后正名 kb_factory.*；worktree 阶段回退顶层名（同 envelope.py/tests 双导入法）
    from kb_factory.channel_adapters.base import RateLimiter
    from kb_factory.harvest_engine.envelope import (
        STATE_FAIL, STATE_NEED_VERIFY, STATE_OK)
except ImportError:
    from channel_adapters.base import RateLimiter  # type: ignore
    from harvest_engine.envelope import (  # type: ignore
        STATE_FAIL, STATE_NEED_VERIFY, STATE_OK)

__all__ = [
    "BACKOFF_LADDER_S", "DEFAULT_SITES", "CREDENTIALS_DIR_DEFAULT",
    "OK_DECAY_K", "OK_CLEAR_RUN", "OK_HOLD_S",
    "SENSITIVE_LOGIN_KEYS", "SecretStr",
    "AccountSlot", "AccountPool",
]

#: tri_cap 熔断退避梯度（R13：60s→300s→1800s，连续 NeedVerify 逐级升梯、顶格封顶）
BACKOFF_LADDER_S: tuple[float, ...] = (60.0, 300.0, 1800.0)

#: T41P0（P0-3/a）：单次 OK 的梯级衰减步长（研判修法口径 K≥2 取 2）
OK_DECAY_K = 2
#: T41P0（P0-3/a）：连续 N 次 OK 才真清零（verify_streak/cooldown 全复位；研判 ② N=3）
OK_CLEAR_RUN = 3
#: T41P0（P0-3/a）：未达真清零的 OK 保留短冷却（研判「保留短冷却」；< 首档 60s）
OK_HOLD_S = 30.0

#: T41P0（P0-1/g ②）：login_creds 中须降敏 SecretStr 的敏感键（小写匹配；研判清单）
SENSITIVE_LOGIN_KEYS = frozenset({"password", "passwd", "pwd", "secret", "token", "bduss"})

#: 凭据目录缺省（只读；REPO_ROOT = 本文件向上第 3 级 = kb_factory 的上级）
CREDENTIALS_DIR_DEFAULT = (Path(__file__).resolve().parents[3]
                           / "07 任务" / "自动建库Agent" / "_credentials")

#: 已知站点 limiter 缺省（wenku 对齐 wenku_meta 缺省 3s/500；未知站点走 _GENERIC）
_GENERIC_SITE_CFG: dict[str, float] = {
    "min_interval": 3.0, "daily_limit": 300, "error_threshold": 5}
DEFAULT_SITES: dict[str, dict[str, float]] = {
    "wenku": {"min_interval": 3.0, "daily_limit": 500, "error_threshold": 5},
    "csdn": {"min_interval": 3.0, "daily_limit": 300, "error_threshold": 5},
    "doc88": {"min_interval": 3.0, "daily_limit": 300, "error_threshold": 5},
    "book118": {"min_interval": 3.0, "daily_limit": 300, "error_threshold": 5},
}


# ---------------------------------------------------------------- 凭据降敏容器（T41P0/P0-1）

class SecretStr:
    """敏感值降敏容器（T41P0/P0-1（g）②）——repr/str 恒 ``***``，真值仅
    ``get_secret_value()`` 解出（登录腿发起时的「短暂解出」点）；与明文 str 等值
    比较/同 hash（消费侧与既有断言兼容）；深拷贝保持降敏（``dataclasses.asdict``
    面不泄漏）。cookie 的短暂解出点=``AccountSlot.cookie`` 属性。
    """

    __slots__ = ("_value",)

    def __init__(self, value):
        self._value = "" if value is None else str(value)

    def get_secret_value(self) -> str:
        return self._value

    def __repr__(self) -> str:
        return "SecretStr('***')"

    def __str__(self) -> str:
        return "***"

    def __bool__(self) -> bool:
        return bool(self._value)

    def __eq__(self, other):
        if isinstance(other, SecretStr):
            return self._value == other._value
        if isinstance(other, str):
            return self._value == other
        return NotImplemented

    def __hash__(self) -> int:
        return hash(self._value)

    def __copy__(self):
        return SecretStr(self._value)

    def __deepcopy__(self, memo):
        return SecretStr(self._value)


def _secret_file_mode_error(path: Path, *, os_name: str | None = None,
                            stat_fn=os.stat) -> str | None:
    """T41P0（P0-1（g）①）凭据文件权限门：POSIX 下 group/other 任一位可读写即判错
    （600/400 口径）；Windows 原生无 POSIX mode 位（研判工人注①：本机部署=ACL 面归
    部署侧管控）——如实放行不拦。os_name/stat_fn 注入点供确定性测试。
    """
    os_name = os.name if os_name is None else os_name
    if os_name != "posix":
        return None
    try:
        mode = stat_mod.S_IMODE(stat_fn(path).st_mode)
    except OSError as exc:
        return f"{path.name}: 权限检查失败 {type(exc).__name__}"
    if mode & 0o077:
        return f"{path.name}: 权限过宽 {oct(mode)}（须 600/400：group/other 零权限）"
    return None


# ---------------------------------------------------------------- 槽位

@dataclass
class AccountSlot:
    """一个站点账号槽：取出的凭据句柄 + 健康态（冷却游标/计数，零造假全实测）。

    ``name`` 为槽位序名（``wenku#1``）——真账号名/cookie 值永不落 name/报表；
    ``_cookie``=降敏 SecretStr（T41P0/P0-1），``cookie`` 属性=原始串消费接口（保持
    str 契约，空=匿名槽，登录腿归下游）；``limiter``=channel_adapters.base 真符号
    （复用频控+日上限熔断+连续错误熔断，不另造）；``cooldown_until``=monotonic 时钟
    刻度，<=now 即可出池；``egress``=出口标签（T41P0/P0-2，ini ``egress`` 键；空=
    共享默认出口——同 egress 多槽受「最多 1 活跃槽」锁）；``ok_run``=连续 OK 计数
    （T41P0/P0-3，达 ``OK_CLEAR_RUN`` 才真清零）。
    """

    site: str
    name: str                                   # 槽位序名（wenku#1；非凭据值）
    _cookie: SecretStr                          # 原始 cookie 串（降敏容器；空=匿名/待登录）
    limiter: RateLimiter                        # 真符号（每槽独立实例）
    egress: str = ""                            # T41P0/P0-2：出口标签（代理/源 IP 绑定面）
    cooldown_until: float = 0.0                 # monotonic；0=无冷却
    verify_streak: int = 0                      # 连续 NeedVerify 计数（退避梯级）
    ok_run: int = 0                             # 连续 OK 计数（T41P0/P0-3：达标才真清零）
    ok_count: int = 0
    fail_count: int = 0
    need_verify_count: int = 0
    last_kind: str = ""                         # 最近事件 kind（如 tri_cap；非凭据）
    source: str = ""                            # 凭据文件名（文件名非凭据值）
    login_creds: dict = field(default_factory=dict)  # ini 其余键内存态（敏感键=SecretStr）

    @property
    def cookie(self) -> str:
        """原始 cookie 串（消费接口保持 str——适配器直接挂请求头；空=匿名槽）。
        T41P0/P0-1（g）②：字段本体降敏（vars/asdict/repr 零回显），本属性即短暂解出点。"""
        return self._cookie.get_secret_value()

    def __repr__(self) -> str:  # 凭据纪律：cookie/login_creds 永不进 repr（含异常栈）
        return (f"AccountSlot(site={self.site!r}, name={self.name!r}, "
                f"has_cookie={bool(self._cookie)!r}, limiter={self.limiter.name!r}, "
                f"cooldown_until={self.cooldown_until!r}, verify_streak={self.verify_streak!r})")

    __str__ = __repr__

    @property
    def cooling(self) -> bool:
        """是否处于冷却（供调用方快速判；池内判定以注入 clock 为准）。"""
        return self.cooldown_until > time.monotonic()


# ---------------------------------------------------------------- 账号池

class AccountPool:
    """cookie 账号池（FR8）：acquire 轮换取槽 / report 三态事件驱动 / health 报表。

    用法：``pool = AccountPool({"wenku": {"min_interval": 3.0}})`` →
    ``slot = pool.acquire("wenku")``（None=全冷却/无槽，调用方降级不炸）→
    适配器带 ``slot.cookie`` 发请求并走 ``slot.limiter.acquire()`` 节流 →
    信封判定后 ``pool.report("wenku", slot, verdict)`` 回报三态。
    """

    def __init__(self, sites_config: Mapping[str, Mapping[str, float]] | None = None,
                 *, credentials_dir: str | Path | None = None,
                 backoff_s: Sequence[float] = BACKOFF_LADDER_S,
                 clock: Callable[[], float] | None = None,
                 sleep: Callable[[float], None] | None = None):
        self._clock: Callable[[], float] = clock or time.monotonic
        self._sleep: Callable[[float], None] = sleep or time.sleep
        self._backoff = tuple(float(s) for s in backoff_s)
        if not self._backoff or any(s <= 0 for s in self._backoff):
            raise ValueError("backoff_s 须为非空正数梯度（如 60→300→1800）")
        self._sites_cfg: dict[str, dict[str, float]] = dict(DEFAULT_SITES)
        for site, cfg in (sites_config or {}).items():
            self._sites_cfg[site] = {**self._site_defaults(site), **dict(cfg or {})}
        self._credentials_dir = Path(credentials_dir) if credentials_dir else CREDENTIALS_DIR_DEFAULT
        self._slots: dict[str, list[AccountSlot]] = {s: [] for s in self._sites_cfg}
        self._rr: dict[str, int] = {}          # 每站独立轮换游标（隔离）
        self._outstanding: dict[str, set[str]] = {}  # T41P0/P0-2：每站在途槽名（acquire 记/report 清）
        self._files_scanned: list[str] = []    # 如实：扫过的 *.secret.ini 文件名
        self._load_errors: list[str] = []      # 如实：解析失败文件+原因（不含值）
        self._load_credentials()

    # ------------------------------------------------------------ 凭据装载（只读 ini）

    def _site_defaults(self, site: str) -> dict[str, float]:
        return {**_GENERIC_SITE_CFG, **DEFAULT_SITES.get(site, {})}

    def _site_limiter_cfg(self, site: str) -> dict[str, float]:
        return self._sites_cfg.get(site) or self._site_defaults(site)

    def _load_credentials(self) -> None:
        """扫描凭据目录 ``*.secret.ini``（排序稳定→槽序确定）；坏文件记台账不炸。

        T41P0/P0-1（g）：文件级 POSIX 权限门（过宽即拒载记 load_errors）；
        ``egress`` 键=槽出口标签（P0-2，非凭据不入 login_creds）；敏感键降敏 SecretStr。
        """
        cred_dir = self._credentials_dir
        if not cred_dir.is_dir():
            self._load_errors.append(f"凭据目录不存在: {cred_dir}")
            return
        for ini in sorted(cred_dir.glob("*.secret.ini")):
            self._files_scanned.append(ini.name)
            mode_err = _secret_file_mode_error(ini)
            if mode_err is not None:            # T41P0/P0-1①：权限过宽拒载（整文件不解析）
                self._load_errors.append(mode_err)
                continue
            parser = configparser.ConfigParser()
            try:
                if not parser.read(ini, encoding="utf-8"):
                    self._load_errors.append(f"{ini.name}: 文件不可读/为空")
                    continue
            except (configparser.Error, OSError, UnicodeDecodeError) as exc:
                self._load_errors.append(f"{ini.name}: {type(exc).__name__}")
                continue
            for section in parser.sections():
                site = section.split(":", 1)[0].strip()
                if not site:
                    self._load_errors.append(f"{ini.name}: 节名 {section!r} 无站点前缀")
                    continue
                cookie = str(parser.get(section, "cookie", fallback="") or "").strip()
                egress = str(parser.get(section, "egress", fallback="") or "").strip()
                login = {
                    k: (SecretStr(v) if k.lower() in SENSITIVE_LOGIN_KEYS else v)
                    for k, v in parser.items(section)
                    if k not in ("cookie", "egress")}
                index = len(self._slots.setdefault(site, [])) + 1
                lim = self._site_limiter_cfg(site)
                slot = AccountSlot(
                    site=site, name=f"{site}#{index}", _cookie=SecretStr(cookie),
                    limiter=RateLimiter(
                        min_interval=float(lim["min_interval"]),
                        daily_limit=int(lim["daily_limit"]),
                        error_threshold=int(lim["error_threshold"]),
                        name=f"account:{site}#{index}",
                        clock=self._clock, sleep=self._sleep),
                    egress=egress, source=ini.name, login_creds=login)
                self._slots[site].append(slot)

    # ------------------------------------------------------------ acquire（轮换/冷却/熔断跳过）

    def _available(self, slot: AccountSlot) -> bool:
        if self._clock() < slot.cooldown_until:
            return False                       # tri_cap 冷却中（R13）
        if slot.limiter.status()["circuit_open"]:
            return False                       # RateLimiter 连续错误熔断（真符号第二道闸）
        return True

    def _egress_lendable(self, site: str, slot: AccountSlot) -> bool:
        """T41P0（P0-2/c）同 egress（=同出口 IP）最多 1 活跃槽——同 egress 已有**他槽**
        在途即锁（账号隔离名存实亡的短期护栏；每槽独立 egress 后自然解除）；同槽重复
        取出=同账号续用，不属多槽并发，不受限。"""
        out = self._outstanding.get(site) or frozenset()
        if slot.name in out:
            return True
        slots = self._slots.get(site) or ()
        return not any(o is not slot and o.name in out and o.egress == slot.egress
                       for o in slots)

    def _egress_isolation(self, site: str) -> bool:
        """T41P0（P0-2/c）：该站出口隔离是否成立——≤1 槽（单账号单 IP=天然隔离）或
        全槽 egress 非空且两两相异（每槽独立出口）。"""
        slots = self._slots.get(site) or ()
        if len(slots) <= 1:
            return True
        egresses = [s.egress for s in slots]
        return all(egresses) and len(set(egresses)) == len(egresses)

    def acquire(self, site: str) -> AccountSlot | None:
        """轮换取该站点一个可用槽（round-robin 跳过冷却/熔断/同 egress 在途锁槽）。

        无槽/全冷却/全熔断/全被 egress 锁 → None（调用方降级，不炸）；站点键未知同理
        None。取出的槽**必须** ``report`` 回报（在途记账清账的唯一路径——T41P0/P0-2）。
        """
        slots = self._slots.get(site)
        if not slots:
            return None
        rr, n = self._rr.get(site, 0), len(slots)
        for offset in range(n):
            slot = slots[(rr + offset) % n]
            if self._available(slot) and self._egress_lendable(site, slot):
                self._rr[site] = (rr + offset + 1) % n
                self._outstanding.setdefault(site, set()).add(slot.name)  # 在途记账
                return slot
        return None                             # 全员不可用：游标不动，如实 None

    # ------------------------------------------------------------ report（三态事件驱动）

    def report(self, site: str, slot: AccountSlot, event) -> dict:
        """回报信封三态事件（EnvelopeOK/EnvelopeFail/EnvelopeNeedVerify）。

        - OK → ``record_success`` + 梯级衰减 ``verify_streak-K``、未达连续
          ``OK_CLEAR_RUN`` 次保留 ``OK_HOLD_S`` 短冷却（T41P0/P0-3：单次放行不再
          全面复位——间歇软封下升级梯持续生效）；达 ``OK_CLEAR_RUN`` 次真清零
          （streak=0+无冷却）；
        - Fail → ``record_error``（连续达阈值由 RateLimiter 熔断）；
        - NeedVerify → 熔断冷却（退避梯度升梯）+ ``record_error``；
        - 任一态即清在途记账（T41P0/P0-2：请求生命周期止于 report）。
        返回回执 dict（无凭据值，可直接进 audit）。
        """
        if slot not in self._slots.get(site, []):
            raise ValueError(
                f"槽 {slot.name!r} 不属于站点 {site!r} 的池槽（多站点隔离防串槽）")
        self._outstanding.get(site, set()).discard(slot.name)   # 在途清账（先于分支，三态通吃）
        state = getattr(event, "state", None)
        kind = str(getattr(event, "kind", "") or "")
        now = self._clock()
        if state == STATE_NEED_VERIFY:          # R13：tri_cap 即熔断退避
            slot.need_verify_count += 1
            slot.verify_streak += 1
            slot.ok_run = 0                     # 连续 OK 断（P0-3 口径）
            rung = min(slot.verify_streak - 1, len(self._backoff) - 1)
            slot.cooldown_until = now + self._backoff[rung]  # 事件时刻起算本档时长；
            slot.limiter.record_error()         # 梯内连击 rung 单调不减+now 单调增 → 冷却只增不减
            action = f"cooldown+{self._backoff[rung]:g}s"
        elif state == STATE_OK:
            slot.ok_count += 1
            slot.ok_run += 1
            slot.limiter.record_success()
            if slot.ok_run >= OK_CLEAR_RUN:     # 连续 N 次 OK：真清零（全面复位）
                slot.verify_streak = 0
                slot.cooldown_until = 0.0
                action = "record_success+clear"
            else:                               # 衰减-K + 保留短冷却（不清零）
                slot.verify_streak = max(0, slot.verify_streak - OK_DECAY_K)
                slot.cooldown_until = now + OK_HOLD_S
                action = f"record_success+hold{OK_HOLD_S:g}s"
        elif state == STATE_FAIL:
            slot.fail_count += 1
            slot.ok_run = 0                     # 连续 OK 断（P0-3 口径）
            slot.limiter.record_error()
            action = "record_error"
        else:
            raise ValueError(f"未知信封三态: {state!r}（合法=ok/fail/need_verify）")
        slot.last_kind = kind
        return {"site": site, "slot": slot.name, "state": state, "kind": kind,
                "action": action, "ok_run": slot.ok_run,
                "cooldown_until": slot.cooldown_until,
                "cooldown_remaining_s": round(max(0.0, slot.cooldown_until - now), 3)}

    # ------------------------------------------------------------ health（报表，零凭据值）

    def health(self) -> dict:
        """池健康报表：每站槽位态/计数/真 limiter.status()——不回显任何凭据值。

        T41P0/P0-2：增 ``outstanding``（在途槽数）/``egress_isolation``（出口隔离
        是否成立）/``egress_shared_warning``（多槽共享出口时显式标记「同 IP 隔离
        不成立」——研判修法③原文口径）。
        """
        now = self._clock()
        sites: dict[str, dict] = {}
        for site in sorted(self._slots):
            slots = self._slots[site]
            isolation = self._egress_isolation(site)
            sites[site] = {
                "slots_total": len(slots),
                "slots_available": sum(1 for s in slots if self._available(s)),
                "outstanding": len(self._outstanding.get(site) or ()),
                "egress_isolation": isolation,
                "egress_shared_warning": (
                    "" if isolation or len(slots) <= 1 else
                    f"同 IP 隔离不成立（{len(slots)} 槽共享出口 egress=''——封号连坐面，"
                    f"须每槽独立 egress 或维持单活跃槽锁）"),
                "slots": [self._slot_health(s, now) for s in slots],
            }
        return {"clock": now, "backoff_ladder_s": list(self._backoff),
                "ok_decay_k": OK_DECAY_K, "ok_clear_run": OK_CLEAR_RUN,
                "ok_hold_s": OK_HOLD_S,
                "credential_files_scanned": list(self._files_scanned),
                "load_errors": list(self._load_errors),
                "sites": sites}

    def _slot_health(self, slot: AccountSlot, now: float) -> dict:
        if now < slot.cooldown_until:
            state = "cooldown"
        elif slot.limiter.status()["circuit_open"]:
            state = "circuit_open"
        else:
            state = "active"
        return {"name": slot.name, "source": slot.source,
                "has_cookie": bool(slot._cookie),
                "egress": slot.egress,
                "state": state,
                "cooldown_remaining_s": round(max(0.0, slot.cooldown_until - now), 1),
                "verify_streak": slot.verify_streak,
                "ok_run": slot.ok_run,
                "ok": slot.ok_count, "fail": slot.fail_count,
                "need_verify": slot.need_verify_count,
                "last_kind": slot.last_kind,
                "limiter": slot.limiter.status()}
