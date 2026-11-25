# -*- coding: utf-8 -*-
"""highlight_backup.py — 高光片段按场次增量备份到超级总包知识库·直播回放。

映射源: 网盘既有 manifest.jsonl（replay_id→topic/video_path/summary）
        + state.db highlights（manifest 未覆盖的本地新增片段）
        + sph live history（replay_id→场次名/日期）
远端结构: /超级总包知识库（动态更新）/65. 总包生态资源库/02 总包说（视频库）/
          直播回放/<YYYYMMDD 场次名>/高光片段/<原clip文件名>
增量: 远端同名同尺寸跳过；每场次目录附 manifest 拷贝（可溯源性）。

用法: python highlight_backup.py
"""
import json
import pathlib
import shutil
import sqlite3
import subprocess
import sys
import time
import urllib.request
from datetime import datetime

ROOT = pathlib.Path(__file__).resolve().parent
TMP = ROOT / "replay_tmp"
VIDEOS = pathlib.Path(r"E:/AI-Station/WeVideo-AutoPub/data/videos")
STATE_DB = pathlib.Path(r"E:/AI-Station/WeVideo-AutoPub/data/state.db")
NET_MANIFEST = "/03 总包生态/03 总包视频库/高登六张网直播课/20261124回放高光片段/视频/manifest.jsonl"
KB_BASE = ("/超级总包知识库（动态更新）/65. 总包生态资源库/"
           "02 总包说（视频库）/直播回放")
BDN = r"E:/AI-Station/逆向工程/baidu-netdisk/replica/bdn.py"
SPH = r"E:/AI-Station/逆向工程/shipinhao-reverse/sph.py"
PY = sys.executable


def _utf8():
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass


def run(cmd, timeout=None):
    r = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout,
                       encoding="utf-8", errors="replace")
    return r.returncode, (r.stdout or "") + (r.stderr or "")


def bdn_json(*args):
    rc, out = run([PY, "-I", BDN, *args, "--json"], timeout=600)
    try:
        return json.loads(out[out.index("{"):])
    except Exception:
        return {}


def remote_ls(path):
    j = bdn_json("ls", path)
    ents = {}
    for e in j.get("entries") or []:
        nm = str(e.get("name") or "")
        ents[nm] = int(e.get("size") or 0)
    return ents


def session_names():
    """replay_id -> (date, desc)。"""
    sys.path.insert(0, str(pathlib.Path(SPH).parent))
    import importlib.util
    spec = importlib.util.spec_from_file_location("sph", SPH)
    S = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(S)
    class A: vault=None; cookie=None
    c = S.load_cookies(A())
    m = {}
    page = 1
    while page <= 12:
        j = S.call("live/get_live_history", S.env(pageSize=20, currentPage=page, count=20), c)
        chunk = ((j.get("data") or {}).get("liveObjectList") or [])
        if not chunk:
            break
        for it in chunk:
            lid = str(it.get("liveObjectId"))
            desc = str(it.get("description") or "").strip() or lid
            for ch in '\\/:*?"<>|':
                desc = desc.replace(ch, "_")
            ts = int(it.get("createTime") or 0)
            date = datetime.fromtimestamp(ts).strftime("%Y%m%d") if ts else "unknown"
            m[lid] = (date, desc[:40])
        page += 1
        time.sleep(0.5)
    return m


def main():
    _utf8()
    TMP.mkdir(exist_ok=True)
    # 1) manifest（网盘既有账本）
    lm = TMP / "manifest.jsonl"
    if not lm.exists():
        run([PY, "-I", BDN, "download", NET_MANIFEST, str(lm), "--json"], timeout=120)
    rows = []
    if lm.exists():
        rows = [json.loads(l) for l in lm.read_text(encoding="utf-8").splitlines() if l.strip()]
    print(f"manifest rows: {len(rows)}")
    # 2) state.db 补充（manifest 未覆盖的本地片段）
    db_rows = []
    try:
        db = sqlite3.connect(str(STATE_DB))
        cur = db.cursor()
        for rid, desc, extra in cur.execute(
                "SELECT replay_id, one_line_desc, extra FROM highlights"):
            db_rows.append((str(rid), str(desc or ""), str(extra or "")))
    except Exception as e:
        print("db:", e)
    # 本地实际有的 clip 文件
    local_clips = {p.name: p for p in VIDEOS.glob("clip_*.mp4")}
    # manifest 覆盖的文件名
    mapped = {}
    for r in rows:
        vp = str(r.get("video_path") or "")
        fname = vp.rsplit("\\", 1)[-1].rsplit("/", 1)[-1]
        if fname in local_clips:
            mapped.setdefault(str(r.get("replay_id")), []).append((fname, str(r.get("topic") or "")))
    print(f"manifest 覆盖本地: {sum(len(v) for v in mapped.values())} 个")
    # 未覆盖的本地片段→state.db 映射（video 无 path 字段，按 highlights 数量+文件 hash 无法精确配对——
    # 如实标注为 未映射，放到对应场次的 高光片段/未编号/ 下）
    covered_files = {f for v in mapped.values() for f, _ in v}
    unmapped = [n for n in local_clips if n not in covered_files]
    print(f"本地未映射: {len(unmapped)} 个")
    # 3) 场次名映射
    names = session_names()
    # 4) 逐场上传
    total_up = 0
    for rid, files in sorted(mapped.items(), key=lambda kv: kv[0]):
        date, desc = names.get(rid, ("unknown", rid))
        rdir = f"{KB_BASE}/{date} {desc}/高光片段"
        existing = remote_ls(rdir)
        new = [(f, t) for f, t in files
               if f not in existing
               or existing[f] != local_clips[f].stat().st_size]
        print(f"[{date} {desc}] 已在库 {len(files)-len(new)}/{len(files)}，待传 {len(new)}")
        for f, topic in new:
            src = local_clips[f]
            rc, up = run([PY, "-I", BDN, "upload", str(src), f"{rdir}/{f}", "--json"],
                         timeout=3600)
            sz = src.stat().st_size
            after = remote_ls(rdir)
            ok = after.get(f) == sz
            print(f"  {f} {'OK' if ok else 'MISMATCH'}")
            if ok:
                total_up += 1
            time.sleep(1.5)
    # 5) 未映射片段 → 各自场次（从 db 取 replay_id 尽力归组，否则 未编号 组）
    if unmapped:
        rid_by_hash = {}
        try:
            db = sqlite3.connect(str(STATE_DB))
            for rid, extra in db.execute("SELECT replay_id, extra FROM highlights"):
                h = str(extra or "")
                for n in unmapped:
                    if n.rsplit("_", 1)[-1].split(".")[0] in h:
                        rid_by_hash[n] = str(rid)
        except Exception:
            pass
        grouped = {}
        for n in unmapped:
            rid = rid_by_hash.get(n, "UNGROUPED")
            grouped.setdefault(rid, []).append(n)
        for rid, files in grouped.items():
            date, desc = names.get(rid, ("unknown", "未编号场次"))
            rdir = f"{KB_BASE}/{date} {desc}/高光片段"
            existing = remote_ls(rdir)
            for f in files:
                if f in existing and existing[f] == local_clips[f].stat().st_size:
                    continue
                rc, up = run([PY, "-I", BDN, "upload", str(local_clips[f]),
                              f"{rdir}/{f}", "--json"], timeout=3600)
                after = remote_ls(rdir)
                ok = after.get(f) == local_clips[f].stat().st_size
                print(f"[未映射→{date} {desc}] {f} {'OK' if ok else 'MISMATCH'}")
                if ok:
                    total_up += 1
                time.sleep(1.5)
    # 6) manifest 落库（可溯源性）
    mdir = f"{KB_BASE}/manifest"
    run([PY, "-I", BDN, "mkdir", mdir, "--json"], timeout=60)
    run([PY, "-I", BDN, "upload", str(lm), f"{mdir}/highlights_manifest_20261125.jsonl", "--json"],
        timeout=120)
    print(f"上传完成 {total_up} 个文件")


if __name__ == "__main__":
    main()
