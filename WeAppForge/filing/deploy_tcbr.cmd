@echo off
set PATH=%PATH%;C:\Users\91216\AppData\Roaming\npm
tcb cloudrun deploy -s qianwen-engine --source E:/AI-Station/WeAppForge/filing/deploy_src --port 8080 --min-num 1 --max-num 2 --open-access-types PUBLIC,MINIAPP --vpc-config "{\"vpcId\":\"vpc-hv6ji25g\",\"vpcCIDR\":\"172.17.0.0/16\",\"subnetId\":\"subnet-ksblbg8p\",\"subnetCIDR\":\"172.17.0.0/20\"}" --force --wait
