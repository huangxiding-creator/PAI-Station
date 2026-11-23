# -*- coding: utf-8 -*-
"""super_kb_sku_insert.py — 超级总包知识库 5 SKU 头插 report.json（1123《100×总案》C6/E1/E2）。
旗舰 ¥9,800（定价铁令）置顶 + 4 个试点标准包。体例对齐 KB-SUBCON-2026（实测 18/18 交付卡）。
幂等：已存在 SKU 跳过。缩进 2 空格与原文件一致。"""
import sys, os, json, datetime

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
RJ = r"E:\AI-Station\report_platform\content\report.json"

SHARES = json.load(open(r"E:\AI-Station\逆向工程\baidu-netdisk\replica\_kb_build\delivery_shares.json",
                        encoding="utf-8"))
def share_of(path_frag):
    for s in SHARES:
        if path_frag in s.get("path", "") and "error" not in s:
            # 从 resp 里取 link
            resp = s.get("resp", {})
            return {"url": resp.get("link", ""), "code": s.get("pwd", ""),
                    "period": "permanent", "created": "2026-11-24"}
    return None

NOW = "2026-11-24 03:10"

FLAGSHIP = {
    "sku": "KB-SUPER-FLAGSHIP",
    "title": "《超级总包知识库（动态更新）· 旗舰全库》",
    "subtitle": "45 库体系 · 510 挂载单元持续入库 · 91 SKU 独家研报全量 · 每日凌晨自动更新",
    "price": 9800,
    "price_label": "¥9,800/年",
    "words_wan": 0,
    "cat": "topic",
    "cat_name": "知识库旗舰",
    "badges": [
        {"k": "库体系", "v": "45 个编号知识库（九族全覆盖）"},
        {"k": "独家研报", "v": "91 SKU 全量（市价逾 ¥15,000）"},
        {"k": "更新机制", "v": "每日凌晨 03:30 自动入库"},
        {"k": "独家数据", "v": "裁判文书全量 + 24,071 册书库检索层"},
        {"k": "交付方式", "v": "百度网盘永久链接 → 邮箱 3 分钟自动发送"},
        {"k": "旗舰权益", "v": "年度更新订阅 + 库内容持续生长"},
    ],
    "sample_file": "super_kb_blueprint.md",
    "sample_label": "免费蓝图（45 库全目录地图）",
    "coming_soon": False,
    "chapters": [
        {"id": "g0", "title": "项目管理族（00 库）", "desc": "PMBOK 十大知识领域 · 组织能力 · 管理经典"},
        {"id": "g1", "title": "法规标准族（11-18 库）", "desc": "法律法规全量 · 标准规范全集 · 安全生产 · 水利/能源/交通/建筑专题"},
        {"id": "g2", "title": "商务裁决族（21-24 库）", "desc": "招标采购 · 裁判文书全量 · 造价审计 · 疑难杂症"},
        {"id": "g3", "title": "企业对标族（31-35 库）", "desc": "标杆企业 28 家 · 总包体系手册 · 顶级咨询 · 宏观行研"},
        {"id": "g4", "title": "全过程管控族（41-48 库）", "desc": "全过程管控 · 失败项目警醒 · 标杆项目 · 期刊/电子书/案例"},
        {"id": "g5", "title": "团队工具族（51-55 库）", "desc": "岗位技能课程视频 · 施工组织设计 · 数字转型 · 思维方法"},
        {"id": "g6", "title": "学园生态族（61-65 库）", "desc": "专家百人 · 独家研报 91 SKU · 总包视频库 · 生态资源"},
        {"id": "g7", "title": "模式国际族（71-81 库）", "desc": "PMC · 全过程咨询 · 总承包模式 · 国际项目管理"},
        {"id": "g8", "title": "方法归档族（91-99 库）", "desc": "知识炼金 · 工具软件 · 创研院归档"},
    ],
    "listed_at": NOW,
    "product_type": "knowledge_base",
    "baidu_share": share_of("动态更新"),
}

STD_PACKS = [
    ("KB-STD-12", "《总包标准规范库 · 标准包》", 599, "12. 总包标准规范库",
     "国家/行业标准规范全集 · 图集 · 企业标准", "标准规范全覆盖",
     [{"id": "c1", "title": "国家标准（GB/GB/T）", "desc": "工程建设国家标准全集"},
      {"id": "c2", "title": "行业标准（JGJ/DL/SL 等）", "desc": "建筑/电力/水利等行业标准"},
      {"id": "c3", "title": "扩充专题规范库", "desc": "建筑结构规范 AI 知识库等专业归集"}]),
    ("KB-STD-11", "《总包法规政策库 · 标准包》", 499, "11. 总包法规政策库",
     "国家法律法规数据库全量 · 司法解释 · 政策文件", "法规政策全覆盖",
     [{"id": "c1", "title": "国家法律法规数据库", "desc": "法律/行政法规全量文本"},
      {"id": "c2", "title": "司法解释及典型案例", "desc": "21,708 件判例与解释文件"},
      {"id": "c3", "title": "政策与规范汇编", "desc": "工程法谈系列汇编 + 扩充专题"}]),
    ("KB-STD-22", "《总包纠纷裁决库 · 标准包》", 499, "22. 总包纠纷裁决库",
     "裁判文书全量数据 · 判例谱系 · 争议解决年度观察", "纠纷裁决弹药库",
     [{"id": "c1", "title": "裁判文书全量数据", "desc": "建设工程裁判文书全量"},
      {"id": "c2", "title": "判例谱系与调解实务", "desc": "造价争议判例谱系"},
      {"id": "c3", "title": "争议解决年度观察", "desc": "北仲年度观察"}]),
    ("KB-STD-13", "《安全生产知识库 · 标准包》", 399, "13. 安全生产知识库",
     "安全生产法规 · 专项安全（核/化工/电力） · 事故案例", "安全生产全域",
     [{"id": "c1", "title": "专题安全库", "desc": "核安全/核电/化工/危大工程"},
      {"id": "c2", "title": "法律法规与标准", "desc": "安全生产法律法规 + 标准规范"},
      {"id": "c3", "title": "案例与应急", "desc": "事故案例库 + 应急处置实务"}]),
]

def main():
    data = json.load(open(RJ, encoding="utf-8"))
    reports = data["reports"]
    have = {r.get("sku") for r in reports}
    now = datetime.datetime.now()
    news = []
    f = dict(FLAGSHIP)
    if f["baidu_share"] is None:
        raise SystemExit("旗舰分享缺失——先建分享")
    news.append(f)
    for sku, title, price, frag, sub, kw, chapters in STD_PACKS:
        sh = share_of(frag)
        if sh is None:
            print(f"跳过 {sku}: 无分享")
            continue
        news.append({
            "sku": sku, "title": title,
            "subtitle": f"{sub} · 每日更新订阅",
            "price": price, "price_label": f"¥{price}",
            "words_wan": 0, "cat": "topic", "cat_name": "知识库标准包",
            "badges": [
                {"k": "内容", "v": kw},
                {"k": "更新", "v": "每日凌晨自动入库"},
                {"k": "交付方式", "v": "百度网盘永久链接 → 邮箱自动发送"},
            ],
            "sample_file": "super_kb_blueprint.md",
            "sample_label": "免费蓝图（全库地图，见旗舰库章节）",
            "coming_soon": False,
            "chapters": chapters,
            "listed_at": NOW,
            "product_type": "knowledge_base",
            "baidu_share": sh,
        })
    ins = [x for x in news if x["sku"] not in have]
    for i, x in enumerate(reversed(ins)):
        reports.insert(0, x)
    json.dump(data, open(RJ, "w", encoding="utf-8"), ensure_ascii=False, indent=2)
    print(f"已头插 {len(ins)} 个 SKU: {[x['sku'] for x in ins]}")
    print(f"总 SKU: {len(reports)}")

if __name__ == "__main__":
    main()
