# -*- coding: utf-8 -*-
"""dl_collect_wechat — 面A采集器：私聊(p2p) + 朋友圈(moments) → 需求台账 (F2/F3).

rion-cli 只读红线。关键词触发式 JTBD 抽取：工程痛点词命中的消息/动态 →
demand_quote=原文句, jtbd=模板。幂等入账。
用法: py -X utf8 tools/dl_collect_wechat.py [--p2p-limit 200] [--sns-offset 0]
"""
from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import demand_ledger as dl  # noqa: E402

RION = r"E:\AI-Station\vendor\wechat-intelligence-hub\rion-cli.cmd"
ENV = {**os.environ, "PYTHONIOENCODING": "utf-8"}

# 工程痛点触发词（需求语义，非泛词）
TRIGGERS = ["司法鉴定", "工程造价", "工程款", "结算", "索赔", "工期延误", "工期顺延",
            "资质", "挂靠", "联合体", "投标", "招标", "评标", "串标", "中标",
            "保证金", "垫资", "签证", "变更", "验收", "审计", "仲裁", "诉讼",
            "判决", "裁判", "实际施工人", "分包", "转包", "EPC", "总承包",
            "设计院", "造价师", "建造师", "监理", "施工合同", "劳动合同",
            "工伤", "安全生产", "质量事故", "返工", "修复", "赔偿"]


def rion(*args: str, timeout: int = 120) -> dict:
    r = subprocess.run(["cmd", "/c", RION, *args],
                       capture_output=True, timeout=timeout, env=ENV)
    try:
        return json.loads(r.stdout.decode("utf-8", errors="replace"))
    except Exception:
        return {}


def _plain(m: dict) -> str:
    mc = m.get("message_content") or {}
    if isinstance(mc, str):
        return mc
    return mc.get("data") if mc.get("encoding") == "plain" else (m.get("text") or m.get("snippet") or "")


def _hit(text: str) -> str | None:
    for t in TRIGGERS:
        if t in text:
            return t
    return None


def collect_p2p(limit: int) -> int:
    """私聊面：会话列表筛 p2p → 逐会话 timeline 近窗 → 触发句入账。"""
    n = 0
    d = rion("sessions", "--limit", "200")
    sessions = (d.get("data") or {}).get("sessions") or d.get("sessions") or []
    p2p = [s for s in sessions
           if "@chatroom" not in str(s.get("username", ""))
           and not str(s.get("username", "")).startswith(("gh_", "brand", "filehelper", "weixin"))
           and str(s.get("display_name") or "") not in ("公众平台安全助手", "微信团队", "文件传输助手")][:40]
    print(f"[A2] p2p 会话 {len(p2p)}")
    for s in p2p:
        name = s.get("display_name") or s.get("name") or s.get("username") or "?"
        r = rion("timeline", "--chat", str(s.get("username") or s.get("wxid") or ""),
                 "--limit", str(min(limit, 100)))
        msgs = (r.get("data") or {}).get("messages") or r.get("messages") or []
        for m in msgs:
            text = _plain(m)
            if len(text) < 10:
                continue
            kw = _hit(text)
            if not kw:
                continue
            sent = _sentence(text, kw)
            if dl.append("p2p", sent, ref=f"p2p:{name}",
                         jtbd={"trigger": kw, "job_statement": f"在私聊中讨论{kw}问题",
                               "outcome": "问题闭环"},
                         urgency="mid"):
                n += 1
        time.sleep(0.8)
    print(f"[A2] p2p 入账 {n}")
    return n


def collect_moments(offset: int = 0) -> int:
    """朋友圈面：sns-feed 翻页 → 触发句入账。"""
    n = 0
    seen = 0
    while seen < 600:
        d = rion("sns-feed", "--offset", str(offset + seen), "--limit", "100")
        items = (d.get("data") or {}).get("items") or d.get("feed") or []
        if not items:
            break
        for it in items:
            seen += 1
            text = str(it.get("text") or "")
            if not text:
                import re as _re
                m = _re.search(r"<contentDesc>([^<]{8,})</contentDesc>", str(it.get("content") or ""))
                text = m.group(1) if m else ""
            if len(text) < 10:
                continue
            kw = _hit(text)
            if not kw:
                continue
            sent = _sentence(text, kw)
            if dl.append("moments", sent, ref=f"sns:{it.get('user_name','?')}",
                          jtbd={"trigger": kw, "job_statement": f"在朋友圈发布{kw}相关内容",
                                "outcome": "获客/求助"},
                          urgency="low"):
                n += 1
        time.sleep(1.0)
    print(f"[A3] 朋友圈扫描 {seen} 条, 入账 {n}")
    return n


def _sentence(text: str, kw: str, maxlen: int = 120) -> str:
    i = text.find(kw)
    start = max(0, i - 40)
    return text[start:start + maxlen].replace("\n", " ").strip()


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--p2p-limit", type=int, default=200)
    ap.add_argument("--sns-offset", type=int, default=0)
    ap.add_argument("--skip-p2p", action="store_true")
    ap.add_argument("--skip-sns", action="store_true")
    ns = ap.parse_args()
    if not ns.skip_p2p:
        collect_p2p(ns.p2p_limit)
    if not ns.skip_sns:
        collect_moments(ns.sns_offset)
    print("[A] 面A完成:", dl.stats())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
