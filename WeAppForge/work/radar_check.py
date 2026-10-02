# -*- coding: utf-8 -*-
"""引擎雷达：查 ECS 生产 DB users 表是否新增登录（桌面微信打开体验版 0.2.7 的实证）。"""
import base64
import sys

sys.path.insert(0, "E:/AI-Station/WeAppForge/work")
import ecs_deploy

NL = chr(10)
payload = (
    "import glob, sqlite3, json" + NL
    + "import subprocess" + NL
    + "out = subprocess.run(['find', '/opt/qianwen', '-name', '*.sqlite*'], capture_output=True, text=True).stdout" + NL
    + "dbs = [x for x in out.splitlines() if x.strip()]" + NL
    + "print('DB_FILES:', dbs)" + NL
    + "for db in set(dbs):" + NL
    + "    try:" + NL
    + "        con = sqlite3.connect(db)" + NL
    + '        q = "SELECT name FROM sqlite_master WHERE type=" + chr(39) + "table" + chr(39)' + NL
    + "        tabs = [r[0] for r in con.execute(q)]" + NL
    + "        if 'users' in tabs:" + NL
    + "            cols = [r[1] for r in con.execute('PRAGMA table_info(users)')]" + NL
    + "            print('USERS_COLS:', cols)" + NL
    + "            rows = list(con.execute('SELECT * FROM users ORDER BY rowid DESC LIMIT 8'))" + NL
    + "            cnt = con.execute('SELECT COUNT(*) FROM users').fetchone()[0]" + NL
    + "            print('USERS_DB:', db, 'count=', cnt)" + NL
    + "            for r in rows: print('  ROW:', r)" + NL
    + "        con.close()" + NL
    + "    except Exception as e:" + NL
    + "        print('ERR', db, e)" + NL
)
b64 = base64.b64encode(payload.encode("utf-8")).decode()
script = (
    "cd /opt/qianwen" + NL
    + f"echo {b64} | base64 -d > /tmp/radar.py" + NL
    + "PYTHONIOENCODING=utf-8 /opt/qianwen/venv/bin/python /tmp/radar.py 2>&1 | tail -20" + NL
)
code, out = ecs_deploy.ecs_cmd(script, "qw-radar-check", wait=180)
print("exit:", code)
print(out[-1500:])
