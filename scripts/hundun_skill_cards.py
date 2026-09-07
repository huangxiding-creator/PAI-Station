"""混沌学园 3 门课 → 技能卡蒸馏实跑（M2.5 PoC）。

deep 模型逐课提炼 → 五层安全扫描（复用 M5 scan_skill）→ data/hundun/skills/
用法: python scripts/hundun_skill_cards.py
"""
import glob
import json
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation import config
from paistation.forge.skill_cards import distill_cards, save_cards
from paistation.llm.zhipu_client import ZhipuClient
from paistation.skills.scanner import scan_skill

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA = os.path.join(ROOT, "data", "hundun")
OUT = os.path.join(DATA, "skills")


def main():
    cfg = config.load(os.path.join(ROOT, "config", "pai.ini"))
    key = config.resolve_api_key(cfg)
    client = ZhipuClient(
        key, [cfg["llm"]["fast_model"], cfg["llm"]["deep_model"]],
        vision_model=cfg["llm"]["vision_model"])
    total = 0
    for path in sorted(glob.glob(os.path.join(DATA, "*.json"))):
        course = json.load(open(path, encoding="utf-8"))
        print(f"[distill] {course['title']} ...", flush=True)
        cards = distill_cards(client.deep, course)
        for c in cards:
            print(f"  - {c['name']}：{c['description']}（{len(c['steps'])}步）")
        written = save_cards(cards, OUT)
        for w in written:
            verdict = scan_skill(os.path.dirname(w))
            print(f"    scan: {verdict['verdict']}"
                  + (f" {verdict['layers']}" if verdict["verdict"] != "pass"
                     else ""))
        total += len(cards)
    print(f"\n[done] 共 {total} 张技能卡 -> {OUT}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
