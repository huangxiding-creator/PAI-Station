# -*- coding: utf-8 -*-
"""Compare opcode-name sequences: rebuilt config_layer.py vs original dis dump."""
import re, dis, marshal, sys

DUMP = r'E:/AI-Station/逆向工程/IMA下载助手/dump/core_config_manager.dis.txt'
DUMP2 = r'E:/AI-Station/逆向工程/IMA下载助手/dump/config.dis.txt'
SRC = r'E:/AI-Station/逆向工程/IMA下载助手/src_rebuilt/core/config_layer.py'

OP_RE = re.compile(r'^(?:--\s+)?(?:L\d+:)?\s*((?:[A-Z][A-Z0-9_]+)\b)')

SKIP = {'ExceptionTable:', '##', '###', '#', '=====',
        # pseudo-lines inside exception table blocks
        }

def parse_dump(path):
    methods = {}
    cur = None
    in_ext = False
    for raw in open(path, encoding='utf-8'):
        line = raw.rstrip('\n')
        s = line.strip()
        if s.startswith('### CODE '):
            cur = s[len('### CODE '):].split()[0]
            methods[cur] = []
            in_ext = False
            continue
        if s.startswith('## CODE ') or s.startswith('# CODE '):
            cur = None
            continue
        if cur is None:
            continue
        if s.startswith('ExceptionTable:'):
            in_ext = True
            continue
        if in_ext:
            if s == '' or s.startswith('L') or s.startswith('--'):
                if s == '':
                    in_ext = False
                continue
        if s == '':
            continue
        if s.startswith('L') and ' to ' in s:
            continue
        if s.startswith('--'):
            s = s.lstrip('-').strip()
        s = re.sub(r'^\d+\s+', '', s)  # strip leading source-line number
        m = re.match(r'^(?:L\d+:\s+)?([A-Z][A-Z0-9_]+)\b', s)
        if m and m.group(1) not in ('CODE',):
            methods[cur].append(m.group(1))
    return methods

def ops_of(code):
    return [i.opname for i in dis.get_instructions(code)]

def collect_rebuilt():
    src = open(SRC, encoding='utf-8').read()
    code = compile(src, 'config_layer.py', 'exec')
    out = {}
    for cls_name in ('ConfigManager', 'Config'):
        cls_code = None
        for c in code.co_consts:
            if hasattr(c, 'co_name') and c.co_name == cls_name:
                cls_code = c
                break
        assert cls_code is not None, cls_name
        for k, v in vars(type(cls_name, (), {})).items():
            pass
        # extract from co_consts of class body
        for c in cls_code.co_consts:
            if hasattr(c, 'co_name'):
                out[f'{cls_name}.{c.co_name}'] = ops_of(c)
    return out

dump1 = parse_dump(DUMP)
dump2 = parse_dump(DUMP2)
orig = {}
for k, v in dump1.items():
    orig[k] = v
for k, v in dump2.items():
    orig[k] = v

rebuilt = collect_rebuilt()

# methods expected identical (excluding _load_config which has documented fallback)
identical, differ, missing = [], [], []
for name, ops in sorted(rebuilt.items()):
    if name not in orig:
        missing.append(name)
        continue
    if ops == orig[name]:
        identical.append(name)
    else:
        differ.append(name)

print('=== BYTECODE-STRUCTURE COMPARISON (opcode name sequences) ===')
print(f'identical ({len(identical)}):')
for n in identical:
    print('  =', n)
print(f'differing ({len(differ)}):')
for n in differ:
    print('  !=', n)
print(f'not in original dump (module-level / merged artifacts) ({len(missing)}):')
for n in missing:
    print('  ?', n)

for n in differ:
    o, r = orig[n], rebuilt[n]
    print(f'\n--- diff {n} ---')
    print(' orig len', len(o), ' rebuilt len', len(r))
    for i in range(max(len(o), len(r))):
        a = o[i] if i < len(o) else '<END>'
        b = r[i] if i < len(r) else '<END>'
        mark = '' if a == b else '   <<<'
        print(f'  {i:3d} {a:28s} {b:28s}{mark}')
        if a == '<END>' and b == '<END>':
            break

# also confirm original-dump methods all covered
orig_names = set(orig)
reb_names = set(rebuilt)
uncovered = sorted(orig_names - reb_names)
print('\noriginal methods not present in rebuilt:', uncovered if uncovered else '(none)')
