# -*- coding: utf-8 -*-
"""L6 质检 + L7 组装 — 实测计数/禁词扫/终稿合并/质检JSON (数字零造假)."""
import json
import re
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parent
CJK = re.compile(r"[一-鿿]")
FORBIDDEN = ["待补充", "TODO", "占位", "待完善", "待确定"]

# 1) 实测每文件 CJK + 禁词
files = {}
for sub, pat in (("chapters", "*.md"), ("parts", "*.md")):
    for f in sorted((ROOT / sub).glob(pat)):
        t = f.read_text(encoding="utf-8")
        files[f"{sub}/{f.name}"] = {
            "cjk": len(CJK.findall(t)),
            "forbidden": {w: t.count(w) for w in FORBIDDEN if w in t},
            "tables": len(re.findall(r"^\|[- ]{3,}", t, re.M)) // max(1, len(re.findall(r"^\|[- ]{3,}", t, re.M))) if not re.findall(r"^\|[- ]{3,}", t, re.M) else len([1 for _ in re.finditer(r"^\|[- ]{3,}", t, re.M)]),
        }
ch_files = [k for k in files if k.startswith("chapters/")]
part_files = [k for k in files if k.startswith("parts/")]
total_ch = sum(files[k]["cjk"] for k in ch_files)
total_all = sum(v["cjk"] for v in files.values())
forbidden_hits = {k: v for k, v in ((k, files[k]["forbidden"]) for k in files) if v}
print(f"chapters={len(ch_files)} parts={len(part_files)}")
print(f"章合计CJK={total_ch:,} 全组件CJK={total_all:,}")
print("禁词命中:", forbidden_hits or "无")

# 2) URL 批检 (参考资料全量, 走代理, 8s 超时 HEAD->GET 兜底)
urls = {}
for k in files:
    t = (ROOT / k).read_text(encoding="utf-8")
    for m in re.finditer(r"\[(\d+)\]:\s*(https?://[^\s]+)", t):
        urls.setdefault(m.group(2).rstrip('")'), []).append(k)
print(f"待检URL: {len(urls)}")


def check(url):
    try:
        r = subprocess.run(
            ["curl", "-sS", "-o", "/dev/null", "--proxy", "http://127.0.0.1:7890",
             "-m", "12", "-A", "Mozilla/5.0", "-w", "%{http_code}",
             "-L", "--max-redirs", "4", url],
            capture_output=True, text=True, timeout=20)
        return (r.stdout or "").strip()
    except Exception:
        return "ERR"


bad = []
for i, (u, refs) in enumerate(urls.items()):
    code = check(u)
    if i % 20 == 0:
        print(f"  …{i}/{len(urls)}")
    if code not in ("200", "301", "302", "403"):  # 403=反爬但存在
        bad.append({"url": u, "code": code, "in": refs[:2]})
print(f"URL 异常: {len(bad)}")

# 3) 组装终稿 (P0-P4 + C1-C10 + P5)
order = (
    ["parts/00-严正声明.md", "parts/01-内容摘要.md", "parts/02-研究方法.md",
     "parts/03-报告价值.md", "parts/04-推荐序.md"]
    + [f"chapters/{n:02d}.md" for n in range(1, 11)]
    + ["parts/05-术语表.md"]
)
segs = []
for k in order:
    t = (ROOT / k).read_text(encoding="utf-8").strip()
    segs.append(t)
final = "\n\n---\n\n".join(segs) + "\n"
(ROOT / "终稿.md").write_text(final, encoding="utf-8")
final_cjk = len(CJK.findall(final))
print(f"终稿.md 组装完成: {len(final):,}B / {final_cjk:,} CJK")

# 4) 质检 JSON
qc = {
    "chapters": len(ch_files),
    "parts": len(part_files),
    "chapter_cjk_counts": {k.split("/")[1]: files[k]["cjk"] for k in ch_files},
    "chapters_total_cjk": total_ch,
    "all_components_cjk": total_all,
    "final_merged_cjk": final_cjk,
    "target": {"chapters": 10, "per_chapter_cjk": 3000, "total_cjk": 35000},
    "per_chapter_gate_pass": all(files[k]["cjk"] >= 3000 for k in ch_files),
    "total_gate_pass": final_cjk >= 35000,
    "structure_exists": True,
    "merged_exists": True,
    "docx_exists": False,
    "forbidden_terms": forbidden_hits,
    "url_checked": len(urls),
    "url_abnormal": bad,
    "engine": "manus-report-replica ModeA workflow wf_a42a2fd8 (17 agents)",
    "measured_by": "independent CJK regex count (非自报)",
}
(ROOT / "质量检查报告.json").write_text(
    json.dumps(qc, ensure_ascii=False, indent=1), encoding="utf-8")
print("质量检查报告.json 落盘")
print("GATES:", "章门", qc["per_chapter_gate_pass"], "| 总门", qc["total_gate_pass"])
