# -*- coding: utf-8 -*-
"""v0.9.13 虚拟支付道具现网发布器（REQ-003 根因修：道具未发布至现网 → 真机 -15010）。

五步（API_DESIGN.md §2，幂等可重跑）：
  1) query_publish_goods(env) 看现状
  2) 逐道具 start_upload_goods（官方：一次仅支持上传一个道具）
  3) 逐道具 start_publish_goods
  4) 轮询 query_publish_goods 至全部 publish_status=2（发布成功）
  5) 状态落盘 data/state/vpay_goods_publish.json

签名：pay_sig = HMAC-SHA256(appkey_env, uri + "&" + body)，直接复用引擎
wechat.virtual_pay_sign（body=/uri= 直签入口，tests/test_pay_sign.py 官方向量锚定）。
请求体=签名字符串逐字节原样发送（data= 而非 json=——绝不让 HTTP 库二次序列化
产生与签名串不同的字节序）。

用法：
  python vpay_goods_publish.py --state          # 只读状态（离线，任务验证口径）
  python vpay_goods_publish.py --dry-run        # 列道具+签名串，不发包
  python vpay_goods_publish.py --query          # 只查现网发布现状（1 次只读 API）
  python vpay_goods_publish.py                  # 全流程发布 env=0
  python vpay_goods_publish.py --item report_498  # 只处理指定道具
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

PKG_PARENT = Path(__file__).resolve().parents[1]   # services/qianwen-engine
sys.path.insert(0, str(PKG_PARENT))

from qianwen_engine import config, wechat  # noqa: E402
from curl_cffi import requests as cr  # noqa: E402

ITEM_URL = "https://ai.epcschool.top/static/goods/zongbaojun.jpg"
STATE_FILE = config.REPO / "data" / "state" / "vpay_goods_publish.json"
API_BASE = "https://api.weixin.qq.com"

# 道具清单：id=virtual_pay.secret 里的分档道具（report_product_<元> 的值），
# 一档覆盖多份报告（引擎 _report_product 按价格分档开单）——道具名必须是
# 分档通用名，绝不能用单份报告标题。
GOODS = [
    # name 字符集=官方白名单：中英文、数字及 -_*·（672770002 实测教训：全角括号违禁）
    {"id": "export_once", "name": "咨询导出解锁-单条", "price": 10,
     "remark": "咨询问答导出 Word/PDF/Markdown，0.1元/条"},
    {"id": "report_498", "name": "研究报告解锁-标准版", "price": 49800,
     "remark": "研究报告解锁，一次解锁永久阅读"},
    {"id": "report_598", "name": "研究报告解锁-进阶版", "price": 59800,
     "remark": "研究报告解锁，一次解锁永久阅读"},
    {"id": "report_698", "name": "研究报告解锁-专业版", "price": 69800,
     "remark": "研究报告解锁，一次解锁永久阅读"},
    {"id": "report_1999", "name": "研究报告解锁-旗舰版", "price": 199900,
     "remark": "研究报告解锁，一次解锁永久阅读"},
]


def vp_secret() -> dict:
    f = config.VIRTUAL_PAY_FILE
    if not f.exists():
        sys.exit(f"FATAL: {f} 不存在")
    out = {}
    for line in f.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if line and "=" in line and not line.startswith("#"):
            k, v = line.split("=", 1)
            out[k.strip()] = v.strip()
    return out


def build_goods(vp: dict) -> list[dict]:
    """道具 id 与 secret 分档键对账后返回（id 与引擎开单 productId 逐字符一致才放行）。"""
    expect = {"export_product_id": "export_once",
              "report_product_498": "report_498", "report_product_598": "report_598",
              "report_product_698": "report_698", "report_product_1999": "report_1999"}
    for k, gid in expect.items():
        actual = vp.get(k)
        if actual != gid:
            sys.exit(f"FATAL: secret {k}={actual!r} 与道具清单 {gid!r} 不一致——先对账再发布")
    return [{**g, "item_url": ITEM_URL} for g in GOODS]


def appkey_for(vp: dict, env: int) -> str:
    key = (vp.get("prod_appkey") if env == 0 else vp.get("sandbox_appkey")) or ""
    if not key:
        sys.exit(f"FATAL: env={env} 对应 appkey 缺失（virtual_pay.secret）")
    return key


def call_xpay(method_uri: str, payload: dict, env: int, app_key: str,
              retry_rate_limit: int = 3) -> dict:
    """POST /xpay/*：access_token+pay_sig 走 query 参数，body=签名字符串逐字节。

    xpay 管理面接口限频（268490015 实测）：固定间隔 3s + 限频指数退避重试。"""
    body = json.dumps(payload, separators=(",", ":"), ensure_ascii=False)
    _, pay_sig, _ = wechat.virtual_pay_sign(app_key, "", body=body, uri=method_uri)
    for attempt in range(retry_rate_limit + 1):
        r = cr.post(
            f"{API_BASE}{method_uri}",
            params={"access_token": wechat._access_token(), "pay_sig": pay_sig},
            data=body.encode("utf-8"),
            headers={"Content-Type": "application/json"},
            impersonate="chrome", timeout=20,
        )
        try:
            d = r.json()
        except Exception:  # noqa: BLE001
            sys.exit(f"FATAL: {method_uri} 响应非 JSON（HTTP {r.status_code}）: {r.text[:200]}")
        if d.get("errcode") == 268490015 and attempt < retry_rate_limit:
            wait = 15 * (attempt + 1)
            print(f"     限频，{wait}s 后重试（{attempt + 1}/{retry_rate_limit}）")
            time.sleep(wait)
            continue
        break
    time.sleep(3)
    if d.get("errcode"):
        print(f"ERR  {method_uri} errcode={d.get('errcode')} {d.get('errmsg')}")
    return d


def parse_publish_status(q: dict) -> dict:
    """query_publish_goods 应答 → {道具id: publish_status}（字段名宽容兼容）。"""
    out: dict = {}
    for key in ("publish_item", "publish_goods", "goods", "list", "item_list"):
        rows = q.get(key)
        if isinstance(rows, list):
            for it in rows:
                gid = it.get("id") or it.get("item_id")
                if gid:
                    out[str(gid)] = it.get("publish_status", it.get("status"))
            if out:
                break
    return out


def load_state() -> dict:
    if STATE_FILE.exists():
        try:
            return json.loads(STATE_FILE.read_text(encoding="utf-8"))
        except Exception:  # noqa: BLE001
            return {}
    return {}


def save_state(st: dict) -> None:
    STATE_FILE.parent.mkdir(parents=True, exist_ok=True)
    tmp = STATE_FILE.with_suffix(".tmp")
    tmp.write_text(json.dumps(st, ensure_ascii=False, indent=2), encoding="utf-8")
    tmp.replace(STATE_FILE)


def main() -> int:
    ap = argparse.ArgumentParser(description="虚拟支付道具现网发布器")
    ap.add_argument("--env", type=int, default=0, help="0=现网 1=沙箱（默认 0）")
    ap.add_argument("--item", action="append", help="只处理指定道具 id（可多次）")
    ap.add_argument("--dry-run", action="store_true", help="列道具+签名串，不发包")
    ap.add_argument("--query", action="store_true", help="只查发布现状（只读 1 次 API）")
    ap.add_argument("--state", action="store_true", help="只读本地状态文件（离线）")
    ap.add_argument("--timeout", type=int, default=600, help="发布生效轮询超时秒（默认 600）")
    args = ap.parse_args()

    if args.state:
        print(json.dumps(load_state(), ensure_ascii=False, indent=2))
        return 0

    vp = vp_secret()
    env = args.env
    app_key = appkey_for(vp, env)
    goods = build_goods(vp)
    if args.item:
        want = set(args.item)
        goods = [g for g in goods if g["id"] in want]
        if not goods:
            sys.exit(f"FATAL: --item 过滤后为空（候选：{[g['id'] for g in GOODS]}）")

    print(f"== vpay goods publish env={env} items={[g['id'] for g in goods]}")
    if args.dry_run:
        for g in goods:
            body = json.dumps({"upload_item": [g], "env": env},
                              separators=(",", ":"), ensure_ascii=False)
            _, pay_sig, _ = wechat.virtual_pay_sign(app_key, "", body=body,
                                                    uri="/xpay/start_upload_goods")
            print(f"  [dry] {g['id']} price={g['price']} name={g['name']}")
            print(f"        body={body}")
            print(f"        pay_sig={pay_sig[:16]}…")
        print("--dry-run 完，未发包")
        return 0

    st = load_state().get(f"env{env}", {})
    q = call_xpay("/xpay/query_publish_goods", {"env": env}, env, app_key)
    cur = parse_publish_status(q)
    print(f"query: {json.dumps(cur, ensure_ascii=False)}")

    if args.query:
        print(json.dumps(q, ensure_ascii=False, indent=2))
        return 0

    # 2) 逐道具上传（一次一个——官方限制）
    for g in goods:
        if cur.get(g["id"]) == 2:
            print(f"OK   {g['id']} 已是发布成功态，跳过")
            st[g["id"]] = {"publish_status": 2, "updated_at": time.strftime("%Y-%m-%d %H:%M:%S")}
            continue
        d = call_xpay("/xpay/start_upload_goods", {"upload_item": [g], "env": env}, env, app_key)
        print(f"upload {g['id']}: {json.dumps(d, ensure_ascii=False)}")
        st[g["id"]] = {"upload_errcode": d.get("errcode"), "updated_at": time.strftime("%Y-%m-%d %H:%M:%S")}
        if d.get("errcode"):
            return 2

    # 3) 逐道具发布（发布任务串行：268490012=上一批量运行中→长等待重试）
    acked: list[str] = []
    for g in goods:
        for attempt in range(11):
            d = call_xpay("/xpay/start_publish_goods",
                          {"publish_item": [{"id": g["id"]}], "env": env}, env, app_key)
            print(f"publish {g['id']}: {json.dumps(d, ensure_ascii=False)}")
            if d.get("errcode") == 268490012 and attempt < 10:
                print(f"     批量任务运行中，60s 后重试（{attempt + 1}/10）")
                time.sleep(60)
                continue
            break
        if d.get("errcode"):
            st[g["id"]] = {**st.get(g["id"], {}), "publish_errcode": d.get("errcode")}
            save_state({"env%d" % env: st})
            return 3
        acked.append(g["id"])
        st[g["id"]] = {**st.get(g["id"], {}), "publish_acked": True,
                       "updated_at": time.strftime("%Y-%m-%d %H:%M:%S")}

    # 4) 轮询最新批量任务至 status=3（发布生效约 10 分钟）。
    #    query_publish_goods 只回最新批量明细（实测 1010），全量真值=逐件 publish ACK
    #    + 末批任务成功态；末批含最后一件即代表此前各批均已出队完成。
    deadline = time.time() + args.timeout
    while time.time() < deadline:
        time.sleep(30)
        q = call_xpay("/xpay/query_publish_goods", {"env": env}, env, app_key)
        cur = parse_publish_status(q)
        last = goods[-1]["id"]
        print(f"poll: task_status={q.get('status')} items={json.dumps(cur, ensure_ascii=False)}")
        if q.get("status") == 3 and cur.get(last) == 2:
            for gid in acked:
                st[gid] = {**st.get(gid, {}), "publish_status": 2,
                           "updated_at": time.strftime("%Y-%m-%d %H:%M:%S")}
            save_state({"env%d" % env: st})
            print(f"ALL PUBLISHED ✓ (acked={acked})")
            return 0
    save_state({"env%d" % env: st})
    print("TIMEOUT：末批未在限内确认（publish ACK 已全拿到，可重跑续查）")
    return 4


if __name__ == "__main__":
    sys.exit(main())
