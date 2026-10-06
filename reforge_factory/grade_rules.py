# -*- coding: utf-8 -*-
"""W1-2 权威度 A/B/C 规则引擎 — 断言链引擎证据合同件 (1006 用户批 ②).

METHODOLOGY.md §二 S5 GRADE 分级 (A官方一手/B权威二手/C未验证) 的真值化:
credibility 粗三类 (official/media/research) 不动, 本件以 **sidecar** 方式
给每行 manifest 落 A/B/C 精细等级 —— 只增不删, 原账零改动 (判定源纪律).

判级次序 (先具体后兜底, 每行必落值 → 覆盖率恒 100%):
  1. 域名规则表: url_norm 为真实域名时, 政务/司法/交易所/部委 → A,
     .edu.cn → B (域名证据强于渠道默认);
  2. 渠道规则表: 按采集渠道落默认等级 (官网深挖=A / CNKI·学术=B /
     NB问答·军团·ima·秘塔·微信 = C 合成或聚合未溯源);
  3. 未知渠道兜底: C + rule=default-unknown (保守地板, 绝不虚标 A).

用法:
  python grade_rules.py <cid> [--pool-root E:\\AI-Station\\ammo_pool]
  → sidecar: <pool_root>/<cid>/grade_map.jsonl + 控制台 A/B/C 分布
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")

# ---------- 域名规则表 (真实 URL 才吃; 占位 URL 如 https://w/ 不命中) ----------
# A = 一手官方: 政府/司法/采购/交易所公告/部委/央企集团门户
DOMAIN_A = (
    "gov.cn",            # 政务域 (含 court.gov.cn / ccgp / sasac / stats / 部委)
    "ccgp.gov.cn",
    "cninfo.com.cn",     # 巨潮资讯: 年报/公告指定披露
    "sse.com.cn",        # 上交所
    "szse.cn",           # 深交所
    "nea.gov.cn",        # 能源局
    "mohurd.gov.cn",     # 住建部
    "sasac.gov.cn",      # 国资委
)
DOMAIN_B = (
    "edu.cn",            # 高校 (权威二手)
    "ssrn.com",
    "cnki.net",          # 知网文献库本体
)

# ---------- 渠道规则表 (盘上 12 渠道实值, EPC50 引擎分布实证) ----------
# A: 企业官网深挖/官网资料/用户自备一手原料
# B: 学术与权威文献 (CNKI/论文学术/飞书沉淀语料——多为机构文献转载)
# C: 合成或聚合且未逐条溯源 (NB 问答/军团报告/ima 公开库/秘塔/微信自媒体)
ENGINE_GRADES: dict[str, tuple[str, str]] = {
    "52_官网深挖":  ("A", "engine-official-site"),
    "50_官网资料":  ("A", "engine-official-site"),
    "own:manual":  ("A", "engine-own-primary"),
    "CNKI":        ("B", "engine-academic"),
    "60_论文学术":  ("B", "engine-academic"),
    "50_飞书语料":  ("B", "engine-curated-corpus"),
    "99_v2问答":   ("C", "engine-synthetic-qa"),      # NB 合成, 溯源解析前保守 C
    "35_Manus军团": ("C", "engine-agent-report"),
    "51_ima知识库": ("C", "engine-public-aggregate"),
    "30_秘塔AI":   ("C", "engine-synthetic-search"),
    "31_秘塔视频":  ("C", "engine-synthetic-search"),
    "20_微信文章":  ("C", "engine-wechat-selfmedia"),
}

DEFAULT_GRADE = ("C", "default-unknown")   # 保守地板: 未知渠道绝不虚标

# 名空间前缀路由 (EPC49 系池词汇: wenshu/official:/paper:/kb:/stock:/web:)
PREFIX_GRADES: tuple[tuple[str, tuple[str, str]], ...] = (
    ("official:",  ("A", "engine-official-site")),   # 官网/兄弟单位官网
    ("paper:",     ("B", "engine-academic")),        # 学术文献腿
    ("standard:",  ("A", "engine-standard-text")),   # 国标/行标原文
    ("kb:",        ("C", "engine-public-aggregate")),
    ("stock:",     ("C", "engine-stock-corpus")),    # 存量盘点, 溯源不透明
    ("web:",       ("C", "engine-web-mixed")),
)
# 精确名特判 (不落前缀的独立引擎名)
EXACT_GRADES: dict[str, tuple[str, str]] = {
    "wenshu":      ("A", "engine-court-doc"),        # 裁判文书 = 一手司法
    "feishu_zhiku": ("B", "engine-curated-corpus"),  # 与 50_飞书语料 同级
}


_URL_RE = re.compile(r"^[a-z][a-z0-9+.\-]*://([^/?#]+)")


def host_of(url: str) -> str:
    """url_norm → 注册域小写 (纯手解析, 零 urllib — 零网络根模块纪律).

    占位/坏 URL (如 https://w/ 无点域名) 返回空串, 不吃域名规则。
    """
    m = _URL_RE.match((url or "").strip().lower())
    if not m:
        return ""
    host = m.group(1)
    if "@" in host:
        host = host.rsplit("@", 1)[-1]        # 剥 userinfo
    host = host.split(":", 1)[0]              # 剥端口
    if host.startswith("www."):
        host = host[4:]
    if "." not in host:
        return ""                             # 占位域 (w/localhost) 不算真实域
    return host


def grade_by_domain(host: str) -> tuple[str, str] | None:
    """域名规则: 精确尾匹配 DOMAIN_A/DOMAIN_B; 未命中返回 None."""
    if not host or "." not in host:
        return None
    if any(host == d or host.endswith("." + d) for d in DOMAIN_A):
        return ("A", "domain-official")
    if any(host == d or host.endswith("." + d) for d in DOMAIN_B):
        return ("B", "domain-academic")
    return None


def grade_row(row: dict) -> dict:
    """单行判级 (纯函数): 先域名后渠道再兜底, 每行必落 A/B/C.

    只读入参字段 (engine/url_norm/credibility/dedup_key), 返回新对象,
    不改原行 (不可变纪律)。
    """
    host = host_of(str(row.get("url_norm") or ""))
    grade, rule = None, None
    d = grade_by_domain(host)
    if d:
        grade, rule = d
    else:
        eng = str(row.get("engine") or "")
        grade, rule = _engine_grade(eng)
    return {"dedup_key": row.get("dedup_key", ""),
            "engine": row.get("engine", ""),
            "host": host,
            "credibility": row.get("credibility", ""),
            "grade": grade,
            "rule": rule}


def _engine_grade(eng: str) -> tuple[str, str]:
    """渠道判级: 精确表 → 名空间前缀 → 保守地板."""
    if eng in ENGINE_GRADES:
        return ENGINE_GRADES[eng]
    if eng in EXACT_GRADES:
        return EXACT_GRADES[eng]
    for prefix, gr_ in PREFIX_GRADES:
        if eng.startswith(prefix):
            return gr_
    return DEFAULT_GRADE
    return {"dedup_key": row.get("dedup_key", ""),
            "engine": row.get("engine", ""),
            "host": host,
            "credibility": row.get("credibility", ""),
            "grade": grade,
            "rule": rule}


def grade_rows(rows: list[dict]) -> list[dict]:
    """全量判级 (纯函数); 输入行序 = 输出行序, 覆盖率恒 100%."""
    return [grade_row(r) for r in rows]


def summarize(graded: list[dict]) -> dict:
    """A/B/C 分布 + 规则命中分布 + 域名覆盖率 (聚合新对象)."""
    dist: dict[str, int] = {}
    rules: dict[str, int] = {}
    n_host = 0
    for g in graded:
        dist[g["grade"]] = dist.get(g["grade"], 0) + 1
        rules[g["rule"]] = rules.get(g["rule"], 0) + 1
        if g["host"]:
            n_host += 1
    n = len(graded)
    return {"rows": n,
            "grade_dist": dist,
            "grade_pct": {k: round(v * 100.0 / n, 2)
                          for k, v in dist.items()} if n else {},
            "rule_dist": dict(sorted(rules.items(),
                                     key=lambda x: -x[1])),
            "url_real_pct": round(n_host * 100.0 / n, 2) if n else 0.0}


def run(cid: str, pool_root: Path = POOL_ROOT) -> dict:
    """读 manifest → 判级 → sidecar 落盘 (grade_map.jsonl, 只增不删原账)."""
    mpath = pool_root / cid / "manifest.jsonl"
    rows = [json.loads(x) for x in mpath.read_text(encoding="utf-8")
            .splitlines() if x.strip()]
    graded = grade_rows(rows)
    summary = summarize(graded)
    out = {"cid": cid, "generated": time.strftime("%Y-%m-%d %H:%M"),
           "engine_version": "grade-rules-v1 (W1-2 断言链引擎)",
           "summary": summary}
    sidecar = pool_root / cid / "grade_map.jsonl"
    with sidecar.open("w", encoding="utf-8") as f:
        for g in graded:
            f.write(json.dumps(g, ensure_ascii=False) + "\n")
    (pool_root / cid / "grade_summary.json").write_text(
        json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
    return out


def _main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description="弹药权威度 A/B/C sidecar 判级")
    ap.add_argument("cid")
    ap.add_argument("--pool-root", default=str(POOL_ROOT))
    ns = ap.parse_args(argv)
    out = run(ns.cid, Path(ns.pool_root))
    s = out["summary"]
    print(f"[grade] {ns.cid}: {s['rows']} 行 → A/B/C = {s['grade_dist']}")
    print(f"[grade] 占比 {s['grade_pct']} | 真实URL占比 {s['url_real_pct']}%")
    print(f"[grade] 规则命中 Top5: {dict(list(s['rule_dist'].items())[:5])}")
    print(f"[grade] sidecar: {Path(ns.pool_root) / ns.cid / 'grade_map.jsonl'}")
    return 0


if __name__ == "__main__":
    sys.exit(_main(sys.argv[1:]))
