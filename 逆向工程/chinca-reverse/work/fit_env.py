# -*- coding: utf-8 -*-
"""Fit loop: try fake (name, stack) variants until Node output == Chrome's fixture ground truth."""
import json, os, subprocess, itertools

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FIX = os.path.join(BASE, "work", "fixture", "challenge.html")
TARGET = "1234cf0d46-439554356d56edc507dffafa018b62584488d8806e4d2d295c"
ARG1 = "5df63044f876afd54a08451b285880dce63958d54453e0d322"

URL = "http://127.0.0.1:18765/challenge.html"

def run(name, stack):
    p = subprocess.run(["node", "instrument.js", FIX, "", name, stack],
                       capture_output=True, text=True, timeout=60,
                       cwd=os.path.join(BASE, "work"))
    try:
        return json.loads(p.stdout.strip().splitlines()[-1])["acw_sc__v2"]
    except Exception:
        return "ERR:" + p.stdout[:100] + p.stderr[:200]

msg = "TypeError: SVGAnimateString is not a function"
frame_s = "    at s (%s:1:1234)" % URL
frame_x = "    at xXRQBR (%s:1:567)" % URL
frame_top = "    at %s:1:89" % URL

variants = []
# frame combos
for combo_name, frames in [
    ("s+x+top", [frame_s, frame_x, frame_top]),
    ("s+x", [frame_s, frame_x]),
    ("s+top", [frame_s, frame_top]),
    ("x+top", [frame_x, frame_top]),
    ("s", [frame_s]),
    ("anon3", ["    at %s:1:12" % URL, "    at %s:1:34" % URL, "    at %s:1:56" % URL]),
]:
    stack = msg + "\n" + "\n".join(frames)
    variants.append((combo_name, "TypeError", stack))

print("target:", TARGET)
for cname, nm, st in variants:
    out = run(nm, st)
    hit = "MATCH!!!" if out == TARGET else ""
    print(f"{cname:10s} -> {out} {hit}")
