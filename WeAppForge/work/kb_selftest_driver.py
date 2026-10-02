# -*- coding: utf-8 -*-
"""LEG A 自检驱动：ECS 上直调引擎真实秘塔 KB 函数（免费网页会话池，单次必要性验证）。"""
import base64
import sys

sys.path.insert(0, "E:/AI-Station/WeAppForge/work")
import ecs_deploy

NL = chr(10)
payload = (
    "import sys" + NL
    + 'sys.path.insert(0, "/opt/qianwen/services/qianwen-engine")' + NL
    + "from qianwen_engine import metaso_kb" + NL
    + 'r = metaso_kb.ask("自检：联合体投标各方资质等级如何认定？请简要回答。")' + NL
    + 'a = getattr(r, "answer", "") or ""' + NL
    + 'c = getattr(r, "citations", []) or []' + NL
    + 'print("KB_ANSWER_LEN:", len(a))' + NL
    + 'print("KB_CITES:", len(c))' + NL
    + 'print("KB_HEAD:", a[:150].replace(chr(10), " "))' + NL
    + 'print("KB_ELAPSED:", getattr(r, "elapsed_sec", "?"))' + NL
    + 'print("LEG_A_VERDICT:", "PASS" if len(a) > 100 else "FAIL")' + NL
)
b64 = base64.b64encode(payload.encode("utf-8")).decode()
script = (
    "cd /opt/qianwen" + NL
    + f"echo {b64} | base64 -d > /tmp/kb_selftest.py" + NL
    + 'PY=/opt/qianwen/venv/bin/python; [ -x "$PY" ] || PY=python3' + NL
    + "PYTHONIOENCODING=utf-8 $PY /tmp/kb_selftest.py 2>&1 | tail -15" + NL
)
code, out = ecs_deploy.ecs_cmd(script, "qw-kb-selftest2", wait=300)
print("exit:", code)
print(out[-1200:])
