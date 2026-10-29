//var loadCorpusByZtcode_relevantUrl = "//bianke.cnki.net/subject/";
var loadCorpusByZtcode_relevantUrl = "//bianke.cnki.net";

var searchData = {
    XuewenServerUrl: "http://192.168.107.112:8040",
    CorpusServerUrl: "http://192.168.107.112/web",
    MallServerUrl: "http://192.168.107.112:8091",
    create: function (url, params, callback, posttype) {
        var search = {};
        search.requestUrl = url;
        search.requestParams = params == undefined || params == null ? {} : params;
        search.requestCallBack = callback == undefined || callback == null || typeof (callback) != "function" ? function (json) {
        } : callback;
        search.postType = posttype == undefined || posttype == null ? "jsonp" : posttype;
        search.requestData = [];
        search.post = function () {
            $.post(search.requestUrl, search.requestParams, search.requestCallBack, search.postType);
        }
        return search;
    },

    set: function (options) {
        $.extend(this, options);

    },

    crfdBindHtml: function (json) {
        if (json.errorCode == "E0001") {
            var totalCount = parseInt(json.Count);
            if (isNaN(totalCount) || totalCount <= 0) {
                $("#crfd_result").hide();
                $("#crfd_result_list").hide();
                return;
            }

            var requestData = json.ViewModel;
            $("#crfd_result").html("");
            $("#crfd_result_list").html("");

            var footArr = new Array();

            var regKeyWord = eval("/" + json.KeyWord + "/g");
            var nowShowType = $("#showType").val();
            var html = "";
            var htmlList = "";

            //详细
            html = "<div class=\"list-item baike\">\n";
            var headHtml = "<p class=\"tit clearfix\"><a class=\"left\" href=\"//xuewen.cnki.net/searchentry.aspx?key=" + encodeURI(json.KeyWord) + "\" target=\"_blank\"><i>" + json.KeyWord + "</i>";
            if (json.KeyWord && json.KeyWord.length > 0)
                headHtml += "&nbsp;&nbsp;";
            headHtml += "CNKI百科</a></p>\n";
            var footHtml = "";
            var mainHtml = "<div class=\"bk-box\">\n<div class=\"box\">";
            var mainHeadHtml = "<div class=\"box-top positionR\">";
            var mainItemHtml = "";
            var index = 0;
            $(requestData).each(function () {
                if (index > 2)
                    return false;
                var name = this.Title;
                var bookName = this.BName;
                var showBookName = subbybyte(bookName, 16, true).replace(regKeyWord, "<i>" + json.KeyWord + "</i>");
                //var reg = new RegExp("");
                var content = this.Content.replace(/</g, "").replace(/>/g, "").replace(regKeyWord, "<i>" + json.KeyWord + "</i>");
                var cid = this.Cid;
                var imghtml = "";// this.Img;
                imghtml = "<a href=\"//xuewen.cnki.net/" + this.Bid + ".html\" target=\"_blank\" title=\"" + bookName + "\" class=\"pic left\"><img width=\"70\" height=\"100\" align=\"absmiddle\" src=\"http://refbook.img.cnki.net/crfdpic/small/" + this.Bid + "fm_small.jpg\"></a>";

                var relWordArr = eval(this.RelWord);
                if (relWordArr.length > 0) //相关词
                {
                    for (var i = 0; i < relWordArr.length && i < 3; i++) {
                        if (footHtml.indexOf(relWordArr[i]) == -1 && relWordArr[i] != json.KeyWord) {
                            footHtml += "<a href=\"//xuewen.cnki.net/searchentry.aspx?key=" + encodeURI(relWordArr[i]) + "\" target=\"_blank\">" + relWordArr[i] + "</a>";
                            if (i < 2 && i < relWordArr.length - 1) {
                                footHtml += " / ";
                            }
                        }
                    }
                }
                if (index > 0) {
                    mainHeadHtml += "<span class=\"tab\" data-cid=\"" + this.Cid + "\" title=\"" + bookName + "\">" + showBookName + "</span>\n";
                    mainItemHtml += "<div class=\"tab-cont clearfix\" data-cid=\"" + this.Cid + "\" style=\"display:none;\">\n";
                }
                else {
                    mainHeadHtml += "<span class=\"tab current\" data-cid=\"" + this.Cid + "\" title=\"" + bookName + "\">" + showBookName + "</span>\n";
                    mainItemHtml += "<div class=\"tab-cont clearfix\" data-cid=\"" + this.Cid + "\">\n";
                }
                if (imghtml.length > 0) {
                    mainItemHtml += "<span class=\"pic left\">" + imghtml + "</span>";
                    mainItemHtml += "<p class=\"jianj right\">" + content + "<a href=\"//xuewen.cnki.net/" + this.Cid + ".html\" class=\"qw\" target=\"_blank\">[详细]</a></p>\n";
                }
                else {
                    mainItemHtml += "<p class=\"jianj jianjwt\">" + content + "<a href=\"//xuewen.cnki.net/" + this.Cid + ".html\" class=\"qw\" target=\"_blank\">[详细]</a></p>\n";
                }
                mainItemHtml += "</div>";
                index++;
            });
            mainHeadHtml += "<a class=\"all positionA\" href=\"//xuewen.cnki.net/searchentry.aspx?key=" + encodeURI(json.KeyWord) + "\" target=\"_blank\">查看全部" + totalCount + "个相关百科</a>\n</div>\n";
            mainHtml += mainHeadHtml + mainItemHtml + "</div></div>";
            if (footHtml.length > 10)
                footHtml = "<div class=\"xgbk\">相关百科：" + footHtml + "</div>\n";
            html += headHtml + mainHtml + footHtml;
            html += "</div>\n";


            //list new
            var totalCount = parseInt($("#totalcount").html());
            totalCount = isNaN(totalCount) ? 0 : totalCount;
            //var notCount = totalCount >= 15 ? 15 + 1 : totalCount + 1;
            var notCount = "";
            htmlList = "<table cellspacing=\"0\" cellpadding=\"0\" class=\"re-table re-table1\">\n";
            htmlList += "    <tr>";
            htmlList += "        <td width=\"32\">" + notCount + "</td>";
            htmlList += "        <td width=\"288\" class=\"td1\"><div class=\"name\"><a href=\"//xuewen.cnki.net/searchentry.aspx?key=" + encodeURI(json.KeyWord) + "\" target=\"_blank\"><span class=\"red\">" + json.KeyWord + "</span>__CNKI百科</a></div></td>";
            htmlList += "        <td width=\"\" class=\"td2\" colspan=\"7\">\n<div>\n";
            var index = 0;
            $(requestData).each(function () {
                if (index > 2)
                    return false;
                var name = this.Title;
                var bookName = this.BName;
                var showBookName = subbybyte(bookName, 16, true).replace(regKeyWord, "<i>" + json.KeyWord + "</i>");
                var cid = this.Cid;
                htmlList += "        <a href=\"//xuewen.cnki.net/" + cid + ".html\" target=\"_blank\" title=\"" + bookName + "\">《" + showBookName + "》</a>\n";
                index++;
            });
            htmlList += "        </div></td>\n";
            htmlList += "    </tr>\n";
            htmlList += "</table>\n";

            ////console.log(html);

            $("#crfd_result").append(html);
            $("#crfd_result_list").append(htmlList);

            if (nowShowType == undefined || nowShowType == "0") {
                $("#crfd_result").show();
                $("#crfd_result_list").hide();
            }
            else {
                $("#crfd_result").hide();
                $("#crfd_result_list").show();
            }

            init_crfdBookTitle();
        }
        else {
            $("#crfd_result").hide();
            $("#crfd_result_list").hide();
            ////console.log(json.errorMessages);
        }
    },
    corpusBindHtml: function (json) {
        if (json != undefined) {
            var totalCount = parseInt(json.TotalCount);
            if (isNaN(totalCount) || totalCount <= 0) {
                $("#wenji_result").hide();
                $("#wenji_result_list").hide();
                return;
            }

            var requestData = json.ItemList;
            $("#wenji_result").html("");
            $("#wenji_result_list").html("");
            var regKeyWord = eval("/" + json.KeyWord + "/g");
            var html = "";
            var headHtml = "<p class=\"tit clearfix\"><a href=\"" + json.MoreUrl + "\" target=\"_blank\" class=\"left\"><i>" + json.KeyWord + "</i>&nbsp;&nbsp;知网书</a></p>\n";
            var footHtml = "<p class=\"wenji-more\"><a href=\"" + json.MoreUrl + "\" target=\"_blank\">查看更多相关知网书" + json.TotalCount + "本</a></p>\n";
            var mainItemHtml = "";
            var mainTableHtml = "";
            var mainTableListHtml = "";
            var mainTrHtml = "";
            var mainTr1Html = "";
            var mainTr2Html = "";
            var index = 0;
            var nowShowType = $("#showType").val();
            $(requestData).each(function () {
                var name = subbybyte(this.Title, 26, true).replace(regKeyWord, "<i>" + json.KeyWord + "</i>");
                var pic = this.Pic;
                var url = this.Url;
                var userName = this.UserName;
                if (index < 3) {
                    if (index != 2) {
                        mainItemHtml += "<ul class=\"left\">";
                        mainTrHtml += "<td width=\"8\"></td><td width=\"230\"><a href=\"" + url + "\" target=\"_blank\" title=" + this.Title + ">" + name + "</a></td><td width=\"10\"></td>";
                    }
                    else {
                        mainItemHtml += "<ul class=\"left nomargin\">";
                        mainTrHtml += "<td width=\"8\"></td><td width=\"230\"><a href=\"" + url + "\" target=\"_blank\" title=" + this.Title + ">" + name + "</i></a></td>";
                    }
                    mainItemHtml += "<li><a href=\"" + url + "\" class=\"positionR\" target=\"_blank\"><img src=\"" + pic + "\" width=\"238\" height=\"160\"><span class=\"positionA\">主编：" + userName + "</span></a></li><li class=\"name\"><a href=\"" + url + "\" target=\"_blank\" title=" + this.Title + ">" + name + "</a></li></ul>";
                }
                else if (index < 6) {
                    if (index != 5) {
                        mainTr1Html += "<td width=\"8\"></td><td width=\"230\"><a href=\"" + url + "\" target=\"_blank\" title=" + this.Title + ">" + name + "</a></td><td width=\"10\"></td>";
                    }
                    else {
                        mainTr1Html += "<td width=\"8\"></td><td width=\"230\"><a href=\"" + url + "\" target=\"_blank\" title=" + this.Title + ">" + name + "</i></a></td>";
                    }
                }
                else if (index < 9) {
                    if (index != 8) {
                        mainTr2Html += "<td width=\"8\"></td><td width=\"230\"><a href=\"" + url + "\" target=\"_blank\" title=" + this.Title + ">" + name + "</a></td><td width=\"10\"></td>";
                    }
                    else {
                        mainTr2Html += "<td width=\"8\"></td><td width=\"230\"><a href=\"" + url + "\" target=\"_blank\" title=" + this.Title + ">" + name + "</a></td>";
                    }
                }
                index++;
            });
            var necessaryStr = "<td width=\"8\"></td><td width=\"230\"></td>";
            var extraStr = "<td width=\"10\"></td>";

            if (index < 3 && index > 0) {
                mainTrHtml += index == 2 ? necessaryStr : necessaryStr + extraStr;
            }
            else if (index < 6 && index > 3) {
                mainTr1Html += index == 5 ? necessaryStr : necessaryStr + extraStr;
            }
            else if (index < 9 && index > 6) {
                mainTr2Html += index == 8 ? necessaryStr : necessaryStr + extraStr;
            }
            if (mainItemHtml != "") {
                mainItemHtml = "<div class=\"piclist clearfix\">" + mainItemHtml + "</div>";
            }
            if (mainTrHtml != "") {
                mainTrHtml = "<tr height=\"24\">" + mainTrHtml + "</tr>";
            }
            if (mainTr1Html != "") {
                mainTr1Html = "<tr height=\"24\">" + mainTr1Html + "</tr>";
            }
            if (mainTr2Html != "") {
                mainTr2Html = "<tr height=\"24\">" + mainTr2Html + "</tr>";
            }

            if (mainTrHtml != "" || mainTr1Html != "" || mainTr2Html != "") {
                mainTableHtml = "<table class=\"table1\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"736\">" + mainTr1Html + mainTr2Html + "</table>";
                mainTableListHtml = "<table class=\"table1\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"736\">" + mainTrHtml + mainTr1Html + "</table>";
            }

            //list new
            ////bianke.cnki.net/Web/SearchCollectionPic?kw=%E5%84%BF%E7%AB%A5
            var totalCount = parseInt($("#totalcount").html());
            totalCount = isNaN(totalCount) ? 0 : totalCount;
            //var notCount = totalCount >= 15 ? 15 + 2 : totalCount + 2;
            var notCount = "";
            var htmlList = "<table cellspacing=\"0\" cellpadding=\"0\" class=\"re-table re-table1\">\n";
            htmlList += "    <tr>";
            htmlList += "        <td width=\"32\">" + notCount + "</td>";
            htmlList += "        <td width=\"288\" class=\"td1\"><div class=\"name\"><a href=\"" + json.MoreUrl + "\" target=\"_blank\"><span class=\"red\">" + json.KeyWord + "</span>__知网书</a></div></td>";
            htmlList += "        <td width=\"\" class=\"td2\" colspan=\"7\">\n<div>\n";
            var index = 0;
            $(requestData).each(function () {
                if (index > 1)
                    return false;
                var name = subbybyte(this.Title, 24, true).replace(regKeyWord, "<i>" + json.KeyWord + "</i>");
                htmlList += "        <a href=\"" + this.Url + "\" target=\"_blank\" title=" + this.Title + ">《" + name + "》</a>\n";
                index++;
            });
            htmlList += "        </div></td>\n";
            htmlList += "    </tr>\n";
            htmlList += "</table>\n";

            ////console.log(html);
            $("#wenji_result").html(headHtml + mainItemHtml + mainTableHtml + footHtml);
            $("#wenji_result_list").html(htmlList);

            if (nowShowType == undefined || nowShowType == "0") {
                $("#wenji_result").show();
                $("#wenji_result_list").hide();
            }
            else {
                $("#wenji_result").hide();
                $("#wenji_result_list").show();
            }
        }
        else {
            $("#wenji_result").hide();
            $("#wenji_result_list").hide();
            ////console.log(json.errorMessages);
        }
    },
    corpusBindHtml_relevant: function (json) {
        if (json != undefined) {
            var totalCount = parseInt(json.TotalCount);
            if (isNaN(totalCount) || totalCount <= 0) {
                $("#relevantCorpus_result").hide();
                return;
            }
            var regKeyWord = eval("/" + json.KeyWord + "/g");
            var requestData = json.ItemList;
            var html = "<div class=\"xgqk\">\n";
            var _url = json.MoreUrl == "" ? loadCorpusByZtcode_relevantUrl : json.MoreUrl;
            html += "     <h1 class=\"positionR\">相关知网书<a class=\"positionA more\" href=\"" + _url + "\" target=\"_blank\">更多&gt;&gt;</a></h1>\n";
            html += "     <div class=\"book-list clearfix\">\n";
            var index = 0;
            $(requestData).each(function () {
                if (index >= 4) {
                    return false;
                }
                var name = subbybyte(this.Title, 18, true).replace(regKeyWord, "<i>" + json.KeyWord + "</i>");
                var pic = this.Pic;
                var url = this.Url;
                var userName = this.UserName;
                html += "<ul class=\"left wj\">\n";
                html += "<li><a class=\"positionR\" href=\"" + url + "\" target=\"_blank\" title=\"" + this.Title + "\"><img width=\"140\" height=\"100\" src=\"" + pic + "\"><span class=\"positionA\" title=\"主编：" + userName + "\">主编：" + userName + "</span></a></li>\n";
                html += "<li class=\"name\"><a href=\"" + url + "\" target=\"_blank\" title=\"" + this.Title + "\">" + name + "</a></li>\n";
                html += "</ul>\n";
                index++;
            });
            html += "  </div>\n";
            html += "</div>\n";

            $("#relevantCorpus_result").html(html);
            $("#relevantCorpus_result").show();
        }
        else {
            $("#relevantCorpus_result").hide();
        }
    },
    pindeBindHtml: function (json) {
        if (json != undefined) {
            var totalCount = parseInt(json.total);
            if (isNaN(totalCount) || totalCount <= 0) {
                $("#pinde_result").hide();
                return;
            }
            var realTotalCount = parseInt(json.realtotal); //真空相关的
            realTotalCount = isNaN(realTotalCount) ? 0 : realTotalCount;
            var moreUrl = searchData.MallServerUrl + "/mallsearch/home/book?keys=" + encodeURIComponent(json.keyword) + "&searchType=1";
            var requestData = json.rows;
            $("#pinde_result").html("");
            var regKeyWord = eval("/" + json.keyword + "/g");
            var html = "";
            if (realTotalCount > 0) {
                html += "<p class=\"tit clearfix\"><a href=\"" + moreUrl + "\" target=\"_blank\" class=\"left\"><i>" + json.keyword + "</i>&nbsp;&nbsp;图书</a></p>\n";
            } else {
                html += "<p class=\"tit clearfix\"><a href=\"" + searchData.MallServerUrl + "/Xinke/" + "\" target=\"_blank\" class=\"left\">好书推荐</a></p>\n";
            }
            html += "<div class=\"piclist clearfix\">\n<ul class=\"left\">\n";
            var index = 0;
            var nowShowType = $("#showType").val();
            $(requestData).each(function () {
                var name = json.keyword;
                try {
                    name = subbybyte(this.title, 28, true);
                    name = name.replace(regKeyWord, "<i>" + json.keyword + "</i>");
                    var pic = "//qiangguo.cnki.net/Mall/Images/Book/Cover/Big/" + this.sku + ".jpg";
                    var url = searchData.MallServerUrl + "/xinke/web/info/" + this.sku;
                    if (index < requestData.length - 1) {
                        html += "<li class=\"left\">";
                    } else {
                        html += "<li class=\"left nomargin\">";
                    }
                    html += "<a href=\"" + url + "\" target=\"_blank\" class=\"img\" title=\"" + this.title + "\"><img src=\"" + pic + "\" width=\"126\" height=\"178\" alt=\"" + this.title + "\"></a>\n";
                    html += "<p><a href=\"" + url + "\" target=\"_blank\" title=\"" + this.title + "\">" + name + "</a></p>\n</li>\n";
                } catch (e) {
                }
                index++;
            });
            html += "</ul>\n</div>";

            ////console.log(html);
            $("#pinde_result").html(html);

            if (nowShowType == undefined || nowShowType == "0") {
                $("#pinde_result").show();
            }
            else {
                $("#pinde_result").hide();
            }
        }
        else {
            $("#pinde_result").hide();
            ////console.log(json.error);
        }
    },
    pindeBindHtml_relevant: function (json) {
        if (json != undefined) {
            var totalCount = parseInt(json.total);
            if (isNaN(totalCount) || totalCount <= 0) {
                $("#relevantPinde_result").hide();
                return;
            }
            var realTotalCount = parseInt(json.realtotal); //真空相关的
            realTotalCount = isNaN(realTotalCount) ? 0 : realTotalCount;
            var moreUrl = searchData.MallServerUrl + "/mallsearch/home/book?keys=" + encodeURIComponent(json.keyword) + "";
            var regKeyWord = eval("/" + json.keyword + "/g");
            var requestData = json.rows;
            var html = "<div class=\"xgqk\">\n";
            if (realTotalCount > 0) {
                html += "     <h1 class=\"positionR\">相关图书<a class=\"positionA more\" href=\"" + moreUrl + "\" target=\"_blank\">更多&gt;&gt;</a></h1>\n";
            } else {
                html += "     <h1 class=\"positionR\">好书推荐<a class=\"positionA more\" href=\"" + searchData.MallServerUrl + "/Xinke/" + "\" target=\"_blank\">更多&gt;&gt;</a></h1>\n";
            }
            var html2 = "<ul class=\"rbook clearfix\">";
            var index = 0;
            $(requestData).each(function () {
                var name = json.keyword;
                try {
                    var pic = "//qiangguo.cnki.net/Mall/Images/Book/Cover/Big/" + this.sku + ".jpg";
                    var url = searchData.MallServerUrl + "/xinke/web/info/" + this.sku;
                    var viewUrl = searchData.MallServerUrl + "/GoToOnlineRead.aspx?sourceId=20&cover=2&fName=" + this.sku;
                    if (index == 0) {
						name = subbybyte(this.title, 32, true);
						name = name.replace(regKeyWord, "<i>" + json.keyword + "</i>");
                        html += "<div class=\"bbook clearfix\">\n";
                        html += "<a href=\"" + url + "\" target=\"_blank\" class=\"img left\" title=\"" + this.title + "\"><img src=\"" + pic + "\" width=\"108\" height=\"148\" alt=\"" + this.title + "\" /></a>\n";
                        html += "<div class=\"info\">";
                        html += "<p class=\"tit\"><a href=\"" + url + "\" title=\"" + this.title + "\" target=\"_blank\">" + name + "</a></p>";
                        html += "<p class=\"author\" title=\"" + this.Author + "\">" + subbybyte(this.Author, 16, true) + " 著</p>";
                        html += "<a href=\"" + url + "\" class=\"read\" target=\"_blank\">阅读本书</a>";
                        html += "</div>\n";
                        html += "</div>\n";
                    }
                    else {
						name = subbybyte(this.title, 24, true);
						name = name.replace(regKeyWord, "<i>" + json.keyword + "</i>");
                        html2 += "<li>";
                        html2 += "<a href=\"" + url + "\" target=\"_blank\" class=\"img\" title=\"" + this.title + "\"><img src=\"" + pic + "\" width=\"81\" height=\"112\" alt=\"" + this.title + "\"></a>";
                        html2 += "<p><a href=\"" + url + "\" target=\"_blank\" title=\"" + this.title + "\">" + name + "</a></p>";
                        html2 += "</li>";
                    }
                } catch (e) {
                }
                index++;
            });
            html2 += "</ul>";
            html += html2 + "</div>\n";

            $("#relevantPinde_result").html(html);
            $("#relevantPinde_result").show();
        }
        else {
            $("#relevantPinde_result").hide();
        }
    },
    imageBindHtml: function (json) {


        $("#image_result").append("");
        $("#image_result_list").append("");

        var regKeyWord = eval("/" + json.Keyword + "/g");
        var nowShowType = $("#showType").val();

        var imageClassType = "";
        var totalCount = json.Count;
        if (totalCount == undefined || totalCount <= 0) {
            $("#image_result").hide();
            $("#image_result_list").hide();
            return;
        }

        //at 20170216
        //图片打开的链接地址：//image.cnki.net/MoreTuijian.aspx?id=ZHXU2013010060001&ttype=%E5%90%8C%E6%96%87%E5%9B%BE%E7%89%87
        //图片查看更多 //image.cnki.net/Result.aspx?n=" + encodeURI(json.Keyword)

        //searchConditionPara.DoMainSearch
        var html = "";
        var htmlList = "";

        if (true) {
            html = "<div class=\"list-item xspic\">\n";
            html += "            	<p class=\"tit clearfix\"><a class=\"left\" href='" + searchConditionPara.DoMainSearch + "/Image/home/Result?theme=" + encodeURI(json.Keyword) + "' target=\"_blank\"><i>" + json.Keyword + "</i>&nbsp;&nbsp;CNKI学术图片</a></p>\n";
            html += "            	<div class=\"picbox clearfix\">\n";
            var itemUlStyle = "";
            var itemShowTitle = "";
            for (var j = 0; j < json.Result.length; j++) {
                var item = json.Result[j];
                if (item.ImageType.length > 2 && imageClassType.indexOf(item.ImageType) < 0) {
                    imageClassType += item.ImageType;
                }
                if (j == json.Result.length - 1) {
                    itemUlStyle = "style=\"margin-right:0;\"";
                }
                else {
                    itemUlStyle = "";
                }
                itemShowTitle = subbybyte(item.ChineseTitle, 20, true).replace(regKeyWord, "<i>" + json.Keyword + "</i>");
                html += "            	<ul class=\"left\" " + itemUlStyle + ">\n";
                html += "            	      <li><a href='" + searchConditionPara.DoMainSearch + "/Image/detail/index/" + item.Id + "' target=\"_blank\" title=\"" + item.ChineseTitle + "\"><img width=\"152\" height=\"100\" src=\"" + item.ImageURL + "\" alt=\"" + item.ChineseTitle + "\"></a></li>\n";
                html += "            	      <li class=\"ms\"><a href='" + searchConditionPara.DoMainSearch + "/Image/detail/index/" + item.Id + "' target=\"_blank\" title=\"" + item.ChineseTitle + "\">" + itemShowTitle + "</a></li>\n";
                html += "            	</ul>\n";
            }
            html += "            	</div>\n";
            html += "       <div class=\"info clearfix\">\n";

            //if (imageClassType.length > 0) {
            //    html += "            <div class=\"info_left left\">图片类别：";
            //    var lastIndex = imageClassType.lastIndexOf(";");
            //    if (lastIndex == imageClassType.length - 1)
            //        imageClassType = imageClassType.substr(0, lastIndex);
            //    var imageClassTypeArr = imageClassType.split(";");
            //    var iMaxIndex = imageClassTypeArr.length > 5 ? 5 : imageClassTypeArr.length;

            //    for (var i = 0; i < iMaxIndex; i++) {
            //        if (imageClassTypeArr[i].length > 1) {
            //            html += "<a href='" + searchConditionPara.DoMainSearch + "/Image/home/Result?theme=" + encodeURI(json.Keyword) + "' target=\"_blank\">" + imageClassTypeArr[i] + "</a>";
            //            if (i < iMaxIndex - 1)
            //                html += " /  ";
            //        }
            //    }
            //    html += "            </div>\n";
            //}
            html += "            <div class=\"info_right right\"><a href='" + searchConditionPara.DoMainSearch + "/Image/home/Result?theme=" + encodeURI(json.Keyword) + "' target=\"_blank\">查看全部" + json.Count + "张图片</a></div>\n";
            html += "        </div>\n";
            html += "</div>\n";


            //list new
            var totalCount = parseInt($("#totalcount").html());
            totalCount = isNaN(totalCount) ? 0 : totalCount;
            //var notCount = totalCount >= 15 ? 15 + 3 : totalCount + 3;
            var notCount = "";
            htmlList = "<table cellspacing=\"0\" cellpadding=\"0\" class=\"re-table re-table1\">\n";
            htmlList += "    <tr>";
            htmlList += "        <td width=\"32\">" + notCount + "</td>";
            htmlList += "        <td width=\"288\" class=\"td1\"><div class=\"name\"><a href='" + searchConditionPara.DoMainSearch + "/Image/home/Result?theme=" + encodeURI(json.Keyword) + "' target=\"_blank\"><span class=\"red\">" + json.Keyword + "</span>__CNKI图片</a></div></td>";
            htmlList += "        <td width=\"\" class=\"td2\" colspan=\"7\">\n<div>\n";
            var index = 0;
            for (var k = 0; k < json.Result.length && k < 1; k++) {
                var item = json.Result[k];
                var name = subbybyte(item.ChineseTitle, 40, true).replace(regKeyWord, "<i>" + json.Keyword + "</i>");
                htmlList += "        <a href='" + searchConditionPara.DoMainSearch + "/Image/detail/index/" + item.Id + "' target=\"_blank\" title=" + item.ChineseTitle + ">" + name + "</a>\n";
                index++;
            }
            htmlList += "        </div></td>\n";
            htmlList += "    </tr>\n";
            htmlList += "</table>\n";
        }
        else {
            html = "<div class=\"list-item xspic\">\n";
            html += "            	<p class=\"tit clearfix\"><a class=\"left\" href=\"//image.cnki.net/Result.aspx?n=" + encodeURI(json.Keyword) + "\" target=\"_blank\"><i>" + json.Keyword + "</i>&nbsp;&nbsp;CNKI学术图片</a></p>\n";
            html += "            	<div class=\"picbox clearfix\">\n";
            var itemUlStyle = "";
            var itemShowTitle = "";
            for (var j = 0; j < json.Result.length; j++) {
                var item = json.Result[j];
                if (item.ImageType.length > 2 && imageClassType.indexOf(item.ImageType) < 0) {
                    imageClassType += item.ImageType;
                }
                if (j == json.Result.length - 1) {
                    itemUlStyle = "style=\"margin-right:0;\"";
                }
                else {
                    itemUlStyle = "";
                }
                itemShowTitle = subbybyte(item.ChineseTitle, 20, true).replace(regKeyWord, "<i>" + json.Keyword + "</i>");
                html += "            	<ul class=\"left\" " + itemUlStyle + ">\n";
                html += "            	      <li><a href=\"//image.cnki.net/MoreTuijian.aspx?id=" + item.Id + "&ttype=%E5%90%8C%E6%96%87%E5%9B%BE%E7%89%87\" target=\"_blank\" title=\"" + item.ChineseTitle + "\"><img width=\"152\" height=\"100\" src=\"" + item.ImageURL + "\" alt=\"" + item.ChineseTitle + "\"></a></li>\n";
                html += "            	      <li class=\"ms\"><a href=\"//image.cnki.net/MoreTuijian.aspx?id=" + item.Id + "&ttype=%E5%90%8C%E6%96%87%E5%9B%BE%E7%89%87\" target=\"_blank\" title=\"" + item.ChineseTitle + "\">" + itemShowTitle + "</a></li>\n";
                html += "            	</ul>\n";
            }
            html += "            	</div>\n";
            html += "       <div class=\"info clearfix\">\n";

            if (imageClassType.length > 0) {
                html += "            <div class=\"info_left left\">图片类别：";
                var lastIndex = imageClassType.lastIndexOf(";");
                if (lastIndex == imageClassType.length - 1)
                    imageClassType = imageClassType.substr(0, lastIndex);
                var imageClassTypeArr = imageClassType.split(";");
                var iMaxIndex = imageClassTypeArr.length > 5 ? 5 : imageClassTypeArr.length;

                for (var i = 0; i < iMaxIndex; i++) {
                    if (imageClassTypeArr[i].length > 1) {
                        html += "<a href=\"//image.cnki.net/Result.aspx?n=" + encodeURI(json.Keyword) + "&classtype=" + encodeURI(imageClassTypeArr[i]) + "\" target=\"_blank\">" + imageClassTypeArr[i] + "</a>";
                        if (i < iMaxIndex - 1)
                            html += " /  ";
                    }
                }
                html += "            </div>\n";
            }
            html += "            <div class=\"info_right right\"><a href=\"//image.cnki.net/Result.aspx?n=" + encodeURI(json.Keyword) + "\" target=\"_blank\">查看全部" + json.Count + "张图片</a></div>\n";
            html += "        </div>\n";
            html += "</div>\n";


            //list new
            var totalCount = parseInt($("#totalcount").html());
            totalCount = isNaN(totalCount) ? 0 : totalCount;
            //var notCount = totalCount >= 15 ? 15 + 3 : totalCount + 3;
            var notCount = "";
            htmlList = "<table cellspacing=\"0\" cellpadding=\"0\" class=\"re-table re-table1\">\n";
            htmlList += "    <tr>";
            htmlList += "        <td width=\"32\">" + notCount + "</td>";
            htmlList += "        <td width=\"288\" class=\"td1\"><div class=\"name\"><a href=\"//image.cnki.net/Result.aspx?n=" + encodeURI(json.Keyword) + "\" target=\"_blank\"><span class=\"red\">" + json.Keyword + "</span>__CNKI图片</a></div></td>";
            htmlList += "        <td width=\"\" class=\"td2\" colspan=\"7\">\n<div>\n";
            var index = 0;
            for (var k = 0; k < json.Result.length && k < 1; k++) {
                var item = json.Result[k];
                var name = subbybyte(item.ChineseTitle, 40, true).replace(regKeyWord, "<i>" + json.Keyword + "</i>");
                htmlList += "        <a href=\"//image.cnki.net/MoreTuijian.aspx?id=" + item.Id + "&ttype=%E5%90%8C%E6%96%87%E5%9B%BE%E7%89%87\" target=\"_blank\" title=" + item.ChineseTitle + ">" + name + "</a>\n";
                index++;
            }
            htmlList += "        </div></td>\n";
            htmlList += "    </tr>\n";
            htmlList += "</table>\n";
        }

        $("#image_result").append(html);
        $("#image_result_list").append(htmlList);

        if (nowShowType == undefined || nowShowType == "0") {
            $("#image_result").show();
            $("#image_result_list").hide();
        }
        else {
            $("#image_result").hide();
            $("#image_result_list").show();
        }
    },
    translateBindHtml: function (json) {
        if (json.errorCode == "E0001") {
            var totalCount = parseInt(json.Count);
            if (isNaN(totalCount) || totalCount <= 0) {
                $("#translate_result").hide();
                return;
            }
            var requestData = json.ViewModel;
            //关键词没有对应的翻译时不显示
            if (requestData == "" || requestData == null) {
                return false;
            }
            $("#translate_result").html("");
            var regKeyWord = eval("/" + json.KeyWord + "/g");
            var html = "<div class=\"translate\">\n";
            html += "  <h1>相关翻译</h1>\n";
            html += "  <div class=\"fanyi\">\n";
            html += "    <div class=\"fanyi-inner\">\n";
            html += "      <span class=\"icon positionA\">CNKI翻译助手</span>\n";
            html += "      <p class=\"word\">" + json.KeyWord + "&nbsp;</p>\n";
            var index = 0;
            $(requestData).each(function () {
                if (index > 2)
                    return false;
                var content = subbybyte(this.Content, 30, true).replace(/</g, "").replace(/>/g, "").replace(regKeyWord, "<i>" + json.KeyWord + "</i>");
                var showBookName = subbybyte(this.BName, 24, true);
                html += "<p class=\"shiyi positionR\"><span class=\"tip positionA\">[释义]</span><a href=\"//xuewen.cnki.net/" + this.Cid + ".html\" target=\"_blank\" title=\"" + this.Title + "\">" + content + "</a></p>\n";
                html += "<p class=\"shiyi from positionR textAlignR\">来源：<a href=\"//xuewen.cnki.net/" + this.Bid + ".html\" target=\"_blank\" title=\"" + this.BName + "\">" + showBookName + "</a></p>";
            });
            html += "    </div>\n";
            html += "  </div>\n";
            html += "  <div class=\"fanyi-btm\"></div>\n";
            html += "</div>";
            $("#translate_result").html(html);
            $("#translate_result").show();
        }
        else {
            $("#translate_result").hide();
        }
    }
};

function loadBaikea(content) {

    var search = searchData.create(searchData.XuewenServerUrl + "/request/searchcrfdhandler.ashx?jsoncallback=?", { key: content, txtlen: 220, size: 4 }, searchData.crfdBindHtml, "jsonp");
    search.post();

}

function loadCorpus(content) {
    var search = searchData.create(searchData.CorpusServerUrl + "/api/webapi/SearchCollectionList?jsoncallback=?", { kw: content, pageSize: 9 }, searchData.corpusBindHtml, "jsonp");
    search.post();
}
function loadMallPinde(content) {
    var search = searchData.create(searchData.MallServerUrl + "/xinke/search/searchbooklistapi?jsoncallback=?", { keyword: content, searchType: 1, PageSize: -5, fillOther: 1 }, searchData.pindeBindHtml, "jsonp");
    search.post();
}
function loadImageRelevant(content) {
    if (content.length <= 0)
        return;
    //http://192.168.20.62:8686,  //image.cnki.net
    //var search = searchData.create(getImageReleantUrl, { theme: encodeURI(content), number: 4 }, searchData.imageBindHtml, "json");
    // getImageReleantUrl = searchConditionPara.DoMainSearch + "/api/SearchImageApi/GetImageList";
    // var search = searchData.create(getImageReleantUrl, { theme: encodeURI(content), PageSize: 4 }, searchData.imageBindHtml, "json");
    // search.post();
}

function loadTranslate(content) {
    var search = searchData.create(searchData.XuewenServerUrl + "/request/searchcrfdhandler.ashx?jsoncallback=?", { key: content, txtlen: 80, size: 2, type: 1 }, searchData.translateBindHtml, "jsonp");
    search.post();
}
function loadCorpus_relevant(content) {
    var search = searchData.create(searchData.CorpusServerUrl + "/api/webapi/SearchCollectionList?jsoncallback=?", { kw: content, pageSize: 4 }, searchData.corpusBindHtml_relevant, "jsonp");
    search.post();
}
function loadPindeByZtCode_relevant(content) {
    var search = searchData.create(searchData.MallServerUrl + "/xinke/search/searchbooklistapi?jsoncallback=?", { k_zt: content, PageSize: -4, fillOther: 1 }, searchData.pindeBindHtml_relevant, "jsonp");
    //var search = searchData.create(searchData.MallServerUrl + "/xinke/search/searchbooklistapi?jsoncallback=?", { keyword: '白', searchType: 1, PageSize: 4, fillOther: 1 }, searchData.pindeBindHtml_relevant, "jsonp");
    search.post();
}
function loadCorpusByZtcode_relevant(code) {
    //loadCorpusByZtcode_relevantUrl =loadCorpusByZtcode_relevantUrl+ code;
    var search = searchData.create(searchData.CorpusServerUrl + "/api/WebApi/SearchCorpusByZTCode?jsoncallback=?", { code: code, count: 4 }, searchData.corpusBindHtml_relevant, "jsonp");
    search.post();
}
function init_crfdBookTitle() {
    $(".box-top span").click(function () {
        $(".box-top span").removeClass("current");
        //$(this).siblings("span[class='tab current']").removeClass("current");
        $(this).addClass("current");
        var cid = $(this).attr("data-cid");
        $(this).parent().siblings("div[class='tab-cont clearfix']").hide()
        $(this).parent().siblings("div[data-cid='" + cid + "']").show();
    });
}
function setCrfd_Corpus_ImageResultView(page, isView) {
    if (isView == undefined || isView == null) {
        if (page == 1 && $(".yx >p").size() <= 0 && window.location.href.toLowerCase().indexOf("/search/result") != -1 && window.location.href.toLowerCase().indexOf("/search/literatureresult") == -1) {
            isView = true;
        }
        else {
            isView = false;
        }
    }
    setCrfdResultView(isView);
    setCorpusResultView(isView);
    setImageResultView(isView);
}
function setCrfdResultView(isView) {
    isView = isView == undefined ? false : isView;
    if (isView) {
        var showType = $("#showType").val();
        if (showType == "1") {
            $("#crfd_result").hide();
            $("#crfd_result_list").show();
        }
        else {
            $("#crfd_result").show();
            $("#crfd_result_list").hide();
        }
    }
    else {
        $("#crfd_result").hide();
        $("#crfd_result_list").hide();
    }
}
function setCorpusResultView(isView) {
    isView = isView == undefined ? false : isView;
    if (isView) {
        var showType = $("#showType").val();
        if (showType == "1") {
            $("#wenji_result").hide();
            $("#wenji_result_list").show();
        }
        else {
            $("#wenji_result").show();
            $("#wenji_result_list").hide();
        }
    }
    else {
        $("#wenji_result").hide();
        $("#wenji_result_list").hide();
    }
}
function setImageResultView(isView) {
    isView = isView == undefined ? false : isView;
    if (isView) {
        var showType = $("#showType").val();
        if (showType == "1") {
            $("#image_result").hide();
            $("#image_result_list").show();
        }
        else {
            $("#image_result").show();
            $("#image_result_list").hide();
        }
    }
    else {
        $("#image_result").hide();
        $("#image_result_list").hide();
    }
}

function LoadAjaxDynamicAction(tagId, postUrl, fun, preLoading) {
    if (preLoading != undefined) {
        var preloadingHtml = "";//"<div style=\"margin:100px auto 0;width:239px;\"><img src=\"" + preLoading + "\" width=\"293\" height=\"220\" /></div>";
        $(tagId).html(preloadingHtml);
    }
    if (postUrl != undefined) {
        //&amp; 替换所有的&amp;
        postUrl = postUrl.replace(/&amp;/g, '&');
    }
    $.ajax({
        url: postUrl,
        type: "POST",
        contentType: "application/json;charset=utf-8",
        error: function (request, error, status) {
        },
        success: function (result, status) {
            if ($(tagId) != undefined && (typeof result == 'string') && result.constructor == String) {
                $(tagId).html(result);
                if (fun) {
                    fun();
                }
            }
        }
    });
}

var subbybyte = function (str, n, isBl) {
    var r = /[^\x00-\xff]/g;
    try {
        if (str.replace(r, "mm").length <= n) { return str; }
    } catch (e) {
    }
    try {
        var m = Math.floor(n / 2);
        for (var i = m; i < str.length; i++) {
            if (str.substr(0, i).replace(r, "mm").length >= n) {
                if (isBl)
                    return str.substr(0, i) + "...";
                else
                    return str.substr(0, i);
            }
        }
    } catch (e) {
    }
    return str;
}
var adjustImgSize = function (img, boxWidth, boxHeight) {
    // var imgWidth=img.width();
    // var imgHeight=img.height();
    // 上面这种取得img的宽度和高度的做法有点儿bug
    // src如果由两个大小不一样的图片相互替换时，上面的写法就有问题了，换过之后的图片的宽度和高度始终取得的还是换之前图片的值。
    // 解决方法：创建一个新的图片类，并将其src属性设上。
    var tempImg = new Image();
    tempImg.src = img.attr('src');
    var imgWidth = tempImg.width;
    var imgHeight = tempImg.height;

    //比较imgBox的长宽比与img的长宽比大小
    if ((boxWidth / boxHeight) >= (imgWidth / imgHeight)) {
        //重新设置img的width和height
        img.width((boxHeight * imgWidth) / imgHeight);
        img.height(boxHeight);
        //让图片居中显示
        var margin = (boxWidth - img.width()) / 2;
        img.css("margin-left", margin);
    }
    else {
        //重新设置img的width和height
        img.width(boxWidth);
        img.height((boxWidth * imgHeight) / imgWidth);
        //让图片居中显示
        var margin = (boxHeight - img.height()) / 2;
        img.css("margin-top", margin);
    }
};

var searchBox = {
    nav: { all: "全部", qk: "期刊" },
    requestParams: {},

    create: function () {

    }
}

function cutStr(str, len, ellipsis) {
    ellipsis = ellipsis == undefined ? false : true;
    var len1 = 0;
    var newStr = "";
    for (var i = 0; i < str.length; i++) {
        if (str.charCodeAt(i) >= 10000) {
            len1 += 2;
        }
        else {
            len1++;
        }
        if (len1 <= len) {
            if (i < str.length - 1)
                newStr += str.substr(i, 1); //i后取一位,
            else
                newStr += str.substr(i);
        }
        else {
            if (ellipsis)
                newStr += "...";
            break;
        }
    }
    return newStr;
}

var cnkibrowser = {};
function userBrowser() {
    var userAgent = navigator.userAgent,
		rMsie = /(msie\s|trident.*rv:)([\w.]+)/,
		rFirefox = /(firefox)\/([\w.]+)/,
		rOpera = /(opera).+version|(opr)\/([\w.]+)/,
    //rOpera = /(opera).+version\/([\w.]+)/,
		rChrome = /(chrome)\/([\w.]+)/,
		rSafari = /version\/([\w.]+).*(safari)/,
        rEdge = /(edge)\/([\w.]+)/;
    var ua = userAgent.toLowerCase();

    var version = "0";
    var match = rMsie.exec(ua);
    if (match != null) {
        cnkibrowser.msie = true;
        cnkibrowser.name = "msie";
        version = match[2] || "0";
    }
    match = rFirefox.exec(ua);
    if (match != null) {
        cnkibrowser.firefox = true;
        cnkibrowser.name = match[1] || "firefox";
        version = match[2] || "0";
    }
    match = rChrome.exec(ua);
    if (match != null) {
        cnkibrowser.chrome = true;
        cnkibrowser.name = match[1] || "chrome";
        version = match[2] || "0";
    }
    match = rOpera.exec(ua);
    if (match != null) {
        cnkibrowser.opera = true;
        cnkibrowser.name = match[1] || "opera";
        version = match[2] || "0";
        if (match.length > 3) {
            version = match[3] || "0";
        }
    }
    match = rSafari.exec(ua);
    if (match != null) {
        cnkibrowser.safari = true;
        cnkibrowser.name = match[2] || "safari";
        version = match[1] || "0";
    }
    match = rEdge.exec(ua);
    if (match != null) {
        cnkibrowser.edge = true;
        cnkibrowser.msie = true;
        cnkibrowser.name = "msie";
        version = match[2] || "0";
    }
    var num = parseInt(version);
    cnkibrowser.version = isNaN(num) ? 0 : num;
}
//设为首页
function setHomePage(url) {
    url = url == undefined ? window.location : url;
    if (document.all) {
        document.body.style.behavior = 'url(#default#homepage)';
        document.body.setHomePage(url);
    }
    else if (window.sidebar) {
        if (window.netscape) {
            try {
                netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
            }
            catch (e) {
                alert("该操作被浏览器拒绝，如果想启用该功能，请在地址栏内输入 about:config,然后将项 signed.applets.codebase_principal_support 值该为true");
            }
        }
        var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
        prefs.setCharPref('browser.startup.homepage', url);
    }
}
//加入收藏夹
function addFavorite(url, title) {
    var title = title == undefined ? document.title : title;
    var url = url == undefined ? location.href : url;
    try {
        window.external.addFavorite(url, title);
    }
    catch (e) {
        try {
            window.sidebar.addPanel(title, url, "");
        }
        catch (e) {
            alert("请您点击浏览器的“添加到收藏夹”按钮，进行收藏");
        }
    }
}
//创建桌面网址快捷方式
function toDesktop(sUrl, title) {
    CreateShortcut();
    return;
    var title = title == undefined ? document.title : title;
    var url = url == undefined ? location.href : url;
    try {
        var WshShell = new ActiveXObject("WScript.Shell");
        var UrlLink = WshShell.CreateShortcut(WshShell.SpecialFolders("Desktop") + "\\" + title + ".url");
        oUrlLink.TargetPath = sUrl;
        oUrlLink.Save();
    }
    catch (e) {
        alert("当前浏览器安全级别不允许操作！");
    }
}
var scrolldelay = null;
function pageScroll() {
    if (document.documentElement.scrollTop == 0)
        clearTimeout(scrolldelay);
    window.scrollBy(0, -10);
    scrolldelay = setTimeout('pageScroll()', 100);
}

function CreateShortcut() {
    try {
        var fso = new ActiveXObject("Scripting.FileSystemObject");
        var shell = new ActiveXObject("WScript.Shell");
        var tagFolder = shell.SpecialFolders("Desktop");
        if (!fso.FolderExists(tagFolder)) {
            fso.CreateFolder(tagFolder);
        }
        if (!fso.FileExists(tagFolder + "\\乐猪软件.lnk")) {
            varWshSysEnv = shell.Environment("Process");
            iLocal = (WshSysEnv.Item("SystemRoot") + "\\1.ico"); //下载到C:\windows\1.ico
            iRemote = ("/Images/2.ico"); //先下载图标文件，再用自定义图标把首页的图标地址替换
            varxPost = new ActiveXObject("Microsoft.XMLHTTP");
            xPost.Open("GET", iRemote, 0);
            xPost.Send();
            varsGet = new ActiveXObject("ADODB.Stream");
            sGet.Mode = 3;
            sGet.Type = 1;
            sGet.Open();
            sGet.Write(xPost.ResponseBody);
            sGet.SaveToFile(iLocal, 2);
            varlink = shell.CreateShortcut(tagFolder + "\\编程入门管理系统.lnk");
            link.Description = "打开基本软件的快捷方式";
            link.Hotkey = "Ctrl+Alt+e";
            link.TargetPath = "http://www.lezhu99.com/";
            link.IconLocation = iLocal;
            link.WindowStyle = 3;
            link.WorkingDirectory = "c:\\blah";
            link.Save();
            alert("恭喜！快捷方式创建成功！");
        }
    }
    catch (ex) {
        alert("快捷方式创建失败，可能浏览器不支持！");
    }
}

//++++++++++++++++++++++去下载的，
function goDownload(rurl,url) {
    if (rurl)
    {
        rurl = encodeURIComponent(rurl);
    }
    url = url + "&rurl=" + rurl;
    openUrl(url);
    //checkLoginStatus(url);
}

function downArticle(curObj) {
    try {
        var d_fn = curObj.getAttribute("data-fn");
        var d_dbcode = curObj.getAttribute("data-dbcode");
        var d_year = curObj.getAttribute("data-year");
        var d_dflag = curObj.getAttribute("data-dflag");
        if (d_dflag == null || d_dflag.length <= 0) {
            d_dflag = "pdfdown";
            if (d_dbcode.toLowerCase() == "CDFD" || d_dbcode.toLowerCase() == "CMFD" || d_dbcode.toLowerCase() == "CDMD") {
                d_dflag = "cajdown";
            }
        }
        var d_drange = curObj.getAttribute("data-drange");
        if (d_drange == null)
            d_drange = "";
        //================================下载没登录时弹框=============================url
        var url = searchConditionPara.DoMainSearch + "/Home/DownloadArticle?id=" + d_fn + "&dbtype=" + d_dbcode + "&year=" + d_year + "&dflag=" + d_dflag + "&drange=" + d_drange;
        openUrl(url);
        //checkLoginStatus(url);
    }
    catch (e) {
        //alert(e);
    }
    //return true;
}
function checkLoginStatus(url) {
    $('.loading02').show();
    var isAsync = true;
    $.ajax({
        type: "post",
        dataType: "json",
        data: "",
        url: $('#pageUrl').val() + "/home/JudgeLoginState",
        async: isAsync,
        success: function (restult) {
            if (restult == "" || restult == "noLogin") {
                $('.login-html').show();
                $('.login-html .btn').unbind("click");
                $('.login-html .btn').bind("click", function () {
                    login(url, '', openUrl, isAsync);
                });
            }
            else {
                openUrl(url);
            }
            $('.loading02').hide();
            return false;
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
        }
    });
}
function openUrl(url) {
    try {
        if (/MSIE\s*(\d+\.\d+);/.test(navigator.userAgent) || /MSIE(\d+\.\d+);/.test(navigator.userAgent) || navigator.userAgent.indexOf('MSIE') >= 0 || navigator.userAgent.indexOf('msie') >= 0) {
            var referLink = document.createElement('a');
            referLink.href = url;
            referLink.target = "_blank";
            document.body.appendChild(referLink);
            referLink.click();
        } else {
            //window.location.href = url;
            //window.open(url);
            var a = $("<a href='" + url + "' target='_blank'>download</a>").get(0);
            var e = document.createEvent('MouseEvents');
            e.initEvent('click', true, true);
            a.dispatchEvent(e);
        }
    } catch (e) {
        //window.location.href = url;
        window.open(url);
    }
}

function downArticle2(curObj) {
    try {
        var d_fn = curObj.getAttribute("data-fn");
        var d_dbcode = curObj.getAttribute("data-dbcode");
        var d_year = curObj.getAttribute("data-year");
        var d_dflag = curObj.getAttribute("data-dflag");
        if (d_dflag == null || d_dflag.length <= 0) {
            d_dflag = "pdfdown";
            if (d_dbcode.toLowerCase() == "CDFD" || d_dbcode.toLowerCase() == "CMFD" || d_dbcode.toLowerCase() == "CDMD") {
                d_dflag = "cajdown";
            }
        }
        var d_drange = curObj.getAttribute("data-drange");
        if (d_drange == null)
            d_drange = "";
        var url = "//search.cnki.com.cn/down/default.aspx?filename=" + d_fn + "&dbcode=" + d_dbcode + "&year=" + d_year + "&dflag=" + d_dflag + "&drange=" + d_drange;
        try {
            if (/MSIE\s*(\d+\.\d+);/.test(navigator.userAgent) || /MSIE(\d+\.\d+);/.test(navigator.userAgent) || navigator.userAgent.indexOf('MSIE') >= 0 || navigator.userAgent.indexOf('msie') >= 0) {
                var referLink = document.createElement('a');
                referLink.href = url;
                document.body.appendChild(referLink);
                referLink.click();
            } else {
                window.location.href = url;
            }
        } catch (e) {
            window.location.href = url;
        }
    }
    catch (e) {
        //alert(e);
    }
    //return true;
}
//js subStr重写
String.prototype.autoCutStr = function (start, len, ellipsis) {
    ellipsis = ellipsis == undefined ? false : true;
    var str = this;
    var len1 = 0;
    var newStr = "";
    for (var i = start; i < str.length; i++) {
        if (str.charCodeAt(i) >= 10000) {
            len1 += 2;
        }
        else {
            len1++;
        }
        if (len1 <= len * 2) {
            if (i < str.length - 1)
                newStr += str.substr(i, 1); //i后取一位,
            else
                newStr += str.substr(i);
        }
        else {
            if (ellipsis)
                newStr += "...";
            break;
        }
    }
    return newStr;

}

//滑动Scroll取数据-知网节
function InitScrollFun(itemArry, funArry) {

    if (itemArry && itemArry.length > 0) {
        for (var i = 0; i < itemArry.length; i++) {
            var item = itemArry[i];
            LoadAjaxDynamicAction(item.id, item.url);
        }
    }
    if (funArry && funArry.length > 0) {
        for (var i = 0; i < funArry.length; i++) {
            var item = funArry[i];
            if (item != undefined && item != null && typeof (item) == "function") {
                item();
            }
        }
    }
    //    }
    //});
}
