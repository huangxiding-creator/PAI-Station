# Dump disassembly + constants for the three utils/*.pyc modules (py313 native)
# Reuses the same output format as tools/pyc_dump.py (parent fleet dumper).
import marshal, dis, sys, os

PYZ = r"E:\AI-Station\逆向工程\IMA下载助手\extracted\_pyz"
OUT = r"E:\AI-Station\逆向工程\IMA下载助手\dump"

TARGETS = [
    "utils/bkn.pyc",
    "utils/crash_guard.pyc",
    "utils/time_parser.pyc",
]

def walk(code, depth=0):
    yield code, depth
    for c in code.co_consts:
        if hasattr(c, "co_code"):
            yield from walk(c, depth + 1)

def fmt_const(c):
    if isinstance(c, str):
        return repr(c)
    if hasattr(c, "co_code"):
        return f"<code {c.co_name}>"
    if isinstance(c, (tuple, list, frozenset, set)):
        return "(" + ", ".join(fmt_const(x) for x in c) + ")"
    return repr(c)

def main():
    os.makedirs(OUT, exist_ok=True)
    for rel in TARGETS:
        path = os.path.join(PYZ, *rel.split("/"))
        if not os.path.exists(path):
            print("MISSING", rel)
            continue
        with open(path, "rb") as f:
            head = f.read(16)
            rest = f.read()
        try:
            code = marshal.loads(rest)
        except Exception:
            # headerless marshal blob fallback
            code = marshal.loads(head + rest)
        tag = rel.replace("/", "_")[:-4]
        with open(os.path.join(OUT, tag + ".dis.txt"), "w", encoding="utf-8") as w:
            w.write(f"===== {rel} =====\n")
            for c, d in walk(code):
                w.write(f"\n{'#'*(d+1)} CODE {c.co_qualname}  args={c.co_varnames[:c.co_argcount]}\n")
                try:
                    dis.dis(c, file=w, depth=0)
                except Exception as ex:
                    w.write(f"!dis fail {ex}\n")
        with open(os.path.join(OUT, tag + ".summary.txt"), "w", encoding="utf-8") as w:
            w.write(f"===== {rel} =====\n")
            w.write(f"DOCSTRING: {code.co_consts[0] if code.co_consts and isinstance(code.co_consts[0], str) else None}\n\n")
            for c, d in walk(code):
                ind = "  " * d
                consts = [x for x in c.co_consts if not hasattr(x, "co_code")]
                w.write(f"{ind}[{c.co_qualname}] args={c.co_varnames[:c.co_argcount]} names={c.co_names}\n")
                for k in consts:
                    w.write(f"{ind}  CONST {fmt_const(k)}\n")
                w.write("\n")
        print("dumped", rel)

if __name__ == "__main__":
    main()
