# -*- coding: utf-8 -*-
"""harvest_gap — 饱和缺口定向收割腿 (E2 反证/E3 权威空槽精准补, 1016 令).

用法: py reforge_factory/harvest_gap.py --campaign EPC-BID26 [--dry]
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng")
sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\EPC100")
import ammo_pool                                        # noqa: E402
from collectors.anysearch.client import AnySearchClient   # noqa: E402

REPO = Path(__file__).resolve().parents[1]

# (查询, EEI, cred) — 11 空槽逐槽定投
PLAN: list[tuple[str, str, str]] = [
    # E3 权威口径槽 (官方统计/公报/年报)
    ("招投标 行政处罚 通报 住建部门", "Q13-E3", "official"),
    ("最高人民法院 招标投标 纠纷 典型案例", "Q14-E3", "official"),
    ("中国建筑 上市公司 年报 营业收入", "Q16-E3", "official"),
    ("建筑业 统计公报 2025 住建部", "Q8-E3", "official"),
    ("头部企业 应收账款 建筑行业 风险", "Q17-E3", "research"),
    # E2 反证槽 (风险/反例/失败)
    ("EPC 工程总承包 亏损 失败 案例", "Q12-E2", "media"),
    ("央企 建筑企业 战略 失误 裁员", "Q9-E2", "media"),
    ("EPC 合同 计价 争议 固定总价", "Q11-E2", "research"),
    ("中资企业 海外项目 亏损 撤出", "Q24-E2", "media"),
    ("电子招投标 平台 故障 事故", "Q19-E2", "media"),
    ("招标代理机构 违规 处罚", "Q25-E2", "media"),
    # 第二波齐射 (1016: 差4槽, ev=1 的5槽各补1 + 零槽缓冲)
    ("建筑央企 战略 转型 风险 挑战", "Q9-E2", "media"),
    ("国资委 中央企业 建筑 转型 部署", "Q9-E3", "official"),
    ("工程项目 超概算 审计 通报", "Q12-E2", "official"),
    ("建筑企业 毛利率 下滑 原因", "Q16-E2", "research"),
    ("海外工程 亏损 教训 风险 防范", "Q24-E2", "media"),
    ("招标投标法 修订 争议 问题", "Q2-E2", "research"),
    ("招标投标 统计 数据 口径 争议", "Q5-E2", "research"),
    ("工程合同 纠纷 败诉 原因 判决", "Q14-E2", "research"),
    ("建筑企业 应收账款 坏账 诉讼", "Q17-E2", "research"),
    ("造价工程师 资格 取消 争议", "Q21-E2", "media"),
]
MIN_CHARS = 400
PER_QUERY = 2


def run(cid: str, dry: bool = False) -> int:
    out = REPO / "data" / "harvest" / "gap" / cid
    out.mkdir(parents=True, exist_ok=True)
    cli = AnySearchClient()
    n_ok = n_skip = 0
    for q, eei, cred in PLAN:
        try:
            resp = cli.search(q, max_results=PER_QUERY + 2) or {}
            res = ((resp.get("data") or {}).get("results")) or []
        except Exception as e:
            print(f"[gap] search 失败 '{q[:24]}': {str(e)[:60]}")
            continue
        got = 0
        for it in res:
            if got >= PER_QUERY:
                break
            title = str(it.get("title") or "")
            url = str(it.get("url") or "")
            content = ""
            try:
                ex = cli.extract(url) or {}
                content = str(((ex.get("data") or {}).get("content"))
                              or "")
            except Exception:
                pass
            if len(content) < MIN_CHARS:
                content = str(it.get("content") or it.get("snippet") or "")
            if len(content) < MIN_CHARS or not title or not url:
                n_skip += 1
                continue
            fp = out / (re.sub(r"[^\w一-鿿-]+", "_", title)[:50] + ".md")
            fp.write_text(f"# {title}\n\n> 定向补采 ({url})\n\n{content}",
                          encoding="utf-8")
            got += 1
            n_ok += 1
            if not dry:
                ammo_pool.ingest(cid, str(fp), engine="anysearch:gap",
                                 url=url, cred=cred, tree=eei,
                                 stance="against" if eei.endswith("-E2")
                                 else "support")
        print(f"[gap] '{q[:26]}' → {got} → {eei}")
    print(f"[gap] {'DRY' if dry else 'APPLY'}: {n_ok} 件 | 跳 {n_skip}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="饱和缺口定向腿")
    ap.add_argument("--campaign", default="EPC-BID26")
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    return run(ns.campaign, ns.dry)


if __name__ == "__main__":
    sys.exit(main())
