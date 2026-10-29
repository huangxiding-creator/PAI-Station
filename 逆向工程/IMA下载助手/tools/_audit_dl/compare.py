# Compare rebuilt candidate source vs original pyc, instruction-for-instruction (py3.13).
import marshal, dis, sys, io

PYC = r"E:\AI-Station\逆向工程\IMA下载助手\extracted\_pyz\gui\download_mixin.pyc"

def load_pyc(path):
    with open(path, "rb") as f:
        f.read(16)  # 3.13 pyc header
        return marshal.load(f)

def compile_src(path):
    with open(path, "rb") as f:
        src = f.read()
    return compile(src, path, "exec", dont_inherit=True)

JUMP_OPS = {"JUMP_FORWARD", "JUMP_BACKWARD", "POP_JUMP_IF_TRUE", "POP_JUMP_IF_FALSE",
            "POP_JUMP_IF_NONE", "POP_JUMP_IF_NOT_NONE", "FOR_ITER", "SEND", "JUMP_BACKWARD_NO_INTERRUPT",
            "JUMP_NO_INTERRUPT"}

import re
_CODE_RE = re.compile(r"^<code object (\w+)")

def norm_ar(ins):
    ar = ins.argrepr
    if ar.startswith("<code object"):
        return "<code " + _CODE_RE.match(ar).group(1) + ">"
    if ins.opname in JUMP_OPS:
        return ""
    return ar

def norm_ins(code, keep_lines=False):
    out, lines, jt = [], [], []
    idx = {}
    arr = list(dis.get_instructions(code, show_caches=False))
    for n, ins in enumerate(arr):
        idx[ins.offset] = n
    for ins in arr:
        out.append((ins.opname, norm_ar(ins)))
        if keep_lines:
            lines.append(ins.positions.lineno if ins.positions.lineno is not None else -1)
        if ins.opname in JUMP_OPS and ins.argval is not None and ins.argval in idx:
            # relative target as instruction-index delta
            jt.append((idx[ins.offset], ins.opname, idx[ins.argval] - idx[ins.offset]))
    return out, lines, jt

def walk(code, prefix=""):
    yield prefix + code.co_name, code
    i = 0
    for c in code.co_consts:
        if hasattr(c, "co_code"):
            i += 1
            yield from walk(c, prefix + code.co_name + "." if not prefix else prefix + ".")

def tree(code):
    d = {}
    def rec(c, path):
        d[path] = c
        for k in c.co_consts:
            if hasattr(k, "co_code"):
                rec(k, path + "." + k.co_name)
    rec(code, code.co_name if code.co_name != "<module>" else "<module>")
    return d

def cmp_consts(a, b, path, problems):
    aa = [c for c in a if not hasattr(c, "co_code")]
    bb = [c for c in b if not hasattr(c, "co_code")]
    if len(aa) != len(bb):
        problems.append(f"{path}: non-code const count {len(aa)} != {len(bb)}\n  A={aa!r}\n  B={bb!r}")
        return
    for x, y in zip(aa, bb):
        if x != y or type(x) is not type(y):
            problems.append(f"{path}: const mismatch {x!r} ({type(x).__name__}) != {y!r} ({type(y).__name__})")

def main(cand_path):
    orig = load_pyc(PYC)
    cand = compile_src(cand_path)
    ot, ct = tree(orig), tree(cand)
    problems, line_notes = [], []
    ok, cb = ot["<module>"], ct["<module>"]
    # module: compare post-import part only? No: full sequence; import names must match.
    pairs = [("<module>", ok, cb)]
    for name, oc in ot.items():
        if name == "<module>":
            continue
        cc = ct.get(name)
        if cc is None:
            problems.append(f"MISSING in candidate: {name}")
            continue
        pairs.append((name, oc, cc))
    for name in ct:
        if name not in ot:
            problems.append(f"EXTRA in candidate: {name}")
    for name, oc, cc in pairs:
        if oc.co_argcount != cc.co_argcount:
            problems.append(f"{name}: argcount {oc.co_argcount} != {cc.co_argcount}")
        if oc.co_varnames != cc.co_varnames:
            problems.append(f"{name}: co_varnames\n  orig={oc.co_varnames}\n  cand={cc.co_varnames}")
        if oc.co_names != cc.co_names:
            problems.append(f"{name}: co_names\n  orig={oc.co_names}\n  cand={cc.co_names}")
        if oc.co_flags != cc.co_flags:
            problems.append(f"{name}: flags {oc.co_flags:#x} != {cc.co_flags:#x}")
        if oc.co_freevars != cc.co_freevars or oc.co_cellvars != cc.co_cellvars:
            problems.append(f"{name}: freevars/cellvars differ")
        cmp_consts(oc.co_consts, cc.co_consts, name, problems)
        oi, _, oj = norm_ins(oc); ci, _, cj = norm_ins(cc)
        if oi != ci:
            n = max(len(oi), len(ci))
            for i in range(n):
                x = oi[i] if i < len(oi) else ("<none>", "")
                y = ci[i] if i < len(ci) else ("<none>", "")
                if x != y:
                    lo = max(0, i - 3)
                    problems.append(f"{name}: instruction divergence at #{i}: orig={x} cand={y}\n  ctx orig={oi[lo:i+4]}\n  ctx cand={ci[lo:i+4]}")
                    break
        if oj != cj:
            problems.append(f"{name}: jump-target deltas differ\n  orig={oj}\n  cand={cj}")
        if getattr(oc, "co_exceptiontable", b"") != getattr(cc, "co_exceptiontable", b""):
            problems.append(f"{name}: co_exceptiontable differs\n  orig={oc.co_exceptiontable!r}\n  cand={cc.co_exceptiontable!r}")
        _, ol, _ = norm_ins(oc, True); _, cl, _ = norm_ins(cc, True)
        if ol != cl:
            # report first line-table divergence informationally
            for i, (x, y) in enumerate(zip(ol, cl)):
                if x != y:
                    line_notes.append(f"{name}: line-table diverges at ins#{i}: orig_line={x} cand_line={y} (informational)")
                    break
    print("=== SEMANTIC PROBLEMS (opnames/argrepr/constants/names) ===")
    if not problems:
        print("NONE — instruction sequences semantically identical")
    for p in problems:
        print(p)
    print("=== LINE-TABLE NOTES ===")
    if not line_notes:
        print("NONE — line tables identical too")
    for p in line_notes:
        print(p)
    return 0 if not problems else 1

if __name__ == "__main__":
    sys.exit(main(sys.argv[1]))
