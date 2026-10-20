# -*- coding: utf-8 -*-
"""EPC-SCHED 存量并入班 v1 (1020) — 工期/延误/索赔口径强相关收割.

复刻 epc49_stock_ingest.py v2 已验证模式 (绝不凑数两级判定 + NB切篇 +
幂等双查重), 判定词表换 SCHED 口径:
  L1 强词: T1 工期族 (工期延误/顺延/签证/赶工/停工损失/网络计划/关键线路/
           进度偏差/施工组织设计/工期管理/进度管理/延误索赔)
  L2 泛词: 工期/进度/索赔/顺延/停工/延误/签证 + 工程语境词共现才算,
           单独命中=rejected (绝不凑数令)
源: NB_MD_library_v2 68卷 + 10战役战场(02/04/60) + 04智库 + 49池80_存量.
引擎 stock:* 前缀 → C轴 corpus_stores (存量语料库) 渠道点亮.
"""
import io
import json
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

sys.path.insert(0, r"E:\AI-Station\reforge_factory")
import ammo_pool as ap  # noqa: E402

CODE_VERSION = "sched-stock-v1"
CID = "EPC-SCHED"
ENG = Path(r"E:\AI-Station\ResearchFactory-Eng")
TOPICS = ENG / "ResearchTopics"
STATION = Path(r"E:\AI-Station")
BLOCK_HEAD = "\n\n---\n\n# "

CAMPAIGNS = [
    "《上海电力设计院有限公司怎么干EPC总承包？》",
    "《中冶长天国际工程有限责任公司怎么干EPC总承包？》",
    "《中国电子工程设计院股份有限公司怎么干EPC总承包？》",
    "《中国电建集团海南电力设计研究院有限公司怎么干EPC总承包？》",
    "《中国能源建设集团安徽省电力设计院有限公司怎么干EPC总承包？》",
    "《中国能源建设集团山西省电力勘测设计院有限公司怎么干EPC总承包？》",
    "《中国能源建设集团湖南省电力设计院有限公司怎么干EPC总承包？》",
    "《北京首钢国际工程技术有限公司怎么干EPC总承包？》",
    "《中石化南京工程有限公司怎么干EPC总承包？》",
    "《四川电力设计咨询有限责任公司怎么干EPC总承包？》",
]
SUB_PREFIX = ("02", "04", "60")

L1_KWS = [
    "工期延误", "工期顺延", "延误索赔", "赶工", "停工损失", "工期签证",
    "网络计划", "关键线路", "进度偏差", "施工组织设计", "工期管理",
    "进度管理",
]
L2_PAN = ["工期", "进度", "索赔", "顺延", "停工", "延误", "签证"]
L2_CTX = ["工程", "施工", "合同", "项目", "EPC", "总承包", "建筑", "监理"]

SKIP_SUFFIX = {".json", ".tmp", ".crdownload", ".part", ".png", ".jpg",
               ".jpeg", ".gif", ".zip", ".rar", ".7z", ".exe", ".dll",
               ".mp4", ".mp3"}


def judge_stock(text: str) -> tuple:
    """两级判定: L1 强词任一命中=valid; L2 泛词+语境共现=valid;
    否则 rejected(stock_offtopic) — 绝不凑数令."""
    head = text[:8000]
    if any(k in head for k in L1_KWS):
        return "valid", "stock_L1"
    pan = [k for k in L2_PAN if k in head]
    if pan and any(c in head for c in L2_CTX):
        return "valid", f"stock_L2+{pan[0]}"
    return "rejected", "stock_offtopic"


def iter_files(d: Path):
    for f in sorted(d.rglob("*")):
        if f.is_file() and f.suffix.lower() not in SKIP_SUFFIX:
            yield f


class Ledger:
    """manifest 追加器: 路径+内容指纹双查重, 幂等."""

    def __init__(self, camp: Path):
        self.camp = camp
        self.mp = camp / "manifest.jsonl"
        self.paths = set()
        self.keys = set()
        for x in self.mp.read_text(encoding="utf-8").splitlines():
            if x.strip():
                r = json.loads(x)
                self.paths.add(r.get("source_path"))
                self.keys.add(r.get("dedup_key"))

    def add(self, engine: str, src: str, text: str, stats: dict) -> None:
        if src in self.paths:
            stats["dup_path"] += 1
            return
        if len(text) < 50:
            stats["skip_short"] += 1
            return
        key = ap.dedup_key(None, text)
        if key in self.keys:
            stats["dup_content"] += 1
            return
        verdict, reason = judge_stock(text)
        ch = ap.count_chars(text)
        row = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
               "engine": engine, "source_path": src, "url_norm": "",
               "chars": ch, "credibility": "archive", "dedup_key": key,
               "judge": verdict, "judge_reason": reason,
               "judge_engine": "stock2level", "tree_node": "",
               "stance": "support", "grade": "B",
               "text_head": text[:500]}
        with ap._pool_lock(self.camp):
            with self.mp.open("a", encoding="utf-8") as fh:
                fh.write(json.dumps(row, ensure_ascii=False) + "\n")
        self.paths.add(src)
        self.keys.add(key)
        stats[verdict] += 1
        stats[f"{verdict}_chars"] += ch


def ingest_nb_volumes(led: Ledger, stats: dict) -> None:
    """NB v2 库: 68 卷切篇逐条 (整卷判会被卷头第一篇污染)."""
    nb2 = ENG / "NB_MD_library_v2"
    if not nb2.is_dir():
        return
    for fp in sorted(nb2.glob("*.md")):
        raw = fp.read_text(encoding="utf-8", errors="replace")
        segs = raw.split(BLOCK_HEAD)
        for seg in segs[1:]:
            nl = seg.find("\n", 1)
            title = seg[:nl].strip() if nl > 0 else seg.strip()[:60]
            led.add("stock:nb_library",
                    f"{fp.name}#{title[:70]}", BLOCK_HEAD + seg, stats)
        print(f"[NB卷] {fp.name}: 累计 valid {stats['valid']:,}字", flush=True)


def main() -> int:
    print(f"[{CODE_VERSION}] SCHED 存量并入班启动 {time.strftime('%F %T')}",
          flush=True)
    camp = ap._camp_dir(CID)
    if not camp.is_dir():
        print(f"[stock] 战役池不存在: {CID}", file=sys.stderr)
        return 1
    led = Ledger(camp)

    jobs = []
    for name in CAMPAIGNS:
        b = TOPICS / name
        if not b.is_dir():
            continue
        tag = "stock:campaign_" + name[1:7]
        for sub in sorted(b.iterdir()):
            if sub.is_dir() and sub.name.startswith(SUB_PREFIX):
                jobs.append((sub, tag))
    zk = STATION / "04 智库"
    if zk.is_dir():
        jobs.append((zk, "stock:zhiku"))

    t0 = time.time()
    stats = {"valid": 0, "valid_chars": 0, "rejected": 0,
             "rejected_chars": 0, "dup_path": 0, "dup_content": 0,
             "skip_short": 0, "fail": 0}
    ingest_nb_volumes(led, stats)
    for d, engine in jobs:
        print(f"[开吃] {engine}: {d.name}", flush=True)
        for f in iter_files(d):
            try:
                text = ap.read_text_safe(f)
                led.add(engine, str(f), text, stats)
            except Exception as e:  # noqa: BLE001
                stats["fail"] += 1
                if stats["fail"] <= 8:
                    print(f"[fail] {f.name[:50]}: {type(e).__name__}", flush=True)
            n = (stats["valid"] + stats["rejected"] + stats["dup_path"]
                 + stats["dup_content"] + stats["skip_short"] + stats["fail"])
            if n % 1000 == 0:
                print(f"[进度] {n}件 | valid {stats['valid']:,}件/"
                      f"{stats['valid_chars']:,}字 | rej {stats['rejected']} | "
                      f"重复P{stats['dup_path']}/C{stats['dup_content']} | "
                      f"{time.time()-t0:.0f}s", flush=True)
        print(f"[收] {engine}: valid累计 {stats['valid']:,}件/"
              f"{stats['valid_chars']:,}字 ({time.time()-t0:.0f}s)", flush=True)
    ap.rebuild(CID)
    s = json.loads((camp / "pool_state.json").read_text(encoding="utf-8"))
    print(f"[门槛账] 有效弹药 {s['total_chars']:,} 字 | "
          f"待审 {s['pending_chars']:,} | 废弃 {s['rejected_chars']:,} | "
          f"引擎 {len(s['by_engine'])} 个", flush=True)
    print(f"[{CODE_VERSION}] 全部完成 {time.strftime('%F %T')}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
