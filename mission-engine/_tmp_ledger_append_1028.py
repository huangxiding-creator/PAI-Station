import json, datetime
ts = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
entry = {
    "ts": ts,
    "event": "radar_light_pass",
    "detail": {
        "round": "1028首巡(08:05轻量轮,周三;上巡1027 20:05四巡no_proposal#15)",
        "pull": "7适配器(08:05:44)全绿零错误: demand_ledger +63(06:37批)/主账本2030行, 余六源全dup零新增(viaim 0/12+wechat_insight 0/1748+moments 0/508+topic_radar 0/42/28skip+revision_flywheel 0/1+refund_score 0/0)",
        "source_freshness": "topic-signals 14.8h<24h免夜刷(1027三巡刷源果实在位);下巡11:05约17.8h仍免刷;17:05三巡临界23.8h/20:05末巡26.8h必刷→建议17:05外科式刷源或深夜值守补N0全史腿(1026lesson:白天补撞API拥堵)",
        "analysis": "63新全验尸=跨日重放实锤: 与1027-0805批63条quote100%重合(63/63,dl_20753族,ts06:37),hygiene缺陷(dedup含日期未含内容指纹,1025二巡在案)重放再实证,零信息增量;近3h窗(05:05-08:05)=63条全此批(双倍权重加于噪音仍噪音);24h桶174=wechat_insight94(1027已消化回灌批)+demand_ledger63(重放)+moments9/viaim8(均已验尸出局)",
        "themes": "全史2030加权重算同轴无新向: EPC518.5让路域(371d待批)/造价168.2=JIAGE域(1027收官尾部用户闸)/法律133/AI122.5伪阳性维持/研报59.5=mp_feedback改版飞轮域/海外35.5=OVERSEAS已覆盖/KB禁推25维持;居间/资质买卖/广联达锁租=灰域族外;IPD玄学=伪阳性",
        "jtbd": "本批四步: sph_comment27=视频号平台帮助文案boilerplate(非用户Job)/moments32=生活+灰域居间/mp_feedback4=报告迭代走改版飞轮;唯一solution级Job(结算争议证据整编)=APPR-371d内核已待批勿重推",
        "verdict": "三族(研报/解决方案/在线部署工具)零新合格候选→no_proposal=radar_light_pass精确第16次,静默不推(宁缺毋滥合格常态)",
        "watch": "8a2e待批98.6h/371d待批24.0h均无decision不重推(防打扰);viaim 0新无watchlist新事件",
        "push": "none"
    }
}
with open('ledger/run-ledger.jsonl', 'a', encoding='utf-8') as f:
    f.write(json.dumps(entry, ensure_ascii=False) + '\n')
print('appended @', ts)
