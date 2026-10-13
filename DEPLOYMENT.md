# DEPLOYMENT — zongbao-ai-v0917（0.9.18 部署记录）

## 引擎（腾讯云托管 TCB，服务 qianwen-engine）

- **部署号 033**（TaskId 2348026，2026-10-13 15:30:51 提交，~5min 转 normal）
- 状态：**normal + HasTraffic + FlowRatio 100**（getDeployRecords 实证）
- 内容：DELETE /api/answers/{aid} 端点 + 软删四可见性门 + pot_list 幽灵过滤 + deleted 列双方言迁移（_ANSWER_UPGRADES 幂等 ALTER，生产 MySQL 平滑）
- 通道：qw_tcb_prep.py（staging+EnvParams roundtrip）→ mn_client update_envparams.js（manager-node deploy，凭证=auth.json 临时密钥，过期走设备授权刷新）

## 生产冒烟（三板斧+端点实证）

| 项 | 结果 |
|---|---|
| /api/health | {"ok":true} |
| 部署记录 | 033 normal/HasTraffic/100 |
| DELETE 路由在役 | 无鉴权 DELETE /api/answers/x → **401「未登录或凭证过期」**（缺路由应 404 Not Found——端点存在性实证） |
| 海报零回归 | GET /api/report/CNNC-EPC/poster → 200 / 315662B |
| 列服务 | /api/history 系正常（e2e 全链在生产侧语义核对经本地同构代码） |

## 小程序（0.9.18）

- **UPLOAD_OK**：robot7（轮转），327635B，2026-10-13 15:20:20
- **提审**：六段向导（recon/open/step1/step2/fill/submit），DESC 114 字，
  表单=无需登录/否/**采集用户隐私**（fill 零误翻=0916 精确匹配根治首验），
  **审核中 15:45:50**，普通队列不加急只一次
- 提审键真身坑第三次在案（A.btn.btn_primary 非 button）——0918 向导选择器已根治

## 人工步骤记录（向导在案）

1. TCB 设备授权（浏览器一次，凭证 2h 窗）
2. 控制台扫码（9336 Chrome，_relogin_0918 企微叫号+15min 轮询）

## 发布链候位

过审后（住哨 QianwenReviewWatch 每 2h 盯 0.9.18 行，翻转企微）：发布→
测试账号 3 条历史答案可用新删除功能自清→台账。引擎侧无待发（033 已全量）。
