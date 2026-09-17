"""站群 CLI。

用法：
  python -m paistation.swarm identity [--name 站名]     # 建/看本站身份
  python -m paistation.swarm register --site-id X --pubkey K [--owner O ...]
  python -m paistation.swarm pack --skill-dir D --out P.zip [--price N] [--to X]
  python -m paistation.swarm receive --swap-zip P.zip --dest .claude/skills
  python -m paistation.swarm confirm --receipt R.json
  python -m paistation.swarm ledger / balance
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from . import PointsLedger, SiteIdentity, SiteRegistry, confirm_receipt, pack_swap, receive_swap


def _find_root() -> Path:
    for parent in Path(__file__).resolve().parents:
        if (parent / "pyproject.toml").is_file():
            return parent
    return Path.cwd()


def _data_dir(args) -> Path:
    return Path(args.data_dir) if args.data_dir else _find_root() / "data" / "swarm"


def main(argv=None) -> int:
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser(prog="swarm")
    ap.add_argument("--data-dir", default=None, help="默认 data/swarm")
    sub = ap.add_subparsers(dest="cmd", required=True)

    p_id = sub.add_parser("identity")
    p_id.add_argument("--name", default=None, help="站名（仅首次建身份时生效）")
    p_id.add_argument("--domain", default=None,
                      help="给真 did:wba 用自己的域名（如 gcblog.net）")

    p_reg = sub.add_parser("register")
    p_reg.add_argument("--site-id", required=True)
    p_reg.add_argument("--pubkey", required=True)
    for flag in ("--owner", "--endpoint", "--did", "--note"):
        p_reg.add_argument(flag, default="")

    p_pack = sub.add_parser("pack")
    p_pack.add_argument("--skill-dir", required=True)
    p_pack.add_argument("--out", required=True)
    p_pack.add_argument("--price", type=int, default=0)
    p_pack.add_argument("--to", default="")

    p_recv = sub.add_parser("receive")
    p_recv.add_argument("--swap-zip", required=True)
    p_recv.add_argument("--dest", required=True)
    p_recv.add_argument("--receipt-out", default=None)

    p_conf = sub.add_parser("confirm")
    p_conf.add_argument("--receipt", required=True)

    sub.add_parser("ledger")
    sub.add_parser("balance")
    args = ap.parse_args(argv)
    data = _data_dir(args)
    reg = SiteRegistry(str(data / "registry.json"))

    if args.cmd == "identity":
        ident = SiteIdentity.load_or_create(str(data), site_id=args.name)
        print(f"site_id:  {ident.site_id}")
        print(f"pubkey:   {ident.public_key_b64()}")
        print(f"did 预留:  {ident.did_hint()}")
        if args.domain:
            # P3 预研落地：真 e1_ 指纹 DID（HTTPS 端点上线前不可解析，绑定已成立）
            print(f"did_wba:  {ident.did_wba(args.domain)}")
        print(f"created:  {ident.created_at}")
        return 0
    if args.cmd == "register":
        site = reg.upsert({"site_id": args.site_id, "pubkey": args.pubkey,
                           "owner": args.owner, "endpoint": args.endpoint,
                           "did": args.did, "note": args.note})
        print(json.dumps(site, ensure_ascii=False))
        return 0
    if args.cmd == "pack":
        ident = SiteIdentity.load_or_create(str(data))
        manifest = pack_swap(args.skill_dir, args.out, ident,
                             price=args.price, to_site=args.to)
        print(f"packed: {args.out}")
        print(json.dumps(manifest, ensure_ascii=False, indent=2))
        return 0
    if args.cmd == "receive":
        ident = SiteIdentity.load_or_create(str(data))
        ledger = PointsLedger(str(data / "ledger.jsonl"), ident.site_id)
        receipt = receive_swap(args.swap_zip, args.dest, reg, ident, ledger)
        out = args.receipt_out or (args.swap_zip + ".receipt.json")
        Path(out).write_text(json.dumps(receipt, ensure_ascii=False,
                                        indent=2), encoding="utf-8")
        print(f"installed: {receipt['package']} -> {args.dest}")
        print(f"paid: {receipt['price_points']} -> {receipt['to_site']}")
        print(f"receipt: {out}（发给对方站 confirm 即完成对账）")
        return 0
    if args.cmd == "confirm":
        ident = SiteIdentity.load_or_create(str(data))
        ledger = PointsLedger(str(data / "ledger.jsonl"), ident.site_id)
        receipt = json.loads(Path(args.receipt).read_text(encoding="utf-8"))
        row = confirm_receipt(receipt, reg, ledger)
        print(f"income: +{row['points']} ({row['package']} from "
              f"{row['counterparty']}) seq={row['seq']}")
        return 0
    if args.cmd == "ledger":
        ident = SiteIdentity.load_or_create(str(data))
        ledger = PointsLedger(str(data / "ledger.jsonl"), ident.site_id)
        for row in ledger.events():
            print(json.dumps(row, ensure_ascii=False))
        return 0
    if args.cmd == "balance":
        ident = SiteIdentity.load_or_create(str(data))
        ledger = PointsLedger(str(data / "ledger.jsonl"), ident.site_id)
        print(f"{ident.site_id}: {ledger.balance()}")
        return 0
    return 2


if __name__ == "__main__":
    raise SystemExit(main())
