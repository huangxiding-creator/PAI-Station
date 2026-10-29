# -*- coding: utf-8 -*-
"""_raw PDF -> 提取文本 -> seeds/gb/<主题分类>/ 种子 + index.json（对齐 seeds/ 现有 domain/need/tree 包络）。"""
import json, os, re, sys, time
GB = r'E:\AI-Station\kb_factory\seeds\gb'
RAW = os.path.join(GB, '_raw')
items = json.load(open(os.path.join(RAW, '_harvest_result.json'), encoding='utf-8'))
print('EV items', len(items), flush=True)

extractor = 'none'
try:
    from pypdf import PdfReader
    extractor = 'pypdf'
except Exception:
    try:
        import pdfplumber
        extractor = 'pdfplumber'
    except Exception:
        try:
            from pdfminer.high_level import extract_text as pm_text
            extractor = 'pdfminer'
        except Exception:
            try:
                import fitz
                extractor = 'pymupdf'
            except Exception:
                extractor = 'none'
print('EV extractor', extractor, flush=True)

def pdf_text_and_pages(p):
    if extractor == 'pypdf':
        rd = PdfReader(p)
        t = '\n'.join((pg.extract_text() or '') for pg in rd.pages)
        return t, len(rd.pages)
    if extractor == 'pdfplumber':
        with pdfplumber.open(p) as pdf:
            t = '\n'.join((pg.extract_text() or '') for pg in pdf.pages)
            return t, len(pdf.pages)
    if extractor == 'pdfminer':
        t = pm_text(p)
        try:
            from pdfminer.pdfparser import PDFParser
            from pdfminer.pdfdocument import PDFDocument
            with open(p, 'rb') as f:
                doc = PDFDocument(PDFParser(f))
                n = max(int(x.get('Count', 0)) for x in doc.catalog.get('Pages', {}).get('Count', []) if isinstance(x, int)) if False else 0
        except Exception:
            n = None
        return t, n
    if extractor == 'pymupdf':
        d = fitz.open(p)
        t = '\n'.join(pg.get_text() for pg in d)
        return t, d.page_count
    return '', None

def safe_name(s, n=40):
    s = re.sub(r'[\/:*?"<>|\r\n]+', ' ', s).strip()
    return s[:n].strip()

by_kw = {}
index_items = []
text_ok = 0
for x in items:
    kw = x['kw']; code = x['code']; pdf = x['pdf']
    folder = os.path.join(GB, kw)
    os.makedirs(folder, exist_ok=True)
    stem = re.sub(r'[^0-9A-Za-z]+', '_', code)
    try:
        t, pages = pdf_text_and_pages(pdf)
    except Exception as e:
        t, pages = '', None
        print('EV extract_err', code, str(e)[:80], flush=True)
    t = re.sub(r'[ \t]+', ' ', t)
    t = re.sub(r'\n{3,}', '\n\n', t).strip()
    short = safe_name(x['name'], 24)
    txt_path = None
    if len(t) >= 200:
        txt_path = os.path.join(folder, f'{stem}_{short}.txt')
        open(txt_path, 'w', encoding='utf-8').write(t)
        text_ok += 1
    fname = f'{stem}_{short}.pdf'
    rel_pdf = os.path.relpath(pdf, GB).replace('\', '/')
    entry = {
        'name': fname, 'path': f'{kw}/', 'tier': 'core', 'ext': 'pdf',
        'title': f'{code} {x["name"]}', 'creator': '国家标准(全文公开系统)',
        'date': x.get('issue'), 'format': 'application/pdf',
        'size_kb': round(x['bytes'] / 1024), 'source': 'gb_openstd',
        'badge': 'gb_free', 'perm': 'green', 'language': 'zh-CN',
        'relation': f'{kw}/', 'coverage': kw,
        'rights': '公开文本·免费下载', 'identifier': code, 'checksum_slot': None,
        'description': f'{x.get("nature")}·{x.get("state")}·实施{x.get("act")}；全文PDF+提取文本{len(t)}字{"" if txt_path else "(文本层缺失)"}',
        'url': f'https://openstd.samr.gov.cn/bzgk/std/newGbInfo?hcno={x.get("hcno")}',
        'pages': pages, 'text_chars': len(t),
        'text_file': os.path.relpath(txt_path, GB).replace('\', '/') if txt_path else None,
        'pdf_file': rel_pdf,
    }
    by_kw.setdefault(kw, []).append(entry)
    index_items.append({'code': code, 'name': x['name'], 'nature': x.get('nature'),
                        'state': x.get('state'), 'issue': x.get('issue'), 'act': x.get('act'),
                        'kw': kw, 'hcno': x.get('hcno'), 'pdf': rel_pdf,
                        'bytes': x['bytes'], 'pages': pages, 'text_chars': len(t),
                        'text': entry['text_file']})
    print('EV seed', code, kw, 'pages', pages, 'chars', len(t), flush=True)

for kw, files in by_kw.items():
    domain = f'GB国标·{kw}知识库'
    seed = {
        'domain': domain,
        'need': {'domain': domain, 'keywords': [kw], 'intent': '国标全文免费件收割（文档驱动引擎燃料）', 'size_hint': 'medium'},
        'tree': {
            'mode': 'document_driven', 'root': domain,
            'l1': [{
                'code': 'D-01', 'dir': 'D-01', 'path': 'D-01/', 'name': '现行国标全文',
                'theme': f'{kw}相关现行国家标准（std.samr.gov.cn 全文公开）', 'source': 'gb_openstd',
                'l2': [{'code': 'D-01/01', 'dir': '01', 'path': 'D-01/01/', 'name': '0币免费件PDF全文',
                        'theme': '官方免费公开全文', 'file_count': len(files), 'files': files}],
            }],
        },
    }
    p = os.path.join(GB, kw, '_seed.json')
    json.dump(seed, open(p, 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
    print('EV seed_json', kw, len(files), flush=True)

total_kb = round(sum(x['bytes'] for x in items) / 1024)
index = {
    'generated_at': time.strftime('%Y-%m-%d %H:%M:%S'),
    'source': 'std.samr.gov.cn / openstd.samr.gov.cn 免登录链（samr_lib.search->detail->try_native_pdf）',
    'harvest_window': '2026-10-24', 'throttle': '>=2.2s, single-thread',
    'extractor': extractor,
    'stats': {'pdf_count': len(items), 'text_ok': text_ok, 'total_kb': total_kb,
              'by_kw': {k: len(v) for k, v in by_kw.items()}},
    'items': index_items,
}
json.dump(index, open(os.path.join(GB, 'index.json'), 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
print('EV INDEX pdf=%d text_ok=%d kb=%d' % (len(items), text_ok, total_kb), flush=True)
print('MAKE_SEEDS DONE', flush=True)
