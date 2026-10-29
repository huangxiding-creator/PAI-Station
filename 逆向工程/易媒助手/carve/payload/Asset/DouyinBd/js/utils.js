function Encode64(str) {
  return btoa(
    encodeURIComponent(str).replace(/%([0-9A-F]{2})/g, function toSolidBytes(match, p1) {
      return String.fromCharCode("0x", p1)
    })
  )
}

function Decode64(str) {
  return decodeURIComponent(
    atob(str)
      .split("")
      .map(function (c) {
        return "%" + ("00" + c.charCodeAt(0).toString(16)).slice(-2)
      })
      .join("")
  )
}

function getBaseString(response) {
  let str = Decode64(response)
  let indexs = str.lastIndexOf("|")
  let result = JSON.parse(str.substring(0, indexs))
  return result
}

/**
 * 判断是否是json字符串 是返回true 不是返回false
 */

function isJsonType(str) {
  if (typeof str == "string") {
    try {
      var obj = JSON.parse(str)
      // 等于这个条件说明就是JSON字符串 会返回true
      if (typeof obj == "object" && obj) {
        return true
      } else {
        // 不是就返回false
        return false
      }
    } catch (e) {
      return false
    }
  }
  return false
}

function getYestDayOrNextDay(day) {
  const today = new Date()
  today.setDate(today.getDate() + day) // 获取day后的日期
  var y = today.getFullYear()
  var m = formatNum(today.getMonth() + 1) // 获取当前月份的日期
  var d = formatNum(today.getDate())
  return y + "-" + m + "-" + d
}

function getDayOrNextDay(day, v) {
  const today = new Date(v)
  today.setDate(today.getDate() + day) // 获取day后的日期
  var y = today.getFullYear()
  var m = formatNum(today.getMonth() + 1) // 获取当前月份的日期
  var d = formatNum(today.getDate())
  return y + "-" + m + "-" + d
}

function formatNum(arg0) {
  let str = arg0.toString()
  if (str.length == 1) {
    return "0" + str
  } else {
    return str
  }
}

function getCurrentDate() {
  const date = new Date()
  const year = date.getFullYear()
  const month = formatNum(date.getMonth() + 1)
  const day = formatNum(date.getDate())

  return `${year}-${month}-${day}`
}

function formatDateTime(date) {
  const year = date.getFullYear()
  const month = date.getMonth() + 1
  const day = date.getDate()
  const hour = date.getHours()
  const minute = date.getMinutes()
  const second = date.getSeconds()
  return `${year}-${formatNum(month)}-${formatNum(day)} ${formatNum(hour)}:${formatNum(
    minute
  )}:${formatNum(second)}`
}

function getLastDay(i) {
  const now = new Date()
  const year = now.getFullYear()
  const month = now.getMonth() + 1
  const dateObj = []
  const endTimeMonthDay = new Date(year, parseInt(month) - i, 0).getDate()
  for (let x = 0; x < endTimeMonthDay; x++) {
    let date = new Date()
    let r = date.setDate(date.getDate() + -x)
    let y = new Date(r).getFullYear()
    let m = new Date(r).getMonth() + 1
    let d = new Date(r).getDate()
    dateObj.push({
      id: x,
      value: `${y}-${formatNum(m)}-${formatNum(d)}`
    })
  }
  return dateObj
}

function transNumberToShort(value, decimal = 1) {
  const BASE = 10000
  const SIZES = ["", "w", "亿", "万亿"]
  let i = undefined
  let str = ""
  if (isNaN(value)) {
    throw new Error("The input parameter is not a number.")
  }
  if (typeof decimal !== "number" || decimal < 0) {
    throw new Error("The 'decimal' parameter should be a non-negative number.")
  }
  if (value < BASE) {
    str = value
  } else {
    i = Math.floor(Math.log(value) / Math.log(BASE))
    str = `${(value / Math.pow(BASE, i)).toFixed(decimal)}${SIZES[i]}`
  }
  return str
}

/**获取周 */
function getBeforeWeeksTime(num) {
  /**获取到当前的年月日 */
  var now = new Date()
  var year = now.getFullYear() //年
  var month = now.getMonth() + 1 //月
  var day = now.getDate() //日
  let currentYear = year.toString()
  let currentMonth = ""
  if (month < 10) currentMonth += "0"
  currentMonth += month
  let currentDay = ""
  if (day < 10) currentDay += "0"
  currentDay += day

  var nowDate = new Date(year, parseInt(month) - 1, day) //获取到今天的时间
  var startDate = new Date(year, 0, 1) //获取到今年第一月第一天
  let d = Math.round((nowDate.valueOf() - startDate.valueOf()) / 86400000) // d是当前日期是今年第多少天
  //用d + 当前年的第一天的周差距的和在除以7就是本年第几周
  let currentWeek = year + "-" + (Math.ceil((d + (startDate.getDay() + 1 - 1)) / 7) + 1 - num) //获取到最近num周是第几周

  let weekNo = currentWeek.split("-")[1] //获取想要计算的周是一年的第多少周
  let oneday = new Date(year + "-01-01").getDay() // 此年1号是星期几

  // 方便计算，当为星期天时为7
  if (oneday == 0) {
    oneday = 7
  }
  let one_fistday
  let one_lastday
  // 如果1号刚好是星期一
  if (oneday == 1) {
    one_fistday = year + "-01-01"
    one_lastday = year + "-01-07"
  } else {
    let jj = 8 - oneday
    one_fistday =
      year - 1 + "-12-" + (31 - oneday + 2 > 9 ? 31 - oneday + 2 : "0" + (31 - oneday + 2))
    one_lastday = year + "-01-" + (jj > 9 ? jj : "0" + jj)
  }

  let fistday
  let lastday
  // 如果刚好是第一周
  if (weekNo == 1) {
    fistday = one_fistday
    lastday = one_lastday
  } else {
    fistday = this.addDate(one_lastday, (weekNo - 2) * 7 + 1)
    lastday = this.addDate(one_lastday, (weekNo - 1) * 7)
  }
  let obj = {
    beforeMonday: fistday,
    beforeSunday: lastday
  }
  return obj
  /**
   * fistday 为前第几周的周一 格式(xxxx-xx-xx)
   * lastday 为前第几周的周日 格式(xxxx-xx-xx)
   */
}

function addDate(date, days) {
  var d = new Date(date)
  d.setDate(d.getDate() + days)
  var m = d.getMonth() + 1

  return (
    d.getFullYear() +
    "-" +
    (m > 9 ? m : "0" + m) +
    "-" +
    (d.getDate() > 9 ? d.getDate() : "0" + d.getDate())
  )
}

// 获取近i月的时间段
function getLastMonth(i) {
  console.log("获取近i月的时间段", i)
  var now = new Date()
  var year = now.getFullYear()
  var month = now.getMonth() + 1
  var day = now.getDate()
  var dateObj = {}
  dateObj.endTime = year + "-" + month + "-" + day
  var nowMonthDay = new Date(year, month, 0).getDate() //当前月的总天数
  if (i == 12) {
    //如果是12月，年数往前推一年<br>
    dateObj.startTime = year - 1 + "-" + month + "-" + day
  } else if (month - i <= 0) {
    // 如果前推i月小于0，年数往前推一年<br>
    dateObj.startTime = year - 1 + "-" + 12 + "-" + day
  } else {
    var endTimeMonthDay = new Date(year, parseInt(month) - i, 0).getDate()
    if (endTimeMonthDay < day) {
      // i个月前所在月的总天数小于现在的天日期
      if (day < nowMonthDay) {
        // 当前天日期小于当前月总天数
        dateObj.startTime = year + "-" + (month - i) + "-" + (endTimeMonthDay - (nowMonthDay - day))
      } else {
        dateObj.startTime = year + "-" + (month - i) + "-" + endTimeMonthDay
      }
    } else {
      dateObj.startTime = year + "-" + (month - i) + "-" + day
    }
  }
  return dateObj
}

function getRecentMonth(n) {
  let nowDate = new Date()
  let array = []
  let year = nowDate.getFullYear()
  let mon = nowDate.getMonth() + 1
  for (let i = 0; i < n; i++) {
    mon = mon - 1
    if (mon <= 0) {
      year = year - 1
      mon = mon + 12
    }
    if (mon < 10) {
      mon = "0" + mon
    }
    array[i] = year + "-" + mon
  }
  return array
}

function getMonthFristLast(timestamp) {
  let year = new Date(timestamp).getFullYear()
  let month = new Date(timestamp).getMonth() + 1
  let lastDate = new Date(year, month, 0).getDate()
  let dayObj = {
    startingDay: `${year}-${formatNum(month)}-01`,
    endDay: `${year}-${formatNum(month)}-${formatNum(lastDate)}`
  }
  return dayObj
}

let listMenu = [
  {
    id: "1",
    type: "data",
    name: "数据大盘",
    title: "最新抖音热榜数据",
    placeholder: "",
    active: true,
    icon: "./assets/icon/statistics-1.svg",
    action: "data_market"
  },
  {
    id: "2",
    type: "hot",
    name: "实时热点榜",
    title: "实时热点榜",
    placeholder: "实时更新全网热点榜单，给你提供当下最热门的视频素材。",
    active: false,
    icon: "./assets/icon/hotspot-1.svg",
    action: "sentence"
  },
  {
    id: "3",
    type: "topic",
    name: "热门话题榜",
    title: "热门话题榜",
    placeholder: "每日更新全网话题的视频和互动增量，紧跟潮流创作，享受流量红利。",
    active: false,
    icon: "./assets/icon/subject-1.svg",
    action: "topc"
  },
  {
    id: "4",
    type: "video",
    name: "热门视频榜",
    title: "热门视频榜",
    placeholder: "统计周期内发布的互动效果最好的短视频，实时掌握行业最新内容动态。",
    active: false,
    icon: "./assets/icon/video-1.svg",
    action: "hot_video"
  },
  {
    id: "5",
    type: "live",
    name: "热门直播榜",
    title: "热门直播榜",
    placeholder: "统计周期内发布的互动效果最好的短视频，实时掌握行业最新内容动态。",
    active: false,
    icon: "./assets/icon/liveBroadcast-1.svg",
    action: "hot_live"
  },
  {
    id: "6",
    type: "sage",
    name: "热门达人榜",
    title: "热门达人榜",
    placeholder: "根据达人的影响力指数数据排序，展示不同行业下内容传播效果最好的达人。",
    active: false,
    icon: "./assets/icon/famous-1.svg",
    action: "hot_sage"
  },
  {
    id: "7",
    type: "music",
    name: "热门音乐榜",
    title: "热门音乐榜",
    placeholder: "根据短视频BGM的使用量数据排序，展示不同行业下内容传播效果最好的达人。",
    active: false,
    icon: "./assets/icon/music-1.svg",
    action: "hot_music"
  }
]

let dataList = [
  {
    id: "1",
    type: "hot",
    list: [],
    title: "实时热点榜",
    time: "2023-01-01 00:00:00",
    label: "热点变化趋势",
    itemTitle: "sentence",
    itemAvatar: "",
    itemOption1: "hot_level",
    itemTime: "active_time"
  },
  {
    id: "2",
    type: "topic",
    list: [],
    title: "热门话题榜",
    time: "2023-01-01 00:00:00",
    label: "影响力指数",
    itemTitle: "title",
    itemAvatar: "",
    itemOption1: "effect_value",
    itemTime: "create_time"
  },
  {
    id: "3",
    type: "video",
    list: [],
    title: "热门视频榜",
    time: "2023-01-01 00:00:00",
    label: "点赞数",
    itemTitle: "title",
    itemAvatar: "item_cover",
    itemOption1: "digg_count",
    itemTime: "create_time"
  },
  {
    id: "4",
    type: "live",
    list: [],
    title: "热门直播榜",
    time: "2023-01-01 00:00:00",
    label: "直播标题",
    itemTitle: "nickname",
    itemAvatar: "cover",
    itemOption1: "title",
    itemTime: "create_time"
  },
  {
    id: "5",
    type: "sage",
    list: [],
    title: "热门达人榜",
    time: "2023-01-01 00:00:00",
    label: "粉丝量",
    itemTitle: "nickname",
    itemAvatar: "avatar",
    itemOption1: "follower_count",
    itemTime: "create_time"
  },
  {
    id: "6",
    type: "music",
    list: [],
    title: "热门音乐榜",
    time: "2023-08-18 00:00:00",
    label: "使用量",
    itemTitle: "title",
    itemAvatar: "cover",
    itemOption1: "use_count",
    itemTime: "create_time"
  }
]

let hourList = [
  {
    id: 1,
    label: "02:00",
    value: ["00:00:00", "02:00:00"],
    active: false
  },
  {
    id: 2,
    label: "04:00",
    value: ["02:00:00", "04:00:00"],
    active: false
  },
  {
    id: 3,
    label: "06:00",
    value: ["04:00:00", "06:00:00"],
    active: false
  },
  {
    id: 4,
    label: "08:00",
    value: ["06:00:00", "08:00:00"],
    active: false
  },
  {
    id: 5,
    label: "10:00",
    value: ["08:00:00", "10:00:00"],
    active: false
  },
  {
    id: 6,
    label: "12:00",
    value: ["10:00:00", "12:00:00"],
    active: false
  },
  {
    id: 7,
    label: "14:00",
    value: ["12:00:00", "14:00:00"],
    active: false
  },
  {
    id: 8,
    label: "16:00",
    value: ["14:00:00", "16:00:00"],
    active: false
  },
  {
    id: 9,
    label: "18:00",
    value: ["16:00:00", "18:00:00"],
    active: false
  },
  {
    id: 10,
    label: "20:00",
    value: ["18:00:00", "20:00:00"],
    active: false
  },
  {
    id: 11,
    label: "22:00",
    value: ["20:00:00", "22:00:00"],
    active: false
  },
  {
    id: 12,
    label: "24:00",
    value: ["22:00:00", "00:00:00"],
    active: false
  }
]

let compareList = [
  {
    time: getCurrentDate() + " 00:01:00",
    value: [getYestDayOrNextDay(-1) + " 20:00:00", getYestDayOrNextDay(-1) + " 22:00:00"]
  },
  {
    time: getCurrentDate() + " 02:01:00",
    value: [getYestDayOrNextDay(-1) + " 22:00:00", getYestDayOrNextDay(0) + " 00:00:00"]
  },
  {
    time: getCurrentDate() + " 04:01:00",
    value: [getCurrentDate() + " 00:00:00", getCurrentDate() + " 02:00:00"]
  },
  {
    time: getCurrentDate() + " 06:01:00",
    value: [getCurrentDate() + " 02:00:00", getCurrentDate() + " 04:00:00"]
  },
  {
    time: getCurrentDate() + " 08:01:00",
    value: [getCurrentDate() + " 04:00:00", getCurrentDate() + " 06:00:00"]
  },
  {
    time: getCurrentDate() + " 10:01:00",
    value: [getCurrentDate() + " 06:00:00", getCurrentDate() + " 08:00:00"]
  },
  {
    time: getCurrentDate() + " 12:01:00",
    value: [getCurrentDate() + " 08:00:00", getCurrentDate() + " 10:00:00"]
  },
  {
    time: getCurrentDate() + " 14:01:00",
    value: [getCurrentDate() + " 10:00:00", getCurrentDate() + " 12:00:00"]
  },
  {
    time: getCurrentDate() + " 16:01:00",
    value: [getCurrentDate() + " 12:00:00", getCurrentDate() + " 14:00:00"]
  },
  {
    time: getCurrentDate() + " 18:01:00",
    value: [getCurrentDate() + " 14:00:00", getCurrentDate() + " 16:00:00"]
  },
  {
    time: getCurrentDate() + " 20:01:00",
    value: [getCurrentDate() + " 16:00:00", getCurrentDate() + " 18:00:00"]
  },
  {
    time: getCurrentDate() + " 22:01:00",
    value: [getCurrentDate() + " 18:00:00", getCurrentDate() + " 20:00:00"]
  }
]

let starIndex = [
  {
    id: "1",
    label: "星图指数",
    value: "star_map",
    active: false
  },
  {
    id: "2",
    label: "涨粉指数",
    value: "rising_map",
    active: false
  },
  {
    id: "3",
    label: "性价比指数",
    value: "performance_map",
    active: false
  },
  {
    id: "4",
    label: "种草指数",
    value: "grass_map",
    active: false
  },
  {
    id: "5",
    label: "精选指数",
    value: "selection_map",
    active: false
  },
  {
    id: "6",
    label: "传播指数",
    value: "spread_map",
    active: false
  }
]
