# -*- coding: utf-8 -*-
"""Read-only UIA tree probe of the running WeChat (Weixin.exe) window.
Does NOT click, type, focus, or send anything — enumerates accessibility nodes only."""
import io, sys

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
import uiautomation as u

root = u.GetRootControl()
win = None
for w in root.GetChildren():
    if w.ProcessId and w.ClassName == "Weixin" or (w.Name and "微信" in (w.Name or "")):
        # match main Weixin window
        pass
# more robust: search by process name via iterating top-level windows
import ctypes
win = None
for w in root.GetChildren():
    try:
        if w.ClassName in ("Weixin", "WeChatMainWndForPC", "Chrome_WidgetWin_0"):
            pass
    except Exception:
        pass

def pid_name(pid):
    import subprocess
    try:
        out = subprocess.run(["tasklist", "/FI", f"PID eq {pid}"], capture_output=True, text=True).stdout
        for line in out.splitlines():
            if line.startswith("Weixin") or line.startswith("WeChat"):
                return line.split()[0]
    except Exception:
        pass
    return ""

candidates = []
for w in root.GetChildren():
    try:
        pn = pid_name(w.ProcessId)
    except Exception:
        pn = ""
    candidates.append((w, pn, w.ClassName, w.Name))

for w, pn, cn, nm in candidates:
    print(f"[top] proc={pn or w.ProcessId} class={cn!r} name={nm!r}")

# pick the Weixin main window
main = None
for w, pn, cn, nm in candidates:
    if pn == "Weixin.exe":
        main = w
        break
if main is None:
    print("NO Weixin.exe top-level window found")
    sys.exit(0)

print("\n=== walking main window (depth<=7, max 500 nodes) ===")
count = 0
def walk(ctrl, depth):
    global count
    if depth > 7 or count >= 500:
        return
    count += 1
    try:
        name = (ctrl.Name or "")[:40].replace("\n", " ")
        cls = ctrl.ClassName or ""
        ct = ctrl.ControlTypeName
        rect = ""
        try:
            r = ctrl.BoundingRectangle
            rect = f"({r.left},{r.top},{r.right},{r.bottom})"
        except Exception:
            pass
        print("  " * depth + f"{ct:<16} {cls:<28} {name!r:<44} {rect}")
    except Exception as e:
        print("  " * depth + f"<err {e}>")
        return
    try:
        for ch in ctrl.GetChildren():
            walk(ch, depth + 1)
    except Exception:
        pass

walk(main, 0)
print("total nodes:", count)
