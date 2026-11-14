"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.saveToAlbum = saveToAlbum;
// utils/album_save.js — 海报直存相册（1114 用户令：修复「暂无图片保存权限」）
// 根因：海报生成后走 showShareImageMenu 原生面板，其内置「保存图片」在
// scope.writePhotosAlbum 被拒后由平台弹「暂无图片保存权限」，小程序侧无法接住。
// 正解：显式 wx.saveImageToPhotosAlbum 直存；被拒不硬撞——qw-pop modal 引导 openSetting
// 开关一次到位，开启后自动重存；其余失败如实报错（v0.9.9 硬门：无原生弹窗，page 未接线时降级兜底）。

// 权限引导（qw-pop modal 接线版；page/pop 必传——调用页均已接线 qw-pop）
function _guideToSetting(page, pop, filePath, resolve, reject) {
  const ask = (page && pop)
    ? pop.modal(page, {
        kicker: 'ALBUM · 权限',
        title: '需要相册权限',
        content: '开启「添加到相册」权限后，海报即可直接保存到手机相册。',
        confirmText: '去开启',
      })
    : Promise.resolve(-1); // 未接线=直接放弃（现网两调用页均已接线，不可达分支）
  ask.then((r) => {
    const ok = r === 'ok' || r === true || (r && r.confirm === true);
    if (!ok) { reject({ errMsg: 'cancel' }); return; }
    wx.openSetting({
      success: (s2) => {
        if (s2.authSetting && s2.authSetting['scope.writePhotosAlbum']) {
          wx.saveImageToPhotosAlbum({
            filePath,
            success: () => resolve(true),
            fail: (e2) => reject(e2),
          });
        } else {
          reject({ errMsg: 'settings:still-denied' });
        }
      },
      fail: () => reject({ errMsg: 'settings:fail' }),
    });
  });
}

function saveToAlbum(filePath, page, pop) {
  return new Promise((resolve, reject) => {
    const attempt = () => wx.saveImageToPhotosAlbum({
      filePath,
      success: () => resolve(true),
      fail: (e) => {
        const msg = (e && e.errMsg) || '';
        if (msg.indexOf('auth') >= 0 || msg.indexOf('denied') >= 0 || msg.indexOf('deny') >= 0) {
          _guideToSetting(page, pop, filePath, resolve, reject);
        } else {
          reject(e);
        }
      },
    });
    // 先静默探权：首次会弹系统授权框（同意即走），曾被拒会直接 fail auth → 走引导
    wx.getSetting({
      success: (s) => {
        const st = s.authSetting && s.authSetting['scope.writePhotosAlbum'];
        if (st === false) {
          // 明确拒绝过：先引导，避免 save 静默失败
          _guideToSetting(page, pop, filePath, resolve, reject);
        } else {
          attempt(); // 未问过(undefined)或已授权(true) → 直接存
        }
      },
      fail: attempt,
    });
  });
}
