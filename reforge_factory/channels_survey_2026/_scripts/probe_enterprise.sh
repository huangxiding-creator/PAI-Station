#!/bin/bash
# 渠道普查第七路(enterprise) 官网探活: 直连GET -> 7895代理兜底; ≤2请求/站 (铁律)
UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0 Safari/537.36"
PX="http://127.0.0.1:7895"
probe() {
  local id="$1" url="$2"
  local code=$(curl -s -o /dev/null -m 12 -w "%{http_code}" -A "$UA" -L --max-redirs 3 "$url")
  if [ "$code" = "000" ] || [ "$code" = "" ]; then
    local code2=$(curl -s -o /dev/null -m 12 -w "%{http_code}" -A "$UA" -L --max-redirs 3 -x "$PX" "$url")
    echo -e "$id\t$code\t$code2(prox)\t$url"
  else
    echo -e "$id\t$code\t-\t$url"
  fi
}
cat <<'LIST' | while IFS='|' read -r id url; do probe "$id" "$url" & done | sort
gsxt|https://gsxt.gov.cn
qcc|https://www.qcc.com
tianyancha|https://www.tianyancha.com
aiqicha|https://aiqicha.baidu.com
qixin|https://www.qixin.com
wenshu|https://wenshu.court.gov.cn
creditchina|https://www.creditchina.gov.cn
zxgk|https://zxgk.court.gov.cn
jzsc|https://jzsc.mohurd.gov.cn
glxy_mot|https://glxy.mot.gov.cn
xypt_mwr|http://xypt.mwr.cn
nea|https://www.nea.gov.cn
fec_mofcom|https://fec.mofcom.gov.cn
ggzy|http://ggzy.gov.cn
cebpub|http://www.cebpubservice.com
qianlima|https://www.qianlima.com
jianshe99|https://www.jianshe99.com
bidizhaobiao|https://www.bidizhaobiao.com
bidcenter|https://www.china.bidcenter.com.cn
ebnew|https://www.ebnew.com
ccgp|http://www.ccgp.gov.cn
ecp_sgcc|https://ecp.sgcc.com.cn
cninfo|http://www.cninfo.com.cn
sse|https://www.sse.com.cn
szse|https://www.szse.cn
neeq|https://www.neeq.com.cn
hkexnews|https://www1.hkexnews.hk
chinca|https://www.chinca.org
ecaci|http://www.ecaci.org.cn
cacem|http://www.cacem.com.cn
sinosure|https://www.sinosure.com.cn
jzsbs|http://www.jzsbs.com
chinajsb|http://www.chinajsb.cn
bai100njz|https://www.100njz.com
mysteel|https://www.mysteel.com
ccement|https://www.ccement.com
enr|https://www.enr.com
sec_edgar_fts|https://efts.sec.gov/LATEST/search-index?q=%22caterpillar%22
opencorp|https://opencorporates.com
chouse|https://find-and-update.company-information.service.gov.uk/
wb_projects_api|https://projects.worldbank.org/API/v3/projects?format=json&rows=1
wb_debarred|https://www.worldbank.org/en/projects-operations/procurement/debarred-firms
adb_projects|https://www.adb.org/projects
adb_sanctions|https://www.adb.org/who-we-are/integrity/sanctions
aiib_projects|https://www.aiib.org/en/projects/index.html
ungm|https://www.ungm.org
ebrd_pdb|https://www.ebrd.com/work-with-us/procurement/projects-database.html
sam_gov|https://sam.gov/content/exclusions
usaspending_api|https://api.usaspending.gov/api/v2/references/agency/1/
fidic|https://fidic.org
fiec|https://fiec.org
eic_fiec|https://eic.fiec.org
LIST
wait
