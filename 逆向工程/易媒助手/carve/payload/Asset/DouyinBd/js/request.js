function Ajax(url, data, callback, method) {
  $.ajax({
    beforeSend: function (xhr) {
      my_xhr = xhr
      xhr.setRequestHeader("loginToken", initialization.queryInfo.logintoken)
    },
    url: url,
    method: method,
    data: data,
    asycn: true,
    dataType: "text",
    crossDomain: true,
    error: function (data) {
      let result = data.responseText ? getBaseString(data.responseText) : "abort"
      callback(result)
    },
    success: function (success) {
      let result = success ? getBaseString(success) : "200"
      callback(result, data)
    }
  })
}

let baseUrl = function (url) {
  return "https://interface.17van.com" + url
}

let request = {
  // 数据大盘
  getDataMarket: function (data, callback) {
    Ajax(baseUrl("/pcrank/hot_rank"), data, callback, "POST")
  },
  // 实时热点
  getDataHot: function (data, callback) {
    Ajax(baseUrl("/pcrank/hotSentences"), data, callback, "POST")
  },
  // 热点详情
  getHotDetails: function (data, callback) {
    Ajax(baseUrl("/pcrank/sentenceDetails"), data, callback, "POST")
  },
  // 热门话题
  getDataTopic: function (data, callback) {
    Ajax(baseUrl("/pcrank/topic"), data, callback, "POST")
  },
  // 热门视频
  getDataVideo: function (data, callback) {
    Ajax(baseUrl("/pcrank/hotVideo"), data, callback, "POST")
  },
  // 热门直播
  getDataLive: function (data, callback) {
    Ajax(baseUrl("/pcrank/liveRank"), data, callback, "POST")
  },
  // 热门音乐
  getDataMusic: function (data, callback) {
    Ajax(baseUrl("/pcrank/musicRank"), data, callback, "POST")
  },
  // 星图达人
  getDataStart: function (data, callback) {
    Ajax(baseUrl("/pcrank/startRank"), data, callback, "POST")
  },
  // 行业达人
  getDataSage: function (data, callback) {
    Ajax(baseUrl("/pcrank/sageRank"), data, callback, "POST")
  },
  // 数据投递
  getActionCollect: function (data, callback) {
    Ajax("https://action.17van.com/action/collection", data, callback, "POST")
  }
}

var my_xhr = {}
function closeAjax() {
  my_xhr.abort()
}
