# -*- coding: utf-8 -*-
"""EPC50 问题树 v2 — 10 倍扩容 (0923 用户令).

56 主题 × 10 问法模板 = 560 个可回答子问题. 全渠道单一事实源:
Manus 军团按子问题派 collect 任务; 搜狗/秘塔/官网/视频按子问题
生成检索词; 饱和引擎按子问题量覆盖度 (同题 ≥2 独立源 = 饱和).
v1 (56 主题规划层) 保持不动 — round-0 账本; v2 只增不改.
输出: 战场 _pipeline/epc50_topic_tree_v2.json
"""
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
BATTLE = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
              r"\《中石化南京工程有限公司怎么干EPC总承包？》")
V1 = BATTLE / "_pipeline" / "epc50_topic_tree.json"
V2 = BATTLE / "_pipeline" / "epc50_topic_tree_v2.json"

TEMPLATES = [
    ("现状", "{s}在「{t}」方面的现状与最新布局是什么？"),
    ("数据", "{s}「{t}」有哪些可查证的公开数据与指标（2020-2025）？"
             "数字、口径与出处分别是什么？"),
    ("案例", "{s}「{t}」方面有哪些标杆项目或典型工程案例？"
             "项目规模、角色分工、工期、成效细节如何？"),
    ("制度", "{s}「{t}」的组织、制度、流程是如何设计的？"
             "有何特点与行业评价？"),
    ("对标", "「{t}」方面{s}与中石化宁波工程、中石化洛阳工程、SEI "
             "等同行相比，优势与差距各是什么？"),
    ("风险", "{s}「{t}」方面出现过哪些问题、争议、处罚、事故或"
             "风险事件？后续如何整改？"),
    ("时间线", "{s}「{t}」的演进时间线与关键转折节点是什么？"
               "每个节点发生了什么？"),
    ("文献", "关于「{t}」（涉及{s}）有哪些行业研究报告、政策文件、"
             "标准规范或学术文献？各自核心结论是什么？"),
    ("人物", "{s}「{t}」方面的关键人物、专家团队、领导言论或"
             "公开表态有哪些？"),
    ("趋势", "「{t}」领域的前沿趋势与技术方向是什么？{s}的"
             "应对布局与投入如何？"),
]


def main() -> None:
    v1 = json.loads(V1.read_text(encoding="utf-8"))
    s, company = v1["short"], v1["company"]
    v2 = {"company": company, "short": s, "generated":
          time.strftime("%Y-%m-%dT%H:%M:%S"), "version": 2,
          "topics": []}
    n = 0
    for t in v1["topics"]:
        topic = {"id": t["id"], "dimension": t["dimension"],
                 "title": t["title"], "status": t["status"],
                 "manus_use": t["manus_use"], "queries": t["queries"],
                 "questions": []}
        for k, (kind, tpl) in enumerate(TEMPLATES, 1):
            n += 1
            topic["questions"].append({
                "id": f"{t['id']}Q{k:02d}", "kind": kind,
                "text": tpl.format(s=s, t=t["title"]),
                "status": "pending", "chars": 0, "sources": []})
        v2["topics"].append(topic)
    V2.write_text(json.dumps(v2, ensure_ascii=False, indent=1),
                  encoding="utf-8")
    # 校验: 全库无重复 id
    ids = [q["id"] for tp in v2["topics"] for q in tp["questions"]]
    assert len(ids) == len(set(ids)) == 560, f"子问题数异常: {len(ids)}"
    print(f"[v2] {len(v2['topics'])} 主题 × {len(TEMPLATES)} 问法 = "
          f"{n} 子问题 → {V2}")
    for tp in v2["topics"][:2]:
        for q in tp["questions"][:3]:
            print(f"  {q['id']} [{q['kind']}] {q['text'][:50]}")


if __name__ == "__main__":
    main()
