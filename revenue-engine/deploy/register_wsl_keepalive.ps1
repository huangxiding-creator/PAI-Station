# WSL 常驻保活（T-041 生存实验 14 天必需：WSL 空闲自杀会让容器反复冷启）
schtasks /Create /F /TN "RE-WSL-Keepalive" /SC ONLOGON /TR "wsl -d RE-Ubuntu -u root -- bash -c 'nohup sleep infinity >/dev/null 2>&1 &'"
schtasks /Run /TN "RE-WSL-Keepalive"
