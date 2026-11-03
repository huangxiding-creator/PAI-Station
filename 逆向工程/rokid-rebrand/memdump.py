# -*- coding: utf-8 -*-
"""memdump.py v4 — 单会话单脚本，attach 后一次性流式 dump 全部候选区（抢反调试心跳）"""
import os
import sys
import threading
import time

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
OUT = r"E:\AI-Station\逆向工程\rokid-rebrand\dump"
os.makedirs(OUT, exist_ok=True)

JS = """
var ranges = Process.enumerateRanges('rw-');
var picked = 0;
ranges.forEach(function(r) {
    var sizeMB = r.size / 1048576;
    var file = r.file ? r.file.path : '';
    if (!file && sizeMB >= 0.4 && sizeMB <= 300) {
        picked++;
        try {
            var buf = Memory.readByteArray(r.base, r.size);
            send({tag: r.base.toString()}, buf);
        } catch (e) { send({tag: r.base.toString(), err: '' + e}); }
    }
});
send({done: true, picked: picked});
"""


def main():
    pid = int(sys.argv[1])
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    session = dev.attach(pid)
    state = {"saved": 0, "done": False}

    def on_message(message, data):
        p = message.get("payload", {})
        if not isinstance(p, dict):
            print(p, flush=True)
            return
        if p.get("done"):
            state["done"] = True
            print("[*] js done, picked", p["picked"], flush=True)
            return
        if p.get("err"):
            return
        if data:
            open(os.path.join(OUT, "mem_%s.bin" % p["tag"]), "wb").write(data)
            state["saved"] += 1

    script = session.create_script(JS)
    script.on("message", on_message)
    script.load()
    t0 = time.time()
    while not state["done"] and time.time() - t0 < 60:
        threading.Event().wait(0.5)
    time.sleep(2)
    try:
        session.detach()
    except Exception:
        pass
    print("[*] saved", state["saved"], "regions", flush=True)


if __name__ == "__main__":
    main()
