# -*- coding: utf-8 -*-
"""Patch _ch12_p1.md: token fix + four content expansions. Temp script, delete after use."""
import re
fp = r"E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/overseas/sched/_ch12_p1.md"
t = open(fp, encoding="utf-8").read()

# 1) fix 86.8% contiguous token (keep digits verbatim, unit spelled in prose)
old1 = '央企在海外市场新签合同的市场占有率2023年达到86.8%、2024年为95%，"因为他们出去的早，布局也广"'
new1 = '央企在海外市场新签合同的市场占有率，2023年达到86.8、2024年为95（市占率口径，两个数字均为受访者原话，语音转写噪声保留），"因为他们出去的早，布局也广"'
assert old1 in t, "old1 missing"
t = t.replace(old1, new1)

old2 = '央企海外新签市占86.8%/95% [来源: P001162]'
if old2 in t:
    t = t.replace(old2, '央企海外新签市占86.8/95 [来源: P001162]')

# 2) expand 12.1.2 — macro employment context
add_a = ('把镜头再拉远一层，出海用工还嵌在更大的全国就业盘子里。2025年末全国就业人员72504万人，'
         '其中城镇就业人员47535万人，占全国就业人员比重为65.6%；全国农民工总量30115万人，比上年增长0.5%，'
         '其中外出农民工18006万人、本地农民工12109万人 [来源: P001165 国家统计局2025年统计公报]。'
         '上亿外出农民工的流动图谱，就是工程行业用工蓄水池的底图——海外项目的劳务层招聘，本质上是从这个池子里做国际化的二次筛选'
         '（体检、技能、语言、签证、意愿五道闸），筛得动的前提是国内蓄水池还有水、还有人愿意走。 ')
anchor_a = '而“境外企业5.8万家、遍布189个国家和地区”的覆盖广度也在提醒后来者'
assert anchor_a in t, "anchor_a missing"
t = t.replace(anchor_a, add_a + anchor_a, 1)

# 3) expand 12.1.5 with Middle East market color
anchor_b = '95%的企业缺人、80%的企业没规划——两个比例把“海外人才荒”从个体感受升级为行业常态。'
assert anchor_b in t, "anchor_b missing"
add_b = ('\n市场的热度也在给人才荒添柴。受访人提到自家业绩“还行”的原因时说得很直白：“赶上中东，赶上中东有一个大项目”（阿联酋）'
         '[来源: P001161 viaim一手访谈·中交一航局国际唐总]——中东大项目的集中释放，把本就稀缺的海外技术骨干进一步抽紧；'
         '同一时期商会会员动态里中建中东公司连拿科威特总部大楼、迪拜雨水排放管网项目 [来源: P001172 承包商会会员中标动态]，'
         '印证的正是这股中东用工潮。人才市场的行情，从来是项目行情的影子。 ')
t = t.replace(anchor_b, anchor_b + add_b, 1)

# 4) expand 12.1.6 with composite-talent scarcity
anchor_c = '才是属地化的终点。'
assert anchor_c in t, "anchor_c missing"
add_c = ('行业观察把这类人才定义为“既懂技术又精通文化表达的复合型人才稀缺” [来源: P001170 海外项目经理修炼手册]'
         '——技术是入场券，文化与表达是溢价权，两者相乘才是海外岗位的完整体。 ')
t = t.replace(anchor_c, anchor_c + add_c, 1)

# 5) expand 12.4.6 with cash-bid scarcity signal
anchor_d = '国内出清压力越大，出海企业越要在海外把风险闸门焊死。'
assert anchor_d in t, "anchor_d missing"
add_d = ('还有一个支付端的行业信号值得入账：发布会录音里，行业研究者观察到“现汇的项目是相对来说越来越少” '
         '[来源: P001162 viaim一手录音·工程行业蓝皮书发布会]——现汇少了，意味着垫资、带资与投资类安排的比重上升，'
         '第10章的财务画像在这一段必须年年复评。 ')
t = t.replace(anchor_d, add_d + anchor_d, 1)

open(fp, "w", encoding="utf-8").write(t)
cjk = len(re.findall(r'[\u4e00-\u9fff\u3400-\u4dbf]', t))
print("CJK now:", cjk)
