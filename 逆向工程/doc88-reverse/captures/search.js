var Search = function(){}; 
(function(p8) {
	Search.currentSearchType = 0;
	Search.curpage = 0;
	Search.listLoading = false;
	Search.pageRange = 0;   
	Search.pageNum = "0"; 
	Search.lastRk = ""; 
	Search.lastScrollTime = 0; 
	Search.scrollIntervalIndex = 0;    
	Search.loading = false;
	Search.keyword = '';
	Search.preSugKeyword = '';
	Search.suggestLoading = false;   
	Search.index = 0;
	Search.suggestIf = false;
	Search.client = 0;  
 	Search.lastSearchType =  0;
	Search.sDate = '';
	Search.eDate = '';
	Search.setType = function(type)
  { 
    Search.setCookie("searchType",type);
  };
	Search.init = function(keyword)
	{
		Search.getLoginBar("loginBar");
		$(document).click(function (event){
			var tarId = $(event.target).attr("id");
			if(tarId!="keyword")
				$('.search-hint,.search-rhint').hide();
		});       
		Search.keyword = keyword;
		$("#keyword").val(Search.keyword);
		$('document').keyup(function(e) {
		 	if (e.keyCode == 13) { 
				Search.goSearch();	
				$("#keyword").blur();
			}
		});
		$('#keyword').keyup(function(e) { 
			if($('#keyword').val()!="")
			{
			   $(".search-del").show();
			}
			else
			{
			   $(".search-del").hide();
			}
			if (e.keyCode == 38) {
		        var active = $(".hint-list li.active");
		        if (active.length) {
		            var prev = active.prev();
		            if (prev.length) {
		                prev.addClass("active").siblings().removeClass("active");
		            }
		            else {
		                $(".hint-list li:last").addClass("active").siblings().removeClass("active");
		            }
		        }
		        else {
		            $(".hint-list li:last").addClass("active");
		            $("#keyword").val($(".hint-list li.active").html());
		        }
				if (active.length)
				{
					var m_t = $(".hint-list li.active").attr("title");
					if(m_t==null||m_t==""||m_t==undefined)
					{
						m_t = $(".hint-list li.active").text();
					}
					$("#keyword").val(m_t);
				}
		    }
		    else if (e.keyCode == 40) {
		        var active = $(".hint-list li.active");
		        if (active.length) {
		            var next = active.next();
		            if (next.length) {
		                next.addClass("active").siblings().removeClass("active");
		            }
		            else {
		                $(".hint-list li:first").addClass("active").siblings().removeClass("active");
		            }
		        }
		        else {
		            $(".hint-list li:first").addClass("active");
		            $("#keyword").val($(".hint-list li.active").html());
		        }
				if (active.length)
		        {
					var m_t = $(".hint-list li.active").attr("title");
					if(m_t==null||m_t==""||m_t==undefined)
					{
						m_t = $(".hint-list li.active").text();
					}
					$("#keyword").val(m_t);
				}
		    }else{
		    	Search.showSuggest();
		    }

		});
		$('#keyword').click(function(event) {
			Search.showSuggest();
		});
		$(".input_key").focus(function(event) {
			$(".search-del").show();
		});
		$(".search-del").click(function(event) {
			$("#keyword").val('');
			$("#keyword").focus();  
			$(".search-del").hide();
		});  
		if(Search.index==1)
		{
		   $('#keyword').focus();
		}
		if(Search.index == 0)
		{
			
			Search.getReadHistory();
			var format = Search.getCookie("cdb_search_format");
			Search.setFormat(format);
			Search.scrollListener();


			$(".sd-time-filter").click(function(event){
				event.stopPropagation(); 
				var stmenuShow = $(".sd-time-menu-filter").is(":hidden")
				if (stmenuShow) {
					$(".sd-time-menu-filter").show();
				}else{
					$(".sd-time-menu-filter").hide();
				}
				$(document).click(function(event){
					event.stopPropagation(); 
					$(".sd-time-menu-filter").hide();
				})
			})
			$(".sd-time-menu-filter>a").click(function(){
				var stHtml = $(this).html();
				$(".sd-time-filter .st").html( $(this).html() );

				var nowdate = new Date();
				var stime = "";
				$("#sd-filter-more").addClass('hide');
				$("#sd-filter-clear").removeClass('hide');
				if (stHtml == "时间不限") {
					$("#sd-filter-more").removeClass('hide');
					$("#sd-filter-clear").addClass('hide');
				}else if(stHtml == "一周内"){
					stime = new Date(nowdate-7*24*3600*1000).getTime();
					stime = timeFormat(stime);
				}else if(stHtml == "一月内"){
					stime = nowdate.setMonth(nowdate.getMonth()-1);
					stime = timeFormat(stime);
				}else if(stHtml == "半年内"){
					stime = nowdate.setMonth(nowdate.getMonth()-6);
					stime = timeFormat(stime);
				}else if(stHtml == "一年内"){
					stime = nowdate.setMonth(nowdate.getMonth()-12);
					stime = timeFormat(stime);
				}
				Search.sDate = stime;
				Search.searchPage("p=1");

			})
			
			$("#sd-filter-more").click(function(event) {
				if ($(".sd-fpages").is(":hidden")) {
					$(this).html('收起 <i class="iconfont">&#xe68d;</i>');
					$(".sd-fpages").show();
					$("#sd-filter-more i").html('&#xe68d;');
				} else{
					var plabel = "";
					if(Search.pageNum!=""&&Search.pageNum!=0)
					{
						plabel = "("+Search.pageNum+")"
						if(Search.pageRange==1)
						{
							plabel = "("+Search.pageNum+"页以上)"
						}
					} 
					// $(this).html('高级 <id="pageLabel">'+plabel+'</label><i class="iconfont">&#xe68a;</i>');
					$(this).html('高级 <i class="iconfont">&#xe68a;</i>');
					$(".sd-fpages").hide();
					$("#sd-filter-more i").html('&#xe68a;');
				};
			});
			/**
			$("#sd-filter-more").toggle(function() {
				$(this).html('收起 <i class="iconfont">&#xe68d;</i>');
				$(this).parent().css('paddingBottom', '5px');
				$("#sd-fpages").show();
			}, function() {         
				var plabel = "";
				if(Search.pageNum!=""&&Search.pageNum!=0)
				{
					plabel = "("+Search.pageNum+")"
					if(pageRange==1)
					{
						plabel = "("+Search.pageNum+"页以上)"
					}
				} 
				$(this).html('页码<id="pageLabel">'+plabel+'</label><i class="iconfont">&#xe68a;</i>');
				$(this).parent().removeAttr("style");
				$("#sd-fpages").hide();    
			});**/
			$("#formatAll").click(function(){Search.setFormat("");});  
			$("#formatPDF").click(function(){Search.setFormat("PDF"); });
			$("#formatDOC").click(function(){Search.setFormat("DOC");});
			$("#formatPPT").click(function(){Search.setFormat("PPT");});
			$("#formatXLS").click(function(){Search.setFormat("XLS");});
			$("#formatTXT").click(function(){Search.setFormat("TXT");});
		}
	};
	//自定义时间
	Search.customTime = function()
	{ 
		var timeStart = $('#time-start').val();
		var timeEnd = $('#time-end').val();
		timeStart = new Date(timeStart.replace(/-/g, '/')).getTime();
		timeEnd = new Date(timeEnd.replace(/-/g, '/')).getTime();

		var isTrue = timeStart-timeEnd;
		if (isTrue > 0) {
			$('.sd-time-menu-filter').hide();
			$('.sd-time-custom-error').show();
			return;
		}
		Search.sDate = $('#time-start').val();
		Search.eDate = $('#time-end').val();
		$('.sd-time-menu-filter').show();
		$('.sd-time-custom-error').hide();
		$(".sd-time-filter .st").html( $(".sd-time-st input").val()+"至"+$(".sd-time-et input").val() );
		$("#sd-filter-more").addClass('hide');
		$("#sd-filter-clear").removeClass('hide');
		Search.searchPage("p=1");
	};
	// 清除筛选条件
	Search.clearFilter = function()
	{ 
		
		Search.sDate = '';
		Search.eDate = '';
		$(".sd-time-filter .st").html("时间不限");

		Search.pageRange= 0;
		Search.pageNum = "";
		$("#pstart").val(""); 
		$("#pend").val(""); 
		$("#p-0").addClass("current").siblings().removeClass("current");

		$("#sd-filter-more").removeClass('hide');
		$("#sd-filter-clear").addClass('hide');
		Search.searchPage("p=1");
	};

	Search.changePage = function(t)
	{   
		$("#sd-filter-more").addClass('hide');
		$("#sd-filter-clear").removeClass('hide');
		if(t==5)
		{
			var start = $("#pstart").val();  
			var end = $("#pend").val();    
			if(start=="")
			{
				start = 0;
			}
			Search.pageRange= 3;
			if(end=="")
			{
				Search.pageNum = start;
				Search.pageRange = 1;
			}
			else
			{
				Search.pageNum = start+"-"+end;
			}
			 $("#pageLabel").html("("+Search.pageNum+")");
			
		}
		$("#p-0").removeClass("current"); 
		$("#p-1").removeClass("current");
		$("#p-2").removeClass("current");
		$("#p-3").removeClass("current");
		$("#p-4").removeClass("current"); 
		if(t<5)
		{
		   $("#p-"+t).addClass("current"); 	
		}   
	
		if(t==0)
		{   
			$("#sd-filter-more").removeClass('hide');
			$("#sd-filter-clear").addClass('hide');
			Search.pageRange= 0;
			Search.pageNum = "";
			$("#pstart").val(""); 
			$("#pend").val("");  
			$("#pageLabel").html("");
		}        
		else if(t==1)
		{       
			Search.pageRange= 3;
			Search.pageNum = "1-5";
			$("#pstart").val(1); 
			$("#pend").val(5); 
			$("#pageLabel").html("("+Search.pageNum+")");
		} 
		else if(t==2)
		{        
			Search.pageRange= 3;
			Search.pageNum = "6-10"; 
			$("#pstart").val(6); 
			$("#pend").val(10); 
			$("#pageLabel").html("("+Search.pageNum+")");
		}
		else if(t==3)
		{                
			Search.pageRange= 3;
			Search.pageNum = "11-20"; 
			$("#pstart").val(11); 
			$("#pend").val(20); 
			$("#pageLabel").html("("+Search.pageNum+")");
		}
		else if(t==4)
		{               
			Search.pageRange = 1;
			Search.pageNum = "21"; 
			$("#pstart").val(21); 
			$("#pend").val(""); 
			$("#pageLabel").html("(21页以上)");
		}  
	
		Search.searchPage("p=1");
	};   
	Search.openurl = function(url)
	{         
		window.external.CppCall('openurl','http://www.doc88.com/'+url);
		
	   	return false;
	};
	Search.showSuggest = function()
	{
		var keyword = $("#keyword").val();
		if(keyword=="")
		{
			$(".hint-list").html("");
			var m_showSIf = false;
			var m_skh = localStorage.getItem("SH_KEYWORD");
			if (m_skh != null && m_skh !='') {
				var m_keywordArray = m_skh.split(",");
				for (i = 0; i < m_keywordArray.length - 1; i++) {
				    var m_key = m_keywordArray[i];
				    if(m_key!="")
					{
						m_showSIf = true;
						$(".hint-list").append("<li onclick='Search.setSuggest(this)' title='"+m_key+"' type='sh'><i class='iconfont icon-suggest'>&#xe717;</i><b class='title-suggest'>"+m_key+"</b></li>");
					}
				}
			}
			var m_rh_code = localStorage.getItem("RH_CODE");
			if (m_rh_code != null && m_rh_code !='') {
			    var m_codeArray = m_rh_code.split(",");
				for (i = 0; i < m_codeArray.length - 1; i++) {
				    var m_code = m_codeArray[i].replace(/_/g, "");
				    var m_rc = localStorage.getItem("RC_" + m_code);
				    var m_obj = JSON.parse(m_rc);
					var m_format = m_obj.df;
					var m_name = m_obj.n;
					var m_page = m_obj.pc;
					if(i>10)
					{
						break;
					}
					m_showSIf = true;
					$(".hint-list").append("<li onclick='Search.setSuggest(this)' code='"+m_code+"' title='"+m_name+"' type='rh'><img class='img-suggest' src='/assets/images/icons/type/"+m_format+".png'/><b class='title-suggest'>"+m_name+"</b>&nbsp;"+m_page+"页</li>");
				}
			} 
			if(m_showSIf)
			{
				$(".search-hint,.search-rhint").show();
			}
			return;
		}
		if(Search.preSugKeyword==keyword||Search.suggestLoading||keyword=="")
		{    
			if(Search.suggestIf)
			{     
				$(".search-hint,.search-rhint").show();
			}
			return false;
		}
		Search.preSugKeyword = keyword;
		Search.suggestLoading = true;
		$.ajax({
			url: "/search/suggest.do?q="+encodeURIComponent(keyword),
			type: "get",
			dataType: "json",
			async: true,
			success: function(msg){
				$(".hint-list").html("");
				for(var i = 0; i < msg.length; i++){
				  var title = msg[i].title;
				  $(".hint-list").append("<li onclick='Search.setSuggest(this)'  title='"+title+"' type='sg'>"+title+"</li>");
				} 
				if(msg.length>0){
					$(".search-hint,.search-rhint").show();
				}else{
					$(".search-hint,.search-rhint").hide();
				}
					
				Search.suggestLoading = false;
				Search.suggestIf = true;
			}
		});
	};
	Search.setSuggest = function(obj)
	{
		
		var m_type =  obj.getAttribute("type");
		if(m_type=="sg"||m_type=="sh")
		{
			$("#keyword").val(obj.getAttribute("title"));
			$(".search-hint,.search-rhint").hide();
			Search.goSearch();
		}
		else
		{
			var m_code = obj.getAttribute("code");
			window.open("/p-"+m_code+".html");
		}
	};
	Search.goSearch = function(){
		var keyword = document.getElementById("keyword").value; 
		if(keyword == ""){
			document.getElementById("keyword").focus();
			return false;
		}
		if(Search.keyword==keyword)
		{   
    
			var f = Search.getCookie("searchType"); 
			if(Search.lastSearchType==f)
				return false;
		}
		if(Search.client==3)
		{
			window.location.href='/ltag/'+encodeURIComponent(document.getElementById("keyword").value);
			return;
		}
		var searchForm = document.getElementById('searchForm');
		if(Search.client==1)
		{
			
			if(Search.c==4)
			{
				window.location.href='/dtag/'+encodeURIComponent(document.getElementById("keyword").value);
			}
			else
			{
				
				callClientInterface('openurl', Search.siteurl+'/ctag/'+encodeURIComponent(document.getElementById("keyword").value));
				
			}
			
			
		}
		else
		{
			window.location.href='/tag/'+encodeURIComponent(document.getElementById("keyword").value);
		}
		return false;
	};
	Search.srcoll = function()
	{
		var scroll_height = $(document).scrollTop();
		if(scroll_height > 0){
			$("#header-box").addClass("shadow");
			$(".users").hide();
		} else {
			$("#header-box").removeClass("shadow");
			$(".users").show();
		} 
		 var nowTime =  new Date().getTime();
		 if(Search.lastScrollTime<nowTime)
		 {
			Search.lastScrollTime = nowTime;
			clearInterval(Search.scrollIntervalIndex);
			Search.scrollIntervalIndex = window.setInterval(Search.scrollListener,400);
		 }
	};
	Search.getRK = function(keyword) 
	{
		$.ajax({
			url: "/search/rk.do?q="+encodeURIComponent(keyword)+"&ct="+Search.client,
			type: "get",
			dataType: "json",
			async: true,
			success: function(msg){
				Search.lastRk = keyword;
				$("#rkul").html(msg.kwSb);   
				$("#rkul-p").html(msg.kwSb);
				$("#related_div").show();  
			}
		});
	};
	Search.getReadHistory = function()
	{
		$.ajax({
			url: "/doc.php?act=rh",
			type: "get",
			dataType: "html",
			async: true,
			success: function(msg){
				$(".recent-viewed").html(msg);   
			}
		});
	};
	Search.loadGroupDocList = function(group_id)
	{
		$.ajax({
			url: "/doc.php?act=group_doc&group_id="+group_id+"&s=1&h=1",
			type: "get",
			dataType: "html",
			async: true,
			success: function(data){
				$(".guess-like").html(data); 
			}
		});
	};
	Search.loadHomeLikeDoc = function(group_id)
	{
		$.ajax({
			url: "/mobile/mobile.php?act=ajax_like&type=2",
			type: "get",
			dataType: "html",
			async: true,
			success: function(data){
				$("#guess_like").html(data); 
			}
		});
	};
	Search.setListEvent = function()
	{
		$(".commonlist1>li").mouseover(function(){
		$(this).addClass("over");
		}).mouseout(function(){
			$(this).removeClass("over");
		});
	};
	Search.loadIntro = function(textpath,p_id)
	{         
		var img_if = $('#intro_'+p_id).attr("img");  
		if(img_if==1)     
		{      
			var imgloadif = $('#thumb_'+p_id).attr("loadIf"); 
			if(imgloadif!=1)
			{
				$("#thumb_"+p_id).hide();
				var img = $("#thumb_"+p_id).attr("orig");    
				document.getElementById("thumb_"+p_id).style.backgroundImage="url('"+img+"')"; 
				$('#thumb_'+p_id).fadeIn(500);	
				$('#thumb_'+p_id).attr("loadIf","1"); 
			 }
		}
		var loadIf = $('#intro_'+p_id).attr("loadIf");    
		if(loadIf==1||Search.loading||Search.lastSearchType==1)
		{
		   return;
		}   
		Search.loading = true;    
		$('#intro_'+p_id).attr("loadIf","1");  
		$.ajax({
			url: "/doc.php?act=get_intro&p="+textpath,
			dataType:"html",       
			async: true,
			success: function(msg){    
				$('#intro_'+p_id).html(msg);   
				$('#intro_'+p_id).fadeIn(500);	
				Search.loading = false; 
				Search.scrollListener();
			}
		});
	};
	Search.scrollListener = function()
	{           
		var m_nowTime = new Date().getTime();
		if(m_nowTime-Search.lastScrollTime>200)
		{
		 $(".sd-con,.sd-con-cover").each(function(){
			var loadIf = $(this).attr("loadIf");   
			if(loadIf==0)
			{                
			   var intropath = $(this).attr("intropath");      
			   var p_id = $(this).attr("p_id");
				var a = $(this).offset().top;   
				if (a >= $(window).scrollTop() && a < ($(window).scrollTop()+$(window).height()+300)) {
					Search.loadIntro(intropath,p_id);
				}   
			}
		  });   
	   }
	};      
	Search.setFormat = function(format)
	{          
		$("#formatAll").removeClass("active");   
		$("#formatPDF").removeClass("active");
		$("#formatDOC").removeClass("active");
		$("#formatPPT").removeClass("active");
		$("#formatXLS").removeClass("active");
		$("#formatTXT").removeClass("active");
		var idName = "formatAll";    
		if(format!="")
		{
			idName = "format"+format;
		} 
		$("#"+idName).addClass("active");
		Search.setCookie("cdb_search_format",format,30*24); 
		Search.searchPage("p=1");
	};   
	Search.searchPage = function(par)
	{    
		Search.searchDoc(par);
	}; 
	Search.getLoginBar = function(barId)
	{
      $.ajax({
          url: '/member.php?act=search_user&ct='+Search.client,
          type: "get",
          dataType: "html",
          success: function(msg) {
              $("#"+barId).html(msg);
          }
      });
	};
	Search.searchDoc = function(par)
	{            
  
   var f = Search.getCookie("searchType");  
		var format = Search.getCookie("cdb_search_format");
		var rkIf = 0;
		if(par=="p=1")
		{
			if(Search.lastRk!=Search.keyword)
			{
				Search.getRK(Search.keyword);
			}
			//callClientInterface('searchword',Search.keyword)
		
		}
		window.scroll(0,0); 
		$("#sd-result").html("");
		Search.showLoading();
		footPos();       
		var post_keyword = encodeURIComponent(Search.keyword);
		Search.lastSearchType = f;
		$.ajax({
			url: "/search/post.do?from=1&f="+f+"&h=1&t=1728894524&pageRange="+Search.pageRange+"&pageNum="+Search.pageNum+"&format="+format+"&"+par+"&q="+post_keyword+"&sDate="+Search.sDate+"&eDate="+Search.eDate+"&ct="+Search.client,
			dataType:"html",
			cache:false,
			async: true,
			success: function(msg)
			{       
				$("#result_content").html(msg);
				$("#sd-result").html($("#pageResult").html());
				Search.setListEvent(); 
			  
				Search.scrollListener();
				if(par=="p=1")
				{
				   if($("#urlDocTitle").val()!=""&&$("#urlDocTitle").val()!="null")
					{
					   Search.getRK($("#urlDocTitle").val());
					}
				   else
				   {
					   $("#rkul").html($("#rkul-p").html());	
				   }
					
				}
				else
				{
					$("#rkul").html($("#rkul-p").html());	
				}
				footPos();
			}
		});
		
	}; 
	Search.m_setHistory = function(m_keyword)
	{
		if(!window.localStorage)
		{
			return;
		}
		m_keyword = m_keyword.replace(",","");
		if(m_keyword==null||m_keyword=="")
		{
			return;
		}
		var m_sh_keyword = localStorage.getItem("SH_KEYWORD");
		if(m_sh_keyword==null)
		{
			m_sh_keyword = "";
		}
		if(m_sh_keyword!="")
		{
			m_sh_keyword = m_sh_keyword.replace(m_code+",","");
		}
		m_sh_keyword = m_keyword+","+m_sh_keyword;
		var m_keywordArray = m_sh_keyword.split(",");
		if(m_keywordArray.length>20)
		{
			var m_lastKeyword = m_keywordArray[m_keywordArray.length-2];
			m_sh_keyword = m_sh_keyword.replace(m_lastKeyword+",","");
		}
		localStorage.setItem("SH_KEYWORD",m_sh_keyword);
	
	};
	Search.showLoading = function()
	{
		var slider_reload="<div style = 'width:100%; margin:0px; text-align:center; font-size:12px; align:center;'>"+
			"<table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td width='50%' height='100' align='right'><img src = '/resources/images/loading.gif'/></td><td align='left'></td></tr></table>"+
			"</div>";
		$("#result_content").html(slider_reload);
	}   
	Search.getCookie = function(m_name)
	{
		var m_cValue = "";
		var m_cookies = document.cookie.split('; ');
			for (var i = 0, l = m_cookies.length; i < l; i++) {
				var m_parts = m_cookies[i].split('=');
				if (m_parts[0]== m_name) {
					if(m_parts.length>1)
					{
						m_cValue =  unescape(m_parts[1]);
					}
				}
			}
		if(m_cValue==null||m_cValue=='null')
		{
			m_cValue="";
		}
		return m_cValue;
	}; 
	Search.setCookie = function(m_name,m_value,m_objHours)
	{
		Search.delCookie(m_name);
		var m_name = escape(m_name);
		var m_value = escape(m_value);
		m_path = "/";
		m_path = m_path == "" ? "" : ";path=" + m_path;
		if(m_objHours > 0){  
			var m_date = new Date();
			var m_ms = m_objHours*3600*1000;
			m_date.setTime(m_date.getTime() + m_ms);
			document.cookie = m_name + "=" + m_value  + m_path+"; expires=" + m_date.toGMTString();
	   }
	   else
	   {
		   document.cookie = m_name + "=" + m_value  + m_path;
	   } 
	}; 
	Search.delCookie = function(m_name)
	{
		var m_exp = new Date();
		m_exp.setTime(m_exp.getTime() - 1);
		document.cookie= m_name + "=;expires="+m_exp.toGMTString();
	}

})(document);
$(window).bind("scroll", function(event){  
 	Search.srcoll();
}); 



var windowWidth = $(window).width();
if(windowWidth < 1280){
    $("body").addClass('container-s');
}
function getLoginBar(barId)
{
	top.DOC88Window.close(); 
	Search.getLoginBar(barId);
	
}

// 页脚固定
function footPos(){
	var srConH = $(window).height() - $(".sresult-box").outerHeight() - $(".sr-footer").height();
	if (srConH > 0) {
		$(".sr-footer").addClass('srf-fixed');
	} else{
		$(".sr-footer").removeClass('srf-fixed');
	};
}

$(window).resize(function(event) {
	footPos();
});