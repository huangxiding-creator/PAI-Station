# -*- coding: utf-8 -*-
"""xueyuan-engine ECS 部署驱动（母本=ecs_deploy_v025.py；ARCHITECTURE §七）。
tar.gz 本地打包 → base64 分片云助手追加 → 解包 → venv(requirements) → systemd → ufw → 探针。

布局: /opt/xueyuan/{services/xueyuan-engine, data/secrets, data/xueyuan, venv}
端口: 8871（8870=qianwen 在役门实例勿占；8864/8869 平行共存互不碰）
红线: 只写 /opt/xueyuan 前缀；绝不触碰 /opt/qianwen 与 8864/8869/8870。

用法:
  python ecs_deploy_xueyuan.py --dry-run   # 备料期干跑（不发任何 aliyun 调用）
  python ecs_deploy_xueyuan.py             # 部署日真跑（T-P0-23/24 到点才执行）
"""
import argparse
import base64
import io
import json
import os
import subprocess
import sys
import tarfile
import time
from pathlib import Path

ROOT = Path(r"E:\AI-Station")
ENGINE = ROOT / "services" / "xueyuan-engine"
PKG_DIR = ENGINE / "xueyuan_engine"
REQUIREMENTS = ENGINE / "requirements.txt"
SECRETS = {
    "xueyuan_mp.secret": ROOT / "data/secrets/xueyuan_mp.secret",
    "xueyuan_engine_hmac.key": ROOT / "data/secrets/xueyuan_engine_hmac.key",
}

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
CHUNK = 16000                    # 云助手 RunShellScript content 上限 16KB（母本实测口径）
PREFIX = "/opt/xueyuan"          # 与 /opt/qianwen 平行，互不覆盖
PORT = 8871
UNIT = "xueyuan-engine"
PKG_B64 = f"{PREFIX}/xy_pkg.b64"
HEALTH = f"http://127.0.0.1:{PORT}/health"
MIRROR = "https://mirrors.aliyun.com/pypi/simple/"
PER_CHUNK_SEC = 4.9              # 2026-09-28 云助手逐条往返实测（3 采样 4.8/4.9/4.9s）
NO_WINDOW = 0x08000000           # Windows 不弹窗铁律

# 零交叉判据：任何远端命令/清单出现以下子串即中止（与 /opt/qianwen 世界零交叉自查）
FORBIDDEN = ("/opt/qianwen", "qianwen-engine", "8864", "8869", "8870")


def run_aliyun(*args, timeout=90):
    # 剥离代理直连：aliyun 中国端点无需代理；经系统代理易遭 TCP 重置（2026-09-28 实锤 143 片处断链）
    env = {k: v for k, v in os.environ.items()
           if k.upper() not in ("HTTP_PROXY", "HTTPS_PROXY", "ALL_PROXY")}
    p = subprocess.run(["aliyun", "ecs", *args], capture_output=True, text=True,
                       encoding="utf-8", errors="replace", timeout=timeout,
                       env=env, creationflags=NO_WINDOW)
    if p.returncode != 0:
        raise RuntimeError(f"aliyun {' '.join(args[:2])} 失败: {(p.stderr or '')[:300]}")
    return p.stdout


def describe_inv(inv, attempts=4):
    """查询侧安全重试：纯读操作可任意重试（RunCommand 不重试——重跑有双执行风险）。"""
    last = None
    for i in range(attempts):
        try:
            return json.loads(run_aliyun("DescribeInvocationResults", "--RegionId", REGION,
                                         "--InvokeId", inv))
        except RuntimeError as e:
            last = e
            if i < attempts - 1:
                time.sleep(5 * (i + 1))
    raise last


def ecs_cmd(script, name, wait=300):
    # Timeout=600：云助手 RunCommand 的 API 参数名是 Timeout（默认 60s 会杀掉
    # venv/pip 这类分钟级命令，2026-09-28 实锤 xy-venv ExitCode=-1；
    # --TimeoutSeconds 非法参数名，第二次实锤）；wait 是本地轮询上限，须大于远端超时。
    out = run_aliyun("RunCommand", "--Type", "RunShellScript", "--Name", name,
                     "--CommandContent", script, "--InstanceId.1", INSTANCE,
                     "--RegionId", REGION, "--Timeout", "600")
    inv = json.loads(out)["InvokeId"]
    t0 = time.time()
    while time.time() - t0 < wait:
        time.sleep(4)
        r = describe_inv(inv)
        rs = (r.get("Invocation", {}).get("InvocationResults", {})
              .get("InvocationResult", []))
        if rs and rs[0].get("InvocationStatus") in ("Success", "Failed",
                                                    "Cancelled", "Timeout"):
            code = rs[0].get("ExitCode", -1)
            output = base64.b64decode(rs[0].get("Output") or "").decode(
                "utf-8", "replace")
            print(f"[{name}] exit={code}")
            if output.strip():
                print(output[-1500:])
            if code != 0:
                raise RuntimeError(f"{name} ExitCode={code}")
            return output
    raise TimeoutError(f"{name} 超时")


def build_pkg():
    """内存构建 tar.gz：xueyuan_engine/ + tools/(qr_pool 码池) + requirements.txt。"""
    buf = io.BytesIO()
    with tarfile.open(fileobj=buf, mode="w:gz") as tf:
        tf.add(str(PKG_DIR), arcname="xueyuan_engine")
        tf.add(str(REQUIREMENTS), arcname="requirements.txt")
        tf.add(str(PKG_DIR.parent / "tools"), arcname="tools")   # 0929：码池工具随包（Day-0 release 重灌用）
    members = {"xueyuan_engine", "requirements.txt", "tools"}
    return buf.getvalue(), members


def cmd_mkdir():
    # rm 幂等头：重跑部署时清掉旧 b64，防分片二次追加污染包体（2026-09-28 加固）
    return (f"mkdir -p {PREFIX}/services/xueyuan-engine {PREFIX}/data/secrets "
            f"{PREFIX}/data/xueyuan/pdfs {PREFIX}/data/xueyuan/posters "
            f"{PREFIX}/data/xueyuan/content {PREFIX}/data/content_pkg && "
            f"rm -f {PKG_B64}")


def cmd_clean():
    return f"rm -f {PKG_B64}"


def cmd_chunk(chunk):
    return f"printf %s '{chunk}' >> {PKG_B64}"


def cmd_unpack(secret_cmds):
    return (
        f"cd {PREFIX} && base64 -d xy_pkg.b64 | "
        f"tar xz -C services/xueyuan-engine/ && "
        f"ls services/xueyuan-engine/xueyuan_engine | wc -l && "
        + " && ".join(secret_cmds) + " && "
        # virtual_pay 凭证未开通 → 占位文件（v025 同款；引擎侧缺字段=503 降级不炸）
        f"([ -f {PREFIX}/data/secrets/virtual_pay_xueyuan.secret ] || "
        f"printf '# 虚拟支付配置（用户开通后回填 offer_id/product_id）\\n"
        f"offer_id=\\nproduct_id=\\nenv=0\\n' "
        f"> {PREFIX}/data/secrets/virtual_pay_xueyuan.secret) && "
        f"ls -la {PREFIX}/data/secrets | tail -4"
    )


def cmd_venv():
    return (
        f"test -x {PREFIX}/venv/bin/pip || python3 -m venv {PREFIX}/venv; "
        f"{PREFIX}/venv/bin/pip install -q -i {MIRROR} -r "
        f"{PREFIX}/services/xueyuan-engine/requirements.txt && echo PIP_OK && "
        f"{PREFIX}/venv/bin/python -c "
        "'import fastapi,uvicorn,curl_cffi,jieba,PIL,pypdf; print(\"IMPORT_OK\")'"
    )


def systemd_unit():
    return (
        "[Unit]\nDescription=xueyuan-engine (zongbao market)\n"
        "After=network.target\n\n"
        "[Service]\n"
        f"WorkingDirectory={PREFIX}/services/xueyuan-engine\n"
        f"Environment=XY_CONTENT_DIR={PREFIX}/data/content_pkg\n"
        f"ExecStart={PREFIX}/venv/bin/python -m uvicorn xueyuan_engine.app:app"
        f" --host 0.0.0.0 --port {PORT} --log-level warning\n"
        "Restart=always\nRestartSec=3\n\n"
        "[Install]\nWantedBy=multi-user.target\n"
    )


def cmd_systemd(unit_b64):
    # enable --now 对已 active 服务不重启（2026-09-28 P1 部署实锤：盘上代码已换、
    # 进程仍跑旧模块致新路由 404）——显式 restart 保证换血
    return (
        f"printf %s '{unit_b64}' | base64 -d > /etc/systemd/system/{UNIT}.service"
        f" && systemctl daemon-reload && systemctl enable {UNIT}"
        f" && systemctl restart {UNIT}"
        f" && sleep 3 && echo service=$(systemctl is-active {UNIT})"
    )


def cmd_ufw():
    # ⚠ 双层墙纪律：云助手只做 ufw 层。阿里云安全组 8871 放行=用户控制台位，
    #   本脚本绝不调 AuthorizeSecurityGroup（开闸请示一次到位，ARCHITECTURE §七）。
    return (f"ufw allow {PORT}/tcp comment 'xueyuan-engine' && "
            f"ufw status | grep '{PORT}/tcp'")


def cmd_probe():
    return (f"curl -s -o /dev/null -w 'health=%{{http_code}}\\n' {HEALTH} && "
            f"curl -s {HEALTH}")


def audit(commands, members):
    """零交叉自查：命令与包清单不得出现 qianwen 世界任何痕迹。"""
    hits = [c[:80] for c in commands
            for bad in FORBIDDEN if bad in c]
    bad_members = [m for m in members if not (
        m == "requirements.txt" or m == "tools"   # 0929：qr_pool 码池工具随包
        or m.startswith("xueyuan_engine"))]
    if hits or bad_members:
        raise RuntimeError(f"零交叉审计失败 hits={hits} bad_members={bad_members}")
    return True


def check_local_sources():
    missing = [str(p) for p in (PKG_DIR / "app.py", PKG_DIR / "config.py",
                                REQUIREMENTS, *SECRETS.values()) if not p.exists()]
    if missing:
        raise RuntimeError(f"本地源缺失: {missing}")


def secret_cmds():
    return [
        f"printf %s '{base64.b64encode(p.read_bytes()).decode()}'"
        f" | base64 -d > {PREFIX}/data/secrets/{name}"
        for name, p in SECRETS.items()
    ]


def plan():
    """生成部署计划（干跑与真跑共用同一代码路径，保证所查即所跑）。"""
    pkg, members = build_pkg()
    b64 = base64.b64encode(pkg).decode()
    chunks = [b64[i:i + CHUNK] for i in range(0, len(b64), CHUNK)]
    unit_b64 = base64.b64encode(systemd_unit().encode()).decode()
    static_cmds = [cmd_mkdir(), cmd_clean(), cmd_unpack(secret_cmds()),
                   cmd_venv(), cmd_systemd(unit_b64), cmd_ufw(), cmd_probe()]
    audit(static_cmds, members)
    return {"pkg_bytes": len(pkg), "chunks": chunks, "members": members,
            "static_cmds": static_cmds}


def dry_run():
    check_local_sources()
    p = plan()
    eta = len(p["chunks"]) * PER_CHUNK_SEC
    print(f"[DRY-RUN] 引擎包 {p['pkg_bytes']} bytes → {len(p['chunks'])} 片"
          f"（含解包/venv/systemd/ufw/探针共 {len(p['static_cmds']) + len(p['chunks'])}"
          f" 次云助手调用，预估 {eta / 60:.0f} 分 + 固定步骤约 3 分）")
    print("[DRY-RUN] tar 成员:", sorted(p["members"]))
    print("[DRY-RUN] 远端命令清单（占位脱敏）:")
    for i, c in enumerate(p["static_cmds"]):
        shown = c if len(c) < 200 else c[:200] + " …(截断)"
        print(f"  {i + 1}. {shown}")
    print("[DRY-RUN] systemd unit 预览:")
    print(systemd_unit())
    print("[DRY-RUN] 零交叉审计 PASS（无 /opt/qianwen|8864|8869|8870 痕迹）")
    print("[DRY-RUN] 未发生任何 aliyun 调用；未触碰 ECS")
    return 0


def deploy():
    check_local_sources()
    p = plan()
    print(f"包体 {p['pkg_bytes']} bytes → {len(p['chunks'])} 片")
    ecs_cmd(cmd_clean() + " && " + cmd_mkdir(), "xy-mkdir")
    for i, ch in enumerate(p["chunks"]):
        ecs_cmd(cmd_chunk(ch), f"xy-chunk{i:03d}", wait=120)
    ecs_cmd(cmd_unpack(secret_cmds()), "xy-unpack")
    out = ecs_cmd(cmd_venv(), "xy-venv", wait=900)
    if "IMPORT_OK" not in out:
        raise RuntimeError("依赖安装失败")
    ecs_cmd(cmd_systemd(base64.b64encode(systemd_unit().encode()).decode()),
            "xy-systemd", wait=120)
    ecs_cmd(cmd_ufw(), "xy-ufw")
    out = ecs_cmd(cmd_probe(), "xy-probe")
    if "health=200" not in out:
        raise RuntimeError(f"探针未达 200: {out[-200:]}")
    ecs_cmd(f"rm -f {PKG_B64}", "xy-clean")
    print("XUEYUAN DEPLOY DONE —— 公网探针待安全组 8871 放行后即通"
          "（用户控制台位，本脚本不开）")


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--dry-run", action="store_true", help="只校验不执行")
    args = ap.parse_args()
    try:
        return dry_run() if args.dry_run else deploy()
    except Exception as e:  # noqa: BLE001 —— 部署驱动顶层兜底
        print(f"FAIL: {e}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
