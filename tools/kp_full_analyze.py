# -*- coding: utf-8 -*-
"""kp_full_analyze — 全量试跑证据分析器: 吞吐曲线/瓶颈定位/token估算/优化建议原料"""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding='utf-8', errors='replace')
OUT = Path(r'E:\AI-Station\tools\fullrun')


def load(name: str, default=None):
    p = OUT / name
    return json.loads(p.read_text(encoding='utf-8')) if p.exists() else default


def main() -> None:
    snaps = load('snapshots.json', [])
    tl = load('timeline.json', [])
    if not snaps:
        print('无快照')
        return
    print(f'═══ 吞吐曲线 ({len(snaps)}采样) ═══')
    prev_t, prev_c = snaps[0]['t'], snaps[0]['chars']
    for s in snaps[1:] + [snaps[-1]]:
        dt = s['t'] - prev_t
        rate = (s['chars'] - prev_c) / dt if dt > 0 and s['chars'] >= prev_c else 0
        bar = '█' * int(min(rate, 200) / 8)
        print(f"  +{s['t']:>7.0f}s done={s['done']:>3} gen={s['gen']} chars={s['chars']:>7} "
              f"{rate:>6.0f}字/min {bar}")
        prev_t, prev_c = s['t'], s['chars']

    # 分段计时(从时间线)
    print('\n═══ 阶段耗时 ═══')
    for e in tl:
        print(f"  +{e['t']:>7.1f}s {e['msg'][:90]}")

    # body SSE 事件分布
    body_sse = OUT / 'stage_body.sse'
    if body_sse.exists():
        lines = [l for l in body_sse.read_text(encoding='utf-8', errors='replace').splitlines()
                 if l.startswith('data:')]
        kinds = {}
        for l in lines:
            for k in ('section_done', 'progress', 'error', 'all_done', 'gates_done',
                      '"stage": "review"', 'part_done'):
                if k in l:
                    kinds[k] = kinds.get(k, 0) + 1
                    break
        print(f"\n═══ body事件分布 ═══ {kinds}")
        errs = [l for l in lines if '"event": "error"' in l]
        if errs:
            print(f'错误样本: {errs[0][:150]}')

    # 最终任务态
    tf = load('report_task_final.json')
    if tf:
        secs = tf.get('sections') or []
        done = [s for s in secs if s['status'] == 'done']
        chars = [s['chars'] for s in done if s['chars']]
        print(f"\n═══ 终态 ═══ 节={len(secs)} done={len(done)} "
              f"总字={sum(chars)} 均值={sum(chars)//max(1,len(chars))} "
              f"最薄={min(chars) if chars else 0} 最厚={max(chars) if chars else 0}")
        g = load('report_gates.json', {}).get('gates') or {}
        print(f"闸门: 修复={g.get('fixed_total')} 致命={len(g.get('fatal') or [])} "
              f"G7={(g.get('G7') or {}).get('overall_rate')}/{(g.get('G7') or {}).get('verdict')}")
        mx = load('report_matrix.json', {}).get('coverage') or {}
        print(f"矩阵: {mx.get('covered')}/{mx.get('total')} rate={mx.get('rate')}")


if __name__ == '__main__':
    main()
