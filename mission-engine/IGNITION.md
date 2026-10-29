# 点火手册 IGNITION v1.1（W1.4 守护：schtasks被拒访问→改用户级Startup方案，默认停用）
## 前台试跑（建议第一步）
Git Bash: cd /e/AI-Station/mission-engine && ./auto-loop.sh   观察首循环；Ctrl+C 或 ./stop-loop.sh 停
## 启用登录自启（无需管理员）
copy "E:\AI-Station\mission-engine\ignition-startup.cmd" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
## 停用自启
del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\ignition-startup.cmd"   （自启文件可删；引擎资产不删）
## 紧急停
./stop-loop.sh（优雅）或任务管理器结束 bash/claude 进程
## 备选：管理员 PowerShell 建计划任务（5分钟复活式）
schtasks /Create /TN MissionEngineLoop /TR "E:\AI-Station\mission-engine\guard.cmd" /SC MINUTE /MO 5 /F
## 参数与红线
LOOP_INTERVAL/CYCLE_TIMEOUT_SECONDS/MAX_CONSECUTIVE_ERRORS/LIMIT_WAIT_SECONDS 环境变量可调；
内置：高峰期(工作日14-18)让路/断路器5连错停轮+企微/429限额等待/consensus回滚/日志只增不删

## 器官层（W2.2 已接入）
- `organs.json`=器官注册表（新器官只加条目不改代码）；`organ_probe.py`=只读健康探针（`py -X utf8 organ_probe.py --organ zqg [--summary]`）；`organ_start.py`=幂等拉起（不健康才启，DETACHED 无窗，stdout 入器官日志）
- 点火(ignition-startup.cmd)/守护(guard.cmd)/循环启动(auto-loop.sh) 三路均连带拉起器官；首个器官=zqg智谱护盾（`pythonw -m zqg.daemon`，dry_run=simulated 先行，实弹重置待人工JWT登录）
- 429限额路径：auto-loop 自动探护盾快照入 ledger（`shield_snapshot`）+企微带护盾摘要
- 复活语义：进程死但心跳未过期(<1260s)时zqg自拒接管，guard 5min节奏兜底；器官层不代删锁文件（删除铁律）
