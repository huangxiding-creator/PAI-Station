# -*- coding: utf-8 -*-
"""pan_hunter_leg — 全网网盘资源检索腿 (1031 用户令: PAN-HUNTER ph.py 接入调研渠道体系).

链路: ph.py search 九活源全网搜研究关键词 → 命中清单 (交付层绿盘/发现层黄盘) →
绿盘价值判定 → ph.py download 免登直下 (增长熔断+扩展名门) → staging →
ammo_pool ingest (engine=pan_hunter, cred=media) → channel_invocations.jsonl
台账 (api_replica_bridge.append_invocation, 只增)。

价值判定 (纯规则零伪造, 三层):
  ① 红绿灯: 绿盘 (uc/lanzou/ilanzou/feijipan/ecpan) 免登直下 +80 入下载面;
     黄盘 (quark/baidu/aliyun/xunlei/139) =发现层只入命中清单不下载 (交付走
     本地凭据插件, 默认关 — 法务原则#3 零凭据托管);
  ② URL 词面 × campaign tiers: ammo_pool/<战役>/tiers.json T1 词 +60/词(封顶2词),
     T2 词 +25/词(封顶2词), 查询词 +10/词(封顶3词) — URL 解百分码后小写匹配;
  ③ 下载后门: 扩展名首选 .pdf/.docx/.xlsx/.md/.txt / 次选 .doc/.xls/.ppt/.pptx/
     .csv/.epub/.rtf/.wps/.et 才入池 (ph.py 首件≥min-mb 自选, 网盘常见视频/压缩
     包如实记「扩展名不入面」留 staging); 下载中文件增长超 --max-mb (默认200)
     即熔断杀进程 (网盘文件可能很大), 部分件留 staging 不入池。
  排序: 判分 desc; --download-limit (默认3) 为**全程总预算** (跨查询共享, URL去重)。

铁律 (ph.py 安全节, 本腿只造 search/download 两条子命令):
  只搜/下载 (只读语义), 不转存/不分享/不删; 下载物一律落 staging 再入池;
  零登录零凭据 (BDCLND 等分享面派生令牌除外, 密钥零进仓); 法务四原则:
  收割物仅内部调研语料 (purpose=research, ph.py 自写 download_audit.jsonl);
  零命中/失败如实记录不伪造 (数字零造假)。

用法:
  py -X utf8 reforge_factory/legs/pan_hunter_leg.py --campaign EPC-TOP50
      --queries "工程总承包 EPC" "工程 图集" [--download-limit 3] [--max-mb 200]
      [--min-mb 1] [--rows 20 别名兼容] [--tree Q1-E2] [--no-ingest]
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
import sys
import time
from pathlib import Path
from urllib.parse import unquote

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import api_replica_bridge as arb                     # noqa: E402 (台账只增)

REPO = Path(__file__).resolve().parents[2]          # E:\AI-Station
AMMO_POOL_PY = REPO / "reforge_factory" / "ammo_pool.py"
PH = REPO / "逆向工程" / "pan-hunter" / "ph.py"
ENGINE = "pan_hunter"
SOURCE = ("全网网盘资源检索 (ph.py 九活源聚合 melost/mikuclub/panhunt/hunhepan/naspt/"
          "pansearch/tg/bixin/miosou, 21盘红绿灯; 绿5盘免登直下)")
SAFETY = "ph.py安全节: 只search/download, 不转存/不分享/不删; 零登录零凭据"

#: 允许子命令白名单 (双保险: 腿内构造的命令恒在此集内, 越集即 bug)
ALLOWED_SUBCOMMANDS = {"search", "download"}

EXT_PRIMARY = {".pdf": 100, ".docx": 100, ".xlsx": 100, ".md": 100, ".txt": 100}
EXT_SECONDARY = {".doc": 40, ".xls": 40, ".ppt": 40, ".pptx": 40, ".csv": 40,
                 ".epub": 40, ".rtf": 40, ".wps": 40, ".et": 40}

SEARCH_TIMEOUT = 300        # 九源×间隔2-3.5s+超时重试, 实测40-90s/词
DOWNLOAD_WALL = 300         # 单件下载墙钟 (增长熔断另算)


def human_size(n) -> str:
    try:
        n = float(n or 0)
    except (TypeError, ValueError):
        return "-"
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if n < 1024 or unit == "TB":
            return f"{n:.2f}{unit}" if unit != "B" else f"{int(n)}B"
        n /= 1024


def run_ph(args_list: list[str], timeout: int) -> tuple[int, dict | list | None, str]:
    """子进程调 ph.py (py -I 隔离模式)。返回 (returncode, 解析后JSON|None, 残文/错误摘要)。
    白名单护栏: 首参必须在 ALLOWED_SUBCOMMANDS 内 (安全节代码化)。"""
    sub = args_list[0] if args_list else ""
    if sub not in ALLOWED_SUBCOMMANDS:
        return 99, None, f"安全节拦截: 子命令 {sub!r} 不在白名单 {sorted(ALLOWED_SUBCOMMANDS)}"
    if not PH.is_file():
        return 98, None, f"ph.py 缺失: {PH}"
    cmd = ["py", "-I", str(PH), *args_list]
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


def download_with_cap(url: str, out_dir: Path, min_mb: int, max_bytes: int,
                      wall: int = DOWNLOAD_WALL) -> tuple[int, Path | None, str]:
    """ph.py download + 增长熔断: 轮询落盘件, 超 max_bytes 杀进程 (网盘大文件护栏)。
    返回 (rc, 下载件|None, 附注)。部分件留 staging 不删 (清理只认用户令)。"""
    out_dir.mkdir(parents=True, exist_ok=True)
    before = {p.name for p in out_dir.iterdir() if p.is_file()}
    cmd = ["py", "-I", str(PH), "download", url, "--out", str(out_dir),
           "--min-mb", str(min_mb)]
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                            text=True, encoding="utf-8", errors="replace")
    t0, capped = time.time(), False
    try:
        while True:
            rc = proc.poll()
            if rc is not None:
                break
            if time.time() - t0 > wall:
                proc.kill()
                time.sleep(1)
                return 124, _newest(out_dir, before), "墙钟%ds熔断" % wall
            for p in out_dir.iterdir():
                if p.is_file() and p.stat().st_size > max_bytes:
                    capped = True
                    break
            if capped:
                proc.kill()
                time.sleep(1)
                f = _newest(out_dir, before)
                return 125, f, "增长熔断>%s (部分件如实留staging)" % human_size(max_bytes)
            time.sleep(2)
        out, _ = proc.communicate(timeout=30)
    finally:
        if proc.poll() is None:
            proc.kill()
    note_bits = []
    if capped:
        note_bits.append("增长熔断")
    out = out or ""
    m = re.search(r"完成：(\d+) bytes\s+sha1=([0-9A-Fa-f]+)", out or "")
    if m:
        note_bits.append("sha1=" + m.group(2)[:12] + "…")
    em = re.search(r"PanError: (.+)", out or "")
    if em:
        note_bits.append("上游: " + em.group(1).strip()[:80])
    f = _newest(out_dir, before)
    if proc.returncode == 0 and f is None:
        return 1, None, "rc=0但无落盘件: " + ((out or "").strip().splitlines()[-1] if out.strip() else "(无输出)")[:120]
    return proc.returncode, f, "; ".join(note_bits)


def _newest(d: Path, before: set[str]) -> Path | None:
    """out_dir 内本次新出现的最大件 (download 一次只落一件)。"""
    cands = [p for p in d.iterdir() if p.is_file() and p.name not in before]
    return max(cands, key=lambda p: p.stat().st_size) if cands else None


def load_tiers(campaign: str) -> dict[str, list[str]]:
    """读战役词表 tiers.json (T1/T2); 缺席/坏件 fail-soft 返回 {} (只丢tier分)。"""
    p = REPO / "ammo_pool" / campaign / "tiers.json"
    try:
        data = json.loads(p.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        return {}
    return {k: [str(x) for x in v] for k, v in data.items()
            if k in ("T1", "T2") and isinstance(v, list)}


def url_face(url: str) -> str:
    """URL 解百分码 → 小写, 供词面匹配 (盘链常编码文件名/转写名)。"""
    try:
        return unquote(url).lower()
    except Exception:
        return url.lower()


def judge_hit(hit: dict, tiers: dict[str, list[str]],
              queries: list[str]) -> tuple[int | None, list[str]]:
    """单命中 → (判分|None=不下载, 判由清单)。绿=可直下面, 黄/死=发现层不入下载面。"""
    light = str(hit.get("light") or "")
    if light != "绿":
        return None, ["%s盘=发现层(交付走凭据插件默认关)" % (hit.get("disk") or "?")]
    face = url_face(str(hit.get("url") or ""))
    score, why = 80, ["绿盘免登直下+80"]
    t1 = [w for w in tiers.get("T1", []) if w.lower() in face]
    if t1:
        score += 60 * min(len(t1), 2)
        why.append("T1×%d+%d(%s)" % (min(len(t1), 2), 60 * min(len(t1), 2),
                                     "/".join(t1[:3])))
    t2 = [w for w in tiers.get("T2", []) if w.lower() in face]
    if t2:
        score += 25 * min(len(t2), 2)
        why.append("T2×%d+%d" % (min(len(t2), 2), 25 * min(len(t2), 2)))
    qw = sorted({q for q in queries if q and q.lower() in face})
    if qw:
        score += 10 * min(len(qw), 3)
        why.append("查询词×%d+%d" % (min(len(qw), 3), 10 * min(len(qw), 3)))
    ext = Path(face.split("?")[0]).suffix
    if ext in EXT_PRIMARY:
        score += 30
        why.append("URL尾部%s+30" % ext)
    return score, why


def fp(url: str) -> str:
    """链接指纹 (简报/台账用, 原链留 staging 原始 JSON — 简报零http链接过 S2-1 门)。"""
    return "%s/%s" % ((url.split("//", 1)[-1].split("/", 1)[0] or "url"),
                      hashlib.sha1(url.encode("utf-8")).hexdigest()[:10])


def base_url(url: str) -> str:
    """剥离空格分隔的提取码尾巴, 留纯链接 (入池 url 字段稳定去重键)。"""
    return url.split()[0].strip() if url.strip() else url


def build_digest(query: str, hits: list[dict], judged: list[dict], meta: str) -> str:
    """命中面散文式 md (零编号结果行, 无 http 链接 — 过 S2-1 snippet 硬门)。"""
    from collections import Counter
    by_disk = Counter(str(h.get("disk") or "?") for h in hits)
    green = sum(1 for h in hits if h.get("light") == "绿")
    lines = [
        "# 全网网盘资源检索 检索简报 | " + query,
        "",
        "本件为 pan_hunter 渠道 (1031 接入令) 九活源全网网盘聚合检索的命中面收割 "
        "(cred=media, 结构化一手元数据面)。内容=命中分享的盘型红绿灯、来源站与"
        "三层价值判定 (红绿灯×campaign tiers×下载后门), 数字均 ph.py CLI 实测零手填。",
        "",
        "- 检索词: " + query,
        "- 引擎: %s (engine=%s) | 采集: %s" % (SOURCE, ENGINE, time.strftime("%Y-%m-%d %H:%M")),
        "- 通道: %s" % meta,
        "- 命中: %d 条 (绿盘可直下 %d / 发现层 %d); 盘型分布: %s; 价值判定后可下载面 %d 条" % (
            len(hits), green, len(hits) - green,
            "、".join("%s%d" % kv for kv in by_disk.most_common()),
            sum(1 for j in judged if j["score"] is not None)),
        "",
        "---",
        "",
    ]
    for j in judged[:60]:                        # 前60条入简报, 余量如实计数
        h = j["hit"]
        lines.append("## %s盘 · %s源 · 指纹%s" % (
            h.get("disk") or "?", h.get("source") or "?", fp(str(h.get("url") or ""))[:28]))
        lines.append("")
        lines.append("*%s | %s*" % (
            "绿盘免登直下" if h.get("light") == "绿" else "%s盘发现层" % (h.get("light") or "?"),
            "判分%s[%s]" % (j["score"], "; ".join(j["why"])) if j["score"] is not None
            else "不下载[%s]" % "; ".join(j["why"])))
        lines.append("")
        if j.get("download_note"):
            lines.append("**下载实录:** " + j["download_note"])
            lines.append("")
    more = max(0, len(judged) - 60)
    lines += ["---", "",
              "合计 %d 条命中 (简报列前 60%s); 黄盘交付面=本地凭据插件(默认关, "
              "法务原则#3); 判选下载与入池字数见运行台账, 零手填。"
              % (len(hits), ", 其余 %d 条在 staging 原始 JSON" % more if more else "")]
    return "\n".join(lines)


def pool_ingest(campaign: str, md: Path, url: str, tree: str) -> tuple[int, int]:
    cmd = ["py", "-X", "utf8", str(AMMO_POOL_PY), "ingest", campaign,
           "--file", str(md), "--engine", ENGINE, "--cred", "media"]
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
        description="全网网盘资源检索腿 (ph.py search→判值→绿盘download→staging→弹药池)")
    ap.add_argument("--campaign", default="EPC-TOP50")
    ap.add_argument("--queries", nargs="+", required=True)
    ap.add_argument("--download-limit", dest="download_limit", type=int, default=3,
                    help="全程下载总预算 (跨查询共享; 网盘文件可能很大, 默认只拉3件)")
    ap.add_argument("--rows", dest="rows", type=int, default=0,
                    help="兼容别名 (ph.py search 无 rows 形参, 收下不转发)")
    ap.add_argument("--max-mb", dest="max_mb", type=int, default=200,
                    help="单件增长熔断上限 MB (默认 200, 超限杀下载留部分件)")
    ap.add_argument("--min-mb", dest="min_mb", type=int, default=1,
                    help="ph.py download 首件偏好下限 MB (默认 1, 文档件友好)")
    ap.add_argument("--tree", default="", help="挂树 EEI id (如 Q1-E2)")
    ap.add_argument("--no-ingest", action="store_true")
    ns = ap.parse_args(argv)
    print("[pan_hunter_leg] campaign=%s | queries=%d | download_limit=%d | 熔断=%dMB | %s"
          % (ns.campaign, len(ns.queries), ns.download_limit, ns.max_mb, SAFETY))

    tiers = load_tiers(ns.campaign)
    max_bytes = ns.max_mb * 1024 * 1024
    ts = time.strftime("%Y%m%d_%H%M%S")
    stage = REPO / "ammo_pool" / ns.campaign / "staging" / ENGINE / ts
    files_dir = stage / "files"
    files_dir.mkdir(parents=True, exist_ok=True)

    budget = max(0, ns.download_limit)
    done_urls: set[str] = set()
    tot_hits = tot_green = tot_down_ok = tot_items = tot_chars = 0
    per_q, downloads = [], []
    for q in ns.queries:
        print("[pan_hunter_leg] 查询: " + q)
        rc, data, err = run_ph(["search", q, "--json"], SEARCH_TIMEOUT)
        hits = [h for h in (data or []) if isinstance(h, dict)] if isinstance(data, list) else []
        if rc != 0 or not isinstance(data, list):
            print("    如实失败: search rc=%s %s" % (rc, err[:160]))
            per_q.append({"query": q, "hits": 0, "green": 0, "eligible": 0,
                          "downloaded": 0, "ingested": 0, "chars": 0, "rc": rc})
            continue
        tot_hits += len(hits)
        tot_green += sum(1 for h in hits if h.get("light") == "绿")
        judged = []
        for h in hits:
            score, why = judge_hit(h, tiers, ns.queries)
            judged.append({"hit": h, "score": score, "why": why})
        eligible = [j for j in judged if j["score"] is not None]
        eligible.sort(key=lambda j: -(j["score"] or 0))
        picked = []
        for j in eligible:
            if budget <= 0:
                break
            u = base_url(str(j["hit"].get("url") or ""))
            if not u or u in done_urls:
                continue
            picked.append(j)
            done_urls.add(u)
            budget -= 1
        # ---- 绿盘直下 (增长熔断 + staging 落盘) ----
        for i, j in enumerate(picked, 1):
            h = j["hit"]
            u = base_url(str(h.get("url") or ""))
            slot = files_dir / ("q%d_%02d_%s" % (abs(hash(q)) % 1000, i,
                                                 fp(u).replace("/", "_")))
            drc, f, note = download_with_cap(u, slot, ns.min_mb, max_bytes)
            if drc == 0 and f is not None and f.is_file():
                ok_size = f.stat().st_size
                ext = f.suffix.lower()
                tot_down_ok += 1
                if ext in EXT_PRIMARY or ext in EXT_SECONDARY:
                    note = "已下载 %s → %s (%s)" % (human_size(ok_size), f.name, note or "sha1见ph审计")
                    row = {"url": u, "disk": h.get("disk"), "source": h.get("source"),
                           "local": str(f), "bytes": ok_size, "ext": ext, "rc": drc,
                           "score": j["score"], "why": "; ".join(j["why"])}
                    downloads.append(row)
                    print("    下载[%d/%d] %s (%s, %s盘, 判分%d)" % (
                        i, len(picked), f.name, human_size(ok_size),
                        h.get("disk"), j["score"]))
                    if not ns.no_ingest:
                        irc, ch = pool_ingest(ns.campaign, f, u, ns.tree)
                        if irc == 0 and ch > 0:
                            tot_items += 1
                            tot_chars += ch
                            note += " | 入池+%s字" % format(ch, ",")
                            row["ingested_chars"] = ch
                else:
                    note = ("已下载 %s 但扩展名%s不入文档面, 留staging不入池 (网盘常见"
                            "媒体/压缩件, 如实记)" % (human_size(ok_size), ext or "(无)"))
                    downloads.append({"url": u, "disk": h.get("disk"), "local": str(f),
                                      "bytes": ok_size, "ext": ext, "rc": drc,
                                      "ingested": False, "gate": "ext"})
                    print("    扩展名门: %s (%s) 不入池" % (f.name, ext or "(无)"))
            else:
                note = "下载失败 rc=%s: %s" % (drc, note or err[:100])
                downloads.append({"url": u, "disk": h.get("disk"), "rc": drc,
                                  "err": (note or "")[:200], "score": j["score"]})
                print("    如实失败: %s (%s)" % (fp(u)[:24], (note or "")[:100]))
            j["download_note"] = note
        # ---- 命中面简报 (发现层也入池, 判层定生死) ----
        ing = ch = 0
        meta = "ph.py search --json | 九活源聚合 | 命中%d条 (绿%d)" % (len(hits), tot_green)
        digest = build_digest(q, hits, judged, meta)
        slug = re.sub(r"[^0-9A-Za-z\u4e00-\u9fff]+", "-", q).strip("-")[:48] or "query"
        dpath = stage / (slug + ".md")
        dpath.write_text(digest, encoding="utf-8")
        (stage / (dpath.stem + ".search.json")).write_text(
            json.dumps(hits, ensure_ascii=False, indent=1), encoding="utf-8")
        print("    命中面简报 %d 条 (绿 %d, 可下载面 %d, 本词实下载 %d) -> %s (%d字面)"
              % (len(hits), sum(1 for h in hits if h.get("light") == "绿"),
                 len(eligible), len(picked), dpath.name, len(digest)))
        if not ns.no_ingest and len(digest) >= 300:
            irc, ch = pool_ingest(ns.campaign, dpath, "", ns.tree)
            if irc == 0 and ch > 0:
                ing, tot_items, tot_chars = 1, tot_items + 1, tot_chars + ch
        per_q.append({"query": q, "hits": len(hits),
                      "green": sum(1 for h in hits if h.get("light") == "绿"),
                      "eligible": len(eligible), "downloaded": len(picked),
                      "ingested": ing, "chars": ch, "rc": rc})
        time.sleep(2.0)                              # 查询间礼貌间隔 (源间隔≥2s铁律)

    run_manifest = {"campaign": ns.campaign, "engine": ENGINE, "ts": ts,
                    "queries": ns.queries, "tiers_used": {k: len(v) for k, v in tiers.items()},
                    "gates": {"download_limit": ns.download_limit, "max_mb": ns.max_mb,
                              "min_mb": ns.min_mb, "rows_alias": ns.rows},
                    "safety": SAFETY, "downloads": downloads,
                    "per_query": per_q,
                    "totals": {"hits": tot_hits, "green": tot_green,
                               "downloaded_ok": tot_down_ok,
                               "ingested": tot_items, "chars": tot_chars}}
    (stage / "run_manifest.json").write_text(
        json.dumps(run_manifest, ensure_ascii=False, indent=1), encoding="utf-8")

    if not ns.no_ingest:
        yld = "%d查询%d命中(绿%d)/下载%d件/入池%d件%s字" % (
            len(ns.queries), tot_hits, tot_green, tot_down_ok, tot_items,
            format(tot_chars, ","))
        arb.append_invocation(
            ENGINE, "pan_hunter_leg:全网网盘资源检索 (ph.py九活源search→判值→绿盘download→staging→ingest; " + SAFETY + ")",
            "; ".join(ns.queries), yld,
            note="1031 pan_hunter 接入令; 桥=api_replica_bridge.CLI_ENGINES[pan_hunter]; "
                 "零登录零凭据; download_limit=%d max_mb=%d(增长熔断) min_mb=%d tree=%s; "
                 "ph.py审计=逆向工程/pan-hunter/analysis/download_audit.jsonl; staging=%s"
                 % (ns.download_limit, ns.max_mb, ns.min_mb, ns.tree or "-", ts),
            campaign=ns.campaign)
    print(json.dumps({"campaign": ns.campaign, "engine": ENGINE,
                      "queries": len(ns.queries), "hits": tot_hits, "green": tot_green,
                      "downloaded_ok": tot_down_ok, "ingested": tot_items,
                      "chars": tot_chars, "staging": str(stage),
                      "per_query": per_q, "safety": SAFETY},
                     ensure_ascii=False, indent=1))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
