# -*- coding: utf-8 -*-
"""Context extractor for minified JS bundles.

usage:
  py -3 -I ctx.py <file> <regex> [before=400] [after=400] [max=20] [start=0]

Prints every regex hit with `before` chars of leading and `after` chars of
trailing context, prefixed by the absolute char offset in the file.
`start` skips hits whose offset is < start (for paging through repeats).
"""
import io
import re
import sys

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")


def main():
    path = sys.argv[1]
    pat = re.compile(sys.argv[2])
    before = int(sys.argv[3]) if len(sys.argv) > 3 else 400
    after = int(sys.argv[4]) if len(sys.argv) > 4 else 400
    limit = int(sys.argv[5]) if len(sys.argv) > 5 else 20
    start = int(sys.argv[6]) if len(sys.argv) > 6 else 0

    with open(path, "r", encoding="utf-8", errors="replace") as fh:
        data = fh.read()

    shown = 0
    for m in pat.finditer(data):
        if m.start() < start:
            continue
        s = max(0, m.start() - before)
        e = min(len(data), m.end() + after)
        print("=" * 100)
        print("OFFSET %d  (match len %d)  line %d" % (
            m.start(), m.end() - m.start(), data.count("\n", 0, m.start()) + 1))
        print(data[s:e])
        shown += 1
        if shown >= limit:
            break
    print("=" * 100)
    print("total hits shown: %d ; file chars: %d" % (shown, len(data)))


if __name__ == "__main__":
    main()
