# -*- coding: utf-8 -*-
"""kp_smoke2_writepath — 写路径受控冒烟：上传→解析→SSE首事件(LLM连通)→任务回读

不烧全量生成：只跑到 explain 级 SSE 首个事件即断流。
产物任务留在服务器上（1条，兼作恢复证据）。
"""
from __future__ import annotations

import json
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

BASE = 'http://47.120.43.20:5100'
TENDER = r'E:\AI-Station\逆向工程\xique-reverse\extracted\TENDER.docx'


def sh(cmd: list[str], timeout: int = 60) -> tuple[int, str]:
    r = subprocess.run(cmd, capture_output=True, text=True, encoding='utf-8',
                       errors='replace', timeout=timeout)
    return r.returncode, (r.stdout or '') + (r.stderr or '')


def main() -> None:
    fails = []

    # 1) 上传 → cid
    code, out = sh(['curl', '-s', '--max-time', '60', '-F', f'file=@{TENDER}', f'{BASE}/api/upload'])
    print(f'upload: {out[:120]}')
    try:
        cid = json.loads(out)['cid']
    except Exception:
        raise SystemExit(f'[ABORT] upload bad resp: {out[:200]}')

    # 2) 任务回读（本地解析是否落库）
    code, out = sh(['curl', '-s', '--max-time', '15', f'{BASE}/api/task/{cid}'])
    info = json.loads(out)
    print(f"task: cid={cid} filename={info.get('filename')} stage={info.get('stage')}")
    if info.get('code') != 200 or info.get('filename') != 'TENDER.docx':
        fails.append('task-readback')

    # 3) SSE explain 首事件（LLM 端到端连通：服务器→智谱→token回流）
    code, out = sh(['curl', '-s', '-N', '--max-time', '45',
                    f'{BASE}/api/task/{cid}/stream/explain'], timeout=50)
    first = out.splitlines()[:4]
    print(f'sse explain rc={code} first-events: {first}')
    if 'event:' not in out and 'data:' not in out:
        fails.append('sse-explain')

    # 4) 再回读：explains 是否开始填充
    time.sleep(2)
    code, out = sh(['curl', '-s', '--max-time', '15', f'{BASE}/api/task/{cid}'])
    info = json.loads(out)
    expl = info.get('explains') or {}
    print(f'explains keys after sse: {list(expl.keys())[:5]}')
    if not expl:
        fails.append('explains-empty')

    if fails:
        raise SystemExit(f'[SMOKE2 FAIL] {fails} (cid={cid})')
    print(f'\n[SMOKE2 PASS] 写路径全通 (cid={cid}) — upload/parse/SSE-LLM/回读')


if __name__ == '__main__':
    main()
