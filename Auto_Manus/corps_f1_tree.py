# -*- coding: utf-8 -*-
"""F1 蓝皮书缺口战役树生成器 (1010 点火令) — 产出 f1_gap_tree_v2.json
并插到 epc_battle_queue.json 队首 (Manus 军团按队列优先级派单).

缺口四面 (CHARTER §已知缺口 + FRAMEWORK §7):
  T001 十七省 2026 动态时效增补 (17 问, 一省一问)
  T002 政策与行业大盘时效增补 (8 问)
  T003 水利EPC投标 D级缺口 (10 问)
  T004 企业卷回捞补充 (6 问)
  T005 卷五独家判断证据 (10 问)
schema 与 epc49/50_topic_tree_v2 同构 (dispatch() 队列树读法).
幂等: 树已存在只重排队列.
"""
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).parent
TREE_OUT = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007"
                r"\work\f1_gap_tree_v2.json")
QUEUE = ROOT / "data" / "epc_battle_queue.json"

PROVS = ["湖南", "贵州", "海南", "安徽", "四川", "新疆", "浙江", "宁夏",
         "河北", "青海", "黑龙江", "福建", "天津", "山东", "云南", "湖北",
         "山西"]


def topic(tid, dim, title, queries, qs):
    return {
        "id": tid, "dimension": dim, "title": title, "status": "pending",
        "manus_use": "collect", "queries": queries,
        "questions": [{"id": f"{tid}Q{i+1:02d}", "kind": "collect",
                       "text": t, "status": "pending", "chars": 0,
                       "sources": 0}
                      for i, t in enumerate(qs)],
        "rounds": 0,
    }


def build():
    t1 = topic(
        "T001", "时效增补", "2026年十七省EPC市场最新动态",
        ["2026 固定资产投资 增速 重点建设项目",
         "2026 工程总承包 中标 政策 省份",
         "2026 重点项目 开工计划 投资"],
        [f"{p}省2026年固定资产投资增速、重点建设项目开工与EPC工程总承包"
         f"市场最新动态（含2026年上半年数据与下半年计划）" for p in PROVS])
    t2 = topic(
        "T002", "时效增补", "2026年国家政策与EPC行业大盘",
        ["2026 工程总承包 政策 住建部 发改委",
         "2026 建筑业总产值 固定资产投资 统计",
         "工程总承包 十五五 规划 趋势"],
        [
            "2026年住建部与发改委工程总承包（EPC）相关政策文件与征求意见稿最新动态",
            "2026年全国建筑业总产值、固定资产投资（含基建投资）官方统计与增速",
            "「十五五」规划纲要及中期评估中与工程建设、新型城镇化、重大工程相关部署",
            "2026年《招标投标法》修订及相关招投标监管新规对EPC发包的影响",
            "2026年城市更新、老旧小区改造、地下管网改造国家投资计划与规模",
            "2026年新能源大基地、抽水蓄能、核电核准建设进度与工程投资规模",
            "2026年全国EPC工程总承包中标金额、项目数与渗透率行业统计或第三方研究",
            "2026年央企建筑新签合同额排名与EPC合同占比变化（中国建筑/中铁/中交/能建/电建）",
        ])
    t3 = topic(
        "T003", "水利缺口", "水利EPC项目投标专题（D级缺口补采）",
        ["2026 水利工程 投资 计划 水利部",
         "水利工程 EPC 总承包 中标 招标",
         "重大水利工程 2026 开工 清单"],
        [
            "水利部2026年水利投资计划完成情况与重大水利工程开工建设清单",
            "2026年水利工程EPC/DB总承包模式中标项目盘点（项目名、金额、中标单位）",
            "水利工程施工总承包与设计采购施工总承包资质要求与投标门槛",
            "长江委、黄委、淮河等流域机构及省级水投平台2026年招标计划与发包偏好",
            "重大水利工程（引调水、防洪、灌区）EPC投标竞争格局与主要玩家份额",
            "水利工程EPC项目投标报价构成、下浮率水平与价格竞争态势",
            "水利工程EPC+F、特许经营等投融资模式2026年应用案例与风险",
            "水利工程EPC项目设计变更、结算审计与核减典型案例（2024-2026）",
            "智慧水利、数字孪生水利工程建设项目2026年布局与EPC机会",
            "对标:中国电建/中国能建下属设计院在水利EPC市场的2026年新签与在手订单",
        ])
    t4 = topic(
        "T004", "企业回捞", "企业卷六家缺口回捞补充",
        ["中国建筑第六工程局 EPC 项目 业绩",
         "工程总承包 央企 2026 新签合同",
         "设计院 EPC 转型 业绩 案例"],
        [
            "中国建筑第六工程局工程总承包（EPC）业务布局、代表项目与2024-2026年经营数据",
            "中国建筑第六工程局组织架构、项目管理体系与在建重大项目清单",
            "中国公路工程咨询集团与中国寰球工程2024-2026年EPC新签合同与代表项目",
            "山东电力工程咨询院与上海市政总院2024-2026年工程总承包经营数据更新",
            "中建三局、中建五局、中建八局2024-2026年EPC新签合同额与区域布局",
            "铁四院、华陆工程、湖南设计院2024-2026年工程总承包业务动态与代表项目",
        ])
    t5 = topic(
        "T005", "判断证据", "卷五独家判断证据采集（2026-2029预判）",
        ["EPC 渗透率 趋势 数据",
         "工程总承包 利润率 低价中标 演化",
         "设计施工一体化 趋势 国际对比"],
        [
            "中国政府投资项目EPC模式渗透率变化数据与2026-2029渗透率预测证据",
            "EPC总承包商利润率与毛利率趋势：央企年报数据与低价中标竞争演化证据",
            "设计院与施工企业EPC能力融合（设计施工一体化）进展与典型案例",
            "EPC模式下审计核减、结算争议趋势数据（2023-2026）",
            "F+EPC、EPC+O等模式风险暴露案例与监管态度（2024-2026）",
            "日本、新加坡、欧美设计建造（DB）模式渗透率与中国EPC对比研究",
            "区域保护与本地化壁垒在省级EPC市场的表现证据（信用分、属地资质要求）",
            "央企与地方国企、民企在EPC市场份额迁移的结构性证据（2020-2026）",
            "2027-2030年中国固定资产投资与建筑业需求预测（权威机构口径）",
            "AI与数字化（BIM、智能建造）对EPC交付模式改造的进展与量化效果证据",
        ])
    return {"company": "工程总承包行业蓝皮书F1缺口补采", "short": "蓝皮书F1",
            "generated": time.strftime("%Y-%m-%dT%H:%M:%S"), "version": "v2",
            "topics": [t1, t2, t3, t4, t5]}


def main() -> int:
    if TREE_OUT.is_file():
        t = json.loads(TREE_OUT.read_text(encoding="utf-8"))
        n = sum(1 for tp in t["topics"] for q in tp["questions"]
                if q["status"] == "pending")
        print(f"树已存在 ({n} pending), 只重排队列")
    else:
        t = build()
        TREE_OUT.parent.mkdir(parents=True, exist_ok=True)
        TREE_OUT.write_text(json.dumps(t, ensure_ascii=False, indent=1),
                            encoding="utf-8")
        n = sum(1 for tp in t["topics"] for q in tp["questions"]
                if q["status"] == "pending")
        print(f"✓ 生成 {TREE_OUT.name}: 5 话题 {n} 问")
    q = json.loads(QUEUE.read_text(encoding="utf-8"))
    trees = [str(TREE_OUT)] + [p for p in q["trees"] if str(TREE_OUT) != p]
    q["trees"] = trees
    q["note"] = ("1010 用户令: F1 蓝皮书缺口补采插队首 (字数门达成前主产); "
                 "吃空后自动落回 #49 四川院 → #50 储备")
    q["updated"] = time.strftime("%Y-%m-%dT%H:%M:%S")
    QUEUE.write_text(json.dumps(q, ensure_ascii=False, indent=1),
                     encoding="utf-8")
    print(f"✓ 队列已更新, 首位 = {trees[0].split(chr(92))[-1]}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
