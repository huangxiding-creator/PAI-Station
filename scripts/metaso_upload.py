"""通用：本地文件 → 秘塔任意知识库目录上传（2026-09-14）。

前身 scripts/metaso_upload_hundun.py（M2.5 混沌学园一次性版，已归档保留）。

复用 waytoagi-sync 的生产级 MetasoClient（登录自愈/页内 fetch/幂等契约）。
目标目录可任意指定：URL / cfid / 按名建子目录（支持 a/b 嵌套）。
台账按目标 cfid 分文件，断点续跑；格式政策：默认只传 md（--docx 可开）。

用法:
  python scripts/metaso_upload.py \
      --url "https://metaso.cn/subject-v2/<sid>/manage?cfid=<cfid>" <文件|目录...>
  python scripts/metaso_upload.py \
      --cfid <cfid> [--subject <sid>] [--folder 工程/子目录] <文件|目录...>
  加 --smoke 只传第一个；--dry-run 只列清单不开浏览器。
"""
import argparse
import glob
import json
import random
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

SKILL_SCRIPTS = Path(__file__).resolve().parent.parent / ".claude" / "skills" / \
    "waytoagi-sync" / "scripts"
sys.path.insert(0, str(SKILL_SCRIPTS))
import upload_metaso as um  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
LEDGER_DIR = ROOT / "data" / "metaso" / "_recon"


def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)


def parse_url(url):
    """metaso 管理页 URL → (subject_id, cfid)；不匹配返回 (None, None)。"""
    m = re.search(r"subject-v2/(\d+)/manage\?cfid=(\d+)", url)
    return (m.group(1), m.group(2)) if m else (None, None)


def collect_files(args_files, allow_docx):
    """位置参数（文件/目录）→ 待传 md（可选 docx）清单。"""
    out = []
    for item in args_files:
        p = Path(item)
        if p.is_file():
            out.append(p)
        elif p.is_dir():
            for g in sorted(glob.glob(str(p / "**" / "*.md"), recursive=True)):
                q = Path(g)
                if any(part.startswith("_") for part in q.relative_to(p).parts):
                    continue
                out.append(q)
            if allow_docx:
                out += [Path(g) for g in sorted(glob.glob(str(p / "**" / "*.docx"),
                                                          recursive=True))]
        else:
            log(f"⚠️ 路径不存在，跳过: {item}")
    exts = {".md"} | ({".docx"} if allow_docx else set())
    return [p for p in out if p.suffix.lower() in exts]


def resolve_target(cli, args):
    """--url/--cfid/--folder → 实际上传 cfid（建夹走 create/find，幂等）。"""
    subject, cfid = (None, None)
    if args.url:
        subject, cfid = parse_url(args.url)
        if not cfid:
            log("✗ URL 解析失败，需形如 subject-v2/<sid>/manage?cfid=<cfid>")
            return None
    elif args.cfid:
        subject, cfid = args.subject, args.cfid
    else:
        log("✗ 需 --url 或 --cfid 指定目标目录")
        return None
    if subject:
        um.SUBJECT_ID = subject  # find_folder/刷新页 URL 引用同一模块全局
    um.TARGET_CFID = cfid

    if not args.folder:
        return cfid
    cli.ensure_browser()
    if not cli.ensure_login():
        return None
    cli.tab.get(f"https://metaso.cn/subject-v2/{um.SUBJECT_ID}/manage?cfid={cfid}")
    time.sleep(2)
    cur = cfid
    for name in [n.strip() for n in args.folder.split("/") if n.strip()]:
        nxt = cli.create_folder(cur, name)
        if not nxt:
            log(f"✗ 建夹失败: {name}")
            return None
        log(f"  📁 {name} → cfid {nxt}")
        cur = nxt
    return cur


def load_ledger(path):
    done = set()
    if path.exists():
        for line in path.read_text(encoding="utf-8").splitlines():
            try:
                rec = json.loads(line)
                if rec.get("status") == "ok":
                    done.add(rec["path"])
            except Exception:
                pass
    return done


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("files", nargs="+", help="待传 md 文件或目录")
    ap.add_argument("--url", help="秘塔管理页 URL（含 subject+cfid）")
    ap.add_argument("--cfid", help="目标目录 cfid")
    ap.add_argument("--subject", help="知识库 subject id（默认 waytoagi 同库）")
    ap.add_argument("--folder", help="在目标 cfid 下建/复用子目录，支持 a/b 嵌套")
    ap.add_argument("--docx", action="store_true", help="同时允许 .docx")
    ap.add_argument("--smoke", action="store_true", help="只传第一个文件")
    ap.add_argument("--dry-run", action="store_true", help="只列清单不上传")
    args = ap.parse_args()

    jobs = collect_files(args.files, args.docx)
    if not jobs:
        log("✗ 没有可传文件")
        return 1
    if args.smoke:
        jobs = jobs[:1]

    cli = um.MetasoClient()
    target = resolve_target(cli, args) if not args.dry_run else \
        (parse_url(args.url)[1] or args.cfid or "(dry-run 未解析)")
    log(f"目标 cfid: {target}")
    log(f"待上传 {len(jobs)} 个文件:")
    for p in jobs:
        log(f"  {p}（{p.stat().st_size // 1024}KB）")
    if args.dry_run or not target:
        return 0 if args.dry_run else 1

    ledger = LEDGER_DIR / f"upload_{target}.jsonl"
    done = load_ledger(ledger)
    jobs = [p for p in jobs if str(p) not in done]
    log(f"台账跳过后余 {len(jobs)}")
    if not jobs:
        return 0

    cli.ensure_browser()
    if not cli.ensure_login():
        return 1
    cli.tab.get(f"https://metaso.cn/subject-v2/{um.SUBJECT_ID}/manage?cfid={target}")
    time.sleep(2)

    ok = fail = consec = 0
    t0 = time.time()
    for i, path in enumerate(jobs, 1):
        good, info = False, "unknown"
        for attempt in range(4):
            try:
                if path.suffix.lower() == ".docx":
                    good, info = cli.upload_docx(
                        target, um.safe_fname(path.stem, ".docx"), str(path))
                else:
                    content = path.read_text(encoding="utf-8", errors="replace")
                    good, info = cli.upload_md(
                        target, um.safe_fname(path.stem, ".md"), content)
                break
            except Exception as exc:
                info = f"conn:{type(exc).__name__}"
                log(f"  ⚡ {info} @ {path.name[:30]}，自愈 {attempt + 1}/4")
                time.sleep(5 + attempt * 15)
                if not cli.reconnect():
                    time.sleep(60)
        ledger.parent.mkdir(parents=True, exist_ok=True)
        with open(ledger, "a", encoding="utf-8") as fh:
            fh.write(json.dumps({"path": str(path), "status": "ok" if good else "fail",
                                 "info": info,
                                 "ts": time.strftime("%Y-%m-%d %H:%M:%S")},
                                ensure_ascii=False) + "\n")
        if good:
            ok += 1
            consec = 0
            log(f"  ✓ [{i}/{len(jobs)}] {path.name[:44]}（{info}）")
        else:
            fail += 1
            consec += 1
            log(f"  ✗ [{i}/{len(jobs)}] {path.name[:44]}: {info}")
            if consec >= 5:
                log("⏸️ 连续 5 次失败熔断（重跑续传）")
                break
        time.sleep(random.uniform(2, 4))
    log(f"🏁 完成：ok={ok} fail={fail} / {len(jobs)}，用时 {int(time.time() - t0)}s")
    return 0 if fail == 0 else 2


if __name__ == "__main__":
    sys.exit(main())
