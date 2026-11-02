# -*- coding: utf-8 -*-
"""hook_spawn.py — spawn 模式 Frida：抢在反调试前钩住 okhttp 头
用法：python hook_spawn.py <采集秒数>
"""
import sys
import time

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
LOG = r"E:\AI-Station\逆向工程\weread-apk-reverse\evidence\frida_headers.log"

JS = """
Java.perform(function() {
    var Builder = Java.use('okhttp3.Request$Builder');
    Builder.build.implementation = function() {
        var req = this.build();
        try {
            var url = req.url().toString();
            if (url.indexOf('i.weread.qq.com') !== -1) {
                send('[REQ] ' + url);
                send('[HDR]\\n' + req.headers().toString());
            }
        } catch (e) { send('[ERR] ' + e); }
        return req;
    };
    send('[*] okhttp hook installed');
});
"""


def on_message(message, data):
    if message.get("type") == "send":
        line = message["payload"]
        print(line, flush=True)
        with open(LOG, "a", encoding="utf-8") as fh:
            fh.write(line + "\n")
    elif message.get("type") == "error":
        print("[FRIDA-ERR]", message.get("description", ""), flush=True)


def main():
    secs = int(sys.argv[1]) if len(sys.argv) > 1 else 45
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    pid = dev.spawn(["com.tencent.weread"])
    print("[*] spawned pid", pid, flush=True)
    session = dev.attach(pid)
    script = session.create_script(JS)
    script.on("message", on_message)
    script.load()
    dev.resume(pid)
    print("[*] resumed, collecting %ds ..." % secs, flush=True)
    t0 = time.time()
    while time.time() - t0 < secs:
        time.sleep(1)
    try:
        dev.kill(pid)
    except Exception:
        pass
    print("[*] done", flush=True)


if __name__ == "__main__":
    sys.exit(main())
