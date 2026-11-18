# -*- coding: utf-8 -*-
"""W3 邮箱自动交付：KB购买后把百度网盘分享链接发到用户邮箱。

用法:
  py -X utf8 tools/kb_email_delivery.py --email user@example.com \
      --sku KB-SUBCON-2026 --link "https://pan.baidu.com/s/xxx" --code "ab12" \
      [--name KB名称] [--desc 描述] [--files 174] [--size 0.7GB] \
      [--package package.json路径] [--validity 有效说明] [--from-addr noreply@zcby.ai] \
      [--dry-run] [--check]

行为:
  - SMTP 读 E:/AI-Station/data/secrets/smtp.secret，支持三种格式:
      1) 单行管道格式: host|port|user|pass       (任务规范格式)
      2) key=value 行: smtp_host=... smtp_port=... smtp_user=... smtp_pass=...
      3) INI [smtp] 节: host= / port= / user= / password=   (kb_factory/deliver.py 兼容)
  - smtp.secret 不存在 → 写模板文件 + 提示配置 → exit 2
  - 保留测试域(example.com 等 RFC2606)自动转 dry-run，绝不真发（防退信事故，同 deliver.py 护栏）
  - 失败重试 3 次（退避 5s/10s），日志落 E:/AI-Station/data/logs/kb_delivery.jsonl
  - 凭据只读不打印；日志不含密码。

退出码: 0=成功(或dry-run) 2=SMTP未配置 3=重试后仍失败 4=参数非法
"""
import argparse
import json
import smtplib
import ssl
import sys
import time
from datetime import datetime, timezone
from email.header import Header
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.utils import formataddr
from pathlib import Path

REPO = Path("E:/AI-Station")
SMTP_SECRET = REPO / "data" / "secrets" / "smtp.secret"
LOG_JSONL = REPO / "data" / "logs" / "kb_delivery.jsonl"

SENDER_NAME = "总包创研院"
DEFAULT_FROM_ADDR = "noreply@zcby.ai"
RETRY_TIMES = 3
RETRY_BACKOFF_S = (5, 10)
SMTP_TIMEOUT_S = 30

# 保留测试域（RFC 2606/6761 子集）——deliver 层硬护栏，防真发退信
_RESERVED_DOMAINS = frozenset({
    "example.com", "example.org", "example.net", "test.com", "test",
    "invalid", "localhost", "example@qq.com",
})

# 常用SKU元数据兜底（--package 优先）
SKU_META = {
    "KB-SUBCON-2026": {
        "name": "EPC分包界面知识库",
        "desc": "《EPC分包与界面管理研究报告》全链调研弹药：判决年卷按分包界面族切片23卷+跨池收割+行业库，2.34亿字原始语料。",
        "files": "174件（切片23卷+跨池+行业库）",
        "size": "0.7GB",
    },
}


# ---------------------------------------------------------------- SMTP 配置
def load_smtp_config(path: Path = SMTP_SECRET) -> dict | None:
    """读 SMTP 配置；缺失/残缺/模板占位 → None。绝不打印凭据。"""
    if not path.is_file():
        return None
    try:
        text = path.read_text(encoding="utf-8-sig").strip()
    except OSError:
        return None
    if not text:
        return None

    cfg = None
    # 格式1: 单行 host|port|user|pass
    line1 = text.splitlines()[0].strip()
    if line1 and "|" in line1 and "=" not in line1.split("|")[0]:
        parts = [p.strip() for p in line1.split("|")]
        if len(parts) >= 4:
            cfg = {"host": parts[0], "port": parts[1], "user": parts[2],
                   "password": parts[3], "sender": parts[2]}
    # 格式2: key=value 行
    if cfg is None and "=" in text:
        kv = {}
        for ln in text.splitlines():
            ln = ln.strip()
            if ln and not ln.startswith("#") and "=" in ln:
                k, _, v = ln.partition("=")
                kv[k.strip().lower()] = v.strip()
        if kv.get("smtp_host") or kv.get("host"):
            cfg = {
                "host": kv.get("smtp_host") or kv.get("host"),
                "port": kv.get("smtp_port") or kv.get("port") or "465",
                "user": kv.get("smtp_user") or kv.get("user"),
                "password": kv.get("smtp_pass") or kv.get("password") or kv.get("pass"),
                "sender": kv.get("smtp_sender") or kv.get("sender")
                          or kv.get("smtp_user") or kv.get("user"),
            }
    # 格式3: INI [smtp]
    if cfg is None and text.startswith("["):
        import configparser
        cp = configparser.ConfigParser()
        cp.read(path, encoding="utf-8-sig")
        sec = cp["smtp"] if cp.has_section("smtp") else None
        if sec:
            cfg = {"host": sec.get("host"), "port": sec.get("port", "465"),
                   "user": sec.get("user"), "password": sec.get("password"),
                   "sender": sec.get("sender", sec.get("user", ""))}
    if not cfg:
        return None

    # 模板占位/非法值 → 视为未配置
    host = (cfg.get("host") or "").lower()
    pwd = cfg.get("password") or ""
    if (not cfg.get("host") or not cfg.get("user") or not pwd
            or "change_me" in pwd.lower() or "your-password" in pwd.lower()
            or host.endswith("example.com") or host == "smtp.example.com"):
        return None
    try:
        cfg["port"] = int(cfg["port"])
    except (TypeError, ValueError):
        cfg["port"] = 465
    return cfg


def ensure_smtp_template(path: Path = SMTP_SECRET) -> bool:
    """smtp.secret 不存在 → 写模板（管道格式，任务规范）。返回是否新建。"""
    if path.exists():
        return False
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(
        "smtp.example.com|465|noreply@zcby.ai|CHANGE_ME\n",
        encoding="utf-8",
    )
    return True


# ---------------------------------------------------------------- 邮件渲染
def build_html(kb: dict, link: str, code: str, validity: str) -> str:
    rows = [
        ("知识库", kb["name"]),
        ("内容规模", f"{kb.get('files', '—')} / 约{kb.get('size', '—')}"),
    ]
    trs = "".join(
        f'<tr><td class="k">{k}</td><td class="v">{v}</td></tr>' for k, v in rows
    )
    return f"""<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1"></head>
<body style="margin:0;padding:24px;background:#f4f6f9;font-family:'Microsoft YaHei',Arial,sans-serif;color:#1f2937;">
<div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:12px;overflow:hidden;border:1px solid #e5e7eb;">
  <div style="background:#1d4ed8;padding:20px 28px;">
    <div style="color:#ffffff;font-size:18px;font-weight:bold;">总包创研院 · 知识库交付</div>
    <div style="color:#bfdbfe;font-size:12px;margin-top:4px;">ZONGBAO CREATIVE RESEARCH INSTITUTE</div>
  </div>
  <div style="padding:28px;">
    <p style="font-size:15px;line-height:1.8;">您好，您购买的 <b>{kb['name']}</b> 已完成交付，请查收下方百度网盘下载信息：</p>
    <table style="width:100%;border-collapse:collapse;font-size:14px;margin:16px 0;">{trs}</table>
    <div style="background:#eff6ff;border:1px solid #bfdbfe;border-radius:10px;padding:18px 20px;margin:16px 0;">
      <div style="font-size:13px;color:#1e40af;margin-bottom:6px;">下载链接（点击直接打开）</div>
      <div style="font-size:14px;word-break:break-all;"><a href="{link}" style="color:#1d4ed8;">{link}</a></div>
      <div style="font-size:13px;color:#1e40af;margin:14px 0 6px;">提取码</div>
      <div style="font-size:22px;font-weight:bold;letter-spacing:4px;color:#1d4ed8;">{code}</div>
    </div>
    <p style="font-size:13px;color:#6b7280;line-height:1.8;">有效说明：{validity}</p>
    <div style="border-top:1px solid #e5e7eb;margin-top:20px;padding-top:16px;font-size:12px;color:#9ca3af;line-height:1.8;">
      知识库简介：{kb.get('desc', '—')}<br>
      本邮件由总包创研院知识库交付系统自动发送，请勿直接回复；如有问题请通过购买渠道联系客服。
    </div>
  </div>
</div>
</body></html>"""


def build_message(cfg: dict, to_addr: str, kb: dict, link: str, code: str,
                  validity: str, from_addr: str) -> MIMEMultipart:
    msg = MIMEMultipart("alternative")
    subject = f"【知识库交付】{kb['name']} - 百度网盘下载链接"
    msg["Subject"] = Header(subject, "utf-8")
    msg["From"] = formataddr((str(Header(SENDER_NAME, "utf-8")), from_addr))
    msg["To"] = to_addr
    html = build_html(kb, link, code, validity)
    msg.attach(MIMEText(html, "html", "utf-8"))
    msg.attach(MIMEText(
        f"【知识库交付】{kb['name']}\n\n下载链接: {link}\n提取码: {code}\n"
        f"内容规模: {kb.get('files', '—')} / 约{kb.get('size', '—')}\n"
        f"有效说明: {validity}\n\n总包创研院", "plain", "utf-8"))
    return msg


# ---------------------------------------------------------------- 日志
def log_event(rec: dict, path: Path = LOG_JSONL) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    rec["ts"] = datetime.now(timezone.utc).astimezone().isoformat(timespec="seconds")
    with path.open("a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")


# ---------------------------------------------------------------- 发送
def is_test_domain(email: str) -> bool:
    dom = email.rsplit("@", 1)[-1].lower()
    return dom in _RESERVED_DOMAINS or email.lower() in _RESERVED_DOMAINS


def send_with_retry(cfg: dict, to_addr: str, msg: MIMEMultipart) -> tuple[bool, int, str]:
    """SMTP_SSL(465)/STARTTLS(587) 自适应；重试 RETRY_TIMES 次。返回(ok, attempts, detail)。"""
    last_err = ""
    for attempt in range(1, RETRY_TIMES + 1):
        try:
            ctx = ssl.create_default_context()
            if cfg["port"] == 465:
                srv = smtplib.SMTP_SSL(cfg["host"], cfg["port"], timeout=SMTP_TIMEOUT_S, context=ctx)
            else:
                srv = smtplib.SMTP(cfg["host"], cfg["port"], timeout=SMTP_TIMEOUT_S)
                srv.starttls(context=ctx)
            with srv:
                srv.login(cfg["user"], cfg["password"])
                srv.send_message(msg, from_addr=cfg["user"], to_addrs=[to_addr])
            return True, attempt, ""
        except Exception as e:  # noqa: BLE001 重试任意SMTP异常
            last_err = f"{type(e).__name__}: {e}"
            if attempt < RETRY_TIMES:
                time.sleep(RETRY_BACKOFF_S[min(attempt - 1, len(RETRY_BACKOFF_S) - 1)])
    return False, RETRY_TIMES, last_err


# ---------------------------------------------------------------- CLI
def load_kb_meta(args) -> dict:
    kb = dict(SKU_META.get(args.sku, {"name": args.sku, "desc": "", "files": "", "size": ""}))
    if args.package:
        p = Path(args.package)
        if not p.is_file():
            sys.exit(f"[exit4] package 不存在: {p}")
        pkg = json.loads(p.read_text(encoding="utf-8-sig"))
        kb["name"] = pkg.get("name") or kb["name"]
        kb["desc"] = pkg.get("description") or pkg.get("desc") or kb.get("desc", "")
        if pkg.get("file_count") is not None:
            kb["files"] = f"{pkg['file_count']}件"
        if pkg.get("size_gb") is not None:
            kb["size"] = f"{pkg['size_gb']}GB"
    for arg_key, kb_key in (("name", "name"), ("desc", "desc"), ("files", "files"), ("size", "size")):
        v = getattr(args, arg_key)
        if v:
            kb[kb_key] = v
    if not kb.get("name"):
        sys.exit("[exit4] 缺少KB名称: --name 或 --package 或内置SKU表")
    return kb


def main() -> int:
    ap = argparse.ArgumentParser(description="KB邮箱自动交付（百度网盘链接）")
    ap.add_argument("--email", help="收件邮箱")
    ap.add_argument("--sku", help="知识库SKU, 如 KB-SUBCON-2026")
    ap.add_argument("--link", help="百度网盘分享链接")
    ap.add_argument("--code", help="提取码")
    ap.add_argument("--name", help="KB名称（覆盖）")
    ap.add_argument("--desc", help="KB描述（覆盖）")
    ap.add_argument("--files", help="文件数（覆盖）")
    ap.add_argument("--size", help="大小（覆盖, 如 0.7GB）")
    ap.add_argument("--validity", default="链接长期有效；建议收到后尽快登录百度网盘转存至自己的网盘，避免分享失效。")
    ap.add_argument("--package", help="package.json 路径（名称/描述/件数/大小 自动读取）")
    ap.add_argument("--from-addr", default=DEFAULT_FROM_ADDR, help=f"发件地址, 默认 {DEFAULT_FROM_ADDR}")
    ap.add_argument("--secret", default=str(SMTP_SECRET), help="SMTP secret 路径")
    ap.add_argument("--dry-run", action="store_true", help="只渲染+记日志, 不真发")
    ap.add_argument("--check", action="store_true", help="只检查SMTP配置状态")
    args = ap.parse_args()

    if args.check:
        cfg = load_smtp_config(Path(args.secret))
        if cfg:
            print(f"[smtp] 已配置: {cfg['host']}:{cfg['port']} user={cfg['user'][:3]}*** sender={cfg.get('sender', '')}")
        else:
            print("[smtp] 未配置或为模板占位")
        return 0

    for req in ("email", "sku", "link", "code"):
        if not getattr(args, req):
            ap.error(f"--{req} 必填")

    secret_path = Path(args.secret)
    template_created = ensure_smtp_template(secret_path)
    cfg = load_smtp_config(secret_path)

    kb = load_kb_meta(args)
    subject = f"【知识库交付】{kb['name']} - 百度网盘下载链接"
    test_domain = is_test_domain(args.email)
    dry = args.dry_run or test_domain

    base = {"email": args.email, "sku": args.sku, "subject": subject,
            "link": args.link, "kb_name": kb["name"]}

    if template_created and not cfg:
        print(f"[W3] smtp.secret 不存在，已创建模板: {secret_path}")
        print("[W3] 请按格式 host|port|user|pass 填写真实SMTP凭据后重试")
        log_event({**base, "ok": False, "mode": "smtp_not_configured",
                   "error": "template_created", "attempts": 0})
        return 2
    if not cfg:
        print(f"[W3] {secret_path} 存在但配置无效（占位/残缺），请填写 host|port|user|pass")
        log_event({**base, "ok": False, "mode": "smtp_invalid", "attempts": 0})
        return 2
    if test_domain:
        print(f"[W3] 收件域为保留测试域({args.email.rsplit('@',1)[-1]})，自动转 dry-run 防真发退信")

    if dry:
        msg = build_message(cfg, args.email, kb, args.link, args.code, args.validity, args.from_addr)
        log_event({**base, "ok": True, "mode": "dry_run", "attempts": 0})
        print(f"[W3][dry-run] 已渲染邮件: {subject}")
        print(f"[W3][dry-run] 收件: {args.email} | 链接: {args.link} | 提取码: {args.code}")
        return 0

    msg = build_message(cfg, args.email, kb, args.link, args.code, args.validity, args.from_addr)
    ok, attempts, err = send_with_retry(cfg, args.email, msg)
    log_event({**base, "ok": ok, "mode": "smtp", "attempts": attempts, "error": err or None})
    if ok:
        print(f"[W3] 交付邮件已发送: {args.email} <- {subject} (attempts={attempts})")
        return 0
    print(f"[W3] 发送失败({attempts}次): {err}")
    return 3


if __name__ == "__main__":
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")
    sys.exit(main())
