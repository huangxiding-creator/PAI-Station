"""判断层客户端：TypeSafe System One（Jev）三原语薄壳（09-19 深度融合）。

四层计算栈的「判断层」具象化：执行层（代码）之上的高频语义反射。
设计契约（用户三令）：
  1. 一键开关——PAI_JEV env 硬关 > config/jev.ini enabled > key 缺失，任一关即惰性；
  2. 故障跳过——所有公共入口 fail-soft 返回 None，调用方降级回原路径，绝不炸主链；
  3. 熔断器——连续失败进冷却，半开试探恢复，防雪崩打爆上游。

实验依据（tmp/jev_exp{1,2}_*.jsonl，2026-09-19）：
  - E2 任务请求 Noul：对抗集召回 1.00 / 误报 0.00（规则基线 0.27/0.42）
  - E1 意图 Choice：p50 1.3s、$0.0001/次、conf(对)0.92 vs conf(错)0.70 可路由
"""
from __future__ import annotations

import configparser
import hashlib
import json
import os
import random
import time
import urllib.error
import urllib.request
from collections.abc import Callable
from pathlib import Path

ENDPOINT = "https://api.typesafe.ai/v1/systemone"
DEFAULT_MODEL = "jev-1.13.0"
DEFAULT_TIMEOUT = 20.0
BREAKER_FAILURES = 3          # 连续失败阈值 → 熔断
BREAKER_COOLDOWN = 300.0      # 熔断冷却（秒），过后半开试探
_MAX_RETRIES = 2              # 429/529/网络抖动退避重试次数（共 3 发）

# LayaForge 引擎位（09-23）：laya=本机常驻服务（免费/50ms/可微调），
# typesafe=Jev 云端付费。应答逐字段同构 → 只换 transport，ask 主链零改动。
LAYA_ENDPOINT = "http://127.0.0.1:8864/v1/systemone"
LAYA_TIMEOUT = 5.0            # 本机服务，快失败快熔断
_DEFAULT_ENGINE = "typesafe"  # 平价门未过前默认云端；过门后切 laya

# transport: 请求数据(bytes) -> 响应 JSON(dict)；抛异常视作失败
Transport = Callable[[bytes], dict]

_OFF_VALUES = {"0", "false", "off", "no", ""}


def _config_dir() -> Path:
    # src/paistation/judgment/client.py → parents[3] = 仓库根（main.py 同款三层惯例）
    return Path(__file__).resolve().parents[3] / "config"


def _read_jev_ini(config_dir: Path) -> configparser.ConfigParser:
    cp = configparser.ConfigParser()
    cp.read(config_dir / "jev.ini", encoding="utf-8")
    return cp


def engine_status(config_dir: Path | None = None,
                  position: str | None = None) -> str:
    """引擎选择：PAI_JEV_ENGINE env > [engines] 位覆盖 > jev.ini engine >
    typesafe 默认。position=P1 渐进位名（intent/taskcards/golden/rf…）。"""
    cfg_dir = config_dir or _config_dir()
    env_raw = os.environ.get("PAI_JEV_ENGINE", "").strip().lower()
    if env_raw in ("laya", "typesafe"):
        return env_raw
    ini = cfg_dir / "jev.ini"
    if ini.is_file():
        cp = _read_jev_ini(cfg_dir)
        if position:
            raw = cp.get("engines", position, fallback="").strip().lower()
            if raw in ("laya", "typesafe"):
                return raw
        raw = cp.get("jev", "engine", fallback="").strip().lower()
        if raw in ("laya", "typesafe"):
            return raw
    return _DEFAULT_ENGINE


def shadow_status(config_dir: Path | None = None) -> tuple[str, float]:
    """双轨影子配置：[shadow] engine/sample。返回 (引擎, 采样率)；
    引擎空串=双轨关。影子只在主引擎≠影子引擎且有 traj 时生效（免费位
    全采样；付费影子不默认开——免费模型优先铁律）。"""
    cfg_dir = config_dir or _config_dir()
    ini = cfg_dir / "jev.ini"
    if not ini.is_file():
        return "", 1.0
    cp = _read_jev_ini(cfg_dir)
    eng = cp.get("shadow", "engine", fallback="").strip().lower()
    try:
        sample = float(cp.get("shadow", "sample", fallback="1.0"))
    except ValueError:
        sample = 1.0
    return (eng if eng in ("laya", "typesafe") else ""), max(0.0, min(1.0, sample))


def switch_status(config_dir: Path | None = None) -> dict:
    """三要素静态开关状态（env > ini > key）。laya 引擎免鉴权=不要求 key。"""
    cfg_dir = config_dir or _config_dir()
    engine = engine_status(cfg_dir)
    env_raw = os.environ.get("PAI_JEV")
    enabled_ini = None
    ini = cfg_dir / "jev.ini"
    if ini.is_file():
        cp = configparser.ConfigParser()
        cp.read(ini, encoding="utf-8")
        if cp.has_section("jev") and cp.has_option("jev", "enabled"):
            enabled_ini = cp.get("jev", "enabled").strip().lower() in ("1", "true", "yes", "on")
    key_file = cfg_dir / "typesafe.secret.ini"
    has_key = False
    if key_file.is_file():
        cp = configparser.ConfigParser()
        cp.read(key_file, encoding="utf-8")
        has_key = bool(cp.get("typesafe", "api_key", fallback="").strip())
    env_off = env_raw is not None and env_raw.strip().lower() in _OFF_VALUES
    enabled = ((not env_off) and (enabled_ini is not False)
               and (has_key or engine == "laya"))
    return {"enabled": enabled, "env": env_raw, "env_off": env_off,
            "ini_enabled": enabled_ini, "has_key": has_key, "engine": engine}


def set_switch(on: bool, config_dir: Path | None = None,
               engine: str | None = None,
               engines: dict[str, str] | None = None,
               shadow: dict[str, str] | None = None) -> Path:
    """一键开关：读改写 config/jev.ini（入库无秘密；env 硬关不受此影响）。
    engine=None 保持现状；engines/shadow 合并进对应节（P1 渐进位/双轨），
    未提到的键原样保留——round-trip 不再吞节。"""
    cfg_dir = config_dir or _config_dir()
    engine = engine or engine_status(cfg_dir)
    ini = cfg_dir / "jev.ini"
    ini.parent.mkdir(parents=True, exist_ok=True)
    cp = configparser.ConfigParser()
    if ini.is_file():
        cp.read(ini, encoding="utf-8")
    if not cp.has_section("jev"):
        cp.add_section("jev")
    cp.set("jev", "engine", engine)
    cp.set("jev", "enabled", "1" if on else "0")
    if engines:
        if not cp.has_section("engines"):
            cp.add_section("engines")
        for pos, eng in engines.items():
            cp.set("engines", pos, eng)
    if shadow:
        if not cp.has_section("shadow"):
            cp.add_section("shadow")
        for key, val in shadow.items():
            cp.set("shadow", key, val)
    with ini.open("w", encoding="utf-8") as fh:
        fh.write("# Jev 判断层总开关：off 后所有接线点静默回退原行为\n")
        cp.write(fh)
    return ini


class JudgmentClient:
    """Jev 三原语客户端（进程内单例语义：熔断状态随实例）。

    ask()        state+questions -> answers dict | None
    ask_noul()   -> float | None          （命题为真概率）
    ask_choice() -> (choice, meta) | None （选项+{probabilities,confidence}）
    一切故障（开关关/熔断/网络/协议）→ None，绝不抛出。
    """

    def __init__(self, api_key: str | None = None,
                 model: str = DEFAULT_MODEL, *,
                 config_dir: Path | None = None,
                 timeout: float = DEFAULT_TIMEOUT,
                 transport: Transport | None = None,
                 traj_path: Path | None = None,
                 position: str | None = None,
                 shadow_transport: Transport | None = None):
        self._cfg_dir = config_dir or _config_dir()
        self.position = position
        status = switch_status(self._cfg_dir)
        self.engine = engine_status(self._cfg_dir, position)
        self._api_key = api_key if api_key is not None else _load_key(self._cfg_dir)
        # laya=本机免鉴权服务，无 key 也算可用；typesafe 必须有 key
        self.enabled = status["enabled"] and (bool(self._api_key)
                                              or self.engine == "laya")
        self.model = model
        self._timeout = (LAYA_TIMEOUT if (self.engine == "laya"
                                          and timeout == DEFAULT_TIMEOUT)
                         else float(timeout))
        self._transport = transport or (self._laya_http if self.engine == "laya"
                                        else self._http)
        # 调用轨迹审计（typesafe 六项合规，隐私优先：state 只落 hash、
        # answers 只落数值摘要；None=不记录（默认零写入）；
        # 写入失败 fail-soft 不影响 ask 主链）。
        # P1：带 position 的接线位默认落 traj（双轨报告的数据面）
        if traj_path is None and position:
            # 锚在 config_dir 的仓库根（config/ 的上级）：默认落位
            # <repo>/data/traj/jev-{position}.jsonl；测试 tmp 目录同样成立
            self._traj_path = (self._cfg_dir.parent / "data" / "traj"
                               / f"jev-{position}.jsonl")
        else:
            self._traj_path = traj_path
        # 双轨影子（P1）：主引擎之外单发采样调第二引擎，traj 记
        # agree/latency；免费位全采样，绝不抛、绝不重试、三连败停摆
        s_engine, s_sample = shadow_status(self._cfg_dir)
        self._shadow_engine = (s_engine if s_engine and s_engine != self.engine
                               else "")
        self._shadow_sample = s_sample
        # 影子专线：默认按引擎名自选（生产）；测试注入同一 fake 分流用
        self._shadow_transport = shadow_transport
        self._shadow_fails = 0
        self._shadow_off = False
        # 熔断器状态
        self._consecutive_failures = 0
        self._open_until: float = 0.0

    # ---- 公共原语（fail-soft）----

    def ask(self, state, questions: dict) -> dict | None:
        if not self.enabled or not self._breaker_allows():
            return None
        t0 = time.monotonic()
        body = json.dumps({"state": state, "model": self.model,
                           "questions": questions}, ensure_ascii=False).encode("utf-8")
        for attempt in range(_MAX_RETRIES + 1):
            try:
                payload = self._transport(body)
                answers = payload.get("answers")
                if not isinstance(answers, dict) or not answers:
                    raise ValueError("empty answers")
                self._breaker_success()
                dual = self._shadow_run(state, questions, answers)
                self._record_traj(state, questions, answers,
                                  payload.get("usage"), t0, ok=True, dual=dual)
                return answers
            except Exception:  # noqa: BLE001 - 一切故障统一降级
                if attempt < _MAX_RETRIES:
                    time.sleep(2 ** attempt + 1)
                    continue
        self._breaker_fail()
        dual = self._shadow_run(state, questions, None)
        self._record_traj(state, questions, None, None, t0, ok=False, dual=dual)
        return None

    def ask_noul(self, state, instructions: str,
                 criteria: dict | None = None) -> float | None:
        q: dict = {"type": "noul", "instructions": instructions}
        if criteria:
            q["criteria"] = criteria
        answers = self.ask(state, {"noul": q})
        if not answers:
            return None
        try:
            return float(answers["noul"]["noul"])
        except (KeyError, TypeError, ValueError):
            return None

    def ask_choice(self, state, instructions: str, criteria: dict):
        answers = self.ask(state, {"choice": {
            "type": "choice", "instructions": instructions,
            "criteria": criteria}})
        if not answers:
            return None
        try:
            ans = answers["choice"]
            return ans["choice"], {"probabilities": ans["probabilities"],
                                   "confidence": float(ans["confidence"])}
        except (KeyError, TypeError, ValueError):
            return None

    # ---- 双轨影子（P1 渐进替换的观察器）----

    def _shadow_run(self, state, questions, primary_answers) -> dict | None:
        """主引擎答完后再单发一次影子引擎（免费位），返回 dual 摘要。
        契约：绝不抛、绝不重试（单发）、三连败本实例停摆、
        仅 traj 在位时运行（影子是观察仪器，无记录=无意义白烧）。"""
        if (not self._shadow_engine or self._traj_path is None
                or self._shadow_off
                or random.random() > self._shadow_sample):
            return None
        t0 = time.monotonic()
        try:
            body = json.dumps({"state": state, "model": self.model,
                               "questions": questions},
                              ensure_ascii=False).encode("utf-8")
            transport = (self._shadow_transport or
                         (self._laya_http if self._shadow_engine == "laya"
                          else self._http))
            payload = transport(body)
            answers = payload.get("answers")
            if not isinstance(answers, dict) or not answers:
                raise ValueError("empty answers")
        except Exception:  # noqa: BLE001 - 影子任何故障都不碰主链
            self._shadow_fails += 1
            if self._shadow_fails >= 3:
                self._shadow_off = True
            return {"engine": self._shadow_engine, "latency_s":
                    round(time.monotonic() - t0, 2), "error": True}
        self._shadow_fails = 0
        return {"engine": self._shadow_engine,
                "latency_s": round(time.monotonic() - t0, 2),
                "agree": _answers_agree(primary_answers, answers),
                "sa": _answer_digest(answers)}

    # ---- 调用轨迹审计（六项合规，fail-soft）----

    def _record_traj(self, state, questions, answers, usage, t0, *,
                     ok: bool, dual: dict | None = None) -> None:
        """一行一调用：ts/state_hash/question 摘要/answer 数值摘要/
        usage/latency/outcome（+position/engine/dual 双轨字段）。
        traj_path 缺席或写失败=零影响。"""
        if self._traj_path is None:
            return
        try:
            state_json = json.dumps(state, ensure_ascii=False, sort_keys=True)
            row = {
                "ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
                "position": self.position,
                "engine": self.engine,
                "state_hash": hashlib.sha256(
                    state_json.encode("utf-8")).hexdigest()[:16],
                "q": {qid: q.get("type")
                      for qid, q in (questions or {}).items()
                      if isinstance(q, dict)},
                "a": _answer_digest(answers),
                "usage": usage if isinstance(usage, dict) else None,
                "latency_s": round(time.monotonic() - t0, 2),
                "ok": ok,
                "dual": dual,
            }
            self._traj_path.parent.mkdir(parents=True, exist_ok=True)
            with self._traj_path.open("a", encoding="utf-8") as fh:
                fh.write(json.dumps(row, ensure_ascii=False) + "\n")
        except Exception:  # noqa: BLE001 - 审计绝不反噬主链
            pass

    # ---- 熔断器 ----

    def _breaker_allows(self) -> bool:
        if self._open_until <= 0:
            return True
        if time.monotonic() < self._open_until:
            return False               # open：冷却中全拒
        self._open_until = -1.0        # half-open：放一次试探
        return True

    def _breaker_success(self) -> None:
        self._consecutive_failures = 0
        self._open_until = 0.0

    def _breaker_fail(self) -> None:
        self._consecutive_failures += 1
        if self._consecutive_failures >= BREAKER_FAILURES:
            self._open_until = time.monotonic() + BREAKER_COOLDOWN
            self._consecutive_failures = 0

    @property
    def breaker_open(self) -> bool:
        return self._open_until > 0 and time.monotonic() < self._open_until

    # ---- 默认 HTTP transport ----

    def _http(self, data: bytes) -> dict:
        req = urllib.request.Request(
            ENDPOINT, data=data, method="POST", headers={
                "Authorization": f"Bearer {self._api_key}",
                "Content-Type": "application/json"})
        with urllib.request.urlopen(req, timeout=self._timeout) as resp:
            return json.loads(resp.read().decode("utf-8"))

    def _laya_http(self, data: bytes) -> dict:
        """laya transport：同款 JSON body POST 本机服务，免鉴权（ADR-2）。"""
        req = urllib.request.Request(
            LAYA_ENDPOINT, data=data, method="POST", headers={
                "Content-Type": "application/json"})
        with urllib.request.urlopen(req, timeout=self._timeout) as resp:
            return json.loads(resp.read().decode("utf-8"))


def _load_key(cfg_dir: Path) -> str:
    cp = configparser.ConfigParser()
    cp.read(cfg_dir / "typesafe.secret.ini", encoding="utf-8")
    return cp.get("typesafe", "api_key", fallback="").strip()


def _answer_digest(answers) -> dict | None:
    """answers → 数值摘要（noul 值/choice+confidence），不落文本负载。"""
    if not isinstance(answers, dict):
        return None
    out = {}
    for qid, ans in answers.items():
        if not isinstance(ans, dict):
            continue
        t = ans.get("type")
        if t == "noul":
            out[qid] = {"noul": ans.get("noul")}
        elif t == "choice":
            out[qid] = {"choice": ans.get("choice"),
                        "confidence": ans.get("confidence")}
    return out or None


def _answers_agree(primary, shadow) -> bool | None:
    """双轨一致性：choice 同选 / noul |Δ|≤0.15（E2/E3 分离缝两侧不跨界）。
    任一侧缺席或无可比字段 → None（不计入一致率分母）。"""
    da, db = _answer_digest(primary), _answer_digest(shadow)
    if not da or not db or set(da) != set(db):
        return None
    verdicts = []
    for qid, x in da.items():
        y = db[qid]
        if "choice" in x:
            verdicts.append(x["choice"] == y.get("choice"))
        if "noul" in x:
            try:
                verdicts.append(abs(float(x["noul"]) - float(y["noul"])) <= 0.15)
            except (TypeError, ValueError):
                verdicts.append(False)
    return all(verdicts) if verdicts else None


def make_task_judge(config_dir: Path | None = None,
                    transport: Transport | None = None) -> Callable[[str], float | None]:
    """taskcards 专用 judge 适配器：text -> Noul(是否任务指派) | None。
    位名 taskcards：E2 门已过 → [engines] 可切 laya，traj 自动落位。"""
    client = JudgmentClient(config_dir=config_dir, transport=transport,
                            position="taskcards")
    instructions = "这句话是否是在向某人指派或请求完成一项具体任务或待办事项？"
    criteria = {
        "true": "有明确的受托人和要完成的具体事项，常含时间要求；"
                "叙述过去、闲聊、抒发观点不算",
        "false": "闲聊、观点、过去的叙述、或对未来的一般性建议，"
                 "不构成可记录的待办",
    }

    def judge(text: str) -> float | None:
        if not client.enabled:
            return None
        return client.ask_noul(
            {"text": text, "context": "用户语音/会议转写中的一句话"},
            instructions, criteria)

    return judge
