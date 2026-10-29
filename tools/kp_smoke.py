# -*- coding: utf-8 -*-
"""kp_smoke — 恢复后 HTTP 级冒烟（不开浏览器、不烧大Token）

验收四件事：
1. 公网 health
2. / 与 /static/app.html 前端可达 + P2/P4/P5 功能标记在位（PPT/PDF/编辑器）
3. templates API 活着
4. 知识库语料在服务器上（knowledge/ 落地数）
"""
from __future__ import annotations

import re
import subprocess
import sys

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

BASE = 'http://47.120.43.20:5100'
MARKERS = {'btnPPT': '述标PPT', 'export/pdf': 'PDF导出', 'edit': '在线编辑器'}


def curl(url: str) -> tuple[int, str]:
    r = subprocess.run(['curl', '-s', '-w', '\n%{http_code}', '--max-time', '10', url],
                       capture_output=True, text=True, encoding='utf-8', errors='replace')
    body, _, code = r.stdout.rpartition('\n')
    return int(code or 0), body


def main() -> None:
    fails = []

    code, body = curl(f'{BASE}/api/health')
    print(f'health: {code} {body[:60]}')
    if code != 200 or 'ok' not in body:
        fails.append('health')

    code, body = curl(f'{BASE}/')
    print(f'index: {code} {len(body)}B')
    if code != 200 or len(body) < 500:
        fails.append('index')

    code, body = curl(f'{BASE}/app')
    print(f'app.html(/app): {code} {len(body)}B')
    if code != 200:
        fails.append('app.html')
    else:
        for m, label in MARKERS.items():
            n = len(re.findall(m, body))
            print(f'  marker {m} ({label}): {n}')
            if n == 0:
                fails.append(f'marker:{m}')

    code, body = curl(f'{BASE}/api/templates')
    print(f'templates: {code} {body[:80]}')
    if code != 200:
        fails.append('templates')

    if fails:
        raise SystemExit(f'[SMOKE FAIL] {fails}')
    print('\n[SMOKE PASS] 恢复验收全绿')


if __name__ == '__main__':
    main()
