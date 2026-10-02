# 总包AI顾问后端 · CloudBase 云托管部署手册（TCB_DEPLOY）

迁移目标：Aliyun ECS（systemd + 本地 SQLite）→ 腾讯云 CloudBase 云托管（容器）+ CloudBase MySQL。
引擎代码零分叉：`DB_KIND` 环境变量切换存储驱动，ECS 旧链路（sqlite）保持逐位可用。

---

## 1. 前置：开通 CloudBase MySQL

1. CloudBase 控制台 → 环境 → 数据库 MySQL → 开通（同一环境内网互通，免外网带宽）。
2. 记下 **内网地址 / 端口 / 账号 / 密码 / 库名**（建库建议 `utf8mb4`）。
3. 库表可预建（也可不建——引擎首连自动 `CREATE TABLE IF NOT EXISTS` 自举）：
   - 控制台导入本目录 `scripts/mysql_schema.sql`，或任一 MySQL 客户端执行。
   - 注意：`scripts/mysql_schema.sql` 与 `qianwen_engine/store.py` 的 `_SCHEMA` 同步维护，改表两处一起改。

## 2. 镜像构建与部署（两条路任选）

**方式 A · 云托管控制台直接构建（推荐）**
1. 云托管 → 创建服务（名称如 `qianwen-engine`，内存 1G 起）。
2. 部署方式选「本地代码上传 / 代码托管 Git」，**根目录选本目录 `services/qianwen-engine/`**
   （Dockerfile 就在本目录，云托管识别后自动构建）。
3. 构建即 `python:3.11-slim` + `requirements.txt` + `qianwen_engine/`，系统层含 `fonts-noto-cjk`
   （海报/导出中文字体，ECS 同路线）。

**方式 B · 本地构建推镜像**
```bash
cd services/qianwen-engine
docker build -t ccr.ccs.tencentyun.com/<命名空间>/qianwen-engine:v080 .
docker push ccr.ccs.tencentyun.com/<命名空间>/qianwen-engine:v080
```
云托管创建服务时选「镜像拉取」，填上址。

## 3. 环境变量（服务设置 → 环境变量）

| 变量 | 必填 | 说明 |
|---|---|---|
| `DB_KIND` | 是 | 固定 `mysql`（云托管线；不设则默认 sqlite=本地行为） |
| `MYSQL_HOST` | 是 | CloudBase MySQL 内网地址 |
| `MYSQL_PORT` | 否 | 默认 `3306` |
| `MYSQL_USER` | 是 | 数据库账号 |
| `MYSQL_PASSWORD` | 是 | 数据库密码 |
| `MYSQL_DATABASE` | 是 | 库名 |
| `PORT` | 否 | 容器监听端口，默认 `8080`（云托管会注入 PORT，Dockerfile 同源） |
| `DATA_DIR` | 建议设 | 数据目录（字体/wxacode 小程序码缓存），指到挂载卷，如 `/mnt/qianwen` |
| `SECRETS_DIR` | 建议设 | 密钥文件目录（见下节），指到挂载卷，如 `/mnt/secrets` |
| `QW_DEV_LOGIN` | 否 | 测试双闸（dev openid 直登）；生产**不设** |
| `QW_FAKE_ASK` | 否 | 测试假答案（不烧秘塔积分）；生产**不设** |

## 4. 密钥文件挂载（值不进镜像/不进环境变量，来自 data/secrets）

把 ECS 端 `E:\AI-Station\data\secrets\` 下这些文件挂载到 `SECRETS_DIR`（CFS 持久卷或构建时注入的 Secret 卷）：

| 文件 | 用途 |
|---|---|
| `zhipu.secret` | 智谱免费链（追问/要点/引用展开/优化提问主引擎） |
| `metaso_kb_session.json` | 秘塔总包智库网页会话（正式咨询主引擎） |
| `zongbao_qianwen_mp.secret` | 小程序 appsecret（code2session / 小程序码 / msgSecCheck） |
| `qianwen_engine_hmac.key` | **用户 token HMAC 密钥——必须持久化**：丢失/轮换=全体已发 token 失效，用户被登出 |
| `metaso_api_key_user.txt` | 可选：search-api 外援腿 |
| `virtual_pay.secret` | 可选：虚拟支付（当前免费模式未启用） |

另需把 `data/qianwen/fonts/`（NotoSansSC 双字重 otf/ttf）放入 `DATA_DIR/fonts/`（docx/pdf 导出与海报的中文字体；无字体时导出/海报接口返回 503，问答主链不受影响）。

## 5. 健康检查与端口

- 监听：`0.0.0.0:${PORT:-8080}`（单端口，uvicorn 启动命令在 Dockerfile CMD）。
- 健康检查路径：**`/api/health`**（app.py 内建，返回 `{"ok": true}`）——控制台健康检查照此填写。
- 首页即健康面：部署后 `curl https://<默认域名>/api/health` 验证。

## 6. 数据迁移（ECS SQLite → CloudBase MySQL，一次性）

在 ECS（或任一能同时摸到源库文件与目标 MySQL 网络的机器）上：
```bash
cd services/qianwen-engine
export MYSQL_HOST=... MYSQL_PORT=3306 MYSQL_USER=... MYSQL_PASSWORD=... MYSQL_DATABASE=...
python scripts/migrate_sqlite_to_mysql.py /path/to/data/qianwen/db.sqlite
# 重灌（先清空目标表）加 --fresh
```
- 建表复用引擎运行时自举（DDL 同源不漂移）；自增 id 原值保留，answers 按 rowid 序灌入（历史排序语义保持）。
- 防呆：目标表非空默认拒跑，防重复灌数。
- 灌数后抽样核对：`users` / `answers` 行数与 ECS sqlite 一致；小程序登录→历史列表能翻出旧问答即通。

## 7. 自定义域名 api.epcschool.top

1. 云托管 → 服务设置 → 自定义域名 → 绑定 `api.epcschool.top`（走 CloudBase 默认 HTTPS 证书或自有证书）。
2. 域名 DNS 按控制台提示加 CNAME 到服务的默认公网域名。
3. 小程序后台「开发管理 → 服务器域名 → request 合法域名」加入 `https://api.epcschool.top`。
4. 小程序端 `utils/config.js` 的 API base 切到该域名（WeAppForge 工程内一处配置）。

## 8. 注意事项

- **单副本运行**：进度流（打字机/阶段事件）与 KB 串行闸在引擎里是进程内态，云托管先固定
  「实例数=1、弹性伸缩关」；多副本前需先把这两态外置（MySQL/Redis）。
- 换库不换代码：回滚到 ECS 只需 `DB_KIND` 不设（默认 sqlite），旧链路原样可用。
- mysql 模式连接池小（4）+ 借出 ping 自愈，容器空闲断连/重启自动恢复，无需人工干预。
