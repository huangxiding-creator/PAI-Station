"""M7.2 试点方案批量锻造（1深+2广，真实 GLM 无人值守）。

深 = 工程总承包 FDE 实施方案（两本 EPC 书语料，report 深产品）
广1 = 智能商业时代传统企业转型 FDE 实施方案（曾鸣《智能商业》语料）
广2 = 传统企业创新转型 FDE 实施方案（混沌语料；餐饮书挖掘因当日限额 3/3
       触顶按提案 §8 降级路径执行，方案页如实标注——不假完成）
用法: python scripts/foundry_pilot_plans.py [--only deep|broad1|broad2]
产物: data/foundry/plans/{slug}/plan.json + plan.md + plan.docx
"""
import argparse
import glob
import json
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation import config
from paistation.foundry.export_docx import plan_to_docx
from paistation.foundry.fde import compose_plan, digest_markdown, save_plan
from paistation.foundry.reconstructor import Reconstructor
from paistation.foundry.report import generate_report
from paistation.llm.zhipu_client import ZhipuClient

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PLANS = os.path.join(ROOT, "data", "foundry", "plans")

EPC_BOOKS = ("EPC工程总承包项目过程控制概论", "工程总承包_EPC_DB_争议解决实战攻略")
ZENGMING_BOOK = "智能商业"
HUNDUN_WANT = ("生成式创造", "100% 可以落地的AI产品", "从用户任务出发",
               "建立AI思维", "认知型创新", "AI 商业领导者")

# 语料降级说明（账号安全铁律：当日微信读书限额触顶，明日可换真书语料再版）
DEGRADED_CORPUS_NOTE = ("语料说明：本版语料为混沌学园方法论库（微信读书行业书挖掘"
                        "当日限额已满，按预案降级生成）。下一版将换行业书语料重锻。")


def _read(path: str) -> str:
    return open(path, encoding="utf-8").read()


def corpus_deep() -> str:
    parts = [_read(p) for p in glob.glob(os.path.join(ROOT, "data", "weread", "*", "*.md"))
             if any(b in p for b in EPC_BOOKS)]
    if not parts:
        raise SystemExit("深产品语料缺失：检查 data/weread/ 下两本 EPC 书")
    return digest_markdown("\n\n".join(parts), max_chars=32000)


def corpus_broad1() -> str:
    hits = [p for p in glob.glob(os.path.join(ROOT, "data", "weread", "*", "*.md"))
            if ZENGMING_BOOK in p]
    if not hits:
        raise SystemExit("广1 语料缺失：检查 data/weread/智能商业/")
    return digest_markdown(_read(hits[0]), max_chars=30000)


def corpus_broad2() -> tuple[str, bool]:
    """混沌语料（降级路径）。返回 (语料, 是否降级标注)。"""
    lines = []
    for path in sorted(glob.glob(os.path.join(ROOT, "data", "hundun", "_mining", "*.json"))):
        course = json.load(open(path, encoding="utf-8"))
        if not isinstance(course, dict) or not course.get("title"):
            continue
        if not any(w in course["title"] for w in HUNDUN_WANT):
            continue
        lines.append(f"# 课程：《{course['title']}》 讲师：{course.get('teacher', '')}")
        for item in course.get("items", []):
            lines.append(f"- {item.get('name', '')}：{item.get('core', '')}"
                         f"｜AI应用：{item.get('ai_application', '')}")
    return "\n".join(lines), True


def build_client() -> ZhipuClient:
    cfg = config.load(os.path.join(ROOT, "config", "pai.ini"))
    key = config.resolve_api_key(cfg)
    return ZhipuClient(
        key, [cfg["llm"]["fast_model"], cfg["llm"]["deep_model"]],
        vision_model=cfg["llm"]["vision_model"])


def forge(client: ZhipuClient, slug: str, gen) -> dict:
    out_dir = os.path.join(PLANS, slug)
    ckpt = os.path.join(out_dir, "plan.ckpt.json")
    os.makedirs(out_dir, exist_ok=True)
    plan = gen(Reconstructor(client.deep), checkpoint_path=ckpt)
    plan["slug"] = slug
    jp, mp = save_plan(plan, out_dir)
    dp = plan_to_docx(plan, os.path.join(out_dir, "plan.docx"))
    print(f"[plan:{slug}] 密度 {plan['score']} passed={plan['passed']} → {jp} / {mp} / {dp}",
          flush=True)
    return plan


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--only", choices=("deep", "broad1", "broad2"), default="")
    args = ap.parse_args()
    client = build_client()
    summary = {}

    if not args.only or args.only == "deep":
        corpus = corpus_deep()
        summary["deep"] = forge(
            client, "epc-fde-ai",
            lambda eng, checkpoint_path="": generate_report(
                eng, "工程总承包（EPC）行业 AI 转型 FDE 实施方案", corpus,
                n_chapters=7, checkpoint_path=checkpoint_path))

    if not args.only or args.only == "broad1":
        corpus = corpus_broad1()
        summary["broad1"] = forge(
            client, "zengming-smart-business-fde",
            lambda eng, checkpoint_path="": compose_plan(
                eng, "智能商业时代传统企业转型 FDE 实施方案", corpus,
                n_chapters=6, checkpoint_path=checkpoint_path))

    if not args.only or args.only == "broad2":
        corpus, degraded = corpus_broad2()
        def _gen(eng, checkpoint_path=""):
            plan = compose_plan(eng, "传统企业创新转型 FDE 实施方案", corpus,
                                n_chapters=6, checkpoint_path=checkpoint_path)
            return {**plan, "corpus_note": DEGRADED_CORPUS_NOTE if degraded else ""}
        summary["broad2"] = forge(client, "legacy-innovation-fde", _gen)

    for slug, plan in summary.items():
        degraded = sum(1 for ch in plan["chapters"] for s in ch["sections"]
                       if s.get("degraded"))
        print(f"[summary] {slug}: score={plan['score']} passed={plan['passed']}"
              f" degraded_secs={degraded}", flush=True)


if __name__ == "__main__":
    main()
