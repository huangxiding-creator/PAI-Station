// 首页: 旗舰直达 + 资产总览 + 八线矩阵 + 四重价值 + 收入引擎 + 联系
const content = require('../../utils/content.js');

const CONSULTANT_APPID = 'wx5cee1574ce45819b';

Page({
  data: {
    spm: false, // 朋友圈单页模式（scene 1154）：顶导条 + 跳转类 CTA 降级
    hero: content.hero,
    flagship: content.flagship,
    chips: content.chips,
    dwg: content.dwg,
    marquee: content.marquee,
    stats: content.stats,
    native: content.native,
    value: content.value,
    ledger: content.ledger,
    unity: content.unity,
    business: content.business,
    contact: content.contact,
    footer: content.footer,
  },

  onLoad() {
    // 朋友圈单页模式（scene 1154）检测：顶导条引导进完整小程序
    try {
      if (wx.getLaunchOptionsSync().scene === 1154) this.setData({ spm: true });
    } catch (e) { /* 场景值不可得时按正常模式 */ }
  },

  goProduct(e) {
    const { id } = e.currentTarget.dataset;
    wx.navigateTo({ url: `/pages/product/product?id=${id}` });
  },

  onFlagship(e) {
    if (this.data.spm) {
      wx.showToast({ title: '朋友圈预览模式 · 请从右上角菜单进入小程序后跳转', icon: 'none', duration: 2200 });
      return;
    }
    const { type } = e.currentTarget.dataset;
    if (type === 'jump') {
      wx.navigateToMiniProgram({
        appId: CONSULTANT_APPID,
        path: 'pages/home/home',
        fail: () => wx.showToast({ title: '跳转未成功，请重试', icon: 'none' }),
      });
    } else {
      wx.navigateTo({ url: '/pages/product/product?id=aiglasses' });
    }
  },

  previewQr() {
    wx.previewImage({ urls: [content.contact.qr] });
  },

  saveQr() {
    wx.getImageInfo({
      src: content.contact.qr,
      success: (info) => {
        wx.saveImageToPhotosAlbum({
          filePath: info.path,
          success: () => wx.showToast({ title: '已保存到相册', icon: 'success' }),
          fail: (err) => {
            if (err.errMsg && err.errMsg.indexOf('auth') >= 0) {
              wx.showToast({ title: '请在设置中授权相册', icon: 'none' });
            } else {
              wx.showToast({ title: '保存未成功', icon: 'none' });
            }
          },
        });
      },
      fail: () => wx.showToast({ title: '图片读取失败', icon: 'none' }),
    });
  },

  onShareAppMessage() {
    // 专业级朋友卡：5:4 品牌卡图（工程豹产品首页实拍）
    return {
      title: '总包科技 · 大模型兵马已动，行业粮草先行十年',
      path: '/pages/index/index',
      imageUrl: '/images/leopard.jpg',
    };
  },

  // 1019 用户令：专业级朋友圈分享（1:1 卡图 + 单页模式适配）
  onShareTimeline() {
    return {
      title: '总包科技 · 大模型兵马已动，行业粮草先行十年',
      imageUrl: '/images/leopard.jpg',
    };
  },
});
