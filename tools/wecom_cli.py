"""企微 CLI（自建）：官方/社区均无现成包（2026-09-13 探测），封装
paistation.channels.wecom.WeComChannel webhook 通道。

用法：
  wecom send --title "标题" --body "正文"        # 正文缺省读 stdin
  wecom test                                     # 发预设测试消息
  wecom send --webhook <url> ...                 # 显式指定

webhook 是 secret，绝不硬编码/不进 repo。三来源（优先级递减）：
  --webhook 参数 > $WECOM_WEBHOOK > ~/.wecom_webhook（一行文件）

退出码：0 成功；1 发送失败（errcode!=0/网络异常）；2 webhook 未配置。
"""
from __future__ import annotations

import argparse
import os
import sys
from pathlib import Path

from paistation.channels.wecom import WeComChannel

_HOME_FILE = ".wecom_webhook"


def _resolve_webhook(args_webhook: str | None) -> str | None:
    if args_webhook:
        return args_webhook.strip()
    env = os.environ.get("WECOM_WEBHOOK", "").strip()
    if env:
        return env
    path = Path.home() / _HOME_FILE
    if path.is_file():
        line = path.read_text(encoding="utf-8").strip()
        if line:
            return line
    return None


def _build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(prog="wecom",
                                description="企业微信消息 CLI（webhook 通道，自建）")
    sub = p.add_subparsers(dest="cmd", required=True)
    s = sub.add_parser("send", help="发送 markdown 消息")
    s.add_argument("--webhook", help="webhook URL（缺省取 $WECOM_WEBHOOK 或 ~/.wecom_webhook）")
    s.add_argument("--title", required=True, help="消息标题")
    s.add_argument("--body", default=None,
                   help="消息正文（缺省读 stdin）")
    t = sub.add_parser("test", help="发送预设测试消息")
    t.add_argument("--webhook", help="同 send")
    return p


def main(argv: list[str] | None = None, opener=None) -> int:
    for stream in (sys.stdout, sys.stderr):
        try:  # GBK 控制台兜底：不让中文炸掉输出
            stream.reconfigure(errors="replace")
        except (AttributeError, ValueError):
            pass
    args = _build_parser().parse_args(argv)
    webhook = _resolve_webhook(args.webhook)
    if not webhook:
        print("错误：未配置 webhook。三选一：\n"
              "  1) --webhook 'https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=…'\n"
              "  2) set WECOM_WEBHOOK=<url>\n"
              "  3) echo <url> > %USERPROFILE%\\.wecom_webhook",
              file=sys.stderr)
        return 2
    try:
        ch = WeComChannel(webhook, _opener=opener)
    except ValueError as exc:
        print(f"错误：{exc}", file=sys.stderr)
        return 2

    if args.cmd == "test":
        result = ch.send("wecom CLI 测试消息", "通道正常 ✓（自建 CLI）")
    else:
        body = args.body if args.body is not None else sys.stdin.read()
        result = ch.send(args.title, body)
    if result["ok"]:
        print("已发送 ✓")
        return 0
    print(f"发送失败：errcode={result['errcode']} {result['errmsg']}",
          file=sys.stderr)
    return 1


if __name__ == "__main__":
    sys.exit(main())
