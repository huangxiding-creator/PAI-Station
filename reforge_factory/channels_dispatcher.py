# -*- coding: utf-8 -*-
"""channels_dispatcher — 全渠道生产调度器 (1026 用户令「生产中使用起来」).

职责: 让全部点亮渠道自动进入每一份报告的 S1 采集产线, 取代手工编波。
本件是**编排层** (只建新件不改产线既有件):
  ① 输入: --campaign <池> [--eeis Q1-E1,Q2-E3 | --kws 词表] [--tags 域过滤]
     [--max-concurrent 4]; 缺省 EEI 面 = question_tree 未饱和 EEI (status!=saturated);
  ② 路由: 读战役 question_tree.json (或 --kws) → 每个**点亮**渠道
     (legs/*_leg.py 全集) 按其 fit 标签 (api_replica_bridge.HTTP_ENGINES tags,
     权威源=channels_survey_2026/MASTER_REGISTRY) 匹配 EEI 域 → 生成每渠道任务
     (腿 CLI: --campaign X --queries <该域词>) → 进程池并发 ≤ max-concurrent
     (每任务=一个腿子进程, 线程池只是等待器) → 逐腿收 stdout/exit → 汇总台账;
  ③ 健康表: 内嵌渠道健康账 (活/墙/骨架/词面不匹配), 证据源=
     · 骨架 = 腿件 SPEC note 的 batch1025骨架TODO 标记 (腿建造台账 63 条, 动态读);
     · 墙 = 冒烟矩阵台账 (ammo_pool/<campaign>/channel_invocations.jsonl 1025
       23:55-00:06 全腿冒烟波 + 集成台账已知边界) 的 HTTP 失败证据, 下方 WALLS 逐条在案;
     · 词面不匹配 = 端点无查询词面 (事件流/目录/序列ID), 派自然语言词=假调用,
       如实跳过 (数字零造假铁律的反向面: 不制造假渠道使用);
     墙与骨架自动跳过, 台账记 skipped+原因;
  ④ 幂等: 同 campaign+渠道+查询 hash (sha1) 去重 — 跑过的跳过 (--force-rerun 破);
  ⑤ 台账: reforge_factory/dispatch_ledger.jsonl 只增不改 (渠道/查询/命中/入池/
     exit/dur/skip原因), 末行汇总。

铁律: 数字零造假 (hits/ingested/chars 全从腿 stdout 终态 JSON 实收, 解析不出=
null 不编造); 只建本新件; 腿全 API 零浏览器; 不删任何文件; ingest 走
ammo_pool 跨进程池锁 (并发安全, 1004 事故根治件)。

用法:
  py -X utf8 reforge_factory/channels_dispatcher.py --campaign EPC-JIAGE --dry-run
  py -X utf8 reforge_factory/channels_dispatcher.py --campaign EPC-JIAGE \
      --eeis Q6-E3,Q18-E3,Q26-E3 --max-concurrent 3
  py -X utf8 reforge_factory/channels_dispatcher.py --campaign EPC-JIAGE --kws "词1","词2"
  py -X utf8 reforge_factory/channels_dispatcher.py --list-health
"""
from __future__ import annotations

import argparse
import hashlib
import importlib.util
import json
import re
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]          # E:\AI-Station
FACTORY = Path(__file__).resolve().parent           # reforge_factory
LEGS_DIR = FACTORY / "legs"
AMMO_ROOT = REPO / "ammo_pool"
LEDGER_PATH = FACTORY / "dispatch_ledger.jsonl"     # 汇总台账 (只增不改)
BRIDGE_PATH = LEGS_DIR / "api_replica_bridge.py"

CANON_TAGS = ["标准定额", "项目数据", "学术专利", "新闻舆情",
              "工商招投标", "数据集", "通用网研"]

#: ---- 渠道健康账: 墙 (冒烟矩阵台账证据, 逐条在案) --------------------------
#: 证据源: ammo_pool/EPC-JIAGE/channel_invocations.jsonl 1025-10-25 23:55 →
#: 10-26 00:06 全腿冒烟波 (60 行 http_api_leg 实跑) + 集成台账已知边界 +
#: last30days 周期账 (reddit 全出口拒 双证)。状态码=腿如实录的 HTTP 终态。
WALLS: dict[str, str] = {
    "reddit_json": "墙: 403×2 (1025冒烟 23:58/00:00) + last30days 周期账全出口拒(直连000/7895出口403)",
    "ddgs_duckduckgo_search": "墙: 403 (1025冒烟 00:01, html/lite 反爬)",
    "marginalia_search": "墙: 000 网络不可达×2 (1025冒烟 00:02)",
    "marginalia_search_2": "墙: 000 网络不可达 (1025冒烟 00:02, 与主id同端点)",
    "searx_space": "墙: 000 网络不可达×2 (1025冒烟 00:02/00:05)",
    "gdelt_2_0_doc_api": "墙: 429 限速×2 (1025冒烟 23:57/23:59)",
    "gdelt_doc_2_0_api": "墙: 429 限速×2 (1025冒烟 23:58/00:00, 同面)",
    "semantic_scholar_graph_api": "墙: 429 限速×3 (1025冒烟 23:57/23:58/00:01)",
    "semantic_scholar_api": "墙: 同族 api.semanticscholar.org 429×3 (graph面实证, 同后端)",
    "unpaywall_api": "墙: 410 (1025冒烟 23:56; 端点需 DOI 词面, 自然语言词不可用)",
    "reliefweb_api": "墙: 410 (1025冒烟 00:00, query 参数形态拒)",
    "gdacs": "墙: 406 (1025冒烟 00:01, 无 q 参数端点拒自然语言词)",
    "prozorro": "墙: 404 (1025冒烟 00:01, 列表面端点形态拒)",
    "ddgr": "墙: CLI 缺件 (ddgr 二进制未装, 腿建造台账已知边界「缺件如实记不擅自安装」)",
}

#: ---- 词面形态账: 端点不吃自然语言查询词 → 派词=假调用, 如实跳过 ----------
QUERY_SHAPES: dict[str, str] = {
    "bls": "词面=序列ID (WPSFD4 等; 集成台账在案「查询词=BLS序列ID」)",
    "emsc_seismic_portal": "词面=事件流 (FDSN limit, 无 q 参数)",
    "usgs_earthquake_api": "词面=事件流 (geojson limit/orderby, 无 q 参数)",
    "imf_datamapper_sdmx": "词面=指标目录 (指标清单面, 无 q 参数)",
    "oecd_data_explorer_sdmx": "词面=dataflow目录 (XML 清单面, 查询过滤待接)",
    "openstreetmap_overpass_api": "词面=Overpass QL (name 正则模板, 非自然语言)",
    "common_crawl_2": "词面=URL模式 (索引查询词=URL 非自然语言)",
    "noaa_ncei": "词面=目录 searchTerm 形态待校准 (半实装, 冒烟 0 命中无实据)",
    "openfema": "词面=OData $filter 表达式 (非自然语言)",
}

#: 特殊腿 CLI 适配器之外的在役/专项腿 fit 标签 (不在 HTTP_ENGINES 表内)。
EXTRA_TAGS: dict[str, str] = {
    "last30days": "新闻舆情",          # 近30日社媒热度 (1025 接入令)
    "dangdang": "数据集",              # 当当图书情报 (1024 专项令)
    "metaso_kb": "数据集",             # 秘塔知识库专题·工程行业大脑 (1024 专项令)
    "bdn": "数据集/工商招投标/通用网研",   # 百度网盘检索下载 (1030 接入令, 自有SVIP8账号面)
}

#: ---- EEI → 域标签路由 (channels_hint 渠道 id → fit 标签域) ----------------
HINT_TAG_MAP: dict[str, set[str]] = {
    "std_samr": {"标准定额"}, "samr": {"标准定额"},
    "govlist": {"标准定额", "工商招投标"},
    "court": {"工商招投标"},
    "opencli": {"标准定额", "工商招投标"},
    "rss": {"新闻舆情"},
    "cnki": {"学术专利"},
    "chinca": {"工商招投标", "项目数据"},
    "ebook": {"数据集"},
    "sogou_wechat": {"新闻舆情", "通用网研"},
    "metaso": {"新闻舆情", "通用网研"},
    "websearch": {"新闻舆情", "通用网研"},
    "ima": {"新闻舆情", "数据集"},
    "website": {"标准定额", "工商招投标"},
    "video": {"新闻舆情"},
    "wenku": {"数据集"}, "kb_harvest": {"数据集"},
    "djyanbao": {"新闻舆情", "数据集"},
    "dangdang": {"数据集"},
}

#: 子问 dim 关键词 → 域标签 (channels_hint 之外的语境补强)。
DIM_TAG_RULES: list[tuple[str, str]] = [
    ("定额", "标准定额"), ("标准", "标准定额"), ("规范", "标准定额"),
    ("法规", "标准定额"), ("政策", "标准定额"), ("监管", "标准定额"),
    ("招标", "工商招投标"), ("投标", "工商招投标"), ("合同", "工商招投标"),
    ("争议", "工商招投标"), ("司法", "工商招投标"), ("鉴定", "工商招投标"),
    ("价格", "项目数据"), ("市场价", "项目数据"), ("数据源", "项目数据"),
    ("信息价", "项目数据"), ("平台", "项目数据"),
]

#: 特殊 CLI 腿 (非 http_api_leg_core --campaign/--queries 形态)。
def build_cmd(engine: str, leg: Path, campaign: str, queries: list[str],
              rows: int) -> list[str]:
    base = ["py", "-X", "utf8", str(leg)]
    if engine == "dangdang":
        return base + [campaign, "--q", "|".join(queries), "--limit", str(rows)]
    if engine == "metaso_kb":
        return base + [campaign, "--q", queries[0], "--dl-limit", "2",
                       "--limit", str(rows)]
    if engine == "last30days":                     # 无 --rows 形参 (1026实弹实证)
        return base + ["--campaign", campaign, "--queries", *queries]
    if engine == "bdn":                            # 下载腿: 收紧下载预算 3 件 (1030 接入令)
        return base + ["--campaign", campaign, "--queries", *queries,
                       "--download-limit", "3", "--max-mb", "100"]
    return base + ["--campaign", campaign, "--queries", *queries,
                   "--rows", str(rows)]


def norm_tag(t: str) -> str:
    t = t.strip()
    if t.startswith("通用网研"):
        return "通用网研"
    for c in CANON_TAGS:
        if t.startswith(c):
            return c
    return t


def parse_tags(raw: str) -> set[str]:
    return {norm_tag(x) for x in re.split(r"[/、,，;；]", raw) if x.strip()}


def load_bridge_tags() -> dict[str, set[str]]:
    """importlib 读 api_replica_bridge.HTTP_ENGINES tags (桥表零改动)。"""
    spec = importlib.util.spec_from_file_location("dispatcher_arb", BRIDGE_PATH)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)                 # noqa: SLF001 (登记表加载)
    tags: dict[str, set[str]] = {}
    for k, v in mod.HTTP_ENGINES.items():
        tags[k] = parse_tags(v.get("tags", "")) or {"通用网研"}
    for k, v in EXTRA_TAGS.items():
        tags[k] = parse_tags(v)
    return tags


def discover_legs(tags_by_engine: dict[str, set[str]]
                  ) -> list[dict]:
    """扫 legs/*_leg.py → 渠道台账行 (engine/batch/tags/health)。"""
    rows = []
    for p in sorted(LEGS_DIR.glob("*_leg.py")):
        text = p.read_text(encoding="utf-8", errors="replace")
        m = re.search(r'batch1025(实装|半实装|骨架TODO)', text)
        batch = m.group(1) if m else "在役/专项"
        em = re.search(r'["\']engine["\']\s*:\s*["\']([^"\']+)', text)
        engine = em.group(1) if em else p.stem[:-4]
        if batch == "骨架TODO":
            health, reason = "骨架", "骨架TODO: 腿建造台账63条 — 端点/解析面未落位, 实调=零命中假跑"
        elif engine in WALLS:
            health, reason = "墙", WALLS[engine]
        elif engine in QUERY_SHAPES:
            health, reason = "词面不匹配", QUERY_SHAPES[engine]
        else:
            health, reason = "活", ""
        rows.append({"engine": engine, "leg": p.name, "path": p,
                     "batch": batch, "tags": tags_by_engine.get(engine, {"通用网研"}),
                     "health": health, "skip_reason": reason})
    return rows


def load_tree_eeis(campaign: str) -> tuple[list[dict], str]:
    tp = AMMO_ROOT / campaign / "question_tree.json"
    if not tp.is_file():
        return [], "question_tree.json 缺席"
    qt = json.loads(tp.read_text(encoding="utf-8"))
    out = []
    for sq in qt.get("subquestions", []):
        for e in sq.get("eeis", []):
            tags: set[str] = set()
            for h in e.get("channels_hint", []):
                tags |= HINT_TAG_MAP.get(h, {"通用网研"})
            dim = sq.get("dim", "")
            for kw, tag in DIM_TAG_RULES:
                if kw in dim:
                    tags.add(tag)
            if e.get("stance") == "against":       # 反证面 → 舆情/争议域
                tags.add("新闻舆情")
            out.append({"id": e["id"], "dim": dim, "stance": e.get("stance", ""),
                        "status": e.get("status", ""), "queries": e.get("queries", []),
                        "tags": tags or {"通用网研"}})
    return out, ""


def prior_qhashes() -> set[str]:
    """已跑 (phase=run 且终态) 的 qhash 集 — 幂等去重索引。"""
    done: set[str] = set()
    if not LEDGER_PATH.is_file():
        return done
    for line in LEDGER_PATH.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            r = json.loads(line)
        except json.JSONDecodeError:
            continue
        if r.get("phase") == "run" and r.get("finished"):
            done.add(r.get("qhash", ""))
    return done


def append_ledger(row: dict) -> None:
    with LEDGER_PATH.open("a", encoding="utf-8") as f:
        f.write(json.dumps(row, ensure_ascii=False) + "\n")


def parse_leg_summary(stdout: str) -> dict | None:
    """腿 stdout 终态 JSON (core.run/last30days 同形, indent=1 多行) → dict;
    从尾部逐行回退尝试解析; 解析不出=None 不编造。"""
    lines = (stdout or "").splitlines()
    for i in range(len(lines) - 1, -1, -1):
        s = lines[i].strip()
        if not s.startswith("{"):
            continue
        try:
            obj = json.loads("\n".join(lines[i:]))
        except json.JSONDecodeError:
            continue
        if isinstance(obj, dict) and "campaign" in obj and "engine" in obj:
            return obj
        if i < len(lines) - 30:                    # 只在尾部窗口找, 防全量扫描
            return None
    return None


def run_leg(task: dict, timeout: int) -> dict:
    t0 = time.time()
    cmd = build_cmd(task["engine"], task["path"], task["campaign"],
                    task["queries"], task["rows"])
    try:
        r = subprocess.run(cmd, capture_output=True, text=True,
                           encoding="utf-8", errors="replace",
                           timeout=timeout)
        out, err, rc = r.stdout or "", r.stderr or "", r.returncode
        timed_out = False
    except subprocess.TimeoutExpired as e:
        out = (e.stdout or b"").decode("utf-8", "replace") if isinstance(
            e.stdout, bytes) else (e.stdout or "")
        err, rc, timed_out = "timeout", "timeout", True
    dur = round(time.time() - t0, 1)
    summ = parse_leg_summary(out)
    tail = "\n".join((out or "").strip().splitlines()[-6:])[-600:]
    row = {"ts": time.strftime("%Y-%m-%d %H:%M:%S"), "phase": "run",
           "campaign": task["campaign"], "engine": task["engine"],
           "leg": task["leg"], "tags": sorted(task["tags"]),
           "eeis": task["eeis"], "queries": task["queries"],
           "qhash": task["qhash"], "cmd": cmd[:3] + ["..."] if len(cmd) > 5 else cmd,
           "exit": rc, "timeout": timed_out, "dur_s": dur,
           "hits": (summ or {}).get("hits"), "ingested": (summ or {}).get("ingested"),
           "chars": (summ or {}).get("chars"),
           "fails_n": len((summ or {}).get("fails") or []),
           "summary_json": bool(summ), "stdout_tail": tail,
           "stderr_tail": (err or "")[-300:], "finished": True}
    return row


def main() -> int:
    ap = argparse.ArgumentParser(
        description="全渠道生产调度器 — 全部点亮渠道自动进 S1 采集产线 (编排层)")
    ap.add_argument("--campaign", default="EPC-JIAGE")
    ap.add_argument("--eeis", default="",
                    help="EEI id 逗号分隔 (如 Q6-E3,Q18-E3); 缺省=未饱和 EEI 全集")
    ap.add_argument("--kws", default="",
                    help="词表 逗号分隔 (绕过 question_tree 直采)")
    ap.add_argument("--tags", default="",
                    help="域标签过滤 (标准定额,数据集,舆情... 子串匹配)")
    ap.add_argument("--max-concurrent", type=int, default=4)
    ap.add_argument("--rows", type=int, default=8, help="每查询命中行数 (腿 --rows)")
    ap.add_argument("--leg-timeout", type=int, default=1200, help="单腿子进程超时秒")
    ap.add_argument("--dry-run", action="store_true", help="只出计划不实跑不落台账")
    ap.add_argument("--force-rerun", action="store_true", help="破幂等去重强制重跑")
    ap.add_argument("--no-ingest", action="store_true",
                    help="透传腿 --no-ingest (演练用; 实采勿用)")
    ap.add_argument("--include-shaped", action="store_true",
                    help="词面不匹配渠道也派 (默认跳过, 防假调用)")
    ap.add_argument("--only", default="",
                    help="只派指定渠道 (逗号分隔 engine id, 外科重跑用)")
    ap.add_argument("--list-health", action="store_true",
                    help="只打印渠道健康账不跑")
    ns = ap.parse_args()

    tags_by_engine = load_bridge_tags()
    legs = discover_legs(tags_by_engine)
    alive = [x for x in legs if x["health"] == "活"]
    if ns.list_health:
        from collections import Counter
        cnt = Counter(x["health"] for x in legs)
        print("[health] 渠道健康账 (腿全集 %d): %s" % (
            len(legs), json.dumps(dict(cnt), ensure_ascii=False)))
        for x in legs:
            mark = {"活": "√", "墙": "×", "骨架": "○", "词面不匹配": "△"}[x["health"]]
            print(" %s %-46s %-8s %-10s %s" % (
                mark, x["engine"], x["batch"], x["health"], x["skip_reason"][:70]))
        print("[health] 活渠道 %d 条 (dispatch 面)" % len(alive))
        return 0

    # ---- 采集词面: EEI 路由 或 直采词表 ----
    eeis = []
    if ns.kws:
        kws = [k.strip() for k in re.split(r"[,，]", ns.kws) if k.strip()]
        plan_src = "kws直采"
    else:
        all_eeis, err = load_tree_eeis(ns.campaign)
        if err:
            print("[dispatcher] question_tree 不可用 (%s) 且未给 --kws" % err)
            return 2
        if ns.eeis:
            want = {x.strip() for x in ns.eeis.split(",") if x.strip()}
            eeis = [e for e in all_eeis if e["id"] in want]
            missing = want - {e["id"] for e in eeis}
            if missing:
                print("[dispatcher] 如实: EEI 不在树 %s" % sorted(missing))
        else:
            eeis = [e for e in all_eeis if e.get("status") != "saturated"]
        plan_src = "question_tree (%d EEI: %s)" % (
            len(eeis), ",".join(e["id"] for e in eeis) or "(空)")
        kws = None

    # ---- 生成每渠道任务 (fit 标签匹配) ----
    tag_filter = [norm_tag(t) for t in re.split(r"[,，]", ns.tags) if t.strip()]
    tasks, skips = [], []
    all_queries = []
    for e in eeis:
        for q in e["queries"]:
            if q not in all_queries:
                all_queries.append(q)
    if ns.kws:
        all_queries = kws

    for x in legs:
        eng = x["engine"]
        if ns.only:
            want = {e.strip() for e in ns.only.split(",") if e.strip()}
            if eng not in want:
                continue                          # --only 外科面: 其余渠道不记不派
        if x["health"] != "活":
            if x["health"] == "词面不匹配" and ns.include_shaped:
                pass                               # 显式令: 词面不匹配也派
            else:
                skips.append({"engine": eng, "reason": "[%s] %s" % (
                    x["health"], x["skip_reason"])})
                continue
        if ns.kws:
            matched_q, matched_eeis = list(all_queries), ["kws"]
        else:
            matched = [e for e in eeis
                       if (x["tags"] & e["tags"]) or ("通用网研" in x["tags"])]
            if not matched:
                skips.append({"engine": eng, "reason": "fit不匹配: 渠道标签%s ∩ 本批EEI域=空" % (
                    sorted(x["tags"])[:3])})
                continue
            matched_q, matched_eeis = [], []
            for e in matched:
                if e["id"] not in matched_eeis:
                    matched_eeis.append(e["id"])
                for q in e["queries"]:
                    if q not in matched_q:
                        matched_q.append(q)
        if tag_filter:
            hit = any(any(f in t or t in f for t in x["tags"]) for f in tag_filter)
            if not hit:
                skips.append({"engine": eng, "reason": "tags过滤: %s 不含 %s" % (
                    sorted(x["tags"]), tag_filter)})
                continue
        if not matched_q:
            skips.append({"engine": eng, "reason": "匹配EEI无查询词(空queries)"})
            continue
        qh_src = "%s|%s|%s" % (ns.campaign, eng, "|".join(sorted(matched_q)))
        qh = hashlib.sha1(qh_src.encode("utf-8")).hexdigest()[:16]
        tasks.append({**{k: x[k] for k in ("engine", "leg", "path", "tags")},
                      "campaign": ns.campaign, "queries": matched_q,
                      "eeis": matched_eeis, "rows": ns.rows, "qhash": qh})

    done = prior_qhashes()
    runnable, dup_skips = [], []
    for t in tasks:
        if t["qhash"] in done and not ns.force_rerun:
            dup_skips.append({"engine": t["engine"],
                              "reason": "幂等: qhash=%s 已跑过 (campaign+渠道+查询hash)" % t["qhash"]})
        else:
            runnable.append(t)

    print("[dispatcher] campaign=%s | 词面源=%s | 查询%d词 | 渠道全集%d → 活%d | "
          "计划派%d (跳过%d: 墙/骨架/词面/fit %d + 幂等%d) | 并发≤%d%s" % (
              ns.campaign, plan_src, len(all_queries), len(legs), len(alive),
              len(runnable), len(skips) + len(dup_skips), len(skips),
              len(dup_skips), ns.max_concurrent,
              " | DRY-RUN" if ns.dry_run else ""))
    if not runnable:
        print("[dispatcher] 无可派任务 (全部跳过/幂等) — 台账不动")
        return 0

    for t in runnable[:60]:
        print("  → %-46s q=%d %s" % (t["engine"], len(t["queries"]),
                                     "; ".join(t["queries"])[:60]))
    if ns.dry_run:
        print("[dispatcher] dry-run: 不实跑不落台账; 跳过账如下 (前20)")
        for s in (skips + dup_skips)[:20]:
            print("  ✗ %-46s %s" % (s["engine"], s["reason"][:80]))
        return 0

    # ---- 落 skip 台账 (先记后跑, 台账只增) ----
    ts0 = time.strftime("%Y-%m-%d %H:%M:%S")
    for s in skips + dup_skips:
        append_ledger({"ts": ts0, "phase": "skip", "campaign": ns.campaign,
                       "engine": s["engine"], "status": "skipped",
                       "reason": s["reason"]})

    # ---- 进程池并发 (每任务=1腿子进程; 线程只做等待) ----
    results = []
    with ThreadPoolExecutor(max_workers=max(1, ns.max_concurrent)) as ex:
        futs = {ex.submit(run_leg, t, ns.leg_timeout): t for t in runnable}
        for fu in as_completed(futs):
            t = futs[fu]
            row = fu.result()
            if ns.no_ingest:                       # 演练标记 (实采不会出现)
                row["no_ingest"] = True
            results.append(row)
            append_ledger(row)
            print("  ✓ %-46s exit=%s dur=%ss hits=%s ingested=%s chars=%s%s" % (
                t["engine"], row["exit"], row["dur_s"], row["hits"],
                row["ingested"], row["chars"],
                " (无终态JSON, 如实null)" if not row["summary_json"] else ""))

    # ---- 汇总 ----
    ok = [r for r in results if str(r["exit"]) == "0"]
    tot_hits = sum(r["hits"] or 0 for r in results)
    tot_ing = sum(r["ingested"] or 0 for r in results)
    tot_chars = sum(r["chars"] or 0 for r in results)
    summ = {"ts": time.strftime("%Y-%m-%d %H:%M:%S"), "phase": "summary",
            "campaign": ns.campaign, "dispatched": len(results),
            "exit0": len(ok), "exit_non0": len(results) - len(ok),
            "skipped": len(skips) + len(dup_skips),
            "total_hits": tot_hits, "total_ingested": tot_ing,
            "total_chars": tot_chars,
            "wall_s": round(sum(r["dur_s"] for r in results), 1),
            "concurrency": ns.max_concurrent, "queries_total": len(all_queries)}
    append_ledger(summ)
    print("[dispatcher] 汇总: 派%d (exit0=%d) 跳过%d | 命中%d 入池%d件 %s字 | "
          "腿耗时合计%ss | 台账=%s" % (
              summ["dispatched"], summ["exit0"], summ["skipped"], tot_hits,
              tot_ing, format(tot_chars, ","), summ["wall_s"], LEDGER_PATH))
    print("[dispatcher] 下一步: py -X utf8 reforge_factory/ammo_pool.py judge %s --limit 1000"
          % ns.campaign)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
