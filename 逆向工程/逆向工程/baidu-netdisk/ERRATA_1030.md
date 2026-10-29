# ERRATA · 2026-10-30 · W5 transfer 断因结论勘误（W6 受控复测证伪记录）

## 被证伪的断言
「/share/transfer errno 2 的根因 = 缺 bdstoken；携带 bdstoken 即应放行」
（W5 README/PROTOCOL 漂移账 #15 以「定位=缺 bdstoken（diag 06 档）」落账）

## 证伪证据（W6 受控复测，2026-10-29/30）
- 复测形态：CLI 实装携带链（loginStatus bdstoken 32 位 → verify（带 bdstoken）→
  list（BDCLND=randsk）→ transfer（query 带 bdstoken+BDCLND cookie）），1 发 POST。
- 结果：**仍 errno 2 参数错误**（tests/_diag_archive/w6_qa_gate/transfer_retest.json）。
- 跳级探针钉死断点：records/surlinfo/loginStatus/verify/list 五跳全 errno=0，
  errno 2 确落 transfer POST 本身（transfer_hop_probe.json）——排除前跳干扰。

## 误判根因（W5 诊断单变量未穷尽）
W5 两发不带 bdstoken 均 errno 2 → 归因 bdstoken 缺失；但**对照组缺失**（带 bdstoken
从未单测过就落了因果结论）。蓝本复核（BaiduPCS-Go baidupcs/transfer.go:79-85）：
transfer query 全参 = app_id+channel=chunlei+clienttype=0+web=1+**shareid+from
(=shareUK)**+bdstoken——现实现缺 **shareid/from 两必参**，仅补 bdstoken 不充分。
教训入方法论：**缺参类 errno 2 的归因必须对照蓝本全参清单逐参核对，单变量差分
只在「已带全参」基线上才有意义。**

## 修正后口径（已改写入 api.py share_transfer docstring、bdn.py cmd_transfer、
## test_offline_w5.py、README、PROTOCOL 漂移账 #15）
- share/transfer 活性维持 **N/A（errno 2）**；W6 已实装蓝本全参形态
  （shareid+from+bdstoken，单测在位），1 发复测留 W7/用户令（W6 硬帽 1/1 已耗）。
- cmd_transfer 异常路径补 JSON 回显（errno+payload 可归档——本次复测失败曾因
  异常路径吞 payload 无法落响应原文）。

## 关联档案
tests/_diag_archive/w6_qa_gate/{transfer_retest.json, transfer_retest_pick.json,
transfer_retest_ls_verify.json, transfer_hop_probe.json}
