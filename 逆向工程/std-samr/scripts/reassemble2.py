# -*- coding: utf-8 -*-
"""std.samr 重组器 v2: 静态 HTML token 映射 + chunk 文件 -> 每页 PNG"""
import re, os, sys
from PIL import Image

BASE = r"E:\AI-Station\逆向工程\std-samr"

def load_chunks(data_dir):
    files = [f for f in sorted(os.listdir(data_dir)) if f.startswith('chunk_') and f.endswith('.webp')]
    return {f: Image.open(os.path.join(data_dir, f)) for f in files}

def parse_static(html_path):
    html = open(html_path, encoding='utf-8', errors='ignore').read()
    pages = []
    parts = re.split(r'(?=<div id="\d+" class="page")', html)
    for p in parts:
        m = re.match(r'<div id="(\d+)" class="page"([^>]*)>', p)
        if not m: continue
        pid = int(m.group(1)); attrs = m.group(2)
        st = dict(re.findall(r'(width|height):([\d.]+)px', attrs.replace(' ', '')))
        bg = re.search(r'bg="([^"]*)"', attrs)
        spans = []
        for sm in re.finditer(r'class="pdfImg-(\d+)-(\d+)"\s+style="background-position:\s*(-?\d+)px\s+(-?\d+)px', p):
            spans.append((int(sm.group(1)), int(sm.group(2)), abs(int(sm.group(3))), abs(int(sm.group(4)))))
        pages.append({'id': pid, 'w': int(float(st.get('width', 2315))), 'h': int(float(st.get('height', 3274))),
                      'token': bg.group(1) if bg else None, 'spans': spans})
    return pages

def match(pages, chunks):
    """token -> chunk 文件, 按 (高度容纳 + 唯一性) 匹配"""
    toks = []
    for p in pages:
        if p['token'] and p['token'] not in toks: toks.append(p['token'])
    used, assign = set(), {}
    for t in toks:
        spans_pages = [p for p in pages if p['token'] == t and p['spans']]
        if not spans_pages:
            assign[t] = None; continue
        need = max((max(s[3] for s in p['spans']) + 328) for p in spans_pages)
        # 宽度应一致(2320)
        cands = [f for f, im in chunks.items() if im.size[1] >= need and f not in used]
        exact = [f for f in cands if chunks[f].size[1] == need]
        pick = exact[0] if exact else (cands[0] if cands else None)
        if pick:
            assign[t] = pick; used.add(pick)
    return assign

def build(pages, chunks, assign, out_dir):
    os.makedirs(out_dir, exist_ok=True)
    n = 0
    for p in pages:
        if not p['spans'] or not p['token'] or p['token'] not in assign:
            print(f'page {p["id"]}: blank/no-chunk skip'); continue
        src = chunks[assign[p['token']]]
        canvas = Image.new('RGB', (p['w'], p['h']), 'white')
        tw, th = p['w'] / 10, p['h'] / 10
        for L, T, sx, sy in p['spans']:
            tile = src.crop((sx, sy, sx + 232, sy + 328))
            if tile.size != (int(tw), int(th)):
                tile = tile.resize((int(round(tw)), int(round(th))))
            canvas.paste(tile, (int(L * tw), int(T * th)))
        canvas.save(os.path.join(out_dir, f'page_{p["id"]:02d}.png'))
        n += 1
    print('built pages:', n)

if __name__ == '__main__':
    html_path = sys.argv[1] if len(sys.argv) > 1 else os.path.join(BASE, 'recon', 'showgb.html')
    out_dir = sys.argv[2] if len(sys.argv) > 2 else os.path.join(BASE, 'data', 'pages')
    chunks = load_chunks(os.path.join(BASE, 'data'))
    print('chunks:', {f: im.size for f, im in chunks.items()})
    pages = parse_static(html_path)
    print('pages:', [(p['id'], len(p['spans'])) for p in pages])
    assign = match(pages, chunks)
    print('assign:', {k[:30]: v for k, v in assign.items()})
    build(pages, chunks, assign, out_dir)
