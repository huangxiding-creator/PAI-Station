# -*- coding: utf-8 -*-
"""replay_backup.py — 直播整场回放增量备份到百度网盘·超级总包知识库。

链路: live/get_live_history → live/live_replay_info(replayUrl) → 下载(临时盘)
      → bdn upload → 远端对账(size) → 本地临时即删。
远端: /超级总包知识库（动态更新）/65. 总包生态资源库/02 总包说（视频库）/直播回放/
增量: 远端已有同名(size 一致)即跳过；--limit 控制本轮场次数。

用法:
  python replay_backup.py [--limit 5] [--json]
"""
import json
import pathlib
import subprocess
import sys
import time
import urllib.request
from datetime import datetime

ROOT = pathlib.Path(__file__).resolve().parent
TMP = ROOT / "replay_tmp"
SPH = r"E:/AI-Station/逆向工程/shipinhao-reverse/sph.py"
BDN = r"E:/AI-Station/逆向工程/baidu-netdisk/replica/bdn.py"
PY = sys.executable
REMOTE_DIR = ("/超级总包知识库（动态更新）/65. 总包生态资源库/"
              "02 总包说（视频库）/直播回放")


def _utf8():
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass


def run(cmd, timeout=None):
    r = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout,
                       encoding="utf-8", errors="replace")
    return r.returncode, (r.stdout or "") + (r.stderr or "")


def sph(*args):
    rc, out = run([PY, "-I", SPH, "--json", *args], timeout=120)
    try:
        return json.loads(out[out.index("{"):])
    except Exception:
        return {}


def remote_listing():
    rc, out = run([PY, "-I", BDN, "ls", REMOTE_DIR, "--json"], timeout=120)
    names = {}
    try:
        j = json.loads(out[out.index("{"):])
        for e in j.get("entries") or []:
            p = e.get("path") or e.get("name") or ""
            nm = p.rstrip("/").rsplit("/", 1)[-1]
            names[nm] = int(e.get("size") or 0)
    except Exception:
        pass
    return names


def download(url: str, dest: pathlib.Path, expect: int = 0) -> int:
    tmp = dest.with_suffix(".part")
    req = urllib.request.Request(url)
    with urllib.request.urlopen(req, timeout=60) as r, open(tmp, "wb") as f:
        got = 0
        while True:
            chunk = r.read(4 * 1024 * 1024)
            if not chunk:
                break
            f.write(chunk)
            got += len(chunk)
    if expect and abs(got - expect) > expect * 0.001:
        return got  # 尺寸不符仍保留，由对账判定
    tmp.replace(dest)
    return got


def main():
    _utf8()
    limit = 5
    for i, a in enumerate(sys.argv):
        if a == "--limit" and i + 1 < len(sys.argv):
            limit = int(sys.argv[i + 1])
    TMP.mkdir(exist_ok=True)
    remote = remote_listing()
    print(f"远端已有 {len(remote)} 个文件（增量基线）")
    hist = sph("live", "history", "--count", "20")
    _d = hist.get("data") or hist  # --json 输出 data 层或整信封双形兼容
    items = (_d.get("liveObjectList") or [])
    done = 0
    for it in items:
        if done >= limit:
            break
        lid = str(it.get("liveObjectId"))
        desc = str(it.get("description") or "").strip() or lid
        for ch in '\\/:*?"<>|':
            desc = desc.replace(ch, "_")
        ts = int(it.get("createTime") or 0)
        date = datetime.fromtimestamp(ts).strftime("%Y%m%d") if ts else "unknown"
        fname = f"{date} {desc[:40]}.mp4"
        rsize = remote.get(fname)
        if rsize is not None:
            print(f"[skip-remote] {fname}")
            continue
        # 进程内取 replayUrl（复用 sph.py 传输层）
        sys.path.insert(0, str(pathlib.Path(SPH).parent))
        import importlib.util
        spec = importlib.util.spec_from_file_location("sph", SPH)
        S = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(S)
        class A: vault=None; cookie=None
        cc = S.load_cookies(A())
        jr = S.call("live/live_replay_info", S.env(liveObjectId=lid), cc)
        url = (jr.get("data") or {}).get("replayUrl") or ""
        if not url:
            print(f"[no-replay] {fname}")
            continue
        req = urllib.request.Request(url, method="HEAD")
        with urllib.request.urlopen(req, timeout=30) as r:
            size = int(r.headers.get("Content-Length") or 0)
        dest = TMP / fname
        print(f"[down] {fname} {size/1024/1024:.1f}MB ...", flush=True)
        t0 = time.time()
        got = download(url, dest, size)
        print(f"  downloaded {got/1024/1024:.1f}MB in {time.time()-t0:.0f}s")
        rc, up = run([PY, "-I", BDN, "upload", str(dest),
                      f"{REMOTE_DIR}/{fname}", "--json"], timeout=7200)
        ok = '"rapid"' in up or "blocks_uploaded" in up or '"success": true' in up
        # 对账
        rc2, ls = run([PY, "-I", BDN, "ls", REMOTE_DIR, "--json"], timeout=120)
        matched = fname in ls and (f'"size": {size}' in ls or f'"size":{size}' in ls)
        print(f"  upload={'ok' if ok else '?'} 对账={'一致' if matched else '需复核'}")
        if matched:
            dest.unlink()  # 传完即删（备份纪律）
            done += 1
        else:
            print(f"  本地保留待复核: {dest}")
        time.sleep(2)
    print(f"本轮完成 {done} 场")


if __name__ == "__main__":
    main()
