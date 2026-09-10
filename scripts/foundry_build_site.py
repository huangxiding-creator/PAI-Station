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

# 笔记页：知识环真实产出（存在才展示——不假完成）
_WORK_SOURCES = (
    ("技能卡库", "混沌学园技能卡总览（13 张）",
     "逆向 Sign V3 提取 15 万字文稿 → deep 蒸馏 → 五层安全扫描全过",
     os.path.join("data", "hundun", "技能卡总览_混沌学园13张.md")),
    ("学习笔记", "混沌学园三门课学习笔记",
     "公开可读的工厂学习成果（公众号发布链入口）",
     os.path.join("data", "hundun", "学习笔记_混沌学园三门课.md")),
    ("语料底座", "混沌学园语料库说明",
     "知识原料湖：章节指纹增量 / 全程溯源 / 版权三态标记",
     os.path.join("data", "hundun", "README.md")),
)


def _real_works() -> list[dict]:
    works = []
    for wtype, title, desc, rel in _WORK_SOURCES:
        path = os.path.join(ROOT, rel)
        if os.path.isfile(path):
            works.append({"type": wtype, "title": title, "desc": desc,
                          "content": open(path, encoding="utf-8").read()})
    return works

# 定价与一句话卖点（PROPOSAL_M7 §5.1 定价策略：深案高值/广案普惠/降级案明示折价）
CATALOG = {
    "epc-fde-ai": {
        "price": 498,
        "tagline": "EPC 工程总承包 × AI 转型全案——两本行业专著重构，7 章 35 节抄作业工具包。",
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
    result = build_site(PLANS_DIR, DOCS_DIR, catalog=CATALOG,
                        works=_real_works())
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
