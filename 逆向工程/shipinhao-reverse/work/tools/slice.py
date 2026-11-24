# -*- coding: utf-8 -*-
"""Offset-range reader for minified bundles.

usage:
  py -3 -I slice.py <file> <start> <length>

Prints data[start:start+length] (char offsets, python str indices).
"""
import io
import sys

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")


def main():
    path = sys.argv[1]
    start = int(sys.argv[2])
    length = int(sys.argv[3])
    with open(path, "r", encoding="utf-8", errors="replace") as fh:
        data = fh.read()
    chunk = data[start:start + length]
    print("[offset %d .. %d of %d]" % (start, start + len(chunk), len(data)))
    print(chunk)


if __name__ == "__main__":
    main()
