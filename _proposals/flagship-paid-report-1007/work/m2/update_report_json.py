# -*- coding: utf-8 -*-
"""update_report_json — BLUEBOOK-2027 条目从预售位转正式 SKU（真实五卷结构+74章+详细转化面）。

chapters 从 bluebook/volN/*.md 首行标题程序化生成（id=章号，desc=标题「：」后缀，无后缀用手写兜底）。
只改 BLUEBOOK-2027 一条，其余 65 条原样保留；缩进=2 空格、ensure_ascii=False 与原文件一致。
usage: PYTHONIOENCODING=utf-8 python update_report_json.py
"""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[2]
BLUE = ROOT / "bluebook"
RJ = Path(r"E:\AI-Station\report_platform\content\report.json")

DESC_FALLBACK = {
    "5-3": "必赢·长功·险招三分档的创效打法精编",
}
VOLS = ["vol1", "vol2", "vol3", "vol4", "vol5"]


def build_chapters():
    chapters = []
    for v in VOLS:
        files = sorted((BLUE / v).glob("*.md"),
                       key=lambda p: [int(x) for x in re.match(r"(\d+)-(\d+)", p.name).groups()])
        for p in files:
            m = re.match(r"(\d+-\d+)", p.name)
            title = p.read_text(encoding="utf-8").splitlines()[0].lstrip("# ").strip()
            cid = m.group(1)
            desc = title.split("：", 1)[1].strip() if "：" in title else DESC_FALLBACK.get(cid, "")
            if len(desc) > 42:
                desc = desc[:40] + "…"
            chapters.append({"id": cid, "title": title, "desc": desc})
    return chapters


def main():
    chapters = build_chapters()
    assert len(chapters) == 74, f"章数 {len(chapters)} ≠ 74"

    entry = {
        "sku": "BLUEBOOK-2027",
        "title": "《中国工程总承包（EPC）产业蓝皮书·二〇二七》",
        "subtitle": "五卷本 · 74 章 · 50 万字 · 每个数字可回查",
        "price": 10000,
        "price_label": "五卷套装 ¥10,000",
        "words_wan": 50,
        "badges": [
            {"k": "全书字数", "v": "50.1 万字（结算 500,998）"},
            {"k": "章节数", "v": "五卷 74 章"},
            {"k": "成书页数", "v": "737 页 PDF"},
            {"k": "数字纪律", "v": "机器验收逐句核锚"},
            {"k": "判断纪律", "v": "结论+强度+反证三件套"},
        ],
        "sample_file": "bluebook_sample.md",
        "sample_label": "总序 + 五卷导语 + 74 章目录（完整试读）",
        "chapters": chapters,
        "coming_soon": False,
        "volumes": [
            "卷一 市场全景（9 章 · 136 页）",
            "卷二 标杆企业（30 章 · 201 页）",
            "卷三 区域机会（18 章 · 186 页）",
            "卷四 专题实战（10 章 · 129 页）",
            "卷五 独家判断（7 章 · 85 页）",
        ],
        "cat": "",  # v0.9.6 用户令：旗舰/独家筛档已下线——cat 留空=只进「全部」，不进任何筛档
        "cat_name": "蓝皮书",
        "intro_lede": "工程总承包这门生意，金额大、链条长、口径乱——任何真实的进入决策，都要跨过同一道坎：把散落在政策文件、企业口径与行业传闻里的信息，拼成一张能下注的底图。这本五卷本蓝皮书为此而写：一份每个数字都能回查、每个判断都标了强度的行业底账。",
        "intro": "全书五卷 74 章、50.1 万字、737 页成书 PDF。卷一《市场全景》给面：全国 EPC 投资盘子测算、政策时间线 2017-2026、商业模式演变、竞争格局四层、区域梯度、细分赛道、盈利真相与时效增补——任何跨章数字对不上，先回卷一对口径。卷二《标杆企业》给对标：公路咨询、寰球、中油工程、中冶南方、中建二三四五六八局、铁四院、湖南院等 28 家旗舰逐一开底账，四章制（概况定位/组织体系/代表项目/经营数据与模式判断），末章四维证据评分收成梯队——评分评的是源稿可证实度，不是企业实力。卷三《区域机会》给地域：湘黔琼皖新川浙宁冀青黑闽津鲁滇鄂晋 17 省逐省盘账，投资盘子、政策风向、重点项目、竞争格局、进入打法五章制，一省一本可核验的账。卷四《专题实战》给实操：储能、风电、核电、水电、水利五条能源水利线的全流程图景与翻车点，丰城电厂三期事故失效链逐环解剖，EPC 项目经理能力模型，DeepSeek×EPC 场景图景，卷末收拢 55 件可直接复用的实战工具。卷五《独家判断》给判断：断言链方法论、第一性五步法、创效 30 招、跨库判断两章、独家样本判断与 2026-2029 二十条预判——每条判断交三件套：结论、证据强度（实证/推断/观点三档）、反证检验。成书法分三态：精编章数字逐字取自存档源稿、句句挂段落锚号；融合章只路由数字、不生产数字；原创章一律摆出算式与假设。两说并陈、缺口如实，全书经机器验收逐句核锚、主编独立复验零采信自报。",
        "audience": "工程与设计企业决策层（要不要转型 EPC、往哪个省/哪条赛道压资源）、投资与尽调机构（要一套可回查的第三方底账交叉检验）、设备与材料供应商（要排布销售资源）、行业研究者与政策分析岗",
        "method_note": "五卷 74 章三态成书（精编/融合/原创）· 数字锚点机器验收逐句核验 · 主编独立复验零采信自报 · 判断全带证据强度与反证检验 · G1 结算 500,998 字",
    }

    data = json.loads(RJ.read_text(encoding="utf-8"))
    idx = next(i for i, x in enumerate(data["reports"]) if x["sku"] == "BLUEBOOK-2027")
    data["reports"][idx] = entry
    RJ.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

    # 回读验证：74 章在册、字段齐、其余条目数不变
    back = json.loads(RJ.read_text(encoding="utf-8"))
    b = next(x for x in back["reports"] if x["sku"] == "BLUEBOOK-2027")
    assert len(back["reports"]) == 66 and len(b["chapters"]) == 74
    assert b["price"] == 10000 and b["coming_soon"] is False and b["sample_file"] == "bluebook_sample.md"
    pdf = Path(r"E:\AI-Station\report_platform\content\full\BLUEBOOK-2027.pdf")
    smp = Path(r"E:\AI-Station\report_platform\content\sample\bluebook_sample.md")
    print(f"条目已更新：74 章 · price=10000 · coming_soon=false")
    print(f"售卖件 full/BLUEBOOK-2027.pdf = {pdf.stat().st_size:,}B")
    print(f"试读件 sample/bluebook_sample.md = {smp.stat().st_size:,}B")
    banned = ["抓手", "赋能", "闭环", "颗粒度", "对齐", "心智", "生态位", "打法沉淀", "组合拳"]
    hit = [w for w in banned if w in json.dumps(b, ensure_ascii=False) or w in smp.read_text(encoding="utf-8")]
    print("禁词检查：" + ("PASS 零命中" if not hit else f"FAIL {hit}"))
    sys.exit(1 if hit else 0)


if __name__ == "__main__":
    main()
