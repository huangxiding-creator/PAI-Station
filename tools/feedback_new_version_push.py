# -*- coding: versatile-encoding
# -*- coding: utf-8 -*-
"""feedback_new_version_push — 报告优化后自动向反馈者邮箱发送新版 (1017 用户令).

当报告经用户反馈改进并重新部署后，运行本脚本：
  1. 读取所有留了邮箱的反馈者
  2. 向每个邮箱发送新版 PDF + 个性化改进说明
  3. 记录发送状态

用法: python tools/feedback_new_version_push.py --sku BID26-2026 \\
        --pdf report_platform/content/full/BID26-2026.pdf \\
        --improvements "修正第7章数据错误,新增行业指数" [--dry]
"""
from __future__ import annotations

import argparse
import json
import smtplib
import time
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.application import MIMEApplication
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
FEEDBACK_DIR = REPO / "data" / "feedback"


def get_feedback_emails(sku: str) -> list[dict]:
    """读取该SKU所有留了邮箱的反馈者."""
    emails_file = FEEDBACK_DIR / "emails.jsonl"
    if not emails_file.exists():
        return []
    out = []
    for ln in emails_file.open(encoding="utf-8"):
        if not ln.strip():
            continue
        try:
            r = json.loads(ln)
        except json.JSONDecodeError:
            continue
        if r.get("sku") == sku and r.get("email"):
            out.append(r)
    return out


def get_feedback_details(sku: str) -> list[dict]:
    """读取该SKU的反馈详情（用于个性化改进说明）."""
    details = []
    for fp in FEEDBACK_DIR.glob(f"{sku}_*.json"):
        try:
            d = json.loads(fp.read_text(encoding="utf-8"))
            details.append(d)
        except (json.JSONDecodeError, OSError):
            continue
    return details


def build_email(report_title: str, feedback: dict, improvements: str,
                pdf_path: Path) -> MIMEMultipart:
    """构建个性化新版推送邮件."""
    score = feedback.get("scores", {}).get("total_score", 0)
    transcript_head = feedback.get("transcript", "")[:80]

    msg = MIMEMultipart()
    msg["Subject"] = f"【免费新版】{report_title}已根据您的反馈优化完成"
    msg["From"] = "总包智库 <noreply@epcschool.top>"
    msg["To"] = feedback["email"]

    body = f"""尊敬的读者：

感谢您的宝贵反馈（评分：{score}分）。

您当时的反馈：「{transcript_head}...」

基于您和多位读者的反馈，我们已经完成以下优化：

{improvements}

新版报告已附上（PDF），您可以免费下载阅读。

您的退款已按评分比例处理。

如果您对新版仍有意见，欢迎继续提交建议。

祝工作顺利！

—— 总包智库 产线团队
（本邮件由系统自动发送，报告优化后触发）"""

    msg.attach(MIMEText(body, "plain", "utf-8"))

    # 附上 PDF
    if pdf_path.exists():
        with open(pdf_path, "rb") as f:
            pdf_attachment = MIMEApplication(f.read(), _subtype="pdf")
            pdf_attachment.add_header(
                "Content-Disposition", "attachment",
                filename=pdf_path.name)
            msg.attach(pdf_attachment)

    return msg


def send_email(msg: MIMEMultipart, smtp_host: str, smtp_port: int,
                smtp_user: str, smtp_pass: str) -> bool:
    """通过SMTP发送邮件."""
    try:
        with smtplib.SMTP(smtp_host, smtp_port) as server:
            server.starttls()
            server.login(smtp_user, smtp_pass)
            server.send_message(msg)
            return True
    except Exception as e:
        print(f"  发送失败: {e}")
        return False


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--sku", required=True)
    ap.add_argument("--pdf", required=True)
    ap.add_argument("--improvements", required=True)
    ap.add_argument("--dry", action="store_true")
    ap.add_argument("--smtp-host", default="smtp.qq.com")
    ap.add_argument("--smtp-port", type=int, default=587)
    ap.add_argument("--smtp-user", default="")
    ap.add_argument("--smtp-pass", default="")
    ns = ap.parse_args()

    pdf_path = Path(ns.pdf)
    if not pdf_path.exists():
        print(f"[push] PDF不存在: {pdf_path}")
        return

    # 获取该报告标题
    import json as j
    rj = REPO / "report_platform" / "content" / "report.json"
    title = ns.sku
    if rj.exists():
        reports = j.loads(rj.read_text(encoding="utf-8"))["reports"]
        for r in reports:
            if r.get("sku") == ns.sku:
                title = r.get("title", ns.sku)
                break

    emails = get_feedback_emails(ns.sku)
    print(f"[push] {ns.sku}: {len(emails)} 个反馈者留了邮箱")

    if ns.dry:
        for e in emails:
            print(f"  [dry] → {e['email']}")
        return

    if not ns.smtp_user or not ns.smtp_pass:
        print("[push] 缺少SMTP凭证（--smtp-user/--smtp-pass），无法发送")
        return

    sent = 0
    for feedback in emails:
        msg = build_email(title, feedback, ns.improvements, pdf_path)
        if send_email(msg, ns.smtp_host, ns.smtp_port,
                       ns.smtp_user, ns.smtp_pass):
            sent += 1
            print(f"  ✅ → {feedback['email']}")
        time.sleep(1)  # 避免被SMTP服务商限流

    # 记录发送状态
    log = FEEDBACK_DIR / f"push_log_{ns.sku}.jsonl"
    entry = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
             "sku": ns.sku, "sent": sent, "total": len(emails)}
    with log.open("a", encoding="utf-8") as f:
        f.write(json.dumps(entry, ensure_ascii=False) + "\n")
    print(f"[push] 完成: {sent}/{len(emails)}")


if __name__ == "__main__":
    main()
