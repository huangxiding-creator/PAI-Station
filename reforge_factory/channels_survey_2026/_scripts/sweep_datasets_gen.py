import json, os
P = []
def e(name, site, one, access, cn, fit, ev):
    P.append({"name": name, "repo_or_site": site, "one_liner": one, "access": access, "cn_reach": cn, "fit": fit, "evidence": ev})

# ---- 学术API族 ----
e("OpenAlex API", "https://api.openalex.org", "2.5亿+学术作品/作者/机构开放元数据图谱,微软MAG继任者,研报文献普查主力", "免登录API(匿名限额,mailto礼貌池提额)", "直连实测200", "学术专利", "HTTP 200 direct (works?per-page=1)")
e("Crossref REST API", "https://api.crossref.org", "1.6亿+DOI注册元数据,期刊/会议/资助关联,参考文献抽取", "免登录API(mailto礼貌池提额)", "直连实测200", "学术专利", "HTTP 200 direct (works?rows=1)")
e("CORE API v3", "https://api.core.ac.uk", "全球3亿+开放获取元数据与全文收割聚合,工程OA论文全文来源", "需免费key(匿名限流)", "直连301→429(匿名限流实证)", "学术专利", "301→429 direct; 官方要求注册免费key")
e("OpenAIRE Search API", "https://api.openaire.eu/search", "欧盟地平线计划资助产出+项目关联图谱,欧洲工程研究项目一手", "免登录API", "直连实测200", "学术专利/项目数据", "HTTP 200 direct")
e("Unpaywall API", "https://api.unpaywall.org", "按DOI解析合法OA全文位置,付费墙论文的免费全文定位器", "免登录API(仅需email参数)", "直连实测200", "学术专利", "HTTP 200 direct (email参数)")
e("Semantic Scholar Graph API", "https://api.semanticscholar.org", "引文网络+TLDR摘要+领域标注(本项目已在役,本次复验)", "免登录API(无key限速)", "直连实测429(限速非墙,端点活)", "学术专利", "HTTP 429 direct; 本项目在役渠道")
e("Europe PMC REST API", "https://www.ebi.ac.uk/europepmc/webservices/rest", "生命科学文献+全文,环境/水利/职业健康等工程交叉面", "免登录API", "直连实测200", "学术专利", "HTTP 200 direct")
e("arXiv API", "https://export.arxiv.org/api", "预印本检索,eess工程数学/cs/physics分册,工程前沿方法论文", "免登录API", "直连实测200(https)", "学术专利", "HTTP 200 direct; http入口301")
e("DOAJ API", "https://doaj.org/api", "2万+开放获取期刊白名单元数据,predatory刊过滤", "免登录API", "直连实测200", "学术专利", "HTTP 200 direct")
e("BASE", "https://www.base-search.net", "比勒费尔德学术索引,3.4亿+文档聚合机构仓库(补OpenAlex盲区)", "浏览器+API需合作申请", "直连000,代理实测200(需代理)", "学术专利", "HTTP 200 via proxy 7895")
e("OpenCitations", "https://opencitations.net", "开放引文索引数据集+API,引用关系透明化(引文核查)", "数据集+免登录API", "直连实测403(新端点被拦); v1端点410已弃", "学术专利", "v1 410 Gone实证; /acm/api/meta 403")
e("Springer Nature API", "https://dev.springernature.com", "Springer/Nature文献元数据,工程学科馆藏强", "需免费key", "开发者门户直连200; 数据API未实测", "学术专利", "portal HTTP 200 direct")
e("IEEE Xplore API", "https://developer.ieee.org", "IEEE电子电气计算机全文库API,工程核心文献", "需key(有免费配额)", "开发者门户直连200; 数据API未实测", "学术专利", "portal HTTP 200 direct")
e("Scopus API (Elsevier Dev)", "https://dev.elsevier.com", "Scopus摘要引文API,工程覆盖最广的订阅库", "需机构订阅key", "开发者门户直连200; 数据API未实测", "学术专利", "portal HTTP 200 direct")
e("Dimensions", "https://app.dimensions.ai", "文献+专利+资助+政策文本四库联动分析(Digital Science)", "需key(订阅,有学术免费档)", "直连实测303(门户重定向,可达)", "学术专利", "HTTP 303 direct")
e("Web of Science API", "https://clarivate.com/products/web-of-science/", "老牌引文索引,机构订阅制API", "需机构订阅key", "产品页直连301(可达)", "学术专利", "HTTP 301 direct")

# ---- 专利族 ----
e("Google Patents Public Datasets (BigQuery)", "https://patents.google.com", "美欧世等专利全量BigQuery公开表,CPC/引文/家族字段齐全,批量分析首选", "需GCP计费项目(BigQuery免额度)", "检索页代理实测200(直连000)", "学术专利", "patents.google.com 200 via proxy")
e("Google Patents 检索", "https://patents.google.com", "浏览器专利全文检索,含非公开XHR查询接口可程序化", "浏览器免登录+非公开XHR", "代理实测200(直连000,需代理)", "学术专利", "HTTP 200 via proxy")
e("EPO Espacenet + OPS API", "https://ops.epo.org/3.2/rest-services/", "欧专局全球专利检索(浏览器免登录)+OPS官方REST API", "浏览器免登录; API需免费key", "OPS直连403(无key实证拦截)", "学术专利", "OPS HTTP 403 direct (key实证)")
e("WIPO PATENTSCOPE", "https://patentscope.wipo.int", "世知组织PCT国际申请检索,70+国家藏量", "浏览器免登录; API需key", "直连实测302(会话跳转,可达)", "学术专利", "HTTP 302 direct")
e("PatentsView (USPTO)", "https://search.patentsview.org", "美国专利开放分析API,发明人/受让人/CPC聚合统计", "需免费key", "直连+代理均000(疑反爬,未实证通)", "学术专利", "000 both; 官方2023新规需注册key")
e("Lens.org API", "https://api.lens.org", "学术文献+专利双库联动检索,Lens学术免费档", "需申请key", "GET/POST直连均401(无key实证)", "学术专利", "HTTP 401 direct (GET+POST双实证)")
e("国家知识产权局专利检索系统", "https://pss-system.cponline.cnipa.gov.cn", "中国专利官方检索,中文一手专利渠道", "浏览器免登录(反爬)", "直连实测412(预条件反爬拦截)", "学术专利", "HTTP 412 direct")

# ---- 标准族 ----
e("ISO Online Browsing Platform", "https://www.iso.org/obp/ui/", "ISO标准全文条款免费在线浏览(HTML),PDF付费", "浏览器免登录", "直连403(curl探针被拦,站点在)", "标准定额造价", "HTTP 403 direct (anti-bot)")
e("IEC", "https://www.iec.ch", "国际电工标准IEC 60xxx系列,电气工程母标准", "浏览器(购买;GPICS等免费件)", "直连实测202", "标准定额造价", "HTTP 202 direct")
e("NIST Technical Series Publications", "https://www.nist.gov", "美国标准技术研究院出版物,计量/建筑/火灾工程PDF免费直下(nvlpubs)", "免登录PDF直下", "nist.gov与nvlpubs.nist.gov双站直连200", "标准定额造价", "200 direct x2")
e("ANSI Webstore", "https://webstore.ansi.org", "美国国标委标准商店,ANSI及ISO美版采购", "浏览器(付费)", "直连403(反爬,站点在)", "标准定额造价", "HTTP 403 direct")
e("ASTM International", "https://www.astm.org", "材料试验标准母版,工程建设ASTM A/C/E系列", "浏览器(付费)", "直连实测200", "标准定额造价", "HTTP 200 direct")
e("BSI", "https://www.bsigroup.com/en-GB/", "英国标准,BS EN欧标英版母版,海外EPC英系项目适用", "浏览器(付费;部分BS免费)", "直连实测200", "标准定额造价", "HTTP 200 direct")
e("DIN", "https://www.din.de/en", "德国标准DIN EN/ISO德版,机械与工程母版", "浏览器(付费;DIN SPEC部分免费)", "直连实测200", "标准定额造价", "HTTP 200 direct")
e("JISC (日本产业标准调查会)", "https://www.jisc.go.jp", "日本JIS标准体系,日系海外工程EPC适用", "浏览器(日文;英译付费)", "英文路径直连404(入口疑变,待核)", "标准定额造价", "HTTP 404 direct (path TBD)")
e("CEN-CENELEC", "https://www.cencenelec.eu", "欧洲标准EN体系(EN 1090/1991等工程建设主战场)", "浏览器(购买;部分国别门户免费)", "直连实测200", "标准定额造价", "HTTP 200 direct")
e("ASME", "https://www.asme.org", "美国机械工程师学会标准,锅炉压力容器BPVC等", "浏览器(付费)", "直连实测200", "标准定额造价", "HTTP 200 direct")

# ---- 数据集门户/清单 ----
e("awesome-public-datasets", "https://github.com/awesomedata/awesome-public-datasets", "79.7k星主题化开放数据集总目,含Architecture/Economics/Energy/GIS/Government/Transportation工程经济子集", "数据集目录(repo浏览)", "gh直连核验", "数据集", "79736 stars; README 2363行,章节行号Architecture71/Climate188/Economics438/Energy714/GIS905/Government986/Transportation2238")
e("awesome-spacecraft-engineering-datasets", "https://github.com/patrickfleith/awesome-spacecraft-engineering-datasets", "航天器工程数据集清单(产业+科研)", "数据集目录", "gh直连核验", "数据集", "110 stars (gh api)")
e("awesome-civil-engineering (QuantumNovice)", "https://github.com/QuantumNovice/awesome-civil-engineering", "土木工程软件与编程资源清单", "数据集目录(工具生态)", "gh直连核验", "数据集", "105 stars (gh api)")
e("awesome-civil-engineering (riponcm)", "https://github.com/riponcm/awesome-civil-engineering", "开源土木软件:结构FEA/岩土/交通/水利/BIM/GIS/测绘", "数据集目录(工具生态)", "gh直连核验", "数据集", "5 stars (gh api)")
e("awesome-digital-civil-engineering", "https://github.com/Ayberkrk/awesome-digital-civil-engineering", "土木与基础设施开源工具+数据集(结构/抗震/水力/BIM/点云/地理)", "数据集目录", "gh直连核验", "数据集", "3 stars (gh api)")
e("Kaggle Datasets", "https://www.kaggle.com/datasets", "众包数据集平台,含construction/cost类工程数据集", "浏览器+API需key", "直连实测200", "数据集", "HTTP 200 direct")
e("Google Dataset Search", "https://datasetsearch.research.google.com", "谷歌数据集垂直检索,按schema.org元数据聚合", "浏览器", "代理实测200(直连000,需代理)", "数据集", "HTTP 200 via proxy")
e("Zenodo API", "https://zenodo.org/api", "CERN开放仓库,Horizon欧盟项目工程数据集+DOI沉淀", "免登录API", "直连301(可达),代理跟进200", "数据集", "301→200")
e("Figshare API", "https://api.figshare.com", "学术数据集托管,工程试验数据常见载体", "免登录API(上传需key)", "直连403(探针被拦;官方开放API)", "数据集", "HTTP 403 direct (probe blocked)")
e("Dryad API", "https://datadryad.org/api/v2", "同行评审关联研究数据仓库", "免登录API", "直连实测200", "数据集", "HTTP 200 direct")
e("DataCite API", "https://api.datacite.org", "数据集DOI元数据注册库,数万仓库索引", "免登录API", "直连实测200", "数据集", "HTTP 200 direct")
e("re3data API", "https://www.re3data.org", "全球研究数据仓库注册目录,按学科定位工程数据仓库", "免登录API", "直连实测200", "数据集", "HTTP 200 direct")
e("data.gov (US CKAN)", "https://data.gov", "美国政府开放数据门户,基建/能源/采购数据集", "浏览器+CKAN API", "CKAN探针404(入口疑迁移); 门户待核", "数据集/项目数据", "package_search与site_read均404 direct")
e("data.europa.eu", "https://data.europa.eu", "欧盟开放数据门户,成员国交通/能源/工程目录", "浏览器+API", "代理实测200(直连000)", "数据集", "HTTP 200 via proxy")
e("Wikidata API", "https://www.wikidata.org", "结构化知识库,工程机构/项目/标准号实体事实源", "免登录API+SPARQL", "代理实测200(直连000)", "数据集", "HTTP 200 via proxy")
e("OpenStreetMap Overpass API", "https://overpass-api.de", "全球基础设施地理底图,路网/建筑/水利设施矢量数据", "免登录API(多镜像)", "主镜像+备用均000(当前网络不可达)", "数据集", "000 both mirrors; 官方免费无key")
e("HuggingFace Datasets API", "https://huggingface.co/api/datasets", "数据集托管+行业语料,工程中文语料渐增", "免登录API(部分下载需登录)", "代理实测200(直连000)", "数据集", "HTTP 200 via proxy")
e("Common Crawl", "https://commoncrawl.org", "PB级全网网页快照语料,自建舆情语料的原料", "数据集(S3公开桶)+索引API", "索引API代理实测200(直连000)", "数据集/新闻舆情", "index API 200 via proxy")
e("GDELT 2.0 Doc API", "https://api.gdeltproject.org", "全球新闻事件库,30秒级更新含地理与情绪", "免登录API", "直连+代理均000(当前不可达,通道仍在)", "新闻舆情", "000 both; 官方免费无key")
e("Our World in Data", "https://ourworldindata.org", "全球议题图表化数据,CSV/Grapher配置直下", "数据集+免登录CSV", "直连实测200", "数据集", "HTTP 200 direct")

# ---- 统计门户/项目数据 ----
e("World Bank Open Data API", "https://api.worldbank.org/v2", "世行14000+指标,基建投资/能源/城市专题", "免登录API", "直连实测200", "项目数据", "HTTP 200 direct")
e("World Bank Projects & Operations API", "https://search.worldbank.org/api/v2/projects", "世行贷款项目级档案,国际工程行业一手项目流", "免登录API", "直连实测200", "项目数据", "HTTP 200 direct")
e("IMF DataMapper + SDMX", "https://www.imf.org/external/datamapper/api/v1/", "国际货币基金宏观库(WEO/IFS),汇率与宏观景气底座", "免登录API(官方)", "DataMapper直连403(反爬); SDMX dataservices 000", "项目数据", "403/000 probes; 官方开放JSON文档在")
e("OECD Data Explorer SDMX", "https://sdmx.oecd.org/public/rest/", "OECD全库SDMX API,建筑指数/投资/专利(STP)", "免登录API(匿名限额)", "直连实测200(dataflow目录)", "项目数据", "HTTP 200 direct")
e("Eurostat API", "https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/", "欧盟统计局,建筑生产指数/建筑许可/PPI,欧洲工程景气主源", "免登录API", "直连实测200", "项目数据", "HTTP 200 direct")
e("UN Data Portal", "https://data.un.org", "联合国数据门户,汇集UN各统计库含能源与工业", "浏览器+SDMX API", "直连实测200", "项目数据", "HTTP 200 direct")
e("UN Comtrade API", "https://comtradeapi.un.org/data/v1/get/", "国际贸易HS全量,建材/机电进出口工程贸易流", "需免费key", "直连401(无key实证)", "项目数据", "HTTP 401 direct (实证)")
e("UNIDO Statistics", "https://stat.unido.org", "工发组织工业统计,INDSTAT产业库含建筑业分国", "浏览器(部分XLSX免下)", "直连403(反爬)", "项目数据", "HTTP 403 direct")
e("国家统计局国家数据", "https://data.stats.gov.cn", "中国官方月度/年度库,建筑业产值/固定资产投资/价格指数", "浏览器(易query接口需会话cookie)", "首页直连302; easyquery 403(需会话)", "项目数据", "302/403; 会话制实测")
e("US Census Bureau API", "https://api.census.gov", "美国普查局,建设支出C30/经济普查,美国工程量价源", "需免费key(data.json目录免)", "data.json代理实测200(直连000)", "项目数据", "data.json 200 via proxy")
e("BLS Public Data API", "https://api.bls.gov/publicAPI/v2/timeseries/data/", "美国劳工统计局,PPI建材/就业/CPI,造价通胀底座", "免登录API(注册key提额)", "直连403(探针被拦;官方公共API文档明确no-key)", "项目数据", "HTTP 403 probe; 官方no-key文档")
e("FRED API", "https://api.stlouisfed.org", "圣路易斯联储宏观数据库10万+序列,住宅建筑/材料价格序列", "需免费key", "直连400(缺api_key实证)", "项目数据", "HTTP 400 direct (missing key实证)")
e("EIA API v2", "https://api.eia.gov/v2", "美国能源信息署,电力/油气全量,能源工程量价", "需免费key", "直连403(无key实证)", "项目数据", "HTTP 403 direct (实证)")
e("IEA Data & Statistics", "https://www.iea.org/data-and-statistics", "国际能源署,能源平衡表/电力基建投资,能源转型数据", "浏览器(部分数据产品付费)", "直连403(反爬)", "项目数据", "HTTP 403 direct")
e("ADB Projects & Statistics", "https://www.adb.org/projects", "亚行项目库+基本统计,亚洲工程贷款一手项目流", "浏览器", "直连+代理均000(当前不可达,官方公开)", "项目数据", "000 both")
e("AidData", "https://www.aiddata.org", "发展融资地理编码数据集,含中国对外工程融资追踪", "数据集免登录下载", "代理实测200(直连000)", "项目数据", "HTTP 200 via proxy")
e("USAspending API", "https://api.usaspending.gov", "美国联邦支出全透明API,含联邦工程合同与受援方", "免登录API", "直连实测200", "项目数据", "HTTP 200 direct")
e("Open Contracting Data Registry", "https://data.open-contracting.org", "全球公共采购开放数据注册表,OCDS工程招标结构化", "数据集+免登录", "代理实测200(直连000)", "项目数据", "HTTP 200 via proxy")
e("TED (Tenders Electronic Daily)", "https://ted.europa.eu", "欧盟官方招标公报,欧洲工程procurement一手,v3 API匿名限额", "浏览器+API(匿名限额)", "直连实测202", "项目数据", "HTTP 202 direct")

names = [x["name"] for x in P]
assert len(names) == len(set(names)), "dup found"
doc = {
  "sweep": "sweep_datasets",
  "lane": "数据集/学术文献/专利/标准/统计门户",
  "generated": "2026-10-25",
  "method": "curl实测HTTP状态码(直连→7895代理兜底,-L跟进重定向)+gh api仓库核验; 403/000多为反爬或瞬时不可达,非通道死亡判定; 官方文档形态如实标注未实测项",
  "proxy": "http://127.0.0.1:7895",
  "count": len(P),
  "projects": P,
}
out = "E:/AI-Station/reforge_factory/channels_survey_2026/sweep_datasets.json"
with open(out, "w", encoding="utf-8") as f:
    json.dump(doc, f, ensure_ascii=False, indent=2)
print("count", len(P), "bytes", os.path.getsize(out))
