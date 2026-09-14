#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""秘塔收尾清理（收敛循环）：
  1) 删除所有 .docx 条目（用户已批准，政策=仅 md）
  2) 同一文件夹内同名 md 重复条目 → 保留最新 1 个，其余进回收站
     （重复源自双上传进程竞态——秘塔接受同名文件，服务端不去重）
循环列表-删除直到每夹稳定：docx=0 且无重复 md。
"""
import json
import sys
import time
from pathlib import Path
from collections import defaultdict

sys.path.insert(0, str(Path(__file__).resolve().parent))
from upload_metaso import MetasoClient, SUBJECT_ID, TARGET_CFID, STATE, DIRS
from delete_docx_metaso import make_client, list_dir, trash


def clean_folder(cli, name, cfid, rounds_max=6):
    """单夹收敛。返回 (docx_deleted, dup_deleted, status)。"""
    d_del = dup_del = 0
    for rnd in range(rounds_max):
        items = list_dir(cli, cfid)
        victims = [it for it in items if str(it.get("fileName") or "").endswith(".docx")]
        # 同名 md 分组（列表已按 updateTime desc → 组内首个=最新）
        groups = defaultdict(list)
        for it in items:
            fn = str(it.get("fileName") or "")
            if fn.endswith(".md"):
                groups[fn].append(it)
        for fn, g in groups.items():
            victims.extend(g[1:])  # 保留第 0 个（最新）
        if not victims:
            return d_del, dup_del, "clean"
        ids = [str(v["id"]) for v in victims]
        for i in range(0, len(ids), 20):
            chunk = ids[i:i + 20]
            chunk_victims = victims[i:i + 20]
            n_docx = sum(1 for v in chunk_victims
                         if str(v.get("fileName")).endswith(".docx"))
            res = trash(cli, chunk)
            status, _, body = res.partition("||")
            ok = status == "200" and '"errCode":0' in body.replace(" ", "")
            n_ok = len(chunk) if ok else 0
            if not ok:
                for one in chunk:
                    r2 = trash(cli, [one])
                    s2, _, b2 = r2.partition("||")
                    if s2 == "200" and '"errCode":0' in b2.replace(" ", ""):
                        n_ok += 1
                    time.sleep(0.5)
            d_del += min(n_docx, n_ok)
            dup_del += max(0, n_ok - min(n_docx, n_ok))
            time.sleep(0.8)
        print(f"   轮次{rnd + 1}: 删 {len(victims)}（docx+重复md），继续复核...")
        time.sleep(1.0)
    return d_del, dup_del, "unstable"


def main():
    cli = make_client()
    dirs = json.loads(DIRS.read_text(encoding="utf-8")) if DIRS.exists() else {}
    scopes = {"<根目录>": TARGET_CFID}
    scopes.update(dirs)
    tot_d = tot_dup = 0
    unstable = []
    for name, cfid in scopes.items():
        print(f"\n📂 {name}")
        d, dup, st = clean_folder(cli, name, cfid)
        tot_d += d
        tot_dup += dup
        if st != "clean":
            unstable.append(name)
        print(f"   → docx删 {d}，重复md删 {dup}，状态 {st}")
    print(f"\n🏁 总计：docx {tot_d}，重复 md {tot_dup}，未收敛: {unstable or '无'}")


if __name__ == "__main__":
    main()
