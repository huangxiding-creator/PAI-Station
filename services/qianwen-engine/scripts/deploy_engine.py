# -*- coding: utf-8 -*-
"""TCB 云托管引擎重部署（新 secret + config），走 cloudbase CLI。"""
import sys, os, subprocess, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ENGINE = r"E:\AI-Station\services\qianwen-engine"
CLI = r"C:\Users\91216\AppData\Roaming\npm\cloudbase.cmd"

print("[1] 确认变更文件在位")
for f, desc in [
    ("data/secrets/virtual_pay.secret", "VP secret（kb_product_id=report_1999）"),
    ("qianwen_engine/config.py", "KB_GOODS_UNIT_FEN=100"),
]:
    p = os.path.join(ENGINE, "..", "..", f) if f.startswith("data") else os.path.join(ENGINE, f)
    if os.path.exists(p):
        content = open(p, encoding="utf-8").read()
        if "kb_product_id" in content or "KB_GOODS_UNIT_FEN" in content:
            print(f"  ✓ {desc}")
        else:
            print(f"  ! {f} 缺少 kb 相关键")
    else:
        print(f"  ✗ {f} 不存在")

print("[2] LF 归一（CRLF 会炸 Dockerfile）")
for root, dirs, files in os.walk(ENGINE):
    dirs[:] = [d for d in dirs if d not in ("__pycache__", ".pytest_cache", "node_modules", "data", "_*", ".*")]
    for fn in files:
        if fn.endswith((".py", ".sh", ".txt", ".md")):
            fp = os.path.join(root, fn)
            data = open(fp, "rb").read()
            if b"\r\n" in data:
                open(fp, "wb").write(data.replace(b"\r\n", b"\n"))
print("  归一完")

print("[3] cloudbase cloudrun deploy（需答灰度提示=否）")
p = subprocess.Popen(
    [CLI, "cloudrun", "deploy", "-s", "qianwen-engine",
     "--source", ENGINE, "--port", "8080", "--wait"],
    stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
    text=True, encoding="utf-8", errors="replace", cwd=ENGINE)

out = []
try:
    import threading
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
    p.wait(timeout=600)
    t.join(timeout=5)
except subprocess.TimeoutExpired:
    p.kill()
    print("[!] 超时")
except Exception as e:
    print(f"[!] {e}")

print(f"\n[4] rc={p.returncode}")
if p.returncode == 0:
    print("[✓] 部署成功")
else:
    print("[✗] 部署失败，最后10行：")
    for l in out[-10:]:
        print(f"  {l[:120]}")
