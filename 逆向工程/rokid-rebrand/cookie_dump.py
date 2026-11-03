# -*- coding: utf-8 -*-
"""cookie_dump.py — 终极：mCookie → art::DexFile* → begin_/size_ → 16片内存dex直倒（单会话一击）"""
import os
import sys
import time

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
OUT = r"E:\AI-Station\逆向工程\rokid-rebrand\dump"
os.makedirs(OUT, exist_ok=True)

JS = r"""
Java.perform(function() {
    send('[*] start');
    var Long = Java.use('java.lang.Long');
    var ArrayCls = Java.use('java.lang.reflect.Array');
    var mc = Java.use('com.rokid.sprite.aiapp.ui.MainActivity').class.getClassLoader();
    var BaseDex = Java.cast(mc, Java.use('dalvik.system.BaseDexClassLoader'));
    var elements = BaseDex.pathList.value.dexElements.value;
    send('[*] elements=' + elements.length);
    var N = 0;
    for (var i = 0; i < elements.length; i++) {
        var df = null;
        try { df = elements[i].dexFile.value; } catch (e) {}
        if (df === null) continue;
        var cookie = null;
        try { cookie = df.mCookie.value; } catch (e) { try { cookie = df.mInternalCookie.value; } catch (e2) {} }
        if (cookie === null) continue;
        // cookie 是 long[]（Java数组）
        var len = 0;
        try { len = cookie.length; } catch (e) { continue; }
        for (var j = 0; j < len; j++) {
            var v;
            try { v = cookie[j]; } catch (e) { continue; }
            if (v === null) continue;
            var p = ptr(Long.toString(Long.valueOf(v), 16) === '0' ? '0x0' : Long.toString(Long.valueOf(v), 16));
            if (p.isNull()) continue;
            // 尝试 art::DexFile 布局: +0 vptr, +8 begin_, +0x10 size_
            var got = false;
            var offs = [[8, 16], [0, 8], [16, 24], [8, 24]];
            for (var k = 0; k < offs.length && !got; k++) {
                try {
                    var begin = p.add(offs[k][0]).readPointer();
                    var size = p.add(offs[k][1]).readU64();
                    if (size > 1000 && size < 300000000) {
                        var head = begin.readByteArray(4);
                        var u8 = new Uint8Array(head);
                        if (u8[0] === 0x64 && u8[1] === 0x65 && u8[2] === 0x78 && u8[3] === 0x0a) {
                            var buf = Memory.readByteArray(begin, size.valueOf());
                            send({n: N, el: i, co: j, size: size.valueOf(), off: offs[k]}, buf);
                            N++;
                            got = true;
                        }
                    }
                } catch (e) {}
            }
        }
    }
    send({done: true, dumped: N});
});
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
            print("[*] js done, dumped", p["dumped"], flush=True)
            state["done"] = True
            return
        if "n" in p:
            fn = os.path.join(OUT, "real_%02d_el%d.dex" % (p["n"], p["el"]))
            open(fn, "wb").write(data or b"")
            state["n"] += 1
            print("[DUMP]", fn, p["size"], "offset-layout", p["off"], flush=True)

    script = session.create_script(JS)
    script.on("message", on_message)
    script.load()
    t0 = time.time()
    while not state.get("done") and time.time() - t0 < 30:
        time.sleep(0.5)
    print("[*] total saved", state["n"], flush=True)


if __name__ == "__main__":
    main()
