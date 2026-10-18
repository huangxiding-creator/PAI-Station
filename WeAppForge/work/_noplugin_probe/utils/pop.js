// utils/pop.js — qw-pop 自绘弹窗页面接线助手（v0.9.7）
// 页面三件接线：
//   ① json:  "usingComponents": { "qw-pop": "/components/qw-pop/qw-pop" }
//   ② wxml:  尾部 <qw-pop id="qwpop" bind:popstate="onPopState"/>
//   ③ js:    const pop = require('../../utils/pop');
//            onPopState(e) { pop.onPopState(this, e); }   // 镜像开合态 + tabBar 压暗让路
// 调用：pop.modal(this, {...}).then(r => ...) / pop.sheet(this, {...}) /
//       pop.loading(this, '生成中…') / pop.hideLoading(this)
const SEL = '#qwpop';

function _comp(page) {
  const c = page && page.selectComponent && page.selectComponent(SEL);
  if (!c) throw new Error('qw-pop 未接线（页面缺 #qwpop 节点）');
  return c;
}

function modal(page, opts) {
  return _comp(page).modal(opts);
}

function sheet(page, opts) {
  return _comp(page).sheet(opts);
}

function loading(page, text) {
  return _comp(page).loading(text);
}

function hideLoading(page) {
  const c = page && page.selectComponent && page.selectComponent(SEL);
  if (c) c.hideLoading();
}

// 统一 popstate 处理器：页面 data 镜像（popOpen/popMode=e2e+结构锚）+
// 自绘 tabBar 压暗让路（tab 页弹窗期间 tab 不可误触；非 tab 页 getTabBar 不存在自然跳过）
function onPopState(page, e) {
  const d = (e && e.detail) || {};
  page.setData({ popOpen: !!d.open, popMode: d.open ? (d.mode || '') : '' });
  if (typeof page.getTabBar === 'function' && page.getTabBar()) {
    page.getTabBar().setData({ dim: !!d.open });
  }
}

module.exports = { modal, sheet, loading, hideLoading, onPopState };
