# -*- coding: utf-8 -*-
import io, sys, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
for path in [r"E:\AI-Station\逆向工程\work\shiflow_unpack\resources\biz\index.js",
             r"E:\AI-Station\逆向工程\work\shiflow_unpack\resources\renderer\assets\target-window-selection-ipc-BNoPqbgj.js"]:
    s = open(path, encoding="utf-8", errors="replace").read()
    print("### ", path.split("\\")[-1])
    print(sorted(set(re.findall(r'apiRequest\(\s*["\x27]([^"\x27]+)["\x27]', s))))
    print(sorted(set(re.findall(r'["\x27](/v\d/[a-zA-Z0-9/_-]{2,40})["\x27]', s))))
