echo '== D1. remove systemd unit =='
rm -f /etc/systemd/system/qianwen-engine.service
systemctl daemon-reload
systemctl list-unit-files | grep qianwen || echo UNIT_GONE
echo '== D2. remove /opt/qianwen =='
rm -rf /opt/qianwen
ls /opt/
echo '== D3. remove yrecepc vhost (keep gcbrain for beian posture) =='
rm -f /root/dify/docker/nginx/conf.d/api-yrecepc.conf
ls -la /root/dify/docker/nginx/conf.d/
echo '== D4. remove yrecepc certs (live/archive/renewal) =='
ls -d /root/dify/docker/volumes/certbot/conf/live/api.yrecepc.cn 2>/dev/null && rm -rf /root/dify/docker/volumes/certbot/conf/live/api.yrecepc.cn
ls -d /root/dify/docker/volumes/certbot/conf/archive/api.yrecepc.cn 2>/dev/null && rm -rf /root/dify/docker/volumes/certbot/conf/archive/api.yrecepc.cn
rm -f /root/dify/docker/volumes/certbot/conf/renewal/api.yrecepc.cn.conf
ls /root/dify/docker/volumes/certbot/conf/live/ 2>/dev/null
ls /root/dify/docker/volumes/certbot/conf/renewal/ 2>/dev/null
echo '== D5. nginx test + reload (dify container) =='
docker exec docker-nginx-1 nginx -t 2>&1
docker exec docker-nginx-1 nginx -s reload 2>&1 && echo RELOADED
echo '== D6. ufw remove 8869 =='
ufw delete allow 8869/tcp 2>&1 || (ufw status numbered | grep 8869; echo RETRY_BY_NUMBER_NEEDED)
ufw status | grep 8869 || echo UFW_8869_GONE
echo '== D7. watcher secret survives =='
ls -la /root/qianwen-audit/secrets/
echo '== D8. archive survives =='
ls -la /root/archives/
