# -*- coding: utf-8 -*-
"""dump_dex.py — 易盾 7.6.1 脱壳：spawn 竞速 + InMemoryDexClassLoader/DexClassLoader 拦截
产物: 逆向工程/rokid-rebrand/dump/dex_N.dex
"""
import os
import sys
import time

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
OUT = r"E:\AI-Station\逆向工程\rokid-rebrand\dump"
os.makedirs(OUT, exist_ok=True)

JS = """
var DUMPED = 0;
function saveBytes(bytes, tag) {
    try {
        var FileOutputStream = Java.use('java.io.FileOutputStream');
        var StringCls = Java.use('java.lang.String');
        var path = '/data/local/tmp/dump_' + tag + '_' + DUMPED + '.dex';
        var fos = FileOutputStream.$new(path);
        fos.write(bytes);
        fos.close();
        DUMPED++;
        send('[DUMP] ' + path + ' size=' + bytes.length);
    } catch (e) { send('[ERR-save] ' + e); }
}

Java.perform(function() {
    send('[*] hooking classloaders');
    // InMemoryDexClassLoader(ByteBuffer[], ClassLoader) — 易盾主通道
    var InMem = Java.use('dalvik.system.InMemoryDexClassLoader');
    InMem.$init.overload('[Ljava.nio.ByteBuffer;', 'java.lang.ClassLoader').implementation = function(buffers, parent) {
        send('[HIT] InMemoryDexClassLoader buffers=' + buffers.length);
        for (var i = 0; i < buffers.length; i++) {
            try {
                var buf = buffers[i];
                var size = buf.remaining();
                var ByteArray = Java.use('[B');
                var arr = Java.array('byte', size);
                // Java.array('byte', size) 不可用; 用 reflect 构造
                var JByte = Java.use('java.lang.Byte');
                var bytes = Java.reflect.Array.newInstance(Java.use('byte').class, size); // fallback below
            } catch (e) { send('[ERR-buf' + i + '] ' + e); }
        }
        return this.$init(buffers, parent);
    };
    // 简化路线: 直接抓 ByteBuffer → 通过 hidden API readFully
    // 用 InMemoryDexClassLoader 构造后的 findClass 行为不拦截, 改拦 dexFile
    var DexFile = Java.use('dalvik.system.DexFile');
    // 老式 DexClassLoader(byte[]...) 若在
    try {
        var DexCL = Java.use('dalvik.system.DexClassLoader');
        send('[*] DexClassLoader present');
    } catch (e) {}
    // 兜底: OpenMemory (native) — libart 符号
    try {
        var libart = Process.findModuleByName('libart.so');
        if (libart) {
            ['OpenMemory', '_ZN3art7DexFile10OpenMemoryEPKhmRKNSt6__ndk112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEEjPNS_6OatDexFileEPS9_',
             '_ZN3art7DexFile10OpenMemoryEPKhmRKNSt3__112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEEjPNS_6OatDexFileEPS9_'].forEach(function(sym) {
                var addr = libart.findExportByName(sym);
                if (addr) {
                    send('[*] libart ' + sym + ' @ ' + addr);
                    try {
                        Interceptor.attach(addr, {
                            onEnter: function(args) {
                                var base = args[0], size = args[1].toInt32();
                                if (size > 100000) {
                                    var tag = 'mem';
                                    var path = '/data/local/tmp/dump_' + tag + '_' + DUMPED + '.dex';
                                    var f = new File(path, 'wb');
                                    f.write(Memory.readByteArray(base, Math.min(size, 200*1024*1024)));
                                    f.close();
                                    DUMPED++;
                                    send('[DUMP-NATIVE] ' + path + ' size=' + size);
                                }
                            }
                        });
                    } catch (e) { send('[ERR-int] ' + e); }
                }
            });
        }
    } catch (e) { send('[ERR-libart] ' + e); }
    send('[*] hooks installed');
});
"""


def on_message(message, data):
    if message.get("type") == "send":
        print(message["payload"], flush=True)


def main():
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    pid = dev.spawn(["com.rokid.sprite.aiapp"])
    print("[*] spawned", pid, flush=True)
    session = dev.attach(pid)
    script = session.create_script(JS)
    script.on("message", on_message)
    script.load()
    dev.resume(pid)
    print("[*] resumed; collecting 60s …", flush=True)
    time.sleep(60)
    try:
        dev.kill(pid)
    except Exception:
        pass
    print("[*] done", flush=True)


if __name__ == "__main__":
    sys.exit(main())
