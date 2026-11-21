# -*- coding: utf-8 -*-
"""jes2 chapters 9-12 collation audit (reusable). Usage: py -3 _audit_jes2.py 09|10|11|12"""
import re, io, sys
def audit(nn):
    final = f'_ch{nn}_final.md'; bank = f'bank_ch{nn}.md'
    t = io.open(final, encoding='utf-8').read()
    bankt = io.open(bank, encoding='utf-8', errors='replace').read()
    bank_anchors = set(re.findall(r'^## (P\d{6})', bankt, re.M))
    try:
        src = io.open(f'_ch{nn}_nb_draft.md', encoding='utf-8').read()
    except FileNotFoundError:
        src = ''  # NB通道死钉选兜底: 无nb_draft, 门=15000
    src_cjk = len(re.findall(r'[\u4e00-\u9fff]', src))
    cjk = len(re.findall(r'[\u4e00-\u9fff]', t))
    gate = max(15000, src_cjk)
    out = [f'== {final}: CJK {cjk} / gate {gate} {"PASS" if cjk>=gate else "FAIL"} (source {src_cjk})']
    h1 = re.findall(r'^# (.+)$', t, re.M)
    out.append(('h1=%d %s' % (len(h1), 'PASS' if len(h1)==1 else 'FAIL')))
    h2m = re.findall(r'^## (\d+)\.(\d+) ', t, re.M)
    minors = [int(b) for a,b in h2m]
    seq = all(minors[i+1]==minors[i]+1 for i in range(len(minors)-1)) and minors and minors[0]==1
    out.append(('h2 minor seq=%s %s' % (minors, 'PASS' if seq else 'FAIL'))
               if True else '')
    h3m = re.findall(r'^### (\d+)\.(\d+)\.(\d+) ', t, re.M)
    parents = {}
    ok3 = True
    for a,b,c in h3m:
        k = f'{a}.{b}'
        if k in parents:
            if int(c) != parents[k]+1: ok3 = False
        else:
            if int(c) != 1: ok3 = False
        parents[k] = int(c)
    # parent existence
    h2keys = {f'{a}.{b}' for a,b in h2m}
    orphan = [k for k in parents if k not in h2keys]
    out.append(f'h3={len(h3m)} seq={"PASS" if ok3 else "FAIL"} orphan={orphan if orphan else "none"}')
    for pat, name, fail in [(r'^出品[:：]','出品行',True),(r'纪律声明','纪律声明块',True),(r'```','代码围栏',True),
                            (r'[│┌┐└┘├┤─┬┴╔╗╚╝═]','ASCII框线',True),(r'^\s*[-*+] ','无序列表',True),(r'^#### ','四级标题',True),
                            (r'\$[^$]+\$','LaTeX',True)]:
        m = re.findall(pat, t, re.M)
        out.append(f'{name}={len(m)} {"FAIL" if (m and fail) else "PASS"}')
    anchors = sorted(set(re.findall(r'P\d{6}', t)))
    ghosts = [a for a in anchors if a not in bank_anchors]
    out.append(f'anchors={len(anchors)} ghosts={ghosts if ghosts else "0 PASS"}')
    tail_i = t.rfind('本章尾注')
    tail = t[tail_i:]
    body = t[:tail_i]
    fn_anchors = set(re.findall(r'P\d{6}', tail))
    missing = sorted(a for a in set(re.findall(r'P\d{6}', body)) if a not in fn_anchors)
    out.append(f'尾注覆盖 missing={missing if missing else "0 PASS"}')
    lines = t.split('\n')
    bad_tbl = []
    for i,l in enumerate(lines):
        if re.match(r'^\|[-| :]+\|$', l.strip()):
            j = i-1
            while j>=0 and not lines[j].strip(): j-=1
            if j>=0 and lines[j].strip().startswith('|') and not re.match(r'^表\d+-\d+ ', lines[j-1].strip() if j-1>=0 else ''):
                # check line above header
                k = j-1
                while k>=0 and not lines[k].strip(): k-=1
                if k<0 or (not re.match(r'^表\d+-\d+ ', lines[k].strip()) and '尾注' not in lines[k].strip() and '本章' not in lines[k].strip()):
                    bad_tbl.append(i)
    out.append(f'表标题独立行 bad={bad_tbl if bad_tbl else "0 PASS"}')
    bold = re.findall(r'^\*\*[^*]+\*\*$', t, re.M)
    out.append(f'加粗独立段={len(bold)} {"PASS" if bold else "FAIL"}')
    resid = {w: t.count(w) for w in ['NBLM','下一段将继续输出','是否需要我','AI生成','语料库','面板','Studio','出品：'] if t.count(w)}
    out.append(f'残留词={resid if resid else "0 PASS"}')
    xulie = re.findall(r'本章小结', t)
    bianjie = re.findall(r'本章证据边界与数据说明', t)
    weizhu = re.findall(r'本章尾注', t)
    out.append(f'尾部三件套 小结={len(xulie)} 边界={len(bianjie)} 尾注={len(weizhu)}')
    io.open(f'_audit_ch{nn}_final_report.txt','w',encoding='utf-8').write('\n'.join(out))
    print('\n'.join(out))
if __name__ == '__main__':
    for nn in sys.argv[1:]: audit(nn)
