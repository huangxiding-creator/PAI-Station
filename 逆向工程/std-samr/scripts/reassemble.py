# -*- coding: utf-8 -*-
"""std.samr 阅读器重组器: 从 chunk webp + viewer DOM 重建每页 PNG"""
import re, os, sys, json
from PIL import Image

DATA = r"E:\AI-Station\逆向工程\std-samr\data"
OUT = os.path.join(DATA, "pages")
os.makedirs(OUT, exist_ok=True)

def parse_dom(path):
    dom = open(path, encoding='utf-8').read()
    pages = []
    for m in re.finditer(r'<div id="(\d+)" class="page"([^>]*)>(.*?)</div>\s*(?=<div id="\d+" class="page"|</div>\s*</div>|<div class="clear")', dom, re.S):
        pid = int(m.group(1)); attrs = m.group(2); body = m.group(3)
        st = dict(re.findall(r'(width|height):\s*([\d.]+)px', attrs))
        spans = []
        for sm in re.finditer(r'class="pdfImg-(\d+)-(\d+)" style="background-position: (-?\d+)px (-?\d+)px; background-image: url\(&quot;blob:[^&]*?/([0-9a-f-]+)&quot;\)', body):
            L, T, sx, sy, blob = int(sm.group(1)), int(sm.group(2)), int(sm.group(3)), int(sm.group(4)), sm.group(5)
            spans.append((L, T, sx, sy, blob))
        pages.append({'id': pid, 'w': float(st.get('width', 2310)), 'h': float(st.get('height', 3270)), 'spans': spans})
    return pages

def match_chunks(pages, chunks):
    """按 max srcRow 匹配 blob 组 -> chunk 文件"""
    groups = {}
    for p in pages:
        if not p['spans']:
            continue
        blob = p['spans'][0][4]
        groups.setdefault(blob, []).append(p)
    assign = {}
    for blob, plist in groups.items():
        maxrow = max(-s[3] // 328 for p in plist for s in p['spans'])
        cands = [c for c in chunks if chunks[c][1] >= (maxrow + 1) * 328]
        if not cands:
            assign[blob] = None; continue
        # 唯一高度匹配优先
        exact = [c for c in cands if chunks[c][1] == (maxrow + 1) * 328]
        assign[blob] = exact[0] if exact else cands[0]
    return groups, assign

def reassemble(pages, groups, assign):
    imgs = {c: Image.open(os.path.join(DATA, c)) for c in set(assign.values()) if c}
    for p in pages:
        if not p['spans']:
            print(f'page {p["id"]}: BLANK, skip')
            continue
        blob = p['spans'][0][4]
        cf = assign.get(blob)
        if not cf:
            print(f'page {p["id"]}: no chunk match!'); continue
        src = imgs[cf]
        W, H = int(p['w']), int(p['h'])
        canvas = Image.new('RGB', (W, H), 'white')
        tw, th = W / 10, H / 10
        for L, T, sx, sy, _ in p['spans']:
            tile = src.crop((abs(sx), abs(sy), abs(sx) + 232, abs(sy) + 328))
            canvas.paste(tile, (int(L * tw), int(T * th)))
        canvas.save(os.path.join(OUT, f'page_{p["id"]:02d}.png'))
        print(f'page {p["id"]}: {len(p["spans"])} tiles -> {cf}')

if __name__ == '__main__':
    domp = sys.argv[1] if len(sys.argv) > 1 else os.path.join(DATA, 'viewer_dom.html')
    pages = parse_dom(domp)
    print('pages parsed:', len(pages), 'with spans:', sum(1 for p in pages if p['spans']))
    chunks = {f: Image.open(os.path.join(DATA, f)).size for f in sorted(os.listdir(DATA)) if f.startswith('chunk_') and f.endswith('.webp')}
    print('chunks:', chunks)
    groups, assign = match_chunks(pages, chunks)
    print('blob->chunk:', {k[:8]: v for k, v in assign.items()})
    reassemble(pages, groups, assign)
