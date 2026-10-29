# -*- coding: utf-8 -*-
"""智谱免费链客户端 — PAI-Station zhipu_client（We-AIPO 五轮修复版）契约的引擎精简移植。

契约 1:1 对齐 src/paistation/llm/zhipu_client.py：
- 429 → 该模型冷却 120s 即切下一模型（不睡眠拖累全链）
- 429+1113 余额耗尽 → 该账号摘链（本会话不再尝试）
- 400+1301 内容审核 → 立即失败（同内容所有模型都会拒）
- 直连 opener（ProxyHandler({})），不吃系统代理（R1-S1）
- 多账号免费池：账号全链耗尽自动切下一账号重试整链
精简：无 tenacity（网络瞬断=失败切模型）；无企微告警（引擎日志即告警面）。
密钥：data/secrets/zhipu.secret，行式 api_key=... / api_key_2=...
"""
from __future__ import annotations

import json
import logging
import threading
import time
import urllib.error
import urllib.request
from pathlib import Path

from . import config

_log = logging.getLogger("qianwen.zhipu")

_ZHIPU_URL = "https://open.bigmodel.cn/api/paas/v4/chat/completions"
_OPENER = urllib.request.build_opener(urllib.request.ProxyHandler({}))  # 直连
_COOLDOWN_SECONDS = 120.0
_MIN_CALL_INTERVAL = 1.5   # v0.7.0：免费链全局节流——并发请求自己打爆限流的根治

# v0.7.0 串行闸：智谱免费池共享限流额度，所有调用排队走（追问/要点/引用展开共用）
_CALL_LOCK = threading.Lock()
_LAST_CALL_TS = 0.0

# 按 key 隔离的账号状态（余额/限流都是账号属性，非模型属性）
_STATE_LOCK = threading.Lock()
_ACCOUNT_STATE: dict[str, dict] = {}
_KEYS_CACHE: list[str] | None = None
_KEYS_TS = 0.0


def _acct_nolock(key: str) -> dict:
    st = _ACCOUNT_STATE.get(key)
    if st is None:
        st = {"dead": set(), "cooldown": {}}
        _ACCOUNT_STATE[key] = st
    return st


def load_keys() -> list[str]:
    """读密钥文件（5s 缓存；文件缺失/为空 → []，调用方走 KB 回落）。"""
    global _KEYS_CACHE, _KEYS_TS
    now = time.time()
    if _KEYS_CACHE is not None and now - _KEYS_TS < 5:
        return _KEYS_CACHE
    keys: list[str] = []
    f: Path = config.ZHIPU_SECRET_FILE
    try:
        if f.exists():
            for line in f.read_text(encoding="utf-8").splitlines():
                line = line.strip()
                if not line or line.startswith("#"):
                    continue
                k, _, v = line.partition("=")
                if k.strip() in ("api_key", "api_key_2", "key", "key2") and v.strip():
                    if v.strip() not in keys:
                        keys.append(v.strip())
    except OSError as exc:
        _log.warning("zhipu.secret 读取失败: %s", exc)
    _KEYS_CACHE, _KEYS_TS = keys, now
    return keys


def configured() -> bool:
    return bool(load_keys())


def _post(url: str, headers: dict, payload: dict, timeout: int) -> tuple[int, str]:
    data = json.dumps(payload).encode()
    req = urllib.request.Request(url, data=data, headers=headers, method="POST")
    try:
        with _OPENER.open(req, timeout=timeout) as resp:
            return resp.status, resp.read().decode("utf-8", "ignore")
    except urllib.error.HTTPError as exc:
        return exc.code, exc.read().decode("utf-8", "ignore")


def _clean(text: str) -> str:
    """问题改写输出规整：去围栏/首尾引号/空白。"""
    t = (text or "").strip()
    if t.startswith("```"):
        t = t.strip("`").lstrip(" \n").rstrip(" \n")
        if t.lower().startswith("text"):
            t = t[4:].lstrip(" \n")
    return t.strip().strip('"“”').strip()


def rewrite(prompt: str) -> str:
    """单轮改写（追问/要点/引用展开共用）：免费链逐模型 × 逐账号，首个成功即返回。
    v0.7.0：全局串行闸 + 最小间隔——多线程并发调用不再自己打爆免费限流。"""
    return _chat_any([{"role": "user", "content": prompt}])


def deep_answer(system: str, prompt: str, temperature: float = 0.5,
                max_tokens: int = 2048) -> str:
    """v0.7.3 锅圈播种长文生成：system+user 双角色（区别于 rewrite 的单轮短改写）。"""
    return _chat_any(
        [{"role": "system", "content": system}, {"role": "user", "content": prompt}],
        temperature=temperature, max_tokens=max_tokens)


def _chat_any(messages: list, temperature: float = 0.3, max_tokens: int | None = None) -> str:
    """免费链通用对话核：逐模型 × 逐账号，首个成功即返回。
    v0.7.0：全局串行闸 + 最小间隔——多线程并发调用不再自己打爆免费限流。"""
    keys = load_keys()
    if not keys:
        raise RuntimeError("zhipu 未配置密钥")
    last_error: Exception | None = None
    with _CALL_LOCK:
        global _LAST_CALL_TS
        _wait = _LAST_CALL_TS + _MIN_CALL_INTERVAL - time.time()
        if _wait > 0:
            time.sleep(_wait)
        _LAST_CALL_TS = time.time()
        with _STATE_LOCK:
            alive_keys = [k for k in keys if not _acct_nolock(k)["dead"]]
        for key in alive_keys:
            for model in config.ZHIPU_FREE_MODELS:
                with _STATE_LOCK:
                    st = _acct_nolock(key)
                    if model in st["dead"] or st["cooldown"].get(model, 0.0) > time.time():
                        continue
                payload = {"model": model, "messages": messages,
                           "temperature": temperature, "top_p": 0.9}
                if max_tokens:
                    payload["max_tokens"] = max_tokens
                status, text = _post(
                    _ZHIPU_URL,
                    {"Authorization": f"Bearer {key}", "Content-Type": "application/json"},
                    payload,
                    config.ZHIPU_TIMEOUT_SEC,
                )
                if status == 429:
                    if "1113" in text:
                        with _STATE_LOCK:
                            _acct_nolock(key)["dead"].add(model)
                        last_error = RuntimeError(f"GLM {model} 1113 余额耗尽")
                        continue
                    with _STATE_LOCK:
                        _acct_nolock(key)["cooldown"][model] = time.time() + _COOLDOWN_SECONDS
                    last_error = RuntimeError(f"GLM {model} 429 限流")
                    continue
                if status == 400 and ("1301" in text[:300] or "contentFilter" in text[:300]):
                    raise RuntimeError("内容审核拦截，请调整问题表述后重试")
                if status != 200:
                    last_error = RuntimeError(f"GLM {model} HTTP {status}: {text[:200]}")
                    continue
                try:
                    content = json.loads(text)["choices"][0]["message"]["content"]
                except (KeyError, IndexError, ValueError):
                    last_error = RuntimeError(f"GLM 响应结构异常: {text[:200]}")
                    continue
                cleaned = _clean(content)
                if cleaned:
                    return cleaned
                last_error = RuntimeError("GLM 返回空内容")
        raise RuntimeError(f"智谱免费链全失败: {last_error}")


def friendly_error(exc: Exception) -> str:
    """面向用户的追问/引用展开失败文案（不裸抛内部堆栈）。"""
    t = str(exc or "")
    if "429" in t or "限流" in t:
        return "免费通道当前咨询人数较多，请稍等 1-2 分钟再试"
    if "1113" in t or "余额" in t:
        return "免费通道今日额度紧张，请稍后再试"
    if "内容审核" in t:
        return "这个问题暂时无法展开，请调整表述后重试"
    return "生成遇到一点问题，请稍后再试"
