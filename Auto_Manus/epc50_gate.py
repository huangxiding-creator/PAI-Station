# -*- coding: utf-8 -*-
"""EPC50 弹药门 — 增量有效字数 1000 万门槛 (用户 09-24 令).

口径 (弹药门槛语义铁律 09-22 终版 + 09-24 战役令):
- 只算本次新增: 02 初次网络调研 + 04 网络调研搜集的资料;
  80_本地存量语料 = 存量, 不计门槛账 (成稿可引用, 门槛管计数不管引用);
  00 研究报告需求 = 需求文件非弹药, 不计.
- 全部 md 格式 (用户令): .md/.txt 直读; .pdf 走 pypdf 兜底计数 (历史件);
  其余类型落 skipped 出声不静默.
- 字数 = 去空白字符数.
- 机器只出账; 停不停/进不进下一环节由战役层读 verdict (passed=true 才放行).

用法: python epc50_gate.py [--watch 600]   # watch=每 N 秒重算落盘
"""
import argparse
import io
import json
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

BATTLE = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
              r"\《中石化南京工程有限公司怎么干EPC总承包？》")
REPORT = BATTLE / "_pipeline" / "epc50_gate_report.json"
CHAR_GATE = 10_000_000
# 增量口径: 计数的根; 80_本地存量语料 排除 (存量不计账)
COUNT_ROOTS = ("02 初次网络调研", "04 网络调研搜集的资料")
EXCLUDE_DIRS = {"80_本地存量语料"}

# 0924 用户令 (反编造铁律): Manus 是采集器不是作者 — 35_Manus军团 产物
# 必须带真实出处锚点 (URL) 才算有效弹药; 低引用密度 = 疑似编写/编造,
# 不计数只出声 (文件保留在盘, 复核属实后可人工转正).
import re as _re
_URL_RE = _re.compile(r"https?://")
MANUS_CHANNEL = "35_Manus军团"
CITE_CHARS_PER_URL = 2000   # 密度门: 每 2000 字 ≥1 条 http(s) 链接
CITE_MIN_URLS = 1           # 任何件至少 1 条


def _manus_cited_ok(text: str, n_chars: int) -> bool:
    """引用密度核验 — 搜集型资料库天然高密度带链接, 编写型叙事低/零链接."""
    urls = len(_URL_RE.findall(text))
    need = max(CITE_MIN_URLS, n_chars // CITE_CHARS_PER_URL)
    return urls >= need


def chars_of(path: Path) -> int:
    """去空白字符数; pdf 走 pypdf, 坏件抛错由调用方落 skipped."""
    suffix = path.suffix.lower()
    if suffix in (".md", ".txt"):
        return len("".join(path.read_text(encoding="utf-8",
                                          errors="replace").split()))
    if suffix == ".pdf":
        from pypdf import PdfReader
        reader = PdfReader(str(path))
        return sum(len("".join((page.extract_text() or "").split()))
                   for page in reader.pages)
    raise ValueError(f"uncounted type {suffix}")


# 0925 用户纠偏令×2: 研究对象原始资料占比过低 / ima 占比过高 —
# 弹药门增「构成比」账本: PRIMARY=关于中石化南京工程本体的原始资料;
# CONTEXT=方法论与行业背景 (ima/论文/政策/研报). 目标: PRIMARY ≥ 50%.
PRIMARY_DIRS = {
    "10_官网", "02 初次网络调研", "20_微信文章", "30_秘塔AI", "31_秘塔视频",
    "32_涉诉风控", "35_Manus军团", "50_官网资料", "52_官网深挖", "70_开放网络",
}


def count() -> dict:
    by_channel: dict[str, dict] = {}
    skipped: list[str] = []
    low_cite: list[dict] = []   # 0924 反编造门: 低引用 Manus 件 (不计数)
    low_cite_chars = 0
    legacy: list[dict] = []     # 0924 C1口径: 存量语料复用件 (不计门槛, 供引用)
    legacy_chars = 0
    total = 0
    file_count = 0
    for root in COUNT_ROOTS:
        d = BATTLE / root
        if not d.is_dir():
            continue
        for f in sorted(d.rglob("*")):
            if not f.is_file():
                continue
            rel = f.relative_to(d).parts
            if rel and rel[0] in EXCLUDE_DIRS:
                continue
            channel = rel[0] if root.startswith("04") else root
            slot = by_channel.setdefault(channel, {"chars": 0, "files": 0})
            file_count += 1
            try:
                if f.suffix.lower() in (".md", ".txt"):
                    text = f.read_text(encoding="utf-8", errors="replace")
                    n = len("".join(text.split()))
                    if "存量语料复用" in text[:500]:
                        legacy.append({"file": f.name, "chars": n})
                        legacy_chars += n
                        continue
                    if (channel == MANUS_CHANNEL
                            and not _manus_cited_ok(text, n)):
                        low_cite.append({"file": f.name, "chars": n})
                        low_cite_chars += n
                        continue
                else:
                    n = chars_of(f)
            except Exception as e:  # noqa: BLE001 — 坏件出声不炸
                skipped.append(f"{root}/{f.name} ({type(e).__name__})")
                continue
            slot["chars"] += n
            slot["files"] += 1
            total += n
    return {
        "ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "battle": "中石化南京工程有限公司 EPC50",
        "total_chars": total,
        "gate": CHAR_GATE,
        "gap": max(0, CHAR_GATE - total),
        "ratio": round(total / CHAR_GATE, 4),
        "passed": total >= CHAR_GATE,
        "file_count": file_count,
        "by_channel": {k: v for k, v in sorted(by_channel.items(),
                                               key=lambda kv: -kv[1]["chars"])},
        "manus_validity": {
            "rule": f"{MANUS_CHANNEL}: ≥1 URL/{CITE_CHARS_PER_URL}字",
            "low_citation_files": low_cite,
            "excluded_chars": low_cite_chars,
        },
        "legacy_reuse": {
            "rule": "C1口径: 存量语料复用件不计增量门槛, 供成稿引用",
            "files": len(legacy),
            "chars": legacy_chars,
        },
        "skipped": skipped,
        "composition": {
            "rule": "0925 用户令: PRIMARY=研究对象原始资料 ≥50% 目标",
            "primary_chars": sum(v["chars"] for k, v in by_channel.items()
                                 if k in PRIMARY_DIRS),
            "primary_files": sum(v["files"] for k, v in by_channel.items()
                                 if k in PRIMARY_DIRS),
            "context_chars": sum(v["chars"] for k, v in by_channel.items()
                                 if k not in PRIMARY_DIRS),
            "ima_pct": round(100 * by_channel.get(
                "51_ima知识库", {"chars": 0})["chars"] / max(1, total), 1),
        },
    }


def main() -> int:
    global BATTLE, REPORT
    ap = argparse.ArgumentParser()
    ap.add_argument("--watch", type=int, default=0,
                    help=">0 = 每 N 秒重算落盘 (监控模式)")
    ap.add_argument("--battle", choices=("epc49", "epc50"), default="epc50",
                    help="战役战场: epc49=四川电力设计咨询(0930起) / "
                         "epc50=中石化南京工程")
    args = ap.parse_args()
    if args.battle == "epc49":
        BATTLE = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
                      r"\《四川电力设计咨询有限责任公司怎么干EPC总承包？》")
        REPORT = BATTLE / "_pipeline" / "epc49_gate_report.json"
    while True:
        r = count()
        REPORT.parent.mkdir(parents=True, exist_ok=True)
        REPORT.write_text(json.dumps(r, ensure_ascii=False, indent=1),
                          encoding="utf-8")
        print(f"[gate] {r['total_chars']:,} / {r['gate']:,} "
              f"({r['ratio'] * 100:.1f}%)  gap={r['gap']:,}  "
              f"files={r['file_count']}  passed={r['passed']}", flush=True)
        for k, v in list(r["by_channel"].items())[:5]:
            print(f"    {k}: {v['chars']:,} 字 / {v['files']} 件", flush=True)
        comp = r["composition"]
        pc = comp["primary_chars"]
        print(f"    [构成比] PRIMARY {pc:,} ({100 * pc / max(1, r['total_chars']):.1f}%)"
              f" / CONTEXT {comp['context_chars']:,} | ima {comp['ima_pct']}%"
              f" — 目标 PRIMARY ≥ 50%", flush=True)
        mv = r["manus_validity"]
        if mv["low_citation_files"]:
            print(f"    [反编造门] 低引用 Manus 件 {len(mv['low_citation_files'])} "
                  f"个 / {mv['excluded_chars']:,} 字不计弹药 (见报告)",
                  flush=True)
        if r["skipped"]:
            print(f"    skipped {len(r['skipped'])} 件 (见报告)", flush=True)
        if not args.watch:
            return 0
        if r["passed"]:
            print("[gate] 门槛已过 — 可以停采进入下一环节", flush=True)
            return 0
        time.sleep(args.watch)


if __name__ == "__main__":
    sys.exit(main())
