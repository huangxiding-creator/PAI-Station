# 23:59 运营日报军团腿注册（T-073 / REQ-023，部署时执行一次）
schtasks /Create /F /TN "RE-DailyReport-2359" /SC DAILY /ST 23:59 `
  /TR "py -I E:\AI-Station\revenue-engine\probes\daily_report.py"
