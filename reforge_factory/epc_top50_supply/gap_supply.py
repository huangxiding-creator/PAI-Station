# -*- coding: utf-8 -*-
"""gap_supply — EPC-TOP50 缺口定向采集 (1028 三门冲线·二).

归挂后 coverage 37/78: E1 全绿(除 Q24/Q25/Q26 分档带), 缺口集中在
E2 反证槽 (13 个零) 与 E3 权威槽 (~23 个零/单源)。本件定向补:

  腿A (E3 权威口径): anysearch search+extract 抓官方/协会原文
      (勘察设计协会排名公告 / 建市规12号 / 国办发19号 / GB标准 / 统计公报),
      cred=official, --tree <E3>;
  腿B (E2 反证): anysearch 抓风险/亏损/争议/处罚页, stance=against,
      --tree <E2> (搜狗微信腿 antispider 拦截中, 复活后补腿)。

诚实纪律 (铁律):
  - 每件抓回必须过 want 词域验证 (内容真在域内才入池), 不域内=如实 0;
  - judge 启发式会再过一遍战役 21 词硬门 (off_topic 废弃如实);
  - 每件可挂 2-5 EEI (计划表钦定, 域内明确才多挂);
  - 0 产出也落账 (supply_log.jsonl), 不做假账。

用法: py -X utf8 gap_supply.py [--leg e3|e2|all] [--max-tasks N]
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\EPC100"
                 r"\collectors\anysearch")
sys.path.insert(0, str(REPO / "reforge_factory"))
from client import AnySearchClient  # noqa: E402
from ammo_pool import count_chars  # noqa: E402  (与池 substance 同口径)

AMMO = REPO / "reforge_factory" / "ammo_pool.py"
POOL = REPO / "ammo_pool" / "EPC-TOP50"
STAGE = POOL / "staging" / "gap_supply" / time.strftime("%Y%m%d_%H%M%S")
LOG = STAGE / "supply_log.jsonl"
CID = "EPC-TOP50"

# 域黑名单 (403/登录墙/低质 SERP 形态)
DOM_SKIP = ("zhihu.com", "baidu.com", "weixin.sogou", "douyin", "bilibili",
            "csdn.net", "docin.com", "book118", "doc88")

# ---------- 计划表: slot → 采集任务 ----------
# eei_primary = ingest --tree; eei_extra = 追加挂树 (域内明确才列)
PLAN_E3 = [
    # 排名族 (中设协官方 = 全报告权威口径之源)
    {"eeis": ["Q1-E3", "Q2-E3", "Q3-E3", "Q24-E3"],
     "q": "中国勘察设计协会 工程总承包营业额排名 公布 通知",
     "must": ["排名"], "want": ["工程总承包"]},
    {"eeis": ["Q2-E3", "Q1-E3"],
     "q": "工程总承包营业额排名活动 申报 通知 口径 中设协字",
     "must": ["排名"], "want": ["工程总承包"]},
    {"eeis": ["Q3-E1", "Q24-E1", "Q25-E1", "Q26-E1"],
     "q": "2025年勘察设计企业工程项目管理和工程总承包营业额排名 178家",
     "must": ["排名"], "want": ["工程总承包"]},
    {"eeis": ["Q3-E1", "Q3-E3", "Q24-E1"],
     "q": "2021年 工程总承包营业额排名 公布 设计院",
     "must": ["排名"], "want": ["工程总承包"]},
    # 政策族
    {"eeis": ["Q4-E3", "Q6-E3", "Q12-E3"],
     "q": "房屋建筑和市政基础设施项目工程总承包管理办法 建市规 2019 12号 全文",
     "must": ["工程总承包"], "want": ["工程总承包"]},
    {"eeis": ["Q4-E3", "Q6-E3"],
     "q": "国办发 2017 19号 关于促进建筑业持续健康发展的意见 全文 工程总承包",
     "must": ["建筑业"], "want": ["工程总承包"]},
    {"eeis": ["Q13-E3", "Q14-E3", "Q4-E3"],
     "q": "工程勘察设计行业发展 十四五 规划 住建部 通知",
     "must": ["勘察设计"], "want": ["工程总承包"]},
    {"eeis": ["Q15-E3"],
     "q": "建设项目工程总承包管理规范 GB/T 50358-2017 全文",
     "must": ["50358"], "want": ["工程总承包"]},
    {"eeis": ["Q15-E3"],
     "q": "建设项目工程总承包合同 示范文本 GF-2020-0216 住建部",
     "must": ["总承包"], "want": ["工程总承包"]},
    {"eeis": ["Q16-E3"],
     "q": "招标投标法实施条例 全文 中标 gov.cn",
     "must": ["招标"], "want": ["中标"]},
    {"eeis": ["Q17-E3", "Q1-E3"],
     "q": "2024年 建筑业总产值 统计公报 国家统计局",
     "must": ["建筑业"], "want": ["建筑业"]},
    {"eeis": ["Q10-E3"],
     "q": "石油和化工勘察设计协会 工程总承包 排名 通知",
     "must": ["化工"], "want": ["工程总承包"]},
    {"eeis": ["Q11-E3"],
     "q": "冶金建设协会 工程总承包 排名 通知 冶金",
     "must": ["冶金"], "want": ["工程"]},
    {"eeis": ["Q9-E3"],
     "q": "国资委 中央企业负责人经营业绩考核办法 全文",
     "must": ["中央企业"], "want": ["业绩"]},
    {"eeis": ["Q19-E3"],
     "q": "保障中小企业款项支付条例 全文 国务院",
     "must": ["条例"], "want": ["工程"]},
    {"eeis": ["Q23-E3"],
     "q": "工程建设工法管理办法 住建部 全文",
     "must": ["工法"], "want": ["工程"]},
    {"eeis": ["Q20-E3"],
     "q": "工程总承包 项目经理 培训班 通知 协会 2025",
     "must": ["总承包"], "want": ["工程总承包"]},
    {"eeis": ["Q21-E3"],
     "q": "国企改革深化提升行动方案 全文 组织",
     "must": ["国企"], "want": ["工程"]},
    {"eeis": ["Q5-E3"],
     "q": "民营 设计院 工程总承包 发展 通知 支持",
     "must": ["设计"], "want": ["工程总承包"]},
    {"eeis": ["Q8-E3"],
     "q": "中国石化 工程建设 工程总承包 管理 办法 制度",
     "must": ["石化"], "want": ["工程总承包"]},
    {"eeis": ["Q18-E3"],
     "q": "工程造价改革工作方案 住建部 全文 成本",
     "must": ["造价"], "want": ["工程"]},
]

PLAN_E2 = [
    {"eeis": ["Q1-E2"], "q": "工程总承包营业额排名 质疑 口径 争议",
     "must": ["排名"], "want": ["总承包"]},
    {"eeis": ["Q2-E2"], "q": "工程总承包 排名 统计口径 争议 吞并 虚报",
     "must": ["排名"], "want": ["总承包"]},
    {"eeis": ["Q3-E2"], "q": "设计院 排名 下滑 出局 营业额 掉队",
     "must": ["设计院"], "want": ["总承包"]},
    {"eeis": ["Q5-E2"], "q": "民营设计院 倒闭 困境 EPC 转型失败",
     "must": ["设计院"], "want": ["EPC"]},
    {"eeis": ["Q8-E2"], "q": "石化 EPC 项目 亏损 教训",
     "must": ["EPC"], "want": ["EPC"]},
    {"eeis": ["Q9-E2"], "q": "中国中冶 中国化学 行政处罚 通报 项目",
     "must": ["中冶"], "want": ["工程"]},
    {"eeis": ["Q10-E2"], "q": "化工工程 EPC 项目 亏损 案例 失败",
     "must": ["化工"], "want": ["工程"]},
    {"eeis": ["Q11-E2"], "q": "冶金工程 建材工程 项目 亏损 停建 处罚",
     "must": ["工程"], "want": ["工程"]},
    {"eeis": ["Q14-E2"], "q": "电力设计院 亏损 困境 转型 风险",
     "must": ["电力设计"], "want": ["设计"]},
    {"eeis": ["Q21-E2"], "q": "设计院 组织架构 调整 裁员 争议",
     "must": ["设计院"], "want": ["设计"]},
    {"eeis": ["Q23-E2"], "q": "施工企业 专利侵权 判决 赔偿",
     "must": ["专利"], "want": ["工程"]},
    {"eeis": ["Q24-E2"], "q": "中国建筑 中国中铁 债务 风险 应收 质疑",
     "must": ["中国"], "want": ["工程"]},
    {"eeis": ["Q25-E2"], "q": "中型设计院 工程总承包 风险 亏损 承压",
     "must": ["设计院"], "want": ["总承包"]},
    {"eeis": ["Q26-E2"], "q": "设计院 排名 出局 垫底 榜单 压力",
     "must": ["排名"], "want": ["设计"]},
]


def emit(obj: dict):
    STAGE.mkdir(parents=True, exist_ok=True)
    with LOG.open("a", encoding="utf-8") as f:
        f.write(json.dumps(obj, ensure_ascii=False) + "\n")
    print(("  [%s] %s" % (obj.get("slot", "?"), obj.get("why", "")))[:160],
          flush=True)


def run_task(c: AnySearchClient, t: dict, cred: str, stance: str,
             tag: str) -> dict:
    slot = "+".join(t["eeis"])
    rec = {"slot": slot, "tag": tag, "q": t["q"], "ts": time.strftime("%F %T")}
    try:
        res = c.search(t["q"], max_results=8)
    except Exception as e:                                  # noqa: BLE001
        rec.update({"ok": False, "why": f"search_fail:{type(e).__name__}"})
        emit(rec)
        return rec
    hits = res.get("data", {}).get("results") or []
    cands = []
    for h in hits:
        url = str(h.get("url") or "")
        blob = str(h.get("title") or "") + str(h.get("snippet") or "")
        if any(d in url for d in DOM_SKIP):
            continue
        if not any(m in blob or m in url for m in t["must"]):
            continue
        cands.append(h)
    if not cands:
        rec.update({"ok": False, "why": "no_domain_hit",
                    "serp_n": len(hits)})
        emit(rec)
        return rec
    # 候选轮试: 协会页多为附件/JS 壳, 单一命中常薄 — 最多试 3 个,
    # 取首个过域门 (CJK 实质 ≥400 与池同口径 ∧ want 词在场) 的
    text = title = url = ""
    tries = []
    for pick in cands[:3]:
        u = pick["url"]
        try:
            ex = c.extract(u)
            txt = str((ex.get("data") or {}).get("content") or "")
        except Exception as e:                              # noqa: BLE001
            tries.append(f"{u[:40]}:extract_fail:{type(e).__name__}")
            continue
        cjk = count_chars(txt)
        tries.append(f"{u[:40]}:cjk={cjk}")
        if cjk >= 400 and any(w in txt for w in t["want"]):
            text, title, url = txt, str(pick.get("title") or u), u
            break
    if not text:
        rec.update({"ok": False, "why": "content_not_in_domain",
                    "serp_n": len(hits), "tries": tries})
        emit(rec)
        return rec
    title = re.sub(r"\s+", " ", title)[:60]
    eng = str(t.get("engine", "anysearch_web"))
    md = STAGE / (re.sub(r"\W+", "_", title)[:50] + ".md")
    md.parent.mkdir(parents=True, exist_ok=True)
    md.write_text(
        f"# {title}\n\n来源: {url} (engine={eng}, 采集 {rec['ts']}, "
        f"gap_supply {tag} 腿)\ncampaign {CID}, tree {'+'.join(t['eeis'])}, "
        f"cred {cred}, stance {stance}\n\n---\n\n{text}", encoding="utf-8")
    rc = subprocess.run(
        ["py", "-X", "utf8", str(AMMO), "ingest", CID, "--file", str(md),
         "--engine", eng, "--url", url, "--cred", cred,
         "--tree", t["eeis"][0], "--stance", stance],
        capture_output=True, text=True, encoding="utf-8", errors="replace")
    msg = (rc.stdout or "") + (rc.stderr or "")
    ing_ok = rc.returncode == 0 and ("+待审" in msg or "重复" in msg)
    rec.update({"ok": bool(ing_ok), "why": msg.strip()[-80:], "chars":
                len(text), "title": title, "file": str(md),
                "eeis": t["eeis"]})
    emit(rec)
    return rec


# ---------- 第二轮 (round2: 单源补第二源 + E3 零槽, 配额100内) ----------
PLAN_R2 = [
    # 单源槽 → 第二源 (须与首源异 host)
    {"eeis": ["Q2-E3", "Q24-E3"],
     "q": "关于公布2025年勘察设计企业工程项目管理和工程总承包营业额排名的通知",
     "must": ["排名"], "want": ["工程总承包"]},
    {"eeis": ["Q3-E3"],
     "q": "2024年勘察设计企业工程项目管理和工程总承包营业额排名公布",
     "must": ["排名"], "want": ["工程总承包"]},
    {"eeis": ["Q26-E1"],
     "q": "2024中国勘察设计企业排名 工程总承包营业额 榜单",
     "must": ["排名"], "want": ["工程总承包"]},
    {"eeis": ["Q16-E3"],
     "q": "工程建设项目招标范围和规模标准规定 全文 发改委",
     "must": ["招标"], "want": ["中标"]},
    {"eeis": ["Q17-E3"],
     "q": "2024年建筑业发展统计分析 住建部 总产值",
     "must": ["建筑业"], "want": ["建筑业"]},
    {"eeis": ["Q19-E3"],
     "q": "保障中小企业款项支付条例 2025 修订 全文 逾期付款",
     "must": ["条例"], "want": ["支付"]},
    {"eeis": ["Q10-E3"],
     "q": "石油和化工勘察设计协会 2024 工程总承包 排名 通知 转发",
     "must": ["化工"], "want": ["工程总承包"]},
    {"eeis": ["Q11-E3"],
     "q": "中国冶金建设协会 2024 工程总承包 排名 公布",
     "must": ["冶金"], "want": ["工程总承包"]},
    {"eeis": ["Q2-E2"],
     "q": "工程总承包营业额排名 联合体 口径 争议 吞并",
     "must": ["排名"], "want": ["总承包"]},
    # E3 零槽
    {"eeis": ["Q13-E3", "Q4-E3"],
     "q": "十四五 工程勘察设计行业发展规划 印发 通知 mohurd",
     "must": ["勘察设计"], "want": ["工程总承包"]},
    {"eeis": ["Q14-E3", "Q13-E3"],
     "q": "电力勘察设计行业 十四五 发展 规划 通知 协会",
     "must": ["电力"], "want": ["设计"]},
    {"eeis": ["Q5-E3"],
     "q": "住建部 促进建筑业 民营企业 发展 政策 措施 通知",
     "must": ["建筑业"], "want": ["工程"]},
    {"eeis": ["Q8-E3"],
     "q": "中国石化 工程建设有限公司 EPC 总承包 管理体系 公告",
     "must": ["石化"], "want": ["总承包"]},
    {"eeis": ["Q18-E3"],
     "q": "住房和城乡建设部 工程造价改革工作方案 建办标 38号",
     "must": ["造价"], "want": ["工程"]},
    {"eeis": ["Q20-E3"],
     "q": "勘察设计协会 工程总承包 项目经理 轮训 培训 通知",
     "must": ["总承包"], "want": ["培训"]},
    {"eeis": ["Q21-E3"],
     "q": "国资委 中央企业 压减 精简机构 组织 通知",
     "must": ["央企"], "want": ["企业"]},
    {"eeis": ["Q23-E3"],
     "q": "工程建设工法管理办法 建市〔2014〕77号 全文",
     "must": ["工法"], "want": ["工程"]},
]


# ---------- 第三轮 (round3: E2 零槽双源 + E3 第二host) ----------
PLAN_R3 = [
    # E2 零槽 ×2 异源 (两查询不同角度 → 落不同 host)
    {"eeis": ["Q1-E2"], "q": "工程总承包 排名 数据 争议 失真 质疑",
     "must": ["排名"], "want": ["总承包"]},
    {"eeis": ["Q1-E2"], "q": "勘察设计企业 营业额排名 口径 问题 分析",
     "must": ["排名"], "want": ["排名"]},
    {"eeis": ["Q3-E2"], "q": "设计院 营业额排名 下滑 出局 2024 2023",
     "must": ["设计院"], "want": ["排名"]},
    {"eeis": ["Q3-E2"], "q": "工程总承包 排名 变动 洗牌 掉队 原因",
     "must": ["排名"], "want": ["排名"]},
    {"eeis": ["Q5-E2"], "q": "民营设计院 倒闭 欠薪 困境 2024",
     "must": ["设计院"], "want": ["设计院"]},
    {"eeis": ["Q5-E2"], "q": "民营建筑企业 EPC 转型 风险 失败",
     "must": ["EPC"], "want": ["EPC"]},
    {"eeis": ["Q8-E2"], "q": "石化工程 EPC 项目 亏损 中石化 中石油",
     "must": ["EPC"], "want": ["工程"]},
    {"eeis": ["Q8-E2"], "q": "炼化工程 总承包 延期 索赔 风险",
     "must": ["总承包"], "want": ["工程"]},
    {"eeis": ["Q9-E2"], "q": "中国中冶 处罚 通报 违规 项目",
     "must": ["中冶"], "want": ["工程"]},
    {"eeis": ["Q9-E2"], "q": "中国化学 中国核建 行政处罚 安全 事故",
     "must": ["中国"], "want": ["工程"]},
    {"eeis": ["Q10-E2"], "q": "化工工程公司 EPC 亏损 项目 教训",
     "must": ["化工"], "want": ["工程"]},
    {"eeis": ["Q10-E2"], "q": "天辰 五环 华陆 项目 风险 争议",
     "must": ["工程"], "want": ["工程"]},
    {"eeis": ["Q11-E2"], "q": "中材国际 水泥工程 亏损 风险",
     "must": ["中材"], "want": ["工程"]},
    {"eeis": ["Q11-E2"], "q": "钢铁 冶金工程 停产 项目 下马 亏损",
     "must": ["冶金"], "want": ["工程"]},
    {"eeis": ["Q14-E2"], "q": "省级电力设计院 亏损 困境 新能源 内卷",
     "must": ["电力设计"], "want": ["设计"]},
    {"eeis": ["Q14-E2"], "q": "电力设计院 转型 EPC 风险 挑战",
     "must": ["电力设计"], "want": ["EPC"]},
    {"eeis": ["Q21-E2"], "q": "设计院 事业单位改制 人员流失 困境",
     "must": ["设计院"], "want": ["设计"]},
    {"eeis": ["Q21-E2"], "q": "工程公司 组织变革 阵痛 部门 裁撤",
     "must": ["工程"], "want": ["组织"]},
    {"eeis": ["Q23-E2"], "q": "工程建设 专利侵权 判决 赔偿 案例",
     "must": ["专利"], "want": ["工程"]},
    {"eeis": ["Q23-E2"], "q": "建筑企业 工法 造假 争议 通报",
     "must": ["工法"], "want": ["工法"]},
    {"eeis": ["Q24-E2"], "q": "中国建筑 中国中铁 应收账款 风险 质疑",
     "must": ["中国"], "want": ["应收"]},
    {"eeis": ["Q24-E2"], "q": "央企建筑 巨头 垄断 争议 中小企业",
     "must": ["央企"], "want": ["建筑"]},
    {"eeis": ["Q25-E2"], "q": "中型设计院 工程总承包 承压 亏损 风险",
     "must": ["设计院"], "want": ["总承包"]},
    {"eeis": ["Q25-E2"], "q": "区域设计院 困境 转型 EPC 风险",
     "must": ["设计院"], "want": ["EPC"]},
    {"eeis": ["Q26-E2"], "q": "设计院 排名 出局 跌出 榜单",
     "must": ["排名"], "want": ["设计"]},
    {"eeis": ["Q26-E2"], "q": "工程公司 榜单 垫底 压力 竞争",
     "must": ["榜单"], "want": ["工程"]},
    # E3 第二host / 零槽
    {"eeis": ["Q24-E3", "Q25-E3", "Q26-E3"],
     "q": "关于公布2024年勘察设计企业工程项目管理和工程总承包营业额排名的通知 转发 协会",
     "must": ["排名"], "want": ["工程总承包"]},
    {"eeis": ["Q2-E3"],
     "q": "勘察设计企业 营业额排名 申报 办法 口径 联合体",
     "must": ["排名"], "want": ["申报"]},
    {"eeis": ["Q3-E3"],
     "q": "历年 勘察设计企业 工程总承包 营业额 排名 汇总",
     "must": ["排名"], "want": ["工程总承包"]},
    {"eeis": ["Q20-E3"],
     "q": "注册建造师管理规定 住建部 全文",
     "must": ["建造师"], "want": ["工程"]},
    {"eeis": ["Q10-E3"],
     "q": "化学工程 工程总承包 排名 通知 2025 石化勘察设计",
     "must": ["排名"], "want": ["总承包"]},
    {"eeis": ["Q13-E3"],
     "q": "勘察设计行业 发展 报告 统计 分析 协会",
     "must": ["勘察设计"], "want": ["工程总承包"]},
    {"eeis": ["Q16-E3"],
     "q": "招标投标 违法 记录 公示 办法 发改委",
     "must": ["招标"], "want": ["招标"]},
    {"eeis": ["Q18-E3"],
     "q": "建筑业 产值 利润率 成本 分析 统计",
     "must": ["建筑业"], "want": ["利润"]},
    {"eeis": ["Q21-E3"],
     "q": "国有企业 深化改革 行动方案 组织 结构",
     "must": ["国企"], "want": ["企业"]},
    {"eeis": ["Q23-E3"],
     "q": "工程建设工法管理办法 2014 建市 77号",
     "must": ["工法"], "want": ["工程"]},
    {"eeis": ["Q8-E3"],
     "q": "石油化工 建设项目 竣工验收 规定 发改委",
     "must": ["石油化工"], "want": ["工程"]},
    {"eeis": ["Q26-E1"],
     "q": "2023年 工程总承包营业额排名 完整 名单 设计院",
     "must": ["排名"], "want": ["工程总承包"]},
]


# ---------- 第四轮 (r4: 1028 三门冲线收口 — 5 单源 E3 补异源官方位 + E2 反证) ----------
# 布阵依据 1028 11:46 覆盖账: 60/78=76.9%, 未饱和 18 槽 (9 zero + 9 single)。
# r4 主打 6 槽 (5 个单源 E3 + Q3-E2), 每槽现源 host 在案 (archina/zjt.shandong/
# ccesda/zgyj/ceppea/tbea), 任务查询刻意指向**异 host** 官方位 (gov.cn/联合会/
# 中电联/协会转发页), 双源即饱和; zero 槽 (Q24/Q25/Q26-E3, Q14-E2) 搭车挂树。
# engine 可逐任务覆盖 (缺省 anysearch_web=websearch; court:anysearch=涉诉 SERP
# 二手源腿, 同 harvest_court 口径)。
PLAN_R4 = [
    # E3 单源 → 第二源 (异 host)
    {"eeis": ["Q3-E3", "Q24-E3"],
     "q": "关于公布2024年勘察设计企业工程项目管理和工程总承包营业额排名的通知 住建部 转发",
     "must": ["排名"], "want": ["工程总承包"]},
    {"eeis": ["Q3-E3", "Q26-E3"],
     "q": "2023年勘察设计企业工程项目管理和工程总承包营业额排名 完整名单 公布",
     "must": ["排名"], "want": ["工程总承包"]},
    {"eeis": ["Q5-E3"],
     "q": "住房和城乡建设部 促进建筑业持续健康发展 民营企业 政策 通知 全文",
     "must": ["建筑业"], "want": ["民营"]},
    {"eeis": ["Q10-E3"],
     "q": "中国石油和化学工业联合会 化工工程 排名 公告 2025",
     "must": ["化工"], "want": ["工程"]},
    {"eeis": ["Q11-E3"],
     "q": "中国建筑材料联合会 建材工程 总承包 排名 公告 中材国际",
     "must": ["建材"], "want": ["工程"]},
    {"eeis": ["Q14-E3"],
     "q": "电力勘测设计企业 排名 通知 中电联 2024",
     "must": ["电力"], "want": ["设计"]},
    # E2 反证位 (websearch form)
    {"eeis": ["Q3-E2"],
     "q": "设计院 营业额排名 下滑 出局 2024 2025",
     "must": ["设计院"], "want": ["排名"]},
    # E2 反证位 (涉诉 form: engine 覆盖 → court:anysearch, C 轴 court 渠道)
    {"eeis": ["Q3-E2"],
     "q": "设计院 工程总承包 合同纠纷 判决 裁判文书",
     "must": ["设计院"], "want": ["纠纷"], "engine": "court:anysearch"},
    {"eeis": ["Q14-E2"],
     "q": "电力设计院 债务 纠纷 判决 处罚 通报",
     "must": ["电力设计"], "want": ["纠纷"], "engine": "court:anysearch"},
]


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--leg", default="all",
                    choices=["e3", "e2", "all", "r2", "r3", "r4"])
    ap.add_argument("--max-tasks", type=int, default=99)
    ns = ap.parse_args()
    STAGE.mkdir(parents=True, exist_ok=True)
    c = AnySearchClient()
    plans = {"r2": PLAN_R2, "r3": PLAN_R3, "r4": PLAN_R4}.get(
        ns.leg,
        ([] if ns.leg == "e2" else PLAN_E3) +
        ([] if ns.leg == "e3" else PLAN_E2))
    print(f"[gap-supply] leg={ns.leg} tasks={min(len(plans), ns.max_tasks)} "
          f"→ {STAGE}", flush=True)
    ok = fail = 0
    for t in plans[:ns.max_tasks]:
        cred = "official" if t in PLAN_E3 and ns.leg in ("e3", "all") \
            and t["eeis"][0].endswith("-E3") else \
            ("official" if any(e.endswith("-E3") for e in t["eeis"])
             else "media")
        stance = "against" if all(e.endswith("-E2") for e in t["eeis"]) \
            else "support"
        r = run_task(c, t, cred, stance, "E3" if stance == "support"
                     and t["eeis"][0].endswith("-E3") else "E2")
        ok += 1 if r.get("ok") else 0
        fail += 0 if r.get("ok") else 1
    print(f"[gap-supply] 完成: 入池 {ok} | 未得/拒 {fail} (如实)", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
