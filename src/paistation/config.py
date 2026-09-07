"""INI 加载与校验（附录 C.4）：五类错误中文报错，不带病运行。

纯标准库；返回只读映射（不可变）。密钥永不落本仓库：
api_key 优先级 环境变量 PAI_LLM_KEY > [llm].api_key > config/llm.secret.ini。
"""
import configparser
import os
import re
import types

_DATA_DIR = os.path.expandvars(r"%LOCALAPPDATA%\PAI-Station")
_BOOL = {"1": True, "true": True, "yes": True, "on": True,
         "0": False, "false": False, "no": False, "off": False}
_HHMM = r"([01]\d|2[0-3]):[0-5]\d"
_WEBHOOK = re.compile(r"^https://qyapi\.weixin\.qq\.com/cgi-bin/webhook/send\?key=[0-9A-Za-z-]+$")


class ConfigError(Exception):
    """配置非法：中文报错，拒绝启动。"""


def _loc(section: str, key: str) -> str:
    return f"[{section}].{key}"


class _Reader:
    """按字段规格读取并校验一个 INI 段。"""

    def __init__(self, parser: configparser.ConfigParser, section: str):
        self.parser = parser
        self.section = section

    def _raw(self, key: str, default) -> str | None:
        if self.parser.has_option(self.section, key):
            return self.parser.get(self.section, key).strip()
        if default is None:
            raise ConfigError(f"缺少配置 {_loc(self.section, key)}，请参考附录 C.1 填写")
        return None  # 用默认值

    def _num(self, key, default, cast, lo, hi, kind):
        raw = self._raw(key, default)
        if raw is None:
            return default
        try:
            val = cast(raw)
        except ValueError:
            raise ConfigError(f"值 '{raw}' 不是合法{kind}（{_loc(self.section, key)}）") from None
        if not (lo <= val <= hi):
            raise ConfigError(f"{val:g} 超出 {_loc(self.section, key)} 允许范围 {lo:g}-{hi:g}")
        return val

    def str(self, key, default=""):
        raw = self._raw(key, default)
        return default if raw is None else raw

    def int(self, key, default, lo, hi):
        return self._num(key, default, int, lo, hi, "整数")

    def float(self, key, default, lo, hi):
        return self._num(key, default, float, lo, hi, "浮点数")

    def bool(self, key, default):
        raw = self._raw(key, default)
        if raw is None:
            return default
        val = raw.lower()
        if val not in _BOOL:
            raise ConfigError(f"值 '{raw}' 不是合法布尔（{_loc(self.section, key)}，"
                              f"应为 1/0/true/false）")
        return _BOOL[val]

    def list(self, key, default):
        raw = self._raw(key, default)
        if raw is None:
            return tuple(default)
        return tuple(item.strip() for item in raw.split(",") if item.strip())

    def pattern(self, key, default, regex, example):
        raw = self._raw(key, default)
        if raw is None:
            return default
        if not re.fullmatch(regex, raw):
            raise ConfigError(f"格式错误：'{raw}' 不匹配 {example}（{_loc(self.section, key)}）")
        return raw


def _watch_dirs(reader: _Reader) -> tuple[str, ...]:
    out = []
    for raw in reader.list("watch_dirs", None):
        expanded = os.path.expandvars(os.path.expanduser(raw))
        if not os.path.isdir(expanded):
            raise ConfigError(f"路径不存在（[sense].watch_dirs）：'{raw}' → '{expanded}'")
        out.append(expanded)
    return tuple(out)


def load(path: str, env: dict[str, str] | None = None) -> types.MappingProxyType:
    """全量校验加载 pai.ini，返回只读配置；非法即抛 ConfigError。"""
    if not os.path.isfile(path):
        raise ConfigError(f"未找到配置文件：{path}（请参考 config/pai.ini，"
                          f"或用环境变量 PAI_INI 指定）")
    parser = configparser.ConfigParser()
    try:
        with open(path, encoding="utf-8") as fh:
            parser.read_file(fh)
    except (OSError, configparser.Error) as exc:
        raise ConfigError(f"配置文件解析失败：{exc}") from exc

    def sec(name: str) -> _Reader:
        return _Reader(parser, name)

    llm = {
        "api_key": sec("llm").str("api_key", ""),
        "fast_model": sec("llm").str("fast_model", "glm-4-flash-250414"),
        "deep_model": sec("llm").str("deep_model", "glm-4.7-flash"),
        "vision_model": sec("llm").str("vision_model", "glm-4.6v-flash"),
        "long_model": sec("llm").str("long_model", "glm-4.7-flash"),
        "upgrade_confidence": sec("llm").float("upgrade_confidence", 0.7, 0.5, 0.9),
        "ensemble_size": sec("llm").int("ensemble_size", 8, 1, 32),
        "verify_rounds": sec("llm").int("verify_rounds", 2, 0, 5),
        "semantic_cache": sec("llm").bool("semantic_cache", True),
    }
    sense = {
        "watch_dirs": _watch_dirs(sec("sense")),
        "ignore_patterns": sec("sense").list("ignore_patterns",
                                            ["*.tmp", "~$*", ".git", "node_modules"]),
        "screen_interval_sec": sec("sense").int("screen_interval_sec", 600, 60, 3600),
        "screen_blacklist": sec("sense").list("screen_blacklist",
                                              ["密码管理器", "银行", "支付", "登录"]),
        "fg_poll_sec": sec("sense").int("fg_poll_sec", 300, 60, 900),
        "deepwork_apps": sec("sense").list("deepwork_apps",
                                           ["WINWORD.EXE", "idea64.exe", "Code.exe", "wps.exe"]),
        "clipboard_enabled": sec("sense").bool("clipboard_enabled", False),
    }
    ch = sec("channels")
    wechat_mode = ch.str("wechat_mode", "vision_readonly")
    if wechat_mode != "vision_readonly":
        raise ConfigError(f"危险配置：[channels].wechat_mode 仅允许 vision_readonly"
                          f"（防篡改），当前值 '{wechat_mode}'")
    webhook = ch.str("notify_webhook", "")
    if webhook and not _WEBHOOK.match(webhook):
        raise ConfigError(f"格式错误：'{webhook}' 不是合法企微 webhook 地址"
                          f"（[channels].notify_webhook）")
    channels = {
        "feishu_enabled": ch.bool("feishu_enabled", False),
        "dingtalk_enabled": ch.bool("dingtalk_enabled", False),
        "wecom_enabled": ch.bool("wecom_enabled", True),
        "wechat_mode": wechat_mode,
        "notify_webhook": webhook,
    }
    proactive = {
        "max_push_per_day": sec("proactive").int("max_push_per_day", 2, 1, 5),
        "drawer_retention_days": sec("proactive").int("drawer_retention_days", 7, 3, 30),
        "quiet_hours": sec("proactive").pattern(
            "quiet_hours", "22:00-07:00", f"{_HHMM}-{_HHMM}", "22:00-07:00"),
        "explore_rate": sec("proactive").float("explore_rate", 0.1, 0.0, 0.3),
    }
    privacy = {
        "data_dir": sec("privacy").str("data_dir", _DATA_DIR),
        "export_on_exit": sec("privacy").bool("export_on_exit", False),
        "never_send": sec("privacy").list(
            "never_send", ["原始截图", "凭据类文件", "身份证", "银行卡"]),
    }
    learn_r = sec("learn")
    if not learn_r.bool("double_loop_confirm", True):
        raise ConfigError("[learn].double_loop_confirm 安全默认不可低于 1：双环改动必须用户确认")
    learn = {
        "pdca_time": learn_r.pattern("pdca_time", "02:00", _HHMM, "HH:MM"),
        "distill_min_samples": learn_r.int("distill_min_samples", 5, 3, 10),
        "double_loop_confirm": True,
    }
    wow_r = sec("wow")
    wow = {
        "wow_first_run": wow_r.bool("wow_first_run", True),
        "singularity_announce": wow_r.bool("singularity_announce", True),
        "zero_bill_monthly": wow_r.bool("zero_bill_monthly", True),
    }
    return types.MappingProxyType({
        name: types.MappingProxyType(sect) for name, sect in (
            ("llm", llm), ("sense", sense), ("channels", channels),
            ("proactive", proactive), ("privacy", privacy), ("learn", learn), ("wow", wow))})


def resolve_api_key(cfg: types.MappingProxyType, env: dict[str, str] | None = None,
                    secret_ini: str | None = None) -> str:
    """优先级：env PAI_LLM_KEY > [llm].api_key > config/llm.secret.ini。"""
    env = os.environ if env is None else env
    for val in (env.get("PAI_LLM_KEY", "").strip(), cfg["llm"]["api_key"].strip()):
        if val:
            return val
    secret_ini = secret_ini or os.path.join(os.path.dirname(os.path.abspath(
        __file__)), "..", "..", "config", "llm.secret.ini")
    if os.path.isfile(secret_ini):
        sp = configparser.ConfigParser()
        sp.read(secret_ini, encoding="utf-8")
        from_secret = sp.get("llm", "api_key", fallback="").strip()
        if from_secret:
            return from_secret
    raise ConfigError("缺少智谱 API Key：请设置环境变量 PAI_LLM_KEY，"
                      "或填写 [llm].api_key / llm.secret.ini")
