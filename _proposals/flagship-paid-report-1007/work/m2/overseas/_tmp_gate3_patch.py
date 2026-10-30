# -*- coding: utf-8 -*-
"""gate3 锚点传播补丁: 对四章真缺口句句尾追加短式锚点; 表格行唯一例外=ch9效率之困行
(全章唯一'35'载体, 无传递路径, 按本章既有in-cell锚惯例在'剩余35%是盲区'后插锚, 零数字改动).
每键须命中恰好一条缺口句; 插入点降序应用; 二进制读写保原样."""
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

FW = '：'  # ch9 全角冒号风格
EDITS = {
 '01': [
   ('当年签订合同9933份', 'P000031'),
   ('占同期中国对外承包工程新签合同总额的55.4', 'P000031'),
   ('清洁能源占比65.1', 'P000032'),
 ],
 '07': [
   ('预估总价约为8960万美元', 'P000607'),
   ('国际收入占总收入比重约5.1', 'P000619'),
 ],
 '09': [
   ('同样1%的风险敞口', 'P000853'),
   ('组成伊江上游水电有限责任公司', 'P000909'),
   ('自2006年就与缅甸第一电力部签署谅解备忘录', 'P000908'),
   ('《关于合作开发缅甸水电资源的框架协议》', 'P000908'),
   ('2015年10月签署的全国停火协议', 'P000909'),
   ('50个牧师搜集了4100个反对签名', 'P000909'),
   ('合同金额66.5亿沙特里亚尔', 'P000902'),
   ('仅此一项就增加成本4-5亿元', 'P000902'),
   ('运送旅客209.4万余人次', 'P000904'),
   ('累计运送朝觐者超过2500万人次', 'P000904'),
   ('实施位于利比亚的2000套住宅及配套服务设施工程', 'P000905'),
   ('就多个大学校园工程项目签订《公共工程合同》', 'P000905'),
   ('《利比亚住房项目合作协议》和《大学城合作协议》', 'P000905'),
   ('向武汉仲裁委员会提起仲裁', 'P000905'),
   ('并提供5.98亿信用担保', 'P000905'),
   ('总投资27.3亿美元', 'P000906'),
   ('占老挝18吉瓦水电总装机容量的7%', 'P000906'),
   ('月度电费拖欠共计4.863亿美元', 'P000906'),
   ('透水事故（2021年）', 'P000851'),
   ('"9·24"事故（2022年）', 'P000851'),
   ('于1931年在《工业事故预防》', 'P000851'),
   ('水利部2022年印发', 'P000851'),
   ('剩余35%是盲区', 'P000851'),  # 表格行 in-cell (after_key)
 ],
 '12': [
   ('其中国有控股企业利润3669亿元', 'P001167'),
   ('全年建筑业增加值86425亿元', 'P001165'),
   ('完成营业额1659.70亿美元，比上年增长3.14', 'P001167'),
   ('国家完成营业额10902亿元', 'P001165'),
   ('比上年增加6.2万人', 'P001167'),
   ('劳务合作项下派出25.6万人', 'P001167'),
   ('占全球投资的比重增加到7.4', 'P001166'),
   ('其中雇用外方员工296.5万人', 'P001166'),
   ('占全国就业人员比重为65.6', 'P001165'),
   ('占比较去年小幅提升0.5个百分点', 'P001168'),
   ('平均国际营业额19.04亿美元', 'P001168'),
   ('创近10年最大增幅', 'P001167'),
   ('占比较上年度降低2.9个百分点', 'P001167'),
   ('市场占有率占到70%左右', 'P001162'),
   ('设备台套数超过7万台套', 'P001151'),
   ('约60%—70%的现场变更与返工', 'P001151'),
   ('2018年10月发布', 'P001174'),
 ],
}
TBL_KEY = '剩余35%是盲区'  # ch09 表格行 in-cell 插入键

num_pat = re.compile(
    r'\d[\d,]*(?:\.\d+)?(?=\s*(?:亿|万|％|%|个百分点))|(?<![\d.])(?:19|20)\d{2}(?![\d.])')
_FWr = { **{c: c - 0xFEE0 for c in range(0xFF10, 0xFF1A)},
         0xFF05: 0x25, 0xFF0E: 0x2E }
norm = lambda x: x.translate(_FWr).replace(',', '').replace('，', '').replace(' ', '')

for ch, edits in EDITS.items():
    path = f'sched/_ch{ch}_p1.md'
    raw = open(path, 'rb').read().decode('utf-8')
    body = re.sub(r'\[[^\[\]]*\]', lambda m: m.group(0).replace('；', ';'), raw)

    parts, pos = [], 0
    for m in re.finditer(r'[。；\n]', body):
        parts.append((pos, body[pos:m.start()], m.start()))
        pos = m.start() + 1
    parts.append((pos, body[pos:], len(body)))

    def nums_of(s, anchored):
        t = s
        if anchored:
            t = re.sub(r'\[[^\[\]]*[来源来][^\[\]]*\]', '', t)
            t = re.sub(r'P\d{6}', '', t)
        return [norm(x) for x in num_pat.findall(t)]

    pool = set()
    for _, s, _ in parts:
        if 'own_calc' in s: continue
        if re.search(r'P\d{6}', s):
            pool.update(nums_of(s, True))

    gaps = []
    for st, s, en in parts:
        if 'own_calc' in s or re.search(r'P\d{6}', s): continue
        ns = nums_of(s, False)
        if any(n not in pool for n in ns):
            gaps.append((st, s, en))

    ins = []          # (position, insert_text)
    used = set()
    for st, s, en in gaps:
        hits = [k for k, a in edits if k in s]
        if len(hits) == 0: continue          # 传递化解, 无需编辑
        if len(hits) > 1:
            sys.exit(f'ch{ch}: 缺口句命中多键 {hits} | {s[:60]}')
        k = hits[0]
        if k in used:
            sys.exit(f'ch{ch}: 键 [{k}] 命中多条缺口句')
        used.add(k)
        anchor = dict(edits)[k]
        tag = f' [来源{FW} {anchor}]' if ch == '09' else f' [来源: {anchor}]'
        if k == TBL_KEY:  # in-cell: 紧跟键后插入
            ins.append((raw.find(k) + len(k), tag))
        else:             # 句尾(终结符前)插入
            ins.append((en, tag))

    leftover = [k for k, _ in edits if k not in used]
    if leftover:
        sys.exit(f'ch{ch}: 未消费键 {leftover}')
    unresolved = [s.strip()[:60] for st, s, en in gaps
                  if not any(k in s for k, _ in edits)]
    for p, tag in sorted(ins, reverse=True):
        raw = raw[:p] + tag + raw[p:]
    open(path, 'wb').write(raw.encode('utf-8'))
    print(f'ch{ch}: gaps={len(gaps)} edits={len(ins)} transitive={len(unresolved)}')
    for u in unresolved: print('   TRANSITIVE-ONLY:', u)
