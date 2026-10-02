# -*- coding: utf-8 -*-
"""EPC50 秘塔腿 — scholar/web 双域批量查询 (0923).

每查询落一份 md (答案+来源), 存战场 04 网络调研搜集的资料/99_秘塔/.
节流: 查询间 20-40s (账号安全). 脚本走 metaso-search skill 的
metaso_search.py (legacy q 模式, Bearer env).
"""
import argparse
import random
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
MS = (r"C:\Users\91216\.claude\skills\metaso-search\scripts"
      r"\metaso_search.py")
OUT = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
           r"\《中石化南京工程有限公司怎么干EPC总承包？》"
           r"\04 网络调研搜集的资料\99_秘塔")

QUERIES = [
    ("scholar", "中石化南京工程有限公司 EPC总承包 业务发展 研究"),
    ("scholar", "设计院 EPC转型 工程总承包 模式 研究 炼化"),
    ("scholar", "石化工程公司 项目管理体系 研究"),
    ("scholar", "煤化工 EPC 项目 管理 案例研究"),
    ("web", "中石化南京工程有限公司 简介 资质 业绩"),
    ("web", "中石化南京工程 EPC 总承包 中标 2024 2025"),
    ("web", "中石化南京工程 煤化工项目 业绩"),
    ("web", "中石化南京工程 海外项目 一带一路"),
    ("web", "中石化南京工程 数字化转型 三维设计"),
    ("web", "炼化工程 EPC 竞争格局 中石化 洛阳 宁波"),
    ("web", "中国石化 工程总承包 排名 百强 ENR"),
    ("web", "中石化南京工程 组织架构 人才 招聘"),
]


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--limit", type=int, default=0)
    args = ap.parse_args()
    qs = QUERIES[:args.limit] if args.limit else QUERIES
    OUT.mkdir(parents=True, exist_ok=True)
    done = 0
    for i, (scope, q) in enumerate(qs, 1):
        slug = (q.replace(" ", "_").replace("/", "_")[:50]
                + f"_{scope}.md")
        outp = OUT / slug
        if outp.exists() and outp.stat().st_size > 500:
            print(f"[{i}/{len(qs)}] 已存在跳过 {slug}", flush=True)
            continue
        print(f"[{i}/{len(qs)}] {scope}: {q}", flush=True)
        try:
            r = subprocess.run(
                [sys.executable, MS, "-q", q, "--scope", scope,
                 "--mode", "legacy"],
                capture_output=True, text=True, encoding="utf-8",
                timeout=240)
            body = r.stdout or ""
            if len(body) < 200:
                print(f"    疑似空回 ({len(body)}B) stderr={r.stderr[:80]}",
                      flush=True)
            outp.write_text(
                f"---\nsource: metaso/{scope}\nquery: {q}\n"
                f"ts: {time.strftime('%Y-%m-%dT%H:%M:%S')}\n---\n\n"
                + body, encoding="utf-8")
            done += 1
        except Exception as e:
            print(f"    EXC {type(e).__name__}: {str(e)[:60]}", flush=True)
        time.sleep(random.uniform(20, 40))
    print(f"[metaso 批] 新增 {done}/{len(qs)}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
