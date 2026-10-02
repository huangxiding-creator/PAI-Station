# -*- coding: utf-8 -*-
"""API 直发任务探针 — 探 OpenapiService/CreateTask 端点 (0923).

web 端发消息走 WebSocket (chatController.sendQuestion), 但 OpenapiService 族
(session token 实证可用, CreateWebhook 全 200) 可能有 CreateTask REST 面.
探针即真发: 用主题树 T001 首任务, 成功=军团免浏览器腿打通, 直接记账.
"""
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_api as api

BATTLE = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
              r"\《中石化南京工程有限公司怎么干EPC总承包？》")
TREE = BATTLE / "_pipeline" / "epc50_topic_tree.json"
LEDGER = Path("data/dispatch_ledger.json")


def pick_account() -> tuple:
    """挑今日未派发的 token 账号 → (email, tok)."""
    day = time.strftime("%Y-%m-%d")
    led = json.loads(LEDGER.read_text(encoding="utf-8")) \
        if LEDGER.is_file() else {"day": day, "dispatched": {}}
    if led.get("day") != day:
        led = {"day": day, "dispatched": {}}
    for p in sorted(Path("data/tokens").glob("*.json")):
        email = p.stem.replace("_at_", "@")
        if led["dispatched"].get(email, 0) < 1:
            return email, api.load_token(email), led
    raise RuntimeError("全部账号今日已达限额")


def main() -> int:
    tree = json.loads(TREE.read_text(encoding="utf-8"))
    topic = next(t for t in tree["topics"] if t["status"] == "pending")
    email, tok, led = pick_account()
    prompt = (f"请针对课题《{topic['title']}（{tree['company']}）》完成以下任务，"
              f"以Markdown文件交付成果。附加要求：{'; '.join(topic['queries'][:3])}。"
              f"只产出要求的内容，不要展开长篇撰写。"
              f"搜集整理该课题的公开资料并汇编：1）按主题分组的资料汇编，"
              f"每条注明来源与可信度；2）关键数据表格（含来源标注）；"
              f"3）指出尚无法从公开渠道获得的信息缺口。"
              f"成果文件名：collected_materials.md。")
    title = f"{topic['id']} {topic['title']}"
    print(f"[probe] 账号 {email} | 主题 {title} | prompt {len(prompt)}字")

    candidates = [
        ("POST", "/openapi.v1.OpenapiService/CreateTask",
         {"prompt": prompt, "title": title}),
        ("POST", "/v2/createTask", {"prompt": prompt, "title": title}),
        ("POST", "/api/chat/scheduleTask",
         {"detail": prompt, "title": title}),
    ]
    for method, path, body in candidates:
        st, text = api._urllib_call(method, path, tok, body, timeout=60)
        print(f"  {path} → {st}: {text[:300]}")
        if st == 200 and ("taskId" in text or "task_id" in text
                          or "sessionId" in text or "id" in text):
            print(f"[HIT] {path} 通了 — 端点记录在案")
            return 0
        if st == 200:
            print(f"[HIT?] 200 但无任务 id, 看响应结构")
            return 0
    print("[probe] 全部候选未命中, 需深挖 WS 协议或 v2 文档")
    return 1


if __name__ == "__main__":
    sys.exit(main())
