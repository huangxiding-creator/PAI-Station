import os, re, sys, json
BASE = r"E:\AI-Station\逆向工程\wps-ai-paiban\work\decrypt"
ROOTS = [r"C:\Users\91216\AppData\Local\Kingsoft", r"C:\Users\91216\AppData\Roaming\kingsoft"]
kw_dir = re.compile(r'template|templet|docer|aitypeset|smartlayout|cache', re.I)
num_name = re.compile(r'^\d{19,20}(\.[^.]+)?$')

def magic_tag(h):
    if h is None: return None
    if h.startswith(b'PK\x03\x04'): return 'ZIP(PK0304)'
    if h.startswith(b'\xd0\xcf\x11\xe0'): return 'OLE(D0CF11E0)'
    return None

def probe(path):
    try:
        sz = os.path.getsize(path)
        with open(path, 'rb') as f:
            h = f.read(8)
        return sz, h.hex(), magic_tag(h)
    except OSError as e:
        return None, None, 'ERR:' + str(e)

marker_paths = []
with open(os.path.join(BASE, 'marker_paths.txt'), encoding='utf-8', errors='replace') as f:
    for line in f:
        line = line.strip().replace('/', chr(92))
        if line:
            marker_paths.append(line)
marker_info = []
for p in marker_paths:
    sz, hx, tag = probe(p)
    marker_info.append({'path': p, 'size': sz, 'head8_hex': hx, 'magic': tag})
hits = []
numeric_files = []
aitypeset_dirs = []
kw_dirs = {}
errors = []
scanned = 0
total_files = 0
INTEREST_EXT = ('.docx','.doc','.docm','.dot','.dotx','.dotm','.wps','.wpt','.et','.ett')

for root in ROOTS:
    for dirpath, dirnames, filenames in os.walk(root, onerror=lambda e: errors.append(str(e))):
        lowpath = dirpath.lower()
        for d in dirnames:
            full = os.path.join(dirpath, d)
            ld = d.lower()
            if 'aitypeset' in ld or 'docer' in ld or 'smartlayout' in ld:
                aitypeset_dirs.append(full)
            if kw_dir.search(ld):
                kw_dirs[full] = 0
        dir_kw = bool(kw_dir.search(lowpath))
        for fn in filenames:
            total_files += 1
            p = os.path.join(dirpath, fn)
            if num_name.match(fn):
                try: nsz = os.path.getsize(p)
                except OSError: nsz = -1
                numeric_files.append({'path': p, 'size': nsz})
            if dir_kw:
                kw_dirs[dirpath] = kw_dirs.get(dirpath, 0) + 1
            ext = os.path.splitext(fn)[1].lower()
            scan_this = dir_kw or ext in INTEREST_EXT or ext == ''
            if not scan_this:
                continue
            scanned += 1
            sz, hx, tag = probe(p)
            if tag is None:
                continue
            if isinstance(tag, str) and tag.startswith('ERR:'):
                errors.append(p + ' ' + tag)
                continue
            hits.append({'path': p, 'size': sz, 'head8_hex': hx, 'magic': tag,
                         'ext': ext if ext else '(none)', 'dir_kw': dir_kw,
                         'aitypeset': 'aitypeset' in lowpath})
hits.sort(key=lambda x: (0 if x['aitypeset'] else 1, 0 if x['dir_kw'] else 1, x['path']))
out = {
 'roots': ROOTS,
 'total_files_seen': total_files,
 'files_magic_scanned': scanned,
 'marker_files': marker_info,
 'magic_hits': hits,
 'numeric_19_20_files': numeric_files,
 'aitypeset_related_dirs': sorted(aitypeset_dirs),
 'keyword_dirs_filecount': kw_dirs,
 'errors_count': len(errors),
 'errors_sample': errors[:30],
}
with open(os.path.join(BASE, 'cache_hunt.json'), 'w', encoding='utf-8') as f:
    json.dump(out, f, ensure_ascii=False, indent=1)
print('total_files_seen=', total_files)
print('files_magic_scanned=', scanned)
print('magic_hits=', len(hits))
print('numeric_files=', len(numeric_files))
print('aitypeset_dirs=', len(aitypeset_dirs))
print('keyword_dirs=', len(kw_dirs))
print('errors=', len(errors))
print('--- marker files head8 ---')
for m in marker_info:
    print(m['size'], m['head8_hex'], m['magic'], '|', m['path'])
print('--- hits under aitypeset ---')
n = 0
for hh in hits:
    if hh['aitypeset']:
        n += 1
        if n <= 60: print(hh['magic'], hh['size'], hh['ext'], hh['path'])
print('aitypeset_hits_total=', n)
print('--- hits in kw dirs (non-aitypeset) ---')
n2 = 0
for hh in hits:
    if (not hh['aitypeset']) and hh['dir_kw']:
        n2 += 1
        if n2 <= 60: print(hh['magic'], hh['size'], hh['ext'], hh['path'])
print('kw_hits_total=', n2)
print('--- other hits (ext interest, non-kw) sample ---')
n3 = 0
for hh in hits:
    if (not hh['aitypeset']) and (not hh['dir_kw']):
        n3 += 1
        if n3 <= 40: print(hh['magic'], hh['size'], hh['ext'], hh['path'])
print('other_hits_total=', n3)
print('--- numeric 19-20 digit files ---')
for nf in numeric_files[:40]:
    print(nf['size'], nf['path'])
print('--- aitypeset dirs ---')
for d in sorted(aitypeset_dirs):
    print(d)
