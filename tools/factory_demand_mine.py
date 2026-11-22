# -*- coding: utf-8 -*-
"""factory_demand_mine — W1 语义挖掘层 (V2, 用户哲学: 需求从用户中来回到用户中去变现).
对 factory_top10.json 候选主题的头部公众号文章, GLM 逐篇抽取:
  重难点分析 / 作者未解决的遗留问题 / 可变现研究方向 → factory_mined.json
与词频层(factory_demand.py 粗筛)互补: 词频定热度, 挖掘定方向与变现依据.
密钥: data/secrets/zhipu.secret (双key轮换, 宪法: 编队≤4并发)
用法: py -X utf8 tools/factory_demand_mine.py [--per-theme 8] [--themes 5]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
import urllib.request
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
TOP10 = REPO / "data" / "factory" / "factory_top10.json"
OUT = REPO / "data" / "factory" / "factory_mined.json"
RSS = REPO / "data" / "rss_harvest" / "articles"
MODELS = ("glm-4.7-flash", "glm-4-flash-250414", "glm-4.5-flash")


def load_keys() -> list[str]:
    keys = []
    p = REPO / "data" / "secrets" / "zhipu.secret"
    for ln in p.read_text(encoding="utf-8").splitlines():
        ln = ln.strip()
        if ln.startswith("api_key") and "=" in ln:
            keys.append(ln.split("=", 1)[1].strip())
    return keys


def glm(messages: list[dict], keys: list[str]) -> tuple[str, str]:
    """双key轮换调用, 返回 (model_used, content)."""
    last = ""
    for mi, model in enumerate(MODELS):
        for ki, key in enumerate(keys):
            payload = json.dumps({"model": model, "messages": messages,
                                  "temperature": 0.3, "max_tokens": 900},
                                 ensure_ascii=False).encode()
            req = urllib.request.Request(
                "https://open.bigmodel.cn/api/paas/v4/chat/completions", data=payload,
                headers={"Authorization": f"Bearer {key}",
                         "Content-Type": "application/json"})
            try:
                with urllib.request.urlopen(req, timeout=90) as r:
                    d = json.loads(r.read().decode())
                    content = (d.get("choices") or [{}])[0].get("message", {}).get("content", "")
                    if content:
                        return model, content
                    last = f"empty@{model}"
            except Exception as e:
                last = f"{str(e)[:60]}@{model}k{ki}"
                if "1113" in last:  # 余额耗尽 → 换模型
                    break
                if "429" in last:
                    time.sleep(8)
            time.sleep(1)
    return "", last


def head_articles(theme_kws: list[str], per: int, days: int = 3) -> list[dict]:
    """按主题词选取近N日命中密度最高的头部文章."""
    scored = []
    for d in range(days):
        day = time.strftime("%Y-%m-%d", time.localtime(time.time() - d * 86400))
        p = RSS / day
        if not p.is_dir():
            continue
        for f in p.glob("*.md"):
            try:
                t = f.read_text(encoding="utf-8", errors="replace")
            except OSError:
                continue
            head = t[:3000]
            n = sum(head.count(k) for k in theme_kws)
            if n >= 2:
                scored.append((n, f.stem[:70], head))
    scored.sort(key=lambda x: -x[0])
    return [{"title": s[1], "text": s[2]} for s in scored[:per]]


PROMPT = """你是工程研究工厂的需求挖掘员。下面是一篇工程/建工领域公众号文章（作者多为行业专家）。
请从「研究选题与变现」视角抽取三件事，严格按JSON输出（不要输出其他文字）：
{{"pain_points": ["文章分析的重难点，每条一句"], "unsolved": ["作者指出但没有解决好的遗留问题/开放难题，没有则空数组"], "direction": "一句话：值得工程企业付费了解、可做成付费研究报告/知识库的研究方向（要具体到争点/场景，不要泛主题词）", "monetization": "一句话：谁会为此付费（角色+场景）"}}
文章标题：{title}
文章正文（节选）：
{text}"""


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--per-theme", type=int, default=8)
    ap.add_argument("--themes", type=int, default=5)
    ns = ap.parse_args()
    doc = json.loads(TOP10.read_text(encoding="utf-8"))
    keys = load_keys()
    if not keys:
        print("[mine] 无zhipu key")
        return 1
    theme_kws_map = {name: kws for name, kws in [
        ("EPC工程总承包", ["EPC", "工程总承包"]), ("招投标与投标", ["招投标", "投标", "招标"]),
        ("合同与索赔", ["索赔", "签证", "变更", "合同"]), ("工程结算与造价", ["结算", "造价", "工程款", "审减"]),
        ("竣工验收与移交", ["竣工验收", "验收", "移交", "质保金"]), ("分包与劳务", ["分包", "实际施工人", "挂靠", "转包"]),
        ("安全生产", ["安全生产", "安全事故"]), ("保险与保函", ["保函", "保险", "履约担保"]),
        ("融资与投资", ["融资", "PPP", "BOT", "垫资"]), ("税务", ["增值税", "发票", "税务"]),
        ("国际工程", ["国际工程", "FIDIC", "海外工程"]), ("新能源与储能", ["储能", "光伏", "风电"]),
        ("水利水电", ["水利", "水电", "枢纽"]), ("交通基建", ["公路", "桥梁", "隧道", "铁路"]),
        ("房建与市政", ["房建", "市政", "管廊"]), ("数字化转型", ["BIM", "智慧工地", "数字化"]),
        ("司法鉴定与诉讼", ["司法鉴定", "造价鉴定", "诉讼", "仲裁"]), ("政策与法规", ["新规", "条例", "办法", "标准"]),
    ]}
    mined = []
    for row in doc.get("top", [])[:ns.themes]:
        theme = row["theme"]
        kws = theme_kws_map.get(theme, [theme[:4]])
        arts = head_articles(kws, ns.per_theme)
        print(f"[mine] {theme}: 头部文章{len(arts)}篇", flush=True)
        entry = {"theme": theme, "score_wordfreq": row.get("score"),
                 "articles": [], "mined_at": time.strftime("%Y-%m-%d %H:%M")}
        for a in arts:
            msg = [{"role": "user", "content": PROMPT.format(title=a["title"], text=a["text"][:2600])}]
            model, content = glm(msg, keys)
            if not content:
                print(f"   ✗ {a['title'][:36]} ({content[:40]})", flush=True)
                continue
            try:
                m = content[content.find("{"):content.rfind("}") + 1]
                j = json.loads(m)
            except Exception:
                j = {"raw": content[:300]}
            j["_src"] = a["title"][:60]
            j["_model"] = model
            entry["articles"].append(j)
            print(f"   ✓ {a['title'][:36]} → 方向: {str(j.get('direction'))[:50]}", flush=True)
            time.sleep(1.5)
        # 聚合: 该主题的未解难题清单 + 方向列表
        entry["unsolved_all"] = [u for art in entry["articles"] for u in (art.get("unsolved") or [])][:12]
        entry["directions"] = list(dict.fromkeys(
            str(art.get("direction")) for art in entry["articles"] if art.get("direction")))[:6]
        mined.append(entry)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps({"ts": time.strftime("%Y-%m-%d %H:%M:%S"), "themes": mined},
                              ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[mine] → {OUT}")
    for e in mined:
        print(f"\n== {e['theme']} (词频分{e['score_wordfreq']}) ==")
        for u in e["unsolved_all"][:4]:
            print("  未解:", u[:70])
        for d in e["directions"][:3]:
            print("  方向:", d[:70])
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
