# -*- coding: utf-8 -*-
"""被动监听器：用 rion-cli 读本地微信 DB，不等 @，持续扫描所有群。

数据源复用：vendor/wechat-intelligence-hub/rion-cli.cmd
消息管线复用：radar/detector + radar/evaluator + ai/brain
发送复用：wxrpa（Ctrl+Enter）

工作流：
  1. rion-cli sessions → 获取活跃群列表
  2. rion-cli tail --chat <id> --jsonl → 流式读取新消息
  3. 每条消息过 SignalDetector
  4. 有信号 → OpportunityEvaluator 评估
  5. 求助 → EngineeringBrain 生成回答 → wxrpa 发送
  6. 商机 → 记台账 → 推送告警
"""
from __future__ import annotations

import asyncio
import json
import logging
import subprocess
import time
from pathlib import Path

log = logging.getLogger("zbops.passive")

RION_CLI = r"E:\AI-Station\vendor\wechat-intelligence-hub\rion-cli.cmd"


class RionMonitor:
    """基于 rion-cli 的被动消息监听（JTBD 引擎 + 群策略驱动）。"""

    def __init__(self, radar=None, guardian=None, store=None,
                 wxrpa_engine=None, poll_interval: float = 30.0,
                 max_groups: int = 20, jtbd_engine=None):
        self.radar = radar
        self.guardian = guardian
        self.store = store
        self.wxrpa = wxrpa_engine
        self.poll_interval = poll_interval
        self.max_groups = max_groups
        self.jtbd = jtbd_engine
        self._last_check: dict[str, int] = {}
        self._running = False
        self._reply_count: dict[str, int] = {}  # chat_id → 今日回复数

        # 群策略引擎
        from .group_policy import GroupPolicyEngine
        self.policy_engine = GroupPolicyEngine()

    async def start(self):
        """主循环：定期扫描所有群的新消息。"""
        self._running = True
        log.info("被动监听启动（间隔 %.0f 秒，最多 %d 个群）",
                 self.poll_interval, self.max_groups)

        while self._running:
            try:
                sessions = self._get_sessions()
                for sess in sessions[:self.max_groups]:
                    await self._check_group(sess)
            except Exception as e:  # noqa: BLE001
                log.error("扫描异常: %s", e)
            await asyncio.sleep(self.poll_interval)

    def stop(self):
        self._running = False

    def _run_cli(self, *args) -> list[dict]:
        """执行 rion-cli 命令，返回文本消息列表。"""
        cmd = [RION_CLI] + list(args)
        proc = subprocess.run(cmd, capture_output=True, text=True,
                              timeout=30, encoding="utf-8", errors="replace")
        if proc.returncode != 0:
            log.debug("rion-cli: %s", proc.stderr[:100])
            return []
        try:
            data = json.loads(proc.stdout)
            if data.get("ok"):
                msgs = data.get("data", {}).get("messages", [])
                # rion-cli 字段: kind_name="text" 是纯文本, text 字段是内容
                result = []
                for m in msgs:
                    kind = m.get("kind_name", "")
                    text = m.get("text", "") or m.get("content", "")
                    if kind == "text" and text and len(text) > 5:
                        result.append({
                            "content": text,
                            "sender": m.get("sender", ""),
                            "sender_wxid": m.get("sender_wxid", ""),
                            "from_me": m.get("from_me", False),
                            "time": m.get("time", ""),
                            "create_time": m.get("create_time", ""),
                        })
                return result
            return []
        except json.JSONDecodeError:
            return []

    def _get_sessions(self) -> list[dict]:
        """获取完整群列表——用 contacts 搜索所有总包群 + sessions 补充。"""
        groups = []

        # 1) 用 contacts 搜索所有含"总包"的群（完整列表）
        try:
            proc = subprocess.run(
                [RION_CLI, "contacts", "--keyword", "总包", "--limit", "100"],
                capture_output=True, timeout=30,
                env={**__import__('os').environ,
                     'PYTHONIOENCODING': 'utf-8'})
            data = json.loads(proc.stdout.decode("utf-8", errors="replace"))
            contacts = data.get("data", {}).get("contacts", [])
            for c in contacts:
                name = c.get("display_name", "") or c.get("nickname", "")
                username = c.get("username", "") or c.get("wxid", "")
                if "@chatroom" in username or name:
                    groups.append({
                        "username": username,
                        "display_name": name,
                        "unread_count": 0,
                        "sort_timestamp": 0,
                        "chat_type": "group" if "@chatroom" in username else "contact"
                    })
        except Exception as e:  # noqa: BLE001
            log.warning("contacts 搜索失败: %s", e)

        # 2) 补充 sessions 中的活跃群（可能有 contacts 没覆盖的）
        try:
            proc = subprocess.run(
                [RION_CLI, "sessions", "--limit", "30"],
                capture_output=True, timeout=30,
                env={**__import__('os').environ,
                     'PYTHONIOENCODING': 'utf-8'})
            data = json.loads(proc.stdout.decode("utf-8", errors="replace"))
            for s in data.get("data", {}).get("sessions", []):
                if s.get("chat_type") != "group":
                    continue
                uname = s.get("username", "")
                if not any(g["username"] == uname for g in groups):
                    groups.append(s)
        except Exception as e:  # noqa: BLE001
            log.warning("sessions 补充失败: %s", e)

        # 排序：总包群优先 → 工程群 → 其他
        zb = [g for g in groups if "总包" in g.get("display_name", "")]
        eng_kw = ["工程", "水利", "EPC", "建筑", "施工", "造价", "安全", "项目"]
        eng = [g for g in groups
               if g not in zb and any(kw in g.get("display_name", "") for kw in eng_kw)]
        other = [g for g in groups if g not in zb and g not in eng]

        result = zb + eng + other
        log.info("监控群: 总包%d + 工程%d + 其他%d = %d 个",
                len(zb), len(eng), len(other), len(result))
        if zb:
            log.info("总包群: %s",
                    ", ".join(g["display_name"][:10] for g in zb[:8]))
        return result[:self.max_groups]

    async def _check_group(self, session: dict):
        """检查一个群的新消息并处理信号。"""
        chat_id = session.get("username", "")
        display_name = session.get("display_name", "")
        last_ts = session.get("sort_timestamp", 0)
        known_ts = self._last_check.get(chat_id, 0)

        if last_ts <= known_ts:
            return  # 没有新消息

        # 用 timeline 读取最近消息（chat 是位置参数）
        msgs = self._run_cli(
            "timeline", chat_id,
            "--limit", "10")

        self._last_check[chat_id] = last_ts

        for msg in msgs:
            await self._process_message(msg, chat_id, display_name)

    async def _process_message(self, msg: dict, chat_id: str,
                               group_name: str):
        """处理单条消息：群策略判定 → JTBD 分析 → 行动过滤 → 执行。"""
        text = msg.get("content", "").strip()
        sender = msg.get("sender", "")
        from_me = msg.get("from_me", False)

        if not text or len(text) < 12 or from_me:
            return

        # ── 群策略判定 ──
        policy = self.policy_engine.classify(group_name)
        log.debug("[监听] %s(%s) | %s: %s",
                 group_name[:12], policy.ownership.value, sender, text[:40])

        # 他人群：只做商机检测，不在群内发言
        if policy.ownership.value == "foreign":
            await self._process_foreign_group(text, sender, chat_id,
                                              group_name, policy)
            return

        # 自有群/合作群：完整 JTBD 行动链
        await self._process_owned_group(text, sender, chat_id,
                                        group_name, policy)

    async def _process_foreign_group(self, text: str, sender: str,
                                     chat_id: str, group_name: str,
                                     policy):
        """他人群处理：只记商机+告警，绝不在群内发言。"""
        if not self.jtbd:
            return

        result = await self.jtbd.analyze_and_act(
            text, sender, chat_id, group_name)

        if result.job.value == "no_job":
            return

        # 只保留告警和线索（去掉所有群内回复）
        from .group_policy import filter_actions_by_policy
        safe_actions = filter_actions_by_policy(result.actions, policy)

        if safe_actions:
            log.info("[他人群-商机] %s | %s | %s | 变现%.0f%%",
                    group_name[:12], sender, result.job.value,
                    result.monetization_potential * 100)

        for act in sorted(safe_actions, key=lambda a: a.priority):
            await self._execute_action(act, chat_id, group_name,
                                      sender, result)

    async def _process_owned_group(self, text: str, sender: str,
                                   chat_id: str, group_name: str,
                                   policy):
        """自有群/合作群处理：完整行动链（AI 回答+产品推荐+内容分享）。"""
        if not self.jtbd:
            return

        # 检查今日回复配额
        today_count = self._reply_count.get(chat_id, 0)
        if today_count >= policy.max_replies_per_day:
            log.debug("[配额] %s 今日已达上限 %d", group_name[:12], today_count)
            policy.can_reply = False

        result = await self.jtbd.analyze_and_act(
            text, sender, chat_id, group_name)

        if result.job.value == "no_job":
            return

        log.info("[自有群-JTBD] %s | %s | %s | 置信度%.0f%% | 变现%.0f%%",
                group_name[:12], sender, result.job.value,
                result.confidence * 100,
                result.monetization_potential * 100)

        # 合作群去掉产品推广
        from .group_policy import filter_actions_by_policy
        actions = filter_actions_by_policy(result.actions, policy)

        for act in sorted(actions, key=lambda a: a.priority):
            if act.type == "reply":
                self._reply_count[chat_id] = today_count + 1
            await self._execute_action(act, chat_id, group_name,
                                      sender, result)

    async def _execute_action(self, act, chat_id: str, group_name: str,
                              sender: str, jtbd_result=None):
        """执行一个行动——reply 通过 AutoResponder 实际发送。"""
        if act.type == "reply":
            # 通过 AutoResponder 排队发送到微信群
            from .auto_responder import responder
            responder.enqueue(
                chat_name=group_name,
                text=act.content,
                priority=act.priority,
                sender=sender, job=jtbd_result.job.value if jtbd_result else "")
            log.info("[排队发送] → %s (队列%d)", group_name[:12],
                    len(responder.queue))

        elif act.type == "notify_owner":
            # 高价值商机 → 推送告警
            log.info("[商机告警] %s", act.content[:100])
            # TODO: 接企微 webhook 推送给主理人手机

        elif act.type == "create_lead":
            if self.store:
                score = 50
                if jtbd_result:
                    score = jtbd_result.monetization_potential * 100
                est_val = int(jtbd_result.monetization_potential * 500000) \
                    if jtbd_result else 100000
                lead_id = self.store.add_lead(
                    chat_id=chat_id, sender_id=sender,
                    signal_type=act.metadata.get("job", "unknown"),
                    signal_text=act.content,
                    keywords=[],
                    province=act.metadata.get("province", ""),
                    industry=act.metadata.get("industry", ""),
                    priority="high" if act.priority <= 2 else "medium",
                    score=score,
                    est_value_yuan=est_val)
                log.info("[线索#%d] %s → %s | 预估%.0f万",
                        lead_id, sender, act.metadata.get("job", ""),
                        est_val / 10000)

        elif act.type == "share_article":
            from .auto_responder import responder
            responder.enqueue(chat_name=group_name, text=act.content,
                            priority=act.priority)
