# Dump disassembly + constants tree for business .pyc files (py313 native)
import marshal, dis, sys, os, io, importlib.util

PYZ = r"E:\AI-Station\逆向工程\IMA下载助手\extracted\_pyz"
OUT = r"E:\AI-Station\逆向工程\IMA下载助手\dump"

TARGETS = [
    "services/ima_service.pyc", "services/login_service.pyc", "services/token_refresh_service.pyc",
    "core/auth.pyc", "core/config.pyc", "core/config_manager.pyc", "core/settings.pyc",
    "data/database.pyc", "config.pyc",
    "gui/main_window.pyc", "gui/search_mixin.pyc", "gui/download_mixin.pyc",
    "gui/kb_tree_mixin.pyc", "gui/qr_login_dialog.pyc", "gui/auth_mixin.pyc",
    "gui/workers.pyc", "gui/workers/workers.pyc", "gui/incremental_download_dialog.pyc",
    "gui/tag_mixin.pyc", "gui/dialogs.pyc", "gui/dialogs/common_dialogs.pyc",
    "gui/auto_update_mixin.pyc", "gui/theme.pyc", "gui/context_menu_mixin.pyc",
    "gui/disclaimer_dialog.pyc",
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
            print("MISSING", rel); continue
        with open(path, "rb") as f:
            f.read(16)
            code = marshal.loads(f.read())
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
    # also the PyInstaller main script
    mainp = r"E:\AI-Station\逆向工程\IMA下载助手\extracted\main"
    if os.path.exists(mainp):
        code = marshal.loads(open(mainp, "rb").read())
        with open(os.path.join(OUT, "MAIN.dis.txt"), "w", encoding="utf-8") as w:
            dis.dis(code, file=w, depth=0)
        with open(os.path.join(OUT, "MAIN.summary.txt"), "w", encoding="utf-8") as w:
            for c, d in walk(code):
                w.write(f"[{c.co_qualname}] names={c.co_names}\n")
                for k in c.co_consts:
                    if not hasattr(k, "co_code"):
                        w.write(f"  CONST {fmt_const(k)}\n")
        print("dumped main")

if __name__ == "__main__":
    main()
