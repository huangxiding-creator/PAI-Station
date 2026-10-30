# -*- coding: utf-8 -*-
"""overseas_gate2 — EPC-OVERSEAS 版数字-锚点互引门 (m2_gate2 的战役适配件).

判定逻辑与 m2_gate2.py 一致 (句内数字须逐字出现在该句引用的锚点文本中),
解析层适配本战役格式:
  - bank 锚点: `## P000050 (深读追加 N字)\n路径: ...\n出处: ...\n<正文>` 块式
  - 章节正文: 全文参与 (无 `## 一、` 旧章式假设)
冻结闸: 沿用 collection_gate_state.json user_approved (S1 满贯已呈批放行).
usage: py overseas_gate2.py <chapter_md> <bank_md>
exit:  0 = PASS / 1 = FAIL

1024 gate2 互引门 32 处 MISS 逐条裁决后的归一化补丁 (裁决账: a=25/b=6/c=0):
  N1 引用括号防切: [来源: P1；P2] 内全角分号原被当句界切走后半锚点 →
     切句前把方括号内的 `；` 替换为 `;` (仅括号内, 不动正文分号).
  N2 全角数字归一: docling 扫描件里 `９５％`/`２０２０` 等全角形 → norm 统一
     映射半角 (０-９/％/．), 章文数字与锚点同尺比对.
  N3 出处行入锚: 深读追加锚点的 `出处:` 行是采集件标题 (如 `海外工程洞察·
     投入5.5亿美元的孟加拉马士基拉尔迪亚码头破土动工`), 属锚点块正文的一部分 →
     计入可匹配文本; `路径:` 行仍排除 (文件名哈希含数字, 会假阳).
"""
import re, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

chap = open(sys.argv[1], encoding='utf-8').read()
bank = open(sys.argv[2], encoding='utf-8').read()

# ---- 解析 bank: `## Pxxxxxx` 块式锚点 → {id: 正文} (N3: 含 `出处:` 行) ----
src, cur, buf, meta = {}, None, [], ''
for line in bank.splitlines():
    m = re.match(r'##\s*(P\d{6})', line.strip())
    if m:
        if cur: src[cur] = meta + '\n' + '\n'.join(buf) if meta else '\n'.join(buf)
        cur, buf, meta = int(m.group(1)[1:]), [], ''
    elif cur is not None:
        if line.startswith('出处:'):
            meta = line
        elif not line.startswith('路径:'):
            buf.append(line)
if cur: src[cur] = meta + '\n' + '\n'.join(buf) if meta else '\n'.join(buf)

# N2: 全角数字/％/．→半角 (０-９=U+FF10..FF19, ％=U+FF05, ．=U+FF0E)
_FW = { **{c: c - 0xFEE0 for c in range(0xFF10, 0xFF1A)},
        0xFF05: 0x25, 0xFF0E: 0x2E }
norm = lambda x: x.translate(_FW).replace(',', '').replace('，', '').replace(' ', '')

# N1: 方括号内的全角 `；` 不作句界 (引用组 [来源: P1；P2] 保持同段同判)
body = re.sub(r'\[[^\[\]]*\]', lambda m: m.group(0).replace('；', ';'), chap)
checked = passed = 0
bad = []
for s in re.split(r'[。；\n]', body):
    if 'own_calc' in s: continue
    if re.search(r'P\d{6}\s*[-–—]', s): continue
    anchors = [int(x) for x in re.findall(r'P(\d{6})', s)]
    if not anchors: continue
    s_clean = re.sub(r'P\d{6}', '', s)
    nums = set(re.findall(r'\d[\d,]*(?:\.\d+)?(?=\s*(?:亿|万|％|%|个百分点))|(?<![\d.])(?:19|20)\d{2}(?![\d.])', s_clean))
    if not nums: continue
    ctxs = [src.get(a, '') for a in set(anchors)]
    for a in set(anchors):
        if not src.get(a): bad.append((a, 'ANCHOR_NOT_FOUND', ''))
    for nn in nums:
        checked += 1
        if any(c and norm(nn) in norm(c) for c in ctxs):
            passed += 1
        else:
            bad.append((anchors[0], f'NUM_{nn}', s[:70]))
ok = not bad
print(f"{sys.argv[1].split('/')[-1]}: num_checks={checked} passed={passed} fail={len(bad)} -> {'PASS' if ok else 'FAIL'}")
for b in bad[:12]: print('  MISS', b[0], b[1], '|', b[2])
sys.exit(0 if ok else 1)
