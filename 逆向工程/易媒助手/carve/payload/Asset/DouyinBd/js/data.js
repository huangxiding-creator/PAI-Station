var initialization = {
  queryInfo: {
    logintoken: "",
    uid: "",
    channel: "",
    did: "",
    usertype: "",
    isteam: "",
    issubuser: "",
    version: "",
    osversion: ""
  }
}

var interface = {
  // 获取登录信息
  getQueryString: function () {
    let url = window.location.href
    let urlStr = url.split("?")[1]
    let urlSearchParams = new URLSearchParams(urlStr)
    let authToken = Object.fromEntries(urlSearchParams.entries())
    initialization.queryInfo = {
      logintoken: authToken.logintoken,
      uid: authToken.uid,
      channel: authToken.channel,
      did: authToken.did,
      usertype: authToken.usertype,
      isteam: authToken.isteam,
      issubuser: authToken.issubuser,
      version: authToken.version,
      osversion: authToken.osversion
    }
    return initialization.queryInfo
  },
  // 设置登录信息
  setAccountInfo: function (logintoken, uid, channel, did, usertype, isteam, issubuser) {
    initialization.queryInfo.logintoken = logintoken
    initialization.queryInfo.uid = uid
    initialization.queryInfo.channel = channel
    initialization.queryInfo.did = did
    initialization.queryInfo.usertype = usertype
    initialization.queryInfo.isteam = isteam
    initialization.queryInfo.issubuser = issubuser
    window.setLoginInfo(initialization.queryInfo)
    return initialization.queryInfo
  },
  // 升级VIP
  setUpgradeVip: function () {
    window.JsBuyVip()
  },
  // 打开外部链接
  setOpenUrl: function (v) {
    window.JsBuyVipPageOpenUrl(v)
  }
}
