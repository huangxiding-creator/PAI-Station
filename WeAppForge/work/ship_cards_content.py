# -*- coding: utf-8 -*-
"""ship_cards_content.py — 商机卡数据（content/cards/*.json，38 文件 ~1.3MB）送达 ECS。

引擎读码路径=config.CONTENT_DIR/'cards'（ECS=XY_CONTENT_DIR=/opt/xueyuan/data/
content_pkg，见 systemd unit）；送达=tar.gz 内存构建 → base64 16000 字符分片云助手
追加 → 解包落 content_pkg/cards/ → 文件数+sha256 验收 → restart（进程内卡索引
缓存换血）→ /health 探针。幂等：远端 marker hash 一致即 ALREADY_OK 跳过。

用法：PYTHONIOENCODING=utf-8 python work/ship_cards_content.py [--check]
红线：只写 {PREFIX}/data/content_pkg/cards/ 与 xy_cards.b64/marker 三个远端位；
只 restart xueyuan-engine；数据源=本地 WeAppForge 内容树（生成管线正源）。
"""
from __future__ import annotations

import argparse
import base64
import hashlib
import io
import sys
import tarfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from ecs_deploy_xueyuan import CHUNK, PREFIX, UNIT, ecs_cmd  # noqa: E402

SRC = Path("E:/AI-Station/微信小程序/zongbao/content/cards")
DST_DIR = f"{PREFIX}/data/content_pkg/cards"
B64 = f"{PREFIX}/xy_cards.b64"
MARKER = f"{PREFIX}/data/content_pkg/.cards_sha256"


def build_tar() -> tuple[bytes, str]:
    files = sorted(SRC.glob("*.json"))
    if len(files) < 30:
        raise RuntimeError(f"卡数据源异常：仅 {len(files)} 文件（预期 38）")
    buf = io.BytesIO()
    with tarfile.open(fileobj=buf, mode="w:gz") as tf:
        for f in files:
            tf.add(str(f), arcname=f"cards/{f.name}")
    raw = buf.getvalue()
    return raw, hashlib.sha256(raw).hexdigest()


def remote_ok(digest: str) -> bool:
    out = ecs_cmd(
        f"[ -f {MARKER} ] && cat {MARKER} || echo NONE", "cards-marker", wait=60)
    return digest in out and "NONE" not in out.split("\n")[0]


def ship(digest: str, b64: str, n_files: int, check_only: bool) -> bool:
    if remote_ok(digest):
        print("ALREADY_OK（marker hash 一致，跳过）")
        return True
    if check_only:
        print("NEED_SHIP")
        return False
    chunks = [b64[i:i + CHUNK] for i in range(0, len(b64), CHUNK)]
    print(f"tar.gz sha256={digest[:16]}… → {len(chunks)} 片（~{len(chunks) * 4.9 / 60:.1f} min）")
    ecs_cmd(f"rm -f {B64}", "cards-rm", wait=60)  # 幂等头：清旧分片防追加污染
    for i, ch in enumerate(chunks, 1):
        ecs_cmd(f"printf %s '{ch}' >> {B64}", f"cards-chunk{i}", wait=60)
        if i % 10 == 0 or i == len(chunks):
            print(f"  chunk {i}/{len(chunks)}")
    script = (
        f"mkdir -p {DST_DIR} && cd {PREFIX}/data/content_pkg"
        f" && base64 -d {B64} | tar xz -C {PREFIX}/data/content_pkg"
        f" && n=$(ls {DST_DIR}/*.json 2>/dev/null | wc -l)"
        f" && echo files=$n && [ \"$n\" -eq {n_files} ]"
        f" && echo '{digest}' > {MARKER} && rm -f {B64}"
        f" && systemctl restart {UNIT} && sleep 3"
        f" && echo service=$(systemctl is-active {UNIT})"
        f" && curl -sf http://127.0.0.1:8871/health"
    )
    out = ecs_cmd(script, "cards-unpack-verify", wait=300)
    ok = f"files={n_files}" in out and "service=active" in out and '"ok"' in out
    print(f"[unpack+verify] {'OK' if ok else 'FAIL'}\n{out.strip()[-300:]}")
    return ok


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--check", action="store_true", help="只查缺不送")
    args = ap.parse_args()
    raw, digest = build_tar()
    b64 = base64.b64encode(raw).decode("ascii")
    n = len(list(SRC.glob("*.json")))
    ok = ship(digest, b64, n, args.check)
    print("CARDS CONTENT SHIP " + ("DONE" if ok else "FAIL"))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
