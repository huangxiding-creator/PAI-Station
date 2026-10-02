S=$(sed -n 's/^appsecret=//p' /root/qianwen-audit/secrets/zongbao_qianwen_mp.secret | head -1 | tr -d '\r\n')
if [ -z "$S" ]; then echo SECRET_EMPTY; exit 1; fi
echo "secret_len: ${#S}"
APPID=wx5cee1574ce45819b
TOK=$(curl -s "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=$APPID&secret=$S" | python3 -c "import sys,json;print(json.load(sys.stdin).get('access_token',''))")
if [ -z "$TOK" ]; then echo TOKEN_FAIL; exit 1; fi
echo "token_len: ${#TOK}"
R=$(curl -s -X POST "https://api.weixin.qq.com/wxa/get_latest_auditstatus?access_token=$TOK" -d '{}')
echo "AUDIT_STATUS_JSON: $R"
echo "$(date '+%F %T') manual-migration-test $R" >> /root/qianwen-audit/audit_watch.log
