// utils/theme.js — v0.7.3 周换装系统（用户令：以周为周期 7 天自动轮换配色 + 用户可锁定偏好）
// 7 套调色板出自设计台校准（WeAppForge/work/gen_themes.py，navy 主题≈现网像素）。
// 语义：默认按星期轮换；storage('theme_pref') 有值则锁定该主题（''=跟随星期）。
// 用法：页面 onShow 调 theme.apply(this)；wxml 首节点 <page-meta page-style="{{themeStyle}}" />。
// 注意：page-style 内联变量会同时压过 app.wxss 的亮色默认与暗色 media 块——主题即最终色。
// v0.9.2 深色感知（审计修复）：系统深色时统一注入 obsidian 变量（亮纸面+暖曜石蓝图，全站一致，
// 消灭「亮纸面+各页深色硬编码混排」）；pref 照常存储，切回亮色即恢复周轮换/锁定。

const PREF_KEY = 'theme_pref';

const THEMES = {
  "navy": {name:"深海蓝图", weekday:1, deep:"#050e1c", navy1:"#071a39", navy2:"#0d2449", navy3:"#16325f", raise:"#233147", raise2:"#33435e", line:"#3a4a63", ink:"#edf4ff", inkDim:"#9cadc9", inkDimHi:"#bac8de", inkFaint:"#7887a1", glow:"#65a1fb", glowSoft:"#accaf6", blue:"#2164ca", blueTint:"#e2e9f3", paper:"#f8f5ed", paperHi:"#fdfbf7", paperCool:"#f0f4f9", paperDim:"#ebe7db", paperEdge:"#ddd6c6", paperInk:"#1a2435", paperInk2:"#384457", paperMuted:"#798496", paperLine:"#e6e0d1", accent:"#ff9633", accentSoft:"#ffba7a", accentDeep:"#f98110", accentInk:"#ae5e13", accentBg:"#fcf2e8", amberBg:"#faefe5", amberLine:"#f0d3b7", amberInk:"#ae6119", amberDeep:"#4e2f13", stamp:"#c5402b", stampHi:"#d86655", stampBg:"#f2d8d4", stampMid:"#e2afa7", stampDeep:"#64322b", inkRgb:"237,244,255", glowRgb:"101,161,251", blueRgb:"33,100,202", accentRgb:"255,150,51", accentDeepRgb:"249,129,16", accentInkRgb:"174,94,19", navy1Rgb:"7,26,57", navy2Rgb:"13,36,73", deepRgb:"5,14,28", raiseRgb:"35,49,71", gridRgb:"163,181,210", grid2Rgb:"177,190,211", inkDimRgb:"156,173,201", paperInkRgb:"26,36,53"},
  "pine": {name:"松烟制图", weekday:2, deep:"#061b16", navy1:"#08372b", navy2:"#0e4839", navy3:"#185d4c", raise:"#24463e", raise2:"#345d53", line:"#3b6258", ink:"#edfffb", inkDim:"#9dc8bd", inkDimHi:"#bbddd4", inkFaint:"#79a096", glow:"#65fbdd", glowSoft:"#acf6e7", blue:"#21caa8", blueTint:"#e2f3ef", paper:"#f8f6ed", paperHi:"#fdfcf7", paperCool:"#f0f9f8", paperDim:"#ebe8db", paperEdge:"#ddd8c6", paperInk:"#1b342e", paperInk2:"#38564f", paperMuted:"#79958e", paperLine:"#e6e2d1", accent:"#ffa733", accentSoft:"#ffc67a", accentDeep:"#f99410", accentInk:"#ae6b13", accentBg:"#fcf4e8", amberBg:"#faf1e5", amberLine:"#f0d7b7", amberInk:"#ae6d19", amberDeep:"#4e3413", stamp:"#c5402b", stampHi:"#d86655", stampBg:"#f2d8d4", stampMid:"#e2afa7", stampDeep:"#64322b", inkRgb:"237,255,251", glowRgb:"101,251,221", blueRgb:"33,202,168", accentRgb:"255,167,51", accentDeepRgb:"249,148,16", accentInkRgb:"174,107,19", navy1Rgb:"8,55,43", navy2Rgb:"14,72,57", deepRgb:"6,27,22", raiseRgb:"36,70,62", gridRgb:"164,208,197", grid2Rgb:"178,210,202", inkDimRgb:"157,200,189", paperInkRgb:"26,53,46"},
  "obsidian": {name:"曜石鎏金", weekday:3, deep:"#14110d", navy1:"#272019", navy2:"#342c23", navy3:"#453b30", raise:"#3a3530", raise2:"#4f4942", line:"#544f49", ink:"#fff7ed", inkDim:"#b9b3ac", inkDimHi:"#d1ccc7", inkFaint:"#928d86", glow:"#fbab65", glowSoft:"#f6cfac", blue:"#ca7021", blueTint:"#f3eae2", paper:"#f8f4ed", paperHi:"#fdfbf7", paperCool:"#f9f4f0", paperDim:"#ebe6db", paperEdge:"#ddd6c6", paperInk:"#2b2824", paperInk2:"#4c4843", paperMuted:"#8b8783", paperLine:"#e6e0d1", accent:"#ffc233", accentSoft:"#ffd77a", accentDeep:"#f9b310", accentInk:"#ae8013", accentBg:"#fcf6e8", amberBg:"#faf4e5", amberLine:"#f0dfb7", amberInk:"#ae8119", amberDeep:"#4e3c13", stamp:"#c5402b", stampHi:"#d86655", stampBg:"#f2d8d4", stampMid:"#e2afa7", stampDeep:"#64322b", inkRgb:"255,247,237", glowRgb:"251,171,101", blueRgb:"202,112,33", accentRgb:"255,194,51", accentDeepRgb:"249,179,16", accentInkRgb:"174,128,19", navy1Rgb:"39,32,25", navy2Rgb:"52,44,35", deepRgb:"20,17,13", raiseRgb:"58,53,48", gridRgb:"193,187,180", grid2Rgb:"199,194,189", inkDimRgb:"185,179,172", paperInkRgb:"53,40,26"},
  "violet": {name:"暮山紫电", weekday:4, deep:"#0e071b", navy1:"#1a0936", navy2:"#241046", navy3:"#321a5b", raise:"#312545", raise2:"#43355c", line:"#4a3c61", ink:"#f4edff", inkDim:"#ad9ec7", inkDimHi:"#c8bcdc", inkFaint:"#877a9f", glow:"#9c65fb", glowSoft:"#c7acf6", blue:"#5f21ca", blueTint:"#e8e2f3", paper:"#f2edf8", paperHi:"#faf7fd", paperCool:"#f4f0f9", paperDim:"#e2dbeb", paperEdge:"#d0c6dd", paperInk:"#241b34", paperInk2:"#443956", paperMuted:"#847a94", paperLine:"#dbd1e6", accent:"#33ddff", accentSoft:"#7ae9ff", accentDeep:"#10d2f9", accentInk:"#1395ae", accentBg:"#e8f9fc", amberBg:"#e5f7fa", amberLine:"#b7e6f0", amberInk:"#1995ae", amberDeep:"#13444e", stamp:"#c5402b", stampHi:"#d86655", stampBg:"#f2d8d4", stampMid:"#e2afa7", stampDeep:"#64322b", inkRgb:"244,237,255", glowRgb:"156,101,251", blueRgb:"95,33,202", accentRgb:"51,221,255", accentDeepRgb:"16,210,249", accentInkRgb:"19,149,174", navy1Rgb:"26,9,54", navy2Rgb:"36,16,70", deepRgb:"14,7,27", raiseRgb:"49,37,69", gridRgb:"181,165,207", grid2Rgb:"190,178,209", inkDimRgb:"173,158,199", paperInkRgb:"36,26,53"},
  "celadon": {name:"青瓷官窑", weekday:5, deep:"#07171b", navy1:"#092f36", navy2:"#103d46", navy3:"#1a505b", raise:"#254045", raise2:"#35555c", line:"#3c5b61", ink:"#edfcff", inkDim:"#9ec0c7", inkDimHi:"#bcd7dc", inkFaint:"#7a999f", glow:"#65fbef", glowSoft:"#acf6f0", blue:"#21cabc", blueTint:"#e2f3f1", paper:"#edf8ed", paperHi:"#f7fdf7", paperCool:"#f0f9f9", paperDim:"#dbebdb", paperEdge:"#c6ddc6", paperInk:"#1b3034", paperInk2:"#395156", paperMuted:"#7a9094", paperLine:"#d1e6d1", accent:"#ff4433", accentSoft:"#ff857a", accentDeep:"#f92410", accentInk:"#ae2013", accentBg:"#fceae8", amberBg:"#fae7e5", amberLine:"#f0bcb7", amberInk:"#ae2519", amberDeep:"#4e1813", stamp:"#c5402b", stampHi:"#d86655", stampBg:"#f2d8d4", stampMid:"#e2afa7", stampDeep:"#64322b", inkRgb:"237,252,255", glowRgb:"101,251,239", blueRgb:"33,202,188", accentRgb:"255,68,51", accentDeepRgb:"249,36,16", accentInkRgb:"174,32,19", navy1Rgb:"9,47,54", navy2Rgb:"16,61,70", deepRgb:"7,23,27", raiseRgb:"37,64,69", gridRgb:"165,200,207", grid2Rgb:"178,204,209", inkDimRgb:"158,192,199", paperInkRgb:"26,48,53"},
  "forge": {name:"熔炉信号", weekday:6, deep:"#180c09", navy1:"#31160e", navy2:"#402016", navy3:"#542d21", raise:"#422e28", raise2:"#584039", line:"#5d4740", ink:"#fff1ed", inkDim:"#c3aaa2", inkDimHi:"#d8c5c0", inkFaint:"#9b857e", glow:"#fba365", glowSoft:"#f6cbac", blue:"#ca6721", blueTint:"#f3e9e2", paper:"#f8f3ed", paperHi:"#fdfaf7", paperCool:"#f9f4f0", paperDim:"#ebe4db", paperEdge:"#ddd3c6", paperInk:"#31231e", paperInk2:"#52423c", paperMuted:"#91827d", paperLine:"#e6ddd1", accent:"#ffcc33", accentSoft:"#ffde7a", accentDeep:"#f9bf10", accentInk:"#ae8813", accentBg:"#fcf7e8", amberBg:"#faf5e5", amberLine:"#f0e2b7", amberInk:"#ae8919", amberDeep:"#4e3f13", stamp:"#c5402b", stampHi:"#d86655", stampBg:"#f2d8d4", stampMid:"#e2afa7", stampDeep:"#64322b", inkRgb:"255,241,237", glowRgb:"251,163,101", blueRgb:"202,103,33", accentRgb:"255,204,51", accentDeepRgb:"249,191,16", accentInkRgb:"174,136,19", navy1Rgb:"49,22,14", navy2Rgb:"64,32,22", deepRgb:"24,12,9", raiseRgb:"66,46,40", gridRgb:"203,177,170", grid2Rgb:"206,187,182", inkDimRgb:"195,170,162", paperInkRgb:"53,32,26"},
  "graphite": {name:"晨雾石墨", weekday:7, deep:"#0d1014", navy1:"#171d28", navy2:"#212836", navy3:"#2e3747", raise:"#2f333b", raise2:"#414650", line:"#474d56", ink:"#edf4ff", inkDim:"#aab0bb", inkDimHi:"#c6cad2", inkFaint:"#858a93", glow:"#65abfb", glowSoft:"#accff6", blue:"#2170ca", blueTint:"#e2eaf3", paper:"#edf0f8", paperHi:"#f7f9fd", paperCool:"#f0f4f9", paperDim:"#dbe0eb", paperEdge:"#c6cddd", paperInk:"#23262c", paperInk2:"#42464d", paperMuted:"#82868c", paperLine:"#d1d8e6", accent:"#ff6933", accentSoft:"#ff9e7a", accentDeep:"#f94e10", accentInk:"#ae3d13", accentBg:"#fcede8", amberBg:"#faebe5", amberLine:"#f0c7b7", amberInk:"#ae4119", amberDeep:"#4e2313", stamp:"#c5402b", stampHi:"#d86655", stampBg:"#f2d8d4", stampMid:"#e2afa7", stampDeep:"#64322b", inkRgb:"237,244,255", glowRgb:"101,171,251", blueRgb:"33,112,202", accentRgb:"255,105,51", accentDeepRgb:"249,78,16", accentInkRgb:"174,61,19", navy1Rgb:"23,29,40", navy2Rgb:"33,40,54", deepRgb:"13,16,20", raiseRgb:"47,51,59", gridRgb:"178,184,194", grid2Rgb:"188,192,200", inkDimRgb:"170,176,187", paperInkRgb:"26,36,53"}
};

const WEEKDAY_LABEL = { 1: '周一', 2: '周二', 3: '周三', 4: '周四', 5: '周五', 6: '周六', 7: '周日' };

// getDay() 0=周日..6=周六 → 主题 weekday 1-7
const DAY2WEEKDAY = { 0: 7, 1: 1, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6 };

function pref() {
  try { return wx.getStorageSync(PREF_KEY) || ''; } catch (e) { return ''; }
}

function current() {
  const p = pref();
  if (p && THEMES[p]) return THEMES[p];
  const wd = DAY2WEEKDAY[new Date().getDay()] || 1;
  for (const k of Object.keys(THEMES)) {
    if (THEMES[k].weekday === wd) return THEMES[k];
  }
  return THEMES.navy;
}

// 系统主题探测：优先 getAppBaseInfo，回退 getSystemInfoSync，再回退 light
function systemTheme() {
  try {
    if (wx.getAppBaseInfo && wx.getAppBaseInfo().theme) return wx.getAppBaseInfo().theme;
  } catch (e) { /* 老客户端无此 API */ }
  try {
    const t = wx.getSystemInfoSync().theme;
    if (t) return t;
  } catch (e) { /* 探测失败按亮色处理 */ }
  return 'light';
}

// 实际注入主题：系统深色一律曜石（pref 照常存储，切回亮色即恢复）
function effective() {
  return systemTheme() === 'dark' ? THEMES.obsidian : current();
}

// 系统深浅切换热跟随：模块级一次订阅（防重复），对页面栈各页重新注入
let themeWatchBound = false;
function bindThemeChange() {
  if (themeWatchBound || !wx.onThemeChange) return;
  themeWatchBound = true;
  try {
    wx.onThemeChange(function () {
      try {
        const pages = getCurrentPages() || [];
        for (let i = 0; i < pages.length; i++) apply(pages[i]);
      } catch (e) { /* 页面栈异常静默：下次 onShow 自然刷新 */ }
    });
  } catch (e) { /* 订阅失败静默 */ }
}

function styleStr(t) {
  return [
    /* 蓝图层 */
    '--navy-0:' + t.navy1, '--navy-1:' + t.navy2, '--navy-2:' + t.navy3,
    '--t-deep:' + t.deep, '--t-raise:' + t.raise, '--t-raise2:' + t.raise2, '--t-line:' + t.line,
    '--grid:rgba(' + t.glowRgb + ',0.14)', '--grid-soft:rgba(' + t.glowRgb + ',0.055)',
    '--white-ink:' + t.ink, '--ink-dim:' + t.inkDim, '--t-inkdim-hi:' + t.inkDimHi, '--t-inkdim-faint:' + t.inkFaint,
    '--t-glow:' + t.glow, '--t-glow-soft:' + t.glowSoft,
    /* 纸面层 */
    '--paper:' + t.paper, '--card:' + t.paperHi,
    '--ink:' + t.paperInk, '--ink-2:' + t.paperInk2, '--muted:' + t.paperMuted, '--line:' + t.paperLine,
    '--t-paper-hi:' + t.paperHi, '--t-paper-dim:' + t.paperDim, '--t-paper-edge:' + t.paperEdge,
    '--t-paper-cool:' + t.paperCool, '--t-blue-tint:' + t.blueTint,
    /* 点睛 */
    '--accent:' + t.accent, '--t-accent-soft:' + t.accentSoft, '--accent-deep:' + t.accentDeep,
    '--t-accent-ink:' + t.accentInk, '--t-accent-bg:' + t.accentBg,
    '--t-amber-bg:' + t.amberBg, '--t-amber-line:' + t.amberLine, '--t-amber-ink:' + t.amberInk, '--t-amber-deep:' + t.amberDeep,
    '--stamp:' + t.stamp, '--t-stamp-hi:' + t.stampHi, '--t-stamp-bg:' + t.stampBg, '--t-stamp-mid:' + t.stampMid, '--t-stamp-deep:' + t.stampDeep,
    '--draft:' + t.blue,
    /* rgba 三元组 */
    '--t-ink-rgb:' + t.inkRgb, '--t-glow-rgb:' + t.glowRgb, '--t-blue-rgb:' + t.blueRgb, '--t-accent-rgb:' + t.accentRgb,
    '--t-accent-deep-rgb:' + t.accentDeepRgb, '--t-accent-ink-rgb:' + t.accentInkRgb,
    '--t-navy1-rgb:' + t.navy1Rgb, '--t-navy2-rgb:' + t.navy2Rgb, '--t-deep-rgb:' + t.deepRgb, '--t-raise-rgb:' + t.raiseRgb,
    '--t-inkdim-rgb:' + t.inkDimRgb, '--t-pink-rgb:' + t.paperInkRgb
  ].join(';');
}

// 页面接入：onShow 里调用（全 9 页 navigationStyle=custom，无需再染原生导航栏）
function apply(page) {
  const t = effective();
  page.setData({ themeStyle: styleStr(t), themeKey: t.name ? keyOf(t) : 'navy', themeName: t.name });
  bindThemeChange();
  const bar = page.getTabBar && page.getTabBar();
  if (bar && bar.applyTheme) bar.applyTheme();
}

function keyOf(t) {
  for (const k of Object.keys(THEMES)) { if (THEMES[k] === t) return k; }
  return 'navy';
}

// 用户锁定/解锁偏好（'' = 跟随星期）
function setPref(key) {
  try { wx.setStorageSync(PREF_KEY, key || ''); } catch (e) { /* 存储失败静默：下次仍走星期轮换 */ }
}

// 「我的-外观」画廊数据
function list() {
  const cur = current();
  return Object.keys(THEMES).map(function (k) {
    const t = THEMES[k];
    return { key: k, name: t.name, weekdayLabel: WEEKDAY_LABEL[t.weekday] || '', active: t === cur,
             swatchDeep: t.navy1, swatchAccent: t.accent, swatchPaper: t.paper, swatchGlow: t.glow };
  });
}

module.exports = { apply: apply, current: current, effective: effective, list: list, setPref: setPref, styleStr: styleStr };
