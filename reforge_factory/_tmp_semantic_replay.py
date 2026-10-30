# -*- coding: utf-8 -*-
"""P1-1 语义判层离线复演 (只读, 不写账本分毫).

对象: EPC-JIAGE manifest 中 judge=rejected/off_topic 且源文件在盘的外文材料.
路径: 100% 复用产线双层判定链 (ammo_pool.judge_heuristic + semantic_judge),
      L1 复判 (对账) → L1 仍 rejected ∧ foreign_ratio>=0.30 → L2 GLM 复核 →
      valid∧score>=0.6 记「翻案」.
铁律: 旧账不重写 — 复演只量化「若双道当时在位」的翻案面, 不改 manifest/
      pool_state 一字节. 报告落 _tmp_semantic_replay_report.json.
"""
import io, json, sys, time
from pathlib import Path

sys.path.insert(0, r"E:/AI-Station/reforge_factory")
import semantic_judge as sj
from ammo_pool import judge_heuristic, read_text_safe

CAP = int(sys.argv[1]) if len(sys.argv) > 1 else 300
POOL = Path(r"E:/AI-Station/ammo_pool/EPC-JIAGE")
kws = json.loads((POOL / "pool_state.json").read_text(encoding="utf-8"))["kws"]
rows = [json.loads(x) for x in
        (POOL / "manifest.jsonl").read_text(encoding="utf-8").splitlines()
        if x.strip()]

cand = []
for r in rows:
    if r.get("judge") != "rejected" or r.get("judge_reason") != "off_topic":
        continue
    fp = Path(r["source_path"])
    if not fp.is_file():
        continue
    text = read_text_safe(fp)
    if not text:
        continue
    ratio = sj.foreign_ratio(text[:sj.HEAD_CHARS])
    if ratio >= sj.FOREIGN_RATIO_GATE:
        cand.append((r, fp, text, ratio))

print(f"candidates={len(cand)} (off_topic∧file_exists∧foreign_ratio"
      f">={sj.FOREIGN_RATIO_GATE}) cap={CAP} kws={len(kws)}", flush=True)

t0 = time.time()
flips, holds, errs, l1_diverge = [], [], [], []
done = 0
for r, fp, text, ratio in cand[:CAP]:
    v1, reason1 = judge_heuristic(text, kws)      # L1 复判 (对账)
    if v1 != "rejected":                          # L1 今日不再判废 — 不属翻案面
        l1_diverge.append({"f": fp.name, "l1": v1, "r": reason1})
        continue
    res = sj.judge_semantic(fp.stem, text[:sj.HEAD_CHARS], kws)
    rec = {"file": fp.name, "chars": r.get("chars", 0), "engine": r.get("engine", ""),
           "ratio": round(ratio, 2), "l1": reason1,
           "verdict": res["verdict"], "score": res["score"],
           "reason": res["reason"], "model": res["model"],
           "head": text[:220].replace("\n", " ")}
    if res["verdict"] == "valid" and res["score"] >= sj.SCORE_GATE:
        flips.append(rec)
    elif res["verdict"] == "rejected":
        holds.append(rec)
    else:
        errs.append(rec)
    done += 1
    if done % 20 == 0:
        print(f"progress {done} flips={len(flips)} holds={len(holds)} "
              f"errs={len(errs)} {time.time()-t0:.0f}s", flush=True)

report = {"ts": time.strftime("%Y-%m-%d %H:%M:%S"), "cid": "EPC-JIAGE",
          "candidates_total": len(cand), "cap": CAP, "ran": done,
          "l1_diverge": l1_diverge, "flips": flips, "holds": holds,
          "errs": errs, "stats": dict(sj.STATS),
          "score_gate": sj.SCORE_GATE, "ratio_gate": sj.FOREIGN_RATIO_GATE,
          "elapsed_s": round(time.time() - t0, 1)}
io.open("_tmp_semantic_replay_report.json", "w", encoding="utf-8").write(
    json.dumps(report, ensure_ascii=False, indent=1))
print(f"RESULT ran={done} flips={len(flips)} holds={len(holds)} "
      f"errs={len(errs)} l1_diverge={len(l1_diverge)} "
      f"glm={sj.STATS['ok']}ok/{sj.STATS['err']}err models={sj.STATS['models']} "
      f"keys={sj.STATS['keys']} rotations={sj.STATS['key_rotations']} "
      f"elapsed={report['elapsed_s']}s", flush=True)
for rec in flips[:10]:
    print(f"FLIP[{rec['score']}|{rec['model']}] {rec['file'][:70]} :: "
          f"{rec['reason']} :: {rec['head'][:90]}", flush=True)
