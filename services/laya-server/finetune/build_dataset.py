# -*- coding: utf-8 -*-
"""P2 数据工厂：项目自有中文标注 → laya 训练 items（notebook cell-6 同构）。

源（全部已验证标注，零臆造）：
  E1 意图 choice 162  tests/fixtures/intent_golden.jsonl kind=l1（expect 标签）
  E2 任务 noul 24     MEETING_GOLDEN+ADVERSARIAL（todo/chatter 标签）
  E3 命中 noul 100    golden_100 + hybrid_route 检索重放（词面/引文判口径）
  E3 错配负例 ~60     golden_100 两两错配（A 的问题 × B 的检索片段=必无答案）
  fixtures 36         _quarantine/laya-eval/fixtures_laya.py（构造式带标）

产出: finetune/train_items.pt / heldout_items.pt / dataset_manifest.json
纪律: 问句措辞与平价门逐字一致（钉死）；15% 按 E 分层留出（#186 held-out 温度）。
用法: <laya-server>/venv/Scripts/python.exe finetune/build_dataset.py
"""
from __future__ import annotations

import io
import json
import random
import sys
from pathlib import Path

import torch

SVC = Path(__file__).resolve().parents[1]
REPO = SVC.parents[1]
sys.path.insert(0, str(SVC))                                 # parity_gate 同目录
from parity_gate import (  # noqa: E402
    ADVERSARIAL, CITATION_HITS, INTENT_CRITERIA, INTENT_QUESTION,
    K, MEETING_GOLDEN, Q_HIT, SNIPPET_CHARS, TASKREQ_QUESTION,
)

FT = SVC / "finetune"
SEED = 42
HELDOUT_FRAC = 0.15
SMOOTH = 0.95          # 软标签平滑：真类 0.95/其余均摊（防过度自信）


def _smooth_target(keys: list[str], true_key: str) -> list[float]:
    t = [(1.0 - SMOOTH) / (len(keys) - 1)] * len(keys) if len(keys) > 1 else [1.0]
    t[keys.index(true_key)] = SMOOTH
    return t


def _load_jsonl(p: Path) -> list[dict]:
    return [json.loads(ln) for ln in io.open(p, encoding="utf-8") if ln.strip()]


def _build_items(pairs: list[dict]) -> list[dict]:
    """pairs: {state, questions, gold} → notebook cell-6 训练 items。"""
    from transformers import AutoTokenizer
    from huggingface_hub import snapshot_download
    from laya.agent import _fix_tokenizer_config
    from laya.common import build_sequence, render_options, QTYPES

    model_dir = snapshot_download("convaiinnovations/laya",
                                  allow_patterns=["multilingual/*"])
    model_dir = str(Path(model_dir) / "multilingual")
    _fix_tokenizer_config(model_dir)
    tok = AutoTokenizer.from_pretrained(str(Path(model_dir) / "tokenizer"))
    cfg = json.load(open(Path(model_dir) / "rl_agent_config.json",
                         encoding="utf-8"))

    items, skipped = [], 0
    for p in pairs:
        state, questions, gold = p["state"], p["questions"], p["gold"]
        for qid, q in questions.items():
            g = gold.get(qid)
            if not g:
                continue
            t, crit = q["type"], q.get("criteria", {})
            if t == "choice":
                keys = list(crit.keys())
                target = _smooth_target(keys, g["choice"])
            elif t == "noul":
                target = [1.0 - g["noul"], g["noul"]]
            else:
                skipped += 1
                continue
            label = max(range(len(target)), key=lambda i: target[i])
            k = len(render_options({"t": t, "crit": crit}))
            seq, markers = build_sequence(
                tok, state, {"t": t, "ins": q["instructions"], "crit": crit},
                cfg["max_len"], cfg["head_max_len"])
            if len(markers) != k:
                skipped += 1
                continue
            items.append({"ids": seq, "markers": markers,
                          "qtype": QTYPES[t], "target": target, "label": label,
                          "src": p["src"]})
    return items, skipped


def collect_pairs() -> list[dict]:
    pairs: list[dict] = []

    # E1 意图 choice（措辞钉死=平价门同款）
    for r in _load_jsonl(REPO / "tests" / "fixtures" / "intent_golden.jsonl"):
        if r["kind"] != "l1":
            continue
        pairs.append({"src": "E1", "state": r["sample"],
                      "questions": {"intent": INTENT_QUESTION},
                      "gold": {"intent": {"choice": r["expect"]}}})

    # E2 任务 noul
    for text, label, _origin in MEETING_GOLDEN + ADVERSARIAL:
        if label not in ("todo", "chatter"):
            continue                                  # borderline 不训
        pairs.append({
            "src": "E2",
            "state": {"text": text, "context": "线上会议语音转写中的一句话",
                      "时间": "2026-09-13 09:10"},
            "questions": {"is_task_request": TASKREQ_QUESTION},
            "gold": {"is_task_request": {"noul": 0.95 if label == "todo"
                                         else 0.05}}})

    # E3 命中 noul（正例=词面命中或引文判翻中；#33 已知 miss=负例）
    e3_rows = None
    e3_src = _load_jsonl(SVC / "parity" / "e3_laya.jsonl")
    if e3_src:
        e3_rows = {r["id"]: r for r in e3_src}
        for r in e3_rows.values():
            if r["id"] in CITATION_HITS or r["lexical"]:
                noul = 0.95
            elif r["id"] == 33:
                noul = 0.05                           # judge_v2 判 miss 的唯一定论
            else:
                continue                              # 6 题未知，不臆造标签
            pairs.append({
                "src": "E3", "state": {
                    "问题": r["q"], "标准答案": r["a"],
                    "检索片段top8": r.setdefault("snippets", _snippets_for(r))},
                "questions": {"hit": Q_HIT},
                "gold": {"hit": {"noul": noul}}})
    return pairs, e3_rows


_RETRIEVAL = None


def _retrieval():
    """dossier+索引 惰性单例（一次构建，百题复用）。"""
    global _RETRIEVAL
    if _RETRIEVAL is None:
        sys.path.insert(0, str(REPO / "src"))
        from paistation.cx.dossier import load_dossiers
        from paistation.cx.semantic import SemanticIndex
        from paistation.sense.localfiles.embedder import make_ollama_embedder
        embedder = make_ollama_embedder()
        if embedder is None:
            raise SystemExit("ollama embedder 不可用——E3 片段重放需要同款检索")
        dossier = load_dossiers(REPO / "SELF_PROFILE")
        sem = SemanticIndex.build(dossier.sections, embedder,
                                  REPO / "data" / "cx" / "dossier_vecs.npz")
        _RETRIEVAL = (dossier, sem, embedder)
    return _RETRIEVAL


def _snippets_for(e3_row: dict) -> list[str]:
    """E3 行自带片段（parity 重放时落盘）优先；缺席则重算。"""
    if e3_row.get("snippets"):
        return e3_row["snippets"]
    from paistation.cx.semantic import hybrid_route
    dossier, sem, embedder = _retrieval()
    dhits = hybrid_route(dossier, sem, embedder, e3_row["q"], k=K)
    out = []
    for h in (dhits or []):
        t = (h.text or "").strip().replace("\n", " ")
        if t:
            out.append(t[:SNIPPET_CHARS])
        if len(out) >= K:
            break
    return out


def build_mismatch_negatives(e3_rows: dict, n: int = 60) -> list[dict]:
    """错配负例：A 的问题 × B 的检索片段 → 必无答案（教分离度）。"""
    rng = random.Random(SEED)
    rows = [r for r in e3_rows.values() if r.get("snippets")]
    pairs = []
    ids = [r["id"] for r in rows]
    for qa in rows:
        if len(pairs) >= n:
            break
        cand = rng.choice(rows)
        while cand["id"] == qa["id"]:
            cand = rng.choice(rows)
        pairs.append({
            "src": "E3neg",
            "state": {"问题": qa["q"], "标准答案": qa["a"],
                      "检索片段top8": cand["snippets"]},
            "questions": {"hit": Q_HIT},
            "gold": {"hit": {"noul": 0.05}}})
    return pairs, len(ids)


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    pairs, e3_rows = collect_pairs()
    if e3_rows is None:
        raise SystemExit("先跑平价门 E3（需要 parity/e3_laya.jsonl 落盘片段）")
    neg_pairs, _ = build_mismatch_negatives(e3_rows)
    pairs += neg_pairs

    # E3 snippets 需要落盘：把片段补写回 e3_laya.jsonl（一次性）
    _persist_snippets(e3_rows)

    items, skipped = _build_items(pairs)
    rng = random.Random(SEED)
    rng.shuffle(items)
    by_src: dict[str, list] = {}
    for it in items:
        by_src.setdefault(it["src"], []).append(it)
    train, heldout = [], []
    for src, lst in by_src.items():
        n_hold = max(1, int(len(lst) * HELDOUT_FRAC))
        heldout += lst[:n_hold]
        train += lst[n_hold:]
    torch.save(train, FT / "train_items.pt")
    torch.save(heldout, FT / "heldout_items.pt")
    manifest = {
        "ts": __import__("time").strftime("%Y-%m-%dT%H:%M:%S"),
        "total": len(items), "train": len(train), "heldout": len(heldout),
        "skipped_shape_mismatch": skipped,
        "by_src": {k: len(v) for k, v in by_src.items()},
        "smoothing": SMOOTH, "seed": SEED,
        "note": "E3neg=错配负例(教sep)；E3 六未知题不训；borderline 不训",
    }
    (FT / "dataset_manifest.json").write_text(
        json.dumps(manifest, ensure_ascii=False, indent=1), encoding="utf-8")
    print(json.dumps(manifest, ensure_ascii=False, indent=1))
    return 0


def _persist_snippets(e3_rows: dict) -> None:
    """parity e3_laya.jsonl 补记 snippets 字段（幂等，一次性回填）。"""
    path = SVC / "parity" / "e3_laya.jsonl"
    rows = _load_jsonl(path)
    missing = [r for r in rows if not r.get("snippets")]
    if not missing:
        return
    for r in rows:
        if not r.get("snippets"):
            r["snippets"] = _snippets_for(r)
    with io.open(path, "w", encoding="utf-8") as fh:
        for r in rows:
            fh.write(json.dumps(r, ensure_ascii=False) + "\n")
    print(f"e3_laya.jsonl snippets 已补记（{len(missing)} 行）")


if __name__ == "__main__":
    raise SystemExit(main())
