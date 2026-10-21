# -*- coding: utf-8 -*-
"""mp_list_report — 研报上架总包AI顾问小程序·固化链 (1016 用户令: 上架正道=小程序, 固化代码).

链路 (每份成书报告同链复用, 不走 H5):
  1) sync: report_platform/content/{report.json,full/<sku>.pdf,sample/*}
     → data/state/qw_deploy_stage_1007/report_content/ (部署镜像内容源,
     Dockerfile COPY report_content → /app/report_platform/content);
  2) auth: 触发 cloudbase CLI 静默刷新临时密钥 (env list 探针);
  3) deploy: data/state/mn_client/update_envparams.js 同族 —
     manager-node cloudrun.deploy (FULL, targetPath=stage, EnvParams 原值
     全量替换 '=' 完整保留); 本件动态生成 deploy 脚本到 mn_client 下;
  4) verify: 轮询引擎公网 /api/reports 含目标 sku 且 sellable=true (四腿之一,
     目录腿; 详情/试读/PDF 门禁腿由公网 URL 现场验)。

用法: py tools/mp_list_report.py --sku BID26-2026 [--skip-deploy]
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
STAGE = REPO / "data" / "state" / "qw_deploy_stage_1007"
CONTENT = REPO / "report_platform" / "content"
MN = REPO / "data" / "state" / "mn_client"
CB = r"C:\Users\91216\AppData\Roaming\npm\cloudbase.cmd"
ENGINE_URL = "https://qianwen-engine-"
# 服务默认域名形如 <service>-<envhash>.<region>.app.tcloudbase.com —
# 从 check_version.js 或历史日志取; 先读探测
DEPLOY_JS = MN / "deploy_report_content.js"


def sync_content(sku: str) -> list[Path]:
    """report.json + 目标 sku 的 PDF + 全部 sample → stage 内容源."""
    rc = STAGE / "report_content"
    rc.mkdir(parents=True, exist_ok=True)
    copied = []
    # 1021 用户令：上架时间戳自动盖章——目标 sku 条目缺 listed_at 时以当下时刻回写
    # canonical 与 stage 两份（引擎按 listed_at 倒序排最新研报；缺戳条目垫底）。
    import json as _json
    import datetime as _dt
    _rj = CONTENT / "report.json"
    _d = _json.loads(_rj.read_text(encoding="utf-8"))
    _wrap = isinstance(_d, dict)
    _items = _d.get("reports") if _wrap else _d
    _hit = next((it for it in _items if it.get("sku") == sku), None)
    if _hit is not None and not _hit.get("listed_at"):
        _hit["listed_at"] = _dt.datetime.now().strftime("%Y-%m-%d %H:%M")
        _rj.write_text(_json.dumps(_d, ensure_ascii=False, indent=1), encoding="utf-8")
        print(f"[stamp] listed_at={_hit['listed_at']} -> {sku}")
    for rel in ("report.json",):
        dst = rc / rel
        dst.write_bytes((CONTENT / rel).read_bytes())
        copied.append(dst)
    (rc / "full").mkdir(exist_ok=True)
    pdfs = [CONTENT / "full" / f"{sku}.pdf"]
    pdfs += [p for p in (CONTENT / "full").glob("*.pdf") if p.name != f"{sku}.pdf"]
    for p in pdfs:                       # 全量 PDF 同步 (镜像内容源=真源)
        if p.is_file():
            dst = rc / "full" / p.name
            dst.write_bytes(p.read_bytes())
            copied.append(dst)
    (rc / "sample").mkdir(exist_ok=True)
    for p in (CONTENT / "sample").glob("*.md"):
        dst = rc / "sample" / p.name
        dst.write_bytes(p.read_bytes())
        copied.append(dst)
    return copied


def refresh_auth() -> bool:
    r = subprocess.run(["cmd", "/c", CB, "env", "list"], capture_output=True,
                       text=True, timeout=90)
    ok = "cloudbase-" in r.stdout
    print(f"[mp] auth refresh probe: {'ok' if ok else 'FAIL ' + r.stdout[-120:]}")
    return ok


def write_deploy_js() -> Path:
    DEPLOY_JS.write_text("""// deploy_report_content.js — 报告内容重部署 (mp_list_report.py 生成)
const path = require('path');
const fs = require('fs');
const CloudBase = require('@cloudbase/manager-node').default || require('@cloudbase/manager-node');
const ENV_ID = 'cloudbase-d2gzke5r0b706b3a3';
const REGION = 'ap-shanghai';
const SERVICE = 'qianwen-engine';
const STAGE = 'E:/AI-Station/data/state/qw_deploy_stage_1007';
const ENVP_JSON = 'E:/AI-Station/data/state/qianwen_tcb_envparams.json';
(async () => {
  const auth = JSON.parse(fs.readFileSync(
    path.join(process.env.USERPROFILE, '.config', '.cloudbase', 'auth.json'), 'utf8')).credential;
  const envp = JSON.parse(fs.readFileSync(ENVP_JSON, 'utf8'));
  const app = new CloudBase({ secretId: auth.tmpSecretId, secretKey: auth.tmpSecretKey,
    token: auth.tmpToken, envId: ENV_ID, region: REGION });
  const before = await app.cloudrun.detail({ serverName: SERVICE });
  console.log('server exists, images:', JSON.stringify(before.ServerConfig.ImageInfo || {}).slice(0, 120));
  const res = await app.cloudrun.deploy({
    serverName: SERVICE, targetPath: STAGE,
    deployInfo: { ReleaseType: 'FULL' },
    serverConfig: { EnvParams: JSON.stringify(envp),
      TrafficType: JSON.stringify(['NORMAL']) },
  });
  console.log('deploy result:', JSON.stringify(res).slice(0, 300));
})().catch(e => { console.error('DEPLOY_FAIL', e.message); process.exit(1); });
""", encoding="utf-8")
    return DEPLOY_JS


def deploy() -> bool:
    write_deploy_js()
    r = subprocess.run(["node", str(DEPLOY_JS)], capture_output=True, text=True,
                       cwd=str(MN), timeout=900)
    print(r.stdout[-400:])
    if r.returncode != 0:
        print(f"[mp] deploy 失败: {r.stderr[-200:]}")
        return False
    return True


def verify(sku: str, timeout_s: int = 900) -> bool:
    """轮询引擎公网目录: 目标 sku 在册且 sellable — 域名从详情/历史件取."""
    url = engine_base_url()
    if not url:
        print("[mp] 引擎域名未定位 (查 mn_client 历史或控制台)")
        return False
    import urllib.request
    deadline = time.time() + timeout_s
    while time.time() < deadline:
        try:
            with urllib.request.urlopen(f"{url}/api/reports", timeout=20) as r:
                d = json.loads(r.read())
            items = d.get("reports", d if isinstance(d, list) else [])
            hit = next((x for x in items
                        if x.get("sku") == sku or x.get("id") == sku), None)
            if hit:
                print(f"[mp] ✅ {sku} 在册: sellable={hit.get('sellable')} "
                      f"price={hit.get('price')}")
                return bool(hit.get("sellable"))
        except Exception as e:
            print(f"[mp] 轮询 {type(e).__name__}: {str(e)[:60]} (部署构建中…)")
        time.sleep(30)
    return False


def engine_base_url() -> str:
    """引擎公网域名: 优先缓存件, 其次 detail 运行信息."""
    cache = REPO / "data" / "state" / "qianwen_engine_url.txt"
    if cache.is_file():
        return cache.read_text(encoding="utf-8").strip()
    return ""


def main() -> int:
    ap = argparse.ArgumentParser(description="研报上架小程序·固化链")
    ap.add_argument("--sku", required=True)
    ap.add_argument("--skip-deploy", action="store_true")
    ns = ap.parse_args()
    copied = sync_content(ns.sku)
    print(f"[mp] 内容同步 {len(copied)} 件 → stage")
    if ns.skip_deploy:
        return 0
    if not refresh_auth():
        return 2
    if not deploy():
        return 3
    # 构建等待后验证
    time.sleep(120)
    ok = verify(ns.sku)
    print("[mp] 上架链 " + ("完成 ✅" if ok else "待验证 (域名/构建时延, 重跑 verify 段)"))
    return 0 if ok else 4


if __name__ == "__main__":
    raise SystemExit(main())
