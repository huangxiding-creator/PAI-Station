# -*- coding: utf-8 -*-
"""demand_signals_sph — 需求信号源④视频号评论采集器 (L1, 1016 用户令).

视频评论=下沉真实买家。源: 9222 常驻 Chrome 的视频号助手「互动管理→评论」
(需先跑 tools/channels_login_weaipo.py 保证会话)。抓最近评论 → jsonl。

用法: py -3.11 tools/demand_signals_sph.py [--pages 3]
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import Chromium              # noqa: E402

OUT = Path(__file__).resolve().parents[1] / "data" / "demand_signals"
COMMENT_URL = "https://channels.weixin.qq.com/platform/comment/manage"


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--pages", type=int, default=3)
    ns = ap.parse_args()
    OUT.mkdir(parents=True, exist_ok=True)
    b = Chromium("127.0.0.1:9222")
    tab = b.latest_tab
    tab.get(COMMENT_URL, timeout=20)
    time.sleep(7)
    if "/login" in (tab.url or ""):
        print("[sph] 未登录 — 先跑 tools/channels_login_weaipo.py")
        return 2
    n = 0
    out = OUT / f"raw_sph_{time.strftime('%Y%m%d')}.jsonl"
    with out.open("a", encoding="utf-8") as f:
        for page in range(ns.pages):
            time.sleep(4)
            body = tab.ele("tag:body").text or ""
            # 评论行形: 用户名 + 评论内容 + 视频标题 (行序解析; 结构变化如实跳)
            lines = [l.strip() for l in body.split("\n") if len(l.strip()) > 10]
            for ln in lines:
                if any(k in ln for k in ("回复", "删除", "精选", "置顶")):
                    continue
                f.write(json.dumps({
                    "ts": time.strftime("%Y-%m-%d %H:%M:%S"),
                    "source": "sph_comment",
                    "channel": "channels:总包说",
                    "actor": "", "text": ln[:500],
                    "meta": {"page": page}}, ensure_ascii=False) + "\n")
                n += 1
            nxt = tab.ele("text:下一页", timeout=2)
            if not nxt:
                break
            try:
                nxt.click()
            except Exception:
                break
    print(f"[sph] {n} 条评论行 → {out.name} (行级初筛, 语义分类在汇聚层)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
