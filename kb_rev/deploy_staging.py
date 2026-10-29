# -*- coding: utf-8 -*-
"""staging 部署（Python 自动答灰度提示）。"""
import subprocess, time, threading, sys, os
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

STAGING = r"E:\AI-Station\kb_rev\engine_staging"
CLI = r"C:\Users\91216\AppData\Roaming\npm\cloudbase.cmd"

# LF 归一 staging 所有文本文件
for root, dirs, files in os.walk(STAGING):
    for fn in files:
        fp = os.path.join(root, fn)
        data = open(fp, "rb").read()
        if b"\r\n" in data:
            open(fp, "wb").write(data.replace(b"\r\n", b"\n"))
print("[1] LF 归一完")

print("[2] 部署（自动答灰度=否）...")
p = subprocess.Popen(
    [CLI, "cloudrun", "deploy", "-s", "qianwen-engine",
     "--source", STAGING, "--port", "8080"],
    stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
    text=True, encoding="utf-8", errors="replace")

out = []
answered = [False]

def reader():
    for line in p.stdout:
        out.append(line.rstrip())
        print(line.rstrip()[:140])
        if "灰度" in line and not answered[0]:
            time.sleep(1)
            p.stdin.write("\n")
            p.stdin.flush()
            answered[0] = True
            print(">>> [已答：否（直切流量）]")

t = threading.Thread(target=reader, daemon=True)
t.start()
try:
    p.wait(timeout=900)  # 15分钟（Docker build 可能慢）
    t.join(timeout=5)
except subprocess.TimeoutExpired:
    p.kill()
    print("[!] 15分钟超时")

print(f"\n[3] rc={p.returncode}")
if p.returncode == 0:
    print("[✓] 部署成功！")
else:
    print("[✗] 最后输出：")
    for l in out[-8:]:
        print(f"  {l[:140]}")
