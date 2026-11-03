# -*- coding: utf-8 -*-
"""native_dump.py — 终极脱壳：spawn + 拦 libart 原生 DefineClass/DexFile::Open* 全族"""
import os
import sys
import time

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
OUT = r"E:\AI-Station\逆向工程\rokid-rebrand\dump"
os.makedirs(OUT, exist_ok=True)

JS = r"""
var N = 0;
var libart = Process.findModuleByName('libart.so');
send('[*] libart @ ' + (libart ? libart.base : 'MISSING'));
var targets = [];
if (libart) {
    libart.enumerateSymbols().forEach(function(s) {
        if (s.name.indexOf('DefineClass') !== -1 ||
            (s.name.indexOf('DexFile') !== -1 && s.name.indexOf('Open') !== -1) ||
            s.name.indexOf('OpenCommon') !== -1 ||
            s.name.indexOf('OpenMemory') !== -1) {
            if (s.type === 'function') targets.push(s);
        }
    });
}
send('[*] native targets: ' + targets.length);
targets.forEach(function(sym) {
    try {
        Interceptor.attach(sym.address, {
            onEnter: function(args) {
                // 扫前几个参数找 dex magic (base 指针 + size)
                for (var i = 0; i < 3; i++) {
                    try {
                        var p = args[i];
                        if (p.isNull && p.isNull()) continue;
                        var head = Memory.readByteArray(p, 8);
                        var u8 = new Uint8Array(head);
                        if (u8[0] === 0x64 && u8[1] === 0x65 && u8[2] === 0x78 && u8[3] === 0x0a) {
                            // dex\n — 第二参或第三参常为 size
                            var size = args[i + 1].toInt32 ? args[i + 1].toInt32() : 0;
                            if (size < 1000 || size > 500000000) {
                                for (var j = 1; j <= 5; j++) {
                                    var alt = args[i + j].toInt32 ? args[i + j].toInt32() : 0;
                                    if (alt > 1000 && alt < 500000000) { size = alt; break; }
                                }
                            }
                            if (size > 1000) {
                                var buf = Memory.readByteArray(p, Math.min(size, 100 * 1048576));
                                send({n: N, tag: sym.name.substring(0, 60), size: size}, buf);
                                N++;
                                return;
                            }
                        }
                    } catch (e) {}
                }
            }
        });
    } catch (e) { send({err: sym.name.substring(0, 40) + ' ' + e}); }
});
send('[*] native hooks installed');
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
            print("[ERR]", p["err"][:100], flush=True)
            return
        if "n" in p:
            fn = os.path.join(OUT, "nat_%02d.dex" % p["n"])
            open(fn, "wb").write(data or b"")
            saved["n"] += 1
            print("[DUMP]", fn, p["size"], p["tag"], flush=True)

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
