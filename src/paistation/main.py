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


def first_scan(config_path: str, push: bool = True) -> int:
    """首扫镜像（锚点 1.x / T23 上帝时刻）：白名单只读扫描 + 企微投递。"""
    cfg = config.load(config_path)
    key = config.resolve_api_key(cfg)
    from paistation.channels.wecom import WeComChannel
    from paistation.llm.zhipu_client import ZhipuClient
    from paistation.proactive.first_scan import run_first_scan
    from paistation.proactive.outbox import Outbox

    client = ZhipuClient(
        key, [cfg["llm"]["fast_model"], cfg["llm"]["deep_model"]],
        vision_model=cfg["llm"]["vision_model"])
    channel = outbox = None
    if push:
        channel = WeComChannel(_wecom_webhook())
        outbox = Outbox(max_push_per_day=cfg["proactive"]["max_push_per_day"],
                        quiet_hours=cfg["proactive"]["quiet_hours"],
                        state_path=os.path.join(cfg["privacy"]["data_dir"],
                                                "outbox.json"))
    report = run_first_scan(watch_dirs=list(cfg["sense"]["watch_dirs"]),
                            deep_fn=client.deep, channel=channel, outbox=outbox)
    for i, s in enumerate(report["statements"], 1):
        print(f"[first-scan] {i}. {s['text']}")
        print(f"              依据：{s['evidence']}")
    if "delivery" in report:
        d = report["delivery"]
        print(f"[first-scan] 投递：{'✓ 已推送' if d.get('delivered') else d.get('reason')}")
    return 0


def gui(config_path: str) -> int:
    """托盘 GUI（提案 4.2 ui 四形态之常驻形态）：暂停感知/设置/退出。

    阻塞直至用户点退出；配置非法时先报错退出（不带病上托盘）。
    """
    try:
        config.load(config_path)
    except config.ConfigError as exc:
        print(f"[gui] 配置非法：{exc}")
        return 1
    from paistation.ui.tray import TrayApp
    app = TrayApp(config_dir=os.path.dirname(os.path.abspath(config_path)))
    try:
        app.run()
    except RuntimeError as exc:
        print(f"[gui] {exc}")
        return 1
    return 0


def _wecom_webhook() -> str:
    """企微 webhook：环境变量 PAI_WECOM_WEBHOOK 优先，其次 secret ini。"""
    import configparser
    hook = os.environ.get("PAI_WECOM_WEBHOOK", "")
    if hook:
        return hook
    parser = configparser.ConfigParser()
    parser.read(os.path.join(os.path.dirname(DEFAULT_INI), "wecom.secret.ini"),
                encoding="utf-8")
    return parser.get("wecom", "webhook", fallback="")


def serve(config_path: str, db: str | None = None, max_ticks: int | None = None,
          interval: float = 60.0, runtime_factory=None) -> int:
    """服务主循环（WinSW 守护）：Runtime 整机 + 心跳审计 + 干净退出。

    runtime_factory(cfg, audit=...) 注入（测试用假件）；None 时纯心跳
    （M0 兼容行为）。每拍心跳后过一次 daily_tick 复盘闸门（内部当日幂等）。
    """
    import signal
    import time

    from paistation.security.audit import AuditLog

    cfg = config.load(config_path)
    audit = AuditLog(db or os.path.join(cfg["privacy"]["data_dir"], "audit.db"))
    runtime = None
    if runtime_factory is not None:
        try:
            runtime = runtime_factory(cfg, audit=audit)
            runtime.start()
        except Exception as exc:  # noqa: BLE001 - 整机故障退回心跳保活
            print(f"[serve] runtime 启动失败，退回心跳模式：{exc}")
            runtime = None
    stopping = {"flag": False}

    def _stop(signum, frame):  # noqa: ARG001 - signal 签名固定
        stopping["flag"] = True

    signal.signal(signal.SIGINT, _stop)
    signal.signal(signal.SIGTERM, _stop)
    ticks = 0
    while not stopping["flag"] and (max_ticks is None or ticks < max_ticks):
        audit.record("heartbeat", module="serve", pid=os.getpid(), tick=ticks)
        if runtime is not None:
            try:
                runtime.daily_tick()
            except Exception as exc:  # noqa: BLE001 - 复盘故障不杀主循环
                print(f"[serve] daily_tick 异常（忽略）：{exc}")
        time.sleep(interval)
        ticks += 1
    if runtime is not None:
        runtime.stop()
    audit.record("serve.stop", module="serve", pid=os.getpid(), ticks=ticks)
    audit.close()
    return 0


def main(argv: list[str] | None = None) -> int:
    # GBK 控制台兜底：✓/✗ 等字符在中文 Windows 默认代码页下不可编码，
    # 服务/脚本场景（WinSW 日志、PowerShell）必须免疫（errors=replace）。
    for stream in (sys.stdout, sys.stderr):
        if hasattr(stream, "reconfigure"):
            stream.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser(prog="paistation",
                                 description="PAI-Station 个人超级 AI 工作站")
    ap.add_argument("--check", action="store_true", help="校验配置文件后退出")
    ap.add_argument("--check-llm", action="store_true",
                    help="真实连通测试：fast/deep/vision 各一次（锚点 0.3）")
    ap.add_argument("--doctor", action="store_true",
                    help="自检：配置/密钥/依赖/数据目录")
    ap.add_argument("--serve", action="store_true",
                    help="服务主循环（WinSW 守护，锚点 0.6）")
    ap.add_argument("--first-scan", action="store_true",
                    help="首扫镜像：白名单只读扫描生成 10 条陈述并投递企微")
    ap.add_argument("--gui", action="store_true",
                    help="启动系统托盘（暂停感知/设置/退出）")
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
        from paistation.runtime import Runtime
        return serve(args.config, runtime_factory=Runtime.from_config)
    if args.first_scan:
        return first_scan(args.config)
    if args.gui:
        return gui(args.config)
    ap.print_help()
    return 0


if __name__ == "__main__":
    sys.exit(main())
