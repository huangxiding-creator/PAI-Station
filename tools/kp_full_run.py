# -*- coding: utf-8 -*-
"""kp_full_run — 全量真实标书试跑·实录台

条件: 真实招标文件 + 大纲不修剪 + 真实并发(4) + 全闸门 + 全导出
实录: tools/fullrun/ 下逐段SSE原文+时间线JSON+任务快照流+终报
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from datetime import datetime
from pathlib import Path
from urllib.parse import quote

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

BASE = 'http://47.120.43.20:5100'
TENDER = r'E:\AI-Station\逆向工程\xique-reverse\extracted\TENDER.docx'
OUT = Path(r'E:\AI-Station\tools\fullrun_r3')
OUT.mkdir(exist_ok=True)

timeline: list[dict] = []
t0 = time.time()


def log(msg: str, echo: bool = True) -> None:
    e = {'t': round(time.time() - t0, 1), 'at': datetime.now().strftime('%H:%M:%S'), 'msg': msg}
    timeline.append(e)
    (OUT / 'timeline.json').write_text(json.dumps(timeline, ensure_ascii=False, indent=1), encoding='utf-8')
    if echo:
        print(f"[{e['at']} +{e['t']:>7.1f}s] {msg}", flush=True)


def sh(cmd: list[str], timeout: int = 60) -> tuple[int, str]:
    r = subprocess.run(cmd, capture_output=True, text=True, encoding='utf-8',
                       errors='replace', timeout=timeout)
    return r.returncode, (r.stdout or '')


def task(cid: str) -> dict:
    return json.loads(sh(['curl', '-s', '--max-time', '15', f'{BASE}/api/task/{cid}'], 30)[1])


TERMS = ('"event": "done"', '"event": "all_done"', 'report_done', 'review_done',
         'gantt_done', 'ppt_done')


def sse_stage(cid: str, stage: str, max_total: int, fatal: bool = True) -> dict:
    """EventSource式重连消费 + SSE原文落盘 + 事件统计。返回 {ok, events, errs, secs}"""
    fname = OUT / f'stage_{stage}.sse'
    total_events, errs, first_t, last_event_t = 0, 0, time.time(), time.time()
    deadline = time.time() + max_total
    with open(fname, 'w', encoding='utf-8') as f:
        while time.time() < deadline:
            try:
                p = subprocess.Popen(
                    ['curl', '-s', '-N', '--max-time', '900',
                     f'{BASE}/api/task/{cid}/stream/{stage}'],
                    stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True,
                    encoding='utf-8', errors='replace')
                assert p.stdout is not None
                done = False
                for line in p.stdout:
                    f.write(line)
                    f.flush()
                    if line.startswith('data:'):
                        total_events += 1
                        last_event_t = time.time()
                        if any(t in line for t in TERMS):
                            done = True
                            break
                        if '"event": "error"' in line:
                            errs += 1
                            if fatal:
                                done = True
                                break
                p.terminate()
            except Exception as e:  # noqa: BLE001
                f.write(f'# client: {e}\n')
            if done:
                return {'ok': True, 'events': total_events, 'errs': errs,
                        'secs': round(time.time() - first_t, 1)}
            # 断流: 轮询任务态判完成(孤儿管线可能已完赛)
            time.sleep(2)
    return {'ok': False, 'events': total_events, 'errs': errs,
            'secs': round(time.time() - first_t, 1)}


def snapshot_loop(cid: str, stop_flag: Path, interval: int = 60) -> None:
    """后台快照流: 每60s记录节数/字数/状态分布(吞吐曲线原料)。"""
    snaps = []
    while not stop_flag.exists():
        try:
            d = task(cid)
            secs = d.get('sections') or []
            from collections import Counter
            snaps.append({'t': round(time.time() - t0, 1),
                          'done': sum(1 for s in secs if s['status'] == 'done'),
                          'gen': sum(1 for s in secs if s['status'] == 'generating'),
                          'chars': sum(s.get('chars', 0) for s in secs)})
            (OUT / 'snapshots.json').write_text(json.dumps(snaps, ensure_ascii=False), encoding='utf-8')
        except Exception:  # noqa: BLE001
            pass
        time.sleep(interval)


def main() -> None:
    log(f'全量真实试跑启动: {TENDER.split(chr(92))[-1]} (并发4·不修剪·全闸门)')

    # 1 上传
    rc, out = sh(['curl', '-s', '--max-time', '120', '-F', f'file=@{TENDER}', f'{BASE}/api/upload'], 130)
    cid = json.loads(out)['cid']
    log(f'upload OK cid={cid}')

    # 2 explain
    r = sse_stage(cid, 'explain', 600)
    ex = task(cid).get('explains') or {}
    log(f"explain {'OK' if r['ok'] else 'FAIL'} {r['secs']}s events={r['events']} "
        f"bid_type={(ex.get('bid_type') or {}).get('type')} clauses={len((ex.get('clauses') or {}).get('clauses') or [])}")

    # 3 outline — 不修剪, 原样确认
    r = sse_stage(cid, 'outline', 600)
    d = task(cid)
    tree = d.get('outline') or []
    leaves = sum(len(c.get('children') or []) or 1 for c in tree)
    log(f"outline {'OK' if r['ok'] else 'FAIL'} {r['secs']}s 章={len(tree)} 叶≈{leaves}")
    rc, out = sh(['curl', '-s', '--max-time', '15', '-X', 'PUT', '-H', 'Content-Type: application/json',
                  '-d', json.dumps({'outline': tree, 'confirmed': True}, ensure_ascii=False),
                  f'{BASE}/api/task/{cid}/outline'], 30)
    log(f'outline-confirm(不修剪) {"200" if '"code":200' in out else out[:50]}')

    # 4 全局事实(propose→PUT)
    rc, out = sh(['curl', '-s', '--max-time', '240', '-X', 'POST', f'{BASE}/api/task/{cid}/facts/propose'], 250)
    try:
        fg = json.loads(out).get('facts') or []
    except Exception:
        fg = []
    sh(['curl', '-s', '--max-time', '15', '-X', 'PUT', '-H', 'Content-Type: application/json',
        '-d', json.dumps({'facts': fg}, ensure_ascii=False), f'{BASE}/api/task/{cid}/facts'], 30)
    log(f'facts propose+put: {len(fg)}项')

    # 5 body 全稿(重连+快照并行) — 预算 3 小时
    import threading
    stop_flag = OUT / 'snap.stop'
    th = threading.Thread(target=snapshot_loop, args=(cid, stop_flag), daemon=True)
    th.start()
    log('body 全稿生成开始(快照流并行)')
    r = sse_stage(cid, 'body', 3 * 3600, fatal=False)
    stop_flag.write_text('stop')
    d = task(cid)
    secs = d.get('sections') or []
    from collections import Counter
    c = Counter(s['status'] for s in secs)
    chars = sum(s.get('chars', 0) for s in secs)
    log(f"body {'OK' if r['ok'] else 'TIMEOUT'} {r['secs']}s events={r['events']} errs={r['errs']} "
        f"sections={len(secs)} {dict(c)} 总字={chars}")

    # 6 review / gantt / ppt
    for st, mx in (('review', 900), ('gantt', 600), ('ppt', 900)):
        r = sse_stage(cid, st, mx, fatal=False)
        log(f"{st} {'OK' if r['ok'] else 'FAIL/TIMEOUT'} {r['secs']}s events={r['events']} errs={r['errs']}")

    # 7 导出四件 + 暗标校验
    for label, url in (('docx', f'{BASE}/api/task/{cid}/export?style=blue'),
                       ('pdf', f'{BASE}/api/task/{cid}/export/pdf'),
                       ('pptx', f'{BASE}/api/task/{cid}/ppt/export?style=blue'),
                       ('anbiao', f'{BASE}/api/task/{cid}/export?style=anbiao')):
        t1 = time.time()
        rr = subprocess.run(['curl', '-s', '--max-time', '180', url], capture_output=True, timeout=200)
        ok = rr.returncode == 0 and len(rr.stdout) > 4000
        (OUT / f'export_{label}.bin').write_bytes(rr.stdout[:200000])
        log(f'export-{label}: {"OK" if ok else f"BAD({len(rr.stdout)}B)"} {len(rr.stdout)}B {time.time()-t1:.1f}s')

    # 8 V4 报告集落盘
    for name, url, method in (
            ('matrix', f'{BASE}/api/task/{cid}/matrix', 'GET'),
            ('gates', f'{BASE}/api/task/{cid}/gates', 'GET'),
            ('evaluation', f'{BASE}/api/task/{cid}/evaluation', 'POST'),
            ('fairness', f'{BASE}/api/task/{cid}/fairness', 'POST'),
            ('prequal', f'{BASE}/api/task/{cid}/prequal', 'POST'),
            ('facts_audit', f'{BASE}/api/task/{cid}/facts/audit', 'POST'),
            ('dedup', f'{BASE}/api/task/{cid}/dedup', 'POST'),
            ('archive_verify', f'{BASE}/api/archive/verify', 'GET'),
            ('task_final', f'{BASE}/api/task/{cid}', 'GET')):
        t1 = time.time()
        cmd = ['curl', '-s', '--max-time', '300'] + (['-X', method] if method == 'POST' else []) + [url]
        rc, out = sh(cmd, 310)
        (OUT / f'report_{name}.json').write_text(out, encoding='utf-8')
        log(f'report-{name}: {len(out)}B {time.time()-t1:.1f}s')

    # 9 终报
    g = json.loads((OUT / 'report_gates.json').read_text(encoding='utf-8')).get('gates') or {}
    ev = json.loads((OUT / 'report_evaluation.json').read_text(encoding='utf-8'))
    log(f"终报: gates修复={g.get('fixed_total')} 致命={len(g.get('fatal') or [])} "
        f"G7={(g.get('G7') or {}).get('overall_rate')} 内评={ev.get('verdict')}")
    log('全量试跑完结 — 全部证据在 tools/fullrun/')


if __name__ == '__main__':
    main()
