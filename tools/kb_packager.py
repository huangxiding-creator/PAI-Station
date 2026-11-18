# -*- coding: utf-8 -*-
"""
KB-Packager — 知识库变现引擎 · 结构化打包模块
把 kb_curator 的输出(files/ + curator_report.json)整理为可售知识库包:

  判例语料/  行业知识库/  跨池收割/  政策文件/  其他/
  README.md      KB 名称+描述+分类说明+文件数+总大小+数据来源声明
  INDEX.md       全量文件索引(文件名+分类+大小)
  blueprint.md   免费蓝图(全目录 + 3 件精选样本路径, 样本同步到 blueprint_samples/)
  package.json   {sku, title, desc, price, size_gb, file_count, categories,
                  quality_score, blueprint_files}

定价(与产线公式一致): price = GB数 x 1元 x 质量系数
  质量系数 = 判有效率x0.3 + 密度x0.3 + 稀缺x0.2 + 结构化x0.2  (取自 curator 实测)

用法:
  python kb_packager.py --input E:/AI-Station/data/kb_products/KB-SUBCON-2026 \
      --sku KB-SUBCON-2026 [--title ...] [--desc ...] [--force]
"""
import argparse
import json
import os
import shutil
import sys
import time

CATEGORIES = ["判例语料", "行业知识库", "跨池收割", "政策文件", "其他"]
PRICE_PER_GB_YUAN = 1.0
# 小程序分享回跳: 复用现有产品详情页(?id= 携 SKU)
MP_PRODUCT_ROUTE = "/pages/product/product"
FONT_CANDIDATES = [r"C:/Windows/Fonts/msyh.ttc", r"C:/Windows/Fonts/simhei.ttf"]


def _font(size: int):
    try:
        from PIL import ImageFont
        for p in FONT_CANDIDATES:
            if os.path.exists(p):
                return ImageFont.truetype(p, size)
    except Exception:
        pass
    return None


def gen_share_assets(input_dir: str, sku: str, title: str, stats: dict) -> dict:
    """生成小程序分享素材底图: 5:4 转发图 / 1:1 朋友圈卡图 / 专属海报底图(小程序码由端上叠加)。
    返回相对路径字典; PIL 不可用时返回空 dict(package.json 中如实标注 generated=false)。"""
    try:
        from PIL import Image, ImageDraw
    except Exception as e:
        print(f"[packager] PIL 不可用, 跳过分享底图: {e}")
        return {}
    assets_dir = os.path.join(input_dir, "assets")
    os.makedirs(assets_dir, exist_ok=True)
    bg, accent, ink = (15, 34, 64), (198, 156, 84), (255, 255, 255)

    def text_card(w, h, out_name, qr_box=None):
        img = Image.new("RGB", (w, h), bg)
        d = ImageDraw.Draw(img)
        f_big, f_mid, f_sml = _font(44), _font(28), _font(22)
        d.text((40, 44), "总包创研院 · 结构化知识库", font=f_mid, fill=accent)
        # 标题换行(每行 14 字)
        line, y = "", 130
        for ch in title:
            line += ch
            if len(line) >= 14:
                d.text((40, y), line, font=f_big, fill=ink)
                y += 62
                line = ""
        if line:
            d.text((40, y), line, font=f_big, fill=ink)
            y += 62
        d.text((40, y + 16), f"SKU: {sku}", font=f_mid, fill=ink)
        d.text((40, y + 62), stats["line"], font=f_sml, fill=(178, 190, 205))
        if qr_box:
            x0, y0, s = qr_box
            d.rectangle([x0, y0, x0 + s, y0 + s], outline=accent, width=3)
            d.text((x0 + s // 2 - 66, y0 + s // 2 - 14), "小程序码位", font=f_mid, fill=accent)
        d.text((40, h - 58), "data by ZongBao Research", font=f_sml, fill=(120, 132, 150))
        out = os.path.join(assets_dir, out_name)
        img.save(out, "PNG")
        return os.path.relpath(out, input_dir).replace("\\", "/")

    stat_line = (f"{stats['files']} 件 · {stats['size']} · "
                 f"判例/行业/跨池/政策 四大类 · 定价 {stats['price']} 元")
    return {
        "share_5x4": text_card(500, 400, "share_5x4.png"),
        "share_1x1": text_card(500, 500, "share_1x1.png"),
        "poster": text_card(750, 1000, "poster.png", qr_box=(438, 738, 264)),
        "stat_line": stat_line,
    }


def classify(item) -> str:
    """内容信号优先, 来源引擎兜底; 规则确定性, README 中披露。"""
    sp = (item.get("source_path") or "").lower()
    base = os.path.basename(sp)
    engine = (item.get("engine") or "").lower()
    fname = item["file"].lower()
    # 1) 判例语料: 判决/判例/裁判文书 或判决切片引擎
    if engine.startswith("corpus_stores:judgment") or any(
            k in fname for k in ("判决", "判例", "裁判文书")):
        return "判例语料"
    # 2) 政策文件: 政策目录/政策文件名
    if "policy" in sp or "_channel_policy" in sp or "政策" in fname:
        return "政策文件"
    # 3) 行业知识库: 行业文章/研报/收割暂存
    if any(k in sp for k in ("rss_harvest", "researchtopics", "staging", "harvest")):
        return "行业知识库"
    # 4) 跨池收割: 其余跨池引擎来源
    if engine.startswith("crosspool:"):
        return "跨池收割"
    return "其他"


def human_size(n: float) -> str:
    for unit in ("B", "KB", "MB", "GB"):
        if n < 1024 or unit == "GB":
            return f"{n:.2f}{unit}"
        n /= 1024
    return f"{n:.2f}GB"


def main():
    ap = argparse.ArgumentParser(description="KB-Packager 结构化打包")
    ap.add_argument("--input", required=True, help="curator 输出目录(含 files/ 与 curator_report.json)")
    ap.add_argument("--sku", required=True)
    ap.add_argument("--title", default="")
    ap.add_argument("--desc", default="")
    ap.add_argument("--force", action="store_true", help="分类目录已有文件时允许重跑")
    args = ap.parse_args()

    report_path = os.path.join(args.input, "curator_report.json")
    files_dir = os.path.join(args.input, "files")
    if not (os.path.exists(report_path) and os.path.isdir(files_dir)):
        sys.exit(f"[packager] 输入不完整(需 curator_report.json + files/): {args.input}")

    t0 = time.time()
    with open(report_path, encoding="utf-8") as f:
        report = json.load(f)

    title = args.title or f"{args.sku} 专业知识库"
    desc = args.desc or (
        f"面向{report.get('pool', '')}主题的工程行业结构化知识库, "
        f"含判例语料/行业知识库/跨池收割/政策文件四大类, "
        f"全部文件经弹药池策展管线筛选落盘。")

    # 已分类过则拒绝(除非 --force)
    existing = [c for c in CATEGORIES if os.path.isdir(os.path.join(args.input, c))
                and os.listdir(os.path.join(args.input, c))]
    if existing and not args.force:
        sys.exit(f"[packager] 分类目录已非空: {existing}; 重跑请加 --force")

    # ---- 分类 + 移动(curator 本轮产物在包内腾挪, 不涉池内资产) ----
    moved, missing = [], 0
    for item in report["files"]:
        src = os.path.join(files_dir, item["file"])
        if not os.path.exists(src):
            missing += 1
            continue
        cat = classify(item)
        cat_dir = os.path.join(args.input, cat)
        os.makedirs(cat_dir, exist_ok=True)
        dest = os.path.join(cat_dir, item["file"])
        if os.path.exists(dest):  # 重跑场景: 先清旧
            os.remove(dest)
        shutil.move(src, dest)
        item["category"] = cat
        item["dest"] = f"{cat}/{item['file']}"
        moved.append(item)
    if missing:
        print(f"[packager] 警告: {missing} 个文件在 files/ 缺失(跳过)")

    # ---- 实测账(数字零造假: 以落盘文件为准) ----
    for item in moved:
        item["bytes_final"] = os.path.getsize(os.path.join(args.input, item["dest"]))
    file_count = len(moved)
    total_bytes = sum(i["bytes_final"] for i in moved)
    size_gb = total_bytes / 2 ** 30
    cats = {}
    for c in CATEGORIES:
        ci = [i for i in moved if i["category"] == c]
        if ci:
            cats[c] = {"files": len(ci), "bytes": sum(i["bytes_final"] for i in ci),
                       "chars": sum(i["chars"] for i in ci)}
        else:
            cats[c] = {"files": 0, "bytes": 0, "chars": 0}

    # ---- 定价 ----
    q = report.get("quality_score", 0.0)
    qc = report.get("quality_components", {})
    price = round(size_gb * PRICE_PER_GB_YUAN * q, 2)

    # ---- 小程序分享素材 + share_config(转发/朋友圈/海报/回跳) ----
    assets = gen_share_assets(args.input, args.sku, title, {
        "files": file_count, "size": human_size(total_bytes), "price": price})
    share_config = {
        "title": f"{title} · {file_count}件/{human_size(total_bytes)} 仅{price}元",
        "en": f"{args.sku} | ZongBao Research Knowledge Base",
        "image": assets.get("share_5x4", ""),
        "desc": desc,
        "path": f"{MP_PRODUCT_ROUTE}?id={args.sku}",
        "query": f"id={args.sku}",
        "share_app_image": assets.get("share_5x4", ""),      # onShareAppMessage 5:4
        "timeline_image": assets.get("share_1x1", ""),        # onShareTimeline 1:1
        "poster_image": assets.get("poster", ""),             # 专属海报底图(端上叠小程序码)
        "qr_scene": f"kb={args.sku}",                         # wxacode.getUnlimited scene
        "assets_generated": bool(assets),
    }

    # ---- 免费蓝图: 目录 + 3 件精选样本(核心层判例语料按字数 Top3) ----
    flagship = [i for i in moved if i["category"] == "判例语料" and i["tier"] == "core"]
    flagship.sort(key=lambda i: -i["chars"])
    samples = flagship[:3] if flagship else sorted(
        moved, key=lambda i: -i["chars"])[:3]
    bp_dir = os.path.join(args.input, "blueprint_samples")
    os.makedirs(bp_dir, exist_ok=True)
    blueprint_files = []
    for i, s in enumerate(samples, 1):
        ext = os.path.splitext(s["file"])[1] or ".md"
        dst = os.path.join(bp_dir, f"精选样本{i:02d}_{s['file']}")
        if len(os.path.basename(dst)) > 200:
            dst = os.path.join(bp_dir, f"精选样本{i:02d}{ext}")
        shutil.copy2(os.path.join(args.input, s["dest"]), dst)
        blueprint_files.append(os.path.relpath(dst, args.input).replace("\\", "/"))

    # ---- README.md ----
    src_note = (
        f"数据来源: 总包创研院调研产线弹药池 {report.get('pool')}"
        f"(manifest.jsonl 全量台账可溯源, 每文件保留来源引擎与问题树节点映射; "
        f"核心层 {report['by_tier']['core']['files']} 件经 judge=valid 判读, "
        f"补充层 {report['by_tier']['supplement']['files']} 件为问题树已映射的在盘弹药, 分账披露不混计)。"
    )
    cat_lines = "\n".join(
        f"| {c} | {cats[c]['files']} | {human_size(cats[c]['bytes'])} | {cats[c]['chars']:,} 字 |"
        for c in CATEGORIES if cats[c]["files"])
    readme = f"""# {title}

**SKU**: {args.sku}

{desc}

## 规模一览

| 指标 | 数值 |
|---|---|
| 文件总数 | {file_count} |
| 总大小 | {human_size(total_bytes)} ({size_gb:.4f} GB) |
| 总字数(台账口径) | {sum(i['chars'] for i in moved):,} |
| 质量系数 | {q} |
| 定价 | {price} 元 (公式: GB数 x 1元 x 质量系数) |

## 分类说明

| 分类 | 文件数 | 大小 | 字数 |
|---|---|---|---|
{cat_lines}

- **判例语料**: 真实裁判文书切片(判决/判例/裁判文书, 含 2009-2021 分主题切片)
- **行业知识库**: 行业文章/研报/调研收割件(rss_harvest/ResearchTopics/staging)
- **跨池收割**: 自兄弟弹药池(投标/海外/固定总价/判例/计价/储能)收割的独家语料
- **政策文件**: 政策法规类文件(policy 目录/政策文件名)
- **其他**: 以上规则未覆盖的补充件

## 数据来源声明

{src_note}

免费蓝图见 `blueprint.md`(全目录 + 3 件精选样本在 `blueprint_samples/`)。
全量索引见 `INDEX.md`。机器可读账本见 `package.json` 与 `curator_report.json`。

---
*生成时间: {time.strftime('%Y-%m-%d %H:%M:%S')} · KB-Packager*
"""
    with open(os.path.join(args.input, "README.md"), "w", encoding="utf-8") as f:
        f.write(readme)

    # ---- INDEX.md ----
    rows = "\n".join(
        f"| {n} | {i['category']} | {i['file']} | {human_size(i['bytes_final'])} | "
        f"{i['engine']} | {i['tier']} |"
        for n, i in enumerate(sorted(moved, key=lambda x: (CATEGORIES.index(x['category']), x['file'])), 1))
    with open(os.path.join(args.input, "INDEX.md"), "w", encoding="utf-8") as f:
        f.write(f"""# {args.sku} 全量文件索引

共 {file_count} 件 / {human_size(total_bytes)}。分类目录说明见 README.md。

| # | 分类 | 文件名 | 大小 | 来源引擎 | 层级 |
|---|---|---|---|---|---|
{rows}
""")

    # ---- blueprint.md ----
    def tree(c, depth=0):
        ci = sorted([i for i in moved if i["category"] == c], key=lambda x: -x["chars"])
        head = f"{'- ' * (depth + 1)}**{c}** ({cats[c]['files']} 件 / {human_size(cats[c]['bytes'])})\n"
        for i in ci[:15]:
            head += f"{'- ' * (depth + 2)}{i['file']} ({human_size(i['bytes_final'])}, {i['chars']:,}字)\n"
        if len(ci) > 15:
            head += f"{'- ' * (depth + 2)}…其余 {len(ci) - 15} 件见 INDEX.md\n"
        return head

    catalog = "".join(tree(c) for c in CATEGORIES if cats[c]["files"])
    sample_lines = "\n".join(
        f"- `{p}` — {s['category']}/{s['file']} ({human_size(s['bytes_final'])}, "
        f"{s['chars']:,}字, {s['engine']})"
        for p, s in zip(blueprint_files, samples))
    with open(os.path.join(args.input, "blueprint.md"), "w", encoding="utf-8") as f:
        f.write(f"""# {title} · 免费蓝图

这是 **{args.sku}** 的免费目录蓝图: 先看全库结构, 再决定是否购买整库。
3 件精选样本已随蓝图免费提供(`blueprint_samples/`), 其余为整库付费内容。

## 全库目录(每类列字数 Top15)

{catalog}
## 3 件精选样本(免费)

{sample_lines}

## 购买整库

{file_count} 件 / {human_size(total_bytes)} / 定价 {price} 元。全量清单见 INDEX.md。
""")

    # ---- package.json ----
    package = {
        "sku": args.sku,
        "title": title,
        "desc": desc,
        "price": price,
        "currency": "CNY",
        "price_formula": f"{size_gb:.4f}GB x {PRICE_PER_GB_YUAN}元 x 质量系数{q} = {price}元",
        "size_gb": round(size_gb, 4),
        "file_count": file_count,
        "categories": cats,
        "category_dirs": CATEGORIES,
        "quality_score": q,
        "quality_components": qc,
        "share_config": share_config,
        "blueprint_files": blueprint_files,
        "tiers": report.get("by_tier", {}),
        "source_pool": report.get("pool"),
        "generated_at": time.strftime("%Y-%m-%dT%H:%M:%S"),
    }
    with open(os.path.join(args.input, "package.json"), "w", encoding="utf-8") as f:
        json.dump(package, f, ensure_ascii=False, indent=1)

    print(f"[packager] sku={args.sku} files={file_count} size={size_gb:.4f}GB "
          f"price={price} quality={q}")
    print(f"[packager] categories=" + ", ".join(f"{c}:{cats[c]['files']}" for c in CATEGORIES))
    print(f"[packager] blueprint_samples={len(blueprint_files)} "
          f"share_assets={share_config['assets_generated']} "
          f"share_path={share_config['path']} elapsed={time.time() - t0:.1f}s")


if __name__ == "__main__":
    main()
