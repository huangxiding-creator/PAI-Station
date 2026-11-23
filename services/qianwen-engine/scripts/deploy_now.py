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

# 内容真身同步（1124 实锤：report_content 实拷贝快照会漂移——每次部署前从源真身重同步）
import subprocess as _sp
SRC_CONTENT = r"E:\AI-Station\report_platform\content"
rc = _sp.run(["robocopy", SRC_CONTENT, os.path.join(ENGINE, "report_content"),
              "/E", "/NFL", "/NDL", "/NJH", "/NJS", "/NP"],
             capture_output=True, text=True, encoding="utf-8", errors="replace")
print(f"[1.5] report_content 同步 robocopy rc={rc.returncode}（0-7=成功口径）")

# KB 数据面同步：先重生成（plan+ledger 实时口径），再拷进 kb_content
rund = _sp.run([sys.executable, "-I", "-X", "utf8",
                r"E:\AI-Station\逆向工程\baidu-netdisk\replica\kb_engine_data.py"],
               capture_output=True, text=True, encoding="utf-8", errors="replace",
               cwd=r"E:\AI-Station\逆向工程\baidu-netdisk\replica")
print(f"[1.6] kb_engine_data 生成 rc={rund.returncode} {((rund.stdout or '').strip().splitlines() or [''])[0][:120]}")
KB_SRC = r"E:\AI-Station\逆向工程\baidu-netdisk\replica\_kb_build"
for fn in ("kb_catalog.json", "kb_updates.json"):
    src = os.path.join(KB_SRC, fn)
    if os.path.isfile(src):
        open(os.path.join(ENGINE, "kb_content", fn), "wb").write(open(src, "rb").read())
print("[1.6] kb_content 两 JSON 已同步")

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
