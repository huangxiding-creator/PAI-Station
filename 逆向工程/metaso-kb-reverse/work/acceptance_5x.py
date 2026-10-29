# -*- coding: utf-8 -*-
"""acceptance_5x.py — 5次独立会话贯通验收 (检索→清单→下载; 下载仅S1, 累计≤3次)"""
import json, subprocess, sys, os
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
REP = r'E:/AI-Station/逆向工程/metaso-kb-reverse/replica/metaso_kb_api.py'
CAP = r'E:/AI-Station/逆向工程/metaso-kb-reverse/captures'
PY = sys.executable
kws = ['EPC', '工程', '研报', '合同', '水利']
results = []
for i, kw in enumerate(kws, 1):
    jout = os.path.join(CAP, f'accept_s{i}_{kw}.json')
    p = subprocess.run([PY, REP, 'search', kw, '--size', '20', '--json', jout, '--quiet'],
                       capture_output=True, text=True, encoding='utf-8', timeout=180)
    line = (p.stdout or '').strip().splitlines()
    ok = p.returncode == 0 and line and 'hits=' in line[0]
    n = 0
    if ok:
        try:
            n = len(json.load(open(jout, encoding='utf-8'))['files'])
        except Exception:
            pass
    dl = None
    if ok and i == 1:  # 下载尝试仅S1 (累计含探针≤3)
        try:
            fid = json.load(open(jout, encoding='utf-8'))['files'][0]['id']
            d = subprocess.run([PY, REP, 'download', fid, '--out', os.path.join(CAP, f'dl_probe_{fid}.bin'), '--quiet'],
                               capture_output=True, text=True, encoding='utf-8', timeout=300)
            dl = (d.stdout or '').strip()[:120]
        except Exception as e:
            dl = 'ERR ' + str(e)[:80]
    results.append({'session': i, 'kw': kw, 'search_ok': ok, 'files': n, 'download': dl})
    print(f"S{i} [{kw}] search={'PASS' if ok else 'FAIL'} files={n} download={dl or '-'}")
json.dump(results, open(os.path.join(CAP, 'acceptance_5x.json'), 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
ok_n = sum(1 for r in results if r['search_ok'])
print(f"\n== 5x独立会话: search {ok_n}/5 通过; download段: S1={results[0]['download']}")
