# RUN_LEDGER — 总包科技展示小程序（wxfdb55b184756e89e）

| 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 2026-10-10 16:43 | v1.2.0 提审（ci机器人3 上传 614428B） | 审核版本 1.2.0 · 审核中 · 预计1-7天；只提交一次、未加急 | 过审后控制台点发布 |
| 2026-10-10 16:47 | 体验版钉位 1.2.0 + 出码 | 页面路径 pages/index/index；trial_qr_v120.png 已桌面交付 | 用户扫码真机验 |
| 2026-10-10 | v1.2.0 交付：总包说科技→总包科技更名(0残留)；首页旗舰直达带(跳总包AI顾问 wx5cee1574ce45819b)；consultant(00)+aiglasses(09) 产品页；brain/zhiku 死码换跳转CTA；navigateToMiniProgramAppIdList 已声明 | bootsim 53/53 绿；IDE 编译 0错0警(614430B)；automator DOM 断言全过、0 console 错误（index+3产品页） | — |
| 2026-10-10 | 官网下线：ECS 总包说站点清理，8884/8889 关闭 | 备份 /root/archives/zongbaoshuo-legacy-1010.tar.gz；本地 E:\AI-Station\website\zongbaoshuo\ | — |

## 提审表单口径（1.2.0）

- 版本描述 148 字：旗舰直达卡片/眼镜介绍页/更名；纯展示无支付无登录不采集
- 测试账号=无需登录 · 企业微信=否 · 隐私=未采集 · 审核加急=请选择（未加急）
- 订单中心 path 陈旧值 page/order/list 已清空（非交易类）
