# -*- coding: utf-8 -*-
"""存活门采集器（T-041 / REQ-001）——军团每 30 分钟腿调用。

判据（定死）：2 小号 × 14 天，零封号事件且单号在线率 ≥90% = PASS；
任一小号封号 = FAIL（触发 B 栈单栈降级）。
数据：revenue-engine/reports/survival/events-YYYYMMDD.jsonl（30min 一条/号）
      + groups.jsonl（进群台账，人工追加）→ 按需生成 survival_report.md。
"""
from __future__ import annotations

import json
import os
import time
from pathlib import Path

import requests

ROOT = Path(__file__).resolve().parents[2]
DIR = ROOT / "revenue-engine" / "reports" / "survival"
URL = os.environ.get("RE_WPP_URL", "http://127.0.0.1:1238")
ACCOUNTS = json.loads((DIR / "accounts.json").read_text(encoding="utf-8")
                      if (DIR / "accounts.json").exists() else "[]")
BAN_WORDS = ("封", "异常", "被踢", "禁止", "风险")


def poll_once() -> list[dict]:
    events = []
    for acc in ACCOUNTS:
        try:
            r = requests.get(f"{URL}/login/GetLoginStatus?key={acc['token']}",
                             timeout=10)
            body = r.json()
            code, text = body.get("Code"), str(body.get("Text", ""))
        except Exception as e:  # 采集失败≠账号异常，单独记
            code, text = -1, f"probe_error: {e}"
        events.append({"ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
                       "account": acc["name"], "code": code, "text": text,
                       "ban_hint": any(w in text for w in BAN_WORDS)})
    f = DIR / f"events-{time.strftime('%Y%m%d')}.jsonl"
    f.parent.mkdir(parents=True, exist_ok=True)
    with f.open("a", encoding="utf-8") as fh:
        for e in events:
            fh.write(json.dumps(e, ensure_ascii=False) + "\n")
    return events


def _load_events(days: int = 14) -> list[dict]:
    out = []
    for f in sorted(DIR.glob("events-*.jsonl"))[-days:]:
        for line in f.read_text(encoding="utf-8").splitlines():
            if line:
                try:
                    out.append(json.loads(line))
                except ValueError:
                    continue
    return out


def verdict() -> dict:
    ev = _load_events()
    per: dict[str, dict] = {}
    for e in ev:
        p = per.setdefault(e["account"], {"total": 0, "online": 0,
                                          "ban": 0, "probe_err": 0})
        p["total"] += 1
        if e["code"] == -1:
            p["probe_err"] += 1
        elif e["code"] == 200:
            p["online"] += 1
        if e["ban_hint"]:
            p["ban"] += 1
    groups = []
    gf = DIR / "groups.jsonl"
    if gf.exists():
        groups = [json.loads(x) for x in
                  gf.read_text(encoding="utf-8").splitlines() if x]
    return {"per_account": per, "groups": groups, "events": len(ev),
            "days_covered": len(list(DIR.glob('events-*.jsonl')))}


def report() -> Path:
    v = verdict()
    lines = [f"# 存活门实验报告（T-041） 生成于 {time.strftime('%Y-%m-%d %H:%M')}", ""]
    ok_all, rows = True, []
    for acc, p in v["per_account"].items():
        valid = p["total"] - p["probe_err"]
        uptime = (p["online"] / valid * 100) if valid else 0.0
        ok = p["ban"] == 0 and uptime >= 90
        ok_all &= ok
        rows.append(f"| {acc} | {p['total']} | {uptime:.1f}% | "
                    f"{p['ban']} | {'✅' if ok else '❌'} |")
    lines += ["## 判据：2 小号 × 14 天（D14），零封号且单号在线率 ≥90%", "",
              "| 小号 | 采样数 | 在线率 | 封号征兆 | 判 |", "|---|---|---|---|---|",
              *rows, "",
              f"## 进群台账（{len(v['groups'])} 条）", "",
              *[f"- {g.get('ts','')} {g.get('group','')}（{g.get('note','')}）"
                for g in v["groups"]] or ["- （待扫码后人工追加 groups.jsonl）"], "",
              f"覆盖天数 {v['days_covered']}/14；事件 {v['events']} 条。", "",
              f"VERDICT: {'PASS' if ok_all and v['days_covered'] >= 14 else 'PENDING'}"
              f"{'（未满 D14，时钟继续）' if v['days_covered'] < 14 else ''}"]
    out = DIR / "survival_report.md"
    out.write_text("\n".join(lines), encoding="utf-8")
    return out


if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1 and sys.argv[1] == "report":
        print(report())
    else:
        print(json.dumps(poll_once(), ensure_ascii=False))
