# W6 QA 总门汇总表（2026-10-30，全命令面活体终验）

围栏 /API复刻测试_1029/**；qa_gate_tmp 产物保留待用户处置。
23/24 绿（唯一非绿 = transfer 引证行：任务二 errno 2 维持 N/A，非命令面缺陷）。

| # | 命令 | rc | errno | 耗时 | 发数 | 结果摘要 |
|---|------|----|-------|------|------|----------|
| 1 | whoami | 0 | 0 | ~1.1s | 1 | pyeyeye uk=587408217 VIP8(type21) |
| 2 | quota | 0 | 0 | ~1.0s | 1 | 总17.10TB 用12.83TB 余4.28TB |
| 3 | ls / | 0 | 0 | 1.1s | 1 | 18 项（基线17+围栏产物=信息项） |
| 4 | tree fence --depth 1 | 0 | 0 | 1.1s | 1 | 16 节点 1 发 截断=False |
| 5 | search（xpan, key=演讲, num=20） | 0 | 0 | 2.3s | 1 | 命中 20 条 |
| 6 | shares | 0 | 0 | 1.1s | 1 | 43 条记录 |
| 7 | recycle | 0 | 0 | 1.4s | 1 | 100 项（单页满页） |
| 8 | doctor | 0 | 0 | 11.1s | 8 | verdict=ok 8针 漂移1（root 18 vs 17=信息项） |
| 9 | mkdir qa_gate_tmp | 0 | 0 | 1.2s | 1 | 已创建（围栏） |
| 10 | mkdir sub | 0 | 0 | 1.2s | 1 | 已创建 |
| 11 | upload 100KB | 0 | 0 | 4.1s | 3 | size=102400 三段全通（locateupload+precreate+create）数据面1发 |
| 12 | rename | 0 | 0 | 2.5s | 1 | qa_100k.bin → qa_100k_rn.bin |
| 13 | mv | 0 | 0 | 1.3s | 1 | → qa_gate_tmp/sub/ |
| 14 | cp | 0 | 0 | 1.6s | 1 | ondup=newcopy 同名副本落 qa_gate_tmp/ |
| 15 | rm --confirm | 0 | 0 | 2.6s | 2 | 删围栏内副本 1 件进回收站（唯一远端删除） |
| 16 | download+md5 | 0 | 0 | 3.3s | 2 | 100KB 回传，本地 md5 比对 PASS（849d5ef4…==） |
| 17 | meta（upload 回执 fs_id） | 0 | 0 | 1.1s | 1* | fs_id 跨 rename/mv 不变实证；来源 api/filemetas |
| 18 | share-create | 0 | 0 | 1.7s | 1 | shareid=27396886864（1 发即成，qrcodeurl 已清洗归档） |
| 19 | share-cancel | 0 | 0 | 2.1s | 2 | **属主护栏真跑**：records 校验(1)+cancel(1)，自建放行 |
| 20 | share-cancel 护栏负例 | 3 | -9 | 0s | 0 | 离线单测引证（FakeTransport：非自建拒发零 POST rc3） |
| 21 | transfer（引证任务二） | 1 | 2 | 8.1s | ~6 | **N/A 维持**：bdstoken 携带仍 errno 2；蓝本全参（shareid+from）已实装待 W7（ERRATA_1030） |
| 22 | mirror --dry-run | 0 | 0 | 1.1s | 1 | 计划 2 件零上传（remote_scan 1 发 -9=空目标） |
| 23 | mirror 护栏负例（/备份） | 1 | -7 | 0.5s | 0 | 远端目标护栏拦截（零请求，提示 --allow-root） |
| 24 | E1/E2 附行 | — | — | — | 1+2 | E1: pcs 遗产搜索 error_code 形态=退役再证，xpan 维持；E2: 8线程 5.19 vs 4线程 2.15MB/s（+58.6%） |

\* meta 命令 payload 无 requests 自报，台账记 0，实发 1（post_hoc_corrections 在账）。

## 账本（W6 全局真账 50/50 恰在帽内）
- QA 段：CLI 30（二跑 29+meta 修正 1）+ 首跑 3（whoami/quota/ls——文件名 bug 崩于落档，
  断点续档机制零重复）+ 库会话 4（dup 定位 ls 1 + E1 pcs 1 + E2 metas 2）
- 任务二：复测 2 + CLI 链估 6 + 跳级探针 5 = 13
- 硬帽：share create 1/1、cancel 1/1、transfer 1/1；rm 仅围栏内 1 文件；零其他删除
- 数据面单列：upload 1 发/100KB + download 1 发/100KB + E2 6 发/30MB（测完即止）

## 全档清单
cmd_*.json（每命令原始 --json+stderr+耗时）、qa_gate_ledger.json（含 post_hoc_corrections）、
e1_search_probe.json、e2_download_threads.json、transfer_retest*.json×3、
transfer_hop_probe.json、local/（本地产物：上传源×2、回传件、E2 双下载件、mirror_src/）
