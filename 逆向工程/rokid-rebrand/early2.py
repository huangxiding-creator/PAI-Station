# -*- coding: utf-8 -*-
"""early2.py — 战衣 v2：替换式杀手拦截（_exit/exit/_Exit/abort/tgkill/kill 全 no-op）+ 六波早扫
"""
import os
import sys
import time

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
OUT = r"E:\AI-Station\逆向工程\rokid-rebrand\dump"
os.makedirs(OUT, exist_ok=True)

JS = r"""
var found = {};
// === 替换式拦截（已实证稳定）===
function blockVoid(name) {
    try {
        var addr = Module.findExportByName('libc.so', name);
        if (!addr) return;
        Interceptor.replace(addr, new NativeCallback(function() {
            send('[K] 拒绝 ' + name);
        }, 'void', []));
    } catch (e) { send('[K-skip] ' + name + ' ' + e); }
}
function blockInt(name, argc) {
    try {
        var addr = Module.findExportByName('libc.so', name);
        if (!addr) return;
        var cb = new NativeCallback(function() { send('[K] 拒绝 ' + name); return 0; }, 'int', []);
        Interceptor.replace(addr, cb);
    } catch (e) { send('[K-skip] ' + name + ' ' + e); }
}
var seen = {};
['_exit', 'exit', '_Exit', 'abort', 'exit_group'].forEach(function(n) {
    var a = Module.findExportByName('libc.so', n);
    if (a && !seen['' + a]) { seen['' + a] = 1; blockVoid(n); }
});
['kill', 'killpg', 'tgkill', 'pthread_kill', 'raise'].forEach(function(n) {
    var a = Module.findExportByName('libc.so', n);
    if (a && !seen['' + a]) { seen['' + a] = 1; blockInt(n); }
});
// fork 断源（看门狗分身无法诞生）
['fork', 'vfork'].forEach(function(n) {
    var a = Module.findExportByName('libc.so', n);
    if (a && !seen['' + a]) {
        seen['' + a] = 1;
        Interceptor.replace(a, new NativeCallback(function() {
            send('[K] 断 ' + n); return -1;
        }, 'int', []));
    }
});
var cl = Module.findExportByName('libc.so', 'clone');
if (cl && !seen['' + cl]) {
    seen['' + cl] = 1;
    Interceptor.attach(cl, {
        onEnter: function(args) {
            var flags = args[0].toInt32();
            if ((flags & 0x00010000) === 0) { send('[K] 断 clone(fork式)'); args[0] = ptr(-1); }
        }
    });
}
// syscall 直通道：exit_group(94)/exit(93)/tgkill(131)/kill(129)
var sc = Module.findExportByName('libc.so', 'syscall');
if (sc && !seen['' + sc]) {
    seen['' + sc] = 1;
    Interceptor.attach(sc, {
        onEnter: function(args) {
            var nr = args[0].toInt32();
            if (nr === 93 || nr === 94 || nr === 129 || nr === 131) {
                send('[K] 断 syscall(' + nr + ')'); args[0] = ptr(39);  // 改成无害 getpid
            }
        }
    });
}
send('[K] 杀手全家桶就绪');

Java.perform(function() {
    var Sys = Java.use('java.lang.System');
    Sys.exit.implementation = function(c) { send('[K] 拒绝 System.exit(' + c + ')'); };
    try {
        var Proc = Java.use('android.os.Process');
        Proc.killProcess.implementation = function() { send('[K] 拒绝 killProcess'); };
    } catch (e) {}
    send('[K] Java 层就绪');

    function scanWave(delay) {
        setTimeout(function() {
            var N = 0;
            function scan(r) {
                var file = r.file ? r.file.path : '';
                if (file && file.indexOf('/memfd:') !== 0) return;
                if (r.size > 600000000 || r.size < 4096) return;
                var CHUNK = 0x80000;
                for (var off = 0; off + 0x70 <= r.size; off += CHUNK - 0x100) {
                    var len = Math.min(CHUNK, r.size - off);
                    try {
                        var buf = Memory.readByteArray(r.base.add(off), len);
                        var u8 = new Uint8Array(buf);
                        for (var i = 0; i + 0x70 <= u8.length; i++) {
                            if (u8[i]===0x64&&u8[i+1]===0x65&&u8[i+2]===0x78&&u8[i+3]===0x0a) {
                                var fis=(u8[i+0x20])|(u8[i+0x21]<<8)|(u8[i+0x22]<<16)|(u8[i+0x23]<<24);
                                var sis=(u8[i+0x38])|(u8[i+0x39]<<8)|(u8[i+0x3a]<<16)|(u8[i+0x3b]<<24);
                                var hsz=(u8[i+0x24])|(u8[i+0x25]<<8)|(u8[i+0x26]<<16)|(u8[i+0x27]<<24);
                                if (sis>0&&sis<2000000&&fis>=0x70&&fis<0x8000000&&hsz===0x70) {
                                    var addr=r.base.add(off+i); var key=''+addr;
                                    if (!found[key]) { found[key]=true;
                                        try { send({size:fis}, Memory.readByteArray(addr,fis)); N++; } catch(e){}
                                    }
                                    i += fis-1;
                                }
                            }
                        }
                    } catch (e) {}
                }
            }
            var ranges = Process.enumerateRanges('r--');
            for (var i = 0; i < ranges.length; i++) { try { scan(ranges[i]); } catch(e){} }
            send({wave_done: 1});
        }, delay);
    }
    [100, 300, 600, 1000, 1500, 2500, 4000, 6000, 9000, 13000].forEach(scanWave);
    send('[S] 八波排程 0.3~13s');
});
"""


def main():
    secs = int(sys.argv[1]) if len(sys.argv) > 1 else 60
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    pid = dev.spawn(["com.rokid.sprite.aiapp"])
    print("[*] spawned", pid, flush=True)
    session = dev.attach(pid)
    state = {"dex": 0, "blocks": 0}

    def on_message(m, d):
        if m.get("type") == "error":
            print("[JS-ERR]", m.get("description", "")[:150], flush=True)
            return
        p = m.get("payload", {})
        if isinstance(p, str):
            print(p, flush=True)
            if p.startswith("[K]"):
                state["blocks"] += 1
            return
        if not isinstance(p, dict):
            return
        if p.get("wave_done"):
            print(f"[*] 波完 (累计{state['dex']}片)", flush=True)
        if "size" in p and d and p["size"] > 50000:
            fn = os.path.join(OUT, "e2_%02d.dex" % state["dex"])
            open(fn, "wb").write(d)
            state["dex"] += 1
            print(f"[✓✓DUMP] {fn} {p['size']}B", flush=True)

    script = session.create_script(JS)
    script.on("message", on_message)
    script.load()
    dev.resume(pid)
    print(f"[*] resumed; {secs}s", flush=True)
    t0 = time.time()
    while time.time() - t0 < secs:
        time.sleep(1)
    import subprocess
    alive = subprocess.run(
        ["e:/AI-Station/rea-tools/platform-tools/adb.exe", "-s", "emulator-5554",
         "shell", "pidof", "com.rokid.sprite.aiapp"],
        capture_output=True).stdout.decode().strip()
    print(f"[*] 终局: 进程={'活! ' + alive if alive else '死'} 拦截={state['blocks']} dex={state['dex']}", flush=True)


if __name__ == "__main__":
    sys.exit(main())
