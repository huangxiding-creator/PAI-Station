// 首页: 资产总览 + 八线矩阵 + 四重价值 + 收入引擎 + 联系
const content = require('../../utils/content.js');

Page({
  data: {
    hero: content.hero,
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

  goProduct(e) {
    const { id } = e.currentTarget.dataset;
    wx.navigateTo({ url: `/pages/product/product?id=${id}` });
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
    return {
      title: '总包说科技 · 大模型兵马已动，行业粮草先行十年',
      path: '/pages/index/index',
    };
  },
});
