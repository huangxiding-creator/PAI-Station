# -*- coding: utf-8 -*-
"""qianwen-engine v0.7.4 ECS 部署编排器。

链路: apt 字体(rtc pair) → tar 分片上传(5 文件) → 备份+落位+py_compile+md5
      → systemctl restart → health → ttc/海报冒烟。
用法: python tools/ecs_qw_deploy.py [--files a,b,c] [--skip-apt] [--skip-smoke]
契约: 分片 16000 b64 字符（RunCommand 24KB 上限内）；远端零中文脚本；
      每步打印 ECS 输出，任何一步非零退出即中止（fail-fast）。
"""
from __future__ import annotations

import base64
import io
import subprocess
import sys
import tarfile
import time
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
REMOTE_B64 = "/opt/qianwen/pkg_v074.b64"
PKG = "services/qianwen-engine/qianwen_engine"
SHARD = 16000

sys.path.insert(0, str(REPO))
from tools.ecs_qw import run  # noqa: E402


def sh(name: str, script: str) -> None:
    print(f"\n──── {name} ────")
    code, out = run(script)
    print(out[-6000:] if len(out) > 6000 else out)
    if code != 0:
        raise SystemExit(f"[ABORT] {name} ExitCode={code}")


def main() -> None:
    files = ["app", "exporter", "poster", "store", "wechat"]
    if "--files" in sys.argv:
        files = sys.argv[sys.argv.index("--files") + 1].split(",")

    if "--skip-apt" not in sys.argv:
        sh("apt fonts-noto-cjk（海报双字重 ttc）", r"""
set -e
export DEBIAN_FRONTEND=noninteractive
apt-get install -y fonts-noto-cjk 2>&1 | tail -3
ls -la /usr/share/fonts/opentype/noto/ | head -6
""")

    # ── 打包 + 分片 ──
    buf = io.BytesIO()
    with tarfile.open(fileobj=buf, mode="w:gz") as tf:
        for name in files:
            tf.add(REPO / PKG / f"{name}.py", arcname=f"{PKG}/{name}.py")
    b64 = base64.b64encode(buf.getvalue()).decode("ascii")
    shards = [b64[i:i + SHARD] for i in range(0, len(b64), SHARD)]
    print(f"payload: {len(buf.getvalue())}B gz → {len(b64)}B b64 → {len(shards)} shards")
    for i, chunk in enumerate(shards):
        sh(f"shard {i + 1}/{len(shards)}",
           ("rm -f " + REMOTE_B64 + "\n" if i == 0 else "")
           + f"printf '%s' '{chunk}' >> {REMOTE_B64}\nwc -c {REMOTE_B64}")

    sh("finalize: 备份+落位+编译+md5+重启+健康", f"""
set -e
cd /opt/qianwen
mkdir -p backup_v074
STAMP=$(date +%m%d%H%M)
for f in {' '.join(files)}; do
  cp -a {PKG}/$f.py backup_v074/$f.py.$STAMP
done
base64 -d {REMOTE_B64} | tar xzf - -C /opt/qianwen
/opt/qianwen/venv/bin/python -m py_compile {PKG}/*.py && echo PY_COMPILE_OK
md5sum {PKG}/*.py | sort -k2
systemctl restart qianwen-engine
sleep 4
systemctl is-active qianwen-engine
curl -s -m 6 http://127.0.0.1:8869/api/health && echo
rm -f {REMOTE_B64}
""")

    if "--skip-smoke" not in sys.argv:
        sh("smoke: ttc pair + 海报渲染", r"""
set -e
cd /opt/qianwen/services/qianwen-engine
/opt/qianwen/venv/bin/python - <<'PYEOF'
import io
from PIL import Image
from qianwen_engine import poster
fr, fb = poster._font_pair()
print("font_pair:", fr(28).path if hasattr(fr(28), "path") else "?")
buf = io.BytesIO()
Image.new("RGB", (430, 430), (28, 28, 28)).save(buf, format="PNG")
q = poster.build("EPC 总承包合同工期延误后如何主张费用补偿？", [
    "结论：可主张，须书面通知并留证",
    "依据：通用条款调差与索赔机制",
    "操作：28 天内提交索赔意向书"], buf.getvalue(), {"chars": 3842, "cites": 6})
img = Image.open(io.BytesIO(q))
open("/opt/qianwen/data/qianwen/poster_smoke_v074.png", "wb").write(q)
print("POSTER_SMOKE_OK", img.size, len(q), "bytes")
PYEOF
""")

    print("\nDEPLOY ALL GREEN")


if __name__ == "__main__":
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass
    main()
