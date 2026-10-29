# -*- coding: utf-8 -*-
# build themed digest mds from hits.jsonl (privacy-masked)
import json, re, sys, os
from collections import defaultdict

src = sys.argv[1] if len(sys.argv) > 1 else 'decrypted/hits.jsonl'
outd = os.path.dirname(os.path.abspath(src))

MASK = [
    (re.compile(r'1[3-9]\d{9}'), '1**********'),
    (re.compile(r'\b\d{17}[\dXx]\b'), '[身份证已脱敏]'),
    (re.compile(r'\b\d{16,19}\b'), '[账号已脱敏]'),
]
def mask(t):
    for rx, rep in MASK: t = rx.sub(rep, t)
    return t

THEMES = {
    'wechat4x_epc_overseas_chats.md': ('海外EPC/出海/国际工程 总线',
        re.compile(r'EPC|出海|海外|境外|国际工程|对外承包|一带一路|海外市场|海外项目|海外电力|国际电力', re.I)),
    'wechat4x_country_access_chats.md': ('国别市场与投标准入',
        re.compile(r'印尼|越南|沙特|阿联酋|迪拜|巴基斯坦|哈萨克|土耳其|孟加拉|肯尼亚|巴西|菲律宾|中亚|东南亚|中东|非洲|老挝|尼泊尔|乌兹别克|吉尔吉斯|塔吉克|蒙古|马来西亚|泰国|海外投标|国际招标|海外中标|准入|资质|属地化', re.I)),
    'wechat4x_risk_fidic_chats.md': ('FIDIC合同/索赔/风险一线信号',
        re.compile(r'FIDIC|索赔|超概算|亏损|银皮书|黄皮书|红皮书|纠纷|仲裁|违约|汇率|收款|垫资|应收|清欠', re.I)),
}

def theme_of(t):
    names = []
    for f, (title, rx) in THEMES.items():
        if rx.search(t): names.append(f)
    return names or [list(THEMES)[0]]

rows = []
with open(src, encoding='utf-8') as f:
    for line in f:
        try: rows.append(json.loads(line))
        except Exception: pass

buckets = defaultdict(list)
for r in rows:
    txt = r.get('text', '')
    for f in theme_of(r.get('text', '') + ' ' + ' '.join(r.get('kw', []))):
        buckets[f].append(r)

import datetime
summary = []
for fname, rows_ in buckets.items():
    title = THEMES[fname][0]
    rows_.sort(key=lambda r: r.get('ts') or 0)
    by_talker = defaultdict(list)
    for r in rows_: by_talker[r.get('talker_display', '?')].append(r)
    out = [f'# 微信4.x本地库语料: {title} (EPC-OVERSEAS S1)', '',
           '> 来源: 微信4.x加密库解密检索 (SQLCipher v4, 本机内存密钥只读验证); 一线从业者群聊/私聊纪要信号; 隐私内容已脱敏', '']
    for talker, rs in sorted(by_talker.items(), key=lambda kv: -len(kv[1])):
        out.append(f'## {talker} ({len(rs)}条命中)')
        for r in rs:
            ts = datetime.datetime.fromtimestamp(r['ts']).strftime('%Y-%m-%d %H:%M') if r.get('ts') else '?'
            kws = ','.join(r.get('kw', [])[:6])
            body = mask(r.get('text', '')).strip().replace('\r', '')
            if len(body) > 700: body = body[:700] + ' …[截断]'
            out.append(f'- [{ts}] {r.get("sender","?")} | 命中: {kws}')
            for ln in [l for l in body.split('\n') if l.strip()][:12]:
                out.append(f'  {ln.strip()}')
        out.append('')
    p = os.path.join(outd, fname)
    with open(p, 'w', encoding='utf-8') as fo:
        fo.write('\n'.join(out))
    summary.append(f'{fname}: {len(rows_)}条 / {os.path.getsize(p)}字节 / {len(by_talker)}会话')
print('\n'.join(summary) if summary else 'NO HITS')
