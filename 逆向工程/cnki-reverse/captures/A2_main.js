var recommendViewServerUrl = "";

function initEventBind() {
    //结果页面 搜索框后的"X"
    $(".sweep").click(function () {
        $(this).siblings("input[type='text']").val("");
    })
    //
    $(".header-right .sz").click(function (event) {
        //校验是否打开历史纪录
        if (checkHistoryEnabled()) {
            $("#OpenHistory").hide();
            $("#ShutDownHistory").show()
        } else {
            $("#OpenHistory").show();
            $("#ShutDownHistory").hide();
        }
        $(this).siblings("ul").show();
        event.stopPropagation();//阻止子元素继承父级事件
        /*return false;  //阻止子元素继承父级事件*/
    });
    $(".more").click(function (event) {
        $(this).siblings("ul").show();
        event.stopPropagation();//阻止子元素继承父级事件
        /*return false;  //阻止子元素继承父级事件*/
    });
    $("body").click(function () {
        $(".header-right ul").hide();
        $(".home-nav ul,.result-nav ul").hide();

        $(".select ul").hide();
        $(".select").css({ "z-index": "1" });
        $(".selectwrap").css({ "z-index": "1" });
        $(".yearwrap .p").removeClass("clickp")
    });
    $("#search:visible").live("click", function () {
        writeCookie();
    });

    //点击快捷搜索前面搜索框
    $("#QuickSearch .add").click(function () {
        $("#QuickSearch").addClass("displayN");
        $("#MultiTermSearch").removeClass("displayN");
        var length = $("#MultiTermSearch .xiugai").length;
        if (length <= 0) {
            addMulitySearchboxItems();
        }
        ////将快捷搜索的 内容复制到 高级搜索的第一个文本框中
        $("#MultiTermSearch input").first().val($("#textSearchKey").val());
    });
    //点击 “高级搜索”
    $("#QuickSearch .gj").click(function () {
        $("#QuickSearch").addClass("displayN");
        $("#MultiTermSearch").removeClass("displayN");
        //将快捷搜索的 内容复制到 高级搜索的第一个文本框中
        $("#MultiTermSearch input").first().val($("#textSearchKey").val());
        var itermLength = $("#searchHtmlTemplate .itemlist").find("li").length;
        //触发点击事件 n（itermLength） 次   //
        for (var i = 0; i < itermLength; i++) {
            $("#MultiTermSearch .add:visible").click();
        }
    });
    // 点击 “快捷搜索”
    $("#MultiTermSearch .gj").live("click", function () {
        $("#textSearchKey").val($("#MultiTermSearch").find("input:visible").first().val());
        $("#MultiTermSearch").addClass("displayN");
        $("#QuickSearch").removeClass("displayN");
        $("#MultiTermSearch").find(".xiugai").remove();

    });
}

//校验文本框是否有内容
//如果没有 跳转页面到相应的搜索页面
//如果有内容 跳转页面到 相应的搜索结果页面
function checkClick(obj) {
    var index = $(obj).attr("data-code");
    channelType = index;
    $("#topSearchNav a").removeClass("active");
    $(obj).addClass("active");
    var nullFlag = true;
    $("input[type='text']:visible").each(function () {
        if ($(this).val() != "") {
            nullFlag = false;
            return true;
        }
    })
    if (!nullFlag) {
        searchConditionPara.FilterParam.CrossAreaSearch = true;
        switch (index) {
            case "0": $(obj).removeAttr("href"); Search(); break;
            case "1": $(obj).removeAttr("href"); Search(); break;
            case "4": $(obj).removeAttr("href"); Search(); break;
            case "9": $(obj).removeAttr("href"); Search(); break;
            case "3": $(obj).removeAttr("href"); cjfdSearch(); break;
            default: break;
        }
    }
}

//添加 搜索框
function addMulitySearchboxItems(obj) {
    var htmlStr = $("#searchHtmlTemplate").html();
    //高级搜索区域没有内容
    if (obj == undefined || obj == null || obj == "") {
        htmlStr = htmlStr.replace("DISPALYITEM", "displayN");
        $("#MultiTermSearch").html(htmlStr);
        checkSelectSearchBoxItem(0);
        return false;
    }

    var childItemCount = $("#MultiTermSearch").find(".xiugai").length;
    var itemLength = $("#searchHtmlTemplate .itemlist").find("li").length;//条件类型总数
    if (childItemCount >= 7) {
        alert("抱歉！您最多可以添加7条搜索条件");
        return;
    }
    if (childItemCount < itemLength && childItemCount < 7) {//搜索输入框不能超过7个 搜索框的个数不能大于下拉列表的条目数
        $("#MultiTermSearch .xiugai").each(function (index) {
            $(this).find(".remove").show();
            $(this).find(".add").hide();
            $(this).find("#selectwrap").children(".searchwrap").hide();
        })

        htmlStr = htmlStr.replace("DISPALYITEM", "");
        $("#MultiTermSearch").append(htmlStr);

        checkSelectSearchBoxItem(childItemCount);
    }

}
//删除搜索框
function removeSearchboxItems(obj) {
    var childItemCount = $(obj).parents("#MultiTermSearch").children(".xiugai").length;
    $(obj).parents(".xiugai").remove();
    var itemIndex = childItemCount - 2;
    $("#MultiTermSearch .xiugai").eq(itemIndex).children("div").each(function () {
        if ($(this).attr("class") == "btn") {// 加减图标操作
            if (itemIndex == 0) {
                $(this).children("a").show();
                $(this).children(".remove").hide();
            }
            else {
                $(this).children("a").show();
            }
        }
        if ($(this).attr("class") == "selectwrap") {//隐藏搜索按钮
            $(this).children("div").show();
        }
    })
}

function checkSelectSearchBoxItem(count) {
    var childItemCount = count == "" || count == undefined || count == null ? 0 : count;
    //遍历页面已经显示的种类，再次添加时剔除已有的种类
    var pHtml = $("#MultiTermSearch .select .item").text();
    var enableClick = true;
    $("#MultiTermSearch .itemlist").eq(parseInt(childItemCount)).children("li").each(function () {

        if (count == 0 && enableClick) {
            $(this).click();
            enableClick = false;
        } else {
            var liHtml = $(this).text();
            if (pHtml.indexOf(liHtml) < 0 && enableClick) {
                $(this).click();
                enableClick = false;
            }
        }
    })
}
/**** 创建高级搜索的方法集 ****/
var searchBoxItemFuns = {
    // 高级检索参数的排序
    paramSortKeyArr: ["content","theme","title","keyWd","author","unit","summary","reference","searchFund","originate","publishTime","mapNumber"],
    // 高级检索参数的中文
    paramSortObj: {"content":"全&nbsp;&nbsp;文","theme":"主&nbsp;&nbsp;题","title":"篇&nbsp;&nbsp;名","keyWd":"关键词","author":"作&nbsp;&nbsp;者","unit":"作者单位","summary":"摘&nbsp;&nbsp;要","reference":"参考文献","searchFund":"基&nbsp;&nbsp;金","originate":"文献来源","publishTime":"发表时间","mapNumber":"中图分类号"},
    // 高级搜索中包含值的检索参数
    paramSortObjHaveValeArr: [],
    paramPublishTimeBeginKey: "publishTimeBegin",
    paramPublishTimeEndKey: "publishTimeEnd",
    // 根据检索参数初始化页面的检索框，快捷搜索和高级搜索区
    initSearchBoxArea: function (param) {
        var isMulitySearch = searchBoxItemFuns.checkIsAdvanceMulitySearch(param);
        if(isMulitySearch){
            var html = searchBoxItemFuns.createMulityTermBySearchParam(param);
            $("#MultiTermSearch").html(html);
            $("#QuickSearch").addClass("displayN");
            $("#MultiTermSearch").removeClass("displayN");
        } else {
            var quickSearchContent = param["theme"];
            quickSearchContent = quickSearchContent == undefined || quickSearchContent == null ? "" : quickSearchContent;
            $("#QuickSearch #textSearchKey").val(quickSearchContent);
            $("#MultiTermSearch input[name=theme]").val(quickSearchContent);
            $("#QuickSearch").removeClass("displayN");
            $("#MultiTermSearch").addClass("displayN");
        }
    },
    // 根据检索参数检查是否为高级检索
    checkIsAdvanceMulitySearch: function (param){
        var paramKeyHaveValueCount = 0;
        for(var i=0;i<searchBoxItemFuns.paramSortKeyArr.length;i++) {
            // if(paramKeyHaveValueCount > 0){
            //     break;
            // }
            var paramSortName = searchBoxItemFuns.paramSortKeyArr[i];
            if (paramSortName != "publishTime") {
                if (param[paramSortName] != undefined && param[paramSortName] != null && param[paramSortName].trim().length > 0) {
                    searchBoxItemFuns.paramSortObjHaveValeArr.push(paramSortName);
                    if(paramSortName == "theme"){
                        continue;
                    }
                    paramKeyHaveValueCount++;
                }
            } else {
                if (param[searchBoxItemFuns.paramPublishTimeBeginKey] != undefined && param[searchBoxItemFuns.paramPublishTimeBeginKey] != null && param[searchBoxItemFuns.paramPublishTimeBeginKey].trim().length > 0
                    && param[searchBoxItemFuns.paramPublishTimeEndKey] != undefined && param[searchBoxItemFuns.paramPublishTimeEndKey] != null && param[searchBoxItemFuns.paramPublishTimeEndKey].trim().length > 0
                    && (param[searchBoxItemFuns.paramPublishTimeBeginKey].trim().indexOf("不") != 0 || param[searchBoxItemFuns.paramPublishTimeEndKey].trim().indexOf("不") != 0)) {
                    searchBoxItemFuns.paramSortObjHaveValeArr.push(paramSortName);
                    paramKeyHaveValueCount++;
                }
            }
        }
        return paramKeyHaveValueCount > 0;
    },
    // 根据检索参数创建高级搜索
    createMulityTermBySearchParam: function (param){
        var htmlStr = "";
        for(var i=0;i<searchBoxItemFuns.paramSortObjHaveValeArr.length;i++){
            var paramSortName = searchBoxItemFuns.paramSortObjHaveValeArr[i];
            var publishTimeBeginArrs = [];
            var publishTimeEndArrs = [];
            if(paramSortName != "publishTime"){
                if(param[paramSortName] == undefined || param[paramSortName] == null || param[paramSortName].trim().length == 0){
                    continue;
                }
                var htmlItem = searchBoxItemFuns.createSearchBoxItemHtml(i, param, paramSortName);
                htmlStr += htmlItem;
            } else {
                //时间段
                //如果时间段参数为空，或者时间段的起止时间均以"不限"开头，则跳过
                if(param[searchBoxItemFuns.paramPublishTimeBeginKey] == undefined || param[searchBoxItemFuns.paramPublishTimeBeginKey] == null || param[searchBoxItemFuns.paramPublishTimeBeginKey].trim().length == 0
                || param[searchBoxItemFuns.paramPublishTimeEndKey] == undefined || param[searchBoxItemFuns.paramPublishTimeEndKey] == null || param[searchBoxItemFuns.paramPublishTimeEndKey].trim().length == 0){
                    continue;
                } else if(param[searchBoxItemFuns.paramPublishTimeBeginKey].trim().indexOf("不") == 0 && param[searchBoxItemFuns.paramPublishTimeEndKey].trim().indexOf("不") == 0){
                    continue;
                }
                //时间起止字段数组长度不相同时忽略
                publishTimeBeginArrs = param[searchBoxItemFuns.paramPublishTimeBeginKey].split("|");
                publishTimeEndArrs = param[searchBoxItemFuns.paramPublishTimeEndKey].split("|");
                if(publishTimeBeginArrs ==0 || publishTimeBeginArrs.length != publishTimeEndArrs.length){
                    continue;
                }
                for (var j=0;j<publishTimeBeginArrs.length;j++){
                    //如果时间起止字段为空，则跳过
                    if(publishTimeBeginArrs[j].trim().length == 0 && publishTimeEndArrs[j].trim().length == 0){
                        continue;
                    }
                    var htmlItem = searchBoxItemFuns.createSearchBoxItemHtml(i, param, paramSortName, publishTimeBeginArrs[j], publishTimeEndArrs[j]);
                    htmlStr += htmlItem;
                }
            }
        }
        return htmlStr;
    },
    //创建高级搜索单项搜索内容的html
    createSearchBoxItemHtml: function (index, param, paramSortName, timeBegin, timeEnd){
        var htmlItem = "<div class=\"xiugai clearfix word5\">";
        // 下标小于最后一个，并且检索参数数量大于1，则不显示添加按钮
        var btn_add_index_display = index < searchBoxItemFuns.paramSortObjHaveValeArr.length-1 ? "displayN" : "";
        var btn_del_index_display = searchBoxItemFuns.paramSortObjHaveValeArr.length == 1 ? "displayN" : "";

        //+-符号
        var html_btn = "<div class=\"btn\" id=\"btn\">\n" +
            "                          <a class=\"remove "+btn_del_index_display+"\" onclick=\"removeSearchboxItems(this)\" href=\"javascript:void(0)\"></a>\n" +
            "                          <a class=\"add "+btn_add_index_display+"\" onclick=\"addMulitySearchboxItems(this)\" href=\"javascript:void(0)\"></a>\n" +
            "                  </div>";
        htmlItem += html_btn;

        //下拉列表+搜索值+搜索按钮 的外框
        var html_selectwrap = "<div class=\"selectwrap\" id=\"selectwrap\" style=\"z-index: 1;\">";

        var html_select_advance = "<div class=\"select selectadvance " + (paramSortName=='publishTime' ? "selectspec" : "") +"\" style=\"z-index: 1;\">";
        html_select_advance += "<p class=\"item\" data-code=\""+paramSortName+"\">" + searchBoxItemFuns.paramSortObj[paramSortName]  + "</p>";
        if(paramSortName != "publishTime"){
            html_select_advance += "<input name=\""+paramSortName+"\" class=\"left MulSerchKey\" autocomplete=\"off\" type=\"text\" value=\""+param[paramSortName].trim()+"\" style=\"\" maxlength=\"100\"/>";
            html_select_advance += "<a class=\"positionA sweep\" href=\"javascript:void(0)\" style=\"display:block;\"></a>";
            html_select_advance += "<div class=\"history advance\"></div>";
            html_select_advance += searchBoxItemFuns.createYearSelectHtml();
            html_select_advance += searchBoxItemFuns.createSelectItemListHtml();
        } else {
            timeBegin = timeBegin == undefined ? "不&nbsp;&nbsp;限" : timeBegin;
            timeBegin = timeBegin.length > 4 ? timeBegin.substring(0, 4) : timeBegin;
            timeEnd = timeEnd == undefined ? "不&nbsp;&nbsp;限" : timeEnd;
            timeEnd = timeEnd.length > 4 ? timeEnd.substring(0, 4) : timeEnd;
            var show_timeBegin = timeBegin.indexOf("不") == -1 ? timeBegin+"年" : timeBegin.replace(" ", "&nbsp;");
            var show_timeEnd = timeEnd.indexOf("不") == -1 ? timeEnd+"年" : timeEnd.replace(" ", "&nbsp;");
            html_select_advance += "<input name=\""+paramSortName+"\" class=\"left MulSerchKey\" autocomplete=\"off\" type=\"text\" value=\""+show_timeBegin+";"+show_timeEnd+"\" style=\"display: none;\" maxlength=\"100\">";
            html_select_advance += searchBoxItemFuns.createYearSelectHtml(true, show_timeBegin, show_timeEnd);
            html_select_advance += searchBoxItemFuns.createSelectItemListHtml();
        }
        html_select_advance += "</div>";
        html_selectwrap += html_select_advance;

        //搜索按钮
        var html_search_btn = "<div class=\"searchwrap positionA "+btn_add_index_display+"\">\n" +
            "                             <a class=\"search\" href=\"javascript:void(0)\" id=\"search\" onclick=\"Search()\">搜索</a>\n" +
            "                                 <a href=\"javascript:void(0)\" style=\"right:-65px;padding-bottom:8px;\" class=\"positionA gj kuaijie\">快捷搜索</a>\n" +
            "                         </div>";
        html_selectwrap += html_search_btn;
        html_selectwrap += "</div>"
        htmlItem += html_selectwrap;

        htmlItem += "</div>";
        return htmlItem;
    },
    createYearSelectHtml: function(setHiddenel, timeBegin, timeEnd){
        setHiddenel = setHiddenel == undefined ? false : setHiddenel;
        timeBegin = timeBegin == undefined ? "不&nbsp;&nbsp;限" : timeBegin;
        timeEnd = timeEnd == undefined ? "不&nbsp;&nbsp;限" : timeEnd;
        var yearSelectDisplay = setHiddenel ? "" : "displayN";
        var html_yearAsc = searchBoxItemFuns.createYearsSelectOptionsHtml(true);
        var html_yearDesc = searchBoxItemFuns.createYearsSelectOptionsHtml(false);
        var html = "<div class=\"yearwrap "+yearSelectDisplay+"\">\n" +
            "                  <div class=\"fromwrap left positionR\">\n" +
            "                      <i class=\"left\">从</i>\n" +
            "                      <p class=\"p from right positionR\">\n" +
            "                              <b>"+timeBegin+"</b>\n" +
            "                              <span class=\"positionA\"></span>\n";
        if(setHiddenel) {
            html += "                              <input type=\"hidden\" name=\"publishtimebegin\" value=\"" + timeBegin + "\" maxlength=\"100\">";
        }
        html += "                      </p>\n" +
            "                      <ul class=\"fromlist positionA displayN\" style=\"display: none;\">\n" + html_yearAsc + "</ul>\n" +
            "                  </div>\n" +
            "                  <div class=\"towrap left positionR\">\n" +
            "                      <i class=\"left\">到</i>\n" +
            "                      <p class=\"p to right positionR\">\n" +
            "                              <b>"+timeEnd+"</b>\n" +
            "                              <span class=\"positionA\"></span>\n";
        if(setHiddenel) {
            html += "                              <input type=\"hidden\" name=\"publishtimeend\" value=\"" + timeEnd + "\" maxlength=\"100\">";
        }
        html += "                      </p>\n" +
            "                      <ul class=\"tolist positionA displayN\" style=\"display: none;\">\n" + html_yearDesc + "</ul>\n" +
            "                  </div>\n" +
            "              </div>"
        return html;
    },
    createYearsSelectOptionsHtml: function(ascSort){
        // var currentYear = new Date().getFullYear();
        // var startYear = 1979;
        var html = "<li class=\"ndy\">不&nbsp;&nbsp;限</li>\n";
        if(ascSort){
            html += "<li>1915年</li>\n<li>1949年</li>\n";
            // for(var i = startYear; i<=currentYear; i++){
            //     html += "<li>"+i+"年</li>\n";
            // }
        } else {
            // for(var i = currentYear; i>=startYear; i--){
            //     html += "<li>"+i+"年</li>\n";
            // }
            html += "<li>1949年</li>\n<li>1915年</li>\n";
        }
        return html;
    },
    createSelectItemListHtml: function (){
        html = "<ul class=\"itemlist\" style=\"display: none;\">\n" +
                "    <li val=\"content\">全&nbsp;&nbsp;文</li>\n" +
                "    <li val=\"theme\">主&nbsp;&nbsp;题</li>\n" +
                "    <li val=\"title\">篇&nbsp;&nbsp;名</li>\n" +
                "    <li val=\"keywd\">关键词</li>\n" +
                "    <li val=\"author\">作&nbsp;&nbsp;者</li>\n" +
                "    <li val=\"unit\">作者单位</li>\n" +
                "    <li val=\"summary\">摘&nbsp;&nbsp;要</li>\n" +
                "    <li val=\"reference\">参考文献</li>\n" +
                "    <li val=\"searchfund\">基&nbsp;&nbsp;金</li>\n" +
                "    <li val=\"originate\">文献来源</li>\n" +
                "    <li val=\"publishtime\" class=\"fbsj\">发表时间</li>\n" +
                "    <li val=\"mapnumber\">中图分类号</li>\n" +
                "</ul>";
        return html;
    }
};

/****刊内搜索***/
//添加 搜索框
function addInternalSearchBoxItems(obj) {
    var htmlStr = $("#InteralSelectTemplate").html();
    var childItemCount = $("#InternalSearchBox").find(".xiugai").length;
    var itermLength = $("#InteralSelectTemplate .itemlist").find("li").length;
    if (parseInt(childItemCount) < itermLength && childItemCount < 7) {//搜索输入框不能超过7个
        $("#InternalSearchBox .xiugai .add").each(function (index) {
            $(this).siblings(".remove").removeClass("displayN");
            $(this).addClass("displayN");
            $(this).closest("div").siblings("#selectwrap").children(".searchwrap").addClass("displayN");
        })

        $("#InternalSearchBox").append(htmlStr);

        //遍历页面已经显示的种类，再添加时剔除
        var pHtml = $("#InternalSearchBox .select .item").text().replace(/\s*/g, '');
        var enableClick = true;
        $("#InternalSearchBox .itemlist").eq(parseInt(childItemCount)).children("li").each(function () {
            var liHtml = $(this).text().replace(/\s*/g, '');
            if (pHtml.indexOf(liHtml) < 0 && enableClick) {
                $(this).click();
                enableClick = false;
            }
        })
    }

}

//删除搜索框
function removeInternalSearchBoxItems(obj) {
    var childItemCount = $(obj).parents("#InternalSearchBox").children(".xiugai").length;
    $(obj).parents(".xiugai").remove();
    var itemIndex = parseInt(childItemCount) - 2;
    $("#InternalSearchBox .xiugai").eq(itemIndex).children("div").each(function () {
        if ($(this).attr("class") == "btn") {// 加减图标操作
            if (itemIndex == 0) {
                $(this).children("a").removeClass("displayN");
                $(this).children(".remove").addClass("displayN");
            }
            else {
                $(this).children("a").removeClass("displayN");
            }
        }
        if ($(this).attr("class") == "selectwrap") {//隐藏搜索按钮
            $(this).children("div").removeClass("displayN");
        }
    })
}

/***刊内搜索***/



/*!
 * Date: 2015-11-12
 */
function literatureSearch() {
    //填充时间下拉列表时间
    var start = 1980; // 指定开始年份
    var end = new Date().getFullYear(); // 获取当前年份
    for (i = start; i <= end; i++) {
        $(".fromlist").append("<li>" + i + "年</li>");
        $(".tolist .ndy").after("<li>" + i + "年</li>");
    }


    //下拉列表点击事件
    $(".select .item").live("click", function () {
        $(".select .itemlist").hide();
        $(this).siblings(".itemlist").show();
        $(this).parent(".select").css({ "z-index": "2000" });//ie6、7修正
        $(this).parents(".selectwrap").css({ "z-index": "1000" });//ie6、7修正
    });

    //全文、主题、篇名等鼠标经过事件
    $(".select .itemlist").live("mouseover", function (e) {
        $(this).show();
        $(this).parent(".select").css({ "z-index": "2000" });
        $(this).parents(".selectwrap").css({ "z-index": "1000" })
        e.stopPropagation();//阻止冒泡
    }).live("mouseout", function (e) {
        $(this).hide();
        $(this).parent(".select").css({ "z-index": "1001" });
        $(this).parents(".selectwrap").css({ "z-index": "1001" });
        e.stopPropagation();//阻止冒泡
    });

    //全文、主题、篇名等鼠标经过加深背景
    $(".select .itemlist li").live("mouseover", function (e) {
        $(this).addClass("gray");
        e.stopPropagation();//阻止冒泡

    }).live("mouseout", function (e) {
        $(this).removeClass("gray");
        e.stopPropagation();//阻止冒泡
    });

    //全文、主题、篇名等列表点击事件
    $(".select .itemlist li").live("click", function (e) {
        var Text = $(this).text();
        $(this).parent(".select .itemlist").siblings(".item").text(Text);
        $(this).parent(".select .itemlist").hide();
        $(this).parent(".select").css({ "z-index": "1011" });
        $(this).parents(".selectwrap").css({ "z-index": "1011" });
        $(this).parent(".select .itemlist").removeClass("itemlistspec");
        $(this).parents(".select").removeClass("selectspec");
        $(this).parent().siblings("input").css({ "display": "block" });
        $(this).parent().siblings(".yearwrap").css({ "display": "none" });

        //给除时间以外的Input添加 name属性
        if ($(this).attr("val") != undefined) {
            $(this).parent().siblings("input").attr("name", $(this).attr("val"))
        }
        //移除时间input 标签
        if (!$(this).hasClass(".fbsj")) {
            $(this).parent().siblings(".yearwrap").find("input").remove()
        }
        e.stopPropagation();//阻止冒泡

    });


    //发表时间点击事件
    $(".select .itemlist .fbsj").live("click", function () {
        $(this).parent(".select .itemlist").addClass("itemlistspec");
        $(this).parents(".select").addClass("selectspec");
        $(this).parent().siblings("input").css({ "display": "none" });
        $(this).parent().siblings(".yearwrap").css({ "display": "block" })
        //添加时间input 标签 用于form 提交 并赋值
        $(this).parent().siblings(".yearwrap").find(".fromwrap ul  li").eq(0).click();
        $(this).parent().siblings(".yearwrap").find(".towrap ul li").eq(0).click();
    });

    var yearwarpP = $(".yearwrap .p");

    //鼠标经过和离开时间选择下拉列表
    yearwarpP.live("hover",
        function (event) {
            if (event.type == 'mouseenter')
                $(this).addClass("hoverp");

            else
                $(this).removeClass("hoverp");
        })

    //点击下拉列表
    yearwarpP.live("click", function () {

        $(".yearwrap ul").css({ "display": "none" });
        $(this).removeClass("clickp");
        $(this).parents(".selectspec").css({ "z-index": 100 });
        $(this).parents(".selectwrap").css({ "z-index": 10 });
        $(this).parent().find("ul").css("display", "block");

        $(this).addClass("clickp");
    })


    //时间鼠标经过和离开效果
    $(".yearwrap ul li").live("mouseover", function () {
        $(this).addClass("hover");
    }).live("mouseout", function () {
        $(this).removeClass("hover");
    });

    //鼠标点击事件效果
    $(".select .yearwrap ul li").live("click", function () {
        var Text = $(this).text();
        $(this).parent("ul").siblings(".p").children("b").text(Text);
        $(this).parent("ul").hide();
        $(".select .itemlist").removeClass("itemlistspec");
        //给Input赋值
        if ($(this).parents("div").first().hasClass("fromwrap")) {
            var hpublishTimeBegin = '<input type="hidden" name="publishtimebegin" value="" />';
            if ($(this).parent("ul").siblings(".p").children("input").val() == undefined) {
                $(this).parent("ul").siblings(".p").append(hpublishTimeBegin);
            }
            $(this).parent("ul").siblings(".p").children("input").val(Text);
        } else if ($(this).parents("div").first().hasClass("towrap")) {
            var hpublishTimeEnd = '<input type="hidden" name="publishtimeend" value="" />';
            if ($(this).parent("ul").siblings(".p").children("input").val() == undefined) {
                $(this).parent("ul").siblings(".p").append(hpublishTimeEnd);
            }
            $(this).parent("ul").siblings(".p").children("input").val(Text);
        }
        //exchangeYearSelect($(this).parents(".yearwrap").first());
    });

    //鼠标离开时间下拉列表效果
    $(".select .yearwrap ul").hover(function () {
        $(this).css({ "display": "block" });
    }, function () {
        $(this).css({ "display": "none" });
        $(this).siblings(".p").removeClass("clickp");
    })

    //点击鼠标下拉框收起
    /*$("body").click(function()
	{
		$(".select ul").hide();
		$(".select").css({"z-index":"101"});
		$(".selectwrap").css({"z-index":"101"});
		$(".yearwrap .p").removeClass("clickp");
	})*/

}
//同一行的时间 如果开始时间大于结束时间，交换两者的位置
function exchangeYearSelect(obj) {
    var reg = /[\u4E00-\u9FA5\uF900-\uFA2D]/g;
    var startTimeObj = $(obj).find(".from b");
    var endTimeObj = $(obj).find(".to b");
    var startTime = $(startTimeObj).html().replace(reg, "");
    var endTime = $(endTimeObj).html().replace(reg, "");
    if (!isNaN(startTime) && !isNaN(endTime)) {
        if (startTime > endTime) {
            var tmp = $(startTimeObj).html();
            $(obj).find("input[name='publishtimebegin']").val($(endTimeObj).html());
            $(obj).find("input[name='publishtimeend']").val(tmp);
        }
    }
}

//声明一个全局变量
var tempkeytipitemcheckedindex = -1;
/// 历史查找；
/// 查找提示；
function remember() {
    var time = 0;
    //打开历史
    $("#textSearchKey,.MulSerchKey").live("click", function () {
        var sourceId = $(this);
        $(this).parents(".select").first().css("z-index", "1");
        $(this).parents(".selectwrap").first().css("z-index", "2");
        appendTipsFromCookie(sourceId, $(this).val());
        tempkeytipitemcheckedindex = -1;
    })

    //关闭历史
    $(".cmd .c").live("click", function () {
        DomainSetCookie("HISTORY", "FALSE", 7);
    })

    $("#textSearchKey,.MulSerchKey").live("blur", function () {
        var history = $(this).siblings(".history");
        setTimeout(function () { history.slideUp(0); }, 200);
        tempkeytipitemcheckedindex = -1;
    })

    //删除 历史记录
    $(".history .d").live("click", function () {
        DomianRemoveCookie("KEYWORD");
    })

    //根据输入文字 提示
    $("#textSearchKey,.MulSerchKey").live("keyup", function (event) {
        var code = event.keycode ? parseInt(event.keycode) : parseInt(event.which);
        var value = $(this).val();
        if (isNaN(code)) return true;
        var sourceId = $(this).hasClass("MulSerchKey") ? this : ("#" + $(this).attr("id"));
        if (code != 38 && code != 40) {
            $(".history p").remove();
            var keyStr = $(this).val();
            appendTipsFromCookie(sourceId, keyStr);
        }
    })

    $("#textSearchKey,.MulSerchKey").live("keydown", function (event) {
        var code = event.keycode ? parseInt(event.keycode) : parseInt(event.which);
        var targId = $(this).siblings(".history");
        if (isNaN(code)) return true;
        if (code == 38 || code == 40) {
            if (code == 38)
                tempkeytipitemcheckedindex--;
            else
                tempkeytipitemcheckedindex++;
            if ($(targId).find("p").length > 0) {
                //$(targId).slideDown(time);
                if (targId.find("p")) {
                    var len = targId.find("p").length;
                    targId.find("p").removeClass("hover");
                    tempkeytipitemcheckedindex = tempkeytipitemcheckedindex >= len ? 0 : tempkeytipitemcheckedindex;
                    tempkeytipitemcheckedindex = tempkeytipitemcheckedindex < 0 ? len - 1 : tempkeytipitemcheckedindex;
                    targId.find("p").eq(tempkeytipitemcheckedindex).addClass("hover");
                    $(this).val(targId.find("span").eq(tempkeytipitemcheckedindex).html());
                }
            }
            return false;
        }
        else if (code == 13) {
            if ($(this).hasClass("kj")) { //查找 跳转页面
                writeCookie();
                QuickSearch();
            } else {
                //高级搜索
                if ($(".head-wrap").html() != undefined) {
                    $(".head-wrap .search:visible").click();
                } else
                    $(".home-cont .search:visible").click();

            }

            return false;
        }
        else if (code == 9)
            return false;
    })
}

//写提示词语到Cookie中
function writeCookie() {
    if (!checkHistoryEnabled()) {
        return false;
    }

    var keywordList = $.cookie("KEYWORD");
    if (keywordList == undefined || keywordList == null) { keywordList = ""; }

    var historyArry = new Array();

    var savedWordArry = keywordList.split('$');

    for (var i = 0; i < savedWordArry.length; i++) {
        //console.log(savedWordArry[i]);
        if (savedWordArry[i] != "") {
            if (!checkHtmlStr(savedWordArry[i])) {
                historyArry[i] = savedWordArry[i];
            }
        }
    }
    $("input[type='text']:visible").each(function (index) {
        var keyWord = $(this).val();
        //过滤掉Html字符串
        if (keyWord != "" && !checkHtmlStr(keyWord)) {
            var arryIndex = $.inArray(keyWord, historyArry);
            if (arryIndex != -1) {
                historyArry.splice(arryIndex, 1);
            }
            historyArry.splice(index, 0, keyWord);
        }
    })
    historyArry = historyArry.length > 10 ? historyArry.slice(0, 9) : historyArry;
    //console.log(historyArry);
    keywordList = historyArry.length > 0 ? historyArry.join("$") : "";
    if (keywordList != "") {
        DomainSetCookie("KEYWORD", keywordList, 7);
    }
}

function DomainSetCookie(name, value, days) {
    $.cookie(name, value, { expires: days, path: '/' });
}

function DomianRemoveCookie(name) {
    $.cookie(name, "", { expires: 0, path: '/' });
}

//打开历史纪录
function openHistory() {
    DomianRemoveCookie("HISTORY");
}

//关闭历史纪录
function shutDownHistory() {
    DomainSetCookie("HISTORY", "FALSE", 7);
}
//清除历史纪录
function clearHistory() {

    if (confirm("您确定要清除您的搜索记录吗？")) {
        DomianRemoveCookie("KEYWORD");
    }
}

///校验是否已经关闭历史纪录
function checkHistoryEnabled() {
    var enableHistory = $.cookie("HISTORY") != "FALSE";
    if (!enableHistory) {
        return false;
    }
    return true;
}
//删除历史纪录中的一项
function deleteKeywordItem(obj) {
    var keyword = $(obj).siblings("span").html();
    var cookie = $.cookie("KEYWORD");
    var arry = cookie.split('$');

    for (var i = 0; i <= arry.length; i++) {
        if (arry[i] == keyword) {
            arry.splice(i, 1);
        }
    }
    $(obj).parents("p").first().remove();

    cookie = arry.length > 0 ? arry.join("$") : "";

    DomainSetCookie("KEYWORD", cookie, 7);
}

//点击提示词 如果当前搜索是快捷搜索 查找并跳转页面
function clickTip(obj) {
    var parentID = $(obj).parents(".choose").first().attr("id");
    if (parentID == "QuickSearch") {
        $("#textSearchKey").val($(obj).find("span").html());
        writeCookie();
        QuickSearch();
    } else {
        $(obj).parents(".history").first().siblings("input").val($(obj).find("span").html());
    }

}
//鼠标事件
function mouseoverEvent(obj) {
    $(obj).addClass("hover").children(".clear").css("display", "block");
}
function mouseoutEvent(obj) {
    $(obj).removeClass("hover").children(".clear").css("display", "none");
}

function callbackRecommandWords(data) {
    if (data == null || data.length <= 0) {
        $("#recommandWordsTable").html("");
    }
    if (data == '' || data == undefined) {
        return false;
    }

    var strDataArr = null;
    if (typeof (data) == "string")
        strDataArr = data.replace(/|/g, "").split(";");
    else if (typeof ("object"))
        strDataArr = data;
    var len = strDataArr.length;
    if (len > 0) {
        var html = "<h1>相关搜索</h1>\n";
        html += "<table class=\"table2\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"632\">\n";
        for (var i = 0; i < len && i < 8; i++) {
            if (i % 4 == 0) {
                if (i > 0)
                    html += "</tr>\n";
                html += "<tr height=\"26\">\n";
            }
            html += "<td width=\"158\"><a href=\"" + searchConditionPara.DoMainSearch + "/Search/Result?content=" + encodeURI(strDataArr[i]) + "\" title=\"" + strDataArr[i] + "\" target=\"_blank\" onclick=\"return true;\">" + subbybyte(strDataArr[i], 16, true) + "</a></td>\n";
            if (i == 7 || i == len - 1) {
                html += "</tr>\n";
            }
        }
        html += "</table>\n";
        $("#recommandWordsTable").html(html);
    }
    else {
        $("#recommandWordsTable").html("");
    }
}

//Html结构转字符串形式显示 支持<br>换行
function ToHtmlString(htmlStr) {
    return toString(htmlStr).replace(/\&lt\;br[\&ensp\;|\&emsp\;]*[\/]?\&gt\;|\r\n|\n/g, "<br/>");
}
//Html结构转字符串形式显示
function toString(str) {
    var RexStr = /\<|\>|\"|\'|\&|　| /g
    str = str.replace(RexStr, function (MatchStr) {
        switch (MatchStr) {
            case "<":
                return "&lt;";
                break;
            case ">":
                return "&gt;";
                break;
            case "\"":
                return "&quot;";
                break;
            case "'":
                return "&#39;";
                break;
            case "&":
                return "&amp;";
                break;
            case " ":
                return "&ensp;";
                break;
            case "　":
                return "&emsp;";
                break;
            default:
                break;
        }
    });
    return str;
}

//校验字符串中是否包含html标签  如果包含则过滤掉
function checkHtmlStr(htmlStr) {
    var reg = /<|>/g;
    return reg.test(htmlStr);
}
//从Cookie中绑定数据
function appendTipsFromCookie(sourceID, str) {
    if (!checkHistoryEnabled()) {
        $(sourceID).siblings(".history").hide();
        return false;
    }
    var keyword = $.cookie("KEYWORD");

    if (keyword == undefined || keyword == null || keyword == "") { $(".history").slideUp(0); return false; }
    var arry = keyword.split('$');
    var targID = $(sourceID).siblings(".history");
    $(targID).html("");
    $(arry).each(function (index, val) {
        if (index < 15 && val != "") {
            if (str == "")
                $(targID).append("<p onmouseover=\"mouseoverEvent(this)\" onmouseout=\"mouseoutEvent(this)\" onclick=\"clickTip(this)\"><span class=\"text\"  >" + val + "</span><a class=\"clear\" onclick='deleteKeywordItem(this)' href=\"javascript:void(0)\"></a></p>");
            else if (val.indexOf(str) >= 0)
                $(targID).append("<p onmouseover=\"mouseoverEvent(this)\" onmouseout=\"mouseoutEvent(this)\" onclick=\"clickTip(this)\"> <span class=\"text\" >" + val + "</span><a class=\"clear\" onclick='deleteKeywordItem(this)'  href=\"javascript:void(0)\"></a></p>");
        }
    })

    if ($(sourceID).val() == "")
        $(targID).append("<div class='cmd'><a class='c' href='javascript:void(0)'>关闭历史</a> | <a class='d' href='javascript:void(0)'>删除历史</a></div>");

    $(targID).slideDown(0);
    CheckHistory();
}

function CheckHistory() {
    if ($(".history p").length <= 0) {
        $(".history").slideUp(0);
    }
}
//添加监听事件
function O(G, U, C) {
    if (cnkibrowser.length == undefined || cnkibrowser.length <= 0)
        userBrowser();
    if (cnkibrowser.msie) {
        if (U == "load") {
            if (cnkibrowser.version >= 11) {
                //从IE11开始不支持 onreadystatechange，开始使用onload；
                //参考：https://msdn.microsoft.com/en-us/library/ms536957(v=vs.85).aspx  Remarks
                G.onload = function () {
                    if (document.readyState == "complete") {
                        C();
                    }
                }
            }
            else
                G.onreadystatechange = function () {
                    if (this.readyState == "loaded") {
                        C();
                    }
                }
        }
        else
            G.attachEvent("on" + U, (function (V) { return function () { C.call(V) } })(G));
    }
    else {
        G.addEventListener(U, C, false)
    }
}
//做跨域脚本支持
function CoreDomainLoadJson() {
    this.C;
    this.J = function (c) { return document.createElement(c) };
    this.O = O;
    this.Load = function (src, onJsonLoaded, id) {

        //提示词申请最后一次js加载有效
        var oldscript = document.getElementById(id);
        if (oldscript) {
            document.body.removeChild(oldscript);
        }
        this.C = this.J("SCRIPT");
        if (typeof id == "string" && id.length > 0) {
            this.C.id = id;
        }
        else {
            this.C.id = "callScriptE";
        }
        this.C.src = src + "&td=" + (new Date()).getTime();
        this.C.charset = "utf-8";
        document.body.appendChild(this.C);
        O(this.C, "load", onJsonLoaded);
    }
}
//比结果中选择文献添加到cookie
function getActionID() {
    var myDate = new Date();
    var year = myDate.getFullYear().toString();
    var month = (myDate.getMonth() + 1).toString();
    var day = myDate.getDate().toString();
    if (month.length == 1) {
        month = "0" + month;
    }
    if (day.length == 1) {
        day = "0" + day;
    }
    var actionID = year + month + day;
    return actionID;
}
var citeBtn_marginleft = "-651px";
function initSelectedRefItemsBindEvent() {
    citeBtn_marginleft = $('.citeBtn').css("margin-left");
    if (document.body.clientWidth < 1300) {
        $('.citeBtn').css("left", 0).css("margin-left", 0);
    }
    $(window).resize(function () {
        if (document.body.clientWidth < 1300) {
            $('.citeBtn').css("left", "0").css("margin-left", "0");
        } else {
            $('.citeBtn').css("left", "50%").css("margin-left", citeBtn_marginleft);
        }
    });

    //打开
    $('.citeBtn').click(function () {
        if (!isHasShowSelectBox) {
            setSelectBoxToolBarView(true);
        } else {
            setSelectBoxToolBarView(false);
        }
    });

    //全选
    $('.bottomBar li.item1 label').click(function () {
        if (!$(this).find('i').hasClass('active')) {
            $(this).find('i').addClass('active');
            $('.resault-cont .cont-left .checkbox1').addClass('active');
            checkAll();
        }
        else {
            $(this).find('i').removeClass('active');
            $('.resault-cont .cont-left .checkbox1').removeClass('active');
            clearAllMarks();
        }
    });
    //全部清除
    $('.bottomBar li.item2 a').click(function () {
        $('.resault-cont .cont-left .checkbox1, .bottomBar li.item1 label i').removeClass('active');
        setCookie("FileNameS", "");
        updateCounter();
    });
    //添加或删除单个文献
    $('.resault-cont .cont-left').on('click', '.checkbox1', function (event) {
        //$(this).toggleClass('active');
        var fn = $(this).attr("data-fn");
        if (!$(this).hasClass('active')) {
            checkMark(fn, true);
            if (cnkibrowser.length == undefined || cnkibrowser.length <= 0)
                userBrowser();
            if (!cnkibrowser.msie || (cnkibrowser.msie && cnkibrowser.version > 9)) {
                if (typeof (play_fly) == "function") {
                    play_fly(event);
                }
            }
            //$('.resault-cont .cont-left .re-table .checkbox1[data-fn="'+fn+'"]').addClass("active");
            //$('.resault-cont .cont-left .lplist .checkbox1[data-fn="' + fn + '"]').addClass("active");
            //play(event);
            //addToCookie(fn);
            //var selectedCount = $('.resault-cont .cont-left .lplist .checkbox1[class$="active"]').length;
            //if (typeof (searchConditionPara) != 'undefined' && selectedCount == searchConditionPara.pageSize) {
            //    $('.bottomBar li.item1 label i').addClass('active');
            //}
        } else {
            checkMark(fn, false);

            //$('.resault-cont .cont-left .re-table .checkbox1[data-fn="' + fn + '"]').removeClass("active");
            //$('.resault-cont .cont-left .lplist .checkbox1[data-fn="' + fn + '"]').removeClass("active");
            //removeFromCookie(fn);
            //$('.bottomBar li.item1 label i').removeClass('active');
        }
        //updateCounter();
    });
    //打开参考
    $('.bottomBar li.item4 a').click(function () {
        clickOpen(referenceServerUrl);
    });
    //关闭
    $('.bottomBar .close').click(function () {
        $('.citeBtn').click();
    })
}

function setSelectBoxToolBarView(isHasShow) {
    if (isHasShow) {
        $('.resault-cont .cont-left .list-item .checkbox1').css("display", "block");
        $('.resault-cont .cont-left .re-table tr').find('td:first .checkbox1').show().css("display", "block").siblings('.index').hide();
        $('.bottomBar').show();
        isHasShowSelectBox = true;
    } else {
        $('.resault-cont .cont-left .list-item .checkbox1').hide();
        $('.resault-cont .cont-left .re-table tr').find('td:first .checkbox1').hide().siblings('.index').show();
        $('.bottomBar').hide();
        isHasShowSelectBox = false;
    }
}
var isHasShowSelectBox = false;
function updateCounter() {
    var count = numMarked();
    $(".bottomBar .inner .item3 i").html(count);
}
function numMarked() {
    company = "cnki";
    cookie = new String(getCookie("FileNameS"));
    if ((cookie.substring(0, cookie.indexOf(":")) != company) || cookie.length <= 5) {
        return 0;
    }
    a = cookie.split(",");
    return a.length - 1;
}
function getErrorMsg(count) {
    count = count || '50';
    var msg = '';
    if (!window.localStorage || !window.sessionStorage) {
        msg = '如要选择更多，请您升级浏览器到最新版本。';
    } else {
        msg = '不能超过' + count + '个,若要重新选择,请按清除按钮,再进行选取操作';
    }
    return msg;
}
function clickOpen(url) {
    if (numMarked() == 0) {
        alert('请先选取文献');
        return;
    }
    var fns = "";
    company = "cnki";
    var cookie = new String(getCookie("FileNameS"));
    if ((cookie.length > 0) && ((cookie.substring(0, cookie.indexOf(':')) == company))) {
        fns = cookie.substring(company.length + 1);
    }
    var param = new Object();
    param.id = fns.replace(/.NH,/g, ".nh,").replace(/,/g, ";");
    var form1 = createActionForm(param, url, "post", "_blank");
    //windowOpener(url);
    if (form1 != null) {
        $(form1).submit();
    }
}
function checkAll(stype) {
    var limit = 500;
    if (!window.localStorage || !window.sessionStorage) { limit = 50; };
    //$("#showType").val() == 0 时取lplist
    //$("#showType").val() == 1 时取re-table

    var allCheckedEl = $('.resault-cont .cont-left .lplist .checkbox1');
    //if ($("#showType").val() == "0") {
    //    allCheckedEl = $('.resault-cont .cont-left .lplist .checkbox1[class$="active"]');
    //}
    //else {
    //    allCheckedEl = $('.resault-cont .cont-left .re-table .checkbox1[class$="active"]');
    //}
    $(allCheckedEl).each(function () {
        var fn = $(this).attr("data-fn");
        addToCookie(fn);
    });
    updateCounter();
    return true;

    //var e = document.forms[0].elements;
    //for (i = 0; i < e.length; i++) {
    //    if (e[i].type == "checkbox" && e[i].name == "FileNameS") {
    //        if (numMarked() >= limit) {
    //            this.checked = false;
    //            alert(getErrorMsg(limit));
    //            return false;
    //        } else {
    //            if (e[i].checked == false) {
    //                if (document.cookie.length + e[i].value.length > 4096) {
    //                    alert(getErrorMsg(limit));
    //                    return false;
    //                }
    //                addToCookie(e[i].value);
    //                e[i].checked = true;
    //            }
    //        }
    //    }
    //}
}
function clearAllMarks() {
    var allCheckedEl = $('.resault-cont .cont-left .lplist .checkbox1');
    $(allCheckedEl).each(function () {
        var fn = $(this).attr("data-fn");
        removeFromCookie(fn);
    });
    updateCounter();
    //if ($("#showType").val() == "0")
    //    allCheckedEl = $('.resault-cont .cont-left .lplist .checkbox1[class$="active"]')
    //else
    //    allCheckedEl = $('.resault-cont .cont-left .re-table .checkbox1[class$="active"]');

    //e = document.forms[0].elements;
    //for (i = 0; i < e.length; i++) {
    //    if (e[i].type == "checkbox" && e[i].name == "FileNameS") {
    //        removeFromCookie(e[i].value);
    //        e[i].checked = false;
    //    }
    //}
}
function getCookie(Name, stype) {
    stype = "1";
    if (window.localStorage || window.sessionStorage) {
        if (stype == '2')
            return window.sessionStorage.getItem(Name);
        return window.localStorage.getItem(Name);
    }
    var search = Name + "=";
    if (document.cookie.length > 0) {
        offset = document.cookie.indexOf(search);
        if (offset != -1) {
            offset += search.length;
            end = document.cookie.indexOf(";", offset);
            if (end == -1)
                end = document.cookie.length;
            return unescape(document.cookie.substring(offset, end));
        }
    }
}
function setCookie(name, value, stype) {
    stype = "1";
    if (window.localStorage || window.sessionStorage) {
        if (stype == '2') {
            window.sessionStorage.setItem(name, value);
        }
        else {
            localStorage.setItem(name, value);
        }
        return true;
    }
    var cookieValue = name + "=" + escape(value) + ";" + "path=/";
    if (cookieValue.length > 4096) {
        return false;
    }
    document.cookie = cookieValue;
    return true;
}
function getTableNameFileNames(s) {
    if (!s || s.length <= 0) { return ''; }
    var tempArr = s.split('!');
    if (tempArr.length == 4) {
        return tempArr[0] + '!' + tempArr[1];
    }
    return '';
}
function handlerRegexSpcileChar(input) {
    if (input) {
        return input.replace(/[\(|\)|\+|\.|\*]/g, function (m) { return '\\' + m; });
    }
    return input;
}
function addToCookie(v) {
    v = v.toUpperCase()
    company = "cnki";
    cookie = new String(getCookie("FileNameS"));
    if ((cookie.length > 0) && ((cookie.substring(0, cookie.indexOf(':')) == company))) {
        //var tableFileNames = getTableNameFileNames(v);
        //tableFileNames = handlerRegexSpcileChar(tableFileNames);
        //var re = new RegExp(tableFileNames + '[^,]*', 'ig');
        //if (re.test(cookie)) return;
        if (cookie.indexOf(v + ",") != -1)
            return;
        //if (cookie.length - 1 == cookie.indexOf(':')) {
        //    setCookie("FileNameS", cookie + v + ",");
        //} else {
        setCookie("FileNameS", cookie + v + ",");
        //}
    } else {
        setCookie("FileNameS", company + ":" + v + ",");
    }
}
function removeFromCookie(v) {
    var company = "cnki";
    var cookie = new String(getCookie("FileNameS"));
    if (cookie.substring(0, cookie.indexOf(':')) == company) {
        cookie = cookie.substring(cookie.indexOf(':') + 1, cookie.length);
        //var deleteV = function (input, value) {
        //    re = new RegExp("^" + handlerRegexSpcileChar(value) + "$");
        //    input = input.replace(re, "");
        //    re = new RegExp("^" + handlerRegexSpcileChar(value) + ",");
        //    input = input.replace(re, "");
        //    re = new RegExp("," + handlerRegexSpcileChar(value) + "$");
        //    input = input.replace(re, "");
        //    re = new RegExp("," + handlerRegexSpcileChar(value) + ",");
        //    input = input.replace(re, ",");
        //    return input;
        //}
        //var tableFileNames = getTableNameFileNames(v);
        //tableFileNames = handlerRegexSpcileChar(tableFileNames);
        //if (tableFileNames && tableFileNames.length <= 0) { return; }
        //var re = new RegExp(tableFileNames + '[^,]*', 'ig');
        //var tempMaths = cookie.match(re);
        //if (tempMaths && tempMaths.length > 0) {
        //    for (var i = 0; i < tempMaths.length; i++) {
        //        cookie = deleteV(cookie, tempMaths[i]);
        //    }
        //}
        v = v.toUpperCase();
        var reg = new RegExp("(" + v + ",)", "g");
        cookie = cookie.replace(reg, "");
    } else {
        cookie = "";
    }
    if (cookie != "") {
        setCookie("FileNameS", company + ":" + cookie);
    }
    else {
        setCookie("FileNameS", company + ":");
    }
}
function initSelectedRefItemsForCookie() {
    var fns = "";
    company = "cnki";
    try {
        var cookie = new String(getCookie("FileNameS"));
        if ((cookie.length > 0) && ((cookie.substring(0, cookie.indexOf(':')) == company))) {
            fns = cookie.substring(company.length + 1);
            var fnsArr = fns.split(",");
            if (typeof (searchConditionPara) != 'undefined' && fnsArr.length <= searchConditionPara.pageSize) {
                //如果cookie中选中的值数小于页面item数,循环fnsArr
                for (var i = 0; i < fnsArr.length; i++) {
                    if (fnsArr[i].length <= 0)
                        continue;
                    $('.resault-cont .cont-left .lplist .checkbox1[data-fn="' + fnsArr[i] + '"]').addClass("active");
                    $('.resault-cont .cont-left .re-table .checkbox1[data-fn="' + fnsArr[i] + '"]').addClass("active");
                }
            } else {
                var checkBoxArr = $('.resault-cont .cont-left .lplist .checkbox1');
                if (checkBoxArr != null && checkBoxArr.length > 0) {
                    for (var i = 0; i < checkBoxArr.length; i++) {
                        var fn = $(checkBoxArr[i]).attr("data-fn").toUpperCase();
                        if (fns.indexOf(fn + ",") != -1) {
                            $('.resault-cont .cont-left .lplist .checkbox1[data-fn="' + fn + '"]').addClass("active");
                            $('.resault-cont .cont-left .re-table .checkbox1[data-fn="' + fn + '"]').addClass("active");
                        }
                    }
                }
            }

            //设置为选中的状态长度
            var selectedCount = $('.resault-cont .cont-left .lplist .checkbox1[class$="active"]').length;
            if (typeof (searchConditionPara) != 'undefined' && selectedCount == searchConditionPara.pageSize) {
                $('.bottomBar li.item1 label i').addClass('active');
            }
            else {
                $('.bottomBar li.item1 label i').removeClass('active');
            }
            //设置已选中数
            updateCounter();
        }

        //设置BoxToolBar显示状态
        setSelectBoxToolBarView(isHasShowSelectBox);
    }
    catch (e)
    { }
}
function checkMark(v, checked) {
    var limit = 500;
    if (!window.localStorage || !window.sessionStorage) {
        limit = 50;
    };
    if (checked == true) {
        if (numMarked() >= limit) {
            alert(getErrorMsg(limit));
            return false;
        }
        else {
            if (document.cookie.length + v.length > 4096) {
                alert(getErrorMsg(limit));
                return false;
            }
            $('.resault-cont .cont-left .re-table .checkbox1[data-fn="' + v + '"]').addClass("active");
            $('.resault-cont .cont-left .lplist .checkbox1[data-fn="' + v + '"]').addClass("active");
            addToCookie(v);
            var selectedCount = $('.resault-cont .cont-left .lplist .checkbox1[class$="active"]').length;
            if (typeof (searchConditionPara) != 'undefined' && selectedCount == searchConditionPara.pageSize) {
                $('.bottomBar li.item1 label i').addClass('active');
            }
        }
    } else {
        $('.resault-cont .cont-left .re-table .checkbox1[data-fn="' + v + '"]').removeClass("active");
        $('.resault-cont .cont-left .lplist .checkbox1[data-fn="' + v + '"]').removeClass("active");
        $('.bottomBar li.item1 label i').removeClass('active');
        removeFromCookie(v);
    }
    updateCounter();
}
var play_fly_imgSrc = "";
//抛物线函数
function play_fly(event) {
    try {
        var s_left = event.clientX;//获取鼠标左边的位置
        var s_top = event.clientY;//获取鼠标左边的位置
        var e_left = $(".bottomBar li.item3").offset().left + 100;
        var e_top = $(".bottomBar li.item3").offset().top;
        var _this = $(event.target);//当前到点击的js对象
        var img = _this.parent().siblings("img").attr("src");
        var flyer = $('<img src="' + play_fly_imgSrc + '" width="15">');//创建图片对象
        if (typeof (flyer.fly) != "undefined") {
            flyer.fly({
                start: {
                    left: s_left,
                    top: s_top
                },
                end: {
                    left: e_left,
                    top: e_top
                },
                onEnd: function () {
                    flyer.fadeOut("slow", function () {
                        $(this).remove();
                    });
                }
            });
        }
    }
    catch (e)
    { }
}

function ConvertHexad_3(sum) {
    var digital = isNaN(sum) ? 0 : parseFloat(sum);
    if (digital <= 1000)
        return { unit: 1, name: "" };
    else if (digital > 1000 && digital < 10000)
        return { unit: 1000, name: "千" };
    else if (digital > 10000 && digital < 100000000)
        return { unit: 10000, name: "万" };
    else
        return { unit: 100000000, name: "亿" };
}
function ConvertHexad_2(sum) {
    var digital = isNaN(sum) ? 0 : parseFloat(sum);
    if (digital <= 0)
        return "0";
    else if (digital < 10000)
        return digital;
        //else if (digital > 1000 && digital < 10000)
        //    return (digital / 1000).toFixed(2) + "千";
    else if (digital > 10000 && digital < 100000000)
        return (digital / 10000).toFixed(2) + "万";
    else
        return (digital / 100000000).toFixed(2) + "亿";
}
function ConvertHexad(sum) {
    var digital = isNaN(sum) ? 0 : parseFloat(sum);
    if (digital <= 0)
        return "0";
    else if (digital <= 10000)
        return digital;
    else if (digital > 10000 && digital < 100000000)
        return (digital / 10000).toFixed(2) + "万";
    else
        return (digital / 100000000).toFixed(2) + "亿";
}
//// 文献状态和文献标识代码
function isShowSummaryArticle(filename, articleStatus, disAllowArticleStatus) {
    if (filename == undefined) {
        return false;
    }
    else {
        if ("BCDT201305033;BCDT201305032;".indexOf(filename + ";") != -1) {
            return false;
        }
    }
    if (disAllowArticleStatus == undefined)
        disAllowArticleStatus = "8:8,";
    articleStatus = articleStatus == undefined ? "" : (articleStatus.length > 1 ? articleStatus.substring(0, 1) : articleStatus);
    if (articleStatus && disAllowArticleStatus && articleStatus.length > 0 && disAllowArticleStatus.length > 0 && disAllowArticleStatus.indexOf(articleStatus) != -1)
        return false;
    return true;
}
var SpecialAllowDownloadMagaCode = "CCEN, BFWX, MZWE, TAYA, YLIN, SUOF, SDWX, YUHU, SHJB, YHWX, FJWX, ZUOJ, HHZZ, XSJI, QNWX, XZWE, QHHW, YALJ, BWJC, HAIY, WXGZ, TAIH, DDAA, HCHE, QMIN, SHHZ, CJWY, MZWU, SHWE, SDWU, QNZJ, DIHU, MDAN, HOND, CAOD, AHWX, SCWX, XSDD, FTTY, HYYT, XUYT, ZPYT, HZWX, ZMNT, XHZD, GOGE, GXWX, YECA, SXWU, DIAC, ZTWY, DDCP, YAWX, QCYT, BZXS, JANA, XSLN, SHUA, SHWH, MAZH, FURN, CJCK, GZWY, SDBB, YLHE, CHZZ, TJLL, JGDY, JGWS, ZHXB, SUIY, WXRS, SXWE, XMWX, RMWX, FCYT, LPSY, BDHW, SJZH, CPXS, HHWX, XDXS, WYCB, DDXX, JGWX, JGWM, ZSWE, CAOY, XSYY, XSYB, XSZP, XSCP, LSWX, WXGC, ZHXB, BAHZ, BAIH, TSWX, NYKS, JTDS";
var SpecialAllowDownloadMagaCodeStartYear = 2013;
function inAllowDownloadSpecialMaga(filename) {
    if (filename == undefined || filename.Length < 4)
    {
        return -1;
    }
    var code = filename.substring(0,4);
    if (SpecialAllowDownloadMagaCodeStartYear <= 0)
    {
        return SpecialAllowDownloadMagaCode.indexOf(code) != -1 ? 1 : -1;
    }
    if (filename.Length < 8)
    {
        return SpecialAllowDownloadMagaCode.indexOf(code) != -1 ? 0 : -1;
    }
    var year = parseInt(filename.substring(4, 8));
    if (isNaN(year) || year < 1)
    {
        return SpecialAllowDownloadMagaCode.indexOf(code) != -1 ? 0 : -1;
    }
    else
    {
        return SpecialAllowDownloadMagaCode.indexOf(code) != -1 ? ((year >= SpecialAllowDownloadMagaCodeStartYear) ? 1 : 0) : -1;
    }
}
function isAllowDownloadArticle(articleStatus, articleAssignCode, magaAssignCode, assignType, disAllowArticleStatus, articleFilename, allowdownload) {
    try {
        if (articleFilename == undefined) {
            return false;
        }
        else {
            if ("BCDT201305033;BCDT201305032;".indexOf(articleFilename + ";") != -1) {
                return false;
            }
        }
        if (allowdownload != undefined) {
            if (allowdownload == false)
                return false;
            else
                return true;
        }
        if (disAllowArticleStatus == undefined)
            disAllowArticleStatus = "2;2,8:8,";
        articleStatus = articleStatus == undefined ? "" : (articleStatus.length > 1 ? articleStatus.substring(0, 1) : articleStatus);
        if (articleStatus && disAllowArticleStatus && articleStatus.length > 0 && disAllowArticleStatus.length > 0 && disAllowArticleStatus.indexOf(articleStatus) != -1)
            return false;
        //disAllowDownloadAssignTypes = "CJFU,CJFV";
        //if (assignType && assignType.length > 0 && disAllowDownloadAssignTypes.indexOf(assignType) != -1) {
        //    if (magaAssignCode == undefined || magaAssignCode.length == 0 || magaAssignCode.toUpperCase().indexOf("Q") == -1) {
        //        return false;
        //    }
        //}
        var inAllowDownloadSpecial = inAllowDownloadSpecialMaga(articleFilename);
        if (inAllowDownloadSpecial == 1) {
            return true;
        }
        if (!magaAssignCode)
            return true;
        magaAssignCode = magaAssignCode.toUpperCase();
        if ((magaAssignCode.indexOf("U") == 0 || magaAssignCode.indexOf("V") == 0) && magaAssignCode.indexOf("Q") == -1)
            return false;
        else {
            if (inAllowDownloadSpecial == 0) {
                isAllowDownload = false;
            }
        }
    } catch (e) {
    }
    return true;
}
function getArticleStatusMsgObj(status, tipStatus) {
    if (status == undefined || status == null)
        return "";
    if (tipStatus == undefined)
        tipStatus = "2;2,4;4,6;6,8;8,";
    if (tipStatus != undefined && tipStatus.length > 0 && tipStatus.indexOf(status) == -1)
        return "";
    return getArticleStatusMsg(status);
}
function getArticleStatusMsg(status) {
    if (status == undefined || status == null)
        return "";
    var msg = "";
    switch (status) {
        case "1":
            msg = "已勘误";
            break;
        case "2":
            msg = "撤回";
            break;
        case "3":
            msg = "未勘误";
            break;
        case "4":
        case "8":
            msg = "撤稿";
            break;
        case "5":
            msg = "全文替换";
            break;
        case "6":
            msg = "关注";
            break;
        default:
            break;
    }
    return msg;
}
function getArticleStatusStatementFlag(status) {
    if (status == undefined || status == null)
        return "";
    var msg = "";
    switch (status) {
        case "1":
            msg = "Erratum";
            break;
        case "2":
            msg = "Withdraw";
            break;
        case "3":
            msg = "Erratum";
            break;
        case "4":
            msg = "retraction";
            break;
        case "5":
            msg = "replacement";
            break;
        case "6":
            msg = "Concern";
            break;
        case "7":
            msg = "Concel";
            break;
        case "8":
            msg = "retractionb";
            break;
        default:
            break;
    }
    return msg;
}
