# -*- coding: utf-8 -*-
"""release_render_videos — EPC-LUMPSUM (LUMPSUM-2026) 发布链视频渲染件 (1104).

照 jiage/caselaw 同款: 运行时向 CARDS/ARTCARDS 注入 lumpsum 三卡后调 make().
数字全溯源: 三篇宣传文 + report.json + s3_run_manifest.
用法: python -X utf8 release_render_videos.py [v1|v2|v3|all]
"""
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PROMO = Path(r"E:\AI-Station\report_platform\promo")
sys.path.insert(0, str(PROMO))

import video_factory as vf          # noqa: E402
import artmotion_factory as af     # noqa: E402

META = {
    "lumpsum_v3_h3": {
        "title": "固定总价EPC一张钱路图",
        "desc": ("《固定总价EPC合同计价调价与风险管控实战研究报告》今日上架：12章26.6万字"
                 "404页，固定总价全生命周期+计价调价机制+风险管控实战，2009-2021判例语料28桶"
                 "可回溯。第1章导论免费试读。"),
        "desc_tags": ["固定总价", "EPC", "造价", "深度报告"],
        "frames": [
            ("12章 · 26.6万字", "404页 · 计价调价与风险管控"),
            ("七大争议类型", "17年判例语料 · 全谱系"),
            ("司法解释双轨", "2020基座 + 2026新规"),
            ("今日上架", "第1章导论免费试读 · 公众号"),
        ],
    },
    "lumpsum_v1": {
        "title": "固定总价中途解除怎么算钱",
        "desc": ("固定总价合同干到一半解除，发包人说按合同总价，承包人说按定额据实——"
                 "最高法（2016）民终695号案给出第三条路。EPC分拆结算+先履行抗辩+技术文件"
                 "交付=付款开关，5348.51万元攻防全程拆解，公众号可试读。"),
        "desc_tags": ["固定总价", "未完工程", "结算", "判例"],
        "frames": [
            ("53,485,080元", "节点款之争 · 判例实锤"),
            ("E/P/C 三拆", "融资要求 · 界面风险"),
            ("技术文件交付", "付款开关 · 先履行抗辩"),
            ("比例折算法", "未完工程 · 第三条路"),
        ],
    },
    "lumpsum_v2": {
        "title": "经济风险权重居首",
        "desc": ("四套独立实证样本排序：经济风险在EPC项目全部一级风险因素中权重最高——"
                 "材料价格波动正是主战场。合同里有调差条款的按公式分摊，没写的赌情势变更。"
                 "固定总价EPC报告逐章拆解，公众号可试读。"),
        "desc_tags": ["EPC", "风险管理", "调价", "情势变更"],
        "frames": [
            ("10个一级因素", "36个二级 · 权重排序"),
            ("经济风险 · 第一", "材料波动 · 主战场"),
            ("调差条款", "有则分摊 · 无则自吞"),
            ("12章拆解", "公众号可试读"),
        ],
    },
}

ART = {
    "lumpsum_v1": {
        "duration": 16.5,
        "cues": [
            {"at": 0.0, "kind": "title", "text": "中途解除怎么算",
             "sub": "固定总价 · 未完工程", "data": {"label": "判例警示"}},
            {"at": 2.7, "kind": "number",
             "sub": "最高法民终695号 节点款之争",
             "data": {"value": 5348.51, "suffix": " 万元", "label": "判例实锤"}},
            {"at": 5.4, "kind": "point", "text": "E/P/C三拆",
             "sub": "融资要求拆三合同 界面风险入约",
             "data": {"label": "结构 01", "key": "分拆"}},
            {"at": 8.1, "kind": "point", "text": "技术文件",
             "sub": "交付=付款开关 先履行抗辩权",
             "data": {"label": "攻防 01", "key": "开关"}},
            {"at": 10.8, "kind": "point", "text": "比例折算",
             "sub": "未完工程结算 第三条路",
             "data": {"label": "出路", "key": "折算"}},
            {"at": 11.9, "kind": "highlight", "data": {"word": "折算"}},
            *af._tail_card("试读入口"),
        ],
    },
    "lumpsum_v2": {
        "duration": 16.5,
        "cues": [
            {"at": 0.0, "kind": "title", "text": "经济风险第一",
             "sub": "四样本权重排序", "data": {"label": "风险地图"}},
            {"at": 2.7, "kind": "number",
             "sub": "一级风险因素 10个 · 二级 36个",
             "data": {"value": 10, "suffix": " 个一级因素", "label": "实证排序"}},
            {"at": 5.4, "kind": "point", "text": "材料波动",
             "sub": "经济风险主战场 价格周期",
             "data": {"label": "战场 01", "key": "波动"}},
            {"at": 8.1, "kind": "point", "text": "调差条款",
             "sub": "有则按公式分摊 无则自吞",
             "data": {"label": "分水岭", "key": "调差"}},
            {"at": 10.8, "kind": "point", "text": "情势变更",
             "sub": "认定门槛高 多数望而却步",
             "data": {"label": "兜底", "key": "情势"}},
            {"at": 11.9, "kind": "highlight", "data": {"word": "调差"}},
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
        af.make("lumpsum_v1")
    if which in ("v2", "all"):
        af.make("lumpsum_v2")
    if which in ("v3", "all"):
        vf.make("lumpsum_v3_h3")
    return 0


if __name__ == "__main__":
    sys.exit(main())
