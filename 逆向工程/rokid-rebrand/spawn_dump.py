# -*- coding: utf-8 -*-
"""spawn_dump.py — 易盾脱壳终版：spawn 竞速 + 四路装载钩（InMemory×2/DexClassLoader/文件）"""
import os
import sys
import time

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
OUT = r"E:\AI-Station\逆向工程\rokid-rebrand\dump"
os.makedirs(OUT, exist_ok=True)

JS = r"""
var DEXN = 0;
function dumpBytes(bytes, tag) {
    try {
        send({dex: DEXN, tag: tag, size: bytes.length}, bytes);
        DEXN++;
    } catch (e) { send({err: 'send ' + e}); }
}
function dumpDirect(buf, tag) {
    try {
        var DBB = Java.use('java.nio.DirectByteBuffer');
        var addr = DBB.address.call(buf);   // direct buffer 起址
        var size = buf.remaining();
        var arr = Memory.readByteArray(ptr(addr), size);
        send({dex: DEXN, tag: tag, size: size, mem: true}, arr);
        DEXN++;
    } catch (e) { send({err: 'direct ' + e}); }
}
Java.perform(function() {
    send('[*] installing loaders hooks');
    var InMem = Java.use('dalvik.system.InMemoryDexClassLoader');
    InMem.$init.overload('[Ljava.nio.ByteBuffer;', 'java.lang.ClassLoader').implementation = function(buffers, parent) {
        send('[HIT] InMemory[] n=' + buffers.length);
        for (var i = 0; i < buffers.length; i++) {
            var b = buffers[i];
            if (b === null) continue;
            try { dumpDirect(b, 'imem_' + i); } catch (e) { send({err: 'buf ' + e}); }
        }
        return this.$init(buffers, parent);
    };
    try {
        InMem.$init.overload('java.nio.ByteBuffer', 'java.lang.ClassLoader').implementation = function(buffer, parent) {
            send('[HIT] InMemory(single)');
            try { dumpDirect(buffer, 'imem1'); } catch (e) {}
            return this.$init(buffer, parent);
        };
    } catch (e) { send({err: 'single overload: ' + e}); }
    var DexCL = Java.use('dalvik.system.DexClassLoader');
    DexCL.$init.overload('java.lang.String', 'java.lang.String', 'java.lang.String', 'java.lang.ClassLoader').implementation = function(dexPath, opt, lib, parent) {
        send('[HIT] DexClassLoader path=' + dexPath);
        try {
            var File = Java.use('java.io.File');
            var f = File.$new(dexPath);
            var size = f.length();
            if (size > 1000) {
                var bytes = Java.array('byte', size);
                // 读文件: FileInputStream
                var FIS = Java.use('java.io.FileInputStream');
                var fis = FIS.$new(f);
                fis.read(bytes);
                fis.close();
                dumpBytes(bytes, 'dexcl_' + dexPath);
            }
        } catch (e) { send({err: 'dexcl read ' + e}); }
        return this.$init(dexPath, opt, lib, parent);
    };
    send('[*] hooks installed');
});
"""


def main():
    secs = int(sys.argv[1]) if len(sys.argv) > 1 else 70
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    pid = dev.spawn(["com.rokid.sprite.aiapp"])
    print("[*] spawned", pid, flush=True)
    session = dev.attach(pid)
    saved = {"n": 0}

    def on_message(message, data):
        p = message.get("payload", {})
        if isinstance(p, str):
            print(p, flush=True)
            return
        if p.get("err"):
            print("[ERR]", p["err"][:120], flush=True)
            return
        if "dex" in p:
            fn = os.path.join(OUT, "dex_%d_%s.dex" % (p["dex"], p["tag"].replace("/", "_")[:40]))
            open(fn, "wb").write(data or b"")
            saved["n"] += 1
            print("[DUMP]", fn, p.get("size"), "mem" if p.get("mem") else "", flush=True)

    script = session.create_script(JS)
    script.on("message", on_message)
    script.load()
    dev.resume(pid)
    print("[*] resumed, collecting %ds …" % secs, flush=True)
    time.sleep(secs)
    try:
        dev.kill(pid)
    except Exception:
        pass
    print("[*] saved", saved["n"], flush=True)


if __name__ == "__main__":
    main()
