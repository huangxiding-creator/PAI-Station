# -*- coding: utf-8 -*-
"""wenshu_harvest.py — 裁判文书BT落地件筛选入池腿 (1004兜底火力配套).

工艺 (产能评估wf_c3e91f86定标 + cncases/cases 免解压思路):
  年zip直读(zipfile) → 月CSV流式(csv.reader) → 两级判定(复用stock班
  epc49_stock_ingest 的 L1/L2 词表与 judge_stock, 绝不凑数令同款) →
  命中判决合成篇 → 双轨输出:
    ① manifest 直写 (engine=wenshu, credibility=official, grade=A)
       — 门槛账即时入账, 不走 02 目录+入账班间接层 (大卷判定失真坑)
    ② 月卷 md 落 02/53_裁判文书/ (BLOCK_HEAD 分篇, NB 装包素材)

幂等: state json 记已处理 zip+csv; 断点: 每月CSV完即存.
判定: L1 强词单过 / L2 泛词×工程语境共现; 案由列预筛(建设工程/招标投标/
工程)提高流速; 编码 utf-8→gbk 双试.
"""
import csv
import io
csv.field_size_limit(16 * 2 ** 20)  # 1006: 裁判文书全文列超131072默认限(实测崩点)
import json
import sys
import time
import zipfile
import zlib
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from epc49_stock_ingest import L1_KWS, judge_stock  # noqa: E402,E402
import ammo_pool as ap  # noqa: E402

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

CID = "EPC49-SEPDC"
BT_DIR = Path(r"E:\wenshu_bt\裁判文书全量数据（已完成）")
STATE = Path(r"E:\AI-Station\tools\wenshu_harvest_state.json")
BATTLE = (Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics")
          / "《四川电力设计咨询有限责任公司怎么干EPC总承包？》")
OUT = [d for d in BATTLE.iterdir() if d.name.startswith("02")][0] \
    / "53_裁判文书"
BLOCK_HEAD = "\n\n---\n\n# "

# 案由列预筛词 (案由级候选; 再过全文两级判定)
CAUSE_KWS = ("建设工程", "招标投标", "工程", "电力", "建筑")
META_COLS = ("案号", "案件名称", "法院", "所属地区", "案件类型",
             "审理程序", "裁判日期", "当事人", "案由")


def load_state() -> dict:
    if STATE.exists():
        return json.loads(STATE.read_text(encoding="utf-8"))
    return {"done_csv": [], "stats": {}}


def save_state(st: dict) -> None:
    STATE.write_text(json.dumps(st, ensure_ascii=False, indent=1),
                     encoding="utf-8")


class PoolWriter:
    """manifest 追加器 (与 stock 班同款幂等: 路径+指纹双查重)."""

    def __init__(self):
        self.camp = ap._camp_dir(CID)
        self.mp = self.camp / "manifest.jsonl"
        self.paths = set()
        self.keys = set()
        for x in self.mp.read_text(encoding="utf-8").splitlines():
            if x.strip():
                r = json.loads(x)
                self.paths.add(r.get("source_path"))
                self.keys.add(r.get("dedup_key"))

    def add(self, src: str, text: str, stats: dict) -> str:
        if src in self.paths:
            return "dup_path"
        key = ap.dedup_key(None, text)
        if key in self.keys:
            stats["dup"] += 1
            return "dup"
        verdict, reason = judge_stock(text, L1_KWS)
        ch = ap.count_chars(text)
        row = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
               "engine": "wenshu", "source_path": src, "url_norm": "",
               "chars": ch, "credibility": "official", "dedup_key": key,
               "judge": verdict, "judge_reason": reason,
               "judge_engine": "stock2level", "tree_node": "",
               "stance": "support", "grade": "A"}
        with ap._pool_lock(self.camp):
            with self.mp.open("a", encoding="utf-8") as fh:
                fh.write(json.dumps(row, ensure_ascii=False) + "\n")
        self.paths.add(src)
        self.keys.add(key)
        stats[verdict] = stats.get(verdict, 0) + 1
        stats[f"{verdict}_chars"] = stats.get(f"{verdict}_chars", 0) + ch
        return verdict


def sniff_cols(header: list) -> dict:
    """动态定位列: 案由/全文/元数据列 (各年卷列名可能漂移)."""
    idx = {}
    for i, h in enumerate(header):
        hs = (h or "").strip()
        if not hs:
            continue
        if "案由" in hs:
            idx["cause"] = i
        elif "全文" in hs or "正文" in hs or "文书" in hs and "类型" not in hs:
            idx.setdefault("full", i)
    # 全文兜底: 未命中名则取 header 最宽泛位 (通常末列)
    if "full" not in idx:
        idx["full"] = len(header) - 1
    for m in META_COLS:
        for i, h in enumerate(header):
            if m in (h or ""):
                idx[f"m_{m}"] = i
                break
    return idx


def month_key(name: str) -> str:
    """月CSV文件名 → 月标识 (1995年1月.csv / 01.csv 等形态兼容)."""
    import re
    m = re.search(r"(\d{4})\D*(\d{1,2})", name)
    return f"{m.group(1)}_{int(m.group(2)):02d}" if m else name[:-4]


def harvest_csv(zf: zipfile.ZipFile, item: zipfile.ZipInfo,
                pool: PoolWriter, stats: dict, vol: list) -> int:
    raw = zf.read(item.filename)
    text = None
    for enc in ("utf-8-sig", "utf-8", "gbk", "gb18030"):
        try:
            text = raw.decode(enc)
            if text and text.count("�") < len(text) * 0.01:
                break
        except (UnicodeDecodeError, LookupError):
            text = None
    if not text:
        stats["bad_enc"] += 1
        return 0
    rdr = csv.reader(io.StringIO(text))
    try:
        header = next(rdr)
    except StopIteration:
        return 0
    idx = sniff_cols(header)
    n = 0
    mk = month_key(Path(item.filename).name)
    for row in rdr:
        if len(row) <= max(idx.get("cause", 0), idx["full"]):
            continue
        cause = row[idx["cause"]] if "cause" in idx else ""
        full = row[idx["full"]] or ""
        if len(full) < 200:  # 短桩/空文书跳过
            continue
        # 案由预筛: 命中候选案由才进两级判定 (流速优化, 不放宽判定本身)
        if not any(k in cause for k in CAUSE_KWS):
            stats["cause_pass"] += 1
            continue
        title = (row[idx["m_案件名称"]] if "m_案件名称" in idx
                 else cause)[:80]
        meta = [f"{m}: {row[idx[f'm_{m}']]}" for m in META_COLS
                if f"m_{m}" in idx and idx[f"m_{m}"] < len(row)
                and row[idx[f"m_{m}"]]]
        art = BLOCK_HEAD + f"{title}\n\n" + "\n".join(meta) + "\n\n" + full
        verdict = pool.add(f"wenshu:{mk}:{title}", art, stats)
        if verdict == "valid":  # 月卷只收过审篇 (绝不凑数令)
            vol.append(art)
            n += 1
    return n


def main() -> int:
    print(f"[wenshu-harvest] 启动 {time.strftime('%F %T')}", flush=True)
    st = load_state()
    done = set(st["done_csv"])
    pool = PoolWriter()
    stats = {"dup": 0, "bad_enc": 0, "cause_pass": 0,
             "valid": 0, "valid_chars": 0, "rejected": 0}
    OUT.mkdir(parents=True, exist_ok=True)
    zips = sorted(BT_DIR.glob("*.zip"))
    print(f"[发现] {len(zips)} 个年zip", flush=True)
    for zp in zips:
        if zp.stat().st_size < 1000:  # BT未完成的占位zip跳过
            stats["bad_enc"] = stats.get("bad_enc", 0)
            continue
        try:
            zf_in = zipfile.ZipFile(zp)
        except zipfile.BadZipFile:
            print(f"[skip] 坏zip: {zp.name}", flush=True)
            continue
        with zf_in as zf:
            csvs = [i for i in zf.infolist()
                    if i.filename.lower().endswith(".csv")]
            for it in csvs:
                if it.filename in done:
                    continue
                vol = []
                t0 = time.time()
                try:  # BT未完成条目: 中央目录在但数据段缺 → 跳过整卷待下轮
                    n = harvest_csv(zf, it, pool, stats, vol)
                except (zipfile.BadZipFile, OSError, RuntimeError,
                        zlib.error) as e:
                    print(f"[未完整] {zp.name}: {type(e).__name__} — "
                          f"跳过待下轮", flush=True)
                    break
                if vol:  # 月卷落盘 (NB 装包素材; 只收过审篇)
                    (OUT / f"判决_{month_key(it.filename)}.md").write_text(
                        f"# 裁判文书 {month_key(it.filename)}"
                        f"（{len(vol)}篇 EPC相关）\n" + "".join(vol),
                        encoding="utf-8", newline="\n")
                done.add(it.filename)
                st["done_csv"] = list(done)
                save_state(st)
                print(f"[{it.filename[:40]}] 候选{n} | 累计 valid "
                      f"{stats['valid']}/{stats['valid_chars']:,}字 | "
                      f"rej {stats['rejected']} | dup {stats['dup']} | "
                      f"案由过筛 {stats['cause_pass']} | "
                      f"{time.time()-t0:.0f}s", flush=True)
    ap.rebuild(CID)
    s = json.loads((ap._camp_dir(CID) / "pool_state.json")
                   .read_text(encoding="utf-8"))
    print(f"[门槛账] 有效弹药 {s['total_chars']:,} 字 "
          f"({100*s['total_chars']/200_000_000:.2f}% of 2亿)", flush=True)
    print("[wenshu-harvest] 完成", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
