# -*- coding: utf-8 -*-
"""voice_feedback — 语音反馈+六维评分+按质退款 API (1017 用户令).

买家在小程序报告阅读页语音反馈 → AI 六维评分 → 退款=评分% → 邮箱收集 → 新版推送.
"""
from __future__ import annotations

import json
import time
from pathlib import Path
from typing import Optional

from fastapi import APIRouter, Request
from pydantic import BaseModel

from . import config, store, wechat

router = APIRouter()

FEEDBACK_DIR = Path(config.DATA_DIR) / "feedback"
SCORE_PROMPT = """你是研究报告质量评审专家。请对以下买家反馈进行六维评分。

评分维度（各维度满分不同，总分100）：
1. 真实性（15分）：反馈是否基于实际阅读，是否引用了具体页码/章节/数据
2. 针对性（15分）：是否指出了具体章节/段落的问题，位置是否精确
3. 专业性（15分）：是否使用了行业术语/法律条文/技术标准
4. 证据支持（15分）：是否引用了外部数据/法规/判例来支持观点
5. 可操作性（20分）：是否提出了具体可执行的改进建议
6. 改进价值（20分）：反馈被采纳后对报告质量的提升程度

报告标题：{report_title}
买家反馈：{transcript}

请输出严格JSON（无其他文本）：
{{"authenticity": 0-15, "specificity": 0-15, "professionalism": 0-15,
"evidence_support": 0-15, "actionability": 0-20, "improvement_value": 0-20,
"total_score": 0-100, "refund_percentage": 0-100,
"scoring_rationale": "每维度一句话理由",
"improvement_suggestion": "基于反馈的具体改进建议",
"feedback_category": "data_error|content_gap|depth_insufficient|actionability|dissatisfaction"}}"""


class VoiceFeedbackRequest(BaseModel):
    sku: str
    transcript: str  # 语音转文字结果
    openid: str
    order_id: Optional[str] = None


@router.post("/api/report/{sku}/voice_feedback")
async def submit_voice_feedback(sku: str, req: Request):
    """接收语音反馈 → AI六维评分 → 返回评分+退款比例."""
    body = await req.json()
    transcript = str(body.get("transcript", "")).strip()
    openid = str(body.get("openid", ""))
    order_id = body.get("order_id")

    if len(transcript) < 20:
        return {"ok": False, "error": "反馈内容过短（至少20字）"}

    # 获取报告标题
    report = store.get_report_meta(sku)
    title = report.get("title", sku) if report else sku

    # 六维评分（调用智谱GLM）
    scores = await _score_with_llm(title, transcript)
    if not scores:
        return {"ok": False, "error": "评分服务暂时不可用，请稍后重试"}

    # 计算退款
    refund_pct = scores.get("refund_percentage", 0)
    price = report.get("price", 698) if report else 698
    refund_amount = int(price * refund_pct / 100)

    # 存储
    feedback_id = _save_feedback(sku, openid, transcript, scores, refund_amount)

    # 企微通知产线
    _notify_production_line(sku, scores, refund_amount)

    return {
        "ok": True,
        "feedback_id": feedback_id,
        "scores": scores,
        "refund_percentage": refund_pct,
        "refund_amount": refund_amount,
        "message": f"反馈评分 {scores.get('total_score', 0)} 分，"
                   f"退款比例 {refund_pct}%（¥{refund_amount}）",
        "category": scores.get("feedback_category", "unknown"),
        "improvement_suggestion": scores.get("improvement_suggestion", ""),
    }


@router.post("/api/report/{sku}/feedback_email")
async def submit_feedback_email(sku: str, req: Request):
    """收集反馈者邮箱（用于新版推送）."""
    body = await req.json()
    email = str(body.get("email", "")).strip()
    feedback_id = str(body.get("feedback_id", ""))
    openid = str(body.get("openid", ""))

    if "@" not in email or "." not in email.split("@")[1]:
        return {"ok": False, "error": "邮箱格式不正确"}

    # 存储邮箱
    FEEDBACK_DIR.mkdir(parents=True, exist_ok=True)
    email_file = FEEDBACK_DIR / "emails.jsonl"
    entry = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
             "sku": sku, "openid": openid, "email": email,
             "feedback_id": feedback_id}
    with email_file.open("a", encoding="utf-8") as f:
        f.write(json.dumps(entry, ensure_ascii=False) + "\n")

    return {"ok": True, "message": "邮箱已登记，报告优化后将免费发送新版"}


async def _score_with_llm(title: str, transcript: str) -> Optional[dict]:
    """调用智谱GLM进行六维评分."""
    try:
        import httpx
        prompt = SCORE_PROMPT.format(report_title=title, transcript=transcript)
        # 使用引擎现有的智谱API配置
        api_key = _get_zhipu_key()
        if not api_key:
            return None
        async with httpx.AsyncClient(timeout=30) as client:
            resp = await client.post(
                "https://open.bigmodel.cn/api/paas/v4/chat/completions",
                headers={"Authorization": f"Bearer {api_key}",
                         "Content-Type": "application/json"},
                json={"model": "glm-4-flash",
                      "messages": [{"role": "user", "content": prompt}],
                      "temperature": 0.1})
            if resp.status_code != 200:
                return None
            content = resp.json()["choices"][0]["message"]["content"]
            # 提取JSON
            import re
            m = re.search(r'\{.*\}', content, re.DOTALL)
            if m:
                return json.loads(m.group())
            return None
    except Exception:
        return None


def _get_zhipu_key() -> Optional[str]:
    """从引擎密钥文件读取智谱API密钥."""
    secret = Path(config.SECRETS_DIR) / "zhipu.secret"
    if secret.exists():
        for line in secret.read_text(encoding="utf-8").splitlines():
            if line.startswith("key="):
                return line[4:].strip()
    # 兜底: We-AIPO .env
    env = Path(r"F:\We-AIPO\.env")
    if env.exists():
        for line in env.read_text(encoding="utf-8").splitlines():
            if line.startswith("ZHIPU_API_KEY="):
                return line.split("=", 1)[1].strip()
    return None


def _save_feedback(sku: str, openid: str, transcript: str,
                   scores: dict, refund_amount: int) -> str:
    """存储反馈记录."""
    FEEDBACK_DIR.mkdir(parents=True, exist_ok=True)
    fid = f"fb_{int(time.time())}_{sku[:8]}"
    rec = {"id": fid, "ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
           "sku": sku, "openid": openid[:16] + "…",
           "transcript": transcript[:2000],
           "scores": scores, "refund_amount": refund_amount}
    fp = FEEDBACK_DIR / f"{sku}_{int(time.time())}.json"
    fp.write_text(json.dumps(rec, ensure_ascii=False, indent=1), encoding="utf-8")
    return fid


def _notify_production_line(sku: str, scores: dict, refund: int):
    """企微通知产线有新反馈."""
    try:
        total = scores.get("total_score", 0)
        cat = scores.get("feedback_category", "?")
        rationale = scores.get("scoring_rationale", "")[:200]
        wecom_msg = (f"📝 新语音反馈: {sku}\n"
                     f"评分: {total}/100 | 退款: ¥{refund}\n"
                     f"类型: {cat}\n"
                     f"理由: {rationale}")
        # 复用引擎的通知通道
        import urllib.request
        webhook = _get_wecom_webhook()
        if webhook:
            data = json.dumps({"msgtype": "markdown",
                               "markdown": {"content": wecom_msg}}).encode()
            req = urllib.request.Request(webhook, data=data,
                                       headers={"Content-Type": "application/json"})
            urllib.request.urlopen(req, timeout=10)
    except Exception:
        pass


def _get_wecom_webhook() -> Optional[str]:
    env = Path(r"F:\We-AIPO\.env")
    if env.exists():
        for line in env.read_text(encoding="utf-8").splitlines():
            if line.startswith("WECOM_WEBHOOK_URL="):
                return line.split("=", 1)[1].strip()
    return None
