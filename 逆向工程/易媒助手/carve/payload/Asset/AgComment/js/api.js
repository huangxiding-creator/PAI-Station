const initialization = {
  query_Info: {
    videoMax: 0,
    commentMax: 0,
    logintoken: "" // lzy1eGIIBfmclY4LbnxwJPYPczHuNN5oW8OcVp7Kr/U= //goEanQ7CT9S2RtRPrdodrFX4Xs/YVTYs99wZ3XRy0= xvRocKwz0upIEOitwG5iLTJgYlU4BECu5wKbLFiNdu4=
  },
  account_info: "",
  strategy_info: {
    strategyType: "1",
    strategyForm: ""
  },
  relpy_account: ""
}

var interface = {
  // 获取登录信息
  getQueryString: function (logintoken, uid, channel, did, videoMax, commentMax) {
    let url = window.location.href
    let urlStr = url.split("?")[1]
    let urlSearchParams = new URLSearchParams(urlStr)
    let authToken = Object.fromEntries(urlSearchParams.entries())
    initialization.query_Info = {
      logintoken: logintoken || authToken.logintoken,
      uid: uid || authToken.uid,
      channel: channel || authToken.channel,
      did: did || authToken.did,
      videoMax: videoMax || authToken.videocountlimit,
      commentMax: commentMax || authToken.commentcountlimit
    }
    return initialization.query_Info
  },
  // 获取当前账号信息
  getEmpowerAccountInfo: function (id, name, avatar, authtime) {
    initialization.account_info = {
      id,
      name,
      avatar,
      authtime
    }
    setEmpowerAccountInfo(initialization.account_info)
    return initialization.account_info
  },
  // 设置策略规则类型和数据
  setStrategyForm: function (type, form) {
    form = form.replace("\n", "\\n")
    form = form.replace("\r", "\\r")
    form = form.replace("\t", "\\t")
    initialization.strategy_info = {
      strategyType: type,
      strategyForm: JSON.parse(form)
    }
    setStrategyInfo(initialization.strategy_info)
    return initialization.strategy_info
  },

  /**
   * 判断是否是json字符串 是返回true 不是返回false
   */

  isJsonType: function (str) {
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
  },

  // 设置回复策略的账号
  setRelpyAccountInfo: function (id, name, avatar) {
    initialization.relpy_account = {
      id,
      name,
      avatar
    }
    setRelpyAccount(initialization.relpy_account)
    return initialization.relpy_account
  },
  // 设置回复策略的作品
  setRelpyVideo: function (data) {
    initialization.relpy_video = JSON.parse(data)
    setRelpyWorks(initialization.relpy_video)
    return initialization.relpy_video
  },
  // 选择授权账号
  selectEmpowerAccount: function (srcPage, accountInfo) {
    window.JsShowSelectAuthAccountWnd(srcPage, accountInfo)
  },
  // 选择作品列表
  selectAccountVideo: function (srcPage, accontId, contentList) {
    window.JsShowSelectContentWnd(srcPage, accontId, contentList)
  },
  // 取消新建/修改策略
  cancelStrategy: function (type) {
    window.JsCancelNewPolicy(type)
  },
  // 添加/修改策略成功回掉
  submitStrategy: function (type, form) {
    window.JsNewPolicySuc(type, form)
  },
  // 回复评论剩余条数
  replyCommentNumbr: function (n) {
    window.JsReplyCommentTimes(n)
  }
  // // 报错code10010
  // errorCode10010: function () {
  //   window.JsAuthAccountInvalidate(initialization.account_info.id)
  // }
}

const face_list = [
  {
    id: 0,
    icon: "./assets/img/douyinface/0.png",
    code: "[微笑]",
    text: "[微笑]"
  },
  {
    id: 1,
    icon: "./assets/img/douyinface/1.png",
    code: "[色]",
    text: "[色]"
  },
  {
    id: 2,
    icon: "./assets/img/douyinface/2.png",
    code: "[爱慕]",
    text: "[爱慕]"
  },
  {
    id: 3,
    icon: "./assets/img/douyinface/3.png",
    code: "[捂脸]",
    text: "[捂脸]"
  },
  {
    id: 4,
    icon: "./assets/img/douyinface/4.png",
    code: "[呲牙]",
    text: "[呲牙]"
  },
  {
    id: 5,
    icon: "./assets/img/douyinface/5.png",
    code: "[大笑]",
    text: "[大笑]"
  },
  {
    id: 6,
    icon: "./assets/img/douyinface/6.png",
    code: "[发怒]",
    text: "[发怒]"
  },
  {
    id: 7,
    icon: "./assets/img/douyinface/7.png",
    code: "[灵机一动]",
    text: "[灵机一动]"
  },
  {
    id: 8,
    icon: "./assets/img/douyinface/8.png",
    code: "[灵光一闪]",
    text: "[灵光一闪]"
  },
  {
    id: 9,
    icon: "./assets/img/douyinface/9.png",
    code: "[抠鼻]",
    text: "[抠鼻]"
  },
  {
    id: 10,
    icon: "./assets/img/douyinface/10.png",
    code: "[害羞]",
    text: "[害羞]"
  },
  {
    id: 11,
    icon: "./assets/img/douyinface/11.png",
    code: "[调皮]",
    text: "[调皮]"
  },
  {
    id: 12,
    icon: "./assets/img/douyinface/12.png",
    code: "[可爱]",
    text: "[可爱]"
  },
  {
    id: 13,
    icon: "./assets/img/douyinface/13.png",
    code: "[吃瓜群众]",
    text: "[吃瓜群众]"
  },
  {
    id: 14,
    icon: "./assets/img/douyinface/14.png",
    code: "[晕]",
    text: "[晕]"
  },
  {
    id: 15,
    icon: "./assets/img/douyinface/15.png",
    code: "[闭嘴]",
    text: "[闭嘴]"
  },
  {
    id: 16,
    icon: "./assets/img/douyinface/16.png",
    code: "[笑哭]",
    text: "[笑哭]"
  },
  {
    id: 17,
    icon: "./assets/img/douyinface/17.png",
    code: "[难过]",
    text: "[难过]"
  },
  {
    id: 18,
    icon: "./assets/img/douyinface/18.png",
    code: "[亲亲]",
    text: "[亲亲]"
  },
  {
    id: 19,
    icon: "./assets/img/douyinface/19.png",
    code: "[来看我]",
    text: "[来看我]"
  },
  {
    id: 20,
    icon: "./assets/img/douyinface/20.png",
    code: "[偷笑]",
    text: "[偷笑]"
  },
  {
    id: 21,
    icon: "./assets/img/douyinface/21.png",
    code: "[打脸]",
    text: "[打脸]"
  },
  {
    id: 22,
    icon: "./assets/img/douyinface/22.png",
    code: "[翻白眼]",
    text: "[翻白眼]"
  },
  {
    id: 23,
    icon: "./assets/img/douyinface/23.png",
    code: "[睡]",
    text: "[睡]"
  },
  {
    id: 24,
    icon: "./assets/img/douyinface/24.png",
    code: "[睡]",
    text: "[睡]"
  },
  {
    id: 25,
    icon: "./assets/img/douyinface/25.png",
    code: "[奸笑]",
    text: "[奸笑]"
  },
  {
    id: 26,
    icon: "./assets/img/douyinface/26.png",
    code: "[送心]",
    text: "[送心]"
  },
  {
    id: 27,
    icon: "./assets/img/douyinface/27.png",
    code: "[大哭]",
    text: "[大哭]"
  },
  {
    id: 28,
    icon: "./assets/img/douyinface/28.png",
    code: "[抓狂]",
    text: "[抓狂]"
  },
  {
    id: 29,
    icon: "./assets/img/douyinface/29.png",
    code: "[惊讶]",
    text: "[惊讶]"
  },
  {
    id: 30,
    icon: "./assets/img/douyinface/30.png",
    code: "[酷拽]",
    text: "[酷拽]"
  },
  {
    id: 31,
    icon: "./assets/img/douyinface/31.png",
    code: "[泣不成声]",
    text: "[泣不成声]"
  },
  {
    id: 32,
    icon: "./assets/img/douyinface/32.png",
    code: "[大金牙]",
    text: "[大金牙]"
  },
  {
    id: 33,
    icon: "./assets/img/douyinface/33.png",
    code: "[疑问]",
    text: "[疑问]"
  },
  {
    id: 34,
    icon: "./assets/img/douyinface/34.png",
    code: "[小鼓掌]",
    text: "[小鼓掌]"
  },
  {
    id: 35,
    icon: "./assets/img/douyinface/35.png",
    code: "[吐]",
    text: "[吐]"
  },
  {
    id: 36,
    icon: "./assets/img/douyinface/36.png",
    code: "[拥抱]",
    text: "[拥抱]"
  },
  {
    id: 37,
    icon: "./assets/img/douyinface/37.png",
    code: "[惊恐]",
    text: "[惊恐]"
  },
  {
    id: 38,
    icon: "./assets/img/douyinface/38.png",
    code: "[耶]",
    text: "[耶]"
  },
  {
    id: 39,
    icon: "./assets/img/douyinface/39.png",
    code: "[醉了]",
    text: "[醉了]"
  },
  {
    id: 40,
    icon: "./assets/img/douyinface/40.png",
    code: "[看]",
    text: "[看]"
  },
  {
    id: 41,
    icon: "./assets/img/douyinface/41.png",
    code: "[二哈]",
    text: "[二哈]"
  },
  {
    id: 42,
    icon: "./assets/img/douyinface/42.png",
    code: "[微笑袋鼠]",
    text: "[微笑袋鼠]"
  },
  {
    id: 43,
    icon: "./assets/img/douyinface/43.png",
    code: "[冷漠]",
    text: "[冷漠]"
  },
  {
    id: 44,
    icon: "./assets/img/douyinface/44.png",
    code: "[暗中观察]",
    text: "[暗中观察]"
  },
  {
    id: 45,
    icon: "./assets/img/douyinface/45.png",
    code: "[凝视]",
    text: "[凝视]"
  },
  {
    id: 46,
    icon: "./assets/img/douyinface/46.png",
    code: "[握爪]",
    text: "[握爪]"
  },
  {
    id: 47,
    icon: "./assets/img/douyinface/47.png",
    code: "[锦鲤]",
    text: "[锦鲤]"
  },
  {
    id: 48,
    icon: "./assets/img/douyinface/48.png",
    code: "[蜡烛]",
    text: "[蜡烛]"
  },
  {
    id: 49,
    icon: "./assets/img/douyinface/49.png",
    code: "[加一]",
    text: "[加一]"
  },
  {
    id: 50,
    icon: "./assets/img/douyinface/50.png",
    code: "[我酸了]",
    text: "[我酸了]"
  },
  {
    id: 51,
    icon: "./assets/img/douyinface/51.png",
    code: "[加鸡腿]",
    text: "[加鸡腿]"
  },
  {
    id: 52,
    icon: "./assets/img/douyinface/52.png",
    code: "[我太南了]",
    text: "[我太南了]"
  },
  {
    id: 53,
    icon: "./assets/img/douyinface/53.png",
    code: "[扎心]",
    text: "[扎心]"
  },
  {
    id: 54,
    icon: "./assets/img/douyinface/54.png",
    code: "[给跪了]",
    text: "[给跪了]"
  },
  {
    id: 55,
    icon: "./assets/img/douyinface/55.png",
    code: "[赞]",
    text: "[赞]"
  },
  {
    id: 56,
    icon: "./assets/img/douyinface/56.png",
    code: "[鼓掌]",
    text: "[鼓掌]"
  },
  {
    id: 57,
    icon: "./assets/img/douyinface/57.png",
    code: "[比心]",
    text: "[比心]"
  },
  {
    id: 58,
    icon: "./assets/img/douyinface/58.png",
    code: "[感谢]",
    text: "[感谢]"
  },
  {
    id: 59,
    icon: "./assets/img/douyinface/59.png",
    code: "[祈祷]",
    text: "[祈祷]"
  },
  {
    id: 60,
    icon: "./assets/img/douyinface/60.png",
    code: "[胜利]",
    text: "[胜利]"
  },
  {
    id: 61,
    icon: "./assets/img/douyinface/61.png",
    code: "[强壮]",
    text: "[强壮]"
  },
  {
    id: 62,
    icon: "./assets/img/douyinface/62.png",
    code: "[加油]",
    text: "[加油]"
  },
  {
    id: 63,
    icon: "./assets/img/douyinface/63.png",
    code: "[OK]",
    text: "[OK]"
  },
  {
    id: 64,
    icon: "./assets/img/douyinface/64.png",
    code: "[ok]",
    text: "[ok]"
  },
  {
    id: 65,
    icon: "./assets/img/douyinface/65.png",
    code: "[弱]",
    text: "[弱]"
  },
  {
    id: 66,
    icon: "./assets/img/douyinface/66.png",
    code: "[抱拳]",
    text: "[抱拳]"
  },
  {
    id: 67,
    icon: "./assets/img/douyinface/67.png",
    code: "[勾引]",
    text: "[勾引]"
  },
  {
    id: 68,
    icon: "./assets/img/douyinface/68.png",
    code: "[再见]",
    text: "[再见]"
  },
  {
    id: 69,
    icon: "./assets/img/douyinface/69.png",
    code: "[握手]",
    text: "[握手]"
  },
  {
    id: 70,
    icon: "./assets/img/douyinface/70.png",
    code: "[玫瑰]",
    text: "[玫瑰]"
  },
  {
    id: 71,
    icon: "./assets/img/douyinface/71.png",
    code: "[666]",
    text: "[666]"
  },
  {
    id: 72,
    icon: "./assets/img/douyinface/72.png",
    code: "[爱心]",
    text: "[爱心]"
  },
  {
    id: 73,
    icon: "./assets/img/douyinface/73.png",
    code: "[心]",
    text: "[心]"
  },
  {
    id: 74,
    icon: "./assets/img/douyinface/74.png",
    code: "[胡瓜]",
    text: "[胡瓜]"
  },
  {
    id: 75,
    icon: "./assets/img/douyinface/75.png",
    code: "[嘴唇]",
    text: "[嘴唇]"
  },
  {
    id: 76,
    icon: "./assets/img/douyinface/76.png",
    code: "[kiss]",
    text: "[kiss]"
  },
  {
    id: 77,
    icon: "./assets/img/douyinface/77.png",
    code: "[给力]",
    text: "[给力]"
  },
  {
    id: 78,
    icon: "./assets/img/douyinface/78.png",
    code: "[啤酒]",
    text: "[啤酒]"
  },
  {
    id: 79,
    icon: "./assets/img/douyinface/79.png",
    code: "[派对]",
    text: "[派对]"
  },
  {
    id: 80,
    icon: "./assets/img/douyinface/80.png",
    code: "[撒花]",
    text: "[撒花]"
  },
  {
    id: 81,
    icon: "./assets/img/douyinface/81.png",
    code: "[蛋糕]",
    text: "[蛋糕]"
  },
  {
    id: 82,
    icon: "./assets/img/douyinface/82.png",
    code: "[红包]",
    text: "[红包]"
  },
  {
    id: 83,
    icon: "./assets/img/douyinface/83.png",
    code: "[礼物]",
    text: "[礼物]"
  },
  {
    id: 84,
    icon: "./assets/img/douyinface/84.png",
    code: "[发]",
    text: "[发]"
  },
  {
    id: 85,
    icon: "./assets/img/douyinface/85.png",
    code: "[咖啡]",
    text: "[咖啡]"
  },
  {
    id: 86,
    icon: "./assets/img/douyinface/86.png",
    code: "[太阳]",
    text: "[太阳]"
  },
  {
    id: 87,
    icon: "./assets/img/douyinface/87.png",
    code: "[月亮]",
    text: "[月亮]"
  },
  {
    id: 88,
    icon: "./assets/img/douyinface/88.png",
    code: "[心碎]",
    text: "[心碎]"
  },
  {
    id: 89,
    icon: "./assets/img/douyinface/89.png",
    code: "[伤心]",
    text: "[伤心]"
  },
  {
    id: 90,
    icon: "./assets/img/douyinface/90.png",
    code: "[便便]",
    text: "[便便]"
  },
  {
    id: 91,
    icon: "./assets/img/douyinface/91.png",
    code: "[福]",
    text: "[福]"
  },
  {
    id: 92,
    icon: "./assets/img/douyinface/92.png",
    code: "[一起加油]",
    text: "[一起加油]"
  },
  {
    id: 93,
    icon: "./assets/img/douyinface/93.png",
    code: "[戴口罩]",
    text: "[戴口罩]"
  },
  {
    id: 94,
    icon: "./assets/img/douyinface/94.png",
    code: "[勤洗手]",
    text: "[勤洗手]"
  },
  {
    id: 95,
    icon: "./assets/img/douyinface/95.png",
    code: "[不信谣言]",
    text: "[不信谣言]"
  },
  {
    id: 96,
    icon: "./assets/img/douyinface/96.png",
    code: "[情书]",
    text: "[情书]"
  },
  {
    id: 97,
    icon: "./assets/img/douyinface/97.png",
    code: "[iloveyou]",
    text: "[iloveyou]"
  },
  {
    id: 98,
    icon: "./assets/img/douyinface/98.png",
    code: "[巧克力]",
    text: "[巧克力]"
  },
  {
    id: 99,
    icon: "./assets/img/douyinface/99.png",
    code: "[戒指]",
    text: "[戒指]"
  },
  {
    id: 100,
    icon: "./assets/img/douyinface/100.png",
    code: "[流泪]",
    text: "[流泪]"
  },
  {
    id: 101,
    icon: "./assets/img/douyinface/101.png",
    code: "[愉快]",
    text: "[愉快]"
  },
  {
    id: 102,
    icon: "./assets/img/douyinface/102.png",
    code: "[笑]",
    text: "[笑]"
  },
  {
    id: 103,
    icon: "./assets/img/douyinface/103.png",
    code: "[发呆]",
    text: "[发呆]"
  },
  {
    id: 104,
    icon: "./assets/img/douyinface/104.png",
    code: "[惊呆]",
    text: "[惊呆]"
  },
  {
    id: 105,
    icon: "./assets/img/douyinface/105.png",
    code: "[机智]",
    text: "[机智]"
  },
  {
    id: 106,
    icon: "./assets/img/douyinface/106.png",
    code: "[快哭了]",
    text: "[快哭了]"
  },
  {
    id: 107,
    icon: "./assets/img/douyinface/107.png",
    code: "[击掌]",
    text: "[击掌]"
  },
  {
    id: 108,
    icon: "./assets/img/douyinface/108.png",
    code: "[黑脸]",
    text: "[黑脸]"
  },
  {
    id: 109,
    icon: "./assets/img/douyinface/109.png",
    code: "[飞吻]",
    text: "[飞吻]"
  },
  {
    id: 110,
    icon: "./assets/img/douyinface/110.png",
    code: "[碰拳]",
    text: "[碰拳]"
  },
  {
    id: 111,
    icon: "./assets/img/douyinface/111.png",
    code: "[舔屏]",
    text: "[舔屏]"
  },
  {
    id: 112,
    icon: "./assets/img/douyinface/112.png",
    code: "[憨笑]",
    text: "[憨笑]"
  },
  {
    id: 113,
    icon: "./assets/img/douyinface/113.png",
    code: "[我想静静]",
    text: "[我想静静]"
  },
  {
    id: 114,
    icon: "./assets/img/douyinface/114.png",
    code: "[思考]",
    text: "[思考]"
  },
  {
    id: 115,
    icon: "./assets/img/douyinface/115.png",
    code: "[呆无辜]",
    text: "[呆无辜]"
  },
  {
    id: 116,
    icon: "./assets/img/douyinface/116.png",
    code: "[尴尬]",
    text: "[尴尬]"
  },
  {
    id: 117,
    icon: "./assets/img/douyinface/117.png",
    code: "[黑线]",
    text: "[黑线]"
  },
  {
    id: 118,
    icon: "./assets/img/douyinface/118.png",
    code: "[得意]",
    text: "[得意]"
  },
  {
    id: 119,
    icon: "./assets/img/douyinface/119.png",
    code: "[衰]",
    text: "[衰]"
  },
  {
    id: 120,
    icon: "./assets/img/douyinface/120.png",
    code: "[互粉]",
    text: "[互粉]"
  },
  {
    id: 121,
    icon: "./assets/img/douyinface/121.png",
    code: "[吐血]",
    text: "[吐血]"
  },
  {
    id: 122,
    icon: "./assets/img/douyinface/122.png",
    code: "[可怜]",
    text: "[可怜]"
  },
  {
    id: 123,
    icon: "./assets/img/douyinface/123.png",
    code: "[不看]",
    text: "[不看]"
  },
  {
    id: 124,
    icon: "./assets/img/douyinface/124.png",
    code: "[摸头]",
    text: "[摸头]"
  },
  {
    id: 125,
    icon: "./assets/img/douyinface/125.png",
    code: "[去污粉]",
    text: "[去污粉]"
  },
  {
    id: 126,
    icon: "./assets/img/douyinface/126.png",
    code: "[钱]",
    text: "[钱]"
  },
  {
    id: 127,
    icon: "./assets/img/douyinface/127.png",
    code: "[撇嘴]",
    text: "[撇嘴]"
  },
  {
    id: 128,
    icon: "./assets/img/douyinface/128.png",
    code: "[震惊]",
    text: "[震惊]"
  },
  {
    id: 129,
    icon: "./assets/img/douyinface/129.png",
    code: "[V5]",
    text: "[V5]"
  },
  {
    id: 130,
    icon: "./assets/img/douyinface/130.png",
    code: "[菜刀]",
    text: "[菜刀]"
  },
  {
    id: 131,
    icon: "./assets/img/douyinface/131.png",
    code: "[刀]",
    text: "[刀]"
  },
  {
    id: 132,
    icon: "./assets/img/douyinface/132.png",
    code: "[做鬼脸]",
    text: "[做鬼脸]"
  },
  {
    id: 133,
    icon: "./assets/img/douyinface/133.png",
    code: "[皱眉]",
    text: "[皱眉]"
  },
  {
    id: 134,
    icon: "./assets/img/douyinface/134.png",
    code: "[敲打]",
    text: "[敲打]"
  },
  {
    id: 135,
    icon: "./assets/img/douyinface/135.png",
    code: "[尬笑]",
    text: "[尬笑]"
  },
  {
    id: 136,
    icon: "./assets/img/douyinface/136.png",
    code: "[恐惧]",
    text: "[恐惧]"
  },
  {
    id: 137,
    icon: "./assets/img/douyinface/137.png",
    code: "[惊喜]",
    text: "[惊喜]"
  },
  {
    id: 138,
    icon: "./assets/img/douyinface/138.png",
    code: "[石化]",
    text: "[石化]"
  },
  {
    id: 139,
    icon: "./assets/img/douyinface/139.png",
    code: "[哈欠]",
    text: "[哈欠]"
  },
  {
    id: 140,
    icon: "./assets/img/douyinface/140.png",
    code: "[炸弹]",
    text: "[炸弹]"
  },
  {
    id: 141,
    icon: "./assets/img/douyinface/141.png",
    code: "[嘘]",
    text: "[嘘]"
  },
  {
    id: 142,
    icon: "./assets/img/douyinface/142.png",
    code: "[吐舌]",
    text: "[吐舌]"
  },
  {
    id: 143,
    icon: "./assets/img/douyinface/143.png",
    code: "[委屈]",
    text: "[委屈]"
  },
  {
    id: 144,
    icon: "./assets/img/douyinface/144.png",
    code: "[吐彩虹]",
    text: "[吐彩虹]"
  },
  {
    id: 145,
    icon: "./assets/img/douyinface/145.png",
    code: "[奋斗]",
    text: "[奋斗]"
  },
  {
    id: 146,
    icon: "./assets/img/douyinface/146.png",
    code: "[生病]",
    text: "[生病]"
  },
  {
    id: 147,
    icon: "./assets/img/douyinface/147.png",
    code: "[雾霾]",
    text: "[雾霾]"
  },
  {
    id: 148,
    icon: "./assets/img/douyinface/148.png",
    code: "[擦汗]",
    text: "[擦汗]"
  },
  {
    id: 149,
    icon: "./assets/img/douyinface/149.png",
    code: "[如花]",
    text: "[如花]"
  },
  {
    id: 150,
    icon: "./assets/img/douyinface/150.png",
    code: "[鄙视]",
    text: "[鄙视]"
  },
  {
    id: 151,
    icon: "./assets/img/douyinface/151.png",
    code: "[强]",
    text: "[强]"
  },
  {
    id: 152,
    icon: "./assets/img/douyinface/152.png",
    code: "[紫薇别走]",
    text: "[紫薇别走]"
  },
  {
    id: 153,
    icon: "./assets/img/douyinface/153.png",
    code: "[红脸]",
    text: "[红脸]"
  },
  {
    id: 154,
    icon: "./assets/img/douyinface/154.png",
    code: "[困]",
    text: "[困]"
  },
  {
    id: 155,
    icon: "./assets/img/douyinface/155.png",
    code: "[流汗]",
    text: "[流汗]"
  },
  {
    id: 156,
    icon: "./assets/img/douyinface/156.png",
    code: "[流汗]",
    text: "[流汗]"
  },
  {
    id: 157,
    icon: "./assets/img/douyinface/157.png",
    code: "[绿帽子]",
    text: "[绿帽子]"
  },
  {
    id: 158,
    icon: "./assets/img/douyinface/158.png",
    code: "[左上]",
    text: "[左上]"
  },
  {
    id: 159,
    icon: "./assets/img/douyinface/159.png",
    code: "[熊吉]",
    text: "[熊吉]"
  },
  {
    id: 160,
    icon: "./assets/img/douyinface/160.png",
    code: "[听歌]",
    text: "[听歌]"
  },
  {
    id: 161,
    icon: "./assets/img/douyinface/161.png",
    code: "[骷髅]",
    text: "[骷髅]"
  },
  {
    id: 162,
    icon: "./assets/img/douyinface/162.png",
    code: "[18禁]",
    text: "[18禁]"
  },
  {
    id: 163,
    icon: "./assets/img/douyinface/163.png",
    code: "[西瓜]",
    text: "[西瓜]"
  },
  {
    id: 164,
    icon: "./assets/img/douyinface/164.png",
    code: "[斜眼]",
    text: "[斜眼]"
  },
  {
    id: 165,
    icon: "./assets/img/douyinface/165.png",
    code: "[阴险]",
    text: "[阴险]"
  },
  {
    id: 166,
    icon: "./assets/img/douyinface/166.png",
    code: "[白眼]",
    text: "[白眼]"
  },
  {
    id: 167,
    icon: "./assets/img/douyinface/167.png",
    code: "[凋谢]",
    text: "[凋谢]"
  },
  {
    id: 168,
    icon: "./assets/img/douyinface/168.png",
    code: "[嘿哈]",
    text: "[嘿哈]"
  },
  {
    id: 169,
    icon: "./assets/img/douyinface/169.png",
    code: "[坏笑]",
    text: "[坏笑]"
  },
  {
    id: 170,
    icon: "./assets/img/douyinface/170.png",
    code: "[加好友]",
    text: "[加好友]"
  },
  {
    id: 171,
    icon: "./assets/img/douyinface/171.png",
    code: "[囧]",
    text: "[囧]"
  },
  {
    id: 172,
    icon: "./assets/img/douyinface/172.png",
    code: "[泪奔]",
    text: "[泪奔]"
  },
  {
    id: 173,
    icon: "./assets/img/douyinface/173.png",
    code: "[不失礼貌的微笑]",
    text: "[不失礼貌的微笑]"
  },
  {
    id: 174,
    icon: "./assets/img/douyinface/174.png",
    code: "[拳头]",
    text: "[拳头]"
  },
  {
    id: 175,
    icon: "./assets/img/douyinface/175.png",
    code: "[右边]",
    text: "[右边]"
  },
  {
    id: 176,
    icon: "./assets/img/douyinface/176.png",
    code: "[右哼哼]",
    text: "[右哼哼]"
  },
  {
    id: 177,
    icon: "./assets/img/douyinface/177.png",
    code: "[悠闲]",
    text: "[悠闲]"
  },
  {
    id: 178,
    icon: "./assets/img/douyinface/178.png",
    code: "[绝望的凝视]",
    text: "[绝望的凝视]"
  },
  {
    id: 179,
    icon: "./assets/img/douyinface/179.png",
    code: "[咒骂]",
    text: "[咒骂]"
  },
  {
    id: 180,
    icon: "./assets/img/douyinface/180.png",
    code: "[猪头]",
    text: "[猪头]"
  },
  {
    id: 181,
    icon: "./assets/img/douyinface/181.png",
    code: "[左边]",
    text: "[左边]"
  },
  {
    id: 182,
    icon: "./assets/img/douyinface/182.png",
    code: "[左哼哼]",
    text: "[左哼哼]"
  }
]

const hour_list = [
  "00",
  "01",
  "02",
  "03",
  "04",
  "05",
  "06",
  "07",
  "08",
  "09",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23"
]

const minute_lisst = [
  "00",
  "01",
  "02",
  "03",
  "04",
  "05",
  "06",
  "07",
  "08",
  "09",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23",
  "24",
  "25",
  "26",
  "27",
  "28",
  "29",
  "30",
  "31",
  "32",
  "33",
  "34",
  "35",
  "36",
  "37",
  "38",
  "39",
  "40",
  "41",
  "42",
  "43",
  "44",
  "45",
  "46",
  "47",
  "48",
  "49",
  "50",
  "51",
  "52",
  "53",
  "54",
  "55",
  "56",
  "57",
  "58",
  "59"
]
