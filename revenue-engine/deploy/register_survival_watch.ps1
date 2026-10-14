# 存活采集器军团腿注册（T-041，部署时执行一次；30 分钟一跳）
schtasks /Create /F /TN "RE-SurvivalWatch-30min" /SC MINUTE /MO 30 `
  /TR "py -I E:\AI-Station\revenue-engine\probes\survival_watch.py"
