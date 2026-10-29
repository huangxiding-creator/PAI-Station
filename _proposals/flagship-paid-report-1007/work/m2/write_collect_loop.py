# -*- coding: utf-8 -*-
"""write_collect_loop — 撰采并行器 (1023 用户令: 边撰写边调研搜集, 一定远程Manus).

机制: S2 撰写期间, 监工扫描已写章节 → 找素材薄点(锚密度低/证据边界多/
盲区声明) → 生成定向采集简报 → 推军团战斗队列(远程Manus采集) → 收割成
果入池bank → 触发该章NB扩写重写 → 循环。撰写永不等待: 素材薄就先写,
采到的料回填后该章自动升级。

用法: py -X utf8 write_collect_loop.py --campaign-dir <战役目录> [--interval 900]
依赖:军团循环在跑(吃队列) + 收割器在跑(拉成果) — 本件只做监工与调度。
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[4]
M2 = Path(__file__).resolve().parent
# 队列文件父目录兜底创建
BATTLE_QUEUE = REPO / "Auto_Manus" / "data" / "epc_battle_queue.json"
CORPS_LOG = REPO / "Auto_Manus" / "data" / "epc50_corps_log.jsonl"
PAIBAN = REPO / "reforge_factory" / "legs"  # 共享腿仓

CIT_RE = re.compile(r"\[\d+")
THIN_MARKS = re.compile(r"证据边界|盲区|未能获取|数据缺失|尚无公开|待补")


def chapter_health(text: str) -> dict:
    """章健康度: 锚密度(引用/千字) + 薄点数(证据边界类声明)."""
    cjk = len(re.findall(r"[一-鿿]", text))
    cits = len(CIT_RE.findall(text))
    density = round(cits / max(cjk, 1) * 1000, 1)
    thin = len(THIN_MARKS.findall(text))
    return {"cjk": cjk, "citations": cits, "density": density,
            "thin_marks": thin,
            "verdict": "thin" if (density < 3.0 or thin >= 3) else "ok"}


def extract_gap_topics(text: str, ch_name: str) -> list[str]:
    """从薄点语句抽采集主题 (证据边界/盲区附近的句子 → 简报素材)."""
    gaps = []
    for m in THIN_MARKS.finditer(text):
        seg = text[max(0, m.start() - 80):m.end() + 60]
        seg = re.sub(r"\s+", " ", seg)
        key = re.sub(r"[^一-鿿A-Za-z0-9 ]", "", seg)[:60]
        if len(key) > 12:
            gaps.append(key)
    return gaps[:3]     # 每章最多3个缺口简报, 防队列爆


def brief_for(gap: str, ch: str) -> str:
    return (f"{ch} 撰写中素材缺口定向采集：{gap}。"
            f"要求：搜集原始资料（数据/清单/案例/政策原文），逐条附来源链接"
            f"与发布日期，官方一手来源优先。只做资料罗列，不做分析论述。")


def enqueue_briefs(briefs: list[tuple[str, str]]) -> int:
    """缺口简报 → 动态树文件 → 插战斗队列队首 (军团远程Manus吃单)."""
    if not briefs:
        return 0
    tree = {
        "company": "撰采并行缺口树(动态)", "short": "撰采缺口",
        "generated": time.strftime("%Y-%m-%dT%H:%M:%S"), "version": "dyn",
        "topics": []}
    for i, (ch, gap) in enumerate(briefs):
        tree["topics"].append({
            "id": f"WC{i:03d}", "dimension": "撰采缺口", "title": f"{ch}缺口",
            "status": "pending", "manus_use": "collect",
            "queries": [gap[:40]],
            "questions": [{"id": f"WC{i:03d}Q01", "kind": "collect",
                           "text": brief_for(gap, ch), "status": "pending",
                           "chars": 0, "sources": 0}]})
    BATTLE_QUEUE.parent.mkdir(parents=True, exist_ok=True)
    out = M2 / "write_collect_gap_tree.json"
    out.write_text(json.dumps(tree, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    q = json.loads(BATTLE_QUEUE.read_text(encoding="utf-8"))
    trees = [str(out)] + [t for t in q.get("trees", [])
                          if "write_collect_gap_tree" not in t]
    q["trees"] = trees
    BATTLE_QUEUE.write_text(json.dumps(q, ensure_ascii=False, indent=1),
                            encoding="utf-8")
    return len(briefs)


def scan_chapters(cdir: Path) -> list[tuple[str, str, dict]]:
    """扫描战役目录已写章节 → [(章名, 路径, 健康度)]."""
    results = []
    out_dir = cdir / "nblm_out"
    if not out_dir.is_dir():
        return results
    for p in sorted(out_dir.glob("ch*初稿.md")):
        text = p.read_text(encoding="utf-8", errors="replace")
        h = chapter_health(text)
        results.append((p.stem, str(p), h))
    return results


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign-dir", required=True)
    ap.add_argument("--interval", type=int, default=900)
    ap.add_argument("--hours", type=float, default=8.0)
    ns = ap.parse_args()
    cdir = Path(ns.campaign_dir).resolve()
    deadline = time.time() + ns.hours * 3600
    round_n = 0
    while time.time() < deadline:
        round_n += 1
        chapters = scan_chapters(cdir)
        briefs = []
        print(f"[撰采 R{round_n} {time.strftime('%H:%M')}] 扫描 "
              f"{len(chapters)} 章", flush=True)
        for name, path, h in chapters:
            mark = "薄" if h["verdict"] == "thin" else "可"
            print(f"  {name[:14]}: 锚密度{h['density']}/千字 "
                  f"薄点{h['thin_marks']} [{mark}]", flush=True)
            if h["verdict"] == "thin":
                text = Path(path).read_text(encoding="utf-8",
                                            errors="replace")
                for gap in extract_gap_topics(text, name):
                    briefs.append((name, gap))
        n = enqueue_briefs(briefs)
        print(f"  → 缺口简报 {n} 条已插军团队列(远程Manus将采)", flush=True)
        time.sleep(ns.interval)
    print("[撰采] 收班", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
