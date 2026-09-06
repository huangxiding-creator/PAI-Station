# 附录 N 安装排查与升级 FAQ（客服底稿）

| 症状 | 根因 | 处置 |
|---|---|---|
| 启动报"缺少 [llm].api_key" | 未复制 example 配置 | copy config\pai.example.ini config\pai.ini 后填 key |
| 模型连通测试 401 | key 错误/未激活 | 到 open.bigmodel.cn 控制台核对；新号需实名 |
| 托盘图标不见 | 安装时选了静默、explorer 重启 | 重跑 WinSW 服务注册；任务栏设置显示图标 |
| 飞书收不到消息 | 事件订阅未选长连接/权限未勾 | 按 5.2 步骤 3 重配；--check 输出缺失权限清单 |
| 企微推送失败 | 应用可见范围不含自己 | work 后台把用户加入可见范围 |
| 截图识别全是 unknown | 断网/4v 限流 | 自动降级 PaddleOCR；检查 pacer 日志 |
| CPU 飙高 | watch_dirs 含了工程目录（node_modules 风暴） | ignore_patterns 加 node_modules,.git |
| 记忆查询很慢 | 库>10 万条 | 检查 FTS5 索引；触发 OPTIMIZE；viking 分层生效确认 |
| 微信识别不到内容 | 微信窗口标题变化/黑名单误伤 | 查 screen_blacklist；窗口标题匹配规则热修 |
| 升级后 schema 报错 | 迁移被中断 | 自动回滚备份库；日志查 migrations/ 卡点 |

**升级策略**：应用内检查更新→下载差分包→校验 SHA256→备份四库→应用迁移→回归冒烟（500 基准抽 50 条）→回滚开关。升级失败自动恢复旧版本并保留错误报告入口。
