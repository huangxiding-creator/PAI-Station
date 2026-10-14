# -*- coding: utf-8 -*-
"""文章处理：从群消息中提取 URL → 获取内容 → 总结要点 → 推荐相关内容。

复用：httpx（获取）、EngineeringBrain（总结）、Retriever（推荐）
"""
from __future__ import annotations

import logging
import re

import httpx

log = logging.getLogger("zbops.article")

URL_PAT = re.compile(r'https?://[^\s<>"\']+')


def extract_urls(text: str) -> list[str]:
    """提取消息中的所有 URL。"""
    return URL_PAT.findall(text)


def is_wechat_article(url: str) -> bool:
    return "mp.weixin.qq.com" in url


async def fetch_article(url: str) -> dict:
    """获取文章内容（标题+正文摘要）。"""
    try:
        async with httpx.AsyncClient(timeout=15, follow_redirects=True) as c:
            r = await c.get(url, headers={
                "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                              "AppleWebKit/537.36"
            })
            r.raise_for_status()
            html = r.text

        # 提取标题
        title_m = re.search(r'<title>(.*?)</title>', html, re.S)
        title = title_m.group(1).strip() if title_m else ""

        # 微信文章提取正文
        if is_wechat_article(url):
            content_m = re.search(
                r'<div[^>]*id="js_content"[^>]*>(.*?)</div>',
                html, re.S)
            if content_m:
                body = re.sub(r'<[^>]+>', ' ', content_m.group(1))
                body = re.sub(r'\s+', ' ', body).strip()
            else:
                body = re.sub(r'<[^>]+>', ' ', html)
                body = re.sub(r'\s+', ' ', body)[:2000]
        else:
            # 通用网页：去标签取前 2000 字
            body = re.sub(r'<script[^>]*>.*?</script>', '', html, flags=re.S)
            body = re.sub(r'<style[^>]*>.*?</style>', '', body, flags=re.S)
            body = re.sub(r'<[^>]+>', ' ', body)
            body = re.sub(r'\s+', ' ', body).strip()[:2000]

        return {"title": title, "body": body[:3000], "url": url}
    except Exception as e:  # noqa: BLE001
        log.error("获取文章失败 %s: %s", url[:50], e)
        return {"title": "", "body": "", "url": url, "error": str(e)}


async def summarize_article(article: dict, brain=None) -> str:
    """用工程行业大脑总结文章要点。"""
    if not brain or not article.get("body"):
        return ""
    prompt = (f"总结以下工程行业文章的 3-5 个核心要点，每个要点一行，"
              f"最后提一个值得深入探讨的问题：\n\n"
              f"标题：{article['title']}\n内容：{article['body'][:1500]}")
    parts = []
    try:
        async for chunk in brain.answer(prompt, {"chat_id": "article_sum",
                                                "sender": "", "chat_type": "single"}):
            parts.append(chunk)
    except Exception as e:  # noqa: BLE001
        log.error("AI 总结失败: %s", e)
        return ""
    return "".join(parts)[:500]
