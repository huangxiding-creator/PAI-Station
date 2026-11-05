# -*- coding: utf-8 -*-
"""ch08 collation surgery: [N]->P anchor mapping (position-aware), NBLM residue purge,
adversarial writebacks, ghost-case rewrite. Auditable log printed to stdout."""
import re, sys

SRC = r'E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\lumpsum\sched\_ch08_final.md'
t = open(SRC, encoding='utf-8').read()
log = []

def rep(old, new, cnt=1, tag=''):
    global t
    assert old in t, f'MISS: {tag} :: {old[:60]}'
    t = t.replace(old, new, cnt)
    log.append(f'[{tag}] {old[:48]!r} -> {new[:48]!r}')

# ---------- A. fixed-point corrections ----------
rep('（注：本章段1前部小节至此输出完毕。下一段将紧接输出第8.4节「工期延误责任划定与工期索赔分析方法」及中部小节内容。）\n\n', '', tag='NBLM分段注1')
rep('（注：本章段2中部小节至此输出完毕。下一段将紧接输出段3后部小节，包含第8.7节、第8.8节及章末小结要点与证据边界。）\n\n', '', tag='NBLM分段注2')
rep('如果需要生成段4《源引用对照》清单，请随时告诉我，我将为您输出包含全部20份笔记本源文件名称、编号及引用的对照表。\n\n', '', tag='AI尾1')
rep('\n💡 如需将第8章完整初稿及其对照清单导出为标准Markdown文档或排版报告，我可以协助整理归档。', '', tag='AI尾2')
rep('## 《源引用对照》清单', '## 本章尾注（事实锚源对照）', tag='尾注标题')
rep('### 8.2.3 临泉县土地建筑工程有限公司与阜阳市建颍房地产开发有限公司、阜阳市建颍房地产公司案',
    '### 8.2.3 临泉县土地建筑工程有限公司与阜阳市建颍房地产开发有限公司案', tag='8.2.3标题残留')
rep('未在约定期限内提交书面书面通知', '未在约定期限内提交书面通知', tag='重复字1')
rep('提交一份一份详尽的最终索赔报告', '提交一份详尽的最终索赔报告', tag='重复字2')
rep('要求补充补充材料', '要求补充材料', tag='重复字3')
for num in ['5.49','5.50','5.51','5.52','5.53','5.56','5.57','5.54']:
    old = f'（{num}）'
    if old in t:
        t = t.replace(old, '', 1); log.append(f'[FIDIC编号删] {old}')

# ghost case numbers in evidence-boundary sentence 1
rep('1. **判例语料与案号真实性边界**：本章所引用的建工判例——西安怡合装饰有限责任公司案（2015）雁民初字第09694号、温州二井建设有限公司案、临泉县土地建筑工程有限公司案、豫1133号案、（2016）冀民初143/162号案等——均取自判决语料切片实收全文；判例的当事人名称、案号、金额在正文引用处均已按源文全称标注，本节汇总处使用简称。',
    '1. **判例语料与案号真实性边界**：本章所引用的建工判例——西安怡合装饰有限责任公司案（2015）雁民初字第09694号(P000701)、温州二井建设有限公司案（2013）浙温民终字第1545号(P000708)、临泉县土地建筑工程有限公司案（2010）阜民一初字第0032号(P000713)、牟锦与张明龙等分包合同案（2016）川08民终128号(P000715)，以及最高人民法院（2017）最高法民再97号判决(P000709)——均取自判决语料切片与律所实务文章的实收全文；判例的当事人名称、案号、金额在正文引用处均已按源文全称标注，本节汇总处使用简称。',
    tag='幽灵案号重写')

# FIDIC 20.1 quote: keep bank-attested text anchored, move 28-day text to unanchored + declared
rep('> **FIDIC第20.1款失权后果警告**：“如果承包商未能在28天的期限内发出索赔通知，则竣工时间不得延长，承包商无权获得附加付款，而雇主应免除有关索赔的一切责任。”(P000702)',
    '> **FIDIC第20.1款［承包商的索赔］原文（实证语料收录段）**：“如果承包商根据本合同条件的任何条款或参照合同的其他规定，认为他有权获得任何竣工时间的延长和（或）任何附加款项，他应通知工程师，说明引起索赔的事件或情况……”(P000702)\n   >\n   > **失权后果警告（依通行文本如实转录）**：“如果承包商未能在28天的期限内发出索赔通知，则竣工时间不得延长，承包商无权获得附加付款，而雇主应免除有关索赔的一切责任。”该28天时限与失权后果表述系依FIDIC通行文本转录，实证语料切片未收录该段，实务引用请以正式合同文本为准。',
    tag='FIDIC引文分层')

# ---------- B. adversarial writebacks (12 bear items + 2 final-round) ----------
rep('发承包双方常因责任界定不清、证据链撕裂或计价依据缺失而陷入长期诉讼纠纷[4][5][3][6]。',
    '发承包双方常因责任界定不清、证据链撕裂或计价依据缺失而陷入长期诉讼纠纷[4][5][3][6]；而当合同对停窝工补偿标准已有明确约定时，双方亦可径按约定快速清算，未必成讼[5]。', tag='回写A2/A11')
rep('帮助读者在施工全过程与争议解决阶段构建严密的风险隔离与损失填补防线[4][1][2][3]。',
    '帮助读者在施工全过程与争议解决阶段构建严密的风险隔离与损失填补防线[4][1][2][3]。责任界定与补偿标准的裁判标尺，见本章8.2节判例谱系；可直接落地的证据链构建方法，见8.5节“七要素”时间账体系。', tag='回写终局头部')
rep('1. **补偿性**：停窝工索赔旨在填补无过错方因干扰事件遭受的实际经济损失，不具备惩罚性，赔偿金额以实际发生的受损数额为限[1]。',
    '1. **补偿性**：停窝工索赔旨在填补无过错方因干扰事件遭受的实际经济损失，不具备惩罚性，赔偿金额以实际发生的受损数额为限[1]；双方以特别约定预先确立定额补偿标准的，法院依法按合意执行，此时补偿数额可与逐项举证的实际损失脱钩[5]。', tag='回写A4')
rep('3. **客观性**：承包人必须确实发生了人、财、物等资源的闲置与额外费用支出，若停工事件未造成实际经济损失，则不能获得费用补偿[1][4]。',
    '3. **客观性**：承包人必须确实发生了人、财、物等资源的闲置与额外费用支出，若停工事件未造成实际经济损失，则不能获得费用补偿[1][4]；损失的有无与幅度取决于停工时长、在场资源闲置规模等实际状况，并非一有停工即生巨大损失[1]。', tag='回写A1')
rep('4. **自身无过错性**：导致停窝工发生的干扰事件须归因于发包人（如图纸延误、付款迟延、未按时提供场地）、第三方或不可抗力等非承包人责任的事由[1][6]。',
    '4. **自身无过错性**：导致停窝工发生的干扰事件须归因于发包人（如图纸延误、付款迟延、未按时提供场地）、第三方或不可抗力等非承包人责任的事由[1][6]；政府资源整合等政策性因素导致的工程停滞，即属双方均无过错的停工事由[5]，而承包人自身质量缺陷返工、投入不足导致的停工，其损失由承包人自担[6]。', tag='回写A3/A5')
rep('当停窝工事件发生时，承包人的费用索赔范围必须严格限定在因停工直接增加的合理开支或资源闲置损失之内[1][7]。',
    '当停窝工事件发生时，承包人的费用索赔范围必须严格限定在因停工直接增加的合理开支或资源闲置损失之内[1][7]；现场与总部管理费等间接费用，仅在合同解除等法定条件成就时方可一并主张[1]。', tag='回写A6')
rep('在司法实践中，承包人主张停窝工损失的胜诉率普遍较低，其核心原因在于未能满足严格的举证要件与程序性门槛[4][3]。',
    '在司法实践中，承包人主张停窝工损失的胜诉率普遍较低，败因集中于两类：一是原始证据链缺失，仅有单方汇总表或利害关系人证言而缺乏原始签认凭证[4]；二是程序性失权，未按合同约定时限提交书面通知[4]。', tag='回写A7')
rep('若承包人未在约定期限内提交书面通知或未办理工期签证，将承担索赔权丧失的致命风险[4][1][7]。',
    '若承包人未在约定期限内提交书面通知或未办理工期签证，将承担索赔权丧失的致命风险[4][1][7]；而在合同无效情形下，承包人仍可依法主张折价补偿与损失赔偿，举证不能的后果由主张方自行承担[8]。', tag='回写A8/A12')
rep('为明确司法审判对停窝工损失的裁判尺度，本节选取笔记本资料中的四个典型判例，严格按照「案情-争议焦点-裁判要点-实务教训」格式展开拆解[4][5][6][8]。',
    '为明确司法审判对停窝工损失的裁判尺度，本节选取笔记本资料中的四个典型判例，严格按照「案情-争议焦点-裁判要点-实务教训」格式展开拆解[4][5][6][8]。四案合观，裁判逻辑的共性在于：合同约定的程序要件与实际履行的证据留存之间的落差，正是停窝工索赔成败的分水岭；承包方自身延误或质量缺陷，同样会触发停窝工责任的承担[4][6]。', tag='回写A9/终局8.2')

# closing point 7 in summary (CJK margin + synthesis)
rep('6. **EPC模式与非诉调解实务**：EPC总价包干下发包人初始资料重大缺陷、审批迟延仍构成停工索赔事由[05, 10, 17]。调解应遵循“责任核算-损失拆分-筹码交换-司法确认”四步法，通过工期顺延与费用妥协实现商业止损与总结算闭环[06, 12, 19]。',
    '6. **EPC模式与非诉调解实务**：EPC总价包干下发包人初始资料重大缺陷、审批迟延仍构成停工索赔事由[05, 10, 17]。调解应遵循“责任核算-损失拆分-筹码交换-司法确认”四步法，通过工期顺延与费用妥协实现商业止损与总结算闭环[06, 12, 19]。\n7. **裁判规则合观**：判例谱系显示，法院对停窝工损失的取舍始终围绕「合同约定—履行证据—损失量化」三点闭环展开：有约定按约定执行(P000708)，无约定看原始凭证(P000701)，凭证不能则由举证方自担不利后果(P000715)。', tag='收束句')

# evidence boundary: add transcription declaration for un-anchored numeric content
rep('对于笔记本资料未包含的国际仲裁机构具体规则或特定地方性补充定额，本章严格保持证据边界，不予延伸推定。',
    '对于笔记本资料未包含的国际仲裁机构具体规则或特定地方性补充定额，本章严格保持证据边界，不予延伸推定。另注：本章所引FIDIC第20.1款索赔时限（28天通知期/42天报告期）、赶工加班工资倍率与降效系数区间等时限、系数类数字，系依初稿所据实收专著通行文本如实转录，实证语料切片未收录该部分页码，实务引用请以正式合同文本与定额标准为准。',
    tag='边界声明补')

# ---------- C. position-aware [N] -> P anchor replacement ----------
SEG2 = t.index('## 8.4 ')
head, tail = t[:SEG2], t[SEG2:]

LOCAL = {'1':'P000702','2':'P000714','3':'P000709','4':'P000701','5':'P000708','6':'P000713','7':'P000702','8':'P000715'}
GLOBAL = {'1':'P000751','2':'P000752','3':'P000753','4':'P000701','5':'P000702','6':'P000703','7':'P000704','8':'P000705',
          '9':'P000706','10':'P000707','11':'P000708','12':'P000709','13':'P000710','14':'P000711','15':'P000712',
          '16':'P000713','17':'P000714','18':'P000715','19':'P000716','20':'P000717'}

# sentences whose citations must be DROPPED (bank-wide unsupported numeric tokens)
DROP_KEYS = [
    '28天内提交索赔意向通知书及书面损失报告',
    '考勤记录、劳动合同及工资发放流水',
    '机械折旧费+定期保养费',
    '超过合同约定的28天索赔期限',
    '通用条款第19.1款对索赔程序设立了三道防线',
    '28天内，向工程师/监理人递交书面索赔意向通知书',
    '按月（或每隔30天）',
    '28天内（或索赔事件发生后的42天内）',
    '1.5倍、2倍至3倍的人工工资补贴',
    '降效系数（如15%–30%）',
    '四大基本类型',
    '（Excusable & Compensable Delay）',
    '（Excusable & Non-compensable Delay）',
    '（Non-excusable & Non-compensable Delay）',
    '发包人初始要求（Employer\'s Requirements）',
    '（如28天失权期限）',
    '28天内向发包人发出索赔意向通知书以锁定权益',
    '（Long-lead Items）',
    '连续停工超过14天或关键线路延误超过7天',
    '停工发生24小时内',
    '专家对抗调解、商事调解、五位一体闭环解纷',
    '28天时限规则',
    '初始延误决定原则',
    '《赶工指令》或双方签署的《压缩工期协议》',
    '默示/构造性赶工（Constructive Acceleration）',
    '《提前竣工协议》',
    '初始基线进度计划（As-Planned）；其次',
    '（如P6或Project源文件）',
    '免死金牌',
    '“赶工指令”',
]

def drop_ranges(text):
    """return char ranges of sentences (up to next 。/；/table cell boundary) containing DROP_KEYS, AFTER anchor replacement those anchors inside get stripped"""
    spans = []
    for key in DROP_KEYS:
        for m in re.finditer(re.escape(key), text):
            s = text.rfind('\n', 0, m.start()) + 1          # line scope is enough
            e = text.find('\n', m.end())
            e = len(text) if e == -1 else e
            spans.append((s, e))
    return spans

def to_drop(pos, spans):
    return any(s <= pos < e for s, e in spans)

BRACKET = re.compile(r'\[\s*(\d{1,2}(?:\s*,\s*\d{1,2})*)\s*\]')

def convert(seg, table):
    spans = drop_ranges(seg)
    def repl(m):
        return '\x00' + m.group(1) + '\x00'
    tmp = BRACKET.sub(repl, seg)
    # now collapse consecutive \x00..\x00 groups glued directly
    tmp = re.sub(r'(\x00[\d,\s]+\x00)(\x00[\d,\s]+\x00)+', lambda m: '\x00' + ','.join(x.strip('\x00 ') for x in re.findall(r'\x00([\d,\s]+)\x00', m.group(0))) + '\x00', tmp)
    def back(m):
        pos = m.start()
        if to_drop(pos, spans):
            return ''
        nums = re.split(r'\s*,\s*', m.group(1).strip())
        seen, ps = set(), []
        for n in nums:
            key = n.lstrip('0') or n
            p = table.get(key)
            if p and p not in seen:
                seen.add(p); ps.append(p)
        return '(' + '/'.join(ps) + ')' if ps else ''
    return re.sub(r'\x00([\d,\s]+)\x00', back, tmp)

# for head (seg1) drop-spans must be computed on pre-converted text; convert() does that internally
head2 = convert(head, LOCAL)
tail2 = convert(tail, GLOBAL)
t = head2 + tail2

# strip now-dangling '  ' double spaces before newline (from deleted [N] after bold markers)
t = re.sub(r'[ \t]+\n', '\n', t)
t = re.sub(r'\n{3,}', '\n\n', t)

open(SRC, 'w', encoding='utf-8', newline='\n').write(t)

cjk = len(re.findall(r'[\u4e00-\u9fff\u3400-\u4dbf]', t))
resid = len(re.findall(r'\[\s*\d{1,2}(?:\s*,\s*\d{1,2})*\s*\]', t))
anchors = sorted(set(re.findall(r'\(P\d{6}\)', t)))
print(f'CJK={cjk}  bytes={len(t.encode("utf-8"))}  residual[N]={resid}  distinct_anchors={len(anchors)}')
print('anchors:', ' '.join(a.strip("()") for a in anchors))
print('--- writebacks/log ---')
for l in log: print(l)
