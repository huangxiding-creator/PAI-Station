# -*- coding: utf-8 -*-
"""Extract pipe-name-like strings and cred key names (masked) from binaries.
Usage: python -I pipe_probe.py <file> [file...]
"""
import sys, re, json

PIPE_RE = re.compile(rb"[\x20-\x7e]{0,60}pipe[\x20-\x7e]{0,80}", re.I)
NAME_RE = re.compile(rb"(?:\\{0,2}\.\\pipe\\[!-~]{3,100})|(?:baidunetdisk[!-~]{0,80})|(?:mojo[!.][!-~]{0,60})", re.I)
CRED_UTF16 = re.compile(rb"(?:[\x20-\x7e]\x00){4,200}")

def mask(s):
    s = s.decode("latin1", "ignore")
    if len(s) <= 10:
        return "*" * len(s)
    return s[:6] + "...(%d chars)" % len(s)

for p in sys.argv[1:]:
    try:
        data = open(p, "rb").read()
    except OSError as e:
        print(p, "ERR", e)
        continue
    hits = set()
    for m in NAME_RE.finditer(data):
        s = m.group().decode("latin1")
        if len(s) >= 6:
            hits.add(s[:120])
    # utf16 pipe refs
    for m in CRED_UTF16.finditer(data):
        try:
            s = m.group().decode("utf-16-le")
        except Exception:
            continue
        if "pipe" in s.lower() and len(s) < 150:
            hits.add("U16:" + s[:120])
    print(json.dumps({"file": p, "pipe_names": sorted(hits)[:40]}, ensure_ascii=True))
