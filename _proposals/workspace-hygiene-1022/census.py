# -*- coding: utf-8 -*-
"""全站普查机：尺寸地图 + 分类账 + git 可恢复性矩阵。只读，输出落盘。"""
import os, sys, json, subprocess, re
from collections import defaultdict
from pathlib import Path

ROOT = r"E:\AI-Station"
OUT = Path(r"E:\AI-Station\_proposals\workspace-hygiene-1015\work")
OUT.mkdir(parents=True, exist_ok=True)

def lp(p):  # long path
    return "\\\\?\\" + os.path.abspath(p)

CAT_RULES = [
    ("pycache", lambda p: "__pycache__" in p or p.endswith(".pyc")),
    ("pytest_cache", lambda p: ".pytest_cache" in p),
    ("node_modules", lambda p: "node_modules" in p),
    ("tmpdir", lambda p: re.search(r"[\\/](\.?tmp_|tmp_|temp_|_tmp[\\/])", p, re.I) is not None or "/.tmp" in p.replace("\\","/")),
    ("logfile", lambda p: p.lower().endswith(".log")),
    ("archive", lambda p: p.lower().endswith((".zip",".7z",".tar",".tar.gz",".tgz",".gz",".bundle",".rar"))),
    ("video", lambda p: p.lower().endswith((".mp4",".mov",".mkv",".avi",".webm"))),
    ("audio", lambda p: p.lower().endswith((".mp3",".wav",".m4a"))),
    ("image", lambda p: p.lower().endswith((".png",".jpg",".jpeg",".gif",".bmp",".webp"))),
    ("pdf", lambda p: p.lower().endswith(".pdf")),
    ("docx_office", lambda p: p.lower().endswith((".docx",".xlsx",".pptx",".doc",".xls",".ppt"))),
    ("db_sqlite", lambda p: p.lower().endswith((".db",".sqlite",".sqlite3"))),
    ("jsonl_json", lambda p: p.lower().endswith((".jsonl",".json"))),
    ("exe_bin", lambda p: p.lower().endswith((".exe",".dll",".msi",".whl"))),
]
SKIP_DIR_PARTS = ("\\.git\\",)  # .git 单独算

def categorize(fp):
    fpn = fp.replace("\\", "/")
    for name, rule in CAT_RULES:
        try:
            if rule(fp): return name
        except Exception: pass
    return "other"

top_sizes = defaultdict(int)      # 顶层目录 -> bytes
cat_sizes = defaultdict(int)      # 分类 -> bytes
top_cat = defaultdict(lambda: defaultdict(int))  # 顶层 -> 分类 -> bytes
file_count = 0; total = 0
big_files = []  # (size, path) top 200
tmp_dirs = set(); pycache_dirs = set(); log_files = []
ext_stat = defaultdict(lambda: [0, 0])  # ext -> [count, bytes]

gitdir = os.path.join(ROOT, ".git")
git_size = 0
for dp, dns, fns in os.walk(lp(ROOT)):
    dp_n = os.path.normpath(dp).removeprefix("\\\\?\\")
    rel = os.path.relpath(dp_n, ROOT)
    depth0 = rel.split(os.sep)[0] if rel != "." else "(root)"
    is_git = rel == ".git" or rel.startswith(".git" + os.sep)
    for fn in fns:
        fp = os.path.join(dp_n, fn)
        try: sz = os.path.getsize(lp(fp))
        except OSError: continue
        file_count += 1; total += sz
        top_sizes[depth0] += sz
        ext = os.path.splitext(fn)[1].lower() or "(noext)"
        ext_stat[ext][0] += 1; ext_stat[ext][1] += sz
        if is_git: git_size += sz; continue
        cat = categorize(fp)
        cat_sizes[cat] += sz
        top_cat[depth0][cat] += sz
        if len(big_files) < 200:
            big_files.append((sz, fp)); big_files.sort(reverse=True)
        elif sz > big_files[-1][0]:
            big_files[-1] = (sz, fp); big_files.sort(reverse=True)
        if cat == "logfile": log_files.append((sz, fp))
    for dn in list(dns):
        rel_d = os.path.join(rel, dn) if rel != "." else dn
        if dn.startswith((".tmp", "tmp_", "temp_")) or re.match(r"^\.?tmp", dn, re.I):
            tmp_dirs.add(os.path.join(dp_n, dn))
        if dn == "__pycache__":
            pycache_dirs.add(os.path.join(dp_n, dn))

def gb(b): return round(b / 1024**3, 3)
def mb(b): return round(b / 1024**2, 1)

# git 可恢复性
try:
    tracked = subprocess.run(["git", "-C", ROOT, "ls-files"], capture_output=True, text=True, timeout=120).stdout.splitlines()
    tracked_set = set(tracked)
    tracked_count = len(tracked_set)
except Exception:
    tracked_set = set(); tracked_count = -1

# 顶层目录只统计文件数（轻量）
top_files = defaultdict(int)
for t in top_sizes:
    try:
        for dp, dns, fns in os.walk(lp(os.path.join(ROOT, t))):
            top_files[t] += len(fns)
    except OSError: pass

report = {
    "total_bytes": total, "total_gb": gb(total), "file_count": file_count,
    "git_dir_bytes": git_size, "git_dir_gb": gb(git_size),
    "git_tracked_count": tracked_count,
    "top_dirs": [{"dir": t, "gb": gb(s), "files": top_files.get(t, 0)} for t, s in sorted(top_sizes.items(), key=lambda x: -x[1])],
    "categories": [{"cat": c, "gb": gb(s)} for c, s in sorted(cat_sizes.items(), key=lambda x: -x[1])],
    "top_cat_matrix": {t: {c: gb(s) for c, s in sorted(cs.items(), key=lambda x: -x[1])[:6]} for t, cs in sorted(top_cat.items(), key=lambda x: -sum(x[1].values()))[:25]},
    "ext_top30": [{"ext": e, "count": n, "gb": gb(b)} for e, (n, b) in sorted(ext_stat.items(), key=lambda x: -x[1][1])[:30]],
    "tmp_dirs_count": len(tmp_dirs), "pycache_dirs_count": len(pycache_dirs),
    "log_files_count": len(log_files), "log_total_gb": gb(sum(s for s, _ in log_files)),
}
(OUT / "census.json").write_text(json.dumps(report, ensure_ascii=False, indent=1), encoding="utf-8")
(OUT / "tmp_dirs.txt").write_text("\n".join(sorted(tmp_dirs)), encoding="utf-8")
(OUT / "log_files.txt").write_text("\n".join(f"{s}\t{p}" for s, p in sorted(log_files, reverse=True)), encoding="utf-8")
(OUT / "big_files.txt").write_text("\n".join(f"{s}\t{p}" for s, p in big_files), encoding="utf-8")
print(json.dumps({k: report[k] for k in ("total_gb","file_count","git_dir_gb","git_tracked_count","tmp_dirs_count","pycache_dirs_count","log_files_count","log_total_gb")}, ensure_ascii=False))
print("top10:", json.dumps(report["top_dirs"][:10], ensure_ascii=False))
print("cats:", json.dumps(report["categories"], ensure_ascii=False))
