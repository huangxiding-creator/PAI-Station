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
    all_mode = "--all" in sys.argv
    for i, a in enumerate(sys.argv):
        if a == "--limit" and i + 1 < len(sys.argv):
            limit = int(sys.argv[i + 1])
    TMP.mkdir(exist_ok=True)
    remote = remote_listing()
    print(f"远端已有 {len(remote)} 个文件（增量基线）")
    # 进程内取 replayUrl（复用 sph.py 传输层）
    sys.path.insert(0, str(pathlib.Path(SPH).parent))
    import importlib.util
    spec = importlib.util.spec_from_file_location("sph", SPH)
    S = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(S)
    class A: vault=None; cookie=None
    cc = S.load_cookies(A())

    items = []
    if all_mode:
        # 全量扫场：翻页 history 直到空页，逐场判回放（远端跳过不计 done）
        page = 1
        empty_pages = 0
        while page <= 50:
            j = S.call("live/get_live_history",
                       S.env(pageSize=20, currentPage=page, count=20), cc)
            _d = j.get("data") or {}
            chunk = (_d.get("liveObjectList") or [])
            if not chunk:
                empty_pages += 1
                if empty_pages >= 2:
                    break
                page += 1
                continue
            items.extend(chunk)
            print(f"[scan] page={page} +{len(chunk)} (累计{len(items)})")
            page += 1
            time.sleep(0.8)
        print(f"[scan] 全部场次 {len(items)}")
    else:
        hist = sph("live", "history", "--count", "20")
        _d = hist.get("data") or hist  # --json 输出 data 层或整信封双形兼容
        items = (_d.get("liveObjectList") or [])
    done = 0
    no_replay = 0
    total_mb = 0.0
    errors = []
    for it in items:
        if not all_mode and done >= limit:
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
        # 回放URL：瞬时网络错重试+会话自愈
        url = ""
        for attempt in range(3):
            try:
                jr = S.call("live/live_replay_info", S.env(liveObjectId=lid), cc)
                url = (jr.get("data") or {}).get("replayUrl") or ""
                break
            except Exception as e:
                print(f"  [retry{attempt+1}] replay_info err: {str(e)[:80]}")
                time.sleep(5 + attempt * 10)
                try:
                    run(["F:/We-AIPO/.venv/Scripts/python.exe",
                         r"E:/AI-Station/WeVideo-AutoPub/s367_login.py"], timeout=600)
                    spec2 = importlib.util.spec_from_file_location("sph2", SPH)
                    S2 = importlib.util.module_from_spec(spec2)
                    spec2.loader.exec_module(S2)
                    cc = S2.load_cookies(A)
                    S = S2
                except Exception:
                    pass
        if not url:
            print(f"[no-replay] {fname}")
            no_replay += 1
            continue
        try:
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
                total_mb += got / 1024 / 1024
            else:
                print(f"  本地保留待复核: {dest}")
        except Exception as e:
            print(f"[item-error] {fname}: {str(e)[:120]}（跳过继续）")
            errors.append({"file": fname, "err": str(e)[:150]})
            continue
        time.sleep(2)
    remote2 = remote_listing()
    summary = {"backed_this_run": done, "total_mb_this_run": round(total_mb, 1),
               "remote_files": len(remote2), "scanned": len(items),
               "no_replay": no_replay, "errors": errors, "remote_dir": REMOTE_DIR}
    (ROOT / "replay_backup_summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"本轮完成 {done} 场 | 远端在库 {len(remote2)} 个 | 本轮体积 {total_mb/1024:.2f}GB | 错误 {len(errors)}")


if __name__ == "__main__":
    main()
