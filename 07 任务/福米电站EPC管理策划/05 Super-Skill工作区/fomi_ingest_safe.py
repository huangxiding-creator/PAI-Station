# -*- coding: utf-8 -*-
"""fomi_ingest_safe - surrogates 安全的批量入池编排件 (不改产线件; 行格式与 ingest_files 同构).
用法: py -X utf8 fomi_ingest_safe.py <slow|fast>
"""
import sys
import time
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")
import ammo_pool                                        # noqa: E402

CAMPAIGN = "FOMI-EPC"
FOMI = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划")
ROOTS = [
    ("lanzhou_monograph", Path(r"D:\兰州水源地专著"), "official"),
    ("zbcx_institute", Path(r"F:\新建文件夹\AI总包创新院"), "research"),
    ("fomi_project_0104", FOMI / "01 编写管理策划的沟通", "official"),
    ("fomi_project_0104", FOMI / "02 管理策划编写需求", "official"),
    ("fomi_project_0104", FOMI / "03 福米电站项目资料", "official"),
    ("fomi_project_0104", FOMI / "04 管理策划参考资料", "official"),
    ("lanzhou_doc_conv", WS := FOMI / "05 Super-Skill工作区" / "doc_converted", "official"),
]
FAST = {".md", ".txt", ".markdown", ".docx"}
SLOW = {".pdf", ".pptx", ".xlsx", ".html", ".htm"}


def clean(t: str) -> str:
    return (t or "").encode("utf-8", errors="ignore").decode("utf-8")


def safe_ingest_files(cid: str, items: list, chunk: int = 200) -> tuple:
    d = ammo_pool._camp_dir(cid)
    added = skipped = 0
    for i in range(0, len(items), chunk):
        batch = []
        for it in items[i:i + chunk]:
            fp = Path(it["file"])
            try:
                if not fp.is_file():
                    continue
                text, _conv = ammo_pool._format_to_text(fp)
            except Exception:
                continue
            text = clean(text)
            if len(text) < 50:
                continue
            try:
                snip, rule = ammo_pool.is_snippet_only(text, it["engine"])
            except Exception:
                snip = False
            if snip:
                ammo_pool._gate_log(d, fp, it["engine"], "snippet", len(text))
                continue
            try:
                key = ammo_pool.dedup_key(None, text)
            except Exception:
                key = "raw_" + str(abs(hash(text[:500])))
            batch.append((fp, it, text, key))
        with ammo_pool._pool_lock(d):
            mp = d / "manifest.jsonl"
            have = set()
            if mp.is_file():
                for ln in mp.read_text(encoding="utf-8").splitlines():
                    ln = ln.strip()
                    if ln:
                        try:
                            have.add(ammo_pool._jload(ln).get("dedup_key", ""))
                        except Exception:
                            pass
            for fp, it, text, key in batch:
                if key in have:
                    skipped += 1
                    continue
                ch = ammo_pool.count_chars(text)
                row = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
                       "engine": it["engine"], "source_path": str(fp),
                       "url_norm": "", "chars": ch,
                       "credibility": it.get("cred", "research"),
                       "dedup_key": key, "judge": "pending",
                       "judge_reason": "", "judge_engine": "",
                       "tree_node": "", "stance": "support",
                       "budget_band": "", "text_head": text[:500]}
                with mp.open("a", encoding="utf-8") as f:
                    f.write(ammo_pool.json.dumps(row, ensure_ascii=False) + "\n")
                have.add(key)
                added += 1
        print(f"[safe] {i + len(batch):>5}/{len(items)} +{len(batch)} "
              f"(累计入 {added} 跳 {skipped})", flush=True)
    return added, skipped


def main() -> int:
    which = sys.argv[1] if len(sys.argv) > 1 else "slow"
    if which == "dir":                      # 自定目录: dir <路径> <engine标签> [fast|slow|all]
        root = Path(sys.argv[2])
        engine = sys.argv[3] if len(sys.argv) > 3 else "localfiles:adhoc"
        exts = {"fast": FAST, "slow": SLOW}.get(
            sys.argv[4] if len(sys.argv) > 4 else "all", FAST | SLOW)
        items = [{"file": str(fp), "engine": engine, "cred": "research"}
                 for fp in root.rglob("*")
                 if fp.is_file() and fp.suffix.lower() in exts]
        print(f"[safe] dir={root} 候选 {len(items)}")
        a, s = safe_ingest_files(CAMPAIGN, items)
        print(f"[safe] DONE 入池 {a} 跳过 {s}")
        return 0
    exts = FAST if which == "fast" else SLOW
    items = []
    for fam, root, cred in ROOTS:
        if not root.is_dir():
            continue
        for fp in root.rglob("*"):
            if fp.is_file() and fp.suffix.lower() in exts:
                items.append({"file": str(fp), "engine": "localfiles:" + fam,
                              "cred": cred})
    print(f"[safe] pass={which} 候选 {len(items)}")
    a, s = safe_ingest_files(CAMPAIGN, items)
    print(f"[safe] DONE 入池 {a} 跳过 {s}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
