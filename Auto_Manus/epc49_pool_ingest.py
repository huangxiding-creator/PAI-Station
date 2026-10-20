# -*- coding: utf-8 -*-
"""EPC49 弹药入账班 v2 — 1004 渠道总动员令 (用户: 所有该入账的引擎都入账).

v1 只扫 10 个约定目录 — 1004 审计实锤 5 处躺盘零计数: 40_洞见研报 21 件
券商研报 / 35_Manus军团 6 件 / 75_RSS本地库 / 31_秘塔视频 / registry 尾巴.
v2 = 全目录自动发现: 02 下所有资料目录显式映射 + 未知目录 fallback
(other:<名>), 一个不漏 (用户完备性令).

规则:
  - 80_本地存量语料跳过 — 门槛语义铁律: 存量不计门槛, 留盘供成稿引用;
  - manus:* 引擎过引用密度门 (反编造, 对齐 epc50_gate): 有效件正文
    http 链接 <2 且无「来源/引用」标记 → 翻 rejected(manus_low_citation),
    翻完 ammo_pool.rebuild 重算账 (manifest=真源, 幂等);
  - 幂等: manifest dedup_key 已入池自动跳过; 早晚双班 (21:37/00:40).
"""
import io
import json
import re
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
import ammo_pool as ap  # noqa: E402
import epc49_topics as T  # noqa: E402

CODE_VERSION = "v6"     # 不跑旧码铁律: 起跑必打横幅, 早验收 grep "[v6]"
# v3 (1004 渠道三决策执行令): +_channel_wenchuanyun(paper:wenchuanyun 全文PDF线)
#   +_channel_wxexporter(wechat:exporter 官微全历史线)
# v4 (1004 渠道整合令): +_channel_zhsearchpro(web:zhsearchpro 检索深读线)
# v5 (1004 白班扩容令): +_channel_websearch_en(web:websearch_en 海外EPC英文线)
# v6 (1004 7渠道补弹归位): +weread/ebook/gbstandard/chinatextbook/pansou/bili 六腿显式映射
#   (statute 腿归 61_政策法规/idle7_statute 吃 official:policy 标签)

BATTLE = T.BATTLE
TWO = [d for d in BATTLE.iterdir() if d.name.startswith("02")][0]

# 目录 → 引擎标签 (显式映射, 与收割器落盘位一一对应; v2 补全全部资料目录)
INGEST_DIRS = {
    "20_微信文章": "wechat:sogou",
    "31_秘塔视频": "video:metaso",
    "32_涉诉风控": "web:risk",
    "35_Manus军团": "manus:corps",
    "40_洞见研报": "research:djyanbao",
    "50_飞书语料": "kb:lark",
    "50_官网资料": "official:website",
    "51_ima知识库": "kb:ima",
    "52_ima公开库": "kb:ima_public",
    "52_官网深挖": "official:deepweb",
    "53_裁判文书": "official:wenshu_vol",
    "54_飞书智库": "kb:lark_zhiku",
    "56_兄弟院": "official:sibling",
    "61_政策法规": "official:policy",
    "70_开放网络": "web:openweb",
    "75_RSS本地库": "rss:local",
    "powerchina": "official:powerchina",
    "rss_local": "rss:local",
    "_opencli_night": "opencli:night",
    # 04 资料根子目录 (1004 总动员: 论文线落点)
    "60_论文学术": "paper:cnki",
    # v3 (1004 三决策): 文献云全文 PDF 线 + 官微全历史导出线
    "_channel_wenchuanyun": "paper:wenchuanyun",
    "_channel_wxexporter": "wechat:exporter",
    # v4 (1004 渠道整合令): zh-search-pro 检索深读线 (webReader 落盘 MD)
    "_channel_zhsearchpro": "web:zhsearchpro",
    # v5 (1004 白班扩容令): WebSearch 海外EPC英文线
    "_channel_websearch_en": "web:websearch_en",
    # v6 (1004 7渠道补弹归位令)
    "_channel_weread": "kb:weread",
    "_channel_ebook": "book:ebook_treasure",
    "_channel_gbstandard": "standard:gbstandard",
    "_channel_chinatextbook": "book:chinatextbook",
    "_channel_pansou": "netdisk:pansou",
    "_channel_video": "video:bili",
}
REGISTRY_PREFIX = "_registry_"

# 跳过: 收割器状态件 / 临时件 / 存量目录 (门槛语义铁律: 存量不计门槛)
SKIP_SUFFIX = {".json", ".tmp", ".crdownload", ".part"}
SKIP_NAME = ("_state_",)
SKIP_DIRS = {"80_本地存量语料"}
# 引用密度门阈值: 正文 http 链接数下限 (低于此且无来源标记 = 疑编造)
MANUS_MIN_LINKS = 2


def iter_files(d: Path):
    for f in sorted(d.rglob("*")):
        if (f.is_file() and f.suffix.lower() not in SKIP_SUFFIX
                and not any(s in f.name for s in SKIP_NAME)):
            yield f


def manus_gate(cid: str) -> int:
    """Manus 军团件引用密度门 (反编造): valid → rejected 翻判 + 账目重建.

    判据对齐 epc50_gate _manus_cited_ok 思路 — 军团产出无引用链 =
    无法核验, 不入门槛账 (弹药等价原则: 渠道资料与军团成果同核验).
    """
    d = ap._camp_dir(cid)
    mp = d / "manifest.jsonl"
    rows = [json.loads(x) for x in
            mp.read_text(encoding="utf-8").splitlines() if x.strip()]
    flipped = 0
    for row in rows:
        if (row.get("judge") == "valid"
                and str(row.get("engine", "")).startswith("manus")):
            fp = Path(row["source_path"])
            text = ap.read_text_safe(fp) if fp.is_file() else ""
            links = len(re.findall(r"https?://", text))
            has_src = any(m in text for m in ("来源", "引用", "参考"))
            if links < MANUS_MIN_LINKS and not has_src:
                row.update(judge="rejected",
                           judge_reason="manus_low_citation")
                flipped += 1
                print(f"[manus门] 翻废弃 (引用密度不足, {links}链): "
                      f"{fp.name[:44]}")
    if flipped:
        tmp = d / "manifest.tmp"
        tmp.write_text("\n".join(json.dumps(r, ensure_ascii=False)
                                 for r in rows) + "\n", encoding="utf-8")
        tmp.replace(mp)
        ap.rebuild(cid)
    print(f"[manus门] 扫 {sum(1 for r in rows if str(r.get('engine', '')).startswith('manus'))} "
          f"军团件, 翻废弃 {flipped}")
    return flipped


def main() -> int:
    print(f"[{CODE_VERSION}] 入账班启动 {time.strftime('%F %T')}",
          flush=True)
    n_ing = n_skip = 0
    seen = set()
    # 1004 总动员: 04 网络调研搜集的资料 = 第二资料根 (CNKI 论文腿落点)
    roots = [TWO] + [d for d in BATTLE.iterdir()
                     if d.name.startswith("04") and d.is_dir()]
    for root in roots:
        for sub in sorted(root.iterdir()):
            if not sub.is_dir() or sub.name in SKIP_DIRS or sub.name.startswith("_pipeline"):
                continue
            seen.add(sub.name)
            if sub.name.startswith(REGISTRY_PREFIX):
                engine = "registry:" + sub.name[len(REGISTRY_PREFIX):]
            else:
                engine = INGEST_DIRS.get(sub.name, "other:" + sub.name)
            if sub.name not in INGEST_DIRS and not sub.name.startswith(REGISTRY_PREFIX):
                print(f"[发现] 未映射目录 {sub.name} → {engine} (完备性令)",
                      flush=True)
            for f in iter_files(sub):
                r = ap.ingest("EPC49-SEPDC", str(f), engine)
                if r == 0:
                    n_ing += 1
                else:
                    n_skip += 1
    print(f"[入账班 {time.strftime('%H:%M')}] 扫 {len(seen)} 目录, "
          f"入池 {n_ing} | 跳过 {n_skip} → 判有效性...", flush=True)
    ap.judge("EPC49-SEPDC")
    manus_gate("EPC49-SEPDC")

    s = json.loads((Path(r"E:\AI-Station\ammo_pool\EPC49-SEPDC")
                    / "pool_state.json").read_text(encoding="utf-8"))
    pct = 100 * s["total_chars"] / 200_000_000
    print(f"[门槛账] 有效弹药 {s['total_chars']:,} 字 "
          f"({pct:.2f}% of 2亿) | 待审 {s['pending_chars']:,} 字 | "
          f"废弃 {s['rejected_chars']:,} 字 | 引擎 {len(s['by_engine'])} 个",
          flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
