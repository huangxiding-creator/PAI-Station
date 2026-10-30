# B级数据集波·收尾台账

生成: 2026-10-26 13:00:38 | 波次: 1026 B级 dataset 桶后续波 (B级接入总账.md §1 「dataset 桶21条·本面待后续波」之收尾件)
前波留痕: 前波子会话 (无Bash工具) 的 notes 件 `wdfeqlm1.output` 已缺失 → 按令走**端点重验**路径, 全部数字以本波实测为准 (零手填).
复刻件: `_btier_ds_download_1026.sh` + `_btier_ds_retry_1026.sh` + `_btier_ds_retry3_1026.sh` (重试链如实保留) | 权威数字源: `_btier_ds_manifest_1026.jsonl`

## 0. 四数 (全实测)
| 数 | 值 | 口径 |
|---|---|---|
| 渠道 | 5 | 4已验LIT渠道 (OpenSanctions/CommonCrawl/Overture/AidData) + OFAC SDN 制裁尽调面 (令⑤) |
| 样本件 | 9 | data/datasets/ 下 5 渠道目录, manifest 去重后实测行数 |
| 样本字节 | 2,821,006 (2821006 B) | 9件实测字节数之和; 大件只取头样本 (64KB/32KB/512KB Range实测206) |
| 腿骨架 | 5/5 | *_ds_leg.py 编译门全绿 (py -3 -m py_compile), 实跑入池+台账行见 §4/§5 |

## 1. LIT 端点复验账 (curl 实测, 日志原样)

- `https://data.opensanctions.org/datasets/latest/index.json|200`
- `https://index.commoncrawl.org/collinfo.json|200`
- `https://overturemaps-us-west-2.s3.amazonaws.com/?list-type=2&max-keys=1|200`
- `https://api.github.com/repos/aiddata/gcdf-geospatial-data|200`
- `最新cdx-api=https://index.commoncrawl.org/CC-MAIN-2026-43-index`
- `首Key=bridgefiles/2025-03-19.0-beta.0/dataset=Esri Community Maps/theme=buildings/type=building/part-00000`
- `version.txt内容=[gcdf_v3-2023_12_04_13_25]`

## 2. 下载账 (9件, 每件字节+md5 实测; 去重取末次)

| 渠道 | 文件 (data/datasets/…) | 字节 | cap | trunc | md5 | http | 通道 |
|---|---|---|---|---|---|---|---|
| aiddata | aiddata/100.geojson | 25,969 | 0 | 0 | `662461d268d98e6f1d68f81472355cf3` | 200 | direct |
| aiddata | aiddata/version.txt | 25 | 0 | 0 | `e69aacc80450a01879827ebafe62eafa` | 200 | direct |
| commoncrawl | commoncrawl/cdx_sample.example.com.jsonl | 2,304 | 0 | 0 | `c2032b9597db0ab12e18df6ebe81a6f2` | 200 | direct |
| commoncrawl | commoncrawl/collinfo.json | 35,501 | 0 | 0 | `c049df45cb3d6b67b2100ada5f3b42f6` | 200 | direct |
| ofac_sdn | ofac_sdn/sdn.xml.head512k | 524,288 | 524288 | 0 | `4004b1106ecb0d3584c79b8c9b2fa4fb` | 206 | direct |
| opensanctions | opensanctions/index.json | 2,122,685 | 0 | 0 | `3c7a411bd8144629819d17f9f6bb952b` | 200 | direct |
| opensanctions | opensanctions/us_ofac_sdn.ftm.json.head64k | 65,536 | 65536 | 0 | `91f0559c4c9b9da66f57f323d44cd0fb` | 206 | direct |
| overture | overture/bridgefile.head32k.parquet | 32,768 | 32768 | 0 | `61a0f961c48015807f845d9f512b33d5` | 206 | direct |
| overture | overture/bucket_list.maxkeys25.xml | 11,930 | 0 | 0 | `ac294d97cf9f9316eb4ee25ce936a5fc` | 200 | direct |

原委如实: ① ftm.json 初判路径 `/datasets/latest/us_ofac_sdn/default/ftm.json` 404 → 从 index.json 解析真链 `/artifacts/us_ofac_sdn/20261026041005-bhx/entities.ftm.json` (整库 53,283,878 字节实测 200, 只入盘头 64KB); ② Overture 首 Key 含空格需 %20 编码; ③ treasury 302→sanctionslistservice→S3 预签名 (整库 29,245,041 字节实测 200, 只入盘头 512KB). 三坑全部留痕于重试脚本与日志.

## 3. 渠道卡 (5渠道)

### OpenSanctions (`opensanctions`)
- 端点: `https://data.opensanctions.org/datasets/latest/index.json`
- 样本: opensanctions/index.json=2,122,685B; opensanctions/us_ofac_sdn.ftm.json.head64k=65,536B
- 腿: `reforge_factory/legs/opensanctions_ds_leg.py` (7,555B, 编译绿; 本地查询面照 warehouse_leg 模式) | 引擎=`opensanctions_ds`
- 并存: batch1025 登记薄壳 `opensanctions_leg.py` (远程探针面) 不动不删, 数据集形态腿为新增件
- 待令面: 整库gz大批量直下; datasets目录共492个数据集(index.json实测计数)

### Common Crawl (`commoncrawl`)
- 端点: `https://index.commoncrawl.org/collinfo.json`
- 样本: commoncrawl/collinfo.json=35,501B; commoncrawl/cdx_sample.example.com.jsonl=2,304B
- 腿: `reforge_factory/legs/commoncrawl_ds_leg.py` (7,017B, 编译绿; 本地查询面照 warehouse_leg 模式) | 引擎=`commoncrawl_ds`
- 并存: batch1025 登记薄壳 `common_crawl_2_leg.py` (远程探针面) 不动不删, 数据集形态腿为新增件
- 待令面: 整爬WET/WARC S3直下; 滚动最新lid待接(薄壳钉2024-33, 本波实测最新=CC-MAIN-2026-43)

### Overture Maps Foundation (`overture`)
- 端点: `https://overturemaps-us-west-2.s3.amazonaws.com`
- 样本: overture/bucket_list.maxkeys25.xml=11,930B; overture/bridgefile.head32k.parquet=32,768B
- 腿: `reforge_factory/legs/overture_ds_leg.py` (6,737B, 编译绿; 本地查询面照 warehouse_leg 模式) | 引擎=`overture_ds`
- 并存: batch1025 登记薄壳 `overture_maps_foundation_leg.py` (远程探针面) 不动不删, 数据集形态腿为新增件
- 待令面: 主题整库parquet直下; Azure镜像待令

### AidData GeoGCDF (`aiddata`)
- 端点: `raw.githubusercontent.com/aiddata/gcdf-geospatial-data`
- 样本: aiddata/version.txt=25B; aiddata/100.geojson=25,969B
- 腿: `reforge_factory/legs/aiddata_gcdf_ds_leg.py` (7,081B, 编译绿; 本地查询面照 warehouse_leg 模式) | 引擎=`aiddata_gcdf_ds`
- 并存: batch1025 登记薄壳 `aiddata_leg.py` (远程探针面) 不动不删, 数据集形态腿为新增件
- 待令面: 整库geojsons(上千项目id)直下; aiddata.org数据集面待接

### OFAC SDN 制裁名单(海外合规尽调底线) (`ofac_sdn`)
- 端点: `treasury.gov/ofac/downloads/sdn.xml`
- 样本: ofac_sdn/sdn.xml.head512k=524,288B
- 腿: `reforge_factory/legs/ofac_sdn_ds_leg.py` (7,734B, 编译绿; 本地查询面照 warehouse_leg 模式) | 引擎=`ofac_sdn_ds`
- 并存: batch1025 登记薄壳 `ofac_sdn_leg.py` (远程探针面) 不动不删, 数据集形态腿为新增件
- 待令面: 整库sdn.xml(29,245,041字节实测)全量+sdn.csv面待令

## 4. 腿实跑账 (本地样本查询→入池, 引擎=渠道别名)

| 引擎 | 查询 | 产出 |
|---|---|---|
| opensanctions_ds | us_ofac_sdn 数据集卡片 | 1查询/1件1,294字入池 |
| commoncrawl_ds | Common Crawl 最新爬 | 1查询/1件404字入池 |
| overture_ds | Overture 清单 | 1查询/1件400字入池 |
| aiddata_gcdf_ds | AidData 版本; 100.geojson 样本 | 2查询/2件1,059字入池 |
| ofac_sdn_ds | OFAC 制裁名单 样本 | 1查询/1件303字入池 |

## 5. channel_matrix 别名登记

- 件: `reforge_factory/completeness/channel_matrix.py` CHANNEL_ALIASES 只增 5 键 (opensanctions/common_crawl/overture_maps/aiddata/ofac_sdn, 涵盖 *_ds 引擎标签)
- 备份先行: `channel_matrix.py.bak_1026_pre_btier_ds`
- 注: 5 渠道尚未入 named_channels (分母28/39), 建渠走 T-015 — 别名先注册防 by_engine 漏记, 渠道命名后即自动点亮.

## 6. 铁律对账

- 只增不删: 全程零删除既有文件 (batch1025 薄壳/旧台账原样; 新增件清单见下); 唯一删除=脚本自建 `.dl` 临时件 (秒级自清, 含解析bug导致的3次全量重下临时件).
- 数字零造假: 本台账一切字节数/md5/HTTP码/行数来自 `_btier_ds_manifest_1026.jsonl` 与日志实测; 腿入池字数来自 ammo_pool 回执.
- 大件只样本: 64KB/32KB/512KB 头样本; 整库体积 (53MB/29MB/4.1MB) 仅实测留痕不入盘.
- 密钥无涉: 5 渠道全部免登录直下, 零密钥零浏览器.

新增件清单: data/datasets/{opensanctions,commoncrawl,overture,aiddata,ofac_sdn}/ (9件) + legs/*_ds_leg.py (5件) + channels_survey_2026/{_btier_ds_download_1026.sh,_btier_ds_retry_1026.sh,_btier_ds_retry3_1026.sh,_btier_ds_manifest_1026.jsonl,_gen_btier_ds_ledger_1026.py,btier_dataset_ledger.md} + completeness/channel_matrix.py (只增5别名, bak先行) + ammo_pool/EPC-JIAGE/channel_invocations.jsonl (5行只增)
