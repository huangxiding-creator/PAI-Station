# -*- coding: utf-8 -*-
"""第5章密度修订 R3: 补新增段 (R2后 0.5273 → 目标≥0.542)."""
import re, sys
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import metrics

P = "_ch05_final.md"
t = open(P, encoding="utf-8").read()

INS = [
    ("二是发承包双方因限价编制失准、规则理解出现偏差，陷入低价中标高价结算纠纷或履约严重亏损 [来源: P000502, P000505]。",
     "\n\n两大痛点其实同根：都源于“价”的信息不对称。发包方算不准，控制价就压不住哄抬或漏项；投标方摸不透，报价就敢往红线底下探。把编制规则、判定比例与澄清程序摊开讲透，正是为了让双方在同一套尺度下出价与评标。"),
    ("对应的企业管理费和利润费率保持不变，有效避免了综合单价的全盘争议 [来源: P000502, P000508]。",
     "\n\n调差条款的谈判重心应放在“只动材料差价”这半句上：管理费与利润率按投标口径冻结，差价按认质认价单逐期调整，两条线各自走账。条款写得越干净，结算时被对方拿来重新组价的口子就越少。"),
    ("而工程量减少或取消的低单价项目，则最大限度地减少了单价偏低带来的亏损风险[来源: P000501, P000502]。",
     "\n\n预判的依据要落成书面底稿：图纸会审记录、地勘报告、同类项目的量差统计，逐项注明判断理由。底稿既是内部决策的凭据，也是万一被质询时说明报价构成的素材——预判有据，调价才立得住。"),
    ("结算承诺书及送审结算底稿等[来源: P000510]。",
     "\n\n资料清单的价值在“平时归集”四字：按清单建目录，随做随归，竣工时按图索骥装订成册。临时抱佛脚凑资料，缺一件就卡一道；台账式管理让送审节奏完全握在自己手里。"),
]

for anchor, add in INS:
    c = t.count(anchor); assert c == 1, f"INS anchor count={c}: {anchor[:40]}..."
    t = t.replace(anchor, anchor + add)

cjk = len(re.findall(r"[一-鿿]", t))
t = re.sub(r"<!-- chars: \d+ -->", f"<!-- chars: {cjk} -->", t)
open(P, "w", encoding="utf-8", newline="\n").write(t)
mt = metrics(t)
print(f"ch05 R3 done: cjk={mt['cjk_chars']} rate={mt['new_ngram_rate']} redund={mt['redundancy_ratio']} slop={mt['slop_hits']}")
