# -*- coding: utf-8 -*-
"""Decode \\uXXXX escapes in the renderer bundle and search Chinese feature labels."""
import io, sys, re

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
raw = open(r"e:\AI-Station\逆向工程\extracted\app64\resources\renderer\assets\index-B2gIEWvw.js",
           encoding="utf-8", errors="replace").read()
decoded = re.sub(r"\\u([0-9a-fA-F]{4})", lambda m: chr(int(m.group(1), 16)), raw)
print("decoded len", len(decoded))

def dump(kw, limit=5, width=130):
    print(f"##### {kw} #####")
    n = 0
    for m in re.finditer(re.escape(kw), decoded):
        s = max(0, m.start() - width)
        e = min(len(decoded), m.end() + width)
        print(decoded[s:e].replace("\n", " "))
        n += 1
        if n >= limit:
            break

for kw in ["朋友圈", "点赞", "自动回复", "关键词", "定时任务", "SOP", "话术", "技能",
           "群聊", "智能体", "新建任务", "任务类型"]:
    dump(kw)
