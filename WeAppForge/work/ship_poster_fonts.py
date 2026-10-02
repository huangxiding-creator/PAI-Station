# -*- coding: utf-8 -*-
"""ship_poster_fonts.py — 海报 CJK 字体送达 ECS（16.9MB 走 16KB 云助手分片要 ~1400 片≈2h，
改走 ECS 侧公网直拉 + sha256 对本地指纹 + PIL 装载验收；jsdelivr 主道/github 直连备道）。

用法：PYTHONIOENCODING=utf-8 python work/ship_poster_fonts.py [--check]
"""
from __future__ import annotations

import argparse
import hashlib
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from ecs_deploy_xueyuan import PREFIX, ecs_cmd  # noqa: E402

FONTS_DIR_LOCAL = Path("E:/AI-Station/services/xueyuan-engine/assets/fonts")
FONTS_DIR_REMOTE = f"{PREFIX}/services/xueyuan-engine/assets/fonts"

# 主备双道（notofonts/noto-cjk 官方仓库同一 blob；jsdelivr 国内可达性好）
URLS = {
    "NotoSansSC-Regular.otf": [
        "https://fastly.jsdelivr.net/gh/notofonts/noto-cjk@main/Sans/SubsetOTF/SC/NotoSansSC-Regular.otf",
        "https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Regular.otf",
    ],
    "NotoSansSC-Bold.otf": [
        "https://fastly.jsdelivr.net/gh/notofonts/noto-cjk@main/Sans/SubsetOTF/SC/NotoSansSC-Bold.otf",
        "https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Bold.otf",
    ],
}


def sha256_local(name: str) -> str:
    return hashlib.sha256((FONTS_DIR_LOCAL / name).read_bytes()).hexdigest()


def ship_one(name: str, digest: str, size: int, check_only: bool) -> bool:
    remote = f"{FONTS_DIR_REMOTE}/{name}"
    url = URLS[name][0]  # jsdelivr 主道（fastly 边缘，大陆可达；github raw 大陆云不可达实测）
    # 续传循环：jsdelivr 半途截断实锤（6.3/7.9MB）→ -C - 续传 ×6 轮，每轮 --retry 3
    script = f"""mkdir -p {FONTS_DIR_REMOTE}
if [ -f {remote} ] && echo '{digest}  {remote}' | sha256sum -c - >/dev/null 2>&1; then
  echo ALREADY_OK
elif {'true' if check_only else 'false'}; then
  echo NEED_SHIP
else
  ok=0
  for i in 1 2 3 4 5 6; do
    curl -fL -C - --retry 3 --retry-delay 2 --connect-timeout 15 -m 600 '{url}' -o {remote}.part
    sz=$(stat -c %s {remote}.part 2>/dev/null || echo 0)
    echo "round$i size=$sz"
    if [ "$sz" -eq {size} ]; then
      if echo '{digest}  {remote}.part' | sha256sum -c - >/dev/null 2>&1; then
        mv {remote}.part {remote} && ok=1 && echo SHIPPED_ROUND$i
      else
        echo HASH_MISMATCH_TRUNCATED; rm -f {remote}.part
      fi
    fi
    [ "$ok" -eq 1 ] && break
  done
  if [ "$ok" -ne 1 ]; then
    echo ALL_ROUND_FAIL; ls -la {FONTS_DIR_REMOTE}; exit 1
  fi
fi"""
    out = ecs_cmd(script, f"font-{name[:12]}", wait=900)
    ok = "ALREADY_OK" in out or "SHIPPED_ROUND" in out or (check_only and "NEED_SHIP" in out)
    print(f"[{name}] {'OK' if ok else 'FAIL'}\n{out.strip()[-500:]}")
    return ok


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--check", action="store_true", help="只查缺不拉")
    args = ap.parse_args()

    results = {
        n: ship_one(n, sha256_local(n), (FONTS_DIR_LOCAL / n).stat().st_size, args.check)
        for n in URLS
    }
    if not all(results.values()):
        print("FONTS SHIP FAIL")
        return 1

    if not args.check:
        # PIL 装载验收（渲染链真验，非仅存在性）+ 渲染冒烟一张不带码占位
        out = ecs_cmd(
            f"cd {PREFIX}/services/xueyuan-engine && {PREFIX}/venv/bin/python -c \""
            "from PIL import ImageFont; import sys; sys.path.insert(0, '.'); "
            "from xueyuan_engine import config; "
            f"f1 = ImageFont.truetype(str(config.POSTER_FONT_REGULAR), 48); "
            f"f2 = ImageFont.truetype(str(config.POSTER_FONT_BOLD), 48); "
            "assert f1.getbbox('总包学园江苏水网') and f2.getbbox('商机情报'); "
            "print('FONT_RENDER_OK')\"",
            "font-verify", wait=120,
        )
        if "FONT_RENDER_OK" not in out:
            print(f"FONT VERIFY FAIL: {out[-300:]}")
            return 1
        print(out.strip()[-200:])
    print("POSTER FONTS SHIP DONE")
    return 0


if __name__ == "__main__":
    sys.exit(main())
