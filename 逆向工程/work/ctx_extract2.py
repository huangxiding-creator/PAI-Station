# -*- coding: utf-8 -*-
"""Second recon pass: AI engine, YOLO, doubao, vision model, prompts, scheduled tasks."""
import io, re, sys

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
path = r"e:\AI-Station\逆向工程\extracted\app64\resources\biz\index.js"
src = open(path, "r", encoding="utf-8", errors="replace").read()

def dump(kw, limit=8, width=300):
    print(f"\n########## {kw} ##########")
    count = 0
    for m in re.finditer(re.escape(kw), src):
        s = max(0, m.start() - width)
        e = min(len(src), m.end() + width)
        snippet = src[s:e].replace("\n", "\\n")
        print(f"--- @{m.start()} ---")
        print(snippet)
        count += 1
        if count >= limit:
            break

for kw in ["YOLO", "yolo", "doubao", "SEARCH_VISION_MODEL", "sendCompletionRequest",
           "智能体", "model:", "task_type", "chat_type", "cron"]:
    dump(kw)
