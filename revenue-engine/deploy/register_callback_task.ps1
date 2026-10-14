# 8440 callback 服务军团自启注册（部署时执行一次；REQ-005.AC2）
schtasks /Create /F /TN "RE-Callback8440" /SC ONSTART `
  /TR "py -I E:\AI-Station\私域运营\zbops\main.py callback"
# 环境变量（注册前设好）：RE_ENQUEUE_KEY=<强随机>、RE_CALLBACK_AUTOSTART=1
