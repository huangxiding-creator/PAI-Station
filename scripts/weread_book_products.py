"""微信读书 book.json → 书加工四件套 CLI（B1 技能包 / B2 记忆闭环）。

用法:
  python scripts/weread_book_products.py skill  data/weread/智能商业 --depth study
  python scripts/weread_book_products.py cards  data/weread/智能商业 --concept 3 --action 2
  python scripts/weread_book_products.py commit data/weread/智能商业 --edits edits.json
  python scripts/weread_book_products.py apkg   data/weread/智能商业

链路：book.json 适配器 → deep 蒸馏 → 三层出厂闸门（剥离/扫描/外泄对检）
→ M5 scan_skill 目录级五层扫描 → 落盘 skills/ 或 data/learn/。
"""
import argparse
import json
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation import config
from paistation.forge.book_skill import (  # noqa: E402
    GateError,
    book_to_corpus,
    distill_book,
    save_package,
)
from paistation.learn.fsrs_queue import FsrsQueue  # noqa: E402
from paistation.learn.ria_cards import (  # noqa: E402
    commit_cards,
    export_apkg,
    generate_cards,
    stage_cards,
)
from paistation.llm.zhipu_client import ZhipuClient  # noqa: E402
from paistation.skills.scanner import scan_skill  # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SKILLS_BOOKS_DIR = os.path.join(ROOT, "data", "skills", "books")
DEFAULT_QUEUE = os.path.join(ROOT, "data", "learn", "fsrs_queue.json")


def _client():
    cfg = config.load(os.path.join(ROOT, "config", "pai.ini"))
    key = config.resolve_api_key(cfg)
    return ZhipuClient(
        key, [cfg["llm"]["fast_model"], cfg["llm"]["deep_model"]],
        vision_model=cfg["llm"]["vision_model"])


def _load_book(book_dir: str) -> dict:
    path = os.path.join(book_dir, "book.json")
    with open(path, encoding="utf-8") as fh:
        return json.load(fh)


def cmd_skill(args) -> int:
    book = _load_book(args.book_dir)
    corpus = book_to_corpus(book)
    meta = corpus["metadata"]
    print(f"[preflight] {meta['title']}（{meta['author']}）"
          f" {meta['chapters']} 章单元 / 全文 {meta['estimated_tokens']:,} token"
          f"（隐形码位剥离 {meta['invisible_removed']}）")
    existing = None
    pkg_dir = os.path.join(args.out or SKILLS_BOOKS_DIR,
                           f"weread-{meta['bookId']}")
    manifest_path = os.path.join(pkg_dir, "package.json")
    if os.path.exists(manifest_path) and not args.fresh:
        with open(manifest_path, encoding="utf-8") as fh:
            old = json.load(fh)
        chapters = old.get("chapters_cache")
        if chapters:
            existing = {"chapters": chapters}
            print(f"[fold-in] 复用旧产物 {len(chapters)} 章，只蒸馏新章")
    pkg = distill_book(book, _client().deep, depth=args.depth, existing=existing)
    missing = [c["title"] for c in pkg["chapters"] if c.get("missing")]
    over = [c["title"] for c in pkg["chapters"] if c.get("over_budget")]
    try:
        out = save_package(pkg, pkg_dir)
    except GateError as exc:
        print(f"[gate] 出厂闸门拦截：{exc}")
        return 2
    # 旧章 md 折入缓存，供下次 fold-in
    manifest = json.load(open(out["manifest"], encoding="utf-8"))
    manifest["chapters_cache"] = pkg["chapters"]
    with open(out["manifest"], "w", encoding="utf-8", newline="\n") as fh:
        json.dump(manifest, fh, ensure_ascii=False, indent=2)
    verdict = scan_skill(pkg_dir)
    print(f"[skill] {len(out['files'])} 文件 -> {pkg_dir}")
    print(f"[scan_skill] {verdict['verdict']}"
          + (f" {verdict['layers']}" if verdict["verdict"] != "pass" else ""))
    print(f"[roi] 全文 {pkg['roi']['full_tokens']:,} token → 技能包 "
          f"{pkg['roi']['skill_tokens']:,} token（{pkg['roi']['ratio']}×）")
    if missing:
        print(f"[warn] 模型缺席 {len(missing)} 章：{('、'.join(missing))[:80]}（重跑即补）")
    if over:
        print(f"[warn] 超预算 {len(over)} 章")
    if not pkg["indexes"]["topics"]:
        print("[warn] Topic Index 为空（索引调用两次均失败）——重跑一次即补，"
              "章节缓存会白拿")
    return 0


def cmd_cards(args) -> int:
    book = _load_book(args.book_dir)
    quotas = {"concept": args.concept, "action": args.action}
    cards = generate_cards(book, _client().deep, quotas=quotas)
    if not cards:
        print("[cards] 未产出卡片（模型缺席或解析失败），未落盘")
        return 2
    staged = stage_cards(cards, args.book_dir)
    print(f"[cards] {len(cards)} 张 -> {staged}")
    for card in cards:
        mark = "A" if card["type"] == "action" else "C"
        print(f"  [{mark}] {card['card_id']} {card['question'][:46]}")
        print(f"      原句：{card['quote'][:46]}")
    print("[hint] 人工改写 cards_staged.json 后：")
    print(f"       python scripts/weread_book_products.py commit {args.book_dir} "
          f"--edits <(改写JSON)>")
    return 0


def cmd_commit(args) -> int:
    staged_path = os.path.join(args.book_dir, "cards_staged.json")
    edits = {}
    if args.edits:
        with open(args.edits, encoding="utf-8") as fh:
            edits = json.load(fh)
    queue = FsrsQueue(args.queue or DEFAULT_QUEUE)
    out = commit_cards(staged_path, queue, edits)
    print(f"[commit] 准入 {len(out['committed'])} 张，留审 {out['remaining']} 张"
          f"（队列 {queue.stats()}）")
    for card_id in out["committed"]:
        print(f"  + {card_id}")
    if out["remaining"] and not edits:
        print("[hint] edits 格式：{\"卡ID\": {\"retell\": \"自己的话\", \"approved\": true}}")
    return 0


def cmd_apkg(args) -> int:
    staged_path = os.path.join(args.book_dir, "cards_staged.json")
    with open(staged_path, encoding="utf-8") as fh:
        cards = json.load(fh).get("cards", [])
    if not cards:
        print("[apkg] 暂存区无卡，先跑 cards 子命令")
        return 2
    title = _load_book(args.book_dir).get("title", "RIA")
    out_path = args.out or os.path.join(args.book_dir, f"{title}.apkg")
    export_apkg(cards, out_path, deck_name=title)
    print(f"[apkg] {len(cards)} 张 -> {out_path}（Anki 导入即用，GUID 稳定可重导）")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest="cmd", required=True)

    p_skill = sub.add_parser("skill", help="书 → 技能包（agentskills 规范）")
    p_skill.add_argument("book_dir")
    p_skill.add_argument("--depth", choices=["sketch", "reference", "study"],
                         default="reference")
    p_skill.add_argument("--out", default=None, help="默认 data/skills/books/")
    p_skill.add_argument("--fresh", action="store_true", help="忽略旧产物全量重蒸")
    p_skill.set_defaults(func=cmd_skill)

    p_cards = sub.add_parser("cards", help="书 → RIA 卡（暂存待人审）")
    p_cards.add_argument("book_dir")
    p_cards.add_argument("--concept", type=int, default=3)
    p_cards.add_argument("--action", type=int, default=2)
    p_cards.set_defaults(func=cmd_cards)

    p_commit = sub.add_parser("commit", help="人审通过 → fsrs 队列")
    p_commit.add_argument("book_dir")
    p_commit.add_argument("--edits", default=None, help="改写 JSON 路径")
    p_commit.add_argument("--queue", default=None, help=f"默认 {DEFAULT_QUEUE}")
    p_commit.set_defaults(func=cmd_commit)

    p_apkg = sub.add_parser("apkg", help="暂存卡 → Anki .apkg")
    p_apkg.add_argument("book_dir")
    p_apkg.add_argument("--out", default=None)
    p_apkg.set_defaults(func=cmd_apkg)

    args = parser.parse_args()
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
