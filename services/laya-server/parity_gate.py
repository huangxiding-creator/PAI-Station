# -*- coding: utf-8 -*-
"""平价门 (LayaForge P0) — laya 零样本 vs Jev 实测基线，原措辞重放。

ADR-5 口径铁律：E1-E3 必须用原实验同款 state/questions（换措辞=换实验）。
基线侧：从 tmp/jev_exp{1,2,3}_*.jsonl 原始逐题记录重算（零记忆漂移）。
laya 侧：经 JudgmentClient(engine=laya) 全链（transport→server→agent），
与生产路径逐字节同路。

用法（AI-Station 主 Python）:
  PAI_JEV_ENGINE=laya python services/laya-server/parity_gate.py [e1|e2|e3|report]

产物: services/laya-server/parity/{e1,e2,e3}_laya.jsonl + parity_report.json
门: 每 E 头条指标 ≥ Jev-5pp → PASS（该位族可切 laya）；否则 HOLD（候微调）。
"""
from __future__ import annotations

import io
import json
import os
import sys
import time
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO / "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

# 夜训回归门用独立目录（LAYA_PARITY_DIR 覆写），零样本基线档不被污染
OUT_DIR = Path(os.environ.get("LAYA_PARITY_DIR") or
               (Path(__file__).resolve().parent / "parity"))
OUT_DIR.mkdir(parents=True, exist_ok=True)

# ---- 原措辞契约（钉死不改，与 tmp/jev_exp_run.py / jev_exp3_verify.py 逐字一致）----

INTENT_CRITERIA = {
    "project": "正在编码、开发软件、写工程文档（IDE、代码仓库、技术文档站）",
    "docs": "阅读或编写文档、笔记、知识整理（文档编辑器、笔记软件、Wiki）",
    "research": "搜索资料、阅读资讯、观看学习视频、学术调研",
    "meeting": "参加线上会议或观看直播（会议软件、会议窗口标题）",
    "leisure": "娱乐休闲（视频、游戏、音乐、购物、社交浏览）",
    "chat": "即时通讯聊天（微信、QQ、钉钉等聊天工具）",
    "thinking": "短暂思考或发呆（无明确应用焦点或白板/计算器等轻工具）",
    "system": "系统操作（文件管理、设置、终端命令、安装软件）",
    "idle": "离开电脑或长时间无操作",
    "unknown": "无法判断",
}
INTENT_QUESTION = {
    "type": "choice",
    "instructions": "根据窗口信息判断该用户此刻的电脑使用意图属于哪一类",
    "criteria": INTENT_CRITERIA,
}
MEETING_GOLDEN = [
    ("好，咱们开始周会吧，先过一下上周的进度。", "chatter", "golden"),
    ("上周西峰山水库的初步设计方案评审通过了，大家辛苦。", "chatter", "golden"),
    ("小王，会议纪要今天下班前整理好发给大家。", "todo", "golden"),
    ("这个周末天气预报不错，可以去钓钓鱼。", "chatter", "golden"),
    ("对了，请帮我调研一下腾讯办公助手的定价策略，明天上午要结果。", "todo", "golden"),
    ("现在人工成本涨得厉害，预算得再压一压。", "chatter", "golden"),
    ("季度总结别忘了，本月25号之前提交。", "todo", "golden"),
    ("中午想吃火锅，谁一起？", "chatter", "golden"),
    ("那就这样，散会。", "chatter", "golden"),
]
ADVERSARIAL = [
    ("小王，会议纪要今天下班前得弄完给大家。", "todo", "adv"),
    ("李工，下周三的评审材料您那边出一下。", "todo", "adv"),
    ("安全培训的签到表明天上午收齐。", "todo", "adv"),
    ("这版图纸打印三份，下午带到工地。", "todo", "adv"),
    ("签证资料这周内报给商务组。", "todo", "adv"),
    ("初设概算的复核意见，两天内回复设计院。", "todo", "adv"),
    ("下周的值班班表排好之后知会一声。", "todo", "adv"),
    ("供应商报价对比周五前给到大家。", "todo", "adv"),
    ("我记得去年团建也是在这家店吃的火锅。", "chatter", "adv"),
    ("这部电影需要静下心来看，值得二刷。", "chatter", "adv"),
    ("他上次整理车库的时候翻出不少老照片。", "chatter", "adv"),
    ("周末的演唱会门票确认过了，座位不错。", "chatter", "adv"),
    ("让我意外的是，这次评审居然一次就过了。", "chatter", "adv"),
    ("那家店的奶茶要排队四十分钟，太夸张了。", "chatter", "adv"),
    ("钓鱼记得带伞啊，山边天气说变就变。", "borderline", "adv"),
]
TASKREQ_QUESTION = {
    "type": "noul",
    "instructions": "这句话是否是在向某人指派或请求完成一项具体任务或待办事项？",
    "criteria": {
        "true": "有明确的受托人和要完成的具体事项，常含时间要求；叙述过去、闲聊、抒发观点不算",
        "false": "闲聊、观点、过去的叙述、或对未来的一般性建议，不构成可记录的待办",
    },
}
Q_HIT = {
    "type": "noul",
    "instructions": "以下检索片段中是否包含能直接回答问题的内容？",
    "criteria": {
        "true": "某片段含答案所陈述的事实本身（同义表述、数字写法变体、措辞改写也算）",
        "false": "片段只是与问题主题相关，但不含答案事实本身",
    },
}
CITATION_HITS = {3, 10, 54, 68, 96}   # judge_v2 引文判 ground truth
K = 8
SNIPPET_CHARS = 260
HIT_TH = 0.5


def _client():
    from paistation.judgment.client import JudgmentClient
    c = JudgmentClient()
    if c.engine != "laya":
        raise SystemExit("必须 PAI_JEV_ENGINE=laya 启动（防误打付费端）")
    if not c.enabled:
        raise SystemExit("laya 引擎未启用（服务挂了或开关关）")
    return c


def _load_jsonl(p: Path) -> list[dict]:
    return [json.loads(ln) for ln in io.open(p, encoding="utf-8") if ln.strip()]


def _resume(out: Path, key: str) -> set:
    done = set()
    if out.is_file():
        for r in _load_jsonl(out):
            try:
                done.add(r[key])
            except KeyError:
                pass
    return done


# ---------------- E1: intent Choice ----------------

def run_e1() -> None:
    c = _client()
    rows = [r for r in _load_jsonl(REPO / "tests" / "fixtures" / "intent_golden.jsonl")
            if r["kind"] == "l1"]
    out = OUT_DIR / "e1_laya.jsonl"
    done = _resume(out, "name")
    todo = [r for r in rows if r["name"] not in done]
    print(f"E1: {len(rows)} total, {len(done)} done, {len(todo)} to run", flush=True)
    with io.open(out, "a", encoding="utf-8") as fh:
        for i, r in enumerate(todo):
            t0 = time.perf_counter()
            got = c.ask_choice(r["sample"], INTENT_QUESTION["instructions"],
                               INTENT_CRITERIA)
            rec = {"name": r["name"], "expect": r["expect"],
                   "latency_s": round(time.perf_counter() - t0, 3),
                   "choice": None, "confidence": None, "probabilities": None}
            if got:
                choice, meta = got
                rec.update(choice=choice, confidence=meta.get("confidence"),
                           probabilities=meta.get("probabilities"))
            fh.write(json.dumps(rec, ensure_ascii=False) + "\n")
            fh.flush()
            if (i + 1) % 25 == 0:
                print(f"  ..{i+1}/{len(todo)}", flush=True)


def _e1_metrics(rows: list[dict]) -> dict:
    n = len(rows)
    ok = [r for r in rows if r.get("choice") == r["expect"]]
    wrong = [r for r in rows if r.get("choice") is not None
             and r["choice"] != r["expect"]]
    lat = sorted(r["latency_s"] for r in rows)
    conf_ok = [r["confidence"] for r in ok if r.get("confidence") is not None]
    conf_no = [r["confidence"] for r in wrong if r.get("confidence") is not None]
    return {
        "n": n, "answered": sum(r.get("choice") is not None for r in rows),
        "acc": len(ok) / n if n else 0.0,
        "conf_correct": sum(conf_ok) / len(conf_ok) if conf_ok else None,
        "conf_wrong": sum(conf_no) / len(conf_no) if conf_no else None,
        "latency_p50_s": lat[len(lat) // 2] if lat else None,
    }


# ---------------- E2: 任务请求 Noul ----------------

def run_e2() -> None:
    c = _client()
    out = OUT_DIR / "e2_laya.jsonl"
    done = _resume(out, "text")
    with io.open(out, "a", encoding="utf-8") as fh:
        for text, label, origin in MEETING_GOLDEN + ADVERSARIAL:
            if text in done:
                continue
            t0 = time.perf_counter()
            noul = c.ask_noul(
                {"text": text, "context": "线上会议语音转写中的一句话",
                 "时间": "2026-09-13 09:10"},
                TASKREQ_QUESTION["instructions"], TASKREQ_QUESTION["criteria"])
            fh.write(json.dumps({"text": text, "label": label, "origin": origin,
                                 "noul": noul,
                                 "latency_s": round(time.perf_counter() - t0, 3)},
                                ensure_ascii=False) + "\n")
            fh.flush()


def _e2_metrics(rows: list[dict]) -> dict:
    head = [r for r in rows if r["label"] in ("todo", "chatter")]
    todos = [r for r in head if r["label"] == "todo"]
    chats = [r for r in head if r["label"] == "chatter"]
    out = {"n": len(head), "todo": len(todos), "chatter": len(chats)}
    for th in (0.5, 0.6, 0.7):
        out[f"recall@{th}"] = (sum((r.get("noul", r.get("jev_noul")) or 0) >= th
                                   for r in todos)
                               / len(todos)) if todos else None
        out[f"fp@{th}"] = (sum((r.get("noul", r.get("jev_noul")) or 0) >= th
                               for r in chats)
                           / len(chats)) if chats else None
    return out


# ---------------- E3: 检索命中复核 Noul ----------------

def run_e3() -> None:
    c = _client()
    from paistation.cx.dossier import load_dossiers
    from paistation.cx.golden import extract_tokens, is_hit
    from paistation.cx.semantic import SemanticIndex, hybrid_route
    from paistation.sense.localfiles.embedder import make_ollama_embedder
    embedder = make_ollama_embedder()
    if embedder is None:
        # 口径铁律：embedder 缺席=检索漂移=实验作废，宁可硬失败
        raise SystemExit("ollama embedder 不可用——E3 重放必须与原实验同款检索")
    questions = _load_jsonl(REPO / "SELF_PROFILE" / "golden_set" / "golden_100_v1.jsonl")
    dossier = load_dossiers(REPO / "SELF_PROFILE")
    sem = SemanticIndex.build(dossier.sections, embedder,
                              REPO / "data" / "cx" / "dossier_vecs.npz")
    out = OUT_DIR / "e3_laya.jsonl"
    done = _resume(out, "id")
    with io.open(out, "a", encoding="utf-8") as fh:
        for q in questions:
            if q["id"] in done:
                continue
            toks = extract_tokens(q["a"])
            dhits = hybrid_route(dossier, sem, embedder, q["q"], k=K)
            lexical = is_hit(dhits, toks, norm=True)
            snippets = []
            for h in (dhits or []):
                t = (h.text or "").strip().replace("\n", " ")
                if t:
                    snippets.append(t[:SNIPPET_CHARS])
                if len(snippets) >= K:
                    break
            state = {"问题": q["q"], "标准答案": q["a"], "检索片段top8": snippets}
            t0 = time.monotonic()
            ans = c.ask(state, {"hit": Q_HIT})
            noul = None
            if isinstance(ans, dict):
                try:
                    noul = float(ans["hit"]["noul"])
                except (KeyError, TypeError, ValueError):
                    noul = None
            fh.write(json.dumps({"id": q["id"], "dim": q["dim"],
                                 "diff": q["diff"], "q": q["q"], "a": q["a"],
                                 "lexical": lexical, "noul": noul,
                                 "n_snippets": len(snippets),
                                 "latency_s": round(time.monotonic() - t0, 2)},
                                ensure_ascii=False) + "\n")
            fh.flush()
            print(f"#{q['id']:>3} lexical={int(lexical)} "
                  f"laya={noul if noul is None else round(noul, 2)}", flush=True)


def _e3_metrics(rows: list[dict]) -> dict:
    n = len(rows)
    val = lambda r: r.get("noul", r.get("jev_noul")) or 0  # noqa: E731
    laya_hit = [val(r) >= HIT_TH for r in rows]
    hits = [val(r) for r in rows if r["lexical"]]
    # 非引文判的词面 miss 行 = 疑似真空洞（分离度检验组）
    miss_non_cit = [val(r) for r in rows
                    if not r["lexical"] and r["id"] not in CITATION_HITS]
    med = lambda xs: sorted(xs)[len(xs) // 2] if xs else None   # noqa: E731
    return {
        "n": n,
        "lexical_hits": sum(r["lexical"] for r in rows),
        "laya_hits": sum(laya_hit),
        "agree_with_lexical": sum(r["lexical"] == h
                                  for r, h in zip(rows, laya_hit)) / n if n else None,
        "citation_capture": sum(1 for r in rows if r["id"] in CITATION_HITS
                                and val(r) >= HIT_TH),
        # 分离度：真命中中位 − 疑似空洞中位；≥0.1 才算有判别力
        "sep_gap": (med(hits) - med(miss_non_cit)
                    if hits and miss_non_cit else None),
    }


# ---------------- 汇总对照 ----------------

TOL = 0.05   # 头条指标容差：laya ≥ Jev - 5pp

REPORT = OUT_DIR / "parity_report.json"


def build_report() -> dict:
    e1_jev = _e1_metrics(_load_jsonl(REPO / "tmp" / "jev_exp1_intent.jsonl"))
    e1_laya = _e1_metrics(_load_jsonl(OUT_DIR / "e1_laya.jsonl"))
    e2_jev = _e2_metrics(_load_jsonl(REPO / "tmp" / "jev_exp2_taskreq.jsonl"))
    e2_laya = _e2_metrics(_load_jsonl(OUT_DIR / "e2_laya.jsonl"))
    e3_jev_raw = _load_jsonl(REPO / "tmp" / "jev_exp3_verify.jsonl")
    e3_jev = _e3_metrics([{"id": r["id"], "lexical": r["lexical"],
                           "noul": r["jev_noul"]} for r in e3_jev_raw])
    e3_laya = _e3_metrics(_load_jsonl(OUT_DIR / "e3_laya.jsonl"))

    def gate(laya_v, jev_v, higher=True):
        if laya_v is None or jev_v is None:
            return "MISSING"
        ok = laya_v >= jev_v - TOL if higher else laya_v <= jev_v + TOL
        return "PASS" if ok else "HOLD"

    report = {
        "ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "tolerance_pp": TOL * 100,
        "E1_intent_choice": {
            "jev": e1_jev, "laya": e1_laya,
            "headline": "acc",
            "verdict": gate(e1_laya.get("acc"), e1_jev.get("acc")),
        },
        "E2_taskreq_noul": {
            "jev": e2_jev, "laya": e2_laya,
            "headline": "recall@0.5 (fp@0.5 须同时 ≤ Jev+5pp)",
            "verdict": (gate(e2_laya.get("recall@0.5"), e2_jev.get("recall@0.5"))
                        if gate(e2_laya.get("fp@0.5"), e2_jev.get("fp@0.5"),
                                higher=False) == "PASS" else "HOLD"),
        },
        "E3_hit_verify_noul": {
            "jev": e3_jev, "laya": e3_laya,
            "headline": "citation_capture /5 + sep_gap≥0.1 双门（防恒真探测器）",
            "verdict": ("PASS" if (
                gate(e3_laya.get("citation_capture"),
                     e3_jev.get("citation_capture")) == "PASS"
                and (e3_laya.get("sep_gap") or 0) >= 0.1) else "HOLD"),
        },
    }
    REPORT.write_text(json.dumps(report, ensure_ascii=False, indent=1),
                      encoding="utf-8")
    print(json.dumps(report, ensure_ascii=False, indent=1))
    print(f"\n落档: {REPORT}")
    return report


if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "all"
    if cmd in ("e1", "all"):
        run_e1()
    if cmd in ("e2", "all"):
        run_e2()
    if cmd in ("e3", "all"):
        run_e3()
    if cmd in ("report", "all"):
        build_report()
