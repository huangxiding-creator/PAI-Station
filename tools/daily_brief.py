# -*- coding: utf-8 -*-
"""daily_brief — 每日行业AI日报生成+推送 (1017 商业模式升级#4).

每日 07:00 从 RSS 池取最新文章 → AI 生成 3-5 条要点简报 → 推送到订阅用户.
日报免费 → 养成每日阅读习惯 → 「解锁完整报告 ¥698」变现.

用法: python tools/daily_brief.py [--dry] [--push]
"""
from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import time
from datetime import datetime, timedelta
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
RSS_DIR = REPO / "data" / "rss_harvest" / "articles"
BRIEF_DIR = REPO / "data" / "daily_brief"
PY = sys.executable

ZHIPU_KEY = ""
_env = Path(r"F:\We-AIPO\.env")
if _env.exists():
    for line in _env.read_text(encoding="utf-8").splitlines():
        if line.startswith("ZHIPU_API_KEY="):
            ZHIPU_KEY = line.split("=", 1)[1].strip()


def get_recent_articles(hours=24, limit=50):
    """取最近N小时的RSS文章摘要."""
    cutoff = datetime.now() - timedelta(hours=hours)
    articles = []
    for day_dir in sorted(RSS_DIR.iterdir(), reverse=True):
        if not day_dir.is_dir():
            continue
        for fp in day_dir.glob("*.md"):
            try:
                mtime = datetime.fromtimestamp(fp.stat().st_mtime)
            except OSError:
                continue
            if mtime < cutoff:
                continue
            try:
                head = fp.read_text(encoding="utf-8", errors="replace")[:500]
            except OSError:
                continue
            articles.append({
                "file": fp.stem,
                "time": mtime.strftime("%H:%M"),
                "head": head,
            })
            if len(articles) >= limit:
                break
        if len(articles) >= limit:
            break
    return articles


def generate_brief(articles, report_sku="BID26-2026", report_title="《工程总承包招投标合规指南》"):
    """AI生成日报简报."""
    if not ZHIPU_KEY:
        return None
    import requests
    context = "\n\n".join(
        f"[{a['time']}] {a['file'][:50]}\n{a['head'][:300]}"
        for a in articles[:20]
    )
    prompt = f"""你是工程行业研究日报编辑。基于以下今日RSS文章摘要，生成一份简洁的中文日报。

要求：
1. 3-5条要点，每条一句话（30字以内）
2. 1个「深度洞察」（2-3句话，基于多篇交叉）
3. 结尾加一行推广（不带链接，纯文字）

今日文章摘要：
{context}

输出格式（纯文本，无markdown）：
📋 工程行业AI日报 | {datetime.now().strftime('%Y-%m-%d')}

【今日要点】
1. ...
2. ...
3. ...

【深度洞察】
...

【相关报告】
以上洞察的完整分析见{report_title}，总包AI顾问小程序搜索解锁。"""

    try:
        r = requests.post(
            "https://open.bigmodel.cn/api/paas/v4/chat/completions",
            headers={"Authorization": f"Bearer {ZHIPU_KEY}",
                     "Content-Type": "application/json"},
            json={"model": "glm-4-flash",
                  "messages": [{"role": "user", "content": prompt}],
                  "temperature": 0.3, "max_tokens": 1000},
            timeout=30)
        if r.status_code == 200:
            return r.json()["choices"][0]["message"]["content"]
    except Exception:
        pass
    return None


def push_to_wecom(brief_text):
    """推送到企微群."""
    webhook = ""
    if _env.exists():
        for line in _env.read_text(encoding="utf-8").splitlines():
            if line.startswith("WECOM_WEBHOOK_URL="):
                webhook = line.split("=", 1)[1].strip()
    if not webhook:
        return False
    import urllib.request
    data = json.dumps({
        "msgtype": "markdown",
        "markdown": {"content": brief_text}
    }).encode()
    req = urllib.request.Request(webhook, data=data,
                                headers={"Content-Type": "application/json"})
    try:
        urllib.request.urlopen(req, timeout=10)
        return True
    except Exception:
        return False


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry", action="store_true")
    ap.add_argument("--push", action="store_true")
    ns = ap.parse_args()

    articles = get_recent_articles(hours=24, limit=30)
    if not articles:
        print("[brief] 近24h无新文章，跳过")
        return

    brief = generate_brief(articles)
    if not brief:
        print("[brief] AI生成失败，跳过")
        return

    # 保存
    BRIEF_DIR.mkdir(parents=True, exist_ok=True)
    fp = BRIEF_DIR / f"brief_{datetime.now().strftime('%Y%m%d')}.md"
    fp.write_text(brief, encoding="utf-8")
    print(f"[brief] 日报已生成: {fp.name} ({len(brief)} chars)")

    if ns.dry:
        print(brief)
        return

    if ns.push or True:  # 默认推送
        ok = push_to_wecom(brief)
        print(f"[brief] 企微推送: {'✅' if ok else '❌'}")


if __name__ == "__main__":
    main()
