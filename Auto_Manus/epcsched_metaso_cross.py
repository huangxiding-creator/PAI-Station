# -*- coding: utf-8 -*-
"""EPC-SCHED metaso 交叉腿 (1020) — 战场 _channel_metaso 既有问答按相关性并入.

metaso 实时腿依赖 9222 登录浏览器 (WeAIPO 免打扰铁律) → 走 DSIM/JSFDD
已验证的交叉复用路径: 扫各战场 02/_channel_metaso/ 的 metaso_*.md,
工期口径两级判定 (绝不凑数) → engine=cross:metaso → C轴 metaso 渠道.
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

CODE_VERSION = "sched-metaso-v1"
CID = "EPC-SCHED"
TOPICS = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics")

L1_KWS = ["工期延误", "工期顺延", "延误索赔", "赶工", "停工损失", "工期签证",
          "网络计划", "关键线路", "进度偏差", "施工组织设计", "工期管理",
          "进度管理"]
L2_PAN = ["工期", "进度", "索赔", "顺延", "停工", "延误", "签证"]
L2_CTX = ["工程", "施工", "合同", "项目", "EPC", "总承包", "建筑", "监理"]


def judge(text: str) -> tuple:
    head = text[:8000]
    if any(k in head for k in L1_KWS):
        return "valid", "cross_L1"
    pan = [k for k in L2_PAN if k in head]
    if pan and any(c in head for c in L2_CTX):
        return "valid", f"cross_L2+{pan[0]}"
    return "rejected", "offtopic"


def main() -> int:
    print(f"[{CODE_VERSION}] metaso 交叉腿启动 {time.strftime('%F %T')}",
          flush=True)
    camp = ap._camp_dir(CID)
    mp = camp / "manifest.jsonl"
    with ap._pool_lock(camp):
        paths, keys = set(), set()
        for x in mp.read_text(encoding="utf-8").splitlines():
            if x.strip():
                r = json.loads(x)
                paths.add(r.get("source_path"))
                keys.add(r.get("dedup_key"))
        n_scan = n_valid = n_rej = n_dup = 0
        out_rows = []
        for b in sorted(TOPICS.iterdir()):
            if not b.is_dir():
                continue
            for two in b.iterdir():
                if not (two.is_dir() and two.name.startswith("02")):
                    continue
                cmd = two / "_channel_metaso"
                if not cmd.is_dir():
                    continue
                for f in sorted(cmd.glob("metaso_*.md")):
                    n_scan += 1
                    if str(f) in paths:
                        n_dup += 1
                        continue
                    try:
                        text = f.read_text(encoding="utf-8",
                                           errors="replace")
                    except OSError:
                        continue
                    if len(text) < 50:
                        continue
                    key = ap.dedup_key(None, text)
                    if key in keys:
                        n_dup += 1
                        continue
                    v, why = judge(text)
                    ch = ap.count_chars(text)
                    out_rows.append(json.dumps({
                        "ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
                        "engine": "cross:metaso", "source_path": str(f),
                        "url_norm": "", "chars": ch, "credibility": "media",
                        "dedup_key": key, "judge": v, "judge_reason": why,
                        "judge_engine": "stock2level", "tree_node": "",
                        "stance": "support", "grade": "B",
                        "text_head": text[:500]}, ensure_ascii=False))
                    keys.add(key)
                    if v == "valid":
                        n_valid += 1
                    else:
                        n_rej += 1
        if out_rows:
            with mp.open("a", encoding="utf-8") as fh:
                fh.write("\n".join(out_rows) + "\n")
    print(f"[metaso-cross] 扫 {n_scan} | valid {n_valid} | rej {n_rej} | "
          f"重复 {n_dup}", flush=True)
    ap.rebuild(CID)
    print(f"[{CODE_VERSION}] 完成", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
