# -*- coding: utf-8 -*-
import json, os, time
from pathlib import Path
lock = Path(__file__).resolve().parent / "state" / "daemon.lock"
lock.parent.mkdir(exist_ok=True)
while True:
    lock.write_text(json.dumps({"pid": os.getpid(), "hb": time.time()}), encoding="utf-8")
    time.sleep(5)
