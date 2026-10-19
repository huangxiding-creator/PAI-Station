// 产品详情页: ?id=consultant|leopard|brain|zhiku|factory|aipo|station|glasses|robot|aiglasses
const { products, getProduct } = require('../../utils/products.js');

Page({
  data: {
    spm: false, // 朋友圈单页模式（scene 1154）
    p: null,
    prev: null,
    next: null,
  },

  onLoad(query) {
    try {
      if (wx.getLaunchOptionsSync().scene === 1154) this.setData({ spm: true });
    } catch (e) { /* 场景值不可得按正常模式 */ }
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
    if (this.data.spm) {
      wx.showToast({ title: '朋友圈预览模式 · 请从右上角菜单进入小程序后跳转', icon: 'none', duration: 2200 });
      return;
    }
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
    // 专业级朋友卡：按产品配图（5:4 自动裁切）
    const p = this.data.p;
    return {
      title: `${p.title} · ${p.en}`,
      path: `/pages/product/product?id=${p.id}`,
      imageUrl: this.shareImage(p),
    };
  },

  // 1019 用户令：专业级朋友圈分享（1:1 卡图 + query 携参回本产品）
  onShareTimeline() {
    const p = this.data.p;
    return {
      title: `${p.title} · ${p.en}`,
      query: `id=${p.id}`,
      imageUrl: this.shareImage(p),
    };
  },

  shareImage(p) {
    if (p.image && p.image.src) return p.image.src;
    if (p.images && p.images.length && p.images[0].src) return p.images[0].src;
    return '/images/leopard.jpg';
  },
});
