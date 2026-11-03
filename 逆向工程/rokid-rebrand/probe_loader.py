# -*- coding: utf-8 -*-
"""probe_loader.py — 反射挖 BaseDexClassLoader.pathList.dexElements[].dexFile 文件名/来源"""
import sys
import time

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

JS = r"""
Java.perform(function() {
    function dumpLoader(tag, cl) {
        try {
            var BaseDex = Java.cast(cl, Java.use('dalvik.system.BaseDexClassLoader'));
            var pathList = BaseDex.pathList.value;
            var elements = pathList.dexElements.value;
            var out = [];
            for (var i = 0; i < elements.length; i++) {
                var el = elements[i];
                var df = el.dexFile.value;
                var entry = {i: i};
                if (df !== null) {
                    try { entry.file = '' + df.mFileName.value; } catch (e) {}
                    try { entry.cookie = '' + df.mCookie.value; } catch (e) {}
                    try { entry.internal = '' + df.mInternalCookie.value; } catch (e) {}
                }
                try { entry.path = '' + el.path.value; } catch (e) {}
                out.push(entry);
            }
            send({loader: tag, elements: out});
        } catch (e) { send({loader: tag, err: '' + e}); }
    }
    var mc = Java.use('com.rokid.sprite.aiapp.ui.MainActivity').class.getClassLoader();
    dumpLoader('main', mc);
    dumpLoader('context', Java.use('java.lang.Thread').currentThread().getContextClassLoader());
    // loaded classes 里的 rokid 类计数（评估真代码规模）
    var cnt = 0, sample = [];
    Java.enumerateLoadedClasses({
        onMatch: function(name) {
            if (name.indexOf('com.rokid') === 0) { cnt++; if (sample.length < 12) sample.push(name); }
        },
        onComplete: function() { send({rokidClasses: cnt, sample: sample}); }
    });
});
"""


def main():
    pid = int(sys.argv[1])
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    session = dev.attach(pid)
    script = session.create_script(JS)
    script.on("message", lambda m, d: print(m.get("payload", m), flush=True))
    script.load()
    time.sleep(5)
    session.detach()


if __name__ == "__main__":
    main()
