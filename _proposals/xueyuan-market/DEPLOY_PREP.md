# DEPLOY_PREP — 总包学园·研报商城 部署备料（WBS 切片④，T-P0-23/24 前置）

> 2026-09-28。性质=**备料**：路线探明+脚本备好+干跑校验全过+ECS 只读预检完成，**未做最终部署**。
> 上游：ARCHITECTURE §七（/opt/xueyuan 前缀/8871/systemd/双层墙/与 8869 共存）；母本=WeAppForge/work/ecs_deploy_v025.py。
> 探针驱动与原始回包：`C:\Users\91216\AppData\Local\Temp\xy_deploy_probe.py` / `xy_deploy_probe_result.txt`（TEMP 留档）。

---

## 一、上云路线决策（全部实测数字，非估算）

### 1.1 资产实测（2026-09-28，E:\AI-Station\data\xueyuan\）

| 资产 | 原始体积 | gzip/tgz 后 | 说明 |
|---|---|---|---|
| content/（38 份 chapters_full） | 10,197,650 B | **2,853,248 B** | JSON 压缩比 3.57x |
| db.sqlite | 10,768,384 B | **2,918,400 B** | gzip -9，3.69x |
| 包内容（zongbao content，catalog+空壳章） | 2,588,728 B | **1,359,255 B** | 引擎 XY_CONTENT_DIR 源 |
| pdfs/（38 报告 × 115 份 PDF） | 101,049,776 B | **75,702,253 B** | PDF 已压缩仅 1.33x |
| **合计** | ≈122 MB | **≈82.8 MB** | 任务书预估 475MB 为上限口径（38×3×~4MB），实测均值 2.7MB/份 |

### 1.2 路线①：阿里云 OSS —— **未开通，控制台位**

- `aliyun oss ls` → `Bucket Number is: 0`（列表 API 可达，账号未建过 bucket）。
- `aliyun oss mb oss://xy-xueyuan-probe-8871` → **403 `UserDisable`**（RequestId 6ABA4D5E5AA95931371B3B0C）——账号 OSS 服务层被禁用（典型原因=从未开通或欠费停用），**写操作全拒**。
- 1KB 探针对象因 mb 即被拒**未上传**，复测 bucket 数仍=0，**无任何残留**。
- 结论：OSS 路线当前不可用。开通后即首选：本地 `aliyun oss cp`（公网传）→ `aliyun oss sign -e oss-cn-heyuan-internal.aliyuncs.com`（sign 支持 `-e` 内网 endpoint，已验语法）→ ECS 内网 wget（同地域 cn-heyuan 内网免流量费）。**开通 OSS=付费服务=用户控制台拍板，绝不自作主张。**

### 1.3 路线②：云助手大分片数学（CHUNK=16000 b64 字符/条，实测 4.9s/条往返）

分片参数取母本 v025 口径（RunShellScript content 上限 16KB）；逐条往返今日实测 3 采样 **4.8/4.9/4.9s**（RunCommand→DescribeInvocationResults 轮询 4s 节奏）。

| 场景 | tgz 后体积 | b64 字符 | 总片数 | 预估时长 | 判定 |
|---|---|---|---|---|---|
| 任务书假想 475MB（raw） | 475 MiB | 664M | 41,507 | **56.5 h** | 不可行 |
| 同上按 PDF 实测压缩比 ×0.75 | ≈374 MB | 498M | 31,132 | ≈42 h | 不可行 |
| 实测 pdfs 全量 | 75.7 MB | 100,936,337 | **6,309** | **8.6 h** | 勉强可行但脆（6.3k 次 API 调用、粗粒度恢复） |
| 实测 core（content+db+包内容） | 7,118,430 B | 9.49M | **594** | **49 分** | 完全可行 ✅ |
| 引擎代码本体 | 77,383 B | 103K | **7** | 1 分 | 完全可行 ✅ |

### 1.4 决策：**混合路线**（OSS 未开通期的在役方案）

1. **部署日当天**：`ecs_deploy_xueyuan.py`（引擎 7 片/1 分）→ `ecs_upload_xueyuan_data.py --phase core`（594 片/49 分）→ **引擎当天全功能在役**（检索/阅读/支付签名/批评评分；仅 PDF 下载腿等 pdfs 相位）。
2. **pdfs 夜间分批**：`--phase pdfs --batch 10` ≈1,544 片/**2.1 h/晚 → 4 晚搬完**（或 `--batch 38` 一夜 8.6h）；按报告粒度原子搬运+本地台账断点续跑（`work/xy_pdf_upload_ledger.json`），单片失败只重跑该报告。
3. **用户开通 OSS 后**：pdfs 整腿切换 `oss cp`+内网拉取（75.7MB 秒级~分钟级），本脚本 pdfs 相位退役；core 相位保留（49 分钟可接受、零付费依赖）。

### 1.5 用户控制台位清单（当前已知两项）

| # | 动作 | 何时 | 说明 |
|---|---|---|---|
| 1 | **阿里云安全组放行 8871/tcp** | 部署日 ufw 开完后 | 脚本只做 ufw 层（双层墙纪律，脚本内醒目注释+绝不调 AuthorizeSecurityGroup）；开闸请示一次到位 |
| 2 | **OSS 开通/启用（解除 UserDisable）** | 可选，越早越好 | 付费服务用户拍板；开通即解锁 pdfs 秒级上云路线 |

---

## 二、交付脚本与使用说明（均已干跑校验 PASS，未真跑）

### 2.1 `WeAppForge/work/ecs_deploy_xueyuan.py`（母本 v025 换装）

- 变更面：ENGINE=services/xueyuan-engine（tar 含 `xueyuan_engine/`+`requirements.txt`）、PREFIX=/opt/xueyuan、PORT=8871、UNIT=xueyuan-engine.service、探针 `http://127.0.0.1:8871/health`（app.py @157 实核路由）、venv 独立 `/opt/xueyuan/venv`（阿里云 pypi 镜像装 requirements.txt 全量：fastapi/uvicorn/curl_cffi/pydantic/**jieba/Pillow/pypdf**+pytest 件）、ufw allow 8871/tcp。
- systemd unit 照 ARCHITECTURE §七：Restart=always/RestartSec=3，`Environment=XY_CONTENT_DIR=/opt/xueyuan/data/content_pkg`（引擎启动对内容区缺失优雅降级已实核 app.py lifespan try/except）。
- secrets：上传 `xueyuan_mp.secret`+`xueyuan_engine_hmac.key`（本地在位实核）；`virtual_pay_xueyuan.secret` 远端缺则建占位（v025 同款，缺字段=503 降级不炸，等用户开通虚拟支付回填）。
- **零交叉自查内置**：FORBIDDEN=(/opt/qianwen, qianwen-engine, 8864, 8869, 8870) 审计所有远端命令+tar 成员；干跑实过（还逮住过自身 ufw 验证命令误带 8869，已改只 grep 8871）。
- 用法：`python ecs_deploy_xueyuan.py --dry-run`（备料期，今日 EXIT=0）；部署日去掉 --dry-run。`--dry-run` 与真跑共用同一 plan() 代码路径=所查即所跑。

### 2.2 `WeAppForge/work/ecs_upload_xueyuan_data.py`（混合路线执行件）

- `--phase core`：content+db+包内容合一 tgz（实测 7,118,430B/594 片/49 分）→ 落 `/opt/xueyuan/data/xueyuan/{content,db.sqlite}` + `/opt/xueyuan/data/content_pkg`，远端回显 content_reports 数/db 字节数自检。
- `--phase pdfs --batch N`（默认 10）：按报告 slug 逐份 tgz→分片→解包到 `/opt/xueyuan/data/xueyuan/pdfs/<slug>/`→回显 PDF 计数；本地台账断点续跑，重跑自动跳过已完成。
- 两相位均带 FORBIDDEN 审计与 `--dry-run`（今日 core 594 片/batch10=1,544 片 2.1h 均 EXIT=0）。

### 2.3 `WeAppForge/work/nginx_xueyuan.conf.template`

域名 TBD 占位 `__XUEYUAN_DOMAIN__`；listen 80 → `location /api/v1/ proxy_pass http://127.0.0.1:8871`（引擎自带 /api/v1 前缀，路径原样透传）+ `/health` 直透 + 流式下载 `proxy_buffering off`/`proxy_read_timeout 60s`；惯例对齐 ECS 既有四站（独立 conf/gzip/nosniff），不占专用端口（绑域名虚拟主机，与四站 server_name _ + 专用端口零冲突）。落位法：替换域名两处 → b64 → `/etc/nginx/conf.d/xueyuan-api.conf` → `nginx -t && systemctl reload nginx`（部署日动作，今日未动）。

### 2.4 部署日执行序（T-P0-23/24 到点）

```
python ecs_deploy_xueyuan.py            # 引擎+venv+systemd+ufw+探针（约 5 分钟）
python ecs_upload_xueyuan_data.py --phase core   # 当天全功能（约 50 分钟）
# → 用户控制台：安全组放行 8871 → 公网 GET http://47.120.43.20:8871/health =200
python ecs_upload_xueyuan_data.py --phase pdfs --batch 10   # 之后每夜一批×4
# 域名定后：nginx 模板落位 reload
```

---

## 三、ECS 预检实数（2026-09-28 只读云助手，单命令 elapsed 5.0s，exit=0）

| 项 | 实测 | 判定 |
|---|---|---|
| 磁盘 / | /dev/vda3 49G 总/36G 用/**12G 可用**（76%） | 122MB 资产+venv 依赖充裕 ✅ |
| 内存 | 7.1Gi 总/2.8Gi available（无 swap） | 充裕 ✅ |
| 端口监听 | 53/8000/8001/8090/443/80/22/17358/5003/**8869**/8881/8882/8883/8884/8889/8890 | **8871 空闲无冲突 ✅**；8864 未监听（laya-server 未上云，同样无冲突） |
| python3 | 3.12.3，venv/ensurepip=24.0 OK | qianwen 部署期已装 python3-venv，无需再 apt ✅ |
| /opt | alibabacloud/containerd/**qianwen**（xueyuan 不存在=干净） | 平行落位无覆盖风险 ✅ |
| nginx conf.d | 四站在役：weaipo-8881/paistation-8882/wechatbrief-8883/zongbaoshuo-8884(→301 8889) | 模板已对齐惯例 ✅ |
| ufw | active（放行 20/21/22/80/443/888/17358/39000:40000/8090/8881…，**无 8871**） | 部署日脚本开 8871/tcp；SG 层=用户控制台位 |
| OS | Ubuntu 24.04.2 LTS | 与母本链路一致 ✅ |

## 四、红线遵守记录

- ECS 全程**只读**（df/free/ss/ls/head/ufw status/cat conf），未写任何文件、未动任何服务/端口/配置；8869/8864 零接触。
- OSS **未开通付费服务**：mb 被 UserDisable 拒后未重试未绕过；1KB 探测未遂即止；bucket 数复测=0 无残留。
- 未真部署、未真上传大文件（引擎/数据脚本只跑 --dry-run，零 aliyun 调用）。
- 未 commit；本地测量中间件（tar/gz/探针对象）已清理，TEMP 留探针脚本+回包原文备查。
