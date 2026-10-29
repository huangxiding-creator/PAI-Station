# -*- coding: utf-8 -*-
"""W0 凭据迁移：captures/secrets_vault.json → data/secrets/bdn_credentials.json
值全程不打印（仅掩码确认）；迁移成功后将 vault 覆写为指针文件（不删除文件本体）。
用法: python -I migrate_secret_w0.py
"""
import json, sys, io
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(r"E:\AI-Station")
VAULT = ROOT / r"逆向工程\baidu-netdisk\captures\secrets_vault.json"
DEST = ROOT / r"data\secrets\bdn_credentials.json"


def mask(v: str) -> str:
    return f"{v[:8]}…(len={len(v)})" if v else "<empty>"


def main() -> int:
    if not VAULT.exists():
        print(f"[W0] vault 不存在: {VAULT}")
        return 1
    import re
    raw = VAULT.read_text(encoding="utf-8", errors="replace")
    # vault 实测形态：dict 带多个重复 "Cookie" 键，凭据内联在值里（STOKEN=..; BDUSS=..）
    # → 直接对原文做正则提取（json.loads 会丢重复键，不可用）
    m_b = re.search(r"BDUSS=([A-Za-z0-9\-~_.]{100,400})", raw)
    m_s = re.search(r"STOKEN=([0-9a-f]{60,70})", raw)
    bduss = m_b.group(1) if m_b else None
    stoken = m_s.group(1) if m_s else None
    if not bduss or not stoken:
        print("[W0] 未能在 vault 中定位 BDUSS/STOKEN（结构未预期）——不破坏原文件，人工介入")
        return 2
    DEST.parent.mkdir(parents=True, exist_ok=True)
    payload = {
        "_meta": {"source": "client-8.2.5-capture-1029", "account": "pyeye@126.com", "migrated": "2026-10-29"},
        "bduss": bduss,
        "stoken": stoken,
        "ua_native": "netdisk;8.2.5.103;PC;PC-Windows;10.0.19045;WindowsBaiduYunGuanJia",
    }
    DEST.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")
    # 迁移成功 → vault 覆写为指针（保文件、去明文）
    VAULT.write_text(
        "# 已迁移 → E:/AI-Station/data/secrets/bdn_credentials.json (W0, 2026-10-29)\n"
        "# 本文件不再保存明文凭据。迁移确认: BDUSS/STOKEN 均已落位。\n",
        encoding="utf-8",
    )
    print(f"[W0] 迁移OK → {DEST}")
    print(f"[W0] bduss={mask(bduss)} stoken={mask(stoken)}")
    print("[W0] vault 已覆写为指针文件（明文清除，文件保留）")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
