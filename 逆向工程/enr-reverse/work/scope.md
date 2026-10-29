# 授权范围 — enr.com Cloudflare「Just a moment」挑战逆向

- 授权依据: 用户 2026-10-24 战役令（EPC-OVERSEAS Q7-E3/Q8-E3，ENR 榜单原文一直靠二手镜像，前波死墙清单遗留）
- 标的: enr.com / www.enr.com（Engineering News-Record，全球最大 250 家国际承包商榜发布方）Cloudflare JS 挑战
- 性质认定: 访问性过墙（公开榜单列表页的 bot gate），非付费墙/登录墙破解
- 允许操作:
  - 只读 GET（首页/top-lists/榜单页）
  - 本地保存挑战页样本、本地执行挑战 JS 求解（Node/Python 沙箱）
  - 正常浏览器 UA 与请求头；curl_cffi 标准 chrome 指纹
  - 浏览器仅侦察（REA capture_browser_scenario，用完即清）
- 禁止操作:
  - 指纹伪造农场；人机验证码（turnstile）自动破解
  - 任何写操作；删除任何文件；git push；数据造假
- 若挑战为 turnstile 人机验证: 如实定性，转替代源方案（chinca industry/标准排名网/建筑时报等）
- 方法论契约: 复刻 逆向工程/chinca-reverse 结构（work/captures/replica/报告）
