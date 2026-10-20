#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
ima 知识库可导出性单文件探测（只读，不落盘、不写台账）
用法: probe_export.py <kb_id> [probe_n=2] [scan_seconds=120]
判定: 取 access_status==3 的普通文件(非笔记/网址/公众号/ima报告)调 get_media_url,
      返回真URL且 Range GET 能取到字节 → EXPORTABLE; 否则 BLOCKED。
"""
import os
import sys
import time
from collections import Counter

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from ima_replica import ImaClient, IOS_UA  # noqa: E402

LINK_TYPE_NAMES = ("网址", "腾讯新闻", "公众号")


def log(m):
    print(m, flush=True)


def scan_with_cap(c, kb_id, cap_seconds):
    """递归扫描，超时即停（返回已扫到的部分 + 是否完整）"""
    out = []
    complete = True
    t0 = time.time()
    stopped = {"brk": False}

    def rec(folder_id="", path=""):
        if stopped["brk"]:
            return
        if time.time() - t0 > cap_seconds:
            stopped["brk"] = True
            return
        content = c.get_folder_content(kb_id, folder_id)
        for f in content["files"]:
            g = dict(f)
            g["path"] = path
            out.append(g)
        for d in content["folders"]:
            if stopped["brk"]:
                return
            rec(d["folder_id"], (path + "/" + d["name"]).strip("/"))

    rec()
    complete = not stopped["brk"]
    return out, complete


def pick_probe_files(files, n):
    """优先: access_status==3 普通文件, 标题带常见文档扩展名"""
    def is_normal(fi):
        mt, tn = fi.get("media_type", 0), (fi.get("media_type_info") or {}).get("name", "")
        if mt == 11 or (mt == 2 and tn in ("ima 报告",) + LINK_TYPE_NAMES) or (mt == 6):
            return False
        return True

    cands = [f for f in files if f.get("access_status") == 3 and is_normal(f)]
    pref = [f for f in cands if any(
        (f.get("title") or "").lower().endswith(e)
        for e in (".pdf", ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".zip"))]
    rest = [f for f in cands if f not in pref]
    return (pref + rest)[:n], len(cands)


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    kb_id = sys.argv[1]
    probe_n = int(sys.argv[2]) if len(sys.argv) > 2 else 2
    cap_s = int(sys.argv[3]) if len(sys.argv) > 3 else 120

    c = ImaClient()
    c.load_cred()
    c.ensure_token()

    try:
        c.join_kb(kb_id)
        log(f"[join] ok")
    except Exception as ex:
        log(f"[join] FAILED: {ex}")

    try:
        res = c.get_knowledge_list(kb_id, limit=1)
        total = int(res.get("total_size") or 0)
        name = ((res.get("current_path") or [{}])[0]).get("name") or kb_id
        log(f"[kb] {name} | 声称文件数={total}")
    except Exception as ex:
        log(f"[kb] meta FAILED: {ex}")
        name, total = kb_id, 0

    files, complete = scan_with_cap(c, kb_id, cap_s)
    acc = Counter(f.get("access_status") for f in files)
    types = Counter(((f.get("media_type_info") or {}).get("name") or str(f.get("media_type", "?")))
                    for f in files)
    log(f"[scan] 实扫文件={len(files)} 完整={complete} access_status={dict(acc)}")
    log(f"[scan] 类型分布={dict(types.most_common(10))}")

    probes, n_avail = pick_probe_files(files, probe_n)
    if not probes:
        log(f"[probe] 无普通文件候选(可导出普通文件={n_avail}) → 判定: BLOCKED(无实体文件)")
        return 2

    ok = 0
    for fi in probes:
        mid, title = fi["media_id"], fi.get("title") or mid
        url, dl_headers, _rtitle = c.get_media_url(mid, kb_id)
        if not url:
            log(f"[probe] ✗ 「{title[:40]}」 无下载URL")
            time.sleep(1)
            continue
        try:
            h = dict(dl_headers or {"User-Agent": IOS_UA})
            h["Range"] = "bytes=0-1023"
            r = c.s.get(url, headers=h, stream=True, timeout=(10, 60))
            chunk = next(r.iter_content(1024), b"")
            r.close()
            got = len(chunk)
            log(f"[probe] ✓ 「{title[:40]}」 URL已返回 HTTP {r.status_code} 首块{got}B")
            if r.status_code in (200, 206) and got > 0:
                ok += 1
        except Exception as ex:
            log(f"[probe] ? 「{title[:40]}」 URL返回但取字节失败: {ex}")
        time.sleep(1)

    verdict = "EXPORTABLE" if ok > 0 else "BLOCKED(有URL但不服务/全部无URL)"
    log(f"[verdict] {verdict} (probe_ok={ok}/{len(probes)}, 可导出普通文件总数={n_avail})")
    return 0 if ok > 0 else 2


if __name__ == "__main__":
    sys.exit(main())
