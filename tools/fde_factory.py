"""M11 FDE 扩产排产：20 课题 → compose_plan → 成品落 data + SKU 上架。

链路：04 智库语料 digest → Reconstructor（GLM 免费链）逐节重构（密度
闸门+断点续传）→ data/foundry/plans/<slug>/plan.{json,md} →
09 发布/store/<slug>/ manifest+试读（全案不上公开仓）→ R14 凭证 09 链。
排产账本：data/foundry/factory_ledger.json（done 集，重跑只补缺）。
用法：python tools/fde_factory.py [--limit N] [--only slug1,slug2]
"""
import glob
import json
import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                "..", "src"))

from paistation import config as cfg_mod                    # noqa: E402
from paistation.foundry.fde import compose_plan, digest_markdown, save_plan  # noqa: E402
from paistation.foundry.funnel import write_sku              # noqa: E402
from paistation.foundry.reconstructor import Reconstructor   # noqa: E402
from paistation.llm.zhipu_client import ZhipuClient          # noqa:E402
from paistation.organ import credential as cred_mod          # noqa: E402
from paistation.organ.registry import find_by_name           # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# 20 课题（调研报告域首发 × 工程市场 × 智库方法论缝合）
THEMES = [
    ("epc-claim-playbook", "EPC 索赔实战手册：从证据链到谈判桌"),
    ("epc-design-value", "EPC 设计优化与价值挖掘方案"),
    ("settlement-dispute", "工程结算争议解决全景方案"),
    ("subcontract-risk", "分包管理风险清单与治理方案"),
    ("bid-strategy", "工程投标报价决策系统方案"),
    ("contract-negotiation", "工程合同谈判要点与底线设计"),
    ("safety-governance", "施工安全治理现代化方案"),
    ("urban-renewal-epc", "城市更新 EPC 模式创新方案"),
    ("newenergy-epc", "新能源 EPC 全周期管理方案"),
    ("owner-rep", "业主代表履职全景手册方案"),
    ("cost-control", "工程成本动态管控方案"),
    ("schedule-recovery", "工期延误诊断与赶工方案"),
    ("quality-system", "工程质量体系数字化方案"),
    ("supply-chain-resilience", "工程供应链韧性建设方案"),
    ("claims-forensics", "索赔取证与工程文档治理方案"),
    ("risk-register", "项目风险登记册实操方案"),
    ("joint-venture", "联合体投标与权责设计方方案"),
    ("digital-twin-site", "智慧工地落地路线图方案"),
    ("carbon-epc", "双碳目标下的 EPC 转型方案"),
    ("intl-epc-fidic", "国际 EPC 风险与 FIDIC 应对方方案"),
]

CORPUS_GLOBS = [
    os.path.join(ROOT, "04 智库", "万维钢调研方法论", "**", "*.md"),
    os.path.join(ROOT, "04 智库", "调研框架库", "**", "*.md"),
    os.path.join(ROOT, "05 方法", "毛选", "**", "*.md"),
]

LEDGER = os.path.join(ROOT, "data", "foundry", "factory_ledger.json")


def load_corpus(per_file_cap: int = 12000, total_cap: int = 60000) -> str:
    """智库语料 → 骨架 digest（每文件截顶 + 总量封顶，防提示词爆炸）。"""
    chunks, size = [], 0
    for pattern in CORPUS_GLOBS:
        for path in sorted(glob.glob(pattern, recursive=True)):
            try:
                text = open(path, encoding="utf-8").read()
            except OSError:
                continue
            digest = digest_markdown(text, max_chars=per_file_cap)
            chunks.append(digest)
            size += len(digest)
            if size >= total_cap:
                break
        if size >= total_cap:
            break
    return "\n\n".join(chunks)[:total_cap]


def load_done() -> list:
    try:
        return json.load(open(LEDGER, encoding="utf-8")).get("done", [])
    except (OSError, json.JSONDecodeError):
        return []


def save_done(done: list) -> None:
    os.makedirs(os.path.dirname(LEDGER), exist_ok=True)
    with open(LEDGER, "w", encoding="utf-8") as fh:
        json.dump({"done": done}, fh, ensure_ascii=False)


def main() -> int:
    args = sys.argv[1:]
    limit = 0
    only = set()
    if "--limit" in args:
        limit = int(args[args.index("--limit") + 1])
    if "--only" in args:
        only = set(args[args.index("--only") + 1].split(","))

    cfg = cfg_mod.load(os.path.join(ROOT, "config", "pai.ini"))
    client = ZhipuClient(cfg_mod.resolve_api_key(cfg),
                         [cfg["llm"]["fast_model"], cfg["llm"]["deep_model"]])
    engine = Reconstructor(client.deep)
    corpus = load_corpus()
    print(f"[factory] 语料 {len(corpus)} 字 · 课题 {len(THEMES)} 个", flush=True)

    done = load_done()
    built = 0
    for slug, theme in THEMES:
        if slug in done or (only and slug not in only):
            continue
        if limit and built >= limit:
            break
        out_dir = os.path.join(ROOT, "data", "foundry", "plans", slug)
        print(f"\n[factory] === {slug}：{theme} ===", flush=True)
        t0 = time.time()
        plan = compose_plan(engine, theme, corpus=corpus, n_chapters=6,
                            checkpoint_path=os.path.join(out_dir, "checkpoint.json"))
        save_plan(plan, out_dir)
        write_sku(ROOT, plan, plan_id=slug)
        spec = find_by_name("发布")
        cred = cred_mod.issue(
            kind="fde_plan_published", upstream="05 方法",
            downstream=spec.dirname,
            payload={"slug": slug, "score": plan.get("score", 0),
                     "passed": bool(plan.get("passed"))})
        cred_mod.append_to_chain(ROOT, spec.dirname, cred)
        done = [*done, slug]
        save_done(done)
        built += 1
        print(f"[factory] {slug} 完成：{plan.get('score')} 分"
              f"（{time.time() - t0:.0f}s）已上架", flush=True)
    print(f"\n[factory] 排产结束：本次出厂 {built} 案，累计 {len(done)}/"
          f"{len(THEMES)}", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
