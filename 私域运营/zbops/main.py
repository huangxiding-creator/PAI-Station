# -*- coding: utf-8 -*-
"""zbops 入口：selftest（免凭据自检）/ run（智能机器人上线）/ callback（回调服务）。

用法：
  py -I main.py selftest
  py -I main.py run          # 需 config.yaml 凭据
  py -I main.py callback --port 8440
"""
from __future__ import annotations

import asyncio
import logging
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

logging.basicConfig(level=logging.INFO,
                    format="%(asctime)s %(name)s %(levelname)s %(message)s")


def load_cfg() -> dict:
    import os
    import yaml
    p = Path(__file__).parent / "config" / "config.yaml"
    cfg = yaml.safe_load(p.read_text(encoding="utf-8")) or {} if p.exists() else {}

    # 环境变量覆盖（凭据可不落文件）：ZBOPS_CORP_ID / ZBOPS_AIBOT_SECRET /
    # ZBOPS_ANTHROPIC_KEY / ZBOPS_ZHIPU_KEY
    env = os.environ
    if env.get("ZBOPS_CORP_ID"):
        cfg.setdefault("wecom", {})["corp_id"] = env["ZBOPS_CORP_ID"]
    if env.get("ZBOPS_AIBOT_SECRET"):
        cfg.setdefault("wecom", {}).setdefault("aibot", {})["secret"] = \
            env["ZBOPS_AIBOT_SECRET"]
    if env.get("ZBOPS_ANTHROPIC_KEY"):
        cfg.setdefault("ai", {}).setdefault("anthropic", {})["key"] = \
            env["ZBOPS_ANTHROPIC_KEY"]
    if env.get("ZBOPS_ZHIPU_KEY"):
        cfg.setdefault("ai", {}).setdefault("zhipu", {})["key"] = \
            env["ZBOPS_ZHIPU_KEY"]
    return cfg


# ---------------- selftest（免凭据全链路单元自检） ----------------
def selftest() -> int:
    import tempfile, os
    fails = []

    def check(name, cond):
        print(f"  {'PASS' if cond else 'FAIL'}  {name}")
        if not cond:
            fails.append(name)

    print("[1/8] 回调加解密回环")
    from zbops.wecom.crypto import WeComCrypto
    c = WeComCrypto("token123", "43charsabcdefghijklmnopqrstuvwxyz0123456789ab"[:43],
                    "ww1234567890")
    enc = c.encrypt("<xml><test>你好世界</test></xml>")
    dec = c.decrypt(enc)
    check("AES 回环 + corpid 校验", dec == "<xml><test>你好世界</test></xml>")
    sig = c.signature("1", "n", enc)
    check("签名可验证", c.verify(sig, "1", "n", enc))

    print("[2/6] 票据链（急停→令牌→审核→票据→验签）")
    import sqlite3
    tmp = tempfile.mktemp(suffix=".db")
    sqlite3.connect(tmp).executescript("")  # 建空文件占位
    from zbops.guardian.gateway import ActionGateway
    g = ActionGateway({"runtime_dir": tempfile.mkdtemp(), "quiet_hours": ["23:59", "00:01"],
                       "rates": {"wecom_aibot_per_chat_hourly": 2}}, tmp)
    p1 = g.permit("wecom_aibot", "grp1", "reply", "这是一条正常回复")
    check("正常内容放行+票据", p1.ok and g.verify_ticket(
        p1.ticket, "wecom_aibot", "grp1", "reply", "这是一条正常回复"))
    p2 = g.permit("wecom_aibot", "grp1", "reply", "我们保证中标100%通过")
    check("A 级词拦截", not p2.ok and "A级" in p2.reason or "审核" in p2.reason)
    p3 = g.permit("wecom_aibot", "grp1", "reply", "第三条")
    p4 = g.permit("wecom_aibot", "grp1", "reply", "第四条")
    check("令牌桶限额(2/h)生效", p3.ok and not p4.ok)

    print("[3/6] 词库三级")
    from zbops.guardian.moderation import moderate
    check("A 级", moderate("国家级最佳").level == "A")
    check("B 级", moderate("请问报价多少").level == "B")
    check("放行", moderate("依据GB/T 8110 第5.2条").level == "pass")

    print("[4/6] 引用校验（防幻觉）")
    from zbops.ai import citation
    chunks = [{"std_no": "GB/T 8110-2020", "clause": "第5.2条",
               "title": "气体保护电弧焊", "text": "..."}]
    ok1, _ = citation.verify("依据GB/T 8110-2020 第5.2条应...", chunks)
    ok2, f2 = citation.verify("依据GB 50011 第3.1条...", chunks)
    check("可溯源引用通过", ok1)
    check("编造条款号被拦", not ok2)

    print("[5/6] 智库 FTS 检索")
    from zbops.ai.retriever import Retriever
    kb = Retriever(tempfile.mktemp(suffix=".db"))
    kb.db.execute("INSERT INTO kb_fts(text,std_no,clause,title) VALUES(?,?,?,?)",
                  ("气体保护电弧焊质量要求：焊缝表面不得有裂纹气孔。", "GB/T 8110",
                   "第5.2条", "GB-T 8110-2020"))
    kb.db.commit()
    hits = kb.retrieve("气体保护电弧焊 焊缝 质量要求")
    check("FTS 命中带元数据", len(hits) >= 1 and hits[0]["std_no"] == "GB/T 8110")

    print("[6/8] 数据骨架")
    from zbops.data.store import Store
    st = Store(tempfile.mktemp(suffix=".db"))
    gid = st.upsert_group("wecom", "wr_jc7x1", "总包技术群")
    aid = st.log_action("wecom", "reply", "wr_jc7x1", "responsive",
                        "测试动作", "ticket123", "executed")
    check("建表+upsert+审计", gid > 0 and aid > 0)

    print("[7/8] 商机雷达")
    from zbops.radar.detector import SignalDetector, SignalType
    from zbops.radar.evaluator import OpportunityEvaluator
    det = SignalDetector()
    ev = OpportunityEvaluator()
    sigs = det.detect("浙江省水库EPC总承包项目招标", "u1", "c1")
    check("信号检测", len(sigs) > 0 and any(s.type == SignalType.PROJECT for s in sigs))
    opp = ev.evaluate(sigs[0])
    check("商机评估", opp.score > 40)
    # 线索台账
    lid = st.add_lead("c1", "u1", "project", "浙江省水库EPC", ["EPC"], "浙江",
                      "水利", "high", opp.score, 8000000)
    check("线索写入+去重", lid > 0)
    summary = st.get_leads_summary()
    check("线索统计", summary["total"] >= 1)

    print("[8/8] 文章 URL 提取")
    from zbops.radar.article import extract_urls, is_wechat_article
    urls = extract_urls("分享一篇文章 https://mp.weixin.qq.com/s/abc123 很好")
    check("URL 提取", len(urls) == 1 and "mp.weixin.qq.com" in urls[0])
    check("微信文章识别", is_wechat_article(urls[0]))

    print(f"\n{'='*40}\n{'全部通过 [OK]' if not fails else f'失败 {len(fails)} 项: {fails}'}")
    return 1 if fails else 0


# ---------------- run（智能机器人上线） ----------------
async def run():
    cfg = load_cfg()
    wecom = cfg.get("wecom", {})
    aibot_cfg = wecom.get("aibot", {})
    bot_id = aibot_cfg.get("bot_id", "")
    secret = aibot_cfg.get("secret", "")
    if not bot_id or not secret:
        print("缺少凭据：请在 config/config.yaml 填写 wecom.aibot.bot_id 与 "
              "wecom.aibot.secret（获取方式见 README 上线清单）")
        return 1

    from zbops.ai.brain import EngineeringBrain
    from zbops.guardian.gateway import ActionGateway
    from zbops.radar.middleware import RadarMiddleware
    from zbops.wecom.aibot import AiBotGateway

    guardian = ActionGateway(cfg.get("guardian", {}),
                             cfg.get("guardian", {}).get("db_path",
                                                         "C:/zb-ops/data/core.db"))

    # 工程行业大脑：多供应商免费模型轮换
    brain_keys = {"zhipu": cfg.get("ai", {}).get("zhipu", {}).get("key", "")}
    brain = EngineeringBrain(brain_keys)
    print("工程行业大脑就绪（供应商：智谱/硅基流动/Agnes 自动降级链）")

    # 商机雷达中间件
    radar = RadarMiddleware(brain=brain, guardian=guardian)
    print("商机雷达就绪（信号检测+商机评估+文章总结）")

    bot = AiBotGateway(bot_id, secret, brain, guardian, radar=radar)
    print("智能机器人长连接启动（Ctrl+C 退出）")
    await bot.run()


async def monitor():
    """完整自主运营：被动监听 + 安全应答 + 主动服务。"""
    cfg = load_cfg()
    from zbops.ai.brain import EngineeringBrain
    from zbops.data.store import Store
    from zbops.guardian.gateway import ActionGateway
    from zbops.radar.auto_responder import responder
    from zbops.radar.jtbd_engine import JTBDEngine
    from zbops.radar.passive_monitor import RionMonitor
    from zbops.radar.proactive import ProactiveService

    store = Store(cfg.get("guardian", {}).get("db_path",
                                              "C:/zb-ops/data/core.db"))
    guardian = ActionGateway(cfg.get("guardian", {}),
                             cfg.get("guardian", {}).get("db_path",
                                                         "C:/zb-ops/data/core.db"))
    brain_keys = {"zhipu": cfg.get("ai", {}).get("zhipu", {}).get("key", "")}
    brain = EngineeringBrain(brain_keys)

    jtbd = JTBDEngine(brain=brain, kb=None, guardian=guardian, store=store)

    mon = RionMonitor(guardian=guardian, store=store,
                      poll_interval=30, max_groups=100, jtbd_engine=jtbd)

    proactive = ProactiveService(responder=responder, store=store)

    print("=== 自主运营系统启动 ===")
    print("[被动监听] 每30秒扫描所有微信群（最多100个，优先总包群）")
    print("[群策略] 自有群=主动服务 / 他人群=只听不说")
    print("[JTBD] 六大任务识别（技术/合作/商机/风向/资源/声望）")
    print("[主动服务] 每日9点推送精选内容到总包群，让群活跃起来")
    print("[安全应答] 同群日限3条，全局日限20条，风控熔断")
    print("[台账] SQLite 商机线索自动记录")
    print("=" * 40)

    # 三引擎并行
    await asyncio.gather(
        mon.start(),          # 被动监听（识别商机+响应需求）
        responder.start(),    # 安全发送（风控防护）
        proactive.start(),    # 主动推送（每日精选内容）
    )


async def both():
    """双模式同时运行：被动监听（全量消息）+ 智能机器人（@触发答疑）。"""
    cfg = load_cfg()
    import concurrent.futures

    # 在线程池中启动被动监听（它是同步 subprocess 调用）
    loop = asyncio.get_event_loop()

    from zbops.ai.brain import EngineeringBrain
    from zbops.data.store import Store
    from zbops.guardian.gateway import ActionGateway
    from zbops.radar.jtbd_engine import JTBDEngine
    from zbops.radar.passive_monitor import RionMonitor

    store = Store(cfg.get("guardian", {}).get("db_path",
                                              "C:/zb-ops/data/core.db"))
    guardian = ActionGateway(cfg.get("guardian", {}),
                             cfg.get("guardian", {}).get("db_path",
                                                         "C:/zb-ops/data/core.db"))
    brain_keys = {"zhipu": cfg.get("ai", {}).get("zhipu", {}).get("key", "")}
    brain = EngineeringBrain(brain_keys)

    jtbd = JTBDEngine(brain=brain, kb=None, guardian=guardian, store=store)

    # 被动监听（JTBD 引擎驱动）
    mon = RionMonitor(guardian=guardian, store=store,
                      poll_interval=30, jtbd_engine=jtbd)
    mon_task = asyncio.create_task(mon.start())
    print("[被动监听] 启动（每 30 秒扫描所有个人微信群）")

    # 智能机器人（主线程 asyncio）
    wecom = cfg.get("wecom", {})
    aibot_cfg = wecom.get("aibot", {})
    bot_id = aibot_cfg.get("bot_id", "")
    secret = aibot_cfg.get("secret", "")
    if bot_id and secret:
        from zbops.wecom.aibot import AiBotGateway
        bot = AiBotGateway(bot_id, secret, brain, guardian, radar=radar)
        print("[智能机器人] 启动（企微 @触发答疑）")
        # 两个任务并发
        await asyncio.gather(mon_task, bot.run())
    else:
        print("[智能机器人] 未配置凭据，仅运行被动监听")
        await mon_task()


if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "selftest"
    if cmd == "selftest":
        sys.exit(selftest())
    elif cmd == "run":
        sys.exit(asyncio.run(run()))
    elif cmd == "monitor":
        sys.exit(asyncio.run(monitor()))
    elif cmd == "both":
        sys.exit(asyncio.run(both()))
    elif cmd == "callback":
        # T-075/REQ-005: 8440 注入口（POST /enqueue, X-Api-Key 鉴权）
        import uvicorn
        from zbops.radar.service_8440 import app
        print("[8440] callback/enqueue 服务启动 127.0.0.1:8440")
        sys.exit(uvicorn.run(app, host="127.0.0.1", port=8440))
    else:
        print(__doc__)
