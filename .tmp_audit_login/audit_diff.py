# -*- coding: utf-8 -*-
"""Recompile-diff audit: rebuilt source vs dump dis.txt (CPython 3.13).
Compiles the rebuilt .py (parse only, never executes it), renders each function
with dis.Bytecode().dis(), normalizes both sides identically, and diffs.
"""
import sys, io, re, dis
from dis import Bytecode

def norm_text(text):
    out = []
    in_extab = False
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
        # strip leading source-line-number column: "  34   L1:  OP" / "  --   L4:"
        m = re.match(r'^(?:\s*)(?:(\d+|--)\s+)?(.*)$', line)
        body = m.group(2) if m else line
        # strip instruction offset column (first bare number or --> marker)
        m2 = re.match(r'^(?:-->\s*)?(\d+)\s+(?=[A-Z_])', body)
        if m2:
            body = body[m2.end():]
        out.append(body.strip())
    return out

def parse_dump(path):
    funcs = {}
    cur = None
    buf = []
    def flush():
        if cur is not None:
            funcs[cur] = norm_text('\n'.join(buf))
    for line in open(path, encoding='utf-8'):
        s = line.strip()
        m = re.match(r'^#+\s*CODE\s+(\S+)', s)
        if m or s.startswith('====='):
            flush()
            if m:
                cur = m.group(1)
                buf = []
            else:
                cur = None
            continue
        if s.startswith('# CODE'):
            flush(); cur = None; continue
        if cur is not None:
            buf.append(line.rstrip('\n'))
    flush()
    return funcs

def collect_codes(co, prefix=''):
    """Yield named non-module code objects recursively."""
    for c in co.co_consts:
        if hasattr(c, 'co_code'):
            if c.co_name != '<module>':
                yield c
            for sub in collect_codes(c):
                yield sub

def main(rebuilt_path, dump1, dump2):
    src = open(rebuilt_path, encoding='utf-8').read()
    top = compile(src, rebuilt_path, 'exec')   # parse only
    d1 = parse_dump(dump1)
    d2 = parse_dump(dump2)
    dumps = {}
    for k, v in d1.items():
        dumps[k] = ('login_service', v)
    for k, v in d2.items():
        dumps[k] = ('token_refresh_service', v)

    rebuilt = {}
    for c in collect_codes(top):
        rebuilt[c.co_name] = norm_text(Bytecode(c).dis())

    ok = True
    for name, (origin, ref) in sorted(dumps.items()):
        if name == '<module>':
            print(f'[skip] <module> of {origin} (merged file header documented)')
            continue
        got = rebuilt.get(name)
        if got is None:
            print(f'[MISSING] function {name} not found in rebuilt source')
            ok = False
            continue
        # drop the "ExceptionTable:" trailing block for flow-only compare first,
        # then compare including it.
        if got == ref:
            print(f'[EXACT]  {name} ({origin}): {len(ref)} normalized lines identical (instructions + exception table)')
        else:
            ok = False
            print(f'[DIFF]   {name} ({origin})')
            import difflib
            for l in difflib.unified_diff(ref, got, 'original_dis', 'rebuilt', lineterm='', n=1):
                print('   ' + l)
    print('OVERALL:', 'IDENTICAL' if ok else 'DIFFERENCES FOUND')
    return 0 if ok else 1

if __name__ == '__main__':
    sys.exit(main(sys.argv[1], sys.argv[2], sys.argv[3]))
