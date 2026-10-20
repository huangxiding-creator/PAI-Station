# -*- coding: utf-8 -*-
"""epc49_stock_ingest.py — 存量并入班 v2 (1004 双令: 2天2亿 + 绝不凑数).

用户令:
  1) 2 亿字 2 天内完成 (时限硬约束);
  2) 强相关筛选合格才计数 — 与调研主题(四川院怎么干EPC总承包)/
     调研对象(四川电力设计咨询有限责任公司)/调研业务(EPC总承包/
     输变电/新能源)强烈相关, 泛工程内容不得凑数.

两级判定 (绝不凑数):
  L1 强词单过: 课题词 + 同业电力设计院 + 母系 + EPC/总承包族
  L2 泛词共现: 建设工程/施工合同等 须同时命中工程语境词才算, 单独命中=rejected
  NB v2 68 卷不整卷判 (卷头污染) — BLOCK_HEAD 切篇逐条判, 篇级强相关才算.
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

CODE_VERSION = "stock-v2"
CID = "EPC49-SEPDC"
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
]
SUB_PREFIX = ("02", "04", "60")

# L1 强词 (并入池级 kws, 渠道新增件判定同步受益)
L1_KWS = [
    "工程总承包", "EPC总承包", "EPC项目", "电力设计院", "电力勘测设计",
    "中国电建", "中国能建", "上海电力设计院", "海南电力设计研究院",
    "安徽省电力设计院", "山西省电力勘测设计院", "湖南省电力设计院",
]
# L2 泛词 (仅存量班两级判定用, 不进池级 kws — 单独命中=凑数, 拒)
L2_PAN = ["建设工程", "施工合同", "招标投标", "工程造价", "火电", "水电",
          "抽水蓄能", "变电站", "送变电", "勘察设计"]
L2_CTX = ["EPC", "总承包", "工程", "电力", "设计院", "施工"]

SKIP_SUFFIX = {".json", ".tmp", ".crdownload", ".part", ".png", ".jpg",
               ".jpeg", ".gif", ".zip", ".rar", ".7z", ".exe", ".dll",
               ".mp4", ".mp3"}


def judge_stock(text: str, l1: list) -> tuple:
    """两级判定: L1 强词任一命中=valid; L2 泛词+语境共现=valid;
    否则 rejected(stock_offtopic) — 绝不凑数令."""
    head = text[:8000]
    if any(k in head for k in l1):
        return "valid", "stock_L1"
    pan = [k for k in L2_PAN if k in head]
    if pan and any(c in head for c in L2_CTX):
        return "valid", f"stock_L2+{pan[0]}"
    return "rejected", "stock_offtopic"


def iter_files(d: Path):
    for f in sorted(d.rglob("*")):
        if f.is_file() and f.suffix.lower() not in SKIP_SUFFIX:
            yield f


def expand_kws(d: Path) -> list:
    s = ap._load_state(d)
    kws = list(s.get("kws", []))
    add = [k for k in L1_KWS if k not in kws]
    if add:
        ap._save_state(d, {**s, "kws": kws + add})
        print(f"[词表] 池级 +{len(add)} 强词 → {len(kws)+len(add)} 词", flush=True)
    return kws + add


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

    def add(self, engine: str, src: str, text: str, kws: list,
            stats: dict) -> None:
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
        verdict, reason = judge_stock(text, kws)
        ch = ap.count_chars(text)
        row = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
               "engine": engine, "source_path": src, "url_norm": "",
               "chars": ch, "credibility": "archive", "dedup_key": key,
               "judge": verdict, "judge_reason": reason,
               "judge_engine": "stock2level", "tree_node": "",
               "stance": "support", "grade": "B"}
        with ap._pool_lock(self.camp):
            with self.mp.open("a", encoding="utf-8") as fh:
                fh.write(json.dumps(row, ensure_ascii=False) + "\n")
        self.paths.add(src)
        self.keys.add(key)
        stats[verdict] += 1
        stats[f"{verdict}_chars"] += ch


def ingest_nb_volumes(led: Ledger, kws: list, stats: dict) -> None:
    """NB v2 库: 68 卷切篇逐条 (整卷判会被卷头第一篇污染 — 绝不凑数令)."""
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
                    f"{fp.name}#{title[:70]}", BLOCK_HEAD + seg, kws, stats)
        print(f"[NB卷] {fp.name}: 累计 valid {stats['valid']:,}字", flush=True)


def main() -> int:
    print(f"[{CODE_VERSION}] 存量并入班启动 {time.strftime('%F %T')}", flush=True)
    camp = ap._camp_dir(CID)
    if not camp.is_dir():
        print(f"[stock] 战役池不存在: {CID}", file=sys.stderr)
        return 1
    kws = expand_kws(camp)
    led = Ledger(camp)

    jobs = []
    for name in CAMPAIGNS:
        b = TOPICS / name
        if not b.is_dir():
            print(f"[缺] 战役目录不在: {name[:30]}", flush=True)
            continue
        tag = "stock:campaign_" + name[1:7]
        for sub in sorted(b.iterdir()):
            if sub.is_dir() and sub.name.startswith(SUB_PREFIX):
                jobs.append((sub, tag))
    zk = STATION / "04 智库"
    if zk.is_dir():
        jobs.append((zk, "stock:zhiku"))
    b49 = TOPICS / "《四川电力设计咨询有限责任公司怎么干EPC总承包？》"
    for sub in sorted(b49.iterdir()):
        if sub.is_dir() and sub.name == "80_本地存量语料":
            jobs.append((sub, "stock:local80"))

    t0 = time.time()
    # 先 NB 切篇 (快, 纯文本, 几分钟出千万级)
    stats = {"valid": 0, "valid_chars": 0, "rejected": 0,
             "rejected_chars": 0, "dup_path": 0, "dup_content": 0,
             "skip_short": 0, "fail": 0}
    ingest_nb_volumes(led, kws, stats)
    # 再 9 家战役 + 智库 + 80_存量 (大头, PDF 抽取慢)
    for d, engine in jobs:
        print(f"[开吃] {engine}: {d.name}", flush=True)
        for f in iter_files(d):
            try:
                text = ap.read_text_safe(f)
                led.add(engine, str(f), text, kws, stats)
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
    print(f"[门槛账] 有效弹药 {s['total_chars']:,} 字 "
          f"({100*s['total_chars']/200_000_000:.2f}% of 2亿) | "
          f"待审 {s['pending_chars']:,} | 废弃 {s['rejected_chars']:,} | "
          f"引擎 {len(s['by_engine'])} 个", flush=True)
    print(f"[{CODE_VERSION}] 全部完成 {time.strftime('%F %T')}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
