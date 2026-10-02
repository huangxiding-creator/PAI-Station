#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""小程序码预生成池工具（FR-P1-07 / R-11 限频处置）——默认 dry-run，--live 才真调微信。

为什么预生成：getwxacodeunlimit 调用频率 5000 次/分钟（官方建议预生成），海报码按
(report × inviter) 组合增长，批量生成期实时调用量必须=0（GWT 判据：码池命中 100%）。

用法（引擎根目录；Windows 全程 PYTHONIOENCODING=utf-8）：
  PYTHONIOENCODING=utf-8 ./.venv/Scripts/python.exe tools/qr_pool.py js-shuiwang-2026
  PYTHONIOENCODING=utf-8 ./.venv/Scripts/python.exe tools/qr_pool.py js-shuiwang-2026 --live
  PYTHONIOENCODING=utf-8 ./.venv/Scripts/python.exe tools/qr_pool.py js-shuiwang-2026 \
      --uid u1234abcd --uid u5678ef90 --live
  PYTHONIOENCODING=utf-8 ./.venv/Scripts/python.exe tools/qr_pool.py js-shuiwang-2026 \
      --all-users --live

⚠ env_version 两处约定（与部署手册同口径，Day-0 检查点）：
  1) 小程序未发布（当前）：必须 develop/trial 且 check_path=False（本工具默认 develop）。
  2) Day-0 上线发布后：须 --env-version release 重灌正式码池（develop 码只进开发版）。
wechat.py import-only：复用 wechat.mp_secret()/config.WX_APPID，不改它——
引擎与 qianwen 母本均无 access_token 助手，本工具进程内自取（见 fetch_access_token）。
"""
from __future__ import annotations

import argparse
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from curl_cffi import requests as cr  # noqa: E402

from xueyuan_engine import config, poster, store, wechat  # noqa: E402

API = "https://api.weixin.qq.com"
THROTTLE_SEC = 0.05   # 600 次/分保守节流（远低于 5000 次/分官方限频）


def fetch_access_token() -> str:
    """appsecret→access_token（进程内一次性；wechat.py 无既有助手故自取，绝不落盘）。"""
    secret = wechat.mp_secret()
    if not secret:
        raise SystemExit("appsecret 未配置（data/secrets/xueyuan_mp.secret），无法 --live")
    r = cr.get(
        f"{API}/cgi-bin/token",
        params={"grant_type": "client_credential",
                "appid": config.WX_APPID, "secret": secret},
        impersonate="chrome", timeout=15,
    )
    d = r.json()
    if "access_token" not in d:
        raise SystemExit(f"access_token 获取失败: {d.get('errcode')}: {d.get('errmsg')}")
    return d["access_token"]


def fetch_qr(access_token: str, scene: str, page: str, env_version: str, width: int) -> bytes:
    """getwxacodeunlimit 单发（成功=图片字节；错误=JSON，40129/41030/45009 见 viral_poster §3）。"""
    r = cr.post(
        f"{API}/wxa/getwxacodeunlimit",
        params={"access_token": access_token},
        json={"scene": scene, "page": page, "check_path": False,
              "env_version": env_version, "width": width},
        impersonate="chrome", timeout=20,
    )
    if "json" in r.headers.get("content-type", ""):
        d = r.json()
        raise SystemExit(f"getwxacodeunlimit {d.get('errcode')}: {d.get('errmsg')}（scene={scene}）")
    if r.status_code != 200:
        raise SystemExit(f"getwxacodeunlimit HTTP {r.status_code}（scene={scene}）")
    return r.content


def main() -> None:
    ap = argparse.ArgumentParser(description="小程序码预生成池（默认 dry-run；--live 才真调微信）")
    ap.add_argument("report_id", nargs="?", default="", help="报告短 ID（如 js-shuiwang-2026）")
    ap.add_argument("--card", default="", help="卡模式：商机卡 card_id（如 ezhou-shuiliju-2026-c001）")
    ap.add_argument("--uid", action="append", default=[], help="邀请人 uid（可多次）")
    ap.add_argument("--all-users", action="store_true", help="全库用户逐一生成")
    ap.add_argument("--channel", default="poster", help="poster/session/moments")
    ap.add_argument("--page", default="pages/index/index", help="扫码落地页（不能带参数）")
    ap.add_argument("--env-version", default="develop", choices=("develop", "trial", "release"),
                    help="未发布小程序须 develop/trial；Day-0 发布后 release 重灌正式码池")
    ap.add_argument("--width", type=int, default=720, help="码宽 280-1280；海报印刷位建议 600-800")
    ap.add_argument("--limit", type=int, default=500, help="单次安全上限（限频 5000 次/分的保守闸）")
    ap.add_argument("--live", action="store_true", help="真调微信（默认 dry-run 只打印计划）")
    args = ap.parse_args()

    store.init()
    if args.card:
        return run_card_mode(args)
    with store._db() as c:
        if not c.execute("SELECT 1 FROM reports WHERE id=? AND status='on'",
                         (args.report_id,)).fetchone():
            raise SystemExit(f"报告不存在或已下架: {args.report_id}")
        uids = list(args.uid) or (
            [r["id"] for r in c.execute("SELECT id FROM users ORDER BY created_at").fetchall()]
            if args.all_users else [])
    if not uids:
        raise SystemExit("未指定 --uid 且未开 --all-users（dry-run 也须明确目标）")
    if len(uids) > args.limit:
        raise SystemExit(f"目标 {len(uids)} 超单次上限 {args.limit}（--limit 调整；限频 5000/分）")

    plan = []
    for uid in uids:
        scene = poster.ensure_scene(args.report_id, uid, channel=args.channel)
        plan.append((uid, scene, poster.qr_pool_path(scene)))

    if not args.live:
        for uid, scene, path in plan:
            print(f"[dry-run] {'SKIP(已有)' if path.exists() else 'PLAN':10s}"
                  f" uid={uid} scene={scene} -> {path.name}")
        todo = sum(1 for _, _, p in plan if not p.exists())
        print(f"[dry-run] 共 {len(plan)} 条，待生成 {todo} 条；加 --live 才真调微信")
        return

    token = fetch_access_token()
    ok = skip = 0
    for uid, scene, path in plan:
        if path.exists():
            skip += 1
            continue
        path.parent.mkdir(parents=True, exist_ok=True)   # 全新数据区 qrs/ 不存在自愈
        path.write_bytes(fetch_qr(token, scene, args.page, args.env_version, args.width))
        with store._LOCK, store._db() as c:   # pregenerated=1 码池标记（幂等 upsert）
            c.execute(
                "INSERT INTO poster_code(scene_code,report_id,inviter_uid,channel,"
                "poster_version,pregenerated,created_at) VALUES(?,?,?,?,?,1,?)"
                " ON CONFLICT(scene_code) DO UPDATE SET pregenerated=1",
                (scene, args.report_id, uid, args.channel, config.POSTER_VERSION, store.now()))
        ok += 1
        time.sleep(THROTTLE_SEC)
        print(f"[live] uid={uid} scene={scene} -> {path.name}")
    print(f"[live] 新增 {ok} / 跳过 {skip}（env_version={args.env_version}；"
          f"Day-0 发布后须 --env-version release 重灌）")


def run_card_mode(args) -> None:  # noqa: ANN001
    """卡码池模式（--card）：真实卡直拼 c= 全量超 32 上限→ensure_card_code 短码。

    码表落 card_code（ensure 幂等，无 poster_code 副写）；page 默认卡落地页。
    """
    from xueyuan_engine import cards
    card = cards.find_card(args.card)
    if not card:
        raise SystemExit(f"卡不存在: {args.card}")
    uids = list(args.uid)
    if not uids:
        raise SystemExit("卡模式须显式 --uid（可多次；不支持 --all-users 全笛卡尔）")
    if len(uids) > args.limit:
        raise SystemExit(f"目标 {len(uids)} 超单次上限 {args.limit}")
    page = args.page if args.page != "pages/index/index" else "pages/cards/detail"
    plan = []
    for uid in uids:
        scene = cards.card_qr_scene(args.card, uid)
        if not scene:
            raise SystemExit(f"卡 scene 分配失败（card={args.card} uid={uid}）")
        plan.append((uid, scene, poster.qr_pool_path(scene)))
    if not args.live:
        for uid, scene, path in plan:
            print(f"[dry-run] {'SKIP(已有)' if path.exists() else 'PLAN':10s}"
                  f" uid={uid} scene={scene} -> {path.name}")
        todo = sum(1 for _, _, p in plan if not p.exists())
        print(f"[dry-run] 卡模式共 {len(plan)} 条，待生成 {todo} 条；加 --live 才真调微信")
        return
    token = fetch_access_token()
    ok = skip = 0
    for uid, scene, path in plan:
        if path.exists():
            skip += 1
            continue
        path.parent.mkdir(parents=True, exist_ok=True)   # 同主模式：全新数据区自愈
        path.write_bytes(fetch_qr(token, scene, page, args.env_version, args.width))
        ok += 1
        time.sleep(THROTTLE_SEC)
        print(f"[live] uid={uid} scene={scene} -> {path.name}")
    print(f"[live] 卡模式新增 {ok} / 跳过 {skip}（env_version={args.env_version}）")


if __name__ == "__main__":
    main()
