"""智谱免费链客户端 —— 移植自 We-AIPO src/llm/zhipu.py（实战五轮修复版）。

保留的实战修复（We-AIPO 编号）：
- FIX-0816e 429+1113 余额耗尽 → 会话级摘链（不退避，充值重启恢复）
- FIX-0816g 429 过载 → 120s 冷却跳过（不发请求不退避）
- FIX-0819i 限流记账不睡眠 → 立刻切下一免费模型；仅全链限流睡一次
- R1-S1 国内 API 直连铁律 → ProxyHandler({})，不吃系统代理
- 内容审核 1301 → 同内容所有模型都会拒绝，立即跳出
适配差异：requests→urllib（守住 pyproject 三依赖红线）；logger→stdlib；
企微告警→可注入回调；新增 fast/deep/vision 三契约方法（提案 4.2）。
"""
import base64
import json
import logging
import os
import re
import threading
import time
import urllib.error
import urllib.request
from collections.abc import Callable
from typing import Any

from tenacity import retry, retry_if_exception_type, stop_after_attempt, wait_exponential

_log = logging.getLogger("paistation.llm.zhipu")
_ZHIPU_URL = "https://open.bigmodel.cn/api/paas/v4/chat/completions"
# 视觉免费链回退（429 即切下一棒，语义同 chat 链）
_VISION_FALLBACKS = ("glm-4v-flash",)
# R1-S1：直连 opener，不吃 WinINET/Clash 系统代理
_OPENER = urllib.request.build_opener(urllib.request.ProxyHandler({}))


class _NetError(Exception):
    """网络层瞬断（tenacity 重试，429 不在内——必须立刻切模型）。"""


class _RateLimited(Exception):
    """GLM 429，上层应切换模型。"""


class _BalanceExhausted(Exception):
    """429+1113 余额耗尽：该模型本会话摘链，切下一个（不退避）。"""


class _ContentFilterError(Exception):
    """内容审核拦截（HTTP 400 code 1301）：立即跳过，不烧后续模型。"""


class _GLMError(Exception):
    """GLM 调用失败（全链）。"""


class _AdaptivePacer:
    """429 自适应节流：失败翻倍等待，成功缓慢回落。"""

    def __init__(self, start: float = 5.0, cap: float = 40.0):
        self._interval = start
        self._cap = cap
        self._lock = threading.Lock()

    def on_success(self) -> None:
        with self._lock:
            self._interval = max(2.0, self._interval * 0.7)

    def on_rate_limited(self) -> None:
        """翻倍并睡一个间隔（We-AIPO 原语义；热路径用 note_rate_limited）。"""
        with self._lock:
            self._interval = min(self._cap, self._interval * 2.0)
            wait = self._interval
        time.sleep(wait)

    def note_rate_limited(self) -> None:
        """FIX-0819i：只记账不睡眠——单模型退避不得拖累全链。"""
        with self._lock:
            self._interval = min(self._cap, self._interval * 2.0)

    @property
    def interval(self) -> float:
        with self._lock:
            return self._interval


# FIX-0816e：死模型登记（1113）；FIX-0816g：429 冷却 120s——共用一把锁
_STATE_LOCK = threading.Lock()
_DEAD_MODELS: set = set()
_MODEL_COOLDOWN: dict = {}
_COOLDOWN_SECONDS = 120.0
_ALERTED = False


def _cool_model(model: str) -> None:
    with _STATE_LOCK:
        _MODEL_COOLDOWN[model] = time.time() + _COOLDOWN_SECONDS


def _cooled_out(model: str) -> bool:
    with _STATE_LOCK:
        return _MODEL_COOLDOWN.get(model, 0.0) > time.time()


def _mark_model_dead(model: str, alert: Callable[[str, str], None] | None) -> None:
    global _ALERTED
    with _STATE_LOCK:
        if model in _DEAD_MODELS:
            return
        _DEAD_MODELS.add(model)
        first = not _ALERTED
        _ALERTED = True
    _log.warning("FIX-0816e: %s 1113 余额耗尽——本会话摘链（充值后重启恢复）", model)
    if first and alert:
        try:
            alert("GLM 余额耗尽请充值",
                  f"模型 {model} 返回 1113（余额不足），已自动摘链；"
                  f"请充值智谱后重启恢复。")
        except Exception as exc:  # 告警失败不阻断主链
            _log.debug("1113 告警回调异常（忽略）: %s", exc)


def _http_post(url: str, headers: dict, payload: dict, timeout: int = 60):
    data = json.dumps(payload).encode()
    req = urllib.request.Request(url, data=data, headers=headers, method="POST")
    try:
        with _OPENER.open(req, timeout=timeout) as resp:
            return resp.status, resp.read().decode("utf-8", "ignore")
    except urllib.error.HTTPError as exc:  # 4xx/5xx 仍带响应体
        return exc.code, exc.read().decode("utf-8", "ignore")
    except urllib.error.URLError as exc:
        raise _NetError(str(exc)) from exc


def extract_json(text: str) -> dict:
    """从 GLM 输出鲁棒提取 JSON：去 ```json 围栏，抓最外层 { }。"""
    cleaned = text.strip()
    cleaned = re.sub(r"^```(?:json)?|```$", "", cleaned, flags=re.MULTILINE).strip()
    if cleaned.startswith("{") and cleaned.endswith("}"):
        return json.loads(cleaned)
    match = re.search(r"\{.*\}", cleaned, flags=re.DOTALL)
    if match:
        return json.loads(match.group(0))
    raise ValueError(f"无法从输出中提取 JSON: {text[:200]}")


class ZhipuClient:
    """智谱 GLM 客户端（线程安全：单 pacer）。免费链优先，429 即切链。"""

    def __init__(self, api_key: str, free_models: list[str],
                 vision_model: str = "glm-4.6v-flash", *,
                 alert: Callable[[str, str], None] | None = None,
                 _post: Callable | None = None):
        if not api_key or api_key.startswith("${"):
            raise ValueError("智谱 api_key 未配置（env PAI_LLM_KEY / llm.secret.ini）")
        self._api_key = api_key
        self._free_models = free_models or ["glm-4.7-flash"]
        self._vision_model = vision_model
        self._alert = alert
        self._pacer = _AdaptivePacer()
        self._post = _post or _http_post

    def _headers(self) -> dict:
        return {"Authorization": f"Bearer {self._api_key}",
                "Content-Type": "application/json"}

    @retry(retry=retry_if_exception_type(_NetError),
           stop=stop_after_attempt(3),
           wait=wait_exponential(multiplier=4, min=4, max=30),
           reraise=True)
    def _call(self, messages: list, model: str, json_mode: bool,
              temperature: float, thinking: bool = False) -> dict:
        payload: dict[str, Any] = {"model": model, "messages": messages,
                                   "temperature": temperature, "top_p": 0.9}
        if json_mode:
            payload["response_format"] = {"type": "json_object"}
        if thinking:  # 附录 E.1：4.7-flash 思考开关（系统 2 深思考）
            payload["thinking"] = {"type": "enabled"}
        status, text = self._post(_ZHIPU_URL, self._headers(), payload)
        if status == 429:
            if "1113" in text:
                _mark_model_dead(model, self._alert)
                raise _BalanceExhausted(f"GLM {model} 1113 余额耗尽")
            _cool_model(model)
            self._pacer.note_rate_limited()
            raise _RateLimited(f"GLM {model} 429")
        if status != 200:
            if status == 400 and ("1301" in text[:300] or "contentFilter" in text[:300]):
                raise _ContentFilterError(f"GLM 内容审核拦截，跳过: {model}")
            raise _GLMError(f"GLM {model} HTTP {status}: {text[:300]}")
        self._pacer.on_success()
        data = json.loads(text)
        try:
            choice = data["choices"][0]
            return {"text": choice["message"]["content"],
                    "usage": data.get("usage", {}),
                    "finish_reason": choice.get("finish_reason", "stop")}
        except (KeyError, IndexError):
            raise _GLMError(f"GLM 响应结构异常: {text[:200]}") from None

    def chat(self, system_prompt: str, user_prompt: str, *,
             json_mode: bool = False, temperature: float = 0.3,
             prefer: str = "") -> str:
        """依次尝试免费链，首个成功即返回（FIX-0819i 语义）。"""
        messages = [{"role": "system", "content": system_prompt},
                    {"role": "user", "content": user_prompt}]
        chain = list(self._free_models)
        if prefer and prefer not in chain:
            chain.insert(0, prefer)
        with _STATE_LOCK:
            if _DEAD_MODELS:
                chain = [m for m in chain if m not in _DEAD_MODELS]
                if not chain:
                    raise _GLMError("所有 GLM 模型均 1113 余额耗尽（等待充值重启）")
        alive = [m for m in chain if not _cooled_out(m)]
        if alive:  # 全冷却则退回原链硬试（限流期总比不跑强）
            chain = alive
        last_error: Exception | None = None
        for model in chain:
            try:
                return self._call(messages, model, json_mode, temperature)["text"]
            except _ContentFilterError:
                raise  # 同内容所有模型都会拒绝，立即跳出
            except _BalanceExhausted:
                last_error = _BalanceExhausted("余额耗尽")
            except _RateLimited:
                last_error = _RateLimited("限流")
            except (_GLMError, _NetError) as exc:
                _log.warning("GLM %s 失败: %s，尝试下一模型", model, exc)
                last_error = exc
        if isinstance(last_error, _RateLimited):
            time.sleep(min(self._pacer.interval, 40.0))
        raise _GLMError(f"所有模型均失败，链={chain}，最后错误={last_error}")

    # ---------- 4.2 接口契约 ----------

    def fast(self, prompt: str, context: str = "", json_mode: bool = False) -> dict:
        """系统 1 高速通道：{text, confidence, usage}（json_mode 供 ingest 摘要）。"""
        r = self._call([{"role": "user", "content": f"{context}\n{prompt}".strip()}],
                       self._free_models[0], json_mode=json_mode, temperature=0.3)
        return {"text": r["text"], "usage": r["usage"],
                "confidence": 1.0 if r["finish_reason"] == "stop" else 0.5}

    def deep(self, prompt: str, reasoning: bool = True) -> dict:
        """系统 2 深思考：{text, chain, confidence}——思考开关 + 逐模型回退。"""
        messages = [{"role": "user", "content": prompt}]
        chain = list(self._free_models)
        tried: list[str] = []
        last: Exception | None = None
        for model in chain:
            tried.append(model)
            try:
                r = self._call(messages, model, json_mode=False,
                               temperature=0.3, thinking=reasoning)
                return {"text": r["text"], "chain": tried,
                        "confidence": 1.0 if r["finish_reason"] == "stop" else 0.5}
            except (_RateLimited, _BalanceExhausted) as exc:
                last = exc
            except (_GLMError, _NetError) as exc:
                _log.warning("GLM deep %s 失败: %s", model, exc)
                last = exc
        raise _GLMError(f"deep 全链失败，链={tried}，最后错误={last}")

    def vision(self, image_path: str, schema: dict) -> dict:
        """截图 → GLM-4V → 结构化事件：{json}。"""
        if not os.path.isfile(image_path):
            raise _GLMError(f"图片不存在: {image_path}")
        with open(image_path, "rb") as fh:
            b64 = base64.b64encode(fh.read()).decode()
        messages = [{"role": "user", "content": [
            {"type": "text", "content": "把截图内容结构化为 JSON，schema="
             + json.dumps(schema, ensure_ascii=False)},
            {"type": "image_url",
             "image_url": {"url": f"data:image/png;base64,{b64}"}}]}]
        last: Exception | None = None
        for model in (self._vision_model, *_VISION_FALLBACKS):
            with _STATE_LOCK:
                if model in _DEAD_MODELS:
                    continue
            if _cooled_out(model):
                continue
            try:
                r = self._call(messages, model, json_mode=True, temperature=0.1)
                return {"json": extract_json(r["text"])}
            except (_RateLimited, _BalanceExhausted) as exc:
                last = exc
            except (_GLMError, _NetError) as exc:
                _log.warning("GLM vision %s 失败: %s，尝试下一模型", model, exc)
                last = exc
        raise _GLMError(f"vision 全链失败，最后错误={last}")
