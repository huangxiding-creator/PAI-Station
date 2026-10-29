var util = {
	callback: {},
	files: {
		js: [],
		css: []
	},
	version: '1.0.0',
	getIeVersion: function() {
		var userAgent = navigator.userAgent,
			reIE = new RegExp("MSIE (\\d+\\.\\d+);"),
			ie_version = 0;
		if (userAgent.indexOf('compatible') > -1 && userAgent.indexOf('MSIE') > -1) {
			reIE.test(userAgent);
			ie_version = parseFloat(RegExp["$1"]);
		}else if (userAgent.indexOf('Trident') > -1 && userAgent.indexOf('rv:11.0') > -1) { // 检测IE11（Trident引擎）
			ie_version = 11;
		}
		return ie_version;
	},
	init: function() {
		var that = this,
			ie_version = that.getIeVersion();
		if (ie_version > 0 && ie_version < 10) {
			that.ie();
			if ($('input').length) {
				that.load(__PLUGIN_ROOT__ + '/jquery/jquery.enplaceholder.js?v=' + __SRV__ + '20181107', function() {
					$('input').each(function() {
						if ($(this).attr('autocomplete') != 'off') {
							$(this).placeholder();
						} else {
							var p = $(this).attr('placeholder');
							if (p) {
								$(this).attr('aria-hover', 'clear');
								$(this).val(p);
							}
						}
					});
				});
			}
		}
		if ($('input[type=checkbox]').length || $('input[type=radio]').length) {
			that.icheck();
		}
		that.layer();
		that.tab();
	},
	layer: function() {
		layer.config({
			resize: false,
			move: false,
			title: '',
			shade: 0.7,
			closeBtn: 3
		});
	},
    getMaxZIndex: function () {
        var maxZ = Math.max.apply(null, $.map($('body *'), function(e,n) {
    	if ( $(e).css('position') != 'static' ) {
            	return parseInt($(e).css('z-index')) || 1;
            }
        }));
        return maxZ;
    },
	loading: function(msg) {
        var that = this,
            z = that.getMaxZIndex() + 9,
            m = msg ? '<div class="shade"></div><dl class="msg"><dt style="background: url(' + __LIB_ROOT__ +
			'/images/loading.gif) no-repeat center center"></dt><dd>'+msg+'</dd></dl>' : '<div id="loading"><img src="' + __LIB_ROOT__ +
			'/images/loading.gif"/>';
		$('#loading', top.document).remove();
        $(top.document.body).append('<div id="loading" style="z-index:'+z+'">'+m+'</div>');
	},
	loaded: function() {
		$('#loading', top.document)[0] && $('#loading', top.document).remove();
	},
	processing: function() {
        var that = this,
            z = that.getMaxZIndex() + 9;
		!$('#processing', top.document)[0] && $(top.document.body).append(
			'<div id="processing" style="z-index:'+z+'"><div class="box"><img src="' + __LIB_ROOT__ +
			'/images/loading.gif"/><strong>等待系统处理中...</strong></div></div>');
	},
	processed: function() {
		$('#processing', top.document)[0] && $('#processing', top.document).remove();
	},
	lazy: function(_src, callback, _href) {
		var that = this;
		that.loading();
		setTimeout(function() {
			that.load(_src, callback, _href)
		}, 500);
		return false;
	},
	load: function(_src, callback, _href) {
		var that = this;
		that.js(_src, callback);
		_href && that.css(_href);
	},
	js: function(_src, callback) {
		var that = this,
			_v = '',
			_script = document.createElement("script");
		if (_src.indexOf('?v=') != -1) {
			var arr = _src.split('?v=');
			_src = arr[0];
			_v = arr[1];
		}
		if (that.files.js.indexOf(_src) == -1) {
			_script.type = "text/javascript";
			_script.src = _src + '?v=' + that.version + _v;
			document.getElementsByTagName('head')[0].appendChild(_script);
			if (! /*@cc_on!@*/ 0) {
				_script.onload = function() {
					that.loaded();
					callback();
				}
			} else {
				_script.onreadystatechange = function() {
					if (_script.readyState == 'loaded' || _script.readyState == 'complete') {
						that.loaded();
						callback();
					}
				}
			}
			that.files.js.push(_src);
		}
	},
	css: function(_href) {
		var that = this,
			_v = '',
			_css = document.createElement('link');
		if (_href.indexOf('?v=') != -1) {
			var arr = _href.split('?v=');
			_href = arr[0];
			_v = arr[1];
		}
		if (that.files.css.indexOf(_href) == -1) {
			_css.rel = 'stylesheet';
			_css.type = 'text/css';
			_css.href = _href + '?v=' + that.version + _v;
			document.getElementsByTagName('head')[0].appendChild(_css);
			that.files.css.push(_href);
		}
	},
	upload: function(callback) {
		var that = this;
		if (typeof WebUploader != 'undefined') {
			that.load(__UTIL_ROOT__ + '/js/upload.js?v=20230523', function() {
				if (jQuery.isFunction(callback)) {
					callback();
				}
				if (jQuery.isFunction(util.callback.image)) {
					util.callback.image();
				}
			}, __UTIL_ROOT__ + '/css/upload.css?v=20230523');
		}
	},
	captcha: function(o) {
		var c = $('img' + o),
			u = c.prop('src'),
			i = u.indexOf('?');
		u = (i > 0) ? u.substring(0, i) + '?' + Math.random() : u + '?' + Math.random();
		c.prop('src', u);
	},
	valid: function(options) {
		if (typeof util_valid == 'undefined') {
			this.load(__UTIL_ROOT__ + '/js/valid.js?v=' + __SRV__ + '20210803', function() {
				util_valid.init(options);
			});
		} else {
			util_valid.init(options);
		}
	},
	video: function(o,v) {
		var init_video = function() {
			var url = o.attr('data-url'),
				autoplay = o.attr('autoplay')?true:false,
				videoObject = {
					container: '#' + o.attr('id'),
					variable: 'player',
					volume: autoplay ? 0 : '',
					autoplay: autoplay,
					video: (v&&v instanceof Array) ? v :[
						[url, 'video/mp4', '中文标清', 0]
					]
				},
				player = new ckplayer(videoObject);
			document.getElementById('video').children[0].oncontextmenu = function() {
				return false;
			}
			window['ckplayer_'+o.attr('id')] = player;
		};
		if (typeof ckplayer == 'undefined' && o.length > 0) {
			this.load(__PLUGIN_ROOT__ + '/ckplayer/ckplayer.min.js?v=' + __SRV__ + '20220321', function() {
				init_video();
			});
		} else {
			init_video();
		}
	},
	cookie: {
		get: function(name, _return) {
			var nameEQ = name + "=",
				ca = document.cookie.split(';'),
				i,
				c;
			for (i = 0; i < ca.length; i++) {
				c = ca[i];
				while (c.charAt(0) == ' ') c = c.substring(1, c.length);
				if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
			}
			return typeof _return != 'undefined' ? _return : false;
		},
		set: function(name, value, time) {
			var date = new Date(),
				expires = '';
			if (time == 0) {
				date = 'Fri, 31 Dec 9999 23:59:59 GMT';
			} else if (time > 0) {
				date.setTime(date.getTime() + time);
				date = date.toUTCString();
			} else {
				date.setTime(date.getTime() + 1 * (24 - date.getTimezoneOffset() / 60) * 60 * 60 * 1000);
				date = date.toUTCString();
			}
			expires = "; expires = " + date;
			document.cookie = name + "=" + value + expires + "; path=/";
		},
        del: function(name){
            var that = this,
                c = that.get(name),
                date = new Date(),
                expires = '';
            date.setTime(date.getTime() - 1);
            date = date.toUTCString();
            if( c ){
                expires = "; expires = " + date;
			    document.cookie = name + "=" + expires + "; path=/";
            }
        }
	},
	keynum: function(e) {
		var r = e.keyCode > 47 && e.keyCode < 58,
			l = e.keyCode > 95 && e.keyCode < 106;
		return r || l;
	},
	verify: function(options) {
		if (typeof(util_verify) == 'undefined') {
			this.load(__UTIL_ROOT__ + '/js/verify.js?v=' + __SRV__ + '20201918', function() {
				util_verify.init(options);
			});
		} else {
			util_verify.init(options);
		}
	},
	verify_invite: function(options) {
		if (typeof(util_verify) == 'undefined') {
			this.load(__UTIL_ROOT__ + '/js/verify-invite.js?v=' + __SRV__ + '20210126', function() {
				util_verify.init(options);
			});
		} else {
			util_verify.init(options);
		}
	},
	countdown: function(o) {
		var times = o.attr('data-times'),
			is_second = o.attr('data-second') == 'true' ? true : false,
			timer = null,
			content = '',
			old_minute;
		timer = setInterval(function() {
			var day = 0,
				hour = 0,
				minute = 0,
				second = 0; //时间默认值
			if (times > 0) {
				day = Math.floor(times / (60 * 60 * 24));
				hour = Math.floor(times / (60 * 60)) - (day * 24);
				minute = Math.floor(times / 60) - (day * 24 * 60) - (hour * 60);
				second = Math.floor(times) - (day * 24 * 60 * 60) - (hour * 60 * 60) - (minute * 60);
			}
			if (day <= 9) day = '0' + day;
			if (hour <= 9) hour = '0' + hour;
			if (minute <= 9) minute = '0' + minute;
			if (second <= 9) second = '0' + second;
			times--;
			if (typeof old_minute == 'undefined' || is_second || minute != old_minute) {
				content = '<span class="day">' + day + '</span> 天 <span class="hour">' + hour +
					'</span> 小时 <span class="minute">' + minute + '</span> 分 ';
				if (is_second) content += '<span class="second">' + second + '</span> 秒';
				o.html(content);
			}
			old_minute = minute != old_minute ? minute : old_minute;
		}, 1000);
		if (times <= 0) {
			clearInterval(timer);
		}
	},
	msg: function(message, callback, time) {
		var time = time ? time : 1500;
		layer.msg(message, {
			time: time
		});
		switch (callback) {
			case 'reload':
				setTimeout(function() {
					window.location.reload();
				}, time);
				break;
			case 'parent':
				setTimeout(function() {
					parent.location.reload();
				}, time);
				break;
			case 'close':
				setTimeout(function() {
					layer.closeAll();
				}, time);
				break;
			default:
				if (jQuery.isFunction(callback)) {
					setTimeout(function() {
						callback();
					}, time);
				}
				break;
		}
	},
	ie: function(closeBtn) {
		var zone = typeof isIe_zone != 'undefined' ? isIe_zone : top.window;
		if (typeof zone.layer_ie_id != 'undefined') {
			return false;
		}
		var that = this,
			ie = that.cookie.get('IE');
		if (ie == "" || ie != 'LESSTHAN9' || (typeof isIe != 'undefined' && isIe == 1) || closeBtn == 0 ) {
			var content = '<div class="ie-layer">' +
				'<p>您当前使用的IE浏览器版本过低，请更换为IE9以上版本的浏览器；若您使用的是360浏览器，搜狗浏览器等其他国产浏览器，请切换为极速模式访问。</p>' +
				'<dl><dt>切换示例如右图：</dt><dd><img src="' + __UTIL_ROOT__ + '/images/ie.png"/></dd></dl>' +
				(typeof isIe != 'undefined' && isIe == 1 ? '': '<div class="know"><button type="button" class="btn-know"">知道了</button></div>')+
				'</div>';
			zone.layer_ie_id = zone.layer.open({
				type: 1,
				area: ['500px', '450px'],
				skin: 'layui-layer-rim',
				title: '<strong>温馨提示</strong>',
				anim: 5,
				resize: false,
				move: false,
				content: content,
				closeBtn:( typeof isIe != 'undefined' && isIe == 1 || closeBtn == 0  ? 0 : 1),
				success:function(layero,index){
					layero.find('.btn-know').on('click',function(){
						zone.layer.closeAll();
					});
				},
				end: function() {
					util.cookie.set('IE', 'LESSTHAN9');
				}
			});
		}
	},
	wechat: function(options) {
			if (typeof(util_wechat) == 'undefined') {
				this.load(__UTIL_ROOT__ + '/js/wechat.js?v=' + __SRV__ + '20210909', function() {
					util_wechat.init(options);
				}, __UTIL_ROOT__ + '/css/wechat.css?v=' + __SRV__ + '20210908');
			} else {
					util_wechat.init(options);
			}
	},
	clipboard: function(options) {
		/*
		 * options
		 * handlerID：用于点击事件的控件，在html标签里面加上id这个属性；
		 * textID：被复制文本所在的容器的id；
		 * isAttr：用于说明复制的内容是否为控件中的属性值，默认为false（此时复制的内容是textID内的文本），如果设置为true，前提需要在控件这个标签上增添一个属性：data-clipboard-text，属性值就是你要复制的文本；eg: <button id="copy-btn" data-clipboard-text="这里是被复制的内容">复制</button>
		 * type：操作的类型，取值为copy/cut（复制/剪切），默认是copy
		 * */
		var that = this;
		if (typeof window.clipboard == 'undefined') {
			that.load(__PLUGIN_ROOT__ + '/clipboard/clipboard.min.js', function() {
				var clipboard = new ClipBoard(options);
				window.clipboard = ClipBoard;
				clipboard.attach();
			});
		} else {
			var clipboard = new window.clipboard(options);
			clipboard.attach();
		}
		//兼容IE重新封装
		var ClipBoard=function(obj){
			this.handlerID=obj.handlerID||null;
			this.textID=obj.textID||null;
			this.type=obj.type||"copy";
			this.isAttr=obj.isAttr||false;
			this.isPlugin=true;
			this.isActive=false;
			var ua=window.navigator.userAgent;
			var is_IE=ua.match(/(rv:|msie )\d+/i);
			var IE_Version=is_IE?parseInt(is_IE[0].split(/:| /g)[1]):9;
			if(IE_Version<=8){
				this.isPlugin=false
			}
			var handlerObj=document.getElementById(obj.handlerID);
			if(typeof this.type==="string"){
				handlerObj.setAttribute("data-clipboard-action",this.type)
			}else{
				throw error("type类型错误！")
			}
			if(!obj.isAttr&&obj.textID){
				handlerObj.setAttribute("data-clipboard-target","#"+obj.textID)
			}
		};
		ClipBoard.prototype.attach=function(){
			if(this.isActive){return};
			var tip="复制";
			if(this.type==="cut"){
				tip="剪切"
			}
			this.isActive=true;
			if(this.isPlugin){
				var clip=new Clipboard("#"+this.handlerID);
				clip.on("success",function(e){
					layer.msg(tip+"成功，可通过Ctrl+V进行粘贴！",{time:1000})
				})
			}else{
				if(window.attachEvent){
					var self=this;
					var handlerObj=document.getElementById(this.handlerID);
					handlerObj.attachEvent("onclick",function(){
						var text="";
						if(self.isAttr){
							text=handlerObj.getAttribute("data-clipboard-text")
						}else{
							var textObj=document.getElementById(self.textID);
							text=textObj.value||textObj.innerHTML
						};
						window.clipboardData.setData("Text",text);
						layer.msg(tip+"成功，可通过Ctrl+V进行粘贴！",{time:1000});
					})
				}
			}
		};
	},
	icheck: function() {
		if (typeof(util_icheck) == 'undefined') {
			this.load(__UTIL_ROOT__ + '/js/icheck.js', function() {
				util_icheck.init();
			});
		} else {
			util_icheck.init();
		}
	},
	carousel: function(options) {
		var that = this,
			doFun = function() {
				for (var i = 0; i < that.carousel_options.length; i++) {
					new util_carousel(that.carousel_options[i]);
				}
				for (var i = 0; i < that.carousel_options.length; i++) {
					that.carousel_options.splice(i, 1);
				}
			};
		that.carousel_options = that.carousel_options || [];
		that.carousel_options.push(options);
		if (typeof(util_carousel) == 'undefined') {
			util.load(__UTIL_ROOT__ + '/js/carousel.js', function() {
				doFun();
			});
		} else {
			doFun();
		}
	},
	swiper: function(options) {
		var that = this,
			doFun = function() {
				for (var i = 0; i < that.swiper_options.length; i++) {
					new util_swiper(that.swiper_options[i]);
				}
                for (var i = 0; i < that.swiper_options.length; i++) {
					that.swiper_options.splice(i, 1);
				}
			};
		that.swiper_options = that.swiper_options || [];
		that.swiper_options.push(options);
		if (typeof(util_swiper) == 'undefined') {
			util.load(__UTIL_ROOT__ + '/js/swiper.js?v=0.1', function() {
				doFun();
			});
		} else {
			doFun();
		}
	},
	getObjectLength: function(obj) {
		if (typeof Object.getOwnPropertyNames != 'undefined') {
			return Object.getOwnPropertyNames(obj).length;
		} else {
			var i = 0;
			for (var prop in obj) {
				i++;
			}
			return i;
		}
	},
	tab: function($o) {
		var $hover = $o ? $o.find('[data-tab-hover-target]') : $('[data-tab-hover-target]'),
			$click = $o ? $o.find('[data-tab-target]') : $('[data-tab-target]'),
			doFun = function($this, data_target) {
				if ($this.hasClass('active')) {
					return false;
				}
				var _target = $this.attr(data_target),
					$target = $('[data-tab-item="' + _target + '"]'),
					$nav = $this.parents('.tab-nav'),
					$items = $target.parents('.tab-items');
				$nav.find('[' + data_target + ']').removeClass('active');
				$this.addClass('active');
				$items.children('.tab-item').removeClass('active');
				$target.addClass('active');
			};
		$click.on('click', function() {
			doFun($(this), 'data-tab-target');
		});
		$hover.mouseenter(function() {
			doFun($(this), 'data-tab-hover-target');
		});
	},
	multilineOver: function(num) { //多行文本溢出显示省略号
		if (isNaN(parseInt(num, 10))) num = 10;
		var txtStr = $(this).text(),
			sliceStr = txtStr.substr(0, num) + '···';
		if (num >= txtStr.length) return;
		$(this).html(sliceStr);
	},
	trimSpace: function(str) {
		return str.replace(/\ +/g, "").replace(/[ ]/g, "").replace(/[\r\n]/g, "");
	},
	stopFunc: function(e) {
		e.stopPropagation ? e.stopPropagation() : e.cancelBubble = true;
	},
	debounce: function(fn, delay) {
		var d = null;
		return function() {
			if (d) {
				clearInterval(d);
			}
			d = setTimeout(fn, delay);
		}
	},
	arrayRemove: function(_array, v) {
		var index = _array.indexOf(v);
		if (index > -1) {
			_array.splice(index, 1);
		}
	},
	drag: function(opts) {
		/**
		 * drag: 被拖拽对象的css选择器 必传
		 * move: 移动对象的css选择器 非必传，不传则默认是drag对象
		 */
		if(!opts || !opts.drag || !$(opts.drag).length) return;
		var $drag = $(opts.drag),
			$move = opts.move ? $(opts.move) : $drag;
		$drag.mousedown(function(e) {
			e.stopPropagation();
			var mouseStartLeft = e.pageX,
				mouseStartTop = e.pageY,
				elmentsStartLeft = $move.position().left,
				elmentsStartTop = $move.position().top;
			$(document).mousemove(function(e) {
				e.preventDefault();
				var changeX = e.pageX - mouseStartLeft,
					changeY = e.pageY - mouseStartTop,
					elementsCurrentLeft = elmentsStartLeft + changeX,
					elementsCurrentTop = elmentsStartTop + changeY;
				elementsCurrentLeft = elementsCurrentLeft > 0 ? elementsCurrentLeft : 0;
				elementsCurrentTop = elementsCurrentTop > 0 ? elementsCurrentTop : 0;
				if (elementsCurrentLeft > $(this).width() - $move.width()) {
					elementsCurrentLeft = $(this).width() - $move.width();
				}
				if (elementsCurrentTop > $(window).height() - $drag.height()) {
					elementsCurrentTop = $(window).height() - $drag.height();
				}
				$move.css({
					left: elementsCurrentLeft + 'px',
					top: elementsCurrentTop + 'px'
				});
			}).mouseup(function() {
				$(document).off('mousemove');
			})
		}).mouseup(function() {
			$(document).off('mousemove');
		})
	},
	share: function(options) {
		_bd_share_config = {
			common: {
				bdText: options.text,
				bdDesc: options.desc,
				bdUrl: options.url,
				bdPic: options.pic,
				bdSign: 'off'
			},
			api: 'util',
			share: [{
				"bdSize": options.font ? options.font : 32
			}]
		}
		with(document) 0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src =
			__PLUGIN_ROOT__ + '/share/api/js/share.js'];
	},
	qrcode: function(options) {
		var that = this,
			duFun = function() {
				new QRCode(document.getElementById(options.id), {
					text: options.text,
					width: typeof options.width != 'undefined' ? options.width : 240,
					height: typeof options.height != 'undefined' ? options.height : 240,
					colorDark: "#000000",
					colorLight: "#ffffff",
					correctLevel: QRCode.CorrectLevel.H
				});
                options.callback && options.callback();
			};
		if (typeof QRCode == 'undefined') {
			that.load(__PLUGIN_ROOT__ + '/jquery/jquery.qrcode.min.js', function() {
				duFun();
			});
		} else {
			duFun();
		}
	},
	lazyImg: function(options) {
		var that = this,
			parent = options.parentSelector,
			lazy = options.lazy || 'lazy',
			error = options.error || '',
			$imgs = $(parent).find('img.' + lazy),
			delay = typeof options.delay != 'undefined' ? options.delay : 300,
			isShow = jQuery.isFunction(options.show) ? options.show : function() {
				return true
			};
		if ($imgs.length) {
			that.lazyImgs = that.lazyImgs || [];
			that.lazyImgsTimer = that.lazyImgsTimer || 0;
			if (that.lazyImgs.length == 0) {
				$(window).scroll(function() {
				 that.lazyImgLoad();
				});
			}
			that.lazyImgs.push({
				parent: options.parentSelector,
				lazy: lazy,
				error: error,
				delay: delay,
				show: isShow
			});
			that.lazyImgLoad();
		}
	},
	lazyImgLoad: function(active_parent) {
		var that = this,
			showImgs = [],
			len = 0,
			pushShowImgs = function(i) {
				var parent = that.lazyImgs[i].parent,
					lazy = that.lazyImgs[i].lazy,
					isShow = that.lazyImgs[i].show,
					$imgs = [];
				if (that.isShow($(parent))) {
					$imgs = $(parent).find('img.' + lazy);
					if ($imgs.length) {
						$imgs.each(function(index) {
							if (isShow($(this)) && that.isShow($(this))) {
								showImgs.push({
									i: i,
									index: index
								});
							}
						});
					}
				}
			};
		if (that.lazyImgs.length) {
			var active_i = 0;
			if (active_parent) {
				for (var i = 0; i < that.lazyImgs.length; i++) {
					if (that.lazyImgs[i].parent == active_parent) {
						active_i = i;
						break;
					}
				}
			}
			if (active_i) {
				pushShowImgs(active_i);
			} else {
				for (var i = 0; i < that.lazyImgs.length; i++) {
					pushShowImgs(i);
				}
			}
			len = showImgs.length;
			if (len) {
				var max = len - 1,
					r = that.randomNum(0, max),
					i = showImgs[r].i,
					index = showImgs[r].index,
					parent = that.lazyImgs[i].parent,
					lazy = that.lazyImgs[i].lazy,
					delay = that.lazyImgs[i].delay,
					$img = $(parent).find('img.' + lazy).eq(index),
					src = $img.attr('src'),
					error = that.lazyImgs[i].error || src,
					data_src = $img.attr('data-src') || '';
				$img.attr('src', data_src).removeClass(lazy).addClass('lazy-success').error(function() {
					if ($(this).hasClass('lazy-error')) {
						return false;
					} else {
						$(this).attr('src', error).removeClass('lazy-success').addClass('lazy-error');
					}
				});
				setTimeout(function() {
					that.lazyImgLoad(active_parent);
				}, delay<=10 ? 100 : delay);
			}
		}
	},
	/**
	 * 背景图的懒加载
	 * @param {String} options.selector 选择器的名称，必须为类选择器
	 * @param {String} options.error 图片加载失败显示内容，默认<i class="icon icon-lazy icon-lazy-error">暂无封面图</i>
	 */
	lazyBackgroundImg: function(options) {
		var that = this,
			$lazys = $('.' + options.selector),
			delayTime = options.delayTime || 300,
			error = options.error || '<i class="icon icon-lazy icon-lazy-error">暂无封面图</i>',
			loadBgImg = function() {
				clearTimeout(y);
				if ($lazys.length) {
					var showLazys = [];
					for (var i = 0; i < $lazys.length; i++) {
						that.isShow($($lazys[i])) && showLazys.push(i);
					}
					if (showLazys.length) {
						var l = showLazys.length - 1,
							r = that.randomNum(0, l),
							i = showLazys[r],
							$el = $($lazys[i]),
							url = $el.attr('data-url'),
							$img = $('<img src="' + url + '"/>');
						$el.css('background', "url('" + url + "')");
						$img.error(function() {
							$el.append(error);
							$el.css('background', '');
						});
						$el.removeClass(options.selector);
						$lazys.splice(i, 1);
						var y = setTimeout(function() {
							loadBgImg();
						}, delayTime);
					}
				} else {
					$(window).off('scroll', delayScroll);
				}
			}
		if ($lazys.length) {
			loadBgImg();
			$(window).on('scroll', delayScroll)

			function delayScroll() {
				clearTimeout(d);
				var d = setTimeout(function() {
					loadBgImg();
				}, delayTime);
			}
		}
	},
	isShow: function($el) {
        if( $el.length && $el.is(':visible') ){
            var scroll_top = $(window).scrollTop(),
                window_height = $(window).height(),
                offset_top = $el.offset().top,
                height = $el.height();
            return scroll_top <= offset_top + height && scroll_top >= offset_top - window_height;
        }else{
            return false;
        }
	},
	randomNum: function(minNum, maxNum) {
		switch (arguments.length) {
			case 1:
				return parseInt(Math.random() * minNum + 1, 10);
				break;
			case 2:
				return parseInt(Math.random() * (maxNum - minNum + 1) + minNum, 10);
				break;
			default:
				return 0;
				break;
		}
	},
	getImgNaturalSize: function(_img) {
		var natureSize = {};
		if (_img.naturalWidth && _img.naturalHeight) {
			natureSize.width = _img.naturalWidth;
			natureSize.height = _img.naturalHeight;
		} else {
			var img = new Image();
			img.src = _img.src;
			natureSize.width = img.width;
			natureSize.height = img.height;
		}
		return natureSize;
	},
	/*
	 * 首先从最大的数开始遍历，之后递减,随机索引值randomIndex是从0-arr.length中随机抽取的,
	 * 把从数组中随机抽取到的值与当前遍历的值互换位置,
	 * 每一次的遍历都相当于把从数组中随机抽取（不重复）的一个元素放到数组的最后面（索引顺序为：len-1,len-2,len-3......0）
	 */
	randomArray: function(arr) {
		var len = arr.length,
			random_index = 0,
			c = 0;
		for (var i = len - 1; i >= 0; i--) {
			random_index = Math.floor(Math.random() * (i + 1));
			c = arr[random_index];
			arr[random_index] = arr[i];
			arr[i] = c;
		}
		return arr;
	},
	plusEventListener: function($el, event, fun) {
		if ($el.addEventListener) { // 对于所有主流浏览器，IE 8及更早版本除外
			$el.addEventListener(event, fun, false);
		} else if ($el.attachEvent) { // 适用于IE 8及更早版本
			$el.attachEvent(event, fun, false);
		}
	},
	delEventListener: function($el, event, fun) {
		if ($el.addEventListener) { // 对于所有主流浏览器，IE 8及更早版本除外
			$el.addEventListener(event, fun, false);
		} else if ($el.attachEvent) { // 适用于IE 8及更早版本
			$el.attachEvent(event, fun, false);
		}
	},
    windowOpen: function(url){
        var a = $('<a href="'+url+'" target="_blank">打开新窗口</a>').get(0),
            e = document.createEvent('MouseEvents');
        e.initEvent( 'click', true, true );
        a.dispatchEvent(e);
    },
    //获取url地址的参数
    getQueryString: function(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    },
	chat: function(options) {
		var that = this;
		if (typeof util_chat === 'undefined') {
			that.load(__UTIL_ROOT__ + '/js/chat.js', function() {
				util_chat.init(options);
			}, __UTIL_ROOT__ + '/css/chat.css');
		}else{
			util_chat.init(options);
		}
	},
	convertDate: function(timeStamp, format) {//日期格式化
        if (!timeStamp) return '';
		if (format == 'SUBYM') {
			timeStamp = timeStamp + '';
			return timeStamp.substring(0, 4) + '/' + timeStamp.substring(4, timeStamp.length);
		}
        timeStamp = +timeStamp;
        var date = new Date(timeStamp);
        // 年月日
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        month = month < 10 ? '0' + month : month;
        var day = date.getDate();
        day = day < 10 ? '0' + day : day;
        // 时分秒
        var hour = date.getHours();
        hour = hour < 10 ? '0' + hour : hour;
        var min = date.getMinutes();
        min = min < 10 ? '0' + min : min;
        var sec = date.getSeconds();
        sec = sec < 10 ? '0' + sec : sec;
        if (format) {
            format = format.replace('Y', year);
            format = format.replace('M', month);
            format = format.replace('D', day);
            format = format.replace('h', hour);
            format = format.replace('m', min);
            format = format.replace('s', sec);
            return format;
        } else {
            return year+'-'+month+'-'+day;
        }
    },
	htmlEscape: function(str) {//字符转义
		var escapesMap = {
			'<': '&lt;',
			'>': '&gt;',
			'"': '&quot;',
			"'": '&#039;'
		},
		reUnescapedHtml = new RegExp(/[<>"']/g);
		return (str && reUnescapedHtml.test(str))
		? str.replace(reUnescapedHtml, function(chr) {
			return escapesMap[chr];
		}):(str || "");
	},
	htmlUnEscape: function(str) {//反转义
		var unescapes = {
			'&amp;': '&',
			'&lt;': '<',
			'&gt;': '>',
			'&quot;': '"',
			'&#39;': "'"
		},
		reEscapedHtml = new RegExp(/&(?:amp|lt|gt|quot|#39);/g);
		return (str && reEscapedHtml.test(str))
						? str.replace(reEscapedHtml, function(entity) {
							return unescapes[entity];
						}): (str || '')
	},
	// 模拟a标签点击
	imitateClick: function(url, targetName) {
		var aEle = document.createElement("a");
		aEle.setAttribute("href", url);
		aEle.setAttribute("target", targetName || "_blank");
		aEle.setAttribute("id", "previewJumpEle");
		// 防止重复添加
		if (!document.getElementById("previewJumpEle")) {
			document.body.appendChild(aEle);
		}
		// 模拟点击
		aEle.click();
		(aEle.remove && aEle.remove()) || (aEle.removeNode && aEle.removeNode(true));
	},
	im: function(options) {
		var that = util,
				ieV = util.getIeVersion(),
				typeOf = function(obj) {
					return Object.prototype.toString.call(obj).slice(8,-1).toLowerCase();
				};
		if(ieV !== 0 && ieV < 10) {
			util.msg('浏览器版本过低，请升级到IE10及以上或更换为其他浏览器！');
			return;
		}
		if (options.show_type == '1') {
			for (var key in options) {
				if (typeOf(options[key]) !== 'function') {
					var value = typeOf(options[key]) == 'object' ? encodeURIComponent(JSON.stringify(options[key])) : encodeURIComponent(options[key]);
					options[key] = value;
				}
			}
			if(typeof TIM !== 'undefined' && typeof util_im !== 'undefined') return util_im.init(options);
			var tim_time = '20230307';
			that.js(__PLUGIN_ROOT__ + '/tim/tim-js.js?v='+tim_time, function() {
				that.js(__PLUGIN_ROOT__ + '/tim/tim-upload-plugin.js?v='+tim_time, function() {
					that.js(__UTIL_ROOT__ + '/js/im.js?v='+tim_time, function() {
						util_im.init(options);
					});
				});
				that.js(__UTIL_ROOT__ + '/js/im-emoji.js?v='+tim_time, function() {});
				that.css(__UTIL_ROOT__ + '/css/im.css?v='+tim_time, function() {});
			});
			return
		}
		var url = '/user_center_v1/home/chat/chat',
				search = '';
		for (var key in options) {
			var value = typeOf(options[key]) == 'object' ? encodeURIComponent(JSON.stringify(options[key])) : encodeURIComponent(options[key]);
			search += '&' + key + '=' + value;
		}
		if (search.length > 0) {
			search = search.replace('&', '?');
		}
		url += search;
		that.imitateClick(url, 'chat_im');
	},
	intro: function(options) {
		var that = this, ieV = util.getIeVersion();
		if(ieV !== 0 && ieV < 8) return false;
		if(typeof introJs !== 'undefined') {
			introJs().setOptions(options).start();
		}else{
			that.load(__PLUGIN_ROOT__ + '/intro/intro.js', function() {
				introJs().setOptions(options).start().oncomplete(function() {
					options.oncomplete && options.oncomplete();
				}).onexit(function() {
					options.onexit && options.onexit();
				}).onbeforechange(function(el) {
					options.onbeforechange && options.onbeforechange(el);
				}).onchange(function(el) {
					options.onchange && options.onchange(el);
				})
			}, __PLUGIN_ROOT__ + '/intro/introjs.css');
		}
	},
	fieldLayer: function(options) {
		var that = this;
		if(typeof field_layer == 'undefined'){
			that.load(__UTIL_ROOT__ + '/js/field-layer.js?v=' + __SRV__ + '20230629', function() {
				field_layer.init(options);
			}, __UTIL_ROOT__ + '/css/field-layer.css?v=' + __SRV__ + '20230629');
		}else{
			field_layer.init(options);
		}
	},
	// 0是等审核
	// 3是未上传
	guaranteeLayer: function(type,options) {
		var that = this;
		if(type == '3' || type == '2'){
			if(typeof guarantee_layer == 'undefined'){
				that.load(__UTIL_ROOT__ + '/js/guarantee-layer.js?v=' + __SRV__ + '20221208', function() {
					guarantee_layer.init(options);
				}, __UTIL_ROOT__ + '/css/guarantee-layer.css?v=' + __SRV__ + '20221208');
			}else{
				guarantee_layer.init(options);
			}
		}else if(type == '0'){
			if(typeof common_tips_layer == 'undefined'){
				that.load(__UTIL_ROOT__ + '/js/guarantee-layer.js?v=' + __SRV__ + '20221208', function() {
					common_tips_layer.init(options);
				}, __UTIL_ROOT__ + '/css/guarantee-layer.css?v=' + __SRV__ + '20221208');
			}else{
				common_tips_layer.init(options);
			}
		}
	},
	improveMsgLayer: function(type,options) {
		var that = this;
		if(type == '3' || type == '2'){
			if(typeof improve_msg_layer == 'undefined'){
				that.load(__UTIL_ROOT__ + '/js/improve-msg-layer.js?v=' + __SRV__ + '20221208', function() {
						improve_msg_layer.init(options);
				}, __UTIL_ROOT__ + '/css/improve-msg-layer.css?v=' + __SRV__ + '20221208');
			}else{
				improve_msg_layer.init(options);
			}
		}else if(type == '0'){
			if(typeof common_tips_layer == 'undefined'){
				that.load(__UTIL_ROOT__ + '/js/improve-msg-layer.js?v=' + __SRV__ + '20221208', function() {
					common_tips_layer.init(options);
				}, __UTIL_ROOT__ + '/css/improve-msg-layer.css?v=' + __SRV__ + '20221208');
			}else{
				common_tips_layer.init(options);
			}
		}
	},
	notificationLayer: function(type,options) {
		var that = this;
		if(type == '3' || type == '2'){
			if(typeof notification_layer == 'undefined'){
				that.load(__UTIL_ROOT__ + '/js/notification-layer.js?v=' + __SRV__ + '20221227', function() {
					notification_layer.init(options);
				}, __UTIL_ROOT__ + '/css/notification-layer.css?v=' + __SRV__ + '20221227');
			}else{
				notification_layer.init(options);
			}
		}else if(type == '0'){
			if(typeof common_tips_layer == 'undefined'){
				that.load(__UTIL_ROOT__ + '/js/notification-layer.js?v=' + __SRV__ + '20221227', function() {
					common_tips_layer.init(options);
				}, __UTIL_ROOT__ + '/css/notification-layer.css?v=' + __SRV__ + '20221227');
			}else{
				common_tips_layer.init(options);
			}
		}
	},
	addTaskLayer: function(options) {
		var that = this;
			if(typeof task_layer == 'undefined'){
				that.load(__UTIL_ROOT__ + '/js/task-layer.js?v=' + __SRV__ + '20230104', function() {
					task_layer.addTask_layer(options);
				}, __UTIL_ROOT__ + '/css/common-layer.css?v=' + __SRV__ + '20230104');
			}else{
				task_layer.addTask_layer(options);
			}
	},
	getTaskLayer: function(options) {
		var that = this;
			if(typeof task_layer == 'undefined'){
				that.load(__UTIL_ROOT__ + '/js/task-layer.js?v=' + __SRV__ + '20230104', function() {
					task_layer.getTask_layer(options);
				}, __UTIL_ROOT__ + '/css/common-layer.css?v=' + __SRV__ + '20230104');
			}else{
				task_layer.getTask_layer(options);
			}
	},
	//公众号迁移
	officialAccountLayer:function(){
		var that = this;
		if(typeof official_layer == 'undefined'){
			that.load(__UTIL_ROOT__ + '/js/official-account.js?v=' + __SRV__ + '20230905', function() {
				official_layer.init();
			}, __UTIL_ROOT__ + '/css/official-account.css?v=' + __SRV__ + '20230905');
		}else{
			official_layer.init();
		}
	},
	// 阅读统计
	stat: function (fnName, options) {
		if(this.getIeVersion()>0 && this.getIeVersion()<10) return;
		var that = this,
		fnName = fnName ? fnName : 'init',
		doFn = function() {
			for(var i = 0;i<window.statArr.length;i++) {
				if(typeof read_stat != 'undefined'){
                    read_stat[window.statArr[i].fnName](window.statArr[i].options);
                }
			}
			window.statArr = [];
		};
		if(!window.statArr) {
			window.statArr = [];
		}
		window.statArr.push({
			fnName: fnName,
			options: options
		})
		if (typeof read_stat == 'undefined') {
			that.load(__OPEN_ROOT__ + '/statistics/read.js?v=' + __SRV__ + '20231128', function () {
				doFn();
			});
		} else {
			doFn();
		}
	}
};
$(function() {
	util.init();
});
