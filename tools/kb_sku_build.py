# -*- coding: utf-8 -*-
"""kb_sku_build — KB知识库SKU构建+上架到report.json."""
import json, shutil, time
from pathlib import Path

REPO = Path(r"E:\AI-Station")
CONTENT = REPO / "report_platform" / "content"
KB_DIR = REPO / "data" / "kb_products" / "KB-SUBCON-2026"

# 读package.json
pkg = json.loads((KB_DIR / "package.json").read_text(encoding="utf-8"))

# 构建KB entry（与报告同结构，cat=kb区分）
entry = {
    "sku": pkg["sku"],
    "title": f"《{pkg['title']}》",
    "subtitle": f"{pkg['file_count']}件 · {pkg['size_gb']}GB · 四类分类（{pkg['quality_score']}质量分）",
    "price": pkg["price"],
    "price_label": pkg["price_label"],
    "words_wan": pkg["size_gb"],
    "cat": "kb",
    "cat_name": "知识库",
    "badges": [
        {"k": "文件数", "v": f"{pkg['file_count']:,}件原始材料"},
        {"k": "总容量", "v": f"{pkg['size_gb']}GB（ZIP打包）"},
        {"k": "质量评分", "v": f"{pkg['quality_score']}（判有效率84.8%）"},
        {"k": "分类", "v": "判例语料/行业知识库/跨池收割/政策文件"},
        {"k": "交付方式", "v": "百度网盘永久链接→邮箱自动发送"},
    ],
    "sample_file": "kb_subcon_blueprint.md",
    "sample_label": "免费蓝图（目录+3件精选样本）",
    "coming_soon": False,
    "chapters": [],
    "listed_at": time.strftime("%Y-%m-%d %H:%M"),
    "product_type": "knowledge_base",
    "baidu_share": pkg.get("baidu_share", {}),
    "parent_report": pkg.get("parent_report", "SUBCON-2026"),
}

# 头插到report.json
rp = CONTENT / "report.json"
data = json.loads(rp.read_text(encoding="utf-8"))
assert not any(r.get("sku") == entry["sku"] for r in data["reports"]), "SKU已存在"
data["reports"].insert(0, entry)
rp.write_text(json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"[ok] report.json 头插 {entry['sku']} (共{len(data['reports'])}SKU, cat=kb)")

# 复制蓝图文件作为sample
sample_src = KB_DIR / "blueprint.md"
if sample_src.exists():
    shutil.copy2(sample_src, CONTENT / "sample" / "kb_subcon_blueprint.md")
    print("[ok] sample/kb_subcon_blueprint.md")
else:
    # 生成蓝图
    bp = f"""# {pkg['title']} — 免费蓝图

## 知识库概览
- SKU: {pkg['sku']}
- 文件数: {pkg['file_count']:,}件
- 总容量: {pkg['size_gb']}GB
- 质量评分: {pkg['quality_score']}
- 定价: ¥{pkg['price']}

## 分类目录
1. 判例语料（650MB）— 十二主题族判决切片
2. 行业知识库（5,162件）— 行业报告/学术论文/实务文章
3. 跨池收割（419件）— 六大战役池交叉素材
4. 政策文件（258件）— 法律法规/司法解释

## 3件精选样本
购买后可查看全部5,953件文件。以下是3件高质量样本：

### 样本1: 判决切片示例
（购买后可查看完整判决书切片，含案号/当事人/裁判要旨）

### 样本2: 行业知识库示例
（购买后可查看5,162件行业知识库中的任意文件）

### 样本3: 政策文件示例
（购买后可查看258件政策文件原始文本）

---
*总包创研院知识库市场 · 数据来源：《EPC分包与总分包界面管理实战研究报告》调研产线*
"""
    (CONTENT / "sample" / "kb_subcon_blueprint.md").write_text(bp, encoding="utf-8")
    print("[ok] 蓝图已生成 sample/kb_subcon_blueprint.md")
