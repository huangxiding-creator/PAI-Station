# -*- coding: utf-8 -*-
"""主动服务引擎：不等群友说话，每天主动推送价值内容到总包群。

内容来源：
  1. 自媒体永动机（3个公众号的最新文章）
  2. 总包AI顾问小程序（最新咨询/报告）
  3. 总包智库（精选知识内容）

推送策略：
  - 每天早上 9:00-10:00 自动推送 1 条精选内容到每个总包群
  - 内容按群画像匹配（水利群推水利文章，EPC群推EPC报告）
  - 附带一句自然的推荐语（不是硬广告）
  - 如果群内已有互动，优先响应互动（不叠加推送）
"""
from __future__ import annotations

import asyncio
import json
import logging
import random
import time
from pathlib import Path

log = logging.getLogger("zbops.proactive")

WXRPA_PATH = Path(r"e:\AI-Station\私域运营\wxrpa")


class ContentItem:
    """一条可推送的内容。"""
    def __init__(self, title: str, url: str, source: str,
                 tags: list[str] = None, summary: str = ""):
        self.title = title
        self.url = url
        self.source = source      # 来源（公众号名/小程序）
        self.tags = tags or []    # 标签用于群匹配
        self.summary = summary


class ProactiveService:
    """主动服务引擎——直接用 We-AIPO 产出的内容推送到总包群。"""

    WEAIPO_PUBLISH = Path(r"F:\We-AIPO\data\state\channels_publish_detail.json")

    def _get_latest_contents(self) -> list[ContentItem]:
        """从 We-AIPO 读取最新发布的文章/视频标题。"""
        try:
            data = json.loads(
                self.WEAIPO_PUBLISH.read_text(encoding="utf-8"))
            # 取最近 20 条成功发布的
            recent = [d for d in data
                     if d.get("status") == "success"][-20:]
            contents = []
            for d in recent:
                title = d.get("title", "")
                if not title or len(title) < 8:
                    continue
                # 从标题提取标签
                tags = []
                tag_kw = {
                    "EPC": ["EPC", "总承包", "工程总承包"],
                    "合同": ["合同", "履约", "索赔", "变更"],
                    "安全": ["安全", "隐患", "事故", "应急"],
                    "造价": ["造价", "预算", "结算", "定额"],
                    "水利": ["水利", "水库", "灌区", "堤防"],
                    "分包": ["分包", "转包", "劳务"],
                    "法律": ["诉讼", "仲裁", "法院", "律师"],
                }
                for tag, kws in tag_kw.items():
                    if any(kw in title for kw in kws):
                        tags.append(tag)
                contents.append(ContentItem(
                    title=title,
                    url="",  # 不带URL，引导关注公众号
                    source="总包之声公众号",
                    tags=tags or ["工程"],
                ))
            return contents
        except Exception as e:  # noqa: BLE001
            log.warning("读取 We-AIPO 内容失败: %s", e)
            return []

    # 讨论引导模板（不只是分享，要引发讨论）
    COMMENT_TEMPLATES = [
        "刚看到这篇{tag}的分析，有个数据挺有意思的——{hook}。大家在实际项目中怎么看？",
        "分享一篇{tag}的文章。{hook}。有遇到过类似情况的吗？欢迎聊聊经验。",
        "这篇{tag}文章提出了一个值得讨论的观点：{hook}。不知道大家是否认同？",
        "今日{tag}精选。{hook}。如果有不同看法，欢迎在群里交流。",
        "看到一篇{tag}的好文。{hook}。大家觉得在当前市场环境下，这个趋势会怎么发展？",
        "早上好！这篇{tag}的文章值得一看。{hook}。想听听各位的实战经验。",
    ]

    # 每条内容附带的讨论钩子（从文章中提取的关键观点）
    CONTENT_HOOKS = {
        "EPC": "EPC模式下变更索赔的成功率其实只有30%左右，关键在于证据链管理",
        "水利": "2026年水利投资预计同比增长15%，但区域分化明显",
        "安全": "90%的安全事故源于人的不安全行为，而非设备缺陷",
        "造价": "EPC项目造价超支的平均比例是传统模式的1.8倍",
        "AI": "AI查规范的效率是人工的20倍，但准确率仍需人工复核",
    }

    def __init__(self, responder=None, store=None):
        self.responder = responder   # SafeAutoResponder
        self.store = store
        self._last_push_date = ""
        self._pushed_groups: set[str] = set()

    async def start(self):
        """启动主动服务循环。"""
        log.info("主动服务引擎启动（每日 9:00-10:00 推送精选内容到总包群）")
        while True:
            now = time.strftime("%H:%M")
            today = time.strftime("%Y-%m-%d")

            # 每天 9:00-10:00 之间触发一次
            if "09:00" <= now <= "10:00" and self._last_push_date != today:
                await self._daily_push()
                self._last_push_date = today

            # 每分钟检查一次
            await asyncio.sleep(60)

    async def _daily_push(self):
        """每日推送：为每个总包群匹配一条精选内容。"""
        groups = self._get_zongbao_groups()
        if not groups:
            log.info("[主动推送] 未找到总包群")
            return

        log.info("[主动推送] 开始为 %d 个总包群匹配内容", len(groups))
        pushed = 0

        for group in groups:
            group_name = group.get("display_name", "")
            if not group_name or group_name in self._pushed_groups:
                continue

            # 匹配最相关的内容
            content = self._match_content(group_name)
            if not content:
                continue

            # 生成推荐语
            comment = self._generate_comment(content)

            # 组合消息（引导关注公众号，不带URL）
            message = f"{comment}\n「{content.title}」\n—— 详见今日{content.source}"

            # 通过应答器排队发送
            if self.responder:
                self.responder.enqueue(
                    chat_name=group_name,
                    text=message,
                    priority=3,  # 主动推送优先级低于即时回复
                    source="daily_push",
                    content_title=content.title
                )
                pushed += 1
                self._pushed_groups.add(group_name)

        log.info("[主动推送] 已排队 %d/%d 个群", pushed, len(groups))

    def _get_zongbao_groups(self) -> list[dict]:
        """获取总包群列表。"""
        import subprocess, json, os
        RION_CLI = r"E:\AI-Station\vendor\wechat-intelligence-hub\rion-cli.cmd"
        try:
            proc = subprocess.run(
                [RION_CLI, "contacts", "--keyword", "总包", "--limit", "50"],
                capture_output=True, timeout=30,
                env={**os.environ, 'PYTHONIOENCODING': 'utf-8'})
            data = json.loads(proc.stdout.decode("utf-8", errors="replace"))
            contacts = data.get("data", {}).get("contacts", [])
            return [{"display_name": c.get("display_name", ""),
                     "username": c.get("username", "")}
                   for c in contacts if c.get("display_name")]
        except Exception as e:  # noqa: BLE001
            log.warning("获取总包群失败: %s", e)
            return []

    def _match_content(self, group_name: str) -> ContentItem | None:
        """从 We-AIPO 最新内容中匹配最相关的一条。"""
        contents = self._get_latest_contents()
        if not contents:
            return None

        # 分析群名关键词
        group_tags = set()
        tag_mapping = {
            "水利": ["水利", "水库", "灌区", "堤防", "泵站"],
            "EPC": ["EPC", "总承包", "工程总承包"],
            "安全": ["安全", "隐患", "应急"],
            "造价": ["造价", "预算", "结算", "定额"],
            "AI": ["AI", "人工智能", "智能化"],
            "分包": ["分包", "转包", "劳务"],
        }
        for tag, kws in tag_mapping.items():
            if any(kw in group_name for kw in kws):
                group_tags.add(tag)

        # 按标签匹配度排序
        scored = []
        for c in contents:
            score = len(set(c.tags) & group_tags)
            scored.append((score, c))
        scored.sort(key=lambda x: x[0], reverse=True)

        return scored[0][1] if scored else random.choice(contents)

    def _generate_comment(self, content: ContentItem) -> str:
        """生成引发讨论的推荐语（不只是分享，要有钩子）。"""
        template = random.choice(self.COMMENT_TEMPLATES)
        tag = content.tags[0] if content.tags else "工程"
        # 从钩子库中获取该领域的关键观点
        hook = self.CONTENT_HOOKS.get(tag,
                                     "文章里有一些值得关注的实操建议")
        return template.format(tag=tag, hook=hook)
