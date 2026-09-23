# -*- coding: utf-8 -*-
"""P2 扩标腿：GLM 免费链引导式生成 → v2 训练弹药（338 → 1k+）。

诚实标注铁律（与 build_dataset 同口径）：
  E1/E2 标签 = 生成条件（引导式生成，非模型自判——规避循环标注）；
  E3 正例 = 生成后过真实 hybrid_route 检索，词面命中才收（否则弃，不臆造）；
  E3 幻觉负例 = 答案确不在库（生成后词面反查，误中真库即弃）。
输出: finetune/augment/aug_samples.jsonl —— {src,state,questions,gold} 与
  build_dataset.collect_pairs 同构，v2 合并零转换。
断点续跑: 追加式 jsonl + key 去重，重跑只补缺口。
用法（主 Python311，需 paistation 依赖）:
  python services/laya-server/finetune/augment_label.py smoke   # 每腿小配额
  python services/laya-server/finetune/augment_label.py e1|e2|full
注意: E3 腿要 ollama embedder（占 GPU）——训练占卡期间只跑 e1/e2。
"""
from __future__ import annotations

import io
import json
import os
import random
import sys
import time
from pathlib import Path

SVC = Path(__file__).resolve().parents[1]
REPO = SVC.parents[1]
sys.path.insert(0, str(SVC))                    # parity_gate 同目录（措辞钉死）
sys.path.insert(0, str(REPO / "src"))           # paistation
from parity_gate import (  # noqa: E402
    ADVERSARIAL, INTENT_CRITERIA, INTENT_QUESTION, K, MEETING_GOLDEN,
    Q_HIT, SNIPPET_CHARS, TASKREQ_QUESTION,
)

FT = SVC / "finetune"
AUG = FT / "augment"
OUT = AUG / "aug_samples.jsonl"
SEED = 43
CALL_GAP_S = 1.0            # 调用间隔（GLM 客户端内建 429 pacer 之上再加礼让）
BATCH = 8                   # 每次调用生成样本数

# full 配额（smoke = 每腿 8/8/5/5 缩样）
QUOTA_E1_PER_CLASS = {"project": 14, "docs": 30, "research": 30, "leisure": 33,
                      "chat": 34, "thinking": 34, "meeting": 38, "system": 39,
                      "idle": 42, "unknown": 44}   # 补至每类 ~50
QUOTA_E2 = {"todo": 100, "chatter": 100}
QUOTA_E3_POS = 150
QUOTA_E3_NEG = 150
QUOTA_E3NEG_EXTRA = 60       # 错配负例增量（无 GLM，本地重配对）


def _client():
    from paistation import config
    from paistation.llm.zhipu_client import ZhipuClient
    ini = os.environ.get("PAI_INI") or str(REPO / "config" / "pai.ini")
    cfg = config.load(ini)
    return ZhipuClient(config.resolve_api_keys(cfg), config.free_chain(cfg))


def _load_jsonl(p: Path) -> list[dict]:
    return [json.loads(ln) for ln in io.open(p, encoding="utf-8") if ln.strip()]


def _done_keys() -> set:
    """已落样本去重键（断点续跑）。"""
    if not OUT.is_file():
        return set()
    keys = set()
    for r in _load_jsonl(OUT):
        k = r.get("_dedup")
        if k:
            keys.add(k)
    return keys


def _write(rows: list[dict]) -> None:
    AUG.mkdir(parents=True, exist_ok=True)
    with io.open(OUT, "a", encoding="utf-8") as fh:
        for r in rows:
            fh.write(json.dumps(r, ensure_ascii=False) + "\n")
            fh.flush()


def _gen(client, system: str, user: str) -> list | dict:
    """GLM json_mode 调用 + 鲁棒提取（失败抛，腿级容错在外层）。"""
    from paistation.llm.zhipu_client import extract_json
    text = client.chat(system, user, json_mode=True, temperature=0.8)
    return extract_json(text)


# ---------------- E1: 窗口意图 choice ----------------

E1_SYSTEM = ("你是 Windows 窗口活动模拟器。只输出 JSON，格式 "
             '{"samples": [{"process": str, "title": str, "domain": str, '
             '"idle_s": int}, ...]}。process 是真实可执行文件名（如 chrome.exe），'
             "title 是逼真的窗口标题（中文场景为主，混合英文软件），domain 仅浏览器"
             "时有值否则空串，idle_s 通常 0（idle 类除外）。不要解释。")


def run_e1(client, smoke: bool = False) -> int:
    rng = random.Random(SEED)
    fixture = [r for r in _load_jsonl(REPO / "tests" / "fixtures"
                                      / "intent_golden.jsonl")
               if r["kind"] == "l1"]
    done = _done_keys()
    total = 0
    for cls, quota in QUOTA_E1_PER_CLASS.items():
        n = 8 if smoke else quota
        made = 0
        seen = {(r["sample"]["process"], r["sample"]["title"])
                for r in fixture if r["expect"] == cls}
        rounds = 0
        while made < n and rounds < (n // BATCH + 3):
            rounds += 1
            shots = rng.sample([r for r in fixture if r["expect"] == cls],
                               k=min(3, sum(1 for r in fixture
                                            if r["expect"] == cls)))
            few = json.dumps([r["sample"] for r in shots], ensure_ascii=False)
            user = (f"意图类别「{cls}」的定义：{INTENT_CRITERIA[cls]}\n"
                    f"以下是该类别的真实样本：{few}\n"
                    f"再生成 {min(BATCH, n - made)} 个**不重复**的同类别新样本，"
                    f"场景尽量多样（不同软件/网站/标题措辞）。")
            try:
                data = _gen(client, E1_SYSTEM, user)
            except Exception as e:                       # noqa: BLE001
                print(f"  [E1 {cls}] 生成失败跳过一轮: {e}", flush=True)
                time.sleep(CALL_GAP_S)
                continue
            rows = []
            for s in (data.get("samples") or [])[:BATCH]:
                try:
                    proc, title = str(s["process"]).strip(), str(s["title"]).strip()
                    dom = str(s.get("domain", "")).strip()
                    idle = int(s.get("idle_s", 0))
                except (KeyError, TypeError, ValueError):
                    continue
                key = (proc, title)
                if not proc or not title or key in seen:
                    continue
                seen.add(key)
                dedup = f"e1|{proc}|{title}|{dom}"
                if dedup in done:
                    continue
                rows.append({"src": "E1aug", "state": {
                    "process": proc, "title": title, "domain": dom,
                    "idle_s": idle},
                    "questions": {"intent": INTENT_QUESTION},
                    "gold": {"intent": {"choice": cls}},
                    "_dedup": dedup})
            made += len(rows)
            total += len(rows)
            _write(rows)
            print(f"  [E1 {cls}] {made}/{n}", flush=True)
            time.sleep(CALL_GAP_S)
    return total


# ---------------- E2: 任务请求 noul ----------------

E2_SYSTEM = ("你是线上会议语音转写模拟器。只输出 JSON，格式 "
             '{"samples": ["句子", ...]}。句子要像真实会议口语文转写，'
             "（中文，自然、有行业感：工程建设/设计院/办公室场景为主）。不要解释。")


def run_e2(client, smoke: bool = False) -> int:
    done = _done_keys()
    total = 0
    for label, quota in QUOTA_E2.items():
        n = 8 if smoke else quota
        want = ("向某人指派或请求完成一项具体任务/待办（常有受托人+具体事项+时间要求）"
                if label == "todo" else
                "闲聊/观点/过去叙述/一般性建议——绝不构成可记录待办")
        crit = (f"true: {TASKREQ_QUESTION['criteria']['true']}\n"
                f"false: {TASKREQ_QUESTION['criteria']['false']}")
        few = json.dumps([t for t, lb, _ in (MEETING_GOLDEN + ADVERSARIAL)
                          if lb == label][:6], ensure_ascii=False)
        made, rounds = 0, 0
        while made < n and rounds < (n // BATCH + 3):
            rounds += 1
            user = (f"判定标准——{crit}\n目标：生成属于「{'true' if label == 'todo' else 'false'}」"
                    f"的句子（{want}）。\n同标签真实例：{few}\n"
                    f"再生成 {min(BATCH, n - made)} 个不重复的新句子，措辞多样。")
            try:
                data = _gen(client, E2_SYSTEM, user)
            except Exception as e:                       # noqa: BLE001
                print(f"  [E2 {label}] 生成失败跳过一轮: {e}", flush=True)
                time.sleep(CALL_GAP_S)
                continue
            rows = []
            for s in (data.get("samples") or [])[:BATCH]:
                text = str(s).strip() if isinstance(s, str) else ""
                if not text or len(text) > 80:
                    continue
                dedup = f"e2|{label}|{text}"
                if dedup in done:
                    continue
                done.add(dedup)
                rows.append({
                    "src": "E2aug",
                    "state": {"text": text, "context": "线上会议语音转写中的一句话",
                              "时间": "2026-09-13 09:10"},
                    "questions": {"is_task_request": TASKREQ_QUESTION},
                    "gold": {"is_task_request": {"noul": 0.95 if label == "todo"
                                                 else 0.05}},
                    "_dedup": dedup})
            made += len(rows)
            total += len(rows)
            _write(rows)
            print(f"  [E2 {label}] {made}/{n}", flush=True)
            time.sleep(CALL_GAP_S)
    return total


# ---------------- E3: 命中复核 noul（需 embedder，GPU 空窗跑） ----------------

E3_SYSTEM = ("你是知识库问答对生成器。只输出 JSON，格式 "
             '{"pairs": [{"q": str, "a": str}, ...]}。q 是中文自然问题，'
             "a 是**直接摘自所给资料原文事实**的简短答案（数字/专名保持原样）。"
             "不要解释。")


def _retrieval():
    from paistation.cx.dossier import load_dossiers
    from paistation.cx.semantic import SemanticIndex
    from paistation.sense.localfiles.embedder import make_ollama_embedder
    embedder = make_ollama_embedder()
    if embedder is None:
        raise SystemExit("ollama embedder 不可用——E3 腿必须与原实验同款检索")
    dossier = load_dossiers(REPO / "SELF_PROFILE")
    sem = SemanticIndex.build(dossier.sections, embedder,
                              REPO / "data" / "cx" / "dossier_vecs.npz")
    return dossier, sem, embedder


def _snippets(dossier, sem, embedder, q: str) -> list[str]:
    from paistation.cx.semantic import hybrid_route
    dhits = hybrid_route(dossier, sem, embedder, q, k=K)
    out = []
    for h in (dhits or []):
        t = (h.text or "").strip().replace("\n", " ")
        if t:
            out.append(t[:SNIPPET_CHARS])
        if len(out) >= K:
            break
    return out


def run_e3(client, smoke: bool = False) -> int:
    """正例（库内事实+词面命中才收）+ 幻觉负例（库外事实+词面反查不中才收）。"""
    from paistation.cx.golden import extract_tokens, is_hit
    dossier, sem, embedder = _retrieval()
    done = _done_keys()
    sections = [s for s in dossier.sections if (s.text or "").strip()]
    rng = random.Random(SEED)
    rng.shuffle(sections)
    total = 0
    for mode, quota in (("pos", 8 if smoke else QUOTA_E3_POS),
                        ("neg", 8 if smoke else QUOTA_E3_NEG)):
        made, i = 0, 0
        while made < quota and i < len(sections) * 2:
            i += 1
            sec = sections[i % len(sections)]
            if mode == "pos":
                user = ("根据以下资料生成 5 个问答对（答案必须是资料中明确陈述的"
                        f"事实）：\n{(sec.text or '')[:1500]}")
            else:
                other = sections[(i + 7) % len(sections)]
                user = ("以下是背景资料（仅供风格参考）：\n"
                        f"{(other.text or '')[:800]}\n"
                        "生成 5 个问答对，要求：问题像在问这个知识库里的东西，"
                        "但**答案事实是编造的**（库中不存在、看起来却可信，"
                        "如不存在的数字/日期/名称/结论）。")
            try:
                data = _gen(client, E3_SYSTEM, user)
            except Exception as e:                       # noqa: BLE001
                print(f"  [E3 {mode}] 生成失败跳过: {e}", flush=True)
                time.sleep(CALL_GAP_S)
                continue
            rows = []
            for p in (data.get("pairs") or [])[:5]:
                q, a = str(p.get("q", "")).strip(), str(p.get("a", "")).strip()
                if not q or not a:
                    continue
                dedup = f"e3{mode}|{q}"
                if dedup in done:
                    continue
                snips = _snippets(dossier, sem, embedder, q)
                if len(snips) < 4:
                    continue                    # 检索太弱=分布外，不训
                hit = is_hit(snips, extract_tokens(a), norm=True)
                if mode == "pos" and not hit:
                    continue                    # 词面不命中=标签不确定，弃
                if mode == "neg" and hit:
                    continue                    # 误中真库，弃
                rows.append({
                    "src": f"E3{mode}aug",
                    "state": {"问题": q, "标准答案": a, "检索片段top8": snips},
                    "questions": {"hit": Q_HIT},
                    "gold": {"hit": {"noul": 0.95 if mode == "pos" else 0.05}},
                    "_dedup": dedup})
            done.update(r["_dedup"] for r in rows)
            made += len(rows)
            total += len(rows)
            _write(rows)
            print(f"  [E3 {mode}] {made}/{quota}", flush=True)
            time.sleep(CALL_GAP_S)
    return total


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    cmd = sys.argv[1] if len(sys.argv) > 1 else "full"
    smoke = cmd == "smoke"
    client = _client()
    t0 = time.time()
    counts = {}
    if cmd in ("e1", "full", "smoke"):
        counts["e1"] = run_e1(client, smoke)
    if cmd in ("e2", "full", "smoke"):
        counts["e2"] = run_e2(client, smoke)
    if cmd in ("e3", "full"):                   # smoke 不碰 e3（GPU 占用）
        counts["e3"] = run_e3(client, smoke)
    summary = {"cmd": cmd, "new_samples": sum(counts.values()),
               "by_leg": counts, "seconds": round(time.time() - t0, 1),
               "out": str(OUT)}
    print(json.dumps(summary, ensure_ascii=False, indent=1))
    (AUG / "augment_summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=1), encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
