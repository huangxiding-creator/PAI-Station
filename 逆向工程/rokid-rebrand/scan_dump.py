# -*- coding: utf-8 -*-
"""scan_dump.py — frida-dexdump 法：进程内扫全部 rw 区找合法 dex 头，只回传命中块"""
import os
import sys
import time

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
OUT = r"E:\AI-Station\逆向工程\rokid-rebrand\dump"
os.makedirs(OUT, exist_ok=True)

JS = r"""
var N = 0;
var found = {};
function scanRange(r) {
    var sizeMB = r.size / 1048576;
    var file = r.file ? r.file.path : '';
    if (file || sizeMB > 600 || r.size < 4096) return;
    if (r.protection.indexOf('r') !== 0) return;
    try {
        var CHUNK = 0x100000;
        for (var off = 0; off + 0x70 <= r.size; off += CHUNK - 0x100) {
            var len = Math.min(CHUNK, r.size - off);
            try {
                var buf = Memory.readByteArray(r.base.add(off), len);
                var u8 = new Uint8Array(buf);
                for (var i = 0; i + 0x70 <= u8.length; i++) {
                    if (u8[i] === 0x64 && u8[i+1] === 0x65 && u8[i+2] === 0x78 && u8[i+3] === 0x0a) {
                        var fis = (u8[i+0x20]) | (u8[i+0x21]<<8) | (u8[i+0x22]<<16) | (u8[i+0x23]<<24);
                        var sis = (u8[i+0x38]) | (u8[i+0x39]<<8) | (u8[i+0x3a]<<16) | (u8[i+0x3b]<<24);
                        var hsz = (u8[i+0x24]) | (u8[i+0x25]<<8) | (u8[i+0x26]<<16) | (u8[i+0x27]<<24);
                        if (sis > 0 && sis < 2000000 && fis >= 0x70 && fis < 0x8000000 && hsz === 0x70) {
                            var addr = r.base.add(off + i);
                            var key = '' + addr;
                            if (!found[key]) {
                                found[key] = true;
                                try {
                                    var dexbuf = Memory.readByteArray(addr, fis);
                                    send({n: N, addr: key, size: fis}, dexbuf);
                                    N++;
                                } catch (e) {}
                            }
                            i += fis - 1;
                        }
                    }
                }
            } catch (e) {}
        }
    } catch (e) {}
}
var ranges = [];
var idx = 0;
setTimeout(function() {
    ranges = Process.enumerateRanges({protection: 'r*', coalesce: false});
    send('[*] rw ranges: ' + ranges.length);
    var timer = setInterval(function() {
        var t0 = 0;
        // 每次定时器处理最多 ~150ms 的区间
        while (idx < ranges.length && (Date.now() - t0) < 150) {
            scanRange(ranges[idx]);
            idx++;
            t0 = t0 || Date.now();
        }
        if (idx >= ranges.length) {
            clearInterval(timer);
            send({done: true, dumped: N});
        }
    }, 50);
}, 10);
"""


def main():
    pid = int(sys.argv[1])
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    session = dev.attach(pid)
    state = {"n": 0}

    def on_message(message, data):
        p = message.get("payload", {})
        if isinstance(p, str):
            print(p, flush=True)
            return
        if p.get("done"):
            print("[*] DONE, dumped", p["dumped"], flush=True)
            state["fin"] = True
            return
        if "n" in p:
            fn = os.path.join(OUT, "fd_%02d.dex" % p["n"])
            open(fn, "wb").write(data or b"")
            state["n"] += 1
            print("[DUMP]", fn, p["size"], "@", p["addr"], flush=True)

    script = session.create_script(JS)
    script.on("message", on_message)
    script.load()
    t0 = time.time()
    while not state.get("fin") and time.time() - t0 < 120:
        time.sleep(1)
    try:
        session.detach()
    except Exception:
        pass
    print("[*] total", state["n"], flush=True)


if __name__ == "__main__":
    main()
