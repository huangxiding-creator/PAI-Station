# -*- coding: utf-8 -*-
"""EPC49 lark 转正腿 — 1003 检索 206 命中(本页15)逐条 export md 正文.

配方承 epc50_lark_harvest: lark-cli drive +export, 1.2s/篇节流(账号安全).
输入: 50_飞书语料/lark_search_49.json (1003 白天检索账).
"""
import io
import json
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

LARK = Path.home() / "AppData/Roaming/npm/node_modules/@larksuite/cli/bin/lark-cli.exe"
OUT = Path(r"E:/AI-Station/ResearchFactory-Eng/ResearchTopics/"
           "《四川电力设计咨询有限责任公司怎么干EPC总承包？》/02 初次网络调研"
           "/50_飞书语料")
SEARCHES = ["lark_search_49.json"]
TYPE_MAP = {"DOCX": "docx", "DOC": "doc", "SHEET": "sheet",
            "BITABLE": "bitable", "SLIDES": "slides"}


def norm_title(t: str) -> str:
    t = re.sub(r"</?(em|h|hl)>", "", t or "").strip()
    return re.sub(r'[\\/:*?"<>|\r\n]', "_", t)[:80] or "untitled"


def collect() -> list:
    seen, items = set(), []
    for f in SEARCHES:
        d = json.loads((OUT / f).read_text(encoding="utf-8"))
        for r in (d.get("data", {}).get("results", [])):
            m = r.get("result_meta", {})
            tok = m.get("token", "")
            if not tok or tok in seen:
                continue
            seen.add(tok)
            items.append({"token": tok,
                          "doc_type": TYPE_MAP.get(m.get("doc_types", "DOCX"), "docx"),
                          "title": norm_title(r.get("title_highlighted", ""))})
    return items


def export_one(it: dict) -> tuple:
    dst = OUT / f"lark_{it['title']}.md"
    if dst.exists():
        return True, "skip"
    r = subprocess.run(
        [str(LARK), "drive", "+export", "--token", it["token"],
         "--type", it["doc_type"], "--format", "markdown", "--as", "user"],
        capture_output=True, text=True, encoding="utf-8", timeout=120)
    ok = r.returncode == 0
    if ok:
        # lark-cli export 输出到 stdout 或文件 — 与 epc50 同形态: 找产物
        for cand in OUT.glob(f"{it['token']}*"):
            cand.rename(dst)
            break
        else:
            dst.write_text(r.stdout or "", encoding="utf-8")
    return ok, (r.stderr or "")[:120]


def main() -> int:
    OUT.mkdir(parents=True, exist_ok=True)
    items = collect()
    print(f"[lark] 待转正 {len(items)} 条", flush=True)
    ok_n = 0
    for it in items:
        ok, err = export_one(it)
        ok_n += ok
        if not ok:
            print(f"[lark] 失败 {it['title'][:40]}: {err}", flush=True)
        time.sleep(1.2)  # 账号安全: 导出节流
    print(f"[lark] 完成 {ok_n}/{len(items)}", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
