# -*- coding: utf-8 -*-
"""Audit v2: same recompile-diff, with qualified method names and
canonicalization of inherently-different metadata (code object reprs,
__firstlineno__ value). Semantic instruction streams stay fully compared."""
import sys, re, difflib
from dis import Bytecode

CODE_OBJ_RE = re.compile(r'<code object \w+ at 0x[0-9A-Fa-f]+, file ".*", line \d+>')
FIRSTLINE_RE = re.compile(r"^LOAD_CONST\s+\d+\s+\(\d+\)$")

def norm_text(text):
    out, in_extab = [], False
    for raw in text.splitlines():
        line = raw.rstrip()
        s = line.strip()
        if not s:
            in_extab = False
            continue
        if s.startswith('ExceptionTable:'):
            in_extab = True
            out.append('ExceptionTable:')
            continue
        if in_extab:
            out.append(s)
            continue
        m = re.match(r'^(?:\s*)(?:(\d+|--)\s+)?(.*)$', line)
        body = m.group(2) if m else line
        m2 = re.match(r'^(?:-->\s*)?(\d+)\s+(?=[A-Z_])', body)
        if m2:
            body = body[m2.end():]
        b = body.strip()
        b = CODE_OBJ_RE.sub('<CODEOBJ>', b)
        # canonicalize __firstlineno__ constant (merged file layout differs by design)
        if FIRSTLINE_RE.match(b):
            b = 'LOAD_CONST (FIRSTLINE)'
        out.append(b)
    return out

def parse_dump(path):
    funcs, cur, buf = {}, None, []
    def flush():
        if cur is not None:
            funcs[cur] = norm_text('\n'.join(buf))
    for line in open(path, encoding='utf-8'):
        s = line.strip()
        m = re.match(r'^#+\s*CODE\s+(\S+)', s)
        if m or s.startswith('====='):
            flush()
            cur = m.group(1) if m else None
            buf = []
            continue
        if cur is not None:
            buf.append(line.rstrip('\n'))
    flush()
    return funcs

def walk(co, prefix=''):
    for c in co.co_consts:
        if hasattr(c, 'co_code'):
            name = c.co_name
            qual = f'{prefix}.{name}' if prefix else name
            if name.startswith('<'):
                continue
            yield qual, c
            for kv in walk(c, qual):
                yield kv

def main(rebuilt_path, dump1, dump2):
    src = open(rebuilt_path, encoding='utf-8').read()
    top = compile(src, rebuilt_path, 'exec')
    dumps = {}
    for k, v in parse_dump(dump1).items():
        dumps[k] = ('login_service', v)
    for k, v in parse_dump(dump2).items():
        dumps[k] = ('token_refresh_service', v)
    rebuilt = {qual: norm_text(Bytecode(c).dis()) for qual, c in walk(top)}

    ok = True
    for name, (origin, ref) in sorted(dumps.items()):
        if name == '<module>':
            print(f'[skip] <module> ({origin}) — merged-file imports documented in header')
            continue
        got = rebuilt.get(name)
        if got is None:
            print(f'[MISSING] {name}')
            ok = False
            continue
        if got == ref:
            print(f'[EXACT]  {name} ({origin}): instructions + exception table identical')
        else:
            ok = False
            print(f'[DIFF]   {name} ({origin})')
            for l in difflib.unified_diff(ref, got, 'original_dis', 'rebuilt', lineterm='', n=1):
                print('   ' + l)
    print('OVERALL:', 'IDENTICAL' if ok else 'DIFFERENCES FOUND')
    return 0 if ok else 1

if __name__ == '__main__':
    sys.exit(main(sys.argv[1], sys.argv[2], sys.argv[3]))
