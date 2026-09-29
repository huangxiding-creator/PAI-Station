// 答案页 — 总包AI顾问 v0.5.0
// Markdown 结构化渲染（md2blocks）；pending 实时进度；ready 渲染全文；error 退次提示
// v0.5.0（用户九点令）：语音全撤；「总包AI智库专业解答」；五枚精美小按钮（有用/复制/导出/纠错/分享）
// 互动赠次：有用/导出/纠错(具体意见)/分享 每篇各 +1 次咨询机会；分享标题=总包AI顾问-免费咨询
const api = require('../../utils/api');
const md2blocks = require('../../utils/md2blocks');

Page({
  data: {
    id: '',
    loading: true,
    loadError: '',
    kbError: '',          // 引擎侧失败（已自动退次）
    polling: false,
    elapsed: 0,
    progress: [],
    question: '',
    unlocked: true,
    blocks: [],           // Markdown 结构化块（渲染用）
    citations: [],
    fullChars: 0,
    liked: false,
    likeBusy: false,
    nav: { statusBarHeight: 20, navHeight: 44 }
  },

  onLoad(options) {
    const app = getApp();
    if (app.globalData && app.globalData.nav) {
      this.setData({ nav: app.globalData.nav });
    }
    this.setData({ id: options.id || '' });
    this._pollTimer = null;
    this._tickTimer = null;
    this._rawText = '';   // 原文留存：复制/导出用（不进 data，避免超长渲染负担）
    this.load();
  },

  onUnload() {
    this._stopTimers();
  },

  _stopTimers() {
    if (this._pollTimer) { clearTimeout(this._pollTimer); this._pollTimer = null; }
    if (this._tickTimer) { clearInterval(this._tickTimer); this._tickTimer = null; }
  },

  _startTick() {
    if (this._tickTimer) return;
    this._tickTimer = setInterval(() => {
      this.setData({ elapsed: this.data.elapsed + 1 });
    }, 1000);
  },

  load() {
    const id = this.data.id;
    if (!id) {
      this.setData({ loading: false, loadError: '缺少答案编号' });
      return;
    }
    api.answer(id)
      .then((d) => {
        if (d.status === 'pending') {
          // 工程大脑处理中：播报阶段 + 秒表，2 秒后再来看
          this.setData({
            loading: false, polling: true,
            question: d.question,
            progress: d.progress || [],
            elapsed: d.elapsed || 0
          });
          this._startTick();
          this._pollTimer = setTimeout(() => this.load(), 2000);
          return;
        }
        this._stopTimers();
        if (d.status === 'error') {
          this.setData({ loading: false, polling: false, kbError: d.error_text || '引擎处理失败' });
          return;
        }
        const full = (d.unlocked ? d.answer : d.preview) || '';
        this._rawText = full;
        this.setData({
          loading: false, polling: false,
          question: d.question,
          unlocked: !!d.unlocked,
          blocks: md2blocks.md2blocks(full),
          citations: d.citations || [],
          fullChars: d.full_chars || 0,
          liked: !!d.liked
        });
        wx.setNavigationBarTitle({ title: '回答' });
      })
      .catch((err) => {
        this._stopTimers();
        this.setData({ loading: false, polling: false, loadError: api.errMsg(err, '加载失败') });
      });
  },

  onRetry() {
    this.setData({ loading: true, loadError: '' });
    this.load();
  },

  goAsk() {
    wx.switchTab({ url: '/pages/ask/ask' });
  },

  goBack() {
    const pages = getCurrentPages();
    if (pages.length > 1) {
      wx.navigateBack();
    } else {
      wx.switchTab({ url: '/pages/ask/ask' });
    }
  },

  onLike() {
    if (this.data.liked || this.data.likeBusy) return;
    this.setData({ likeBusy: true });
    api.like(this.data.id)
      .then((d) => {
        this.setData({ liked: true, likeBusy: false });
        if (d.granted) {
          wx.showToast({ title: '感谢！+1 次咨询机会', icon: 'none', duration: 2200 });
        } else {
          wx.showToast({ title: '已感谢', icon: 'success' });
        }
      })
      .catch((err) => {
        this.setData({ likeBusy: false });
        wx.showToast({ title: api.errMsg(err, '操作失败'), icon: 'none' });
      });
  },

  // 用户令 v0.5.0：纠错须写具体意见才奖励 +1 次
  onCriticize() {
    wx.showModal({
      title: '指出问题',
      editable: true,
      placeholderText: '哪里不准确？请写具体意见（必填，可得 +1 次）',
      success: (r) => {
        if (!r.confirm) return;
        const text = (r.content || '').trim();
        if (!text) {
          wx.showToast({ title: '写点具体意见才能领次数哦', icon: 'none', duration: 2000 });
          return;
        }
        api.criticize(this.data.id, text.slice(0, 200))
          .then((d) => {
            if (d.granted) {
              wx.showToast({ title: '已收到 +1 次咨询机会', icon: 'none', duration: 2200 });
            } else {
              wx.showToast({ title: '已收到，人工复核', icon: 'none' });
            }
          })
          .catch((err) => wx.showToast({ title: api.errMsg(err, '提交失败'), icon: 'none' }));
      }
    });
  },

  // 分享小按钮：点击即赠次（fire-and-forget，不打断系统分享面板）
  onShareTap() {
    api.shareReward(this.data.id)
      .then((d) => {
        if (d.granted) wx.showToast({ title: '分享 +1 次咨询机会', icon: 'none', duration: 2000 });
      })
      .catch(() => { /* 静默：分享动作本身不该被失败打断 */ });
  },

  onCopy() {
    const text = this._rawText || '';
    if (!text) return;
    wx.setClipboardData({
      data: text,
      success: () => wx.showToast({ title: '已复制全文', icon: 'success' })
    });
  },

  // ── 导出：Word/PDF 引擎生成（base64 落盘），MD 本地拼 ──
  onExport() {
    if (!this._rawText || !this.data.unlocked) {
      wx.showToast({ title: '解锁全文后可导出', icon: 'none' });
      return;
    }
    wx.showActionSheet({
      itemList: ['Word 文档 (.docx)', 'PDF 文档 (.pdf)', 'Markdown (.md)'],
      success: (r) => this._exportAs(['docx', 'pdf', 'md'][r.tapIndex]),
      fail: () => { /* 用户取消 */ }
    });
  },

  _exportAs(fmt) {
    const fname = '总包AI顾问-咨询问答-' + String(this.data.id).slice(0, 6) + '.' + fmt;
    const filePath = wx.env.USER_DATA_PATH + '/export-' + Date.now() + '.' + fmt;
    const fs = wx.getFileSystemManager();
    const writeAndOffer = (data, encoding) => {
      fs.writeFile({
        filePath,
        data,
        encoding,
        success: () => {
          wx.hideLoading();
          wx.showModal({
            title: '已生成文件',
            content: fname + ' · 可直接微信转发给同事，或预览后另存。',
            confirmText: '微信转发',
            cancelText: '预览',
            success: (m) => {
              if (m.confirm) this._shareFile(filePath, fname);
              else this._previewFile(filePath);
            }
          });
        },
        fail: () => {
          wx.hideLoading();
          wx.showToast({ title: '本机写入失败', icon: 'none' });
        }
      });
    };
    wx.showLoading({ title: '生成中…', mask: true });
    if (fmt === 'md') {
      writeAndOffer(this._buildMd(), 'utf8');
      return;
    }
    api.exportAnswer(this.data.id, fmt)
      .then((d) => writeAndOffer((d && d.b64) || '', 'base64'))
      .catch((err) => {
        wx.hideLoading();
        wx.showToast({ title: api.errMsg(err, '导出失败'), icon: 'none' });
      });
  },

  _shareFile(filePath, fileName) {
    if (!wx.shareFileMessage) {
      this._previewFile(filePath); // 老基础库：预览菜单里也能转发
      return;
    }
    wx.shareFileMessage({
      filePath,
      fileName,
      fail: () => this._previewFile(filePath)
    });
  },

  _previewFile(filePath) {
    wx.openDocument({
      filePath,
      showMenu: true,
      fail: () => wx.showToast({ title: '本机暂不支持预览该格式', icon: 'none' })
    });
  },

  _buildMd() {
    const lines = ['# 总包AI顾问 · 咨询问答', '', '## 咨询问题', '', (this.data.question || ''), '', '## 专业解答', ''];
    lines.push(this._rawText || '');
    lines.push('');
    if (this.data.citations && this.data.citations.length) {
      lines.push('## 依据来源', '');
      this.data.citations.forEach((c) => {
        lines.push('- [' + c.n + '] ' + c.source + (c.loc ? '（第 ' + c.loc + ' 条）' : ''));
      });
      lines.push('');
    }
    lines.push('---', '', '*由 总包AI顾问 · 总包AI智库（背后是顶级总包智库）生成 · 仅供参考，不构成正式法律意见*');
    return lines.join('\n');
  },

  onUnlock() {
    // v0.2.5 虚拟支付：签名腿（服务端出双签名）→ 拉起支付 → 成功回调解锁
    if (this._payBusy) return;
    this._payBusy = true;
    api.paySign(this.data.id)
      .then((d) => this._requestPay(d))
      .catch((err) => {
        this._payBusy = false;
        if (err && err.statusCode === 503) {
          // 虚拟支付未开通：诚实降级，引导点赞赠次
          wx.showModal({
            title: '支付即将上线',
            content: '虚拟支付开通前，在历史回答里点「有用 +1」即可再获 1 次全文提问机会。',
            showCancel: false,
            confirmText: '知道了'
          });
        } else {
          wx.showToast({ title: api.errMsg(err, '拉起支付失败'), icon: 'none' });
        }
      });
  },

  _requestPay(d) {
    if (!wx.requestVirtualPayment) {
      this._payBusy = false;
      wx.showModal({
        title: '需要升级微信',
        content: '当前微信版本过低，暂不支持虚拟支付。升级后即可 1 元解锁全文。',
        showCancel: false
      });
      return;
    }
    wx.requestVirtualPayment({
      mode: d.mode,
      signData: d.sign_data,     // 服务端签名字符串必须原样透传
      paySig: d.pay_sig,
      signature: d.signature,
      success: () => {
        api.unlockPaid(this.data.id, d.out_trade_no || '')
          .then(() => {
            this._payBusy = false;
            wx.showToast({ title: '已解锁全文', icon: 'success' });
            this.setData({ loading: true });
            this.load();
          })
          .catch(() => {
            this._payBusy = false;
            wx.showToast({ title: '已支付，解锁确认稍后自动生效，可重进本页', icon: 'none', duration: 3000 });
          });
      },
      fail: (res) => {
        this._payBusy = false;
        const code = res && res.errCode;
        if (code === -15007) {
          // session_key 过期：静默重登（服务端同步新 session_key）后再试一次
          api.login()
            .then(() => this.onUnlock())
            .catch(() => wx.showToast({ title: '请稍后重试', icon: 'none' }));
        } else if (code === -15005 || code === -15006) {
          wx.showToast({ title: '签名校验未过，我们已记录', icon: 'none', duration: 2500 });
        } else if (code === 1 || (res && res.errMsg && res.errMsg.indexOf('cancel') >= 0)) {
          // 用户取消：静默
        } else {
          wx.showToast({ title: '支付未完成', icon: 'none' });
        }
      }
    });
  },

  onShareAppMessage() {
    // 用户令 v0.5.0：分享标题统一为「总包AI顾问-免费咨询」
    return {
      title: '总包AI顾问-免费咨询',
      path: '/pages/answer/answer?id=' + this.data.id
    };
  }
});
