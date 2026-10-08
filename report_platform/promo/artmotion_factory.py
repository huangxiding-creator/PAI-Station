# -*- coding: utf-8 -*-
"""artmotion_factory — huashu-art-motion 引擎生产线 (F5b 视频腿 v2).

用户令 1008: 「请下载这个开源项目，帮助制作研究报告的宣传视频」.
升级 video_factory 静态卡车道 → Canvas 代码动画车道 (画面必须动):

  选题卡 (本文件 ARTCARDS, 只管画面/节奏)
    → y5_kinetic_type spec JSON (竖屏 1080×1920@30, 品牌色 墨蓝×铜金,
      cue 家族 title/point/number/highlight, 视频号 UI safe 区)
    → render.py --spec (Chromium 逐帧渲 canvas → ffmpeg H.264)
    → videos/<slug>_am.mp4 + 伴生 meta json (video_upload.py 消费)

文案 (title/desc/tags) 复用 video_factory.CARDS — 单一事实源, 不另抄一份.

用法 (任意 py3, 渲染子进程自动用 We-AIPO venv playwright):
  python -X utf8 promo/artmotion_factory.py list
  python -X utf8 promo/artmotion_factory.py make --slug cnnec_v1
  python -X utf8 promo/artmotion_factory.py qa   --slug cnnec_v1
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PROMO = Path(__file__).resolve().parent
sys.path.insert(0, str(PROMO))
from video_factory import CARDS as META_CARDS  # noqa: E402

OUT_DIR = PROMO / "videos"
ENGINE = Path(r"E:\AI-Station\_vendors\huashu-art-motion\scripts\engine")
VENV_PY = Path(r"E:\CPOPC\We-AIPO\.venv\Scripts\python.exe")  # playwright 在这

# 品牌色 (video_factory 同款): 墨蓝×铜金×纸白 — 每页换底色, 色彩即章节号
PAL = [["#0F2A43", "#FAF7F2"],   # 墨蓝底 纸白字
       ["#C9A876", "#0F2A43"],   # 铜金底 墨蓝字
       ["#16385C", "#C9A876"],   # 深藏青 铜金字
       ["#FAF7F2", "#0F2A43"]]   # 纸白底 墨蓝字

# 视频号竖屏 UI safe: 底部文案/互动栏让开
SAFE = {"top": 140, "bottom": 420}


def _tail_card(brand_label: str) -> list[dict]:
    """收尾 CTA 两页 (所有选题共用): 免费试读 + 荧光笔点「试读」.
    审片必修: 给可执行路径 (视频号头像点关注 + 公众号可搜), 不止口号."""
    return [
        {"at": 13.5, "kind": "point", "text": "免费试读",
         "sub": "点关注 · 公众号搜「总包智库」", "data": {"label": brand_label,
                                                     "key": "总包智库"}},
        {"at": 14.6, "kind": "highlight", "data": {"word": "试读"}},
    ]


# 画面卡: slug → y5 spec (grammar/duration/cues). 主词 ≤6 字 (0.3s 读完,
# 辅句 ≤14 字 (2 行内), number 页一数一镜头; at=主词砸下那一帧.
# ⚠ highlight 语法 (y5_kinetic_type.js L34 实证): word 必须出现在 11.9 时点
# 「当前页」(=10.8 页) 的主词里, 引擎只扫当前页主词, 缺词=console.warn 空拍
# (1008 ent22/prov07 两片实锤过此坑); key 只染辅句, 须 key∈辅句.
ARTCARDS: dict[str, dict] = {
    "cnnec_v1": {
        "duration": 16.5,
        "cues": [
            {"at": 0.0, "kind": "title", "text": "全国只有一家",
             "sub": "能总承包整座核电站", "data": {"label": "深度研报"}},
            {"at": 2.7, "kind": "point", "text": "四项全能",
             "sub": "设计·采购·施工·调试",
             "data": {"label": "能力 01"}},
            {"at": 5.4, "kind": "number",
             "sub": "核电EPC全链条一手拆解",
             "data": {"value": 1600, "suffix": " 份资料", "label": "一手资料"}},
            {"at": 8.1, "kind": "point", "text": "华龙一号",
             "sub": "首堆就是这么干成的",
             "data": {"label": "实战 01", "key": "首堆"}},
            {"at": 10.8, "kind": "point", "text": "拆成14章",
             "sub": "15.6万字深度研报",
             "data": {"label": "成果", "key": "15.6万字"}},
            {"at": 11.9, "kind": "highlight", "data": {"word": "14章"}},
            *_tail_card("试读入口"),
        ],
    },
    "fengcheng_v1": {
        "duration": 16.5,
        "cues": [
            {"at": 0.0, "kind": "title", "text": "73人遇难",
             "sub": "不是意外，是基因缺陷", "data": {"label": "事故复盘"}},
            {"at": 2.7, "kind": "point", "text": "责任碎片化",
             "sub": "人人都负责=没人负责",
             "data": {"label": "黑洞 01", "key": "没人负责"}},
            {"at": 5.4, "kind": "number",
             "sub": "丰城电厂11·24冷却塔",
             "data": {"value": 1.02, "decimals": 2, "suffix": " 亿损失",
                      "label": "案情"}},
            {"at": 8.1, "kind": "point", "text": "三个黑洞",
             "sub": "模式基因缺陷全拆解",
             "data": {"label": "拆解 01", "key": "全拆解"}},
            {"at": 10.8, "kind": "point", "text": "30章沉思录",
             "sub": "最弱势的人敢不敢说停",
             "data": {"label": "成果", "key": "说停"}},
            {"at": 11.9, "kind": "highlight", "data": {"word": "30章"}},
            *_tail_card("试读入口"),
        ],
    },
    # 1008 续队: 中建三局 (ENT-22 在稿实锤: 火神山雷神山/三天一层楼/
    # 铁军执行力/地标制造; number=11.1万字徽章)
    "ent22_v1": {
        "duration": 16.5,
        "cues": [
            {"at": 0.0, "kind": "title", "text": "火神山",
             "sub": "雷神山背后的建设铁军", "data": {"label": "深度研报"}},
            {"at": 2.7, "kind": "point", "text": "三天一层楼",
             "sub": "深圳速度的起源",
             "data": {"label": "基因 01", "key": "深圳速度"}},
            {"at": 5.4, "kind": "number",
             "sub": "12章拆解中建三局EPC",
             "data": {"value": 11.1, "decimals": 1, "suffix": " 万字",
                      "label": "拆解深度"}},
            {"at": 8.1, "kind": "point", "text": "地标制造机",
             "sub": "上海环球金融中心·深圳平安",
             "data": {"label": "业绩", "key": "深圳平安"}},
            {"at": 10.8, "kind": "point", "text": "铁军执行力",
             "sub": "急难险重里怎么打胜仗",
             "data": {"label": "打法 01", "key": "打胜仗"}},
            {"at": 11.9, "kind": "highlight", "data": {"word": "铁军"}},
            *_tail_card("试读入口"),
        ],
    },
    # 1008 续队: 湖南省卷 (在售单册字数第一 38.6万字; 454页/20章徽章;
    # 受众线=页内原文「省内建企/进场央国企/投资机构」)
    "prov07_v1": {
        "duration": 16.5,
        "cues": [
            {"at": 0.0, "kind": "title", "text": "38.6万字",
             "sub": "写透一个省的EPC市场", "data": {"label": "省份市场"}},
            {"at": 2.7, "kind": "point", "text": "机会在哪",
             "sub": "未来五年怎么走",
             "data": {"label": "问题 01", "key": "五年"}},
            {"at": 5.4, "kind": "number",
             "sub": "湖南EPC全景一册装下",
             "data": {"value": 454, "suffix": " 页", "label": "体量"}},
            {"at": 8.1, "kind": "point", "text": "在湖南干工程",
             "sub": "这份值得看",
             "data": {"label": "读者", "key": "值得看"}},
            {"at": 10.8, "kind": "point", "text": "20章拆解",
             "sub": "机会与打法全图谱",
             "data": {"label": "结构", "key": "全图谱"}},
            {"at": 11.9, "kind": "highlight", "data": {"word": "20章"}},
            *_tail_card("试读入口"),
        ],
    },
    # 1008 用户令「最新的研究报告」: R50 中石化南京工程 (r50_article.md
    # 同调: 合并≠会EPC / 交付基因 / 923处引注 / 笨功夫)
    "r50_snei_v1": {
        "duration": 16.5,
        "cues": [
            {"at": 0.0, "kind": "title", "text": "怎么干EPC？",
             "sub": "设计与施工合并了，还是干不好",
             "data": {"label": "深度研报"}},
            {"at": 2.7, "kind": "point", "text": "交付基因",
             "sub": "组织合并解决不了的东西",
             "data": {"label": "判断 01", "key": "解决不了"}},
            {"at": 5.4, "kind": "number",
             "sub": "消化1294万字·成稿10万字",
             "data": {"value": 867, "suffix": " 份底稿", "label": "笨功夫"}},
            {"at": 8.1, "kind": "point", "text": "923处引注",
             "sub": "关键结论最多9源印证",
             "data": {"label": "可信 01", "key": "9源"}},
            {"at": 10.8, "kind": "point", "text": "拆成15章",
             "sub": "30年总承包打法全复盘",
             "data": {"label": "成果", "key": "全复盘"}},
            {"at": 11.9, "kind": "highlight", "data": {"word": "15章"}},
            *_tail_card("试读入口"),
        ],
    },
}


def build_spec(slug: str) -> dict:
    card = ARTCARDS[slug]
    return {
        "grammar": "y5_kinetic_type",
        "duration": card["duration"],
        "fps": 30,
        "width": 1080,
        "height": 1920,
        "safe": SAFE,
        "data": {"palette": PAL},
        "cues": card["cues"],
    }


def _run_engine(args: list[str], timeout_s: int = 900) -> int:
    """cwd=engine 跑 render.py/qa.py (相对路径资源 + clip.html 才找得到)."""
    cmd = [str(VENV_PY), "-X", "utf8", *args]
    print(f"[amf] $ {' '.join(args)}")
    try:
        return subprocess.run(cmd, cwd=str(ENGINE), timeout=timeout_s,
                              check=False).returncode
    except (OSError, subprocess.TimeoutExpired) as exc:
        print(f"[amf] 引擎子进程失败: {exc}")
        return 1


def make(slug: str) -> int:
    if slug not in ARTCARDS or slug not in META_CARDS:
        print(f"[amf] 未知选题 {slug!r} (须在 ARTCARDS+video_factory.CARDS)")
        return 1
    for p, what in ((ENGINE / "render.py", "引擎"), (VENV_PY, "venv python")):
        if not p.exists():
            print(f"[amf] 缺 {what}: {p}")
            return 1
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    spec_p = OUT_DIR / f"{slug}_am.spec.json"
    mp4 = OUT_DIR / f"{slug}_am.mp4"
    spec = build_spec(slug)
    spec_p.write_text(json.dumps(spec, ensure_ascii=False, indent=1),
                      encoding="utf-8")
    print(f"[amf] spec → {spec_p.name} ({spec['duration']}s × "
          f"{len(spec['cues'])} cues)")
    rc = _run_engine(["render.py", "--spec", str(spec_p), "--out", str(mp4)])
    if rc != 0 or not mp4.exists():
        print(f"[amf] 渲染失败 rc={rc} exists={mp4.exists()}")
        return 1
    # 伴生 meta (uploader 消费; 文案单一事实源=video_factory.CARDS)
    src = META_CARDS[slug]
    meta = OUT_DIR / f"{slug}_am.json"
    meta.write_text(json.dumps(
        {"title": src["title"], "desc": src.get("desc", ""),
         "tags": src["desc_tags"], "video": mp4.name},
        ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[amf] ✓ {mp4.name} ({mp4.stat().st_size // 1024}KB) "
          f"+ meta {meta.name}")
    return 0


def qa(slug: str) -> int:
    """skill 硬门: qa.py (稳定/效率/动感/流畅/框景) — 独立审片另派 agent."""
    spec_p = OUT_DIR / f"{slug}_am.spec.json"
    if not spec_p.exists():
        print(f"[amf] 先 make: 缺 {spec_p.name}")
        return 1
    return _run_engine([r"..\qa.py", "--spec", str(spec_p)])


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("cmd", choices=["list", "make", "qa"])
    ap.add_argument("--slug", default="cnnec_v1")
    ns = ap.parse_args()
    if ns.cmd == "list":
        for k, v in ARTCARDS.items():
            print(f"{k}: {v['duration']}s, {len(v['cues'])} cues — "
                  f"{META_CARDS.get(k, {}).get('title', '?')[:30]}")
        return 0
    if ns.cmd == "make":
        return make(ns.slug)
    return qa(ns.slug)


if __name__ == "__main__":
    sys.exit(main())
