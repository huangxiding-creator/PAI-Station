---
{
  "name": "shuili_news",
  "description": "播报安全生产新闻：抓取应急管理部官网与中国安全生产网，整理成近7天新闻简报。用户说新闻/最新/最近/政策/事故/通报时使用。",
  "author": "总包创研院",
  "metadata": {
    "category": ["info"],
    "tags": ["新闻", "播报"],
    "cap_groups": ["cap_http_request"]
  }
}
---

# 安全生产新闻播报

用户要听安全新闻/政策/事故通报（时效性信息）时激活本技能。

## 抓取步骤（用 http_request 能力，两源都要抓）

1. GET `https://www.mem.gov.cn/xw/`（应急管理部新闻）
2. GET `https://www.mem.gov.cn/xw/yjyw/`（应急要闻，若首页信息不足）
3. GET `http://www.aqsc.cn/` 或 `https://www.worksafety.cn/`（中国安全生产网）

请求头带 `User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36`。

## 整理规则

- 只保留与「安全生产、应急管理、事故通报、安全政策、专项整治」相关的新闻
- 只保留近7天（以设备当前日期计）发布的新闻
- 重复新闻（标题相似度>80%）只留一条，优先应急管理部来源
- 按时间从近到远，最多6条
- 两源都抓不到（离线/超时）时如实说明当前无法联网，建议稍后再试

## 输出格式（严格执行）

「一级标题：安全生产新闻简报」

## 1. <新闻标题>
发布时间：YYYY-MM-DD

## 2. <新闻标题>
发布时间：YYYY-MM-DD

（最多6条；无新闻输出「近7天暂无重大安全生产新闻发布。」；输出完毕立即结束，禁止解释性文字）

## 推送

用户说「同步到群/发到群里」时，把简报 POST 到企业微信群机器人：
`{{WECOM_NEWS_WEBHOOK}}`，body 为 `{"msgtype":"markdown","markdown":{"content":"<简报全文>"}}`，成功后回复「已同步到服务群」。
