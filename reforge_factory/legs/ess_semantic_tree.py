# -*- coding: utf-8 -*-
"""lumpsum_semantic_tree — EPC-ESS GLM 语义挂树件 (1102 饱和冲门正解).

诊断: 池内 valid 667 件弹药充足, 词面 backfill 与树词错位 → 57 EEI 零挂.
本件: 每缺口 EEI(need+queries) → valid 未挂件词粗筛 top8 候选 → GLM 判相关
(≥相关取2件, 双 host 优先) → 直写 manifest tree_node. 数字零造假: GLM 判
「不相关」不挂.
用法: py -X utf8 lumpsum_semantic_tree.py [--dry] [--gap-only]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path
from urllib.parse import urlsplit

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
POOL = REPO / "ammo_pool" / "EPC-ESS"
MANIFEST = POOL / "manifest.jsonl"
sys.path.insert(0, str(REPO / "reforge_factory"))
sys.path.insert(0, r"E:\AI-Station\mission-engine\forge")

from glm_json import load_keys  # noqa: E402  (forge 双钥客户端, 产线在役)


def load_rows():
    rows = [json.loads(x) for x in MANIFEST.read_text(encoding="utf-8").splitlines() if x.strip()]
    return rows


def gap_eeis(rows) -> list[dict]:
    tree = json.loads((POOL / "question_tree.json").read_text(encoding="utf-8"))
    by = {}
    for r in rows:
        if r.get("judge") == "valid" and r.get("tree_node"):
            by.setdefault(r["tree_node"], []).append(r)
    out = []
    for q in tree["subquestions"]:
        for e in q["eeis"]:
            ev = by.get(e["id"], [])
            hosts = {(urlsplit(r.get("url_norm") or "").netloc or Path(r["source_path"]).stem)
                     for r in ev}
            if len(ev) >= 2 and len(hosts) >= 2:
                continue
            out.append({"id": e["id"], "need": e.get("need", ""),
                        "queries": e.get("queries", []),
                        "qtext": q.get("text", "")})
    return out


def cands(rows, e: dict, k=8) -> list[dict]:
    """词粗筛: 堆积EEI溢出件(每EEI留6件)+未挂件, 词面命中取top."""
    terms = set(re.findall(r"[\u4e00-\u9fffA-Za-z0-9]{2,}",
                           e["need"] + " " + " ".join(e.get("queries", [])[:2])))
    terms = {t for t in terms if len(t) >= 2 and t not in
             ("全国", "2025", "2026", "固定总价EPC合同的计价", "风险管控实战")} - {"EPC合同"}
    from collections import Counter
    cnt = Counter(r.get("tree_node") for r in rows if r.get("tree_node"))
    seen = Counter()
    pool = []
    for r in rows:
        if r.get("judge") != "valid":
            continue
        tn = r.get("tree_node")
        if not tn:
            pool.append(r)
        elif cnt[tn] > 6:
            seen[tn] += 1
            if seen[tn] > 6:
                pool.append(r)          # 溢出位, 可重挂
    scored = []
    for r in pool:
        hay = str(r.get("text_head", ""))[:1500] + " " + Path(r.get("source_path", "")).stem
        s = sum(1 for t in terms if t in hay)
        if s >= 1:
            scored.append((s, r))
    scored.sort(key=lambda x: -x[0])
    return [r for _, r in scored[:k]]


_KEYS = None


def glm_pick(e: dict, cand_rows: list[dict]) -> list[int]:
    """GLM 判: 候选里与 EEI 证据需求相关的索引 (取≤3). 走 forge GlmJson 客户端."""
    global _KEYS
    if not cand_rows:
        return []
    if _KEYS is None:
        try:
            from glm_json import GlmJson
            _KEYS = GlmJson(model="glm-4-flash")
        except Exception:  # noqa: BLE001
            _KEYS = False
    lines = [f"{i}. {str(r.get('text_head',''))[:160]}…"
             .replace("\n", " ") for i, r in enumerate(cand_rows)]
    sys_p = "你是证据相关性审查员, 只输出JSON数组(相关候选编号, 整数, 最多3个)或空数组[]"
    usr = (f"证据需求: {e['need']}\n"
           f"检索词: {e['queries'][0] if e.get('queries') else e['qtext']}\n"
           f"候选材料:\n" + "\n".join(lines) +
           "\n\n哪些候选与证据需求实质相关(支撑该需求的证据/数据/案例/规则)?")
    try:
        res = _KEYS.chat_json(sys_p, usr) if _KEYS else _chat_fallback(usr)
    except Exception as ex:  # noqa: BLE001
        print(f"    GLM异常: {ex}", flush=True)
        return []
    if isinstance(res, str):
        return [int(x) for x in re.findall(r"\d+", res) if int(x) < len(cand_rows)][:3]
    if isinstance(res, list):
        return [int(x) for x in res if isinstance(x, int) and x < len(cand_rows)][:3]
    return []


def _chat_fallback(prompt: str) -> str:
    """GLM 直调兜底 (zhipu 双钥轮换, 照产线件)."""
    import urllib.request
    import configparser
    cfg = configparser.ConfigParser()
    cfg.read(REPO / "data" / "secrets" / "zhipu.secret")
    keys = []
    for sec in cfg.sections():
        for k, v in cfg[sec].items():
            if "key" in k and len(v) > 20:
                keys.append(v)
    body = json.dumps({"model": "glm-4-flash", "messages":
                       [{"role": "user", "content": prompt}],
                       "temperature": 0.1, "max_tokens": 60}).encode()
    last = ""
    for key in keys[:2]:
        try:
            req = urllib.request.Request(
                "https://open.bigmodel.cn/api/paas/v4/chat/completions", data=body,
                headers={"Content-Type": "application/json",
                         "Authorization": f"Bearer {key}"})
            with urllib.request.urlopen(req, timeout=40) as r:
                last = json.loads(r.read())["choices"][0]["message"]["content"]
            return last
        except Exception as ex:  # noqa: BLE001
            last = f"ERR:{ex}"
    return last


glm_pick.chat = None


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()

    rows = load_rows()
    gaps = gap_eeis(rows)
    print(f"[sem] 缺口 {len(gaps)} EEI | valid未挂 "
          f"{sum(1 for r in rows if r.get('judge')=='valid' and not r.get('tree_node'))} 件")
    n_ok = n_none = 0
    for i, e in enumerate(gaps, 1):
        c = cands(rows, e)
        if not c:
            n_none += 1
            print(f"  [{i}/{len(gaps)}] {e['id']} 无候选", flush=True)
            continue
        idx = glm_pick(e, c)
        if not idx:
            n_none += 1
            print(f"  [{i}/{len(gaps)}] {e['id']} GLM判全不相关(不挂)", flush=True)
            continue
        for j in idx:
            rows[rows.index(c[j])]["tree_node"] = e["id"]
        n_ok += 1
        print(f"  [{i}/{len(gaps)}] {e['id']} 挂 {len(idx)} 件", flush=True)
        time.sleep(1)
    if not ns.dry:
        MANIFEST.write_text(
            "\n".join(json.dumps(r, ensure_ascii=False) for r in rows) + "\n",
            encoding="utf-8")
    print(f"[sem] 完成: {n_ok} EEI 挂上, {n_none} 无获 ({'DRY未写' if ns.dry else '已写manifest'})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
