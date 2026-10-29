# Verify rebuilt sources against original pyc bytecode, instruction by instruction.
# Strips the provenance comment header (leading '#' lines / blanks) so that the
# remaining source's line numbers align 1:1 with the original .py line numbers.
import marshal, dis, sys

BASE = "E:/AI-Station/逆向工程/IMA下载助手"
PAIRS = [
    ("bkn", "utils/bkn.pyc", "src_rebuilt/utils/bkn.py"),
    ("crash_guard", "utils/crash_guard.pyc", "src_rebuilt/utils/crash_guard.py"),
    ("time_parser", "utils/time_parser.pyc", "src_rebuilt/utils/time_parser.py"),
]

def load_pyc(path):
    with open(path, "rb") as f:
        f.read(16)
        return marshal.loads(f.read())

def strip_header(src):
    lines = src.splitlines()
    i = 0
    while i < len(lines) and (lines[i].startswith("#") or not lines[i].strip()):
        i += 1
    return "\n".join(lines[i:]) + "\n"

def walk(code):
    yield code
    for c in code.co_consts:
        if hasattr(c, "co_code"):
            yield from walk(c)

import re
def norm_repr(s):
    # code-object argreprs embed memory addresses (run-specific) and the original
    # build's path separators (utils\x.py); mask both as non-semantic artifacts.
    s = re.sub(r"at 0x[0-9A-Fa-f]+", "at 0xX", s)
    s = s.replace("utils\\\\", "utils/").replace('utils\\', 'utils/')
    return s

def profile(code):
    """Structural fingerprint: (qualname, args, names, plain consts, instruction stream)."""
    funcs = []
    for c in walk(code):
        instrs = []
        for ins in dis.get_instructions(c):
            argrepr = norm_repr(ins.argrepr)
            instrs.append((ins.opname, argrepr, ins.starts_line is not None and ins.starts_line or 0))
        consts = [k for k in c.co_consts if not hasattr(k, "co_code")]
        funcs.append({
            "qualname": c.co_qualname,
            "args": c.co_varnames[:c.co_argcount],
            "names": c.co_names,
            "consts": consts,
            "instrs": instrs,
        })
    return funcs

def compare(tag, orig_code, built_code, problems):
    a, b = profile(orig_code), profile(built_code)
    if len(a) != len(b):
        problems.append(f"[{tag}] nested code count differs: orig={len(a)} built={len(b)}")
        return
    for fa, fb in zip(a, b):
        fn = fa["qualname"]
        if fa["qualname"] != fb["qualname"]:
            problems.append(f"[{tag}] qualname mismatch {fa['qualname']} vs {fb['qualname']}")
            continue
        if fa["args"] != fb["args"]:
            problems.append(f"[{tag}/{fn}] args {fa['args']} vs {fb['args']}")
        if fa["names"] != fb["names"]:
            problems.append(f"[{tag}/{fn}] names differ:")
            for i, (x, y) in enumerate(zip(fa["names"], fb["names"])):
                if x != y:
                    problems.append(f"    idx{i}: orig={x!r} built={y!r}")
            if len(fa["names"]) != len(fb["names"]):
                problems.append(f"    lens orig={len(fa['names'])} built={len(fb['names'])}")
        if fa["consts"] != fb["consts"]:
            problems.append(f"[{tag}/{fn}] consts differ:")
            for x in fa["consts"]:
                if x not in fb["consts"]:
                    problems.append(f"    orig-only: {x!r}")
            for y in fb["consts"]:
                if y not in fa["consts"]:
                    problems.append(f"    built-only: {y!r}")
        if len(fa["instrs"]) != len(fb["instrs"]):
            problems.append(f"[{tag}/{fn}] instr count {len(fa['instrs'])} vs {len(fb['instrs'])}")
        for i, (ia, ib) in enumerate(zip(fa["instrs"], fb["instrs"])):
            if ia != ib:
                problems.append(f"[{tag}/{fn}] instr #{i}: orig={ia} built={ib}")
                if len(problems) > 40:
                    problems.append("...truncated")
                    return

def main():
    total_problems = []
    for tag, pyc_rel, src_rel in PAIRS:
        orig = load_pyc(f"{BASE}/extracted/_pyz/{pyc_rel}")
        src = strip_header(open(f"{BASE}/{src_rel}", encoding="utf-8").read())
        try:
            built = compile(src, f"utils/{tag}.py", "exec")
        except SyntaxError as ex:
            print(f"{tag}: SYNTAX ERROR {ex}")
            total_problems.append(f"[{tag}] syntax error {ex}")
            continue
        problems = []
        compare(tag, orig, built, problems)
        n_func = len(list(walk(orig)))
        if problems:
            print(f"{tag}: MISMATCH ({len(problems)} problem(s), {n_func} code objects)")
            for p in problems[:40]:
                print("  " + p)
            total_problems.extend(problems)
        else:
            print(f"{tag}: OK - {n_func} code objects, all instructions/names/consts/lines identical")
    if total_problems:
        print(f"\nRESULT: {len(total_problems)} problem(s) total")
        sys.exit(1)
    print("\nRESULT: all rebuilt modules match original bytecode exactly")

if __name__ == "__main__":
    main()
