# -*- coding: utf-8 -*-
"""M9.4 毛选方法论采集排产器（用户 2026-09-11 愿景：调研 ≥100 篇）。

账号安全红线（memory: account-safety-first）：
- SouGouWeDown2 服务单任务锁（409 拒绝并发）——天然串行
- 词与词之间冷却 35 分钟；页内延迟 delayMin/Max = 3-6s（slow 模式）
- 全程只经服务 API，不直连搜狗
产出：E:\\AI-Station\\05 方法\\毛选\\<关键词>_<日期>.md + 采集台账 harvest_log.json
"""
import json
import shutil
import sys
import time
from datetime import datetime
from pathlib import Path

import urllib.request

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

API = "http://127.0.0.1:3000"
DEST = Path(r"E:\AI-Station\05 方法\毛选")
SRC = Path(r"E:\AI-Station\ResearchFactory-Eng\SouGouWeDown2\output")
COOLDOWN_SECONDS = 35 * 60          # 词间冷却（账号安全）
POLL_SECONDS = 30                    # 状态轮询
PAGE_DELAY = (3, 6)                  # slow 模式页内延迟

KEYWORDS = [
    "毛泽东选集 解决问题的方法论",
    "毛选 调查研究方法",
    "反对本本主义 调查研究",
    "实践论 认识论 方法论",
    "矛盾论 矛盾分析法",
    "具体问题具体分析 工作方法",
    "没有调查就没有发言权",
    "毛泽东 工作方法 六十条",
    "群众路线 工作方法",
    "论持久战 战略思维",
    "集中优势兵力 各个歼灭",
    "毛泽东 抓主要矛盾",
    "毛选 问题定义",
]


def post_search(keyword: str, pages: int) -> dict:
    body = json.dumps({"keyword": keyword, "pages": pages,
                       "delayMin": PAGE_DELAY[0], "delayMax": PAGE_DELAY[1]}
                      ).encode("utf-8")
    req = urllib.request.Request(
        f"{API}/api/search", data=body, method="POST",
        headers={"Content-Type": "application/json; charset=utf-8"})
    with urllib.request.urlopen(req, timeout=30) as resp:
        return json.loads(resp.read().decode("utf-8"))


def get_status() -> dict:
    with urllib.request.urlopen(f"{API}/api/status", timeout=15) as resp:
        return json.loads(resp.read().decode("utf-8"))


def wait_done(keyword: str) -> dict:
    """等任务真正完成：先等 running=true（提交竞态），再等收尾并核对 phase。

    phase=error 时如实返回——绝不把失败当成功（本次事故的根因修复）。
    """
    start = time.time()
    while time.time() - start < 300:  # 最多等 5 分钟进入运行态
        st = get_status()
        if st.get("running"):
            break
        time.sleep(5)
    while True:
        time.sleep(POLL_SECONDS)
        st = get_status()
        if not st.get("running"):
            return st
        phase = st.get("progress", {}).get("phase", "?")
        msg = st.get("progress", {}).get("message", "")[:60]
        print(f"  [{datetime.now():%H:%M:%S}] {phase}: {msg}", flush=True)


def archive(keyword: str) -> Path | None:
    """按文件名匹配归档（输出文件名 = 关键词_日期.md），杜绝拿旧文件充数。"""
    DEST.mkdir(parents=True, exist_ok=True)
    key_head = keyword.split()[0][:4]  # 文件名以关键词开头
    candidates = [p for p in SRC.glob("*.md")
                  if key_head in p.stem]
    if not candidates:
        return None
    src_file = max(candidates, key=lambda p: p.stat().st_mtime)
    stamp = datetime.now().strftime("%Y-%m-%d")
    target = DEST / f"{src_file.stem}_{stamp}.md"
    if target.exists():
        return target
    shutil.copy2(src_file, target)
    return target


def main() -> int:
    ledger_path = DEST / "harvest_log.json"
    DEST.mkdir(parents=True, exist_ok=True)
    ledger = json.loads(ledger_path.read_text(encoding="utf-8")) \
        if ledger_path.exists() else {"done": []}
    done = {row["keyword"] for row in ledger["done"]
            if row.get("phase", "done") == "done" and row.get("articles", 0) > 0}
    total_articles = sum(row.get("articles", 0) for row in ledger["done"])

    for i, kw in enumerate(KEYWORDS):
        if kw in done:
            print(f"[{i + 1}/{len(KEYWORDS)}] 跳过（已完成）：{kw}", flush=True)
            continue
        print(f"[{i + 1}/{len(KEYWORDS)}] 提交采集：{kw}", flush=True)
        try:
            post_search(kw, pages=3)
        except Exception as exc:  # noqa: BLE001 - 单词失败不终止排产
            print(f"  提交失败：{exc}", flush=True)
            continue
        st = wait_done(kw)
        phase = st.get("progress", {}).get("phase", "")
        if phase != "done":
            print(f"  任务失败（phase={phase}）：{kw}，重试一次", flush=True)
            time.sleep(120)
            try:
                post_search(kw, pages=3)
                st = wait_done(kw)
                phase = st.get("progress", {}).get("phase", "")
            except Exception as exc:  # noqa: BLE001
                print(f"  重试提交失败：{exc}", flush=True)
        articles = st.get("progress", {}).get("totalArticles", 0) \
            if phase == "done" else 0
        archived = archive(kw) if phase == "done" else None
        ledger["done"].append({"keyword": kw, "articles": articles,
                               "phase": phase,
                               "archived": str(archived) if archived else "",
                               "at": datetime.now().isoformat(timespec="seconds")})
        ledger_path.write_text(json.dumps(ledger, ensure_ascii=False, indent=1),
                               encoding="utf-8")
        total_articles += articles
        print(f"  完成：{articles} 篇 -> {archived}", flush=True)
        if total_articles >= 100 and i < len(KEYWORDS) - 1:
            print(f"  累计 {total_articles} 篇已过 100 门槛，剩余词继续攒密度",
                  flush=True)
        if i < len(KEYWORDS) - 1:
            print(f"  冷却 {COOLDOWN_SECONDS // 60} 分钟（账号安全）", flush=True)
            time.sleep(COOLDOWN_SECONDS)

    print(f"\n采集结束：{total_articles} 篇（门槛 100）", flush=True)
    return 0 if total_articles >= 100 else 1


if __name__ == "__main__":
    raise SystemExit(main())
