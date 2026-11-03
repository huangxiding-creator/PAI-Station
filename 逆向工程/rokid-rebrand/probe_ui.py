# -*- coding: utf-8 -*-
"""probe_ui.py — attach 运行中 app：①View树底导区 ②ClassLoader 清单 ③Compose特征"""
import sys
import time

import frida

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

JS = r"""
Java.perform(function() {
    // 1) ClassLoader 清单
    var names = [];
    Java.enumerateClassLoaders({
        onMatch: function(l) { names.push(l.toString().substring(0, 80)); },
        onComplete: function() { send({loaders: names}); }
    });
    // 2) 底部 View 树（找 BottomNavigationView / TabLayout / NavigationBar）
    try {
        var ActivityThread = Java.use('android.app.ActivityThread');
        var at = ActivityThread.currentActivityThread();
        // 走 DecorView 遍历
        var Runnable = Java.registerClass({
            name: 'com.probe.Run',
            implements: [Java.use('java.lang.Runnable')],
            methods: { run: function() {
                try {
                    var Activity = Java.use('android.app.Activity');
                    // 拿 resumed activities
                    var meth = ActivityThread.getMethod ? null : null;
                } catch (e) {}
            }}
        });
    } catch (e) {}
    // 3) 关键类是否存在（判断实现层）
    function probe(cls) {
        try { Java.use(cls); return true; } catch (e) { return false; }
    }
    send({
        compose: probe('androidx.compose.runtime.Composer'),
        bottomNav: probe('com.google.android.material.bottomnavigation.BottomNavigationView'),
        composeNavHost: probe('androidx.navigation.compose.NavHost'),
        rokidMain: probe('com.rokid.sprite.aiapp.ui.MainActivity'),
        kuiklyRender: probe('com.kwai.kuikly.render.KuiklyRenderView'),
    });
    // 4) MainActivity 的类加载器来源
    try {
        var mc = Java.use('com.rokid.sprite.aiapp.ui.MainActivity').class.getClassLoader();
        send({mainLoader: mc.toString().substring(0, 120)});
    } catch (e) { send({mainLoaderErr: '' + e}); }
});
"""


def main():
    pid = int(sys.argv[1])
    dev = frida.get_device_manager().add_remote_device("127.0.0.1:27042")
    session = dev.attach(pid)

    def on_message(message, data):
        print(message.get("payload", message), flush=True)

    script = session.create_script(JS)
    script.on("message", on_message)
    script.load()
    time.sleep(4)
    session.detach()


if __name__ == "__main__":
    main()
