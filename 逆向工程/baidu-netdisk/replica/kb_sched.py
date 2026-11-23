# -*- coding: utf-8 -*-
"""kb_sched — 超级总包知识库每日自动更新的计划任务入口。
跑三条：kb_build.py update（归位/复制/净化/核验补缺，余量闸门 50GiB）+ kb_build.py index（刷新并上传索引）
+ kb_engine_data.py（引擎 C1/C2 数据面刷新，AI顾问知识库栏目数据源）。
日志落 _kb_build/sched_update.log；无论内部退出码如何总退出 0，保证三条都跑。"""
import os
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
LOG = os.path.join(HERE, "_kb_build", "sched_update.log")
os.makedirs(os.path.dirname(LOG), exist_ok=True)

STEPS = (
    (os.path.join(HERE, "kb_build.py"), ["update", "--reserve-gb", "50"]),
    (os.path.join(HERE, "kb_build.py"), ["index"]),
    (os.path.join(HERE, "kb_engine_data.py"), []),
)


def main() -> int:
    with open(LOG, "a", encoding="utf-8") as log:
        log.write("\n==== %s run ====\n" % subprocess.list2cmdline([sys.executable]))
        for script, args in STEPS:
            cmd = [sys.executable, "-I", "-X", "utf8", script] + args
            log.write("\n$ %s %s\n" % (os.path.basename(script), " ".join(args)))
            log.flush()
            r = subprocess.run(cmd, capture_output=True, text=True,
                               encoding="utf-8", errors="replace", cwd=HERE)
            out = (r.stdout or "").strip()
            err = (r.stderr or "").strip()
            if len(out) > 20000:
                out = out[:20000] + "\n…(截断)"
            log.write(out + "\n")
            if err:
                log.write("[stderr] " + err[-2000:] + "\n")
            log.write("[exit %d]\n" % r.returncode)
            log.flush()
    return 0


if __name__ == "__main__":
    sys.exit(main())
