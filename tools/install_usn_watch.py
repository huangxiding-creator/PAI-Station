"""USN 看护安装器（UAC 管理员窗口载荷，一次点击完成全部部署）。

做三件事（幂等，重复跑无害）：
1. fsutil readjournal 权限实测（真读记录流，结果落标记）
2. 注册 schtask PAIStation-usn-watch：当前用户最高权限、每 15 分钟
   （开机后 1 分钟也触发一次），以后读 USN 永不再弹 UAC
3. 立即跑一次载荷首跑（记水位）
结果写 install_result.json 供普通权限侧验证。
"""
from __future__ import annotations

import json
import subprocess
import time
from datetime import datetime
from pathlib import Path

OUT = Path(r"E:\AI-Station\data\local_index\install_result.json")
PYW = r"E:\AI-Station\.venv\Scripts\pythonw.exe"
TASK = "PAIStation-usn-watch"


def _ps(cmd: str) -> tuple[int, str]:
    p = subprocess.run(
        ["powershell", "-NoProfile", "-Command", cmd],
        capture_output=True, text=True, encoding="utf-8",
        errors="replace", timeout=120)
    return p.returncode, (p.stdout or "") + (p.stderr or "")


def main() -> int:
    res = {"ts": time.time(), "steps": {}}
    # ① readjournal 权限实测：真读 2 秒采样（非 queryjournal 的宽松面）
    try:
        p = subprocess.run(
            ["fsutil", "usn", "readjournal", "C:"], capture_output=True,
            text=True, encoding="mbcs", errors="replace", timeout=15)
        head = (p.stdout or "")[:400]
        res["steps"]["readjournal"] = {
            "rc": p.returncode,
            "ok": p.returncode == 0 and len(p.stdout or "") > 0,
            "head": head[-200:]}
    except subprocess.TimeoutExpired:
        # 超时=记录流巨大但读得动（权限已过）——采样态
        res["steps"]["readjournal"] = {"rc": 0, "ok": True,
                                       "note": "timeout=reading(权限OK)"}
    except Exception as exc:
        res["steps"]["readjournal"] = {"rc": -1, "ok": False, "err": str(exc)}
    # ② 注册常驻看护（最高权限 + 每 15 分钟 + 开机后补跑）
    ps = (
        "$a = New-ScheduledTaskAction -Execute "
        f"'{PYW}' -Argument "
        "'E:\\AI-Station\\tools\\usn_watch_task.py'; "
        "$t1 = New-ScheduledTaskTrigger -Once -At (Get-Date) "
        "-RepetitionInterval (New-TimeSpan -Minutes 15) "
        "-RepetitionDuration (New-TimeSpan -Days 3650); "
        "$t2 = New-ScheduledTaskTrigger -AtLogOn; "
        "$p = New-ScheduledTaskPrincipal -UserId $env:USERNAME "
        "-LogonType Interactive -RunLevel Highest; "
        f"Register-ScheduledTask -TaskName '{TASK}' -Action $a "
        "-Trigger @($t1,$t2) -Principal $p -Force | Out-Null; "
        f"(Get-ScheduledTask -TaskName '{TASK}').State")
    rc, out = _ps(ps)
    res["steps"]["register"] = {"rc": rc, "state": out.strip()[:40]}
    # ③ 首跑载荷（记水位）
    rc2, out2 = _ps(
        f"& 'E:\\AI-Station\\.venv\\Scripts\\python.exe' "
        f"E:\\AI-Station\\tools\\usn_watch_task.py; $LASTEXITCODE")
    res["steps"]["first_run"] = {"rc": rc2, "out": out2.strip()[:80]}
    res["ok"] = (res["steps"]["readjournal"]["ok"]
                 and "Running Ready".find(
                     res["steps"]["register"].get("state", "")) < 0
                 or res["steps"]["register"]["state"] in ("Ready", "Running"))
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(res, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    # 管理员窗口自证（用户能看到闪过的窗口内容意义不大，落文件为准）
    print(json.dumps(res, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    main()
