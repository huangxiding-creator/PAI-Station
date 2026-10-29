# -*- coding: utf-8 -*-
"""kp_e2e_scaled — 缩配全链 E2E：小标书跑通七级流水线+五导出+编辑器回写

覆盖: upload→explain→outline→确认→body→review→gantt→ppt
     → docx导出(红蓝灰任一)→PDF导出→PPTX导出→AI改写→保存回写
纯HTTP, 不开浏览器。SSE 靠服务端生成器耗尽自然断流(rc=0)作为完成信号。
"""
from __future__ import annotations

import json
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

BASE = 'http://47.120.43.20:5100'
TENDER = r'E:\AI-Station\tools\mini_tender.docx'
results: list[tuple[str, bool, str]] = []


def sh(cmd: list[str], timeout: int) -> tuple[int, str]:
    r = subprocess.run(cmd, capture_output=True, text=True, encoding='utf-8',
                       errors='replace', timeout=timeout)
    return r.returncode, (r.stdout or '')


def rec(name: str, ok: bool, note: str = '') -> None:
    results.append((name, ok, note))
    print(f'{"✔" if ok else "✘"} {name} {note}', flush=True)


def sse(cid: str, stage: str, max_time: int, fatal_errors: bool = True) -> tuple[bool, str]:
    """EventSource式SSE消费: 断流自动重连(生成器resume-aware), 直到终结事件/总超时。
    fatal_errors=False时error事件只记数不退场(body段级LLM错带bump_retry重试语义,浏览器端同样继续)。"""
    t0 = time.time()
    total = 0
    errors = 0
    consecutive_bad = 0
    last_tail = ''
    TERMS = ('"event": "done"', '"event": "all_done"', 'report_done', 'review_done',
             'gantt_done', 'ppt_done')
    while time.time() - t0 < max_time:
        try:
            r = subprocess.run(['curl', '-s', '-N', '--max-time', '600',
                                f'{BASE}/api/task/{cid}/stream/{stage}'],
                               capture_output=True, text=True, encoding='utf-8',
                               errors='replace', timeout=615)
            out = r.stdout or ''
        except subprocess.TimeoutExpired:
            out = ''
        lines = [l for l in out.splitlines() if l.startswith('data:')]
        total += len(lines)
        round_errs = sum(1 for l in lines if '"event": "error"' in l)
        errors += round_errs
        if lines:
            last_tail = lines[-1][:100]
        if any(any(t in l for t in TERMS) for l in lines):
            return True, f'events={total} errs={errors} tail={last_tail}'
        # 熔断: 连续5轮纯error(无终结事件)=确定性故障,别锤自家API
        consecutive_bad = consecutive_bad + 1 if round_errs else 0
        if fatal_errors and errors:
            return False, f'error-event events={total} tail={last_tail}'
        if consecutive_bad >= 5:
            return False, f'circuit-broken(连续5轮纯错) events={total} errs={errors} tail={last_tail}'
        time.sleep(1)
    return False, f'timeout({max_time}s) events={total} errs={errors} tail={last_tail}'


def task(cid: str) -> dict:
    return json.loads(sh(['curl', '-s', '--max-time', '15', f'{BASE}/api/task/{cid}'], 30)[1])


def main() -> None:
    t_start = time.time()

    # 1 上传
    out = sh(['curl', '-s', '--max-time', '60', '-F', f'file=@{TENDER}', f'{BASE}/api/upload'], 90)[1]
    cid = json.loads(out)['cid']
    rec('upload', bool(cid), f'cid={cid}')

    # 2 explain
    ok, note = sse(cid, 'explain', 240)
    expl = task(cid).get('explains') or {}
    rec('explain(SSE+LLM)', ok and len(expl) >= 2, f'{note} keys={list(expl)[:4]}')

    # 3 outline
    ok, note = sse(cid, 'outline', 300)
    info = task(cid)
    tree = info.get('outline')
    rec('outline(SSE)', ok and isinstance(tree, list) and len(tree) >= 3,
        f'{note} nodes={len(tree) if tree else 0}')

    # 4 确认大纲(修剪: 前3章×前2子叶, 控时长——LLM大纲非确定性可爆49叶)
    tree = (tree or [])[:3]
    for ch in tree:
        ch['children'] = (ch.get('children') or [])[:2]
        for cn in ch.get('children') or []:
            cn.pop('children', None)
    rc, out = sh(['curl', '-s', '--max-time', '15', '-X', 'PUT', '-H', 'Content-Type: application/json',
                  '-d', json.dumps({'outline': tree, 'confirmed': True}, ensure_ascii=False),
                  f'{BASE}/api/task/{cid}/outline'], 30)
    rec('outline-confirm(PUT+trim)', rc == 0 and '"code":200' in out, out[:60])

    # 5 body 全稿(段级error非致命,终判看任务态)
    ok, note = sse(cid, 'body', 900, fatal_errors=False)
    info = task(cid)
    secs = info.get('sections') or []
    n_done = sum(1 for s in secs if s.get('status') == 'done')
    min_chars = min((s.get('chars', 0) for s in secs if s.get('chars', 0) > 0), default=0)
    rec('body(全稿生成)', n_done == len(secs) and n_done >= 3 and min_chars >= 800,
        f'{note} sections={len(secs)} done={n_done} min_chars={min_chars}')

    # 6 review
    ok, note = sse(cid, 'review', 300)
    rec('review(SSE)', ok, note)

    # 7 gantt
    ok, note = sse(cid, 'gantt', 240)
    rc, out = sh(['curl', '-s', '--max-time', '15', f'{BASE}/api/task/{cid}/gantt'], 30)
    get_ok = '"code":200' in out
    rec('gantt(SSE+GET)', ok and get_ok, f'{note} get={get_ok}')

    # 8 ppt(SSE超时不判死: 服务器端生成常以孤儿方式完赛,轮询GET对齐)
    ok, note = sse(cid, 'ppt', 600)
    ppt_get_ok = False
    for _ in range(36):
        rc, out = sh(['curl', '-s', '--max-time', '15', f'{BASE}/api/task/{cid}/ppt'], 30)
        if '"code":200' in out:
            ppt_get_ok = True
            break
        time.sleep(5)
    rec('ppt(SSE+GET)', ppt_get_ok, f'{note} get={ppt_get_ok}')

    # 9 三导出
    for label, url, magic in [
        ('export-docx', f'{BASE}/api/task/{cid}/export?style=blue', b'PK'),
        ('export-pdf', f'{BASE}/api/task/{cid}/export/pdf', b'%PDF'),
        ('export-pptx', f'{BASE}/api/task/{cid}/ppt/export?style=blue', b'PK'),
    ]:
        r = subprocess.run(['curl', '-s', '--max-time', '60', url], capture_output=True, timeout=90)
        ok = r.returncode == 0 and len(r.stdout) > 4000 and r.stdout.startswith(magic)
        rec(label, ok, f'{len(r.stdout)}B magic={r.stdout[:4]}')

    # 10 编辑器: AI改写 + 保存回写 (action词表=rewrite/expand/polish/shorten; sid含#必须urlencode)
    from urllib.parse import quote
    sid = quote(secs[0]['id'], safe='') if secs else ''
    rc, out = sh(['curl', '-s', '--max-time', '90', '-X', 'POST', '-H', 'Content-Type: application/json',
                  '-d', json.dumps({'action': 'polish', 'text': '渠道衬砌采用C25现浇混凝土，厚度十厘米，底部铺设复合土工膜防渗。'}, ensure_ascii=False),
                  f'{BASE}/api/task/{cid}/edit/{sid}'], 120)
    try:
        ok_edit = json.loads(out).get('code') == 200
    except Exception:
        ok_edit = False
    rec('editor-ai-edit', ok_edit, out[:80])

    rc, out = sh(['curl', '-s', '--max-time', '30', '-X', 'POST', '-H', 'Content-Type: application/json',
                  '-d', json.dumps({'content': 'E2E回写验证段落：本段由缩配E2E写入，验证编辑器保存链路。'}, ensure_ascii=False),
                  f'{BASE}/api/task/{cid}/save/{sid}'], 60)
    rec('editor-save', rc == 0 and '"code":200' in out, out[:60])

    # 收官
    n_pass = sum(1 for _, ok, _ in results if ok)
    print(f'\n{"[E2E SCALED PASS]" if n_pass == len(results) else "[E2E SCALED FAIL]"} '
          f'{n_pass}/{len(results)} · {time.time()-t_start:.0f}s · cid={cid}', flush=True)
    if n_pass != len(results):
        raise SystemExit(1)


if __name__ == '__main__':
    main()
