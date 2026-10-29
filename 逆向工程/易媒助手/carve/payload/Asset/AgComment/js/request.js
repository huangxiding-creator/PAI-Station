function post(url, type, data, callback, asycnType, accontId) {
  $.ajax({
    beforeSend: function (request) {
      request.setRequestHeader("loginToken", initialization.query_Info.logintoken)
    },
    type: "POST",
    url: url,
    data: data,
    asycn: asycnType,
    dataType: type,
    crossDomain: true,
    error: function (data) {
      let result = getBaseString(data.responseText)
      callback(result)
    },
    success: function (success) {
      let result = getBaseString(success)
      if (result.code == 10010) {
        errorCode10010(accontId)
      }
      callback(result, data)
    }
  })
}

let baseUrl = function (url) {
  return "https://interface.17van.com" + url
}

let api = {
  strategyForm: {
    // 新增自动回复策略规则
    addStrategyRules: function (data, accontId, callback) {
      post(baseUrl("/pcdouyin/addRules"), "text", data, callback, false, accontId)
    },
    // 修改自动回复策略规则
    editStrategyRules: function (data, accontId, callback) {
      post(baseUrl("/pcdouyin/updateRules"), "text", data, callback, false, accontId)
    }
  },
  commentsPage: {
    // 获取当前账号下的视频列表
    getAuthVideoList: function (data, accontId, callback) {
      post(baseUrl("/pc/selectAuthVideo"), "text", data, callback, false, accontId)
    },
    // 获取所有评论列表
    getCommentList: function (data, accontId, callback) {
      post(baseUrl("/pc/selectCommentlist"), "text", data, callback, false, accontId)
    },
    // 获取回复评论列表
    getReplyCmtlist: function (data, accontId, callback) {
      post(baseUrl("/pc/selectCommentReplylist"), "text", data, callback, false, accontId)
    },
    // 设置回复评论
    setReplyComment: function (data, accontId, callback) {
      post(baseUrl("/pc/replyComment"), "text", data, callback, true, accontId)
    },
    // 获取话术列表
    getReplyScript: function (data, accontId, callback) {
      post(baseUrl("/pcdouyin/getScript"), "text", data, callback, false, accontId)
    },
    // 新增话术
    saveReplyScript: function (data, accontId, callback) {
      post(baseUrl("/pcdouyin/addScript"), "text", data, callback, false, accontId)
    },
    // 修改话术
    editReplyScript: function (data, accontId, callback) {
      post(baseUrl("/pcdouyin/updateScript"), "text", data, callback, false, accontId)
    },
    // 删除话术
    delReplyScript: function (data, accontId, callback) {
      post(baseUrl("/pcdouyin/delScript"), "text", data, callback, false, accontId)
    },
    // 获取剩余回复条数
    getCommentLimit: function (data, accontId, callback) {
      post(baseUrl("/pc/getCommentLimit"), "text", data, callback, false, accontId)
    }
  }
}

var errorCode10010 = function (id) {
  window.JsAuthAccountInvalidate(id)
}
