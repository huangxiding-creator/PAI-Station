# -*- coding: utf-8 -*-
"""blind_test_panel — 双盲 A/B 报告质量评测面板 (1017 用户令: 盲测盲评).

两份匿名摘录 X/Y (mapping.json 存真身映射, 裁判不可见) → 三家独立大模型裁判
(DeepSeek / SiliconFlow-Qwen / 智谱GLM) × 双顺序 (防位次偏置) = 6 判。
评分五维 (1-10): 决策有用性 / 证据可信度 / 分析深度 / 盲区诚实度 / 专业准确性。
输出: _tmp_blind/verdict.json + 控制台汇总。双序同判才计「稳定胜负」。
"""
from __future__ import annotations

import json
import re
import sys
import time
import urllib.request as u
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
D = Path(__file__).resolve().parents[1] / "_tmp_blind"

RUBRIC = """你是资深行业研究报告评审专家。现有两份匿名研究摘录（X 与 Y），主题相同：
全球新能源/储能市场的机会与风险分析。请以「需要据此做投资/经营决策的企业决策者」视角严格评审。

评审纪律（先读完全文再打分）：警惕先入为主——先呈现的文本不构成任何加分理由；
两份必须逐维度对照后独立打分，禁止因篇幅、格式差异倾向任一方。

评分维度（各 1-10 分）：
1. decision_usefulness 决策有用性：读完能否直接指导行动
2. evidence_credibility 证据可信度：数字是否有来源/可核验，还是空泛断言
3. analytical_depth 分析深度：有无因果机制、反证、边界条件，还是罗列现象
4. honesty_about_limits 盲区诚实度：是否承认不确定性/风险/自身局限
5. professional_accuracy 专业准确性：术语、机制、政策引用是否内行

只输出严格 JSON（无其他文本）：
{"X": {"decision_usefulness": n, "evidence_credibility": n, "analytical_depth": n,
       "honesty_about_limits": n, "professional_accuracy": n},
 "Y": {同上},
 "winner": "X" 或 "Y" 或 "tie",
 "one_line": "一句话核心理由（<=60字）"}
"""


def _env_keys() -> dict:
    out = {}
    for line in Path(r"F:\We-AIPO\.env").read_text(encoding="utf-8").splitlines():
        if "=" in line and not line.strip().startswith("#"):
            k, _, v = line.partition("=")
            out[k.strip()] = v.strip()
    return out


def _zhipu_keys() -> list[str]:
    out = []
    for line in Path(r"E:\AI-Station\data\secrets\zhipu.secret").read_text(encoding="utf-8").splitlines():
        line = line.strip()
        for pre in ("api_key=", "api_key_2=", "key="):
            if line.startswith(pre) and len(line) > len(pre) + 8:
                out.append(line[len(pre):])
    return list(dict.fromkeys(out))


def chat(url: str, key: str, model: str, prompt: str, extra_headers: dict | None = None,
         timeout: int = 120) -> str:
    body = json.dumps({"model": model, "temperature": 0.2, "max_tokens": 1500,
                       "messages": [{"role": "user", "content": prompt}]}).encode()
    hdr = {"Authorization": f"Bearer {key}", "Content-Type": "application/json"}
    hdr.update(extra_headers or {})
    req = u.Request(url, data=body, headers=hdr)
    with u.build_opener(u.ProxyHandler({})).open(req, timeout=timeout) as r:
        return json.loads(r.read())["choices"][0]["message"]["content"]


def judge(name: str, url: str, key: str, model: str, xt: str, yt: str,
          extra_headers: dict | None = None) -> dict | None:
    prompt = (RUBRIC + "\n===== 摘录 X =====\n" + xt + "\n\n===== 摘录 Y =====\n" + yt
              + "\n\n请输出 JSON。")
    try:
        raw = chat(url, key, model, prompt, extra_headers)
        m = re.search(r"\{.*\}", raw, re.S)
        if not m:
            return None
        return json.loads(m.group())
    except Exception as e:  # noqa: BLE001
        print(f"  [{name}] 失败: {e}")
        return None


def judge_rev(name, url, key, model, xt, yt, extra_headers=None):
    """Y 在前 X 在后 — 裁判 JSON 键仍按 X/Y 语义, 由调用方换序喂文本。"""
    prompt = (RUBRIC + "\n===== 摘录 Y =====\n" + yt + "\n\n===== 摘录 X =====\n" + xt
              + "\n\n（注意：先读到的标签是 Y，后读到的是 X，评分键仍按 X/Y 归属各自文本）\n请输出 JSON。")
    try:
        raw = chat(url, key, model, prompt, extra_headers)
        m = re.search(r"\{.*\}", raw, re.S)
        return json.loads(m.group()) if m else None
    except Exception as e:  # noqa: BLE001
        print(f"  [{name}-rev] 失败: {e}")
        return None


DIMS = ["decision_usefulness", "evidence_credibility", "analytical_depth",
        "honesty_about_limits", "professional_accuracy"]


def main() -> int:
    xt = (D / "X.md").read_text(encoding="utf-8")
    yt = (D / "Y.md").read_text(encoding="utf-8")
    env = _env_keys()
    zk = _zhipu_keys()
    panel = []
    if env.get("DEEPSEEK_API_KEY"):
        panel.append(("deepseek", "https://api.deepseek.com/chat/completions",
                      env["DEEPSEEK_API_KEY"], "deepseek-chat", None))
    if env.get("SILICONFLOW_API_KEY"):
        panel.append(("qwen-sf", "https://api.siliconflow.cn/v1/chat/completions",
                      env["SILICONFLOW_API_KEY"], "Qwen/Qwen3-32B", None))
    if zk:
        panel.append(("glm-a1", "https://open.bigmodel.cn/api/paas/v4/chat/completions",
                      zk[0], "glm-4-flash", None))
        if len(zk) > 1:
            panel.append(("glm-a2", "https://open.bigmodel.cn/api/paas/v4/chat/completions",
                          zk[1], "glm-4-flash", None))
        panel.append(("glm-46", "https://open.bigmodel.cn/api/paas/v4/chat/completions",
                      zk[0], "glm-4.6", None))

    results = []
    for name, url, key, model, eh in panel:
        for tag, fn in (("fwd", judge), ("rev", judge_rev)):
            t0 = time.time()
            r = fn(name, url, key, model, xt, yt, eh)
            print(f"[{name}/{tag}] {'ok' if r else 'FAIL'} "
                  f"winner={r.get('winner') if r else '-'} {time.time()-t0:.0f}s", flush=True)
            if r:
                results.append({"judge": name, "order": tag, **r})
            time.sleep(2)

    (D / "verdict_raw.json").write_text(
        json.dumps(results, ensure_ascii=False, indent=1), encoding="utf-8")

    # 汇总
    agg = {}
    for side in ("X", "Y"):
        agg[side] = {d: round(sum(r[side][d] for r in results) / max(1, len(results)), 2)
                     for d in DIMS}
        agg[side]["total"] = round(sum(agg[side][d] for d in DIMS), 2)
    wins = {s: sum(1 for r in results if r.get("winner") == s) for s in ("X", "Y", "tie")}
    mapping = json.loads((D / "mapping.json").read_text(encoding="utf-8"))
    blind = {"A": "PwC白皮书" if mapping["A"] == "X" else "蓝皮书4-1",
             "B": "PwC白皮书" if mapping["B"] == "X" else "蓝皮书4-1"}
    print("\n==== 汇总 (6判) ====")
    print(json.dumps({"blind_map": blind, "X_is": blind["A"] if mapping["A"] == "X" else blind["B"],
                      "Y_is": blind["B"] if mapping["B"] == "Y" else blind["A"],
                      "scores": agg, "wins": wins,
                      "reasons": [r.get("one_line", "") for r in results]}, ensure_ascii=False, indent=1))
    (D / "verdict.json").write_text(
        json.dumps({"blind_map": blind, "scores": agg, "wins": wins, "judgments": results},
                   ensure_ascii=False, indent=1), encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
