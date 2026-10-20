#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
IMA 知识库广场收割器 —— 关键词 → 整库下载 → 去重 → 重组知识库架构
用法:
  harvest.py status                          检查登录态
  harvest.py login                           微信扫码登录(弹二维码)
  harvest.py search <关键词> [--pages 5]      广场搜库(翻页)
  harvest.py harvest <关键词> --out <目录> [--pages 3] [--max-kbs 10]
              [--min-files 5] [--workers 4] [--kb-ids id1,id2] [--yes]
  harvest.py dedup <目录>                    对已下载 _raw 去重+重组+生成索引
"""
import argparse
import hashlib
import json
import os
import re
import shutil
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from ima_replica import ImaClient, sanitize_filename, EP  # noqa: E402

CHUNK = 1 << 20


def log(msg):
    print(msg, flush=True)


# ---------- 搜索 ----------
def search_plaza(c, kw, max_pages=5, page_size=10):
    """广场搜索翻页，返回全部命中"""
    all_kbs, cursor, page = [], "", 0
    while page < max_pages:
        res = c.api("search_knowledge_base",
                    {"query": kw, "limit": page_size, "cursor": cursor})
        if res.get("code") != 0:
            raise RuntimeError(f"搜索失败: {res.get('msg')}")
        batch = res.get("searched_knowledge_bases") or []
        all_kbs.extend(batch)
        if res.get("is_end") or not res.get("next_cursor"):
            break
        cursor = res["next_cursor"]
        page += 1
    # 去重（同库多页重复命中）
    seen, uniq = set(), []
    for k in all_kbs:
        kid = k.get("id")
        if kid and kid not in seen:
            seen.add(kid)
            uniq.append(k)
    return uniq


def kb_relevance(kb, kw):
    """关键词相关性打分：库名命中>简介命中"""
    name = (kb.get("name") or "").lower()
    desc = (kb.get("description") or "").lower()
    kw_l = kw.lower()
    score = 0
    if kw_l in name:
        score += 10
    if any(w in name for w in kw_l.split() if len(w) > 1):
        score += 3
    if kw_l in desc:
        score += 2
    return score


# ---------- 下载 ----------
def harvest_kb(c, kb_id, kb_name, out_raw, workers=4, limit_files=None):
    """整库下载到 out_raw/<库名>/，返回统计"""
    target = os.path.join(out_raw, sanitize_filename(kb_name))
    files = c.get_all_files_recursive(kb_id)
    if limit_files:
        files = files[:limit_files]
    log(f"  ↓ {kb_name}: {len(files)} 个文件")
    ok = fail = skip = link = 0
    from concurrent.futures import ThreadPoolExecutor
    link_log = []

    def one(fi, idx):
        # access_status: 1=不可查看 2=可查看不可导出 3=可查看可导出（逆向实锤）
        if fi.get("access_status") == 1:
            return "skip", "无权限(不可查看)"
        sub = os.path.join(target, sanitize_filename(fi.get("path") or ""))
        st, info = c.download_media(fi["media_id"], kb_id, sub,
                                    title=fi.get("title", ""),
                                    media_type=fi.get("media_type", 0),
                                    media_type_info=fi.get("media_type_info") or {},
                                    link_log=link_log, delay=(0.5, 2))
        return st, str(info)[:120]

    with ThreadPoolExecutor(max_workers=workers) as ex:
        futs = [ex.submit(one, fi, i) for i, fi in enumerate(files)]
        for i, fu in enumerate(futs, 1):
            st, info = fu.result()
            if st == "ok":
                ok += 1
                if i % 20 == 0 or i == len(files):
                    log(f"    {i}/{len(files)} …")
            elif st == "skip":
                skip += 1
            elif st == "link":
                link += 1
            else:
                fail += 1
    if link_log:
        with open(os.path.join(target, "_links.json"), "w", encoding="utf-8") as f:
            json.dump(link_log, f, ensure_ascii=False, indent=1)
    return {"kb_id": kb_id, "kb_name": kb_name, "files_found": len(files),
            "ok": ok, "skip": skip, "link": link, "fail": fail, "dir": target}


# ---------- 去重 + 重组 ----------
def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        while True:
            b = f.read(CHUNK)
            if not b:
                break
            h.update(b)
    return h.hexdigest()


def iter_files(root):
    for dirpath, _dirs, names in os.walk(root):
        for n in names:
            if n.endswith(".part") or n.startswith("_"):
                continue
            p = os.path.join(dirpath, n)
            if os.path.isfile(p):
                yield p


def dedup_and_organize(out_root):
    """扫描 <out>/_raw/** → sha256 去重 → 复制到 <out>/<库名>/ → 生成 _index/"""
    raw = os.path.join(out_root, "_raw")
    if not os.path.isdir(raw):
        raise SystemExit(f"未找到 {raw}，先跑 harvest")
    index_dir = os.path.join(out_root, "_index")
    os.makedirs(index_dir, exist_ok=True)

    manifest, by_hash = [], {}
    total = kept = dup = 0
    t0 = time.time()
    for path in iter_files(raw):
        total += 1
        rel = os.path.relpath(path, raw)
        size = os.path.getsize(path)
        if size == 0:
            dup += 1
            manifest.append({"raw": rel, "size": 0, "sha256": None,
                             "action": "empty-skip"})
            continue
        h = sha256_file(path)
        if h in by_hash:
            dup += 1
            manifest.append({"raw": rel, "size": size, "sha256": h,
                             "action": "duplicate",
                             "kept_at": by_hash[h]["final"]})
            by_hash[h]["dupes"].append(rel)
            continue
        # 重组路径: _raw/<库名>/… → <out>/<库名>/…
        parts = rel.split(os.sep)
        final_rel = os.path.join(*parts) if parts else rel
        final = os.path.join(out_root, final_rel)
        os.makedirs(os.path.dirname(final), exist_ok=True)
        if os.path.exists(final):  # 同名不同内容 → 加短哈希后缀
            stem, ext = os.path.splitext(final)
            final = f"{stem}_{h[:6]}{ext}"
            final_rel = os.path.relpath(final, out_root)
        shutil.copy2(path, final)
        kept += 1
        rec = {"raw": rel, "final": final_rel, "size": size, "sha256": h,
               "action": "kept", "dupes": []}
        manifest.append(rec)
        by_hash[h] = rec
        if kept % 200 == 0:
            log(f"  去重中 {total} 扫描 / {kept} 保留 …")

    with open(os.path.join(index_dir, "MANIFEST.json"), "w", encoding="utf-8") as f:
        json.dump(manifest, f, ensure_ascii=False, indent=1)

    # 汇总报告
    kbs = {}
    for m in manifest:
        if m["action"] == "kept":
            kb = m["final"].split(os.sep)[0]
            kbs[kb] = kbs.get(kb, 0) + 1
    with open(os.path.join(index_dir, "知识库总览.md"), "w", encoding="utf-8") as f:
        f.write(f"# 知识库收割总览\n\n生成: {time.strftime('%Y-%m-%d %H:%M')}\n\n"
                f"- 扫描文件: {total}\n- 保留: {kept}\n- 去重/空文件: {dup}\n\n"
                f"## 各库保留文件数\n\n| 目录 | 文件数 |\n|---|---|\n")
        for kb, n in sorted(kbs.items(), key=lambda x: -x[1]):
            f.write(f"| {kb} | {n} |\n")
    with open(os.path.join(index_dir, "重复文件报告.md"), "w", encoding="utf-8") as f:
        f.write("# 重复文件（同一 sha256 只保留首份）\n\n")
        for h, rec in by_hash.items():
            if rec["dupes"]:
                f.write(f"- 保留: `{rec['final']}`\n")
                for d in rec["dupes"]:
                    f.write(f"  - 重复: `{d}`\n")
    log(f"[✓] 去重重组完成: 扫描{total} 保留{kept} 去重{dup} "
        f"({time.time()-t0:.0f}s) → _index/MANIFEST.json")
    return {"total": total, "kept": kept, "dup": dup}


# ---------- 主命令 ----------
def cmd_status(c):
    c.load_cred()
    if not c.cred:
        log("[✗] 无凭证，跑 login")
        return 1
    try:
        c.ensure_token()
        res = c.api("search_knowledge_base", {"query": "test", "limit": 1, "cursor": ""})
        log(f"[✓] 登录态有效 user_id={c.cred['user_id']} "
            f"token至{time.ctime(c.cred['token_expire_time'])} api={res.get('code')}")
        return 0
    except Exception as ex:
        log(f"[✗] 凭证失效: {ex} → 跑 login")
        return 1


def cmd_harvest(c, args):
    os.makedirs(args.out, exist_ok=True)
    raw = os.path.join(args.out, "_raw")

    # 1. 候选
    if args.kb_ids:
        kb_list = []
        for k in args.kb_ids.split(","):
            kid = k.strip()
            if not kid:
                continue
            # 从库根目录 current_path 取真实库名
            try:
                res = c.get_knowledge_list(kid, limit=1)
                nm = ((res.get("current_path") or [{}])[0]).get("name") or kid
            except Exception:
                nm = kid
            kb_list.append({"id": kid, "name": nm})
    else:
        log(f"[1/4] 广场搜索「{args.kw}」（最多{args.pages}页）…")
        cands = search_plaza(c, args.kw, args.pages)
        cands = [k for k in cands if kb_relevance(k, args.kw) > 0 or args.yes]
        cands.sort(key=lambda k: -kb_relevance(k, args.kw))
        if not cands:
            log("[✗] 无相关库，换个关键词")
            return 1
        log(f"  命中 {len(cands)} 库:")
        for k in cands[:args.max_kbs]:
            log(f"    [{k['id']}] {k.get('name','')} | "
                f"{(k.get('description') or '')[:40]}")
        kb_list = cands[:args.max_kbs]

    # 2. 逐库 join + 探文件数
    log(f"[2/4] 加入并探测 …")
    targets = []
    for k in kb_list:
        kid, name = k["id"], k.get("name") or kid
        try:
            c.join_kb(kid)
        except Exception as ex:
            log(f"  ✗ join {name}: {ex}")
            continue
        try:
            res = c.get_knowledge_list(kid, limit=1)
            n = int(res.get("total_size") or 0)
        except Exception:
            n = 0
        if n and n < args.min_files:
            log(f"  ⊘ {name}: 仅{n}文件 < {args.min_files}，跳过")
            continue
        targets.append((kid, name, n))
        log(f"  ✓ {name}: {n} 文件")

    if not targets:
        log("[✗] 无可下载库")
        return 1

    # 3. 整库下载
    log(f"[3/4] 整库下载（{len(targets)}库, {args.workers}并发）…")
    stats = []
    for kid, name, n in targets:
        try:
            st = harvest_kb(c, kid, name, raw, workers=args.workers,
                            limit_files=args.limit_files or None)
            stats.append(st)
            log(f"    ✓ ok={st['ok']} skip={st['skip']} link={st['link']} fail={st['fail']}")
        except Exception as ex:
            log(f"    ✗ {name} 失败: {ex}")
    with open(os.path.join(raw, "_harvest_stats.json"), "w", encoding="utf-8") as f:
        json.dump(stats, f, ensure_ascii=False, indent=1)

    # 4. 去重重组
    log("[4/4] 去重 + 重组知识库架构 …")
    dedup_and_organize(args.out)
    log(f"\n[完成] 输出: {args.out}\n  - 各库去重后文件在 <库名>/ 目录\n"
        f"  - 索引: _index/MANIFEST.json + 知识库总览.md + 重复文件报告.md\n"
        f"  - 原始未去重副本保留在 _raw/（确认无误后可手动删除）")
    return 0


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd", required=True)
    for name in ("status", "login"):
        sub.add_parser(name)
    sp = sub.add_parser("search")
    sp.add_argument("kw")
    sp.add_argument("--pages", type=int, default=5)
    hp = sub.add_parser("harvest")
    hp.add_argument("kw", nargs="?")
    hp.add_argument("--out", required=True)
    hp.add_argument("--pages", type=int, default=3)
    hp.add_argument("--max-kbs", type=int, default=10)
    hp.add_argument("--min-files", type=int, default=5)
    hp.add_argument("--workers", type=int, default=4)
    hp.add_argument("--kb-ids", default="")
    hp.add_argument("--yes", action="store_true")
    hp.add_argument("--limit-files", type=int, default=0)
    dp = sub.add_parser("dedup")
    dp.add_argument("root")
    args = ap.parse_args()

    c = ImaClient()
    if args.cmd == "login":
        c.login_qr()
        return
    if args.cmd == "status":
        sys.exit(cmd_status(c))
    c.load_cred()
    if not c.cred:
        sys.exit("未登录，先跑 login")
    if args.cmd == "search":
        for k in search_plaza(c, args.kw, args.pages):
            log(f"[{k['id']}] {k.get('name','')} | join_type={k.get('join_type')} | "
                f"{(k.get('description') or '')[:50]}")
    elif args.cmd == "harvest":
        if not args.kb_ids and not args.kw:
            sys.exit("需要关键词或 --kb-ids")
        sys.exit(cmd_harvest(c, args))
    elif args.cmd == "dedup":
        dedup_and_organize(args.root)


if __name__ == "__main__":
    main()
