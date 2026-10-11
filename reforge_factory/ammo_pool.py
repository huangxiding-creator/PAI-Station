# -*- coding: utf-8 -*-
"""弹药池 (Ammo Foundry F-2) — 千万字弹药工程核心件, 用户 09-22 批准 R0.

门槛语义铁律 (用户 09-22 终版定调, 不可漂移):
  1. 单课题门槛 = 本次任务**新增**调研资料 >= 1000 万字 (存量不计入);
  2. 每次研究报告任务 = 全新全渠道调研, 从头开始;
  3. 新增资料**通过有效性判断才计数**: 入池=pending 不计门槛, 判有效才入账;
  4. 成稿素材不受限: 报告生成可用一切掌握的资料 = 存量 + 本次新增
     (存量不上门槛账, 但成稿阶段照常可用 — 门槛管计数, 不管引用);
  5. 弹药等价原则: 渠道资料与军团成果同池同 schema 同核验.

判断链 (三铁律: 免费优先/fail-soft/证据先行):
  R0 = 本地启发式 (免费: 课题相关性+实质度+垃圾页特征, 判不了就留 pending);
  R3 = Jev S2 硬门接管 (F-3 接线后 --engine jev).

池结构 (全站级资产, 本地明文 — Ghost 律):
  E:\\AI-Station\\ammo_pool\\<campaign_id>\\
    manifest.jsonl    每条弹药一行 (judge: pending|valid|rejected + 判由)
    pool_state.json   实时账本 (门槛账=valid; 待审/废弃只作审计)

用法:
  python ammo_pool.py init <campaign_id> --kw "EPC 总承包 水利"
  python ammo_pool.py ingest <cid> --file <path> --engine own:rss [--url URL] [--cred media]
  python ammo_pool.py judge <cid> [--limit 500]        # pending -> valid/rejected
  python ammo_pool.py stocktake <cid> --dirs <dir> [--kw "..."]   # 只读, 不入池
  python ammo_pool.py status <cid>                     # 仪表: 门槛账只认 valid
"""
from __future__ import annotations

import argparse
import contextlib
import hashlib
import json
import os
import re
import sys
import time
from pathlib import Path
from urllib.parse import urlsplit, urlunsplit, parse_qsl

try:                                    # FT-4 辛迪加折叠 (fail-soft)
    from syndicate import effective_hosts
except Exception:                       # 缺件不拖垮弹药池, 退回 raw hosts
    effective_hosts = None

try:                                    # FT-5 信源权威度接线 (fail-soft)
    sys.path.insert(0, str(             # RF-Eng collectors 表在位则借规则
        Path(__file__).resolve().parents[1] / "ResearchFactory-Eng"
        / "EPC100" / "collectors"))
    from source_authority import authority, grade_authority
except Exception:                       # 缺件=行缺权威度两键, 不拖垮入池
    authority = None
    grade_authority = None

if sys.stdout:                           # 1006: pythonw/无控制台时 sys.stdout=None, 无守卫 import 即炸 (conductor router 15 连跳根因)
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

STATION = Path(r"E:\AI-Station")
POOL_ROOT = STATION / "ammo_pool"
AMMO_GATE_CHARS = 200_000_000  # 1004用户终版令: 门槛 2亿 (NB 2.5亿预算 = 2亿采集 + 0.5亿萃取炼金)
# 1005 用户定调 (分层门槛 v3, 接棒旧总量门): 有效资料 = 对当前研究报告
# 有帮助的资料 — 行业泛词命中不再等同有效. 判据:
#   T1 报告直接(研究对象本体) ≥ 300万 且 T1+T2(同业对标) ≥ 3000万 才算达标;
#   T3 行业框架封顶 5000万 计参考; T0 泛命中(标题无课题词)不计入.
# 词表 = 战役目录 tiers.json {"T1": [...], "T2": [...]}; 分层为标题级下界.
T1_MIN_CHARS = 3_000_000
T12_MIN_CHARS = 30_000_000
T3_CAP_CHARS = 50_000_000
# S2-2 预算分档三档 (与 S1-1 BAND_BY_ROLE 同词表: 框架期宽面/章级窄面/
# 补弹); 入池行带档 → tier_report by_band 分列, 消耗分桶可查.
BUDGET_BANDS = ("outline_wide", "section_narrow", "gap")


def tier_report(cid: str) -> dict:
    """分层账 (标题级下界, dedup 后): manifest valid 行 × tiers.json 词表.

    返回 t1/t2/t3/t0 字数与件数、t3_capped、gate_chars(合成门槛账) 与
    gate_ok(分层双门判定); by_band 分列 (S2-2 消耗分桶, ""=存量未归档).
    无 tiers.json 时 tiers_configured=False,
    调用方应回退旧总量门并提示补词表."""
    d = _camp_dir(cid)
    tp = d / "tiers.json"
    t1k: list[str] = []
    t2k: list[str] = []
    if tp.is_file():
        cfg = json.loads(tp.read_text(encoding="utf-8"))
        t1k, t2k = cfg.get("T1", []), cfg.get("T2", [])
    kws = (_load_state(d).get("kws") or []) if (d / "pool_state.json").is_file() else []
    t = {"t1": 0, "t2": 0, "t3": 0, "t0": 0, "n1": 0, "n2": 0, "n3": 0,
         "n0": 0, "tiers_configured": bool(t1k)}
    by_band: dict[str, dict] = {}
    mp = d / "manifest.jsonl"
    seen: set[str] = set()
    if mp.is_file():
        for line in mp.read_text(encoding="utf-8").splitlines():
            line = line.strip()
            if not line:
                continue
            try:
                r = json.loads(line)
            except json.JSONDecodeError:
                continue
            if r.get("judge") != "valid":
                continue
            key = r.get("dedup_key") or r.get("url_norm") \
                or r.get("source_path") or ""
            if key:
                if key in seen:          # manifest 行=文件×问题对, 行累加=虚账
                    continue
                seen.add(key)
            title = os.path.basename(r.get("source_path")
                                     or r.get("url_norm") or "")
            ch = r.get("chars") or 0
            if t1k and any(k in title for k in t1k):
                tk, nk = "t1", "n1"
            elif t2k and any(k in title for k in t2k):
                tk, nk = "t2", "n2"
            elif any(k in title for k in kws):
                tk, nk = "t3", "n3"
            else:
                tk, nk = "t0", "n0"
            t[tk] += ch
            t[nk] += 1
            band = r.get("budget_band") or ""
            b = by_band.setdefault(band, {"chars": 0, "items": 0})
            b["chars"] += ch
            b["items"] += 1
    t["by_band"] = by_band
    t["t3_capped"] = min(t["t3"], T3_CAP_CHARS)
    t["gate_chars"] = t["t1"] + t["t2"] + t["t3_capped"]
    t["gate_ok"] = (t["t1"] >= T1_MIN_CHARS
                    and t["t1"] + t["t2"] >= T12_MIN_CHARS)
    return t



# ---------- URL 归一化 (跨引擎去重键) ----------
_UTM = re.compile(r"^(utm_|spm|from|share|chksm|scene|srcid)")


def norm_url(url: str) -> str:
    """小写 host + 去 utm 族参数 + 去尾斜杠 — 弹药等价原则的去重基础."""
    try:
        p = urlsplit(url.strip())
        q = "&".join(f"{k}={v}" for k, v in parse_qsl(p.query)
                     if not _UTM.match(k))
        path = p.path.rstrip("/") or "/"
        return urlunsplit((p.scheme.lower(), p.netloc.lower(), path, q, ""))
    except ValueError:
        return url.strip()


def dedup_key(url: str | None, text_head: str) -> str:
    """URL 优先; 无 URL 用内容前 500 字指纹."""
    if url:
        return "u:" + hashlib.sha1(norm_url(url).encode()).hexdigest()[:16]
    return "c:" + hashlib.sha1(
        re.sub(r"\s", "", text_head)[:500].encode()).hexdigest()[:16]


def count_chars(text: str) -> int:
    """有效字数: 去空白后的字符数 (中文口径)."""
    return len(re.sub(r"\s", "", text))


def read_text_safe(p: Path) -> str:
    """文本提取 (1004 夜班扩容令: ima公开库/巨潮公告大批 PDF 落盘, 池须能读).

    pdf 走 pypdf 抽取文本 (计字/判相关性都用纯文本, 绝不数二进制垃圾);
    docx 走 zipfile+document.xml 剥标签 (零依赖); 坏件回空串 → judge 判
    pending(file_missing 语义) 不静默计数.
    """
    suf = p.suffix.lower()
    if suf == ".pdf":
        try:
            from pypdf import PdfReader
            return "\n".join((pg.extract_text() or "")
                             for pg in PdfReader(str(p)).pages)
        except Exception:
            return ""
    if suf == ".docx":
        try:
            import zipfile
            with zipfile.ZipFile(str(p)) as z:
                xml = z.read("word/document.xml").decode("utf-8",
                                                         errors="ignore")
            return re.sub(r"<[^>]+>", " ", xml)
        except Exception:
            return ""
    if suf == ".pptx":
        try:                                  # 1005: 智库课件pptx是肉
            import zipfile
            with zipfile.ZipFile(str(p)) as z:
                parts = sorted(n for n in z.namelist()
                               if n.startswith("ppt/slides/slide")
                               and n.endswith(".xml"))
                xml = " ".join(z.read(n).decode("utf-8", errors="ignore")
                               for n in parts)
            return re.sub(r"<[^>]+>", " ", xml)
        except Exception:
            return ""
    for enc in ("utf-8", "gbk", "utf-16"):
        try:
            return p.read_text(encoding=enc, errors="ignore")
        except OSError:
            return ""
    return ""


def parse_kws(kw: str) -> list[str]:
    return [k for k in re.split(r"[\s,，、]+", kw) if len(k) >= 2]


# ---------- 证据分级 (G3: Cochrane GRADE 简化版) ----------
GRADE_MAP = {"official": "A", "research": "B", "media": "B",
             "unknown": "C"}   # A=官方一手 B=权威二手 C=未验证


# ---------- 有效性判断 (R0 启发式 — 免费优先/fail-soft/证据先行) ----------
_GARBAGE = ("登录后查看", "请输入验证码", "404 Not Found", "403 Forbidden",
            "扫码关注", "访问过于频繁", "页面不存在", "网络出错")
MIN_SUBSTANCE = 300   # 实质度: 去空白后至少 300 字


def judge_heuristic(text: str, kws: list[str]) -> tuple[str, str]:
    """返回 (verdict, reason). 判不了相关性时返回 pending — 绝不静默计数."""
    if count_chars(text) < MIN_SUBSTANCE:
        return "rejected", f"substance<{MIN_SUBSTANCE}"
    head = text[:3000]
    if sum(1 for g in _GARBAGE if g in head) >= 2:
        return "rejected", "garbage_page"
    if not kws:
        return "pending", "no_campaign_kws"   # 无判据=不计数 (fail-soft)
    body = text[:8000]
    # 1005 全文窗口: 长 PDF 前置封面/目录/版权页吃掉 8000 字窗口,
    # 《中建四局EPC全景洞察》59万字核心弹药被误杀实锤 — 全量扫 (in 是
    # C 级子串搜索, 5万字×19词 ~1ms); 语义兜底见战役腿 semantic_rescue.
    if not any(k in text for k in kws):
        return "rejected", "off_topic"
    return "valid", "kw_hit+substance_ok"


# ---------- S2-1 snippet 不入池硬门 (全量检索 snippet-only 零入池) ----------
# 保守三规则: 宁可漏 (judge 层兜底) 不可错杀全文. 误杀全文=弹药真损失,
# 漏放 snippet=审计可见 (snippet-audit 复查).
_SNIPPET_ENG_MARKS = ("serp", "snippet", "搜索清单", "线索")
_SERP_LINE = re.compile(r"^#{0,3}\s*\d+[.、)]\s+\S", re.M)


def is_snippet_only(text: str, engine: str = "") -> tuple[bool, str]:
    """全量检索 snippet-only 件判定 (纯规则, 零网络). 返回 (是, 规则名).

    三规则: ①engine 自标 (serp/snippet/搜索清单/线索) ②SERP 面形
    (前 4000 字 ≥3 编号结果行 ∧ ≥3 URL) ③检索 JSON 原样落盘 ({"hits" 头)."""
    eng = (engine or "").lower()
    if any(m in eng for m in _SNIPPET_ENG_MARKS):
        return True, "engine_marked"
    if not text:
        return False, ""
    head = text[:4000]
    if head.lstrip().startswith('{"hits"'):
        return True, "search_json_dump"
    if len(_SERP_LINE.findall(head)) >= 3 and head.count("http") >= 3:
        return True, "serp_shape"
    return False, ""


def _gate_log(d: Path, fp: Path, engine: str, rule: str, chars: int) -> None:
    """硬门拦截留痕 (snippet_gate.jsonl — grep 可证入池记录恒 0)."""
    rec = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "file": str(fp),
           "engine": engine, "rule": rule, "chars": chars}
    with (d / "snippet_gate.jsonl").open("a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")


def snippet_audit(cid: str = "") -> dict:
    """manifest 全行 snippet 形复查 (验收: snippet-only 入池记录 = 0).

    判据=text_head(500字窗)+engine 同规则; 战役缺省=全池扫.
    返回 {campaign: {"rows": n, "snippet_rows": n, "rules": {…}}}."""
    roots = ([_camp_dir(cid)] if cid else
             [p for p in POOL_ROOT.iterdir()
              if p.is_dir() and (p / "manifest.jsonl").is_file()])
    out: dict = {}
    for d in roots:
        rows, snip, rules = 0, 0, {}
        for ln in (d / "manifest.jsonl").read_text(
                encoding="utf-8").splitlines():
            if not ln.strip():
                continue
            rows += 1
            r = json.loads(ln)
            hit, rule = is_snippet_only(r.get("text_head", ""),
                                        r.get("engine", ""))
            if hit:
                snip += 1
                rules[rule] = rules.get(rule, 0) + 1
        out[d.name] = {"rows": rows, "snippet_rows": snip, "rules": rules}
    return out


# ---------- 池操作 (immutability: 读→新对象→原子写回) ----------
def _camp_dir(cid: str) -> Path:
    if not re.fullmatch(r"[A-Za-z0-9_\-]{3,40}", cid):
        raise ValueError(f"非法 campaign_id: {cid}")
    return POOL_ROOT / cid


def _load_state(d: Path) -> dict:
    p = d / "pool_state.json"
    if p.is_file():
        return json.loads(p.read_text(encoding="utf-8"))
    return {"campaign": d.name, "kws": [], "total_chars": 0, "items": 0,
            "pending_chars": 0, "pending_items": 0,
            "rejected_chars": 0, "rejected_items": 0,
            "by_engine": {}, "domains": [], "gate_chars": AMMO_GATE_CHARS,
            "created": time.strftime("%Y-%m-%d %H:%M")}


def _save_state(d: Path, s: dict) -> None:
    d.mkdir(parents=True, exist_ok=True)
    tmp = d / "pool_state.tmp"
    tmp.write_text(json.dumps(s, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    # WinError 5 瞬态锁 (AV/索引器扫 pool_state.json) 有界重试 —
    # 1011 实锤: 无重试时 1.5 万件级长跑被一次瞬态锁整跑打断
    for i in range(5):
        try:
            tmp.replace(d / "pool_state.json")
            return
        except PermissionError:
            if i == 4:
                raise
            time.sleep(0.2 * (i + 1))


def _manifest_keys(d: Path) -> set[str]:
    p = d / "manifest.jsonl"
    if not p.is_file():
        return set()
    return {json.loads(x).get("dedup_key", "") for x in
            p.read_text(encoding="utf-8").splitlines() if x.strip()}


LOCK_STALE_S = 1800          # 锁属主 30min 无进展 = 僵尸, 允许接管


@contextlib.contextmanager
def _pool_lock(d: Path, timeout: float = 600.0):
    """跨进程池锁 (O_EXCL, 与全站 tasklist+O_EXCL 范式同源).

    1004 事故根治: 白天入账班 (慢 PDF 抽字, 持旧基线数小时) 与夜腿
    judge 并发写 pool_state → 后写者覆盖先写者 (kw2 +30.2万字账目
    回退实锤). ingest/judge 的 load→mutate→save 临界区全部串行化;
    僵尸锁 (属主崩死) 按 mtime 年龄接管, 不死等.
    """
    lock = d / "pool.lock"
    d.mkdir(parents=True, exist_ok=True)
    t0 = time.time()
    while True:
        try:
            fd = os.open(str(lock), os.O_CREAT | os.O_EXCL | os.O_WRONLY)
            os.write(fd, f"{os.getpid()} {time.strftime('%m-%d %H:%M:%S')}"
                     .encode("ascii"))
            os.close(fd)
            break
        except FileExistsError:
            try:
                age = time.time() - lock.stat().st_mtime
            except OSError:
                age = 0.0
            if age > LOCK_STALE_S:
                print(f"[pool-lock] 僵尸锁 {age / 60:.0f}min, 接管",
                      flush=True)
                lock.unlink(missing_ok=True)
                continue
            if time.time() - t0 > timeout:
                raise TimeoutError("pool lock 等待超时 (600s)")
            time.sleep(2)
    try:
        yield
    finally:
        lock.unlink(missing_ok=True)


def rebuild(cid: str) -> int:
    """pool_state 从 manifest 全量重算 (manifest = 唯一真源).

    manifest 是 append + 原子重写, 并发覆盖打不到它; pool_state 是
    读改写, 任何历史覆盖/手工误改都能在这里自愈. 门槛账三桶
    (valid/pending/rejected) 与 by_engine/domains 全部按行重算.
    """
    d = _camp_dir(cid)
    mp = d / "manifest.jsonl"
    if not mp.is_file():
        print(f"[pool] 无 manifest: {cid}", file=sys.stderr)
        return 1
    with _pool_lock(d):
        rows = [json.loads(x) for x in
                mp.read_text(encoding="utf-8").splitlines() if x.strip()]
        s = _load_state(d)
        by_eng: dict = {}
        doms: list = []
        tot = pen = rej = 0
        it = pit = rit = 0
        for r in rows:
            ch, j = r.get("chars", 0), r.get("judge", "pending")
            if j == "valid":
                tot += ch
                it += 1
                e = r.get("engine", "?")
                by_eng[e] = by_eng.get(e, 0) + ch
                host = (urlsplit(r["url_norm"]).netloc
                        if r.get("url_norm")
                        else Path(r["source_path"]).stem)
                if host and host not in doms:
                    doms.append(host)
            elif j == "rejected":
                rej += ch
                rit += 1
            else:
                pen += ch
                pit += 1
        ns = {**s, "total_chars": tot, "items": it,
              "pending_chars": pen, "pending_items": pit,
              "rejected_chars": rej, "rejected_items": rit,
              "by_engine": by_eng, "domains": doms[:2000],
              "last_rebuild": time.strftime("%Y-%m-%d %H:%M")}
        _save_state(d, ns)
    print(f"[rebuild] manifest {len(rows)} 条 → 有效 {tot:,}字/{it}件 | "
          f"待审 {pen:,}字/{pit}件 | 废弃 {rej:,}字/{rit}件 | "
          f"引擎 {len(by_eng)} 个")
    return 0


def ingest(cid: str, file: str, engine: str, url: str = "",
           cred: str = "unknown", tree: str = "",
           stance: str = "support", band: str = "") -> int:
    """单条入池: URL 归一 + 去重 + source_engine 标记 + 挂树 (G3).
    入池即 pending, **不计门槛账** — 判有效 (judge) 才计数 (用户铁律).
    tree=EEI id (question_tree.json, 如 Q1-E2); stance=support/against/
    contradict (对竞争假设的立场 — ACH 对抗场原料).
    band=预算分档三档 (S2-2: outline_wide/section_narrow/gap; 非法值
    归 ""=存量未归档) — tier_report by_band 消耗分桶可查.
    行落 text_head[:500] (FT-4 辛迪加折叠比对原料 — 缺字段折叠空转) 与
    authority_score/authority_grade 两键 (FT-5 权威度维, import 缺件时缺键)."""
    d = _camp_dir(cid)
    if not d.is_dir():
        print(f"[pool] 战役池不存在, 先 init {cid}", file=sys.stderr)
        return 1
    fp = Path(file)
    if not fp.is_file():
        print(f"[pool] 文件不存在: {file}", file=sys.stderr)
        return 1
    # 1004 快路: 路径已入池直接跳 — 免得入账班每次重跑都把全部
    # PDF 重新抽字一遍 (119 件标准 PDF ~10min 纯浪费).
    mp = d / "manifest.jsonl"
    if mp.is_file() and any(
            json.loads(x).get("source_path") == str(fp)
            for x in mp.read_text(encoding="utf-8").splitlines() if x.strip()):
        return 0
    text = read_text_safe(fp)
    if len(text) < 50:
        print(f"[pool] 跳过 (太短): {fp.name}")
        return 0
    snip, rule = is_snippet_only(text, engine)      # S2-1 硬门: 零入池
    if snip:
        _gate_log(d, fp, engine, rule, len(text))
        print(f"[pool] 硬拒 snippet-only ({rule}): {fp.name[:44]} "
              f"— 全文腿取回后再入池")
        return 0
    key = dedup_key(url or None, text)
    with _pool_lock(d):
        if key in _manifest_keys(d):
            print(f"[pool] 跳过 (重复): {fp.name}")
            return 0
        ch = count_chars(text)
        row = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "engine": engine,
               "source_path": str(fp), "url_norm": norm_url(url) if url else "",
               "chars": ch, "credibility": cred, "dedup_key": key,
               "judge": "pending", "judge_reason": "", "judge_engine": "",
               "tree_node": tree, "stance": stance,
               "budget_band": band if band in BUDGET_BANDS else "",
               "text_head": text[:500]}   # FT-4: 缺此键辛迪加折叠恒空转
        if authority is not None:         # FT-5: 权威度两键 (缺件缺键不炸)
            score = int(authority(url or str(fp)).get("score", 3))
            row = {**row, "authority_score": score,   # 未分级默认 3 诚实降档
                   "authority_grade": grade_authority(score)}
        with (d / "manifest.jsonl").open("a", encoding="utf-8") as f:
            f.write(json.dumps(row, ensure_ascii=False) + "\n")
        s = _load_state(d)
        ns = {**s, "pending_chars": s.get("pending_chars", 0) + ch,
              "pending_items": s.get("pending_items", 0) + 1}
        _save_state(d, ns)
    print(f"[pool] +待审 {ch:>7,}字 {fp.name[:36]:<36} "
          f"待审判有效后计数 (现待审 {ns['pending_chars']:,})")
    return 0


def ingest_files(cid: str, items: list, chunk: int = 400) -> tuple:
    """批量入池 (1011 cross-ingest 腿): 单条 ingest 每次全量重读
    manifest + 持锁抽字, 万件级长跑 = O(n²) 且长时间占池锁.
    本腿分块: 抽字/判 snippet 在**锁外**预做, 每块一次持锁 —
    manifest 键集读 + 追加 + state 写, 锁占用秒级 (hook_harvest
    PT5M 落地腿不被堵). 行字段与 ingest() 完全同构 (G3 挂树键/
    S2-1 snippet 硬拒/FT-4 text_head/待审计数 全保留).

    items: [{"file": 路径, "engine": 源标记, "cred": 可信级}, ...]
    返回 (入池件数, 跳过件数). 幂等: source_path + dedup_key 双查重."""
    d = _camp_dir(cid)
    if not d.is_dir():
        print(f"[pool] 战役池不存在, 先 init {cid}", file=sys.stderr)
        return (0, len(items))
    added = skipped = 0
    for i in range(0, len(items), chunk):
        batch = []                                   # 锁外抽字
        for it in items[i:i + chunk]:
            fp = Path(it["file"])
            try:
                if not fp.is_file():
                    continue
                text = read_text_safe(fp)
            except Exception:
                continue
            if len(text) < 50:
                continue
            snip, rule = is_snippet_only(text, it["engine"])
            if snip:
                _gate_log(d, fp, it["engine"], rule, len(text))
                continue
            batch.append((fp, it, text, dedup_key(None, text)))
        with _pool_lock(d):
            mp = d / "manifest.jsonl"
            have: set = set()
            keys: set = set()
            if mp.is_file():
                for x in mp.read_text(encoding="utf-8").splitlines():
                    if not x.strip():
                        continue
                    r = json.loads(x)
                    have.add(r.get("source_path"))
                    keys.add(r.get("dedup_key", ""))
            lines = []
            for fp, it, text, key in batch:
                if str(fp) in have or key in keys:
                    skipped += 1
                    continue
                lines.append(json.dumps(
                    {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
                     "engine": it["engine"], "source_path": str(fp),
                     "url_norm": "", "chars": count_chars(text),
                     "credibility": it.get("cred", "unknown"),
                     "dedup_key": key, "judge": "pending",
                     "judge_reason": "", "judge_engine": "",
                     "tree_node": it.get("tree", ""), "stance": "support",
                     "budget_band": "", "text_head": text[:500]},
                    ensure_ascii=False))
                have.add(str(fp))
                keys.add(key)
            if lines:
                with mp.open("a", encoding="utf-8") as f:
                    f.write("\n".join(lines) + "\n")
                s = _load_state(d)
                ns = {**s, "pending_chars": s.get("pending_chars", 0)
                      + sum(json.loads(x)["chars"] for x in lines),
                      "pending_items": s.get("pending_items", 0) + len(lines)}
                _save_state(d, ns)
                added += len(lines)
        print(f"[batch] {min(i + chunk, len(items)):>6}/{len(items)} "
              f"+{len(lines)} (累计跳 {skipped})", flush=True)
    print(f"[batch] 入池 {added} / 跳过 {skipped}")
    return (added, skipped)


def judge(cid: str, limit: int = 500) -> int:
    """有效性判断: pending -> valid (入门槛账) / rejected (审计废弃).
    判据随行写入 manifest; 文件丢失/无课题关键词 -> 保持 pending 不计数.
    1004: 全程持池锁 (并发写覆盖根治)."""
    d = _camp_dir(cid)
    mp = d / "manifest.jsonl"
    if not mp.is_file():
        print(f"[pool] 无 manifest: {cid}", file=sys.stderr)
        return 1
    with _pool_lock(d):
        return _judge_locked(d, mp, limit)


def _judge_locked(d: Path, mp: Path, limit: int) -> int:
    s = _load_state(d)
    kws = s.get("kws", [])
    if not kws:
        print("[judge] 战役未配置课题关键词 (init --kw), 无法判相关性 — "
              "全部保持 pending, 绝不静默计数", file=sys.stderr)
        return 2
    rows = [json.loads(x) for x in
            mp.read_text(encoding="utf-8").splitlines() if x.strip()]
    n_valid = n_rej = n_keep = 0
    for row in rows:
        if limit and n_valid + n_rej >= limit:
            break
        if row.get("judge", "pending") != "pending":
            continue
        fp = Path(row["source_path"])
        text = read_text_safe(fp) if fp.is_file() else ""
        if not text:
            row.update(judge="pending", judge_reason="file_missing",
                       judge_engine="heuristic")
            n_keep += 1
            continue
        verdict, reason = judge_heuristic(text, kws)
        row.update(judge=verdict, judge_reason=reason, judge_engine="heuristic",
                   grade=GRADE_MAP.get(row.get("credibility", "unknown"), "C"))
        ch = row["chars"]
        if verdict == "valid":
            n_valid += 1
            s = {**s, "total_chars": s["total_chars"] + ch,
                 "items": s["items"] + 1,
                 "pending_chars": s["pending_chars"] - ch,
                 "pending_items": s["pending_items"] - 1,
                 "by_engine": {**s["by_engine"],
                               row["engine"]: s["by_engine"].get(
                                   row["engine"], 0) + ch}}
            host = (urlsplit(row["url_norm"]).netloc
                    if row["url_norm"] else fp.stem)
            if host and host not in s["domains"]:
                s = {**s, "domains": [*s["domains"], host][:2000]}
        else:
            n_rej += 1
            s = {**s,
                 "rejected_chars": s.get("rejected_chars", 0) + ch,
                 "rejected_items": s.get("rejected_items", 0) + 1,
                 "pending_chars": s["pending_chars"] - ch,
                 "pending_items": s["pending_items"] - 1}
    tmp = d / "manifest.tmp"
    tmp.write_text("\n".join(json.dumps(r, ensure_ascii=False)
                             for r in rows) + "\n", encoding="utf-8")
    tmp.replace(mp)
    _save_state(d, {**s, "last_judge": time.strftime("%Y-%m-%d %H:%M")})
    print(f"\n[判断] 启发式@课题关键词({len(kws)}): 有效 {n_valid} 入门槛账 | "
          f"废弃 {n_rej} | 留审 {n_keep} (文件缺失)")
    print(f"[门槛账] 有效弹药 {s['total_chars']:,} 字 "
          f"({100 * s['total_chars'] / AMMO_GATE_CHARS:.2f}% of 2亿) | "
          f"待审 {s['pending_chars']:,} 字 | 废弃 {s.get('rejected_chars', 0):,} 字")
    return 0


def stocktake(cid: str, dirs: list[str], kw: str = "") -> int:
    """全站资产盘点 (纯只读统计, 不入战役池) — 用户 09-22 令: 存量不参与
    报告生产, 战役池只收新增调研资料; 本命令仅作全站资产摸底报表."""
    kws = parse_kws(kw)
    scanned = relevant = skipped_short = skipped_kw = 0
    total = 0
    by_dir: dict[str, int] = {}
    for ds in dirs:
        root = Path(ds)
        if not root.is_dir():
            print(f"[盘点] 目录不存在, 跳过: {ds}", file=sys.stderr)
            continue
        for p in sorted(root.rglob("*")):
            if p.suffix.lower() not in (".md", ".txt", ".json"):
                continue
            scanned += 1
            text = read_text_safe(p)
            if len(text) < 200:
                skipped_short += 1
                continue
            if kws:
                head = text[:2000]
                if not any(k in head or k in p.name for k in kws):
                    skipped_kw += 1
                    continue
            relevant += 1
            ch = count_chars(text)
            total += ch
            by_dir[root.name] = by_dir.get(root.name, 0) + ch
    print(f"\n[全站资产盘点·只读] 扫描 {scanned} | 相关 {relevant} | "
          f"太短弃 {skipped_short} | 不相关弃 {skipped_kw}")
    print(f"[相关存量] {total:,} 字 (全站资产摸底; 不入战役池, 不算门槛; "
          f"成稿阶段可作素材引用 — 用户 09-22 终版定调)")
    for k, v in sorted(by_dir.items(), key=lambda x: -x[1])[:5]:
        print(f"  {k[:24]:<24} {v:>12,}")
    return 0


def coverage(cid: str) -> int:
    """G4 覆盖度仪表 (饱和门): 问题树逐 EEI 亮灯.
    饱和=该 EEI 有效证据 >=2 条且独立信源 >=2 (交叉验证);
    子问题级另判反证位 (stance=against 至少 1 条 valid).
    灯: ✓饱和 △单源 ○零源 ✗缺反证. 不足叶子=缺口清单→下轮采集任务."""
    d = _camp_dir(cid)
    tp = d / "question_tree.json"
    if not tp.is_file():
        print(f"[coverage] 无问题树, 先 question_tree.py generate {cid}",
              file=sys.stderr)
        return 1
    tree = json.loads(tp.read_text(encoding="utf-8"))
    rows = []
    mp = d / "manifest.jsonl"
    if mp.is_file():
        rows = [json.loads(x) for x in
                mp.read_text(encoding="utf-8").splitlines() if x.strip()]
    valid = [r for r in rows if r.get("judge") == "valid"]
    by_eei: dict[str, list[dict]] = {}
    for r in valid:
        if r.get("tree_node"):
            by_eei.setdefault(r["tree_node"], []).append(r)
    n_sat = n_gap = 0
    n_syn = 0                                   # FT-4: 折叠掉的辛迪加组数
    print(f"\n╔═ 覆盖度仪表 (饱和门) ═ {cid} ═ {tree['topic']}")
    for q in tree["subquestions"]:
        eei_flags = []
        for e in q["eeis"]:
            ev = by_eei.get(e["id"], [])
            hosts = {(urlsplit(r["url_norm"]).netloc or
                      Path(r["source_path"]).stem) for r in ev}
            if effective_hosts is not None:      # FT-4: 同文多站 = 1 票
                eff = effective_hosts(ev)        # 缺 text_head 的行原样参与
                n_syn += sum(1 for h in eff if str(h).startswith("syn-"))
                hosts = eff
            if len(ev) >= 2 and len(hosts) >= 2:
                e["status"], flag = "saturated", "✓"
                n_sat += 1
            elif len(ev) == 1 or (ev and len(hosts) == 1):
                e["status"], flag = "single", "△"
                n_gap += 1
            else:
                e["status"], flag = "zero", "○"
                n_gap += 1
            eei_flags.append(f"{e['id']}:{flag}{len(ev)}")
        has_against = any(r.get("stance") == "against" for r in valid
                          if r.get("tree_node", "").startswith(q["id"] + "-"))
        q_flag = "✓" if all(e["status"] == "saturated" for e in q["eeis"]) \
            else ("✗缺反证" if not has_against else "△")
        print(f"║ {q['id']} [{q['dim']}] {q_flag} {q['text'][:38]}")
        print(f"║    {' '.join(eei_flags)}")
    total_eei = sum(len(q["eeis"]) for q in tree["subquestions"])
    sat_pct = 100 * n_sat / max(1, total_eei)
    tree["coverage"] = {"eei_total": total_eei, "saturated": n_sat,
                        "gap": n_gap, "sat_pct": round(sat_pct, 1),
                        "syndicate_groups": n_syn,
                        "checked": time.strftime("%Y-%m-%d %H:%M")}
    tp.write_text(json.dumps(tree, ensure_ascii=False, indent=1),
                  encoding="utf-8")
    print(f"║")
    print(f"║ 饱和度: {n_sat}/{total_eei} EEI ({sat_pct:.1f}%) | "
          f"缺口 {n_gap} 个 → 下轮定向采集任务源")
    print(f"║ 辛迪加折叠: {n_syn} 组 (同文多站 = 1 票, 通稿不冒充共识)")
    tr = tier_report(d.name)
    char_gate = tr["gate_ok"] if tr["tiers_configured"] else (
        json.loads((d / "pool_state.json").read_text(encoding="utf-8"))
        ["total_chars"] >= AMMO_GATE_CHARS)
    gate_name = "分层门" if tr["tiers_configured"] else "总量门(未配tiers.json)"
    print(f"║ 报告准入: 字数门[{gate_name}] "
          f"({'✅' if char_gate else '⏳ 未过'}) "
          f"∧ 饱和门 ({'✅' if sat_pct >= 80 else f'⏳ {sat_pct:.0f}%<80%'}) "
          f"— 双门全过才准成稿")
    return 0


def status(cid: str) -> int:
    """仪表首屏: 门槛账只认有效弹药 (valid); 待审/废弃为审计副账."""
    d = _camp_dir(cid)
    if not d.is_dir():
        print(f"[pool] 战役池不存在: {cid}", file=sys.stderr)
        return 1
    s = _load_state(d)
    pct = min(1.0, s["total_chars"] / AMMO_GATE_CHARS)
    bar = "█" * int(pct * 30) + "░" * (30 - int(pct * 30))
    print(f"\n╔═ 弹药池仪表 ═ {cid}")
    print(f"║ 课题关键词: {' | '.join(s.get('kws', [])) or '(未配置!)'}")
    print(f"║ 门槛账 [有效新增弹药 — 通过判断才计数, 用户铁律]:")
    print(f"║   {s['total_chars']:>12,} / {AMMO_GATE_CHARS:,}  "
          f"[{bar}] {pct * 100:.1f}%")
    print(f"║   有效条目: {s['items']:,} | 独立信源域: {len(s['domains']):,}")
    print(f"║   待审: {s.get('pending_items', 0):,} 条 / "
          f"{s.get('pending_chars', 0):,} 字 (judge 后移动)")
    print(f"║   废弃: {s.get('rejected_items', 0):,} 条 / "
          f"{s.get('rejected_chars', 0):,} 字 (off_topic/垃圾/太短)")
    print(f"║   门槛状态: {'✅ 已过门 (可进撰写)' if pct >= 1 else '⏳ 未过门 (有效弹药继续)'}")
    tr = tier_report(cid)
    if tr["tiers_configured"]:
        print(f"║ 分层门槛账 [1005 用户定调: 有效=对当前研究报告有帮助]:")
        print(f"║   T1 报告直接  {tr['t1']:>12,} 字 ({tr['n1']:,}件) / {T1_MIN_CHARS:,} 门 "
              f"{'✅' if tr['t1'] >= T1_MIN_CHARS else '⏳'}")
        t12 = tr['t1'] + tr['t2']
        print(f"║   T1+T2 对标  {t12:>12,} 字 ({tr['n1']+tr['n2']:,}件) / {T12_MIN_CHARS:,} 门 "
              f"{'✅' if t12 >= T12_MIN_CHARS else '⏳'}")
        print(f"║   T3 框架封顶 {tr['t3_capped']:>12,} 字 (raw {tr['t3']:,}) | "
              f"T0 泛命中 {tr['t0']:,} 字 不计入")
        print(f"║   合成门槛账  {tr['gate_chars']:>12,} 字 | "
              f"分层判定: {'✅ 已过分层门' if tr['gate_ok'] else '⏳ 未过分层门'}")
    else:
        print(f"║ ⚠️ 未配 tiers.json — 分层门未生效, 仅旧总量门; "
              f"补词表后自动启用 (工具 tools/ammo_tier_audit.py)")
    print(f"║ 渠道贡献榜 (仅有效弹药):")
    top = max(s["by_engine"].values()) if s["by_engine"] else 1
    for eng, ch in sorted(s["by_engine"].items(), key=lambda x: -x[1])[:8]:
        print(f"║   {eng[:24]:<24} {ch:>12,}  {'▇' * max(1, int(20 * ch / top))}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="弹药池 (千万字弹药工程 F-2)")
    ap.add_argument("cmd", choices=["init", "ingest", "judge", "rebuild",
                                    "stocktake", "coverage", "status",
                                    "snippet-audit"])
    ap.add_argument("cid", nargs="?", default="",
                    help="campaign_id (如 EPC100-2026Q4; snippet-audit 可缺省=全池)")
    ap.add_argument("--kw", default="", help="课题关键词 (init 配置判断判据)")
    ap.add_argument("--limit", type=int, default=500, help="judge 批量上限")
    ap.add_argument("--tree", default="", help="挂树 EEI id (如 Q1-E2)")
    ap.add_argument("--stance", default="support",
                    choices=["support", "against", "contradict"],
                    help="对竞争假设的立场 (ACH 原料)")
    ap.add_argument("--file", default="")
    ap.add_argument("--engine", default="own:manual")
    ap.add_argument("--band", default="", choices=[""] + list(BUDGET_BANDS),
                    help="预算分档 (S2-2: outline_wide/section_narrow/gap)")
    ap.add_argument("--url", default="")
    ap.add_argument("--cred", default="unknown",
                    choices=["official", "media", "research", "stock", "unknown"])
    ap.add_argument("--dirs", action="append", default=[])
    args = ap.parse_args()
    try:
        if args.cmd == "init":
            d = _camp_dir(args.cid)
            s = _load_state(d)
            if args.kw:
                s = {**s, "kws": parse_kws(args.kw)}
            _save_state(d, s)
            print(f"[pool] 战役池就绪: {d} (课题关键词 {len(s['kws'])} 个)")
        elif args.cmd == "ingest":
            if not args.file:
                print("--file 必填", file=sys.stderr)
                return 2
            return ingest(args.cid, args.file, args.engine, args.url,
                          args.cred, args.tree, args.stance, args.band)
        elif args.cmd == "judge":
            return judge(args.cid, args.limit)
        elif args.cmd == "rebuild":
            return rebuild(args.cid)
        elif args.cmd == "coverage":
            return coverage(args.cid)
        elif args.cmd == "stocktake":
            if not args.dirs:
                print("--dirs 必填 (可多次)", file=sys.stderr)
                return 2
            return stocktake(args.cid, args.dirs, args.kw)
        elif args.cmd == "snippet-audit":
            rep = snippet_audit(args.cid)
            total_snip = 0
            for camp, r in sorted(rep.items()):
                total_snip += r["snippet_rows"]
                print(f"[pool] {camp}: {r['rows']} 行, snippet 形 "
                      f"{r['snippet_rows']} {r['rules'] or ''}")
            print(f"[pool] snippet-audit 合计 snippet-only 入池记录 "
                  f"{total_snip} (验收判据 =0)")
            return 0 if total_snip == 0 else 1
        return status(args.cid)
    except (ValueError, OSError, json.JSONDecodeError) as e:
        print(f"[pool] 错误: {e}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
