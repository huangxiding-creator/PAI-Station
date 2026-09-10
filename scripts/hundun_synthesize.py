"""知识资产综合：全部 _mining/<cid>.json → 规范化聚类 → 武器库数据底座。

map-reduce 聚类（GLM 免费链）：
- 汇总四类 items（思维模型/原则/方法论/经验），按类型分批 ~120 条
- 每批 GLM 聚合去重 → clusters（规范名/别名/核心/金句/AI应用/来源/频次）
- 迭代 reduce 直至每类 ≤120 簇，按 频次×来源分 排序
输出 data/hundun/_mining/synthesized.json（handbook 生成的数据底座）。
幂等：--from-cache 用缓存的中 programmatically 产物重排；默认全量重跑。
"""
import configparser
import glob
import json
import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation.llm.zhipu_client import ZhipuClient, extract_json  # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MINE = os.path.join(ROOT, "data", "hundun", "_mining")
BATCH = 60
MAX_CLUSTERS = 120
THROTTLE = 1.0

SYSTEM = (
    "你是知识架构师，把多门商业/创新课程中提炼出的同类知识资产去重合并成规范条目。"
    "铁律：语义同一才合并（同一模型/原则/方法的不同表述）；独特条目不得丢失；"
    "不编造；保留中文术语习惯。"
)

TPL = """以下是 {n} 条「{label}」原始条目（来自混沌学园不同课程，大量同义重复）：

{items}

请聚合同类项，输出 JSON（UTF-8、无围栏）：
{{
 "clusters": [
  {{"name": "规范名≤15字", "aliases": ["其他常见叫法"],
    "core": "合并后的核心思想，2-4句，综合多家表述",
    "quote": "最有代表性的原文金句≤80字",
    "ai_application": "对AI产品研发的应用启示，2-3句",
    "steps": "操作步骤，分号分隔（仅方法论有，无则空串）",
    "courses": ["来源课程标题（去重）"],
    "freq": 出现条数}}
 ]
}}
freq 按输入中实际出现条数统计；输出簇数不限，但不得丢弃语义独立的条目。"""


def build_client() -> ZhipuClient:
    cp = configparser.ConfigParser()
    cp.read(os.path.join(ROOT, "config", "llm.secret.ini"), encoding="utf-8")
    return ZhipuClient(api_key=cp.get("llm", "api_key"),
                       free_models=["glm-4-flash-250414", "glm-4.7-flash"])


def aggregate() -> dict:
    """汇总全部课程挖掘产物 → 按类型分组（含来源课程与 triage 分）。"""
    triage = json.load(open(os.path.join(MINE, "triage.json"), encoding="utf-8"))
    by_type: dict[str, list] = {}
    stats = {"courses": 0, "items": 0}
    for path in glob.glob(os.path.join(MINE, "*.json")):
        name = os.path.basename(path)
        if name in ("triage.json", "synthesized.json", "mine_failed.json"):
            continue
        try:
            rec = json.load(open(path, encoding="utf-8"))
        except (OSError, ValueError):
            continue
        stats["courses"] += 1
        score = triage.get(rec.get("course_id", ""), {}).get("score", 0)
        for it in rec.get("items") or []:
            entry = {
                "name": (it.get("name") or "").strip()[:40],
                "core": (it.get("core") or "").strip()[:400],
                "quote": (it.get("quote") or "").strip()[:160],
                "ai_application": (it.get("ai_application") or "").strip()[:300],
                "steps": (it.get("steps") or "").strip()[:300],
                "course": rec.get("title", ""),
                "teacher": rec.get("teacher", ""),
                "score": score,
            }
            if entry["name"]:
                by_type.setdefault(it.get("type", "经验"), []).append(entry)
                stats["items"] += 1
    return {"by_type": by_type, "stats": stats}


def fmt(entries: list) -> str:
    return "\n".join(
        f"[{i}] {e['name']}｜{e['course']}｜{e['core']}"
        + (f"｜步骤:{e['steps']}" if e.get("steps") else "")
        for i, e in enumerate(entries, 1))


def merge_batch(cli: ZhipuClient, label: str, entries: list) -> list:
    prompt = TPL.format(n=len(entries), label=label, items=fmt(entries))
    raw = cli.chat(SYSTEM, prompt, json_mode=True, temperature=0.2)
    clusters = extract_json(raw).get("clusters") or []
    out = []
    for c in clusters:
        if not isinstance(c, dict) or not c.get("name"):
            continue
        courses = c.get("courses") or []
        out.append({
            "name": str(c["name"])[:40],
            "aliases": [str(a)[:30] for a in c.get("aliases") or []][:6],
            "core": str(c.get("core") or "")[:600],
            "quote": str(c.get("quote") or "")[:160],
            "ai_application": str(c.get("ai_application") or "")[:400],
            "steps": str(c.get("steps") or "")[:400],
            "courses": [str(x)[:50] for x in courses][:40],
            "freq": int(c.get("freq") or len(courses) or 1),
        })
    return out or [{"name": "（本批合并失败，保留原始首条）",
                    "core": entries[0]["core"], "quote": entries[0]["quote"],
                    "ai_application": entries[0]["ai_application"],
                    "steps": entries[0].get("steps", ""),
                    "courses": [entries[0]["course"]], "freq": 1,
                    "aliases": []}]


def merge_robust(cli: ZhipuClient, label: str, entries: list,
                 depth: int = 0) -> list:
    """带二分降级的合并：失败→睡60s重试→再失败对半分开各合→兜底透传。"""
    try:
        return merge_batch(cli, label, entries)
    except Exception as exc:  # noqa: BLE001 - 限流/超时均降级
        print(f"  [{label}] batch 失败({str(exc)[:60]}) "
              f"depth={depth} n={len(entries)}", flush=True)
        if depth >= 2 or len(entries) <= 5:
            time.sleep(30)
            try:
                return merge_batch(cli, label, entries)
            except Exception:
                print(f"  [{label}] 透传 {len(entries)} 条待后续轮次", flush=True)
                return [{"name": e["name"], "aliases": [], "core": e["core"],
                         "quote": e.get("quote", ""),
                         "ai_application": e.get("ai_application", ""),
                         "steps": e.get("steps", ""),
                         "courses": [e["course"]], "freq": 1}
                        for e in entries]
        time.sleep(60)
        mid = len(entries) // 2
        return (merge_robust(cli, label, entries[:mid], depth + 1)
                + merge_robust(cli, label, entries[mid:], depth + 1))


def reduce_type(cli: ZhipuClient, label: str, entries: list) -> list:
    """迭代 map-reduce 至 ≤MAX_CLUSTERS；每批落盘缓存可断点续跑。"""
    cache_dir = os.path.join(MINE, "synth_cache")
    os.makedirs(cache_dir, exist_ok=True)
    round_no = 0
    while len(entries) > MAX_CLUSTERS:
        round_no += 1
        merged = []
        n_batches = (len(entries) + BATCH - 1) // BATCH
        for bi, s in enumerate(range(0, len(entries), BATCH)):
            cache = os.path.join(cache_dir, f"{label}_r{round_no}_b{bi}.json")
            if os.path.exists(cache):
                merged.extend(json.load(open(cache, encoding="utf-8")))
                continue
            batch = merge_robust(cli, label, entries[s:s + BATCH])
            with open(cache, "w", encoding="utf-8") as fh:
                json.dump(batch, fh, ensure_ascii=False)
            merged.extend(batch)
            time.sleep(THROTTLE)
            print(f"  [{label}] r{round_no} batch {bi + 1}/{n_batches}",
                  flush=True)
        entries = merged
        print(f"  [{label}] round{round_no}: {len(entries)} 簇", flush=True)
    return entries


def main() -> int:
    agg = aggregate()
    print(f"[synth] 课程 {agg['stats']['courses']} / 条目 "
          f"{agg['stats']['items']}", flush=True)
    cli = build_client()
    final = {}
    for label, entries in agg["by_type"].items():
        print(f"[synth] {label}: {len(entries)} 条 → 聚类", flush=True)
        clusters = reduce_type(cli, label, entries)
        clusters.sort(key=lambda c: (-c.get("freq", 1),
                                     -len(c.get("courses") or [])))
        final[label] = clusters
        print(f"[synth] {label} → {len(clusters)} 簇 (top: "
              f"{clusters[0]['name'] if clusters else '-'})", flush=True)
    with open(os.path.join(MINE, "synthesized.json"), "w", encoding="utf-8") as fh:
        json.dump({"stats": agg["stats"], "clusters": final},
                  fh, ensure_ascii=False, indent=1)
    total = sum(len(v) for v in final.values())
    print(f"[synth] 完成：{total} 规范条目 -> synthesized.json", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
