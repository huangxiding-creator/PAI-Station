# -*- coding: utf-8 -*-
"""ch10 编辑稿 拼版手术：去重(前半小结/证据边界 vs 10.8; 10.6.2 vs 10.4.3; 10.6.3 vs 10.4.2)
+ AI残留剥离 + NBLM来源口径中性化 + 10.8标题规范化"""
import re, json

P = r'e:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/sched/nblm_out/ch10_编辑稿.md'
raw = open(P, encoding='utf-8', newline='').read().lstrip('\ufeff')
crlf = raw.count('\r\n')
lf_only = raw.count('\n') - crlf
print('line-endings: crlf=%d lf-only=%d' % (crlf, lf_only))
s = raw.replace('\r\n', '\n')
lines = s.split('\n')

def L(n): return lines[n-1]
def span(a, b): return lines[a-1:b]
def chars(a, b): return len('\n'.join(span(a, b)))

# ---- boundary assertions (fail loudly, write nothing) ----
assert L(1).startswith('# 第10章'), L(1)
assert L(260) == '---', repr(L(260))
assert L(262) == '## 【本半章小结要点】（第10章前半部分总结）', repr(L(262))
assert L(271) == '## 【本章证据边界】（第10章前半部分引用声明）', repr(L(271))
assert L(273).find('笔记本内置资料') >= 0, L(273)[:30]
assert L(285).startswith('*(提示'), L(285)[:20]
assert L(287).startswith('💡'), L(287)[:10]
assert L(289).startswith('## 10.5'), L(289)[:15]
assert L(374).startswith('在面对包含'), L(374)[:15]
assert L(375) == '', repr(L(375))
assert L(376).startswith('#### 1. 沙盘推演培训的核心实施流程'), L(376)[:20]
assert L(386).startswith('#### 2. 沙盘推演培训中的五种演练方式'), L(386)[:20]
assert L(394).startswith('在福清核电'), L(394)[:15]
assert L(395) == '' and L(396) == '---', (repr(L(395)), repr(L(396)))
assert L(398).startswith('### 10.6.3'), L(398)[:15]
assert L(409).find('早班会') >= 0, L(409)[:30]
assert L(410) == '', repr(L(410))
assert L(411).startswith('2. **班组“红绿灯”评价与闭环整改培训**'), L(411)[:20]
assert L(412).find('周评价（定性）') >= 0, L(412)[:20]
assert L(415).startswith('通过该机制的持续培训与疏导'), L(415)[:20]
assert L(416) == '' and L(417) == '---', (repr(L(416)), repr(L(417)))
assert L(514) == '## 10.8 本章终极总结与全章证据边界', repr(L(514))
assert L(516) == '### 10.8.1 第10章终极小结', repr(L(516))
assert L(528) == '### 10.8.2 本章全文献源引用对照清单', repr(L(528))
assert L(530).startswith('本章（第10章上、下两部分）'), L(530)[:20]
assert L(530).find('笔记本内置的8份核心资料') >= 0
assert L(532).startswith('| 源引用编号 | 笔记本原文献名称'), L(532)[:20]
assert L(541).startswith('| **[3]**'), L(541)[:15]
assert L(543) == '---', repr(L(543))
assert L(545).startswith('*(第10章全章撰写完成)*'), L(545)[:20]
assert L(547).find('已全部撰写完毕') >= 0, L(547)[:30]
assert L(551).startswith('### 本章（第10章）全景框架'), L(551)[:20]
assert L(560).find('笔记本8份原文献') >= 0, L(560)[:30]
assert L(564).startswith('💡'), L(564)[:10]
assert len(lines) == 565, len(lines)

# ---- replacement text for dedup'd subsections (citation values [4]/[6] 均为既存编号, 未改值) ----
R1 = ('沙盘推演的核心实施流程（“五步推演法”）以及访谈沟通、文件调阅、情景模拟、压力测试、模拟演练五种方式，'
      '已在本章10.4.3节结合“华龙一号”首堆实践系统阐述，培训组织中可直接沿用 [4]。'
      '培训场景下应重点用足两个环节：一是压力测试，随机设定“现场吊装风力突增至7级”“施工人员返岗率仅50%”等极限条件，'
      '逼迫学员在限定时间内重新调整网络计划与资源配置 [4]；二是模拟演练，在真实或1:1模拟场地进行实物演练'
      '（如重大设备模拟吊装、模拟混凝土浇筑），检验团队的现场指挥配合默契度 [4]。')
R2 = ('2. **班组“红绿灯”评价与闭环整改培训**：周定性评价（安全、质量、进度三维度）、“红灯历史台账”与整改更换机制'
      '已在本章10.4.2节详述。落到培训环节，对出现“红灯”的班组应立即安排专人深入班组查找原因，'
      '开展针对性的现场安全教育与技能补强培训，并将整改成效纳入下一轮评价，形成“评价—培训—改进”的联动 [6]。')

# ---- assemble new document ----
out_lines = (span(1, 261)        # H1+导言+10.1~10.4 全文 + 分隔线
             + span(289, 375)    # 10.5 ~ 10.6.2 引导句
             + [R1]              # 10.6.2 去重改写段(指回10.4.3, 保留B系独有演练细节)
             + span(395, 410)    # 分隔线 + 10.6.3 标题/引导/机制图/早班会微培训
             + [R2]              # 10.6.3 第2点去重压缩(指回10.4.2, 保留培训独有内容)
             + span(416, 543)    # 分隔线 + 10.6.4 + 10.7 + 10.8(含源引用对照表) + 章尾分隔线
             )
out = '\n'.join(out_lines)

# ---- 标题规范化 + NBLM生产口径中性化 ----
fixes = [
    ('## 10.8 本章终极总结与全章证据边界', '## 10.8 本章总结与证据边界'),
    ('### 10.8.1 第10章终极小结', '### 10.8.1 本章小结要点'),
    ('### 10.8.2 本章全文献源引用对照清单', '### 10.8.2 本章源引用对照清单'),
    ('本章（第10章上、下两部分）所有撰写内容、观点、数据、模型及司法判例，均严格基于笔记本内置的8份核心资料。',
     '本章所有撰写内容、观点、数据、模型及司法判例，均严格基于8份核心参考资料。'),
    ('| 源引用编号 | 笔记本原文献名称 |', '| 源引用编号 | 原文献名称 |'),
]
for old, new in fixes:
    assert out.count(old) == 1, old[:30]
    out = out.replace(old, new)

# ---- in-memory final-state checks before writing ----
def cjk(t): return len(re.findall('[一-鿿]', t))
checks = {
    '章H1数': len(re.findall(r'^# 第10章', out, re.M)),
    '小结要点标题': len(re.findall(r'^#{1,6}.*小结要点', out, re.M)),
    '证据边界标题': len(re.findall(r'^#{1,6}.*证据边界', out, re.M)),
    '源对照类标题': len(re.findall(r'^#{1,6}.*源引用对照', out, re.M)),
    '二级节10.x数': len(re.findall(r'^## 10\.\d', out, re.M)),
}
residue = ['请回复', '「继续」', '继续', '💡', '下一步建议', '后续实务', '我可以为您', '由我为您',
           '我将为您', '撰写完毕', '撰写完成', '前半部分', '后半部分', '上、下两部分', '笔记本',
           'losses', 'monthly', '全景框架', 'Tailored', 'slide', '您希望', '至此']
for pat in residue:
    checks['残留:' + pat] = out.count(pat)

ok = (checks['章H1数'] == 1 and checks['小结要点标题'] == 1 and checks['证据边界标题'] == 1
      and checks['源对照类标题'] == 1 and checks['二级节10.x数'] == 8
      and all(v == 0 for k, v in checks.items() if k.startswith('残留:')))
print(json.dumps(checks, ensure_ascii=False, indent=1))
assert ok, 'final-state check failed, nothing written'

# ---- removed-span accounting (old line ranges) ----
removed = [
    ('重复劣版: 前半【本半章小结要点】+【本章证据边界】(仅覆盖前半, 10.8全章版更完整且含判例案号)', '262-283', chars(262, 283)),
    ('AI残留: 「请回复继续」括注+💡下一步建议', '284-288', chars(284, 288)),
    ('重复劣版: 10.6.2五步推演法流程图+五种方式清单+首堆推演数据(与10.4.3重复, 压缩为指回段保留B系独有演练细节)', '376-394', chars(376, 394)),
    ('重复劣版: 10.6.3红绿灯周评价/台账细则+违章与返工率数据(与10.4.2重复, 压缩为指回句保留培训联动内容)', '411-415', chars(411, 415)),
    ('AI残留: 「全章撰写完成」括注+书名宣布句', '544-549', chars(544, 549)),
    ('AI残留: 全景框架回顾8条(含「笔记本8份原文献」口径)+💡下一步建议+您希望如何推进', '550-565', chars(550, 565)),
]
report = {
    'cjk_before': cjk(s),
    'cjk_after': cjk(out),
    'chars_before': len(s),
    'chars_after': len(out),
    'lines_before': len(lines),
    'lines_after': len(out_lines) + 1,
    'removed': removed,
    'added_dedup_pointer_chars': len(R1) + len(R2),
}
print(json.dumps(report, ensure_ascii=False, indent=1))

out_disk = out.replace('\n', '\r\n') if crlf > 0 else out
open(P, 'w', encoding='utf-8', newline='').write(out_disk)
print('WRITTEN OK')
