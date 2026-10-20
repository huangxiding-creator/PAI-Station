标题: 

大家好，我是 Ai 学习的老章

Anthropic 这家公司是真的恶，但也真的很有货

刚外面逛推，被 Anthropic 工程主管 Felix Rieseberg 的一篇万字长文刷屏了

陶哲轩之前评价现在的顶级大模型，说过一句特别精辟的话：“模型的能力在某些方向上令人惊叹，而在另一些方向上又显得笨拙”

现实中确实也是这样

一部分人抓住了那些令人惊叹的超强能力，玩得像在天空中自由翱翔；但更多的人，还在拼命跟自己新长出来的翅膀较劲，拿着世界上最聪明的模型，日常也就是问问“法国首都在哪”或者“帮我把这封邮件改得更正式”

说实话，这就相当于开着歼 -20 去送外卖，暴殄天物

Felix 在文章里大声疾呼：我们在使用模型时，必须更有野心（Be More Ambitious）！

他在 Anthropic 负责 Claude ai、Cowork 以及 Claude Code Desktop 等核心产品工程，此前还是 Electron 的长期核心维护者，在 Notion、Stripe、Slack、微软都干过，是真正天天泡在大模型最前线、看着成千上万顶尖用户折腾 AI 的老手

该骂骂，该学学

今天老章把他的整篇核心长文、实操案例以及海外技术社区最激烈的交锋讨论全盘拆解了一遍，必须把这套真正拉开人与人差距的“野心提问法”分享给大家

简介：什么才叫真正有野心的用法很多人一提到用 AI 提高效率，第一反应就是“做同样的事情，花更少的时间”

写代码更快了，写周报更省事了，做个小工具省了半天工时

Felix 把这种追求称为速度

这当然是 AI 最基础、最稳固的经济价值，只要你需要写代码、写文案，开个 Claude 确实能让你快上好几倍

但这东西已经人尽皆知，而且压根不需要你有多大的创造力，所以 Felix 在长文里直接把它略过了

真正能拉开代差的野心，体现在另外三个核心维度：高度（Altitude）、深度（Depth）与广度（Range）

这三个维度到底该怎么用？我们一个一个来看，保证看完刷新你的认知

高度（Altitude）：跳出具体指令，追问最终结果我们在让 AI 干活时，往往容易陷入微观操作的泥潭

你让模型去改一个函数，模型就老老实实执行你的猜想，但这往往只是通往最终结果的一条小路，甚至可能是条弯路

要想在高度上拥有野心，下达指令前你必须多问自己一句：“这件事情搞定之后，我真正希望发生什么？目标背后的终极目标到底是什么？”

Felix 举了他自己的亲身经历：

在去年初的时候，他还在让 Claude 帮他修一个又一个具体的应用崩溃

修完这个，又来那个，疲于奔命

后来他突然想明白了，他直接把要求拉升到了最高抽象层级：“Claude，让我们的客户端应用持续保持零崩溃”

为了实现这个终极目标，他的整个工作流全变了：

他不再是手动复制错误日志发给 AI，而是给 Claude 配备了拉取崩溃报告的权限，让 Claude 自动将版本号映射到具体的 Git commit，甚至给 Claude 接入了 Windows、macOS 和 Linux 三套独立的系统测试环境，让 Claude 能够自主复现 Bug、验证修复、提交补丁并全自动跑回归测试

你看，当你把抽象层级拉高，你才可能构建出真正持久的、把人类解放出来的全自动工作流

为了说明日常办公场景怎么做，Felix 还拿大厂最常见的“季度业务回顾”（QBR）做了一个堪称典范的三步升维演练

下面这张阶梯图完整呈现了这种思维跃迁：

QBR 高度跃迁阶梯著名技术作家 Thorsten Ball 在推特上特意把这段案例单拎出来盛赞：

让我们看看这三步的具体差别：

第一步（普通初级做法）： 领导让你做季度业务汇报，你有一份 PPT 模板，绝大多数人就是把这季度的数字手动往模板里填，顶多让 AI 润色一下句子

第二步（进阶有野心）： 忍住直接填模板的冲动，把你能找到的全部一手业务数据全喂给模型，让模型理解你们公司的实际运转情况，直接问它：“告诉我这个季度到底发生了什么变化、为什么会变、我们该采取什么行动？根据你学到的一切，梳理出眼前最紧急的 3 个关键决策，并为每个决策给出正反论证”

第三步（终极野心）： 追问 QBR 这项制度诞生的初衷，几十年前之所以要开季度汇报会，是因为那时候数据分散，需要人类花大量时间人肉筛选整理，高管才能早点发现问题、调配资金和人手

既然如此，直接对 Claude 说：“季度回顾存在的终极目的，是让管理层尽早发现问题并调配资源，请设计一套比季度 PPT 更好的全新机制，用我们过去的历史数据证明它能比现在更早发现问题，并且在下一个季度与现有汇报并行试跑”

看到这里的格局差距了吗？

你还在给老板当幻灯片排版工，有野心的人已经开始让 AI 帮管理层重构决策系统了

Felix 给出了一个很实用的判断标准：如果你当前手头在做的工作，后续还需要频繁开会来讨论和拍板，这项工作大概率就非常适合用“高度”视角来重新思考！

深度（Depth）：逼模型像顶级专家一样下场干活很多同学说：“老章，我也经常在提示词里写‘你是一位资深架构师/首席数据科学家’啊，怎么感觉它给的建议还是车轱辘话？”

Felix 一针见血指出了症结所在：

当你仅仅在提示词里让模型扮演专业人士时，模型往往只是换了一套行业黑话，实际采用的方法却丝毫没有长进！

要想在“深度”上拥有野心，就必须逼迫模型去使用该领域最顶尖专家所使用的真实工具、专业方法、原始素材与理论框架，一直推进到连行业大牛看了你的成果都能学到新东西为止

Felix 总结了五条深度实操秘诀：

1. 强制要求使用行业顶尖专家的真实武器： 当你让 Claude 分析数据，如果它只满足于给你吐出几个 Markdown 格式的简单文本表格，立刻打回去！强行要求它使用工业级数据库、严谨的统计学回归模型与因果推断方法，哪怕你不知道专家用什么，直接问 Claude，它自己全懂

2. 提出看似不可思议的超高目标，并坚定告诉它这非常合理： 网页加载时间想从 10 秒压到 5 秒？别提 5 秒，直接要求压到 200 毫秒！当模型叫苦觉得不可能时，明确告诉它：“这在工程上完全可以解决，继续往下深挖，不要停”

3. 用原始底层数据反向对抗既有假设： 业务里很多所谓的常识，其实都只是对现实的粗糙脑补，把最底层的原始日志全部扔给模型：“管理层普遍认为用户流失是新手引导没做好导致的，请完全基于原始日志，尝试能否复现并证实这个结论”

4. 挖掘盲区，创造前所未有的新知识： 让模型在真实日志中建立微观用户行为模拟器，去预测它从未见过的新数据，找出连老员工都从未注意到的早期流失信号

5. 必须引入客观的外部裁判： 这一条至关重要！在当下大模型发展的阶段，绝对不要让模型自己去评判自己的答案，它会陷入自我感动，必须引入能够运行代码、单元测试、基准跑分的外部校验工具，让模型在实打实的客观反馈下快速迭代

为了方便大家直接上手，Felix 贡献了一段可以直接复制的黄金深度提示词：

老章特意把这段提示词的核心逻辑做了精准汉化，建议大家全文收藏到自己的常用提示词库里：

我想把这项任务做成更深度的版本，不要仅仅做成更庞大的版本

在重写我的任务提示词之前，请先完成以下四件事：
1. 明确指出该领域最顶尖的专家在这里会做些什么，而这些是我当前根本没有想到的？
2. 指出他们会从什么样最原始的底层素材和数据开始，放弃使用别人已经为我消化过的二手结论？
3. 列出他们会具体使用的专业工具、统计模型与工作方法；
4. 说明除了你和我之外，有什么客观的外部标准或工具能够证明最终的结果是完全正确的？

梳理清楚以上四点后，请重新改写我的提示词，完全按照这个顶尖专家的标准向你发起提问
这段提示词最厉害的地方，在于它把“如何成为专家”的思考负担直接反抛给了模型，让模型从底层工具、一手数据和客观验收三个维度，主动把任务提升到工业级水准

广度（Range）：打破学科隔离，召集你的跨界天团所谓的广度，就是站在完全不同学科和领域的视角来审视当前的工作

好莱坞所有的经典盗宝大片（Heist Movie），开头半小时永远是招募一群身怀绝技的奇人异士：黑客、爆破手、伪装大师、机械专家

多 Agent 系统以及带有子代理的 AI 工具已经越来越成熟，调用跨领域的专业智慧变得极度廉价

但怎么才能跳出固有思维？Felix 传授了两个绝招：

绝招一：把“名词”换成“动词”这个技巧来自全球顶级设计创新公司 IDEO 创始人写的名作《创新艺术》

举个例子：

如果你的思维停留在名词上，要做一个季度汇报，你的脑海里就只有“一份 PPT 幻灯片”

但如果你把名词拆解成具体的动词：

“在 30 分钟的时间里，让一群极度忙碌、注意力分散的人，看懂事物背后的因果关系，并敢于在充满不确定性的局面下迅速做出重大决断”

当你看到这串动词的时候，你的思路瞬间打开了！

为了完成这个动词目标，你需要什么样的专业视角？

绝招二：组建跨界特遣队与红队审查单靠一个打工人的脑袋显然不够，你需要召集一个全明星阵容：

数据分析师： 负责清洗底层数据、做相关性验证
调查记者： 负责挖掘冰冷数字背后的人性故事与真实动机
主编： 负责提炼叙事主线，砍掉废话
动效与音频设计师： 负责设计 30 分钟内的信息节奏与视觉注意力抓手
做空机构分析师： 假想自己要恶意做空这家公司，用最苛刻的眼光挑出数据里的漏洞与自欺欺人
法务会计师： 穿透财务表象，审查账目与资产真实流动
Felix 特别提醒：千万不要让模型去玩劣质的角色扮演！

给模型扣个“你是一个做空机构经理”的帽子，往往只会让对话记录变得油腔滑调

正确的做法，是要求模型直接调用做空机构分析师实际使用的研究方法和审计步骤，对业务数据发起严酷审查

破局：心理学的「自我效能感」与冷思考聊完方法论，Felix 在文章后半部分探寻了一个更深刻的问题：为什么我们明明手里攥着这么强大的工具，却始终不敢放开手脚去想象？

心理学上把这种现象称为“自我效能感”（Self-efficacy）

简单来说，那些对自己能力拥有强烈信念的人，往往最终能取得远超常人的成就

很多人并不是能力不行，而是被自己过去的认知边界死死困住了

Felix 举了三个极其震撼的真实历史案例：

1. 坚信事情是可以被解决的： 1939 年，数学家乔治·丹齐格（George Dantzig）在伯克利上统计学课迟到了，急匆匆把黑板上写着的两道题抄了下来，以为是当天的课后作业，花几天时间硬生生给解了出来，直到教授激动地找上门，他才知道那其实是统计学历史上悬而未决的两大世界级未解难题！正因为他不知道那是不可能完成的，他才把它做成了

2. 看到别人做成之后打破心防： 在人类田径史上，“4 分钟跑完一英里”曾经被医学界断言是人类生理极限，直到 1954 年罗杰·班尼斯特（Roger Bannister）打破了这个记录，神奇的事情发生了：仅仅过了 46 天，第二位选手就同样突破了 4 分钟大关！信念的枷锁一旦打碎，极限就不复存在

3. 允许自己失败： 很多人之所以不敢尝试有野心的大目标，是因为太想把事情做完美了，心理压力极大；当年林纳斯写 Linux 的时候，在邮件列表里云淡风轻地写道：“这只是个业余爱好，不会搞得像 GNU 那样又大又专业”，卸下包袱，反而成就了人类软件史上最伟大的操作系统

著名独立开发者 @levelsio 在推特上分享了一件很有意思的真事：Felix 居然常常在骑自行车的时候，通过手机端语音给 Claude 下达宏观指令，搭建出令人惊叹的 3D 个人主页：

野心背后的真实代价在这篇教程引发全球热议的同时，评论区几位硬核工程师的交锋同样值得关注：

1. 创意工作者的反思： 编剧 Alex Dobrenko 提出质疑，认为在纯艺术创作中，很多神来之笔恰恰来自于漫无目的的游荡，高度太高会不会抹杀创作的偶然性？Felix 罕见地直接回复赞同：“我认为你说得很对！”，不过高度依然能帮助创作者摆脱烦琐的格式泥潭，专注在核心故事内核上：

2. 审查成本的指数级飙升（Review Cost）： 工程师 Rajesh 尖锐指出，当你把任务的抽象层级拉得非常高时，人类对 AI 产出结果的审查成本也会呈指数级上升，如果人类无法看懂或验证整个复杂系统的正确性，这种野心就会变成灾难

3. 错误滚雪球累积： 开发者 JohnKocdr 提醒，越长程、越复杂的任务，AI 在第一步犯下的微小错误，会在后续十几步里被急剧放大，形成致命的逻辑崩塌

这恰恰印证了老章一直以来的观点：

有野心绝不等于把任务扔给 AI 就撒手不管！

越是有野心的高层级任务，越需要我们给模型搭建好具备严密自动化测试、版本控制与客观外部校验的严谨执行沙盒

在模型智力每周都在跃迁的时代，真正限制技术天花板的，往往是我们自己陈旧的思维定势

别停留在“让 AI 写得更快”的速度陷阱里，学会站在高度上追问终极结果
别满足于“让 AI 假扮专家”的黑话表演，学会运用深度逼它拿出顶级工具与原始证据
别局限在“狭隘单一工种”的经验主义里，学会通过广度把名词化为动词，召集跨学科天团
给模型装上能够自动化运行、严格验证的外部工具裁判，警惕审查成本与错误累积
从今天开始，不妨挑一个你手头最头疼的复杂业务任务，套用上面的黄金深度提示词试一试，看看大模型能给你交出一份怎样震撼的答卷

          
            var first_sceen__time = (+new Date());
            if ("" == 1 && document.getElementById('js_content')) {
              document.getElementById('js_content').addEventListener("selectstart",function(e){ e.preventDefault(); });
            }
          
        
                
       
       
        if ("0" == 1) {
          document.addEventListener("keydown",function(e){
            if ((e.metaKey || e.ctrlKey) && (e.key === 'c' || e.key === 'C' || e.key === 'x' || e.key === 'X' || e.key === 'a' || e.key === 'A')) {
              if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') { return; }
              e.preventDefault();
            }
          });
          document.addEventListener("copy",function(e){
            var sel = window.getSelection();
            var content = document.getElementById('js_content');
            if (sel && sel.rangeCount > 0 && content && content.contains(sel.getRangeAt(0).commonAncestorContainer)) {
              e.preventDefault();
            }
          });
        }
        

                预览时标签不可点
                
        
        
         
        
        

        
        
          

    
    
                  
    
      
            
            
            
        修改于
      
            
      
        
        不喜欢
      
    
  
  

        

                
              
    

    

    
    
      
        
        
      
    

    
    
      
        
          
          微信扫一扫
关注该公众号

        
      
    
  

  
    
    
  

  
  
    
    
      知道了
    
  

  window.img_popup = 1;

.weui-dialog_link{-webkit-transform:translateY(-75%);transform:translateY(-75%)}

  
      
          
          微信扫一扫
使用小程序
      
  

  
  
      
          
      
      
      
      
          取消
          允许
      
  

  
  
    
      
    
    
    
    
      取消
      允许
    
  

  
  
    
      
    
    
    
    
      取消
      允许
    
  

  ×
  分析

  
  
    
      
      
        
                
          
        
              
    
    
      微信扫一扫可打开此内容，
使用完整服务

    
  

  
  
    
      
    
  

    
window.logs.pagetime.page_begin = Date.now();

try {
  var adIframeUrl = localStorage.getItem('__WXLS_ad_iframe_url');
  if (window === top) {
    if (adIframeUrl) {
      if (navigator.userAgent.indexOf('iPhone') > -1) {
        var img = new Image();
        img.src = adIframeUrl;
      } else {
        var link = document.createElement('link');
        link.rel = 'prefetch';
        link.href = adIframeUrl;
        document.getElementsByTagName('head')[0].appendChild(link);
      }
    }
  }
} catch (err) {

}

    

：
，
，
，
，
，
，
，
，
，
，
，
，
。
 

视频
小程序

赞
，轻点两下取消赞
在看
，轻点两下取消在看
分享
留言
收藏
听过

    
(function () {
  var totalCount = 0,
    finishCount = 0;

  function _addScript(uri, cb) {
    totalCount++;
    var node = document.createElement('SCRIPT');
    node.type = 'text/javascript';
    node.src = uri;
    node.setAttribute('nonce', '2103858897');
    if (cb) {
      node.onload = cb;
    }
    document.getElementsByTagName('head')[0].appendChild(node);
  }
  if ((document.cookie && document.cookie.indexOf('vconsole_open=1') > -1) || location.href.indexOf('vconsole=1') > -1) {
    _addScript('https://mp.weixin.qq.com/mmbizappmsg/zh_CN/htmledition/js/scripts/vconsole-3.14.6.js', function () {
      window.vConsole = new window.VConsole();
    });
  }
  var tokenMatch = document.cookie.match(/__xweb_remote_debug_device_token__=([^;]+)/);
  if (tokenMatch && tokenMatch[1] !== '-1') {
    _addScript('https://unpkg.com/mprdev@0.4.2-beta.11/dist/sdk/index.js', function () {
      _addScript('https://mp.weixin.qq.com/mmbizappmsg/zh_CN/htmledition/js/scripts/xwebrd-0.0.2.js');
    });
  }
})();

    
    

  var item_show_type = "0";
var __INLINE_SCRIPT__ = (function () {
   'use strict';

   
   var blockEleTagName = ['P', 'DIV', 'SECTION', 'LI', 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'TABLE', 'WX-VIEW'];
   var FILTER_ATTRS = ['mp-original-line-height', 'mp-original-font-size'];
   var BLOCK_TAG_NAMES = blockEleTagName;
   var LAYOUT_TAG_NAMES = [
   'BR', 'SPAN', 'B', 'STRONG', 'I', 'EM', 'U', 'S', 'SUB', 'SUP', 'FONT', 'CODE', 'A',
   'P', 'DIV', 'SECTION', 'LI', 'UL', 'OL', 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'TABLE', 'THEAD', 'TBODY', 'TFOOT', 'TR', 'TD', 'TH', 'WX-VIEW',
   'BLOCKQUOTE', 'HR',
   'MP-STYLE-TYPE'];
   var BLANK_TEXT_REGEXP = /[\s\u200B-\u200D\uFEFF]+/g;

   
   var hasVisibleStyleSignal = function hasVisibleStyleSignal(el) {
     if (!el.style) return false;
     var bgImage = el.style.backgroundImage;
     if (bgImage && bgImage !== 'none') return true;
     var bgColor = el.style.backgroundColor;
     if (bgColor && bgColor !== 'transparent' && !/rgba?\(\s*\d+\s*,\s*\d+\s*,\s*\d+\s*,\s*0\s*\)/.test(bgColor)) return true;
     var height = el.style.height;
     if (height && height !== 'auto' && height !== '0' && !/^0[a-z%]*$/i.test(height)) return true;
     var minHeight = el.style.minHeight;
     if (minHeight && minHeight !== 'auto' && minHeight !== '0' && !/^0[a-z%]*$/i.test(minHeight)) return true;
     return false;
   };

   
   var isEmptyParagraph = function isEmptyParagraph(el) {
     if (!el || el.nodeType !== 1) return false;
     if (BLOCK_TAG_NAMES.indexOf(el.tagName) === -1) return false;
     var text = (el.textContent || '').replace(BLANK_TEXT_REGEXP, '');
     if (text !== '') return false;
     if (el.querySelector('mp-style-type')) return false;
     var all = el.querySelectorAll('*');
     for (var i = 0; i = 0; i--) {
       var el = children[i];
       if (el.tagName === 'MP-STYLE-TYPE' || el.querySelector('mp-style-type')) {
         if (!kept) continue;
         break;
       }
       if (isEmptyParagraph(el)) {
         if (!kept) {
           kept = el;
         } else if (el.parentNode) {
           el.parentNode.removeChild(el);
         }
       } else {
         break;
       }
     }
     if (kept) {
       trimTrailingBlankParagraphs(kept);
     }
   };
   var __contentFilter = function __contentFilter(container) {
     if (!container) return;
     var nodes = container.querySelectorAll("[".concat(FILTER_ATTRS.join('], ['), "]"));
     for (var i = 0; i var __INLINE_SCRIPT__ = (function (exports) {
  'use strict';

  function _typeof(obj) {
    "@babel/helpers - typeof";

    return _typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (obj) {
      return typeof obj;
    } : function (obj) {
      return obj && "function" == typeof Symbol && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj;
    }, _typeof(obj);
  }

  
  
  var Device = {};
  function detect(ua) {
    var MQQBrowser = ua.match(/MQQBrowser\/(\d+\.\d+)/i);
    var MQQClient = ua.match(/QQ\/(\d+\.(\d+)\.(\d+)\.(\d+))/i) || ua.match(/V1_AND_SQ_([\d\.]+)/);
    var WeChat = ua.match(/MicroMessenger\/((\d+)\.(\d+))\.(\d+)/) || ua.match(/MicroMessenger\/((\d+)\.(\d+))/);
    var MacOS = ua.match(/Mac\sOS\sX\s(\d+[\.|_]\d+)/);
    var WinOS = ua.match(/Windows(\s+\w+)?\s+?(\d+\.\d+)/);
    var Linux = ua.match(/Linux\s/);
    var MiuiBrowser = ua.match(/MiuiBrowser\/(\d+\.\d+)/i);
    var M1 = ua.match(/MI-ONE/);
    var MIPAD = ua.match(/MI PAD/);
    var UC = ua.match(/UCBrowser\/(\d+\.\d+(\.\d+\.\d+)?)/) || ua.match(/\sUC\s/);
    var IEMobile = ua.match(/IEMobile(\/|\s+)(\d+\.\d+)/) || ua.match(/WPDesktop/);
    var ipod = ua.match(/(ipod).*\s([\d_]+)/i);
    var ipad = ua.match(/(ipad).*\s([\d_]+)/i);
    var iphone = ua.match(/(iphone)\sos\s([\d_]+)/i);
    var Chrome = ua.match(/Chrome\/(\d+\.\d+)/);
    var AndriodBrowser = ua.match(/Mozilla.*Linux.*Android.*AppleWebKit.*Mobile Safari/);
    var android = ua.match(/(android)\s([\d\.]+)/i);
    var harmony = ua.match(/(OpenHarmony)\s([\d\.]+)/i);
    Device.browser = Device.browser || {}, Device.os = Device.os || {};
    Device.os.type = -1;
    Device.os.unifiedPC = ua.match(/UnifiedPC/);
    Device.os.unifiedMac = /UnifiedPCMac/i.test(ua);
    Device.os.unifiedWindows = /UnifiedPCWindows/i.test(ua);
    if (window.ActiveXObject) {
      var vie = 6;
      (window.XMLHttpRequest || ua.indexOf('MSIE 7.0') > -1) && (vie = 7);
      (window.XDomainRequest || ua.indexOf('Trident/4.0') > -1) && (vie = 8);
      ua.indexOf('Trident/5.0') > -1 && (vie = 9);
      ua.indexOf('Trident/6.0') > -1 && (vie = 10);
      Device.browser.ie = true, Device.browser.version = vie;
    } else if (ua.indexOf('Trident/7.0') > -1) {
      Device.browser.ie = true, Device.browser.version = 11;
    }
    if (android) {
      Device.os.android = true;
      Device.os.version = android[2];
      Device.os.type = 2;
    }
    if (harmony) {
      Device.os.harmony = true;
      Device.os.version = harmony[2];
      Device.os.type = 42;
    }
    if (ipod) {
      Device.os.ios = Device.os.ipod = true;
      Device.os.version = ipod[2].replace(/_/g, '.');
    }
    if (ipad) {
      Device.os.ios = Device.os.ipad = true;
      Device.os.version = ipad[2].replace(/_/g, '.');
      Device.os.type = 13;
    }
    if (iphone) {
      Device.os.iphone = Device.os.ios = true;
      Device.os.version = iphone[2].replace(/_/g, '.');
      Device.os.type = 1;
    }
    if (WinOS) Device.os.windows = true, Device.os.version = WinOS[2], Device.os.type = 15;
    if (MacOS) Device.os.Mac = true, Device.os.version = MacOS[1], Device.os.type = 14;
    if (Linux) Device.os.Linux = true, Device.os.type = 33;
    if (ua.indexOf('lepad_hls') > 0) Device.os.LePad = true;
    if (MIPAD) Device.os.MIPAD = true;
    if (MQQBrowser) Device.browser.MQQ = true, Device.browser.version = MQQBrowser[1];
    if (MQQClient) Device.browser.MQQClient = true, Device.browser.version = MQQClient[1];
    if (WeChat) Device.browser.WeChat = true, Device.browser.mmversion = Device.browser.version = WeChat[1];
    if (MiuiBrowser) Device.browser.MIUI = true, Device.browser.version = MiuiBrowser[1];
    if (UC) Device.browser.UC = true, Device.browser.version = UC[1] || NaN;
    if (IEMobile) Device.browser.IEMobile = true, Device.browser.version = IEMobile[2];
    if (AndriodBrowser) {
      Device.browser.AndriodBrowser = true;
    }
    if (M1) {
      Device.browser.M1 = true;
    }
    if (Chrome) {
      Device.browser.Chrome = true, Device.browser.version = Chrome[1];
    }
    if (Device.os.windows) {
      if (typeof navigator.platform !== "undefined" && navigator.platform.toLowerCase() == "win64") {
        Device.os.win64 = true;
      } else {
        Device.os.win64 = false;
      }
    }
    if (Device.os.Mac || Device.os.windows || Device.os.Linux || Device.os.unifiedPC || /OpenHarmony/i.test(ua) && /pc/i.test(ua)) {
      Device.os.pc = true;
    }
    var osType = {
      iPad7: 'iPad; CPU OS 7',
      LePad: 'lepad_hls',
      XiaoMi: 'MI-ONE',
      SonyDTV: "SonyDTV",
      SamSung: 'SAMSUNG',
      HTC: 'HTC',
      VIVO: 'vivo'
    };
    for (var os in osType) {
      Device.os[os] = ua.indexOf(osType[os]) !== -1;
    }
    Device.os.phone = Device.os.phone || /windows phone/i.test(ua);
    Device.os.getNumVersion = function () {
      return parseFloat(Device.os.version);
    };
    Device.os.hasTouch = 'ontouchstart' in window;
    if (Device.os.hasTouch && Device.os.ios && Device.os.getNumVersion() = 3.0;
    };
    Device.browser.isCanOcx = function () {
      return !!Device.os.windows && (!!Device.browser.ie || Device.browser.isFFCanOcx() || !!Device.browser.webkit);
    };
    Device.browser.isNotIESupport = function () {
      return !!Device.os.windows && (!!Device.browser.webkit || Device.browser.isFFCanOcx());
    };
    Device.userAgent = {};
    Device.userAgent.browserVersion = Device.browser.version;
    Device.userAgent.osVersion = Device.os.version;
    if (Device.os.unifiedPC) {
      if (Device.os.unifiedWindows) Device.os.type = 37;else if (Device.os.unifiedMac) Device.os.type = 38;else Device.os.type = 39;
    }
    delete Device.userAgent.version;
  }
  detect(window.navigator.userAgent);
  function canSupportH5Video() {
    var ua = window.navigator.userAgent,
      m = null;
    if (!!Device.os.android) {
      if (Device.browser.MQQ && Device.browser.getNumVersion() >= 4.2) {
        return true;
      }
      if (ua.indexOf('MI2') != -1) {
        return true;
      }
      if (Device.os.version >= '4' && (m = ua.match(/MicroMessenger\/((\d+)\.(\d+))\.(\d+)/))) {
        if (parseFloat(m[1]) >= 4.2) {
          return true;
        }
      }
      if (Device.os.version >= '4.1') {
        return true;
      }
    }
    return false;
  }
  function canSupportVideoMp4() {
    var video = document.createElement('video');
    if (typeof video.canPlayType === 'function') {
      if (video.canPlayType('video/mp4; codecs="mp4v.20.8"') === 'probably') {
        return true;
      }
      if (video.canPlayType('video/mp4; codecs="avc1.42E01E"') === 'probably' || video.canPlayType('video/mp4; codecs="avc1.42E01E, mp4a.40.2"') === 'probably') {
        return true;
      }
    }
    return false;
  }
  function canSupportAutoPlay() {
    if (Device.os.ios && Device.os.getNumVersion()  1 && arguments[1] !== undefined ? arguments[1] : 0;
    var canEqual = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : false;
    var nowVersionStr = Device.os.version;
    if (!nowVersionStr) return false;
    var versionArr = version.split('.');
    var nowVersionArr = nowVersionStr.split('.');
    for (var i = 0; i  0) return vi > nvi;
      if (cp = o.length) return { done: true }; return { done: false, value: o[i++] }; }, e: function e(_e) { throw _e; }, f: F }; } throw new TypeError("Invalid attempt to iterate non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); } var normalCompletion = true, didErr = false, err; return { s: function s() { it = it.call(o); }, n: function n() { var step = it.next(); normalCompletion = step.done; return step; }, e: function e(_e2) { didErr = true; err = _e2; }, f: function f() { try { if (!normalCompletion && it["return"] != null) it["return"](); } finally { if (didErr) throw err; } } }; }
  function _unsupportedIterableToArray$1(o, minLen) { if (!o) return; if (typeof o === "string") return _arrayLikeToArray$1(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === "Object" && o.constructor) n = o.constructor.name; if (n === "Map" || n === "Set") return Array.from(o); if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray$1(o, minLen); }
  function _arrayLikeToArray$1(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i  b;
    }
  };
  function cpVersion(ver, op, canEq, type) {
    var mmver = false;
    switch (type) {
      case 'mac':
        mmver = getMac();
        break;
      case 'windows':
        mmver = getWindowsVersionFormat();
        break;
      case 'wxwork':
        mmver = getWxWork();
        break;
      case 'mpapp':
        mmver = getMpApp();
        break;
      case 'unifiedpc':
        mmver = getUnifiedPcVer();
        break;
      default:
        mmver = get();
        break;
    }
    if (!mmver) {
      return;
    }
    var mmversion = mmver.split('.');
    var version = ver.split('.');
    if (!/\d+/g.test(mmversion[mmversion.length - 1])) {
      mmversion.pop();
    }
    for (var i = 0, len = Math.max(mmversion.length, version.length); i = 64 && parseInt(v) = hexNum;
    }
    return false;
  }
  var mmversion = {
    get: get,
    getMac: getMac,
    getMacOS: getMacOS,
    getWindows: getWindows,
    getInner: getInner,
    getWxWork: getWxWork,
    getMpApp: getMpApp,
    cpVersion: cpVersion,
    eqVersion: eqVersion,
    gtVersion: gtVersion,
    ltVersion: ltVersion,
    getPlatform: getPlatform,
    getVersionNumber: getVersionNumber,
    isWp: is_wp,
    isIOS: is_ios,
    isAndroid: is_android$1,
    isHarmony: is_harmony,
    isHarmonyWechat: is_harmony && is_wechat && cpVersion('1.0.0', 1, true),
    isInMiniProgram: is_in_miniProgram,
    isWechat: is_wechat,
    isMac: is_mac,
    isWindows: is_windows,
    isLinux: is_linux,
    isMacWechat: is_mac_wechat,
    isWindowsWechat: is_windows_wechat,
    isWxWork: is_wx_work,
    isOnlyWechat: is_wechat && !is_wx_work,
    isMpapp: is_mpapp,
    isIPad: is_ipad,
    isGooglePlay: is_google_play,
    isPrefetch: is_prefetch,
    isDonutAPP: is_donut_app,
    compareHexVersion: compareHexVersion,
    isPcWechat: is_windows_wechat || is_mac_wechat,
    xwebVersion: xweb_version,
    isUnifiedPcWechat: is_unified_pc_wechat
  };
  var getOriginExpVal = function getOriginExpVal(key) {
    var _a, _b, _c;
    return ((_c = (_b = (_a = window.cgiDataNew) === null || _a === void 0 ? void 0 : _a.user_info) === null || _b === void 0 ? void 0 : _b.frontend_exp) === null || _c === void 0 ? void 0 : _c.list) && window.cgiDataNew.user_info.frontend_exp.list.reduce(function (res, item) {
      if (item.key === key) res = (item === null || item === void 0 ? void 0 : item.value) || '';
      return res;
    }, '');
  };

  function asyncGeneratorStep(gen, resolve, reject, _next, _throw, key, arg) {
    try {
      var info = gen[key](arg);
      var value = info.value;
    } catch (error) {
      reject(error);
      return;
    }
    if (info.done) {
      resolve(value);
    } else {
      Promise.resolve(value).then(_next, _throw);
    }
  }
  function _asyncToGenerator(fn) {
    return function () {
      var self = this,
        args = arguments;
      return new Promise(function (resolve, reject) {
        var gen = fn.apply(self, args);
        function _next(value) {
          asyncGeneratorStep(gen, resolve, reject, _next, _throw, "next", value);
        }
        function _throw(err) {
          asyncGeneratorStep(gen, resolve, reject, _next, _throw, "throw", err);
        }
        _next(undefined);
      });
    };
  }

  function _regeneratorRuntime$5() {  _regeneratorRuntime$5 = function _regeneratorRuntime() { return e; }; var t, e = {}, r = Object.prototype, n = r.hasOwnProperty, o = Object.defineProperty || function (t, e, r) { t[e] = r.value; }, i = "function" == typeof Symbol ? Symbol : {}, a = i.iterator || "@@iterator", c = i.asyncIterator || "@@asyncIterator", u = i.toStringTag || "@@toStringTag"; function define(t, e, r) { return Object.defineProperty(t, e, { value: r, enumerable: !0, configurable: !0, writable: !0 }), t[e]; } try { define({}, ""); } catch (t) { define = function define(t, e, r) { return t[e] = r; }; } function wrap(t, e, r, n) { var i = e && e.prototype instanceof Generator ? e : Generator, a = Object.create(i.prototype), c = new Context(n || []); return o(a, "_invoke", { value: makeInvokeMethod(t, r, c) }), a; } function tryCatch(t, e, r) { try { return { type: "normal", arg: t.call(e, r) }; } catch (t) { return { type: "throw", arg: t }; } } e.wrap = wrap; var h = "suspendedStart", l = "suspendedYield", f = "executing", s = "completed", y = {}; function Generator() {} function GeneratorFunction() {} function GeneratorFunctionPrototype() {} var p = {}; define(p, a, function () { return this; }); var d = Object.getPrototypeOf, v = d && d(d(values([]))); v && v !== r && n.call(v, a) && (p = v); var g = GeneratorFunctionPrototype.prototype = Generator.prototype = Object.create(p); function defineIteratorMethods(t) { ["next", "throw", "return"].forEach(function (e) { define(t, e, function (t) { return this._invoke(e, t); }); }); } function AsyncIterator(t, e) { function invoke(r, o, i, a) { var c = tryCatch(t[r], t, o); if ("throw" !== c.type) { var u = c.arg, h = u.value; return h && "object" == _typeof(h) && n.call(h, "__await") ? e.resolve(h.__await).then(function (t) { invoke("next", t, i, a); }, function (t) { invoke("throw", t, i, a); }) : e.resolve(h).then(function (t) { u.value = t, i(u); }, function (t) { return invoke("throw", t, i, a); }); } a(c.arg); } var r; o(this, "_invoke", { value: function value(t, n) { function callInvokeWithMethodAndArg() { return new e(function (e, r) { invoke(t, n, e, r); }); } return r = r ? r.then(callInvokeWithMethodAndArg, callInvokeWithMethodAndArg) : callInvokeWithMethodAndArg(); } }); } function makeInvokeMethod(e, r, n) { var o = h; return function (i, a) { if (o === f) throw new Error("Generator is already running"); if (o === s) { if ("throw" === i) throw a; return { value: t, done: !0 }; } for (n.method = i, n.arg = a;;) { var c = n.delegate; if (c) { var u = maybeInvokeDelegate(c, n); if (u) { if (u === y) continue; return u; } } if ("next" === n.method) n.sent = n._sent = n.arg;else if ("throw" === n.method) { if (o === h) throw o = s, n.arg; n.dispatchException(n.arg); } else "return" === n.method && n.abrupt("return", n.arg); o = f; var p = tryCatch(e, r, n); if ("normal" === p.type) { if (o = n.done ? s : l, p.arg === y) continue; return { value: p.arg, done: n.done }; } "throw" === p.type && (o = s, n.method = "throw", n.arg = p.arg); } }; } function maybeInvokeDelegate(e, r) { var n = r.method, o = e.iterator[n]; if (o === t) return r.delegate = null, "throw" === n && e.iterator["return"] && (r.method = "return", r.arg = t, maybeInvokeDelegate(e, r), "throw" === r.method) || "return" !== n && (r.method = "throw", r.arg = new TypeError("The iterator does not provide a '" + n + "' method")), y; var i = tryCatch(o, e.iterator, r.arg); if ("throw" === i.type) return r.method = "throw", r.arg = i.arg, r.delegate = null, y; var a = i.arg; return a ? a.done ? (r[e.resultName] = a.value, r.next = e.nextLoc, "return" !== r.method && (r.method = "next", r.arg = t), r.delegate = null, y) : a : (r.method = "throw", r.arg = new TypeError("iterator result is not an object"), r.delegate = null, y); } function pushTryEntry(t) { var e = { tryLoc: t[0] }; 1 in t && (e.catchLoc = t[1]), 2 in t && (e.finallyLoc = t[2], e.afterLoc = t[3]), this.tryEntries.push(e); } function resetTryEntry(t) { var e = t.completion || {}; e.type = "normal", delete e.arg, t.completion = e; } function Context(t) { this.tryEntries = [{ tryLoc: "root" }], t.forEach(pushTryEntry, this), this.reset(!0); } function values(e) { if (e || "" === e) { var r = e[a]; if (r) return r.call(e); if ("function" == typeof e.next) return e; if (!isNaN(e.length)) { var o = -1, i = function next() { for (; ++o = 0; --o) { var i = this.tryEntries[o], a = i.completion; if ("root" === i.tryLoc) return handle("end"); if (i.tryLoc = 0; --r) { var o = this.tryEntries[r]; if (o.tryLoc = 0; --e) { var r = this.tryEntries[e]; if (r.finallyLoc === t) return this.complete(r.completion, r.afterLoc), resetTryEntry(r), y; } }, "catch": function _catch(t) { for (var e = this.tryEntries.length - 1; e >= 0; --e) { var r = this.tryEntries[e]; if (r.tryLoc === t) { var n = r.completion; if ("throw" === n.type) { var o = n.arg; resetTryEntry(r); } return o; } } throw new Error("illegal catch attempt"); }, delegateYield: function delegateYield(e, r, n) { return this.delegate = { iterator: values(e), resultName: r, nextLoc: n }, "next" === this.method && (this.arg = t), y; } }, e; }
  var ENV_READY_RETRY_INTERVAL = 200;
  var ENV_READY_TIMEOUT = 2000;
  var env;
  var getEnv = function getEnv(key, updateEnv) {
    if (window.__wxWebEnv && (!env || updateEnv)) {
      try {
        var next = window.__wxWebEnv && typeof window.__wxWebEnv.getEnv === 'function' && window.__wxWebEnv.getEnv();
        env = next ? JSON.parse(next) : null;
      } catch (error) {
        env = null;
        console.error('get env error', error);
      }
    }
    return env ? env[key] : undefined;
  };
  var isEnvReady = function isEnvReady() {
    return !!env;
  };
  var getEnvAsync = function () {
    var _ref = _asyncToGenerator( _regeneratorRuntime$5().mark(function _callee(key) {
      var start;
      return _regeneratorRuntime$5().wrap(function _callee$(_context) {
        while (1) switch (_context.prev = _context.next) {
          case 0:
            start = Date.now();
          case 1:
            if (env) {
              _context.next = 11;
              break;
            }
            getEnv(key, true);
            if (!env) {
              _context.next = 5;
              break;
            }
            return _context.abrupt("break", 11);
          case 5:
            if (!(Date.now() - start >= ENV_READY_TIMEOUT)) {
              _context.next = 7;
              break;
            }
            return _context.abrupt("return", undefined);
          case 7:
            _context.next = 9;
            return new Promise(function (resolve) {
              return setTimeout(resolve, ENV_READY_RETRY_INTERVAL);
            });
          case 9:
            _context.next = 1;
            break;
          case 11:
            return _context.abrupt("return", env ? env[key] : undefined);
          case 12:
          case "end":
            return _context.stop();
        }
      }, _callee);
    }));
    return function getEnvAsync(_x) {
      return _ref.apply(this, arguments);
    };
  }();

  function _regeneratorRuntime$4() {  _regeneratorRuntime$4 = function _regeneratorRuntime() { return e; }; var t, e = {}, r = Object.prototype, n = r.hasOwnProperty, o = Object.defineProperty || function (t, e, r) { t[e] = r.value; }, i = "function" == typeof Symbol ? Symbol : {}, a = i.iterator || "@@iterator", c = i.asyncIterator || "@@asyncIterator", u = i.toStringTag || "@@toStringTag"; function define(t, e, r) { return Object.defineProperty(t, e, { value: r, enumerable: !0, configurable: !0, writable: !0 }), t[e]; } try { define({}, ""); } catch (t) { define = function define(t, e, r) { return t[e] = r; }; } function wrap(t, e, r, n) { var i = e && e.prototype instanceof Generator ? e : Generator, a = Object.create(i.prototype), c = new Context(n || []); return o(a, "_invoke", { value: makeInvokeMethod(t, r, c) }), a; } function tryCatch(t, e, r) { try { return { type: "normal", arg: t.call(e, r) }; } catch (t) { return { type: "throw", arg: t }; } } e.wrap = wrap; var h = "suspendedStart", l = "suspendedYield", f = "executing", s = "completed", y = {}; function Generator() {} function GeneratorFunction() {} function GeneratorFunctionPrototype() {} var p = {}; define(p, a, function () { return this; }); var d = Object.getPrototypeOf, v = d && d(d(values([]))); v && v !== r && n.call(v, a) && (p = v); var g = GeneratorFunctionPrototype.prototype = Generator.prototype = Object.create(p); function defineIteratorMethods(t) { ["next", "throw", "return"].forEach(function (e) { define(t, e, function (t) { return this._invoke(e, t); }); }); } function AsyncIterator(t, e) { function invoke(r, o, i, a) { var c = tryCatch(t[r], t, o); if ("throw" !== c.type) { var u = c.arg, h = u.value; return h && "object" == _typeof(h) && n.call(h, "__await") ? e.resolve(h.__await).then(function (t) { invoke("next", t, i, a); }, function (t) { invoke("throw", t, i, a); }) : e.resolve(h).then(function (t) { u.value = t, i(u); }, function (t) { return invoke("throw", t, i, a); }); } a(c.arg); } var r; o(this, "_invoke", { value: function value(t, n) { function callInvokeWithMethodAndArg() { return new e(function (e, r) { invoke(t, n, e, r); }); } return r = r ? r.then(callInvokeWithMethodAndArg, callInvokeWithMethodAndArg) : callInvokeWithMethodAndArg(); } }); } function makeInvokeMethod(e, r, n) { var o = h; return function (i, a) { if (o === f) throw new Error("Generator is already running"); if (o === s) { if ("throw" === i) throw a; return { value: t, done: !0 }; } for (n.method = i, n.arg = a;;) { var c = n.delegate; if (c) { var u = maybeInvokeDelegate(c, n); if (u) { if (u === y) continue; return u; } } if ("next" === n.method) n.sent = n._sent = n.arg;else if ("throw" === n.method) { if (o === h) throw o = s, n.arg; n.dispatchException(n.arg); } else "return" === n.method && n.abrupt("return", n.arg); o = f; var p = tryCatch(e, r, n); if ("normal" === p.type) { if (o = n.done ? s : l, p.arg === y) continue; return { value: p.arg, done: n.done }; } "throw" === p.type && (o = s, n.method = "throw", n.arg = p.arg); } }; } function maybeInvokeDelegate(e, r) { var n = r.method, o = e.iterator[n]; if (o === t) return r.delegate = null, "throw" === n && e.iterator["return"] && (r.method = "return", r.arg = t, maybeInvokeDelegate(e, r), "throw" === r.method) || "return" !== n && (r.method = "throw", r.arg = new TypeError("The iterator does not provide a '" + n + "' method")), y; var i = tryCatch(o, e.iterator, r.arg); if ("throw" === i.type) return r.method = "throw", r.arg = i.arg, r.delegate = null, y; var a = i.arg; return a ? a.done ? (r[e.resultName] = a.value, r.next = e.nextLoc, "return" !== r.method && (r.method = "next", r.arg = t), r.delegate = null, y) : a : (r.method = "throw", r.arg = new TypeError("iterator result is not an object"), r.delegate = null, y); } function pushTryEntry(t) { var e = { tryLoc: t[0] }; 1 in t && (e.catchLoc = t[1]), 2 in t && (e.finallyLoc = t[2], e.afterLoc = t[3]), this.tryEntries.push(e); } function resetTryEntry(t) { var e = t.completion || {}; e.type = "normal", delete e.arg, t.completion = e; } function Context(t) { this.tryEntries = [{ tryLoc: "root" }], t.forEach(pushTryEntry, this), this.reset(!0); } function values(e) { if (e || "" === e) { var r = e[a]; if (r) return r.call(e); if ("function" == typeof e.next) return e; if (!isNaN(e.length)) { var o = -1, i = function next() { for (; ++o = 0; --o) { var i = this.tryEntries[o], a = i.completion; if ("root" === i.tryLoc) return handle("end"); if (i.tryLoc = 0; --r) { var o = this.tryEntries[r]; if (o.tryLoc = 0; --e) { var r = this.tryEntries[e]; if (r.finallyLoc === t) return this.complete(r.completion, r.afterLoc), resetTryEntry(r), y; } }, "catch": function _catch(t) { for (var e = this.tryEntries.length - 1; e >= 0; --e) { var r = this.tryEntries[e]; if (r.tryLoc === t) { var n = r.completion; if ("throw" === n.type) { var o = n.arg; resetTryEntry(r); } return o; } } throw new Error("illegal catch attempt"); }, delegateYield: function delegateYield(e, r, n) { return this.delegate = { iterator: values(e), resultName: r, nextLoc: n }, "next" === this.method && (this.arg = t), y; } }, e; }
  var attrs = ['top', 'left', 'right', 'bottom'];
  var computedInsets = {};
  var changedAttrs = [];
  var callbacks$1 = [];
  var inited = false;
  var support = '';
  function detectSupport() {
    if (!('CSS' in window) || typeof CSS.supports !== 'function') {
      return '';
    }
    if (CSS.supports('top: env(safe-area-inset-top)')) {
      return 'env';
    }
    if (CSS.supports('top: constant(safe-area-inset-top)')) {
      return 'constant';
    }
    return '';
  }
  function emitChange(attr) {
    if (!changedAttrs.length) {
      setTimeout(function () {
        var style = {};
        changedAttrs.forEach(function (changedAttr) {
          style[changedAttr] = computedInsets[changedAttr];
        });
        changedAttrs.length = 0;
        callbacks$1.forEach(function (callback) {
          return callback(style);
        });
      }, 0);
    }
    changedAttrs.push(attr);
  }
  function ensureProbe() {
    if (inited) return;
    support = detectSupport();
    if (!support) {
      attrs.forEach(function (attr) {
        computedInsets[attr] = 0;
      });
      inited = true;
      return;
    }
    function setStyle(el, style) {
      Object.keys(style).forEach(function (key) {
        el.style[key] = style[key];
      });
    }
    var readyCallbacks = [];
    function parentReady(callback) {
      if (callback) {
        readyCallbacks.push(callback);
        return;
      }
      readyCallbacks.forEach(function (cb) {
        return cb();
      });
    }
    var passiveEvents = false;
    try {
      var opts = Object.defineProperty({}, 'passive', {
        get: function get() {
          passiveEvents = {
            passive: true
          };
        }
      });
      window.addEventListener('test', null, opts);
    } catch (e) {}
    function addChild(parent, attr) {
      var a1 = document.createElement('div');
      var a2 = document.createElement('div');
      var a1Children = document.createElement('div');
      var a2Children = document.createElement('div');
      var MAX = 10000;
      var style = {
        position: 'absolute',
        width: '100px',
        height: '200px',
        boxSizing: 'border-box',
        overflow: 'hidden',
        paddingBottom: "".concat(support, "(safe-area-inset-").concat(attr, ")")
      };
      setStyle(a1, style);
      setStyle(a2, style);
      setStyle(a1Children, {
        transition: '0s',
        animation: 'none',
        width: '400px',
        height: '400px'
      });
      setStyle(a2Children, {
        transition: '0s',
        animation: 'none',
        width: '250%',
        height: '250%'
      });
      a1.appendChild(a1Children);
      a2.appendChild(a2Children);
      parent.appendChild(a1);
      parent.appendChild(a2);
      parentReady(function () {
        a1.scrollTop = MAX;
        a2.scrollTop = MAX;
        var a1LastScrollTop = a1.scrollTop;
        var a2LastScrollTop = a2.scrollTop;
        function onScroll() {
          if (this.scrollTop === (this === a1 ? a1LastScrollTop : a2LastScrollTop)) {
            return;
          }
          a1.scrollTop = MAX;
          a2.scrollTop = MAX;
          a1LastScrollTop = a1.scrollTop;
          a2LastScrollTop = a2.scrollTop;
          emitChange(attr);
        }
        a1.addEventListener('scroll', onScroll, passiveEvents);
        a2.addEventListener('scroll', onScroll, passiveEvents);
      });
      var computedStyle = getComputedStyle(a1);
      Object.defineProperty(computedInsets, attr, {
        configurable: true,
        get: function get() {
          return parseFloat(computedStyle.paddingBottom);
        }
      });
    }
    var parent = document.createElement('div');
    setStyle(parent, {
      position: 'absolute',
      left: '0',
      top: '0',
      width: '0',
      height: '0',
      zIndex: '-1',
      overflow: 'hidden',
      visibility: 'hidden'
    });
    attrs.forEach(function (attr) {
      return addChild(parent, attr);
    });
    document.body.appendChild(parent);
    parentReady();
    inited = true;
  }
  function pollUntilReady(attr) {
    var timeout = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 2000;
    return new Promise(function (resolve) {
      var start = Date.now();
      function check() {
        var val = computedInsets[attr];
        if (val && val !== 0 || Date.now() - start > timeout) {
          resolve();
          return;
        }
        setTimeout(check, 300);
      }
      setTimeout(check, 300);
    });
  }
  function getCssInset(attr) {
    ensureProbe();
    return computedInsets[attr];
  }
  function readyCssInset(_x) {
    return _readyCssInset.apply(this, arguments);
  }
  function _readyCssInset() {
    _readyCssInset = _asyncToGenerator( _regeneratorRuntime$4().mark(function _callee(attr) {
      return _regeneratorRuntime$4().wrap(function _callee$(_context) {
        while (1) switch (_context.prev = _context.next) {
          case 0:
            ensureProbe();
            if (!support) {
              _context.next = 4;
              break;
            }
            _context.next = 4;
            return pollUntilReady(attr);
          case 4:
            return _context.abrupt("return", computedInsets[attr]);
          case 5:
          case "end":
            return _context.stop();
        }
      }, _callee);
    }));
    return _readyCssInset.apply(this, arguments);
  }
  function onCssInsetChange(callback) {
    ensureProbe();
    callbacks$1.push(callback);
  }
  function offCssInsetChange(callback) {
    var index = callbacks$1.indexOf(callback);
    if (index >= 0) {
      callbacks$1.splice(index, 1);
    }
  }
  function isCssSafeAreaSupported() {
    return !!detectSupport();
  }

  var initJsBridge = false;
  if (!window.JSAPIEventCallbackMap) {
    window.JSAPIEventCallbackMap = {};
  }
  function connectWebViewJavascriptBridge(callback) {
    if (window.WebViewMPapp || window.WebViewJavascriptBridge) {
      return callback(window.WebViewMPapp || window.WebViewJavascriptBridge);
    }
    if (window.WVJBCallbacks) {
      return window.WVJBCallbacks.push(callback);
    }
    window.WVJBCallbacks = [callback];
    if (!mmversion.isMpapp) {
      return false;
    }
    if (!initJsBridge) {
      initJsBridge = true;
      var WVJBIframe = document.createElement('iframe');
      WVJBIframe.style.display = 'none';
      WVJBIframe.src = 'https://__bridge_loaded__';
      document.body.appendChild(WVJBIframe);
      setTimeout(function () {
        initJsBridge = false;
        document.body.removeChild(WVJBIframe);
      }, 0);
    }
    return false;
  }
  function invoke$1(jsapiName, opt, callback) {
    connectWebViewJavascriptBridge(function (bridge) {
      try {
        if (typeof opt === 'function') {
          callback = opt;
        }
        if (_typeof(opt) !== 'object' && typeof opt !== 'string') {
          opt = {};
        }
        bridge.callHandler(jsapiName, opt, function (res) {
          try {
            var ret = _typeof(res) === 'object' ? res : JSON.parse(res);
            var errMsg = ret.err_msg || ret.errMsg;
            console.info("[mpapp jsapi] invoke->".concat(jsapiName, " ").concat(opt.action || '', " ").concat(errMsg));
            typeof callback === 'function' && callback(ret);
          } catch (e) {
            window.WX_BJ_REPORT.BadJs.report('invoke', "callback ".concat(jsapiName, " error:"), {
              mid: 'mmbizwebapp:js_brridge',
              _info: e
            });
            console.error("[mpapp jsapi] ".concat(jsapiName, " ").concat(opt.action || ''), e, res);
          }
        });
      } catch (e) {
        window.WX_BJ_REPORT.BadJs.report('invoke', 'callback error:', {
          mid: 'mmbizwebapp:js_brridge',
          _info: e
        });
        console.error('[mpapp jsapi]', e);
      }
    });
  }
  function on$3(eventName, callback) {
    connectWebViewJavascriptBridge(function (bridge) {
      if (!window.JSAPIEventCallbackMap[eventName]) {
        window.JSAPIEventCallbackMap[eventName] = [];
      }
      window.JSAPIEventCallbackMap[eventName].push(callback);
      if (window.JSAPIEventCallbackMap[eventName].length > 1) {
        return false;
      }
      try {
        bridge.registerHandler(eventName, function () {
          for (var _len = arguments.length, args = new Array(_len), _key = 0; _key ".concat(eventName, " ").concat(data.err_msg));
            if (window.JSAPIEventCallbackMap[eventName] && window.JSAPIEventCallbackMap[eventName].length) {
              var result;
              for (var i = 0; i = 0; i--) {
        if (window.JSAPIEventCallbackMap[eventName][i] === callback) {
          window.JSAPIEventCallbackMap[eventName].splice(i, 1);
          result = true;
        }
      }
      return result;
    });
  }

  function _regeneratorRuntime$3() {  _regeneratorRuntime$3 = function _regeneratorRuntime() { return e; }; var t, e = {}, r = Object.prototype, n = r.hasOwnProperty, o = Object.defineProperty || function (t, e, r) { t[e] = r.value; }, i = "function" == typeof Symbol ? Symbol : {}, a = i.iterator || "@@iterator", c = i.asyncIterator || "@@asyncIterator", u = i.toStringTag || "@@toStringTag"; function define(t, e, r) { return Object.defineProperty(t, e, { value: r, enumerable: !0, configurable: !0, writable: !0 }), t[e]; } try { define({}, ""); } catch (t) { define = function define(t, e, r) { return t[e] = r; }; } function wrap(t, e, r, n) { var i = e && e.prototype instanceof Generator ? e : Generator, a = Object.create(i.prototype), c = new Context(n || []); return o(a, "_invoke", { value: makeInvokeMethod(t, r, c) }), a; } function tryCatch(t, e, r) { try { return { type: "normal", arg: t.call(e, r) }; } catch (t) { return { type: "throw", arg: t }; } } e.wrap = wrap; var h = "suspendedStart", l = "suspendedYield", f = "executing", s = "completed", y = {}; function Generator() {} function GeneratorFunction() {} function GeneratorFunctionPrototype() {} var p = {}; define(p, a, function () { return this; }); var d = Object.getPrototypeOf, v = d && d(d(values([]))); v && v !== r && n.call(v, a) && (p = v); var g = GeneratorFunctionPrototype.prototype = Generator.prototype = Object.create(p); function defineIteratorMethods(t) { ["next", "throw", "return"].forEach(function (e) { define(t, e, function (t) { return this._invoke(e, t); }); }); } function AsyncIterator(t, e) { function invoke(r, o, i, a) { var c = tryCatch(t[r], t, o); if ("throw" !== c.type) { var u = c.arg, h = u.value; return h && "object" == _typeof(h) && n.call(h, "__await") ? e.resolve(h.__await).then(function (t) { invoke("next", t, i, a); }, function (t) { invoke("throw", t, i, a); }) : e.resolve(h).then(function (t) { u.value = t, i(u); }, function (t) { return invoke("throw", t, i, a); }); } a(c.arg); } var r; o(this, "_invoke", { value: function value(t, n) { function callInvokeWithMethodAndArg() { return new e(function (e, r) { invoke(t, n, e, r); }); } return r = r ? r.then(callInvokeWithMethodAndArg, callInvokeWithMethodAndArg) : callInvokeWithMethodAndArg(); } }); } function makeInvokeMethod(e, r, n) { var o = h; return function (i, a) { if (o === f) throw new Error("Generator is already running"); if (o === s) { if ("throw" === i) throw a; return { value: t, done: !0 }; } for (n.method = i, n.arg = a;;) { var c = n.delegate; if (c) { var u = maybeInvokeDelegate(c, n); if (u) { if (u === y) continue; return u; } } if ("next" === n.method) n.sent = n._sent = n.arg;else if ("throw" === n.method) { if (o === h) throw o = s, n.arg; n.dispatchException(n.arg); } else "return" === n.method && n.abrupt("return", n.arg); o = f; var p = tryCatch(e, r, n); if ("normal" === p.type) { if (o = n.done ? s : l, p.arg === y) continue; return { value: p.arg, done: n.done }; } "throw" === p.type && (o = s, n.method = "throw", n.arg = p.arg); } }; } function maybeInvokeDelegate(e, r) { var n = r.method, o = e.iterator[n]; if (o === t) return r.delegate = null, "throw" === n && e.iterator["return"] && (r.method = "return", r.arg = t, maybeInvokeDelegate(e, r), "throw" === r.method) || "return" !== n && (r.method = "throw", r.arg = new TypeError("The iterator does not provide a '" + n + "' method")), y; var i = tryCatch(o, e.iterator, r.arg); if ("throw" === i.type) return r.method = "throw", r.arg = i.arg, r.delegate = null, y; var a = i.arg; return a ? a.done ? (r[e.resultName] = a.value, r.next = e.nextLoc, "return" !== r.method && (r.method = "next", r.arg = t), r.delegate = null, y) : a : (r.method = "throw", r.arg = new TypeError("iterator result is not an object"), r.delegate = null, y); } function pushTryEntry(t) { var e = { tryLoc: t[0] }; 1 in t && (e.catchLoc = t[1]), 2 in t && (e.finallyLoc = t[2], e.afterLoc = t[3]), this.tryEntries.push(e); } function resetTryEntry(t) { var e = t.completion || {}; e.type = "normal", delete e.arg, t.completion = e; } function Context(t) { this.tryEntries = [{ tryLoc: "root" }], t.forEach(pushTryEntry, this), this.reset(!0); } function values(e) { if (e || "" === e) { var r = e[a]; if (r) return r.call(e); if ("function" == typeof e.next) return e; if (!isNaN(e.length)) { var o = -1, i = function next() { for (; ++o = 0; --o) { var i = this.tryEntries[o], a = i.completion; if ("root" === i.tryLoc) return handle("end"); if (i.tryLoc = 0; --r) { var o = this.tryEntries[r]; if (o.tryLoc = 0; --e) { var r = this.tryEntries[e]; if (r.finallyLoc === t) return this.complete(r.completion, r.afterLoc), resetTryEntry(r), y; } }, "catch": function _catch(t) { for (var e = this.tryEntries.length - 1; e >= 0; --e) { var r = this.tryEntries[e]; if (r.tryLoc === t) { var n = r.completion; if ("throw" === n.type) { var o = n.arg; resetTryEntry(r); } return o; } } throw new Error("illegal catch attempt"); }, delegateYield: function delegateYield(e, r, n) { return this.delegate = { iterator: values(e), resultName: r, nextLoc: n }, "next" === this.method && (this.arg = t), y; } }, e; }
  var doc$1 = {};
  var isAcrossOrigin$1 = false;
  var notFoundedMPPageAction = [];
  var __moon_report$1 = window.__moon_report || function () {};
  var MOON_JSAPI_KEY_OFFSET = 8;
  try {
    doc$1 = top.window.document;
  } catch (e) {
    isAcrossOrigin$1 = true;
  }
  if (!window.JSAPIEventCallbackMap) {
    window.JSAPIEventCallbackMap = {};
  }
  function ready$1(onBridgeReady) {
    var bridgeReady = function bridgeReady() {
      try {
        if (onBridgeReady) {
          window.onBridgeReadyTime = window.onBridgeReadyTime || Date.now();
          onBridgeReady();
        }
      } catch (e) {
        __moon_report$1([{
          offset: MOON_JSAPI_KEY_OFFSET,
          log: 'ready',
          e: e
        }]);
        throw e;
      }
      window.jsapiReadyTime = Date.now();
    };
    if (!isAcrossOrigin$1 && (typeof top.window.WeixinJSBridge === 'undefined' || !top.window.WeixinJSBridge.invoke)) {
      if (doc$1.addEventListener) {
        doc$1.addEventListener('WeixinJSBridgeReady', bridgeReady, false);
      } else if (doc$1.attachEvent) {
        doc$1.attachEvent('WeixinJSBridgeReady', bridgeReady);
        doc$1.attachEvent('onWeixinJSBridgeReady', bridgeReady);
      }
    } else {
      bridgeReady();
    }
  }
  var invokeNotWaitA8key = ['notifyPageInfo', 'updatePageAuth'
  ];
  var checkNotFoundedInvoke = function checkNotFoundedInvoke(methodName, args) {
    if (methodName === 'handleMPPageAction' && (args === null || args === void 0 ? void 0 : args.action) && notFoundedMPPageAction.includes(args === null || args === void 0 ? void 0 : args.action)) {
      return true;
    }
    return false;
  };
  function invoke(_x, _x2, _x3) {
    return _invoke.apply(this, arguments);
  }
  function _invoke() {
    _invoke = _asyncToGenerator( _regeneratorRuntime$3().mark(function _callee(methodName, args, callback) {
      return _regeneratorRuntime$3().wrap(function _callee$(_context) {
        while (1) switch (_context.prev = _context.next) {
          case 0:
            if (!(window.__secPageAuthPromise && !window.__is_page_auth_ok__ && !invokeNotWaitA8key.includes(methodName))) {
              _context.next = 3;
              break;
            }
            _context.next = 3;
            return window.__secPageAuthPromise;
          case 3:
            ready$1(function () {
              if (isAcrossOrigin$1) return false;
              if (_typeof(top.window.WeixinJSBridge) !== 'object') {
                alert('请在微信中打开此链接');
                return false;
              }
              if (checkNotFoundedInvoke(methodName, args)) {
                setTimeout(function () {
                  if (callback) {
                    callback.apply(window, [{
                      err_msg: "".concat(methodName, ":fail"),
                      err_desc: 'action isn\'t supported'
                    }]);
                  }
                }, 0);
              } else {
                top.window.WeixinJSBridge.invoke(methodName, args, function () {
                  try {
                    for (var _len2 = arguments.length, rets = new Array(_len2), _key2 = 0; _key2  ".concat(ret.err_msg) : '';
                    if (['handleMPPageAction', 'handleVideoAction', 'handleHaokanAction'].indexOf(methodName) !== -1) {
                      var action = (args === null || args === void 0 ? void 0 : args.action) || '';
                      console.info('[system]', "[jsapi] invoke->".concat(methodName, ", action->").concat(action).concat(errMsg));
                    } else {
                      console.info('[system]', "[jsapi] invoke->".concat(methodName).concat(errMsg));
                    }
                    if (methodName === 'handleMPPageAction' && (args === null || args === void 0 ? void 0 : args.action) && ((ret === null || ret === void 0 ? void 0 : ret.err_desc) === 'action isn\'t supported' || (ret === null || ret === void 0 ? void 0 : ret.err_msg) === 'handleMPPageAction:fail action is not supported')) {
                      notFoundedMPPageAction.push(args === null || args === void 0 ? void 0 : args.action);
                    }
                    if (callback) {
                      callback.apply(window, rets);
                    }
                  } catch (e) {
                    __moon_report$1([{
                      offset: MOON_JSAPI_KEY_OFFSET,
                      log: "invoke;methodName:".concat(methodName),
                      e: e
                    }]);
                    throw e;
                  }
                });
              }
            });
          case 4:
          case "end":
            return _context.stop();
        }
      }, _callee);
    }));
    return _invoke.apply(this, arguments);
  }
  function call(_x4) {
    return _call.apply(this, arguments);
  }
  function _call() {
    _call = _asyncToGenerator( _regeneratorRuntime$3().mark(function _callee2(methodName) {
      return _regeneratorRuntime$3().wrap(function _callee2$(_context2) {
        while (1) switch (_context2.prev = _context2.next) {
          case 0:
            if (!(window.__secPageAuthPromise && !window.__is_page_auth_ok__)) {
              _context2.next = 3;
              break;
            }
            _context2.next = 3;
            return window.__secPageAuthPromise;
          case 3:
            ready$1(function () {
              if (isAcrossOrigin$1) return false;
              if (_typeof(top.window.WeixinJSBridge) !== 'object') {
                return false;
              }
              try {
                top.window.WeixinJSBridge.call(methodName);
              } catch (e) {
                __moon_report$1([{
                  offset: MOON_JSAPI_KEY_OFFSET,
                  log: "call;methodName:".concat(methodName),
                  e: e
                }]);
                throw e;
              }
            });
          case 4:
          case "end":
            return _context2.stop();
        }
      }, _callee2);
    }));
    return _call.apply(this, arguments);
  }
  function on$2(eventName, callback) {
    ready$1(function () {
      if (isAcrossOrigin$1) return false;
      if (_typeof(top.window.WeixinJSBridge) !== 'object' || !top.window.WeixinJSBridge.on) {
        return false;
      }
      if (!window.JSAPIEventCallbackMap[eventName]) {
        window.JSAPIEventCallbackMap[eventName] = [];
      }
      window.JSAPIEventCallbackMap[eventName].push(callback);
      if (window.JSAPIEventCallbackMap[eventName].length > 1) {
        return false;
      }
      top.window.WeixinJSBridge.on(eventName, function () {
        try {
          for (var _len = arguments.length, rets = new Array(_len), _key = 0; _key  ".concat(ret.err_msg) : '';
          console.info('[system]', "[jsapi] event->".concat(eventName).concat(errMsg));
          if (window.JSAPIEventCallbackMap[eventName] && window.JSAPIEventCallbackMap[eventName].length) {
            var result;
            for (var i = 0; i = 0; i--) {
        if (window.JSAPIEventCallbackMap[eventName][i] === callback) {
          window.JSAPIEventCallbackMap[eventName].splice(i, 1);
          result = true;
        }
      }
      return result;
    });
  }
  var coreAPI = {
    ready: ready$1,
    invoke: invoke,
    call: call,
    on: on$2,
    remove: remove$1
  };
  var mpappAPI = {
    ready: connectWebViewJavascriptBridge,
    invoke: invoke$1,
    call: invoke$1,
    on: on$3,
    remove: remove$2
  };
  var JSAPI = mmversion.isMpapp ? mpappAPI : coreAPI;

  function _regeneratorRuntime$2() {  _regeneratorRuntime$2 = function _regeneratorRuntime() { return e; }; var t, e = {}, r = Object.prototype, n = r.hasOwnProperty, o = Object.defineProperty || function (t, e, r) { t[e] = r.value; }, i = "function" == typeof Symbol ? Symbol : {}, a = i.iterator || "@@iterator", c = i.asyncIterator || "@@asyncIterator", u = i.toStringTag || "@@toStringTag"; function define(t, e, r) { return Object.defineProperty(t, e, { value: r, enumerable: !0, configurable: !0, writable: !0 }), t[e]; } try { define({}, ""); } catch (t) { define = function define(t, e, r) { return t[e] = r; }; } function wrap(t, e, r, n) { var i = e && e.prototype instanceof Generator ? e : Generator, a = Object.create(i.prototype), c = new Context(n || []); return o(a, "_invoke", { value: makeInvokeMethod(t, r, c) }), a; } function tryCatch(t, e, r) { try { return { type: "normal", arg: t.call(e, r) }; } catch (t) { return { type: "throw", arg: t }; } } e.wrap = wrap; var h = "suspendedStart", l = "suspendedYield", f = "executing", s = "completed", y = {}; function Generator() {} function GeneratorFunction() {} function GeneratorFunctionPrototype() {} var p = {}; define(p, a, function () { return this; }); var d = Object.getPrototypeOf, v = d && d(d(values([]))); v && v !== r && n.call(v, a) && (p = v); var g = GeneratorFunctionPrototype.prototype = Generator.prototype = Object.create(p); function defineIteratorMethods(t) { ["next", "throw", "return"].forEach(function (e) { define(t, e, function (t) { return this._invoke(e, t); }); }); } function AsyncIterator(t, e) { function invoke(r, o, i, a) { var c = tryCatch(t[r], t, o); if ("throw" !== c.type) { var u = c.arg, h = u.value; return h && "object" == _typeof(h) && n.call(h, "__await") ? e.resolve(h.__await).then(function (t) { invoke("next", t, i, a); }, function (t) { invoke("throw", t, i, a); }) : e.resolve(h).then(function (t) { u.value = t, i(u); }, function (t) { return invoke("throw", t, i, a); }); } a(c.arg); } var r; o(this, "_invoke", { value: function value(t, n) { function callInvokeWithMethodAndArg() { return new e(function (e, r) { invoke(t, n, e, r); }); } return r = r ? r.then(callInvokeWithMethodAndArg, callInvokeWithMethodAndArg) : callInvokeWithMethodAndArg(); } }); } function makeInvokeMethod(e, r, n) { var o = h; return function (i, a) { if (o === f) throw new Error("Generator is already running"); if (o === s) { if ("throw" === i) throw a; return { value: t, done: !0 }; } for (n.method = i, n.arg = a;;) { var c = n.delegate; if (c) { var u = maybeInvokeDelegate(c, n); if (u) { if (u === y) continue; return u; } } if ("next" === n.method) n.sent = n._sent = n.arg;else if ("throw" === n.method) { if (o === h) throw o = s, n.arg; n.dispatchException(n.arg); } else "return" === n.method && n.abrupt("return", n.arg); o = f; var p = tryCatch(e, r, n); if ("normal" === p.type) { if (o = n.done ? s : l, p.arg === y) continue; return { value: p.arg, done: n.done }; } "throw" === p.type && (o = s, n.method = "throw", n.arg = p.arg); } }; } function maybeInvokeDelegate(e, r) { var n = r.method, o = e.iterator[n]; if (o === t) return r.delegate = null, "throw" === n && e.iterator["return"] && (r.method = "return", r.arg = t, maybeInvokeDelegate(e, r), "throw" === r.method) || "return" !== n && (r.method = "throw", r.arg = new TypeError("The iterator does not provide a '" + n + "' method")), y; var i = tryCatch(o, e.iterator, r.arg); if ("throw" === i.type) return r.method = "throw", r.arg = i.arg, r.delegate = null, y; var a = i.arg; return a ? a.done ? (r[e.resultName] = a.value, r.next = e.nextLoc, "return" !== r.method && (r.method = "next", r.arg = t), r.delegate = null, y) : a : (r.method = "throw", r.arg = new TypeError("iterator result is not an object"), r.delegate = null, y); } function pushTryEntry(t) { var e = { tryLoc: t[0] }; 1 in t && (e.catchLoc = t[1]), 2 in t && (e.finallyLoc = t[2], e.afterLoc = t[3]), this.tryEntries.push(e); } function resetTryEntry(t) { var e = t.completion || {}; e.type = "normal", delete e.arg, t.completion = e; } function Context(t) { this.tryEntries = [{ tryLoc: "root" }], t.forEach(pushTryEntry, this), this.reset(!0); } function values(e) { if (e || "" === e) { var r = e[a]; if (r) return r.call(e); if ("function" == typeof e.next) return e; if (!isNaN(e.length)) { var o = -1, i = function next() { for (; ++o = 0; --o) { var i = this.tryEntries[o], a = i.completion; if ("root" === i.tryLoc) return handle("end"); if (i.tryLoc = 0; --r) { var o = this.tryEntries[r]; if (o.tryLoc = 0; --e) { var r = this.tryEntries[e]; if (r.finallyLoc === t) return this.complete(r.completion, r.afterLoc), resetTryEntry(r), y; } }, "catch": function _catch(t) { for (var e = this.tryEntries.length - 1; e >= 0; --e) { var r = this.tryEntries[e]; if (r.tryLoc === t) { var n = r.completion; if ("throw" === n.type) { var o = n.arg; resetTryEntry(r); } return o; } } throw new Error("illegal catch attempt"); }, delegateYield: function delegateYield(e, r, n) { return this.delegate = { iterator: values(e), resultName: r, nextLoc: n }, "next" === this.method && (this.arg = t), y; } }, e; }
  var insets = {
    top: 0,
    left: 0,
    right: 0,
    bottom: 0
  };
  var supported = false;
  var readyPromise = null;
  function ensureReady() {
    if (!readyPromise) {
      readyPromise = new Promise(function (resolve) {
        JSAPI.invoke('handleDeviceInfo', {
          action: 'getSafeAreaInsets'
        }, function (res) {
          var ok = !!res && typeof res.err_msg === 'string' && res.err_msg.indexOf(':ok') !== -1;
          insets.top = ok ? res.top : 0;
          insets.left = ok ? res.left : 0;
          insets.right = ok ? window.screen.width - res.right : 0;
          insets.bottom = ok ? window.screen.height - res.bottom : 0;
          supported = ok;
          resolve();
        });
      });
    }
    return readyPromise;
  }
  function getJsApiInset(attr) {
    ensureReady();
    return insets[attr];
  }
  function readyJsApiInset(_x) {
    return _readyJsApiInset.apply(this, arguments);
  }
  function _readyJsApiInset() {
    _readyJsApiInset = _asyncToGenerator( _regeneratorRuntime$2().mark(function _callee(attr) {
      return _regeneratorRuntime$2().wrap(function _callee$(_context) {
        while (1) switch (_context.prev = _context.next) {
          case 0:
            _context.next = 2;
            return ensureReady();
          case 2:
            return _context.abrupt("return", insets[attr]);
          case 3:
          case "end":
            return _context.stop();
        }
      }, _callee);
    }));
    return _readyJsApiInset.apply(this, arguments);
  }
  function isJsApiSafeAreaSupported() {
    return supported;
  }
  function warmupJsApiInset() {
    return ensureReady();
  }

  function _regeneratorRuntime$1() {  _regeneratorRuntime$1 = function _regeneratorRuntime() { return e; }; var t, e = {}, r = Object.prototype, n = r.hasOwnProperty, o = Object.defineProperty || function (t, e, r) { t[e] = r.value; }, i = "function" == typeof Symbol ? Symbol : {}, a = i.iterator || "@@iterator", c = i.asyncIterator || "@@asyncIterator", u = i.toStringTag || "@@toStringTag"; function define(t, e, r) { return Object.defineProperty(t, e, { value: r, enumerable: !0, configurable: !0, writable: !0 }), t[e]; } try { define({}, ""); } catch (t) { define = function define(t, e, r) { return t[e] = r; }; } function wrap(t, e, r, n) { var i = e && e.prototype instanceof Generator ? e : Generator, a = Object.create(i.prototype), c = new Context(n || []); return o(a, "_invoke", { value: makeInvokeMethod(t, r, c) }), a; } function tryCatch(t, e, r) { try { return { type: "normal", arg: t.call(e, r) }; } catch (t) { return { type: "throw", arg: t }; } } e.wrap = wrap; var h = "suspendedStart", l = "suspendedYield", f = "executing", s = "completed", y = {}; function Generator() {} function GeneratorFunction() {} function GeneratorFunctionPrototype() {} var p = {}; define(p, a, function () { return this; }); var d = Object.getPrototypeOf, v = d && d(d(values([]))); v && v !== r && n.call(v, a) && (p = v); var g = GeneratorFunctionPrototype.prototype = Generator.prototype = Object.create(p); function defineIteratorMethods(t) { ["next", "throw", "return"].forEach(function (e) { define(t, e, function (t) { return this._invoke(e, t); }); }); } function AsyncIterator(t, e) { function invoke(r, o, i, a) { var c = tryCatch(t[r], t, o); if ("throw" !== c.type) { var u = c.arg, h = u.value; return h && "object" == _typeof(h) && n.call(h, "__await") ? e.resolve(h.__await).then(function (t) { invoke("next", t, i, a); }, function (t) { invoke("throw", t, i, a); }) : e.resolve(h).then(function (t) { u.value = t, i(u); }, function (t) { return invoke("throw", t, i, a); }); } a(c.arg); } var r; o(this, "_invoke", { value: function value(t, n) { function callInvokeWithMethodAndArg() { return new e(function (e, r) { invoke(t, n, e, r); }); } return r = r ? r.then(callInvokeWithMethodAndArg, callInvokeWithMethodAndArg) : callInvokeWithMethodAndArg(); } }); } function makeInvokeMethod(e, r, n) { var o = h; return function (i, a) { if (o === f) throw new Error("Generator is already running"); if (o === s) { if ("throw" === i) throw a; return { value: t, done: !0 }; } for (n.method = i, n.arg = a;;) { var c = n.delegate; if (c) { var u = maybeInvokeDelegate(c, n); if (u) { if (u === y) continue; return u; } } if ("next" === n.method) n.sent = n._sent = n.arg;else if ("throw" === n.method) { if (o === h) throw o = s, n.arg; n.dispatchException(n.arg); } else "return" === n.method && n.abrupt("return", n.arg); o = f; var p = tryCatch(e, r, n); if ("normal" === p.type) { if (o = n.done ? s : l, p.arg === y) continue; return { value: p.arg, done: n.done }; } "throw" === p.type && (o = s, n.method = "throw", n.arg = p.arg); } }; } function maybeInvokeDelegate(e, r) { var n = r.method, o = e.iterator[n]; if (o === t) return r.delegate = null, "throw" === n && e.iterator["return"] && (r.method = "return", r.arg = t, maybeInvokeDelegate(e, r), "throw" === r.method) || "return" !== n && (r.method = "throw", r.arg = new TypeError("The iterator does not provide a '" + n + "' method")), y; var i = tryCatch(o, e.iterator, r.arg); if ("throw" === i.type) return r.method = "throw", r.arg = i.arg, r.delegate = null, y; var a = i.arg; return a ? a.done ? (r[e.resultName] = a.value, r.next = e.nextLoc, "return" !== r.method && (r.method = "next", r.arg = t), r.delegate = null, y) : a : (r.method = "throw", r.arg = new TypeError("iterator result is not an object"), r.delegate = null, y); } function pushTryEntry(t) { var e = { tryLoc: t[0] }; 1 in t && (e.catchLoc = t[1]), 2 in t && (e.finallyLoc = t[2], e.afterLoc = t[3]), this.tryEntries.push(e); } function resetTryEntry(t) { var e = t.completion || {}; e.type = "normal", delete e.arg, t.completion = e; } function Context(t) { this.tryEntries = [{ tryLoc: "root" }], t.forEach(pushTryEntry, this), this.reset(!0); } function values(e) { if (e || "" === e) { var r = e[a]; if (r) return r.call(e); if ("function" == typeof e.next) return e; if (!isNaN(e.length)) { var o = -1, i = function next() { for (; ++o = 0; --o) { var i = this.tryEntries[o], a = i.completion; if ("root" === i.tryLoc) return handle("end"); if (i.tryLoc = 0; --r) { var o = this.tryEntries[r]; if (o.tryLoc = 0; --e) { var r = this.tryEntries[e]; if (r.finallyLoc === t) return this.complete(r.completion, r.afterLoc), resetTryEntry(r), y; } }, "catch": function _catch(t) { for (var e = this.tryEntries.length - 1; e >= 0; --e) { var r = this.tryEntries[e]; if (r.tryLoc === t) { var n = r.completion; if ("throw" === n.type) { var o = n.arg; resetTryEntry(r); } return o; } } throw new Error("illegal catch attempt"); }, delegateYield: function delegateYield(e, r, n) { return this.delegate = { iterator: values(e), resultName: r, nextLoc: n }, "next" === this.method && (this.arg = t), y; } }, e; }
  var callbacks = [];
  var listeningCssChange = false;
  
  function useAndroidJsApiSafeArea() {
    if (!Device.os.android) return false;
    if (mmversion.xwebVersion  0)) {
              _context.next = 3;
              break;
            }
            _context.next = 3;
            return getEnvAsync('enableAndroidEdge2Edge');
          case 3:
            return _context.abrupt("return", useAndroidJsApiSafeArea() ? readyJsApiInset(attr) : readyCssInset(attr));
          case 4:
          case "end":
            return _context.stop();
        }
      }, _callee);
    }));
    return _getAttrAsync.apply(this, arguments);
  }
  function handleCssChange(style) {
    if (useAndroidJsApiSafeArea()) return;
    callbacks.forEach(function (callback) {
      return callback(style);
    });
  }
  function ensureCssChangeListener() {
    if (listeningCssChange) return;
    if (Device.os.android && mmversion.xwebVersion = 0) {
      callbacks.splice(index, 1);
    }
    if (!callbacks.length && listeningCssChange) {
      offCssInsetChange(handleCssChange);
      listeningCssChange = false;
    }
  }
  function ready() {
    return _ready.apply(this, arguments);
  }
  function _ready() {
    _ready = _asyncToGenerator( _regeneratorRuntime$1().mark(function _callee2() {
      return _regeneratorRuntime$1().wrap(function _callee2$(_context2) {
        while (1) switch (_context2.prev = _context2.next) {
          case 0:
            _context2.next = 2;
            return getAttrAsync('bottom');
          case 2:
          case "end":
            return _context2.stop();
        }
      }, _callee2);
    }));
    return _ready.apply(this, arguments);
  }
  if (Device.os.android) {
    warmupJsApiInset();
  }
  var SafeArea = {
    get support() {
      return useAndroidJsApiSafeArea() ? isJsApiSafeAreaSupported() : isCssSafeAreaSupported();
    },
    get top() {
      return getAttr('top');
    },
    get left() {
      return getAttr('left');
    },
    get right() {
      return getAttr('right');
    },
    get bottom() {
      return getAttr('bottom');
    },
    onChange: onChange,
    offChange: offChange,
    ready: ready,
    getAsync: getAttrAsync
  };

  function _toPrimitive(input, hint) {
    if (_typeof(input) !== "object" || input === null) return input;
    var prim = input[Symbol.toPrimitive];
    if (prim !== undefined) {
      var res = prim.call(input, hint || "default");
      if (_typeof(res) !== "object") return res;
      throw new TypeError("@@toPrimitive must return a primitive value.");
    }
    return (hint === "string" ? String : Number)(input);
  }

  function _toPropertyKey(arg) {
    var key = _toPrimitive(arg, "string");
    return _typeof(key) === "symbol" ? key : String(key);
  }

  function _defineProperty(obj, key, value) {
    key = _toPropertyKey(key);
    if (key in obj) {
      Object.defineProperty(obj, key, {
        value: value,
        enumerable: true,
        configurable: true,
        writable: true
      });
    } else {
      obj[key] = value;
    }
    return obj;
  }

  function _classCallCheck(instance, Constructor) {
    if (!(instance instanceof Constructor)) {
      throw new TypeError("Cannot call a class as a function");
    }
  }

  function _defineProperties(target, props) {
    for (var i = 0; i  d2.exp) return 1;
        return 0;
      });
      var memCnt = 0;
      for (var i = 0; i = size) break;
        var key = keys[i];
        memCnt += JSON.stringify(data[key]).length;
        delete data[key];
      }
      return data;
    },
    'clear-all': function clearAll() {
      localStorage$1.clear();
      return {};
    }
  };
  function formatLogMsg(str) {
    return "[WXLS] ".concat(str);
  }
  
  var LS = function () {
    function LS(func, evictionPolicy, logger) {
      _classCallCheck(this, LS);
      this.logger = function () {};
      if (!func) throw 'require function name.';
      this.evictionPolicy = 'noeviction';
      this.key = func;
      if (typeof logger === 'function') {
        this.logger = function (str, type) {
          return logger(formatLogMsg(str), type);
        };
      }
      if (evictionPolicy && Object.keys(evictionPolicies).indexOf(evictionPolicy) !== -1) {
        this.evictionPolicy = evictionPolicy;
      }
      this.init();
    }
    _createClass(LS, [{
      key: "init",
      value: function init() {
        var _a, _b;
        this.check();
        if (Math.random() * 1000  now) {
            temp[key] = val;
          }
        }
        this.logger("check info: isReturn:".concat(isReturn, " data:").concat(JSON.stringify(temp)), 'info');
        if (isReturn) return temp;
        LS.setItem(this.key, JSON.stringify(temp), this.logger);
      }
    }, {
      key: "set",
      value: function set(key, val, exp) {
        var _a, _b;
        var data = this.check(true);
        data[key] = {
          val: val,
          exp: exp || +new Date()
        };
        try {
          if (localStorage$1.getItem(prefix + this.key)) localStorage$1.removeItem(prefix + this.key);
          localStorage$1.setItem(prefix + this.key, JSON.stringify(data));
          this.logger("first set success: LSlen:".concat((_a = window === null || window === void 0 ? void 0 : window.localStorage) === null || _a === void 0 ? void 0 : _a.length, " key:").concat(prefix + this.key, " data:").concat(JSON.stringify(data)), 'success');
        } catch (e) {
          this.logger("first set error: LSlen:".concat((_b = window === null || window === void 0 ? void 0 : window.localStorage) === null || _b === void 0 ? void 0 : _b.length, " error:").concat(e, " key:").concat(prefix + this.key, " data:").concat(JSON.stringify(data), " k:").concat(key, " v:").concat(val, " exp:").concat(exp), 'error');
          localStorage$1.clear();
          LS.setItem(this.key, JSON.stringify(_defineProperty({}, key, {
            val: val,
            exp: exp || +new Date()
          })), this.logger);
        }
      }
    }, {
      key: "get",
      value: function get(key) {
        var data = this.getData();
        data = data[key];
        return data ? data.val || null : null;
      }
    }, {
      key: "remove",
      value: function remove(key) {
        var data = this.getData();
        if (data[key]) delete data[key];
        LS.setItem(this.key, JSON.stringify(data), this.logger);
      }
    }], [{
      key: "getItem",
      value: function getItem(key) {
        key = prefix + key;
        return localStorage$1.getItem(key);
      }
    }, {
      key: "setItem",
      value: function setItem(key, val, logger) {
        var _a, _b;
        key = prefix + key;
        var n = 3;
        while (n--) {
          try {
            if (localStorage$1.getItem(key)) localStorage$1.removeItem(key);
            localStorage$1.setItem(key, val);
            typeof logger === 'function' && logger("setItem success: LSlen:".concat((_a = window === null || window === void 0 ? void 0 : window.localStorage) === null || _a === void 0 ? void 0 : _a.length, " key:").concat(key, " val:").concat(val), 'success');
            break;
          } catch (e) {
            typeof logger === 'function' && logger("setItem error: LSlen:".concat((_b = window === null || window === void 0 ? void 0 : window.localStorage) === null || _b === void 0 ? void 0 : _b.length, " error:").concat(e, " key:").concat(key, " val:").concat(val), 'error');
            LS.clear();
          }
        }
      }
    }, {
      key: "clear",
      value: function clear() {
        var i;
        var k;
        for (i = localStorage$1.length - 1; i >= 0; i--) {
          k = localStorage$1.key(i);
          if (k.indexOf(prefix) == 0) {
            localStorage$1.removeItem(k);
          }
        }
      }
    }, {
      key: "getSupportEvicationPolicy",
      value: function getSupportEvicationPolicy() {
        return Object.keys(evictionPolicies);
      }
    }]);
    return LS;
  }();

  
  var LOCAL_STORAGE_EXPIRE_TIME = 24 * 60 * 60 * 1000;

  
  var onceListeners = window.__wx__eventBus__onceListeners || {};
  window.__wx__eventBus__onceListeners === undefined && (window.__wx__eventBus__onceListeners = onceListeners);
  var permanentListeners = window.__wx__eventBus__permanentListeners || {};
  window.__wx__eventBus__permanentListeners === undefined && (window.__wx__eventBus__permanentListeners = permanentListeners);
  function clean(event, all) {
    delete onceListeners[event];
    if (all) {
      delete permanentListeners[event];
    }
  }
  function on$1(event, callback, permanent) {
    if (typeof callback === 'function') {
      if (permanent) {
        if (!permanentListeners[event]) {
          permanentListeners[event] = [];
        }
        permanentListeners[event].push(callback);
      } else {
        if (!onceListeners[event]) {
          onceListeners[event] = [];
        }
        onceListeners[event].push(callback);
      }
    }
  }
  function emit(event) {
    for (var _len = arguments.length, params = new Array(_len > 1 ? _len - 1 : 0), _key = 1; _key  arr.length) len = arr.length;
    for (var i = 0, arr2 = new Array(len); i = '18003C2A' || mmversion.isOnlyWechat && mmversion.isAndroid && innerVersion >= '28003D3C' || mmversion.isUnifiedPcWechat && mmversion.cpVersion('4.1.10', 1, true, 'unifiedpc');
  function invokeGetBiz(needCheckBiz, bizType) {
    return dedupePromise("getBiz:".concat(needCheckBiz, ":").concat(bizType), function () {
      return new Promise(function (resolve, reject) {
        if (!isGetBizSupported) {
          reject('Not support');
        } else {
          JSAPI.invoke('handleMPPageAction', {
            action: 'getBiz',
            needCheckBiz: needCheckBiz,
            bizType: bizType
          }, function (res) {
            console.log("getBiz needCheckBiz=".concat(needCheckBiz, " bizType=").concat(bizType, " res: ").concat(JSON.stringify(res)));
            if (res && res.err_msg && res.err_msg.indexOf('ok') > -1) {
              var bizMap = getBizMap();
              bizMap[bizType] = res.biz;
              resolve(res.biz);
              getBizLS.set("".concat(bizType, "_get_biz_result"), res.biz, +new Date() + 3 * 24 * 60 * 60 * 1000);
            } else {
              reject('Failed to get biz');
            }
          });
        }
      });
    });
  }
  function getBiz(needCheckBiz, bizType) {
    var _a;
    if (needCheckBiz === void 0) {
      needCheckBiz = false;
    }
    if (bizType === void 0) {
      bizType = ((_a = window.cgiDataNew) === null || _a === void 0 ? void 0 : _a.biz_type) || 1;
    }
    var bizMap = getBizMap();
    if (!needCheckBiz && bizMap[bizType] !== undefined) {
      return Promise.resolve(bizMap[bizType]);
    }
    return invokeGetBiz(needCheckBiz, bizType);
  }
  mmversion.isOnlyWechat && mmversion.isIOS || mmversion.isOnlyWechat && mmversion.isAndroid || mmversion.isUnifiedPcWechat && mmversion.cpVersion('4.1.10', 1, true, 'unifiedpc');
  var getIsAuthor = function getIsAuthor(cb, bizuin, needCheckBiz, bizType) {
    var _a;
    if (bizuin === void 0) {
      bizuin = window.biz;
    }
    if (needCheckBiz === void 0) {
      needCheckBiz = false;
    }
    if (bizType === void 0) {
      bizType = ((_a = window.cgiDataNew) === null || _a === void 0 ? void 0 : _a.biz_type) || 1;
    }
    getBiz(needCheckBiz, bizType).then(function (biz) {
      cb(biz && biz === bizuin);
    })["catch"](function () {
      cb(false);
    });
  };

  function parseUrl(url) {
    var len = url.length;
    var ques_pos = url.indexOf('?');
    var hash_pos = url.indexOf('#');
    hash_pos = hash_pos == -1 ? len : hash_pos;
    ques_pos = ques_pos == -1 ? hash_pos : ques_pos;
    var host = url.substring(0, ques_pos);
    var query_str = url.substring(ques_pos + 1, hash_pos);
    var hash = url.substring(hash_pos + 1);
    return {
      host: host,
      query_str: query_str,
      hash: hash
    };
  }
  function join(url, args, noEncode) {
    var ret = parseUrl(url);
    var query_str = ret.query_str;
    var args_arr = [];
    if (_typeof(args) === 'object') {
      for (var key in args) {
        if (args.hasOwnProperty(key)) {
          args_arr.push("".concat(key, "=").concat(noEncode ? args[key] : encodeURIComponent(args[key])));
        }
      }
    } else {
      args_arr.push(noEncode ? args : encodeURIComponent(args));
    }
    if (args_arr.length > 0) {
      query_str += (query_str !== "" ? "&" : "") + args_arr.join("&");
    }
    return ret.host + (query_str !== "" ? "?".concat(query_str) : "") + (ret.hash !== "" ? "#".concat(ret.hash) : "");
  }
  
  function addParam(url, param, value, forceReplace) {
    url = url || location.href;
    var firstAndPos = url.indexOf("&");
    var len = url.length;
    var reverseUrl = url.replace(/^[\w\d]+:[/\\]+/g, "").split("").reverse();
    if (!Array.prototype.indexOf) {
      Array.prototype.indexOf = function (searchElement, fromIndex) {
        var k;
        if (this == null) {
          throw new TypeError('"this" is null or not defined');
        }
        var O = Object(this);
        var len = O.length >>> 0;
        if (len === 0) {
          return -1;
        }
        var n = fromIndex || 0;
        if (Math.abs(n) === Infinity) {
          n = 0;
        }
        if (n >= len) {
          return -1;
        }
        k = Math.max(n >= 0 ? n : len - Math.abs(n), 0);
        while (k  lastSlashPos) {
      url = url.replace("&", "?");
    }
    var reg = new RegExp("([\\?&]".concat(param, "=)[^&#]*"));
    if (!url.match(reg)) {
      var urlInfo = parseUrl(url);
      var hash = urlInfo.hash ? '#' + urlInfo.hash : '';
      url = url.replace(hash, '');
      var _pos = url.indexOf("?");
      if (_pos == -1) {
        return "".concat(url, "?").concat(param, "=").concat(value).concat(hash);
      }
      if (_pos == url.length - 1) {
        return "".concat(url + param, "=").concat(value).concat(hash);
      }
      return "".concat(url, "&").concat(param, "=").concat(value).concat(hash);
    }
    if (forceReplace === true) {
      return url.replace(reg, "$1".concat(value));
    }
    return url;
  }
  function addWxfrom(src, wxfrom) {
    var offset = window.service_type === 1 ? 10000 : 0;
    return addParam(src, 'wxfrom', offset + Number(wxfrom), true);
  }
  function removeParam(url, param) {
    var _URL = new URL(url),
      protocol = _URL.protocol,
      host = _URL.host,
      pathname = _URL.pathname,
      search = _URL.search,
      hash = _URL.hash;
    var queryParams = new URLSearchParams(search);
    queryParams["delete"](param);
    var newSearch = queryParams.toString();
    var newUrl = new URL("".concat(protocol, "//").concat(host).concat(pathname).concat(newSearch ? "?".concat(decodeURIComponent(newSearch)) : "").concat(hash));
    return newUrl.toString();
  }
  function getQuery(name, url) {
    var u = url || window.location.search;
    var reg = new RegExp("(^|&)".concat(name, "=([^&]*)(&|$)"));
    var r = u.substring(u.indexOf('?') + 1).match(reg);
    return r !== null ? r[2] : '';
  }
  function encodeBase64(value) {
    try {
      return window.btoa(value);
    } catch (e) {
      return '';
    }
  }
  function decodeBase64(value) {
    try {
      return window.atob(value);
    } catch (e) {
      return '';
    }
  }
  function joinUrl$1(url) {
    var obj = {};
    if (typeof window.uin !== 'undefined') {
      obj.uin = window.uin;
    }
    if (typeof window.key !== 'undefined') {
      obj.key = window.key;
    }
    if (typeof window.pass_ticket !== 'undefined') {
      obj.pass_ticket = window.pass_ticket;
    }
    if (typeof window.wxtoken !== 'undefined') {
      obj.wxtoken = window.wxtoken;
    }
    if (typeof window.devicetype !== 'undefined') {
      obj.devicetype = window.devicetype;
    }
    if (typeof window.clientversion !== 'undefined') {
      obj.clientversion = window.clientversion || mmversion.getInner();
    }
    obj.version = obj.clientversion;
    if (window.biz) {
      obj.__biz = window.biz;
    }
    if (getQuery('enterid')) {
      obj.enterid = getQuery('enterid');
    }
    if (typeof window.appmsg_token !== 'undefined') {
      obj.appmsg_token = window.appmsg_token;
    } else if (url.indexOf('advertisement_report') > -1) {
      new Image().src = "".concat(location.protocol, "//mp.weixin.qq.com/mp/jsmonitor?idkey=68064_13_1&r=").concat(Math.random());
    }
    obj.x5 = navigator.userAgent.indexOf('TBS/') !== -1 ? '1' : '0';
    obj.f = 'json';
    return join(url, obj);
  }
  function joinUserArticleRole(url, notJoin, cb) {
    var bizuin = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : window.biz;
    var needCheckBiz = arguments.length > 5 && arguments[5] !== undefined ? arguments[5] : false;
    if (notJoin) {
      cb(url);
    } else {
      getIsAuthor(function (isAuthor) {
        cb(addParam(url, 'user_article_role', isAuthor ? 1 : 0, true));
      }, bizuin, needCheckBiz);
    }
  }
  function getA8keyQuery(name, url) {
    return new Promise(function (resolve) {
      if (window.__secPageAuthPromise) {
        window.__secPageAuthPromise.then(function () {
          resolve(getQuery(name, url));
        });
      } else {
        resolve(getQuery(name, url));
      }
    });
  }
  function addHash(url, hash) {
    var isReplace = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : false;
    if (isReplace) {
      return "".concat(url.split('#')[0]).concat(hash);
    }
    return "".concat(url).concat(url.indexOf('#') === -1 ? '#' : '').concat(hash);
  }
  function decodeUrl(url) {
    var _url = url;
    while (_url.indexOf('&') !== -1) {
      _url = _url.htmlDecode();
    }
    return _url;
  }
  var Url = {
    parseUrl: parseUrl,
    join: join,
    addParam: addParam,
    addWxfrom: addWxfrom,
    addHash: addHash,
    getQuery: getQuery,
    getA8keyQuery: getA8keyQuery,
    encodeBase64: encodeBase64,
    decodeBase64: decodeBase64,
    joinUrl: joinUrl$1,
    joinUserArticleRole: joinUserArticleRole,
    removeParam: removeParam,
    decodeUrl: decodeUrl
  };

  var isIPadOS13 = Device.os.ipad && Device.os.getNumVersion() >= 13 && Device.os.getNumVersion()  0 && isFinite(scale)) {
        window.__dprScale__ = 1 / scale;
        return window.__dprScale__;
      }
    } catch (e) {
    }
    window.__dprScale__ = 1;
    return window.__dprScale__;
  }
  function getNativeFontScale() {
    return getNativeFontScaleVar() * getScaleByDPR();
  }
  function getScaleByDom() {
    if (typeof document === 'undefined' || !document.body) {
      return 1;
    }
    var fontDom = document.createElement('div');
    fontDom.style.fontSize = '16px';
    document.body.appendChild(fontDom);
    var originFontSize = parseFloat(fontDom.style.fontSize);
    var realFontSize = parseFloat(window.getComputedStyle(fontDom, null).getPropertyValue('font-size'));
    document.body.removeChild(fontDom);
    var percent = realFontSize / originFontSize;
    if (!percent || percent  1000) {
        continue;
      }
      setPair[0].style.fontSize = "".concat(calculatedSize, "px");
      setPair[0].style.lineHeight = "".concat(setPair[2]);
    }
  }
  
  function getLevelScaleByFontLevel(fontLevel) {
    var level = Math.max(0, Math.min(fontLevel, FONT_LEVEL_TO_SCALE_MAP.length - 1));
    return FONT_LEVEL_TO_SCALE_MAP[level];
  }
  function getClientFontScaleValue() {
    var useFontLevel = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : false;
    if (useFontLevel) {
      var fontLevel = getNativeFontLevelVar();
      return getLevelScaleByFontLevel(fontLevel - 1) * 100;
    }
    return getNativeFontScale() * 100;
  }
  
  function setArticleContentFontSize(percent, root) {
    if (mmversion.isWxWork) return;
    var contentEl = root || document.getElementById('js_content');
    if (contentEl) {
      window.__contentFontScale__ = percent;
      EventBus.emit(ARTICLE_FONT_SCALE_CHANGE_EVENT, percent);
      setFontSize(contentEl, percent);
    }
  }
  
  function applyContentFontScale(localFontScale) {
    var useFontLevel = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : true;
    var root = arguments.length > 2 ? arguments[2] : undefined;
    if (!localFontScale || mmversion.isWxWork) return;
    var clientFontScale = getClientFontScaleValue(useFontLevel);
    var finalFontScale = localFontScale * clientFontScale / 100;
    setArticleContentFontSize(finalFontScale, root);
  }

  
  function _log(level, msg) {
    if (level === 'log') {
      level = 'info';
      msg = "[WechatFe]".concat(msg);
    } else {
      var prefix = "__wap__".concat(window.__second_open__ ? ' (sec)' : '');
      msg = "".concat(prefix, " ").concat(msg, " location:[").concat(location.href, "]");
    }
    msg += new Error().stack;
    if (mmversion.isMpapp) {
      invoke$1('WNNativeCallbackLog', msg);
    } else if (mmversion.isWechat) {
      if (mmversion.isAndroid) {
        console.warn('[system]', "[MicroMsg.JsApiLog][".concat(level, "] jslog : ").concat(msg));
      } else if (mmversion.isIOS) {
        JSAPI.invoke('writeLog', {
          level: level,
          msg: msg
        });
      } else {
        JSAPI.invoke('log', {
          level: level,
          msg: msg
        });
      }
    }
  }
  var Log = {
    info: function info() {
      for (var _len = arguments.length, args = new Array(_len), _key = 0; _key = 0) continue;
      target[key] = source[key];
    }
    return target;
  }
  function formatDataToString(data) {
    var reportData = [];
    for (var key in data) {
      if (Object.prototype.hasOwnProperty.call(data, key)) {
        reportData.push(key + '=' + encodeURIComponent(data[key]));
      }
    }
    return reportData.join('&');
  }
  monitor.getReportData = function (opt) {
    opt = opt || {};
    var idkey = monitor._reportOptions.idkey || {};
    var key = null;
    var reportData = {};
    var nextKey;
    try {
      for (key in idkey) {
        if (Object.prototype.hasOwnProperty.call(idkey, key) && idkey[key]) {
          reportLogs.push(key + '_' + idkey[key]);
        }
      }
    } catch (e) {
      return false;
    }
    if (reportLogs.length === 0) {
      return false;
    }
    if (reportExtraLogs.length) {
      reportData.lc = reportExtraLogs.length;
      reportExtraLogs.forEach(function (extraLog, index) {
        reportData["log".concat(index)] = extraLog;
      });
    }
    try {
      var reportOptions = monitor._reportOptions;
      if (reportOptions !== null && reportOptions !== undefined) {
        for (nextKey in reportOptions) {
          if (Object.prototype.hasOwnProperty.call(reportOptions, nextKey)) {
            reportData[nextKey] = reportOptions[nextKey];
          }
        }
      }
    } catch (e) {
      reportData = {};
    }
    reportData.idkey = reportLogs.join(';');
    reportData.t = Math.random();
    if (opt.remove !== false) {
      reportLogs = [];
      reportExtraLogs = [];
      monitor._reportOptions = {
        idkey: {}
      };
    }
    return reportData;
  };
  monitor.setLogs = function (opt) {
    var id = opt.id;
    var key = opt.key;
    var value = opt.value;
    var extraLog = opt.log;
    var others = ObjWithoutProperty(opt, ['id', 'key', 'value', 'log']);
    var idkey = monitor._reportOptions.idkey || {};
    var param = id + '_' + key;
    if (idkey[param]) {
      idkey[param] += value;
    } else {
      idkey[param] = value;
    }
    monitor._reportOptions.idkey = idkey;
    if (extraLog) {
      reportExtraLogs.push(extraLog);
    }
    try {
      if (others !== null && others !== undefined) {
        for (var otherKey in others) {
          if (Object.prototype.hasOwnProperty.call(others, otherKey)) {
            monitor._reportOptions[otherKey] = others[otherKey];
          }
        }
      }
    } catch (e) {
      console.log(e);
    }
    return monitor;
  };
  monitor.setAvg = function (id, key, value) {
    var idkey = monitor._reportOptions.idkey || {};
    var param1 = id + '_' + key;
    var param2 = id + '_' + (key - 1);
    if (idkey[param1]) {
      idkey[param1] += value;
    } else {
      idkey[param1] = value;
    }
    if (idkey[param2]) {
      idkey[param2] += 1;
    } else {
      idkey[param2] = 1;
    }
    monitor._reportOptions.idkey = idkey;
    return monitor;
  };
  monitor.setSum = function (id, key) {
    var value = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : 1;
    var idkey = monitor._reportOptions.idkey;
    var param = id + '_' + key;
    if (idkey[param]) {
      idkey[param] += value;
    } else {
      idkey[param] = value;
    }
    monitor._reportOptions.idkey = idkey;
    return monitor;
  };
  monitor.send = function (async, ajax, origin) {
    if (async !== false) {
      async = true;
    }
    var data = monitor.getReportData();
    origin = origin || '';
    if (!data) {
      return;
    }
    if (!!ajax && ajax instanceof Function) {
      ajax({
        url: origin + sendUrl,
        type: 'POST',
        mayAbort: true,
        data: data,
        async: async,
        timeout: 2000,
        dontReport: true
      });
    } else {
      new Image().src = origin + '/mp/jsmonitor?' + formatDataToString(data) + '#wechat_redirect';
    }
  };
  if (typeof window !== 'undefined' && window.__monitor) {
    monitor = window.__monitor;
  } else {
    typeof window !== 'undefined' && (window.__monitor = monitor);
  }
  var monitor$1 = monitor;

  
  var logList = [];
  var log = function log(msg) {
    logList.push(msg);
  };
  var printLog = function printLog() {
    for (var i = 0, len = logList.length; i  [response ".concat(item.requestType, "]"), item.url, item.response, item);
    if (item.rdevRequestId && ((_b = (_a = window.RemoteDevSdk) === null || _a === void 0 ? void 0 : _a.instance) === null || _b === void 0 ? void 0 : _b.Network) && item.id !== '__system_log__') {
      try {
        var finishedOptions = {
          requestId: item.rdevRequestId,
          url: item.url,
          status: +(item.status || '500'),
          statusText: StatusTextMap[+(item.status || '500')] || 'Error',
          responseHeaders: {
            RDEV_RESPONSE_TYPE: item.requestType
          },
          responseBody: item.response,
          requestTime: item.requestTime || 0,
          duration: item.costTime || (item.endTime && item.startTime ? item.endTime - item.startTime : performance.now() / 1000 - (item.requestTime || 0))
        };
        window.RemoteDevSdk.instance.Network.customRequestFinished(finishedOptions);
      } catch (err) {}
    }
    if (((_c = window.vConsole) === null || _c === void 0 ? void 0 : _c.network) && item.id !== '__system_log__') {
      try {
        item.statusText = "".concat(item.status);
        item.responseSize = item.response.length;
        item.responseSizeText = "".concat(item.response.length);
        return (_e = (_d = window.vConsole.network).update) === null || _e === void 0 ? void 0 : _e.call(_d, item.id, Object.assign({}, item, {
          readyState: 4
        }));
      } catch (err) {}
    }
  }
  function reqType(obj, path) {
    return obj.url.indexOf(path) > -1 && obj.url.indexOf('action=') === -1 && (!obj.data || !obj.data.action);
  }
  function findAjaxScopeByConfig(url, config) {
    var pathname = new URL(url, location.href).pathname || '';
    var scope = config[pathname.slice(1)];
    if (scope) {
      return scope;
    }
  }
  function getAjaxScope(ajaxUrl) {
    if (Url.getQuery('no_transfer', location.href) !== '1' && mmversion.isWechat && !mmversion.isInMiniProgram && !mmversion.isWxWork && !mmversion.isMpapp && !isAcrossOrigin && window.__ajaxTransferConfig && _typeof(window.__ajaxTransferConfig) === 'object' && (
    mmversion.isIOS && mmversion.compareHexVersion('1800282F') || mmversion.isAndroid && mmversion.compareHexVersion('28002234') || mmversion.isWindowsWechat && mmversion.cpVersion('3.9.5', 1, true, 'windows') || mmversion.isMacWechat && mmversion.cpVersion('3.8.4', 1, true, 'mac') || mmversion.isHarmonyWechat && mmversion.compareHexVersion('0xf3100b00') && !mmversion.compareHexVersion('0xf3100c00') || mmversion.compareHexVersion('0xf3800b00'))) {
      try {
        return findAjaxScopeByConfig(ajaxUrl, window.__ajaxTransferConfig);
      } catch (err) {
        
      }
    }
  }
  function getActionByData(data) {
    var _a, _b;
    if (_typeof(data) === 'object' && !(data instanceof Blob)) {
      if (data.hasOwnProperty('data') && typeof data.data === 'string') {
        try {
          var workedData = JSON.parse(data.data);
          return workedData.action || '';
        } catch (e) {}
      }
      return data.action || '';
    }
    if (typeof data === 'string') {
      return ((_b = (_a = data.split(/[?&]/).find(function (x) {
        return x.indexOf('action=') >= 0;
      })) === null || _a === void 0 ? void 0 : _a.split('=')) === null || _b === void 0 ? void 0 : _b[1]) || '';
    }
    return '';
  }

  var METHOD_ENUM = {
    GET: 0,
    POST: 1
  };
  var __moon_report = window.__moon_report || function () {};
  var MOON_AJAX_SUCCESS_OFFSET = 3;
  var MOON_AJAX_NETWORK_OFFSET = 4;
  var MOON_AJAX_ERROR_OFFSET = 5;
  var MOON_AJAX_TIMEOUT_OFFSET = 6;
  var MOON_AJAX_COMPLETE_OFFSET = 7;
  var LENGTH_LIMIT = 4096;
  function reportRtError(type, id, key, content) {
    var log = '';
    var prefix = type === 'rt' ? 'rtCheckError' : 'Ajax Length Limit';
    if (content === null || content === void 0 ? void 0 : content.length) {
      var loglen = 1000;
      var len = content.length;
      var lc = Math.ceil(len / loglen);
      log = ["&lc=".concat(lc)];
      for (var i = 0; i = 200 && retryStatus  0 ? 'json' : undefined
        });
        var isTimeout = false;
        handleReqTimeout({
          abort: function abort() {
            isTimeout = true;
            reqLogItem.endTime = Date.now();
            reqLogItem.response = 'timeout';
            networkEndLog(reqLogItem);
          }
        });
        Device.os.pc && monitor$1.setSum(115849, 69, 1);
        JSAPI.invoke(Device.os.pc ? 'H5ExtTransfer' : 'webTransfer', params, function (res) {
          var _a, _b, _c, _d, _e, _f;
          if (isTimeout) return;
          var status = 400;
          var result = '';
          if (Device.os.pc) {
            try {
              var retFlag = res.base_resp.ret === 0 && res.jsapi_resp.ret === 0 && res.err_msg.indexOf(':ok') > -1;
              var respJsonFlag = res.jsapi_resp.resp_json;
              status = retFlag && respJsonFlag ? 200 : 400;
              result = res.jsapi_resp.resp_json;
            } catch (err) {
              console.error(err);
            }
          } else {
            status = res && res.errCode * 1 === 0 && typeof res.result === 'string' && res.result ? 200 : 400;
            result = res.result;
          }
          try {
            Log.log("ajax transfer, status: ".concat(status, ", reqUrl: ").concat(reqUrl));
          } catch (err) {
            console.error(err);
          }
          if (status >= 200 && status  -1 && retryStatus >= 200 && retryStatus = 200 && status  LENGTH_LIMIT) {
            reportAjaxLength(27613, 17, "ajax get limit[length: ".concat(url.length, "]").concat(url.substring(0, 1024)));
          }
          if (data && !(data instanceof Blob) && data.length > LENGTH_LIMIT) {
            reportAjaxLength(27613, 18, "ajax post limit[length: ".concat(data.length, "]").concat(data.substring(0, 1024)));
          }
          if (data && data instanceof Blob && data.size > LENGTH_LIMIT) {
            reportAjaxLength(27613, 18, "ajax post limit[length: ".concat(data.size, "]blob"));
          }
        } catch (e) {
        }
      } catch (e) {
        obj.error && obj.error(xhr, {
          type: 3,
          error: e,
          status: 0
        });
      }
      beforeReq();
    });
  }

  
  mmversion.isWindowsWechat && mmversion.compareHexVersion('0xf2550000') || mmversion.isMacWechat && mmversion.compareHexVersion('0xf2650000');

  
  var getBrandServiceType = function getBrandServiceType() {
    var serviceType = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : window.service_type;
    var _a, _b;
    var brandServiceType = 0;
    if (serviceType !== undefined) brandServiceType = serviceType + 1;
    if (((_b = (_a = window.cgiData) === null || _a === void 0 ? void 0 : _a.trans_appmsg_info) === null || _b === void 0 ? void 0 : _b.trans_type) * 1 === 1) brandServiceType = 3;
    return brandServiceType;
  };

  function setCurrentMpInfo(ifShow) {
    var supportNewTopBar = mmversion.isIOS && mmversion.gtVersion('7.0.10', true) || mmversion.isAndroid && mmversion.gtVersion('7.0.12', true);
    JSAPI.invoke('currentMpInfo', {
      userName: window.user_name,
      brandName: !!supportNewTopBar && window.nickname === '' ? '未命名账号' : window.title,
      title: window.msg_title || '',
      brandIcon: window.hd_head_img.replace(/\/0$/, '/132'),
      itemShowType: window.item_show_type,
      isPaySubscribe: window.isPaySubscribe,
      topBarStyle: supportNewTopBar ? 1 : 0,
      topBarShowed: ifShow,
      disableShowFinderLiveTopBar: 1,
      brandServiceType: getBrandServiceType()
    }, function () {});
  }
  function AjaxWx(obj) {
    var report36408 = typeof obj.report36408 === 'function' ? obj.report36408 : function () {};
    obj.url += obj.url.indexOf('?') === -1 ? '?fasttmplajax=1' : '&fasttmplajax=1';
    if (getAjaxScope(obj.url)) {
      Ajax(obj);
      return;
    }
    if (obj.usePb) {
      obj.type = 'POST';
      obj.data = {
        data: JSON.stringify(obj.data)
      };
    }
    if (!/^(http:\/\/|https:\/\/|\/\/)/.test(obj.url)) {
      obj.url = "https://mp.weixin.qq.com/".concat(obj.url.replace(/^\//, ''));
    } else if (/^\/\//.test(obj.url)) {
      obj.url = "https:".concat(obj.url);
    }
    if (obj.f !== 'html' && (obj.url.indexOf('?f=json') === -1 || obj.url.indexOf('&f=json') === -1)) {
      obj.url += '&f=json';
    }
    if (!obj.notJoinUrl && obj.f !== 'html') {
      obj.url = Url.joinUrl(obj.url);
    }
    Url.joinUserArticleRole(obj.url, !!obj.notJoinUrl, function (url) {
      obj.url = url;
      var urlObj = new URL(url, location.origin);
      var data = null;
      if (_typeof(obj.data) === 'object') {
        var d = obj.data;
        var ds = [];
        for (var k in d) {
          if (d.hasOwnProperty(k)) {
            ds.push("".concat(k, "=").concat(encodeURIComponent(d[k])));
          }
        }
        data = ds.join('&');
      } else {
        data = typeof obj.data === 'string' ? obj.data : null;
      }
      var header = {
        Cookie: document.cookie,
        referer: location.href
      };
      if (obj.contentType) {
        header['Content-Type'] = obj.contentType;
      } else if ((obj.type || 'GET').toUpperCase() === 'POST') {
        header['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
      }
      var reqLogItem = networkStartLog({
        method: obj.type || 'GET',
        url: obj.url,
        postData: obj.data || {},
        requestHeader: header,
        requestType: 'jsapi',
        startTime: Date.now()
      });
      var retryTime = 1;
      var jsapiRequest = function jsapiRequest(obj, data) {
        return JSAPI.invoke('request', {
          url: obj.url,
          method: obj.type,
          data: data,
          header: header
        }, function (res) {
          var _a, _b, _c, _d, _e, _f;
          if (res.err_msg.indexOf(':ok') > -1 && (!res.statusCode || res.statusCode >= 200 && res.statusCode  '27000600')) {
              if (!obj.dontReport) {
                report36408({
                  CgiPath: urlObj.pathname || '',
                  Action: urlObj.searchParams.get('action') || getActionByData(obj.data) || '',
                  Query: urlObj.search || '',
                  PostData: obj.type === 'POST' && !(data instanceof Blob) ? data : '',
                  Method: obj.type || '',
                  RequestType: 20,
                  RetType: 1,
                  HttpCode: res.statusCode || 0,
                  Ret: ((_c = resData === null || resData === void 0 ? void 0 : resData.base_resp) === null || _c === void 0 ? void 0 : _c.ret) || 0
                });
              }
              var _retryTime = retryTime++;
              JSAPI.invoke('updatePageAuth', {}, function (res) {
                console.log('[skeleton] updatePageAuth', res);
                monitor$1.setSum(112287, 3, 1);
                if (res && res.err_msg && res.err_msg.indexOf(':ok') > -1) {
                  window.top.pass_ticket = encodeURIComponent(Url.getQuery('pass_ticket', res.fullUrl).html(false).replace(/\s/g, '+'));
                  if (obj.pass_ticket) {
                    obj.pass_ticket = window.top.pass_ticket;
                  }
                  console.warn('[skeleton] updatePageAuth resetTopbar');
                  var supportNewTopBar = mmversion.isIOS && mmversion.gtVersion('7.0.10', true);
                  var showBottomBar = !!window.is_login;
                  if (window.top.item_show_type === '0' && supportNewTopBar) {
                    var top = document.documentElement.scrollTop || window.pageYOffset || document.body.scrollTop || 0;
                    setCurrentMpInfo(top > 40 && !showBottomBar);
                  }
                  try {
                    obj.url = Url.addParam(obj.url, 'retry', _retryTime, true);
                  } catch (err) {
                    console.error(err);
                  }
                  jsapiRequest(obj, data);
                  monitor$1.setSum(112287, 4, 1);
                } else {
                  obj.success && obj.success(resData);
                  obj.complete && obj.complete();
                  if (mmversion.isIOS) {
                    monitor$1.setSum(112287, 35, 1);
                  } else {
                    monitor$1.setSum(112287, 36, 1);
                  }
                  reqLogItem.status = 200;
                  reqLogItem.endTime = Date.now();
                  reqLogItem.response = resData;
                  networkEndLog(reqLogItem);
                }
              });
            } else {
              if (((_d = tmpResData === null || tmpResData === void 0 ? void 0 : tmpResData.base_resp) === null || _d === void 0 ? void 0 : _d.ret) !== 0) {
                if (!obj.dontReport) {
                  report36408({
                    CgiPath: urlObj.pathname || '',
                    Action: urlObj.searchParams.get('action') || getActionByData(obj.data) || '',
                    Query: urlObj.search || '',
                    PostData: obj.type === 'POST' && !(data instanceof Blob) ? data : '',
                    Method: obj.type || '',
                    RequestType: 20,
                    RetType: 4,
                    HttpCode: res.statusCode || 0,
                    Ret: ((_e = tmpResData === null || tmpResData === void 0 ? void 0 : tmpResData.base_resp) === null || _e === void 0 ? void 0 : _e.ret) || 0
                  });
                }
              } else {
                if (!obj.dontReport) {
                  report36408({
                    CgiPath: urlObj.pathname || '',
                    Action: urlObj.searchParams.get('action') || getActionByData(obj.data) || '',
                    Query: urlObj.search || '',
                    PostData: obj.type === 'POST' && !(data instanceof Blob) ? data : '',
                    Method: obj.type || '',
                    RequestType: 20,
                    RetType: 0,
                    HttpCode: res.statusCode || 0,
                    Ret: ((_f = tmpResData === null || tmpResData === void 0 ? void 0 : tmpResData.base_resp) === null || _f === void 0 ? void 0 : _f.ret) || 0
                  });
                }
              }
              obj.success && obj.success(resData);
              obj.complete && obj.complete();
              reqLogItem.status = 200;
              reqLogItem.endTime = Date.now();
              reqLogItem.response = resData;
              networkEndLog(reqLogItem);
            }
          } else if (res.err_msg.indexOf('no permission') > -1 || !mmversion.isOnlyWechat) {
            if (!obj.dontReport) {
              report36408({
                CgiPath: urlObj.pathname || '',
                Action: urlObj.searchParams.get('action') || getActionByData(obj.data) || '',
                Query: urlObj.search || '',
                PostData: obj.type === 'POST' && !(data instanceof Blob) ? data : '',
                Method: obj.type || '',
                RequestType: 20,
                RetType: 1,
                HttpCode: res.statusCode || 0,
                Ret: 0
              });
            }
            Ajax(obj);
            if (res.err_msg.indexOf('no permission') > -1) {
              console.warn('[JSAPI Request] No permission');
              monitor$1.setSum(112287, 31, 1);
            }
            reqLogItem.status = 302;
            reqLogItem.endTime = Date.now();
            reqLogItem.response = res;
            networkEndLog(reqLogItem);
          } else {
            if (!obj.dontReport) {
              report36408({
                CgiPath: urlObj.pathname || '',
                Action: urlObj.searchParams.get('action') || getActionByData(obj.data) || '',
                Query: urlObj.search || '',
                PostData: obj.type === 'POST' && !(data instanceof Blob) ? data : '',
                Method: obj.type || '',
                RequestType: 20,
                RetType: 2,
                HttpCode: res.statusCode || 0,
                Ret: 0
              });
            }
            obj.error && obj.error(null, {
              type: 3,
              error: res,
              status: 0
            });
            obj.complete && obj.complete();
            monitor$1.setSum(112287, 32, 1);
            var sample = 0.001;
            if (Math.random() = 0; --o) { var i = this.tryEntries[o], a = i.completion; if ("root" === i.tryLoc) return handle("end"); if (i.tryLoc = 0; --r) { var o = this.tryEntries[r]; if (o.tryLoc = 0; --e) { var r = this.tryEntries[e]; if (r.finallyLoc === t) return this.complete(r.completion, r.afterLoc), resetTryEntry(r), y; } }, "catch": function _catch(t) { for (var e = this.tryEntries.length - 1; e >= 0; --e) { var r = this.tryEntries[e]; if (r.tryLoc === t) { var n = r.completion; if ("throw" === n.type) { var o = n.arg; resetTryEntry(r); } return o; } } throw new Error("illegal catch attempt"); }, delegateYield: function delegateYield(e, r, n) { return this.delegate = { iterator: values(e), resultName: r, nextLoc: n }, "next" === this.method && (this.arg = t), y; } }, e; }
  var AjaxRouter = function () {
    var _ref = _asyncToGenerator( _regeneratorRuntime().mark(function _callee(obj) {
      return _regeneratorRuntime().wrap(function _callee$(_context) {
        while (1) switch (_context.prev = _context.next) {
          case 0:
            if (!window.__secPageAuthPromise) {
              _context.next = 3;
              break;
            }
            _context.next = 3;
            return window.__secPageAuthPromise;
          case 3:
            if (!(!mmversion.isWxWork && (window.__second_open__ || !getIsAcrossOrigin() && top.window.__second_open__) && window.__is_page_auth_return__ && !obj.pureHttp)) {
              _context.next = 5;
              break;
            }
            return _context.abrupt("return", AjaxWx(obj));
          case 5:
            return _context.abrupt("return", Ajax(obj));
          case 6:
          case "end":
            return _context.stop();
        }
      }, _callee);
    }));
    return function AjaxRouter(_x) {
      return _ref.apply(this, arguments);
    };
  }();

  var isx5 = navigator.userAgent.indexOf('TBS/') !== -1;
  var getDataFunc = [];
  var reportData = [];
  
  var specificData = {};
  function joinUrl(url) {
    var obj = {};
    if (typeof window.uin !== 'undefined') {
      obj.uin = window.uin;
    }
    if (typeof window.key !== 'undefined') {
      obj.key = window.key;
    }
    if (typeof window.pass_ticket !== 'undefined') {
      obj.pass_ticket = window.pass_ticket;
    }
    if (typeof window.wxtoken !== 'undefined') {
      obj.wxtoken = window.wxtoken;
    }
    if (typeof window.devicetype !== 'undefined') {
      obj.devicetype = window.devicetype;
    }
    if (typeof window.clientversion !== 'undefined') {
      obj.clientversion = window.clientversion;
    }
    if (typeof window.appmsg_token !== 'undefined') {
      obj.appmsg_token = window.appmsg_token;
    } else if (url.indexOf('advertisement_report') > -1) {
      new Image().src = "".concat(location.protocol, "//mp.weixin.qq.com/mp/jsmonitor?idkey=68064_13_1&r=").concat(Math.random());
    }
    obj.x5 = isx5 ? '1' : '0';
    obj.f = 'json';
    return Url.join(url, obj);
  }
  function isObj(obj) {
    return obj && _typeof(obj) === 'object';
  }
  function assign(target, source) {
    if (isObj(target) && isObj(source)) {
      for (var key in source) {
        if (Object.prototype.hasOwnProperty.call(source, key)) {
          target[key] = source[key];
        }
      }
    }
  }
  function assembleReportData(initiative) {
    var leaveReportLog = [];
    leaveReportLog.push({
      content: "[LeaveReport] specificData keys: ".concat(Object.keys(specificData)),
      timestamp: Date.now()
    });
    Log.log("[LeaveReport] specificData keys: ".concat(Object.keys(specificData)));
    console.log("[LeaveReport] specificData keys: ".concat(Object.keys(specificData)));
    var allReportData = {};
    for (var reportField in specificData) {
      if (!allReportData[reportField]) {
        allReportData[reportField] = {};
      }
      for (var i = 0; i = BATCH_SIZE) {
      batchReport();
    } else {
      if (!timeOutId) {
        timeOutId = setTimeout(function () {
          batchReport();
          clearTimeout(timeOutId);
          timeOutId = null;
        }, BATCH_TIME);
      }
    }
  }
  _leaveReport.addReport(function () {
    var repeatedReportJson = getRepeatedReportJson();
    if (!repeatedReportJson) return false;
    var reportData = [];
    for (var _i = 0, _Object$entries = Object.entries(repeatedReportJson); _i  200 || isScrolling()) {
          return;
        }
        var st = e.changedTouches[0];
        if (Math.abs(g.y - st.clientY)  5 || Math.abs(x - e.clientX) > 5)) {
          clearTimeout(timeOutEvent);
          timeOutEvent = undefined;
          typeof cancelCb === 'function' && cancelCb.call(self, e);
        }
      });
      on(el, 'mouseup', className, function () {
        mousedown = false;
        clearTimeout(timeOutEvent);
      });
      on(el, 'click', className, function () {
        if (triggerLongClick) return false;
      });
    } else {
      on(el, 'touchstart', className, function (e) {
        e.touches.length === 1 && (timeOutEvent = setTimeout(function () {
          timeOutEvent = undefined;
          cb.call(self, e);
        }, 500));
      });
      on(el, 'touchmove', className, function (e) {
        if (!timeOutEvent) return;
        var st = e.changedTouches[0];
        if (Math.abs(g.y - st.clientY) > 5 || Math.abs(g.x - st.clientX) > 5) {
          clearTimeout(timeOutEvent);
          timeOutEvent = undefined;
          typeof cancelCb === 'function' && cancelCb.call(self, e);
        }
      });
      on(el, 'touchend', className, function (e) {
        if (timeOutEvent) {
          clearTimeout(timeOutEvent);
          timeOutEvent = undefined;
        } else {
          e.preventDefault();
        }
      }, true);
    }
  }
  function doubletap(el, cb) {
    var _this = this;
    var __lastTouchVideoTs = 0;
    var realCb = function realCb(e) {
      if (Date.now() - __lastTouchVideoTs  -1;
  }
  function closest(target, className, context) {
    while (target && !matches(target, className)) {
      target = target !== context && target.nodeType !== target.DOCUMENT_NODE && target.parentNode;
    }
    return target;
  }
  function on(el, type, className, cb, flag, extra) {
    var callback;
    var handler;
    var delegator;
    if (!el) return;
    if (typeof className === 'function') {
      extra = flag;
      flag = cb;
      cb = className;
      className = '';
    }
    if (typeof className !== 'string') {
      className = '';
    }
    if (el == window && type == "load" && /complete|loaded/.test(document.readyState)) {
      return cb({
        type: "load"
      });
    }
    if (type == 'tap') return tap(el, cb, flag, className);
    if (type === 'longtap') return longtap(el, cb, flag, className, extra);
    if (type == "unload" && "onpagehide" in window) {
      type = "pagehide";
    }
    callback = function callback(e) {
      var ret = cb(e);
      if (ret === false) {
        e.stopPropagation && e.stopPropagation();
        e.preventDefault && e.preventDefault();
      }
      return ret;
    };
    if (className && className.charAt(0) == '.') delegator = function delegator(e) {
      var target = e.target || e.srcElement;
      var match = closest(target, className, el);
      if (match) {
        e.delegatedTarget = match;
        return callback(e);
      }
    };
    handler = delegator || callback;
    cb["".concat(type, "_handler")] = handler;
    if (el.addEventListener) {
      el.addEventListener(type, handler, !!flag);
      return;
    }
    if (el.attachEvent) {
      el.attachEvent("on".concat(type), handler, !!flag);
      return;
    }
  }
  function off(el, type, cb, flag) {
    if (!el) return;
    var handlerType = type;
    var handler;
    if (handlerType == 'tap') {
      if (isUseTap()) {
        handlerType = 'touchend';
        handler = cb.tap_handler && cb.tap_handler.touchend_handler ? cb.tap_handler.touchend_handler : cb;
      } else {
        handlerType = 'click';
      }
    }
    if (!handler) {
      handler = cb["".concat(handlerType, "_handler")] || cb;
    }
    if (el.removeEventListener) {
      el.removeEventListener(handlerType, handler, !!flag);
      return;
    }
    if (el.detachEvent) {
      el.detachEvent("on".concat(handlerType), handler, !!flag);
      return;
    }
    if (handlerType == 'tap' && isUseTap()) {
      if (cb.tap_handler) {
        cb.tap_handler.touchend_handler = null;
      }
      cb.tap_handler = null;
    } else {
      cb["".concat(handlerType, "_handler")] = null;
    }
  }
  function getHiddenProp() {
    if ('hidden' in document) {
      return 'hidden';
    }
    for (var i = 0; i ', '<', ''];
    
    var replaceReverse = ['&', '&', '¥', '¥', '', '>', ' ', ' ', '"', '"', '\'', ''', '`', '`'];
    var str = _str;
    var target;
    if (encode) {
      target = replaceReverse;
    } else {
      target = replace;
    }
    for (var i = 0; i ', '<', '', '>', '"', '"', '\'', ''', '`', '`'];
    var str = _str;
    var target;
    if (encode) {
      target = replaceReverse;
    } else {
      target = replace;
    }
    for (var i = 0; i  MAX_POST_DATA_LENGTH) {
      data.PostData = "".concat(data.PostData.slice(0, MAX_POST_DATA_LENGTH), "...[truncated]");
    }
    WapReport.report(36408, Object.assign(Object.assign({}, data), getCommonReportData()));
  };

  
  var ajax = function ajax(obj) {
    obj.report36408 = report36408;
    AjaxRouter(obj);
  };

  
  var timer = null;
  var jsmonitorReport = {
    setSum: function setSum(id, key, value) {
      throw new Error('Function not implemented.');
    },
    setAvg: function setAvg(id, key, value) {
      throw new Error('Function not implemented.');
    },
    setLogs: function setLogs(opt) {
      throw new Error('Function not implemented.');
    },
    send: function send(async) {
      throw new Error('Function not implemented.');
    }
  };
  window.__monitor_unload_has_done__ = false;
  jsmonitorReport.setSum = function (id, key, value) {
    monitor$1.setSum(id, key, value);
    return jsmonitorReport;
  };
  jsmonitorReport.setAvg = function (id, key, value) {
    monitor$1.setAvg(id, key, value);
    return jsmonitorReport;
  };
  jsmonitorReport.setLogs = function (opt) {
    monitor$1.setLogs(opt);
    return jsmonitorReport;
  };
  jsmonitorReport.send = function (async) {
    if (async !== false) {
      async = true;
    }
    monitor$1.send(async, ajax);
    return jsmonitorReport;
  };
  function reportInterval(fn, delay) {
    timer = window.setTimeout(function () {
      fn();
      reportInterval(fn, delay);
    }, delay);
  }
  reportInterval(function () {
    jsmonitorReport.send();
  }, 1 * 1000);
  window.addEventListener('unload', function () {
    if (window.__monitor_report_has_done__) return;
    window.__ajaxtest = '2';
    if (timer) {
      window.clearTimeout(timer);
      timer = null;
    }
    jsmonitorReport.send(false);
    window.__monitor_unload_has_done__ = true;
  }, false);
  if (window.__jsmonitorReport) {
    jsmonitorReport = window.__jsmonitorReport;
  } else {
    window.__jsmonitorReport = jsmonitorReport;
  }
  var jsmonitorReport$1 = jsmonitorReport;

  
  try {
    if (typeof parent.window.hasListenMpPageAction === 'undefined') {
      parent.window.hasListenMpPageAction = false;
    }
    if (typeof parent.window.hasListenStateChange === 'undefined') {
      parent.window.hasListenStateChange = false;
    }
  } catch (error) {
  }
  var mpPageActionCb = [];
  var stateChangeCb = [];
  var HistoryLS = new LS('history4secondopen');
  var HistoryKey = 'from';
  var hasListenPopstateForSecOpenReload = false;
  
  var webComptStatus = {
    status: 'loading'
  };
  var webComptInitCb = [];
  var directionHandlerId = 0;
  var directionChangeHandlersMap = {};
  function isNativePage() {
    return Url.getQuery('isNativePage') === '1' || Url.getQuery('isNativePage') === '2';
  }
  
  function debounce(func) {
    var wait = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 50;
    var timeout;
    return function () {
      for (var _len = arguments.length, args = new Array(_len), _key = 0; _key  rectA.right || rectB.bottom  rectA.bottom);
  }
  var utils = {
    isNativePage: isNativePage,
    isNewNativePage: function isNewNativePage() {
      return Url.getQuery('isNativePage') === '2';
    },
    isOldNativePage: function isOldNativePage() {
      return Url.getQuery('isNativePage') === '1';
    },
    __useWcSlPlayer: false,
    isWcSlPage: function isWcSlPage() {
      return utils.__useWcSlPlayer;
    },
    getPlayerType: function getPlayerType() {
      if (isNativePage()) {
        return 2;
      }
      return 1;
    },
    getParam: function getParam(key) {
      if (!key) return null;
      var m = location.href.match(new RegExp("(\\?|&)".concat(key, "=([^&]+)")));
      return m ? m[2] : null;
    },
    
    insertAfter: function insertAfter(newElement, targetElement) {
      var parentElement = targetElement.parentNode;
      if (parentElement.lastChild === targetElement) {
        parentElement.appendChild(newElement);
      } else {
        parentElement.insertBefore(newElement, targetElement.nextSibling);
      }
    },
    getInnerHeight: function getInnerHeight() {
      var innerHeightFromApp = window.getInnerHeight && window.getInnerHeight();
      return innerHeightFromApp || window.innerHeight || document.documentElement.clientHeight;
    },
    getInnerWidth: function getInnerWidth() {
      return window.innerWidth || document.documentElement.clientWidth;
    },
    getScrollTop: function getScrollTop() {
      return document.documentElement.scrollTop || window.pageYOffset || document.body.scrollTop;
    },
    getDocumentHeight: function getDocumentHeight() {
      return document.body.scrollHeight;
    },
    getElementActualTop: function getElementActualTop(element) {
      var elRect = element.getBoundingClientRect();
      var actualTop = elRect.top + this.getScrollTop();
      return actualTop;
    },
    getElementTop: function getElementTop(element) {
      return element.getBoundingClientRect().top;
    },
    getElementHeight: function getElementHeight(element) {
      return element.getBoundingClientRect().height;
    },
    getOrientation: function getOrientation() {
      var _a, _b;
      return (_b = (_a = window.screen.orientation) === null || _a === void 0 ? void 0 : _a.angle) !== null && _b !== void 0 ? _b : window.orientation;
    },
    getDirection: function getDirection() {
      var orientation = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : utils.getOrientation();
      return (mmversion.isIPad ? [90, 270] : [0, 180]).indexOf(orientation) > -1 ? 'vertical' : 'horizontal';
    },
    listenDirectionChange: function listenDirectionChange(cb) {
      var _a, _b;
      if ((_b = (_a = window.screen) === null || _a === void 0 ? void 0 : _a.orientation) === null || _b === void 0 ? void 0 : _b.addEventListener) {
        directionChangeHandlersMap[directionHandlerId] = function (e) {
          cb === null || cb === void 0 ? void 0 : cb(utils.getDirection(e.target.angle), e.target.angle);
        };
        window.screen.orientation.addEventListener('change', directionChangeHandlersMap[directionHandlerId]);
      } else {
        directionChangeHandlersMap[directionHandlerId] = function () {
          var orientation = utils.getOrientation();
          cb === null || cb === void 0 ? void 0 : cb(utils.getDirection(orientation), orientation);
        };
        window.addEventListener('orientationchange', directionChangeHandlersMap[directionHandlerId]);
      }
      return directionHandlerId++;
    },
    unlistenDirectionChange: function unlistenDirectionChange(handlerId) {
      var _a, _b;
      if ((_b = (_a = window.screen) === null || _a === void 0 ? void 0 : _a.orientation) === null || _b === void 0 ? void 0 : _b.removeEventListener) {
        window.screen.orientation.removeEventListener('change', directionChangeHandlersMap[handlerId]);
      } else {
        window.removeEventListener('orientationchange', directionChangeHandlersMap[handlerId]);
      }
      delete directionChangeHandlersMap[handlerId];
    },
    isScrollEnd: function isScrollEnd(threshold) {
      return this.getScrollTop() + this.getInnerHeight() + threshold >= this.getDocumentHeight();
    },
    
    listenStateChange: function listenStateChange() {
      var opt = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};
      stateChangeCb.push(opt.cb);
      try {
        if (parent.window.hasListenStateChange) {
          return;
        }
      } catch (error) {
      }
      JSAPI.on('activity:state_change', function (res) {
        stateChangeCb.forEach(function (callback) {
          callback(res);
        });
      });
      try {
        parent.window.hasListenStateChange = true;
      } catch (error) {
      }
    },
    
    listenMpPageAction: function listenMpPageAction(cb) {
      mpPageActionCb.push(cb);
      try {
        if (parent.window.hasListenMpPageAction) {
          return;
        }
      } catch (error) {
      }
      JSAPI.on('onMPPageAction', function (res) {
        mpPageActionCb.forEach(function (callback) {
          callback(res);
        });
      });
      try {
        parent.window.hasListenMpPageAction = true;
      } catch (error) {
      }
    },
    getIosMainVersion: function getIosMainVersion() {
      var versionInfo = navigator.userAgent.toLowerCase().match(/cpu iphone os (.*?) like mac os/);
      return versionInfo && versionInfo[1] && parseInt(versionInfo[1].split('_')[0], 10);
    },
    
    report120081: function report120081(key, times) {
      jsmonitorReport$1.setSum(120081, key, times);
      jsmonitorReport$1.send();
    },
    loadNewPageKeepingHistoryStackIfSecOpen: function loadNewPageKeepingHistoryStackIfSecOpen(url) {
      if (window.__second_open__ && typeof url === 'string' && /^https?:\/\/mp.weixin.qq.com\//.test(url)) {
        HistoryLS.set(HistoryKey, location.href, Date.now() + 10000);
      }
      location.href = "".concat(url.replace(/#.*$/, ''), "#wechat_redirect");
    },
    initNewPageHistoryStackFromSecOpen: function initNewPageHistoryStackFromSecOpen() {
      var fromUrl = HistoryLS.get(HistoryKey);
      if (fromUrl && typeof fromUrl === 'string' && /^https?:\/\/mp.weixin.qq.com\//.test(fromUrl)) {
        HistoryLS.remove(HistoryKey);
        if (history && history.replaceState && history.pushState) {
          var curUrl = location.href;
          try {
            history.replaceState({
              __mock_secopen_history_stack_reload__: 1
            }, '', fromUrl);
            history.pushState({
              __mock_secopen_history_stack_reload__: 1
            }, '', curUrl);
          } catch (e) {
            console.error('[initNewPageHistoryStackFromSecOpen]', e);
          }
        }
      }
      if (!hasListenPopstateForSecOpenReload) {
        hasListenPopstateForSecOpenReload = true;
        window.addEventListener('popstate', function (e) {
          if (e.state && e.state.__mock_secopen_history_stack_reload__ === 1) {
            location.reload();
          }
        });
      }
    },
    initWebCompt: function initWebCompt(webComptList, callback) {
      var flushCb = function flushCb() {
        while (webComptInitCb.length) {
          var cb = webComptInitCb.shift();
          cb(webComptStatus);
        }
      };
      if (mmversion.isWechat && !mmversion.isInMiniProgram && (Device.os.iphone && Device.os.getNumVersion() >= 10.3 && (mmversion.gtVersion('7.0.14', 1) && Device.os.getNumVersion() = 5 || Device.os.harmony && mmversion.compareHexVersion('0xf3800c00'))) {
        document.addEventListener('WeixinOpenTagsReady', function () {
          webComptStatus = {
            status: 'ready'
          };
          flushCb();
        });
        document.addEventListener('WeixinOpenTagsError', function (e) {
          webComptStatus = {
            status: 'error',
            error: e && e.detail && e.detail.errMsg
          };
          flushCb();
        });
        JSAPI.invoke('handleMPPageAction', {
          action: 'wxConfig',
          appid: 'wxmpfakeid',
          webComptList: webComptList,
          url: location.href
        }, function (res) {
          console.log('wx config web compt result', webComptList, res);
          Log.info('wx config web compt result', webComptList, JSON.stringify(res));
          if (res && res.err_msg && res.err_msg.indexOf(':ok') === -1) {
            webComptStatus = {
              status: 'error',
              error: res.err_msg
            };
            flushCb();
          }
          if (typeof callback === 'function') {
            callback(res);
          }
        });
      } else {
        var res = {
          err_msg: 'handleMPPageAction:fail_webcompt unsupported'
        };
        console.log('wx config web compt result', webComptList, res);
        Log.info('wx config web compt result', webComptList, JSON.stringify(res));
        webComptStatus = {
          status: 'error',
          error: res.err_msg
        };
        flushCb();
        if (typeof callback === 'function') {
          callback(res);
        }
      }
    },
    initWebComptForWcSlVideoSharePage: function initWebComptForWcSlVideoSharePage() {
      var initAfterConfWxOpen = function initAfterConfWxOpen(res) {
        if (res.err_msg.indexOf(':ok') !== -1) {
          utils.initNewPageHistoryStackFromSecOpen();
        } else {
          window.__failConfigWxOpen = true;
          Log.info('failed to config wxopen: res not ok');
          jsmonitorReport$1.setSum(221515, Device.os.iphone ? 7 : 8, 1);
          window.WX_BJ_REPORT && window.WX_BJ_REPORT.BadJs && res && window.WX_BJ_REPORT.BadJs.report('WcSlPlayer:CfgError', (window.__second_open__ ? 'secopen:' : 'h5:') + JSON.stringify(res));
        }
      };
      if (mmversion.isAndroid) {
        var clientVer = mmversion.getInner();
        if (clientVer > '27001037' && clientVer = '27001100') {
          utils.initWebCompt(['wxOpen' ], initAfterConfWxOpen);
        } else if (mmversion.gtVersion('7.0.15', 1)) {
          window.__failConfigWxOpen = true;
          Log.info('failed to config wxopen: android version check failed (gt 7.0.15)');
        } else {
          window.__failConfigWxOpen = true;
          Log.info('failed to config wxopen: android version check failed');
        }
      } else if (mmversion.isIOS) {
        if (mmversion.gtVersion('7.0.15', 1)) {
          utils.initWebCompt(['wxOpen' ], initAfterConfWxOpen);
        } else {
          window.__failConfigWxOpen = true;
          Log.info('failed to config wxopen: ios version check failed');
        }
      } else {
        window.__failConfigWxOpen = true;
      }
    },
    
    getWebComptStatus: function getWebComptStatus(cb) {
      if (typeof cb !== 'function') {
        return webComptStatus;
      }
      if (webComptStatus.status === 'loading') {
        webComptInitCb.push(cb);
      } else {
        cb(webComptStatus);
      }
      return true;
    },
    
    supportImmersiveMode: mmversion.isWechat && !mmversion.isInMiniProgram && (mmversion.isIOS && mmversion.gtVersion('8.0.9', 1) || mmversion.isAndroid && mmversion.gtVersion('8.0.9', 1)),
    debounce: debounce,
    
    bindDebounceScrollEvent: function bindDebounceScrollEvent(fn) {
      var scrollEle = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : window;
      var wait = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : 50;
      var useCapture = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : false;
      var debounceFn = debounce(fn, wait);
      DomEvent.on(scrollEle, 'scroll', '', debounceFn, useCapture);
    },
    checkIntersect: checkIntersect,
    
    clickRange: function clickRange(evt) {
      var selection = window.getSelection();
      var range = selection.rangeCount && selection.getRangeAt(0);
      if (!range || range.collapsed || !range.intersectsNode(evt.target)) {
        return false;
      }
      var rangeClientRects = range.getClientRects();
      var targetLineHeight = parseFloat(getComputedStyle(evt.target).lineHeight, 10);
      var targetRect = evt.target.getBoundingClientRect();
      for (var i in rangeClientRects) {
        if (rangeClientRects.hasOwnProperty(i)) {
          var rect = rangeClientRects[i];
          var extraHeight = targetLineHeight ? (targetLineHeight - rect.height) / 2 : 0;
          if (rect.width && checkIntersect(rect, targetRect) && evt.clientX >= rect.left && evt.clientX = rect.top - extraHeight && evt.clientY  0 && arguments[0] !== undefined ? arguments[0] : window.cgiDataNew;
    var envStatus = +getEnv(GLASS_ENV_KEY);
    var payAlbumInfo = cgiDataNew && cgiDataNew.public_tag_info && cgiDataNew.public_tag_info.pay_album_info;
    var pageEligible = !Device.os.pc && Boolean(Device.os.ios || Device.os.android) && Boolean(cgiDataNew) && +(cgiDataNew.item_show_type || 0) === 0 && !cgiDataNew.is_pay_subscribe && !(payAlbumInfo && payAlbumInfo.album_needpay);
    window.__liquid_glass_status__ = pageEligible && (envStatus === 1 || envStatus === 2) ? envStatus : 0;
    if (window.__liquid_glass_status__) {
      document.body.classList.add('ios_26_liquid_glass');
    }
  }
  var fontLS = new LS('font-scale');
  function parseExp(key) {
    var expList = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : [];
    var frontend_exp_list = [];
    if (expList && expList.length > 0) {
      frontend_exp_list = expList;
    } else if (window.frontend_exp_list) {
      frontend_exp_list = window.frontend_exp_list;
    } else {
      try {
        var frontend_exp_str = '';
        frontend_exp_list = JSON.parse('[' + frontend_exp_str + ']');
      } catch (e) {
        console.log('============error', e);
      }
    }
    var res = frontend_exp_list.reduce(function (res, item) {
      if (item.key === key) res = item.value === '1';
      return res;
    }, false);
    return res;
  }
  function setAutospace() {
    if (Device.os.ios && Device.cpVersion('18.4', -1, true)) {
      document.body.classList.add('autospace');
      window.test_autospace = true;
      new Image().src = "https://mp.weixin.qq.com/mp/jsmonitor?idkey=526340_1_1";
    }
  }
  function setBottomBarSafeBottom() {
    var bottomBarSafeBottomKey = '__bottom_bar_safe_bottom__';
    var bottomBarSafeBottom = localStorage.getItem(bottomBarSafeBottomKey);
    if (bottomBarSafeBottom) {
      document.documentElement.style.setProperty('--immersive-safe-bottom', bottomBarSafeBottom);
      window.__bottom_bar_safe_bottom__ = bottomBarSafeBottom.trim().replace('px', '') * 1 || 0;
    }
    var applyBottomBarSafeBottom = function applyBottomBarSafeBottom(res) {
      var setLs = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : false;
      try {
        if (Device.os.android && window.__wxWebEnv && typeof window.__wxWebEnv.getEnv === 'function' && !getEnv('enableAndroidEdge2Edge', true)) {
          window.__bottom_bar_safe_bottom__ = 0;
          document.documentElement.style.setProperty('--immersive-safe-bottom', '0px');
          setLs && localStorage.setItem(bottomBarSafeBottomKey, '0px');
        } else {
          window.__bottom_bar_safe_bottom__ = res * 1 || 0;
          document.documentElement.style.removeProperty('--immersive-safe-bottom');
          setLs && localStorage.setItem(bottomBarSafeBottomKey, "".concat(res, "px"));
        }
      } catch (error) {
        console.log(error);
      }
    };
    SafeArea.getAsync('bottom').then(function (res) {
      applyBottomBarSafeBottom(res, true);
      SafeArea.onChange(function (style) {
        if (typeof style.bottom === 'undefined') return;
        applyBottomBarSafeBottom(style.bottom, false);
      });
    });
  }
  function setGlobalTextLink() {
    var normalTextLinks = document.getElementsByClassName('normal_text_link');
    var mp_article_text_link = document.getElementsByClassName('mp_article_text_link');
    if (!normalTextLinks || normalTextLinks.length === 0 || mp_article_text_link && mp_article_text_link.length > 0) return;
    for (var i = 0; i  851) {
      document.body.classList.add('pages_skin_pc');
    }
  }
  function setWindowsTitleBold() {
    var ua = navigator.userAgent;
    var isWindows = /windows\snt/i.test(ua) && !/Windows\sPhone/i.test(ua);
    if (isWindows) document.body.classList.add('windows-title-bold');
  }
  function setNewCmtUi() {
    document.body.classList.add('appmsg_cmt_new_ui');
    if (window.cgiDataNew && window.cgiDataNew.item_show_type * 1 === 0) {
      document.body.classList.add('appmsg_content_new_ui');
    }
  }
  function setDeviceClass() {
    if (Device.os.ios) {
      document.body.classList.add('wx-device-ios');
    }
  }

  
  function isTimeValid(timestamp) {
    if (!timestamp || timestamp  0) {
      var foundItem = window.fontScaleDBData.find(function (item) {
        return item && item.tripleKey === tripleKey;
      });
      if (foundItem) {
        dbData = foundItem;
      }
    }
    var lsTime = lsData && _typeof(lsData) === 'object' ? lsData.lastUpdateTime || 0 : 0;
    var dbTime = dbData ? dbData.lastUpdateTime || 0 : 0;
    var storedClientFontLevel = lsTime >= dbTime && lsData ? lsData.clientFontLevel || null : dbData ? dbData.clientFontLevel || null : null;
    var currentClientFontLevel = getNativeFontLevelVar();
    if (storedClientFontLevel !== null && Number(currentClientFontLevel) !== Number(storedClientFontLevel)) {
      return null;
    }
    var latestTime = Math.max(lsTime, dbTime);
    if (!isTimeValid(latestTime)) {
      return null;
    }
    var fontScale = null;
    if (lsTime >= dbTime && lsData) {
      fontScale = _typeof(lsData) === 'object' ? lsData.fontScale : lsData;
    } else if (dbData) {
      fontScale = dbData.fontScale;
    }
    if (fontScale) window.lastFontScale = fontScale;
    console.log('getFontScale result:', fontScale);
    return fontScale;
  }

  

  function initFontScale(biz, mid, idx) {
    var useFontLevel = true;
    var fontScale = getFontScale(biz, mid, idx);
    var localFontScale = fontScale || 1;
    applyContentFontScale(localFontScale, useFontLevel);
  }
  function setGlobalStyle(biz, mid, idx) {
    initFontScale(biz, mid, idx);
    setWindowsTitleBold();
    setAutospace();
    setBottomBarGlassEnabled();
    setBottomBarSafeBottom();
    setImgPgaeSkinPc();
    setNewCmtUi();
    setDeviceClass();
  }
  window.canShowAiChatCommentEntry =
  mmversion.isIOS && mmversion.compareHexVersion('0x18004221') || mmversion.isAndroid && mmversion.compareHexVersion('0x28004150');
  window.canShowAiChatRoomEntry =
  mmversion.isIOS && mmversion.compareHexVersion('0x18004522') || mmversion.isAndroid && mmversion.compareHexVersion('0x28004555');
  function setBarAiChat() {
    if (!window.canShowAiChatRoomEntry) {
      var barAiChat = document.getElementById('js_bar_ai_chat');
      barAiChat === null || barAiChat === void 0 ? void 0 : barAiChat.parentElement.removeChild(barAiChat);
    }
  }
  try {
    setBarAiChat();
    setGlobalTextLink();
  } catch (error) {
    console.log('setGlobalTextLink error', error);
  }
  if (!window.__second_open__) {
    var _window = window,
      biz = _window.biz,
      mid = _window.mid,
      idx = _window.idx;
    setGlobalStyle(biz, mid, idx);
  }

  exports.getFontScale = getFontScale;
  exports.initFontScale = initFontScale;
  exports.parseExp = parseExp;
  exports.setAutospace = setAutospace;
  exports.setBottomBarSafeBottom = setBottomBarSafeBottom;
  exports.setDeviceClass = setDeviceClass;
  exports.setGlobalStyle = setGlobalStyle;
  exports.setGlobalTextLink = setGlobalTextLink;
  exports.setImgPgaeSkinPc = setImgPgaeSkinPc;
  exports.setNewCmtUi = setNewCmtUi;
  exports.setWindowsTitleBold = setWindowsTitleBold;

  Object.defineProperty(exports, '__esModule', { value: true });

  return exports;

})({});var __INLINE_SCRIPT__ = (function () {
  'use strict';

  function _arrayLikeToArray$1(arr, len) {
    if (len == null || len > arr.length) len = arr.length;
    for (var i = 0, arr2 = new Array(len); i  d2.exp) return 1;
        return 0;
      });
      var memCnt = 0;
      for (var i = 0; i = size) break;
        var key = keys[i];
        memCnt += JSON.stringify(data[key]).length;
        delete data[key];
      }
      return data;
    },
    'clear-all': function clearAll() {
      localStorage.clear();
      return {};
    }
  };
  function formatLogMsg(str) {
    return "[WXLS] ".concat(str);
  }
  
  var LS = function () {
    function LS(func, evictionPolicy, logger) {
      _classCallCheck(this, LS);
      this.logger = function () {};
      if (!func) throw 'require function name.';
      this.evictionPolicy = 'noeviction';
      this.key = func;
      if (typeof logger === 'function') {
        this.logger = function (str, type) {
          return logger(formatLogMsg(str), type);
        };
      }
      if (evictionPolicy && Object.keys(evictionPolicies).indexOf(evictionPolicy) !== -1) {
        this.evictionPolicy = evictionPolicy;
      }
      this.init();
    }
    _createClass(LS, [{
      key: "init",
      value: function init() {
        var _a, _b;
        this.check();
        if (Math.random() * 1000  now) {
            temp[key] = val;
          }
        }
        this.logger("check info: isReturn:".concat(isReturn, " data:").concat(JSON.stringify(temp)), 'info');
        if (isReturn) return temp;
        LS.setItem(this.key, JSON.stringify(temp), this.logger);
      }
    }, {
      key: "set",
      value: function set(key, val, exp) {
        var _a, _b;
        var data = this.check(true);
        data[key] = {
          val: val,
          exp: exp || +new Date()
        };
        try {
          if (localStorage.getItem(prefix + this.key)) localStorage.removeItem(prefix + this.key);
          localStorage.setItem(prefix + this.key, JSON.stringify(data));
          this.logger("first set success: LSlen:".concat((_a = window === null || window === void 0 ? void 0 : window.localStorage) === null || _a === void 0 ? void 0 : _a.length, " key:").concat(prefix + this.key, " data:").concat(JSON.stringify(data)), 'success');
        } catch (e) {
          this.logger("first set error: LSlen:".concat((_b = window === null || window === void 0 ? void 0 : window.localStorage) === null || _b === void 0 ? void 0 : _b.length, " error:").concat(e, " key:").concat(prefix + this.key, " data:").concat(JSON.stringify(data), " k:").concat(key, " v:").concat(val, " exp:").concat(exp), 'error');
          localStorage.clear();
          LS.setItem(this.key, JSON.stringify(_defineProperty({}, key, {
            val: val,
            exp: exp || +new Date()
          })), this.logger);
        }
      }
    }, {
      key: "get",
      value: function get(key) {
        var data = this.getData();
        data = data[key];
        return data ? data.val || null : null;
      }
    }, {
      key: "remove",
      value: function remove(key) {
        var data = this.getData();
        if (data[key]) delete data[key];
        LS.setItem(this.key, JSON.stringify(data), this.logger);
      }
    }], [{
      key: "getItem",
      value: function getItem(key) {
        key = prefix + key;
        return localStorage.getItem(key);
      }
    }, {
      key: "setItem",
      value: function setItem(key, val, logger) {
        var _a, _b;
        key = prefix + key;
        var n = 3;
        while (n--) {
          try {
            if (localStorage.getItem(key)) localStorage.removeItem(key);
            localStorage.setItem(key, val);
            typeof logger === 'function' && logger("setItem success: LSlen:".concat((_a = window === null || window === void 0 ? void 0 : window.localStorage) === null || _a === void 0 ? void 0 : _a.length, " key:").concat(key, " val:").concat(val), 'success');
            break;
          } catch (e) {
            typeof logger === 'function' && logger("setItem error: LSlen:".concat((_b = window === null || window === void 0 ? void 0 : window.localStorage) === null || _b === void 0 ? void 0 : _b.length, " error:").concat(e, " key:").concat(key, " val:").concat(val), 'error');
            LS.clear();
          }
        }
      }
    }, {
      key: "clear",
      value: function clear() {
        var i;
        var k;
        for (i = localStorage.length - 1; i >= 0; i--) {
          k = localStorage.key(i);
          if (k.indexOf(prefix) == 0) {
            localStorage.removeItem(k);
          }
        }
      }
    }, {
      key: "getSupportEvicationPolicy",
      value: function getSupportEvicationPolicy() {
        return Object.keys(evictionPolicies);
      }
    }]);
    return LS;
  }();

  function _createForOfIteratorHelper(o, allowArrayLike) { var it = typeof Symbol !== "undefined" && o[Symbol.iterator] || o["@@iterator"]; if (!it) { if (Array.isArray(o) || (it = _unsupportedIterableToArray(o)) || allowArrayLike && o && typeof o.length === "number") { if (it) o = it; var i = 0; var F = function F() {}; return { s: F, n: function n() { if (i >= o.length) return { done: true }; return { done: false, value: o[i++] }; }, e: function e(_e) { throw _e; }, f: F }; } throw new TypeError("Invalid attempt to iterate non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); } var normalCompletion = true, didErr = false, err; return { s: function s() { it = it.call(o); }, n: function n() { var step = it.next(); normalCompletion = step.done; return step; }, e: function e(_e2) { didErr = true; err = _e2; }, f: function f() { try { if (!normalCompletion && it["return"] != null) it["return"](); } finally { if (didErr) throw err; } } }; }
  function _unsupportedIterableToArray(o, minLen) { if (!o) return; if (typeof o === "string") return _arrayLikeToArray(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === "Object" && o.constructor) n = o.constructor.name; if (n === "Map" || n === "Set") return Array.from(o); if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen); }
  function _arrayLikeToArray(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i  b;
    }
  };
  function cpVersion(ver, op, canEq, type) {
    var mmver = false;
    switch (type) {
      case 'mac':
        mmver = getMac();
        break;
      case 'windows':
        mmver = getWindowsVersionFormat();
        break;
      case 'wxwork':
        mmver = getWxWork();
        break;
      case 'mpapp':
        mmver = getMpApp();
        break;
      case 'unifiedpc':
        mmver = getUnifiedPcVer();
        break;
      default:
        mmver = get();
        break;
    }
    if (!mmver) {
      return;
    }
    var mmversion = mmver.split('.');
    var version = ver.split('.');
    if (!/\d+/g.test(mmversion[mmversion.length - 1])) {
      mmversion.pop();
    }
    for (var i = 0, len = Math.max(mmversion.length, version.length); i = 64 && parseInt(v) = hexNum;
    }
    return false;
  }
  var mmversion = {
    get: get,
    getMac: getMac,
    getMacOS: getMacOS,
    getWindows: getWindows,
    getInner: getInner,
    getWxWork: getWxWork,
    getMpApp: getMpApp,
    cpVersion: cpVersion,
    eqVersion: eqVersion,
    gtVersion: gtVersion,
    ltVersion: ltVersion,
    getPlatform: getPlatform,
    getVersionNumber: getVersionNumber,
    isWp: is_wp,
    isIOS: is_ios,
    isAndroid: is_android,
    isHarmony: is_harmony,
    isHarmonyWechat: is_harmony && is_wechat && cpVersion('1.0.0', 1, true),
    isInMiniProgram: is_in_miniProgram,
    isWechat: is_wechat,
    isMac: is_mac,
    isWindows: is_windows,
    isLinux: is_linux,
    isMacWechat: is_mac_wechat,
    isWindowsWechat: is_windows_wechat,
    isWxWork: is_wx_work,
    isOnlyWechat: is_wechat && !is_wx_work,
    isMpapp: is_mpapp,
    isIPad: is_ipad,
    isGooglePlay: is_google_play,
    isPrefetch: is_prefetch,
    isDonutAPP: is_donut_app,
    compareHexVersion: compareHexVersion,
    isPcWechat: is_windows_wechat || is_mac_wechat,
    xwebVersion: xweb_version,
    isUnifiedPcWechat: is_unified_pc_wechat
  };

  function getInflightMap() {
    if (!window.__dedupe_promise_inflight__) {
      window.__dedupe_promise_inflight__ = new Map();
    }
    return window.__dedupe_promise_inflight__;
  }
  
  function dedupePromise(key, factory) {
    var inflightMap = getInflightMap();
    var existing = inflightMap.get(key);
    console.log("dedupePromise key=".concat(key, " existing=").concat(existing));
    if (existing) {
      return existing;
    }
    var promise = Promise.resolve().then(factory)["finally"](function () {
      inflightMap["delete"](key);
    });
    inflightMap.set(key, promise);
    return promise;
  }

  function asyncGeneratorStep(gen, resolve, reject, _next, _throw, key, arg) {
    try {
      var info = gen[key](arg);
      var value = info.value;
    } catch (error) {
      reject(error);
      return;
    }
    if (info.done) {
      resolve(value);
    } else {
      Promise.resolve(value).then(_next, _throw);
    }
  }
  function _asyncToGenerator(fn) {
    return function () {
      var self = this,
        args = arguments;
      return new Promise(function (resolve, reject) {
        var gen = fn.apply(self, args);
        function _next(value) {
          asyncGeneratorStep(gen, resolve, reject, _next, _throw, "next", value);
        }
        function _throw(err) {
          asyncGeneratorStep(gen, resolve, reject, _next, _throw, "throw", err);
        }
        _next(undefined);
      });
    };
  }

  var initJsBridge = false;
  if (!window.JSAPIEventCallbackMap) {
    window.JSAPIEventCallbackMap = {};
  }
  function connectWebViewJavascriptBridge(callback) {
    if (window.WebViewMPapp || window.WebViewJavascriptBridge) {
      return callback(window.WebViewMPapp || window.WebViewJavascriptBridge);
    }
    if (window.WVJBCallbacks) {
      return window.WVJBCallbacks.push(callback);
    }
    window.WVJBCallbacks = [callback];
    if (!mmversion.isMpapp) {
      return false;
    }
    if (!initJsBridge) {
      initJsBridge = true;
      var WVJBIframe = document.createElement('iframe');
      WVJBIframe.style.display = 'none';
      WVJBIframe.src = 'https://__bridge_loaded__';
      document.body.appendChild(WVJBIframe);
      setTimeout(function () {
        initJsBridge = false;
        document.body.removeChild(WVJBIframe);
      }, 0);
    }
    return false;
  }
  function invoke$1(jsapiName, opt, callback) {
    connectWebViewJavascriptBridge(function (bridge) {
      try {
        if (typeof opt === 'function') {
          callback = opt;
        }
        if (_typeof(opt) !== 'object' && typeof opt !== 'string') {
          opt = {};
        }
        bridge.callHandler(jsapiName, opt, function (res) {
          try {
            var ret = _typeof(res) === 'object' ? res : JSON.parse(res);
            var errMsg = ret.err_msg || ret.errMsg;
            console.info("[mpapp jsapi] invoke->".concat(jsapiName, " ").concat(opt.action || '', " ").concat(errMsg));
            typeof callback === 'function' && callback(ret);
          } catch (e) {
            window.WX_BJ_REPORT.BadJs.report('invoke', "callback ".concat(jsapiName, " error:"), {
              mid: 'mmbizwebapp:js_brridge',
              _info: e
            });
            console.error("[mpapp jsapi] ".concat(jsapiName, " ").concat(opt.action || ''), e, res);
          }
        });
      } catch (e) {
        window.WX_BJ_REPORT.BadJs.report('invoke', 'callback error:', {
          mid: 'mmbizwebapp:js_brridge',
          _info: e
        });
        console.error('[mpapp jsapi]', e);
      }
    });
  }
  function on$1(eventName, callback) {
    connectWebViewJavascriptBridge(function (bridge) {
      if (!window.JSAPIEventCallbackMap[eventName]) {
        window.JSAPIEventCallbackMap[eventName] = [];
      }
      window.JSAPIEventCallbackMap[eventName].push(callback);
      if (window.JSAPIEventCallbackMap[eventName].length > 1) {
        return false;
      }
      try {
        bridge.registerHandler(eventName, function () {
          for (var _len = arguments.length, args = new Array(_len), _key = 0; _key ".concat(eventName, " ").concat(data.err_msg));
            if (window.JSAPIEventCallbackMap[eventName] && window.JSAPIEventCallbackMap[eventName].length) {
              var result;
              for (var i = 0; i = 0; i--) {
        if (window.JSAPIEventCallbackMap[eventName][i] === callback) {
          window.JSAPIEventCallbackMap[eventName].splice(i, 1);
          result = true;
        }
      }
      return result;
    });
  }

  function _regeneratorRuntime() {  _regeneratorRuntime = function _regeneratorRuntime() { return e; }; var t, e = {}, r = Object.prototype, n = r.hasOwnProperty, o = Object.defineProperty || function (t, e, r) { t[e] = r.value; }, i = "function" == typeof Symbol ? Symbol : {}, a = i.iterator || "@@iterator", c = i.asyncIterator || "@@asyncIterator", u = i.toStringTag || "@@toStringTag"; function define(t, e, r) { return Object.defineProperty(t, e, { value: r, enumerable: !0, configurable: !0, writable: !0 }), t[e]; } try { define({}, ""); } catch (t) { define = function define(t, e, r) { return t[e] = r; }; } function wrap(t, e, r, n) { var i = e && e.prototype instanceof Generator ? e : Generator, a = Object.create(i.prototype), c = new Context(n || []); return o(a, "_invoke", { value: makeInvokeMethod(t, r, c) }), a; } function tryCatch(t, e, r) { try { return { type: "normal", arg: t.call(e, r) }; } catch (t) { return { type: "throw", arg: t }; } } e.wrap = wrap; var h = "suspendedStart", l = "suspendedYield", f = "executing", s = "completed", y = {}; function Generator() {} function GeneratorFunction() {} function GeneratorFunctionPrototype() {} var p = {}; define(p, a, function () { return this; }); var d = Object.getPrototypeOf, v = d && d(d(values([]))); v && v !== r && n.call(v, a) && (p = v); var g = GeneratorFunctionPrototype.prototype = Generator.prototype = Object.create(p); function defineIteratorMethods(t) { ["next", "throw", "return"].forEach(function (e) { define(t, e, function (t) { return this._invoke(e, t); }); }); } function AsyncIterator(t, e) { function invoke(r, o, i, a) { var c = tryCatch(t[r], t, o); if ("throw" !== c.type) { var u = c.arg, h = u.value; return h && "object" == _typeof(h) && n.call(h, "__await") ? e.resolve(h.__await).then(function (t) { invoke("next", t, i, a); }, function (t) { invoke("throw", t, i, a); }) : e.resolve(h).then(function (t) { u.value = t, i(u); }, function (t) { return invoke("throw", t, i, a); }); } a(c.arg); } var r; o(this, "_invoke", { value: function value(t, n) { function callInvokeWithMethodAndArg() { return new e(function (e, r) { invoke(t, n, e, r); }); } return r = r ? r.then(callInvokeWithMethodAndArg, callInvokeWithMethodAndArg) : callInvokeWithMethodAndArg(); } }); } function makeInvokeMethod(e, r, n) { var o = h; return function (i, a) { if (o === f) throw new Error("Generator is already running"); if (o === s) { if ("throw" === i) throw a; return { value: t, done: !0 }; } for (n.method = i, n.arg = a;;) { var c = n.delegate; if (c) { var u = maybeInvokeDelegate(c, n); if (u) { if (u === y) continue; return u; } } if ("next" === n.method) n.sent = n._sent = n.arg;else if ("throw" === n.method) { if (o === h) throw o = s, n.arg; n.dispatchException(n.arg); } else "return" === n.method && n.abrupt("return", n.arg); o = f; var p = tryCatch(e, r, n); if ("normal" === p.type) { if (o = n.done ? s : l, p.arg === y) continue; return { value: p.arg, done: n.done }; } "throw" === p.type && (o = s, n.method = "throw", n.arg = p.arg); } }; } function maybeInvokeDelegate(e, r) { var n = r.method, o = e.iterator[n]; if (o === t) return r.delegate = null, "throw" === n && e.iterator["return"] && (r.method = "return", r.arg = t, maybeInvokeDelegate(e, r), "throw" === r.method) || "return" !== n && (r.method = "throw", r.arg = new TypeError("The iterator does not provide a '" + n + "' method")), y; var i = tryCatch(o, e.iterator, r.arg); if ("throw" === i.type) return r.method = "throw", r.arg = i.arg, r.delegate = null, y; var a = i.arg; return a ? a.done ? (r[e.resultName] = a.value, r.next = e.nextLoc, "return" !== r.method && (r.method = "next", r.arg = t), r.delegate = null, y) : a : (r.method = "throw", r.arg = new TypeError("iterator result is not an object"), r.delegate = null, y); } function pushTryEntry(t) { var e = { tryLoc: t[0] }; 1 in t && (e.catchLoc = t[1]), 2 in t && (e.finallyLoc = t[2], e.afterLoc = t[3]), this.tryEntries.push(e); } function resetTryEntry(t) { var e = t.completion || {}; e.type = "normal", delete e.arg, t.completion = e; } function Context(t) { this.tryEntries = [{ tryLoc: "root" }], t.forEach(pushTryEntry, this), this.reset(!0); } function values(e) { if (e || "" === e) { var r = e[a]; if (r) return r.call(e); if ("function" == typeof e.next) return e; if (!isNaN(e.length)) { var o = -1, i = function next() { for (; ++o = 0; --o) { var i = this.tryEntries[o], a = i.completion; if ("root" === i.tryLoc) return handle("end"); if (i.tryLoc = 0; --r) { var o = this.tryEntries[r]; if (o.tryLoc = 0; --e) { var r = this.tryEntries[e]; if (r.finallyLoc === t) return this.complete(r.completion, r.afterLoc), resetTryEntry(r), y; } }, "catch": function _catch(t) { for (var e = this.tryEntries.length - 1; e >= 0; --e) { var r = this.tryEntries[e]; if (r.tryLoc === t) { var n = r.completion; if ("throw" === n.type) { var o = n.arg; resetTryEntry(r); } return o; } } throw new Error("illegal catch attempt"); }, delegateYield: function delegateYield(e, r, n) { return this.delegate = { iterator: values(e), resultName: r, nextLoc: n }, "next" === this.method && (this.arg = t), y; } }, e; }
  var doc = {};
  var isAcrossOrigin = false;
  var notFoundedMPPageAction = [];
  var __moon_report = window.__moon_report || function () {};
  var MOON_JSAPI_KEY_OFFSET = 8;
  try {
    doc = top.window.document;
  } catch (e) {
    isAcrossOrigin = true;
  }
  if (!window.JSAPIEventCallbackMap) {
    window.JSAPIEventCallbackMap = {};
  }
  function ready(onBridgeReady) {
    var bridgeReady = function bridgeReady() {
      try {
        if (onBridgeReady) {
          window.onBridgeReadyTime = window.onBridgeReadyTime || Date.now();
          onBridgeReady();
        }
      } catch (e) {
        __moon_report([{
          offset: MOON_JSAPI_KEY_OFFSET,
          log: 'ready',
          e: e
        }]);
        throw e;
      }
      window.jsapiReadyTime = Date.now();
    };
    if (!isAcrossOrigin && (typeof top.window.WeixinJSBridge === 'undefined' || !top.window.WeixinJSBridge.invoke)) {
      if (doc.addEventListener) {
        doc.addEventListener('WeixinJSBridgeReady', bridgeReady, false);
      } else if (doc.attachEvent) {
        doc.attachEvent('WeixinJSBridgeReady', bridgeReady);
        doc.attachEvent('onWeixinJSBridgeReady', bridgeReady);
      }
    } else {
      bridgeReady();
    }
  }
  var invokeNotWaitA8key = ['notifyPageInfo', 'updatePageAuth'
  ];
  var checkNotFoundedInvoke = function checkNotFoundedInvoke(methodName, args) {
    if (methodName === 'handleMPPageAction' && (args === null || args === void 0 ? void 0 : args.action) && notFoundedMPPageAction.includes(args === null || args === void 0 ? void 0 : args.action)) {
      return true;
    }
    return false;
  };
  function invoke(_x, _x2, _x3) {
    return _invoke.apply(this, arguments);
  }
  function _invoke() {
    _invoke = _asyncToGenerator( _regeneratorRuntime().mark(function _callee(methodName, args, callback) {
      return _regeneratorRuntime().wrap(function _callee$(_context) {
        while (1) switch (_context.prev = _context.next) {
          case 0:
            if (!(window.__secPageAuthPromise && !window.__is_page_auth_ok__ && !invokeNotWaitA8key.includes(methodName))) {
              _context.next = 3;
              break;
            }
            _context.next = 3;
            return window.__secPageAuthPromise;
          case 3:
            ready(function () {
              if (isAcrossOrigin) return false;
              if (_typeof(top.window.WeixinJSBridge) !== 'object') {
                alert('请在微信中打开此链接');
                return false;
              }
              if (checkNotFoundedInvoke(methodName, args)) {
                setTimeout(function () {
                  if (callback) {
                    callback.apply(window, [{
                      err_msg: "".concat(methodName, ":fail"),
                      err_desc: 'action isn\'t supported'
                    }]);
                  }
                }, 0);
              } else {
                top.window.WeixinJSBridge.invoke(methodName, args, function () {
                  try {
                    for (var _len2 = arguments.length, rets = new Array(_len2), _key2 = 0; _key2  ".concat(ret.err_msg) : '';
                    if (['handleMPPageAction', 'handleVideoAction', 'handleHaokanAction'].indexOf(methodName) !== -1) {
                      var action = (args === null || args === void 0 ? void 0 : args.action) || '';
                      console.info('[system]', "[jsapi] invoke->".concat(methodName, ", action->").concat(action).concat(errMsg));
                    } else {
                      console.info('[system]', "[jsapi] invoke->".concat(methodName).concat(errMsg));
                    }
                    if (methodName === 'handleMPPageAction' && (args === null || args === void 0 ? void 0 : args.action) && ((ret === null || ret === void 0 ? void 0 : ret.err_desc) === 'action isn\'t supported' || (ret === null || ret === void 0 ? void 0 : ret.err_msg) === 'handleMPPageAction:fail action is not supported')) {
                      notFoundedMPPageAction.push(args === null || args === void 0 ? void 0 : args.action);
                    }
                    if (callback) {
                      callback.apply(window, rets);
                    }
                  } catch (e) {
                    __moon_report([{
                      offset: MOON_JSAPI_KEY_OFFSET,
                      log: "invoke;methodName:".concat(methodName),
                      e: e
                    }]);
                    throw e;
                  }
                });
              }
            });
          case 4:
          case "end":
            return _context.stop();
        }
      }, _callee);
    }));
    return _invoke.apply(this, arguments);
  }
  function call(_x4) {
    return _call.apply(this, arguments);
  }
  function _call() {
    _call = _asyncToGenerator( _regeneratorRuntime().mark(function _callee2(methodName) {
      return _regeneratorRuntime().wrap(function _callee2$(_context2) {
        while (1) switch (_context2.prev = _context2.next) {
          case 0:
            if (!(window.__secPageAuthPromise && !window.__is_page_auth_ok__)) {
              _context2.next = 3;
              break;
            }
            _context2.next = 3;
            return window.__secPageAuthPromise;
          case 3:
            ready(function () {
              if (isAcrossOrigin) return false;
              if (_typeof(top.window.WeixinJSBridge) !== 'object') {
                return false;
              }
              try {
                top.window.WeixinJSBridge.call(methodName);
              } catch (e) {
                __moon_report([{
                  offset: MOON_JSAPI_KEY_OFFSET,
                  log: "call;methodName:".concat(methodName),
                  e: e
                }]);
                throw e;
              }
            });
          case 4:
          case "end":
            return _context2.stop();
        }
      }, _callee2);
    }));
    return _call.apply(this, arguments);
  }
  function on(eventName, callback) {
    ready(function () {
      if (isAcrossOrigin) return false;
      if (_typeof(top.window.WeixinJSBridge) !== 'object' || !top.window.WeixinJSBridge.on) {
        return false;
      }
      if (!window.JSAPIEventCallbackMap[eventName]) {
        window.JSAPIEventCallbackMap[eventName] = [];
      }
      window.JSAPIEventCallbackMap[eventName].push(callback);
      if (window.JSAPIEventCallbackMap[eventName].length > 1) {
        return false;
      }
      top.window.WeixinJSBridge.on(eventName, function () {
        try {
          for (var _len = arguments.length, rets = new Array(_len), _key = 0; _key  ".concat(ret.err_msg) : '';
          console.info('[system]', "[jsapi] event->".concat(eventName).concat(errMsg));
          if (window.JSAPIEventCallbackMap[eventName] && window.JSAPIEventCallbackMap[eventName].length) {
            var result;
            for (var i = 0; i = 0; i--) {
        if (window.JSAPIEventCallbackMap[eventName][i] === callback) {
          window.JSAPIEventCallbackMap[eventName].splice(i, 1);
          result = true;
        }
      }
      return result;
    });
  }
  var coreAPI = {
    ready: ready,
    invoke: invoke,
    call: call,
    on: on,
    remove: remove
  };
  var mpappAPI = {
    ready: connectWebViewJavascriptBridge,
    invoke: invoke$1,
    call: invoke$1,
    on: on$1,
    remove: remove$1
  };
  var JSAPI = mmversion.isMpapp ? mpappAPI : coreAPI;
  var innerVersion = (mmversion.getInner() || '').toUpperCase();
  var getBizLS = new LS('get_biz_result');
  function getBizMap() {
    if (!window.__get_biz_map__) {
      window.__get_biz_map__ = {};
    }
    return window.__get_biz_map__;
  }
  var isGetBizSupported = mmversion.isOnlyWechat && mmversion.isIOS && innerVersion >= '18003C2A' || mmversion.isOnlyWechat && mmversion.isAndroid && innerVersion >= '28003D3C' || mmversion.isUnifiedPcWechat && mmversion.cpVersion('4.1.10', 1, true, 'unifiedpc');
  function invokeGetBiz(needCheckBiz, bizType) {
    return dedupePromise("getBiz:".concat(needCheckBiz, ":").concat(bizType), function () {
      return new Promise(function (resolve, reject) {
        if (!isGetBizSupported) {
          reject('Not support');
        } else {
          JSAPI.invoke('handleMPPageAction', {
            action: 'getBiz',
            needCheckBiz: needCheckBiz,
            bizType: bizType
          }, function (res) {
            console.log("getBiz needCheckBiz=".concat(needCheckBiz, " bizType=").concat(bizType, " res: ").concat(JSON.stringify(res)));
            if (res && res.err_msg && res.err_msg.indexOf('ok') > -1) {
              var bizMap = getBizMap();
              bizMap[bizType] = res.biz;
              resolve(res.biz);
              getBizLS.set("".concat(bizType, "_get_biz_result"), res.biz, +new Date() + 3 * 24 * 60 * 60 * 1000);
            } else {
              reject('Failed to get biz');
            }
          });
        }
      });
    });
  }
  function getBiz(needCheckBiz, bizType) {
    var _a;
    if (needCheckBiz === void 0) {
      needCheckBiz = false;
    }
    if (bizType === void 0) {
      bizType = ((_a = window.cgiDataNew) === null || _a === void 0 ? void 0 : _a.biz_type) || 1;
    }
    var bizMap = getBizMap();
    if (!needCheckBiz && bizMap[bizType] !== undefined) {
      return Promise.resolve(bizMap[bizType]);
    }
    return invokeGetBiz(needCheckBiz, bizType);
  }
  mmversion.isOnlyWechat && mmversion.isIOS || mmversion.isOnlyWechat && mmversion.isAndroid || mmversion.isUnifiedPcWechat && mmversion.cpVersion('4.1.10', 1, true, 'unifiedpc');
  function LsGetBiz(bizType) {
    var _a, _b, _c;
    if (bizType === void 0) {
      bizType = ((_a = window.cgiDataNew) === null || _a === void 0 ? void 0 : _a.biz_type) || 1;
    }
    var bizMap = getBizMap();
    return (_c = (_b = bizMap[bizType]) !== null && _b !== void 0 ? _b : getBizLS.get("".concat(bizType, "_get_biz_result"))) !== null && _c !== void 0 ? _c : '';
  }
  
  var getIsAuthorLs = function getIsAuthorLs(bizuin, bizType) {
    var _a;
    if (bizuin === void 0) {
      bizuin = window.biz;
    }
    if (bizType === void 0) {
      bizType = ((_a = window.cgiDataNew) === null || _a === void 0 ? void 0 : _a.biz_type) || 1;
    }
    return bizuin && bizuin === LsGetBiz(bizType);
  };
  var getIsAuthor = function getIsAuthor(cb, bizuin, needCheckBiz, bizType) {
    var _a;
    if (bizuin === void 0) {
      bizuin = window.biz;
    }
    if (needCheckBiz === void 0) {
      needCheckBiz = false;
    }
    if (bizType === void 0) {
      bizType = ((_a = window.cgiDataNew) === null || _a === void 0 ? void 0 : _a.biz_type) || 1;
    }
    getBiz(needCheckBiz, bizType).then(function (biz) {
      cb(biz && biz === bizuin);
    })["catch"](function () {
      cb(false);
    });
  };

  function parseUrl(url) {
    var len = url.length;
    var ques_pos = url.indexOf('?');
    var hash_pos = url.indexOf('#');
    hash_pos = hash_pos == -1 ? len : hash_pos;
    ques_pos = ques_pos == -1 ? hash_pos : ques_pos;
    var host = url.substring(0, ques_pos);
    var query_str = url.substring(ques_pos + 1, hash_pos);
    var hash = url.substring(hash_pos + 1);
    return {
      host: host,
      query_str: query_str,
      hash: hash
    };
  }
  function join(url, args, noEncode) {
    var ret = parseUrl(url);
    var query_str = ret.query_str;
    var args_arr = [];
    if (_typeof(args) === 'object') {
      for (var key in args) {
        if (args.hasOwnProperty(key)) {
          args_arr.push("".concat(key, "=").concat(noEncode ? args[key] : encodeURIComponent(args[key])));
        }
      }
    } else {
      args_arr.push(noEncode ? args : encodeURIComponent(args));
    }
    if (args_arr.length > 0) {
      query_str += (query_str !== "" ? "&" : "") + args_arr.join("&");
    }
    return ret.host + (query_str !== "" ? "?".concat(query_str) : "") + (ret.hash !== "" ? "#".concat(ret.hash) : "");
  }
  
  function addParam(url, param, value, forceReplace) {
    url = url || location.href;
    var firstAndPos = url.indexOf("&");
    var len = url.length;
    var reverseUrl = url.replace(/^[\w\d]+:[/\\]+/g, "").split("").reverse();
    if (!Array.prototype.indexOf) {
      Array.prototype.indexOf = function (searchElement, fromIndex) {
        var k;
        if (this == null) {
          throw new TypeError('"this" is null or not defined');
        }
        var O = Object(this);
        var len = O.length >>> 0;
        if (len === 0) {
          return -1;
        }
        var n = fromIndex || 0;
        if (Math.abs(n) === Infinity) {
          n = 0;
        }
        if (n >= len) {
          return -1;
        }
        k = Math.max(n >= 0 ? n : len - Math.abs(n), 0);
        while (k  lastSlashPos) {
      url = url.replace("&", "?");
    }
    var reg = new RegExp("([\\?&]".concat(param, "=)[^&#]*"));
    if (!url.match(reg)) {
      var urlInfo = parseUrl(url);
      var hash = urlInfo.hash ? '#' + urlInfo.hash : '';
      url = url.replace(hash, '');
      var _pos = url.indexOf("?");
      if (_pos == -1) {
        return "".concat(url, "?").concat(param, "=").concat(value).concat(hash);
      }
      if (_pos == url.length - 1) {
        return "".concat(url + param, "=").concat(value).concat(hash);
      }
      return "".concat(url, "&").concat(param, "=").concat(value).concat(hash);
    }
    if (forceReplace === true) {
      return url.replace(reg, "$1".concat(value));
    }
    return url;
  }
  function addWxfrom(src, wxfrom) {
    var offset = window.service_type === 1 ? 10000 : 0;
    return addParam(src, 'wxfrom', offset + Number(wxfrom), true);
  }
  function removeParam(url, param) {
    var _URL = new URL(url),
      protocol = _URL.protocol,
      host = _URL.host,
      pathname = _URL.pathname,
      search = _URL.search,
      hash = _URL.hash;
    var queryParams = new URLSearchParams(search);
    queryParams["delete"](param);
    var newSearch = queryParams.toString();
    var newUrl = new URL("".concat(protocol, "//").concat(host).concat(pathname).concat(newSearch ? "?".concat(decodeURIComponent(newSearch)) : "").concat(hash));
    return newUrl.toString();
  }
  function getQuery(name, url) {
    var u = url || window.location.search;
    var reg = new RegExp("(^|&)".concat(name, "=([^&]*)(&|$)"));
    var r = u.substring(u.indexOf('?') + 1).match(reg);
    return r !== null ? r[2] : '';
  }
  function encodeBase64(value) {
    try {
      return window.btoa(value);
    } catch (e) {
      return '';
    }
  }
  function decodeBase64(value) {
    try {
      return window.atob(value);
    } catch (e) {
      return '';
    }
  }
  function joinUrl(url) {
    var obj = {};
    if (typeof window.uin !== 'undefined') {
      obj.uin = window.uin;
    }
    if (typeof window.key !== 'undefined') {
      obj.key = window.key;
    }
    if (typeof window.pass_ticket !== 'undefined') {
      obj.pass_ticket = window.pass_ticket;
    }
    if (typeof window.wxtoken !== 'undefined') {
      obj.wxtoken = window.wxtoken;
    }
    if (typeof window.devicetype !== 'undefined') {
      obj.devicetype = window.devicetype;
    }
    if (typeof window.clientversion !== 'undefined') {
      obj.clientversion = window.clientversion || mmversion.getInner();
    }
    obj.version = obj.clientversion;
    if (window.biz) {
      obj.__biz = window.biz;
    }
    if (getQuery('enterid')) {
      obj.enterid = getQuery('enterid');
    }
    if (typeof window.appmsg_token !== 'undefined') {
      obj.appmsg_token = window.appmsg_token;
    } else if (url.indexOf('advertisement_report') > -1) {
      new Image().src = "".concat(location.protocol, "//mp.weixin.qq.com/mp/jsmonitor?idkey=68064_13_1&r=").concat(Math.random());
    }
    obj.x5 = navigator.userAgent.indexOf('TBS/') !== -1 ? '1' : '0';
    obj.f = 'json';
    return join(url, obj);
  }
  function joinUserArticleRole(url, notJoin, cb) {
    var bizuin = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : window.biz;
    var needCheckBiz = arguments.length > 5 && arguments[5] !== undefined ? arguments[5] : false;
    if (notJoin) {
      cb(url);
    } else {
      getIsAuthor(function (isAuthor) {
        cb(addParam(url, 'user_article_role', isAuthor ? 1 : 0, true));
      }, bizuin, needCheckBiz);
    }
  }
  function getA8keyQuery(name, url) {
    return new Promise(function (resolve) {
      if (window.__secPageAuthPromise) {
        window.__secPageAuthPromise.then(function () {
          resolve(getQuery(name, url));
        });
      } else {
        resolve(getQuery(name, url));
      }
    });
  }
  function addHash(url, hash) {
    var isReplace = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : false;
    if (isReplace) {
      return "".concat(url.split('#')[0]).concat(hash);
    }
    return "".concat(url).concat(url.indexOf('#') === -1 ? '#' : '').concat(hash);
  }
  function decodeUrl(url) {
    var _url = url;
    while (_url.indexOf('&') !== -1) {
      _url = _url.htmlDecode();
    }
    return _url;
  }
  var Url = {
    parseUrl: parseUrl,
    join: join,
    addParam: addParam,
    addWxfrom: addWxfrom,
    addHash: addHash,
    getQuery: getQuery,
    getA8keyQuery: getA8keyQuery,
    encodeBase64: encodeBase64,
    decodeBase64: decodeBase64,
    joinUrl: joinUrl,
    joinUserArticleRole: joinUserArticleRole,
    removeParam: removeParam,
    decodeUrl: decodeUrl
  };

  
  
  var Device = {};
  function detect(ua) {
    var MQQBrowser = ua.match(/MQQBrowser\/(\d+\.\d+)/i);
    var MQQClient = ua.match(/QQ\/(\d+\.(\d+)\.(\d+)\.(\d+))/i) || ua.match(/V1_AND_SQ_([\d\.]+)/);
    var WeChat = ua.match(/MicroMessenger\/((\d+)\.(\d+))\.(\d+)/) || ua.match(/MicroMessenger\/((\d+)\.(\d+))/);
    var MacOS = ua.match(/Mac\sOS\sX\s(\d+[\.|_]\d+)/);
    var WinOS = ua.match(/Windows(\s+\w+)?\s+?(\d+\.\d+)/);
    var Linux = ua.match(/Linux\s/);
    var MiuiBrowser = ua.match(/MiuiBrowser\/(\d+\.\d+)/i);
    var M1 = ua.match(/MI-ONE/);
    var MIPAD = ua.match(/MI PAD/);
    var UC = ua.match(/UCBrowser\/(\d+\.\d+(\.\d+\.\d+)?)/) || ua.match(/\sUC\s/);
    var IEMobile = ua.match(/IEMobile(\/|\s+)(\d+\.\d+)/) || ua.match(/WPDesktop/);
    var ipod = ua.match(/(ipod).*\s([\d_]+)/i);
    var ipad = ua.match(/(ipad).*\s([\d_]+)/i);
    var iphone = ua.match(/(iphone)\sos\s([\d_]+)/i);
    var Chrome = ua.match(/Chrome\/(\d+\.\d+)/);
    var AndriodBrowser = ua.match(/Mozilla.*Linux.*Android.*AppleWebKit.*Mobile Safari/);
    var android = ua.match(/(android)\s([\d\.]+)/i);
    var harmony = ua.match(/(OpenHarmony)\s([\d\.]+)/i);
    Device.browser = Device.browser || {}, Device.os = Device.os || {};
    Device.os.type = -1;
    Device.os.unifiedPC = ua.match(/UnifiedPC/);
    Device.os.unifiedMac = /UnifiedPCMac/i.test(ua);
    Device.os.unifiedWindows = /UnifiedPCWindows/i.test(ua);
    if (window.ActiveXObject) {
      var vie = 6;
      (window.XMLHttpRequest || ua.indexOf('MSIE 7.0') > -1) && (vie = 7);
      (window.XDomainRequest || ua.indexOf('Trident/4.0') > -1) && (vie = 8);
      ua.indexOf('Trident/5.0') > -1 && (vie = 9);
      ua.indexOf('Trident/6.0') > -1 && (vie = 10);
      Device.browser.ie = true, Device.browser.version = vie;
    } else if (ua.indexOf('Trident/7.0') > -1) {
      Device.browser.ie = true, Device.browser.version = 11;
    }
    if (android) {
      Device.os.android = true;
      Device.os.version = android[2];
      Device.os.type = 2;
    }
    if (harmony) {
      Device.os.harmony = true;
      Device.os.version = harmony[2];
      Device.os.type = 42;
    }
    if (ipod) {
      Device.os.ios = Device.os.ipod = true;
      Device.os.version = ipod[2].replace(/_/g, '.');
    }
    if (ipad) {
      Device.os.ios = Device.os.ipad = true;
      Device.os.version = ipad[2].replace(/_/g, '.');
      Device.os.type = 13;
    }
    if (iphone) {
      Device.os.iphone = Device.os.ios = true;
      Device.os.version = iphone[2].replace(/_/g, '.');
      Device.os.type = 1;
    }
    if (WinOS) Device.os.windows = true, Device.os.version = WinOS[2], Device.os.type = 15;
    if (MacOS) Device.os.Mac = true, Device.os.version = MacOS[1], Device.os.type = 14;
    if (Linux) Device.os.Linux = true, Device.os.type = 33;
    if (ua.indexOf('lepad_hls') > 0) Device.os.LePad = true;
    if (MIPAD) Device.os.MIPAD = true;
    if (MQQBrowser) Device.browser.MQQ = true, Device.browser.version = MQQBrowser[1];
    if (MQQClient) Device.browser.MQQClient = true, Device.browser.version = MQQClient[1];
    if (WeChat) Device.browser.WeChat = true, Device.browser.mmversion = Device.browser.version = WeChat[1];
    if (MiuiBrowser) Device.browser.MIUI = true, Device.browser.version = MiuiBrowser[1];
    if (UC) Device.browser.UC = true, Device.browser.version = UC[1] || NaN;
    if (IEMobile) Device.browser.IEMobile = true, Device.browser.version = IEMobile[2];
    if (AndriodBrowser) {
      Device.browser.AndriodBrowser = true;
    }
    if (M1) {
      Device.browser.M1 = true;
    }
    if (Chrome) {
      Device.browser.Chrome = true, Device.browser.version = Chrome[1];
    }
    if (Device.os.windows) {
      if (typeof navigator.platform !== "undefined" && navigator.platform.toLowerCase() == "win64") {
        Device.os.win64 = true;
      } else {
        Device.os.win64 = false;
      }
    }
    if (Device.os.Mac || Device.os.windows || Device.os.Linux || Device.os.unifiedPC || /OpenHarmony/i.test(ua) && /pc/i.test(ua)) {
      Device.os.pc = true;
    }
    var osType = {
      iPad7: 'iPad; CPU OS 7',
      LePad: 'lepad_hls',
      XiaoMi: 'MI-ONE',
      SonyDTV: "SonyDTV",
      SamSung: 'SAMSUNG',
      HTC: 'HTC',
      VIVO: 'vivo'
    };
    for (var os in osType) {
      Device.os[os] = ua.indexOf(osType[os]) !== -1;
    }
    Device.os.phone = Device.os.phone || /windows phone/i.test(ua);
    Device.os.getNumVersion = function () {
      return parseFloat(Device.os.version);
    };
    Device.os.hasTouch = 'ontouchstart' in window;
    if (Device.os.hasTouch && Device.os.ios && Device.os.getNumVersion() = 3.0;
    };
    Device.browser.isCanOcx = function () {
      return !!Device.os.windows && (!!Device.browser.ie || Device.browser.isFFCanOcx() || !!Device.browser.webkit);
    };
    Device.browser.isNotIESupport = function () {
      return !!Device.os.windows && (!!Device.browser.webkit || Device.browser.isFFCanOcx());
    };
    Device.userAgent = {};
    Device.userAgent.browserVersion = Device.browser.version;
    Device.userAgent.osVersion = Device.os.version;
    if (Device.os.unifiedPC) {
      if (Device.os.unifiedWindows) Device.os.type = 37;else if (Device.os.unifiedMac) Device.os.type = 38;else Device.os.type = 39;
    }
    delete Device.userAgent.version;
  }
  detect(window.navigator.userAgent);
  function canSupportH5Video() {
    var ua = window.navigator.userAgent,
      m = null;
    if (!!Device.os.android) {
      if (Device.browser.MQQ && Device.browser.getNumVersion() >= 4.2) {
        return true;
      }
      if (ua.indexOf('MI2') != -1) {
        return true;
      }
      if (Device.os.version >= '4' && (m = ua.match(/MicroMessenger\/((\d+)\.(\d+))\.(\d+)/))) {
        if (parseFloat(m[1]) >= 4.2) {
          return true;
        }
      }
      if (Device.os.version >= '4.1') {
        return true;
      }
    }
    return false;
  }
  function canSupportVideoMp4() {
    var video = document.createElement('video');
    if (typeof video.canPlayType === 'function') {
      if (video.canPlayType('video/mp4; codecs="mp4v.20.8"') === 'probably') {
        return true;
      }
      if (video.canPlayType('video/mp4; codecs="avc1.42E01E"') === 'probably' || video.canPlayType('video/mp4; codecs="avc1.42E01E, mp4a.40.2"') === 'probably') {
        return true;
      }
    }
    return false;
  }
  function canSupportAutoPlay() {
    if (Device.os.ios && Device.os.getNumVersion()  1 && arguments[1] !== undefined ? arguments[1] : 0;
    var canEqual = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : false;
    var nowVersionStr = Device.os.version;
    if (!nowVersionStr) return false;
    var versionArr = version.split('.');
    var nowVersionArr = nowVersionStr.split('.');
    for (var i = 0; i  0) return vi > nvi;
      if (cp = 13 && Device.os.getNumVersion()  0 && isFinite(scale)) {
        window.__dprScale__ = 1 / scale;
        return window.__dprScale__;
      }
    } catch (e) {
    }
    window.__dprScale__ = 1;
    return window.__dprScale__;
  }
  function getNativeFontScale() {
    return getNativeFontScaleVar() * getScaleByDPR();
  }
  function getScaleByDom() {
    if (typeof document === 'undefined' || !document.body) {
      return 1;
    }
    var fontDom = document.createElement('div');
    fontDom.style.fontSize = '16px';
    document.body.appendChild(fontDom);
    var originFontSize = parseFloat(fontDom.style.fontSize);
    var realFontSize = parseFloat(window.getComputedStyle(fontDom, null).getPropertyValue('font-size'));
    document.body.removeChild(fontDom);
    var percent = realFontSize / originFontSize;
    if (!percent || percent  1000) {
        continue;
      }
      setPair[0].style.fontSize = "".concat(calculatedSize, "px");
      setPair[0].style.lineHeight = "".concat(setPair[2]);
    }
  }
  function limitFontSizePercent(el, maxPercent) {
    var nowFontScale = getScaleFromParent(el);
    var setPercent = Math.min(maxPercent, getNativeFontScale());
    if (isIPadOS13) {
      setFontSize(el, setPercent, nowFontScale);
    } else if (mmversion.isAndroid || mmversion.isHarmony) {
      setFontSize(el, setPercent, nowFontScale);
    } else if (mmversion.isIOS) {
      el.style.setProperty('-webkit-text-size-adjust', "".concat(Math.min(maxPercent, nowFontScale) * 100, "%"));
    }
  }
  function fixedFontSizePercent(el) {
    var nowFontScale = getScaleFromParent(el);
    var setPercent = 1;
    if (isIPadOS13) {
      setFontSize(el, setPercent, nowFontScale);
    } else if (mmversion.isAndroid) {
      setFontSize(el, setPercent, nowFontScale);
    } else if (mmversion.isIOS) {
      el.style.setProperty('-webkit-text-size-adjust', '100%');
    }
  }

  var key = 'stream_last_read_pos';
  new LS(key);
  var interactionStatusLS = new LS('bottom_interaction_status');
  function getInteractionStatus() {
    var opt = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};
    var biz = opt.biz || window.biz;
    var sn = opt.sn || window.sn;
    var mid = opt.mid || window.mid;
    var idx = opt.idx || window.idx;
    var interactionStatusKey = [biz, sn, mid, idx].join('_');
    var interactionStatusInfo = interactionStatusLS.get(interactionStatusKey) || {};
    if (Object.prototype.toString.call(interactionStatusInfo) !== '[object Object]' || window.cgiData && window.cgiData.trans_appmsg_info && window.cgiData.trans_appmsg_info.trans_type === 1
    ) {
      interactionStatusInfo = {};
    }
    var interactionSubscribeInfo = interactionStatusLS.get(biz + 'interaction_subscribe') || {};
    interactionStatusInfo.is_subscribed = interactionSubscribeInfo.is_subscribed || false;
    return interactionStatusInfo;
  }

  
  var ls = new LS('comment_bar_status');
  function articleKey() {
    var opt = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};
    var biz = opt.biz || window.biz;
    var sn = opt.sn || window.sn;
    var mid = opt.mid || window.mid;
    var idx = opt.idx || window.idx;
    return [biz, sn, mid, idx].join('_');
  }
  function isFinderMsg() {
    var _a, _b;
    return ((_b = (_a = window.cgiDataNew) === null || _a === void 0 ? void 0 : _a.trans_appmsg_info) === null || _b === void 0 ? void 0 : _b.trans_type) === 1;
  }
  
  function getCommentBarDirect() {
    var opt = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};
    var _a, _b, _c;
    var bar = (_c = (_b = (_a = window.cgiDataNew) === null || _a === void 0 ? void 0 : _a.user_info) === null || _b === void 0 ? void 0 : _b.appmsg_bar_data) !== null && _c !== void 0 ? _c : {};
    var barEnabled = bar.comment_enabled * 1 || 0;
    var barCount = bar.comment_count * 1 || 0;
    if (isFinderMsg()) {
      return {
        comment_enabled: barEnabled,
        comment_count: barCount
      };
    }
    var cached = ls.get(articleKey(opt)) || {};
    var comment_enabled = typeof cached.comment_enabled === 'number' ? cached.comment_enabled * 1 : barEnabled;
    var comment_count = cached.comment_count * 1 ? Math.max(cached.comment_count * 1, barCount) : barCount;
    return {
      comment_enabled: comment_enabled,
      comment_count: comment_count
    };
  }

  function textOverflow(el, binding) {
    var _a, _b;
    if (!el || getComputedStyle(el).display === 'none') return;
    var text = el.innerHTML;
    if (!text || !text.length) return;
    var retainTail = [];
    if ((_a = binding.value) === null || _a === void 0 ? void 0 : _a.tailNum) {
      retainTail = Array.from(el.childNodes).slice(-binding.value.tailNum);
    }
    var count = 0;
    function needTextOverflow() {
      var _a;
      if ((_a = binding.value) === null || _a === void 0 ? void 0 : _a.lineClamp) {
        return binding.value.lineClamp > 1;
          count++;
          range.setEndAfter(leaves[mid]);
          setNewFrag(el, getFragmentHTML(range.cloneContents()));
          return needTextOverflow() ? findLastNode(start, mid) : findLastNode(mid, end);
        };
        var findLastCharIndex = function findLastCharIndex(start, end) {
          if (end - start > 1;
          count++;
          range.setEnd(lastNode, mid);
          setNewFrag(el, getFragmentHTML(range.cloneContents()));
          return needTextOverflow() ? findLastCharIndex(start, mid) : findLastCharIndex(mid, end);
        };
        var dom = document.createElement('div');
        dom.innerHTML = text;
        var leaves = getLeaf(dom);
        var range = document.createRange();
        range.setStartBefore(leaves[0]);
        var lastNodeIndex = findLastNode(0, leaves.length - 1);
        var lastNode = leaves[lastNodeIndex];
        findLastCharIndex(0, lastNode.textContent.length);
        ((_b = binding.value) === null || _b === void 0 ? void 0 : _b.processExtraElement) && binding.value.processExtraElement(el.extraElement, el);
      } catch (error) {
        console.error(error);
      }
    }
  }
  function computeLineNum(el) {
    var computyStyle = getComputedStyle(el);
    return Math.round(el.offsetHeight / parseFloat(computyStyle.lineHeight));
  }
  function removeAllChild(el) {
    var childNodes = Array.from(el.childNodes);
    childNodes.forEach(function (child) {
      el.removeChild(child);
    });
  }
  function setNewFrag(el, frag) {
    removeAllChild(el);
    el.appendChild(frag);
  }

  
  var BOTTOM_BAR_GLASS_RADIUS = 36;
  var BOTTOM_BAR_GLASS_BOTTOM_GAP = 20;

  

  var DEFAULT_BAR_ROUND_HEAD_IMG = 'http://mmbiz.qpic.cn/mmbiz/a5icZrUmbV8p5jb6RZ8aYfjfS2AVle8URwBt8QIu6XbGewB9wiaWYWkPwq4R7pfdsFibuLkic16UcxDSNYtB8HnC1Q/0';
  function isBarAvatarCdnUrl(url) {
    if (!url || typeof url !== 'string') return false;
    var offline = typeof window !== 'undefined' && window.__offlineCacheScheme ? "".concat(window.__offlineCacheScheme, "://") : null;
    return url.indexOf('http://mmbiz.qpic.cn/') === 0 || url.indexOf('https://mmbiz.qpic.cn/') === 0 || offline && url.indexOf("".concat(offline, "mmbiz.qpic.cn/")) === 0 || url.indexOf('https://mmbiz.qlogo.cn/') === 0 || url.indexOf('http://mmbiz.qlogo.cn/') === 0 || offline && url.indexOf("".concat(offline, "mmbiz.qlogo.cn/")) === 0 || url.indexOf('http://res.wx.qq.com/') === 0 || url.indexOf('https://res.wx.qq.com/') === 0 || offline && url.indexOf("".concat(offline, "res.wx.qq.com/")) === 0 || url.indexOf('http://mmecoa.qpic.cn') === 0 || url.indexOf('https://mmecoa.qpic.cn') === 0 || offline && url.indexOf("".concat(offline, "mmecoa.qpic.cn")) === 0;
  }

  
  function resolveBarRoundHeadImg(barImg, topImg) {
    var defaultImg = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : DEFAULT_BAR_ROUND_HEAD_IMG;
    if (barImg && isBarAvatarCdnUrl(barImg)) return barImg;
    return topImg || defaultImg;
  }

  var __setBarData = function __setBarData(appmsgBarData, cgiData, allData) {
    if (Url.getQuery('uninteractive') * 1 === 1) return;
    var barWarp = document.querySelector('#js_article_bottom_bar');
    var barMask = document.querySelector('#js_temp_bar_mask');
    var barPlaceholder = document.querySelector('#js_bottom_bar_placeholder');
    var bottomBarGlass = document.querySelector('#js_temp_bottom_bar_glass');
    var isImageType = (cgiData === null || cgiData === void 0 ? void 0 : cgiData.item_show_type) * 1 === 8;
    try {
      if (isImageType) {
        var imgPagePosLS = new LS('page_pos_image', 'clear-all');
        var imgPagePosKey = [cgiData.biz, cgiData.sn, cgiData.mid, cgiData.idx].join('_');
        var _ref = imgPagePosLS.get(imgPagePosKey) || {},
          barPostion = _ref.barPostion,
          barIsRelativeStyle = _ref.barIsRelativeStyle;
        if (document.body.classList.contains('pages_skin_pc') || barPostion === 2 && barIsRelativeStyle) {
          window._has_not_render_bar_placeholder_ = true;
          return;
        }
      }
    } catch (err) {
      console.error(err);
    }
    if (window.__liquid_glass_status__) {
      if (barWarp) {
        barWarp.style.setProperty('--weui-ARTICLE-BOTTOM-BAR-BOTTOM-GAP', "".concat(BOTTOM_BAR_GLASS_BOTTOM_GAP, "px"));
      }
      if (bottomBarGlass) {
        bottomBarGlass.style.display = '';
        bottomBarGlass.style.setProperty('--weui-LIQUID-GLASS-RADIUS', "".concat(BOTTOM_BAR_GLASS_RADIUS, "px"));
      }
      var glassForeground = barPlaceholder && barPlaceholder.querySelector('.article_bottom_bar_glass_foreground');
      if (glassForeground && document.querySelector('#js_stream_friends_all')) {
        glassForeground.classList.add('has_friends_placeholder');
      }
    }
    var bottombar = document.getElementById('js_wx_follow_nickname_large_font');
    var fontScale = +Url.getQuery('fontScale');
    if (!fontScale) {
      try {
        var envData = JSON.parse(window.__wxWebEnv && window.__wxWebEnv.getEnv());
        if (envData.fontScale) fontScale = +envData.fontScale;
      } catch (e) {}
    }
    if (!appmsgBarData) {
      return;
    }
    function formatReadNum(value) {
      var unit = '万';
      if (window.LANG === 'en') {
        unit = 'k';
      }
      var result = '';
      if (parseInt(value, 10) > 100000) {
        result = 10 + unit + '+';
      } else if (parseInt(value, 10) > 10000 && parseInt(value, 10) = offsetWidth;
      } catch (e) {
        console.error('=======compute comment width error ', e);
      }
      var interactionStatus = cgiData.isFinderMsg ? {} : getInteractionStatus({
        biz: cgiData.biz,
        mid: cgiData.mid,
        sn: cgiData.sn,
        idx: cgiData.idx
      });
      var isAuthorWx = getIsAuthorLs(cgiData.biz, allData.biz_type);
      if (interactionStatus.is_my_old_like && !isAuthorWx) {
        oldLikeEl && oldLikeEl.classList.add('praised');
      }
      if (interactionStatus.is_my_like && !isAuthorWx) {
        likeEl && (appmsgBarData.show_friend_seen === 2 ? likeEl.classList.add('love_btn_loved') : likeEl.classList.add('like_btn_liked'));
      }
      var old_like_count = interactionStatus.old_like_count * 1 ? Math.max(interactionStatus.old_like_count * 1, appmsgBarData.old_like_count) : appmsgBarData.old_like_count || 0;
      var share_count = interactionStatus.share_count * 1 ? Math.max(interactionStatus.share_count * 1, appmsgBarData.share_count) : appmsgBarData.share_count || 0;
      var like_count = interactionStatus.like_count * 1 ? Math.max(interactionStatus.like_count * 1, appmsgBarData.like_count) : appmsgBarData.like_count || 0;
      var commentBar = getCommentBarDirect({
        biz: cgiData.biz,
        mid: cgiData.mid,
        sn: cgiData.sn,
        idx: cgiData.idx
      });
      var comment_count = commentBar.comment_count;
      var comment_enabled = commentBar.comment_enabled;
      var collect_count = appmsgBarData.collect_count || 0;
      var read_num = appmsgBarData.read_num || 0;
      if (barProfileHead) {
        var barImg = barProfileHead.getAttribute('src') || '';
        var topImg = (allData === null || allData === void 0 ? void 0 : allData.round_head_img) || '';
        var nextSrc = resolveBarRoundHeadImg(barImg, topImg);
        if (nextSrc && nextSrc !== barImg) {
          barProfileHead.setAttribute('src', nextSrc);
        }
      }
      if (barOldlikeBtn) {
        var defaultWd = isAuthorWx ? '0' : '赞';
        barOldlikeBtn.innerText = old_like_count ? formatReadNum(old_like_count) : defaultWd;
      }
      if (barShareBtn) {
        var _defaultWd = isAuthorWx ? '0' : '分享';
        barShareBtn.innerText = share_count ? formatReadNum(share_count) : _defaultWd;
      }
      if (barLikeBtn) {
        var _defaultWd2 = isAuthorWx ? '0' : allData && allData.red_flower_like_info && allData.red_flower_like_info.is_red_flower_like * 1 === 1 ? '助力' : '推荐';
        barLikeBtn.innerText = like_count ? formatReadNum(like_count) : _defaultWd2;
      }
      if (barCommentBtn) {
        var _defaultWd3 = isAuthorWx ? '0' : isChanegeCommentBtnContext ? '留言' : '写留言';
        barCommentBtn.innerText = comment_count ? formatReadNum(comment_count) : _defaultWd3;
      }
      if (barCollectBtn) {
        var _defaultWd4 = isAuthorWx ? '0' : '收藏';
        barCollectBtn.innerText = collect_count ? formatReadNum(collect_count) : _defaultWd4;
      }
      if (mmversion.isInMiniProgram) {
        if (barShareBtn) {
          barShareBtn.style.display = 'none';
        }
        if (barLikeBtn) {
          barLikeBtn.style.display = 'none';
        }
      }
      var tempbarPraiseBtn = document.getElementById('js_temp_sns_sc_praise_btn');
      var tempbarShareBtn = document.getElementById('js_temp_sns_sc_share_btn');
      var tempbarCollectBtn = document.getElementById('js_temp_sns_sc_collect_btn');
      var tempbarLikeBtn = document.getElementById('js_temp_sns_sc_like_btn');
      var tempbarCommentBtn = document.getElementById('js_temp_sns_sc_comment_btn');
      var tempbarCommentBtnCon = document.getElementById('js_temp_sns_sc_comment_btn_con');
      var tempbarFriendSubscribe = document.getElementById('js_bar_friend_subscribe');
      var tempbarSubscribeBtn = document.getElementById('js_temp_bar_subscribe_btn');
      var tempbarFriendsList = document.getElementById('js_stream_friends_all');
      var tempLoadingInnerHtml = '';
      var handleTempClick = function handleTempClick(_ref2) {
        var type = _ref2.type,
          val = _ref2.val,
          sucCb = _ref2.sucCb,
          failCb = _ref2.failCb;
        if (typeof window.__click_temp_btm_bar_cb__ === 'function') {
          window.__click_temp_btm_bar_cb__({
            type: type,
            val: val,
            sucCb: sucCb,
            failCb: failCb
          });
        } else {
          if (!window.__wait_click_temp_btm_bar_cb__) window.__wait_click_temp_btm_bar_cb__ = [];
          window.__wait_click_temp_btm_bar_cb__.push(function () {
            window.__click_temp_btm_bar_cb__({
              type: type,
              val: val,
              sucCb: sucCb,
              failCb: failCb
            });
          });
        }
      };
      if (isAuthorWx) {
        tempbarPraiseBtn && tempbarPraiseBtn.classList.add('author_praise_btn');
        tempbarLikeBtn && tempbarLikeBtn.classList.add('author_love_btn');
        tempbarFriendSubscribe && (tempbarFriendSubscribe.style.display = 'none');
        tempbarSubscribeBtn && (tempbarSubscribeBtn.style.display = 'none');
        tempbarFriendsList && (tempbarFriendsList.style.display = 'none');
      }
      if (interactionStatus && interactionStatus.is_subscribed) {
        tempbarFriendSubscribe && (tempbarFriendSubscribe.style.display = 'none');
        tempbarSubscribeBtn && (tempbarSubscribeBtn.style.display = 'none');
      }
      tempbarPraiseBtn && barOldlikeBtn && oldLikeEl && tempbarPraiseBtn.addEventListener('click', function () {
        if (mmversion.isMpapp) return;
        if (isAuthorWx) {
          if (tempbarPraiseBtn.getAttribute('has_click') * 1 === 1) return;
          tempbarPraiseBtn.setAttribute('has_click', 1);
          var tempInnerHTML = tempbarPraiseBtn.innerHTML;
          tempbarPraiseBtn.innerHTML = tempLoadingInnerHtml;
          handleTempClick({
            type: 'author_praise',
            sucCb: function sucCb() {
              tempbarPraiseBtn.removeAttribute('has_click');
              tempbarPraiseBtn.innerHTML = tempInnerHTML;
            }
          });
          return;
        }
        var newPraiseStatus = !oldLikeEl.classList.contains('praised');
        var readNum = 0;
        if (newPraiseStatus) {
          oldLikeEl.classList.add('praised');
          readNum = formatReadNum(interactionStatus.is_my_old_like ? old_like_count : old_like_count + 1);
        } else {
          oldLikeEl.classList.remove('praised');
          readNum = formatReadNum(interactionStatus.is_my_old_like ? Math.max(0, old_like_count - 1) : old_like_count);
        }
        barOldlikeBtn.innerText = readNum ? readNum : '赞';
        handleTempClick({
          type: 'praise',
          val: newPraiseStatus
        });
      });
      tempbarLikeBtn && barLikeBtn && likeEl && tempbarLikeBtn.addEventListener('click', function () {
        if (mmversion.isMpapp) return;
        if (isAuthorWx) {
          if (tempbarLikeBtn.getAttribute('has_click') * 1 === 1) return;
          tempbarLikeBtn.setAttribute('has_click', 1);
          var tempInnerHTML = tempbarLikeBtn.innerHTML;
          tempbarLikeBtn.innerHTML = tempLoadingInnerHtml;
          handleTempClick({
            type: 'author_recommend',
            sucCb: function sucCb() {
              tempbarLikeBtn.removeAttribute('has_click');
              tempbarLikeBtn.innerHTML = tempInnerHTML;
            }
          });
          return;
        }
        var newRecommendStatus = appmsgBarData.show_friend_seen === 2 ? !likeEl.classList.contains('love_btn_loved') : !likeEl.classList.contains('like_btn_liked');
        var recommendNum = 0;
        if (newRecommendStatus) {
          appmsgBarData.show_friend_seen === 2 ? likeEl.classList.add('love_btn_loved') : likeEl.classList.add('like_btn_liked');
          recommendNum = formatReadNum(interactionStatus.is_my_like ? like_count : like_count + 1);
        } else {
          appmsgBarData.show_friend_seen === 2 ? likeEl.classList.remove('love_btn_loved') : likeEl.classList.remove('like_btn_liked');
          recommendNum = formatReadNum(interactionStatus.is_my_like ? Math.max(0, like_count - 1) : like_count);
        }
        if (recommendNum) {
          barLikeBtn.innerText = recommendNum;
        } else {
          barLikeBtn.innerText = appmsgBarData.show_friend_seen === 2 ? '推荐' : '在看';
        }
        handleTempClick({
          type: 'recommend',
          val: newRecommendStatus
        });
      });
      tempbarShareBtn && barShareBtn && tempbarShareBtn.addEventListener('click', function () {
        if (mmversion.isMpapp) return;
        if (tempbarShareBtn.getAttribute('has_click') * 1 === 1) return;
        tempbarShareBtn.setAttribute('has_click', 1);
        var tempInnerHTML = tempbarShareBtn.innerHTML;
        tempbarShareBtn.innerHTML = tempLoadingInnerHtml;
        handleTempClick({
          type: 'share',
          sucCb: function sucCb() {
            tempbarShareBtn.removeAttribute('has_click');
            tempbarShareBtn.innerHTML = tempInnerHTML;
          }
        });
      });
      tempbarCommentBtn && barCommentBtn && tempbarCommentBtn.addEventListener('click', function () {
        if (barCommentBtn.getAttribute('has_click') * 1 === 1) return;
        barCommentBtn.setAttribute('has_click', 1);
        var tempInnerHTML = barCommentBtn.innerHTML;
        barCommentBtn.innerHTML = tempLoadingInnerHtml;
        handleTempClick({
          type: 'comment',
          sucCb: function sucCb() {
            barCommentBtn.removeAttribute('has_click');
            barCommentBtn.innerHTML = tempInnerHTML;
          }
        });
      });
      tempbarCollectBtn && barCollectBtn && tempbarCollectBtn.addEventListener('click', function () {
        handleTempClick({
          type: 'collect'
        });
      });
      barSubscribeBtn && barSubscribeBtn.addEventListener('click', function () {
        handleTempClick({
          type: 'subscribe'
        });
      });
      if (comment_enabled || isAuthorWx && (comment_enabled * 1 === 0 || comment_count > 0)) {
        tempbarCommentBtnCon && (tempbarCommentBtnCon.style.display = '');
        if (isAuthorWx && comment_enabled * 1 === 0) {
          tempbarCommentBtn.classList.add('sns_sc_lock_comment_btn');
        }
      }
    } catch (error) {
      console.error(error);
    }
    try {
      try {
        var interactionBar = document.querySelectorAll('.interaction_bar_placeholder');
        var buttons = document.querySelectorAll('.wx_follow_button_placeholder');
        var fixedElements = _toConsumableArray(buttons);
        var maxSize = 1.24;
        var maxSizeElements = _toConsumableArray(interactionBar);
        for (var i = 0; i = 116) {
        var bigBar = document.querySelector('.js_big_font_size_bottom_bar');
        var normalBar = document.querySelector('.js_normal_font_size_bottom_bar');
        var normalBarFt = document.querySelector('.js_normal_font_size_bottom_bar_ft');
        if (normalBar) normalBar.style.display = 'none';
        if (normalBarFt) normalBarFt.style.display = 'none';
        if (bigBar) bigBar.style.display = 'block';
        var bigTopBar = document.querySelector('.js_big_font_size_top_bar');
        var normalTopBar = document.querySelector('.js_normal_font_size_top_bar');
        var normalTopBarFt = document.querySelector('.js_normal_font_size_top_bar_ft');
        if (normalTopBar) normalTopBar.style.display = 'none';
        if (normalTopBarFt) normalTopBarFt.style.display = 'none';
        if (bigTopBar) bigTopBar.style.display = 'block';
        var js_bar_profile = document.getElementById('js_bar_profile');
        js_bar_profile && js_bar_profile.classList.add('large_font_like_profile_bar');
        var topbar = document.getElementById('js_wx_follow_nickname_large_font_top');
        var topNickNameSpans = document.querySelectorAll('.js_big_font_size_top_bar .nickNameSpan');
        var bottomFollowFt = document.querySelectorAll('.js_big_font_size_bottom_bar .wx_follow_ft');
        var topFollowFt = document.querySelectorAll('.js_big_font_size_top_bar .wx_follow_ft');
        [].concat(_toConsumableArray(topNickNameSpans), _toConsumableArray(bottomFollowFt), _toConsumableArray(topFollowFt)).forEach(function (element) {
          fixedFontSizePercent(element);
        });
        if (bottombar) {
          textOverflow(bottombar, {
            value: {
              lineClamp: 2,
              tailNum: 3
            }
          });
        }
        if (topbar) {
          textOverflow(topbar, {
            value: {
              lineClamp: 1,
              tailNum: 2
            }
          });
        }
      } else {
        var _bigBar = document.querySelector('.js_big_font_size_bottom_bar');
        var _normalBar = document.querySelector('.js_normal_font_size_bottom_bar');
        var _normalBarFt = document.querySelector('.js_normal_font_size_bottom_bar_ft');
        if (_bigBar) _bigBar.style.display = 'none';
        if (_normalBar) _normalBar.style.display = 'block';
        if (_normalBarFt) _normalBarFt.style.display = 'block';
        var _bigTopBar = document.querySelector('.js_big_font_size_top_bar');
        var _normalTopBar = document.querySelector('.js_normal_font_size_top_bar');
        var _normalTopBarFt = document.querySelector('.js_normal_font_size_top_bar_ft');
        if (_bigTopBar) _bigTopBar.style.display = 'none';
        if (_normalTopBar) _normalTopBar.style.display = 'block';
        if (_normalTopBarFt) _normalTopBarFt.style.display = 'block';
        var normalNickname = document.getElementById('js_wx_follow_nickname_small_font');
        if (normalNickname) {
          var applyTextOverflow = function applyTextOverflow() {
            textOverflow(normalNickname, {
              value: {
                lineClamp: 1,
                tailNum: 2
              }
            });
          };
          if (Device.os.pc) {
            setTimeout(applyTextOverflow, 0);
          } else {
            applyTextOverflow();
          }
        }
      }
    } catch (error) {
      console.error('set like_profile style error', error);
    }
    barWarp && barWarp.classList.remove('hide');
    barMask && barMask.classList.remove('hide');
  };
  if (!window.__second_open__) {
    var tmpAppmsgBarData = {
      show_like: '' * 1,
      like_count: '' * 1,
      show_share: '' * 1,
      share_count: '' * 1,
      show_old_like: '' * 1,
      old_like_count: '' * 1,
      comment_enabled: '' * 1,
      comment_count: '' * 1,
      show_collect: '' * 1,
      collect_count: '' * 1,
      show_friend_seen: '' * 1,
      is_subscribed: '' * 1,
      verify_status: '' * 1,
      original_content_num: '$user_info.appmsg_bar_data.original_content_num.DATA$' * 1,
      friend_subscribe_count: '' * 1,
      read_num: '' * 1
    };
    var cgiData = {
      idx: ''  ,
      biz: '' ,
      mid: ''  ,
      sn: ''  ,
      subcount_version: '',
      isFinderMsg: '' * 1,
      export_id: '',
      source: '' * 1,
      item_show_type: '0' * 1,
      ori_create_time: '1792106935' * 1
    };
    __setBarData(tmpAppmsgBarData, cgiData, cgiDataNew);
    window.__setBarData = __setBarData;
  }

  return __setBarData;

})();var __INLINE_SCRIPT__ = (function () {
  'use strict';

  function _typeof(obj) {
    "@babel/helpers - typeof";

    return _typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (obj) {
      return typeof obj;
    } : function (obj) {
      return obj && "function" == typeof Symbol && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj;
    }, _typeof(obj);
  }

  function _toPrimitive(input, hint) {
    if (_typeof(input) !== "object" || input === null) return input;
    var prim = input[Symbol.toPrimitive];
    if (prim !== undefined) {
      var res = prim.call(input, hint || "default");
      if (_typeof(res) !== "object") return res;
      throw new TypeError("@@toPrimitive must return a primitive value.");
    }
    return (hint === "string" ? String : Number)(input);
  }

  function _toPropertyKey(arg) {
    var key = _toPrimitive(arg, "string");
    return _typeof(key) === "symbol" ? key : String(key);
  }

  function _defineProperty(obj, key, value) {
    key = _toPropertyKey(key);
    if (key in obj) {
      Object.defineProperty(obj, key, {
        value: value,
        enumerable: true,
        configurable: true,
        writable: true
      });
    } else {
      obj[key] = value;
    }
    return obj;
  }

  function _classCallCheck(instance, Constructor) {
    if (!(instance instanceof Constructor)) {
      throw new TypeError("Cannot call a class as a function");
    }
  }

  function _defineProperties(target, props) {
    for (var i = 0; i  d2.exp) return 1;
        return 0;
      });
      var memCnt = 0;
      for (var i = 0; i = size) break;
        var key = keys[i];
        memCnt += JSON.stringify(data[key]).length;
        delete data[key];
      }
      return data;
    },
    'clear-all': function clearAll() {
      localStorage.clear();
      return {};
    }
  };
  function formatLogMsg(str) {
    return "[WXLS] ".concat(str);
  }
  
  var LS = function () {
    function LS(func, evictionPolicy, logger) {
      _classCallCheck(this, LS);
      this.logger = function () {};
      if (!func) throw 'require function name.';
      this.evictionPolicy = 'noeviction';
      this.key = func;
      if (typeof logger === 'function') {
        this.logger = function (str, type) {
          return logger(formatLogMsg(str), type);
        };
      }
      if (evictionPolicy && Object.keys(evictionPolicies).indexOf(evictionPolicy) !== -1) {
        this.evictionPolicy = evictionPolicy;
      }
      this.init();
    }
    _createClass(LS, [{
      key: "init",
      value: function init() {
        var _a, _b;
        this.check();
        if (Math.random() * 1000  now) {
            temp[key] = val;
          }
        }
        this.logger("check info: isReturn:".concat(isReturn, " data:").concat(JSON.stringify(temp)), 'info');
        if (isReturn) return temp;
        LS.setItem(this.key, JSON.stringify(temp), this.logger);
      }
    }, {
      key: "set",
      value: function set(key, val, exp) {
        var _a, _b;
        var data = this.check(true);
        data[key] = {
          val: val,
          exp: exp || +new Date()
        };
        try {
          if (localStorage.getItem(prefix + this.key)) localStorage.removeItem(prefix + this.key);
          localStorage.setItem(prefix + this.key, JSON.stringify(data));
          this.logger("first set success: LSlen:".concat((_a = window === null || window === void 0 ? void 0 : window.localStorage) === null || _a === void 0 ? void 0 : _a.length, " key:").concat(prefix + this.key, " data:").concat(JSON.stringify(data)), 'success');
        } catch (e) {
          this.logger("first set error: LSlen:".concat((_b = window === null || window === void 0 ? void 0 : window.localStorage) === null || _b === void 0 ? void 0 : _b.length, " error:").concat(e, " key:").concat(prefix + this.key, " data:").concat(JSON.stringify(data), " k:").concat(key, " v:").concat(val, " exp:").concat(exp), 'error');
          localStorage.clear();
          LS.setItem(this.key, JSON.stringify(_defineProperty({}, key, {
            val: val,
            exp: exp || +new Date()
          })), this.logger);
        }
      }
    }, {
      key: "get",
      value: function get(key) {
        var data = this.getData();
        data = data[key];
        return data ? data.val || null : null;
      }
    }, {
      key: "remove",
      value: function remove(key) {
        var data = this.getData();
        if (data[key]) delete data[key];
        LS.setItem(this.key, JSON.stringify(data), this.logger);
      }
    }], [{
      key: "getItem",
      value: function getItem(key) {
        key = prefix + key;
        return localStorage.getItem(key);
      }
    }, {
      key: "setItem",
      value: function setItem(key, val, logger) {
        var _a, _b;
        key = prefix + key;
        var n = 3;
        while (n--) {
          try {
            if (localStorage.getItem(key)) localStorage.removeItem(key);
            localStorage.setItem(key, val);
            typeof logger === 'function' && logger("setItem success: LSlen:".concat((_a = window === null || window === void 0 ? void 0 : window.localStorage) === null || _a === void 0 ? void 0 : _a.length, " key:").concat(key, " val:").concat(val), 'success');
            break;
          } catch (e) {
            typeof logger === 'function' && logger("setItem error: LSlen:".concat((_b = window === null || window === void 0 ? void 0 : window.localStorage) === null || _b === void 0 ? void 0 : _b.length, " error:").concat(e, " key:").concat(key, " val:").concat(val), 'error');
            LS.clear();
          }
        }
      }
    }, {
      key: "clear",
      value: function clear() {
        var i;
        var k;
        for (i = localStorage.length - 1; i >= 0; i--) {
          k = localStorage.key(i);
          if (k.indexOf(prefix) == 0) {
            localStorage.removeItem(k);
          }
        }
      }
    }, {
      key: "getSupportEvicationPolicy",
      value: function getSupportEvicationPolicy() {
        return Object.keys(evictionPolicies);
      }
    }]);
    return LS;
  }();

  var rewardLS = new LS('reward');
  var rewardLSData = null;
  function getRewardLS() {
    var opt = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};
    rewardLSData === null && (rewardLSData = rewardLS.get([opt.biz || window.biz, opt.mid || window.mid, opt.idx || window.idx].join('_')));
    return rewardLSData;
  }

  
  var __setReward = function __setReward(cgiData, opt) {
    var data = getRewardLS(opt);
    if (data) {
      data.canReward !== undefined && (cgiData.can_reward = data.canReward);
      data.isNeedReward !== undefined && (cgiData.is_need_reward = data.isNeedReward);
      if (data.closeReward !== undefined) {
        if (cgiData.user_info) {
          cgiData.user_info.close_reward = data.closeReward;
        } else {
          cgiData.user_info = {
            close_reward: data.closeReward
          };
        }
      }
      data.authorId !== undefined && (cgiData.author_id = data.authorId);
      data.rewardAuthorHead !== undefined && (cgiData.reward_author_head = data.rewardAuthorHead);
      data.author !== undefined && (cgiData.author = data.author);
      data.rewardWording !== undefined && (cgiData.reward_wording = data.rewardWording);
    }
  };
  if (!window.__second_open__) {
    var data = getRewardLS();
    if (data) {
      if (window.cgiData) {
        data.canReward !== undefined && (window.cgiData.can_reward = data.canReward);
        data.isNeedReward !== undefined && (window.cgiData.is_need_reward = data.isNeedReward);
        data.authorId !== undefined && (window.cgiData.author_id = data.authorId);
        data.rewardAuthorHead !== undefined && (window.cgiData.reward_author_head = data.rewardAuthorHead);
        data.author !== undefined && (window.cgiData.author = data.author);
        data.rewardWording !== undefined && (window.cgiData.reward_wording = data.rewardWording);
      } else {
        data.canReward !== undefined && (window.can_reward = data.canReward);
        data.isNeedReward !== undefined && (window.is_need_reward = data.isNeedReward);
        data.authorId !== undefined && (window.author_id = data.authorId);
        data.rewardAuthorHead !== undefined && (window.reward_author_head = data.rewardAuthorHead);
        data.author !== undefined && (window.author = data.author);
        data.rewardWording !== undefined && (window.reward_wording = data.rewardWording);
      }
      data.canReward !== undefined && (window.cgiDataNew.can_reward = data.canReward);
      if (data.closeReward !== undefined) {
        if (window.cgiDataNew.user_info) {
          window.cgiDataNew.user_info.close_reward = data.closeReward;
        } else {
          window.cgiDataNew.user_info = {
            close_reward: data.closeReward
          };
        }
      }
    }
  }

  return __setReward;

})();(function () {
  'use strict';

  function _arrayLikeToArray(arr, len) {
    if (len == null || len > arr.length) len = arr.length;
    for (var i = 0, arr2 = new Array(len); i var __INLINE_SCRIPT__ = (function () {
  'use strict';

  

  

  var EMOJI_BLANK_IMG = 'https://res.wx.qq.com/mmbizappmsg/zh_CN/images/pic/pic_blank.gif';
  var identityFormat = function identityFormat(text) {
    return text;
  };
  var __setEmojiFormat = function __setEmojiFormat() {
    if (typeof window.__emojiFormat === 'function' && window.__emojiFormat !== identityFormat) return;
    if (!window.weEmoji) {
      window.__emojiFormat = identityFormat;
      return;
    }
    var emoji_wx_icon = '';
    var dataMap = window.weEmoji.EmojiDataMap;
    try {
      var replaceRegex = new RegExp(Object.keys(dataMap).map(function (str) {
        return str.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
      }).sort(function (a, b) {
        return b.length - a.length;
      }).join('|'), 'g');
      window.__emojiFormat = function (text) {
        if (!replaceRegex.test(text)) {
          return text;
        }
        return text.replace(replaceRegex, function (match) {
          if (dataMap[match] && window.weEmoji.EmojiData[dataMap[match].index]) {
            var data = window.weEmoji.EmojiData[dataMap[match].index];
            return emoji_wx_icon.replace('#name#', match).replace('#style#', data.style + ' we-emoji');
          }
          return match;
        });
      };
    } catch (e) {
      window.__emojiFormat = identityFormat;
    }
  };
  if (!window.__second_open__) {
    __setEmojiFormat();
  }

  return __setEmojiFormat;

})();var __INLINE_SCRIPT__ = (function () {
  'use strict';

  function _typeof(obj) {
    "@babel/helpers - typeof";

    return _typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (obj) {
      return typeof obj;
    } : function (obj) {
      return obj && "function" == typeof Symbol && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj;
    }, _typeof(obj);
  }

  function _arrayWithHoles(arr) {
    if (Array.isArray(arr)) return arr;
  }

  function _iterableToArrayLimit(arr, i) {
    var _i = null == arr ? null : "undefined" != typeof Symbol && arr[Symbol.iterator] || arr["@@iterator"];
    if (null != _i) {
      var _s,
        _e,
        _x,
        _r,
        _arr = [],
        _n = !0,
        _d = !1;
      try {
        if (_x = (_i = _i.call(arr)).next, 0 === i) {
          if (Object(_i) !== _i) return;
          _n = !1;
        } else for (; !(_n = (_s = _x.call(_i)).done) && (_arr.push(_s.value), _arr.length !== i); _n = !0);
      } catch (err) {
        _d = !0, _e = err;
      } finally {
        try {
          if (!_n && null != _i["return"] && (_r = _i["return"](), Object(_r) !== _r)) return;
        } finally {
          if (_d) throw _e;
        }
      }
      return _arr;
    }
  }

  function _arrayLikeToArray$1(arr, len) {
    if (len == null || len > arr.length) len = arr.length;
    for (var i = 0, arr2 = new Array(len); i  -1) && (vie = 7);
      (window.XDomainRequest || ua.indexOf('Trident/4.0') > -1) && (vie = 8);
      ua.indexOf('Trident/5.0') > -1 && (vie = 9);
      ua.indexOf('Trident/6.0') > -1 && (vie = 10);
      Device.browser.ie = true, Device.browser.version = vie;
    } else if (ua.indexOf('Trident/7.0') > -1) {
      Device.browser.ie = true, Device.browser.version = 11;
    }
    if (android) {
      Device.os.android = true;
      Device.os.version = android[2];
      Device.os.type = 2;
    }
    if (harmony) {
      Device.os.harmony = true;
      Device.os.version = harmony[2];
      Device.os.type = 42;
    }
    if (ipod) {
      Device.os.ios = Device.os.ipod = true;
      Device.os.version = ipod[2].replace(/_/g, '.');
    }
    if (ipad) {
      Device.os.ios = Device.os.ipad = true;
      Device.os.version = ipad[2].replace(/_/g, '.');
      Device.os.type = 13;
    }
    if (iphone) {
      Device.os.iphone = Device.os.ios = true;
      Device.os.version = iphone[2].replace(/_/g, '.');
      Device.os.type = 1;
    }
    if (WinOS) Device.os.windows = true, Device.os.version = WinOS[2], Device.os.type = 15;
    if (MacOS) Device.os.Mac = true, Device.os.version = MacOS[1], Device.os.type = 14;
    if (Linux) Device.os.Linux = true, Device.os.type = 33;
    if (ua.indexOf('lepad_hls') > 0) Device.os.LePad = true;
    if (MIPAD) Device.os.MIPAD = true;
    if (MQQBrowser) Device.browser.MQQ = true, Device.browser.version = MQQBrowser[1];
    if (MQQClient) Device.browser.MQQClient = true, Device.browser.version = MQQClient[1];
    if (WeChat) Device.browser.WeChat = true, Device.browser.mmversion = Device.browser.version = WeChat[1];
    if (MiuiBrowser) Device.browser.MIUI = true, Device.browser.version = MiuiBrowser[1];
    if (UC) Device.browser.UC = true, Device.browser.version = UC[1] || NaN;
    if (IEMobile) Device.browser.IEMobile = true, Device.browser.version = IEMobile[2];
    if (AndriodBrowser) {
      Device.browser.AndriodBrowser = true;
    }
    if (M1) {
      Device.browser.M1 = true;
    }
    if (Chrome) {
      Device.browser.Chrome = true, Device.browser.version = Chrome[1];
    }
    if (Device.os.windows) {
      if (typeof navigator.platform !== "undefined" && navigator.platform.toLowerCase() == "win64") {
        Device.os.win64 = true;
      } else {
        Device.os.win64 = false;
      }
    }
    if (Device.os.Mac || Device.os.windows || Device.os.Linux || Device.os.unifiedPC || /OpenHarmony/i.test(ua) && /pc/i.test(ua)) {
      Device.os.pc = true;
    }
    var osType = {
      iPad7: 'iPad; CPU OS 7',
      LePad: 'lepad_hls',
      XiaoMi: 'MI-ONE',
      SonyDTV: "SonyDTV",
      SamSung: 'SAMSUNG',
      HTC: 'HTC',
      VIVO: 'vivo'
    };
    for (var os in osType) {
      Device.os[os] = ua.indexOf(osType[os]) !== -1;
    }
    Device.os.phone = Device.os.phone || /windows phone/i.test(ua);
    Device.os.getNumVersion = function () {
      return parseFloat(Device.os.version);
    };
    Device.os.hasTouch = 'ontouchstart' in window;
    if (Device.os.hasTouch && Device.os.ios && Device.os.getNumVersion() = 3.0;
    };
    Device.browser.isCanOcx = function () {
      return !!Device.os.windows && (!!Device.browser.ie || Device.browser.isFFCanOcx() || !!Device.browser.webkit);
    };
    Device.browser.isNotIESupport = function () {
      return !!Device.os.windows && (!!Device.browser.webkit || Device.browser.isFFCanOcx());
    };
    Device.userAgent = {};
    Device.userAgent.browserVersion = Device.browser.version;
    Device.userAgent.osVersion = Device.os.version;
    if (Device.os.unifiedPC) {
      if (Device.os.unifiedWindows) Device.os.type = 37;else if (Device.os.unifiedMac) Device.os.type = 38;else Device.os.type = 39;
    }
    delete Device.userAgent.version;
  }
  detect(window.navigator.userAgent);
  function canSupportH5Video() {
    var ua = window.navigator.userAgent,
      m = null;
    if (!!Device.os.android) {
      if (Device.browser.MQQ && Device.browser.getNumVersion() >= 4.2) {
        return true;
      }
      if (ua.indexOf('MI2') != -1) {
        return true;
      }
      if (Device.os.version >= '4' && (m = ua.match(/MicroMessenger\/((\d+)\.(\d+))\.(\d+)/))) {
        if (parseFloat(m[1]) >= 4.2) {
          return true;
        }
      }
      if (Device.os.version >= '4.1') {
        return true;
      }
    }
    return false;
  }
  function canSupportVideoMp4() {
    var video = document.createElement('video');
    if (typeof video.canPlayType === 'function') {
      if (video.canPlayType('video/mp4; codecs="mp4v.20.8"') === 'probably') {
        return true;
      }
      if (video.canPlayType('video/mp4; codecs="avc1.42E01E"') === 'probably' || video.canPlayType('video/mp4; codecs="avc1.42E01E, mp4a.40.2"') === 'probably') {
        return true;
      }
    }
    return false;
  }
  function canSupportAutoPlay() {
    if (Device.os.ios && Device.os.getNumVersion()  1 && arguments[1] !== undefined ? arguments[1] : 0;
    var canEqual = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : false;
    var nowVersionStr = Device.os.version;
    if (!nowVersionStr) return false;
    var versionArr = version.split('.');
    var nowVersionArr = nowVersionStr.split('.');
    for (var i = 0; i  0) return vi > nvi;
      if (cp = o.length) return { done: true }; return { done: false, value: o[i++] }; }, e: function e(_e) { throw _e; }, f: F }; } throw new TypeError("Invalid attempt to iterate non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); } var normalCompletion = true, didErr = false, err; return { s: function s() { it = it.call(o); }, n: function n() { var step = it.next(); normalCompletion = step.done; return step; }, e: function e(_e2) { didErr = true; err = _e2; }, f: function f() { try { if (!normalCompletion && it["return"] != null) it["return"](); } finally { if (didErr) throw err; } } }; }
  function _unsupportedIterableToArray(o, minLen) { if (!o) return; if (typeof o === "string") return _arrayLikeToArray(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === "Object" && o.constructor) n = o.constructor.name; if (n === "Map" || n === "Set") return Array.from(o); if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen); }
  function _arrayLikeToArray(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i  b;
    }
  };
  function cpVersion(ver, op, canEq, type) {
    var mmver = false;
    switch (type) {
      case 'mac':
        mmver = getMac();
        break;
      case 'windows':
        mmver = getWindowsVersionFormat();
        break;
      case 'wxwork':
        mmver = getWxWork();
        break;
      case 'mpapp':
        mmver = getMpApp();
        break;
      case 'unifiedpc':
        mmver = getUnifiedPcVer();
        break;
      default:
        mmver = get();
        break;
    }
    if (!mmver) {
      return;
    }
    var mmversion = mmver.split('.');
    var version = ver.split('.');
    if (!/\d+/g.test(mmversion[mmversion.length - 1])) {
      mmversion.pop();
    }
    for (var i = 0, len = Math.max(mmversion.length, version.length); i = 64 && parseInt(v) = hexNum;
    }
    return false;
  }
  var mmversion = {
    get: get,
    getMac: getMac,
    getMacOS: getMacOS,
    getWindows: getWindows,
    getInner: getInner,
    getWxWork: getWxWork,
    getMpApp: getMpApp,
    cpVersion: cpVersion,
    eqVersion: eqVersion,
    gtVersion: gtVersion,
    ltVersion: ltVersion,
    getPlatform: getPlatform,
    getVersionNumber: getVersionNumber,
    isWp: is_wp,
    isIOS: is_ios,
    isAndroid: is_android$1,
    isHarmony: is_harmony,
    isHarmonyWechat: is_harmony && is_wechat && cpVersion('1.0.0', 1, true),
    isInMiniProgram: is_in_miniProgram,
    isWechat: is_wechat,
    isMac: is_mac,
    isWindows: is_windows,
    isLinux: is_linux,
    isMacWechat: is_mac_wechat,
    isWindowsWechat: is_windows_wechat,
    isWxWork: is_wx_work,
    isOnlyWechat: is_wechat && !is_wx_work,
    isMpapp: is_mpapp,
    isIPad: is_ipad,
    isGooglePlay: is_google_play,
    isPrefetch: is_prefetch,
    isDonutAPP: is_donut_app,
    compareHexVersion: compareHexVersion,
    isPcWechat: is_windows_wechat || is_mac_wechat,
    xwebVersion: xweb_version,
    isUnifiedPcWechat: is_unified_pc_wechat
  };

  var initJsBridge = false;
  if (!window.JSAPIEventCallbackMap) {
    window.JSAPIEventCallbackMap = {};
  }
  function connectWebViewJavascriptBridge(callback) {
    if (window.WebViewMPapp || window.WebViewJavascriptBridge) {
      return callback(window.WebViewMPapp || window.WebViewJavascriptBridge);
    }
    if (window.WVJBCallbacks) {
      return window.WVJBCallbacks.push(callback);
    }
    window.WVJBCallbacks = [callback];
    if (!mmversion.isMpapp) {
      return false;
    }
    if (!initJsBridge) {
      initJsBridge = true;
      var WVJBIframe = document.createElement('iframe');
      WVJBIframe.style.display = 'none';
      WVJBIframe.src = 'https://__bridge_loaded__';
      document.body.appendChild(WVJBIframe);
      setTimeout(function () {
        initJsBridge = false;
        document.body.removeChild(WVJBIframe);
      }, 0);
    }
    return false;
  }
  function invoke$1(jsapiName, opt, callback) {
    connectWebViewJavascriptBridge(function (bridge) {
      try {
        if (typeof opt === 'function') {
          callback = opt;
        }
        if (_typeof(opt) !== 'object' && typeof opt !== 'string') {
          opt = {};
        }
        bridge.callHandler(jsapiName, opt, function (res) {
          try {
            var ret = _typeof(res) === 'object' ? res : JSON.parse(res);
            var errMsg = ret.err_msg || ret.errMsg;
            console.info("[mpapp jsapi] invoke->".concat(jsapiName, " ").concat(opt.action || '', " ").concat(errMsg));
            typeof callback === 'function' && callback(ret);
          } catch (e) {
            window.WX_BJ_REPORT.BadJs.report('invoke', "callback ".concat(jsapiName, " error:"), {
              mid: 'mmbizwebapp:js_brridge',
              _info: e
            });
            console.error("[mpapp jsapi] ".concat(jsapiName, " ").concat(opt.action || ''), e, res);
          }
        });
      } catch (e) {
        window.WX_BJ_REPORT.BadJs.report('invoke', 'callback error:', {
          mid: 'mmbizwebapp:js_brridge',
          _info: e
        });
        console.error('[mpapp jsapi]', e);
      }
    });
  }
  function on$2(eventName, callback) {
    connectWebViewJavascriptBridge(function (bridge) {
      if (!window.JSAPIEventCallbackMap[eventName]) {
        window.JSAPIEventCallbackMap[eventName] = [];
      }
      window.JSAPIEventCallbackMap[eventName].push(callback);
      if (window.JSAPIEventCallbackMap[eventName].length > 1) {
        return false;
      }
      try {
        bridge.registerHandler(eventName, function () {
          for (var _len = arguments.length, args = new Array(_len), _key = 0; _key ".concat(eventName, " ").concat(data.err_msg));
            if (window.JSAPIEventCallbackMap[eventName] && window.JSAPIEventCallbackMap[eventName].length) {
              var result;
              for (var i = 0; i = 0; i--) {
        if (window.JSAPIEventCallbackMap[eventName][i] === callback) {
          window.JSAPIEventCallbackMap[eventName].splice(i, 1);
          result = true;
        }
      }
      return result;
    });
  }

  function _regeneratorRuntime$1() {  _regeneratorRuntime$1 = function _regeneratorRuntime() { return e; }; var t, e = {}, r = Object.prototype, n = r.hasOwnProperty, o = Object.defineProperty || function (t, e, r) { t[e] = r.value; }, i = "function" == typeof Symbol ? Symbol : {}, a = i.iterator || "@@iterator", c = i.asyncIterator || "@@asyncIterator", u = i.toStringTag || "@@toStringTag"; function define(t, e, r) { return Object.defineProperty(t, e, { value: r, enumerable: !0, configurable: !0, writable: !0 }), t[e]; } try { define({}, ""); } catch (t) { define = function define(t, e, r) { return t[e] = r; }; } function wrap(t, e, r, n) { var i = e && e.prototype instanceof Generator ? e : Generator, a = Object.create(i.prototype), c = new Context(n || []); return o(a, "_invoke", { value: makeInvokeMethod(t, r, c) }), a; } function tryCatch(t, e, r) { try { return { type: "normal", arg: t.call(e, r) }; } catch (t) { return { type: "throw", arg: t }; } } e.wrap = wrap; var h = "suspendedStart", l = "suspendedYield", f = "executing", s = "completed", y = {}; function Generator() {} function GeneratorFunction() {} function GeneratorFunctionPrototype() {} var p = {}; define(p, a, function () { return this; }); var d = Object.getPrototypeOf, v = d && d(d(values([]))); v && v !== r && n.call(v, a) && (p = v); var g = GeneratorFunctionPrototype.prototype = Generator.prototype = Object.create(p); function defineIteratorMethods(t) { ["next", "throw", "return"].forEach(function (e) { define(t, e, function (t) { return this._invoke(e, t); }); }); } function AsyncIterator(t, e) { function invoke(r, o, i, a) { var c = tryCatch(t[r], t, o); if ("throw" !== c.type) { var u = c.arg, h = u.value; return h && "object" == _typeof(h) && n.call(h, "__await") ? e.resolve(h.__await).then(function (t) { invoke("next", t, i, a); }, function (t) { invoke("throw", t, i, a); }) : e.resolve(h).then(function (t) { u.value = t, i(u); }, function (t) { return invoke("throw", t, i, a); }); } a(c.arg); } var r; o(this, "_invoke", { value: function value(t, n) { function callInvokeWithMethodAndArg() { return new e(function (e, r) { invoke(t, n, e, r); }); } return r = r ? r.then(callInvokeWithMethodAndArg, callInvokeWithMethodAndArg) : callInvokeWithMethodAndArg(); } }); } function makeInvokeMethod(e, r, n) { var o = h; return function (i, a) { if (o === f) throw new Error("Generator is already running"); if (o === s) { if ("throw" === i) throw a; return { value: t, done: !0 }; } for (n.method = i, n.arg = a;;) { var c = n.delegate; if (c) { var u = maybeInvokeDelegate(c, n); if (u) { if (u === y) continue; return u; } } if ("next" === n.method) n.sent = n._sent = n.arg;else if ("throw" === n.method) { if (o === h) throw o = s, n.arg; n.dispatchException(n.arg); } else "return" === n.method && n.abrupt("return", n.arg); o = f; var p = tryCatch(e, r, n); if ("normal" === p.type) { if (o = n.done ? s : l, p.arg === y) continue; return { value: p.arg, done: n.done }; } "throw" === p.type && (o = s, n.method = "throw", n.arg = p.arg); } }; } function maybeInvokeDelegate(e, r) { var n = r.method, o = e.iterator[n]; if (o === t) return r.delegate = null, "throw" === n && e.iterator["return"] && (r.method = "return", r.arg = t, maybeInvokeDelegate(e, r), "throw" === r.method) || "return" !== n && (r.method = "throw", r.arg = new TypeError("The iterator does not provide a '" + n + "' method")), y; var i = tryCatch(o, e.iterator, r.arg); if ("throw" === i.type) return r.method = "throw", r.arg = i.arg, r.delegate = null, y; var a = i.arg; return a ? a.done ? (r[e.resultName] = a.value, r.next = e.nextLoc, "return" !== r.method && (r.method = "next", r.arg = t), r.delegate = null, y) : a : (r.method = "throw", r.arg = new TypeError("iterator result is not an object"), r.delegate = null, y); } function pushTryEntry(t) { var e = { tryLoc: t[0] }; 1 in t && (e.catchLoc = t[1]), 2 in t && (e.finallyLoc = t[2], e.afterLoc = t[3]), this.tryEntries.push(e); } function resetTryEntry(t) { var e = t.completion || {}; e.type = "normal", delete e.arg, t.completion = e; } function Context(t) { this.tryEntries = [{ tryLoc: "root" }], t.forEach(pushTryEntry, this), this.reset(!0); } function values(e) { if (e || "" === e) { var r = e[a]; if (r) return r.call(e); if ("function" == typeof e.next) return e; if (!isNaN(e.length)) { var o = -1, i = function next() { for (; ++o = 0; --o) { var i = this.tryEntries[o], a = i.completion; if ("root" === i.tryLoc) return handle("end"); if (i.tryLoc = 0; --r) { var o = this.tryEntries[r]; if (o.tryLoc = 0; --e) { var r = this.tryEntries[e]; if (r.finallyLoc === t) return this.complete(r.completion, r.afterLoc), resetTryEntry(r), y; } }, "catch": function _catch(t) { for (var e = this.tryEntries.length - 1; e >= 0; --e) { var r = this.tryEntries[e]; if (r.tryLoc === t) { var n = r.completion; if ("throw" === n.type) { var o = n.arg; resetTryEntry(r); } return o; } } throw new Error("illegal catch attempt"); }, delegateYield: function delegateYield(e, r, n) { return this.delegate = { iterator: values(e), resultName: r, nextLoc: n }, "next" === this.method && (this.arg = t), y; } }, e; }
  var doc$1 = {};
  var isAcrossOrigin$1 = false;
  var notFoundedMPPageAction = [];
  var __moon_report$1 = window.__moon_report || function () {};
  var MOON_JSAPI_KEY_OFFSET = 8;
  try {
    doc$1 = top.window.document;
  } catch (e) {
    isAcrossOrigin$1 = true;
  }
  if (!window.JSAPIEventCallbackMap) {
    window.JSAPIEventCallbackMap = {};
  }
  function ready(onBridgeReady) {
    var bridgeReady = function bridgeReady() {
      try {
        if (onBridgeReady) {
          window.onBridgeReadyTime = window.onBridgeReadyTime || Date.now();
          onBridgeReady();
        }
      } catch (e) {
        __moon_report$1([{
          offset: MOON_JSAPI_KEY_OFFSET,
          log: 'ready',
          e: e
        }]);
        throw e;
      }
      window.jsapiReadyTime = Date.now();
    };
    if (!isAcrossOrigin$1 && (typeof top.window.WeixinJSBridge === 'undefined' || !top.window.WeixinJSBridge.invoke)) {
      if (doc$1.addEventListener) {
        doc$1.addEventListener('WeixinJSBridgeReady', bridgeReady, false);
      } else if (doc$1.attachEvent) {
        doc$1.attachEvent('WeixinJSBridgeReady', bridgeReady);
        doc$1.attachEvent('onWeixinJSBridgeReady', bridgeReady);
      }
    } else {
      bridgeReady();
    }
  }
  var invokeNotWaitA8key = ['notifyPageInfo', 'updatePageAuth'
  ];
  var checkNotFoundedInvoke = function checkNotFoundedInvoke(methodName, args) {
    if (methodName === 'handleMPPageAction' && (args === null || args === void 0 ? void 0 : args.action) && notFoundedMPPageAction.includes(args === null || args === void 0 ? void 0 : args.action)) {
      return true;
    }
    return false;
  };
  function invoke(_x, _x2, _x3) {
    return _invoke.apply(this, arguments);
  }
  function _invoke() {
    _invoke = _asyncToGenerator( _regeneratorRuntime$1().mark(function _callee(methodName, args, callback) {
      return _regeneratorRuntime$1().wrap(function _callee$(_context) {
        while (1) switch (_context.prev = _context.next) {
          case 0:
            if (!(window.__secPageAuthPromise && !window.__is_page_auth_ok__ && !invokeNotWaitA8key.includes(methodName))) {
              _context.next = 3;
              break;
            }
            _context.next = 3;
            return window.__secPageAuthPromise;
          case 3:
            ready(function () {
              if (isAcrossOrigin$1) return false;
              if (_typeof(top.window.WeixinJSBridge) !== 'object') {
                alert('请在微信中打开此链接');
                return false;
              }
              if (checkNotFoundedInvoke(methodName, args)) {
                setTimeout(function () {
                  if (callback) {
                    callback.apply(window, [{
                      err_msg: "".concat(methodName, ":fail"),
                      err_desc: 'action isn\'t supported'
                    }]);
                  }
                }, 0);
              } else {
                top.window.WeixinJSBridge.invoke(methodName, args, function () {
                  try {
                    for (var _len2 = arguments.length, rets = new Array(_len2), _key2 = 0; _key2  ".concat(ret.err_msg) : '';
                    if (['handleMPPageAction', 'handleVideoAction', 'handleHaokanAction'].indexOf(methodName) !== -1) {
                      var action = (args === null || args === void 0 ? void 0 : args.action) || '';
                      console.info('[system]', "[jsapi] invoke->".concat(methodName, ", action->").concat(action).concat(errMsg));
                    } else {
                      console.info('[system]', "[jsapi] invoke->".concat(methodName).concat(errMsg));
                    }
                    if (methodName === 'handleMPPageAction' && (args === null || args === void 0 ? void 0 : args.action) && ((ret === null || ret === void 0 ? void 0 : ret.err_desc) === 'action isn\'t supported' || (ret === null || ret === void 0 ? void 0 : ret.err_msg) === 'handleMPPageAction:fail action is not supported')) {
                      notFoundedMPPageAction.push(args === null || args === void 0 ? void 0 : args.action);
                    }
                    if (callback) {
                      callback.apply(window, rets);
                    }
                  } catch (e) {
                    __moon_report$1([{
                      offset: MOON_JSAPI_KEY_OFFSET,
                      log: "invoke;methodName:".concat(methodName),
                      e: e
                    }]);
                    throw e;
                  }
                });
              }
            });
          case 4:
          case "end":
            return _context.stop();
        }
      }, _callee);
    }));
    return _invoke.apply(this, arguments);
  }
  function call(_x4) {
    return _call.apply(this, arguments);
  }
  function _call() {
    _call = _asyncToGenerator( _regeneratorRuntime$1().mark(function _callee2(methodName) {
      return _regeneratorRuntime$1().wrap(function _callee2$(_context2) {
        while (1) switch (_context2.prev = _context2.next) {
          case 0:
            if (!(window.__secPageAuthPromise && !window.__is_page_auth_ok__)) {
              _context2.next = 3;
              break;
            }
            _context2.next = 3;
            return window.__secPageAuthPromise;
          case 3:
            ready(function () {
              if (isAcrossOrigin$1) return false;
              if (_typeof(top.window.WeixinJSBridge) !== 'object') {
                return false;
              }
              try {
                top.window.WeixinJSBridge.call(methodName);
              } catch (e) {
                __moon_report$1([{
                  offset: MOON_JSAPI_KEY_OFFSET,
                  log: "call;methodName:".concat(methodName),
                  e: e
                }]);
                throw e;
              }
            });
          case 4:
          case "end":
            return _context2.stop();
        }
      }, _callee2);
    }));
    return _call.apply(this, arguments);
  }
  function on$1(eventName, callback) {
    ready(function () {
      if (isAcrossOrigin$1) return false;
      if (_typeof(top.window.WeixinJSBridge) !== 'object' || !top.window.WeixinJSBridge.on) {
        return false;
      }
      if (!window.JSAPIEventCallbackMap[eventName]) {
        window.JSAPIEventCallbackMap[eventName] = [];
      }
      window.JSAPIEventCallbackMap[eventName].push(callback);
      if (window.JSAPIEventCallbackMap[eventName].length > 1) {
        return false;
      }
      top.window.WeixinJSBridge.on(eventName, function () {
        try {
          for (var _len = arguments.length, rets = new Array(_len), _key = 0; _key  ".concat(ret.err_msg) : '';
          console.info('[system]', "[jsapi] event->".concat(eventName).concat(errMsg));
          if (window.JSAPIEventCallbackMap[eventName] && window.JSAPIEventCallbackMap[eventName].length) {
            var result;
            for (var i = 0; i = 0; i--) {
        if (window.JSAPIEventCallbackMap[eventName][i] === callback) {
          window.JSAPIEventCallbackMap[eventName].splice(i, 1);
          result = true;
        }
      }
      return result;
    });
  }
  var coreAPI = {
    ready: ready,
    invoke: invoke,
    call: call,
    on: on$1,
    remove: remove
  };
  var mpappAPI = {
    ready: connectWebViewJavascriptBridge,
    invoke: invoke$1,
    call: invoke$1,
    on: on$2,
    remove: remove$1
  };
  var JSAPI = mmversion.isMpapp ? mpappAPI : coreAPI;

  
  function _log(level, msg) {
    if (level === 'log') {
      level = 'info';
      msg = "[WechatFe]".concat(msg);
    } else {
      var prefix = "__wap__".concat(window.__second_open__ ? ' (sec)' : '');
      msg = "".concat(prefix, " ").concat(msg, " location:[").concat(location.href, "]");
    }
    msg += new Error().stack;
    if (mmversion.isMpapp) {
      invoke$1('WNNativeCallbackLog', msg);
    } else if (mmversion.isWechat) {
      if (mmversion.isAndroid) {
        console.warn('[system]', "[MicroMsg.JsApiLog][".concat(level, "] jslog : ").concat(msg));
      } else if (mmversion.isIOS) {
        JSAPI.invoke('writeLog', {
          level: level,
          msg: msg
        });
      } else {
        JSAPI.invoke('log', {
          level: level,
          msg: msg
        });
      }
    }
  }
  var Log = {
    info: function info() {
      for (var _len = arguments.length, args = new Array(_len), _key = 0; _key = 0) continue;
      target[key] = source[key];
    }
    return target;
  }
  function formatDataToString(data) {
    var reportData = [];
    for (var key in data) {
      if (Object.prototype.hasOwnProperty.call(data, key)) {
        reportData.push(key + '=' + encodeURIComponent(data[key]));
      }
    }
    return reportData.join('&');
  }
  monitor.getReportData = function (opt) {
    opt = opt || {};
    var idkey = monitor._reportOptions.idkey || {};
    var key = null;
    var reportData = {};
    var nextKey;
    try {
      for (key in idkey) {
        if (Object.prototype.hasOwnProperty.call(idkey, key) && idkey[key]) {
          reportLogs.push(key + '_' + idkey[key]);
        }
      }
    } catch (e) {
      return false;
    }
    if (reportLogs.length === 0) {
      return false;
    }
    if (reportExtraLogs.length) {
      reportData.lc = reportExtraLogs.length;
      reportExtraLogs.forEach(function (extraLog, index) {
        reportData["log".concat(index)] = extraLog;
      });
    }
    try {
      var reportOptions = monitor._reportOptions;
      if (reportOptions !== null && reportOptions !== undefined) {
        for (nextKey in reportOptions) {
          if (Object.prototype.hasOwnProperty.call(reportOptions, nextKey)) {
            reportData[nextKey] = reportOptions[nextKey];
          }
        }
      }
    } catch (e) {
      reportData = {};
    }
    reportData.idkey = reportLogs.join(';');
    reportData.t = Math.random();
    if (opt.remove !== false) {
      reportLogs = [];
      reportExtraLogs = [];
      monitor._reportOptions = {
        idkey: {}
      };
    }
    return reportData;
  };
  monitor.setLogs = function (opt) {
    var id = opt.id;
    var key = opt.key;
    var value = opt.value;
    var extraLog = opt.log;
    var others = ObjWithoutProperty(opt, ['id', 'key', 'value', 'log']);
    var idkey = monitor._reportOptions.idkey || {};
    var param = id + '_' + key;
    if (idkey[param]) {
      idkey[param] += value;
    } else {
      idkey[param] = value;
    }
    monitor._reportOptions.idkey = idkey;
    if (extraLog) {
      reportExtraLogs.push(extraLog);
    }
    try {
      if (others !== null && others !== undefined) {
        for (var otherKey in others) {
          if (Object.prototype.hasOwnProperty.call(others, otherKey)) {
            monitor._reportOptions[otherKey] = others[otherKey];
          }
        }
      }
    } catch (e) {
      console.log(e);
    }
    return monitor;
  };
  monitor.setAvg = function (id, key, value) {
    var idkey = monitor._reportOptions.idkey || {};
    var param1 = id + '_' + key;
    var param2 = id + '_' + (key - 1);
    if (idkey[param1]) {
      idkey[param1] += value;
    } else {
      idkey[param1] = value;
    }
    if (idkey[param2]) {
      idkey[param2] += 1;
    } else {
      idkey[param2] = 1;
    }
    monitor._reportOptions.idkey = idkey;
    return monitor;
  };
  monitor.setSum = function (id, key) {
    var value = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : 1;
    var idkey = monitor._reportOptions.idkey;
    var param = id + '_' + key;
    if (idkey[param]) {
      idkey[param] += value;
    } else {
      idkey[param] = value;
    }
    monitor._reportOptions.idkey = idkey;
    return monitor;
  };
  monitor.send = function (async, ajax, origin) {
    if (async !== false) {
      async = true;
    }
    var data = monitor.getReportData();
    origin = origin || '';
    if (!data) {
      return;
    }
    if (!!ajax && ajax instanceof Function) {
      ajax({
        url: origin + sendUrl,
        type: 'POST',
        mayAbort: true,
        data: data,
        async: async,
        timeout: 2000,
        dontReport: true
      });
    } else {
      new Image().src = origin + '/mp/jsmonitor?' + formatDataToString(data) + '#wechat_redirect';
    }
  };
  if (typeof window !== 'undefined' && window.__monitor) {
    monitor = window.__monitor;
  } else {
    typeof window !== 'undefined' && (window.__monitor = monitor);
  }
  var monitor$1 = monitor;

  
  var logList = [];
  var log = function log(msg) {
    logList.push(msg);
  };
  var printLog = function printLog() {
    for (var i = 0, len = logList.length; i  d2.exp) return 1;
        return 0;
      });
      var memCnt = 0;
      for (var i = 0; i = size) break;
        var key = keys[i];
        memCnt += JSON.stringify(data[key]).length;
        delete data[key];
      }
      return data;
    },
    'clear-all': function clearAll() {
      localStorage.clear();
      return {};
    }
  };
  function formatLogMsg(str) {
    return "[WXLS] ".concat(str);
  }
  
  var LS = function () {
    function LS(func, evictionPolicy, logger) {
      _classCallCheck(this, LS);
      this.logger = function () {};
      if (!func) throw 'require function name.';
      this.evictionPolicy = 'noeviction';
      this.key = func;
      if (typeof logger === 'function') {
        this.logger = function (str, type) {
          return logger(formatLogMsg(str), type);
        };
      }
      if (evictionPolicy && Object.keys(evictionPolicies).indexOf(evictionPolicy) !== -1) {
        this.evictionPolicy = evictionPolicy;
      }
      this.init();
    }
    _createClass(LS, [{
      key: "init",
      value: function init() {
        var _a, _b;
        this.check();
        if (Math.random() * 1000  now) {
            temp[key] = val;
          }
        }
        this.logger("check info: isReturn:".concat(isReturn, " data:").concat(JSON.stringify(temp)), 'info');
        if (isReturn) return temp;
        LS.setItem(this.key, JSON.stringify(temp), this.logger);
      }
    }, {
      key: "set",
      value: function set(key, val, exp) {
        var _a, _b;
        var data = this.check(true);
        data[key] = {
          val: val,
          exp: exp || +new Date()
        };
        try {
          if (localStorage.getItem(prefix + this.key)) localStorage.removeItem(prefix + this.key);
          localStorage.setItem(prefix + this.key, JSON.stringify(data));
          this.logger("first set success: LSlen:".concat((_a = window === null || window === void 0 ? void 0 : window.localStorage) === null || _a === void 0 ? void 0 : _a.length, " key:").concat(prefix + this.key, " data:").concat(JSON.stringify(data)), 'success');
        } catch (e) {
          this.logger("first set error: LSlen:".concat((_b = window === null || window === void 0 ? void 0 : window.localStorage) === null || _b === void 0 ? void 0 : _b.length, " error:").concat(e, " key:").concat(prefix + this.key, " data:").concat(JSON.stringify(data), " k:").concat(key, " v:").concat(val, " exp:").concat(exp), 'error');
          localStorage.clear();
          LS.setItem(this.key, JSON.stringify(_defineProperty({}, key, {
            val: val,
            exp: exp || +new Date()
          })), this.logger);
        }
      }
    }, {
      key: "get",
      value: function get(key) {
        var data = this.getData();
        data = data[key];
        return data ? data.val || null : null;
      }
    }, {
      key: "remove",
      value: function remove(key) {
        var data = this.getData();
        if (data[key]) delete data[key];
        LS.setItem(this.key, JSON.stringify(data), this.logger);
      }
    }], [{
      key: "getItem",
      value: function getItem(key) {
        key = prefix + key;
        return localStorage.getItem(key);
      }
    }, {
      key: "setItem",
      value: function setItem(key, val, logger) {
        var _a, _b;
        key = prefix + key;
        var n = 3;
        while (n--) {
          try {
            if (localStorage.getItem(key)) localStorage.removeItem(key);
            localStorage.setItem(key, val);
            typeof logger === 'function' && logger("setItem success: LSlen:".concat((_a = window === null || window === void 0 ? void 0 : window.localStorage) === null || _a === void 0 ? void 0 : _a.length, " key:").concat(key, " val:").concat(val), 'success');
            break;
          } catch (e) {
            typeof logger === 'function' && logger("setItem error: LSlen:".concat((_b = window === null || window === void 0 ? void 0 : window.localStorage) === null || _b === void 0 ? void 0 : _b.length, " error:").concat(e, " key:").concat(key, " val:").concat(val), 'error');
            LS.clear();
          }
        }
      }
    }, {
      key: "clear",
      value: function clear() {
        var i;
        var k;
        for (i = localStorage.length - 1; i >= 0; i--) {
          k = localStorage.key(i);
          if (k.indexOf(prefix) == 0) {
            localStorage.removeItem(k);
          }
        }
      }
    }, {
      key: "getSupportEvicationPolicy",
      value: function getSupportEvicationPolicy() {
        return Object.keys(evictionPolicies);
      }
    }]);
    return LS;
  }();
  var innerVersion = (mmversion.getInner() || '').toUpperCase();
  var getBizLS = new LS('get_biz_result');
  function getBizMap() {
    if (!window.__get_biz_map__) {
      window.__get_biz_map__ = {};
    }
    return window.__get_biz_map__;
  }
  var isGetBizSupported = mmversion.isOnlyWechat && mmversion.isIOS && innerVersion >= '18003C2A' || mmversion.isOnlyWechat && mmversion.isAndroid && innerVersion >= '28003D3C' || mmversion.isUnifiedPcWechat && mmversion.cpVersion('4.1.10', 1, true, 'unifiedpc');
  function invokeGetBiz(needCheckBiz, bizType) {
    return dedupePromise("getBiz:".concat(needCheckBiz, ":").concat(bizType), function () {
      return new Promise(function (resolve, reject) {
        if (!isGetBizSupported) {
          reject('Not support');
        } else {
          JSAPI.invoke('handleMPPageAction', {
            action: 'getBiz',
            needCheckBiz: needCheckBiz,
            bizType: bizType
          }, function (res) {
            console.log("getBiz needCheckBiz=".concat(needCheckBiz, " bizType=").concat(bizType, " res: ").concat(JSON.stringify(res)));
            if (res && res.err_msg && res.err_msg.indexOf('ok') > -1) {
              var bizMap = getBizMap();
              bizMap[bizType] = res.biz;
              resolve(res.biz);
              getBizLS.set("".concat(bizType, "_get_biz_result"), res.biz, +new Date() + 3 * 24 * 60 * 60 * 1000);
            } else {
              reject('Failed to get biz');
            }
          });
        }
      });
    });
  }
  function getBiz(needCheckBiz, bizType) {
    var _a;
    if (needCheckBiz === void 0) {
      needCheckBiz = false;
    }
    if (bizType === void 0) {
      bizType = ((_a = window.cgiDataNew) === null || _a === void 0 ? void 0 : _a.biz_type) || 1;
    }
    var bizMap = getBizMap();
    if (!needCheckBiz && bizMap[bizType] !== undefined) {
      return Promise.resolve(bizMap[bizType]);
    }
    return invokeGetBiz(needCheckBiz, bizType);
  }
  mmversion.isOnlyWechat && mmversion.isIOS || mmversion.isOnlyWechat && mmversion.isAndroid || mmversion.isUnifiedPcWechat && mmversion.cpVersion('4.1.10', 1, true, 'unifiedpc');
  var getIsAuthor = function getIsAuthor(cb, bizuin, needCheckBiz, bizType) {
    var _a;
    if (bizuin === void 0) {
      bizuin = window.biz;
    }
    if (needCheckBiz === void 0) {
      needCheckBiz = false;
    }
    if (bizType === void 0) {
      bizType = ((_a = window.cgiDataNew) === null || _a === void 0 ? void 0 : _a.biz_type) || 1;
    }
    getBiz(needCheckBiz, bizType).then(function (biz) {
      cb(biz && biz === bizuin);
    })["catch"](function () {
      cb(false);
    });
  };

  function parseUrl(url) {
    var len = url.length;
    var ques_pos = url.indexOf('?');
    var hash_pos = url.indexOf('#');
    hash_pos = hash_pos == -1 ? len : hash_pos;
    ques_pos = ques_pos == -1 ? hash_pos : ques_pos;
    var host = url.substring(0, ques_pos);
    var query_str = url.substring(ques_pos + 1, hash_pos);
    var hash = url.substring(hash_pos + 1);
    return {
      host: host,
      query_str: query_str,
      hash: hash
    };
  }
  function join(url, args, noEncode) {
    var ret = parseUrl(url);
    var query_str = ret.query_str;
    var args_arr = [];
    if (_typeof(args) === 'object') {
      for (var key in args) {
        if (args.hasOwnProperty(key)) {
          args_arr.push("".concat(key, "=").concat(noEncode ? args[key] : encodeURIComponent(args[key])));
        }
      }
    } else {
      args_arr.push(noEncode ? args : encodeURIComponent(args));
    }
    if (args_arr.length > 0) {
      query_str += (query_str !== "" ? "&" : "") + args_arr.join("&");
    }
    return ret.host + (query_str !== "" ? "?".concat(query_str) : "") + (ret.hash !== "" ? "#".concat(ret.hash) : "");
  }
  
  function addParam(url, param, value, forceReplace) {
    url = url || location.href;
    var firstAndPos = url.indexOf("&");
    var len = url.length;
    var reverseUrl = url.replace(/^[\w\d]+:[/\\]+/g, "").split("").reverse();
    if (!Array.prototype.indexOf) {
      Array.prototype.indexOf = function (searchElement, fromIndex) {
        var k;
        if (this == null) {
          throw new TypeError('"this" is null or not defined');
        }
        var O = Object(this);
        var len = O.length >>> 0;
        if (len === 0) {
          return -1;
        }
        var n = fromIndex || 0;
        if (Math.abs(n) === Infinity) {
          n = 0;
        }
        if (n >= len) {
          return -1;
        }
        k = Math.max(n >= 0 ? n : len - Math.abs(n), 0);
        while (k  lastSlashPos) {
      url = url.replace("&", "?");
    }
    var reg = new RegExp("([\\?&]".concat(param, "=)[^&#]*"));
    if (!url.match(reg)) {
      var urlInfo = parseUrl(url);
      var hash = urlInfo.hash ? '#' + urlInfo.hash : '';
      url = url.replace(hash, '');
      var _pos = url.indexOf("?");
      if (_pos == -1) {
        return "".concat(url, "?").concat(param, "=").concat(value).concat(hash);
      }
      if (_pos == url.length - 1) {
        return "".concat(url + param, "=").concat(value).concat(hash);
      }
      return "".concat(url, "&").concat(param, "=").concat(value).concat(hash);
    }
    if (forceReplace === true) {
      return url.replace(reg, "$1".concat(value));
    }
    return url;
  }
  function addWxfrom(src, wxfrom) {
    var offset = window.service_type === 1 ? 10000 : 0;
    return addParam(src, 'wxfrom', offset + Number(wxfrom), true);
  }
  function removeParam(url, param) {
    var _URL = new URL(url),
      protocol = _URL.protocol,
      host = _URL.host,
      pathname = _URL.pathname,
      search = _URL.search,
      hash = _URL.hash;
    var queryParams = new URLSearchParams(search);
    queryParams["delete"](param);
    var newSearch = queryParams.toString();
    var newUrl = new URL("".concat(protocol, "//").concat(host).concat(pathname).concat(newSearch ? "?".concat(decodeURIComponent(newSearch)) : "").concat(hash));
    return newUrl.toString();
  }
  function getQuery(name, url) {
    var u = url || window.location.search;
    var reg = new RegExp("(^|&)".concat(name, "=([^&]*)(&|$)"));
    var r = u.substring(u.indexOf('?') + 1).match(reg);
    return r !== null ? r[2] : '';
  }
  function encodeBase64(value) {
    try {
      return window.btoa(value);
    } catch (e) {
      return '';
    }
  }
  function decodeBase64(value) {
    try {
      return window.atob(value);
    } catch (e) {
      return '';
    }
  }
  function joinUrl$1(url) {
    var obj = {};
    if (typeof window.uin !== 'undefined') {
      obj.uin = window.uin;
    }
    if (typeof window.key !== 'undefined') {
      obj.key = window.key;
    }
    if (typeof window.pass_ticket !== 'undefined') {
      obj.pass_ticket = window.pass_ticket;
    }
    if (typeof window.wxtoken !== 'undefined') {
      obj.wxtoken = window.wxtoken;
    }
    if (typeof window.devicetype !== 'undefined') {
      obj.devicetype = window.devicetype;
    }
    if (typeof window.clientversion !== 'undefined') {
      obj.clientversion = window.clientversion || mmversion.getInner();
    }
    obj.version = obj.clientversion;
    if (window.biz) {
      obj.__biz = window.biz;
    }
    if (getQuery('enterid')) {
      obj.enterid = getQuery('enterid');
    }
    if (typeof window.appmsg_token !== 'undefined') {
      obj.appmsg_token = window.appmsg_token;
    } else if (url.indexOf('advertisement_report') > -1) {
      new Image().src = "".concat(location.protocol, "//mp.weixin.qq.com/mp/jsmonitor?idkey=68064_13_1&r=").concat(Math.random());
    }
    obj.x5 = navigator.userAgent.indexOf('TBS/') !== -1 ? '1' : '0';
    obj.f = 'json';
    return join(url, obj);
  }
  function joinUserArticleRole(url, notJoin, cb) {
    var bizuin = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : window.biz;
    var needCheckBiz = arguments.length > 5 && arguments[5] !== undefined ? arguments[5] : false;
    if (notJoin) {
      cb(url);
    } else {
      getIsAuthor(function (isAuthor) {
        cb(addParam(url, 'user_article_role', isAuthor ? 1 : 0, true));
      }, bizuin, needCheckBiz);
    }
  }
  function getA8keyQuery(name, url) {
    return new Promise(function (resolve) {
      if (window.__secPageAuthPromise) {
        window.__secPageAuthPromise.then(function () {
          resolve(getQuery(name, url));
        });
      } else {
        resolve(getQuery(name, url));
      }
    });
  }
  function addHash(url, hash) {
    var isReplace = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : false;
    if (isReplace) {
      return "".concat(url.split('#')[0]).concat(hash);
    }
    return "".concat(url).concat(url.indexOf('#') === -1 ? '#' : '').concat(hash);
  }
  function decodeUrl(url) {
    var _url = url;
    while (_url.indexOf('&') !== -1) {
      _url = _url.htmlDecode();
    }
    return _url;
  }
  var Url = {
    parseUrl: parseUrl,
    join: join,
    addParam: addParam,
    addWxfrom: addWxfrom,
    addHash: addHash,
    getQuery: getQuery,
    getA8keyQuery: getA8keyQuery,
    encodeBase64: encodeBase64,
    decodeBase64: decodeBase64,
    joinUrl: joinUrl$1,
    joinUserArticleRole: joinUserArticleRole,
    removeParam: removeParam,
    decodeUrl: decodeUrl
  };

  var _a;
  var doc;
  var isAcrossOrigin = false;
  try {
    doc = (_a = window.top) === null || _a === void 0 ? void 0 : _a.window.document;
  } catch (e) {
    isAcrossOrigin = true;
  }
  var StatusTextMap = {
    200: 'OK',
    302: 'Found',
    400: 'Bad Request',
    500: 'Internal Server Error'
  };
  function getIsAcrossOrigin() {
    return isAcrossOrigin;
  }
  function networkStartLog(item) {
    var _a, _b, _c, _d, _e;
    console.log('[system]', " [response ".concat(item.requestType, "]"), item.url, item.response, item);
    if (item.rdevRequestId && ((_b = (_a = window.RemoteDevSdk) === null || _a === void 0 ? void 0 : _a.instance) === null || _b === void 0 ? void 0 : _b.Network) && item.id !== '__system_log__') {
      try {
        var finishedOptions = {
          requestId: item.rdevRequestId,
          url: item.url,
          status: +(item.status || '500'),
          statusText: StatusTextMap[+(item.status || '500')] || 'Error',
          responseHeaders: {
            RDEV_RESPONSE_TYPE: item.requestType
          },
          responseBody: item.response,
          requestTime: item.requestTime || 0,
          duration: item.costTime || (item.endTime && item.startTime ? item.endTime - item.startTime : performance.now() / 1000 - (item.requestTime || 0))
        };
        window.RemoteDevSdk.instance.Network.customRequestFinished(finishedOptions);
      } catch (err) {}
    }
    if (((_c = window.vConsole) === null || _c === void 0 ? void 0 : _c.network) && item.id !== '__system_log__') {
      try {
        item.statusText = "".concat(item.status);
        item.responseSize = item.response.length;
        item.responseSizeText = "".concat(item.response.length);
        return (_e = (_d = window.vConsole.network).update) === null || _e === void 0 ? void 0 : _e.call(_d, item.id, Object.assign({}, item, {
          readyState: 4
        }));
      } catch (err) {}
    }
  }
  function reqType(obj, path) {
    return obj.url.indexOf(path) > -1 && obj.url.indexOf('action=') === -1 && (!obj.data || !obj.data.action);
  }
  function findAjaxScopeByConfig(url, config) {
    var pathname = new URL(url, location.href).pathname || '';
    var scope = config[pathname.slice(1)];
    if (scope) {
      return scope;
    }
  }
  function getAjaxScope(ajaxUrl) {
    if (Url.getQuery('no_transfer', location.href) !== '1' && mmversion.isWechat && !mmversion.isInMiniProgram && !mmversion.isWxWork && !mmversion.isMpapp && !isAcrossOrigin && window.__ajaxTransferConfig && _typeof(window.__ajaxTransferConfig) === 'object' && (
    mmversion.isIOS && mmversion.compareHexVersion('1800282F') || mmversion.isAndroid && mmversion.compareHexVersion('28002234') || mmversion.isWindowsWechat && mmversion.cpVersion('3.9.5', 1, true, 'windows') || mmversion.isMacWechat && mmversion.cpVersion('3.8.4', 1, true, 'mac') || mmversion.isHarmonyWechat && mmversion.compareHexVersion('0xf3100b00') && !mmversion.compareHexVersion('0xf3100c00') || mmversion.compareHexVersion('0xf3800b00'))) {
      try {
        return findAjaxScopeByConfig(ajaxUrl, window.__ajaxTransferConfig);
      } catch (err) {
        
      }
    }
  }
  function getActionByData(data) {
    var _a, _b;
    if (_typeof(data) === 'object' && !(data instanceof Blob)) {
      if (data.hasOwnProperty('data') && typeof data.data === 'string') {
        try {
          var workedData = JSON.parse(data.data);
          return workedData.action || '';
        } catch (e) {}
      }
      return data.action || '';
    }
    if (typeof data === 'string') {
      return ((_b = (_a = data.split(/[?&]/).find(function (x) {
        return x.indexOf('action=') >= 0;
      })) === null || _a === void 0 ? void 0 : _a.split('=')) === null || _b === void 0 ? void 0 : _b[1]) || '';
    }
    return '';
  }

  var METHOD_ENUM = {
    GET: 0,
    POST: 1
  };
  var __moon_report = window.__moon_report || function () {};
  var MOON_AJAX_SUCCESS_OFFSET = 3;
  var MOON_AJAX_NETWORK_OFFSET = 4;
  var MOON_AJAX_ERROR_OFFSET = 5;
  var MOON_AJAX_TIMEOUT_OFFSET = 6;
  var MOON_AJAX_COMPLETE_OFFSET = 7;
  var LENGTH_LIMIT = 4096;
  function reportRtError(type, id, key, content) {
    var log = '';
    var prefix = type === 'rt' ? 'rtCheckError' : 'Ajax Length Limit';
    if (content === null || content === void 0 ? void 0 : content.length) {
      var loglen = 1000;
      var len = content.length;
      var lc = Math.ceil(len / loglen);
      log = ["&lc=".concat(lc)];
      f