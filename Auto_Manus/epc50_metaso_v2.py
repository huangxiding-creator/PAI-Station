# -*- coding: utf-8 -*-
"""EPC50 秘塔腿 v2 — 560 子问题批量问答 (0924, 用户令: 增量产弹).

任务源 = _pipeline/epc50_topic_tree_v2.json (56 主题 × 10 问法);
每问一次 metaso web 查询, 落一份 md (frontmatter 带 qid/kind/主题),
存战场 04 网络调研搜集的资料/30_秘塔AI/99_v2问答/.
断点续跑: 文件存在(>500B)即跳过. 节流 20-40s (账号安全).
树文件不改写 — status/chars/sources 的归账属饱和引擎, 本腿只产弹.
"""
import json
import random
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

MS = (r"C:\Users\91216\.claude\skills\metaso-search\scripts"
      r"\metaso_search.py")
BATTLE = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
              r"\《中石化南京工程有限公司怎么干EPC总承包？》")
TREE2 = BATTLE / "_pipeline" / "epc50_topic_tree_v2.json"
OUT = (BATTLE / "04 网络调研搜集的资料" / "30_秘塔AI" / "99_v2问答")


def load_questions() -> list[dict]:
    tree = json.loads(TREE2.read_text(encoding="utf-8"))
    flat = []
    for t in tree["topics"]:
        for q in t.get("questions", []):
            flat.append({"qid": q["id"], "kind": q.get("kind", ""),
                         "topic": t["title"], "text": q["text"]})
    return flat


def main() -> int:
    qs = load_questions()
    OUT.mkdir(parents=True, exist_ok=True)
    done = skipped = failed = 0
    for i, q in enumerate(qs, 1):
        outp = OUT / f"{q['qid']}.md"
        if outp.exists() and outp.stat().st_size > 500:
            skipped += 1
            continue
        print(f"[{i}/{len(qs)}] {q['qid']} ({q['kind']}) {q['text'][:44]}",
              flush=True)
        try:
            r = subprocess.run(
                [sys.executable, MS, "-q", q["text"],
                 "--mode", "legacy"],
                capture_output=True, text=True, encoding="utf-8",
                timeout=240)
            body = r.stdout or ""
            if len(body) < 200:
                failed += 1
                print(f"    疑似空回 ({len(body)}B) stderr={r.stderr[:80]}",
                      flush=True)
            outp.write_text(
                f"---\nsource: metaso/web (v2问答)\nqid: {q['qid']}\n"
                f"kind: {q['kind']}\ntopic: {q['topic']}\n"
                f"query: {q['text']}\n"
                f"ts: {time.strftime('%Y-%m-%dT%H:%M:%S')}\n---\n\n"
                + body, encoding="utf-8")
            if len(body) >= 200:
                done += 1
        except Exception as e:  # noqa: BLE001 — 单问失败不拖全链
            failed += 1
            print(f"    EXC {type(e).__name__}: {str(e)[:60]}", flush=True)
        time.sleep(random.uniform(20, 40))
    print(f"[metaso v2 批] 新增 {done} | 跳过 {skipped} | 空回/失败 {failed} "
          f"/ 总 {len(qs)}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
