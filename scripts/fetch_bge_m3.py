"""后置模型下载（M6.3）：bge-m3 ONNX 到用户模型目录。

运行时永不硬依赖此脚本——HashingEmbedder 兜底在先（基本零成本红线）；
高配机器想要更强语义检索时手动跑一次即可：
    python scripts/fetch_bge_m3.py            # 下载到 %APPDATA%\\PAI-Station\\models
    python scripts/fetch_bge_m3.py --check    # 只查在不在，不下载
源走 hf-mirror（国内可达）；导出仓漂移时用 --tokenizer-url/--onnx-url 换源。
只写目标目录（默认 %APPDATA%），不碰本机其他任何路径。
"""
from __future__ import annotations

import argparse
import os
import sys
import urllib.request
from pathlib import Path

BASE = "https://hf-mirror.com/Xenova/bge-m3/resolve/main"
TOKENIZER_URL = f"{BASE}/tokenizer.json"
ONNX_URL = f"{BASE}/onnx/model.onnx"
CHUNK = 1 << 16


def _default_root() -> Path:
    return Path(os.path.expandvars(
        r"%APPDATA%\PAI-Station\models")) / "bge-m3-onnx"


def plan(dest_root: str | Path | None = None) -> list[tuple[str, Path]]:
    """[(url, dest), ...]；dest 统一落在 dest_root/bge-m3-onnx/ 下。"""
    d = Path(dest_root) / "bge-m3-onnx" if dest_root else _default_root()
    return [(TOKENIZER_URL, d / "tokenizer.json"),
            (ONNX_URL, d / "model.onnx")]


def check_state(dest_root: str | Path | None = None) -> dict:
    items = plan(dest_root)
    state = {p.name: p.is_file() for _u, p in items}
    return {"tokenizer": state.get("tokenizer.json", False),
            "onnx": state.get("model.onnx", False),
            "ready": all(state.values())}


def _download(url: str, dest: Path) -> None:
    dest.parent.mkdir(parents=True, exist_ok=True)
    part = dest.with_suffix(dest.suffix + ".part")
    print(f"[fetch] {url}\n       → {dest}")
    done = 0
    with urllib.request.urlopen(url, timeout=60) as resp, \
            open(part, "wb") as fh:
        total = int(resp.headers.get("Content-Length") or 0)
        while True:
            block = resp.read(CHUNK)
            if not block:
                break
            fh.write(block)
            done += len(block)
            if total:
                print(f"\r[fetch]   {done / total:6.1%}", end="", flush=True)
    os.replace(part, dest)
    print(f"\n[fetch] 完成 {dest.name}（{done} 字节）")


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description="bge-m3 ONNX 后置下载（可选增强，非必需）")
    ap.add_argument("--dest", default=None,
                    help="模型根目录（默认 %%APPDATA%%\\PAI-Station\\models）")
    ap.add_argument("--check", action="store_true", help="只检查不下载")
    ap.add_argument("--tokenizer-url", default=None)
    ap.add_argument("--onnx-url", default=None)
    args = ap.parse_args(argv)

    items = plan(args.dest)
    if args.tokenizer_url:
        items[0] = (args.tokenizer_url, items[0][1])
    if args.onnx_url:
        items[1] = (args.onnx_url, items[1][1])

    state = check_state(args.dest)
    if args.check:
        print(f"[check] tokenizer={'✓' if state['tokenizer'] else '✗'} "
              f"onnx={'✓' if state['onnx'] else '✗'} "
              f"root={items[0][1].parent}")
        return 0 if state["ready"] else 1
    if state["ready"]:
        print("[fetch] 模型已就绪，无需下载")
        return 0
    try:
        for url, dest in items:
            if dest.is_file():
                continue
            _download(url, dest)
    except (OSError, ValueError) as exc:
        print(f"[fetch] 下载失败：{exc}\n"
              f"（不阻塞使用——HashingEmbedder 兜底始终可用；"
              f"网络恢复后重跑，或换 --onnx-url 源）")
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
