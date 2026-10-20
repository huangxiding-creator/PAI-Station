import dis
src = """
def f(a, b):
    d = {'k': a}
    try:
        r = 1 / 0
        return r, d['k']
    except Exception as e:
        return (False, f'x {e}')
"""
co = compile(src, 'probe', 'exec')
fn = co.co_consts[0]
for ins in dis.get_instructions(fn):
    print(repr(ins.opname), repr(ins.argrepr))
