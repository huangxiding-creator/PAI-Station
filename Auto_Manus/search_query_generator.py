# -*- coding: utf-8 -*-
"""四维搜索词生成器 — Manus 核心打法学走·第一件 (逆向第二辑 §一).

实证公式: 地域 × 行业细分 × 主题 × 时间窗, 行业矩阵逐扫 + 漏斗改写
(泛 → 官方数据 → 点名权威源). 输入研究主题, 输出可直接喂采集渠道的
查询词批次 (含漏斗三段序列).

用法 (CLI 冒烟):
    python search_query_generator.py 四川省 EPC总承包市场
"""
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

# 行业细分维度 (从四川/江苏任务实测序列提炼, 工程建设域)
INDUSTRY_DIMS = (
    "教育设施", "文化旅游设施", "现代物流设施", "电子信息产业",
    "大型医院建设", "市政基础设施", "交通枢纽", "产业园区",
    "水利水务", "能源电力",
)

# 主题维度 (市场研究域)
TOPIC_DIMS = (
    "市场规模与统计数据", "政策法规", "项目案例", "招投标动态",
    "重点企业动向", "投融资模式",
)

# 权威源漏斗 (泛 → 官方 → 点名)
FUNNEL_SOURCES = (
    None,                       # 第一段: 泛搜
    "官方数据",                  # 第二段: 收敛到官方
    "统计年鉴",                  # 第三段: 点名权威源
)

AUTHORITY_SITES = (
    "{region}省政府官网", "{region}发展和改革委员会",
    "{region}住房和城乡建设厅", "{region}统计年鉴",
    "{region}公共资源交易平台",
)

YEAR_WINDOW = f"{time.localtime().tm_year - 1}-{time.localtime().tm_year}"


def generate(region: str, subject: str, industries=INDUSTRY_DIMS,
             topics=TOPIC_DIMS, year_window=YEAR_WINDOW) -> dict:
    """生成查询词矩阵: 基础盘 + 行业矩阵 + 主题矩阵 + 权威源 + 漏斗."""
    base = []
    for t in topics:
        base.append(f"{region} {subject} {t} {year_window}")

    industry = []
    for ind in industries:
        industry.append(f"{region} {ind} {subject} 项目案例 政策")

    authority = [s.format(region=region) for s in AUTHORITY_SITES]

    funnel = [  # 漏斗三段: 对市场规模主题的定向改写链
        f"{region} {subject} 市场规模 历史数据 来源",
        f"{region} {subject} 市场规模 官方数据",
        f"{region} 统计年鉴",
    ]
    return {"base": base, "industry": industry,
            "authority": authority, "funnel": funnel,
            "total": len(base) + len(industry) + len(authority) + len(funnel)}


def main():
    region = sys.argv[1] if len(sys.argv) > 1 else "四川省"
    subject = sys.argv[2] if len(sys.argv) > 2 else "EPC总承包市场"
    r = generate(region, subject)
    print(f"=== {region} {subject} 查询词矩阵 ({r['total']} 条) ===")
    print("\n-- 基础盘 (主题×时间窗):")
    for q in r["base"][:6]:
        print(f"   {q}")
    print(f"   …共 {len(r['base'])} 条")
    print("\n-- 行业矩阵 (逐维扫):")
    for q in r["industry"][:5]:
        print(f"   {q}")
    print(f"   …共 {len(r['industry'])} 条")
    print("\n-- 权威源直捣:")
    for q in r["authority"]:
        print(f"   {q}")
    print("\n-- 漏斗改写链:")
    for q in r["funnel"]:
        print(f"   {q}")


if __name__ == "__main__":
    main()
