# -*- coding: utf-8 -*-
"""Arc K 去重+质量门 — 1004 用户令: 去掉重复, 保留高质量, 完全不相关不接入.

输入: sweep findings (角度 agent 结构化输出, 含失败角度补跑后合并)
输出: candidates.json (可纳入新渠道) + exclusions.json (剔除留痕, 每条带理由)

规则 (IDEA_SEED.md DoD):
  1. 域名级去重: 批内互斥 + 与在册 111 站 (sites.py) 互斥
  2. 质量门: quality high/mid 保留; low 默认剔除 (理由=low_quality)
  3. 相关性: 必须是图书内容/检索/目录面; 纯工具链(下载器/阅读器)按
     type=service 且无内容面 → 剔除 (unrelated)
  4. 高风险规避 (9-23 令): 影子图书馆/盗版聚合 (Anna's/LibGen/Z-Lib 等)
     → piracy_suspect 登记 (禁触不发一包), 不算打通对象
"""
import json
import re
import sys
from pathlib import Path
from urllib.parse import urlparse

sys.path.insert(0, str(Path(__file__).resolve().parents[3] /
                       "ResearchFactory-Eng" / "EPC100" / "collectors"))
from ebook_library import sites as S  # noqa: E402

ROOT = Path(__file__).resolve().parent

# 影子图书馆/盗版聚合域名 → piracy_suspect 登记 (登记不访问)
PIRACY_HOSTS = {
    "annas-archive.org", "annas-archive.se", "libgen.is", "libgen.gs",
    "libgen.li", "z-library.rs", "z-library.sk", "z-lib.org", "1lib.net",
    "bookzz.org", "oceanofpdf.com", "flibusta.is", "pdfdrive.com",
    "sobooks.net", "zxcsme.com",          # 已封站的换域马甲 (审计实锤)
    "harborlibrary.com",                   # HarborLibrary = Z-Library 备份集
}
# 已封站的同站变体 (书格新旧域/好读别名等: 归一后再比对注册表)
HOST_VARIANTS = {
    "new.shuge.org": "shuge.org",
    "haodoo.net": "haodoo.org",
}
# 审计实锤非内容渠道 (纯工具/客户端/自建程序/TG/个人页/单书/图片源) → 剔除
NON_CHANNEL_PATHS = {
    "kovidgoyal/calibre", "koodo-reader/koodo-reader", "readest/readest",
    "janeczku/calibre-web", "talebook/talebook", "koreader/koreader",
    "hectorqin/reader", "mgz0227/legado-harmony", "kequans/legado-for-mac",
    "z1131392774/legado-source-generator", "zu1k/book-searcher",
    "gedoor/legado", "dujltqzv/some-many-books",
    "d2l-ai/d2l-zh",            # 单书 repo (开源教材一本书, 非渠道)
    "freeok/so-novel",          # 笔趣阁系下载器 (工具+灰源)
    "downeyrem/pixivsource",    # Pixiv 图片源 (非电子书)
}
NON_CHANNEL_HOSTS = {"t.me", "flowus.cn", "78books.com"}
# org/repo 形态的影子图书馆 (host=github.com 拦不住, 按 path 截)
PIRACY_PATHS = {"HarborLibrary"}
# 拼写修正 (审计: gh api 404 实锤)
URL_FIXES = {"wx-chevalian": "wx-chevalier"}


def norm_host(url: str) -> str:
    try:
        h = urlparse(url if "//" in url else "https://" + url).hostname
        h = (h or "").lower().strip(".")
        if h.startswith("www."):        # www 前缀统一剥 (zxcsme 漏网根因)
            h = h[4:]
        return HOST_VARIANTS.get(h, h)
    except Exception:
        return ""


MULTI_TENANT = {"github.com", "gitlab.com", "codeberg.org", "gitee.com"}


def norm_key(url: str):
    """去重键: 多租户代码托管域按 owner/repo, 其余按域名 (裸域名级)。"""
    host = norm_host(url)
    try:
        p = urlparse(url if "//" in url else "https://" + url).path.strip("/")
    except Exception:
        return (host, "")
    if host in MULTI_TENANT:
        parts = [s for s in p.split("/") if s]
        if len(parts) >= 2:
            return (host, "/".join(parts[:2]).lower())
    return (host, "")


def main(inp: str) -> None:
    raw = json.loads(Path(inp).read_text(encoding="utf-8"))
    reg_keys = {norm_key(s["url"]) for s in S.SITES}
    seen: dict = {}          # norm_key -> first entry (批内去重)
    candidates, excluded, piracy = [], [], []

    for f in raw:
        url = f.get("url", "")
        for bad, good in URL_FIXES.items():
            if bad in url:
                url = f["url"] = url.replace(bad, good)
        host = norm_host(url)
        key = norm_key(url)
        name = (f.get("name") or "").strip()
        if not host or not name:
            excluded.append({**f, "reason": "malformed"})
            continue
        path = urlparse(url if "//" in url else "https://" + url).path.strip("/")
        path_l = path.lower()
        if path_l in NON_CHANNEL_PATHS or host in NON_CHANNEL_HOSTS:
            why = ("tg_or_personal_page" if host in NON_CHANNEL_HOSTS
                   else "tool_not_channel")
            excluded.append({**f, "reason": why})
            seen[key] = f
            continue
        if path_l in {p.lower() for p in PIRACY_PATHS}:
            piracy.append({**f, "why": "影子图书馆镜像集 (高风险规避令: 登记禁触)"})
            seen[key] = f
            continue
        q = (f.get("quality") or "low").lower()
        typ = (f.get("type") or "site").lower()
        if key in seen:
            excluded.append({**f, "reason": f"batch_dup_of:{seen[key]['name']}"})
            continue
        if key in reg_keys:
            excluded.append({**f, "reason": "already_in_registry"})
            continue
        if host in PIRACY_HOSTS:
            piracy.append({**f, "why": "影子图书馆/盗版聚合 (高风险规避令: 登记禁触)"})
            seen[key] = f
            continue
        if q == "low":
            excluded.append({**f, "reason": "low_quality"})
            seen[key] = f
            continue
        if typ not in ("site", "repo", "org", "list"):
            excluded.append({**f, "reason": f"type_{typ}_not_channel"})
            seen[key] = f
            continue
        seen[key] = f
        candidates.append(f)

    out = {
        "ts": "2026-10-05T00:00:00",
        "stats": {
            "raw": len(raw),
            "candidates": len(candidates),
            "excluded": len(excluded),
            "piracy_suspect_new": len(piracy),
            "excl_by_reason": _count(excluded, "reason"),
        },
        "candidates": candidates,
        "piracy_suspect": piracy,
        "excluded": excluded,
    }
    dst = ROOT / "dedup_result.json"
    dst.write_text(json.dumps(out, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    print(json.dumps(out["stats"], ensure_ascii=False, indent=1))
    print("saved:", dst)


def _count(items, key):
    c: dict = {}
    for it in items:
        v = str(it.get(key, "?")).split(":")[0]
        c[v] = c.get(v, 0) + 1
    return c


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else str(ROOT / "sweep_raw.json"))
