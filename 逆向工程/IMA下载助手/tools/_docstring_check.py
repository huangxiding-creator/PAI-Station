# -*- coding: utf-8 -*-
"""Verify rebuilt docstrings/first-consts match the original constant summaries."""
import re, ast

SUM1 = r'E:/AI-Station/逆向工程/IMA下载助手/dump/core_config_manager.summary.txt'
SUM2 = r'E:/AI-Station/逆向工程/IMA下载助手/dump/config.summary.txt'
SRC = r'E:/AI-Station/逆向工程/IMA下载助手/src_rebuilt/core/config_layer.py'


def parse_summary(path):
    """Return {func_display_name: [consts in order]} from summary text."""
    funcs = {}
    cur = None
    for raw in open(path, encoding='utf-8'):
        s = raw.rstrip('\n')
        m = re.match(r'\s*\[(.+?)\]\s+args=', s)
        if m:
            cur = m.group(1)
            funcs[cur] = []
            continue
        m = re.match(r"\s*CONST (.+)$", s)
        if m and cur is not None:
            try:
                v = ast.literal_eval(m.group(1))
            except Exception:
                v = m.group(1)
            funcs[cur].append(v)
    return funcs


orig = {}
orig.update(parse_summary(SUM1))
orig.update(parse_summary(SUM2))

src = open(SRC, encoding='utf-8').read()
code = compile(src, 'config_layer.py', 'exec')
rebuilt = {}
for cls_name in ('Config', 'ConfigManager'):
    cls_code = next(c for c in code.co_consts if hasattr(c, 'co_name') and c.co_name == cls_name)
    for c in cls_code.co_consts:
        if hasattr(c, 'co_name'):
            rebuilt[f'{cls_name}.{c.co_name}'] = list(c.co_consts)

ok, bad, skipped = 0, [], []
for name, consts in rebuilt.items():
    if name not in orig:
        continue
    o0 = orig[name][0] if orig[name] else None
    r0 = consts[0] if consts else None
    if isinstance(o0, str) and o0.startswith(('\n', '获取', '保存', '设置', '加载', '构建', '统一', '应用', '服务器', '服务端', '授权', '数据库', '应用版本', '构建日期', '默认', '最小', '最大', '请求', 'Token', 'Refresh', 'IMA', '从数据库', '所有')) or (isinstance(o0, str) and isinstance(r0, str)):
        if o0 == r0:
            ok += 1
        else:
            bad.append((name, o0, r0))
    else:
        # first const is None/number in original: docstring absent; rebuilt must match type/value
        if o0 == r0 or (o0 is None and r0 is None):
            ok += 1
        elif isinstance(o0, (int, float)) and isinstance(r0, (int, float)) and o0 == r0:
            ok += 1
        else:
            bad.append((name, o0, r0))

print(f'docstring/first-const matches: {ok}')
if bad:
    print('MISMATCHES:')
    for name, o, r in bad:
        print(' ', name)
        print('   orig:', repr(o))
        print('   rbld:', repr(r))
else:
    print('ALL DOCSTRINGS/FIRST-CONSTS MATCH')

# also verify full const tuples for methods whose consts are all simple
strict_ok, strict_bad = 0, []
for name, consts in rebuilt.items():
    o = orig.get(name)
    if not o:
        continue
    # rebuilt contains code objects etc.; compare only str/int/float/bool/None/tuple-of-simple consts
    def simple(cs):
        out = []
        for c in cs:
            if hasattr(c, 'co_name'):
                continue
            if isinstance(c, tuple) and all(isinstance(x, (str, int, float, bool, type(None))) for x in c):
                out.append(c)
            elif isinstance(c, (str, int, float, bool, type(None))):
                out.append(c)
        return out
    if simple(o) == simple(consts):
        strict_ok += 1
    else:
        strict_bad.append(name)
print(f'full simple-const sets equal: {strict_ok} methods')
if strict_bad:
    print('const-set differences (expected for methods referencing differing names):')
    for n in strict_bad:
        print('  *', n)
