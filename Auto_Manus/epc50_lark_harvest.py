# -*- coding: utf-8 -*-
"""EPC50 lark 转正腿 — 把 9-23 检索命中的 31 条飞书文档拉成 md 正文.

背景: lark 渠道 31 命中只落了 JSON 元数据 (50_飞书语料/ 0 字贡献) —
本腿按 token 去重逐条 export markdown, 补上渠道贡献.
配方: lark-cli drive +export (记忆 feishu-channel); 节流 1.2s/篇 (账号安全).
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

ROOT = Path(__file__).parent
LARK = Path.home() / "AppData/Roaming/npm/node_modules/@larksuite/cli/bin/lark-cli.exe"
SRC = Path(r"E:/AI-Station/ResearchFactory-Eng/ResearchTopics/"
           "《中石化南京工程有限公司怎么干EPC总承包？》/04 网络调研搜集的资料")
OUT = SRC / "50_飞书语料"
SEARCHES = ["lark_search_EPC.json", "lark_search_公司名.json"]
TYPE_MAP = {"DOCX": "docx", "DOC": "doc", "SHEET": "sheet",
            "BITABLE": "bitable", "SLIDES": "slides"}


def norm_title(t: str) -> str:
    t = re.sub(r"</?(em|h|hl)>", "", t or "").strip()
    return re.sub(r'[\\/:*?"<>|\r\n]', "_", t)[:80] or "untitled"


def collect() -> list[dict]:
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


def export_one(it: dict) -> tuple[bool, str]:
    dst = OUT / f"{it['title']}.md"
    if dst.exists():
        return True, "skip_exists"
    r = subprocess.run(
        [str(LARK), "drive", "+export", "--as", "user", "--json",
         "--token", it["token"], "--doc-type", it["doc_type"],
         "--file-extension", "markdown",
         "--output-dir", str(OUT), "--overwrite"],
        capture_output=True, text=True, encoding="utf-8", timeout=120,
        env={**__import__("os").environ,
             "LARKSUITE_CLI_NO_UPDATE_NOTIFIER": "1"})
    out = (r.stdout or "") + (r.stderr or "")
    # export 输出的文件名可能与期望不同: 找输出目录里最新 md 归位
    m = re.search(r'"(file_path|path|saved)[":\s]+([^"\n]+\.md)"?', out)
    if m:
        p = Path(m.group(2).strip())
        if p.exists() and p != dst:
            p.rename(dst)
    if dst.exists() and dst.stat().st_size > 50:
        return True, f"{dst.stat().st_size}B"
    return False, out[-120:].replace("\n", " ")


def main() -> int:
    limit = 2 if "--smoke" in sys.argv else 0
    items = collect()
    if limit:
        items = items[:limit]
    print(f"[lark] 待转正 {len(items)} 篇" + (" (冒烟)" if limit else ""), flush=True)
    ok = fail = skip = 0
    for i, it in enumerate(items, 1):
        good, note = export_one(it)
        if not good:
            fail += 1
            print(f"[{i}/{len(items)}] ✗ {it['title'][:30]} | {note}", flush=True)
        elif note == "skip_exists":
            skip += 1
        else:
            ok += 1
            print(f"[{i}/{len(items)}] ✓ {it['title'][:34]} {note}", flush=True)
        time.sleep(1.2)
    print(f"[lark] 完: 新落 {ok} / 已在 {skip} / 败 {fail}", flush=True)
    return 0 if fail == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
