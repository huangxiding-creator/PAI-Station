# -*- coding: utf-8 -*-
"""引擎部署（新 kb_product_id + config）。"""
import sys, os, subprocess, time, threading
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ENGINE = r"E:\AI-Station\services\qianwen-engine"
CLI = r"C:\Users\91216\AppData\Roaming\npm\cloudbase.cmd"

# LF 归一
for root, dirs, files in os.walk(ENGINE):
    dirs[:] = [d for d in dirs if d not in ("__pycache__", ".pytest_cache", "node_modules", "data")]
    for fn in files:
        if fn.endswith((".py", ".sh")):
            fp = os.path.join(root, fn)
            data = open(fp, "rb").read()
            if b"\r\n" in data:
                open(fp, "wb").write(data.replace(b"\r\n", b"\n"))
print("[1] LF 归一完")

# 部署
print("[2] cloudrun deploy...")
p = subprocess.Popen(
    [CLI, "cloudrun", "deploy", "-s", "qianwen-engine",
     "--source", ENGINE, "--port", "8080", "--wait", "--force"],
    stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
    text=True, encoding="utf-8", errors="replace", cwd=ENGINE)

out = []
def reader():
    for line in p.stdout:
        out.append(line.rstrip())
        print(line.rstrip()[:120])
        if "灰度" in line and p.poll() is None:
            time.sleep(0.5)
            p.stdin.write("\n")
            p.stdin.flush()

t = threading.Thread(target=reader, daemon=True)
t.start()
try:
    p.wait(timeout=600)
    t.join(timeout=5)
except subprocess.TimeoutExpired:
    p.kill()
    print("[!] 超时")

print(f"\n[3] rc={p.returncode}")
if p.returncode == 0:
    print("[✓] 部署成功！")
else:
    print("[✗] 最后输出：")
    for l in out[-8:]:
        print(f"  {l[:120]}")
