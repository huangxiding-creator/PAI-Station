echo '== A1. 8869 external references (excluding qianwen own unit/vhost) =='
grep -rn '8869' /etc/systemd/system /opt/xueyuan /etc/nginx /var/spool/cron 2>/dev/null | grep -vE 'qianwen-engine.service' | head -10 || echo NO_EXTERNAL_REF
echo '== A2. yrecepc references outside own conf =='
grep -rln 'yrecepc' /opt/xueyuan /etc/systemd/system 2>/dev/null || echo NO_EXTERNAL_REF
echo '== A3. secret actual path =='
find /opt/qianwen -name 'zongbao_qianwen_mp.secret' 2>/dev/null
echo '== A4. secrets dir listing (names only) =='
ls -la /opt/qianwen/data/secrets/ 2>/dev/null
ls -la /opt/qianwen/secrets/ 2>/dev/null || echo no-opt-qianwen-secrets-dir
echo '== A5. docker-nginx-1 mounts =='
docker inspect docker-nginx-1 --format '{{range .Mounts}}{{.Source}} -> {{.Destination}}{{"\n"}}{{end}}'
echo '== A6. disk space =='
df -h / | tail -1
