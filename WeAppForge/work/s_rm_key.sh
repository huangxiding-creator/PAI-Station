sed -i '/tmp-pull-1002/d' /root/.ssh/authorized_keys && echo REMOVED; grep -c tmp-pull-1002 /root/.ssh/authorized_keys || echo ZERO_LEFT
