# -*- coding: utf-8 -*-
"""release_render_videos — EPC-OVERSEAS (OVERSEAS-2026) 发布链视频渲染件 (1025).

零改动 video_factory.py / artmotion_factory.py (只增纪律):
运行时向 CARDS / ARTCARDS 注入 overseas 三卡后调 make()。
  overseas_v1_am  = artmotion 动画卡 (上海电气13.11亿美元大案钩子)
  overseas_v2_am  = artmotion 动画卡 (印尼退煤时间表=订单清单)
  overseas_v3_h3  = video_factory 静态金句卡 (上架主卡, 历史爆款结构 H3)
用法: python -X utf8 release_render_videos.py [v1|v2|v3|all]
"""
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PROMO = Path(r"E:\AI-Station\report_platform\promo")
sys.path.insert(0, str(PROMO))

import video_factory as vf          # noqa: E402
import artmotion_factory as af      # noqa: E402

# ---- 文案卡 (title/desc/tags/frames — 单一事实源注入 CARDS) ----
META = {
    "overseas_v1": {
        # r6 实锤: 短标题≤14字防发表键锁灰; 长文案住 desc
        "title": "被拖欠13.11亿美元之后",
        "desc": ("上海电气印度莎圣6×660兆瓦电站项目，被拖欠上亿美元尾款，"
                 "对簿新加坡国际仲裁中心，2026年6月30日对方3.89亿美元索赔"
                 "全部被驳回。电力EPC出海的合同规则、索赔时限与证据链，"
                 "25万字实战指南逐案拆解，每个数字可回查。公众号可试读。"),
        "desc_tags": ["EPC", "电力出海", "国际仲裁", "FIDIC"],
        "frames": [
            ("13.11亿美元 合同", "印度莎圣6×660兆瓦电站"),
            ("被拖欠尾款", "对簿新加坡国际仲裁中心"),
            ("3.89亿美元索赔", "2026年6月30日全部驳回"),
            ("25万字 · 每数可回查", "全球市场与准入实战指南"),
        ],
    },
    "overseas_v2": {
        "title": "印尼退煤时间表就是订单",
        "desc": ("印尼国家电力公司退煤时间表：2030/2035/2040/2045年依次淘汰"
                 "1/9/10/24吉瓦燃煤电站，2056年全部退完；100吉瓦太阳能计划"
                 "已奠基，2034年光伏新增17.1吉瓦。存量淘汰的每一步都是订单"
                 "落点。25万字实战指南分市场拆解，公众号可试读。"),
        "desc_tags": ["印尼", "新能源", "EPC", "电力出海"],
        "frames": [
            ("退煤时间表", "2056年全部退完"),
            ("100吉瓦太阳能", "首批5.2吉瓦已奠基"),
            ("2034年光伏+17.1吉瓦", "所有电源里最大一项"),
            ("分市场棋盘", "25万字实战指南 · 可试读"),
        ],
    },
    "overseas_v3_h3": {
        "title": "电力EPC出海一张棋盘",
        "desc": ("《中资电力EPC出海：全球市场与准入实战指南》今日上架：12章"
                 "25.05万字341页，全球市场三卷地图+准入/合同/风险/资金四维"
                 "实战，句末源编号可回查。第1章导论免费试读。"),
        "desc_tags": ["EPC", "电力出海", "全球市场", "深度报告"],
        "frames": [
            ("3000亿美元盘子", "电力工程约占两成"),
            ("12章 · 25.05万字", "341页 · 每个数字可回查"),
            ("三卷市场地图", "准入·合同·风险·资金"),
            ("今日上架", "第1章导论免费试读 · 公众号"),
        ],
    },
}

# ---- 画面卡 (y5 kinetic spec — 沿 sched/slsd 同款节奏) ----
ART = {
    "overseas_v1": {
        "duration": 16.5,
        "cues": [
            {"at": 0.0, "kind": "title", "text": "13.11亿美元",
             "sub": "印度莎圣电站合同", "data": {"label": "出海大案"}},
            {"at": 2.7, "kind": "point", "text": "被拖欠尾款",
             "sub": "对簿新加坡国际仲裁中心",
             "data": {"label": "战例 01", "key": "仲裁"}},
            {"at": 5.4, "kind": "number",
             "sub": "对方索赔 2026年6月30日全部驳回",
             "data": {"value": 3.89, "suffix": " 亿美元", "label": "索赔驳回"}},
            {"at": 8.1, "kind": "point", "text": "先发通知",
             "sub": "后补弹药 索赔两道铁闸",
             "data": {"label": "纪律 01", "key": "通知"}},
            {"at": 10.8, "kind": "point", "text": "25万字",
             "sub": "341页 每个数字可回查",
             "data": {"label": "成果", "key": "341页"}},
            {"at": 11.9, "kind": "highlight", "data": {"word": "可回查"}},
            *af._tail_card("试读入口"),
        ],
    },
    "overseas_v2": {
        "duration": 16.5,
        "cues": [
            {"at": 0.0, "kind": "title", "text": "退煤时间表",
             "sub": "印尼 2056年全部退完", "data": {"label": "订单清单"}},
            {"at": 2.7, "kind": "point", "text": "分年淘汰",
             "sub": "2030/2035/2040/2045 递进",
             "data": {"label": "节奏 01", "key": "淘汰"}},
            {"at": 5.4, "kind": "number",
             "sub": "太阳能计划 已奠基首批5.2吉瓦",
             "data": {"value": 100, "suffix": " 吉瓦", "label": "光伏宏图"}},
            {"at": 8.1, "kind": "point", "text": "17.1吉瓦",
             "sub": "2034年光伏新增 所有电源最大",
             "data": {"label": "增量 01", "key": "光伏"}},
            {"at": 10.8, "kind": "point", "text": "一盘棋",
             "sub": "分市场拆门槛与订单",
             "data": {"label": "方法", "key": "棋盘"}},
            {"at": 11.9, "kind": "highlight", "data": {"word": "棋盘"}},
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
        af.make("overseas_v1")
    if which in ("v2", "all"):
        af.make("overseas_v2")
    if which in ("v3", "all"):
        vf.make("overseas_v3_h3")
    return 0

if __name__ == "__main__":
    sys.exit(main())
