# -*- coding: utf-8 -*-
"""signals_pull.py — 七源一把拉（薄壳；正式CLI=py -X utf8 -m signals.bus --pull）。"""
import sys
from signals.bus import SignalBus
from signals.adapters import ADAPTERS

names = sys.argv[1:] or list(ADAPTERS)
bus = SignalBus()
rc = 0
for n in names:
    print(n, "->", bus.pull(ADAPTERS[n]()))
sys.exit(rc)
