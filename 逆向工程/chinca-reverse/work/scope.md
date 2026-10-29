# 授权范围 — chinca.org 加速乐/Aliyun WAF JS 挑战逆向

- 授权依据: 用户 2026-10-24「全渠道 API 化令」+ 本战役任务书（EPC-OVERSEAS 高价值补充源，现状 requests 被挡=0件）
- 标的: chinca.org（中国对外承包工程商会官网）首页 JS 挑战（renderData/arg1 → acw_sc__v2 cookie）
- 性质认定: **访问性过墙**（公开内容的 JS gate），非付费墙/登录墙破解
- 允许操作:
  - 只读 GET（首页/栏目列表/文章详情）
  - 本地保存挑战页样本、本地执行挑战 JS 求解算法（Node/Python 沙箱）
  - 正常浏览器 UA 与请求头
- 禁止操作:
  - 任何写操作（POST/PUT/DELETE）、登录尝试、付费内容绕过
  - 删除任何文件；git push；数据造假
- 方法论契约: 复刻 逆向工程/sogou-weixin-reverse 结构（work/captures/replica/报告）
- 若挑战算法版本变化导致求解器失效: 如实记录失效模式，不得造假贯通率
