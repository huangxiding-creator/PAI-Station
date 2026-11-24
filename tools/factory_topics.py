# -*- coding: utf-8 -*-
"""factory_topics — 细方向选题: 把选题单位从 20 个粗主题下沉到“具体研究方向”.

为什么需要它: 1123 实测, 粗主题粒度上 20 个里 18 个已被在架报告覆盖、1 个被工厂占住,
只剩两个不贴合的方向 — 粗主题已经做完, 工厂要继续生产必须选到细方向.

两路信号:
  A 专家文章 (公众号 rss): 逐篇抽取 重难点 / 未解难题 / 可研究方向 / 谁付费
  B 社群原话 (微信群聊洞察): 归纳出具体需求, 剔除自我推广与闲聊
然后: 归并同义方向 → 与在架 SKU 查重 → 评分排序 → factory_topics.json

评分 (0-10): 社群需求 35% + 文章关注度 30% + 未解难题 15% + 时效 20%
用法: py -X utf8 tools/factory_topics.py [--days 5] [--per-theme 8] [--top 10]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

TOOLS = Path(__file__).resolve().parent
sys.path.insert(0, str(TOOLS))
import factory_demand as fd  # noqa: E402
from factory_demand_mine import load_keys  # noqa: E402

REPO = fd.REPO
OUT = REPO / "data" / "factory" / "factory_topics.json"
MODELS = ("glm-4.7-flash", "glm-4-flash-250414", "glm-4.5-flash")
_lock = threading.Lock()
_stats = {"calls": 0, "fail": 0}
_health: dict[tuple, dict] = {}   # (模型, key序号) → {ok_ts, fails, cooldown_until}


def glm(messages: list[dict], keys: list[str], max_tokens: int = 1400) -> str:
    """调用 GLM 免费模型. 1123 实测: 同一时刻三个模型里有在限流的、有通道超时的,
    固定顺序硬试会让每次调用先白等两分钟 — 所以按健康度择优: 最近成功的先用,
    限流的歇 20 秒, 超时的按次数递增歇 30~300 秒. 失败返回空串. 不打印密钥."""
    import urllib.error
    import urllib.request
    now = time.time()
    pairs = [(m, i) for m in MODELS for i in range(len(keys))]
    pairs.sort(key=lambda p: -_health.get(p, {}).get("ok_ts", 0))
    for model, i in pairs:
        h = _health.setdefault((model, i), {})
        if h.get("cooldown_until", 0) > now:
            continue
        payload = json.dumps({"model": model, "messages": messages,
                              "temperature": 0.2, "max_tokens": max_tokens},
                             ensure_ascii=False).encode()
        req = urllib.request.Request(
            "https://open.bigmodel.cn/api/paas/v4/chat/completions", data=payload,
            headers={"Authorization": f"Bearer {keys[i]}", "Content-Type": "application/json"})
        with _lock:
            _stats["calls"] += 1
        try:
            with urllib.request.urlopen(req, timeout=40) as r:
                d = json.loads(r.read().decode())
                content = (d.get("choices") or [{}])[0].get("message", {}).get("content", "")
                if content:
                    h["ok_ts"] = time.time()
                    h["fails"] = 0
                    return content
        except urllib.error.HTTPError as e:
            if e.code == 429:                       # 限流: 这把 key 歇一会儿
                h["cooldown_until"] = time.time() + 20
            elif "1113" in read_err_body(e):        # 余额耗尽: 这把 key 长歇
                h["cooldown_until"] = time.time() + 1800
            else:
                h["cooldown_until"] = time.time() + 10
        except Exception:
            h["fails"] = h.get("fails", 0) + 1      # 超时/断连: 递增歇
            h["cooldown_until"] = time.time() + min(300, 30 * h["fails"])
    with _lock:
        _stats["fail"] += 1
    return ""


def read_err_body(e) -> str:
    try:
        return e.read().decode("utf-8", errors="replace")[:200]
    except Exception:
        return ""


def parse_json_array(text: str) -> list:
    if not text:
        return []
    for open_c, close_c in (("[", "]"), ("{", "}")):
        i, j = text.find(open_c), text.rfind(close_c)
        if i >= 0 and j > i:
            try:
                v = json.loads(text[i:j + 1])
                return v if isinstance(v, list) else [v]
            except Exception:
                continue
    return []


# ───────────── A. 专家文章: 逐篇抽取 ─────────────

ARTICLE_PROMPT = """你是工程研究选题员。下面是一篇工程/建工领域公众号文章（作者多为行业专家）。
请判断它有没有研究价值，并抽取三件事，严格按 JSON 输出，不要输出其他文字：
{{"worth": true 或 false（纯活动通知、招聘、产品广告、时政转载等为 false）,
 "pain_points": ["文章分析的重难点，每条一句，最多3条"],
 "unsolved": ["作者明确指出但没有解决好的遗留问题、开放难题、争议点；没有就是空数组，最多3条"],
 "direction": "一句话：值得做成付费研究报告或知识库的具体研究方向。必须具体到争点、规则或场景；如果这篇文章只是泛泛而谈，写空字符串",
 "who_pays": "一句话：哪类角色愿意为此付费、用在什么场景"}}
文章标题：{title}
文章正文（节选）：
{text}"""


def pick_articles(days: int, per_theme: int) -> list[dict]:
    """按粗主题各取最相关的若干篇工程类文章 (总量控制在 per_theme × 主题数)."""
    arts = fd.read_rss(days)
    by_theme: dict[str, list] = {}
    eng = ["工程", "建筑", "施工", "设计院", "总包", "承包", "造价", "监理", "招投标", "EPC", "基建", "市政"]
    for a in arts:
        head = a["title"] + " " + a["text"][:400]
        themes = fd.map_theme(a["title"] + " " + a["text"])
        if not themes or not any(k in head for k in eng):
            continue
        score = sum(head.count(k) for k in eng)
        for t in themes[:1]:
            by_theme.setdefault(t, []).append((score, a))
    out, seen = [], set()
    for t, lst in by_theme.items():
        lst.sort(key=lambda x: -x[0])
        for _, a in lst[:per_theme]:
            if a["title"] in seen:
                continue
            seen.add(a["title"])
            out.append(a)
    return out


# ───────────── B. 社群原话: 归纳需求 ─────────────

COMMUNITY_PROMPT = """下面是从工程行业微信群里摘出的从业者发言，每行一条（编号: 原话）。
请归纳其中反映的**具体需求或难题**：有人在问怎么做、求方案、求标准依据、遇到的实际问题。
剔除三类：推广自己产品或活动的宣传、招聘/证书广告、与工程业务无关的闲聊。
严格按 JSON 数组输出，不要输出其他文字，最多 12 条，按涉及的发言数从多到少：
{{"topic": "具体需求，一句话，具体到场景或问题",
 "n_msgs": 涉及的发言条数（整数）,
 "examples": ["最有代表性的原话，最多2条，尽量照抄"]}}
如果整批都没有真实需求，输出 []。

发言：
{lines}"""


def mine_community(keys: list[str]) -> list[dict]:
    group = [g for g in fd.read_group_signals() if not g["is_share"]]
    demands = []
    B = 25
    batches = [group[i:i + B] for i in range(0, len(group), B)]
    def one(batch):
        lines = "\n".join(f"{i+1}. {g['quote'][:160]}" for i, g in enumerate(batch))
        txt = glm([{"role": "user", "content": COMMUNITY_PROMPT.format(lines=lines)}], keys, 1400)
        return [x for x in parse_json_array(txt) if isinstance(x, dict) and x.get("topic")]
    with ThreadPoolExecutor(max_workers=3) as ex:
        for part in ex.map(one, batches):
            demands.extend(part)
    return demands


# ───────────── B2. 耳机洽谈录音: 客户原话需求 (1125 用户令接入) ─────────────

VIAIM_PROMPT = """下面是工程企业负责人用讯飞耳机录下的洽谈/工作对话摘要，每条一段（编号: 标题|摘要）。
请归纳其中反映的**真实业务需求或难题**：客户/合作方在要什么、承诺了什么场景落地、卡在什么条件上。
剔除三类：纯寒暄行程安排、与工程业务无关的私人内容、空洞没有具体需求的长谈。
严格按 JSON 数组输出，不要输出其他文字，最多 10 条，按业务强度从强到弱：
{{"topic": "具体需求，一句话，具体到场景或问题",
 "n_msgs": 涉及的录音条数（整数）,
 "examples": ["最有代表性的原话或摘要句，最多2条，尽量照抄"]}}
如果整批都没有真实需求，输出 []。

录音摘要：
{lines}"""


def mine_viaim(keys: list[str]) -> list[dict]:
    sig_file = REPO / "data" / "factory" / "viaim_signals.jsonl"
    if not sig_file.is_file():
        return []
    recs = []
    for ln in sig_file.read_text(encoding="utf-8", errors="replace").splitlines():
        try:
            recs.append(json.loads(ln))
        except Exception:
            pass
    if not recs:
        return []
    demands = []
    B = 6
    batches = [recs[i:i + B] for i in range(0, len(recs), B)]

    def one(batch):
        lines = chr(10).join(
            f"{i+1}. {r.get('title','无题')} | {r.get('overview','')[:220]}"
            for i, r in enumerate(batch))
        txt = glm([{"role": "user", "content": VIAIM_PROMPT.format(lines=lines)}], keys, 1400)
        return [x for x in parse_json_array(txt) if isinstance(x, dict) and x.get("topic")]

    with ThreadPoolExecutor(max_workers=2) as ex:
        for part in ex.map(one, batches):
            demands.extend(part)
    return demands


# ───────────── C. 归并 ─────────────

MERGE_PROMPT = """你是研究报告的总编辑。下面有两类材料：
【专家文章】每篇抽出的研究方向、作者没解决的难题；
【社群需求】微信群里从业者的具体需求；
【耳机洽谈】企业负责人洽谈录音里客户/合作方的真实需求（分量最重——这是客户原话）。
请把它们归并成不超过 {cap} 个互不重叠的**具体研究方向**。要求：
1. 每个方向具体到争点、规则或场景（例如“招标文件量身定制负面清单的禁止情形与合规边界”），不要“某某领域研究”这种泛标题。
2. 同义或高度相近的合并成一个；泛泛而谈、没有具体内容的条目直接丢掉。
3. 严格按 JSON 数组输出，不要输出其他文字，每项：
{{"topic": "方向名称",
 "article_dirs": 支撑该方向的专家文章条数（整数）,
 "community_msgs": 支撑该方向的社群发言条数合计（整数，没有就是0）,
 "unsolved": ["专家指出但没解决的问题，最多4条；没有就空数组"],
 "community_examples": ["社群原话举例，最多3条；没有就空数组"],
 "who_pays": "一句话：谁会为此付费、用在什么场景",
 "freshness": "new-rule"（涉及新规新政新机制）或 "evergreen"（长期存在的问题）}}

【专家文章】
{arts}

【社群需求】
{comm}

【耳机洽谈】
{viaim}"""


def run_batch(items, fn, workers=3):
    """并发跑一批. 单条出错只丢那一条并计数, 不让整批归零."""
    def safe(x):
        try:
            return fn(x)
        except Exception:
            with _lock:
                _stats["fail"] += 1
            return None
    with ThreadPoolExecutor(max_workers=workers) as ex:
        return [r for r in ex.map(safe, items) if r is not None]


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--days", type=int, default=5)
    ap.add_argument("--per-theme", type=int, default=8)
    ap.add_argument("--top", type=int, default=10)
    ns = ap.parse_args()
    keys = load_keys()
    if not keys:
        print("[topics] 没有 GLM 密钥")
        return 1
    t0 = time.time()

    # A. 专家文章 + B. 社群需求 (抽取结果缓存 24 小时: 调归并/查重时不必重跑这最慢的两步)
    cache_p = REPO / "data" / "factory" / "_topics_cache.json"
    ckey = f"{ns.days}d_{ns.per_theme}t"
    cache = {}
    if cache_p.is_file():
        try:
            cache = json.loads(cache_p.read_text(encoding="utf-8"))
        except Exception:
            cache = {}
    if ckey in cache and time.time() - cache[ckey].get("ts", 0) < 86400:
        mined, good, comm = cache[ckey]["mined"], cache[ckey]["good"], cache[ckey]["comm"]
        print(f"[topics] 复用 {int((time.time() - cache[ckey]['ts']) / 60)} 分钟前的抽取结果: "
              f"文章 {len(mined)} 篇, 社群需求 {len(comm)} 条", flush=True)
    else:
        arts = pick_articles(ns.days, ns.per_theme)
        print(f"[topics] 选出工程类专家文章 {len(arts)} 篇，逐篇抽取…", flush=True)
        def mine_one(a):
            txt = glm([{"role": "user", "content": ARTICLE_PROMPT.format(title=a["title"], text=a["text"][:2600])}],
                      keys, 900)
            d = parse_json_array(txt)
            d = d[0] if d and isinstance(d[0], dict) else {}
            return {"src": a["title"][:60], "dir": str(d.get("direction") or "").strip(),
                    "unsolved": [str(u)[:120] for u in (d.get("unsolved") or []) if u],
                    "worth": bool(d.get("worth", True))}
        mined = run_batch(arts, mine_one)
        good = [m for m in mined if m["worth"] and (m["dir"] or m["unsolved"])]
        print(f"[topics] 文章抽取: {len(good)}/{len(mined)} 篇有方向或未解题 "
              f"({time.time() - t0:.0f}s, 调用{_stats['calls']}次 失败{_stats['fail']}次)", flush=True)
        comm = mine_community(keys)
        print(f"[topics] 社群需求归纳: {len(comm)} 条 ({time.time() - t0:.0f}s)", flush=True)
        cache[ckey] = {"ts": time.time(), "mined": mined, "good": good, "comm": comm}
        cache_p.parent.mkdir(parents=True, exist_ok=True)
        cache_p.write_text(json.dumps(cache, ensure_ascii=False), encoding="utf-8")

    # C. 归并 (每批 28 条方向材料); B2 耳机洽谈 = 客户原话, 排最前分量最重 (1125 用户令)
    via = mine_viaim(keys)
    print(f"[topics] 耳机洽谈需求归纳: {len(via)} 条 ({time.time() - t0:.0f}s)", flush=True)
    lines = [f"- [洽谈×{v.get('n_msgs', 1)}] {v.get('topic', '')}" for v in via]
    lines += [f"- [文章] {m['dir']}" + (f"｜未解: {'；'.join(m['unsolved'][:2])}" if m["unsolved"] else "")
             for m in good]
    lines += [f"- [社群×{c.get('n_msgs', 1)}] {c.get('topic', '')}" for c in comm]
    batches = [lines[i:i + 28] for i in range(0, len(lines), 28)]
    print(f"[topics] 方向材料 {len(lines)} 条 → {len(batches)} 批归并…", flush=True)
    def merge_one(b):
        txt = glm([{"role": "user", "content": MERGE_PROMPT.format(cap=7, arts="\n".join(b), comm="见上方【社群】条目", viaim="见上方【洽谈】条目(客户原话, 分量最重)")}],
                  keys, 2600)
        return [x for x in parse_json_array(txt) if isinstance(x, dict) and x.get("topic")]
    merged = [x for part in run_batch(batches, merge_one) for x in part]
    print(f"[topics] 一级归并: {len(merged)} 个方向 ({time.time() - t0:.0f}s)", flush=True)

    # 二级归并: 一级是分批做的, 批与批之间还会重叠 → 再并.
    # 1123 教训: 把 50 多个方向一次丢给模型让它输出合并结果, 输出太长被截断, 返回空, 却照常往下走.
    # 所以小批做: 每批 ≤16 条并到 ≤6 个, 最后把总量不多的结果再终并一次; 每一步没得到有效结果都如实打印.
    def compact(lst):
        return [f"- {m['topic']}（文章{m.get('article_dirs', 1)} 社群{m.get('community_msgs', 0)}"
                + (f"；未解: {'；'.join(str(u) for u in (m.get('unsolved') or [])[:2])}" if m.get('unsolved') else "")
                + "）" for m in lst]

    def merge_small(items, cap):
        if len(items) <= cap:
            return list(items)
        txt = glm([{"role": "user", "content": MERGE_PROMPT.format(cap=cap, arts="\n".join(compact(items)),
                                                                    comm="已并入上方各条",
                                                                    viaim="洽谈录音需求已按[洽谈×N]标注在上方材料中, 客户原话分量最重")}], keys, 2600)
        out = [x for x in parse_json_array(txt) if isinstance(x, dict) and x.get("topic")]
        return out if len(out) >= max(3, cap // 2) else []       # 返回太少 = 输出被截断, 当作失败

    if len(merged) > 12:
        chunks = [merged[i:i + 16] for i in range(0, len(merged), 16)]
        lvl2 = [x for part in run_batch(chunks, lambda ch: merge_small(ch, 6)) for x in part]
        print(f"[topics] 二级归并·分批: {len(chunks)} 批 {len(merged)} → {len(lvl2)} 个"
              + ("" if 4 <= len(lvl2) < len(merged) else "  (没有得到有效结果, 保留一级结果)"), flush=True)
        if 4 <= len(lvl2) < len(merged):
            merged = lvl2
            if len(merged) > 12:
                lvl3 = merge_small(merged, 10)
                print(f"[topics] 二级归并·终并: {len(lvl2)} → {len(lvl3)} 个"
                      + ("" if 5 <= len(lvl3) <= 14 else "  (没有得到有效结果, 保留分批结果)"), flush=True)
                if 5 <= len(lvl3) <= 14:
                    merged = lvl3
    print("[topics] 归并后 %d 个方向 (%ds)" % (len(merged), time.time() - t0), flush=True)

    # D. 与在架 SKU / 工厂已占主题 查重 — 两道: 模型对照在架报告逐条判断, 再加字符串片段兜底
    d = json.loads(fd.REPORTS.read_text(encoding="utf-8"))
    skus = [(r.get("sku", ""), str(r.get("title", ""))) for r in d.get("reports", [])]
    taken = fd.taken_themes()
    taken_titles = [f"（研究工厂已产）{h.get('theme', '')}" for h in taken]
    model_overlap: dict[str, str] = {}
    dedup_missing = 0
    shelf = "\n".join(f"{i+1}. {t}" for i, (_, t) in enumerate(skus)) or "（无）"
    # 判重也小批做 (每批 10 个候选): 一次丢 50 多个候选同样会被截断 (1123 实测返回 0 条)
    for ci in range(0, len(merged), 10):
        chunk = merged[ci:ci + 10]
        cand = "\n".join(f"{j+1}. {m['topic']}" for j, m in enumerate(chunk))
        dup_prompt = (
            "下面是一份“已经出版、正在售卖的研究报告清单”（在架报告），以及一份“候选研究方向清单”。\n"
            "请逐条判断：每个候选方向，是否已经有一份在架报告实质覆盖了同一个题目"
            "（读者买了在架那份就不需要再买这个方向的另一本）。角度明显不同的不算重复。\n"
            "严格按 JSON 数组输出，不要输出其他文字，候选有几条就输出几条，顺序不变：\n"
            "{{\"i\": 候选序号, \"dup\": true 或 false, \"sku\": \"重复的在架报告序号（数字字符串），不重复则为空字符串\"}}\n\n"
            "【在架报告】\n" + shelf + "\n\n【候选研究方向】\n" + cand)
        res = [x for x in parse_json_array(glm([{"role": "user", "content": dup_prompt}], keys, 1800))
               if isinstance(x, dict) and "i" in x]
        dedup_missing += len(chunk) - min(len(chunk), len(res))
        for x in res:
            try:
                if x.get("dup") and 1 <= int(x["i"]) <= len(chunk):
                    no = str(x.get("sku") or "")
                    name = skus[int(no) - 1][0] if no.isdigit() and 1 <= int(no) <= len(skus) else "在架报告"
                    model_overlap[chunk[int(x["i"]) - 1]["topic"]] = name
            except Exception:
                continue
    print(f"[topics] 模型判重: {len(model_overlap)} 个方向与在架报告重复"
          + (f"; 有 {dedup_missing} 个候选没拿到判重结论" if dedup_missing else ""), flush=True)

    def norm(s: str) -> str:
        return re.sub(r"[《》（）()·、，,：:“”\"｜|\sA-Za-z0-9\-—+]", "", str(s))

    def frag_overlap(topic: str) -> str:
        nt = norm(topic)
        for sku, t in skus:
            core = re.sub(r"实战研究报告|研究报告|全景洞察报告|知识库|怎么干|实务|指南|版", "", norm(t))
            for i in range(0, max(1, len(core) - 5)):
                frag = core[i:i + 6]
                if len(frag) == 6 and frag in nt:
                    return sku
        return ""

    # E. 评分
    mx_art = max(1, max(int(m.get("article_dirs") or 0) for m in merged))
    mx_com = max(1, max(int(m.get("community_msgs") or 0) for m in merged))
    rows = []
    for m in merged:
        a_n, c_n = int(m.get("article_dirs") or 0), int(m.get("community_msgs") or 0)
        uns = len(m.get("unsolved") or [])
        fresh = 1.0 if str(m.get("freshness")) == "new-rule" else 0.4
        score = 10 * (0.35 * min(1, c_n / mx_com) + 0.30 * min(1, a_n / mx_art)
                      + 0.15 * min(1, uns / 4) + 0.20 * fresh)
        ov = model_overlap.get(m["topic"]) or frag_overlap(m["topic"])
        rows.append({"topic": m["topic"], "score": round(score, 2),
                     "articles": a_n, "community_msgs": c_n, "unsolved": m.get("unsolved") or [],
                     "community_examples": m.get("community_examples") or [],
                     "who_pays": m.get("who_pays", ""), "freshness": m.get("freshness", ""),
                     "overlaps_sku": ov})
    rows.sort(key=lambda x: -x["score"])
    free = [r for r in rows if not r["overlaps_sku"]]
    OUT.parent.mkdir(parents=True, exist_ok=True)
    doc = {"ts": time.strftime("%Y-%m-%d %H:%M:%S"), "days": ns.days,
           "inputs": {"articles_mined": len(mined), "articles_useful": len(good),
                      "community_demands": len(comm), "directions_merged": len(merged),
                      "glm_calls": _stats["calls"], "glm_fail": _stats["fail"],
                      "funnel_events": fd.read_sales_signal()["n_events"],
                      "dedup_mode": "model+fragment" if model_overlap else "fragment-only(模型判重未返回)"},
           "caveats": [
               "方向与未解难题由免费模型从文章节选里归纳, 未经人工逐条核对",
               "社群需求数来自微信群聊洞察台账, 其中混有转发文章标题与推广语, 未经清洗",
               "评分只反映近期信号多寡, 不代表资料是否拿得到、做不做得出来 — 选定后要先做调研侦察",
           ],
           "buyer_feedback": sorted(fd.read_buyer_feedback(), key=lambda x: -x["score"])[:20],
           "top": free[:ns.top], "overlapping": [r for r in rows if r["overlaps_sku"]][:40]}
    OUT.write_text(json.dumps(doc, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"\n[topics] 细方向 {len(rows)} 个 → 与在架不重复 {len(free)} 个 (重复 {len(rows) - len(free)} 个) "
          f"→ 前 {len(free[:ns.top])} 名写入 {OUT}")
    for i, r in enumerate(free[:ns.top], 1):
        print(f"  {i:2d}. [{r['score']:4.2f}] {r['topic'][:56]}")
        print(f"        文章{r['articles']} 社群{r['community_msgs']} {r['freshness']} | 付费方: {str(r['who_pays'])[:46]}")
        if r["unsolved"]:
            print(f"        未解: {str(r['unsolved'][0])[:66]}")
    print("  —— 与在架重复而被剔除的高分方向 ——")
    for r in [r for r in rows if r["overlaps_sku"]][:8]:
        print(f"       [{r['score']:4.2f}] {r['topic'][:44]}  ≈ {r['overlaps_sku']}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
