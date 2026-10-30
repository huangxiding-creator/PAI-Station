# -*- coding: utf-8 -*-
import json
from pathlib import Path
OUT = Path(r"E:/AI-Station/reforge_factory/channels_survey_2026/sweep_enterprise.json")
P = []
def a(name, site, desc, access, cn, fit, ev):
    P.append({"name": name, "repo_or_site": site, "desc": desc, "access": access,
              "cn_reachable": cn, "fit": fit, "stars_or_evidence": ev})
# 一、工商股权司法族
a("国家企业信用信息公示系统", "https://gsxt.gov.cn", "全国企业工商登记权威官方源: 股东出资/股权变更/行政处罚/经营异常/年报", "浏览器检索(滑块验证码闸门,详情页需免费登录; 无官方API)", "curl直连000/代理000(强反爬非死站)", "工商", "探活000/000; gh: youfeng243/gsxt_crawler(3*,2017旧件)佐证闸门史")
a("企查查", "https://www.qcc.com", "工程企业全景情报: 工商/股权/招投标/资质/司法/风险一手聚合站", "免费面+付费面,仅用免费面(免登录网页基础查询/VIP日额度内明细; 官方API=付费面不用)", "直连200", "工商", "直连200; gh: CooperMin/qichacha(43*)/bouxin/company-crawler(735*,天眼查+企查查)")
a("天眼查", "https://www.tianyancha.com", "企业关系图谱/实控链/司法风险/招投标聚合, 工程企业调研常用主力", "免费面+付费面,仅用免费面(免登录基础查询+登录免费额度; API=付费面不用)", "直连200", "工商", "直连200; gh: bouxin/company-crawler(735*)/acpyin/tianyancha(92*)")
a("爱企查(百度)", "https://aiqicha.baidu.com", "百度系工商情报免费开放面最宽: 股东/法人/分支机构/风险免费可查", "免费面+付费面,仅用免费面(免登录网页查询; API走百度智能云=付费面不用)", "直连200", "工商", "直连200")
a("启信宝", "https://www.qixin.com", "工商+司法+资质聚合查询, 免费面覆盖企业基础画像", "免费面+付费面,仅用免费面(免登录/免费注册基础查询; API=付费面不用)", "直连200", "工商", "直连200")
a("中国裁判文书网", "https://wenshu.court.gov.cn", "司法文书全库: 工程合同纠纷/施工判决/保全执行一手文本", "浏览器检索(2021-10后需免费注册登录+查询码; 无公开API)", "直连200", "黑名单(司法涉诉)", "直连200; gh: cncases/cases(1142*,文书本地搜索)/sml2h3h3/mmewmd_crack_for_wenshu(476*); 已有: 工厂court渠道(涉诉检索)在役")
a("信用中国", "https://www.creditchina.gov.cn", "国家信用公示总入口: 行政许可/行政处罚/失信惩戒/严重失信主体名单", "免登录检索(浏览器; 反爬412实测,curl需绕行)", "直连412(反爬实测,浏览器可达)", "黑名单(信用奖惩)", "412实测; gh: Zicaibucai/creditchina-monitor(2*)")
a("中国执行信息公开网", "https://zxgk.court.gov.cn", "被执行人/失信被执行人/终本案件公示", "浏览器检索(验证码闸门)", "直连200", "黑名单(失信执行)", "直连200")
a("OpenCorporates", "https://opencorporates.com", "全球2.2亿+公司工商登记聚合(140+司法辖区), 国际承包商母体/子公司穿透", "免费面+付费面,仅用免费面(免登录网页检索; API=付费面按令排除)", "直连200", "工商(全球)", "直连200; gh: openc/openc-schema(23*)/pjryan126/opyncorporates(13*)")
a("Open Ownership Register", "https://www.openownership.org", "全球受益所有权(UBO)公开登记库, 股权实控穿透国际开放数据", "免费数据集下载+免登录网页(免费); register API直连000待验", "www直连000/代理302(站点活)", "工商(全球UBO)", "代理302实测")
a("英国Companies House", "https://find-and-update.company-information.service.gov.uk/", "英国公司注册官方全库: 高管/年报/抵押/PSC实控人, 国际承包商尽调标配", "免费面+付费面,仅用免费面(免登录网页检索+免费注册API key免费层; 增值产品不用)", "直连200", "工商(全球)", "直连200")
# 二、资质业绩族
a("四库一平台/全国建筑市场监管公共服务平台", "https://jzsc.mohurd.gov.cn", "住建部企业资质/注册人员/工程业绩三库权威源, 建筑企业调研第一官方口径", "免登录网页检索(企业/人员/业绩三面); 公开JSON端点POST实测405待另探GET形态", "直连200", "资质业绩", "直连200; POST /data/company/list=405实测如实")
a("全国公路建设市场信用信息管理系统", "https://glxy.mot.gov.cn", "交通运输部公路施工/监理资质+信用评价+不良行为记录", "浏览器免费公开查询", "curl直连000/代理000(待浏览器复验)", "资质业绩(公路)", "探活000/000如实记录, 站点存在性以行业公开资料佐证")
a("全国水利建设市场监管平台", "http://xypt.mwr.cn", "水利部水利建设市场主体信用/资质/不良行为公示, 与水利EPC主战场直接对口", "浏览器免费公开查询", "http直连500/https 000(站点波动实测)", "资质业绩(水利)", "500/000实测如实")
a("国家能源局电力业务资质", "https://www.nea.gov.cn", "电力业务许可(发电/输电/供电)资质公示与资质和信用信息系统入口", "浏览器免费栏目检索(子系统入口见官网)", "直连200", "资质业绩(电力)", "直连200")
a("商务部对外投资合作信息服务", "https://fec.mofcom.gov.cn", "对外承包工程项目备案/境外工程项目与劳务统计, 对外承包工程资格备案件公示面", "免登录检索(项目备案/统计栏目)", "直连200", "资质业绩(对外承包)", "直连200")
a("中国对外承包工程商会(CHINCA)", "https://www.chinca.org", "对外承包工程行业口径统计/ENR榜单中国区组织申报方/行业自律名单", "免登录网页(纯HTTP过闸件在案)", "直连200", "资质业绩(对外承包)/行业组织", "直连200; 已有复刻件: 逆向工程/chinca-reverse(acw_sc__v2挑战纯HTTP通关在案)")
# 三、招投标族
a("全国公共资源交易平台", "https://www.ggzy.gov.cn", "全国省级公共资源交易公告聚合总门户(工程建设/政采/土地)", "免登录检索(公告聚合)", "www直连200(裸域000/502)", "招投标", "www直连200实测")
a("中国招标投标公共服务平台", "http://www.cebpubservice.com", "全国招投标公告公共服务枢纽(bulletin子站聚合招标公告)", "免登录检索(bulletin公告子站)", "直连200", "招投标", "直连200")
a("千里马招标网", "https://www.qianlima.com", "全国招标公告聚合主力之一(千里马系), 工程类公告覆盖深", "免费面+付费面,仅用免费面(免登录公告检索/公开公告页; 会员明细不用)", "直连200", "招投标", "直连200; 已有蓝本: 逆向工程/xique-reverse(喜鹊标书Tauri逆向,千里马系同构)")
a("建设通", "https://www.jianshe99.com", "建筑业企业中标业绩/资质/荣誉库, 建企业绩尽调常用", "免费面+付费面,仅用免费面(免登录企业/工程基础检索; 会员明细不用)", "直连200", "资质业绩(中标业绩)/招投标", "直连200")
a("比地招标网", "https://www.bidizhaobiao.com", "招标公告聚合+拟建项目信息, 免费检索面较宽", "免费面+付费面,仅用免费面(免登录公告检索)", "直连200", "招投标", "直连200")
a("采招网", "https://www.bidcenter.com.cn", "老牌招标采购信息聚合(工程/货物/服务)", "免费面+付费面,仅用免费面(免登录公告列表; 会员明细不用)", "www直连200(china子域000)", "招投标", "www直连200实测")
a("必联网", "https://www.ebnew.com", "必联电子招标采购公告面(央企/国际标的为主)", "免费面+付费面,仅用免费面(免登录公告浏览)", "直连200", "招投标", "直连200")
a("剑鱼标讯", "https://www.jianyu360.com", "招标数据聚合平台, 免费面提供公告检索与订阅额度", "免费面+付费面,仅用免费面(免登录/免费注册检索)", "直连200", "招投标", "直连200")
a("中国政府采购网", "http://www.ccgp.gov.cn", "财政部政采公告总库: 工程/服务采购公告与地方分站同构检索", "免登录检索(search.ccgp.gov.cn POST端点实测200, 无key)", "www直连200+search POST 200", "招投标(政采)", "POST search.ccgp.gov.cn/bxsearch实测200")
a("国家电网电子商务平台", "https://ecp.sgcc.com.cn", "国网输变电/配网工程招标与中标公告(电力工程EPC一手)", "免登录公告检索", "直连200", "招投标(电力)", "直连200")
a("国铁采购平台", "https://cg.95306.cn", "铁路工程建设/物资招标公告国铁官方平台", "免登录公告检索", "直连200", "招投标(铁路)", "直连200")
a("TED欧盟招标公报", "https://ted.europa.eu", "欧盟全境公共采购公报(Simplified API v3, 工程指令标的), 国际工程投标情报", "免费面+付费面,仅用免费面(免登录网页检索+免费注册key的官方API; 增值服务不用)", "直连202(质询码,站点活)", "招投标(欧盟)", "直连202实测")
# 四、资本市场族
a("巨潮资讯网", "http://www.cninfo.com.cn", "法定信息披露全库: 深沪北三市公告/年报/债券, 上市建企与业主方一手", "免登录API(POST /new/hisAnnouncement/query 实测200)+免登录网页", "直连200+POST端点200", "资本", "POST实测200; gh: legeling/Annualreport_tools(269*,巨潮年报爬取)/jarodise/CNinfo2Notebookllm(365*)")
a("上海证券交易所", "https://www.sse.com.cn", "沪市公告/监管问询/ESG披露, query.sse.com.cn JSON接口免key", "免登录API(query.sse.com.cn JSON+Referer头, 实测200)+网页", "直连200+query API 200", "资本", "query.sse.com.cn/commonQuery实测200(带Referer)")
a("深圳证券交易所", "https://www.szse.cn", "深市公告/统计, /api/report/ShowReport 系列JSON免key", "免登录API(/api/report/ShowReport实测200)+网页", "直连200+api端点200", "资本", "api/report/ShowReport?SHOWTYPE=JSON实测200")
a("新三板(股转系统)", "https://www.neeq.com.cn", "新三板挂牌建企公告/年报/定向发行披露", "免登录检索(网页; 接口形态待验)", "直连200", "资本", "直连200")
a("港交所披露易", "https://www1.hkexnews.hk", "港股公告全库(中资国际承包商H股一手)", "免登录检索(全文检索表单面)", "直连200", "资本", "直连200")
a("SEC EDGAR", "https://efts.sec.gov/LATEST/search-index", "美股全量披露库: 全文检索API免key(efts)+submissions JSON(data.sec.gov), 国际承包商母公司尽调", "免登录API(全文检索+submissions JSON, 需声明UA, 实测200)", "efts直连200+data.sec.gov直连200", "资本(全球)", "双端点200实测; gh: dgunning/edgartools(2815*)/sec-edgar/sec-edgar(1418*)")
a("USAspending API", "https://api.usaspending.gov", "美国联邦合同/拨款全库开放API, 美国市场工程承包商合同履历一手", "免登录API(keyless, 实测200)", "直连200", "资本(全球)", "api/v2/references/agency实测200")
# 五、国际开发银行与黑名单族
a("世界银行项目库API", "https://search.worldbank.org/api/v2/projects", "世行贷款项目全库(项目文件/采购包/实施机构), 国际工程市场结构一手", "免登录API(keyless, 实测200; 注意 projects.worldbank.org/API/v3已404)", "直连200", "招投标(国际开发)/资本", "search.worldbank.org/api/v2实测200; gh: gshs-ornl/wbstats(130*)")
a("世行除名企业清单(AEO)", "https://www.worldbank.org/en/projects-operations/procurement/debarred-firms", "世行制裁除名企业清单+交叉除名(AEO)名单, 国际工程合规黑名单第一源", "免登录网页+清单数据集下载", "直连200", "黑名单", "直连200")
a("亚洲开发银行(ADB)", "https://www.adb.org/projects", "亚行项目库+制裁名单(含交叉除名清单下载), 亚太工程市场一手", "免登录网页+制裁清单文件下载", "curl直连000/代理403(WAF拒curl,浏览器复验待做)", "招投标(国际开发)/黑名单", "000/403实测如实")
a("亚投行(AIIB)", "https://www.aiib.org/en/projects/index.html", "亚投行项目库(批准项目/采购公告), 新兴市场基建工程一手", "免登录网页", "直连000/代理200", "招投标(国际开发)", "代理200实测")
a("UNGM联合国全球市场", "https://www.ungm.org", "联合国系统采购招标统一门户(UNDP/UNOPS等), 人道与基建标的", "免费面: 检索免登录+免费注册账号下载文档(全免费)", "直连200", "招投标(联合国采购)", "直连200")
a("EBRD项目数据库", "https://www.ebrd.com/work-with-us/procurement/projects-database.html", "欧洲复兴开发银行项目与采购数据库, 中亚/东欧工程市场", "免登录网页", "直连200", "招投标(国际开发)", "直连200")
a("SAM.gov排除名单", "https://sam.gov/content/exclusions", "美国联邦政府禁入/排除名单(实体制裁), 涉美合规黑名单官方源", "免登录网页检索(排除面)+免费注册key(Entity API免费层)", "直连200", "黑名单", "直连200; gh: leighmckenna/anthropic-sam-watchdog等周边件")
# 六、行业组织与评级族
a("中国建筑业协会", "http://www.ecaci.org.cn", "建筑业全国性行业协会: 行业统计/评优(鲁班奖发布方之一)/政策解读", "免登录网页", "curl直连000/代理502(站点波动/域名待浏览器复核)", "行业组织", "000/502实测如实, 复核待做")
a("中施企协(中国施工企业管理协会)", "http://www.cacem.com.cn", "施工企业全国协会: 工程建设企业社会贡献度/百强序列/信用评价名单", "免登录网页(名单公示)", "直连200", "行业组织", "直连200")
a("中信保(Sinosure)国别风险公开面", "https://www.sinosure.com.cn", "出口信用保险官方: 国别风险分析报告/风险提示免费栏目, 海外工程市场风险一手", "免费面+付费面,仅用免费面(国别风险报告/风险资讯栏目免费; 买方资信报告=付费面不用)", "直连200", "资本(信用风险)", "直连200")
a("FIDIC国际咨询工程师联合会", "https://fidic.org", "国际工程合同条件(FIDIC条款)权威与行业动态, 国际工程规则面", "免登录网页", "直连200", "行业组织(国际)", "直连200")
a("FIEC欧洲建筑业联合会", "https://fiec.org", "欧洲建筑业联合会: 欧洲建市统计/政策公报, 欧洲工程市场结构", "免登录网页", "curl直连000/代理000(待浏览器复验)", "行业组织(国际)", "000/000实测如实")
a("EIC欧洲国际承包商", "https://eic.fiec.org", "欧洲国际承包商联合会立场文件与海外市场报告, 国际承包商阵营情报", "免登录网页", "curl直连000/代理000(待浏览器复验)", "行业组织(国际)", "000/000实测如实")
a("ENR工程新闻纪录", "https://www.enr.com", "国际工程界权威排行(Top 250 Global Contractors); 本体Cloudflare墙, 走CHINCA官方榜文镜像链", "免登录(经chinca.org镜像链, 复刻件在案); enr.com本体403不直接用", "直连403(cf-mitigated challenge)", "行业组织(国际)/舆情", "直连403实测; 已有: 逆向工程/enr-reverse(镜像链收官,Top250全量在案)")
# 七、媒体舆情族补充
a("建筑时报", "http://www.jzsbs.com", "建筑业行业报纸: 企业动态/工程事故/行业政策舆情", "免登录网页", "直连200", "舆情", "直连200")
a("中国建设报/中国建设新闻网", "http://www.chinajsb.cn", "住建部主管行业报: 政策首发解读/建企新闻, 官方口径舆情面", "免登录网页", "直连200", "舆情", "直连200")
a("百年建筑网", "https://www.100njz.com", "建材行情与工程项目信息(水泥/砂石/混凝土价格指数), 工程成本面舆情", "免费面+付费面,仅用免费面(行情资讯免登录; 会员报告不用)", "直连200", "舆情(建材成本)", "直连200")
a("我的钢铁网", "https://www.mysteel.com", "钢材价格行情资讯(工程主材成本一手), 免费行情面宽", "免费面+付费面,仅用免费面(行情/资讯免登录; 数据API=付费面不用)", "直连200", "舆情(材料成本)", "直连200")
a("中国水泥网", "https://www.ccement.com", "水泥价格指数与行业数据(基建实物量风向标)", "免费面+付费面,仅用免费面(行情免登录; 大数据API=付费面不用)", "直连200", "舆情(材料成本)", "直连200")
# 按免费令排除登记(纯付费)
a("邓白氏D&B(纯付费-按令排除)", "https://www.dnb.com", "纯付费-按令排除: 全球企业征信数据库(D-U-N-S家族树/深度报告面), 官网无公开免费检索面可验证, 按免费令不入使用册", "纯付费, 按免费令排除", "未探活(按排除令省请求)", "工商(全球)", "按令排除登记, 未耗探活请求")
notes = ("用户令: 有益于调研工程企业的渠道尽最大可能收集齐(中国+国际双域)。"
  "方法: curl实测HTTP码(直连GET→7895代理兜底, 每站≤2请求)+gh api仓库核验+已有资产对照"
  "(逆向工程/xique-reverse,chinca-reverse,enr-reverse; channel_manifest court/govlist在役)。"
  "免费令执行: 含付费面条目15条保留免费面且access仅述免费路径(标注「免费面+付费面,仅用免费面」): "
  "企查查/天眼查/爱企查/启信宝/千里马/建设通/比地/采招网/必联/剑鱼/OpenCorporates/"
  "Companies House增值面/TED增值面/中信保资信面/百年建筑+我的钢铁+水泥网数据面(末三项合并计3条)。"
  "纯付费无免费面=1条(邓白氏D&B)desc明标「纯付费-按令排除」不入使用册。"
  "A级(免登录API/端点)7个: SEC EDGAR(efts+data.sec.gov双端点)/世行项目API v2/USAspending/"
  "上交所query/深交所api/巨潮POST query/政采search POST。"
  "各族覆盖: 工商股权司法11/资质业绩7(含商会)/招投标13/资本市场7/国际开发与黑名单7/行业组织7/媒体舆情5。"
  "探活异常如实记录: gsxt与glxy.mot直连代理双000(强反爬), adb.org代理403(WAF拒curl), "
  "ecaci.org.cn与fiec系000待浏览器复验, xypt.mwr 500波动, creditchina 412反爬, "
  "enr.com 403走chinca镜像链(复刻件在案), 世行API v3已死404改用v2。"
  "未注册任何账号、未爬任何大数据(铁律)。溯源件: _scripts/probe_enterprise.sh+probe_enterprise_results.tsv。")
doc = {"sweep": "sweep_enterprise", "lane": "enterprise", "generated": "2026-10-25",
  "method": "curl探活(直连→7895代理兜底,≤2请求/站)+gh api仓库核验+已有资产对照; 全部HTTP码为1025实测, 零手填",
  "count": len(P), "projects": P, "notes": notes}
OUT.write_text(json.dumps(doc, ensure_ascii=False, indent=2), encoding="utf-8")
print("written", OUT, "count=", len(P))
