// 产品详情页: ?id=consultant|leopard|brain|zhiku|factory|aipo|station|glasses|robot|aiglasses
const { products, getProduct } = require('../../utils/products.js');

Page({
  data: {
    p: null,
    prev: null,
    next: null,
  },

  onLoad(query) {
    const p = getProduct(query.id || 'leopard');
    if (!p) {
      wx.showToast({ title: '产品不存在', icon: 'none' });
      setTimeout(() => wx.navigateBack({ fail: () => wx.reLaunch({ url: '/pages/index/index' }) }), 800);
      return;
    }
    const idx = products.findIndex((x) => x.id === p.id);
    wx.setNavigationBarTitle({ title: `${p.no} ${p.name} · 总包科技` });
    this.setData({
      p,
      prev: idx > 0 ? products[idx - 1] : null,
      next: idx < products.length - 1 ? products[idx + 1] : null,
    });
  },

  goProduct(e) {
    const { id } = e.currentTarget.dataset;
    wx.redirectTo({ url: `/pages/product/product?id=${id}` });
  },

  previewImage(e) {
    const { src } = e.currentTarget.dataset;
    const urls = this.data.p.images
      ? this.data.p.images.map((m) => m.src)
      : [this.data.p.image.src];
    wx.previewImage({ current: src, urls });
  },

  previewQr(e) {
    const { src } = e.currentTarget.dataset;
    wx.previewImage({ urls: [src] });
  },

  onJump() {
    const j = this.data.p && this.data.p.jump;
    if (!j) {
      return;
    }
    wx.navigateToMiniProgram({
      appId: j.appId,
      path: j.path,
      fail: () => wx.showToast({ title: '跳转未成功，请重试', icon: 'none' }),
    });
  },

  onShareAppMessage() {
    const p = this.data.p;
    return {
      title: `${p.title} · ${p.en}`,
      path: `/pages/product/product?id=${p.id}`,
    };
  },
});
