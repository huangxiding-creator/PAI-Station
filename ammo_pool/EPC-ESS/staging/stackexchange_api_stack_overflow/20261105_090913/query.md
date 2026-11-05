# StackExchange API 2.3 (search/advanced) 检索简报 | 全国发展和改革委员会

本件为渠道普查纳管 (1025令) 新接入的 StackExchange API 2.3 (search/advanced) 渠道一次引擎运行的实测收割面。内容=命中条目的标题、元信息与摘要/描述摘录 (cred=data, 结构化一手元数据面), 数字均引擎实测零手填。

- 检索词: 全国发展和改革委员会
- 引擎: StackExchange API 2.3 (search/advanced) (engine=stackexchange_api_stack_overflow) | 采集: 2026-11-05 09:10
- 通道: HTTP 200 via direct | https://api.stackexchange.com/2.3/search/advanced

---

## lxml text_content can not get whole text

*0分 | 1答 | python*

原文: https://stackoverflow.com/questions/31132207/lxml-text-content-can-not-get-whole-text

**摘要/描述摘录:**
> As title says,  div[@class="posts-cont"]  contain a lot of sentences, but   text_content()  seems only get the first sentence splited by  &lt;br&gt;...   

>   &gt;&gt;&gt;import requests
> &gt;&gt;&gt;from lxml import html
> &gt;&gt;&gt;url = 'http://club.kdnet.net/dispbbs.asp?boardid=1&amp;id=9964430'
> &gt;&gt;&gt;r = requests.get(url)
> &gt;&gt;&gt;h = html.document_fromstring(r.content)
> &gt;&gt;&gt;h.cssselect('.posts-cont')[0].text_content()

>    u'\r\n\t\t\t\t\t\xa0\xa0\xa0\xa0\u6587/\u65b0\u6d6a\u8d22\u7ecf\u4e13\u680f\u4f5c\u5bb6\xa0\xa0\u4e01\u9053\u9f50\xa0\xa0\xa0\xa0\u4ea4\u6d41\u7279\u9ad8\u538b\u8f93\u7535\u5efa\u8bbe\u6210\u672c\u6700\u9ad8\u4e14'


>  the block: 

>                       &lt;div class="posts-cont" style="word-spacing: 2px;"&gt;
>                 &amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;文/新浪财经专栏作家&amp;nbsp;&amp;nbsp;丁道齐&lt;br&gt;&lt;br&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;交流特高压输电建设成本最高且沒有经济实用输电距离，世界各国几十年前就弃用交流特高压远距离输电采用直流远距离输电。采用交流特高压远距离输电及组网比采用特高压直流远距离输电加超高压交流加强受端电网的组网就贵2倍以上。【专栏讨论：特高压到底该不该上】&lt;br&gt;&lt;br&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;img SRC="http://i3.sinaimg.cn/cj/2014/0402/U10971P31DT20140402113618.jpg" alt="" border="0" / onclick="javascript:if((!(this.width&lt;600))||(!(this.width&lt;100)&amp;&amp;!(this.height&lt;100)))window.open('http://club.kdnet.net/atlas/index.asp?id=9964430&amp;pic='+escape(this.src.replace('.cat898.com/','.kdnet.net/').replace('/UploadSmall/','/Upload/')));"  class="img-src"   onload="javascript:if (th

---

合计 1 条命中 (源状态与代理路径如实记录于台账; 零手填)。