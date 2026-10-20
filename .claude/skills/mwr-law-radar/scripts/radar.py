# -*- coding: utf-8 -*-
"""水利法规雷达 CLI — 三源聚合检索(镜像快照/本地库/planchief KB)."""
from __future__ import annotations

import json
import re
import sqlite3
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding='utf-8', errors='replace')
PC = Path(r'E:\AI-Station\planchief')
KB = PC / 'data' / 'kb.db'
SLJD = PC / 'data' / 'radar_cache' / 'sljd'


def _kb_search(q: str, layers=None, limit: int = 12) -> list[dict]:
    conn = sqlite3.connect(str(KB))
    conn.row_factory = sqlite3.Row
    out = []
    # trigram>=3字 or LIKE
    terms = [t for t in re.split(r'\s+', q) if t]
    layer_sql = ''
    if layers:
        layer_sql = ' AND d.layer IN (%s)' % ','.join('?' * len(layers))
    for t in terms:
        if len(t) >= 3:
            rows = conn.execute(
                f'SELECT d.title, d.layer, d.source_path, c.text FROM chunk_fts f '
                f'JOIN kb_chunk c ON c.id=f.chunk_id JOIN kb_doc d ON d.id=c.doc_id '
                f'WHERE chunk_fts MATCH ? {layer_sql} LIMIT ?', (f'"{t}"', *layers, limit)).fetchall() if layers else conn.execute(
                'SELECT d.title, d.layer, d.source_path, c.text FROM chunk_fts f '
                'JOIN kb_chunk c ON c.id=f.chunk_id JOIN kb_doc d ON d.id=c.doc_id '
                'WHERE chunk_fts MATCH ? LIMIT ?', (f'"{t}"', limit)).fetchall()
        else:
            rows = conn.execute(
                f'SELECT d.title, d.layer, d.source_path, c.text FROM kb_chunk c '
                f'JOIN kb_doc d ON d.id=c.doc_id WHERE c.text LIKE ? {layer_sql} LIMIT ?',
                (f'%{t}%', *layers, limit)).fetchall()
        for r in rows:
            if not any(x['title'] == r['title'] for x in out):
                out.append(dict(title=r['title'], layer=r['layer'],
                                src=r['source_path'], text=r['text'][:260]))
    conn.close()
    return out[:limit]


def cmd_search(args):
    q = ' '.join(args)
    hits = _kb_search(q, layers=['law', 'law-sljd'])
    print(f'「{q}」法规命中 {len(hits)} 条：\n')
    for i, h in enumerate(hits, 1):
        src = h['src']
        if 'radar_cache' in src or h['layer'] == 'law-sljd':
            link = 'sljd镜像(已快照)'
        else:
            link = src
        print(f'[{i}] {h["title"]}\n    层:{h["layer"]} 源:{link[:90]}\n    {h["text"][:180]}…\n')


def cmd_sweep(args):
    total = {}
    for term in args:
        hits = _kb_search(term, layers=['law', 'law-sljd'], limit=6)
        print(f'◆ {term}: {len(hits)} 条')
        for h in hits[:4]:
            print(f'   - {h["title"][:56]}')
            if h['title'] not in total:
                total[h['title']] = h
        print()
    print(f'== sweep 汇总: {len(total)} 条适用法规建议 ==')


def cmd_kb(args):
    q = ' '.join(args)
    hits = _kb_search(q)
    print(f'「{q}」八层KB命中 {len(hits)} 条：\n')
    for i, h in enumerate(hits, 1):
        print(f'[{i}][{h["layer"]}] {h["title"][:50]}\n    {h["text"][:160]}…\n')


def cmd_mirror(args):
    script = PC / 'tools' / 'mirror_sljd.py'
    r = subprocess.run(['py', '-X', 'utf8', str(script)], capture_output=True, text=True,
                       encoding='utf-8', errors='replace')
    print(r.stdout[-2000:] or r.stderr[-800:])


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return
    cmd, args = sys.argv[1], sys.argv[2:]
    if not KB.exists():
        print('KB 不存在，先跑: py -X utf8 E:\\AI-Station\\planchief\\tools\\build_kb.py')
        return
    {'search': cmd_search, 'sweep': cmd_sweep, 'kb': cmd_kb,
     'mirror': cmd_mirror}.get(cmd, lambda a: print('命令: search|sweep|kb|mirror'))(args)


if __name__ == '__main__':
    main()
