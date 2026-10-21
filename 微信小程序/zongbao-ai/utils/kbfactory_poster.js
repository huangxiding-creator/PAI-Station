// utils/kbfactory_poster.js — 知识库工厂 蓝图长图/分享卡绘制（W6）
//
// 对外契约（页面唯一依赖）：
//   generateBlueprintPoster(bp, digest) -> Promise<{filePath}>  解锁导出件：
//       蓝图核心区 = 统计带 + 树缩略 + 配比仪表盘 + 报价卡，绘成分享长图（离屏 canvas 2d）
//   generateShareCard(bp, digest) -> Promise<{filePath}>        免费分享卡（轻量门面，各平台可看）
// 实现：wx.createOffscreenCanvas(type 2d) → toDataURL → 用户目录落 PNG → 页面存相册/预览。
// 老基础库（无离屏 2d/无 toDataURL）拒绝为友好文案，不猜不编。
// 敏感词纪律：本文件在 verify 门扫描范围内——画面文案零渠道名/零技术词。
var PAPER = '#f7f4ec', INK = '#1b2434', INK2 = '#39445a', LINE = '#e6e1d2';
var ACCENT = '#ff9432', ACCENT_DEEP = '#e07a0e', BLUE = '#1d6fd0', GREEN = '#2f9e63';

function _canvas(w, h) {
  if (typeof wx.createOffscreenCanvas !== 'function') return null;
  try { return wx.createOffscreenCanvas({ type: '2d', width: w, height: h }); } catch (e) { return null; }
}

// 圆角矩形路径（手绘四角，不依赖较新运行时的 roundRect）
function _rr(ctx, x, y, w, h, r) {
  ctx.beginPath();
  ctx.moveTo(x + r, y);
  ctx.arcTo(x + w, y, x + w, y + h, r);
  ctx.arcTo(x + w, y + h, x, y + h, r);
  ctx.arcTo(x, y + h, x, y, r);
  ctx.arcTo(x, y, x + w, y, r);
  ctx.closePath();
}

// 超宽截断加省略号（调用前须先设好 font）
function _clip(ctx, text, maxW) {
  var s = String(text || '');
  if (ctx.measureText(s).width <= maxW) return s;
  while (s.length > 1 && ctx.measureText(s + '…').width > maxW) s = s.slice(0, -1);
  return s + '…';
}

function _thousands(n) {
  return String(n).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

// canvas → 用户目录 PNG（base64 落盘）
function _toFile(cv, name) {
  return new Promise(function (resolve, reject) {
    var b64 = '';
    try { b64 = cv.toDataURL('image/png'); } catch (e) { b64 = ''; }
    if (!b64 || b64.indexOf('base64,') < 0) { reject({ message: '长图生成失败，请升级微信后重试' }); return; }
    var data = b64.slice(b64.indexOf('base64,') + 7);
    var dir = (wx.env && wx.env.USER_DATA_PATH) || '';
    if (!dir) { reject({ message: '本机暂不能保存图片，请升级微信后重试' }); return; }
    var fs = null;
    try { fs = wx.getFileSystemManager(); } catch (e) { fs = null; }
    if (!fs) { reject({ message: '本机暂不能保存图片，请稍后再试' }); return; }
    fs.writeFile({
      filePath: dir + '/' + name,
      data: data,
      encoding: 'base64',
      success: function () { resolve({ filePath: dir + '/' + name }); },
      fail: function () { reject({ message: '图片暂存失败，请稍后再试' }); }
    });
  });
}

// 头部橙带（两图共用语言）
function _header(ctx, W, H, domain, sub, sha) {
  var g = ctx.createLinearGradient(0, 0, 0, H);
  g.addColorStop(0, '#ffb066');
  g.addColorStop(0.45, ACCENT);
  g.addColorStop(1, ACCENT_DEEP);
  ctx.fillStyle = g;
  ctx.fillRect(0, 0, W, H);
  ctx.fillStyle = 'rgba(255,255,255,0.8)';
  ctx.font = '600 22px sans-serif';
  ctx.fillText('KB-FACTORY · 知识库蓝图', 48, 64);
  ctx.fillStyle = '#ffffff';
  ctx.font = 'bold 56px sans-serif';
  ctx.fillText(_clip(ctx, domain || '专业知识库', W - 96), 48, 152);
  ctx.fillStyle = 'rgba(255,255,255,0.88)';
  ctx.font = '24px sans-serif';
  ctx.fillText(sub, 48, 204);
  ctx.font = '20px sans-serif';
  ctx.fillStyle = 'rgba(255,255,255,0.7)';
  ctx.fillText(sha ? '图纸版本 ' + sha : '', 48, H - 30);
}

// ── 解锁导出件：统计带 + 树缩略 + 配比 + 报价卡（长图 750 宽）──
function generateBlueprintPoster(bp, digest) {
  bp = bp || {};
  var st = bp.stats || {}, q = bp.quote || {}, r = bp.ratio || {};
  var l1 = ((bp.tree && bp.tree.l1) || []).slice(0, 10);
  var mdPrice = Math.round((q.total || 0) * (q.md_factor || 1.5) * 10) / 10;
  var importPrice = Math.round(((q.total || 0) + (q.import_add || 19)) * 10) / 10;

  var W = 750;
  var HEAD = 300, STATS = 190, RATIO = 200, QUOTE = 320, TREEHEAD = 96;
  var H = HEAD + STATS + RATIO + QUOTE + TREEHEAD + l1.length * 74 + 130;
  var cv = _canvas(W, H);
  if (!cv) return Promise.reject({ message: '当前微信版本较低，长图生成暂不可用' });
  var ctx = cv.getContext('2d');

  ctx.fillStyle = PAPER;
  ctx.fillRect(0, 0, W, H);
  _header(ctx, W, HEAD, bp.domain, '一句话，免费设计 · 满意再带走', digest && digest.version_sha);

  // 统计带（三格大数）
  ctx.fillStyle = INK2;
  ctx.font = '22px sans-serif';
  ctx.fillText('图签统计带 STATS', 48, HEAD + 46);
  var cols = [
    [_thousands(st.files || 0), '总文件数'],
    [String(st.gb || 0), '总GB'],
    [String(st.dir_count || 0), '目录数']
  ];
  for (var c = 0; c < 3; c++) {
    var cx = W / 6 + (W / 3) * c;
    ctx.fillStyle = INK;
    ctx.font = 'bold 54px sans-serif';
    ctx.textAlign = 'center';
    ctx.fillText(cols[c][0], cx, HEAD + 128);
    ctx.fillStyle = INK2;
    ctx.font = '22px sans-serif';
    ctx.fillText(cols[c][1], cx, HEAD + 164);
    ctx.textAlign = 'left';
  }

  // 配比仪表盘（三段条 + 图例）
  var RY = HEAD + STATS;
  ctx.fillStyle = INK2;
  ctx.font = '22px sans-serif';
  ctx.fillText('配比仪表盘 RATIO', 48, RY + 46);
  var barX = 48, barW = W - 96, barY = RY + 74, barH = 28;
  var segs = [[r.core || 0, ACCENT], [r.field || 0, BLUE], [r.guide || 0, GREEN]];
  var sx = barX;
  for (var s = 0; s < segs.length; s++) {
    var w = barW * (segs[s][0] / 100);
    ctx.fillStyle = segs[s][1];
    ctx.fillRect(sx, barY, Math.max(w, 2), barH);
    sx += w;
  }
  var legend = [['核心主干', r.core || 0, ACCENT], ['领域补充', r.field || 0, BLUE], ['导读合成', r.guide || 0, GREEN]];
  var lx = 48;
  for (var g = 0; g < legend.length; g++) {
    ctx.fillStyle = legend[g][2];
    ctx.beginPath();
    ctx.arc(lx + 8, RY + 142, 8, 0, Math.PI * 2);
    ctx.fill();
    ctx.fillStyle = INK2;
    ctx.font = '22px sans-serif';
    var t = legend[g][0] + ' ' + legend[g][1] + '%';
    ctx.fillText(t, lx + 26, RY + 150);
    lx += 26 + ctx.measureText(t).width + 40;
  }

  // 报价卡（白卡 + 大字总价 + 三行）
  var QY = RY + RATIO;
  ctx.fillStyle = '#ffffff';
  _rr(ctx, 32, QY + 8, W - 64, 292, 16);
  ctx.fill();
  ctx.strokeStyle = LINE;
  ctx.lineWidth = 2;
  _rr(ctx, 32, QY + 8, W - 64, 292, 16);
  ctx.stroke();
  ctx.fillStyle = ACCENT_DEEP;
  ctx.font = 'bold 62px sans-serif';
  ctx.fillText('¥' + (q.total || 0), 64, QY + 86);
  ctx.fillStyle = INK2;
  ctx.font = '20px sans-serif';
  ctx.fillText('按 ' + (st.gb || 0) + 'GB 实测体积计价 · 基础 ¥' + (q.base || 0) + ' + 每GB ¥' + (q.per_gb || 0), 64, QY + 124);
  var rows = [
    ['原文件版', '¥' + (q.total || 0)],
    ['轻便阅读版', '¥' + mdPrice],
    ['随身知识库导入包', '¥' + importPrice]
  ];
  for (var i = 0; i < rows.length; i++) {
    var ry = QY + 176 + i * 40;
    ctx.fillStyle = INK;
    ctx.font = '24px sans-serif';
    ctx.fillText(rows[i][0], 64, ry);
    ctx.fillStyle = ACCENT_DEEP;
    ctx.font = 'bold 24px sans-serif';
    ctx.textAlign = 'right';
    ctx.fillText(rows[i][1], W - 64, ry);
    ctx.textAlign = 'left';
  }

  // 树缩略（一级大类清单，最多 10 行，超出注明）
  var TY = QY + QUOTE;
  ctx.fillStyle = INK2;
  ctx.font = '22px sans-serif';
  ctx.fillText('目录骨架 TREE · 一级大类', 48, TY + 46);
  for (var k = 0; k < l1.length; k++) {
    var rowY = TY + TREEHEAD + k * 74;
    ctx.strokeStyle = ACCENT;
    ctx.lineWidth = 3;
    _rr(ctx, 48, rowY - 36, 56, 44, 8);
    ctx.stroke();
    ctx.fillStyle = ACCENT;
    ctx.font = 'bold 24px sans-serif';
    ctx.fillText(_clip(ctx, l1[k].code || String(k + 1), 48), 56, rowY - 6);
    ctx.fillStyle = INK;
    ctx.font = '26px sans-serif';
    ctx.fillText(_clip(ctx, l1[k].name || '', W - 340), 128, rowY - 6);
    ctx.fillStyle = INK2;
    ctx.font = '22px sans-serif';
    ctx.textAlign = 'right';
    ctx.fillText((l1[k].l2_count || 0) + ' 组', W - 48, rowY - 6);
    ctx.textAlign = 'left';
  }
  var totalL1 = ((bp.tree && bp.tree.l1) || []).length;
  if (totalL1 > l1.length) {
    var moreY = TY + TREEHEAD + l1.length * 74;
    ctx.fillStyle = INK2;
    ctx.font = '22px sans-serif';
    ctx.fillText('…… 另有 ' + (totalL1 - l1.length) + ' 个大类，蓝图内可展开', 48, moreY);
  }

  // 页脚
  var FY = H - 70;
  ctx.setLineDash([8, 8]);
  ctx.strokeStyle = LINE;
  ctx.lineWidth = 2;
  ctx.beginPath();
  ctx.moveTo(48, FY - 34);
  ctx.lineTo(W - 48, FY - 34);
  ctx.stroke();
  ctx.setLineDash([]);
  ctx.fillStyle = INK2;
  ctx.font = 'bold 24px sans-serif';
  ctx.fillText('总包智库 · 知识库工厂', 48, FY + 8);
  ctx.textAlign = 'right';
  ctx.fillStyle = INK2;
  ctx.font = '20px sans-serif';
  ctx.fillText('免费看完整蓝图 · 满意再带走', W - 48, FY + 8);
  ctx.textAlign = 'left';

  return _toFile(cv, 'kbf_blueprint_' + ((digest && digest.version_sha) || 'x') + '.png');
}

// ── 免费分享卡（600 宽紧凑门面；iOS 亦可生成查看）──
function generateShareCard(bp, digest) {
  bp = bp || {};
  var st = bp.stats || {}, q = bp.quote || {};
  var W = 600, HEAD = 250, H = 620;
  var cv = _canvas(W, H);
  if (!cv) return Promise.reject({ message: '当前微信版本较低，分享卡生成暂不可用' });
  var ctx = cv.getContext('2d');

  ctx.fillStyle = PAPER;
  ctx.fillRect(0, 0, W, H);
  _header(ctx, W, HEAD, bp.domain, '一句话，免费设计你的知识库', digest && digest.version_sha);

  ctx.textAlign = 'center';
  ctx.fillStyle = INK2;
  ctx.font = '26px sans-serif';
  ctx.fillText(_thousands(st.files || 0) + ' 份资料 · ' + (st.gb || 0) + ' GB · ' + (st.dir_count || 0) + ' 个目录', W / 2, HEAD + 66);

  ctx.fillStyle = ACCENT_DEEP;
  ctx.font = 'bold 84px sans-serif';
  ctx.fillText('¥' + (q.total || 0), W / 2, HEAD + 190);

  ctx.fillStyle = INK2;
  ctx.font = '24px sans-serif';
  ctx.fillText('带走整库 · 整理后发您邮箱', W / 2, HEAD + 238);

  ctx.setLineDash([8, 8]);
  ctx.strokeStyle = LINE;
  ctx.lineWidth = 2;
  ctx.beginPath();
  ctx.moveTo(48, H - 96);
  ctx.lineTo(W - 48, H - 96);
  ctx.stroke();
  ctx.setLineDash([]);
  ctx.fillStyle = INK;
  ctx.font = 'bold 26px sans-serif';
  ctx.fillText('总包智库 · 知识库工厂', W / 2, H - 48);
  ctx.textAlign = 'left';

  return _toFile(cv, 'kbf_card_' + ((digest && digest.version_sha) || 'x') + '.png');
}

module.exports = { generateBlueprintPoster, generateShareCard };
