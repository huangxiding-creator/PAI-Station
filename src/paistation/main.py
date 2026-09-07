"""入口：装配各引擎、启动调度器。

M0 骨架阶段仅支持 `--check`（INI 配置校验）与 `--version`；
引擎装配随里程碑逐个接入（见附录 P 逐日计划）。
"""
import argparse
import os
import sys

from paistation import __version__, config

# 配置文件解析顺序：项目根 config/pai.ini，可用环境变量 PAI_INI 覆盖
DEFAULT_INI = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__)))), "config", "pai.ini")


def check(config_path: str) -> int:
    """全量校验（附录 C.4）：五类错误中文报错，非法即拒绝。"""
    try:
        config.load(config_path)
    except config.ConfigError as exc:
        print(f"[check] 配置非法：{exc}")
        return 1
    print(f"[check] OK config={config_path}")
    return 0


def check_llm(config_path: str) -> int:
    """锚点 0.3：fast/deep/vision 各一次真实调用，返回结构正确即过。"""
    try:
        cfg = config.load(config_path)
        key = config.resolve_api_key(cfg)
    except config.ConfigError as exc:
        print(f"[check-llm] {exc}")
        return 1
    from paistation.llm.zhipu_client import ZhipuClient
    client = ZhipuClient(
        key, [cfg["llm"]["fast_model"], cfg["llm"]["deep_model"]],
        vision_model=cfg["llm"]["vision_model"])
    results = []

    def run(name, fn):
        try:
            detail = fn()
            print(f"[check-llm] {name} ✓ {detail}")
            results.append(True)
        except Exception as exc:  # noqa: BLE001 - 通透测要的是"活着"，不是类型
            print(f"[check-llm] {name} ✗ {exc}")
            results.append(False)

    run("fast ", lambda: f"text={client.fast('请只回复两个字：正常')['text'][:20]!r}")
    run("deep ", lambda: f"chain={client.deep('1+1等于几？只回答数字')['chain']}")
    run("vision", lambda: f"json={_vision_probe(client)}")
    return 0 if all(results) and results else 1


def _vision_probe(client) -> str:
    """纯红色 64×64 PNG（stdlib 生成）打真视觉模型——图片必须有可描述内容。"""
    import struct
    import tempfile
    import zlib

    def chunk(tag: bytes, data: bytes) -> bytes:
        return (struct.pack(">I", len(data)) + tag + data
                + struct.pack(">I", zlib.crc32(tag + data) & 0xFFFFFFFF))

    ihdr = struct.pack(">IIBBBBB", 64, 64, 8, 2, 0, 0, 0)
    idat = zlib.compress((b"\x00" + b"\xff\x00\x00" * 64) * 64)
    png = (b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", ihdr)
           + chunk(b"IDAT", idat) + chunk(b"IEND", b""))
    with tempfile.NamedTemporaryFile(suffix=".png", delete=False) as fh:
        fh.write(png)
        path = fh.name
    try:
        return str(client.vision(path, schema={"主色": "图片的主色"})["json"])
    finally:
        os.unlink(path)


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(prog="paistation",
                                 description="PAI-Station 个人超级 AI 工作站")
    ap.add_argument("--check", action="store_true", help="校验配置文件后退出")
    ap.add_argument("--check-llm", action="store_true",
                    help="真实连通测试：fast/deep/vision 各一次（锚点 0.3）")
    ap.add_argument("--config", default=os.environ.get("PAI_INI", DEFAULT_INI),
                    help=f"INI 路径（默认 {DEFAULT_INI}，环境变量 PAI_INI 可覆盖）")
    ap.add_argument("--version", action="version",
                    version=f"paistation {__version__}")
    args = ap.parse_args(argv)
    if args.check:
        return check(args.config)
    if args.check_llm:
        return check_llm(args.config)
    ap.print_help()
    return 0


if __name__ == "__main__":
    sys.exit(main())
