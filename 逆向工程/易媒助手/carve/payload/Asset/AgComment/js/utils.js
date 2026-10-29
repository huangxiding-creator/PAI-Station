const Base64 = {
	_keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",

	encode: function (e) {
		var t = "";
		var n, r, i, s, o, u, a;
		var f = 0;
		e = Base64._utf8_encode(e);
		while (f < e.length) {
			n = e.charCodeAt(f++);
			r = e.charCodeAt(f++);
			i = e.charCodeAt(f++);
			s = n >> 2;
			o = ((n & 3) << 4) | (r >> 4);
			u = ((r & 15) << 2) | (i >> 6);
			a = i & 63;
			if (isNaN(r)) {
				u = a = 64;
			} else if (isNaN(i)) {
				a = 64;
			}
			t =
				t +
				this._keyStr.charAt(s) +
				this._keyStr.charAt(o) +
				this._keyStr.charAt(u) +
				this._keyStr.charAt(a);
		}
		return t;
	},

	decode: function (e) {
		var t = "";
		var n, r, i;
		var s, o, u, a;
		var f = 0;
		e = e.replace(/[^A-Za-z0-9+/=]/g, "");
		while (f < e.length) {
			s = this._keyStr.indexOf(e.charAt(f++));
			o = this._keyStr.indexOf(e.charAt(f++));
			u = this._keyStr.indexOf(e.charAt(f++));
			a = this._keyStr.indexOf(e.charAt(f++));
			n = (s << 2) | (o >> 4);
			r = ((o & 15) << 4) | (u >> 2);
			i = ((u & 3) << 6) | a;
			t = t + String.fromCharCode(n);
			if (u != 64) {
				t = t + String.fromCharCode(r);
			}
			if (a != 64) {
				t = t + String.fromCharCode(i);
			}
		}
		t = Base64._utf8_decode(t);
		return t;
	},

	_utf8_encode: function (e) {
		e = e.replace(/rn/g, "n");
		var t = "";
		for (var n = 0; n < e.length; n++) {
			var r = e.charCodeAt(n);
			if (r < 128) {
				t += String.fromCharCode(r);
			} else if (r > 127 && r < 2048) {
				t += String.fromCharCode((r >> 6) | 192);
				t += String.fromCharCode((r & 63) | 128);
			} else {
				t += String.fromCharCode((r >> 12) | 224);
				t += String.fromCharCode(((r >> 6) & 63) | 128);
				t += String.fromCharCode((r & 63) | 128);
			}
		}
		return t;
	},

	_utf8_decode: function (e) {
		var t = "";
		var n = 0;
		var r = 0,
			c2 = 0,
			c3 = 0;
		while (n < e.length) {
			r = e.charCodeAt(n);
			if (r < 128) {
				t += String.fromCharCode(r);
				n++;
			} else if (r > 191 && r < 224) {
				c2 = e.charCodeAt(n + 1);
				t += String.fromCharCode(((r & 31) << 6) | (c2 & 63));
				n += 2;
			} else {
				c2 = e.charCodeAt(n + 1);
				c3 = e.charCodeAt(n + 2);
				t += String.fromCharCode(((r & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
				n += 3;
			}
		}
		return t;
	}
};

function Encode64(str) {
	return btoa(
		encodeURIComponent(str).replace(/%([0-9A-F]{2})/g, function toSolidBytes(match, p1) {
			return String.fromCharCode("0x", p1);
		})
	);
}

function Decode64(str) {
	return decodeURIComponent(
		atob(str)
			.split("")
			.map(function (c) {
				return "%" + ("00" + c.charCodeAt(0).toString(16)).slice(-2);
			})
			.join("")
	);
}

function getBaseString(response) {
	let str = Decode64(response);
	let indexs = str.lastIndexOf("|");
	let result = JSON.parse(str.substring(0, indexs));
	return result;
}

/*
防抖原理：一定时间内，只有最后一次操作，再过wait毫秒后才执行函数
@param {Function} func 要执行的回调函数
@param {Number} wait 延时的时间
@param {Boolean} immediate 是否立即执行
@return null
*/
function debounce(func, wait, immediate) {
	let timeout;

	return function () {
		let context = this;

		let args = arguments;

		if (timeout) clearTimeout(timeout);

		if (immediate) {
			var callNow = !timeout;

			timeout = setTimeout(() => {
				timeout = null;
			}, wait);

			if (callNow) func.apply(context, args);
		} else {
			timeout = setTimeout(function () {
				func.apply(context, args);
			}, wait);
		}
	};
}

/**
@desc 函数节流
@param func 函数
@param wait 延迟执行毫秒数
@param type 1 表时间戳版，2 表定时器版
*/

function throttle(func, wait, type) {
	if (type === 1) {
		let previous = 0;
	} else if (type === 2) {
		let timeout;
	}
	return function () {
		let context = this;

		let args = arguments;

		if (type === 1) {
			let now = Date.now();

			if (now - previous > wait) {
				func.apply(context, args);

				previous = now;
			}
		} else if (type === 2) {
			if (!timeout) {
				timeout = setTimeout(() => {
					timeout = null;
					func.apply(context, args);
				}, wait);
			}
		}
	};
}

function formatDateTime(date) {
	const year = date.getFullYear();
	const month = date.getMonth() + 1;
	const day = date.getDate();
	const hour = date.getHours();
	const minute = date.getMinutes();
	const second = date.getSeconds();
	return `${year}-${formatNum(month)}-${formatNum(day)} ${formatNum(hour)}:${formatNum(minute)}`;
}

/**
 * 将时间戳转化为年 月 日 时 分 秒
 * timestamps: 传入的时间戳
 * format：返回格式，支持自定义，如：
 * yyyy-mm-dd hh:mi:ss SSS
 * yyyy/mm/dd hh:mi:ss SSS
 * 获取日期格式字符串作为主键：yyyymmddhhmissSSS
 */
function formatTime(timestamps, format) {
	var date = new Date(timestamps);
	var finalstr = format;
	finalstr = finalstr.replace("yyyy", date.getFullYear()); //年
	finalstr = finalstr.replace("mm", formatNum(date.getMonth() + 1)); //月
	finalstr = finalstr.replace("dd", formatNum(date.getDate())); //天
	finalstr = finalstr.replace("hh", formatNum(date.getHours())); //时
	finalstr = finalstr.replace("mi", formatNum(date.getMinutes())); //分
	finalstr = finalstr.replace("ss", formatNum(date.getSeconds())); //秒
	// finalstr = finalstr.replace("SSS", formatMilliseconds(date.getMilliseconds())); //毫秒
	return finalstr;
}
function formatDaterange(beginDateStr, endDateStr, val) {
	var date = new Date(val * 1000);
	var finalstr = "yyyy-mm-dd hh:mi:ss";
	finalstr = finalstr.replace("yyyy", date.getFullYear()); //年
	finalstr = finalstr.replace("mm", formatNum(date.getMonth() + 1)); //月
	finalstr = finalstr.replace("dd", formatNum(date.getDate())); //天
	finalstr = finalstr.replace("hh", formatNum(date.getHours())); //时
	finalstr = finalstr.replace("mi", formatNum(date.getMinutes())); //分
	finalstr = finalstr.replace("ss", formatNum(date.getSeconds())); //秒
	var curDate = new Date(finalstr);
	if (curDate >= beginDateStr && curDate <= endDateStr) {
		return true;
	} else {
		return false;
	}
}

//月，天，时，分，秒不足补位,
// 返回的值是一个两位的数字。不过返回值不总是两位的，如果该值小于 10，则仅返回一位数字
//如00点，只会返回一个数字0；6:00正的分钟数返回的是一个0
function formatNum(arg0) {
	let str = arg0.toString();
	if (str.length == 1) {
		return "0" + str;
	} else {
		return str;
	}
}

//毫秒补位
function formatMilliseconds(arg) {
	var str = arg.toString();
	if (str.length == 1) {
		return "00" + str;
	} else if (str.length == 2) {
		return "0" + str;
	} else if (str.length == 3) {
		return str;
	}
}

/**
 * [isDuringDate 比较当前时间是否在指定时间段内]
 * @author dongsir
 * @DateTime 2019-08-21
 * @version  1.0
 * @param    date   [beginDateStr] [开始时间]
 * @param    date   [endDateStr]   [结束时间]
 * @return   Boolean
 */
function isDuringDate(beginDateStr, endDateStr) {
	var curDate = new Date(),
		beginDate = new Date(beginDateStr),
		endDate = new Date(endDateStr);
	if (curDate >= beginDate && curDate <= endDate) {
		return true;
	}
	return false;
}

/**
 * 判断是否是json字符串 是返回true 不是返回false
 */

function isJsonType(str) {
	if (typeof str == "string") {
		try {
			var obj = JSON.parse(str);
			// 等于这个条件说明就是JSON字符串 会返回true
			if (typeof obj == "object" && obj) {
				return true;
			} else {
				//不是就返回false
				return false;
			}
		} catch (e) {
			return false;
		}
	}
	return false;
}
