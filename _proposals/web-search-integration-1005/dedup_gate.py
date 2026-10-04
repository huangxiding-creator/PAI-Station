# -*- coding: utf-8 -*-
"""网页搜索扫荡去重门 — 域名级 + github owner/repo 双键 (Arc K dedup_gate 配方移植).

门序: URL_FIXES → malformed → 批内重复 → 已在册(本机检索栈) → 低质/无关 → 候选.
输出: dedup_result.json {candidates, existing, excluded:[{...reason}], stats}
"""
import json
import sys
from pathlib import Path
from urllib.parse import urlparse

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = Path(__file__).parent

MULTI_TENANT = {"github.com", "gitlab.com", "codeberg.org", "gitee.com"}

# org 更名/搬家 别名 → 规范址 (双键之外的同项目双址, 判重前归一)
ALIASES = {
    "github.com/mendableai/firecrawl": "github.com/firecrawl/firecrawl",
    "github.com/itzcrazykns/perplexica": "github.com/itzcrazykns/vane",
}


def canon_url(url: str) -> str:
    """别名归一: org 更名双址 → 规范址 (判重/生成共用)。"""
    u = url if "//" in url else "https://" + url
    h = (urlparse(u).hostname or "").lower()
    if h.startswith("www."):
        h = h[4:]
    path = urlparse(u).path.strip("/").lower()
    hk = f"{h}/{path}" if path else h
    if hk in ALIASES:
        return "https://" + ALIASES[hk]
    return url

# 本机在册检索资产 (existing: 上游项目/域名 → 本机资产名)
EXISTING_STACK = {
    "github.com/openclaw/skills": "zh-search-pro skill 上游库",
    "github.com/fish2018/pansou": "第22渠道 pansou (本机 Go 服务)",
    "metaso.cn": "metaso 渠道 (积分制付费, 批量禁用令)",
    "searx.github.io": "SearXNG 官方文档站 (项目本体在 searxng/searxng repo, 不算重复)",
}


def norm_host(url: str) -> str:
    u = url if "//" in url else "https://" + url
    h = (urlparse(u).hostname or "").lower()
    return h[4:] if h.startswith("www.") else h


def norm_key(url: str):
    """双键: 多租户代码托管域 → (host, owner/repo); 其余 → (host, '')."""
    host = norm_host(url)
    u = url if "//" in url else "https://" + url
    p = urlparse(u).path.strip("/").lower()
    if host in MULTI_TENANT:
        parts = [s for s in p.split("/") if s]
        if len(parts) >= 2:
            return (host, "/".join(parts[:2]))
    return (host, "")


def host_path(url: str) -> str:
    u = url if "//" in url else "https://" + url
    return (urlparse(u).hostname or "").lower() + urlparse(u).path.rstrip("/").lower()


def load_raw():
    doc = json.loads((HERE / "sweep_raw.json").read_text(encoding="utf-8"))
    rows = []
    for f in doc.get("raw", []):
        rows.append(f)
    # 审计增补建议也纳入候选池 (mark 来源)
    for e in doc.get("audit", {}).get("extra_suggestions", []):
        rows.append({"name": e["name"], "url": e["url"], "type": "repo",
                     "lang": "?", "note": "[audit增补] " + e.get("note", ""),
                     "quality": "mid", "practices": [], "angle": "audit-extra"})
    return doc, rows


def main():
    doc, rows = load_raw()
    candidates, existing, excluded = [], [], []
    seen = {}                      # norm_key -> 第一条
    seen_host = {}                 # host -> 第一条 (非多租户域的域名级判重)
    stats = {"raw": len(rows), "batch_dup": 0, "already_in_stack": 0,
             "low_quality": 0, "malformed": 0}

    for f in rows:
        url = canon_url((f.get("url") or "").strip().rstrip("/"))
        name = (f.get("name") or "").strip()
        if not url or not name or "." not in url:
            excluded.append({**f, "gate": "malformed"})
            stats["malformed"] += 1
            continue
        if not url.startswith(("http://", "https://")):
            url = "https://" + url
            f["url"] = url

        # 已在册 (本机栈上游) — 记 existing 不剔除 (注册表内标 existing 态)
        hp = host_path(url)
        hit = next((v for k, v in EXISTING_STACK.items() if hp.startswith(k)), None)
        if hit:
            existing.append({**f, "existing_of": hit})
            continue

        # 批内双键去重
        k = norm_key(url)
        if k in seen:
            first = seen[k]
            # 保留质量高/practices 多的那条, 另一条留痕
            def score(x):
                return (x.get("quality") == "high", len(x.get("practices") or []))
            if score(f) > score(first):
                excluded.append({**first, "gate": "batch_dup",
                                 "dup_of": f["url"]})
                seen[k] = f
            else:
                excluded.append({**f, "gate": "batch_dup", "dup_of": first["url"]})
            stats["batch_dup"] += 1
            continue
        # 非多租户域再按 host 判一次 (同域不同路径的项目页/官网视为同渠道面)
        h = norm_host(url)
        if h not in MULTI_TENANT and h in seen_host:
            excluded.append({**f, "gate": "batch_dup",
                             "dup_of": seen_host[h]["url"]})
            stats["batch_dup"] += 1
            continue

        # 低评不静默剔 → watchlist 留痕 (扫荡 agent 评级有噪声, 如 Whoogle
        # 被标 low; star/活跃度在打通轮由 github api 客观复核)
        if f.get("quality") == "low":
            f["watchlist"] = "low@scan → star实证复核"
            stats["low_quality"] += 1

        seen[k] = f
        seen_host[h] = f
        candidates.append(f)

    # 审计 suspect → 只自动杀「死亡/名实不符」类; 「重复」类 batch_dup 已处理
    # (suspect 上报的重复 URL 与幸存副本同址, 再杀=双重击杀);
    # 多租户域 (github/gitlab/…) 只用 owner/repo 双键, 禁用裸 host 键 —
    # 否则一个嫌疑毒杀全域 (1005 实锤: Openverse 的 reason 复读到全 github 候选)
    import re as _re
    DUP_OR_ALIVE = _re.compile(
        r"重复|dup|非死链|实证活跃|合并清单|同一仓|双列|各独立成条", _re.I)
    DISQUALIFY = _re.compile(
        r"(?<!非)死链|拼写错误|typo|repo.?not.?found|已归档|长期停更|"
        r"超过两年无提交|与网页搜索无关", _re.I)
    suspect_keys = {}
    for s in doc.get("audit", {}).get("suspect", []):
        reason = s.get("reason", "")
        if DUP_OR_ALIVE.search(reason):
            continue
        if DISQUALIFY.search(reason):
            suspect_keys[norm_key(s.get("url", ""))] = reason
            if norm_host(s.get("url", "")) not in MULTI_TENANT:
                suspect_keys[norm_host(s.get("url", ""))] = reason
    kept = []
    for c in candidates:
        k1 = norm_key(c["url"])
        if k1 in suspect_keys:
            excluded.append({**c, "gate": "audit_suspect",
                             "reason": suspect_keys[k1]})
            continue
        kept.append(c)

    out = {"stats": {**stats, "candidates": len(kept), "existing": len(existing),
                     "excluded": len(excluded),
                     "suspect": len(doc.get("audit", {}).get("suspect", []))},
           "candidates": kept,
           "watchlist": [c for c in kept if c.get("watchlist")],
           "existing": existing, "excluded": excluded}
    (HERE / "dedup_result.json").write_text(
        json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
    print(json.dumps(out["stats"], ensure_ascii=False))
    print(f"角度分布: ", end="")
    from collections import Counter
    print(dict(Counter(c["angle"] for c in kept)))


if __name__ == "__main__":
    main()
