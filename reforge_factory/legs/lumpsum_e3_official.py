# -*- coding: utf-8 -*-
"""lumpsum_e3_official — E3 权威位官方域全文真采件 (1102 零豁免铁令).

用户令: 所有研究报告调研时没有任何豁免 → E3(官方统计/公报原文)不豁免,
必须真采官方域全文. 本件: 每缺口E3 → 官方域定向词表(住建部/统计局/商务部/
人社部/最高法) → zh_search_pro 限site检索 → jina reader 拉官方页全文 →
入池(engine=website:official) → 语义/直挂 tree_node.
用法: py -X utf8 lumpsum_e3_official.py [--dry]
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
import time
import urllib.request
from pathlib import Path
from urllib.parse import quote_plus, urlsplit

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
POOL = REPO / "ammo_pool" / "EPC-LUMPSUM"
MANIFEST = POOL / "manifest.jsonl"
HD = POOL / "e3_official"
SEARCH = REPO / ".claude" / "skills" / "zh-search-pro" / "scripts" / "search.py"

#: E3 缺口 → 官方源定向词 (域名 hint + 检索词). 全部为公开官方统计/公报/文件真实存在面.
E3_PLAN = [
    ("Q1-E3",  "mohurd.gov.cn", "工程总承包 管理办法 住建部 通知"),
    ("Q2-E3",  "mohurd.gov.cn", "建筑业 十四五 发展规划 住建部"),
    ("Q3-E3",  "mohurd.gov.cn", "工程总承包 资质 招投标 政策 住建部"),
    ("Q4-E3",  "mohurd.gov.cn", "建筑业发展统计分析 总产值"),
    ("Q5-E3",  "mohurd.gov.cn", "工程造价 指标指数 发布 通知"),
    ("Q6-E3",  "mohurd.gov.cn", "建筑业 增长 建筑业发展统计分析 2024"),
    ("Q7-E3",  "mohurd.gov.cn", "建筑业企业 排名 特级 资质 名单"),
    ("Q9-E3",  "mohurd.gov.cn", "工程总承包 试点 企业 名单"),
    ("Q11-E3", "mohurd.gov.cn", "工程量清单计价标准 GB/T 50500 发布"),
    ("Q12-E3", "mohurd.gov.cn", "工程质量事故 通报 处罚"),
    ("Q13-E3", "mohurd.gov.cn", "工程质量安全 事故 通报 2024"),
    ("Q14-E3", "court.gov.cn",  "建设工程施工合同 司法解释 工程款"),
    ("Q15-E3", "mohurd.gov.cn", "工程价款结算 管理办法 财政部"),
    ("Q16-E3", "mohurd.gov.cn", "建筑业 利润 产值利润率 统计分析"),
    ("Q17-E3", "mohurd.gov.cn", "建筑业 应收账款 清欠 通知"),
    ("Q18-E3", "mohurd.gov.cn", "智能建造 新技术 应用 试点"),
    ("Q19-E3", "mohurd.gov.cn", "建筑产业数字化 发展 通知"),
    ("Q20-E3", "openstd.samr.gov.cn", "建设工程造价鉴定规范 GB/T 51262"),
    ("Q21-E3", "mohrss.gov.cn", "造价工程师 职业资格 制度规定"),
    ("Q22-E3", "court.gov.cn",  "建设工程 司法解释 答记者问"),
    ("Q23-E3", "mofcom.gov.cn", "对外承包工程 统计 商务部"),
    ("Q24-E3", "mofcom.gov.cn", "对外承包工程 完成营业额 统计"),
    ("Q25-E3", "mohurd.gov.cn", "建筑工程 发包承包 管理 办法"),
    ("Q26-E3", "mohurd.gov.cn", "全国建筑市场监管公共服务平台"),
]


def sh(cmd, timeout=150):
    r = subprocess.run(cmd, capture_output=True, text=True,
                       encoding="utf-8", errors="replace", timeout=timeout)
    return (r.stdout or "") + (r.stderr or "")


def search_urls(kw: str, domain: str) -> list[str]:
    out = sh(["py", "-X", "utf8", str(SEARCH), "--q", f"site:{domain} {kw}"], 120)
    urls = [u for u in re.findall(r"https?://[^\s)】\]\"]+", out)
             if domain in u]
    # 去重保序
    seen, res = set(), []
    for u in urls:
        if u not in seen:
            seen.add(u)
            res.append(u)
    return res[:2]


def fetch_full(url: str) -> str:
    try:
        req = urllib.request.Request(
            "https://r.jina.ai/" + url,
            headers={"User-Agent": "Mozilla/5.0"}, method="GET")
        with urllib.request.urlopen(req, timeout=45) as r:
            return r.read(200_000).decode("utf-8", "replace")
    except Exception:  # noqa: BLE001
        return ""


def tag(path: Path, eei: str):
    rows = [json.loads(x) for x in MANIFEST.read_text(encoding="utf-8").splitlines() if x.strip()]
    hit = False
    for r in rows:
        if str(path) == str(r.get("source_path", "")) and not r.get("tree_node"):
            r["tree_node"] = eei
            hit = True
    if hit:
        MANIFEST.write_text(
            "\n".join(json.dumps(r, ensure_ascii=False) for r in rows) + "\n",
            encoding="utf-8")
    return hit


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    HD.mkdir(exist_ok=True)
    n_ok = 0
    for eei, domain, kw in E3_PLAN:
        urls = search_urls(kw, domain)
        got = 0
        for u in urls:
            full = fetch_full(u)
            if len(full) < 400:            # 官方全文门槛
                continue
            f = HD / f"{eei}_{urlsplit(u).path.strip('/').replace('/', '_')[-50:] or 'page'}.md"
            f.write_text(
                f"# 官方原文: {kw}\n\n来源: {u} (官方域全文, jina reader)\n\n{full}\n",
                encoding="utf-8")
            if ns.dry:
                got += 1
                n_ok += 1
                continue
            r = sh(["py", "-X", "utf8", str(REPO / "reforge_factory" / "ammo_pool.py"),
                    "ingest", "EPC-LUMPSUM", "--file", str(f),
                    "--engine", "website:official"], 120)
            if "[pool]" in r:
                tag(f, eei)
                got += 1
                n_ok += 1
        print(f"  {eei} [{domain}] +{got} ({urls and '有URL' or '检索空'})", flush=True)
        time.sleep(2)
    print(f"[e3-official] 官方域全文入池: {n_ok} 件 ({'DRY' if ns.dry else '已写'})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
