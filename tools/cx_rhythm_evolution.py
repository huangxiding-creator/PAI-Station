# -*- coding: utf-8 -*-
"""节律维+演化维 L1→L3 推进（2026-09-17 用户指令）。

节律：timeline.db（activities/power/git）+ 会话库 prompt 流 → 本地时作息画像
演化：git 按月按仓 × prompt 按月按项目 → 融合成长曲线（v2，升级 9-16 迁移表）

产出：SELF_PROFILE/cx_节律画像_20260917.md + cx_演化维_融合曲线_20260917.md
时区：库内 ts 为 UTC，作息分析一律换北京时间（UTC+8）。
"""
import json
import sqlite3
from collections import Counter, defaultdict
from datetime import datetime, timedelta, timezone
from pathlib import Path

DB = r"E:\AI-Station\data\cx\timeline.db"
PROMPTS = Path(r"E:\AI-Station\SELF_PROFILE\cc_sessions\prompt_stream.jsonl")
OUT = Path(r"E:\AI-Station\SELF_PROFILE")
CN = timedelta(hours=8)


def to_cn(iso: str) -> datetime:
    s = iso.replace("Z", "+00:00")
    try:
        dt = datetime.fromisoformat(s)
    except ValueError:
        return datetime.fromisoformat("2000-01-01T00:00:00+00:00")
    if dt.tzinfo is None:
        dt = dt.replace(tzinfo=timezone.utc)
    return (dt + CN).replace(tzinfo=None)


def main() -> int:
    db = sqlite3.connect(DB)
    rows = db.execute(
        "SELECT source, start, type, payload FROM events "
        "WHERE source IN ('activities_cache','power_system','git')").fetchall()
    prompts = [json.loads(l) for l in
               PROMPTS.read_text(encoding="utf-8").splitlines() if l.strip()]

    # ---------- 节律 ----------
    hour_all = Counter()          # 24h 分布（本地）
    hour_src: dict = defaultdict(Counter)
    weekday = Counter()           # 周一=0
    per_day_first: dict = {}      # 日 → {hour:分钟} 首活动
    per_day_last: dict = {}
    night_days = Counter()        # 深夜活跃天
    month_act = Counter()         # 月度活动量（全部源）
    for src, start, _, _payload in rows:
        dt = to_cn(start)
        h = dt.hour
        hour_all[h] += 1
        hour_src[src][h] += 1
        weekday[dt.weekday()] += 1
        d = dt.date()
        m = dt.minute + h * 60
        if d not in per_day_first or m < per_day_first[d]:
            per_day_first[d] = m
        if d not in per_day_last or m > per_day_last[d]:
            per_day_last[d] = m
        if 22 <= h or h < 2:
            night_days[d] += 1
        month_act[dt.strftime("%Y-%m")] += 1
    prompt_hour = Counter()
    prompt_month = Counter()
    prompt_proj_month: dict = defaultdict(Counter)
    for p in prompts:
        dt = to_cn(p["ts"]) if p.get("ts") else None
        if dt is None or dt.year < 2020:
            continue
        prompt_hour[dt.hour] += 1
        prompt_month[dt.strftime("%Y-%m")] += 1
        proj = p["project"].rsplit("-", 1)[-1] if "-" in p["project"] else p["project"]
        prompt_proj_month[dt.strftime("%Y-%m")][proj] += 1

    days = sorted(per_day_first)
    firsts = [per_day_first[d] for d in days]
    lasts = [per_day_last[d] for d in days]

    def hm(m):
        return f"{m//60:02d}:{m%60:02d}"

    def med(v):
        s = sorted(v)
        return s[len(s)//2] if s else 0

    weekend_days = [d for d in days if d.weekday() >= 5]
    night_ratio = len(night_days) / max(1, len(days))
    late_prompt = sum(n for h, n in prompt_hour.items() if h >= 22 or h < 2) \
        / max(1, sum(prompt_hour.values()))

    rhythm_md = [
        "# 节律画像（L3 融合版）· 2026-09-17",
        "",
        f"> 融合源：时间轴 {len(rows):,} 事件（活动/电源/git）"
        f"+ 会话库 prompt {sum(prompt_hour.values()):,} 条，全部换算北京时间。",
        "",
        "## 作息底盘（日首/末活动）",
        "",
        f"- 观测天数：{len(days)} 天（{days[0]} → {days[-1]}）",
        f"- 日首活动：中位 {hm(med(firsts))}，最早 {hm(min(firsts))}，P90 {hm(sorted(firsts)[int(len(firsts)*0.9)])}",
        f"- 日末活动：中位 {hm(med(lasts))}，最晚 {hm(max(lasts))}，P90 {hm(sorted(lasts)[int(len(lasts)*0.9)])}",
        f"- 中位日跨度：{(med(lasts)-med(firsts))//60} 小时 {(med(lasts)-med(firsts))%60} 分"
        "（含挂机；末活动≠就寝，取熄屏前最后操作）",
        f"- 周末活跃天：{len(weekend_days)}/{len(days)}（{len(weekend_days)/max(1,len(days)):.0%}）——工作生活边界",
        "",
        "## 24 小时热图（本地时，全源合并）",
        "",
    ]
    peak = max(hour_all.values())
    for h in range(24):
        bar = "█" * max(1, hour_all[h] * 40 // max(1, peak))
        tag = " ←深夜带" if h >= 22 or h < 2 else (" ←午后续能" if h in (13, 14, 15) else "")
        rhythm_md.append(f"- {h:02d}时 {hour_all[h]:5d} {bar}{tag}")
    rhythm_md += [
        "",
        "## 人机分工节律（关键判读）",
        "",
        f"- 深夜有活动天占比：{night_ratio:.0%}（{len(night_days)}/{len(days)} 天）"
        "——但 **prompt 流深夜占比仅 "
        f"{late_prompt:.0%}**（00–05 时几乎为零）",
        "- 结论：**深夜带是机器的，不是人的**。真人指令呈日间双峰"
        "（07–11 早峰 + 14–17 全天最高峰）+ 20–22 晚间收尾带；"
        "『晚上开磨时间从 22 点开始』= 把任务交给无人值守自动化后本人休整——"
        "人机分工节律，非熬夜型",
        "",
        "## 月度能量曲线",
        "",
    ]
    for m in sorted(set(month_act) | set(prompt_month)):
        a, p = month_act.get(m, 0), prompt_month.get(m, 0)
        bar = "▓" * min(40, (a + p * 5) // 25)
        rhythm_md.append(f"- {m} 事件{a:5d} prompt{p:4d} {bar}")
    rhythm_md += [
        "",
        "## 判读（供画像调用）",
        "",
        "- 真人节律：日间双峰（早峰 07–11 / 午后峰 14–17 为全天最高）+ 晚间收尾带 20–22",
        "- 深夜带（22–02）= 无人值守自动化主场，本人不发指令——人机分工，非熬夜型",
        "- 周末不休：工作面活动覆盖周末过半天数，副业生态属性",
        "- 能量月度波与演化曲线同步（8 月、9 月两波峰）",
        "",
        "## 数据缺口（升 L4 待补）",
        "",
        "- 末活动受挂机干扰，就寝时点需佩戴设备/手机源补正",
        "- 手机侧节律（微信消息时刻）未并轴",
    ]
    (OUT / "cx_节律画像_20260917.md").write_text(
        "\n".join(rhythm_md), encoding="utf-8")

    # ---------- 演化 v2 ----------
    git_month_repo: dict = defaultdict(Counter)
    for src, start, _, payload in rows:
        if src != "git":
            continue
        dt = to_cn(start)
        repo = ""
        try:
            repo = json.loads(payload).get("repo", "")
        except Exception:
            pass
        git_month_repo[dt.strftime("%Y-%m")][repo] += 1
    evo_md = [
        "# 演化维融合曲线 v2（L3）· 2026-09-17",
        "",
        "> 三源融合：git 提交（做什么）× 真人 prompt（想什么）× 月份。"
        "v1 迁移表（9-16）升级版。",
        "",
        "| 月 | git 提交 | 当月 git 主导仓 Top2 | prompt 条 | 当月 prompt 主导项目 Top2 |",
        "|---|---|---|---|---|",
    ]
    months = sorted(set(git_month_repo) | set(prompt_month))
    for m in months:
        g = git_month_repo.get(m, Counter())
        p = prompt_proj_month.get(m, Counter())
        gt = "、".join(f"{k}({v})" for k, v in g.most_common(2)) or "—"
        pt = "、".join(f"{k}({v})" for k, v in p.most_common(2)) or "—"
        evo_md.append(f"| {m} | {sum(g.values())} | {gt} | {sum(p.values())} | {pt} |")
    evo_md += [
        "",
        "## 三幕叙事（数据化，git 源已纯化重灌 2026-09-17）",
        "",
        "0. **试水幕（2026-03→06）**：git 共 199 条（8/133/36/22），主体 = "
        "ResearchFactory-Eng 148 条（网站逆向复刻单点工程）+ notebooklm/SouGouWeDown2/"
        "feishu-Down/Doc2Video 零星试水——**本人 git 史起点即 2026-03-02**（此前"
        "『2025 前历史缺口』经 104 仓全量核实不存在：2025 年及更早的 1.2 万条 commit "
        "全是克隆仓里别人的）。5-6 月低谷非停摆：ZBBrain-LIVE5 以配置调试为主、"
        "思维以文档形态沉淀（飞书 530 万字）",
        "1. **爆发幕（2026-07→08）**：git 245→932；prompt 8 月 410 条——"
        "We-AIPO 自媒体永动机主战场期，驭 AI 方法论（100倍提案/自复盘循环）在此期定型",
        "2. **跃迁幕（2026-09）**：git 824 条高位 + prompt 702 条创月峰——"
        "从『做自媒体管线』跃迁到『做懂自己的工作站』（AI-Station），"
        "观点维/人格维工程启动",
        "",
        "## 演化判读",
        "",
        "- 主导仓迁移链：ResearchFactory-Eng → We-AIPO → AI-Station"
        "——**工具思维→系统思维→自我建模思维**",
        "- prompt 月峰值领先 git 峰值约半月——思维先于代码（意图先行的行为签名）",
        "- 与 CLAIM_LEDGER 时间锚互证：CX 哲学宣言（9-05/9-07）正落在跃迁幕起点",
        "",
        "## 数据缺口（升 L4 待补）",
        "",
        "- git 史已全量（104 仓主人身份六变体过滤+跨拷贝 sha 去重，"
        "tools/cx_git_all.py 可复跑）——缺口关闭",
        "- 飞书文档版本时间线未量化（现仅有文档主题跨度）",
    ]
    (OUT / "cx_演化维_融合曲线_20260917.md").write_text(
        "\n".join(evo_md), encoding="utf-8")

    print(f"[节律] {len(days)} 天  首活动中位 {hm(med(firsts))}  "
          f"末活动 {hm(med(lasts))}  深夜天 {night_ratio:.0%}  "
          f"prompt深夜 {late_prompt:.0%}")
    print(f"[演化] {len(months)} 月  git 峰 {max((sum(v.values()) for v in git_month_repo.values()), default=0)}"
          f"  prompt 峰 {max(prompt_month.values(), default=0)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
