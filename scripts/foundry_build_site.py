"""M7.4 金标准：真实数据建站（data/foundry/plans → docs/ GitHub Pages）。

只发布已完工方案（有 plan.json 才入站，锻造中不误发——不假完成）。
附带：每份方案的宣传文（promo.md）复制到 docs/promo/ 供公众号发布。
"""
import os
import shutil
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation.foundry.site import build_site

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PLANS_DIR = os.path.join(ROOT, "data", "foundry", "plans")
DOCS_DIR = os.path.join(ROOT, "docs")

# 定价与一句话卖点（PROPOSAL_M7 §5.1 定价策略：深案高值/广案普惠/降级案明示折价）
CATALOG = {
    "epc-fde-ai": {
        "price": 498,
        "tagline": "EPC 工程总承包 × AI 转型全案——两本行业专著重构，7 章 31 节抄作业工具包。",
    },
    "zengming-smart-business-fde": {
        "price": 298,
        "tagline": "曾鸣智能商业方法论 × AI 转型——智能协同/网络效应/数据智能落地路径。",
    },
    "legacy-innovation-fde": {
        "price": 198,
        "tagline": "传统企业创新转型方法论——混沌大学课程语料重构（语料降级已明示，折价销售）。",
    },
}


def main() -> None:
    result = build_site(PLANS_DIR, DOCS_DIR, catalog=CATALOG)
    print(f"[site] 发布 {len(result['plans'])} 份方案：")
    for e in result["plans"]:
        print(f"  - {e['slug']}: 密度 {e['score']} 分 · {e['n_chapters']} 章 "
              f"{e['n_sections']} 节 · ¥{e['price']}")

    # 宣传文随站发布（公众号可直接取用）
    promo_dir = os.path.join(DOCS_DIR, "promo")
    os.makedirs(promo_dir, exist_ok=True)
    n_promo = 0
    for e in result["plans"]:
        src = os.path.join(PLANS_DIR, e["slug"], "promo.md")
        if os.path.isfile(src):
            shutil.copyfile(src, os.path.join(promo_dir, f"{e['slug']}.md"))
            n_promo += 1
    print(f"[site] 宣传文 {n_promo} 篇 → docs/promo/")
    print(f"[site] 首页：{result['index']}")


if __name__ == "__main__":
    main()
