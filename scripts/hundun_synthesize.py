"""知识资产综合：全部 _mining/<cid>.json → 规范化聚类 → 武器库数据底座。

map-reduce 聚类（GLM 免费链）：
- 汇总四类 items（思维模型/原则/方法论/经验），本地同名预合并
- 每轮按规范名排序分批（同义条目自然同批），GLM 只判分组（输出编号组），
  字段合并本地完成——避免长输出复读导致的不收敛
- 迭代 reduce 直至每类 ≤MAX_CLUSTERS 簇，按 频次×来源分 排序
输出 data/hundun/_mining/synthesized.json（handbook 生成的数据底座）。
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
MAX_CLUSTERS = 800  # 成册只取每卷 Top80；磨更细只是浪费配额
THROTTLE = 1.0

SYSTEM = (
    "你是知识架构师，只做一件事：判断哪些条目是同一概念的不同表述。"
    "铁律：语义同一才同组（同一模型/原则/方法的不同叫法）；拿不准就分开，"
    "合并错误的代价远大于分开；不发明新名称。"
)

TPL = """以下是 {n} 条「{label}」条目（编号. 名称｜要义｜来源）：

{items}

哪些编号属于同一概念的不同表述？输出 JSON（UTF-8、无围栏）：
{{"groups": [[编号, 编号, ...], ...]}}

规则：每个编号恰好归入一组（单例自成一组如 [5]）；同组必须语义同一；不得遗漏编号。"""


def build_client() -> ZhipuClient:
    cp = configparser.ConfigParser()
    cp.read(os.path.join(ROOT, "config", "llm.secret.ini"), encoding="utf-8")
    return ZhipuClient(api_key=cp.get("llm", "api_key"),
                       free_models=["glm-4-flash-250414", "glm-4.7-flash"])


def _norm_name(s: str) -> str:
    import re
    return re.sub(r"[\s\W_]+", "", s).lower()


def _pre_merge(by_type: dict) -> dict:
    """本地预合并：同名（去空白/标点/大小写后一致）条目先归一，
    频次累加、来源课程去重——省掉一批本不必进 LLM 的重复。"""
    out = {}
    for label, entries in by_type.items():
        seen: dict[str, dict] = {}
        for e in entries:
            k = _norm_name(e["name"])
            if k in seen:
                hit = seen[k]
                hit["freq"] = hit.get("freq", 1) + 1
                if e["course"] not in hit["courses"]:
                    hit["courses"].append(e["course"])
                if len(e["core"]) > len(hit["core"]):
                    hit["core"] = e["core"]
                for f in ("quote", "ai_application", "steps"):
                    if not hit.get(f) and e.get(f):
                        hit[f] = e[f]
            else:
                e2 = dict(e)
                e2["courses"] = [e["course"]]
                e2["freq"] = 1
                seen[k] = e2
        out[label] = list(seen.values())
    return out


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
    by_type = _pre_merge(by_type)
    return {"by_type": by_type, "stats": stats}


def fmt(entries: list) -> str:
    def course_of(e):
        if e.get("courses"):
            return e["courses"][0]
        return e.get("course", "")
    return "\n".join(
        f"{i}. {e['name']}｜{e['core'][:80]}｜{course_of(e)}"
        for i, e in enumerate(entries, 1))


def _join_group(grp: list) -> dict:
    """本地合并一组语义同一的条目：代表取频次最高/要义最长的，字段全保真。"""
    rep = max(grp, key=lambda e: (e.get("freq", 1), len(e.get("core", ""))))
    courses = list(dict.fromkeys(
        c for e in grp for c in (e.get("courses")
                                 or ([e["course"]] if e.get("course") else []))))
    def first(field):
        return next((e.get(field) for e in grp if e.get(field)), "")
    return {
        "name": rep["name"][:40],
        "aliases": [e["name"][:30] for e in grp if e is not rep][:6],
        "core": rep.get("core", "")[:600],
        "quote": first("quote")[:160],
        "ai_application": first("ai_application")[:400],
        "steps": first("steps")[:400],
        "courses": [str(c)[:50] for c in courses][:40],
        "freq": sum(e.get("freq", 1) for e in grp),
    }


def merge_batch(cli: ZhipuClient, label: str, entries: list) -> list:
    """GLM 只输出编号分组（输出小、判断准），字段合并全部本地完成。
    GLM 遗漏的编号按单例兜底；覆盖率 <50% 视为失败（交给降级重试）。"""
    prompt = TPL.format(n=len(entries), label=label, items=fmt(entries))
    raw = cli.chat(SYSTEM, prompt, json_mode=True, temperature=0.2)
    groups = extract_json(raw).get("groups") or []
    seen: set[int] = set()
    idx_groups: list[list[int]] = []
    for g in groups:
        if not isinstance(g, list):
            continue
        ids = []
        for x in g:
            try:
                i = int(x)
            except (TypeError, ValueError):
                continue
            if 1 <= i <= len(entries) and i not in seen:
                seen.add(i)
                ids.append(i)
        if ids:
            idx_groups.append(ids)
    big = [ids for ids in idx_groups if len(ids) > 10]
    if big:  # GLM 偷懒把整批塞一组（实测 60→1），判失败走重试/二分
        raise ValueError(f"异常大组: {len(big[0])} 条同组")
    if len(seen) < len(entries) // 2:
        raise ValueError(f"分组覆盖不足 {len(seen)}/{len(entries)}")
    for i in range(1, len(entries) + 1):  # 遗漏 → 单例
        if i not in seen:
            idx_groups.append([i])
    return [_join_group([entries[i - 1] for i in ids]) for ids in idx_groups]


def merge_robust(cli: ZhipuClient, label: str, entries: list,
                 depth: int = 0) -> tuple:
    """带二分降级的合并：失败→睡60s重试→再失败对半分开各合→兜底透传。
    返回 (clusters, degraded)：透传的 degraded=True，不落缓存可重试。"""
    try:
        return merge_batch(cli, label, entries), False
    except Exception as exc:  # noqa: BLE001 - 限流/超时均降级
        print(f"  [{label}] batch 失败({str(exc)[:60]}) "
              f"depth={depth} n={len(entries)}", flush=True)
        if depth >= 2 or len(entries) <= 5:
            time.sleep(30)
            try:
                return merge_batch(cli, label, entries), False
            except Exception:
                print(f"  [{label}] 透传 {len(entries)} 条待后续轮次", flush=True)
                return ([{"name": e["name"],
                          "aliases": e.get("aliases", []),
                          "core": e.get("core", ""),
                          "quote": e.get("quote", ""),
                          "ai_application": e.get("ai_application", ""),
                          "steps": e.get("steps", ""),
                          "courses": (e.get("courses")
                                      or ([e["course"]]
                                          if e.get("course") else [])),
                          "freq": e.get("freq", 1)}
                         for e in entries], True)
        time.sleep(60)
        mid = len(entries) // 2
        left, ld = merge_robust(cli, label, entries[:mid], depth + 1)
        right, rd = merge_robust(cli, label, entries[mid:], depth + 1)
        return left + right, (ld or rd)


def reduce_type(cli: ZhipuClient, label: str, entries: list) -> list:
    """迭代 map-reduce 至 ≤MAX_CLUSTERS；每批落盘缓存可断点续跑。
    每轮先按规范名排序再分批——同义条目前缀相近自然同批，60条能真合并
    （随机序实测 60→57 几乎不合并，永远收敛不了）。"""
    cache_dir = os.path.join(MINE, "synth_cache")
    os.makedirs(cache_dir, exist_ok=True)
    round_no = 0
    while len(entries) > MAX_CLUSTERS:
        entries = sorted(entries, key=lambda e: _norm_name(e["name"]))
        round_no += 1
        merged = []
        n_batches = (len(entries) + BATCH - 1) // BATCH
        for bi, s in enumerate(range(0, len(entries), BATCH)):
            cache = os.path.join(cache_dir, f"{label}_r{round_no}_b{bi}.json")
            if os.path.exists(cache):
                merged.extend(json.load(open(cache, encoding="utf-8")))
                continue
            batch, degraded = merge_robust(cli, label, entries[s:s + BATCH])
            if not degraded:
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
