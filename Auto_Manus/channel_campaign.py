# -*- coding: utf-8 -*-
"""全渠道战役编成器 (融合蓝图 F0 完善·用户 09-22 令: 大研究报告=全渠道总动员+Manus军团).

模型升级:
  小任务(弹药单) → 单路由 (ticket_bus.py route: own/manus/dual)
  大研究报告(战役) → 全渠道编成 (本模块): 17+渠道全员作战 + Manus军团钻缺口 + dual核验

战役五段:
  A 全渠道广度扫(并行,零账号成本优先) → B 缺口盘点 →
  C Manus 深度钻探(缺口) → D dual 双跑核验(关键数据) → E 弹药汇流同一工单

用法 (F0 零网络 = 只生成编成作战单, 实际执行等网络恢复):
  python channel_campaign.py plan --need "..." [--origin EPC100]   # 直接生成
  python ticket_bus.py campaign <ticket_id>                        # 经总线

数据: data/bus/channel_registry.json (可热改; 渠道增删即进化)
"""
from __future__ import annotations

import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path(__file__).parent
BUS_DIR = ROOT / "data" / "bus"

# 渠道注册表默认版 — strengths 用细粒度信号词 (中文子串直接命中需求文本)
DEFAULT_REGISTRY = [
    {"id": "opencli", "name": "opencli 166站桥接", "entry": "opencli CLI",
     "strengths": ["官方", "公告", "政策", "行业", "企业", "动态", "建筑", "电力"],
     "cost": "free"},
    {"id": "rss", "name": "RSS 905源收割", "entry": "PAIStation-rss-harvest",
     "strengths": ["媒体", "资讯", "日报", "新闻", "动态", "盯梢"],
     "cost": "free"},
    {"id": "sogou_wx", "name": "搜狗微信采集", "entry": "SouGouWeDown2 (:3000)",
     "strengths": ["公众号", "深度", "评论", "分析", "微信"],
     "cost": "free"},
    {"id": "metaso", "name": "秘塔AI搜索", "entry": "metaso-search skill API",
     "strengths": ["全网", "综合", "快答", "检索"], "cost": "free"},
    {"id": "djyanbao", "name": "洞见研报", "entry": "djyanbao CLI",
     "strengths": ["研报", "券商", "研究", "报告", "财务", "市场", "行业"],
     "cost": "vip"},
    {"id": "patent", "name": "专利渠道", "entry": "五环法+5专利点",
     "strengths": ["专利", "技术", "创新", "工艺", "发明"], "cost": "free"},
    {"id": "govlist", "name": "招投标五线", "entry": "GovListChannel",
     "strengths": ["招投标", "招标", "中标", "采购", "项目"], "cost": "free"},
    {"id": "cnki", "name": "CNKI论文", "entry": "cnki-paper-downloader",
     "strengths": ["论文", "学术", "理论", "综述", "研究"], "cost": "cookie"},
    {"id": "weread", "name": "微信读书", "entry": "wrweb-next",
     "strengths": ["书籍", "专著", "理论", "体系"], "cost": "vip"},
    {"id": "ima_kb", "name": "ima知识库", "entry": "ima-skill API",
     "strengths": ["知识库", "语料", "总包", "水利", "知识"], "cost": "free"},
    {"id": "feishu", "name": "飞书文档中枢", "entry": "lark-cli",
     "strengths": ["内部", "战略", "协作", "文档"], "cost": "free"},
    {"id": "websearch", "name": "通用网页搜索", "entry": "WebSearch/webReader",
     "strengths": ["通用", "补盲", "新闻", "国际", "海外", "拓展"],
     "cost": "free"},
    {"id": "webcrawl", "name": "官网定向爬取", "entry": "website-crawler",
     "strengths": ["官网", "企业", "组织", "宣传", "架构"], "cost": "free"},
    {"id": "localfiles", "name": "本地文件扫描", "entry": "localfiles P0-P4",
     "strengths": ["存量", "历史", "档案"], "cost": "free"},
    {"id": "video", "name": "视频字幕", "entry": "yt-dlp",
     "strengths": ["视频", "访谈", "发布"], "cost": "free"},
    {"id": "qqmail", "name": "QQ邮箱", "entry": "qqmail-cli",
     "strengths": ["邮件", "订阅", "通讯"], "cost": "free"},
]

# 领域信号词 — 从需求文本提取, 与渠道 strengths 互补匹配 (覆盖复合词如"总承包")
DOMAIN_LEXICON = ["EPC", "总承包", "工程", "项目", "合同", "转型", "模式",
                  "战略", "市场", "竞争", "对标", "风险", "组织", "人才",
                  "海外", "国际", "新能源", "水利", "电力", "能源", "施工",
                  "设计", "采购", "咨询", "运维"]

# 战役编成: 渠道任务行模板 (F0 生成作战计划, 执行腿网络恢复后接线)
PHASES = ["A_广度扫", "B_缺口盘点", "C_Manus钻探", "D_双跑核验", "E_汇流成稿"]


def load_registry() -> list[dict]:
    p = BUS_DIR / "channel_registry.json"
    if not p.is_file():
        BUS_DIR.mkdir(parents=True, exist_ok=True)
        p.write_text(json.dumps(DEFAULT_REGISTRY, ensure_ascii=False, indent=1),
                     encoding="utf-8")
        return DEFAULT_REGISTRY
    try:
        reg = json.loads(p.read_text(encoding="utf-8"))
        return reg if isinstance(reg, list) and reg else DEFAULT_REGISTRY
    except (json.JSONDecodeError, OSError):
        return DEFAULT_REGISTRY


def _keywords(need: str) -> list[str]:
    return [w for w in re.split(r"[\s,，、;；/]+", need)
            if len(w) >= 2 and not w.isdigit()]


def channel_fit(channel: dict, need: str) -> int:
    """课题-渠道适配分: 细粒度 strengths 子串命中 + 领域信号词互补."""
    direct = sum(1 for s in channel.get("strengths", []) if s in need)
    text = " ".join(channel.get("strengths", [])) + channel.get("name", "")
    lex = sum(1 for w in DOMAIN_LEXICON if w in need and w in text)
    return direct + lex


def build_campaign(need: str, origin: str = "EPC100") -> dict:
    """全渠道战役编成 — 大研究报告全员作战单 (F0: 计划态, 零网络)."""
    reg = load_registry()
    scored = [(c, channel_fit(c, need)) for c in reg]
    # 全渠道总动员 (用户令: 全部用上) — 适配分只决定出场顺序, 不淘汰渠道
    scored.sort(key=lambda x: -x[1])
    sig = [w for w in DOMAIN_LEXICON if w in need][:8] or _keywords(need)[:6]
    order = [
        {"phase": "A", "seq": i + 1, "channel_id": c["id"], "channel": c["name"],
         "entry": c["entry"], "fit": s,
         "role": "主力扫" if s >= 2 else ("协扫" if s == 1 else "广谱兜底"),
         "task": f"按课题关键词收割: {' / '.join(sig)}",
         "status": "planned"}
        for i, (c, s) in enumerate(scored)
    ]
    return {
        "campaign_id": f"CP-{time.strftime('%Y%m%d-%H%M')}",
        "need": need, "origin": origin, "mode": "full_mobilization",
        "created": time.strftime("%Y-%m-%d %H:%M"),
        "principle": "小任务单路由, 大战役全渠道总动员 (用户 09-22 令); "
                     "先极致调研后撰写 — 调研收集做到极致是成稿的唯一前提 (用户 09-22 定调)",
        "ammo_gate": {
            "min_chars": 10_000_000,
            "rule": "本次新增调研资料 (通过有效性判断的, judge=valid) "
                    "总字数 ≥1000万字 才准进入撰写 (用户 09-22 终版铁律: "
                    "存量不计门槛; 成稿素材不受限=存量+新增皆可引用)",
            "check": "Phase B 盘点 (ammo_pool.status 门槛账只认 valid); "
                     "不足则回 A/C 继续采, 严禁带伤撰写",
        },
        "phases": {
            "A_广度扫": {"executors": order,
                         "note": "全渠道并行, 零账号成本渠道优先出场"},
            "B_缺口盘点": {"executors": [{"who": "own+jev",
                         "task": "盘点弹药总字数(硬门≥1000万, 渠道+军团合计)/维度覆盖/信源独立数, 列缺口清单"}],
                         "note": "弹药等价原则: 渠道资料与军团成果同池同schema同核验, 跨引擎URL去重 (用户 09-22 定调)"},
            "C_Manus钻探": {"executors": [{"who": "manus_corps",
                         "task": "缺口清单→参谋拆矩阵→军团钻探 (10-60积分/任务, 每账号≤2)"}],
                         "note": "只钻我方渠道扫不到的缺口, 积分不浪费"},
            "D_双跑核验": {"executors": [{"who": "dual",
                         "task": "关键数据点 (金额/排名/合同额) 双跑交叉, 分歧即红旗"}],
                         "note": "每课题≤3题, 成本受控"},
            "E_汇流成稿": {"executors": [{"who": "manus→own",
                         "task": "Manus 分析输出章节 → Jev 论断终审 → EPC100 终稿整合"}],
                         "note": "前置=ammo_gate 已过; assertions_failed>0 禁止发布"},
        },
        "totals": {"channels": len(order),
                   "main": sum(1 for o in order if o["role"] == "主力扫"),
                   "manus_tasks_est": 6, "dual_est": 3},
    }


def main() -> int:
    import argparse
    ap = argparse.ArgumentParser(description="全渠道战役编成器 (F0)")
    ap.add_argument("cmd", choices=["plan", "channels"])
    ap.add_argument("--need", default="")
    ap.add_argument("--origin", default="EPC100")
    ap.add_argument("--save", help="编成单落盘路径 (默认打印)")
    args = ap.parse_args()

    if args.cmd == "channels":
        for c in load_registry():
            print(f"  {c['id']:<12} {c['name']:<18} [{'/'.join(c['strengths'][:3])}]")
        return 0

    if not args.need.strip():
        print("--need 不能为空", file=sys.stderr)
        return 2
    cp = build_campaign(args.need.strip(), args.origin)
    text = json.dumps(cp, ensure_ascii=False, indent=1)
    if args.save:
        Path(args.save).write_text(text, encoding="utf-8")
        print(f"[campaign] 编成单落盘: {args.save}")
    print(f"[campaign] {cp['campaign_id']} 全渠道 {cp['totals']['channels']} 个 "
          f"(主力 {cp['totals']['main']} | Manus钻探 {cp['totals']['manus_tasks_est']}任务 "
          f"| dual {cp['totals']['dual_est']}题)")
    for o in cp["phases"]["A_广度扫"]["executors"][:6]:
        print(f"  A{o['seq']:>2}. [{o['role']}] {o['channel']} (fit={o['fit']})")
    print("  ... (全部渠道见编成单)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
