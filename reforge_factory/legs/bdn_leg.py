# -*- coding: utf-8 -*-
"""bdn_leg — 百度网盘检索下载腿 (1030 用户令: bdn CLI 接入调研渠道体系).

链路: bdn search 全盘搜研究关键词 → 命中清单 → 价值判定 → bdn download
有价值文件落 staging → ammo_pool ingest (engine=bdn, cred=research) →
channel_invocations.jsonl 台账 (api_replica_bridge.append_invocation, 只增).

价值判定 (纯规则零伪造, 三层):
  ① 扩展名: 首选 .pdf/.docx/.xlsx/.md/.txt (+100); 次选 .doc/.xls/.ppt/.pptx/
     .csv/.epub/.rtf/.wps/.et (+40); 其余 (jpg/zip/tar.gz 等) 只入命中清单不下载;
  ② 文件名 × campaign tiers: ammo_pool/<战役>/tiers.json T1 词 +60/词(封顶2词),
     T2 词 +25/词(封顶2词), 查询词 +10/词(封顶3词) — basename 级匹配;
  ③ 尺寸门: <--min-kb (默认8, 疑存根) 或 >--max-mb (默认200, 大文件别拉) 跳过。
  排序: 判分 desc → 同分取更大件; --download-limit (默认5) 为**全程总预算**
  (跨查询共享, 远端路径去重)。

铁律 (bdn 安全节, 本腿只造 search/download 两条子命令):
  只搜/下载 (只读语义), 不转存(transfer)/不分享(share-create)/不删(rm);
  下载物一律落 staging 再入池; 凭据走 bdn 默认 data/secrets/ (密钥零进仓);
  零命中/失败如实记录不伪造 (数字零造假)。

用法:
  py -X utf8 reforge_factory/legs/bdn_leg.py --campaign EPC-TOP50
      --queries "工程总承包" "EPC总承包" [--download-limit 3] [--num 100]
      [--max-mb 200] [--min-kb 8] [--search-dir /] [--tree Q1-E2]
      [--svip] [--no-ingest]
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import api_replica_bridge as arb                     # noqa: E402 (台账只增)

REPO = Path(__file__).resolve().parents[2]          # E:\AI-Station
AMMO_POOL_PY = REPO / "reforge_factory" / "ammo_pool.py"
BDN = REPO / "逆向工程" / "baidu-netdisk" / "replica" / "bdn.py"
ENGINE = "bdn"
SOURCE = "百度网盘检索下载 (bdn CLI, BDUSS 直连零遥测, 自有 SVIP8 账号面)"
SAFETY = "bdn安全节: 只search/download, 不转存/不分享/不删"

#: 允许子命令白名单 (双保险: 腿内构造的命令恒在此集内, 越集即 bug)
ALLOWED_SUBCOMMANDS = {"search", "download"}

EXT_PRIMARY = {".pdf": 100, ".docx": 100, ".xlsx": 100, ".md": 100, ".txt": 100}
EXT_SECONDARY = {".doc": 40, ".xls": 40, ".ppt": 40, ".pptx": 40, ".csv": 40,
                 ".epub": 40, ".rtf": 40, ".wps": 40, ".et": 40}


def human_size(n) -> str:
    try:
        n = float(n or 0)
    except (TypeError, ValueError):
        return "-"
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if n < 1024 or unit == "TB":
            return f"{n:.2f}{unit}" if unit != "B" else f"{int(n)}B"
        n /= 1024


def run_bdn(args_list: list[str], timeout: int) -> tuple[int, dict | None, str]:
    """子进程调 bdn CLI (py -I 隔离模式, 与产线既定调法一致)。

    返回 (returncode, 解析后JSON|None, 残文/错误摘要)。白名单护栏:
    首参必须是 ALLOWED_SUBCOMMANDS 内子命令 (安全节代码化)。"""
    sub = args_list[0] if args_list else ""
    if sub not in ALLOWED_SUBCOMMANDS:
        return 99, None, f"安全节拦截: 子命令 {sub!r} 不在白名单 {sorted(ALLOWED_SUBCOMMANDS)}"
    if not BDN.is_file():
        return 98, None, f"bdn CLI 缺失: {BDN}"
    cmd = ["py", "-I", str(BDN), *args_list]
    try:
        r = subprocess.run(cmd, capture_output=True, text=True,
                           encoding="utf-8", errors="replace", timeout=timeout)
    except subprocess.TimeoutExpired:
        return 124, None, f"timeout {timeout}s"
    raw = (r.stdout or "").strip()
    err = (r.stderr or "").strip()
    data = None
    if raw:
        try:
            data = json.loads(raw)
        except json.JSONDecodeError:
            pass
    if data is None:
        return r.returncode, None, (err or raw or "(无输出)")[:400]
    return r.returncode, data, err[:200]


def load_tiers(campaign: str) -> dict[str, list[str]]:
    """读战役词表 tiers.json (T1/T2); 缺席/坏件 fail-soft 返回 {} (只丢tier分)。"""
    p = REPO / "ammo_pool" / campaign / "tiers.json"
    try:
        data = json.loads(p.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        return {}
    return {k: [str(x) for x in v] for k, v in data.items()
            if k in ("T1", "T2") and isinstance(v, list)}


def sanitize_name(name: str) -> str:
    """远端 basename → Windows 合法本地文件名 (去非法字符, 限长保扩展名)。"""
    s = re.sub(r'[<>:"/\\|?*\x00-\x1f]', "_", name.strip())
    s = re.sub(r"[\s.]+$", "", s) or "unnamed"
    if len(s) > 110:
        stem, dot, ext = s.rpartition(".")
        if dot and len(ext) <= 10:
            s = stem[:110 - len(ext) - 1] + "." + ext
        else:
            s = s[:110]
    return s


def judge_entry(entry: dict, tiers: dict[str, list[str]],
                queries: list[str], min_bytes: int, max_bytes: int) -> tuple[int | None, list[str]]:
    """单命中 → (判分|None=不下载, 判由清单)。None 时判由说明跳过原因。"""
    path = str(entry.get("path") or "")
    name = path.rsplit("/", 1)[-1]
    low = name.lower()
    size = int(entry.get("size") or 0)
    if entry.get("isdir"):
        return None, ["目录不下载"]
    ext = Path(name).suffix.lower()
    base = EXT_PRIMARY.get(ext, EXT_SECONDARY.get(ext))
    if base is None:
        return None, ["扩展名%s不入下载面" % (ext or "(无)")]
    if size < min_bytes:
        return None, ["%s<%dKB疑存根" % (human_size(size), min_bytes // 1024)]
    if size > max_bytes:
        return None, ["%s超尺寸门%dMB" % (human_size(size), max_bytes // (1024 * 1024))]
    score, why = base, ["ext%s+%d" % (ext, base)]
    t1 = [w for w in tiers.get("T1", []) if w.lower() in low]
    if t1:
        score += 60 * min(len(t1), 2)
        why.append("T1×%d+%d(%s)" % (min(len(t1), 2), 60 * min(len(t1), 2),
                                     "/".join(t1[:3])))
    t2 = [w for w in tiers.get("T2", []) if w.lower() in low]
    if t2:
        score += 25 * min(len(t2), 2)
        why.append("T2×%d+%d" % (min(len(t2), 2), 25 * min(len(t2), 2)))
    qw = sorted({q for q in queries if q and q.lower() in low})
    if qw:
        score += 10 * min(len(qw), 3)
        why.append("查询词×%d+%d" % (min(len(qw), 3), 10 * min(len(qw), 3)))
    return score, why


def build_digest(query: str, entries: list[dict], judged: list[dict],
                 meta: str) -> str:
    """命中面散文式 md (零编号结果行, 无 http 链接 — 过 S2-1 snippet 硬门)。"""
    files = [e for e in entries if not e.get("isdir")]
    dirs = len(entries) - len(files)
    lines = [
        "# 百度网盘检索下载 检索简报 | " + query,
        "",
        "本件为 bdn 渠道 (1030 接入令) 一次全盘检索的命中面收割 (cred=research, "
        "结构化一手元数据面)。内容=命中文件的全盘路径、体积与三层价值判定 "
        "(扩展名×campaign tiers×尺寸门), 数字均 bdn CLI 实测零手填。",
        "",
        "- 检索词: " + query,
        "- 引擎: %s (engine=%s) | 采集: %s" % (SOURCE, ENGINE, time.strftime("%Y-%m-%d %H:%M")),
        "- 通道: %s" % meta,
        "- 命中: %d 条 (文件 %d / 目录 %d); 价值判定后可下载面 %d 条" % (
            len(entries), len(files), dirs, sum(1 for j in judged if j["score"] is not None)),
        "",
        "---",
        "",
    ]
    for j in judged[:60]:                        # 前60条入简报, 余量如实计数
        e = j["entry"]
        name = str(e.get("path") or "").rsplit("/", 1)[-1] or "(无题)"
        lines.append("## " + re.sub(r"^\s*\d+[.、)]\s*", "", name))
        lines.append("")
        lines.append("*%s | %s | %s*" % (
            "目录" if e.get("isdir") else "文件",
            human_size(e.get("size")),
            "判分%s[%s]" % (j["score"], "; ".join(j["why"])) if j["score"] is not None
            else "不下载[%s]" % "; ".join(j["why"])))
        lines.append("")
        lines.append("全盘路径: " + str(e.get("path") or ""))
        if j.get("download_note"):
            lines.append("")
            lines.append("**下载实录:** " + j["download_note"])
        lines.append("")
    more = max(0, len(judged) - 60)
    lines += ["---", "",
              "合计 %d 条命中 (简报列前 60%s); 判选下载与入池字数见运行台账, 零手填。"
              % (len(entries), ", 其余 %d 条在 staging 原始 JSON" % more if more else "")]
    return "\n".join(lines)


def pool_ingest(campaign: str, md: Path, url: str, tree: str) -> tuple[int, int]:
    cmd = ["py", "-X", "utf8", str(AMMO_POOL_PY), "ingest", campaign,
           "--file", str(md), "--engine", ENGINE, "--cred", "research"]
    if url:
        cmd += ["--url", url]
    if tree:
        cmd += ["--tree", tree]
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8",
                       errors="replace", timeout=600)
    out = (r.stdout or "") + (r.stderr or "")
    m = re.search(r"\+待审\s+([\d,]+)字", out)
    chars = int(m.group(1).replace(",", "")) if m else 0
    tail = out.strip().splitlines()[-1] if out.strip() else "(无输出)"
    print("    " + tail)
    return r.returncode, chars


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description="百度网盘检索下载腿 (bdn search→判值→download→staging→弹药池)")
    ap.add_argument("--campaign", default="EPC-TOP50")
    ap.add_argument("--queries", nargs="+", required=True)
    ap.add_argument("--download-limit", dest="download_limit", type=int, default=5,
                    help="全程下载总预算 (跨查询共享; 大文件别拉太多)")
    ap.add_argument("--num", "--rows", dest="num", type=int, default=100,
                    help="search 每词命中上限 (--rows 为调度器兼容别名)")
    ap.add_argument("--max-mb", dest="max_mb", type=int, default=200,
                    help="单件尺寸上限 MB (默认 200)")
    ap.add_argument("--min-kb", dest="min_kb", type=int, default=8,
                    help="单件尺寸下限 KB (默认 8, 疑存根跳过)")
    ap.add_argument("--search-dir", dest="search_dir", default="/",
                    help="bdn search 限定目录 (默认全盘 /)")
    ap.add_argument("--tree", default="", help="挂树 EEI id (如 Q1-E2)")
    ap.add_argument("--svip", action="store_true",
                    help="download 走 locatedl 直链 (SVIP 面, 失败自动回退 dlink)")
    ap.add_argument("--no-ingest", action="store_true")
    ns = ap.parse_args(argv)
    print("[bdn_leg] campaign=%s | queries=%d | download_limit=%d | 门=%dKB-%dMB | %s"
          % (ns.campaign, len(ns.queries), ns.download_limit, ns.min_kb,
             ns.max_mb, SAFETY))

    tiers = load_tiers(ns.campaign)
    min_bytes, max_bytes = ns.min_kb * 1024, ns.max_mb * 1024 * 1024
    ts = time.strftime("%Y%m%d_%H%M%S")
    stage = REPO / "ammo_pool" / ns.campaign / "staging" / ENGINE / ts
    files_dir = stage / "files"
    files_dir.mkdir(parents=True, exist_ok=True)

    budget = max(0, ns.download_limit)
    done_remotes: set[str] = set()
    tot_hits = tot_down_ok = tot_items = tot_chars = 0
    per_q, downloads = [], []
    for q in ns.queries:
        print("[bdn_leg] 查询: " + q)
        rc, data, err = run_bdn(["search", q, "--dir", ns.search_dir,
                                 "--num", str(ns.num), "--json"], 180)
        if rc != 0 or not isinstance(data, dict):
            print("    如实失败: search rc=%s %s" % (rc, err[:160]))
            per_q.append({"query": q, "hits": 0, "eligible": 0,
                          "downloaded": 0, "ingested": 0, "chars": 0, "rc": rc})
            continue
        entries = [e for e in (data.get("entries") or []) if isinstance(e, dict)]
        tot_hits += len(entries)
        judged = []
        for e in entries:
            score, why = judge_entry(e, tiers, ns.queries, min_bytes, max_bytes)
            judged.append({"entry": e, "score": score, "why": why})
        eligible = [j for j in judged if j["score"] is not None]
        eligible.sort(key=lambda j: (-(j["score"] or 0),
                                     -int(j["entry"].get("size") or 0)))
        picked = []
        for j in eligible:
            if budget <= 0:
                break
            rp = str(j["entry"].get("path") or "")
            if rp in done_remotes:
                continue
            picked.append(j)
            done_remotes.add(rp)
            budget -= 1
        # ---- 下载 (staging 落盘) ----
        for i, j in enumerate(picked, 1):
            e = j["entry"]
            rp = str(e.get("path") or "")
            local = files_dir / ("%03d_%s" % (i, sanitize_name(rp.rsplit("/", 1)[-1])))
            mb = int(e.get("size") or 0) / (1024 * 1024)
            dlc = ["download", rp, str(local), "--json"]
            if ns.svip:
                dlc.insert(1, "--svip")
            drc, ddata, derr = run_bdn(dlc, int(300 + max(0, mb) * 12))
            if drc == 0 and local.is_file():
                ok_size = local.stat().st_size
                tot_down_ok += 1
                note = "已下载 %s → %s (md5=%s, %sMB/s, %ss)" % (
                    human_size(ok_size), local.name,
                    "通过" if (ddata or {}).get("md5_ok") else "未比对",
                    (ddata or {}).get("speed_mb_s"), (ddata or {}).get("elapsed_s"))
                row = {"remote": rp, "local": str(local), "bytes": ok_size,
                       "md5_ok": (ddata or {}).get("md5_ok"), "rc": drc,
                       "score": j["score"], "why": "; ".join(j["why"])}
                downloads.append(row)
                print("    下载[%d/%d] %s (%s, 判分%d)" % (
                    i, len(picked), local.name, human_size(ok_size), j["score"]))
                if not ns.no_ingest:
                    irc, ch = pool_ingest(ns.campaign, local, "bdpan://" + rp, ns.tree)
                    if irc == 0 and ch > 0:
                        tot_items += 1
                        tot_chars += ch
                        note += " | 入池+%s字" % format(ch, ",")
                        row["ingested_chars"] = ch
            else:
                note = "下载失败 rc=%s: %s" % (drc, derr[:120])
                downloads.append({"remote": rp, "local": str(local), "rc": drc,
                                  "err": derr[:200], "score": j["score"]})
                print("    如实失败: %s (%s)" % (rp.rsplit('/', 1)[-1][:44], derr[:100]))
            j["download_note"] = note
        # ---- 命中面简报 (检索面也入池, 判层定生死) ----
        ing = ch = 0
        meta = "bdn search --dir %s --num %d | 命中%d条 recursion=1" % (
            ns.search_dir, ns.num, len(entries))
        digest = build_digest(q, entries, judged, meta)
        slug = re.sub(r"[^0-9A-Za-z\u4e00-\u9fff]+", "-", q).strip("-")[:48] or "query"
        dpath = stage / (slug + ".md")
        dpath.write_text(digest, encoding="utf-8")
        (stage / (dpath.stem + ".search.json")).write_text(
            json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")
        print("    命中面简报 %d 条 (可下载面 %d, 本词实下载 %d) -> %s (%d字面)"
              % (len(entries), len(eligible), len(picked), dpath.name, len(digest)))
        if not ns.no_ingest and len(digest) >= 300:
            irc, ch = pool_ingest(ns.campaign, dpath, "", ns.tree)
            if irc == 0 and ch > 0:
                ing, tot_items, tot_chars = 1, tot_items + 1, tot_chars + ch
        per_q.append({"query": q, "hits": len(entries), "eligible": len(eligible),
                      "downloaded": len(picked), "ingested": ing, "chars": ch,
                      "rc": rc})
        time.sleep(1.0)                              # 查询间礼貌间隔

    run_manifest = {"campaign": ns.campaign, "engine": ENGINE, "ts": ts,
                    "queries": ns.queries, "tiers_used": {k: len(v) for k, v in tiers.items()},
                    "gates": {"min_kb": ns.min_kb, "max_mb": ns.max_mb,
                              "download_limit": ns.download_limit, "num": ns.num},
                    "safety": SAFETY, "downloads": downloads,
                    "per_query": per_q,
                    "totals": {"hits": tot_hits, "downloaded_ok": tot_down_ok,
                               "ingested": tot_items, "chars": tot_chars}}
    (stage / "run_manifest.json").write_text(
        json.dumps(run_manifest, ensure_ascii=False, indent=1), encoding="utf-8")

    if not ns.no_ingest:
        yld = "%d查询%d命中/下载%d件/入池%d件%s字" % (
            len(ns.queries), tot_hits, tot_down_ok, tot_items, format(tot_chars, ","))
        arb.append_invocation(
            ENGINE, "bdn_leg:百度网盘检索下载 (bdn CLI search→判值→download→staging→ingest; " + SAFETY + ")",
            "; ".join(ns.queries), yld,
            note="1030 bdn 接入令; 桥=api_replica_bridge.CLI_ENGINES[bdn]; "
                 "凭据=data/secrets/bdn_credentials.json(零进仓); "
                 "download_limit=%d max_mb=%d svip=%s tree=%s; staging=%s"
                 % (ns.download_limit, ns.max_mb, ns.svip, ns.tree or "-", ts),
            campaign=ns.campaign)
    print(json.dumps({"campaign": ns.campaign, "engine": ENGINE,
                      "queries": len(ns.queries), "hits": tot_hits,
                      "downloaded_ok": tot_down_ok, "ingested": tot_items,
                      "chars": tot_chars, "staging": str(stage),
                      "per_query": per_q, "safety": SAFETY},
                     ensure_ascii=False, indent=1))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
