# -*- coding: utf-8 -*-
"""W4 KB宣传文+海报描述生成器。

用法:
  py -X utf8 tools/kb_promo_gen.py --sku KB-SUBCON-2026 \
      --package E:/AI-Station/data/kb_packages/KB-SUBCON-2026/package.json \
      [--outdir 输出目录] [--poster-only] [--check-only]

产出(默认 E:/AI-Station/data/kb_promo/<sku>/):
  <sku>_release.md   发布版宣传文（标题模板: 发布| {name}（{file_count}件/{size}GB原始弹药））
  <sku>_pain.md      痛点版宣传文
  <sku>_case.md      案例版宣传文
  <sku>_poster.txt   海报描述文本（给小程序海报引擎）
  <sku>_poster.json  海报描述结构化版

硬门(不过即exit 1, 零造假):
  - 标题 UTF-8 字节数 ≤ 64B
  - 正文去空白字符数 ≥ 2000
每篇必含: KB描述 + 定价 + 小程序导流 + 末尾海报图引用。
"""
import argparse
import json
import re
import sys
from pathlib import Path

DEFAULT_PKG_DIR = Path("E:/AI-Station/data/kb_packages")
DEFAULT_OUT_ROOT = Path("E:/AI-Station/data/kb_promo")

TITLE_MAX_BYTES = 64
BODY_MIN_CHARS = 2000


# ---------------------------------------------------------------- 工具
def byte_len(s: str) -> int:
    return len(s.encode("utf-8"))


def solid_len(s: str) -> int:
    """去空白字符数（含全角空格/换行/markdown符号保留）。"""
    return len(re.sub(r"\s+", "", s))


def gate(article: str, angle: str, sku: str) -> str:
    lines = [ln for ln in article.splitlines() if ln.strip()]
    title = lines[0].lstrip("# ").strip()
    body = "\n".join(lines[1:])
    tb, cb = byte_len(title), solid_len(body)
    problems = []
    if tb > TITLE_MAX_BYTES:
        problems.append(f"标题{tb}B>{TITLE_MAX_BYTES}B")
    if cb < BODY_MIN_CHARS:
        problems.append(f"正文{cb}字<{BODY_MIN_CHARS}字")
    if problems:
        sys.exit(f"[exit1] {sku}/{angle} 未过门: {'; '.join(problems)}")
    return title


# ---------------------------------------------------------------- 模板
def tpl_release(c: dict) -> tuple[str, str]:
    title = f"发布| {c['name']}（{c['file_count']}件/{c['size']}GB原始弹药）"
    hl = "\n".join(f"- {h}" for h in c["highlights"])
    users = "\n".join(f"- **{u[0]}**：{u[1]}" for u in c["target_users"])
    body = f"""出品：总包创研院研究团队

> {c['report_name']}写完90万字、350+页上架之后，很多人问：报告引用的判例切片、跨池语料、行业文献能不能整库给我们？今天给答案——{c['name']}正式发布：{c['file_count']}件、约{c['size']}GB、{c['total_chars_yi']}亿字原始弹药，与报告同源同锚，每一个案号可回溯。

## 这个知识库从哪里来：一份旗舰报告背后的调研战役

总包创研院的旗舰报告不是先写后查，而是先打一场调研战役再动笔。《{c['report_name']}》立项时，T1弹药战役同步开打：判决年卷按分包界面族切片——总分包界面纠纷、转包与违法分包、挂靠与借用资质、劳务分包、专业分包、分包合同纠纷、连带责任、分包资质、指定分包、分包结算、分包安全责任、国际分包，{c['volumes']}卷整卷切出；再叠加跨池收割（{c['crosspool_note']}）与行业库（{c['industry_note']}）。报告的每一个判例锚号、每一条裁判口径，背后都是这套弹药。现在，报告的知识库版把这场战役的原始弹药全量整理上架——报告管「读懂规则」，知识库管「查到原文」。

## 里面有什么：判例切片+跨池收割+行业库

三大件结构，{c['file_count']}件弹药按卷册编目：

{hl}

判决切片卷是主体：每一卷对应一个界面族，按年序排列的裁判文书语料切片，口径的演变、地域的分化、支持与否定的对比，逐卷可查。跨池收割补交叉场景——{c['crosspool_note']}，同一项目类型下的总分包界面交叉语料直接对照。行业库收全族文献——{c['industry_note']}。全部{c['total_chars_yi']}亿字为实测口径（战役池台账在册），不是估值、不是宣传数。

弹药不是散装堆放，而是按蓝图编目管理：每卷有卷册号与界面族主题，每件有台账记录与来源引擎标记（判决切片、跨池收割、行业库三路来源在册），蓝图即总目录——这也是「GB种子免费」的含义：目录结构永久免费开放，正文弹药按整库交付。

## 谁该用它

{users}

一句话：凡是要在总分包界面上做判断的人——写合同的、审合同的、打官司的、管分包的——这套库都是案头的弹药基座。

## 怎么用：三步上手法

第一步看蓝图：免费编目蓝图把{c['volumes']}卷切片、跨池件、行业库件的目录全部摊开，先确认自己关心的界面族在哪几卷；第二步整卷调取：找到族就找到卷，按年序通读裁判口径的演变，再用报告锚号在语料原文与《{c['report_name']}》章节之间双向跳转；第三步沉淀成自己的作业文件——把高频卷的口径摘成要点清单，写进分包合同评审表与界面交底单，弹药变成制度。三步走完，这套库就从「买了一堆语料」变成「案头的总分包界面裁判手册」。

## 三个常问的问题

问：和直接买报告有什么区别？答：报告是{c['report_chars']}万字的认知框架，知识库是{c['total_chars_yi']}亿字的原始弹药；读报告建立判断体系，用知识库查具体口径与原文，两者同锚互补。问：语料会不会很快过期？答：判决年卷按年序累积，行业库随规范更新滚动增补，蓝图版本可查。问：买完怎么拿货？答：邮箱自动交付，百度网盘链接+提取码即买即到，转存后离线可用。

## 免费蓝图与定价

按总包创研院的交付纪律：{c['blueprint_note']}。整库交付价¥{c['price']}——蓝图先看，结构满意再下单，绝不让任何人盲买。与《{c['report_name']}》（¥{c['report_price']}）配对使用效果最佳：报告建立认知框架，知识库提供检索弹药。

## 怎么买（三步，即买即得）

第一步，微信搜索「{c['miniprogram']}」小程序，进入知识库专区；第二步，找到{c['name']}，先看免费编目蓝图，确认卷册结构后下单支付；第三步，系统自动把百度网盘分享链接和提取码发送到你填写的邮箱——付款完成即到货，无需等待人工处理。

## 数字卡速览

| 维度 | 口径 |
| --- | --- |
| 弹药规模 | {c['file_count']}件 / 约{c['size']}GB / {c['total_chars_yi']}亿字（实测） |
| 结构 | 判决切片{c['volumes']}卷 + 跨池收割 + 行业库 |
| 来源 | 《{c['report_name']}》T1调研战役池 |
| 蓝图 | 免费编目蓝图（GB种子钉死免费） |
| 定价 | 整库¥{c['price']}，邮箱自动交付 |

数字零造假：以上规模数字全部来自战役池实测台账，编目蓝图里每卷每件可点验。判断留给读者，依据全部给足。

![总包创研院·知识库海报]({c['poster']})"""
    return title, body


def tpl_pain(c: dict) -> tuple[str, str]:
    title = f"总包的账，分包来结——{c['name']}上线"
    pains = "\n\n".join(
        f"### 痛点{chr(ord('一') + i)}：{p[0]}\n\n{p[1]}" for i, p in enumerate(c["pain_points"])
    )
    users = "、".join(u[0] for u in c["target_users"])
    body = f"""出品：总包创研院研究团队

> EPC总承包的风险，从来不是自己干的活，而是分包干的活。分包的事故就是总包的事故，分包的欠薪就是总包的欠薪，分包的缺陷就是总包的缺陷——{c['name']}今天上线，把这四笔账背后的裁判弹药整卷给你。

{pains}

## 四个痛点，一个解法：按界面族整卷切片的弹药库

这四个痛点没有一个是靠「多注意」能解决的——它们全部是规则问题，而规则问题只能靠裁判口径说话。{c['name']}的做法简单直接：把《{c['report_name']}》调研战役攒下的{c['total_chars_yi']}亿字原始弹药，按分包界面族整卷切片——判决年卷{c['volumes']}卷、跨池收割（{c['crosspool_note']}）、行业库（{c['industry_note']}），共{c['file_count']}件、约{c['size']}GB。想知道连带责任怎么判，翻连带责任卷；想知道背靠背条款能不能站住，翻分包结算卷；想知道转包红线画在哪，翻转包与违法分包卷。痛点在哪个界面族，弹药就在哪一卷。

## 它跟「自己上网搜判例」差在哪

第一差在完整：搜索引擎给的是散点，这里给的是整卷——同一界面族的裁判文书按年序排列，口径演变与地域分化一目了然；第二差在同源：这套弹药就是《{c['report_name']}》（90万字/350+页）的引用底座，报告里每一个锚号都能在库里回溯到原文，查报告与查原文一次打通；第三差在结构：全部弹药按卷册编目蓝图管理，{c['file_count']}件不是一堆文件，是一套有目录、有切片逻辑、可点验的知识库。

## 免费蓝图先行，绝不盲买

{c['blueprint_note']}。整库¥{c['price']}，{users}都值得放到案头。

## 三步拿到手

微信搜索「{c['miniprogram']}」小程序 → 知识库专区找到{c['name']} → 看完免费蓝图下单；支付完成后系统自动把百度网盘分享链接+提取码发到你填写的邮箱，即买即得。别等下一场分包纠纷找上门才想起来查口径——弹药先入库，判断才有底。

![总包创研院·知识库海报]({c['poster']})"""
    return title, body


def tpl_case(c: dict) -> tuple[str, str]:
    title = f"背靠背攻防——{c['name']}（判例弹药）"
    cases = "\n\n".join(
        f"### 场景{chr(ord('一') + i)}：{case[0]}\n\n要查什么：{case[1]}。在{c['name']}里对应卷册直接整卷调取，按年序比对裁判口径的演变与分化，报告锚号与语料原文双向可回溯。"
        for i, case in enumerate(c["case_examples"])
    )
    body = f"""出品：总包创研院研究团队

> 一个真实的检索日常：分包结算谈崩了，对方主张背靠背条款无效，你主张有效——谁也说服不了谁，因为双方手里都只有零星几篇公众号文章。真正的底气来自整卷判例弹药。{c['name']}（{c['file_count']}件/约{c['size']}GB/{c['total_chars_yi']}亿字实测）今天上架，本文用八个高频检索场景走一遍这套库的用法。

{cases}

## 八个场景背后的同一套结构

这八个场景不是八堆文件，而是同一套按界面族切片的体系：判决年卷{c['volumes']}卷为主体，每卷对应一个界面族的裁判文书语料切片；跨池收割补充交叉场景（{c['crosspool_note']}）；行业库（{c['industry_note']}）提供文献层参照。共{c['file_count']}件、约{c['size']}GB、{c['total_chars_yi']}亿字，全部实测口径、台账在册。检索的时候不需要关键词碰运气——界面族就是目录，找到族就找到卷，找到卷就整卷可用。

## 证据纪律：为什么敢说「可回溯」

这套弹药是《{c['report_name']}》（90万字/350+页/¥{c['report_price']}）的调研底座。报告撰写时立了一条铁规：每一个案号、金额、文号都必须能按锚号回溯核验，350页里没有一句「据介绍」。知识库沿用同一条铁规：卷册编目、件数字号、切片口径全部入蓝图，蓝图免费开放——{c['blueprint_note']}。买前点验，买后查证，全程有据。

## 谁在用这套库

{chr(10).join(f'- {u[0]}：{u[1]}' for u in c['target_users'])}

## 定价与购买流程

整库¥{c['price']}，编目蓝图免费。购买三步：微信搜索「{c['miniprogram']}」小程序 → 知识库专区找到{c['name']}、看完免费蓝图下单 → 系统自动将百度网盘分享链接+提取码发至你填写的邮箱，即买即得。判例攻防的胜负，往往在开庭前就被弹药储备决定了——把整卷弹药放进自己的网盘，是从「零星检索」升级到「整卷作战」的最短路径。

![总包创研院·知识库海报]({c['poster']})"""
    return title, body


def tpl_poster(c: dict) -> tuple[str, str]:
    txt = f"""【KB名称】{c['name']}
【SKU】{c['sku']}
【规模】{c['file_count']}件 / 约{c['size']}GB / {c['total_chars_yi']}亿字（实测口径）
【核心亮点】判决切片{c['volumes']}卷+跨池收割+行业库，与《{c['report_name']}》同源同锚可回溯
【蓝图】编目蓝图免费（GB种子钉死免费）
【定价】¥{c['price']}
【购买】微信搜索「{c['miniprogram']}」小程序 → 知识库专区 → 下单即发百度网盘链接至邮箱
【出品】总包创研院"""
    js = {
        "sku": c["sku"], "name": c["name"],
        "file_count": c["file_count"], "size_gb": c["size"],
        "total_chars": c["total_chars"], "volumes": c["volumes"],
        "highlights": c["highlights"], "blueprint_free": True,
        "price": c["price"], "miniprogram": c["miniprogram"],
        "publisher": "总包创研院", "poster_image": c["poster"],
    }
    return txt, js


# ---------------------------------------------------------------- 上下文
def build_ctx(pkg: dict) -> dict:
    c = dict(pkg)
    c["total_chars_yi"] = f"{pkg['total_chars'] / 1e8:.2f}".rstrip("0").rstrip(".")
    for k in ("file_count", "volumes", "price", "report_price"):
        c[k] = pkg[k]
    c["size"] = f"{pkg['size_gb']:g}"
    return c


def main() -> int:
    ap = argparse.ArgumentParser(description="KB宣传文+海报描述生成器")
    ap.add_argument("--sku", required=True)
    ap.add_argument("--package", help="package.json 路径（缺省找 data/kb_packages/<sku>/package.json）")
    ap.add_argument("--outdir", help="输出目录（缺省 data/kb_promo/<sku>/）")
    ap.add_argument("--poster-only", action="store_true", help="只生成海报描述")
    ap.add_argument("--check-only", action="store_true", help="只校验门, 不落盘")
    args = ap.parse_args()

    pkg_path = Path(args.package) if args.package else DEFAULT_PKG_DIR / args.sku / "package.json"
    if not pkg_path.is_file():
        sys.exit(f"[exit1] package 不存在: {pkg_path}")
    pkg = json.loads(pkg_path.read_text(encoding="utf-8-sig"))
    if pkg.get("sku") and pkg["sku"] != args.sku:
        sys.exit(f"[exit1] SKU不一致: 参数={args.sku} package={pkg['sku']}")
    c = build_ctx(pkg)

    outdir = Path(args.outdir) if args.outdir else DEFAULT_OUT_ROOT / args.sku
    angles = {"release": tpl_release, "pain": tpl_pain, "case": tpl_case}
    articles = {k: f"# {t}\n\n{b}" for k, f in angles.items()
                for t, b in [f(c)]}

    results = []
    for angle, text in articles.items():
        title = gate(text, angle, args.sku)  # 不过门即exit
        results.append((angle, title, byte_len(title), solid_len("\n".join(text.splitlines()[1:]))))

    if args.check_only:
        for angle, title, tb, cb in results:
            print(f"[check] {angle}: 标题{tb}B | 正文{cb}字 | {title}")
        return 0

    outdir.mkdir(parents=True, exist_ok=True)
    written = []
    for angle, text in articles.items():
        p = outdir / f"{args.sku}_{angle}.md"
        p.write_text(text, encoding="utf-8")
        written.append(str(p))

    ptxt, pjs = tpl_poster(c)
    poster_txt_path = outdir / f"{args.sku}_poster.txt"
    poster_json_path = outdir / f"{args.sku}_poster.json"
    if not args.poster_only:
        pass  # 全量模式也写海报件（宣传文末尾引用海报, 两件配套产出）
    poster_txt_path.write_text(ptxt, encoding="utf-8")
    poster_json_path.write_text(json.dumps(pjs, ensure_ascii=False, indent=1), encoding="utf-8")

    print(f"[W4] {args.sku} 生成完毕 → {outdir}")
    for angle, title, tb, cb in results:
        print(f"  - {angle}: 标题{tb}B/≤64B | 正文{cb}字/≥{BODY_MIN_CHARS} | {title}")
    print(f"  - poster: {poster_txt_path.name} + {poster_json_path.name} (海报引擎就绪)")
    return 0


if __name__ == "__main__":
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")
    sys.exit(main())
