var valid = {
    pInt: /^[0-9]\d*$/,//整数,包括0
    isPInt: function (text) {
        return this.pInt.test(text)
    }
};
// 筛选条件
var condition = {
    init: function () {
        this.bind();
        this.change();
    },
    bind: function () {
        var that = this;
        $('.condition').find('.toogle-btn').on('click', function () {
            that.extend(100);
        });
    },
    change: function () {
        var that = this,
            extendActive = $('.condition').find('.extend-list .item.active');
        for (var i = 0; i < extendActive.length; i++) {
            if ($(extendActive[i]).attr('data-value').split('~').length > 1 || parseInt($(extendActive[i]).attr('data-value')) > 0) {
                that.extend(0);
            }
        }
    },
    extend: function (speed) {
        var toogleText = $('.condition').find('.toogle-text');
        operate_extend.init({
            parentSelector: '.condition',
            icon: 'condition',
            speed: speed
        }, function () {
            toogleText.text('收起筛选');
        }, function () {
            toogleText.text('展开筛选');
        });
    }
};
// 安心服务
var service = {
    init: function () {
        $('.service').find('.toogle-btn').on('click', function () {
            operate_extend.init({
                parentSelector: '.service',
                icon: 'service'
            });
        });
        owa.btn($('.service .toogle-btn'), 'search_service');
        $('.service ul.list li a').on('click', function () {
            var _href = $(this).attr('href');
            _href = _href.substr(0, 4).toLocaleLowerCase() != 'http' ? window.location.origin + _href : _href;
            var source = $(this).attr('data-owa') ? $(this).attr('data-owa') : 'search_service_' + $(this).attr('class');

            owa.load(['trackAction', source, 'pc']);
            owa.load(['setCvtRef', _href, source + '_href']);
        });
    }
};
var operate_extend = {
    init: function (options, openFn, closeFn) {
        util.load(__HOME_ROOT__ + '/search/js/extend.js', function () {
            operate_extend.init(options, openFn, closeFn);
        });
    }
};
var navSearch = {
    init: function () {
        if (util.getIeVersion() > 0 && util.getIeVersion() < 10) {
            setTimeout(function () {
                $('.search-control').removeAttr('aria-hover');
            }, 300)
        }
    }
};
var collect = {
    init: function () {
        this.bind();
    },
    bind: function () {
        $('.exhibition ul.list .title i').on('click', function () {
            operate_collect.req(this);
            var source = $(this).attr('data-owa') ? $(this).attr('data-owa') : 'search_result_item_collect';
            owa.load(['trackAction', source, 'pc']);
        })
    }
};
var operate_collect = {
    req: function (_this) {
        util.load(__HOME_ROOT__ + '/search/js/collect.js', function () {
            operate_collect.req(_this);
        });
    }
};
var exhibition = {
    init: function () {
        this.bind();
        this.notice();
    },
    bind: function () {
        util.lazyImg({
            parentSelector: '.exhibition ul.list',
            delay: 10
        });
    },
    notice: function () {
        var items = $('.exhibition ul.notice li'),
            _auto = false,
            intervalId = 0,
            i = 0;
        function _start() {
            if( _auto ){
                return;
            }
            _auto = true;
            items.eq(i).fadeIn(800, function() {
                // 第一个项目显示完成后，开始循环
                intervalId = setInterval(_next, 5000);
            });
        }
        function _next() {
            items.eq(i).fadeOut(600);
            i = (i + 1) % items.length;
            items.eq(i).fadeIn(800);
        }
        items.hover(function () {
            clearInterval(intervalId)
            _auto = false; 
        }, function () {
            _start();
        });
        _start();
    }
};
var exhibition_title = {
    init: function () {
        new this.scrollList({
            list: $('.exhibition-title ul.res')
        })
    },
    scrollList: function (options) {
        var scrollSpeed = options.speed || 30, // 滚动速度(毫秒)
            currentPosition = 0,
            $list = options.list,
            $li = $list.find('li'),
            li_length = $li.length,
            li_height = $li.eq(0).outerHeight(),
            visibleRows = Math.ceil( $list.parent().height() / li_height);
        if ( li_length < visibleRows) {
            return;
        }
        $list.append($li.eq(0).clone());
        $li = $list.find('li');
        var scrollInterval = setInterval(scrollStep, scrollSpeed);
        function scrollStep () {
            if (currentPosition >= ( li_length < visibleRows ? visibleRows : li_length ) * li_height) {
                currentPosition = 0;
                $list.css('top', '0px');
                return;
            }
            currentPosition += 1;
            $list.css('top', '-' + currentPosition + 'px');
        }
        $list.hover(
            function() {
                clearInterval(scrollInterval);
            },
            function() {
                scrollInterval = setInterval(scrollStep, scrollSpeed);
            }
        ); 
    } 
}
var introduce = {
    init: function () {
        this.lazyText({
            parentSelector: '.exhibition ul.list'
        })
    },
    lazyText: function (options) {
        var that = this,
            $parent = options.parentSelector,
            $lazys = $($parent).find('.lazyText'),
            $error = options.error || '暂无描述',
            loadText = function () {
                // 之前$lazys.each在ie下会有兼容性问题所以改成for
                for (var i = 0; i < $lazys.length; i++) {
                    var $content = $($lazys[i]).find('span').text();
                    if ($content == "" && util.isShow($($lazys[i]))) {
                        that.getTxt($lazys[i], $error);
                    }
                }
            };
        if ($lazys.length) {
            loadText();
            $(window).on('scroll', delayScroll);
            var d;
            function delayScroll() {
                if (d)
                    clearTimeout(d);
                d = setTimeout(function () {
                    loadText();
                }, 300);
            }
        }
    },
    getTxt: function (obj, $error) {
        var that = this,
            $id = $(obj).attr('data-id'),
            $url = search_index.url.getTxt;
        $.ajax({
            url: $url,
            data: {
                aid: $id,
                detail_id: search_index.detail_id,
                keywords: base.search.keyword
            },
            dataType: 'json',
            success: function (res) {
                if (res.code == 1) {
                    $(obj).find('span').text(res.data.text);
                    if (res.data.recent_download) {
                        $(obj).parent().parent().find('.recently').html('<span>最近被下载</span>');
                    }
                    if (res.data.label.length) {
                        var $c = '';
                        for (var i = 0; i < res.data.label.length; i++) {
                            $c += '<a href="javascript:;" title="' + res.data.label[i] + '" data-keyword="' + res.data.label[i] + '">#' + res.data.label[i] + '</a>';
                        }
                        $(obj).parent().parent().find('.tags').html($c);
                        setTimeout(function () {
                            that.bind();
                        }, 100)
                    }
                    if (!$(obj).parent().parent().find('.infos small').length) {
                        // 是vip文档
                        if (res.data.is_free > 0) {
                            $(obj).parent().parent().find('.infos').prepend('<small class="free">免费下载</small>');
                        } else if (res.data.vip_type > 0) {
                            $(obj).parent().parent().find('.infos').prepend('<small class="vip">VIP免费下载</small>');
                        } else {
                            $(obj).parent().parent().find('.infos').prepend('<small class="vip">' + res.data.money + '金币</small>');
                        }
                    }
                    var _collect = $(obj).parent().parent().find('.title i');
                    if (res.data.is_collected)
                        _collect.removeClass('icon-collect-no').addClass('icon-collect-yes');
                    else
                        _collect.removeClass('icon-collect-yes').addClass('icon-collect-no');
                }
            },
            error: function () {
                $(obj).find('span').text($error);
            }
        });
    },
    bind: function () {
        $(".exhibition .list li.item .tags a").off('click').on("click", function () {
            filter._result = [];
            filter._keyword = $(this).attr('data-keyword');
            filter._result.push({ label: 'from', value: 'list-keyword' })
            filter.openUrl(null, '_blank');
            // 删除from字段
            for (var i = filter._result.length - 1; i >= 0; i--) {
                if (filter._result[i].label == 'from') {
                    filter._result.splice(i, 1);
                }
            }
        });
    }
};
var recommend = {
    init: function () {
        this.bind();
    },
    bind: function () {
        util.lazyImg({
            parentSelector: '.recommend',
            delay: 20
        });
    }
};
var examine = {
    init: function () {
        operate_examine.init();
    }
};
var operate_examine = {
    init: function () {
        util.load(__HOME_ROOT__ + '/search/js/examine.js?v=20240521', function () {
            operate_examine.init();
        }, __HOME_ROOT__ + '/search/css/examine.css?v=20210201');
    }
};
var filter = {
    _result: [],
    _keyword: base.search.keyword,
    init: function () {
        this.bind();
    },
    bind: function () {
        var that = this,
            _items = $(".filter-items");
        _items.each(function () {
            var _parent = $(this),
                _a = $(this).find(".item"),
                _active = $(this).find(".item.active");
            _a.on("click", function () {
                that.result(_parent.attr("data-type"), $(this).attr("data-value"));
            });
            if (_active.length > 0 && _active.attr("data-value") != 0) {
                that._result.push({ label: _parent.attr("data-type"), value: _active.attr("data-value") });
            };
        });
    },
    result: function (lab, val) {
        var that = this;
        if (val == 0) {//全部状态
            for (var i = that._result.length - 1; i >= 0; i--) {
                if (that._result[i].label == lab) {
                    that._result.splice(i, 1);
                };
            };
        } else {//常用
            if (!that.isHas(lab, val)) that._result.push({ label: lab, value: val });
        }
        var from = 'filter';
        if (lab == 'order' || lab == 'money') {
            from = 'sort_filter'
        }
        that.openUrl(from);
    },
    isHas: function (lab, val) {
        var that = this;
        for (var i = 0; i < that._result.length; i++) {
            if (lab == 'order' && that._result[i].label == lab && that._result[i].value == val) {
                that._result.splice(i, 1);
                return true;
            } else if ((lab != 'order' && that._result[i].label == lab) || (lab == 'order' && that._result[i].label == lab && that._result[i].value != val)) {
                that._result[i].value = val;
                return true;
            }
        };
        return false;
    },
    openUrl: function (from, targetName) {
        var that = this;
        /**
         * from 来源
         *   related - 右侧最近搜索
         *   filter - 顶部筛选
         *   sort_filter - 价格、最新等 排序筛选
         */
        from = from || 'filter';
        var _href = that.joint();
        _href = _href.substr(0, 4).toLocaleLowerCase() != 'http' ? window.location.origin + _href : _href;
        var source = 'search_' + from + '_item';
        owa.load(['trackAction', source, 'pc']);
        owa.load(['setCvtRef', _href, source + '_href']);
        if (targetName == '_blank') {
            util.imitateClick(that.joint())
        } else {
            location.href = that.joint();
        }
    },
    joint: function () {
        var that = this,
            url = null,
            joinStr = encodeURI(that._keyword);
        that.isRange();
        for (var i = 0; i < that._result.length; i++) {
            joinStr += '&' + that._result[i].label + '=' + that._result[i].value;
        };
        url = search_index.url.sub + joinStr;
        return url;
    },
    // 处理范围查找的数据
    isRange: function () {
        var that = this;
        for (var i = that._result.length - 1; i >= 0; i--) {
            if ((that._result[i].label == 'page_number' || that._result[i].label == 'money') && that._result[i].value.indexOf('~') != -1 && that._result[i].value.split('~').length > 0) {
                var _min = that._result[i].value.split('~')[0],
                    _max = that._result[i].value.split('~')[1],
                    _min = _min ? _min : null,
                    _max = _max ? _max : null,
                    _lab = that._result[i].label == 'page_number' ? "page" : that._result[i].label;
                if (_min)
                    that._result.push({ label: 'min_' + _lab, value: _min });
                if (_max)
                    that._result.push({ label: 'max_' + _lab, value: _max });
                that._result.splice(i, 1);
            }
        }
    }
};
var range = {
    init: function () {
        this.bind();
    },
    bind: function () {
        var $top = $('.range .t'),
            $bottom = $('.range .b');
        $top.each(function () {
            $(this).on('click', function () {
                var $startVal = $(this).find(".start-val").val(),
                    $endVal = $(this).find(".end-val").val();
                $(this).hide();
                $(this).next().show();
                $(this).next().find('input[type="text"]').first().focus();
                if ($startVal)
                    $(this).next().find(".start-val").val($startVal);
                if ($endVal)
                    $(this).next().find(".end-val").val($endVal);
            })
        })
        $bottom.each(function () {
            $(this).on('mouseleave', function () {
                $(this).hide();
                $(this).prev('.t').show();
            })
        })
    }
};
var pageRange = {
    $key: 'page_number',
    init: function () {
        this.bind();
    },
    bind: function () {
        var that = this,
            $btn = $('.pages .b .btn-comfirm'),
            $startInput = $('.pages .b .start-val'),
            $endInput = $('.pages .b .end-val');
        $btn.on('click', function () {
            var $startVal = $(this).parent().find('.start-val').val(),
                $endVal = $(this).parent().find('.end-val').val(),
                $result = null;
            if (+$startVal > +$endVal && $endVal) {
                $result = $endVal + '~' + $startVal;
            } else {
                $result = $startVal + '~' + $endVal;
            };
            filter.result(that.$key, $result.length > 1 ? $result : "");
        });
        $startInput.bind('input propertychange', function () {
            var v = util.trimSpace($(this).val());
            if (!valid.isPInt(v)) {
                $(this).val('');
            };
        });
        $endInput.bind('input propertychange', function () {
            var v = util.trimSpace($(this).val());
            if (!valid.isPInt(v)) {
                $(this).val('');
            };
        });
    }
};
var moneyRange = {
    $key: 'money',
    init: function () {
        this.bind();
    },
    bind: function () {
        var that = this,
            $btn = $('.moneys .b .btn-comfirm'),
            $startInput = $('.moneys .b .start-val'),
            $endInput = $('.moneys .b .end-val');
        $btn.on('click', function () {
            var $startVal = $(this).parent().find('.start-val').val(),
                $endVal = $(this).parent().find('.end-val').val(),
                $result = null;
            if (+$startVal > +$endVal && $endVal) {
                $result = $endVal + '~' + $startVal;
            } else {
                $result = $startVal + '~' + $endVal;
            };
            filter.result(that.$key, $result.length > 1 ? $result : "");
        });
        $startInput.bind('input propertychange', function () {
            var v = util.trimSpace($(this).val());
            if (!valid.isPInt(v)) {
                $(this).val('');
            };
        });
        $endInput.bind('input propertychange', function () {
            var v = util.trimSpace($(this).val());
            if (!valid.isPInt(v)) {
                $(this).val('');
            };
        });
    }
};
var vcode = {
    init: function (callback) {
        if (search_index.check_code == 1) {
            operate_vcode.init(callback);
        }
    }
};
var operate_vcode = {
    init: function (callback) {
        util.load(__HOME_ROOT__ + '/search/js/vcode.js?v=20201204', function () {
            operate_vcode.init(callback);
        });
    }
};
var side_fixed = {
    $side: $('#main .side'),
    $downs: $('.side .downs'),
    $keywords: $('.side .keywords'),
    $d: 0,
    data: {
        fixed_height: 0,
        fixed_top: 0
    },
    init: function () {
        var that = this;
        that.scroll();
        util.plusEventListener(window, 'scroll', that.scroll);
        that.ai();
    },
    scroll: function () {
        var that = side_fixed;
        if (that.$d)
            clearTimeout(that.$d);
        that.$d = setTimeout(function () {
            var is_remove = $('#footer').offset().top - $(window).scrollTop() <= that.data.fixed_height + that.data.fixed_top;
            if (!util.isShow(that.$side)) {
                if ($('.side-fixed').length) {
                    is_remove && $('.side-fixed').remove();
                } else {
                    !is_remove && that.fixed();
                }
            } else {
                $('.side-fixed').length && $('.side-fixed').remove();
            }
        }, 100);
    },
    fixed: function () {
        var that = this,
            $fixed = $('<div class="side-fixed"><div class="container"><div class="side"></div></div></div>'),
            $downs = null,
            $keywords = null;
        if (that.$downs.find('ul.list li').length) {
            that.data.fixed_height = that.$downs.outerHeight();
            that.data.fixed_top = that.$downs.offset().top;
            $downs = that.$downs.clone(true);
        }
        if (that.$keywords.find('ul.list li').length) {
            that.data.fixed_height = that.$keywords.outerHeight();
            that.data.fixed_top = that.$keywords.offset().top;
            $keywords = that.$keywords.clone(true);
        }
        var is_append = $('#footer').offset().top - $(window).scrollTop() > that.data.fixed_height;
        if (($downs || $keywords) && is_append) {
            $fixed.find('.side').append($downs);
            $fixed.find('.side').append($keywords);
            $('body').append($fixed);
            $fixed.fadeIn();
            // 为了防止右侧最近下载悬浮后，封面图不显示的BUG
            util.lazyImg({
                parentSelector: '.side-fixed .downs ul.list',
                delay: 0
            });
        }
    },
    ai: function(){
        var ai_is_ie = util.getIeVersion();
        $('.side .ai .ai-entry').on('click', function () {
            if( ai_is_ie > 0 && ai_is_ie < 10 ){
                util.ie(0)
            }else{
                if( typeof sidebar_ai != 'undefined' ){
                    sidebar_ai.init();
                }else{
                    util.load(__HOME_ROOT__+'/sidebar-ai/js/index.js?v=20260713',function(){
                        sidebar_ai.init();
                    },__HOME_ROOT__+'/sidebar-ai/css/index.css?v=20250526');
                }
            }
        });
    }
};
var owaEvent = {
    init: function () {
        owa.load(['trackAction', 'search_click', 'pc']);
        owa.push(['setGlobalEventProperty', 'curent_page', 'search']);

        owa.click($('.exhibition ul.list li a'), 'search_result_item');
        owa.click($('.side .adview a'), 'search_side_adview');
        owa.click($('.side .ask a'), 'search_side_ask');
    }
};
var search_login = {
    init: function () {
        var that = this;
        switch(base.limit_search){
            case 1:
            case 2:
                that.login();
                break;
            case 100003:
            case 100007:
                layer.confirm(base.limit_message, {
                    icon: 5,
                    btn: ['立即购买VIP', '关闭'] 
                }, function(){
                    window.location.href = '/user_center_v1/home/vip/open?from=search';
                  });
                break;
            case 100008:
                layer.msg(base.limit_message);
                break;
        }
    },
    login: function (fn) {
        auth.init({
            title: '您搜索太过频繁，请登录后操作',
            callback: function () {
                if ($.isFunction(fn)) {
                    fn();
                } else {
                    window.location.reload();
                }
            }
        });
    }
}
var operate_crm_card = {
    init: function (o) {
        util.load(__UTIL_ROOT__ + '/js/crm-card.js?v=20220615', function () {
            operate_crm_card.init(o);
        }, __UTIL_ROOT__ + '/css/crm-card.css?v=20220615');
    }
};
var side_re = {
    data: {
        url: '',
        img: '',
        title: ''
    },
    init: function () {
        var c = '<div class="recommend">' +
            '<a href="' + this.data.url + '" target="_blank" title="' + this.data.title + '">' +
            '<img src="' + this.data.img + '" alt="' + this.data.title + '">' +
            '<i>广告</i>' +
            '</a>' +
            '</div>';
        $('.side').prepend(c);
    }
}
var downs = {
    list: [],
    timer: 0,
    init: function () {
        this.getList();
    },
    bind: function () {
        var that = this;
        util.lazyImg({
            parentSelector: '.downs ul.list',
            delay: 0
        });
        $('.downs ul.list li > a').mouseenter(function () {
            var $el = $(this);
            if (that.timer) {
                clearInterval(that.timer);
            }
            that.timer = setTimeout(function () {
                if ($el.hasClass('active')) {
                    return false;
                }
                $el.parents('ul.list').find('li > a').removeClass('active');
                $el.addClass('active');
                if ($el.find('img.lazy').length) {
                    util.lazyImgLoad('.downs');
                }
            }, 200);
        });
        // 兼容IE7点击封面不能跳转的BUG
        if(util.getIeVersion() == 7) {
            $('.downs ul.list li > a').on('click',function(){
                window.open($(this).attr('href'))
            })
        }
    },
    getList: function () {
        var that = this;
        $.ajax({
            url: search_index.url.side_downs,
            data: {
                detail_id: search_index.detail_id,
                pagesize: 20
            },
            dataType: 'JSON',
            success: function (res) {
                if (res.code == 1) {
                    that.list = res.data;
                }
            },
            complete: function () {
                that.setList();
            }
        });
    },
    setList: function () {
        var that = this,
            data = that.list,
            $c = '';
        if (data.length) {
            for (var i = 0; i < data.length; i++) {
                $c += '<li>' +
                    '<a class="' + (i == 0 ? 'active' : '') + '" href="' + data[i].url + '?from=search-downs&index=' + (i + 1) + '" target="_blank" title="' + data[i].title + '">' +
                    '<i class="icon icon-tag icon-tag-' + (i + 1) + '">' + (i + 1) + '</i>' +
                    '<span class="cover">' +
                    '<img class="lazy" src="' + __HOME_ROOT__ + '/images/lazy/load.png" data-src="' + data[i].litpic + '" alt="' + data[i].title + '">' +
                    '</span>' +
                    '<strong>' + data[i].title + '</strong>' +
                    '<span class="d">' +
                    '<i class="icon-font icon-hit"></i>' +
                    '<small class="num">' + data[i].click + '</small>' +
                    '<small class="line">|</small>' +
                    '<small class="num">' + data[i].pagenumber + '页</small>' +
                    '</span>' +
                    '</a>' +
                    '</li>'
            }
            $('.side .downs').show().find('ul.list').html($c);
            that.bind();
        } else {
            $('.side .downs').remove();
        }
    }
}
var keywords = {
    list: [],
    init: function () {
        this.getList();
    },
    getList: function () {
        var that = this;
        $.ajax({
            url: base.search.url.auto,
            type: 'POST',
            data: {
                keywords: base.search.keyword,
                pagesize: 10
            },
            dataType: 'JSONP',
            success: function (res) {
                if (res.code == 1) {
                    that.list = res.data;
                }
            },
            complete: function () {
                that.setList();
            }
        });
    },
    setList: function () {
        var that = this,
            data = that.list,
            $c = '';
        if (data.length) {
            for (var i = 0; i < data.length; i++) {
                $c += '<li><a href="javascript:;" title="' + data[i].title + '">' + data[i].title + '</a></li>';
            }
            $('.side .keywords').show().find('ul.list').html($c);
            that.bind();
        } else {
            $('.side .keywords').remove();
        }
    },
    bind: function () {
        $(".side .keywords .list li a").on("click", function () {
            filter._result = [];
            filter._keyword = $(this).text();
            filter._result.push({ label: 'from', value: 'side-keyword' });
            filter.openUrl('side-keyword', '_blank');
            // 删除from字段
            for (var i = filter._result.length - 1; i >= 0; i--) {
                if (filter._result[i].label == 'from') {
                    filter._result.splice(i, 1);
                }
            }
        });
    }
}
var search_loadmore = {
    page: 1,
    pagesize: 10,
    total: 100,
    list: [],
    wordsList: [],
    maxWord: 12,
    flag: true,
    length: $('.exhibition .list li.item').length,
    init: function () {
        var that = this;
        that.scroll();
        $(window).on('scroll', that.scroll);
    },
    scroll: function () {
        var that = search_loadmore;
        clearInterval(d);
        var d = setTimeout(function () {
            if (util.isShow($('.load-more>span'))) {
                $(window).off('scroll', that.scroll);
                that.getWordsList();
                that.getList();
            }
        });
    },
    getList: function () {
        var that = this;
        if (!that.flag) return;
        that.page++;
        $.ajax({
            url: search_index.url.loadmore + that.getParams(),
            dataType: 'JSON',
            beforeSend: function () {
                that.flag = false;
            },
            success: function (res) {
                switch (+res.code) {
                    case 1:
                        if (res.data.list && res.data.list.docs) {
                            that.list = res.data.list.docs;
                            that.total = res.data.list.total;
                            that.setList();
                        } else {
                            that.list = [];
                        }
                        // 需要登录
                        if (res.data.limit_search >= 1) {
                            search_login.login(function () {
                                that.page--;
                                that.getList();
                            })
                        }
                        // 需要验证码
                        if (res.data.check_code == 1) {
                            search_index.check_code = 1;
                            vcode.init(function () {
                                that.page--;
                                search_index.check_code = 0;
                                that.getList();
                            })
                        }
                        break;

                    default:
                        break;
                }
            },
            complete: function () {
                that.flag = true;
                var len = $('.exhibition .list li.item').length;
                if (that.total == len || !that.list.length) {
                    that.setWordsList(len - 1, that.maxWord - 1);
                    that.noMore();
                }
            }
        });
    },
    noMore: function () {
        var that = this;
        that.flag = false;
        $(window).on('scroll', that.scroll);
        $('.load-more').remove();
        $('.load-end').fadeIn(600);
    },
    getParams: function () {
        var that = this;
        var search = location.search;
        var params = [];
        var param = '';
        if (search && search.length > 1) {
            var queryString = search.substring(1);
            var arr = queryString.split('&');
            for (var i = 0; i < arr.length; i++) {
                if (arr[i].indexOf('page=') !== 0) {
                    params.push(arr[i]);
                }
            }
        }
        if (params.length > 0) {
            param = '?' + params.join('&') + '&page=' + that.page;
        } else {
            param = '?page=' + that.page;
        }
        return param;
    },
    setList: function () {
        var that = this,
            length = $('.exhibition .list li.item').length,
            index = 0,
            $c = '';
        for (var i = 0; i < that.list.length; i++) {
            index = length + i + 1;
            var i_1 = index - 10;
            $c += '<li class="item'+ ( i_1 %3 === 0 ? ' item-third-after' : '' )+'" data-id="' + that.list[i].encode_aid + '">' +
                '<div class="front">' +
                '<a href="' + that.list[i].url + '?from=search&index=' + index + '" title="' + that.list[i].title + '" class="cover" target="_blank">' +
                (that.list[i].is_publisher ? '<img src="//img.book118.com/sr1/M00/10/03/wKh2AmAXbYGIFNQnAAABjznAr9kAAGRfgCDOe4AAAGn683.png" alt="推广" class="img-tg">' : '') +
                '<img class="lazy" src="' + home_static + '/home/images/lazy/load.png" data-src="' + that.list[i].litpic + '" alt="' + that.list[i].title + '">' +
                (that.list[i].vip_type > 0 ? '<em>VIP</em>' : '') +
                '</a>' +
                '</div>' +
                (
                    that.list[i].filetype != 'zip' ?
                        '<div class="title">' +
                        (that.list[i].stand_status_data ? '<span class="stand-status stand-status-' + that.list[i].stand_status_data.stand_status + '">' + that.list[i].stand_status_data.stand_status_title + '</span>' : '') +
                        '<a href="' + that.list[i].url + '?from=search&index=' + index + '" title="' + that.list[i].title + '" target="_blank">' + that.list[i].highlight + '</a>' +
                        '</div>' +
                        '<div class="intros">' +
                        '<a href="' + that.list[i].url + '?from=search&index=' + index + '" data-id="' + that.list[i].encode_aid + '" title="' + that.list[i].title + '" class="lazyText" target="_blank"><span></span></a>' +
                        '</div>' +
                        '<div class="tags"></div>' +
                        '<div class="infos">' +
                        '<span><i class="icon-font icon-search icon-eye"></i>' + that.list[i].hits + ' | ' + that.list[i].checkdate + '发布 | ' + (that.list[i].filesize || that.list[i].byte_format) + ' | ' + that.list[i].pagenumber + ' 页 ' + (that.list[i].font_number ? ' | ' + that.list[i].font_number : '') + '</span>' +
                        '</div>' +
                        '<div class="recently"></div>'
                        :
                        '<div class="title">' +
                        '<a href="' + that.list[i].url + '?from=search&index=' + index + '" title="' + that.list[i].title + '" target="_blank">' + that.list[i].highlight + '</a>' +
                        '<i class="icon-font icon-search icon-collect-no" data-id="' + that.list[i].encode_aid + '" title="收藏"></i>' +
                        '</div>' +
                        '<div class="tags"></div>' +
                        '<div class="intros">' +
                        '<a href="' + that.list[i].url + '?from=search&index=' + index + '" title="' + that.list[i].title + '" target="_blank">' +
                        '<small>资料包大小：' + (that.list[i].filesize || that.list[i].byte_format) + '</small>' +
                        '<small>本资料包文件包含：' + that.list[i].subfile_number + '个子文件</small>' +
                        '</a>' +
                        '</div>' +
                        '<div class="infos">' +
                        '<span><i class="icon-font icon-search icon-eye"></i>' + that.list[i].hits + ' | ' + that.list[i].checkdate + '发布</span>' +
                        '</div>' +
                        '<div class="recently"></div>'
                ) +
                '</li>';
        }
        $('.exhibition ul.list').append($c);
        setTimeout(function () {
            introduce.init();
            search_list.init();
            exhibition.init();
            $(window).on('scroll', that.scroll);
            //为了解决IE7的兼容问题
            if (util.getIeVersion() == 7) {
                $('.load-more').css({
                    height: $('.load-more').height() == 80 ? '82px' : '80px'
                })
            }
        }, 200)
    },
    getWordsList: function () {
        var that = this;
        if (that.page > 1) return;
        $.ajax({
            url: base.search.url.auto,
            type: 'POST',
            data: {
                keywords: base.search.keyword,
                pagesize: 30
            },
            dataType: 'JSONP',
            success: function (res) {
                if (res.code == 1) {
                    that.wordsList = res.data;
                }
            },
            complete: function () {
                that.setWordsList($('.exhibition .list li.item').length - 1, 0);
            }
        });
    },
    setWordsList: function (index, start) {
        var that = this,
            c = '',
            length = $('.exhibition .list li.item').length,
            data = start == 0 ? that.wordsList.splice(start, that.maxWord) : that.wordsList;  // 截取数组
        if (data.length) {
            if (length > that.length || start == 0) {
                c = '<li class="item-keywords"><div class="hd">大家都在搜</div><div class="bd">';
                for (var i = 0; i < data.length; i++) {
                    c += '<a href="javascript:;" title="' + data[i].title + '">' + data[i].title + '</a>';
                }
                c += '</div></li>';
                $('.exhibition .list li.item').eq(index > 10 && start == 0 ? 10 : index).after(c);
            } else {
                for (var i = 0; i < data.length; i++) {
                    c += '<a href="javascript:;" title="' + data[i].title + '">' + data[i].title + '</a>';
                }
                $('.exhibition .list li.item-keywords .bd').append(c);
            }
            that.bindEvent();
        }
    },
    bindEvent: function () {
        $('.exhibition .list li.item-keywords .bd a').off('click').on("click", function () {
            filter._result = [];
            filter._keyword = $(this).text();
            filter._result.push({ label: 'from', value: 'center-keyword' });
            filter.openUrl('center-keyword', '_blank');
            // 删除from字段
            for (var i = filter._result.length - 1; i >= 0; i--) {
                if (filter._result[i].label == 'from') {
                    filter._result.splice(i, 1);
                }
            }
        });
    }
}
var search_list = {
    init: function () {
        this.bind();
    },
    bind: function () {
        $('.exhibition .list li.item a').off('click').on('click', function () {
            var $id = $(this).parent().parent().attr('data-id');
            $.ajax({
                url: search_index.url.addClickLog,
                dataType: 'JSON',
                data: {
                    aid: $id,
                    detail_id: search_index.detail_id
                }
            });
        })
    }
}
var search_ai = {
    init: function () {
        this.bind();
    },
    bind: function () {
        $('#ai_search ul.btns li a').on('click', function () {
            var k = util.trimSpace( base.search.keyword );
            util.cookie.set('ai_search_q', encodeURI(k));
        })
    }
}
$(function () {
    owaEvent.init();
    // 搜索框
    navSearch.init();
    // 筛选
    filter.init();
    // 筛选条件
    condition.init();
    // 安心服务
    service.init();
    // 相关下载
    downs.init();
    // 相关搜索固定
    side_fixed.init();
    // 区间
    range.init();
    // 收藏
    collect.init();
    // 页码区间确认
    pageRange.init();
    // 金币区间确认
    moneyRange.init();
    // 列表展示
    exhibition.init();
    exhibition_title.init();
    // 异步请求简介
    introduce.init();
    // 推荐
    recommend.init();
    // 调查
    examine.init();
    // 验证码
    vcode.init();
    // 登录
    search_login.init();
    // 右侧推荐
    // side_re.init();
    // 大家都在搜
    // keywords.init();
    // 加载更多数据
    search_loadmore.init();
    // 左侧列表
    search_list.init();
    search_ai.init();
})