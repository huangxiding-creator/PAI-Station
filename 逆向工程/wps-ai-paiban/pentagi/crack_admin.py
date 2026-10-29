#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""对迁移播种的 admin bcrypt 哈希跑小候选表（合法自有部署的口令找回）。"""
import bcrypt

HASH = b"$2a$10$deVOk0o1nYRHpaVXjIcyCuRmaHvtoMN/2RUT7w5XbZTeiWKEbXx9q"
CANDS = [
    "pentagipass", "pentagi", "Pentagi123!", "pentagi123", "admin", "password",
    "admin123", "pentagiPass", "PentAGI", "pentagi2024", "changeme", "secret",
    "vxcontrol", "letmein", "pentagipassword", "Pentagi", "123456", "test",
]


def main():
    for c in CANDS:
        if bcrypt.checkpw(c.encode(), HASH):
            print(f"[HIT] admin@pentagi.com 口令 = {c!r}")
            return 0
    print("[MISS] 候选表未命中（18/18）")
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
