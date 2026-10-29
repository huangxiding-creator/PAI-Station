#!/bin/bash
set -x
printf '%s\n' '{"mail":"admin@pentagi.com","password":"pentagipass"}' > /tmp/pt_login.json
curl -k -s -S -c /tmp/pt.cookie -H 'Content-Type: application/json' \
  --data @/tmp/pt_login.json -w '\nHTTP=%{http_code}\n' \
  https://localhost:8443/api/v1/auth/login
echo '--- info with cookie ---'
curl -k -s -b /tmp/pt.cookie -w '\nHTTP=%{http_code}\n' https://localhost:8443/api/v1/info | head -c 400
