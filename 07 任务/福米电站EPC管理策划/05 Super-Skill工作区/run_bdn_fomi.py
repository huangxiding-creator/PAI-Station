# -*- coding: utf-8 -*-
"""FOMI-EPC 用户百度网盘(bdn)检索/整库收割驱动 v2 — 文本表解析 + tree/pull 模式.
用法:
  py -X utf8 run_bdn_fomi.py search            # 15词检索 → bdn_search_results.jsonl
  py -X utf8 run_bdn_fomi.py tree <路径> [深度]  # 目录树 → DOCKET/bdn_tree_*.json
  py -X utf8 run_bdn_fomi.py pullplan <远端> <本地>   # 拉取计划(零下载)
  py -X utf8 run_bdn_fomi.py pull <远端> <本地>       # 实际拉取(md5校验+断点续传)
  py -X utf8 run_bdn_fomi.py plan              # 检索结果→单件下载清单
  py -X utf8 run_bdn_fomi.py download [N]      # 单件下载前N件
"""
import json
import re
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")

PY = sys.executable
BDN = r"E:\AI-Station\逆向工程\baidu-netdisk\replica\bdn.py"
WS = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划\05 Super-Skill工作区")
DOCKET = WS / "RESEARCH_DOCKET"
STAGING = WS / "bdn_staging"
DOCKET.mkdir(exist_ok=True)
RES = DOCKET / "bdn_search_results.jsonl"
PLAN = DOCKET / "bdn_download_plan.json"

QUERIES = [
    "EPC", "工程总承包", "项目管理", "FIDIC", "几内亚", "水电站",
    "施工组织设计", "管理策划", "国际工程", "莫莫克", "兰州水源地",
    "水利工程", "大坝", "监理", "安全文明施工",
]
LINE_RE = re.compile(
    r"^([d\-])\s+([\d.]+)\s*(B|KB|MB|GB|TB)\s+(.+?)\s*$")
MULT = {"B": 1, "KB": 2**10, "MB": 2**20, "GB": 2**30, "TB": 2**40}
NAME_RE = re.compile(
    r"EPC|总承包|项目管理|FIDIC|几内亚|水电|水利|大坝|施工组织|策划|"
    r"国际工程|海外工程|合同|监理|质量|安全|进度|采购|莫莫克|兰州|规范|标准|制度|手册|指南|IPMA|PMI",
    re.I)
DOC_EXT = {".pdf", ".docx", ".doc", ".txt", ".md", ".pptx", ".xlsx",
           ".xls", ".ppt", ".epub", ".mobi", ".azw3", ".chm", ".html"}


def sh(*args):
    r = subprocess.run([PY, "-X", "utf8", BDN, *args], capture_output=True,
                       text=True, encoding="utf-8", errors="replace",
                       cwd=r"E:\AI-Station")
    return r.returncode, r.stdout or "", r.stderr or ""


def parse_table(out: str, q: str = "") -> list[dict]:
    rows = []
    for ln in out.splitlines():
        m = LINE_RE.match(ln.strip())
        if not m:
            continue
        kind, num, unit, path = m.groups()
        rows.append({"kind": "dir" if kind == "d" else "file",
                     "bytes": int(float(num) * MULT[unit]), "path": path,
                     "name": path.rsplit("/", 1)[-1], "_q": q})
    return rows


def do_search():
    rows = []
    for q in QUERIES:
        rc, out, err = sh("search", q)
        got = parse_table(out, q)
        files = [r for r in got if r["kind"] == "file"]
        rows.extend(got)
        print("[bdn-search] %-8s rc=%s 行=%d (文件%d)"
              % (q, rc, len(got), len(files)))
    seen, dedup = set(), []
    for r in rows:
        if r["path"] in seen:
            continue
        seen.add(r["path"])
        dedup.append(r)
    RES.write_text("\n".join(json.dumps(r, ensure_ascii=False)
                             for r in dedup) + "\n", encoding="utf-8")
    print("[bdn-search] 去重后 %d 行 → %s" % (len(dedup), RES))


def slug(s: str) -> str:
    return re.sub(r"[^0-9A-Za-z]+", "_", s)[:40].strip("_") or "root"


def do_tree(path="/", depth=2):
    rc, out, err = sh("tree", path, "--depth", str(depth), "--json",
                      "--num", "1000", "--max-requests", "300")
    obj = None
    for ln in out.splitlines():
        ln = ln.strip()
        if ln.startswith("{"):
            try:
                obj = json.loads(ln)
            except json.JSONDecodeError:
                obj = None
    fp = DOCKET / ("bdn_tree_%s.json" % slug(path))
    if obj is not None:
        fp.write_text(json.dumps(obj, ensure_ascii=False, indent=1),
                      encoding="utf-8")
    else:
        fp.write_text(out, encoding="utf-8")
    # 摘要: 一级子目录
    def dirs_of(o, depth_left):
        rows = []
        if isinstance(o, dict):
            kids = o.get("children") or o.get("dirs") or []
            for k in kids:
                rows.append((k.get("path") or k.get("name"),
                             k.get("bytes") or 0, k.get("files_n") or 0))
        return rows
    print("[bdn-tree] %s rc=%s → %s" % (path, rc, fp.name))
    for ln in out.splitlines()[:80]:
        print("   ", ln[:150])


def do_pull(remote: str, local: str, dry: bool):
    args = ["pull", remote, local, "--max-scan-requests", "600"]
    if dry:
        args.append("--dry-run")
    rc, out, err = sh(*args)
    print("[bdn-pull%s] %s → %s rc=%s" % ("计划" if dry else "", remote,
                                          local, rc))
    tail = "\n".join((out or "").strip().splitlines()[-25:])
    print(tail[:4000])


def do_plan():
    rows = []
    for ln in RES.read_text(encoding="utf-8").splitlines():
        if ln.strip():
            try:
                rows.append(json.loads(ln))
            except json.JSONDecodeError:
                pass
    cands = []
    for r in rows:
        if r.get("kind") != "file":
            continue
        name, path = r.get("name", ""), r.get("path", "")
        ext = Path(name).suffix.lower()
        if ext not in DOC_EXT or not NAME_RE.search(name):
            continue
        b = r.get("bytes") or 0
        if b and (b < 5 * 1024 or b > 300 * 1024 * 1024):
            continue
        cands.append({"path": path, "name": name, "size": b})
    cands.sort(key=lambda x: -(x["size"] or 0))
    PLAN.write_text(json.dumps(cands, ensure_ascii=False, indent=1),
                    encoding="utf-8")
    print("[bdn-plan] 候选 %d 件 → %s" % (len(cands), PLAN))


def do_download(n=40):
    if not PLAN.is_file():
        print("[bdn-dl] 先跑 plan")
        return 1
    cands = json.loads(PLAN.read_text(encoding="utf-8"))[:n]
    STAGING.mkdir(parents=True, exist_ok=True)
    ok = fail = 0
    for c in cands:
        target = STAGING / c["name"]
        rc, out, err = sh("download", c["path"], str(target))
        tail = (out or "").strip().splitlines()[-1:] or [""]
        print("[bdn-dl] rc=%s %s | %s" % (rc, c["name"][:56], tail[0][:90]))
        ok, fail = (ok + 1, fail) if rc == 0 else (ok, fail + 1)
    print("[bdn-dl] ok=%d fail=%d → %s" % (ok, fail, STAGING))
    return 0


if __name__ == "__main__":
    mode = sys.argv[1] if len(sys.argv) > 1 else "help"
    if mode == "search":
        raise SystemExit(do_search())
    if mode == "tree":
        raise SystemExit(do_tree(
            sys.argv[2] if len(sys.argv) > 2 else "/",
            int(sys.argv[3]) if len(sys.argv) > 3 else 2))
    if mode == "pullplan":
        raise SystemExit(do_pull(sys.argv[2], sys.argv[3], True))
    if mode == "pull":
        raise SystemExit(do_pull(sys.argv[2], sys.argv[3], False))
    if mode == "plan":
        raise SystemExit(do_plan())
    if mode == "download":
        raise SystemExit(do_download(
            int(sys.argv[2]) if len(sys.argv) > 2 else 40))
    print(__doc__)
