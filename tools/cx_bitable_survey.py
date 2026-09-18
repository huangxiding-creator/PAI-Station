# -*- coding: utf-8 -*-
"""飞书多维表盘点——AI 眼镜数据后台等工作活数据入卷宗（事实维工作面）。

M2.6 登记的一级信号源"bitable 活数据"首次落地：doc_inventory.json 里
20 个 bitable（含两个 AI 眼镜数据后台），此前从未进检索域。本工具：
- 凭据类标题（密钥/密码/API）整表跳过——红线：凭据内容不采集不导出
- 活跃表（内容探针）：小表拉记录取时间窗与要点；其余仅表级元数据
- 产出 SELF_PROFILE/cx_飞书多维表盘点_<date>.md（入 dossier glob）

API 节流 1.5s/请求；账号安全四件套照旧。用法：
python tools/cx_bitable_survey.py
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import time
from datetime import datetime
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
LARK = Path.home() / "AppData/Roaming/npm/node_modules/@larksuite/cli/bin/lark-cli.exe"
INVENTORY = REPO / "SELF_PROFILE" / "feishu" / "raw" / "doc_inventory.json"
OUT = REPO / "SELF_PROFILE" / f"cx_飞书多维表盘点_{datetime.now():%Y%m%d}.md"

THROTTLE_S = 1.5
REQ_BUDGET = 40

# 凭据类标题硬过滤（命中即整 base 跳过，卡片只记跳过数不记标题）
CRED_RE = ("密钥", "密码", "apikey", "api key", "secret", "credential", "token表")

# 内容探针白名单（工作活数据，小表拉记录取时间窗）
PROBE_TITLES = ("眼镜数据后台", "隐患信息台账", "危险源信息表", "需求池", "反馈池")
PROBE_RECORD_MAX = 150  # 记录数≤此值拉首页取时间窗（gist 仍只取前 3 行）


def is_credential(title: str) -> bool:
    t = title.lower()
    return any(k in t for k in CRED_RE)


def tier_of(title: str) -> str:
    """probe=内容探针白名单；meta=仅表级元数据。"""
    return "probe" if any(p in title for p in PROBE_TITLES) else "meta"


def call_lark(args: list[str], budget: list[int]) -> dict:
    """lark-cli 调用（节流+预算熔断）。"""
    if budget[0] <= 0:
        return {"ok": False, "error": {"message": "budget"}}
    budget[0] -= 1
    time.sleep(THROTTLE_S)
    proc = subprocess.run(
        [str(LARK), *args, "--as", "user", "--json"],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
        timeout=60,
        creationflags=0x08000000)
    try:
        return json.loads(proc.stdout)
    except (json.JSONDecodeError, TypeError):
        return {"ok": False, "error": {"message": proc.stdout[:120]}}


def date_window(rows: list, fields: list, types: list) -> tuple[str, str]:
    """记录行 → (最早, 最晚)。datetime 列取 ISO 前 10 位。"""
    dates = []
    for row in rows:
        for val, ft in zip(row, types):
            if ft in ("datetime", "created_at", "modified_at") and isinstance(val, str):
                dates.append(val[:10])
    return (min(dates), max(dates)) if dates else ("", "")


_ISO_RE = re.compile(r"^\d{4}-\d{2}-\d{2}[T ]")
_NUM_RE = re.compile(r"^[\d~\s.,：:/-]+$")


def gist_ok(v: str) -> bool:
    """样例可用性：非时间戳、非纯数字/符号、有内容（≥4 字符或含 CJK）。"""
    if _ISO_RE.match(v) or _NUM_RE.fullmatch(v):
        return False
    v = v.strip()
    return len(v) >= 4 or any("一" <= c <= "鿿" for c in v)


def gist_rows(rows: list, fields: list, limit: int = 3) -> list[str]:
    """前 limit 行的首个可用文本列（≤60 字），作要点样例。"""
    out = []
    for row in rows[:limit]:
        for val in row:
            if isinstance(val, str) and gist_ok(val):
                out.append(val.replace("\n", " ")[:60])
                break
            if (isinstance(val, list) and val
                    and isinstance(val[0], str) and gist_ok(val[0])):
                out.append(val[0][:60])
                break
    return out


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--min-updated", default="2025-09-01",
                    help="仅盘点此日期后更新过的 base（ISO 前缀）")
    args = ap.parse_args()

    inv = json.loads(INVENTORY.read_text(encoding="utf-8"))
    bases = [b for b in inv
             if b.get("doc_type") == "bitable"
             and (b.get("updated") or "") >= args.min_updated]
    skipped_cred = sum(1 for b in bases if is_credential(b["title"]))
    seen_titles: set[str] = set()
    budget = [REQ_BUDGET]
    n_tab = n_rec = 0

    L = ["# 飞书多维表盘点（bitable 活数据·事实维工作面）", "",
         f"> {datetime.now():%Y-%m-%d %H:%M} · tools/cx_bitable_survey.py · "
         f"共 {len(bases)} 个 base（{args.min_updated} 后有更新；凭据类 "
         f"{skipped_cred} 个按红线跳过）· API 节流 {THROTTLE_S}s", ""]
    for b in sorted(bases, key=lambda x: x.get("updated", ""), reverse=True):
        if is_credential(b["title"]):
            continue
        if b["title"] in seen_titles:  # 复制副本（同标题双 token）只留最新
            continue
        seen_titles.add(b["title"])
        r = call_lark(["base", "+table-list", "--base-token", b["token"]], budget)
        tables = (r.get("data") or {}).get("tables") or []
        if not r.get("ok"):
            L.append(f"## {b['title'][:36]}（表清单拉取失败："
                     f"{(r.get('error') or {}).get('message', '')[:40]}）")
            L.append("")
            continue
        upd = (b.get("updated") or "")[:10]
        L.append(f"## {b['title'][:36]}（更新 {upd}，{len(tables)} 表）")
        L.append("")
        L.append("| 表 | 记录数 | 时间窗 |")
        L.append("|---|---:|---|")
        for t in tables:
            win = ""
            if (tier_of(b["title"]) == "probe"
                    and 0 < t.get("records_count", 0) <= PROBE_RECORD_MAX
                    and budget[0] > 5):
                rr = call_lark(
                    ["base", "+record-list", "--base-token", b["token"],
                     "--table-id", t["id"], "--page-size", str(PROBE_RECORD_MAX)],
                    budget)
                d = rr.get("data") or {}
                rows, fields = d.get("data") or [], d.get("fields") or []
                types = d.get("field_type_list") or []
                if rows:
                    n_rec += len(rows)
                    lo, hi = date_window(rows, fields, types)
                    win = f"{lo}~{hi}"
                    L.append(f"| {t['name']} | {t['records_count']} | {win} |")
                    for g in gist_rows(rows, fields):
                        L.append(f"  - 样例：{g}")
                else:
                    L.append(f"| {t['name']} | {t['records_count']} | — |")
            else:
                L.append(f"| {t['name']} | {t['records_count']} | — |")
            n_tab += 1
        L.append("")

    L.append("## 判读")
    L.append("")
    L.append("- AI 眼镜项目实测窗（数字见上表）：安全助手后台体量最大，"
             "用户反馈含「识别不准/模型调用失败」类真人实测意见——项目到过"
             "真机实测阶段；稽察助手后台为小样试点。")
    L.append("- 需求池/反馈池系列（2025 Q4）= 总包生态公域运营工作面。")
    L.append("- 升级路径：变更流须连接器 webhook，静态盘点外另行立项。")
    OUT.write_text("\n".join(L), encoding="utf-8")
    print(f"多维表盘点 → {OUT}（{len(bases)} base / {n_tab} 表 / {n_rec} 记录探针）")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
