# 收款腿手册要点（验证基线 2026-10-14）

> Read if：商户号确认、acg-faka 部署走单、wechatpay-skills 安装。

## 硬前提

- **微信支付 V3 需企业商户号 + 营业执照**（个人身份无法开通）——Phase 0-3 确认
- 无商户号降级：个人码半自动收款（人工确认发货）

## 组件

1. **wechatpay-skills**（微信支付官方 AI 技能包，MIT，v1.3 2026-10-13）
   - 装进 Claude Code 做接入指导（产品选型/示例代码/排障）
   - 官方 SDK 全家 Apache-2.0（java 1,546★/go 1,283★/php 604★/apache-httpclient 722★）
2. **acg-faka**（5,804★ MIT，kernel/Plugin.php 专有例外）
   - 498 元研报 SKU：下单→自动发卡密/网盘链接
   - ⚠️ 微信支付自动发货插件在闭源商店，**无可公开验证——Phase 0-2 实测走单是硬门**
   - 99 元月会员：meedu 已证伪出局（ADDITIONAL_TERMS 禁未授权商用）→ acg-faka 商品位或薄自建腿（P4 决策）
3. 备选 PHP 侧 easywechat（10,366★ MIT）/ Java 侧 WxJava（33,155★ Apache-2.0）

## 纪律

- docker 镜像固定 digest；插件一律实测走单后才算「通」
- 收款与发货日志进 EspoCRM 归因链（订单关联源 Lead）
