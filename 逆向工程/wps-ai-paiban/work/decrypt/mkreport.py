import json, os, shutil
BASE = 'E:/AI-Station/逆向工程/wps-ai-paiban/work/decrypt'
d = json.load(open(BASE + '/cache_hunt.json', encoding='utf-8'))
probe = json.load(open(BASE + '/container_probe.json', encoding='utf-8'))
OUT3 = BASE + '/out3'
os.makedirs(OUT3, exist_ok=True)

konline_root = 'C:/Users/91216/AppData/Roaming/kingsoft/office6/templates/download/konlinecover/cover'
konl = []
if os.path.isdir(konline_root):
    for idd in sorted(os.listdir(konline_root)):
        sub = os.path.join(konline_root, idd)
        if os.path.isdir(sub):
            for fn in sorted(os.listdir(sub)):
                p = os.path.join(sub, fn)
                konl.append((idd, fn, os.path.getsize(p)))

copies = []
def cp(src, dst):
    dst = os.path.join(OUT3, dst)
    if os.path.isfile(src) and not os.path.exists(dst):
        shutil.copy2(src, dst)
        copies.append((dst, os.path.getsize(dst)))

first = konl[0] if konl else None
if first:
    cp(os.path.join(konline_root, first[0], first[1]), 'konlinecover_' + first[0] + '_exemplar.docx')
cp('C:/Users/91216/AppData/Roaming/kingsoft/office6/templates/download/wpschangetemplate/wpschangetemplate/10093/54375ff7bb5f057fc5f2a18c63c05260.dotx', 'wpschangetemplate_10093_54375ff7.dotx')
ep = 'C:/Users/91216/AppData/Roaming/kingsoft/office6/templates/download/konlinecover/cover/20559222'
if os.path.isdir(ep):
    for fn in os.listdir(ep):
        if fn.endswith('1752190983683'):
            cp(os.path.join(ep, fn), 'konlinecover_20559222_epochrename_1752190983683')
json.dump({'konl': konl, 'copies': copies}, open(BASE + '/report_data.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
print('konl_files=', len(konl))
for c in copies:
    print('COPIED', c[1], c[0])
