# -*- coding: utf-8 -*-
"""只读体检 ECS 生产引擎：部署版本 / 服务运行时 / 生产 answers 表 / 引擎日志。
判定缺陷用：v0.7.0 是否在役 + 有无截断/兜底痕迹。零写操作。"""
import base64
import json
import subprocess
import time

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"


def run(*args, timeout=60):
    r = subprocess.run(["aliyun", *args], capture_output=True, text=True, timeout=timeout)
    if r.returncode != 0:
        raise RuntimeError(f"aliyun {' '.join(args[:3])} failed: {r.stderr[:300]}")
    return r.stdout


def ecs_cmd(script, name, wait=180):
    out = run("ecs", "RunCommand", "--RegionId", REGION, "--Type", "RunShellScript",
              "--CommandContent", script, "--Name", name,
              "--InstanceId.1", INSTANCE, "--Timeout", "300", timeout=60)
    iid = json.loads(out)["InvokeId"]
    t0 = time.time()
    while time.time() - t0 < wait:
        time.sleep(4)
        res = json.loads(run("ecs", "DescribeInvocationResults",
                             "--RegionId", REGION, "--InvokeId", iid, timeout=60))
        results = (res.get("Invocation", {}).get("InvocationResults", {})
                   .get("InvocationResult", []))
        if results and results[0].get("ExitCode") is not None:
            output = base64.b64decode(results[0].get("Output") or "")
            return results[0]["ExitCode"], output.decode("utf-8", "replace")
    raise TimeoutError(f"ECS 命令超时: {name}")


SCRIPT = r"""
echo '=== [1] deployed metaso_kb version markers ==='
grep -c '_chat_post_stream' /opt/qianwen/services/qianwen-engine/qianwen_engine/metaso_kb.py 2>/dev/null
grep -n 'len(answer) >= config.MIN_ANSWER_LEN' /opt/qianwen/services/qianwen-engine/qianwen_engine/metaso_kb.py 2>/dev/null
md5sum /opt/qianwen/services/qianwen-engine/qianwen_engine/metaso_kb.py 2>/dev/null
echo '=== [2] service state ==='
systemctl is-active qianwen-engine
systemctl show qianwen-engine -p ActiveEnterTimestamp -p ExecMainStartTimestamp
echo '=== [3] answers table (recent 40) ==='
/opt/qianwen/venv/bin/python - <<'PYEOF'
import sqlite3
conn = sqlite3.connect('/opt/qianwen/data/qianwen/db.sqlite')
conn.row_factory = sqlite3.Row
rows = conn.execute(
    "SELECT length(answer_full) alen, elapsed_sec, via, status,"
    " substr(error_text,1,60) err, created_at FROM answers"
    " ORDER BY rowid DESC LIMIT 40").fetchall()
for r in rows:
    print(dict(r))
print('--- length histogram (all time) ---')
for r in conn.execute(
        "SELECT CASE WHEN length(answer_full)<100 THEN 'a<100'"
        " WHEN length(answer_full)<300 THEN 'b100-300'"
        " WHEN length(answer_full)<800 THEN 'c300-800'"
        " ELSE 'd>=800' END bucket, status, COUNT(*) n"
        " FROM answers GROUP BY bucket, status ORDER BY bucket"):
    print(dict(r))
PYEOF
echo '=== [4] engine journal: fallback/polling/timeout traces (3 days) ==='
journalctl -u qianwen-engine --since '2026-09-28' --no-pager 2>/dev/null | grep -E '回答超时|为空|EngineError|Traceback|超时' | tail -30
echo '=== [5] done ==='
"""


def main():
    code, out = ecs_cmd(SCRIPT, "qw-refute-inspect")
    print(out)
    return code


if __name__ == "__main__":
    sys_rc = main()
    raise SystemExit(sys_rc)
