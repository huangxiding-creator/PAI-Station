String.prototype.trim = function () {
    return this.replace(/(^\s*)|(\s*$)/g, "");
}
String.prototype.ltrim = function () {
    return this.replace(/(^\s*)/g, "");
}
String.prototype.rtrim = function () {
    return this.replace(/(\s*$)/g, "");
}
var referenceServerUrl = "";
var fileterResultServerApiUrl = "";
var getImageReleantUrl = "";
var filterReloadTagobj = {
    Type: true,
    Subject: true,
    SpecialityCode: true,
    UnitCode: true,
    Year: true,
    AcefuthorFilter: true,
    BossCode: true,
    Fund: true,
    Level: true,
    Organization: true
};
var searchConditionPara = {
    FilterParam: {
        Type: "",
        Subject: "",
        SpecialityCode: "",
        UnitCode: "",
        Year: "",
        AcefuthorFilter: "",
        BossCode: "",
        Fund: "",
        Level: "",
        Elite: "",
        Organization: "",
        Smarts: "",
        /*true表示跨区域搜索*/
        CrossAreaSearch: false
    },
    ConditionParam: function () {
        this.searchType = "MulityTermsSearch";
        this.ArticleType = "";
        this.ReSearch = "";

        /*参数是否都为空 flase 表示所有参数都为空 true 表示 至少有一个参数的值不为空*/
        this.ParamIsNullOrEmpty = true;
        /*参数是否合法 是否还有特殊字符*/
        this.Islegal = false;

        //高级条件
        //一般文献
        this.Content = "";
        this.Theme = "";
        this.Title = "";
        this.KeyWd = "";
        this.Author = "";
        this.SearchFund = "";
        this.Originate = "";
        this.Summary = "";
        this.PublishTimeBegin = "";
        this.PublishTimeEnd = "";
        this.MapNumber = "";//中图分类号
        //CJFD
        this.Name = "";
        this.Issn = "";
        this.Cn = "";
        this.Unit = "";   //source, 单位
        this.Public = ""; //Address
        //CDMD
        this.Boss = "";
        this.FirstBoss = "";
        //this.Summary = "";
        this.Catalog = "";
        this.Reference = "";
        this.Speciality = "";
        //Unit= "";

        //筛选条件
        this.Type = "";
        this.Subject = "";
        this.SpecialityCode = "";
        this.UnitCode = "";
        this.Year = "";
        this.AcefuthorFilter = "";
        this.BossCode = "";
        this.Fund = "";
        this.Level = "";
        this.Elite = "";
        this.Organization = "";

        this.Order = "";

        this.Page = "";
        this.PageIndex = "";

        this.ExcludeField = "";
        this.ZtCode = "";
    },
    conditions: ["Content", "Theme", "Title", "KeyWd", "Author", "AcefuthorFilter", "Unit", "Originate", "Summary", "SearchFund", "PublishTimeBegin", "PublishTimeEnd", "Summary", "Reference", "MapNumber"],
    conditions_cjfd: ["Name", "Issn", "Cn", "Unit", "Public"],
    conditions_cdmd: ["Content", "Theme", "Title", "Author", "Boss", "FirstBoss", "Unit", "KeyWd", "Summary", "Catalog", "Reference", "Speciality", "PublishTimeBegin", "PublishTimeEnd", "Unit"],
    //TODO conditions_cdmd  与filter 存在重复的字段，参数赋值时会覆盖原来的值
    filter: ["Type", "Subject", "SpecialityCode", "UnitCode", "Year", "AcefuthorFilter", "BossCode", "Fund", "Level", "Elite", "Organization", "Smarts"],
    filterViewNameObj: { Type: "文献类型", Subject: "学科分类", SpecialityCode: "专业", UnitCode: "院校", Year: "年度", AcefuthorFilter: "作者", BossCode: "导师", Fund: "基金", Level: "研究层次", Elite: "优秀级别", Organization: "机构" },
    pageSize: 20,
    pageIndex: 1,
    ReSearch: "",
    DoMainSearch: "",
    lastFilterField: "",
    ztCode: "" //文献学科专题检索时有用
}
//at 20150225 by fanyj, 添加isGetFilter用于判断是否取筛选条件中的值,点击搜索按钮时不取筛选项
function getSearchConditionParam(searchType, channelType, excludeField, isGetFilter) {
    //toLowerCase(),toUpperCase()
    var param = new searchConditionPara.ConditionParam();
    searchType = searchType == undefined || searchType == null ? "MulityTermsSearch" : searchType;
    excludeField = excludeField == undefined || excludeField == null ? "" : excludeField;
    isGetFilter = isGetFilter == undefined ? true : false;
    if (searchType == "QuickSearch") {
        param.Theme = $("#textSearchKey").val();
        param.Islegal = checkHtmlStr(itemValue);
    }
    else {
        var itemValue = "";
        var contentArray = new Array();
        switch (channelType) {
            default:
            case "0":
            case "1": contentArray = contentArray.concat(searchConditionPara.conditions); break;
            case "4": contentArray = contentArray.concat(searchConditionPara.conditions_cdmd); break;
        }
        for (var i = 0; i < contentArray.length; i++) {
            itemValue = $("#MultiTermSearch input[name=" + contentArray[i].toLowerCase() + "]").map(function () {
                return $(this).val();
            }).get().join("|");
            if (param.ParamIsNullOrEmpty) {
                param.ParamIsNullOrEmpty = checkParamIsNullOrWhiteSpace(itemValue);
            }
            if (!param.Islegal) {
                param.Islegal = checkHtmlStr(itemValue);
            }
            param[contentArray[i]] = itemValue;
        }
        //at 20150225 by fanyj
        //点击搜索按钮时不取筛选项,但Type必须取
        param["Type"] = searchConditionPara.FilterParam["Type"];
        if (isGetFilter) {
            for (var i = 0; i < searchConditionPara.filter.length; i++) {
                //判断字段重复的情况下，若该字段已赋值就不再重新赋值
                if (param[searchConditionPara.filter[i]] == undefined || param[searchConditionPara.filter[i]] == "") {
                    param[searchConditionPara.filter[i]] = searchConditionPara.FilterParam[searchConditionPara.filter[i]];
                }
            }
        }
    }
    param.ExcludeField = excludeField;
    if (searchConditionPara.ztCode.length > 0) {
        param.ZtCode = searchConditionPara.ztCode;
    }
    if (param.Type != null && param.Type != undefined){
        if(typeof param.Type == "string"){
            param.ArticleType = param.Type.length > 0 ? (isNaN(parseInt(param.Type)) ? 0 : parseInt(param.Type)) : 0;
        } else if(typeof param.Type == "number"){
            param.ArticleType = param.Type;
        }
    }
    else {
        param.ArticleType = 0;
    }
    param.ReSearch = searchConditionPara.ReSearch;
    return param;
}
//校验某个字段是否不为空
function checkParamIsNullOrWhiteSpace(str) {
    return str == undefined || str == "" || str.replace(/^\s+|\s+$/g, '') == "";
}

function createActionForm(param, actionUrl, actionMethod, target) {
    if (param == null || param.length <= 0 || typeof (param) != "object")
        return null;
    actionMethod = actionMethod == undefined || actionMethod == null ? "get" : actionMethod;
    //js动态创建form 提交表单
    var turnForm = document.createElement("form");
    //一定要加入到body中！！
    document.body.appendChild(turnForm);
    turnForm.method = actionMethod;
    turnForm.action = actionUrl;
    var getParam = "";
    for (var item in param) {
        if (param[item] == undefined || param[item] == null)
            continue;
        if (typeof (item) == "string" && param[item].length > 0) {
            if (actionMethod == "post") {
                var hSearchType = document.createElement("input");
                hSearchType.type = "hidden";
                hSearchType.setAttribute("name", item);
                hSearchType.setAttribute("value", encodeURIComponent(param[item]));
                turnForm.appendChild(hSearchType);
            }
            else {
                getParam += "&" + item + "=" + encodeURIComponent(param[item]);
            }
        }
    }
    if (actionMethod == "get" && getParam.length > 0) {
        if (actionUrl.indexOf("?") == -1) {
            actionUrl += getParam.substr(1);
        }
        else {
            actionUrl += getParam;
        }
    }
    if (target != undefined)
        turnForm.target = target;
    return turnForm;
}

//高级搜索
function Search() {
    var articleType = "0";
    //搜索类型
    //  var searchType = "MulityTermsSearch";
    //搜索主题
    var searchSubjecIndex = parseInt($("#topSearchNav").find(".active").attr("data-code"));
    searchSubjecIndex = isNaN(searchSubjecIndex) ? 0 : searchSubjecIndex;
    var actionUrl = searchConditionPara.DoMainSearch + "/Search/Result";
    //根据不同的搜搜类型 设定不同的控制器请求路径
    switch (searchSubjecIndex) {
        case 1:
            actionUrl = searchConditionPara.DoMainSearch + '/Search/LiteratureResult';
            searchConditionPara.FilterParam.Type = "0";
            break;
        case 3:
            actionUrl = searchConditionPara.DoMainSearch + '/cjfd/Home/Result';
            break;
        case 4:
            actionUrl = searchConditionPara.DoMainSearch + '/cdmd/Search/index';
            searchConditionPara.FilterParam.Type = "14";
            break;
    }
    if (channelType == "1" && searchConditionPara.ztCode.length > 0) {
        clearZtCode();
    }
    var param = null;
    param = getSearchConditionParam(null, channelType, null, false);
    if (param.Islegal) {
        alert("检索项不允许输入：' ;  \"  <  > 等字符！");
        return false;
    }
    if (param.ParamIsNullOrEmpty) {
        alert("请输入检索关键词");
        return false;
    }
    if (searchConditionPara.FilterParam.CrossAreaSearch && param.ParamIsNullOrEmpty) {
        param.Content = $(".MulSerchKey[value!='']").eq(0).val();
        param.ArticleType = searchConditionPara.FilterParam.Type;
    }

    var orderNum = $("#orderNum").val();
    orderNum = orderNum == undefined ? 2 : orderNum;
    param.Order = orderNum;
    param.Page = 1;
    if (searchSubjecIndex == 9)
    {
        actionUrl = searchConditionPara.DoMainSearch + '/Image/home/Result'
        if (param.Content) {
            window.location.href = actionUrl + "?theme=" + encodeURI(param.Content);
        } else {
            window.location.href = searchConditionPara.DoMainSearch + "/image/home/";
        }
        return;
    }
    var form1 = createActionForm(param, actionUrl, "post");
    if (form1 != null) {
        $(form1).submit();
    }
    initPage(1);
    return false;
}
//文献页面 点击顶部 搜索按钮时 清除专题代码信息
function clearZtCode() {
    searchConditionPara.ztCode = "";
    searchConditionPara.FilterParam.Subject = "";
}
//ai
function aiSearch() {
    var searchkw = $("#textSearchKey").val().trim();
    var actionUrl = "https://aiplus.cnki.net/aiplus/?question=" + encodeURIComponent(searchkw) + "&type=fulllib";
    window.open(actionUrl);
    return false;
}
//快捷
function QuickSearch() {
    //搜索类型
    var searchType = "QuickSearch";
    //搜索主题
    var searchSubjecIndex = $("#topSearchNav").find(".active").index("#topSearchNav a");

    var actionUrl = searchConditionPara.DoMainSearch + "/Search/Result";

    //根据不同的搜搜类型 设定不同的控制器请求路径
    switch (searchSubjecIndex) {
        case 1:
            actionUrl = searchConditionPara.DoMainSearch + '/Search/LiteratureResult';
            searchConditionPara.FilterParam.Type = "0";
            break;
        case 3:
            actionUrl = searchConditionPara.DoMainSearch + '/cjfd/Home/Result';
            break;
        case 4:
            actionUrl = searchConditionPara.DoMainSearch + '/cdmd/Search/index';
            searchConditionPara.FilterParam.Type = "14";
            break;
    }
    if (searchType == "QuickSearch") {
        if($("#textSearchKey").val().trim().length <= 0)
        {
            alert("请输入检索关键词！");
            return false;
        }
    }
    var param = getSearchConditionParam(searchType, null, null, false);
    if (param.Islegal) {
        alert("检索项不允许输入：' ;  \"  <  > 等字符！");
        return false;
    }
    var orderNum = $("#orderNum").val();
    orderNum = orderNum == undefined ? 2 : orderNum;
    param.Order = orderNum;
    param.Page = 1;
    var form1 = createActionForm(param, actionUrl, "post");
    if (form1 != null) {
        $(form1).submit();
    }
    initPage(1);
    return false;
}

//初始化拼接页码
function initPage(pageIndex) {
    $("#hidCurrentPage").val(pageIndex);
    searchConditionPara.pageIndex = pageIndex;
    var totalcount = $('#totalcount').html() - 0;
    if (totalcount < 1) {
        $('.page').html("");
    }
    else {
        var pageSize = searchConditionPara.pageSize;
        var pageBegin = 1;
        if (pageIndex > 5) {
            pageBegin = pageIndex - 5;
        }
        var totalPageCount = Math.floor((totalcount / pageSize)+1);
        var pageEnd = totalPageCount
        if (totalPageCount > 10) {
            pageEnd = pageBegin + 9;
            if (pageBegin + 9 > totalPageCount) {
                pageEnd = totalPageCount;
                pageBegin = pageEnd - 9;
            }
        }
        if (pageEnd < 10) {
            pageBegin = 1;
        }
        var flag = true;
        var pageHtml = "";
        if (pageIndex == 1) {
            pageHtml += '<a class="n" style=\"cursor:pointer;\">&lt;上一页</a>';
        }
        else {
            pageHtml += '<a onclick="Page(' + (pageIndex - 1) + ');" class="n">&lt;上一页</a>';
        }
        for (var i = pageBegin; i <= pageEnd; i++) {
            if (flag) {
                if (i == pageIndex) {
                    pageHtml += '<strong><span class="pc" style=\"cursor:default;\">' + i + '</span></strong>';
                }
                else {
                    pageHtml += '<a onclick="Page(' + i + ');"><span class="pc">' + i + '</span></a>';
                }
                flag = false;
            }
            else {
                if (i == pageIndex) {
                    pageHtml += '<strong><span class="pc" style=\"cursor:default;\">' + i + '</span></strong>';
                }
                else {
                    pageHtml += '<a onclick="Page(' + i + ');"><span class="pc">' + i + '</span></a>';
                }
                flag = true;
            }
        }
        if (pageEnd == 1) {
            pageHtml += '<a class="n" style=\"cursor:default;\">下一页&gt;</a>'
        }
        else {
            pageHtml += '<a onclick="Page(' + (pageIndex - 0 + 1) + ')" style="cursor:pointer;" class="n">下一页&gt;</a>'
        }
        $('.page').html(pageHtml);
    }
}

//过滤特殊字符
function stripscript(s) {
    var pattern = new RegExp("[`~@!%#$^&*()=|{}':;',\\[\\].<>/?~！#￥……&*（）——|{}【】‘；：”“'。，、？]")
    var rs = "";
    for (var i = 0; i < s.length; i++) {
        rs = rs + s.substr(i, 1).replace(pattern, '');
    }
    return rs;
}

//局部刷新搜索结果，参数：页码
function Page(page) {
    scrollTo(0, 0);
    $("#divLoadingTip").show();
    var url = searchConditionPara.DoMainSearch + "/api/search/listresult";
    var param = getSearchConditionParam(null, channelType, null);
    var orderNum = $("#orderNum").val();
    orderNum = orderNum == undefined ? 2 : orderNum;
    param.Order = orderNum;
    param.Page = page;
    $.ajax({
        url: url,
        type: "POST",
        dataType: "JSON",
        data: param,
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            // 通常 textStatus 和 errorThrown 之中
            // 只有一个会包含信息
            //this; // 调用本次AJAX请求时传递的options参数
            $("#divLoadingTip").hide();
            $("#article_result").html("");
        },
        success: function (data, textStatus, jqXHR) {
            $("#divLoadingTip").hide();
            var html = searchReponseFuns.renderSearchResult(data);
            $("#article_result").html(html);
            if(data.totalCount > 0 && data.articleList != null && data.articleList.length > 0){
                $("#totalcount").html(data.oneSearchTotalCount);
                $("#hidTotalPageCount").val(data.totalPageCount);
            } else {
                $("#totalcount").html(0);
                $("#hidTotalPageCount").val(0);
            }

            $("#article_result").show();
            $("#divLoadingTip").css("display", "none");
            if ($("#showType").val() == 0) {
                $('.re-table').css("display", "none");
                $('.lplist').css("display", "block");
            }
            else {
                $('.re-table').css("display", "block");
                $('.lplist').css("display", "none");
            }
            setCrfd_Corpus_ImageResultView(page);
            $("#totalcount").val($("#hidTotalCount").val());
            initPage(page);
            $(".re-table tr:nth-child(odd)").addClass("even-row");
            //导出参考文献 at 20170613
            initSelectedRefItemsForCookie();
        }
    });
}

function Page0(page) {
    scrollTo(0, 0);
    $("#divLoadingTip").show();
    var url = searchConditionPara.DoMainSearch + "/search/listresult";
    var param = getSearchConditionParam(null, channelType, null);
    var orderNum = $("#orderNum").val();
    orderNum = orderNum == undefined ? 2 : orderNum;
    param.Order = orderNum;
    param.Page = page;
    $.ajax({
        url: url,
        type: "POST",
        dataType: "html",
        data: param,
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            // 通常 textStatus 和 errorThrown 之中
            // 只有一个会包含信息
            //this; // 调用本次AJAX请求时传递的options参数
            $("#divLoadingTip").hide();
            $("#article_result").html("");
        },
        success: function (data, textStatus, jqXHR) {
            $("#divLoadingTip").hide();
            $("#article_result").html(data);
            $("#article_result").show();
            $("#divLoadingTip").css("display", "none");
            if ($("#showType").val() == 0) {
                $('.re-table').css("display", "none");
                $('.lplist').css("display", "block");
            }
            else {
                $('.re-table').css("display", "block");
                $('.lplist').css("display", "none");
            }
            setCrfd_Corpus_ImageResultView(page);
            $("#totalcount").val($("#hidTotalCount").val());
            initPage(page);
            $(".re-table tr:nth-child(odd)").addClass("even-row");
            //导出参考文献 at 20170613
            initSelectedRefItemsForCookie();
        }
    });
}

//排序，参数：按什么排序
function Order(orderNum) {
    $("#orderNum").val(orderNum);
    Page(1);
}

function Showli() {
    $("#amodellist").removeClass("zyxz").addClass("zyxz1");
    $("#amodelsmmary").removeClass("lb").addClass("lb1");
    $('.re-table').show();
    $('.lplist').hide();
    $('.list').show();
    $('.books').hide();
    $("#showType").val('1');
    $("#qklistzyxz").removeClass("current").find("img").attr("src", searchConditionPara.DoMainSearch + "/images/home/qikan2-icon3.jpg");;
    $("#qklistli").addClass("current").find("img").attr("src", searchConditionPara.DoMainSearch + "/images/home/qikan2-icon4.jpg");;
    if ($("#hidCurrentPage").val() == "1") {
        setCrfd_Corpus_ImageResultView(1);
    }
    else {
        setCrfd_Corpus_ImageResultView(2, false);
    }
    $('.books-recommend').show();
}
function Showzyxz() {
    $("#amodellist").removeClass("zyxz1").addClass("zyxz");
    $("#amodelsmmary").removeClass("lb1").addClass("lb");
    $('.re-table').hide();
    $('.lplist').show();
    $('.list').hide();
    $('.books').show();
    $("#showType").val('0');
    $("#qklistzyxz").addClass("current").find("img").attr("src", searchConditionPara.DoMainSearch + "/images/home/qikan2-icon1.jpg");
    $("#qklistli").removeClass("current").find("img").attr("src", searchConditionPara.DoMainSearch + "/images/home/qikan2-icon2.jpg");
    if ($("#hidCurrentPage").val() == "1" && $(".yx p").html() == undefined) {
        setCrfd_Corpus_ImageResultView(1);
    }
    else {
        setCrfd_Corpus_ImageResultView(2, false);
    }
}
var searchGroupObj = {
    lastTime: -6000,
    overTime: 5000,
    overTimeTipMsg: "您不能频繁的点击分组!",
    notTipClickTime: 3,
    nowClickCount: 0,
    checkIsFrequently: function () {
        var currentTime = (new Date()).getTime();
        searchGroupObj.nowClickCount++;
        if (searchGroupObj.nowClickCount <= searchGroupObj.notTipClickTime) {
            searchGroupObj.lastTime = currentTime;
            return false;
        }
        if ((currentTime - searchGroupObj.lastTime) < searchGroupObj.overTime) {
            alert(searchGroupObj.overTimeTipMsg);
            return true;
        }
        else {
            searchGroupObj.lastTime = currentTime;
            return false;
        }
    },
    resetLastTime: function () {
        searchGroupObj.lastTime = -6000;
    },
    searchByFilter: function (elment) {
        var field = elment.attr("data-field");

        $("#filter_" + field + " .classes a").removeClass("yellow");
        $("#filter_" + field + " .filterselect").removeClass("current");//学位论文 学科导航 顶部学科分类

        if (field.toLowerCase() == "specialitycodenavi") {
            field = "SpecialityCode";
        }
        else if (field.toLowerCase() == "subject") {
            $(".items .filterselect").removeClass("current");
        }

        if (elment.hasClass("filterselect")) {
            var url = elment.attr("href");
            //学位论文 学科导航 点击学科分类 如链接中不含 "none" 跳转页面；
            if (url != undefined && url != null && url.toLowerCase().indexOf("none") == -1) {
                return true;
            }
        }
        elment.addClass("yellow").addClass("current");
        var fieldname = elment.data("fieldname");
        var fieldvalue = elment.data("fieldvalue");
        if (searchConditionPara.FilterParam[field] == fieldvalue && searchConditionPara.lastFilterField == field)
            return false;
        searchConditionPara.lastFilterField = field;
        var fieldCN = searchConditionPara.filterViewNameObj[field];
        var ishere = false;

        for (var item in filterReloadTagobj) {
            filterReloadTagobj[item] = true;
        }
        $(".yx >p").each(function (index) {
            if ($(this).attr("data-field") == field) {
                ishere = true;
                if (fieldvalue == "0" || fieldvalue == "" || fieldname == "全部") {
                    $(this).remove();
                    if ($(".yx >p").size() == 0) {
                        $(".yx").hide();
                        return false;
                    }
                }
                //change view
                $(this).attr('id', field);
                $(this).attr('data-fieldname', fieldname);
                $(this).attr('data-fieldvalue', fieldvalue);
                $(this).children('i').text(fieldname);

                if (field == "Type") {
                    searchConditionPara.FilterParam.Type = fieldvalue;
                }
            }
        });
        if (!ishere && fieldvalue != "0" && fieldvalue != "") {
            $(".yx").append("<p id = \"" + field + "\" class=\"tm left positionR\" data-field=\"" + field + "\" data-fieldname=\"" + fieldname + "\" data-fieldvalue=\"" + fieldvalue + "\" onclick=\"searchGroupObj.deletefilter(this,'" + field + "')\">" + fieldCN + "：<i>" + fieldname + "</i><a class=\"close2 positionA\"></a></p>");
            $(".yx").show();
        }
        if (fieldvalue == undefined || fieldvalue + "" == "0" || fieldvalue + "" == "" || (fieldvalue + "").toLowerCase() == "all")
            searchConditionPara.FilterParam[field] = "";
        else {
            searchConditionPara.FilterParam[field] = fieldvalue;
            filterReloadTagobj[field] = false;
        }
        Page(1);
    },
    deletefilter: function (e, pageType) {
        //var field = $(e.target).parent().attr("data-field");
        var nowItem = $(e);
        var field = nowItem.attr("data-field");
        if (field == undefined || field == "") {
            nowItem = nowItem.parent();
            field = nowItem.attr("data-field");
        }
        searchConditionPara.FilterParam[field] = "";
        for (var item in filterReloadTagobj) {
            filterReloadTagobj[item] = true;
        }
        nowItem.remove();
        if ($(".yx >p").size() == 0) {
            $(".yx").hide();
        }
        pageType = pageType == undefined ? "" : pageType.toLowerCase();
        //重置选中项
        var nowUrl = window.location.href.toLowerCase();
        var nowField = field.toLowerCase();
        if ((nowUrl.indexOf("cdmd/search/subject") != -1 || nowUrl.indexOf("search/literatureresult?ztcode=") != -1) && (nowField == "specialitycode" || nowField == "subject")) {
            var nowClearValue = "";
            if ($(".filterselect").length > 0) {
                $(".filterselect").removeClass("current");
                var tempEl = $(".filterselect").eq(0);
                if (tempEl.html().trim() == "全部")
                    tempEl.addClass("current");
                nowClearValue = tempEl.attr("data-fieldvalue");
            }
            searchConditionPara.FilterParam[field] = nowClearValue;
        }
        if ($("#filter_" + field + " .classes a").length > 0 || $("#filter_" + field + "Navi .classes a").length > 0) {
            $("#filter_" + field + " .classes a").removeClass("yellow").removeClass("current");
            $("#filter_" + field + "Navi .classes a").removeClass("yellow").removeClass("current");
            //$("#filter_" + field + " .classes a").eq(0).addClass("yellow").addClass("current");
            var tempEl = $("#filter_" + field + " .classes a").eq(0);
            if (tempEl.html() != undefined && tempEl.html().trim() == "全部")
                tempEl.addClass("yellow").addClass("current");
        }
        Page(1);
        setCrfd_Corpus_ImageResultView(1);
        searchGroupObj.reLoadFilter(field);
    },
    reLoadFilter: function (field) {
        var id = "";
        if ($(".pop2:visible").length > 0)
            id = $(".pop2:visible").attr("id");
        else if ($(".itemslist:visible").length > 0)
            id = $(".itemslist:visible").attr("id");
        if (id == undefined || id == null || id.length == 0)
            return;
        id = id.replace("div", "").replace("filter_", "");

        if ($(".yx .tm").length == 0 && field == id)
            return;
        var filterParamType = 0;
        if (typeof (searchConditionPara.FilterParam.Type) != "number") {
            filterParamType = parseInt(searchConditionPara.FilterParam.Type);
            if (isNaN(filterParamType))
                filterParamType = 0;
        }
        switch (filterParamType) {
            case 0:
            default:
                loadfilter(id);
                break;
            case 1:
                loadfilter(id, $(".title").attr("data-currentcatecode"));
            case 3:
            case 4:
            case 14:
                loadfilter(id, "", bossFilterResultCallback, searchConditionPara.FilterParam.Type, channelType);
        }
        filterReloadTagobj[id] = false;
    }
};
function loadfilter(field, cateCode, callback, articleType, channelType) {
    filterReloadTagobj[field] = false;
    var timestamp = (new Date()).valueOf();
    var totalcount = $("#totalcount").html();
    channelType = channelType == undefined || channelType == null ? "" : channelType;
    var currentCateCode = cateCode == undefined ? "" : cateCode;
    var callbackFun = (callback == undefined || callback == null) ? homeFilterResultCallback : callback;
    var param = getSearchConditionParam(null, channelType, field);
    if (articleType != undefined || articleType != null) {
        param.ArticleType = articleType;
    }
    if (currentCateCode != "") {
        param.Subject = currentCateCode;
    }
    $.ajax({
        type: "POST",
        url: fileterResultServerApiUrl,
        data: param,
        dataType: "json",
        success: function (data) {
            callbackFun(data, field);
        }
    });
    return true;
}

function homeFilterResultCallback(data, field) {
    if (field == "Elite") {
        return false;
    }
    var html = "";
    var json = eval(data);
    var totalcount = $("#totalcount").html();
    var tempFlag = $(".itemslist").length > 0 ? false : true; // true 全部检索, false学位论文
    var InstitutionUrl = "@ProductConfigHelper.InstitutionUrl";
    if (tempFlag)
        html += "<a class='close1 positionA' href='javascript:void(0)' data-field='" + field + "'></a>";
    else
        html += "<a href='javascript:void(0)' class='close' data-field='" + field + "'></a>";

    var nowFieldLastSelectValue = searchConditionPara.FilterParam[field];
    if (nowFieldLastSelectValue == undefined || nowFieldLastSelectValue == null)
        nowFieldLastSelectValue = "";
    else {
        if (typeof (nowFieldLastSelectValue) != "string")
            nowFieldLastSelectValue += "";
        nowFieldLastSelectValue = nowFieldLastSelectValue.trim();
    }
    var isHasMarkCurrent = false;
    $.each(json, function (index, element) {
        if (element.ArticleCount > 0) {
            html += "<div class='classes'><a ";
            if (nowFieldLastSelectValue.length > 0 && element.TypeCode == nowFieldLastSelectValue) {
                html += "class=\"yellow current\"";
                isHasMarkCurrent = true;
            }
            html += " data-field='" + field + "' data-fieldname='" + element.FilterName + "' data-fieldvalue='" + element.TypeCode + "' href='javascript:void(0)'>" + element.FilterName + "</a><span class='num'>(" + element.ArticleCount + ")</span></div>";
        }
    });
    //var html1 = "<div class='classes'><a ";
    //if (!isHasMarkCurrent)
    //    html1 += "class=\"yellow current\"";
    //html1 += " data-field='" + field + "' data-fieldname='全部' data-fieldvalue='0' href='javascript:void(0)'>全部</a><span class='num'>(" + totalcount + ")</span></div>"
    //html = html1 + html;
    if (html.length > 4100) {
        if (tempFlag)
            html += "<span class='unfold' data-field='" + field + "'></span>";
        else
            html += "<a href='javascript:void(0)' class='more more-unfold' data-field='" + field + "'></a>";
    }
    $(".pop2").hide();
    $(".itemslist").hide();
    if (html != "") {
        $("#filter_" + field).show();
        $("#filter_" + field).html(html);
        //bindFilterSelectItemEvent();
    } else {
        $("#filter_" + field).show();
        $("#filter_" + field).html("<div class=\"classes\">暂无数据</div>");
    }
}

/*学位论文院校分类、专业分类页面筛选条件*/
function bossFilterResultCallback(data, field) {
    homeFilterResultCallback(data, field);
}

function bindFilterSelectItemEvent() {
    var flag = false;
    $(".itemslist .more").live('click', function () {
        if (flag = !flag) {
            $(this).parent(".itemslist").addClass("auto-height").removeClass("has-height");
            $(this).removeClass("more-unfold").addClass("more-fold");
        }
        else {
            $(this).parent(".itemslist").removeClass("auto-height").addClass("has-height");
            $(this).removeClass("more-fold").addClass("more-unfold");
        }
    })

    //$(".pop2 .unfold").click(function () {
    //    $(this).siblings(".hide").show()
    //    $(this).hide()
    //});
    //$(".pop2 .fold").click(function () {
    //    $(this).parent(".hide").hide()
    //    $(".pop2 .unfold").show()
    //});
    $(".pop2 .unfold").live("click", function () {
        if ($(this)[0].className == "unfold") {
            $(this)[0].className = "unfold fold";
            $(this).parent().css("height", "auto");
        }
        else {
            $(this)[0].className = "unfold";
            $(this).parent().css("height", 90);
        }
    });
    $(".close").live("click", function () {
        var field = $(this).attr("data-field");
        if (field != undefined) {
            $("#filter_" + field).hide();
        }
        else {
            $(this).parents(".tab1-cont,.tab3-cont,.tab2-cont").first().hide();
            $(this).parents(".tab1-cont,.tab3-cont,.tab2-cont").first().siblings("div").find("a").removeClass("cur");
            $(this).parents(".lwsx").css({ "padding-bottom": "0", "border-bottom-width": "0" });
        }
    })

    $(".pop2 .close1").live("click", function (event) {
        var field = $(this).attr("data-field");
        if (field != undefined) {
            $("#filter_" + field).hide();
            $(".filtrate .itemm .see2").css({ "display": "none" });
        }
        else {
            $(".pop2").css({ "display": "none" });
            $(".pop2 .hide").css({ "display": "none" });
            $(".pop2 .unfold").css({ "display": "block" });
            $(".filtrate .itemm .see2").css({ "display": "none" });
        }
        event.stopPropagation();
    });
    //
    $(".classes a").live("click", function () {
        searchGroupObj.searchByFilter($(this));
    });

    $(".filterselect").click(function () {
        $(".filterselect").removeClass("current");
        $(this).addClass("current");
        searchGroupObj.searchByFilter($(this));
        searchGroupObj.reLoadFilter("");
    });
}
function binKeyWordsConfirmSearch() {
    $(".popSearch .btn").click(function () {
        var r = document.getElementsByName("chekeyword");
        var keyword = "";
        for (var i = 0; i < r.length; i++) {
            if (r[i].checked) {
                keyword += r[i].value;
                keyword += " ";
            }
        }
        keyword = keyword.substr(0, keyword.length - 1);
        var url = "";
        switch (searchConditionPara.FilterParam.Type) {
            case '3':
            case '4':
            case '14':
                url = searchConditionPara.DoMainSearch + "/cdmd/Search/index?articletype=" + searchConditionPara.FilterParam.Type + "&theme=" + encodeURI(keyword);
                break;
            case '1':
            default:
                url = searchConditionPara.DoMainSearch + "/Search/Result?articletype=" + searchConditionPara.FilterParam.Type + "&theme=" + encodeURI(keyword);
                break;
        }
        window.location = url;
    });
}
function bindKeyWordsConfirmOpen() {
    $(".info .info_left a,a[name='key_node']").live("click", function () {
        var keyword = $(this).data("key");
        var currentKeyword = $(this).text();
        var keywords = keyword.split('/');
        var grouphtml = "<div class=\"popSearch\" style=\"display: block;\">\n";
        grouphtml += "      <div class=\"close\" title=\"关闭\"></div>\n";
        grouphtml += "      <div class=\"title\">组合搜索</div>\n";
        grouphtml += "      <div class=\"group clearfix\">\n";
        for (var i = 0; i < keywords.length; i++) {
            if(keywords[i].trim().length == 0) {
                continue;
            }
            var itemWord = keywords[i].length > 8 ? keywords[i].autoCutStr(0, 7, true) : keywords[i];
            if ($(this).text() == keywords[i]) {
                grouphtml += '<a href="javascript:void(0)"><span style="padding-top: 2px;"><input type="checkbox" name="chekeyword" id="checkkeyword_' + i + '" checked="checked" value="' + keywords[i] + '" title="' + keywords[i] + '"></span><label style=\"cursor:pointer;\" title="' + keywords[i] + '" for="checkkeyword_' + i + '">' + itemWord + '</label></a>';
            }
            else {
                grouphtml += '<a href="javascript:void(0)"><span style="padding-top: 2px;"><input type="checkbox" name="chekeyword" id="checkkeyword_' + i + '" value="' + keywords[i] + '" title="' + keywords[i] + '"></span><label style=\"cursor:pointer;\" title="' + keywords[i] + '" for="checkkeyword_' + i + '">' + itemWord + '</label></a>';
            }
        }
        grouphtml += "       </div>\n";
        grouphtml += "       <div class=\"btn\"><a style=\"cursor:pointer;\">搜 索</a></div>\n";
        grouphtml += "</div>\n";
        showKeyWordsConfirm(grouphtml);
    });
}
var winLayer;
function showKeyWordsConfirm(html) {
    //winLayer = $.layer({
    winLayer = layer.open({
        type: 1,
        title: false,
        border: [0],
        closeBtn: 0,
        area: ['460px'],
        //page: {
        //    html: html
        //    },
        content: html,
        //time: 2,
        success: function (layero) {
            binKeyWordsConfirmSearch();
            $(".close").click(function () {
                layer.close(winLayer);
            });
        }
    });
}

function relevantArticleMagazine(kw, count, showYear, keyType, viewElId) {
    var url = searchConditionPara.DoMainSearch + "/Search/CorrArticle";
    count = count == undefined ? 6 : count;
    if (typeof (count) == "string") {
        count == parseInt(count);
        count = isNaN(count) ? 6 : count;
    }
    showYear = showYear == undefined ? false : showYear;
    keyType = keyType == undefined ? "" : keyType;
    viewElId = viewElId == undefined ? "corrArticle" : viewElId;

    $.ajax({
        url: url,
        type: "POST",
        dataType: "html",
        data: { "kw": kw, count: count, isShowYear: showYear, keyType: keyType },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            // 通常 textStatus 和 errorThrown 之中
            // 只有一个会包含信息
            //this; // 调用本次AJAX请求时传递的options参数
        },
        success: function (data, textStatus, jqXHR) {
            $("#" + viewElId).html(data);
        }
    });
}



function cdmdRelevanUnit(id, count) {
    var url = searchConditionPara.DoMainSearch + "/cdmd/Relevant/RelevantUnit";
    $.ajax({
        url: url,
        type: "POST",
        dataType: "html",
        data: {
            "id": id,
            "count": count
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            // 通常 textStatus 和 errorThrown 之中
            // 只有一个会包含信息
            //this; // 调用本次AJAX请求时传递的options参数

        },
        success: function (data, textStatus, jqXHR) {
            $("#relevanUnit").html(data);
        }
    });
}

function cdmdRelevanBoss(unitCode, subjectCode, exCode, count, source) {
    var url = searchConditionPara.DoMainSearch + "/cdmd/Relevant/RelevantBoss";
    $.ajax({
        url: url,
        type: "POST",
        dataType: "html",
        data: {
            "unitCode": unitCode,
            "subjectCode": subjectCode,
            "exCode": exCode,
            "count": count,
            "source": source
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            // 通常 textStatus 和 errorThrown 之中
            // 只有一个会包含信息
            //this; // 调用本次AJAX请求时传递的options参数

        },
        success: function (data, textStatus, jqXHR) {
            if (unitCode != "") {
                $("#relevanUnitBoss").html(data);
            }
            else {
                $("#relevanBoss").html(data);
            }

        }
    });
}

function cdmdRelevanThesis(subjectCode, count) {
    var url = searchConditionPara.DoMainSearch + "/cdmd/Relevant/RelevantThesis";
    $.ajax({
        url: url,
        type: "POST",
        dataType: "html",
        data: {
            "subjectCode": subjectCode,
            "count": count
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            // 通常 textStatus 和 errorThrown 之中
            // 只有一个会包含信息
            //this; // 调用本次AJAX请求时传递的options参数
        },
        success: function (data, textStatus, jqXHR) {
            $("#relevanThesis").html(data);
        }
    });
}

function cdmdRelevanArticle(keyword, count, boolShowYear, keyType) {
    var url = searchConditionPara.DoMainSearch + "/cdmd/Relevant/RelevantArticle";
    $.ajax({
        url: url,
        type: "POST",
        dataType: "html",
        data: {
            "keywd": keyword,
            "count": count,
            "boolShowYear": boolShowYear,
            "keyType": keyType
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            // 通常 textStatus 和 errorThrown 之中
            // 只有一个会包含信息
            //this; // 调用本次AJAX请求时传递的options参数

        },
        success: function (data, textStatus, jqXHR) {
            $("#relevanArticle").html(data);
        }
    });
}

function cdmdRelevanUnitSubject(unitCode, count) {
    var url = searchConditionPara.DoMainSearch + "/cdmd/Relevant/RelevantUnitSubject";
    $.ajax({
        url: url,
        type: "POST",
        dataType: "html",
        data: {
            "unitCode": unitCode,
            "count": count
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            // 通常 textStatus 和 errorThrown 之中
            // 只有一个会包含信息
            //this; // 调用本次AJAX请求时传递的options参数

        },
        success: function (data, textStatus, jqXHR) {
            $("#relevanUnitSubject").html(data);
        }
    });
}

function cdmdRelevanUnitBoss(unitCode, count) {
    var url = searchConditionPara.DoMainSearch + "/cdmd/Relevant/RelevantUnitBoss";
    $.ajax({
        url: url,
        type: "POST",
        dataType: "html",
        data: {
            "unitCode": unitCode,
            "count": count
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            // 通常 textStatus 和 errorThrown 之中
            // 只有一个会包含信息
            //this; // 调用本次AJAX请求时传递的options参数

        },
        success: function (data, textStatus, jqXHR) {
            $("#relevanUnitBoss").html(data);
        }
    });
}

String.prototype.format = function (args) {
    var result = this;
    if (arguments.length > 0) {
        if (arguments.length == 1 && typeof (args) == "object") {
            for (var key in args) {
                if (args[key] != undefined) {
                    var reg = new RegExp("({" + key + "})", "g");
                    result = result.replace(reg, args[key]);
                }
            }
        }
        else {
            for (var i = 0; i < arguments.length; i++) {
                if (arguments[i] != undefined) {
                    //var reg = new RegExp("({[" + i + "]})", "g");//这个在索引大于9时会有问题，谢谢何以笙箫的指出
                    var reg = new RegExp("({)" + i + "(})", "g");
                    result = result.replace(reg, arguments[i]);
                }
            }
        }
    }
    return result;
}
//知网节链接地址
// fileName 文件名 dbtype "CJFD"  dbName"CJFD2013"
//cdNo 光盘号
//isCnkiSpace 是否去知网空间  uitCode 学位单位代码

var cnkiNodeObj = {
    isCnkiSpace:true,
    GetArticleUrl: function (dbType, fileName, dbName, cdNo, uitCode) {
        if (this.isCnkiSpace) {
            return this.GetCnkiArticleUrl(dbType, fileName, dbName, cdNo, uitCode);
        } else {
            return this.GetNodeArticleUrl(dbType, fileName, dbName, cdNo);
        }
    },
    GetNodeArticleUrl: function (dbType, fileName, dbName, cdNo) {
        var linkObj = {
            articleUrl: "",
            titleType: ""
        };
        switch (dbType) {
            case "CJFD":
                if (fileName.length > 13) {
                    linkObj.articleUrl = "//youxian.cnki.com.cn/yxdetail.aspx?filename={0}&dbname={1}".format(fileName, dbName);
                } else {
                    linkObj.articleUrl = this.NodeLinkUrlFormat.CJFDArticleUrl.format(fileName);
                }
                linkObj.titleType = "[J]";
                break;
            case "CPFD":
            case "IPFD":
                linkObj.articleUrl = this.NodeLinkUrlFormat.CPFDArticleUrl.format(dbType + "-" + fileName);
                linkObj.titleType = "[A]";
                break;
            case "CCND":
                linkObj.articleUrl = this.NodeLinkUrlFormat.CCNDArticleUrl.format(fileName);
                linkObj.titleType = "[N]";
                break;
            case "CDMD":
            case "CMFD":
            case "CDFD":
                linkObj.articleUrl = this.NodeLinkUrlFormat.CDMDArticleUrl.format(dbType + "--" + fileName);
                if (cdNo == "CDMDYTMP") {
                    linkObj.articleUrl = "youxian";
                }
                linkObj.titleType = "[D]";
                break;
        }
        return linkObj;
    },
    GetSourceUrl: function (dbType, pyName) {
        var sourceUrl = "";
        switch (dbType) {
            case "CJFD":
                sourceUrl = $("#pageUrl").val() + "/CJFD/Detail/Index/" + pyName
                break;
            case "CDMD":
            case "CMFD":
            case "CDFD":
                sourceUrl = $("#pageUrl").val() + "/cdmd/search/Unit?Code=" + pyName
                break;
        }
        return sourceUrl;
    },
    GetCnkiArticleUrl: function (dbType, fileName, dbName, cdNo,uitCode) {
        var linkObj = {
            articleUrl: "",
            titleType: ""
        };
        switch (dbType) {
            case "CJFD":
                if (fileName.length > 13) {
                    linkObj.articleUrl = "//youxian.cnki.com.cn/yxdetail.aspx?filename={0}&dbname={1}".format(fileName, dbName);
                } else {
                    if (dbName != undefined && dbName.toUpperCase() == "CJFDPREP") {
                        linkObj.articleUrl = "//kns.cnki.net/KCMS/detail/detail.aspx?dbname={0}&filename={1}".format(dbName, fileName);
                    } else {
                        linkObj.articleUrl = this.CnkiLinkUrlFormat.CJFDArticleUrl.format(fileName);
                    }
                }
                linkObj.titleType = "[J]";
                break;
            case "IPFD":
                linkObj.articleUrl = this.CnkiLinkUrlFormat.CPFDArticleUrl.format(fileName,dbName);
                linkObj.titleType = "[A]";
                break;
            case "CPFD":
                linkObj.articleUrl = this.CnkiLinkUrlFormat.CPFDArticleUrl.format(fileName);
                linkObj.titleType = "[A]";
                break;
            case "CCND":
                linkObj.articleUrl = this.CnkiLinkUrlFormat.CCNDArticleUrl.format(fileName);
                linkObj.titleType = "[N]";
                break;
            case "CDMD":
            case "CMFD":
            case "CDFD":
                if (uitCode) {
                    linkObj.articleUrl = this.CnkiLinkUrlFormat.CDMDArticleUrl.format(uitCode, fileName.replace(".nh", ""));
                } else {
                    linkObj.articleUrl = this.NodeLinkUrlFormat.CDMDArticleUrl.format(dbType + "--" + fileName);
                }
                if (cdNo == "CDMDYTMP") {
                    linkObj.articleUrl = "youxian";
                }
                linkObj.titleType = "[D]";
                break;
        }
        return linkObj;
    },
    NodeLinkUrlFormat: {
        CJFDArticleUrl: $("#pageUrl").val() + "/cjfd/Article/Index/{0}",
        CDMDArticleUrl: $("#pageUrl").val() + "/cdmd/Article/Index/{0}",
        CPFDArticleUrl: $("#pageUrl").val() + "/cpfd/Article/Index/{0}",
        CCNDArticleUrl: $("#pageUrl").val() + "/ccnd/Article/Index/{0}"
    },
    CnkiLinkUrlFormat: {
        CJFDArticleUrl: "//www.cnki.com.cn/Article/CJFDTOTAL-{0}.htm",
        CDMDArticleUrl: "//cdmd.cnki.com.cn/Article/CDMD-{0}-{1}.htm",
        CPFDArticleUrl: "//cpfd.cnki.com.cn/Article/CPFDTOTAL-{0}.htm",
        IPFDArticleUrl:"//www.cnki.net/KCMS/detail/detail.aspx?dbcode=IPFD&filename={0}&dbname={1}",
        CCNDArticleUrl: "//mall.cnki.net/magazine/article/CCND/{0}.htm"
    }
}
var searchReponseFuns = {
    renderSearchResult: function(data){
        var totalCount = data.totalCount;
        var pageIndex = data.pageIndex;
        var pageSize = data.pageSize;
        var html = "";
        if(totalCount > 0 && data.articleList != null && data.articleList.length > 0){
            var htmlPl = searchReponseFuns.renderSummaryViewList(data.articleList);
            var htmlTable = searchReponseFuns.renderTableViewList(data.articleList, pageIndex, pageSize);
            html += htmlPl;
            html += htmlTable;
            html += "<input type=\"hidden\" value=\""+totalCount+"\" id=\"hidTotalCount\" class=\"pTotalCount\" />";
            html += "<input type=\"hidden\" value=\""+data.resultsKeyWords+"\" id=\"hidResultKeywords\" />";
            // $("#totalcount").html(data.oneSearchTotalCount);
            // $("#hidTotalPageCount").val(data.totalPageCount);
        } else {
            var gotoAiSearchUrl = "https://aiplus.cnki.net/aiplus/?question=" + encodeURIComponent(data.singleKeyWord) + "&type=fulllib";;
            html += "<div class=\"no-result\">\n" +
                "        <div class=\"nn\">\n" +
                "                <div class=\"text1\">很抱歉！未检索到与“<span>"+data.singleKeyWord+"</span>”内容相关的文献，<a style=\"cursor: pointer;color: blue;\" href='"+gotoAiSearchUrl+"' target='_blank'>去AI学术助手问答&gt;&gt;</a></div>\n" +
                "            <div class=\"text2\">\n" +
                "                <div class=\"s1\">建议您：</div>\n" +
                "                <div class=\"s2\">• 修改或更换搜索词<br>• 尝试其他相关词，如同义、近义词等<br>• 使用AI学术助手问答<br></div>\n" +
                "            </div>\n" +
                "        </div>\n" +
                "    </div>";
            // $("#totalcount").html(0);
            // $("#hidTotalPageCount").val(0);
        }
        return html;
    },
    renderSummaryViewList:function (articleList){
        var html = "<div class=\"lplist\" style=\"\">";
        if(articleList != null && articleList.length > 0){
            for(var i=0;i<articleList.length;i++) {
                html += searchReponseFuns.renderItem(articleList[i], i, "pl").pl;
            }
        }
        html += "</div>";
        return html;
    },
    renderTableViewList:function (articleList, pageIndex, pageSize){
        var html = "";
        if(articleList != null && articleList.length > 0){
            html += "<table style=\"display: block;\" class=\"re-table\" cellpadding=\"0\" cellspacing=\"0\" width=\"734\">";
            html += "<tbody>";
            html += "<tr class=\"even-row\">\n" +
                "            <th width=\"32\"></th>\n" +
                "            <th width=\"290\">题&nbsp;&nbsp;&nbsp;名</th>\n" +
                "            <th width=\"64\">作者</th>\n" +
                "            <th width=\"95\">来&nbsp;&nbsp;&nbsp;源</th>\n" +
                "            <th width=\"79\">发表时间</th>\n" +
                "            <th width=\"40\">类型</th>\n" +
                "            <th width=\"37\">被引</th>\n" +
                "            <th width=\"50\">下载</th>\n" +
                "            <th class=\"bdgray\" width=\"42\">操作</th>\n" +
                "        </tr>";
            var indexStart = (pageIndex - 1) * pageSize;
            for(var i=0;i<articleList.length;i++) {
                html += searchReponseFuns.renderItem(articleList[i], indexStart+i+1, "table").table;
            }
            html += "</tbody></table>";
        }
        return html;
    },
    clearMarkRedTag: function (str){
        if(str == undefined || str == null || str == "null")
            return "";
        return str.replaceAll("~#@", "").replaceAll("@#~", "");
    },
    covertMarkRedTag2HtmlTag: function (str){
        if(str == undefined || str == null || str == "null")
            return "";
        return str.replaceAll("~#@", "<span style=\"color:red\">").replaceAll("@#~", "</span>");
    },
    renderItem:function (item, index, htmlType){
        var articleStatus = (item.articleStatus == null || item.articleStatus == "null") ? "" : item.articleStatus;
        var articleAssignCode = (item.articleAssignCode == null || item.articleAssignCode == "null") ? "" : item.articleStatus;
        var magaAssignCode = (item.magaAssignCode == null || item.magaAssignCode == "null") ? "" : item.articleStatus;
        var assignType = (item.assignType == null || item.assignType == "null") ? "" : item.articleStatus;
        //(dbType, fileName, dbName, cdNo, uitCode)
        var linkObj = cnkiNodeObj.GetArticleUrl(item.dbType, item.fileName, item.dbName, item.cDNo, item.publishCode);
        var articleUrl = linkObj.articleUrl;

        //来源
        var sourceOriginHtml = "";
        var sourceOriginTableHtml = "";
        var sourceOriginPublishTimeHtml = "";
        if(item.dbType == "CJFD" && item.fileName.trim().length >= 13){
            var cjfdMagaUrl = "";
            cjfdMagaUrl = "https://www.cnki.com.cn/Journal/F-F2-"+item.fileName.trim().substring(0,4)+"-"+item.fileName.trim().substring(4,8)+"-"+item.fileName.trim().substring(8,10)+".htm";
            sourceOriginHtml += "<a href='"+cjfdMagaUrl+"' target=\"_blank\" style=\"cursor:pointer;\"><span title=\""+searchReponseFuns.clearMarkRedTag(item.originate)+"\">《"+searchReponseFuns.covertMarkRedTag2HtmlTag(item.originate)+"》</span></a>";
            sourceOriginHtml += "<a href='"+cjfdMagaUrl+"' target=\"_blank\" style=\"cursor:pointer;\"> <span>"+item.year+"年"+item.period+"期</span> </a>";
            sourceOriginTableHtml = "<a class=\"source-i\" title=\"\" href=\""+cjfdMagaUrl+"\" target=\"_blank\" style=\"cursor:pointer;\">《"+searchReponseFuns.covertMarkRedTag2HtmlTag(item.originate)+"》</a>";
            sourceOriginPublishTimeHtml = "<div>"+item.year+"年"+item.period+"期</div>";
        } else {
            sourceOriginHtml += "<span title=\""+searchReponseFuns.clearMarkRedTag(item.originate)+"\">"+searchReponseFuns.covertMarkRedTag2HtmlTag(item.originate)+"</span>";
            sourceOriginHtml += "<span>&nbsp;"+item.publishTime+"&nbsp;</span>";
            sourceOriginTableHtml= "<div><a class=\"source-i\" title=\""+searchReponseFuns.clearMarkRedTag(item.originate)+"\">"+searchReponseFuns.covertMarkRedTag2HtmlTag(item.originate)+"</a></div>";
            sourceOriginPublishTimeHtml = "<div>&nbsp;"+item.publishTime+"&nbsp;</div>";
        }
        sourceOriginHtml += "<span>"+item.arcitleType+"</span>\n";

        //作者
        var authorHtml = "<span title=\"\">";
        var authorTableHtml = "<div>";
        var authors = searchReponseFuns.clearMarkRedTag(item.author);
        if(authors != "null" && authors.length > 0){
            var authorArr = authors.split(";");
            for(var i=0;i<authorArr.length;i++) {
                authorHtml += "<a data-key=\"" + authorArr[i] + "\" href=\"https://search.cnki.com.cn/Search/Result?author=" + encodeURI(authorArr[i]) + "\" style=\"cursor:pointer;\" target=\"_blank\">\n" +
                    authorArr[i] + " </a>";
                authorTableHtml += "<a class=\"author\" href=\"https://search.cnki.com.cn/Search/Result?author=" + encodeURI(authorArr[i]) + "\" style=\"cursor:pointer;\" target=\"_blank\">\n" +
                    authorArr[i] + " </a>";
            }
        }
        if(item.dbType == "CDFD" || item.dbType == "CMFD"){
            var tutor = searchReponseFuns.clearMarkRedTag(item.tutor);
            if(tutor.length > 0) {
                authorHtml += "<span title=\""+tutor+"\" data-otitle=\""+tutor+"\">导师:<a>"+tutor+"</a></span>";
            }
        }
        authorHtml += "</span>\n";
        authorTableHtml += "</div>";
        var keyWordHtml = "";
        var keywords = searchReponseFuns.clearMarkRedTag(item.keyWord).replace(/;;;|;|:|，/g, ';').replace(/;+$/, '');
        if(keywords.length > 0) {
            var keywordArr = keywords.split(";");
            var keywordsJoin = keywordArr.join("/");
            keyWordHtml += "<p class=\"info_left left\">关键词：";
            for(var i=0;i<keywordArr.length;i++) {
                if(keywordArr[i].length > 0) {
                    keyWordHtml += "<a data-key=\"" + keywordsJoin + "\">"+keywordArr[i]+"</a>";
                    if(i < keywordArr.length - 1) {
                        keyWordHtml += "&nbsp;/&nbsp;";
                    }
                }
            }
            keyWordHtml += "</p>\n";
        }
        var htmlObj = {pl: "", table: ""}
        if(htmlType == undefined || htmlType == "pl") {
            var html = "<div class=\"list-item\">\n" +
                "                <p class=\"tit clearfix\">\n" +
                "                    <input type=\"hidden\" value=\"" + articleStatus + "," + articleAssignCode + "," + assignType + "," + assignType + "\">\n" +
                "                    <a href=\"" + articleUrl + "\" target=\"_blank\" class=\"left\" data-ztcode=\"" + item.zTCode + "\" title=\"" + searchReponseFuns.clearMarkRedTag(item.title) + "\">\n" + searchReponseFuns.covertMarkRedTag2HtmlTag(item.title) + "&nbsp;&nbsp;CNKI文献\n" +
                "                    </a>\n" +
                "                    <a class=\"download left\" target=\"_blank\" href=\"" + articleUrl + "\" title=\"下载\"></a>\n" +
                "                </p>\n" +
                "                <p class=\"nr\">\n" + searchReponseFuns.covertMarkRedTag2HtmlTag(item.summary) + "</p>\n" +
                "                <p class=\"source\">\n" +
                "                        " + authorHtml +
                "                        " + sourceOriginHtml +
                "                </p>\n" +
                "                <div class=\"info\">\n" + keyWordHtml +
                "                    <p class=\"info_right right\">\n" +
                "                            <span class=\"time1\">下载（" + item.downloadCount + "）</span>|<span class=\"time2\">被引（" + item.quoteCount + "）</span>\n" +
                "                    </p>\n" +
                "                </div>\n" +
                "                <div class=\"checkbox1\" data-fn=\"" + item.fileName + "\" style=\"display:none;\"></div>\n" +
                "            </div>";
            htmlObj.pl = html;
        }
        if(htmlType == undefined || htmlType == "table") {
            var tableItem = "<tr class=\"even-row\">\n" +
                "                <td>\n" +
                "                    <span class=\"index\">" + index + "</span>\n" +
                "                    <span class=\"checkbox1\" data-fn=\"" + item.fileName + "\" style=\"display:none;\"></span>\n" +
                "                    <input type=\"hidden\" value=\"" + articleStatus + "," + articleAssignCode + "," + assignType + "," + assignType + "\">\n" +
                "                </td>\n" +
                "                <td>\n" +
                "                    <div class=\"name\">\n" +
                "                        <a href=\"" + articleUrl + "\" target=\"_blank\" title=\"" + searchReponseFuns.clearMarkRedTag(item.title) + "\">\n" + searchReponseFuns.covertMarkRedTag2HtmlTag(item.title) + "</a>\n" +
                "                    </div>\n" +
                "                </td>\n" +
                "                <td>\n" + authorTableHtml + "</td>\n" +
                "                <td>\n" + sourceOriginTableHtml + "</td>\n" +
                "                <td>\n" + sourceOriginPublishTimeHtml + "</td>\n" +
                "                <td>\n" +
                "                    <div>" + item.arcitleType + "</div>\n" +
                "                </td>\n" +
                "                <td><div>" + item.downloadCount + "</div></td>\n" +
                "                <td><div>" + item.quoteCount + "</div></td>\n" +
                "                <td class=\"bdgray\">\n" +
                "                    <a class=\"download\" target=\"_blank\" style=\"cursor:pointer;\" href=\"" + articleUrl + "\" title=\"下载\"></a>\n" +
                "                </td>\n" +
                "            </tr>";
            htmlObj.table = tableItem;
        }
        return htmlObj;
    }
}
