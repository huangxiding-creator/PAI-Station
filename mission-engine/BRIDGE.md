# 微信Claw桥启动手册（绑定成功后用）
1. 启动: 双击 bridge-guard.cmd 或 Git Bash: (cd ~/.claude/skills/wechat-claude-code && node dist/main.js start >> daemon_win.log 2>&1 &)
2. 验证: tail daemon_win.log 看到"已连接/监听"类字样；手机微信给新好友发"状态"应获回复
3. 审批接线(引擎侧,待W4.3b循环完成): 审批事件→微信消息;你回复 批准/否决/修改 →闸门消费
4. 日志: skills/wechat-claude-code/daemon_win.log;账号数据 ~/.wechat-claude-code/(机密,勿外传勿入仓)
## 1023修复记录(五连坑)
npm壳缺原生件→CLAUDE_BIN直指扩展二进制(2.1.304版本钉死,扩展升级需重指);dist/claude/provider.js:161已注入CLAUDE_BIN;账号唯一=72457912353f;旧残档.stale-*归档在accounts/
