# -*- coding: utf-8 -*-
"""video_factory — 视频号竖屏金句卡 MP4 生产器 (F5b 视频腿 v1).

PIL 产 1080×1920 竖屏卡帧 (墨蓝×铜金 品牌色) → imageio-ffmpeg 合成
H.264/yuv420p MP4 (微信视频号兼容). 免费依赖 (不占 NB 配额/不用付费API).

用法:
  python -X utf8 promo/video_factory.py make --slug cnnec_v1
  python -X utf8 promo/video_factory.py list      # 内置选题卡
"""
from __future__ import annotations

import argparse
import sys
import tempfile
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[1]
OUT_DIR = ROOT / "promo" / "videos"

W, H = 1080, 1920
INK = (15, 42, 67)
INK2 = (22, 56, 92)
BRASS = (201, 168, 118)
PAPER = (250, 247, 242)
MUT = (154, 154, 154)

# 内置选题: slug → 卡帧文案 (标题另配 — 爆款配方: 具体数字/大案要案/避坑止损)
CARDS: dict[str, dict] = {
    "cnnec_v1": {
        # 1008 用户令: 短标题要简洁 (21字超上限→发表键锁灰, r6实锤);
        # 长文案全挪 desc (描述字段容量大)
        "title": "全国唯一能总承包核电站的公司",
        "desc": ("全国唯一能总承包整座核电站的工程公司，凭什么？"
                 "设计·采购·施工·调试四项能力全部拉满，华龙一号首堆"
                 "就是这么干成的。1600份资料·15.6万字，我们把它拆成了"
                 "14章。深度研报全文，公众号可试读。"),
        "desc_tags": ["EPC", "核电", "工程总承包", "华龙一号"],
        "frames": [
            ("全国只有一家", "能总承包整座核电站的工程公司"),
            ("设计 · 采购 · 施工 · 调试", "四项能力全部拉满"),
            ("1600份资料 · 15.6万字", "我们把它拆成了14章"),
            ("华龙一号首堆怎么干成的", "报告里全拆了 · 公众号可试读"),
        ],
    },
    "fengcheng_v1": {
        "title": "73人遇难，拆出三个安全黑洞",
        "desc": ("73人遇难、1.02亿损失——丰城电厂11·24冷却塔事故复盘。"
                 "不是意外，是模式的基因缺陷：责任碎片化，人人都负责="
                 "没人负责。30章沉思录深度拆解，公众号可试读。"),
        "desc_tags": ["工程安全", "EPC", "丰城电厂", "事故复盘"],
        "frames": [
            ("73人遇难 · 1.02亿损失", "丰城电厂11·24事故"),
            ("不是意外", "是模式的基因缺陷"),
            ("责任碎片化", "人人都负责 = 没人负责"),
            ("最弱势的人敢不敢说停", "30章沉思录 · 公众号可试读"),
        ],
    },
    # 1018 SEPDC 上架队: 四川院全景研究 (数字全部实锤在稿 ch05/ch08/ch01)
    "sepdc_v1_am": {
        "title": "设计院里唯一亏损的这家",
        "desc": ("中国电建17家设计院，唯一亏损的是四川院：总资产96.5亿，"
                 "净利润负7.35亿。钱去哪了？应收账款与现金流真相，20万字"
                 "全景研究逐笔拆解，每个数字标注出处可回查。公众号可试读。"),
        "desc_tags": ["EPC", "设计院", "工程总承包", "财务真相"],
        "frames": [
            ("17家设计院", "唯一亏损的是四川院"),
            ("总资产 96.5亿", "净利润 负7.35亿"),
            ("钱去哪了", "应收账款与现金流逐笔拆"),
            ("20万字 · 数字可回查", "全景研究 · 公众号可试读"),
        ],
    },
    "sepdc_v2_am": {
        "title": "12.96万篇EPC诉讼判例",
        "desc": ("十二年129,566篇裁判文书，拆出EPC风险地图：工程款纠纷"
                 "三步路径、分包挂靠责任穿透、空壳对手方让胜诉归零。"
                 "每个金额都有案号背书。20万字全景研究，公众号可试读。"),
        "desc_tags": ["EPC", "工程纠纷", "裁判文书", "风险管理"],
        "frames": [
            ("129,566篇判决书", "十二年EPC诉讼全景"),
            ("工程款纠纷", "三步路径步步致命"),
            ("分包 · 挂靠 · 空壳", "责任穿透三大通道"),
            ("每个金额有案号", "20万字全景研究 · 可试读"),
        ],
    },
    "sepdc_v3_h3": {
        "title": "一家设计院的全景底账",
        "desc": ("特高压世界纪录、储能EPC、海外电站——中国电建四川院"
                 "20万字全景研究：12章从政策到2029预判，1.3亿字证据底账，"
                 "五轴完备性全绿，每个数字标注出处。今日上架，第1章免费试读。"),
        "desc_tags": ["EPC", "特高压", "工程研究", "深度报告"],
        "frames": [
            ("海拔5360米 500千伏", "输电设计三项世界纪录"),
            ("1.3亿字证据底账", "每个数字标注出处"),
            ("12章 · 20.2万字", "政策到2029预判全景"),
            ("今日上架", "第1章免费试读 · 公众号"),
        ],
    },
    # 1018 TRANSFORM 上架队: 设计院转型方法论 (数字实锤在稿 ch05/ch08/ch04)
    "transform_v1_am": {
        "title": "设计院转型EPC的五条路",
        "desc": ("全过程咨询/设计牵头EPC/联合体/工程公司/投资人+，五条转型"
                 "路径各自适合谁？选错就是十年弯路。21.5万字方法论+双向案例"
                 "档案，每个数字标注出处可回查。公众号可试读。"),
        "desc_tags": ["设计院", "EPC", "转型", "工程总承包"],
        "frames": [
            ("2万家设计院", "集体走到十字路口"),
            ("五条转型路径", "各自适合谁·选错十年弯路"),
            ("成与败双向档案", "真案例真数字逐项拆"),
            ("21.5万字方法论", "数字可回查 · 公众号可试读"),
        ],
    },
    "transform_v2_am": {
        "title": "转型设计院的财务真相",
        "desc": ("转型EPC的设计院，毛利率和应收账款到底怎么样？1.34亿字证据"
                 "底账拆出营收/毛利/现金流真相，风险信号提前看。公众号可试读。"),
        "desc_tags": ["设计院", "财务", "EPC", "应收账款"],
        "frames": [
            ("转型EPC之后", "毛利率和应收怎么样"),
            ("1.34亿字证据底账", "逐笔拆营收与现金流"),
            ("风险信号", "应收账款暴露前的三个征兆"),
            ("财务真相全景", "21.5万字研报 · 可试读"),
        ],
    },
    "transform_v3_h3": {
        "title": "一份设计院转型方法论",
        "desc": ("政策阶梯·市场底账·五条路径·风险档案·2026-2029预判——12章"
                 "21.5万字，1.34亿字证据底账，机器锚点门全量直验。今日上架，"
                 "第1章免费试读。"),
        "desc_tags": ["设计院转型", "EPC", "研究报告", "方法论"],
        "frames": [
            ("政策·市场·路径·风险", "转型全景一张图"),
            ("12章 · 21.5万字", "1.34亿字证据底账"),
            ("每个数字可回查", "机器锚点门全量直验"),
            ("今日上架", "第1章免费试读 · 公众号"),
        ],
    },
    # 1008 续队: 中建三局 (钩子全部实锤在稿 ENT-22: 火神山·雷神山铁军/
    # 深圳速度三天一层楼×5/上海环球金融中心; 徽章 11.1万字·12章·¥698)
    "ent22_v1": {
        "title": "建火神山的三局怎么干EPC",
        "desc": ("火神山、雷神山背后的建设铁军——中建三局。从80年代深圳"
                 "国贸「三天一层楼」的深圳速度，到上海环球金融中心、深圳"
                 "平安金融中心，敢为天下先的打法一脉相承。11.1万字、12章"
                 "拆解三局EPC总承包，公众号可试读，全文 report.yrecepc.cn"),
        "desc_tags": ["EPC", "中建三局", "火神山", "深圳速度"],
        "frames": [
            ("火神山·雷神山", "背后的建设铁军"),
            ("三天一层楼", "深圳速度的起源"),
            ("铁军怎么干EPC", "急难险重里的执行力"),
            ("11.1万字 · 12章", "拆解中建三局 · 公众号可试读"),
        ],
    },
    # 1008 续队: 湖南省卷 (在售单册字数第一: 38.6万字·20章·454页·¥598;
    # 受众=省内建企/进场央国企/投资机构 — 页内原文)
    "prov07_v1": {
        "title": "湖南EPC市场写了38.6万字",
        "desc": ("一个省的EPC市场能写多厚？湖南卷给你答案：38.6万字、20章、"
                 "454页——机会在哪、未来五年怎么走，一册装下。省内建企、"
                 "准备进场的央国企与投资机构都值得看。免费试读："
                 "report.yrecepc.cn"),
        "desc_tags": ["EPC", "湖南", "市场机会", "区域报告"],
        "frames": [
            ("一个省的市场", "能写多厚？38.6万字"),
            ("机会在哪", "未来五年怎么走"),
            ("454页 · 20章", "湖南EPC全景一册装下"),
            ("在湖南干工程的", "这份值得看 · 公众号可试读"),
        ],
    },
    # 1008 用户令: 最新研报 R50 (r50_article.md 同调钩子, 数字全来自
    # report.json badges — 零造假)
    "r50_snei_v1": {
        "title": "中石化南京工程怎么干EPC",
        "desc": ("设计+施工合并了，为什么还是干不好EPC？我们用867份"
                 "研究底稿、1294万字资料，拆解国内炼化EPC第一梯队——"
                 "中石化南京工程的30年总承包打法：923处来源引注、关键"
                 "结论最多9源交叉印证、15章10万字成稿。报告全文首发价"
                 "¥1999，免费试读：report.yrecepc.cn"),
        "desc_tags": ["EPC", "炼化", "中石化南京工程", "研究报告"],
        "frames": [
            ("合并了", "还是干不好EPC"),
            ("交付基因", "组织合并解决不了的东西"),
            ("867份底稿 · 923处引注", "1294万字消化成10万字"),
            ("拆成15章", "30年打法全复盘 · 免费试读"),
        ],
    },
    # 1012 蓝皮书正式发售 (五卷74章/50.1万字/737页; 判断三件套/数字可回查)
    "bluebook_v1": {
        "title": "一本卖一万块的EPC蓝皮书",
        "desc": ("工程总承包这门生意，金额大、链条长、口径乱。我们用"
                 "五卷74章、50.1万字、737页，把它做成了一本每个数字"
                 "都能回查的行业底账——28家标杆企业逐家开底账，17省"
                 "逐省盘机会，20条预判条条带验证口径。总序+完整目录"
                 "免费试读。"),
        "desc_tags": ["EPC", "蓝皮书", "工程总承包", "行业底账"],
        "frames": [
            ("卖一万块", "这本EPC蓝皮书凭什么"),
            ("口径乱", "金额大 · 链条长 · 数字打架"),
            ("737页成书", "五卷74章 · 每个数字可回查"),
            ("28家标杆 · 17省机会", "完整目录免费试读"),
        ],
    },
    # 1015 BID26 招投标合规指南上线
    "bid26_v1": {
        "title": "2026招投标新规齐爆",
        "desc": ("三份新规同日施行，围串标罚款从千分之五提至百分之十。"
                 "我们用2834万字调研弹药，写成12章8万字合规操作手册。"
                 "100+处罚案例全数据，2026六大新规逐条拆解。"
                 "第1章免费试读。"),
        "desc_tags": ["招投标", "EPC", "合规", "2026新规"],
        "frames": [
            ("三份新规", "同日施行"),
            ("罚款提至10%", "串标追责终身化"),
            ("12章8万字", "100+处罚案例全数据"),
            ("2026六大新规", "逐条拆解 · 免费试读"),
        ],
    },
    "bid26_v2": {
        "title": "审计署点名83亿违规",
        "desc": ("审计署发现12省120个项目违规招标83亿。"
                 "2026年招投标合规红线全面收紧：追责情形扩至98种，"
                 "重大决策终身问责。你的企业准备好合规体系了吗？"
                 "12章指南帮你画好红线。"),
        "desc_tags": ["审计署", "招投标", "合规", "EPC"],
        "frames": [
            ("83亿违规", "审计署点名12省"),
            ("追责98种", "终身问责写入新规"),
            ("12章指南", "合规红线全画清"),
            ("ISO 37301体系", "从标准到落地 · 免费试读"),
        ],
    },
    # 1021 水利水电EPC风险报告 (SLSD-RISK-2026, 12章/12.98万字/94页/¥598;
    # 事实: 2024水利投资13529亿/46967项目/41项重大工程/水电43595万kW)
    "slsd_v1": {
        "title": "一个汛期决定一份EPC生死",
        "desc": ("水利工程EPC的风险不在施工在耦合：导流度汛、生态移民、"
                 "索赔证据拴在一条责任链上。12章·12.98万字研究报告，七环"
                 "风险链逐环拆解，数字全部官方口径可回查。公众号可试读。"),
        "desc_tags": ["水利水电", "EPC", "风险管理", "导流度汛"],
        "frames": [
            ("13529亿水利投资", "2024年 · 官方口径"),
            ("46967个项目在建", "风险不在施工 在耦合"),
            ("导流·度汛·移民·索赔", "一条责任链上的七环"),
            ("12章 · 12.98万字", "每个数字可回查 · 公众号可试读"),
        ],
    },
    "slsd_v2": {
        "title": "水利水电EPC风险地图",
        "desc": ("全生命周期12章风险地图：前期勘察、招标计价、设计接口、"
                 "地质水文、融资汇率、分包供应链。风险按控制能力与可计价"
                 "程度分配，报告给出风险台账+预警阈值+应急演练框架。"),
        "desc_tags": ["风险地图", "EPC", "水利水电", "研究报告"],
        "frames": [
            ("12类风险域", "全生命周期 一章一域"),
            ("原因→触发→事件→后果", "→控制→证据→责任"),
            ("风险台账+预警阈值", "变更索赔证据链闭环"),
            ("94页 · 12.98万字", "风险地图 · 公众号可试读"),
        ],
    },
    "slsd_v3_h3": {
        "title": "一份水利水电EPC风险底账",
        "desc": ("2024年水利投资13529亿元、46967个项目——水利水电工程EPC"
                 "总承包风险管理研究报告12章：从政策监管到地质水文极端天气，"
                 "七环风险链治理框架，官方口径交叉核验。今日上架，摘要+第1章"
                 "免费试读。"),
        "desc_tags": ["水利水电", "EPC", "风险治理", "深度报告"],
        "frames": [
            ("13529亿 · 46967个项目", "2024水利建设官方口径"),
            ("七环风险链", "从原因到责任全链闭环"),
            ("12章 · 12.98万字", "水电装机43595万千瓦背景下"),
            ("今日上架", "摘要+第1章免费试读 · 公众号"),
        ],
    },
}


def _font(size: int, bold: bool = False):
    from PIL import ImageFont
    cands = [
        r"C:\Windows\Fonts\msyhbd.ttc" if bold else r"C:\Windows\Fonts\msyh.ttc",
        r"C:\Windows\Fonts\msyh.ttf",
        r"C:\Windows\Fonts\simhei.ttf",
    ]
    for c in cands:
        if Path(c).exists():
            return ImageFont.truetype(c, size)
    return ImageFont.load_default()


def _wrap(draw, text: str, font, max_w: int) -> list[str]:
    lines, cur = [], ""
    for ch in text:
        if draw.textlength(cur + ch, font=font) <= max_w:
            cur += ch
        else:
            lines.append(cur)
            cur = ch
    if cur:
        lines.append(cur)
    return lines


def _card(head: str, sub: str) -> "Image":
    from PIL import Image, ImageDraw
    img = Image.new("RGB", (W, H), INK)
    d = ImageDraw.Draw(img)
    # 装饰圆环 (品牌视觉)
    d.ellipse([W - 320, -320, W + 240, 240], outline=BRASS, width=2)
    d.ellipse([W - 200, -200, W + 120, 120], outline=(176, 141, 87), width=2)
    # 头部品牌条
    f_brand = _font(44)
    d.text((80, 150), "总 包 智 库", font=f_brand, fill=BRASS)
    # 主文案
    f_head = _font(96, bold=True)
    f_sub = _font(60)
    y = 700
    for ln in _wrap(d, head, f_head, W - 160):
        d.text((80, y), ln, font=f_head, fill=PAPER)
        y += 130
    y += 90
    for ln in _wrap(d, sub, f_sub, W - 160):
        d.text((80, y), ln, font=f_sub, fill=(200, 212, 224))
        y += 92
    # 底部提示
    f_tip = _font(42)
    d.text((80, H - 220), "深度研报 · 免费试读", font=f_tip, fill=MUT)
    return img


def make(slug: str, hold_sec: float = 3.2) -> Path:
    import imageio.v2 as iio
    spec = CARDS[slug]
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    out = OUT_DIR / f"{slug}.mp4"
    frames = [_card(h, s) for h, s in spec["frames"]]
    fps = 24
    n_per = int(hold_sec * fps)
    tmp = Path(tempfile.mkdtemp(prefix="vf_"))
    tmp_files = []
    for i, f in enumerate(frames):
        p = tmp / f"f{i}.png"
        f.save(p)
        tmp_files.append(p)
    wr = iio.get_writer(out, fps=fps, codec="libx264",
                        pixelformat="yuv420p", macro_block_size=2)
    # 首帧前加 0.4s 黑场淡入感 (直接重复首帧即可, 简单可靠)
    for i, p in enumerate(tmp_files):
        img = iio.imread(p)
        for _ in range(n_per):
            wr.append_data(img)
    wr.close()
    for p in tmp_files:
        p.unlink()
    tmp.rmdir()
    # 伴生 meta (uploader 消费)
    import json
    meta = OUT_DIR / f"{slug}.json"
    meta.write_text(json.dumps(
        {"title": spec["title"], "desc": spec.get("desc", ""),
         "tags": spec["desc_tags"],
         "video": out.name}, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[video] {out} ({out.stat().st_size//1024}KB, "
          f"{len(frames)}卡×{hold_sec}s) + meta {meta.name}")
    return out


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("cmd", choices=["make", "list"])
    ap.add_argument("--slug", default="")
    ap.add_argument("--hold", type=float, default=3.2)
    ns = ap.parse_args()
    if ns.cmd == "list":
        for k, v in CARDS.items():
            print(f"{k}: {v['title'][:40]} ({len(v['frames'])} 卡)")
        return 0
    make(ns.slug or "cnnec_v1", ns.hold)
    return 0


if __name__ == "__main__":
    sys.exit(main())
