# -*- coding: utf-8 -*-
"""huashu_film — 研究报告宣传片驱动器 (huashu-motion 产线融合件 · 1027 用户令).

研究报告完成后, 除 H3 竖屏卡视频外, 增加 huashu-motion 专业宣传视频
(世界级封面审美 · 大字报排版 · 报告主视觉色 · 数据亮点动态呈现),
统一发布到视频号「总包说」.

用法:
  py -X utf8 promo/huashu_film.py --report OVERSEAS-2026            # 全链: 材料→作曲→配音→check→render→qa→登记
  py -X utf8 promo/huashu_film.py --report OVERSEAS-2026 --stage render|qa|register|voice|sound|check
  py -X utf8 promo/huashu_film.py --report OVERSEAS-2026 --publish  # 视频号上传 (video_upload.py; 登录态死则如实记录, 不硬闯)
  py -X utf8 promo/huashu_film.py --list                            # 在册创意简报

铁律 (全继承): 数字零造假 — 片中数字全出自 report.json / promo 宣传文实料;
不删文件; 密钥不进仓; 渲染 Chrome 用完即清 (只清 om 自起实例, 不碰 9222).
浏览器纪律: OM 自管 Chrome 渲染, 生产渲染需可见帧 (不最小化, 例外), 完即清.
"""
from __future__ import annotations

import argparse
import hashlib
import io
import json
import re
import shutil
import subprocess
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

ROOT = Path(__file__).resolve().parents[1]          # report_platform/
PROMO = ROOT / "promo"
STATION = ROOT.parent                               # E:/AI-Station
OM_CLI = STATION / "vendors" / "huashu-motion" / "cli" / "om.js"   # 源仓 CLI (离线·确定版 0.3.1)
OM_BIN = STATION / ".claude" / "skills" / "huashu-motion" / "bin" / "om"  # 技能 bin (npx 兜底)
OM_RUNTIME = STATION / "vendors" / "huashu-motion" / "runtime" / "om.js"
LEDGER = PROMO / "promo_ledger.jsonl"
VIDEOS = PROMO / "videos"
FILMS = PROMO / "films"
REPORT_JSON = ROOT / "content" / "report.json"
SITE_DIR = ROOT / "site"                            # grab 兜底材料源 (产品真身: 色板+二维码+卡片)
# 官网详情页 (优先材料源, 探活失败自动落回 SITE_DIR)
SITE_URL = "http://47.120.43.20:8885/{page}"
EDGE_VOICE = "zh-CN-YunjianNeural"                  # 沉稳男声 (Sports/Passion), 研报宣发用
FFMPEG = shutil.which("ffmpeg") or r"C:\Users\91216\bin\ffmpeg.exe"   # ffprobe 不在机, 时长走 ffmpeg -i 解析
FFPROBE_DIR = Path(r"F:\We-AIPO\tools")     # om voice/render/qa 依赖 ffprobe (spawnSync PATH 查找), 借 We-AIPO 在役件
OM_ENV_PATH = f"{FFPROBE_DIR};{__import__('os').environ.get('PATH', '')}"
WEAIPO_PY = Path(r"F:\We-AIPO\.venv\Scripts\python.exe")   # video_upload.py 须用其 playwright

# ---------------------------------------------------------------- 创意简报 (数字零造假: 逐条对应实料)

CREATIVE: dict[str, dict] = {
    "JIAGE-2026": {
        # 色板: 品牌族 墨蓝×铜金×纸白 (video_factory 品牌色同源; 计价主题)
        "palette": {"ink": "#0F2A43", "ink2": "#16385C", "brass": "#C9A876",
                    "paper": "#FAF7F2", "mut": "#8A8F98"},
        "kicker": "总包创研院 · 研究报告",
        "title_lines": ["工程计价", "依据与市场价"],
        "subtitle": "基准实战研究报告",
        "meta": ["12 章", "27.3 万字", "425 页"],
        # 实料: 宣传文 2026-10-27_zbzs_jiage_launch.md 回款革命段 (P000220 宣贯指引口径)
        "pot": {"label": "过程结算 · 支付比例下限（宣贯指引口径）",
                "num": 90, "unit": "% 起付",
                "share_lead": "节点一签认 · <b>法律上锁死</b>",
                "share_sub": "已结算金额不得翻出来重审 · 竣工阶段的重复审计与恶意拖欠被挡在门外"},
        "coins": [],
        # 实料: 同文 规则换轨段 / 回款革命段
        "hooks": [
            {"big": "GB → GB/T", "lead": "十一年来第一次换轨",
             "sub": "2024年12月30日新标发布 · 强制改推荐 · 规则效力全看合同怎么写"},
            {"big": "7400万 → 8250万", "lead": "审计结论不是终局",
             "sub": "胁迫签署的收尾结算协议被推翻 · 法院多判850万"},
        ],
        # 实料: 同文 解除与鉴定段 (第8章 固定总价解除案)
        "edge": {"head": "固定总价合同解除案 · 已完工程款之争",
                 "cn": "最高法院<b>采纳定额据实结算</b>",
                 "rev": "按政府定额测算 · 含变更签证的全部应付款与合同总价仅差数十万元 · 紧贴双方缔约预期",
                 "bars": [("发包方主张 · 按总价40%", "40%", 0.40, "paper"),
                          ("最高法采纳 · 定额据实", "全额", 1.0, "brass")],
                 "note": "同一份合同 · 两种算法 · 差出一整个项目的利润"},
        # 实料: report.json badges + s3_run_manifest (272,986 CJK / 425页双口径)
        "stats": [
            ("12", "章", "新规→定额→市场价→结算→鉴定→行动清单 全链"),
            ("27.3", "万字", "总装实测 272,986 CJK"),
            ("425", "页", "Word/PDF 双口径 · 265 证据锚 · 1532 处引用"),
        ],
        "markets": ["清单定额 · 企业内部定额", "信息价 · 市场价 · 调差 ±5%",
                    "过程结算 · 90% 支付锁定"],
        "markets_head": "计价实战 · 三大战场",
        "end": {"price": "全本 ¥698", "trial": "第 1 章 导论全章免费试读",
                "qr_src": SITE_DIR / "assets" / "qr_wechat.png",
                "qr_note": "微信扫码试读 · 或搜「总包AI顾问」",
                "credit": "总包创研院 出品"},
        # 口播 30-45s (宣传文精华; 每个数字有出处)
        "narration": (
            "过程结算，节点一签认，支付比例不低于90%，已结算金额在法律上锁死，不得翻出来重审。"
            "GB改GB/T，十一年来第一次换轨，规则不再自动生效，效力全看合同怎么写。"
            "固定总价合同解除，发包方主张按总价四成结算，最高法院采纳定额据实结算。"
            "胁迫签下的7400万结算协议，法院判了8250万。"
            "《工程计价依据与市场价基准实战研究报告》，12章、27.3万字、425页，265个证据锚。"
            "第1章免费试读，微信搜「总包AI顾问」。"
        ),
        "video": {"slug": "jiage_hm_v1",
                  "title": "节点一锁，90%先落袋",
                  "tags": ["工程计价", "造价", "过程结算", "研究报告", "总包说"],
                  "desc": ("过程结算节点一签认，支付比例不低于90%，已结算金额法律上锁死不得重审；"
                           "GB改GB/T十一年来第一次换轨；固定总价解除案最高法院采纳定额据实结算；"
                           "胁迫签的7400万协议被法院判回8250万。"
                           "《工程计价依据与市场价基准实战研究报告》12章·27.3万字·425页，"
                           "265个证据锚1532处引用。第1章免费试读，微信搜「总包AI顾问」。")},
    },
    "OVERSEAS-2026": {
        # 色板来源: om grab 实测 site/assets CSS 变量 (产品真身色板 1027):
        # --ink #0D2136 · --ink2 #14335A · --paper #F7F3EA · --brass2 #C9A876
        "palette": {"ink": "#0D2136", "ink2": "#14335A", "brass": "#C9A876",
                    "paper": "#F7F3EA", "mut": "#8A8F98"},
        "kicker": "总包创研院 · 研究报告",
        "title_lines": ["中资电力", "EPC 出海"],
        "subtitle": "全球市场与准入实战指南",
        "meta": ["12 章", "25.05 万字", "341 页"],
        # 实料: 宣传文 2026-10-25_zbzs_overseas_launch.md ¶1/¶2
        "pot": {"label": "中国对外承包工程 · 新签合同额（2025 · 逼近）",
                "num": 3000, "unit": "亿美元",
                "share_lead": "电力工程约占两成",
                "share_sub": "每 5 美元对外承包合同 · 约 1 美元出自电力工程"},
        # 实料: 同文 发现一 / 发现二
        "hooks": [
            {"big": "十七年首修", "lead": "入场券逻辑正在改写",
             "sub": "《对外承包工程管理条例》修订草案征求意见"},
            {"big": "2056 全面退煤", "lead": "未来二十年的订单清单",
             "sub": "印尼煤电退出时间表 · 100 吉瓦太阳能计划"},
        ],
        # 实料: 同文 发现五
        "edge": {"head": "ENR 全球最大 250 家国际承包商（2026-08 榜单）",
                 "cn": "75 家中国企业登榜 · 数量连续世界第一",
                 "rev": "2025 海外营收合计 1427.7 亿美元 · 占 250 强总国际营业额 25.9%",
                 "bars": [("中国企业平均", "11.2%", 0.112, "brass"),
                          ("国外头部前十平均", "68%", 0.68, "paper")]},
        # 实料: report.json badges + 宣传文做法段
        "stats": [
            ("12", "章", "全球市场三卷地图 · 准入/合同/风险/资金"),
            ("25.05", "万字", "总装实测 250,451 CJK"),
            ("341", "页", "句末源编号 · 数字-锚点互引门全过"),
        ],
        "markets": ["东南亚 · 南亚", "中东 · 中亚 · 土耳其", "非洲 · 拉美"],
        "end": {"price": "全本 ¥698", "trial": "第 1 章 导论全章免费试读",
                "qr_src": SITE_DIR / "assets" / "qr_wechat.png",
                "qr_note": "微信扫码试读 · 或搜「总包AI顾问」",
                "credit": "总包创研院 出品"},
        # 口播 30-45s 稿 (宣传文精华; 每个数字有出处; 实测 +14% rate ≈ 38.5s)
        "narration": (
            "2025年，中国对外承包工程新签合同额逼近3000亿美元，电力工程约占两成。"
            "条例十七年首修，入场券逻辑正在改写；印尼2056年全面退煤，"
            "就是未来二十年的订单清单。ENR全球250强，75家中国企业登榜，"
            "海外营收1427.7亿美元；但平均国际业务占比只有11.2%，国外头部前十是68%。"
            "《中资电力EPC出海》，12章、25.05万字、341页，全球棋盘一次摊开。"
            "第1章免费试读，微信搜「总包AI顾问」。"
        ),
        "video": {"slug": "overseas_hm_v1",
                  "title": "3000亿美元的盘子，电力占两成",
                  "tags": ["EPC", "电力工程", "出海", "研究报告", "总包说"],
                  "desc": ("2025年中国对外承包工程新签合同额逼近3000亿美元，电力工程约占两成。"
                           "条例十七年首修、印尼2056全面退煤、ENR 75家中企登榜与11.2%对68%的剪刀差——"
                           "《中资电力EPC出海：全球市场与准入实战指南》12章·25.05万字·341页，"
                           "全球棋盘一次摊开。第1章免费试读，微信搜「总包AI顾问」。")},
    },
}


# ---------------------------------------------------------------- 基础件

def log(tag: str, msg: str) -> None:
    print(f"[hf] {tag} {msg}", flush=True)


def om_cmd() -> list[str]:
    """OM 解析: ① 源仓 CLI (node 直驱, 离线确定) ② 技能 bin (npx 兜底)."""
    if OM_CLI.exists():
        return ["node", str(OM_CLI)]
    if OM_BIN.exists():
        return [str(OM_BIN)]
    raise SystemExit("[hf] OM 不可用: vendors CLI 与技能 bin 均缺失")


def run(cmd: list[str], timeout: int = 900, check: bool = True, cwd: Path | None = None) -> str:
    log("run", " ".join(str(c) for c in cmd[:6]) + (" …" if len(cmd) > 6 else ""))
    import os
    env = dict(os.environ, PATH=OM_ENV_PATH)     # om 子进程可见 ffprobe
    p = subprocess.run([str(c) for c in cmd], capture_output=True, text=True,
                       encoding="utf-8", errors="replace", timeout=timeout,
                       cwd=str(cwd) if cwd else None, env=env)
    if p.stdout.strip():
        print(p.stdout.rstrip()[-4000:])
    if p.returncode != 0:
        if p.stderr.strip():
            print(p.stderr.rstrip()[-2000:], file=sys.stderr)
        if check:
            raise SystemExit(f"[hf] 命令失败 rc={p.returncode}: {cmd[:3]}")
    return p.stdout


def load_entry(sku: str) -> dict:
    data = json.loads(REPORT_JSON.read_text(encoding="utf-8"))
    items = data.get("items") or data.get("reports") or []
    for it in items:
        if it.get("sku") == sku or it.get("id") == sku:
            return it
    raise SystemExit(f"[hf] report.json 无此 SKU: {sku}")


def find_promo(sku: str, entry: dict) -> Path | None:
    """找该 SKU 的上架宣传文 (promo/*launch*.md 最新且正文命中标题/SKU)."""
    title_key = re.sub(r"[《》:：\s]", "", entry.get("title", ""))[:12]
    sku_key = sku.lower().replace("-", "")
    cands = []
    for p in sorted(PROMO.glob("*.md"), reverse=True):
        if "launch" not in p.name.lower():
            continue
        body = p.read_text(encoding="utf-8", errors="ignore")
        if title_key and title_key in re.sub(r"[《》:：\s]", "", body):
            cands.append((2, p))
        elif sku_key in body.lower().replace("-", ""):
            cands.append((1, p))
    if not cands:
        return None
    cands.sort(key=lambda t: (t[0], t[1].name), reverse=True)
    return cands[0][1]


def generic_brief(sku: str, entry: dict, promo: Path | None) -> dict:
    """未在册 SKU: 从 report.json + 宣传文自动生成保底创意简报 (数字仍全出实料)."""
    badges = {b.get("k", ""): b.get("v", "") for b in entry.get("badges", [])}
    words = entry.get("words_wan") or re.search(r"([\d.]+)\s*万字", entry.get("subtitle", "") + str(badges))
    num_words = f"{words} 万字" if words else ""
    first_paras = ""
    if promo and promo.exists():
        text = promo.read_text(encoding="utf-8", errors="ignore")
        first_paras = " ".join(p.strip().replace("\n", "") for p in text.split("\n\n")[1:3])[:200]
    return {
        "palette": {"ink": "#0F2A43", "ink2": "#16385C", "brass": "#C9A876",
                    "paper": "#FAF7F2", "mut": "#8A8F98"},
        "kicker": "总包创研院 · 研究报告",
        "title_lines": [entry.get("title", sku).strip("《》")[:8],
                        entry.get("title", sku).strip("《》")[8:16] or sku],
        "subtitle": (entry.get("subtitle") or "")[:24],
        "meta": [m for m in [f"{len(entry.get('chapters', []))} 章", num_words,
                             badges.get("章节体量", "")[:10]] if m],
        "pot": {"label": "研究报告 · 今日上架", "num": entry.get("price", 0), "unit": "元 全本",
                "share_lead": "第 1 章免费试读", "share_sub": "微信搜「总包AI顾问」"},
        "hooks": [{"big": (promo.name[11:19] if promo else sku)[:10], "lead": first_paras[:18],
                   "sub": first_paras[18:44]}],
        "edge": {"head": "报告体量", "cn": f"{len(entry.get('chapters', []))} 章 · 逐章拆解",
                 "rev": badges.get("全书字数", "")[:30],
                 "bars": [("章节", 0.7, "brass"), ("附录", 0.3, "paper")]},
        "stats": [(str(len(entry.get("chapters", []))), "章", "逐章拆解"),
                  (str(entry.get("words_wan", "")), "万字", badges.get("全书字数", "")[:22]),
                  ("¥" + str(entry.get("price", "")), "", "全本定价 · 部分章节免费试读")],
        "markets": [],
        "end": {"price": entry.get("price_label", ""), "trial": entry.get("sample_label", "免费试读"),
                "qr_src": SITE_DIR / "assets" / "qr_wechat.png",
                "qr_note": "微信搜「总包AI顾问」", "credit": "总包创研院 出品"},
        "narration": (f"{entry.get('title', '')}，今天上架。" + first_paras[:150]
                      + f" 微信搜「总包AI顾问」，{entry.get('sample_label', '免费试读')}。"),
        "video": {"slug": f"{sku.lower().replace('_', '-')}_hm_v1",
                  "title": entry.get("title", sku).strip("《》")[:28],
                  "tags": ["EPC", "研究报告", "总包说"],
                  "desc": first_paras[:200]},
    }


# ---------------------------------------------------------------- composition (世界级封面审美 · 禁套 house style)

def composition_html(m: dict) -> str:
    """9:16 (1080x1920) 大字报研报宣传片. 手法: 海报级字排 + 数据冲击 + 剪刀差对比 + 真二维码收口.
    运动全走 transform (x/y/scale/scaleX/rotation), 契约: 变量/data-om-id/scene 标签/结尾 hold."""
    pal = m["palette"]
    qr = "assets/qr_wechat.png"
    hooks_js = json.dumps(m["hooks"], ensure_ascii=False)
    coins_js = json.dumps(m.get("coins", []), ensure_ascii=False)
    stats_js = json.dumps(m["stats"], ensure_ascii=False)
    markets_js = json.dumps(m["markets"], ensure_ascii=False)
    bars_js = json.dumps(m["edge"]["bars"], ensure_ascii=False)
    meta_js = json.dumps(m["meta"], ensure_ascii=False)
    title_js = json.dumps(m["title_lines"], ensure_ascii=False)

    return f"""<!doctype html>
<html lang="zh-CN" data-composition-variables='[
  {{"id":"kicker","type":"string","label":"眉题","default":"{m['kicker']}","group":"封面"}},
  {{"id":"titleLines","type":"string","label":"主标题两行(JSON)","default":{json.dumps(json.dumps(m['title_lines'], ensure_ascii=False), ensure_ascii=False)},"group":"封面"}},
  {{"id":"subtitle","type":"string","label":"副题","default":"{m['subtitle']}","group":"封面"}},
  {{"id":"potNum","type":"number","label":"主数字","default":{m['pot']['num']},"min":0,"max":99999,"step":1,"group":"数据"}},
  {{"id":"endHold","type":"number","label":"结尾停留(秒)","default":2.6,"min":0.5,"max":8,"step":0.1,"group":"节奏"}}
]' data-om-signature="off">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=1080, height=1920">
<title>{title_js[0]} · 宣传片</title>
<style id="om-fonts"></style>
<script src="vendor/gsap.min.js"></script>
<script src="vendor/om.js"></script>
<style>
  :root {{ --ink: {pal['ink']}; --ink2: {pal['ink2']}; --brass: {pal['brass']};
          --paper: {pal['paper']}; --mut: {pal['mut']}; }}
  html, body {{ margin: 0; width: 100%; height: 100%; overflow: hidden; background: var(--paper); }}
  #film {{ position: relative; width: 100%; height: 100%; overflow: hidden;
           background: var(--paper); color: var(--ink);
           font-family: "Noto Sans SC", sans-serif; font-weight: 500; }}
  .scene {{ position: absolute; inset: 0; opacity: 0; }}
  .paper {{ background:
      radial-gradient(1300px 800px at 15% 8%, #ffffffc8, transparent 62%),
      radial-gradient(1000px 700px at 92% 96%, #0f2a4312, transparent 60%), var(--paper); }}
  .ink {{ background:
      radial-gradient(1400px 900px at 85% 12%, #1d4570, transparent 64%),
      radial-gradient(900px 700px at 10% 92%, #0a1e32, transparent 62%), var(--ink);
      color: var(--paper); }}
  .grain {{ position: absolute; inset: 0; opacity: .5; pointer-events: none; }}

  /* ---- scene: poster (frame 0 = 海报, 全要素在场) ---- */
  #s-poster {{ display: block; opacity: 1; }}
  .brand {{ position: absolute; left: 96px; top: 176px; display: flex; align-items: center; gap: 22px;
            font-size: 30px; letter-spacing: 6px; opacity: .82; }}
  .brand .sq {{ width: 26px; height: 26px; background: var(--brass); }}
  .kick {{ position: absolute; left: 96px; top: 256px; font-size: 31px; letter-spacing: 13px;
           color: var(--ink); opacity: .66; }}
  .ttl {{ position: absolute; left: 88px; top: 368px; width: 904px; margin: 0;
          font-weight: 900; font-size: 176px; line-height: 1.06; letter-spacing: 2px; }}
  .ttl .l2 {{ color: var(--ink2); }}
  .rule {{ position: absolute; left: 96px; top: 830px; width: 520px; height: 12px;
           background: var(--brass); transform-origin: 0 50%; }}
  .sub {{ position: absolute; left: 96px; top: 884px; font-size: 58px; font-weight: 700;
          letter-spacing: 5px; color: var(--ink); opacity: .9; }}
  .meta {{ position: absolute; left: 96px; bottom: 190px; display: flex; gap: 20px; }}
  .meta .chip {{ padding: 16px 28px; border: 3px solid var(--ink2); font-size: 34px;
                font-weight: 700; letter-spacing: 2px; background: #ffffff90; }}
  .meta .chip b {{ color: var(--ink2); font-weight: 900; }}
  .yr {{ position: absolute; right: 84px; bottom: 120px; font-size: 120px; font-weight: 900;
         color: var(--brass); letter-spacing: 2px; opacity: .9; }}

  /* ---- scene: pot (墨蓝底 · 大数字) ---- */
  .pot-label {{ position: absolute; left: 96px; top: 420px; font-size: 36px; letter-spacing: 4px;
               opacity: .78; }}
  .pot-num {{ position: absolute; left: 74px; top: 540px; display: flex; align-items: baseline; gap: 18px; }}
  .pot-num .n {{ font-size: 318px; font-weight: 900; line-height: 1; letter-spacing: -8px;
                color: var(--brass); font-variant-numeric: tabular-nums; }}
  .pot-num .u {{ font-size: 74px; font-weight: 700; opacity: .92; }}
  .coins {{ position: absolute; left: 96px; top: 1090px; display: flex; gap: 26px; }}
  .coin {{ width: 120px; height: 120px; border: 4px solid #faF7F25e; background: #faF7F20f;
          display: flex; align-items: center; justify-content: center;
          font-size: 40px; font-weight: 800; color: #faF7F2b8; font-variant-numeric: tabular-nums; }}
  .coin.hot {{ background: var(--brass); border-color: var(--brass); color: var(--ink); }}
  .pot-lead {{ position: absolute; left: 96px; top: 1310px; font-size: 92px; font-weight: 900;
              letter-spacing: 3px; }}
  .pot-lead b {{ color: var(--brass); }}
  .pot-sub {{ position: absolute; left: 96px; top: 1445px; width: 880px; font-size: 40px;
             line-height: 1.65; opacity: .78; }}

  /* ---- scene: hooks (纸底 · 两张钩子卡) ---- */
  .hk {{ position: absolute; left: 96px; right: 96px; top: 420px; opacity: 0; }}
  .hk .tag {{ display: inline-block; padding: 12px 24px; background: var(--ink); color: var(--paper);
             font-size: 30px; letter-spacing: 6px; font-weight: 700; }}
  .hk .big {{ margin: 34px 0 0; font-size: 128px; font-weight: 900; line-height: 1.1;
             color: var(--ink2); letter-spacing: 1px; }}
  .hk .big em {{ font-style: normal; color: var(--brass); }}
  .hk .lead {{ margin: 26px 0 0; font-size: 66px; font-weight: 900; letter-spacing: 2px; }}
  .hk .sub {{ margin: 30px 0 0; font-family: "LXGW WenKai", "Noto Sans SC", serif;
             font-size: 40px; color: var(--mut); letter-spacing: 1px; }}
  .hk .cir {{ position: absolute; left: -30px; top: -32px; width: 216px; height: 122px;
             border: 7px solid var(--brass); border-radius: 48%; transform: rotate(-6deg); }}
  .hk2 {{ top: 1130px; }}

  /* ---- scene: edge (墨蓝底 · 剪刀差) ---- */
  .eg-head {{ position: absolute; left: 96px; top: 340px; font-size: 42px; font-weight: 700;
             letter-spacing: 3px; opacity: .85; }}
  .eg-cn {{ position: absolute; left: 96px; top: 440px; font-size: 84px; font-weight: 900; }}
  .eg-cn b {{ color: var(--brass); }}
  .eg-rev {{ position: absolute; left: 96px; top: 580px; width: 880px; font-size: 40px;
            line-height: 1.6; opacity: .82; }}
  .bars {{ position: absolute; left: 96px; right: 96px; top: 820px; }}
  .bar-lab {{ font-size: 38px; font-weight: 700; opacity: .9; margin-bottom: 14px; }}
  .bar-row {{ display: flex; align-items: center; gap: 24px; margin-bottom: 64px; }}
  .bar-track {{ flex: 1; height: 86px; background: #faF7F214; }}
  .bar-fill {{ width: 100%; height: 100%; transform-origin: 0 50%; }}
  .bar-fill.brass {{ background: var(--brass); }}
  .bar-fill.paper {{ background: var(--paper); }}
  .bar-num {{ min-width: 190px; font-size: 84px; font-weight: 900; font-variant-numeric: tabular-nums; }}
  .bar-num.brass {{ color: var(--brass); }}
  .eg-note {{ position: absolute; left: 96px; top: 1400px; font-family: "LXGW WenKai", serif;
             font-size: 44px; color: var(--brass); }}

  /* ---- scene: body (纸底 · 体量三行) ---- */
  .bd-head {{ position: absolute; left: 96px; top: 330px; font-size: 40px; letter-spacing: 6px;
             opacity: .68; }}
  .row {{ position: absolute; left: 96px; right: 96px; display: flex; align-items: baseline;
         gap: 26px; border-bottom: 4px solid #0f2a4322; padding-bottom: 26px; }}
  .row .n {{ font-size: 150px; font-weight: 900; color: var(--ink); line-height: 1;
            font-variant-numeric: tabular-nums; letter-spacing: -4px; }}
  .row .u {{ font-size: 52px; font-weight: 900; color: var(--ink2); }}
  .row .d {{ font-size: 35px; line-height: 1.5; color: var(--mut); margin-left: auto;
            max-width: 470px; text-align: right; }}
  .mkt {{ position: absolute; left: 96px; top: 1345px; }}
  .mkt .h {{ font-size: 40px; font-weight: 700; letter-spacing: 3px; margin-bottom: 30px; }}
  .mkt .chips {{ display: flex; flex-direction: column; gap: 24px; }}
  .mkt .chip {{ align-self: flex-start; padding: 18px 34px; background: var(--ink); color: var(--paper);
               font-size: 44px; font-weight: 700; letter-spacing: 3px; }}
  .hl {{ position: absolute; left: 96px; top: 1318px; width: 640px; height: 26px;
        background: #c9a87666; transform-origin: 0 50%; }}

  /* ---- scene: end (墨蓝底 · 收口) ---- */
  .e-kick {{ position: absolute; left: 96px; top: 330px; font-size: 30px; letter-spacing: 12px;
            opacity: .66; }}
  .e-ttl {{ position: absolute; left: 88px; top: 420px; width: 904px; font-size: 120px;
           font-weight: 900; line-height: 1.14; }}
  .e-ttl .l2 {{ color: var(--brass); }}
  .e-sub {{ position: absolute; left: 96px; top: 760px; font-size: 48px; font-weight: 700;
           letter-spacing: 4px; opacity: .88; }}
  .e-price {{ position: absolute; left: 96px; top: 900px; display: flex; gap: 24px; }}
  .e-price .p {{ padding: 20px 36px; background: var(--brass); color: var(--ink);
                font-size: 46px; font-weight: 900; }}
  .e-price .t {{ padding: 20px 36px; border: 3px solid #faF7F26e; font-size: 46px; font-weight: 700; }}
  .e-qr {{ position: absolute; left: 96px; top: 1120px; width: 300px; height: 300px;
          background: #ffffff; padding: 20px; }}
  .e-qr img {{ width: 100%; height: 100%; display: block; }}
  .e-qrnote {{ position: absolute; left: 524px; top: 1150px; width: 436px; font-size: 40px;
              line-height: 1.7; opacity: .88; }}
  .e-credit {{ position: absolute; left: 96px; bottom: 130px; font-size: 32px;
              letter-spacing: 6px; opacity: .6; }}
</style>
</head>
<body>
<div id="film" data-composition-id="film" data-width="1080" data-height="1920">
  <audio id="om-voice"></audio>

  <!-- ① 封面海报 (frame 0 全要素在场) -->
  <section class="scene paper" id="s-poster" data-om-id="poster">
    <div class="brand" data-om-id="brand"><span class="sq"></span>总包创研院</div>
    <div class="kick" data-om-id="kicker" data-var-text="kicker">{m['kicker']}</div>
    <h1 class="ttl" data-om-id="title" data-om-var="titleLines"></h1>
    <div class="rule" data-om-id="rule"></div>
    <div class="sub" data-om-id="subtitle" data-var-text="subtitle">{m['subtitle']}</div>
    <div class="meta" data-om-id="meta"></div>
    <div class="yr" data-om-id="yr">2026</div>
  </section>

  <!-- ② 3000亿美元 · 电力占两成 -->
  <section class="scene ink" id="s-pot" data-om-id="pot">
    <div class="pot-label" data-om-id="pot-label">{m['pot']['label']}</div>
    <div class="pot-num" data-om-id="pot-num"><span class="n" id="pot-n">0</span><span class="u">{m['pot']['unit']}</span></div>
    <div class="coins" data-om-id="coins" id="coins-wrap"></div>
    <div class="pot-lead" data-om-id="pot-lead">{m['pot']['share_lead']}</div>
    <div class="pot-sub" data-om-id="pot-sub">{m['pot']['share_sub']}</div>
  </section>

  <!-- ③ 两张钩子卡 -->
  <section class="scene paper" id="s-hooks" data-om-id="hooks">
    <article class="hk" id="hk-a" data-om-id="hook-a"></article>
    <article class="hk hk2" id="hk-b" data-om-id="hook-b"></article>
  </section>

  <!-- ④ ENR 剪刀差 -->
  <section class="scene ink" id="s-edge" data-om-id="edge">
    <div class="eg-head" data-om-id="eg-head">{m['edge']['head']}</div>
    <div class="eg-cn" data-om-id="eg-cn">{m['edge']['cn']}</div>
    <div class="eg-rev" data-om-id="eg-rev">{m['edge']['rev']}</div>
    <div class="bars" data-om-id="bars">
      <div class="bar-lab" id="bar-lab-a"></div>
      <div class="bar-row"><div class="bar-track"><div class="bar-fill brass" id="bar-a"></div></div>
        <div class="bar-num brass" id="bar-n-a">0%</div></div>
      <div class="bar-lab" id="bar-lab-b"></div>
      <div class="bar-row"><div class="bar-track"><div class="bar-fill paper" id="bar-b"></div></div>
        <div class="bar-num" id="bar-n-b">0%</div></div>
    </div>
    <div class="eg-note" data-om-id="eg-note">{m['edge'].get('note', '')}</div>
  </section>

  <!-- ⑤ 体量三行 + 市场三卷 -->
  <section class="scene paper" id="s-body" data-om-id="body">
    <div class="bd-head" data-om-id="bd-head">成书体量 · 实测口径</div>
    <div class="row" id="row-0" style="top:430px"></div>
    <div class="row" id="row-1" style="top:700px"></div>
    <div class="row" id="row-2" style="top:970px"></div>
    <div class="hl" id="hl"></div>
    <div class="mkt" data-om-id="markets">
      <div class="h">{m.get('markets_head', '')}</div>
      <div class="chips" id="mkt-chips"></div>
    </div>
  </section>

  <!-- ⑥ 收口 -->
  <section class="scene ink" id="s-end" data-om-id="end">
    <div class="e-kick" data-var-text="kicker">{m['kicker']}</div>
    <h2 class="e-ttl" data-om-id="e-title" id="e-ttl"></h2>
    <div class="e-sub" data-om-id="e-sub">{m['subtitle']}</div>
    <div class="e-price" data-om-id="e-price">
      <span class="p">{m['end']['price']}</span><span class="t">{m['end']['trial']}</span>
    </div>
    <div class="e-qr" data-om-id="e-qr"><img src="{qr}" alt="qr"></div>
    <div class="e-qrnote" data-om-id="e-qrnote">{m['end']['qr_note']}<br>报告详情 · 全本目录</div>
    <div class="e-credit" data-om-id="e-credit">{m['end']['credit']}</div>
  </section>
</div>

<script>
  const V = OM.vars();
  const esc = (s) => String(s).replace(/[&<>"]/g, (c) => ({{'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}}[c]));

  // 封面标题 (两行, 逐字可指)
  const ttl = document.querySelector('.ttl');
  const lines = JSON.parse(V.titleLines);
  ttl.innerHTML = lines.map((ln, i) =>
    `<div class="${{i ? 'l2' : ''}}" data-om-id="title-l${{i}}">${{esc(ln)}}</div>`).join('');

  // 收口标题 (两行, 与封面同源 titleLines)
  document.getElementById('e-ttl').innerHTML = lines.map((ln, i) =>
    `<div class="${{i ? 'l2' : ''}}" data-om-id="e-title-l${{i}}">${{esc(ln)}}</div>`).join('<br>');

  // meta 徽条
  const META = {meta_js};
  document.querySelector('.meta').innerHTML = META.map((x) => `<span class="chip"><b>${{x}}</b></span>`).join('');

  // 硬币格 (data 驱动: OVERSEAS 传 [1,2,3,4,5]; JIAGE 等无此隐喻 → 空数组隐藏)
  const COINS = {coins_js};
  const coinsWrap = document.getElementById('coins-wrap');
  if (COINS.length) {{
    COINS.forEach((c, i) => coinsWrap.insertAdjacentHTML('beforeend',
      `<span class="coin${{i === COINS.length - 1 ? ' hot' : ''}}" id="coin-${{i}}">${{c}}</span>`));
  }} else {{
    coinsWrap.style.display = 'none';
  }}

  // 钩子卡
  const HOOKS = {hooks_js};
  const hkHtml = (h, accent) => `
    <span class="tag">${{esc(h.tag || '')}}</span>
    <div class="cir" data-om-id="cir-${{accent}}"></div>
    <div class="big">${{esc(h.big)}}</div>
    <div class="lead">${{esc(h.lead)}}</div>
    <div class="sub">${{esc(h.sub)}}</div>`;
  HOOKS.forEach((h, i) => {{
    const el = document.getElementById(i ? 'hk-b' : 'hk-a');
    h.tag = i ? '钩子 二' : '钩子 一';
    el.innerHTML = hkHtml(h, i ? 'b' : 'a');
  }});

  // 剪刀差条
  const BARS = {bars_js};
  document.getElementById('bar-lab-a').textContent = BARS[0][0];
  document.getElementById('bar-lab-b').textContent = BARS[1][0];

  // 体量三行
  const STATS = {stats_js};
  STATS.forEach((s, i) => {{
    document.getElementById('row-' + i).innerHTML =
      `<span class="n">${{esc(s[0])}}</span><span class="u">${{esc(s[1])}}</span><span class="d">${{esc(s[2])}}</span>`;
  }});

  // 市场三卷
  const MKT = {markets_js};
  document.getElementById('mkt-chips').innerHTML =
    MKT.map((x, i) => `<span class="chip" id="mkt-${{i}}">${{esc(x)}}</span>`).join('');

  const tl = gsap.timeline({{ paused: true, defaults: {{ ease: 'power3.out' }} }});

  /* ① 海报 0 → 3.9 (frame0 即成片海报: 推近+元素落位+入切爬推, 开场即动) */
  tl.addLabel('scene:poster', 0)
    .fromTo('#s-poster', {{ scale: .93 }}, {{ scale: 1, duration: 1.6, ease: 'expo.out' }}, 0)
    .fromTo('.rule', {{ scaleX: 0 }}, {{ scaleX: 1, duration: .8, ease: 'expo.inOut' }}, .5)
    .fromTo('.meta .chip', {{ y: 18 }}, {{ y: 0, duration: .55, stagger: .12, ease: 'back.out(1.8)' }}, .35)
    .fromTo('.yr', {{ opacity: 0, x: 60 }}, {{ opacity: .9, x: 0, duration: .7 }}, .7)
    .to('#s-poster', {{ scale: 1.035, duration: 1.9, ease: 'power1.in' }}, 2.0)

  OM.sfx('impact', .12);
  OM.sfx('draw', .5, {{ dur: .7 }});
  OM.sfx('tick', .35);
  OM.sfx('whoosh', 3.9);

  tl.to('#s-poster', {{ opacity: 0, duration: .32, ease: 'power2.in' }}, 3.58);

  /* ② 3000亿 3.9 → 10.7 */
  const pot = {{ v: 0 }};
  tl.addLabel('scene:pot', 3.9)
    .fromTo('#s-pot', {{ opacity: 0 }}, {{ opacity: 1, duration: .3 }}, 3.9)
    .fromTo('.pot-label', {{ opacity: 0, x: -30 }}, {{ opacity: .78, x: 0, duration: .6 }}, 4.0)
    .fromTo('.pot-num', {{ opacity: 0, y: 50 }}, {{ opacity: 1, y: 0, duration: .7 }}, 4.15)
    .fromTo(pot, {{ v: 0 }}, {{ v: V.potNum, duration: 2.3, ease: 'expo.out',
        onUpdate: () => {{ document.getElementById('pot-n').textContent = Math.round(pot.v); }} }}, 4.45)
    .fromTo('.coin', {{ opacity: 0, scale: .5 }}, {{ opacity: 1, scale: 1, duration: .45, stagger: .10, ease: 'back.out(2)' }}, 7.3)
    .fromTo('#coin-4', {{ scale: 1 }}, {{ scale: 1.22, duration: .3, ease: 'back.out(3)' }}, 8.25)
    .fromTo('.pot-lead', {{ opacity: 0, y: 60 }}, {{ opacity: 1, y: 0, duration: .6 }}, 8.45)
    .fromTo('.pot-sub', {{ opacity: 0, y: 30 }}, {{ opacity: .78, y: 0, duration: .6 }}, 8.95)
    .to('#s-pot', {{ opacity: 0, scale: .97, duration: .32, ease: 'power2.in' }}, 10.38);

  OM.sfx('count', 4.45, {{ dur: 2.3 }});
  OM.sfx('tick', 7.3);
  OM.sfx('thud', 8.25);
  OM.sfx('whoosh', 10.7);

  /* ③ 钩子卡 10.7 → 21.2 */
  tl.addLabel('scene:hooks', 10.7)
    .fromTo('#s-hooks', {{ opacity: 0 }}, {{ opacity: 1, duration: .3 }}, 10.7)
    .fromTo('#hk-a', {{ opacity: 0, y: 80 }}, {{ opacity: 1, y: 0, duration: .7, ease: 'expo.out' }}, 10.85)
    .fromTo('#hk-a .cir', {{ scale: 0, rotation: -40 }}, {{ scale: 1, rotation: -7, duration: .6, ease: 'back.out(2.2)' }}, 12.05)
    .to('#hk-a', {{ opacity: 0, y: -60, duration: .35, ease: 'power2.in' }}, 15.5)
    .fromTo('#hk-b', {{ opacity: 0, y: 80 }}, {{ opacity: 1, y: 0, duration: .7, ease: 'expo.out' }}, 15.85)
    .fromTo('#hk-b .cir', {{ scale: 0, rotation: -40 }}, {{ scale: 1, rotation: -7, duration: .6, ease: 'back.out(2.2)' }}, 17.05)
    .to('#s-hooks', {{ opacity: 0, scale: .97, duration: .32, ease: 'power2.in' }}, 20.85);

  OM.sfx('stamp', 10.85);
  OM.sfx('draw', 12.05, {{ dur: .5 }});
  OM.sfx('whip', 15.5);
  OM.sfx('stamp', 15.85);
  OM.sfx('draw', 17.05, {{ dur: .5 }});
  OM.sfx('whoosh', 21.2);

  /* ④ 剪刀差 21.2 → 29.0 */
  const bA = {{ v: 0 }}, bB = {{ v: 0 }};
  tl.addLabel('scene:edge', 21.2)
    .fromTo('#s-edge', {{ opacity: 0 }}, {{ opacity: 1, duration: .3 }}, 21.2)
    .fromTo('.eg-head', {{ opacity: 0, y: -24 }}, {{ opacity: .85, y: 0, duration: .55 }}, 21.3)
    .fromTo('.eg-cn', {{ opacity: 0, y: 50 }}, {{ opacity: 1, y: 0, duration: .6 }}, 21.6)
    .fromTo('.eg-rev', {{ opacity: 0 }}, {{ opacity: .82, duration: .6 }}, 22.1)
    .fromTo('.bars', {{ opacity: 0 }}, {{ opacity: 1, duration: .35 }}, 23.0)
    .fromTo('#bar-a', {{ scaleX: 0 }}, {{ scaleX: {bars_js}[0][2], duration: 1.0, ease: 'expo.out' }}, 23.1)
    .fromTo(bA, {{ v: 0 }}, {{ v: parseFloat(BARS[0][1]) || 0, duration: 1.0, ease: 'expo.out',
        onUpdate: () => {{ const va = parseFloat(BARS[0][1]) || 0; document.getElementById('bar-n-a').textContent = (va % 1 ? bA.v.toFixed(1) : Math.round(bA.v)) + (BARS[0][1].includes('%') ? '%' : ''); }} }}, 23.1)
    .fromTo('#bar-b', {{ scaleX: 0 }}, {{ scaleX: {bars_js}[1][2], duration: 1.3, ease: 'expo.out' }}, 24.3)
    .fromTo(bB, {{ v: 0 }}, {{ v: parseFloat(BARS[1][1]) || 0, duration: 1.3, ease: 'expo.out',
        onUpdate: () => {{ const vb = parseFloat(BARS[1][1]) || 0; document.getElementById('bar-n-b').textContent = (vb % 1 ? bB.v.toFixed(1) : Math.round(bB.v)) + (BARS[1][1].includes('%') ? '%' : ''); }} }}, 24.3)
    .fromTo('.eg-note', {{ opacity: 0, x: -40 }}, {{ opacity: 1, x: 0, duration: .7 }}, 26.1)
    .to('#s-edge', {{ opacity: 0, scale: 1.03, duration: .32, ease: 'power2.in' }}, 28.68);

  OM.sfx('tick', 21.6);
  OM.sfx('riser', 23.0, {{ dur: 1.1 }});
  OM.sfx('thud', 24.3);
  OM.sfx('sparkle', 26.1);
  OM.sfx('whoosh', 29.0);

  /* ⑤ 体量 + 三卷 29.0 → 35.6 */
  tl.addLabel('scene:body', 29.0)
    .fromTo('#s-body', {{ opacity: 0 }}, {{ opacity: 1, duration: .3 }}, 29.0)
    .fromTo('.bd-head', {{ opacity: 0, y: -20 }}, {{ opacity: .68, y: 0, duration: .5 }}, 29.1);
  ['#row-0', '#row-1', '#row-2'].forEach((id, i) => {{
    tl.fromTo(id, {{ opacity: 0, y: 60 }}, {{ opacity: 1, y: 0, duration: .6, ease: 'expo.out' }}, 29.35 + i * .8);
  }});
  tl.fromTo('#hl', {{ scaleX: 0 }}, {{ scaleX: 1, duration: .55, ease: 'power2.inOut' }}, 32.5)
    .fromTo('.mkt', {{ opacity: 0 }}, {{ opacity: 1, duration: .35 }}, 33.15)
    .fromTo('.mkt .chip', {{ opacity: 0, x: -60 }}, {{ opacity: 1, x: 0, duration: .5, stagger: .16, ease: 'expo.out' }}, 33.3)
    .to('#s-body', {{ opacity: 0, scale: .97, duration: .32, ease: 'power2.in' }}, 35.28);

  OM.sfx('paper', 29.35); OM.sfx('paper', 30.15); OM.sfx('paper', 30.95);
  OM.sfx('draw', 32.5, {{ dur: .5 }});
  OM.sfx('pop', 33.3); OM.sfx('pop', 33.46); OM.sfx('pop', 33.62);
  OM.sfx('whoosh', 35.6);

  /* ⑥ 收口 35.6 → endHold */
  tl.addLabel('scene:end', 35.6)
    .fromTo('#s-end', {{ opacity: 0 }}, {{ opacity: 1, duration: .35 }}, 35.6)
    .fromTo('.e-ttl', {{ opacity: 0, y: 70 }}, {{ opacity: 1, y: 0, duration: .8, ease: 'expo.out' }}, 35.75)
    .fromTo('.e-sub', {{ opacity: 0, y: 30 }}, {{ opacity: .88, y: 0, duration: .6 }}, 36.15)
    .fromTo('.e-price .p', {{ opacity: 0, scale: .6 }}, {{ opacity: 1, scale: 1, duration: .5, ease: 'back.out(2.5)' }}, 36.55)
    .fromTo('.e-price .t', {{ opacity: 0, x: 40 }}, {{ opacity: 1, x: 0, duration: .55 }}, 36.8)
    .fromTo('.e-qr', {{ opacity: 0, y: 60, rotation: -3 }}, {{ opacity: 1, y: 0, rotation: 0, duration: .7, ease: 'expo.out' }}, 37.15)
    .fromTo('.e-qrnote', {{ opacity: 0, x: 40 }}, {{ opacity: .88, x: 0, duration: .6 }}, 37.5)
    .fromTo('.e-credit', {{ opacity: 0 }}, {{ opacity: .6, duration: .7 }}, 37.9)
    .to({{}}, {{ duration: V.endHold }});   // 结尾停留

  OM.sfx('chime', 35.75);
  OM.sfx('ding', 36.55);
  OM.sfx('shutter', 37.15);

  OM.music({{ product: 'ai', drop: 'scene:pot' }});   // 床乐+爆发点(3000亿落位), om sound 合成; 自动 duck 至人声之下
  window.__timelines['film'] = tl;
</script>
</body>
</html>
"""


# ---------------------------------------------------------------- 阶段件

def stage_material(film: Path, m: dict, sku: str) -> None:
    film.mkdir(parents=True, exist_ok=True)
    om = om_cmd()
    if not (film / "index.html").exists():
        run(om + ["new", str(film)], cwd=STATION)
    # 材料包: 官网详情页优先, 探活失败落回本地真身 site/ (色板+二维码均在此)
    page = f"{sku.lower()}.html"
    grabbed = None
    import urllib.request
    for url in (SITE_URL.format(page=page), SITE_URL.format(page="")):
        try:
            with urllib.request.urlopen(url, timeout=6) as r:
                if r.status == 200:
                    grabbed = url
                    break
        except OSError:
            continue
    src = grabbed or str(SITE_DIR)
    log("grab", f"材料源: {src}")
    run(om + ["grab", src, str(film)], timeout=300, cwd=STATION, check=False)
    # 组合 (覆写 starter — 契约齐备的自制片, 禁套 house style)
    (film / "index.html").write_text(composition_html(m), encoding="utf-8", newline="\n")
    # 本地库: om.js 运行时 + 二维码真件
    vdir = film / "vendor"
    vdir.mkdir(exist_ok=True)
    shutil.copyfile(OM_RUNTIME, vdir / "om.js")
    qr_src = Path(m["end"]["qr_src"])
    if qr_src.exists():
        adir = film / "assets"
        adir.mkdir(exist_ok=True)
        shutil.copyfile(qr_src, adir / "qr_wechat.png")
    # 字体 (注入 <style id="om-fonts">)
    run(om + ["fonts", "add", "Noto Sans SC", str(film)], cwd=STATION)
    run(om + ["fonts", "add", "LXGW WenKai", str(film)], cwd=STATION, check=False)
    log("material", f"OK → {film}")


def stage_voice(film: Path, m: dict) -> float:
    work = film / "work"
    work.mkdir(exist_ok=True)
    script = work / "script.txt"
    script.write_text(m["narration"], encoding="utf-8")
    best, best_mp3 = None, None
    for rate in ("+14%", "+8%", "+20%"):
        mp3 = work / f"narration_{rate[1:3]}.mp3"
        run(["py", "-m", "edge_tts", "--voice", EDGE_VOICE, "--rate", rate,
             "--file", str(script), "--write-media", str(mp3)], timeout=180, check=False)
        if not mp3.exists():
            continue
        p = subprocess.run([FFMPEG, "-i", str(mp3)], capture_output=True, text=True,
                           encoding="utf-8", errors="replace")
        mt = re.search(r"Duration:\s*(\d+):(\d+):(\d+)\.(\d+)", p.stderr or "")
        if not mt:
            continue
        secs = int(mt.group(1)) * 3600 + int(mt.group(2)) * 60 + int(mt.group(3)) + int(mt.group(4)) / 100
        log("tts", f"rate={rate} → {secs:.1f}s")
        best, best_mp3 = (secs, mp3)
        if secs <= 39.0:      # 片长约 41s, 口播收在 39s 内留收口余量
            break
    if best is None:
        raise SystemExit("[hf] edge-tts 配音失败 (无产物)")
    final = work / "narration.mp3"
    shutil.copyfile(best_mp3, final)
    # om voice: 真录音 + 讲稿 → 词级 cues + srt (静音对齐, 免 whisper)
    run(om_cmd() + ["voice", str(film), "--audio", str(final),
                    "--text", str(script), "--asr", "off"], timeout=300, cwd=STATION)
    log("voice", f"OK {best:.1f}s → assets/voice.wav + srt")
    return best


def stage_render(film: Path, m: dict) -> Path:
    om = om_cmd()
    run(om + ["check", str(film), "--samples", "12"], timeout=600, cwd=STATION)
    run(om + ["render", str(film), "--blur"], timeout=1800, cwd=STATION)
    outs = sorted((film / "out").glob("*.mp4"), key=lambda p: p.stat().st_mtime)
    if not outs:
        raise SystemExit("[hf] render 无 mp4 产物")
    mp4 = outs[-1]
    log("render", f"OK → {mp4.name} ({mp4.stat().st_size // 1024} KB)")
    return mp4


def chrome_hygiene() -> None:
    """渲染 Chrome 用完即清: 只清 om 自起实例 (临时 profile 含 huashu 路径), 绝不碰 9222."""
    try:
        wmic = subprocess.run(
            ["wmic", "process", "where", "name='chrome.exe'", "get", "ProcessId,CommandLine"],
            capture_output=True, text=True, timeout=30)
        orphans = []
        for line in wmic.stdout.splitlines():
            if "huashu" in line.lower() and "chrome.exe" in line.lower():
                pid = re.search(r"(\d+)\s*$", line.strip())
                if pid:
                    orphans.append(pid.group(1))
        for pid in orphans:
            subprocess.run(["taskkill", "/PID", pid, "/F", "/T"], capture_output=True, timeout=20)
        log("chrome", f"om 残留实例清理: {len(orphans)} 个" + (f" ({','.join(orphans)})" if orphans else ""))
    except OSError as e:
        log("chrome", f"巡检跳过: {e}")


def stage_qa(film: Path) -> str:
    out = run(om_cmd() + ["qa", str(film)], timeout=600, cwd=STATION, check=False)
    chrome_hygiene()
    return out


def stage_register(sku: str, m: dict, mp4: Path) -> Path:
    slug = m["video"]["slug"]
    VIDEOS.mkdir(exist_ok=True)
    dst = VIDEOS / f"{slug}.mp4"
    shutil.copyfile(mp4, dst)
    (VIDEOS / f"{slug}.json").write_text(
        json.dumps({"title": m["video"]["title"], "tags": m["video"]["tags"],
                    "desc": m["video"]["desc"], "sku": sku, "src": "huashu_film"},
                   ensure_ascii=False, indent=1), encoding="utf-8")
    rec = {"ts": time.strftime("%Y-%m-%d %H:%M:%S"), "ts_epoch": int(time.time()),
           "date": time.strftime("%Y-%m-%d"), "title": m["video"]["title"],
           "title_hash": hashlib.sha256(m["video"]["title"].encode()).hexdigest()[:12],
           "account": "总包说", "sku": sku, "src": "hm", "media_id": slug}
    with LEDGER.open("a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")
    log("register", f"release chain 已登记: videos/{slug}.mp4 + promo_ledger src=hm")
    return dst


def stage_publish(sku: str, m: dict) -> None:
    if not WEAIPO_PY.exists():
        log("publish", f"登录态执行件缺: {WEAIPO_PY} — 如实记录, 待补")
        return
    slug = m["video"]["slug"]
    base = ["-X", "utf8", str(PROMO / "video_upload.py"), "--slug", slug]
    dry = subprocess.run([str(WEAIPO_PY)] + base, capture_output=True, text=True,
                         encoding="utf-8", errors="replace", timeout=300, cwd=str(PROMO))
    print(dry.stdout.strip()[-1500:])
    if dry.returncode != 0:
        log("publish", f"dry-run 预检未过 rc={dry.returncode} — 如实记录待扫码/待重试")
        return
    go = subprocess.run([str(WEAIPO_PY)] + base + ["--go"], capture_output=True, text=True,
                        encoding="utf-8", errors="replace", timeout=900, cwd=str(PROMO))
    print((go.stdout or "")[-3000:])
    if go.returncode != 0:
        print((go.stderr or "")[-1500:], file=sys.stderr)
        log("publish", "上传失败/登录态死 — 如实记录待扫码, 不硬闯")
    else:
        log("publish", f"已交 video_upload --go (slug={slug}), 详见上方输出与 promo_ledger sph 记录")


# ---------------------------------------------------------------- main

def main() -> int:
    ap = argparse.ArgumentParser(description="研究报告宣传片 huashu-motion 驱动器")
    ap.add_argument("--report", help="SKU, 如 OVERSEAS-2026")
    ap.add_argument("--stage", default="all",
                    choices=["all", "material", "voice", "sound", "check", "render", "qa", "register"])
    ap.add_argument("--publish", action="store_true", help="视频号上传 (video_upload.py)")
    ap.add_argument("--list", action="store_true", help="在册创意简报")
    ns = ap.parse_args()

    if ns.list:
        for k, v in CREATIVE.items():
            print(k, "→", v["video"]["slug"], "|", v["video"]["title"])
        return 0
    if not ns.report:
        ap.error("需 --report <SKU> (或 --list)")

    entry = load_entry(ns.report)
    brief = CREATIVE.get(ns.report) or generic_brief(ns.report, entry, find_promo(ns.report, entry))
    if ns.report not in CREATIVE:
        log("creative", f"{ns.report} 无在册简报, 已按 report.json+宣传文生成保底简报")
    film = FILMS / f"{ns.report}_hm"
    log("sku", f"{ns.report} 《{entry['title'].strip('《》')}》 → {film}")

    mp4: Path | None = None
    stage = ns.stage
    if stage in ("all", "material"):
        stage_material(film, brief, ns.report)
    if stage in ("all", "voice"):
        stage_voice(film, brief)
    if stage in ("all", "sound", "check", "render"):
        run(om_cmd() + ["sound", str(film)], timeout=600, cwd=STATION, check=False)
    if stage in ("all", "check"):
        run(om_cmd() + ["check", str(film), "--samples", "12"], timeout=600, cwd=STATION)
    if stage in ("all", "render"):
        mp4 = stage_render(film, brief)
    if stage in ("all", "qa"):
        stage_qa(film)
    if stage in ("all", "register") and (mp4 or (film / "out").glob("*.mp4")):
        outs = sorted((film / "out").glob("*.mp4"), key=lambda p: p.stat().st_mtime)
        stage_register(ns.report, brief, mp4 or outs[-1])
    if ns.publish:
        stage_publish(ns.report, brief)

    log("done", f"stage={stage} film={film}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
