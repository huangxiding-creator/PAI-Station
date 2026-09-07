"""首扫编排（提案 T23→M2 落地）：扫描 → 镜像报告 → outbox 投递。

run_first_scan 全依赖注入（scanner 参数化于 watch_dirs）；生产装配
（config→ZhipuClient.deep→WeComChannel→Outbox）由调用方完成，
本模块只做编排与正文格式化——保证上帝时刻一条链路可测。
"""
from ..sense.mirror import MirrorScanner

_IGNORE = [".git", "node_modules", "*.tmp", "~$*", "__pycache__", ".venv"]


def run_first_scan(watch_dirs, deep_fn=None, channel=None, outbox=None,
                   n: int = 10) -> dict:
    scanner = MirrorScanner(watch_dirs=watch_dirs, deep_fn=deep_fn,
                            ignore_patterns=_IGNORE)
    report = scanner.report(n=n)
    if channel is not None and outbox is not None:
        delivery = outbox.push(channel, "首扫镜像报告", _body(report))
        report["delivery"] = delivery
    return report


def _body(report: dict) -> str:
    lines = []
    for i, s in enumerate(report["statements"], 1):
        lines.append(f"{i}. {s['text']}\n   依据：{s['evidence']}")
    meta = report.get("meta", {})
    lines.append(f"\n（首扫 {meta.get('files', '?')} 个文件 / "
                 f"{meta.get('dirs', '?')} 个目录，零输入·上帝时刻）")
    return "\n".join(lines)
