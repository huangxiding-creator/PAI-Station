echo '== B1. stop & disable qianwen-engine =='
systemctl disable --now qianwen-engine 2>&1 | tail -2
sleep 1
systemctl is-active qianwen-engine 2>&1 || true
ss -tlnp | grep 8869 || echo PORT_8869_CLOSED
echo '== B2. archive (exclude venv) =='
mkdir -p /root/archives
tar czf /root/archives/qianwen-legacy-1002.tar.gz --exclude='/opt/qianwen/venv' /opt/qianwen /etc/systemd/system/qianwen-engine.service /root/dify/docker/nginx/conf.d/api-yrecepc.conf /root/dify/docker/nginx/conf.d/api-gcbrain.conf 2>/dev/null
ls -la /root/archives/qianwen-legacy-1002.tar.gz
echo '== B3. archive integrity (key files present) =='
tar tzf /root/archives/qianwen-legacy-1002.tar.gz | grep -E 'db.sqlite|zongbao_qianwen_mp.secret|qianwen-engine.service|api-yrecepc.conf|api-gcbrain.conf'
echo 'file count:'
tar tzf /root/archives/qianwen-legacy-1002.tar.gz | wc -l
echo '== B4. migrate watcher secret =='
mkdir -p /root/qianwen-audit/secrets
cp /opt/qianwen/data/secrets/zongbao_qianwen_mp.secret /root/qianwen-audit/secrets/
chmod 600 /root/qianwen-audit/secrets/zongbao_qianwen_mp.secret
echo 'bytes:'
wc -c < /root/qianwen-audit/secrets/zongbao_qianwen_mp.secret
echo 'sha256 (src / migrated):'
sha256sum /opt/qianwen/data/secrets/zongbao_qianwen_mp.secret /root/qianwen-audit/secrets/zongbao_qianwen_mp.secret
