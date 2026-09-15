# -*- coding: utf-8 -*-
"""飞书全量文档扫描（只读）。

三口径清单（--created-by-me / --mine / --opened-since 1y）→ 按 token 去重合并
→ 逐篇 docs +fetch 拉正文（markdown）。串行执行，页间/篇间节流。

用法：
    python tools/feishu_scan_docs.py inventory   # 只跑清单
    python tools/feishu_scan_docs.py fetch       # 清单 + 正文
    python tools/feishu_scan_docs.py fetch --limit 20   # 清单只取前 N 条
"""
import argparse
import json
import os
import re
import subprocess
import sys
import time

CLI = os.path.join(
    os.environ.get("APPDATA", ""),
    r"npm\node_modules\@larksuite\cli\bin\lark-cli.exe",
)
OUT_DIR = os.path.join(os.path.dirname(__file__), "..", "SELF_PROFILE", "feishu")
RAW_DIR = os.path.join(OUT_DIR, "raw")
DOCS_DIR = os.path.join(RAW_DIR, "docs")
THROTTLE = 0.6          # 秒：相邻调用间隔
PAGE_CAP = 40           # 单口径翻页硬顶（每页 20 条 → 上限 800 条）
DOC_CAP = 400           # 正文拉取硬顶
TEXT_TYPES = {"doc", "docx", "wiki"}

CREATE_NO_WINDOW = 0x08000000 if os.name == "nt" else 0


def run_cli(args, timeout=120):
    env = dict(os.environ, LARKSUITE_CLI_NO_UPDATE_NOTIFIER="1")
    proc = subprocess.run(
        [CLI] + args + ["--as", "user", "--json"],
        capture_output=True, text=True, encoding="utf-8",
        errors="replace", env=env, timeout=timeout,
        creationflags=CREATE_NO_WINDOW,
    )
    out = proc.stdout or ""
    if "{" in out:
        out = out[out.index("{"):]
    try:
        payload = json.loads(out)
    except json.JSONDecodeError:
        payload = {"ok": False, "parse_error": out[:500]}
    return payload, proc.stderr or ""


def norm_item(item, source):
    meta = item.get("result_meta") or {}
    return {
        "title": (item.get("title_highlighted") or "").strip(),
        "doc_type": (meta.get("doc_types") or item.get("entity_type") or "?").lower(),
        "token": meta.get("token") or "",
        "url": meta.get("url") or "",
        "owner": meta.get("owner_name") or "",
        "created": meta.get("create_time_iso") or "",
        "updated": meta.get("update_time_iso") or "",
        "last_open": meta.get("last_open_time_iso") or "",
        "cross_tenant": bool(meta.get("is_cross_tenant")),
        "_source": source,
    }


def paginate_search(label, base_flags, save_name):
    """翻页累积一个搜索口径；处理 opened 窗口 90 天 slice 裁剪 notice。"""
    first, err = run_cli(base_flags + ["--page-size", "20"])
    if not first.get("ok"):
        print(f"[{label}] 首次请求失败: {json.dumps(first, ensure_ascii=False)[:300]}", flush=True)
        return [], [first]
    slices = [None]
    notices = re.findall(r"--opened-since (\S+) --opened-until (\S+)", err)
    if notices and "slice" in err:
        slices = [(s, u) for s, u in notices]
        print(f"[{label}] opened 窗口裁成 {len(slices)} 个 slice", flush=True)
    collected, seen_tokens, pages_raw = [], set(), []
    for win in slices:
        flags = list(base_flags)
        if win:
            flags += ["--opened-since", win[0], "--opened-until", win[1]]
        page_token, page_no = None, 0
        while page_no < PAGE_CAP:
            call = flags + ["--page-size", "20"]
            if page_token:
                call += ["--page-token", page_token]
            payload, _ = run_cli(call)
            pages_raw.append(payload)
            if not payload.get("ok"):
                print(f"[{label}] 请求失败: {json.dumps(payload, ensure_ascii=False)[:300]}", flush=True)
                break
            data = payload.get("data") or {}
            for item in (data.get("results") or []):
                norm = norm_item(item, label)
                if norm["token"] and norm["token"] not in seen_tokens:
                    seen_tokens.add(norm["token"])
                    collected.append(norm)
            page_no += 1
            page_token = data.get("page_token")
            if not data.get("has_more") or not page_token:
                break
            time.sleep(THROTTLE)
        if win is None:
            break
    with open(os.path.join(RAW_DIR, save_name), "w", encoding="utf-8") as fh:
        json.dump(pages_raw, fh, ensure_ascii=False, indent=1)
    print(f"[{label}] 去重后 {len(collected)} 条", flush=True)
    return collected


def build_inventory(limit=None):
    os.makedirs(DOCS_DIR, exist_ok=True)
    combos = [
        ("created-by-me", ["drive", "+search", "--query", "", "--created-by-me"], "search_created_by_me.json"),
        ("mine", ["drive", "+search", "--query", "", "--mine"], "search_mine.json"),
        ("opened-1y", ["drive", "+search", "--query", "", "--opened-since", "1y"], "search_opened_1y.json"),
    ]
    merged, seen = [], set()
    for label, flags, save in combos:
        for item in paginate_search(label, flags, save):
            if item["token"] not in seen:
                seen.add(item["token"])
                merged.append(item)
        time.sleep(THROTTLE)
    if limit:
        merged = merged[:limit]
    with open(os.path.join(RAW_DIR, "doc_inventory.json"), "w", encoding="utf-8") as fh:
        json.dump(merged, fh, ensure_ascii=False, indent=1)
    by_type = {}
    for it in merged:
        by_type[it["doc_type"]] = by_type.get(it["doc_type"], 0) + 1
    print(f"[inventory] 合计 {len(merged)} 条；类型分布 {json.dumps(by_type, ensure_ascii=False)}", flush=True)
    return merged


def fetch_docs(inventory):
    ok_n, fail_n, skip_n = 0, 0, 0
    for i, item in enumerate(inventory):
        if i >= DOC_CAP:
            print(f"[fetch] 达到硬顶 {DOC_CAP}，停止", flush=True)
            break
        if item["doc_type"] not in TEXT_TYPES or not item["token"]:
            skip_n += 1
            continue
        title = item["title"] or item["token"]
        safe = re.sub(r"[^\w一-鿿-]", "_", title)[:40] or item["token"]
        path = os.path.join(DOCS_DIR, f"{safe}__{item['token']}.json")
        if os.path.exists(path):
            ok_n += 1
            continue
        payload, _ = run_cli(
            ["docs", "+fetch", "--doc", item["token"], "--doc-format", "markdown"],
            timeout=180,
        )
        payload["_title"] = title
        payload["_doc_type"] = item["doc_type"]
        payload["_url"] = item["url"]
        with open(path, "w", encoding="utf-8") as fh:
            json.dump(payload, fh, ensure_ascii=False, indent=1)
        if payload.get("ok"):
            ok_n += 1
            print(f"[fetch {i+1}] OK  {title[:50]}", flush=True)
        else:
            fail_n += 1
            print(f"[fetch {i+1}] FAIL {title[:50]} :: {json.dumps(payload, ensure_ascii=False)[:200]}", flush=True)
        time.sleep(THROTTLE)
    print(f"[fetch] 完成 ok={ok_n} fail={fail_n} skip(非文本)={skip_n}", flush=True)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("phase", choices=["inventory", "fetch"])
    ap.add_argument("--limit", type=int, default=None)
    args = ap.parse_args()
    if not os.path.exists(CLI):
        sys.exit(f"lark-cli 未找到: {CLI}")
    inventory = build_inventory(args.limit)
    if args.phase == "fetch":
        fetch_docs(inventory)


if __name__ == "__main__":
    main()
