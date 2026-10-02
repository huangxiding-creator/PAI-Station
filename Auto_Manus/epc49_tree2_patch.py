# -*- coding: utf-8 -*-
"""#49 tree2 追加 T073 低空经济 (公司简介新赛道, D1 侦察发现缺口)."""
import io
import json
import sys
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
T2 = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
          r"\《四川电力设计咨询有限责任公司怎么干EPC总承包？》"
          r"\_pipeline\epc49_topic_tree_v2.json")

t2 = json.loads(T2.read_text(encoding="utf-8"))
ids = {tp["id"] for tp in t2["topics"]}
assert "T073" not in ids, "T073 已存在, 不重复追加"

KINDS = ["现状", "战略动因", "组织与资源", "技术与产品", "项目案例",
         "商业模式", "竞争格局", "对标分析", "风险与挑战", "前景研判"]
QS = [
    "四川院在「低空经济业务」方面的现状与最新布局是什么？具体包括哪些业务方向（如低空空域规划设计、起降场/通用机场勘察设计、低空智联网基础设施）？",
    "四川院为何切入低空经济？这一新赛道与其电力设计主业（输变电廊道、电网规划）有何战略协同与资源复用逻辑？",
    "四川院为发展低空经济设立了什么组织（专班/事业部/合资公司）？投入了哪些设计与工程资源？",
    "四川院在低空经济领域已形成哪些技术方案或产品（空域规划、起降设施、低空通信/监视/气象基础设施设计）？",
    "四川院已落地或中标哪些低空经济相关项目？项目类型、规模与角色（咨询/设计/EPC）分别是什么？",
    "四川院低空经济业务的商业模式是什么？收入来自规划设计费、EPC 总承包还是投资运营？与传统能源基建业务相比盈利逻辑有何不同？",
    "在低空经济基建赛道上，四川院面对哪些竞争对手（民航设计院、铁四院、各省交规院、中电建兄弟单位）？各家切入角度与优劣势是什么？",
    "与西南电力设计院、华东电力设计院等同行相比，四川院的低空经济布局起步、投入力度与落地进度处于什么位置？",
    "四川院发展低空经济面临哪些风险与挑战（政策空域审批、需求真实性、竞争加剧、盈利模式不明）？",
    "四川院低空经济业务未来3-5年的前景如何？可能成为第二增长曲线，还是昙花一现的概念布局？",
]

t2["topics"].append({
    "id": "T073",
    "dimension": "10_市场与对标",
    "title": "低空经济新赛道布局",
    "status": "pending",
    "manus_use": "collect",
    "queries": [
        "四川电力设计咨询有限责任公司 低空经济 布局",
        "四川电力设计咨询有限责任公司 低空 空域 起降场 规划设计",
        "四川院 低空经济 电网 协同",
    ],
    "questions": [
        {"id": f"T073Q{i+1:02d}", "kind": KINDS[i], "text": QS[i],
         "status": "pending", "chars": 0, "sources": []}
        for i in range(10)
    ],
})
tmp = T2.with_suffix(".tmp")
tmp.write_text(json.dumps(t2, ensure_ascii=False, indent=1), encoding="utf-8")
tmp.replace(T2)
pend = sum(1 for tp in t2["topics"] for q in tp["questions"]
           if q["status"] == "pending")
print(f"OK: topics={len(t2['topics'])} pending={pend}")
