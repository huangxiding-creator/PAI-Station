# -*- coding: utf-8 -*-
"""cookie_dump_v2.py — 从 :black 进程的 ClassLoader cookie 直接提取 dex
原理: BlackDex 容器在 :black 进程内加载目标 APK(解密后的 dex)→ cookie 指向内存中的 dex
"""
import os
import sys
import time

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
OUT = r"E:\AI-Station\逆向工程\rokid-rebrand\dump"
os.makedirs(OUT, exist_ok=True)

JS = r"""
var dumped = 0;
var found = {};

function dumpDexFromCookie(cookie, dexFile, tag) {
    try {
        // cookie 是 long[] = [oat_fd?, dex1_ptr, dex1_size, dex2_ptr, dex2_size, ...]
        // Android 12+: [n_dex, ptr1, size1, ptr2, size2, ...]
        var arr = Java.array('long', cookie);
        send({tag: tag, cookieLen: arr.length});
        for (var i = 0; i < arr.length; i++) {
            var v = arr[i];
            if (v === 0) continue;
            // 尝试把每个非零 long 当作指针读 dex 头
            try {
                var p = ptr(v);
                if (p.isNull()) continue;
                var head = Memory.readByteArray(p, 4);
                var u8 = new Uint8Array(head);
                if (u8[0] === 0x64 && u8[1] === 0x65 && u8[2] === 0x78 && u8[3] === 0x0a) {
                    // dex magic! 读 header 拿 size
                    var hdr = new Uint8Array(Memory.readByteArray(p, 0x70));
                    var fis = (hdr[0x20])|(hdr[0x21]<<8)|(hdr[0x22]<<16)|(hdr[0x23]<<24);
                    if (fis > 1000 && fis < 0x8000000) {
                        var key = '' + p;
                        if (!found[key]) {
                            found[key] = true;
                            var buf = Memory.readByteArray(p, fis);
                            send({dex: dumped, size: fis, tag: tag, addr: key}, buf);
                            dumped++;
                        }
                    }
                }
            } catch (e) {}
        }
    } catch (e) { send({err: tag + ' ' + e}); }
}

Java.perform(function() {
    send('[*] cookie dump 启动');
    var clsLoader = Java.classFactory.loader;
    // 遍历所有已加载的 ClassLoader
    Java.enumerateClassLoaders({
        onMatch: function(loader) {
            try {
                var loaderStr = '' + loader;
                if (loaderStr.indexOf('InMemory') !== -1 || loaderStr.indexOf('DexPathList') !== -1 || loaderStr.indexOf('PathClassLoader') !== -1) {
                    send({loader: loaderStr.substring(0, 100)});
                }
                // 尝试从 BaseDexClassLoader 获取 pathList
                var baseDex = Java.cast(loader, Java.use('dalvik.system.BaseDexClassLoader'));
                var pathList = baseDex.pathList.value;
                var elements = pathList.dexElements.value;
                for (var i = 0; i < elements.length; i++) {
                    var el = elements[i];
                    var df = null;
                    try { df = el.dexFile.value; } catch (e) {}
                    if (df === null || df === undefined) continue;
                    // mCookie
                    var cookie = null;
                    try { cookie = df.mCookie.value; } catch (e) {
                        try { cookie = df.mInternalCookie.value; } catch (e2) {}
                    }
                    if (cookie === null || cookie === undefined) continue;
                    dumpDexFromCookie(cookie, df, 'el' + i);
                }
            } catch (e) { /* not a BaseDexClassLoader */ }
        },
        onComplete: function() {
            send({done: true, dumped: dumped});
        }
    });
});
"""


def main():
    # 连 MuMu 的 :black 进程
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    # 先找 :black 进程
    import subprocess
    r = subprocess.run(
        ["e:/AI-Station/rea-tools/platform-tools/adb.exe", "-s", "127.0.0.1:16384",
         "shell", "pidof", "top.niunaijun.blackdexa64:black"],
        capture_output=True, timeout=30)
    pid_s = r.stdout.decode().strip()
    if not pid_s:
        print("[!] :black 不在（需先触发脱壳）")
        return 1
    pid = int(pid_s.split()[0])
    print(f"[*] 附体 :black pid={pid}")
    session = dev.attach(pid)
    state = {"n": 0, "fin": False}

    def on_message(m, d):
        p = m.get("payload", {})
        if isinstance(p, str):
            print(p, flush=True)
            return
        if m.get("type") == "error":
            print("[JS-ERR]", m.get("description", "")[:120], flush=True)
            return
        if not isinstance(p, dict):
            return
        if p.get("done"):
            state["fin"] = True
            print(f"[*] 完: {p['dumped']} 片", flush=True)
        if p.get("cookieLen"):
            print(f"[*] cookie 长度={p['cookieLen']} ({p.get('tag','')})", flush=True)
        if p.get("loader"):
            print(f"[*] loader: {p['loader']}", flush=True)
        if "dex" in p and d:
            fn = os.path.join(OUT, f"ck_{p['dex']:02d}.dex")
            open(fn, "wb").write(d)
            state["n"] += 1
            print(f"[✓✓DUMP] {fn} {p['size']}B from {p.get('tag','')}", flush=True)

    script = session.create_script(JS)
    script.on("message", on_message)
    script.load()
    t0 = time.time()
    while not state["fin"] and time.time() - t0 < 60:
        time.sleep(1)
    try:
        session.detach()
    except Exception:
        pass
    print(f"[*] 终局: {state['n']} 片")
    return 0 if state["n"] >= 3 else 1


if __name__ == "__main__":
    sys.exit(main())
