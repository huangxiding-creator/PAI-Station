# -*- coding: utf-8 -*-
"""W7 投递接口：SMTP 发件 + 缺配降级企微通知（绝不因缺配置崩）。

- SMTP 配置读 E:\\AI-Station\\07 任务\\自动建库Agent\\_credentials\\smtp.secret.ini
  （仓库根相对解析；env KB_SMTP_SECRET 可覆盖）。读不到→降级：
  包留 outbox + 调 py -X utf8 tools/notify_approval_wecom.py "KB交付待发"
  "<订单号|邮箱|包路径>" 通知人工发。凭据只读、绝不打印内容。
- 包 >50MB 只发网盘占位说明（v1：企微人工转存百度网盘后回填链接）。
"""
import configparser
import os
import smtplib
import subprocess
from dataclasses import dataclass
from email.mime.multipart import MIMEMultipart
from email.mime.application import MIMEApplication
from email.mime.text import MIMEText
from email.utils import formataddr
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
SMTP_SECRET_DEFAULT = REPO_ROOT / "07 任务" / "自动建库Agent" / "_credentials" / "smtp.secret.ini"
WECOM_NOTIFY_SCRIPT = REPO_ROOT / "tools" / "notify_approval_wecom.py"
ATTACH_LIMIT = 50 * 1024 * 1024   # 邮箱附件上限 50MB
SENDER_NAME = "总包智库知识库交付"


@dataclass
class DeliveryResult:
    mode: str        # email | netdisk_pending | wecom_fallback | smtp_error_fallback
    detail: str
    ok: bool = True


def load_smtp_config(path=None) -> dict | None:
    """读 SMTP ini；读不到/解析失败→None（降级）。凭据只读，绝不打印。"""
    try:
        return _load_smtp_config(path)
    except Exception:  # 配置残缺/端口非法等一律视为缺配→降级，绝不崩
        return None


def _load_smtp_config(path=None) -> dict | None:
    p = Path(path) if path else Path(os.environ.get("KB_SMTP_SECRET", "") or SMTP_SECRET_DEFAULT)
    if not p.is_file():
        return None
    cp = configparser.ConfigParser()
    try:
        cp.read(p, encoding="utf-8")
    except (OSError, ValueError):
        return None
    sec = cp["smtp"] if cp.has_section("smtp") else (cp.defaults() if cp.defaults() else None)
    if sec is None:
        return None
    def pick(*keys):
        for k in keys:
            if k in sec and str(sec[k]).strip():
                return str(sec[k]).strip()
        return None
    cfg = {"host": pick("host", "server"), "port": int(pick("port") or 465),
           "user": pick("user", "from", "account"),
           "password": pick("password", "pass", "pwd"),
           "sender": pick("sender", "from_addr", "user"),
           "ssl": pick("ssl", "tls") not in ("0", "false", "no")}
    if not (cfg["host"] and cfg["user"] and cfg["password"]):
        return None
    return cfg


def _wecom_notify(title: str, text: str, cmd: list | None = None) -> bool:
    """企微通知腿：py -X utf8 tools/notify_approval_wecom.py <title> <text>。

    env KB_WECOM_NOTIFY=0 时静默跳过（冒烟/CI 用，避免假订单触发真通知）。
    """
    if str(os.environ.get("KB_WECOM_NOTIFY", "1")).strip() == "0":
        return False
    command = cmd or ["py", "-X", "utf8", str(WECOM_NOTIFY_SCRIPT), title, text]
    try:
        r = subprocess.run(command, capture_output=True, timeout=120)
        return r.returncode == 0
    except (OSError, subprocess.SubprocessError):
        return False


def send_email(cfg: dict, to: str, subject: str, body: str,
               attachment: Path | None = None) -> bool:
    """真发件腿（smtplib，SSL 优先）。失败返回 False，不抛出。"""
    msg = MIMEMultipart()
    msg["Subject"] = subject
    msg["From"] = formataddr((SENDER_NAME, cfg.get("sender") or cfg["user"]))
    msg["To"] = to
    msg.attach(MIMEText(body, "plain", "utf-8"))
    try:
        if attachment is not None:
            with open(attachment, "rb") as f:
                part = MIMEApplication(f.read())
            part.add_header("Content-Disposition", "attachment",
                            filename=attachment.name)
            msg.attach(part)
        cls = smtplib.SMTP_SSL if cfg.get("ssl", True) else smtplib.SMTP
        with cls(cfg["host"], cfg["port"], timeout=60) as s:
            s.login(cfg["user"], cfg["password"])
            s.send_message(msg)
        return True
    except (OSError, smtplib.SMTPException):
        return False


def deliver(order, zip_path, *, cfg: dict | None = None,
            smtp_secret=None, notify=None) -> DeliveryResult:
    """投递主链：配置缺→企微降级；>50MB→网盘占位；正常→附件发件。绝不抛出。"""
    if notify is None:  # 调用时解析，便于测试打桩
        notify = _wecom_notify
    zp = Path(zip_path)
    if cfg is None:
        cfg = load_smtp_config(smtp_secret)
    if cfg is None:
        text = f"{order.id}|{order.email}|{zp}"
        notified = notify("KB交付待发", text)
        return DeliveryResult(
            "wecom_fallback",
            f"smtp.secret.ini 未配置→包留 outbox 待人工发；企微通知{'已发' if notified else '未发出(需人工检查/发送)'}：{text}",
            ok=notified)

    size = zp.stat().st_size if zp.is_file() else 0
    if size > ATTACH_LIMIT:
        body = (f"您的知识库交付包已生成（{size / 1048576:.1f}MB，超邮箱附件 50MB 上限）。\n"
                f"网盘链接生成后将另行发送；订单号 {order.id}。\n"
                f"（占位说明：大包走网盘通道，链接待回填）")
        sent = send_email(cfg, order.email, f"【知识库交付·网盘】{order.id}", body)
        notify("KB大包待转网盘", f"{order.id}|{order.email}|{zp}|{size // 1048576}MB|人工转存百度网盘后回填链接")
        return DeliveryResult("netdisk_pending",
                              f"包 {size // 1048576}MB>50MB→只发网盘占位说明；邮件{'已发' if sent else '发送失败'}；待企微人工转存百度网盘回填链接",
                              ok=sent)

    body = (f"您好，您的知识库交付包见附件。\n订单号：{order.id}\n"
            f"包内含：知识库目录树、每目录 _INDEX.md、manifest.json、获取指引清单、使用与来源说明。\n"
            f"总包智库研究团队")
    if send_email(cfg, order.email, f"【知识库交付】{order.id}", body, attachment=zp):
        return DeliveryResult("email", f"附件已发至 {order.email}（{size // 1024}KB）")
    # SMTP 在位但发信失败：降级企微，包留 outbox
    text = f"{order.id}|{order.email}|{zp}"
    notified = notify("KB交付待发", text)
    return DeliveryResult("smtp_error_fallback",
                          f"SMTP 发信失败→包留 outbox；企微通知{'已发' if notified else '发送失败'}：{text}",
                          ok=False)
