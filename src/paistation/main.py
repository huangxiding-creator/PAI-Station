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


def doctor(config_path: str, secret_ini: str | None = None,
           data_dir: str | None = None) -> list[tuple[str, bool]]:
    """自修复自检（借 OpenClaw doctor 设计）：配置/密钥/依赖/数据目录。"""
    results: list[tuple[str, bool]] = []
    try:
        cfg = config.load(config_path)
        results.append(("配置校验", True))
    except config.ConfigError as exc:
        results.append((f"配置校验（{exc}）", False))
        return results
    try:
        config.resolve_api_key(cfg, secret_ini=secret_ini)
        results.append(("智谱密钥", True))
    except config.ConfigError:
        results.append(("智谱密钥（缺 PAI_LLM_KEY/llm.secret.ini）", False))
    try:
        import apscheduler  # noqa: F401
        import tenacity  # noqa: F401
        import watchdog  # noqa: F401
        results.append(("核心依赖", True))
    except ImportError:
        results.append(("核心依赖", False))
    target = data_dir or cfg["privacy"]["data_dir"]
    try:
        os.makedirs(target, exist_ok=True)
        probe = os.path.join(target, ".doctor_probe")
        with open(probe, "w", encoding="utf-8") as fh:
            fh.write("ok")
        os.remove(probe)
        results.append(("数据目录可写", True))
    except OSError:
        results.append(("数据目录可写", False))
    return results


def serve(config_path: str, db: str | None = None, max_ticks: int | None = None,
          interval: float = 60.0) -> int:
    """服务主循环（WinSW 守护）：心跳审计 + Ctrl+C/SIGTERM 干净退出。

    M0：心跳空转占位；M1 起逐里程碑接入 watcher/调度器。
    """
    import signal
    import time

    from paistation.security.audit import AuditLog

    cfg = config.load(config_path)
    audit = AuditLog(db or os.path.join(cfg["privacy"]["data_dir"], "audit.db"))
    stopping = {"flag": False}

    def _stop(signum, frame):  # noqa: ARG001 - signal 签名固定
        stopping["flag"] = True

    signal.signal(signal.SIGINT, _stop)
    signal.signal(signal.SIGTERM, _stop)
    ticks = 0
    while not stopping["flag"] and (max_ticks is None or ticks < max_ticks):
        audit.record("heartbeat", module="serve", pid=os.getpid(), tick=ticks)
        time.sleep(interval)
        ticks += 1
    audit.record("serve.stop", module="serve", pid=os.getpid(), ticks=ticks)
    audit.close()
    return 0


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(prog="paistation",
                                 description="PAI-Station 个人超级 AI 工作站")
    ap.add_argument("--check", action="store_true", help="校验配置文件后退出")
    ap.add_argument("--check-llm", action="store_true",
                    help="真实连通测试：fast/deep/vision 各一次（锚点 0.3）")
    ap.add_argument("--doctor", action="store_true",
                    help="自检：配置/密钥/依赖/数据目录")
    ap.add_argument("--serve", action="store_true",
                    help="服务主循环（WinSW 守护，锚点 0.6）")
    ap.add_argument("--config", default=os.environ.get("PAI_INI", DEFAULT_INI),
                    help=f"INI 路径（默认 {DEFAULT_INI}，环境变量 PAI_INI 可覆盖）")
    ap.add_argument("--version", action="version",
                    version=f"paistation {__version__}")
    args = ap.parse_args(argv)
    if args.check:
        return check(args.config)
    if args.check_llm:
        return check_llm(args.config)
    if args.doctor:
        results = doctor(args.config)
        for name, ok in results:
            print(f"[doctor] {'✓' if ok else '✗'} {name}")
        return 0 if all(ok for _, ok in results) else 1
    if args.serve:
        return serve(args.config)
    ap.print_help()
    return 0


if __name__ == "__main__":
    sys.exit(main())
