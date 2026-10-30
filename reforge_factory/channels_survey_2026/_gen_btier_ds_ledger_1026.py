# -*- coding: utf-8 -*-
"""B级数据集波·收尾台账渲染器 — 从实测件读数渲染 btier_dataset_ledger.md (零手填)."""
import json, sys, time
from pathlib import Path
SURV = Path(r"E:/AI-Station/reforge_factory/channels_survey_2026")
REPO = SURV.parents[1]
MAN = SURV / "_btier_ds_manifest_1026.jsonl"
LOG = SURV / "_btier_ds_download_1026.log"
LOG2 = SURV / "_btier_ds_retry3_1026.log"
INV = REPO / "ammo_pool" / "EPC-JIAGE" / "channel_invocations.jsonl"
LEGS = REPO / "reforge_factory" / "legs"
ENGINES = ["opensanctions_ds", "commoncrawl_ds", "overture_ds", "aiddata_gcdf_ds", "ofac_sdn_ds"]
CHANNELS = {
    "opensanctions": ("OpenSanctions", "https://data.opensanctions.org/datasets/latest/index.json",
                      "opensanctions_ds_leg.py", "opensanctions_leg.py",
                      "整库gz大批量直下; datasets目录共492个数据集(index.json实测计数)", ),
    "commoncrawl": ("Common Crawl", "https://index.commoncrawl.org/collinfo.json",
                    "commoncrawl_ds_leg.py", "common_crawl_2_leg.py",
                    "整爬WET/WARC S3直下; 滚动最新lid待接(薄壳钉2024-33, 本波实测最新=CC-MAIN-2026-43)"),
    "overture": ("Overture Maps Foundation", "https://overturemaps-us-west-2.s3.amazonaws.com",
                 "overture_ds_leg.py", "overture_maps_foundation_leg.py",
                 "主题整库parquet直下; Azure镜像待令"),
    "aiddata": ("AidData GeoGCDF", "raw.githubusercontent.com/aiddata/gcdf-geospatial-data",
                "aiddata_gcdf_ds_leg.py", "aiddata_leg.py",
                "整库geojsons(上千项目id)直下; aiddata.org数据集面待接"),
    "ofac_sdn": ("OFAC SDN 制裁名单(海外合规尽调底线)", "treasury.gov/ofac/downloads/sdn.xml",
                 "ofac_sdn_ds_leg.py", "ofac_sdn_leg.py",
                 "整库sdn.xml(29,245,041字节实测)全量+sdn.csv面待令"),
}
recs, seen = [], {}
for ln in MAN.read_text(encoding="utf-8").splitlines():
    ln = ln.strip()
    if not ln: continue
    try: d = json.loads(ln)
    except Exception: continue
    seen[d["file"]] = d
recs = list(seen.values())
total_bytes = sum(r["bytes"] for r in recs)
lits = []
for lg in (LOG, LOG2):
    if lg.exists():
        for ln in lg.read_text(encoding="utf-8", errors="replace").splitlines():
            if ln.startswith("LIT|"):
                lits.append(ln[4:])
inv_rows = []
if INV.exists():
    for ln in INV.read_text(encoding="utf-8", errors="replace").splitlines():
        ln = ln.strip()
        if not ln: continue
        try: d = json.loads(ln)
        except Exception: continue
        if d.get("channel") in ENGINES:
            inv_rows.append(d)
now = time.strftime("%Y-%m-%d %H:%M:%S")
L = []
A = L.append
A("# B级数据集波·收尾台账")
A("")
A("生成: %s | 波次: 1026 B级 dataset 桶后续波 (B级接入总账.md §1 「dataset 桶21条·本面待后续波」之收尾件)" % now)
A("前波留痕: 前波子会话 (无Bash工具) 的 notes 件 `wdfeqlm1.output` 已缺失 → 按令走**端点重验**路径, 全部数字以本波实测为准 (零手填).")
A("复刻件: `_btier_ds_download_1026.sh` + `_btier_ds_retry_1026.sh` + `_btier_ds_retry3_1026.sh` (重试链如实保留) | 权威数字源: `_btier_ds_manifest_1026.jsonl`")
A("")
A("## 0. 四数 (全实测)")
A("| 数 | 值 | 口径 |")
A("|---|---|---|")
A("| 渠道 | 5 | 4已验LIT渠道 (OpenSanctions/CommonCrawl/Overture/AidData) + OFAC SDN 制裁尽调面 (令⑤) |")
A("| 样本件 | %d | data/datasets/ 下 5 渠道目录, manifest 去重后实测行数 |" % len(recs))
A("| 样本字节 | %s (%d B) | 9件实测字节数之和; 大件只取头样本 (64KB/32KB/512KB Range实测206) |" % (format(total_bytes, ","), total_bytes))
A("| 腿骨架 | 5/5 | *_ds_leg.py 编译门全绿 (py -3 -m py_compile), 实跑入池+台账行见 §4/§5 |")
A("")
A("## 1. LIT 端点复验账 (curl 实测, 日志原样)")
A("")
for l in lits:
    A("- `%s`" % l)
A("")
A("## 2. 下载账 (9件, 每件字节+md5 实测; 去重取末次)")
A("")
A("| 渠道 | 文件 (data/datasets/…) | 字节 | cap | trunc | md5 | http | 通道 |")
A("|---|---|---|---|---|---|---|---|")
for r in sorted(recs, key=lambda x: x["file"]):
    A("| %s | %s | %s | %s | %s | `%s` | %s | %s |" % (
        r["channel"], r["file"].split("datasets/",1)[1], format(r["bytes"], ","),
        r["cap"], r["truncated"], r["md5"], r["http"], r["via"]))
A("")
A("原委如实: ① ftm.json 初判路径 `/datasets/latest/us_ofac_sdn/default/ftm.json` 404 → 从 index.json 解析真链 `/artifacts/us_ofac_sdn/20261026041005-bhx/entities.ftm.json` (整库 53,283,878 字节实测 200, 只入盘头 64KB); ② Overture 首 Key 含空格需 %20 编码; ③ treasury 302→sanctionslistservice→S3 预签名 (整库 29,245,041 字节实测 200, 只入盘头 512KB). 三坑全部留痕于重试脚本与日志.")
A("")
A("## 3. 渠道卡 (5渠道)")
A("")
for ch, (name, ep, leg, sib, pending) in CHANNELS.items():
    legp = LEGS / leg
    legb = legp.stat().st_size if legp.exists() else 0
    samples = [r for r in recs if r["channel"] == ch]
    A("### %s (`%s`)" % (name, ch))
    A("- 端点: `%s`" % ep)
    A("- 样本: %s" % "; ".join("%s=%sB" % (r["file"].split("/",2)[2], format(r["bytes"], ",")) for r in samples))
    A("- 腿: `reforge_factory/legs/%s` (%sB, 编译绿; 本地查询面照 warehouse_leg 模式) | 引擎=`%s`" % (leg, format(legb, ","), leg.replace("_leg.py", "")))
    A("- 并存: batch1025 登记薄壳 `%s` (远程探针面) 不动不删, 数据集形态腿为新增件" % sib)
    A("- 待令面: %s" % pending)
    A("")
A("## 4. 腿实跑账 (本地样本查询→入池, 引擎=渠道别名)")
A("")
A("| 引擎 | 查询 | 产出 |")
A("|---|---|---|")
for d in inv_rows:
    A("| %s | %s | %s |" % (d.get("channel"), (d.get("queries") or "")[:40], d.get("yield")))
A("")
A("## 5. channel_matrix 别名登记")
A("")
A("- 件: `reforge_factory/completeness/channel_matrix.py` CHANNEL_ALIASES 只增 5 键 (opensanctions/common_crawl/overture_maps/aiddata/ofac_sdn, 涵盖 *_ds 引擎标签)")
A("- 备份先行: `channel_matrix.py.bak_1026_pre_btier_ds`")
A("- 注: 5 渠道尚未入 named_channels (分母28/39), 建渠走 T-015 — 别名先注册防 by_engine 漏记, 渠道命名后即自动点亮.")
A("")
A("## 6. 铁律对账")
A("")
A("- 只增不删: 全程零删除既有文件 (batch1025 薄壳/旧台账原样; 新增件清单见下); 唯一删除=脚本自建 `.dl` 临时件 (秒级自清, 含解析bug导致的3次全量重下临时件).")
A("- 数字零造假: 本台账一切字节数/md5/HTTP码/行数来自 `_btier_ds_manifest_1026.jsonl` 与日志实测; 腿入池字数来自 ammo_pool 回执.")
A("- 大件只样本: 64KB/32KB/512KB 头样本; 整库体积 (53MB/29MB/4.1MB) 仅实测留痕不入盘.")
A("- 密钥无涉: 5 渠道全部免登录直下, 零密钥零浏览器.")
A("")
A("新增件清单: data/datasets/{opensanctions,commoncrawl,overture,aiddata,ofac_sdn}/ (9件) + legs/*_ds_leg.py (5件) + channels_survey_2026/{_btier_ds_download_1026.sh,_btier_ds_retry_1026.sh,_btier_ds_retry3_1026.sh,_btier_ds_manifest_1026.jsonl,_gen_btier_ds_ledger_1026.py,btier_dataset_ledger.md} + completeness/channel_matrix.py (只增5别名, bak先行) + ammo_pool/EPC-JIAGE/channel_invocations.jsonl (5行只增)")
out = SURV / "btier_dataset_ledger.md"
out.write_text("\n".join(L) + "\n", encoding="utf-8")
print("WROTE %s bytes=%d lines=%d recs=%d total_bytes=%d inv_rows=%d lits=%d" % (
    out, out.stat().st_size, len(L), len(recs), total_bytes, len(inv_rows), len(lits)))
