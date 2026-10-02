tail -3 /var/log/nginx/access.log | awk '{print $1}'
