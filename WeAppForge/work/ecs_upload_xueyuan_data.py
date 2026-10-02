# -*- coding: utf-8 -*-
"""xueyuan 数据资产分批上云驱动（DEPLOY_PREP 上云路线决策的执行件）。
背景: OSS 探测=UserDisable(403) 未开通；云助手分片实测 4.9s/条。
混合路线: core(content+db+包内容, gzip 后约 7MB≈1h)当天全功能先上；
         pdfs(75.7MB tgz≈6.3k 片≈8.6h)按报告粒度分批夜间搬，断点续跑（本地台账）。
等用户控制台开通 OSS 后，本脚本整体退役，改走 oss cp + ECS 内网 wget（见 DEPLOY_PREP §1）。

红线: 只写 /opt/xueyuan 前缀；不碰 /opt/qianwen 与 8864/8869/8870；不真开 OSS。

用法:
  python ecs_upload_xueyuan_data.py --phase core --dry-run
  python ecs_upload_xueyuan_data.py --phase core            # 部署日当天
  python ecs_upload_xueyuan_data.py --phase pdfs --batch 10 --dry-run
  python ecs_upload_xueyuan_data.py --phase pdfs --batch 10 # 每晚一批，跑完 4 晚
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
from datetime import datetime
from pathlib import Path

ROOT = Path(r"E:\AI-Station")
XY_DATA = ROOT / "data" / "xueyuan"
PKG_CONTENT = ROOT / "WeAppForge" / "projects" / "zongbao" / "content"
LEDGER = ROOT / "WeAppForge" / "work" / "xy_pdf_upload_ledger.json"

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
CHUNK = 16000
PREFIX = "/opt/xueyuan"
TMP_DIR = f"{PREFIX}/xy_incoming"
PER_CHUNK_SEC = 4.9
NO_WINDOW = 0x08000000
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
    out = run_aliyun("RunCommand", "--Type", "RunShellScript", "--Name", name,
                     "--CommandContent", script, "--InstanceId.1", INSTANCE,
                     "--RegionId", REGION)
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
                print(output[-600:])
            if code != 0:
                raise RuntimeError(f"{name} ExitCode={code}")
            return output
    raise TimeoutError(f"{name} 超时")


def tgz(entries):
    """entries=[(本地路径, arcname)] → 内存 tar.gz 字节。"""
    buf = io.BytesIO()
    with tarfile.open(fileobj=buf, mode="w:gz") as tf:
        for src, arc in entries:
            tf.add(str(src), arcname=arc)
    return buf.getvalue()


def chunks_of(payload):
    b64 = base64.b64encode(payload).decode()
    return [b64[i:i + CHUNK] for i in range(0, len(b64), CHUNK)]


def ship(name, payload, unpack_cmd):
    """分片上传→远端解包→删临时件（单资产原子单元，失败重跑该资产即可）。"""
    tag = name.replace("/", "_")
    chunks = chunks_of(payload)
    print(f"  {name}: {len(payload)} bytes → {len(chunks)} 片 "
          f"(约 {len(chunks) * PER_CHUNK_SEC / 60:.0f} 分)")
    ecs_cmd(f"mkdir -p {TMP_DIR} && rm -f {TMP_DIR}/{tag}.b64", f"xyd-{tag}-init")
    for i, ch in enumerate(chunks):
        ecs_cmd(f"printf %s '{ch}' >> {TMP_DIR}/{tag}.b64", f"xyd-{tag}-c{i:04d}",
                wait=120)
    ecs_cmd(unpack_cmd, f"xyd-{tag}-unpack")
    ecs_cmd(f"rm -f {TMP_DIR}/{tag}.b64", f"xyd-{tag}-clean")


def phase_core_cmds():
    core_tgz = tgz([
        (XY_DATA / "content", "content"),
        (XY_DATA / "db.sqlite", "db.sqlite"),
        (PKG_CONTENT, "content_pkg"),
    ])
    unpack = (
        f"base64 -d {TMP_DIR}/core.b64 | tar xz -C {TMP_DIR} && "
        f"mkdir -p {PREFIX}/data/xueyuan/content {PREFIX}/data/content_pkg && "
        f"cp -r {TMP_DIR}/content/. {PREFIX}/data/xueyuan/content/ && "
        f"cp -r {TMP_DIR}/content_pkg/. {PREFIX}/data/content_pkg/ && "
        f"cp {TMP_DIR}/db.sqlite {PREFIX}/data/xueyuan/db.sqlite && "
        f"rm -rf {TMP_DIR}/content {TMP_DIR}/content_pkg {TMP_DIR}/db.sqlite && "
        f"echo content_reports=$(ls {PREFIX}/data/xueyuan/content/reports | wc -l)"
        f" pdf_dir=$([ -d {PREFIX}/data/xueyuan/pdfs ] && echo ok)"
        f" db=$(stat -c %s {PREFIX}/data/xueyuan/db.sqlite)"
    )
    return {"core": (core_tgz, unpack)}


def pdf_slugs():
    return sorted(p.name for p in (XY_DATA / "pdfs").iterdir() if p.is_dir())


def load_ledger():
    if LEDGER.exists():
        return json.loads(LEDGER.read_text(encoding="utf-8"))
    return {}


def save_ledger(ledger):
    LEDGER.write_text(json.dumps(ledger, ensure_ascii=False, indent=1),
                      encoding="utf-8")


def audit(cmds):
    hits = [c[:80] for c in cmds for bad in FORBIDDEN if bad in c]
    if hits:
        raise RuntimeError(f"零交叉审计失败: {hits}")


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--phase", choices=["core", "pdfs"], required=True)
    ap.add_argument("--batch", type=int, default=10,
                    help="pdfs 每晚搬运的报告数（默认 10≈2.2h/晚）")
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()
    try:
        if args.phase == "core":
            plan = phase_core_cmds()
            audit([unpack for _, (_, unpack) in plan.items()])
            (payload, unpack) = plan["core"]
            n = len(chunks_of(payload))
            if args.dry_run:
                print(f"[DRY-RUN] core {len(payload)} bytes → {n} 片"
                      f" ≈ {n * PER_CHUNK_SEC / 60:.0f} 分（当天全功能先上）")
                print(f"[DRY-RUN] 解包命令: {unpack[:200]} …")
                print("[DRY-RUN] 零交叉审计 PASS；未发生 aliyun 调用")
                return 0
            ship("core", payload, unpack)
            print("CORE DATA DONE —— 引擎当天可跑全功能（PDF 下载腿待 pdfs 相位）")
            return 0

        slugs = pdf_slugs()
        ledger = load_ledger()
        todo = [s for s in slugs if not ledger.get(s, {}).get("done")]
        batch = todo[:args.batch]
        print(f"pdfs 共 {len(slugs)} 报告，已完成 {len(slugs) - len(todo)}，"
              f"本批 {len(batch)}（--batch {args.batch}）")
        if args.dry_run:
            est = 0
            for s in batch:
                payload = tgz([(XY_DATA / "pdfs" / s, s)])
                est += len(chunks_of(payload))
            audit([f"tar {s}" for s in batch])
            rest = len(todo) - len(batch)
            print(f"[DRY-RUN] 本批 {len(batch)} 报告 ≈ {est} 片"
                  f" ≈ {est * PER_CHUNK_SEC / 3600:.1f} 小时；"
                  f"本批后剩余 {rest} 报告（约 {(rest * est / max(len(batch), 1) * PER_CHUNK_SEC / 3600):.1f} 小时）")
            print(f"[DRY-RUN] 台账: {LEDGER}（断点续跑判据）")
            print("[DRY-RUN] 未发生 aliyun 调用")
            return 0

        for s in batch:
            payload = tgz([(XY_DATA / "pdfs" / s, s)])
            unpack = (
                f"base64 -d {TMP_DIR}/{s}.b64 | tar xz -C {TMP_DIR} && "
                f"mkdir -p {PREFIX}/data/xueyuan/pdfs && "
                f"rm -rf {PREFIX}/data/xueyuan/pdfs/{s} && "
                f"mv {TMP_DIR}/{s} {PREFIX}/data/xueyuan/pdfs/{s} && "
                f"echo {s}_pdfs=$(ls {PREFIX}/data/xueyuan/pdfs/{s}/*.pdf | wc -l)"
            )
            audit([unpack])
            ship(s, payload, unpack)
            ledger = {**ledger, s: {"done": True, "bytes": len(payload),
                                    "ts": datetime.now().isoformat(timespec="seconds")}}
            save_ledger(ledger)
            print(f"  ledger += {s}")
        print(f"PDFS BATCH DONE —— 进度 {len(slugs) - len(todo) + len(batch)}"
              f"/{len(slugs)}")
        return 0
    except Exception as e:  # noqa: BLE001
        print(f"FAIL: {e}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
