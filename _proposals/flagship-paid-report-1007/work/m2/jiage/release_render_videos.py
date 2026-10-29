# -*- coding: utf-8 -*-
"""release_render_videos — EPC-JIAGE (JIAGE-2026) 发布链视频渲染件 (1027).

零改动 video_factory.py / artmotion_factory.py (只增纪律):
运行时向 CARDS / ARTCARDS 注入 jiage 三卡后调 make()。
  jiage_v1_am  = artmotion 动画卡 (过程结算90%回款钩子)
  jiage_v2_am  = artmotion 动画卡 (GB→GB/T 规则换轨钩子)
  jiage_v3_h3  = video_factory 静态金句卡 (上架主卡, 历史爆款结构 H3)
数字全溯源: 三篇宣传文 (2026-10-27_zbzs/dt/zbshuo) + report.json + s3_run_manifest.
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
    "jiage_v1": {
        "title": "节点一签认，90%先落袋",
        "desc": ("过程结算把终点总算改成节点分算：支付比例不低于确认金额90%，"
                 "已结算金额法律上锁死、不得翻出来重审。利息从结算报告审核期满"
                 "第29天起算、按同期贷款利率上浮50%计付——某案终审判决支付"
                 "工程款2.73亿元。计价与结算实战报告逐案拆解，公众号可试读。"),
        "desc_tags": ["过程结算", "工程款", "造价", "工程计价"],
        "frames": [
            ("90% · 支付比例下限", "节点签认即锁定"),
            ("不得二次审计", "已结算金额法律上锁死"),
            ("第29天起算利息", "2.73亿判例 · 上浮50%"),
            ("12章 · 27.3万字", "计价依据与市场价基准 · 可试读"),
        ],
    },
    "jiage_v2": {
        "title": "GB改GB/T，规则换轨了",
        "desc": ("2024年12月30日新清单计价标准发布，执行十一年的强制规范降为"
                 "推荐性标准——规则不再自动生效，效力全看合同怎么写。材料价格"
                 "波动超合同约定±5%超出部分业主承担；工程量偏差超15%重新组价；"
                 "造价咨询资质认定同步取消。新旧规则逐条对照拆解，公众号可试读。"),
        "desc_tags": ["清单计价", "造价", "工程计价", "新标准"],
        "frames": [
            ("十一年来第一次", "GB 50500-2013 → GB/T 50500-2024"),
            ("±5% 材料调差", "超界部分 · 业主承担"),
            ("15% 工程量偏差", "超出部分 · 重新组价"),
            ("规则看合同", "12章对照拆解 · 公众号可试读"),
        ],
    },
    "jiage_v3_h3": {
        "title": "工程计价依据一张底账",
        "desc": ("《工程计价依据与市场价基准实战研究报告》今日上架：12章27.3万字"
                 "425页，清单定额→市场价全链依据+计价/结算/EPC/鉴定四维实战，"
                 "265个证据锚1532处源引用可回查。第1章导论免费试读。"),
        "desc_tags": ["工程计价", "造价", "市场价", "深度报告"],
        "frames": [
            ("12章 · 27.3万字", "425页 · 计价依据与市场价基准"),
            ("265个证据锚", "1532处源引用 · 可回查"),
            ("90% · ±5% · 15%", "回款与调价三道杠杠"),
            ("今日上架", "第1章导论免费试读 · 公众号"),
        ],
    },
}

ART = {
    "jiage_v1": {
        "duration": 16.5,
        "cues": [
            {"at": 0.0, "kind": "title", "text": "90%先落袋",
             "sub": "过程结算 · 支付比例下限", "data": {"label": "回款革命"}},
            {"at": 2.7, "kind": "point", "text": "节点签认",
             "sub": "已结算金额法律上锁死",
             "data": {"label": "锁定 01", "key": "锁死"}},
            {"at": 5.4, "kind": "number",
             "sub": "终审判决支付工程款 2.73亿元",
             "data": {"value": 2.73, "suffix": " 亿元", "label": "判例实锤"}},
            {"at": 8.1, "kind": "point", "text": "第29天",
             "sub": "审核期满即起算 利息上浮50%",
             "data": {"label": "时点 01", "key": "起算"}},
            {"at": 10.8, "kind": "point", "text": "不得重审",
             "sub": "竣工后不再翻旧账",
             "data": {"label": "纪律", "key": "翻旧账"}},
            {"at": 11.9, "kind": "highlight", "data": {"word": "锁死"}},
            *af._tail_card("试读入口"),
        ],
    },
    "jiage_v2": {
        "duration": 16.5,
        "cues": [
            {"at": 0.0, "kind": "title", "text": "GB改GB/T",
             "sub": "十一年来第一次换轨", "data": {"label": "规则换轨"}},
            {"at": 2.7, "kind": "point", "text": "推荐性标准",
             "sub": "规则不再自动生效 效力看合同",
             "data": {"label": "法理 01", "key": "合同"}},
            {"at": 5.4, "kind": "number",
             "sub": "材料波动超界 业主承担",
             "data": {"value": 5, "suffix": "% 调差线", "label": "硬杠杠"}},
            {"at": 8.1, "kind": "point", "text": "偏差15%",
             "sub": "工程量超界 重新组价",
             "data": {"label": "硬杠杠 02", "key": "组价"}},
            {"at": 10.8, "kind": "point", "text": "逐条对照",
             "sub": "新旧规则 12章拆解",
             "data": {"label": "方法", "key": "对照"}},
            {"at": 11.9, "kind": "highlight", "data": {"word": "对照"}},
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
        af.make("jiage_v1")
    if which in ("v2", "all"):
        af.make("jiage_v2")
    if which in ("v3", "all"):
        vf.make("jiage_v3_h3")
    return 0


if __name__ == "__main__":
    sys.exit(main())
