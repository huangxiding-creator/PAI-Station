# -*- coding: utf-8 -*-
"""release_render_videos — EPC-CASELAW (CASELAW-2026) 发布链视频渲染件 (1101).

零改动 video_factory.py / artmotion_factory.py (只增纪律, 照 jiage 同款):
运行时向 CARDS / ARTCARDS 注入 caselaw 三卡后调 make().
  caselaw_v1_am  = artmotion 动画卡 (亿元管辖崩盘钩子)
  caselaw_v2_am  = artmotion 动画卡 (2026新仲裁法四红利钩子)
  caselaw_v3_h3  = video_factory 静态金句卡 (上架主卡, 历史爆款结构 H3)
数字全溯源: 三篇宣传文 (2026-11-01_zbzs/zbshuo/dt) + report.json + s3_run_manifest + ch11终稿.
用法: python -X utf8 release_render_videos.py [v1|v2|v3|all]
"""
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PROMO = Path(r"E:\AI-Station\report_platform\promo")
sys.path.insert(0, str(PROMO))

import video_factory as vf          # noqa: E402
import artmotion_factory as af      # noqa: E402

META = {
    "caselaw_v1": {
        "title": "亿元查封跟着管辖崩盘",
        "desc": ("管辖异议打到最后：最高法民辖终76号支持异议，206套房产亿元保全"
                 "连锁解封、衍生诉讼全部终结。2009年或裁或诉条款案——多写一个"
                 "或字仲裁协议作废。管辖、保全、路径选择的判例谱系逐案拆解，"
                 "公众号可试读。"),
        "desc_tags": ["管辖异议", "财产保全", "造价争议", "判例"],
        "frames": [],
    },
    "caselaw_v2": {
        "title": "2026新仲裁法四红利",
        "desc": ("仲裁法2025年9月12日修订、2026年3月1日施行：仲裁协议默示成立"
                 "（第27条）、行为保全与仲裁前紧急保全入法（第39条）、机构专家"
                 "不少于三分之二（第18条）、在线仲裁法定（第11条）。旧机制判例"
                 "逐条对照拆解，公众号可试读。"),
        "desc_tags": ["仲裁法", "新仲裁法", "造价争议", "工程仲裁"],
        "frames": [],
    },
    "caselaw_v3_h3": {
        "title": "造价争议判例谱系一张图",
        "desc": ("《工程造价争议判例谱系与调解实务研究报告》今日上架：12章22.6万字"
                 "339页，固定总价/审计审减/签证索赔/鉴定/工期/黑白合同/优先受偿权"
                 "七大争议类型判例谱系四段式拆解，2026新仲裁法四红利对照。第1章导论免费试读。"),
        "desc_tags": ["工程造价", "造价争议", "判例", "深度报告"],
        "frames": [
            ("12章 · 22.6万字", "339页 · 判例谱系与调解实务"),
            ("七大争议类型", "17年判例 · 四段式拆解"),
            ("2026新仲裁法", "四红利 · 旧机制判例对照"),
            ("今日上架", "第1章导论免费试读 · 公众号"),
        ],
    },
}

ART = {
    "caselaw_v1": {
        "duration": 16.5,
        "cues": [
            {"at": 0.0, "kind": "title", "text": "亿元查封崩盘",
             "sub": "管辖异议 · 连锁解封", "data": {"label": "判例警示"}},
            {"at": 2.7, "kind": "point", "text": "206套房产",
             "sub": "保全查封 · 价值过亿",
             "data": {"label": "战况 01", "key": "查封"}},
            {"at": 5.4, "kind": "number",
             "sub": "最高法民辖终76号 异议成立",
             "data": {"value": 1, "suffix": " 亿元连锁崩盘", "label": "判例实锤"}},
            {"at": 8.1, "kind": "point", "text": "一个或字",
             "sub": "或裁或诉条款 仲裁协议作废",
             "data": {"label": "条款 01", "key": "作废"}},
            {"at": 10.8, "kind": "point", "text": "移送终结",
             "sub": "衍生诉讼 全线连锁退场",
             "data": {"label": "多米诺", "key": "崩盘"}},
            {"at": 11.9, "kind": "highlight", "data": {"word": "崩盘"}},
            *af._tail_card("试读入口"),
        ],
    },
    "caselaw_v2": {
        "duration": 16.5,
        "cues": [
            {"at": 0.0, "kind": "title", "text": "新仲裁法来了",
             "sub": "2026年3月1日施行", "data": {"label": "规则换轨"}},
            {"at": 2.7, "kind": "point", "text": "默示成立",
             "sub": "开庭前不否认 视为有协议",
             "data": {"label": "红利 01", "key": "第27条"}},
            {"at": 5.4, "kind": "number",
             "sub": "仲裁机构专家占比下限",
             "data": {"value": 2, "suffix": "/3 专家门槛", "label": "第18条"}},
            {"at": 8.1, "kind": "point", "text": "仲裁前保全",
             "sub": "行为保全入法 现场界面有抓手",
             "data": {"label": "红利 03", "key": "第39条"}},
            {"at": 10.8, "kind": "point", "text": "在线仲裁",
             "sub": "微信群记录 电子签单实时质证",
             "data": {"label": "红利 04", "key": "第11条"}},
            {"at": 11.9, "kind": "highlight", "data": {"word": "换轨"}},
            *af._tail_card("试读入口"),
        ],
    },
}


def main() -> int:
    which = sys.argv[1] if len(sys.argv) > 1 else "all"
    for k, v in META.items():
        vf.CARDS[k] = v
    for k, v in ART.items():
        af.ARTCARDS[k] = v
    if which in ("v1", "all"):
        af.make("caselaw_v1")
    if which in ("v2", "all"):
        af.make("caselaw_v2")
    if which in ("v3", "all"):
        vf.make("caselaw_v3_h3")
    return 0


if __name__ == "__main__":
    sys.exit(main())
