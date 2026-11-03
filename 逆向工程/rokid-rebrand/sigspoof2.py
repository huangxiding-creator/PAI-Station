# -*- coding: utf-8 -*-
"""sigspoof2.py — 双层伪装：①Java getPackageInfo 喂原证书 ②libnesec open(base.apk) 重定向原版文件
+ 存活后延迟 dump 16 片 dex（三鸟一弓）
"""
import base64
import os
import sys
import time

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
OUT = r"E:\AI-Station\逆向工程\rokid-rebrand\dump"
os.makedirs(OUT, exist_ok=True)

CERT_DER = open(r"E:\AI-Station\逆向工程\rokid-rebrand\original_cert.der", "rb").read()
CERT_HEX = base64.b64encode(CERT_DER).decode()

JS_TMPL = r"""
var ORIG_CERT_B64 = '%s';
var ORIG_APK = '/data/local/tmp/orig.apk';
var found = {};
var nesecBase = null;
var nesecSize = 0;

function inNesec(addr) {
    if (!nesecBase) return false;
    var a = addr.valueOf ? ptr(addr) : addr;
    return a.compare(nesecBase) >= 0 && a.compare(nesecBase.add(nesecSize)) < 0;
}

Java.perform(function() {
    send('[*] L1: Java 签名伪装');
    var PM = Java.use('android.app.ApplicationPackageManager');
    var Signature = Java.use('android.content.pm.Signature');
    PM.getPackageInfo.overload('java.lang.String', 'int').implementation = function(pkg, flags) {
        var info = this.getPackageInfo(pkg, flags);
        try {
            if (pkg === 'com.rokid.sprite.aiapp' && (flags & 64) !== 0) {
                var bytes = Java.use('android.util.Base64').decode(ORIG_CERT_B64, 0);
                info.signatures.value = Java.array('android.content.pm.Signature', [Signature.$new(bytes)]);
                send('[L1] getPackageInfo 签名已喂原版');
            }
        } catch (e) {}
        return info;
    };

    // L2: native open 重定向（libnesec 范围内的 base.apk 打开 → 原版）
    send('[*] L2: open 重定向部署');
    var modules = Process.enumerateModules();
    for (var i = 0; i < modules.length; i++) {
        if (modules[i].name.indexOf('nesec') !== -1) {
            nesecBase = modules[i].base;
            nesecSize = modules[i].size;
            send('[L2] libnesec @ ' + nesecBase + ' size=' + nesecSize);
        }
    }
    // libnesec 可能未加载(壳后加载) → 同时按路径含判断（任何非系统模块打开 base.apk 都重定向）
    ['openat', 'open'].forEach(function(fname) {
        var addr = Module.findExportByName('libc.so', fname);
        if (!addr) return;
        Interceptor.attach(addr, {
            onEnter: function(args) {
                try {
                    var pathArg = fname === 'open' ? args[0] : args[1];
                    var path = pathArg.readCString();
                    if (path && path.indexOf('/base.apk') !== -1 &&
                        path.indexOf('com.rokid.sprite.aiapp') !== -1) {
                        var caller = this.context.lr ? this.context.lr : ptr(0);
                        // 保守: 任何调用者都重定向（易盾壳库路径特征）——资源加载走 AssetManager 缓存不受影响
                        send('[L2] ' + fname + '(' + path + ') caller=' + caller + ' → 原版');
                        pathArg.writeUtf8String(ORIG_APK);
                        this.redirected = true;
                    }
                } catch (e) {}
            }
        });
    });
    send('[*] 双层伪装就绪');

    // L3: 延迟 dex 收割（等易盾解完 16 片）
    setTimeout(function() {
        Java.perform(function() {
            send('[*] L3: dex 扫描');
            var N = 0;
            function scan(r) {
                var file = r.file ? r.file.path : '';
                if (file && file.indexOf('/memfd:') !== 0) return;
                if (r.size > 600000000 || r.size < 4096) return;
                var CHUNK = 0x100000;
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
                                        try { send({n:N,size:fis}, Memory.readByteArray(addr,fis)); N++; } catch(e){}
                                    }
                                    i += fis-1;
                                }
                            }
                        }
                    } catch (e) {}
                }
            }
            var ranges = Process.enumerateRanges('r--');
            var idx = 0;
            var timer = setInterval(function() {
                var t0 = Date.now();
                while (idx < ranges.length && Date.now()-t0 < 150) { try { scan(ranges[idx]); } catch(e){} idx++; }
                if (idx >= ranges.length) { clearInterval(timer); send({done: true, n: N}); }
            }, 50);
        });
    }, 20000);
});
"""


def main():
    secs = int(sys.argv[1]) if len(sys.argv) > 1 else 120
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    pid = dev.spawn(["com.rokid.sprite.aiapp"])
    print("[*] spawned", pid, flush=True)
    session = dev.attach(pid)
    state = {"dex": 0, "l2": 0}

    def on_message(m, d):
        p = m.get("payload", {})
        if isinstance(p, str):
            print(p, flush=True)
            if p.startswith("[L2]"):
                state["l2"] += 1
            return
        if m.get("type") == "error":
            print("[JS-ERR]", m.get("description", "")[:120], flush=True)
            return
        if not isinstance(p, dict):
            return
        if p.get("done"):
            print(f"[*] dex 扫完 命中 {p['n']}", flush=True)
            state["fin"] = True
        if "n" in p and d and p["size"] > 50000:
            fn = os.path.join(OUT, "s2_%02d.dex" % state["dex"])
            open(fn, "wb").write(d)
            state["dex"] += 1
            print(f"[✓DUMP] {fn} {p['size']}B", flush=True)

    script = session.create_script(JS_TMPL % CERT_HEX)
    script.on("message", on_message)
    script.load()
    dev.resume(pid)
    print(f"[*] resumed; {secs}s 观察", flush=True)
    t0 = time.time()
    while time.time() - t0 < secs:
        time.sleep(2)
    import subprocess
    alive = subprocess.run(
        ["e:/AI-Station/rea-tools/platform-tools/adb.exe", "-s", "emulator-5554",
         "shell", "pidof", "com.rokid.sprite.aiapp"],
        capture_output=True).stdout.decode().strip()
    print(f"[*] 终局: 进程={'活! PID ' + alive if alive else '死'} L2重定向={state['l2']} dex={state['dex']}", flush=True)


if __name__ == "__main__":
    sys.exit(main())
