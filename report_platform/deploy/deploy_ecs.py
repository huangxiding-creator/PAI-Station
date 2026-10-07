# -*- coding: utf-8 -*-
"""deploy_ecs — 发布平台部署到阿里云 ECS (F5a).

通道 = tools/ecs_qw.py (阿里云 CLI RunCommand, 免 SSH); 打包 tar.gz →
base64 分片 (每片 12KB, RunCommand 脚本体上限 16KB) → 远端拼装解压 →
systemd 常驻 :8885 → ufw 开闸; 安全组由本脚本末段 aliyun CLI 开 (双层墙配方).
admin token 从本地 secret.ini 读 (绝不进包/不进仓).

用法: python deploy/deploy_ecs.py [--check-only]
"""
from __future__ import annotations

import argparse
import base64
import io
import json
import subprocess
import sys
import tarfile
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, r"E:\AI-Station\tools")
sys.path.insert(0, str(ROOT))
from ecs_qw import run  # noqa: E402
from template import SITE_BASE  # noqa: E402  域名唯一属主在 template

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
PORT = 8885
CHUNK = 12000


def _pack(site_only: bool = False) -> bytes:
    buf = io.BytesIO()
    rels = ("site", "template.py") if site_only else (
        "site", "server.py", "pay.py", "content", "template.py")
    with tarfile.open(fileobj=buf, mode="w:gz") as tf:
        for rel in rels:
            p = ROOT / rel
            if p.is_file():
                tf.add(p, arcname=f"report_platform/{rel}")
            else:
                for f in sorted(p.rglob("*")):
                    if f.is_file():
                        tf.add(f, arcname=f"report_platform/{rel}/"
                                + f.relative_to(p).as_posix())
    return buf.getvalue()


def _token() -> str:
    ini = ROOT / "secret.ini"
    if ini.is_file():
        for line in ini.read_text(encoding="utf-8").splitlines():
            if line.startswith("admin_token="):
                return line.split("=", 1)[1].strip()
    import os
    return os.environ.get("RP_ADMIN_TOKEN", "")


def _aliyun(*args: str) -> dict:
    r = subprocess.run(["aliyun", *args], capture_output=True, text=True,
                       encoding="utf-8", errors="replace")
    if r.returncode != 0:
        raise RuntimeError(f"aliyun {' '.join(args[:3])} 失败: {r.stderr[:400]}")
    return json.loads(r.stdout)


def sg_open() -> str:
    """安全组开 Tcp 8885 (幂等: 已有同规则则跳)."""
    sgs = _aliyun("ecs", "DescribeSecurityGroups", "--RegionId", REGION)
    sgid = None
    for g in sgs.get("SecurityGroups", {}).get("SecurityGroup", []):
        sgid = g["SecurityGroupId"]                 # 实例唯一 SG
        break
    if not sgid:
        return "no-sg-found"
    perms = _aliyun("ecs", "DescribeSecurityGroupAttribute",
                    "--RegionId", REGION, "--SecurityGroupId", sgid)
    for p in perms.get("Permissions", {}).get("Permission", []):
        if (p.get("IpProtocol") == "tcp" and str(p.get("PortRange")) ==
                f"{PORT}/{PORT}" and p.get("Direction") == "ingress"):
            return f"sg {sgid} already-open"
    _aliyun("ecs", "AuthorizeSecurityGroup", "--RegionId", REGION,
            "--SecurityGroupId", sgid, "--IpProtocol", "tcp",
            "--PortRange", f"{PORT}/{PORT}", "--SourceCidrIp", "0.0.0.0/0",
            "--Description", "report-platform-f5a")
    return f"sg {sgid} opened {PORT}"


def main(check_only: bool, site_only: bool = False) -> int:
    blob = _pack(site_only)
    b64 = base64.b64encode(blob).decode("ascii")
    print(f"[dep] pack {len(blob)}B → b64 {len(b64)} chars, "
          f"{(len(b64) + CHUNK - 1) // CHUNK} chunks"
          + (" (site-only)" if site_only else ""))
    if check_only:
        return 0
    tok = _token()
    if not tok and not site_only:
        print("[dep] ! secret.ini 无 admin_token — admin 台将不可用 (站照常)")
    ec, out = run("mkdir -p /www /tmp/rp_in && rm -f /tmp/rp_in/rp.b64 && "
                  "echo ready")
    if ec != 0:
        print("[dep] 远端预置失败:\n", out)
        return 1
    t0 = time.time()
    for i in range(0, len(b64), CHUNK):
        ec, out = run(f"printf '%s' '{b64[i:i + CHUNK]}' >> /tmp/rp_in/rp.b64")
        if ec != 0:
            print(f"[dep] 片 {i // CHUNK} 失败:\n", out)
            return 1
    print(f"[dep] {((len(b64) + CHUNK - 1) // CHUNK)} 片上传 "
          f"{time.time() - t0:.0f}s")
    if site_only:
        # 暂存-验证-换入 (评审 MEDIUM): 解压进 site_new → 验证过了才 mv 换入;
        # 验证失败=线上仍是旧版; 同目录 mv=原子换, 不再边解压边服务.
        swap = run(
            "set -e\n"
            "base64 -d /tmp/rp_in/rp.b64 > /tmp/rp_in/rp.tgz\n"
            "cd /www/report_platform\n"
            "rm -rf site_new && mkdir site_new\n"
            "tar -xzf /tmp/rp_in/rp.tgz -C site_new --strip-components=2"
            " report_platform/site\n"
            "tar -xzf /tmp/rp_in/rp.tgz -C . --strip-components=1"
            " report_platform/template.py\n"
            "grep -c 'property=\"og:url\"' site_new/index.html\n"
            "ls site_new/assets/og_card.png\n"
            "rm -rf site_old\n"
            "[ ! -d site ] || mv site site_old\n"
            "mv site_new site\n"
            "rm -rf site_old /tmp/rp_in\n"
            f"curl -s -o /dev/null -w 'local:%{{http_code}}'"
            f" http://127.0.0.1:{PORT}/\n")
        print(f"[dep] site-only exit={swap[0]}\n{swap[1].strip()}")
        if swap[0] != 0:
            print("[dep] ! 验证失败 — 未换入, 线上仍是旧版; 新包留 /tmp/rp_in 待查")
            return 1
        print(f"[dep] 公网验收: {SITE_BASE}/ (或 http://47.120.43.20:{PORT}/)")
        return 0
    setup = f"""
set -e
base64 -d /tmp/rp_in/rp.b64 > /tmp/rp_in/rp.tgz
tar -xzf /tmp/rp_in/rp.tgz -C /www/
mkdir -p /www/report_platform/data
python3 -c 'import qrcode' 2>/dev/null || pip3 install -q --break-system-packages qrcode || apt-get install -y -q python3-qrcode >/dev/null 2>&1 || true
cat > /etc/systemd/system/report-platform.service <<'UNIT'
[Unit]
Description=Report Platform (F5a flagship paid-report H5)
After=network.target
[Service]
Type=simple
WorkingDirectory=/www/report_platform
Environment=RP_ADMIN_TOKEN={tok}
ExecStart=/usr/bin/python3 /www/report_platform/server.py --site /www/report_platform/site --db /www/report_platform/data/report_platform.db --port {PORT}
Restart=always
RestartSec=5
[Install]
WantedBy=multi-user.target
UNIT
systemctl daemon-reload
systemctl enable report-platform >/dev/null 2>&1
systemctl restart report-platform
sleep 2
ufw allow {PORT}/tcp >/dev/null 2>&1 || true
systemctl is-active report-platform
curl -s -o /dev/null -w 'local:%{{http_code}}' http://127.0.0.1:{PORT}/
"""
    ec, out = run(setup)
    print(f"[dep] setup exit={ec}\n{out.strip()}")
    if ec != 0:
        return 1
    print("[dep]", sg_open())
    print(f"[dep] 公网验收: http://47.120.43.20:{PORT}/")
    return 0


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--check-only", action="store_true")
    ap.add_argument("--site-only", action="store_true",
                    help="只发 site/+template.py 增量 (静态站, 免重启)")
    ns = ap.parse_args()
    sys.exit(main(ns.check_only, ns.site_only))
