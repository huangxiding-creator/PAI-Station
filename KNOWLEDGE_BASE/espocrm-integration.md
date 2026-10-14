# EspoCRM 集成手册要点（验证基线 2026-10-14）

> Read if：写采集→Lead 桥、设计去重键、查 CRM 字段。

## 部署

- 官方镜像：espocrm/espocrm-docker（90★，2026-09-29 维护中）
- License：AGPL-3.0（不分发即无义务；CRM 页面若暴露给外部客户需复查）

## API（文档实证 docs/development/api.md）

- 认证三选一，最简 `X-Api-Key` 头
- 建线索：`POST /Lead`（JSON body）
- 查询/更新/流转化（Lead→Contact/Account/Opportunity）REST 全覆盖

## 查重（关键内置能力）

- 文档原文（duplicate-check.md）："Duplicate check is performed upon record creation"
- 创建时自动查重是内置；**自定义查重规则才要写 PHP 类**
- ⚠️ 查重字段是 CRM 内部字段——微信侧跨群身份归一化（同一个人换昵称/多群）的
  去重键选择是本项目设计件（候选：wxid 优先 / 昵称+群 fallback / 手机号合并键）

## 中文

- application/Espo/Resources/i18n/zh_CN 随仓分发（目录实测）
- 中文全文搜索依赖 MySQL fulltext——CJK 需 ngram 调优（现成配置未验证，上线时实测）

## 开源版边界

- Workflows（CRM 内触发流程）是付费 Advanced Pack——开源版不做 CRM 内自动化；
  告警/推送统一由采集侧（zbops）或编排侧发起
