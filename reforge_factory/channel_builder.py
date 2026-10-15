# -*- coding: utf-8 -*-
"""建渠器 channel_builder: 缺口→SOP 四步法自动推进→守卫测试入列
(T-015 / REQ-029 后半 / KB-CHANNEL-BUILDER-SPEC)。

四步 (CONTEXT 术语口径):
  1. probe     探测: 渠道端点 1 发礼貌真请求 (limit=1, EPC 词), 返回
               {reachable, http_status, sample_ok, latency_ms, error}
  2. verdict   判决: available / needs_creds / abandoned + reason
               (放弃也留判决 —— 负面资产复利)
  3. implement 实现: 已实现适配器 → 模块路径 + 函数名; 无配方 → no_recipe
               留队列跳过 (不冒充实现)
  4. enlist    入列: 只增写 ResearchFactory-Eng/channel_manifest.json 的
               named_channels (幂等: 已在列不重复登记; 既有条目一字不动,
               写前在码内断言), totals 计数与 updated 同步; 每步落建渠台账。

入列政策: verdict=available → 入列; needs_creds 且 http=429 (免 key 渠道
匿名限流, cnki「账号态待验」先例) 且配方允许 → 入列并在 note 留探实证;
needs_creds(401/403 真鉴权墙) / abandoned → 不入列, 判决留台账。

队列语义 (与 C 轴传感器 channel_matrix 一致):
  C_axis_queue.json = [{"name","sop_step"}] 兼容纯字符串; 也接受缺口清单
  (json 数组或每行一名字的文本)。名字→配方归一匹配 (去空白+小写子串),
  「学术英文（OpenAlex/S2/arXiv 待建渠 T-015）」一条可展开三件套;
  academic_en 基名同理。无配方的缺口 → no_recipe 留痕, 不丢。

台账: <V3计划>/work/channel_build_ledger.jsonl (只增 append, 每步一行)。

CLI:
  py reforge_factory/channel_builder.py --queue <C_axis_queue.json|缺口清单>
      [--channels openalex,semantic_scholar,arxiv] [--manifest PATH]
      [--ledger PATH] [--campaign NAME] [--dry-run]

真请求红线: 每渠道单次运行探测 <= 2 发 (1 发 + KB「超时重试」1 次, 每次
timeout 20s; HTTP 429/5xx 状态码不自动重试 —— 限流端点不打扰); 适配器内部
同主机 >=1s 礼貌间隔; R10 反爬礼貌; 失败不造假。
"""
from __future__ import annotations

import argparse
import json
import sys
import time
import urllib.error
from datetime import datetime
from pathlib import Path

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parent))
from channels import academic  # noqa: E402

REPO_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_MANIFEST_PATH = REPO_ROOT / "ResearchFactory-Eng" / "channel_manifest.json"
V3_PLAN_DIR = REPO_ROOT / "ResearchFactory-Eng" / "06 迭代优化" / "百倍V3_极致调研变现计划"
DEFAULT_LEDGER_PATH = V3_PLAN_DIR / "work" / "channel_build_ledger.jsonl"

SENSOR = "channel_builder"
PROBE_QUERY = "EPC contract"  # 建渠探测统一 EPC 词 (与守卫测试同词)

#: 建渠配方注册表: 每渠道 = 探测函数 + 适配器声明 + manifest 条目底稿。
#: aliases 供队列缺口名归一匹配 (含 academic_en 基名 / 中文缺口名)。
RECIPES: dict[str, dict] = {
    "openalex": {
        "aliases": ["openalex", "academic_en", "学术英文"],
        "probe_fn": academic.search_openalex,
        "module": "reforge_factory/channels/academic.py",
        "functions": ["search_openalex"],
        "enlist_on_rate_limit": True,
        "manifest": {
            "id": "openalex",
            "name": "OpenAlex 学术API(免key)",
            "runner": "reforge_factory/channels/academic.py::search_openalex (urllib, timeout20s, 同主机>=1s礼貌间隔)",
            "note": "T-015 建渠器入列; 开放学术索引匿名免key; 统一Doc[{title,url,year,abstract_head(300),source}]; 摘要由 abstract_inverted_index 重建",
        },
    },
    "semantic_scholar": {
        "aliases": ["semantic scholar", "semanticscholar", "s2", "academic_en", "学术英文"],
        "probe_fn": academic.search_s2,
        "module": "reforge_factory/channels/academic.py",
        "functions": ["search_s2"],
        "enlist_on_rate_limit": True,
        "manifest": {
            "id": "semantic_scholar",
            "name": "Semantic Scholar 学术API(S2, 免key)",
            "runner": "reforge_factory/channels/academic.py::search_s2 (urllib, timeout20s, 同主机>=1s礼貌间隔)",
            "note": "T-015 建渠器入列; 免key匿名; 共享IP 429 匿名限流常见→守卫测试如实skip不造假; 计划书L卷实测通过; 429 解法=免费API key提额(工单另立)",
        },
    },
    "arxiv": {
        "aliases": ["arxiv", "academic_en", "学术英文"],
        "probe_fn": academic.search_arxiv,
        "module": "reforge_factory/channels/academic.py",
        "functions": ["search_arxiv"],
        "enlist_on_rate_limit": True,
        "manifest": {
            "id": "arxiv",
            "name": "arXiv 学术API(免key)",
            "runner": "reforge_factory/channels/academic.py::search_arxiv (urllib, timeout20s, 同主机>=1s礼貌间隔)",
            "note": "T-015 建渠器入列; Atom XML 端点 export.arxiv.org; 响应可慢(实测>20s也可能成), timeout 20s+守卫重试1次; 计划书L卷实测通过",
        },
    },
}


# ---- 台账 (只增) ---------------------------------------------------------

def log_step(ledger_path: Path, step: str, channel: str, data: dict,
             *, campaign: str | None = None) -> dict:
    """建渠台账追加一行 jsonl (append-only, 目录缺席则建)。"""
    path = Path(ledger_path)
    path.parent.mkdir(parents=True, exist_ok=True)
    rec = {
        "ts": datetime.now().astimezone().isoformat(timespec="seconds"),
        "sensor": SENSOR,
        "step": step,
        "channel": channel,
    }
    if campaign:
        rec["campaign"] = campaign
    rec["data"] = data
    with path.open("a", encoding="utf-8", newline="\n") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")
    return rec


# ---- SOP 四步 -----------------------------------------------------------

#: 超时/网络不可达的礼貌重试间隔 (KB-CHANNEL-BUILDER-SPEC「超时重试」;
#: HTTP 状态码 429/5xx 不自动重试 —— 限流端点不打扰)。
PROBE_RETRY_SLEEP_S = 5.0


def probe(channel: str, *, retries: int = 1) -> dict:
    """①探测: 适配器真请求 (limit=1), 捕获可达性/HTTP 状态/样本形态。

    KB「超时重试」语义: 超时/网络不可达 (reachable=False) 间隔 5s 重试 1 次
    (每渠道单次运行真请求 <= 2 发, 红线内); HTTP 状态码不重试。
    unknown 渠道 (无配方) 抛 ValueError —— 建渠器不冒充探测。
    """
    recipe = RECIPES.get(channel)
    if recipe is None:
        raise ValueError(f"no_probe_recipe: 渠道 `{channel}` 无建渠配方, 留队列待后续任务")
    attempts = 0
    while True:
        attempts += 1
        t0 = time.monotonic()
        try:
            docs = recipe["probe_fn"](PROBE_QUERY, 1)
        except urllib.error.HTTPError as e:
            return {
                "channel": channel, "reachable": True, "http_status": int(e.code),
                "sample_ok": False,
                "latency_ms": int((time.monotonic() - t0) * 1000),
                "error": f"HTTPError {e.code}: {str(e.reason)[:120]}",
                "query": PROBE_QUERY, "attempts": attempts,
            }
        except Exception as e:  # URLError / timeout / 解析异常 → 不可达
            err = f"{type(e).__name__}: {str(e)[:120]}"
            if attempts <= retries:
                time.sleep(PROBE_RETRY_SLEEP_S)
                continue
            return {
                "channel": channel, "reachable": False, "http_status": None,
                "sample_ok": False,
                "latency_ms": int((time.monotonic() - t0) * 1000),
                "error": err, "query": PROBE_QUERY, "attempts": attempts,
            }
        sample_ok = bool(docs) and bool(docs[0].get("title"))
        return {
            "channel": channel, "reachable": True, "http_status": 200,
            "sample_ok": sample_ok,
            "latency_ms": int((time.monotonic() - t0) * 1000),
            "error": None if sample_ok else "200 但 0 条 Doc 或样本缺题",
            "query": PROBE_QUERY, "attempts": attempts,
        }


def verdict(probe_result: dict) -> dict:
    """②判决: available / needs_creds / abandoned + reason (纯函数, 可离线测)。"""
    status = probe_result.get("http_status")
    reachable = bool(probe_result.get("reachable"))
    if reachable and status == 200 and probe_result.get("sample_ok"):
        return {"verdict": "available",
                "reason": "探测 200 且样本 Doc 形态正确"}
    if reachable and status in (401, 402, 403):
        return {"verdict": "needs_creds",
                "reason": f"HTTP {status} 鉴权墙: 需凭证后才可入列"}
    if reachable and status == 429:
        return {"verdict": "needs_creds",
                "reason": "HTTP 429 匿名限流(共享IP): 免key渠道择时重试或申请key提额"}
    if reachable and status == 200:
        return {"verdict": "abandoned",
                "reason": "HTTP 200 但样本形态不符(0条/缺题), 数据面异常"}
    if reachable:
        return {"verdict": "abandoned",
                "reason": f"HTTP {status} 服务端异常"}
    return {"verdict": "abandoned",
            "reason": "网络不可达: " + str(probe_result.get("error") or "超时")}


def implement(channel: str) -> dict:
    """③实现: 配方 → 适配器模块路径 (在盘验证, 不冒充); 无配方 → None。"""
    recipe = RECIPES.get(channel)
    if recipe is None:
        return {"module": None, "functions": [],
                "reason": "no_recipe: 建渠配方未覆盖, 留队列待后续任务"}
    path = REPO_ROOT / recipe["module"]
    return {
        "module": recipe["module"],
        "functions": list(recipe["functions"]),
        "module_exists": path.is_file(),
        "reason": None if path.is_file() else "适配器模块不在盘上",
    }


def enlist(channel: str, probe_result: dict, verdict_result: dict, *,
           manifest_path: Path | str = DEFAULT_MANIFEST_PATH,
           ledger_path: Path | str = DEFAULT_LEDGER_PATH,
           campaign: str | None = None, dry_run: bool = False) -> dict:
    """④入列: 只增写 channel_manifest.json named_channels (幂等 + 既有条目不动)。"""
    recipe = RECIPES[channel]
    entry = dict(recipe["manifest"])
    note_tail = (f"; 入列实证: probe http={probe_result.get('http_status')} "
                 f"verdict={verdict_result['verdict']} "
                 f"({verdict_result['reason']})")
    entry["note"] = str(entry["note"]) + note_tail

    mpath = Path(manifest_path)
    raw = mpath.read_text(encoding="utf-8")
    data = json.loads(raw)
    named = data.get("named_channels")
    if not isinstance(named, list):
        raise ValueError(f"manifest 结构异常: named_channels 非列表 ({mpath})")
    existing_ids = [c.get("id") for c in named if isinstance(c, dict)]
    if channel in existing_ids:
        out = {"enlisted": False, "reason": "already_enlisted",
               "manifest": str(mpath)}
        log_step(ledger_path, "enlist", channel,
                 {**out, "note": "幂等: 已在列不重复登记"}, campaign=campaign)
        return out

    if dry_run:
        out = {"enlisted": False, "reason": "dry_run",
               "manifest": str(mpath), "would_append": entry}
        log_step(ledger_path, "enlist", channel, out, campaign=campaign)
        return out

    before = json.dumps(named, ensure_ascii=False)
    named.append(entry)
    # 只增守卫: 写前断言既有条目一字不动 (仅尾部追加)
    assert json.dumps(named[:-1], ensure_ascii=False) == before, \
        "只增红线被破: 既有条目被改动"
    data["named_channels"] = named
    totals = data.get("totals")
    if isinstance(totals, dict):
        totals["named_channels"] = int(totals.get("named_channels", 0)) + 1
    data["updated"] = datetime.now().astimezone().date().isoformat()
    mpath.write_text(json.dumps(data, ensure_ascii=False, indent=1) + "\n",
                     encoding="utf-8", newline="\n")
    out = {"enlisted": True, "manifest": str(mpath),
           "entry_id": entry["id"], "named_total": len(named)}
    log_step(ledger_path, "enlist", channel, out, campaign=campaign)
    return out


def _enlist_policy(verdict_result: dict, probe_result: dict,
                   recipe: dict) -> tuple[bool, str]:
    """入列政策: available → 入列; 429 匿名限流 + 配方允许 → 带实证注记入列。"""
    if verdict_result["verdict"] == "available":
        return True, ""
    if (verdict_result["verdict"] == "needs_creds"
            and probe_result.get("http_status") == 429
            and recipe.get("enlist_on_rate_limit")):
        return True, ("rate-limit 入列: 免key渠道匿名限流不阻断 "
                      "(cnki「账号态待验」先例), note 已留探实证")
    return False, f"verdict={verdict_result['verdict']} 不入列: {verdict_result['reason']}"


def build_channel(channel: str, *, manifest_path: Path | str = DEFAULT_MANIFEST_PATH,
                  ledger_path: Path | str = DEFAULT_LEDGER_PATH,
                  campaign: str | None = None, dry_run: bool = False) -> dict:
    """四步编排一渠道: probe→verdict→implement→(政策)enlist, 每步台账留痕。"""
    recipe = RECIPES.get(channel)
    if recipe is None:
        out = {"channel": channel, "skipped": True,
               "reason": "no_recipe: 留队列待后续任务"}
        log_step(ledger_path, "skip", channel, out, campaign=campaign)
        return out

    log_step(ledger_path, "start", channel,
             {"manifest": str(Path(manifest_path)), "dry_run": dry_run},
             campaign=campaign)
    pr = probe(channel)
    log_step(ledger_path, "probe", channel, pr, campaign=campaign)
    vd = verdict(pr)
    log_step(ledger_path, "verdict", channel, vd, campaign=campaign)
    im = implement(channel)
    log_step(ledger_path, "implement", channel, im, campaign=campaign)
    if not im["module_exists"]:
        out = {"channel": channel, "skipped": True,
               "reason": f"implement 未落地: {im['reason']}"}
        log_step(ledger_path, "skip", channel, out, campaign=campaign)
        return out

    allowed, why = _enlist_policy(vd, pr, recipe)
    if not allowed:
        out = {"channel": channel, "skipped": True, "verdict": vd["verdict"],
               "reason": why}
        log_step(ledger_path, "skip", channel, out, campaign=campaign)
        return {"channel": channel, "verdict": vd["verdict"], "reason": why,
                "enlisted": False, "skipped": True}

    en = enlist(channel, pr, vd, manifest_path=manifest_path,
                ledger_path=ledger_path, campaign=campaign, dry_run=dry_run)
    return {"channel": channel, "verdict": vd["verdict"],
            "probe_http": pr.get("http_status"),
            "module": im["module"], **en}


# ---- 队列解析 (C_axis_queue / 缺口清单) ---------------------------------

def _norm(s: str) -> str:
    """与 channel_matrix._norm 同口径: 去空白 + 小写 (id/中文名皆可对上)。"""
    return "".join(str(s).split()).lower()


def resolve_queue_entries(entries: list) -> tuple[list[str], list[dict]]:
    """队列/缺口条目 → (配方渠道 id 去重有序, 无配方缺口留痕)。

    匹配: 条目名归一后 == 渠道 id/别名, 或包含任一别名 (子串)。
    「学术英文（OpenAlex/S2/arXiv 待建渠 T-015）」/「academic_en」一条展开三件套。
    """
    picked: list[str] = []
    seen: set[str] = set()
    no_recipe: list[dict] = []
    for it in entries:
        name = str(it.get("name") if isinstance(it, dict) else it).strip()
        if not name:
            continue
        key = _norm(name)
        matched: list[str] = []
        for cid, recipe in RECIPES.items():
            aliases = [cid] + [str(a) for a in recipe["aliases"]]
            if any(_norm(a) == key for a in aliases):
                matched.append(cid)
                continue
            if any(_norm(a) in key for a in recipe["aliases"]):
                matched.append(cid)
        if matched:
            for cid in matched:
                if cid not in seen:
                    seen.add(cid)
                    picked.append(cid)
        else:
            no_recipe.append({"name": name,
                              "reason": "no_recipe: 建渠配方未覆盖, 留队列"})
    return picked, no_recipe


def load_gap_file(path: Path | str) -> list:
    """读队列/缺口清单: json 数组 ([{name,sop_step}]/纯字符串) 或每行一名字文本。"""
    text = Path(path).read_text(encoding="utf-8")
    try:
        data = json.loads(text)
        if isinstance(data, list):
            return data
        if isinstance(data, dict) and isinstance(data.get("names"), list):
            return data["names"]
    except json.JSONDecodeError:
        pass
    return [ln.strip() for ln in text.splitlines() if ln.strip()]


# ---- CLI ----------------------------------------------------------------

def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description="建渠器: 缺口→SOP 四步法(探测/判决/实现/入列)→守卫测试入列 "
                    "(T-015 / REQ-029 后半)")
    ap.add_argument("--queue", default=None,
                    help="C_axis_queue.json 或缺口清单 (json 数组/每行一名字)")
    ap.add_argument("--channels", default=None,
                    help="直接指定渠道 id 逗号分隔 (如 openalex,semantic_scholar,arxiv)")
    ap.add_argument("--manifest", default=None, help="channel_manifest.json 路径覆盖")
    ap.add_argument("--ledger", default=None, help="建渠台账 jsonl 路径覆盖")
    ap.add_argument("--campaign", default=None, help="战役名 (台账标注用)")
    ap.add_argument("--dry-run", action="store_true",
                    help="跑探测/判决/实现但不动 manifest")
    args = ap.parse_args(argv)

    if args.channels:
        wanted = [c.strip() for c in args.channels.split(",") if c.strip()]
    elif args.queue:
        entries = load_gap_file(args.queue)
        wanted, no_recipe = resolve_queue_entries(entries)
        for nr in no_recipe:
            log_step(args.ledger or DEFAULT_LEDGER_PATH, "skip", nr["name"],
                     nr, campaign=args.campaign)
            print(f"[建渠] no_recipe 留队列: {nr['name']}")
    else:
        ap.error("--queue 与 --channels 至少给一个")
        return 2

    manifest = args.manifest or DEFAULT_MANIFEST_PATH
    ledger = args.ledger or DEFAULT_LEDGER_PATH
    results = []
    for channel in wanted:
        r = build_channel(channel, manifest_path=manifest, ledger_path=ledger,
                          campaign=args.campaign, dry_run=args.dry_run)
        results.append(r)
        print("[建渠] " + json.dumps(r, ensure_ascii=False))

    ok = sum(1 for r in results if r.get("enlisted"))
    skip = sum(1 for r in results if r.get("skipped"))
    print(f"[建渠] 完成: {len(results)} 渠道, 入列 {ok}, 跳过 {skip}; "
          f"台账 {Path(ledger)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
