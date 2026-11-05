# -*- coding: utf-8 -*-
"""ESS-NBLM 缺失源补传 (1105 车道抖动期丢件补齐).

背景: 1105 18:5x 跑者 --phase all 启动时 7895 出口侧刚恢复、抖动导致
框架本 14 件 SourceAddError 三连败跳过 (详见 nblm_all.log [skip] 行).
本脚本在**主跑者退出后**运行 (NBLM 严禁双开/token 竞速铁律):
  py -3 -X utf8 ess_source_backfill.py            # 框架+全部已建章补齐
  py -3 -X utf8 ess_source_backfill.py --only framework
必须先设 NBLM_PROXY=http://127.0.0.1:7895 (nb_lane 专线).

- 幂等: 每本先 sources.list, title 在场即跳过 (upload_dir_3s 同式)
- 去重: wedrive 三重复副本 (.Bf/.ie/.ciSf6UDn/.dQfj6csj 乱码后缀版) 只传正身
- 对账: 末尾打各本 present/total
"""
import asyncio
import os
import sys

os.environ["NBLM_PROXY"] = os.environ.get("NBLM_PROXY", "http://127.0.0.1:7895")
_HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, _HERE)
import ess_nblm_run as run  # noqa: E402  (import 即设代理 env)

DUPE_SUFFIXES = (".Bf", ".ie", ".ciSf6UDn", ".dQfj6csj", "_92d8c4", "_594946", "_cdd502")


def is_dupe(stem: str) -> bool:
    return any(stem.endswith(s) for s in DUPE_SUFFIXES)


async def backfill_one(client, nb_id: str, d, tag: str) -> tuple[int, int]:
    files = sorted(f for f in d.iterdir()
                   if f.suffix.lower() in (".md", ".txt", ".pdf")
                   and not is_dupe(f.stem))
    srcs = await client.sources.list(nb_id)
    exist = {s.title for s in srcs}
    exist |= {os.path.splitext(t)[0] for t in tuple(exist)}
    todo = [f for f in files if f.stem[:80] not in exist]
    print(f"[bf] {tag}: 目标{len(files)} 在场{len(files)-len(todo)} 待补{len(todo)}", flush=True)
    ok = 0
    for f in todo:
        done = False
        for att in range(3):
            try:
                await client.sources.add_file(nb_id, f, title=f.stem[:80])
                done = True
                break
            except Exception as e:  # noqa: BLE001
                print(f"[bf!] {f.name[:44]} 第{att+1}次: {type(e).__name__} {str(e)[:60]}", flush=True)
                await asyncio.sleep(30 * (att + 1))
        if done:
            ok += 1
            print(f"[bf+] {tag} ← {f.name[:60]}", flush=True)
            await asyncio.sleep(3)
        else:
            print(f"[bfX] {f.name[:44]} 三次失败仍缺 (服务端拒收型, 记账)", flush=True)
    final = {s.title for s in await client.sources.list(nb_id)}
    final |= {os.path.splitext(t)[0] for t in tuple(final)}
    present = sum(1 for f in files if f.stem[:80] in final)
    return present, len(files)


async def main() -> int:
    only = None
    if "--only" in sys.argv:
        only = sys.argv[sys.argv.index("--only") + 1]
    st = run.base.load_state()
    nbs = st["notebooks"]
    client = await run.get_client()
    rows = []
    if nbs.get("framework") and only in (None, "framework"):
        p, t = await backfill_one(client, nbs["framework"], run.FW_DIR, "框架")
        rows.append(("框架", p, t))
    for key in sorted(nbs):
        if key == "framework" or not key.startswith("ch"):
            continue
        if only and key != only:
            continue
        d = run.UPLOAD / f"{key}_笔记本"
        if not d.is_dir():
            print(f"[bf?] {key} 无目录 {d} — 跳过")
            continue
        p, t = await backfill_one(client, nbs[key], d, key)
        rows.append((key, p, t))
    print("\n===== 补传对账 =====")
    for tag, p, t in rows:
        mark = "OK " if p == t else "缺件"
        print(f"{mark} {tag}: {p}/{t}")
    return 0


if __name__ == "__main__":
    raise SystemExit(asyncio.run(main()))
