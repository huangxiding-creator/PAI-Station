// 答案页 — 总包AI顾问 v0.6.0
// Markdown 结构化渲染（md2blocks）；pending 实时进度；ready 渲染全文；error 退次提示
// v0.5.0（用户九点令）：语音全撤；「总包AI智库专业解答」；五枚精美小按钮（有用/导出/纠错/分享）
// v0.7.3（用户令）：复制全文下线；导出不再赠次（赠次=有用/纠错/分享三动作）
// 互动赠次：有用/导出/纠错(具体意见)/分享 每篇各 +1 次咨询机会；分享标题=总包AI顾问-免费咨询
// v0.6.0（100× 弧线，全免费）：要点速览 tldr / 相关问题 chips / 追问对话流（智谱接地）/ 分享海报（引擎 Pillow）
// v0.7.4 提审合规：AI 生成标识上屏 / 极限词归零 / 依据解读口径 / 分享回流注释中性化
// v0.7.3（用户令）：观看/转发计数展示；互动得次授勋动画（徽章+光芒+火花+震动）；周换装主题
const api = require('../../utils/api');
const md2blocks = require('../../utils/md2blocks');
const theme = require('../../utils/theme');
const pay = require('../../utils/pay');
const tel = require('../../utils/telemetry'); // v0.9.6：真机导出链打点

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
    blocks: [],           // Markdown 结构化块（渲染用）
    citations: [],
    citeShow: false,      // v0.7.8 依据全文弹层开关（原生 modal 不可滚 → 页内自绘可滚动）
    citeTitle: '',
    citeText: '',
    citeBtn: '知道了',
    fullChars: 0,
    views: 0,             // v0.7.3 观看次数（点开全文即 +1，同人重复看持续累计）
    shares: 0,            // v0.7.3 转发次数（分享/海报传播即 +1）
    liked: false,
    likeBusy: false,
    criticBusy: false,    // v0.7.8 纠错提交中（慢网防连开连发）
    streamChars: 0,       // v0.7.0 流式已生成字数（打字机进度）
    partialBlocks: [],    // v0.7.0 流式增量正文块（生成中先睹为快）
    shared: false,        // v0.7.0 已共享进锅圈
    canShare: false,      // v0.7.0 本人已完成答案 → 可共享
    shareBusy: false,
    rewardShow: false,    // v0.7.3 授勋动画开关
    reward: '',           // 授勋副标（有用/分享/纠错/共享）
    tldr: [],             // v0.6.0 要点速览（生成失败→隐藏区块）
    related: [],          // v0.6.0 相关问题 chips
    fuList: [],           // v0.6.0 追问对话流
    fuInput: '',
    canSendFu: false,
    fuSending: false,    // v0.9.5 审计修（U2）：追问在途视觉位（置灰+文案切换，慢网防"点了没反应"）
    fuLeftA: null,        // 本篇今日追问剩余
    fuLeftG: null,        // 全局今日追问剩余
    posterBusy: false,
    exportPaid: false,   // v0.8.0 本篇导出已解锁（¥0.1/条）
    payOk: true,         // v0.8.0 虚拟支付可用（iOS=false → 隐藏导出入口，虚拟支付铁律）
    nav: { statusBarHeight: 20, navHeight: 44 }
  },

  onLoad(options) {
    const app = getApp();
    if (app.globalData && app.globalData.nav) {
      this.setData({ nav: app.globalData.nav });
    }
    theme.apply(this); // v0.7.4 首帧即上主题变量（onShow 仍会再刷，不闪白）
    this.setData({ id: options.id || '', payOk: pay.paySupported() });
    this._pollTimer = null;
    this._tickTimer = null;
    this._fuTimer = null;
    this._fuFails = 0;    // v0.7.8 追问轮询连续失败计数（退避重排用，成功即清零）
    this._visible = true; // v0.7.8 页面可见位：onHide 置 false，隐藏态不点火/不空烧定时器
    this._rawText = '';   // 原文留存：复制/导出用（不进 data，避免超长渲染负担）
    this.load();
  },

  onUnload() {
    this._stopTimers();
    if (this._rwTimer) { clearTimeout(this._rwTimer); this._rwTimer = null; }
  },

  // v0.7.3 周换装：每次进入刷新主题（含导航栏染色）
  // v0.7.8 隐藏期间轮询已停（onHide）：回前台按记录恢复，隐藏页不再空烧
  onShow() {
    this._visible = true;
    theme.apply(this);
    if (this._resumeMainPoll) {
      this._resumeMainPoll = false;
      this.load();   // pending 分支自带重建秒表 + 2s 轮询；已 ready 则直接渲染
    }
    if (this._resumeFuPoll) {
      this._resumeFuPoll = false;
      this._fuFails = 0;
      this._pollFollowups();
    }
  },

  // v0.7.8 切 tab/切后台：记录轮询状态后停表停轮询（正文生成中 + 追问 pending 都不空烧）
  onHide() {
    this._visible = false;
    this._resumeMainPoll = !!this.data.polling;
    this._resumeFuPoll = (this.data.fuList || []).some((x) => x.status === 'pending');
    this._stopTimers();
  },

  // v0.7.3 授勋动画（用户令）：得次瞬间全屏荣誉时刻——徽章弹出+光芒旋转+火花散射+重震
  _reward(label) {
    this.setData({ rewardShow: true, reward: label });
    wx.vibrateShort({ type: 'heavy', fail: () => {} });
    if (this._rwTimer) clearTimeout(this._rwTimer);
    this._rwTimer = setTimeout(() => {
      this.setData({ rewardShow: false, reward: '' });
      this._rwTimer = null;
    }, 2400);
  },

  noop() {},

  _stopTimers() {
    if (this._pollTimer) { clearTimeout(this._pollTimer); this._pollTimer = null; }
    if (this._tickTimer) { clearInterval(this._tickTimer); this._tickTimer = null; }
    if (this._fuTimer) { clearTimeout(this._fuTimer); this._fuTimer = null; }
    // v0.9.5 审计修：授勋动画定时器并入——切 tab 中途不再对隐藏页 setData（对齐本页隐藏态纪律）
    if (this._rwTimer) { clearTimeout(this._rwTimer); this._rwTimer = null; }
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
          // 总包智库处理中：流式打字机正文 + 阶段播报 + 秒表，2 秒后再来看
          this.setData({
            loading: false, polling: true,
            question: d.question,
            progress: d.progress || [],
            elapsed: d.elapsed || 0,
            streamChars: d.stream_chars || 0,
            partialBlocks: (d.partial && d.partial.length >= 30)
              ? md2blocks.md2blocks(d.partial) : []
          });
          if (!this._visible) {
            // 页面已隐藏（切 tab/后台）：不点火定时器，标记待恢复，onShow 再续跑
            this._resumeMainPoll = true;
            return;
          }
          this._startTick();
          this._pollTimer = setTimeout(() => this.load(), 2000);
          return;
        }
        this._stopTimers();
        if (d.status === 'error') {
          this.setData({ loading: false, polling: false, kbError: d.error_text || '引擎处理失败' });
          return;
        }
        const full = d.answer || d.preview || '';
        this._rawText = full;
        this.setData({
          loading: false, polling: false,
          question: d.question,
          exportPaid: !!d.export_paid,   // v0.8.0 详情腿下发
          blocks: md2blocks.md2blocks(full),
          citations: d.citations || [],
          fullChars: d.full_chars || 0,
          views: d.views || 0,
          shares: d.shares || 0,
          liked: !!d.liked,
          shared: !!d.shared,
          canShare: !!d.can_share
        });
        // v0.9.5 审计修：删除 wx.setNavigationBarTitle——全站 custom 导航栏，原生标题栏不存在（死调用）
        // v0.6.0 免费延伸层：要点速览 + 追问对话（失败各自优雅降级，不挡正文）
        this._loadDigest();
        this._loadFollowups();
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
          this._reward('「有用」是给同行的掌声');
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
  // v0.7.8 确认提交后置 criticBusy：完成/失败复位，慢网防连开连发
  onCriticize() {
    if (this.data.criticBusy) return;
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
        this.setData({ criticBusy: true });
        api.criticize(this.data.id, text.slice(0, 200))
          .then((d) => {
            this.setData({ criticBusy: false });
            if (d.granted) {
              this._reward('具体纠错是最珍贵的同行礼遇');
            } else {
              wx.showToast({ title: '已收到，人工复核', icon: 'none' });
            }
          })
          .catch((err) => {
            this.setData({ criticBusy: false });
            wx.showToast({ title: api.errMsg(err, '提交失败'), icon: 'none' });
          });
      }
    });
  },

  // v0.7.6 提审合规：分享按钮回归纯分享（open-type=share 直开系统面板）
  // 依《小程序平台运营规范》3.2.1 去除「分享 +1 次」利益激励，赠次仅保留有用/纠错等站内真实互动

  // ── 导出：Word/PDF 引擎生成（base64 落盘），MD 本地拼 ──
  // v0.8.0（用户令 1008）：咨询全免费；导出按条收费 ¥0.1（虚拟支付，Android；
  // iOS 隐藏付费入口——虚拟支付铁律；已解锁内容 iOS 也可导出）。
  onExport() {
    tel.ping('export_tap');
    if (!this._rawText) {
      wx.showToast({ title: '正文还没就绪', icon: 'none' });
      return;
    }
    if (this.data.exportPaid) {
      this._exportSheet();
      return;
    }
    if (!this.data.payOk) {
      wx.showToast({ title: '当前系统暂不支持导出，阅读全文不受影响', icon: 'none', duration: 2400 });
      return;
    }
    // v0.9.6（1009 真机根因战）：confirmText 硬限 ≤4 字符——「支付 0.1 元」8 字符
    // 在真机 showModal 直接 fail（devtools 宽松不校验）→ 导出确认弹窗整链静默死。
    // 金额已在 content 里，按钮文字回归 4 字内。
    wx.showModal({
      title: '导出本篇解答',
      content: '咨询全程免费，导出文件按 ¥0.1/条 收费（虚拟支付），本次支付 0.1 元。解锁后本篇可反复导出 Word/PDF/Markdown。',
      confirmText: '确认支付',
      cancelText: '再想想',
      success: (r) => {
        if (!r.confirm) return;
        if (this._payBusy) return;
        this._payBusy = true;
        wx.showLoading({ title: '拉起支付…', mask: true });
        pay.payExport(this.data.id)
          .then((res) => {
            wx.hideLoading();
            this._payBusy = false;
            if (res.reconciling) {
              // 已扣款、核验腿抖断：不谎报完成，重取详情（服务端查单补标记后自然解锁）
              wx.showToast({ title: res.message, icon: 'none', duration: 2500 });
              this.load();
              return;
            }
            if (res.ok) {
              this.setData({ exportPaid: true });
              this._exportSheet();
              return;
            }
            // v0.9.4：取消=轻提示；其余失败大声弹窗（同 my 批量导出修法）
            if (String(res.message || '').indexOf('取消') >= 0) {
              wx.showToast({ title: res.message, icon: 'none' });
            } else {
              tel.ping('export_fail', { m: String(res.message || '').slice(0, 60) });
              wx.showModal({
                title: '支付没完成',
                content: String(res.message || '请稍后重试') + '。可稍后再试；已扣款的金额不会丢（重新进入会自动对账解锁）。',
                showCancel: false,
                confirmText: '知道了'
              });
            }
          })
          .catch((err) => {
            // v0.9.4：兜底防假死（同 my 页修法——loading 永转+按钮废死的根）
            tel.ping('export_fail', { m: api.errMsg(err, '').slice(0, 60) });
            wx.hideLoading();
            this._payBusy = false;
            wx.showModal({
              title: '支付没成功',
              content: api.errMsg(err, '网络波动，请稍后重试'),
              showCancel: false,
              confirmText: '知道了'
            });
          });
      }
    });
  },

  _exportSheet() {
    wx.showActionSheet({
      itemList: ['Word 文档 (.docx)', 'PDF 文档 (.pdf)', 'Markdown (.md)'],
      success: (r) => this._exportAs(['docx', 'pdf', 'md'][r.tapIndex]),
      fail: () => { /* 用户取消 */ }
    });
  },

  _exportAs(fmt) {
    const fname = '总包AI顾问-咨询问答-' + String(this.data.id).slice(0, 6) + '.' + fmt;
    // v0.7.8 固定文件名（按答案+格式，writeFile 覆写）：重复导出不堆积（对齐海报腿做法）
    const filePath = wx.env.USER_DATA_PATH + '/export-' + this.data.id + '.' + fmt;
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
      .then((d) => {
        wx.hideLoading();
        if (!(d && d.b64)) {
          wx.showToast({ title: '导出失败，请重试', icon: 'none' });
          return;
        }
        writeAndOffer(d.b64, 'base64');
      })
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
    lines.push('---', '', '*由 总包AI顾问（AI 检索总包智库生成）生成 · 仅供参考，不构成正式法律意见*');
    return lines.join('\n');
  },

  // ══ v0.7.0 共享入锅圈（用户令 0930 第 8 条）：共享赠 1 次 / 取消共享扣 1 次 ══

  // 共享：本人已完成问答 → 公共锅圈展区（免费赠 1 次咨询机会）
  onShareOn() {
    if (this.data.shareBusy || this.data.shared) return;
    this.setData({ shareBusy: true });
    api.shareOn(this.data.id)
      .then(() => {
        this.setData({ shareBusy: false, shared: true });
        this._reward('共享进锅圈，帮到更多同行');
      })
      .catch((err) => {
        this.setData({ shareBusy: false });
        wx.showToast({ title: api.errMsg(err, '共享失败'), icon: 'none' });
      });
  },

  // 取消共享：撤出锅圈 + 扣 1 次咨询机会（用户令：明确告知再扣）
  onShareOff() {
    if (this.data.shareBusy || !this.data.shared) return;
    wx.showModal({
      title: '取消共享',
      content: '取消后本篇撤出锅圈，同时扣除 1 次咨询机会。确定取消吗？',
      confirmText: '取消共享',
      cancelText: '再想想',
      success: (r) => {
        if (!r.confirm) return;
        this.setData({ shareBusy: true });
        api.shareOff(this.data.id)
          .then(() => {
            this.setData({ shareBusy: false, shared: false });
            wx.showToast({ title: '已撤出锅圈，扣 1 次咨询机会', icon: 'none', duration: 2400 });
          })
          .catch((err) => {
            this.setData({ shareBusy: false });
            wx.showToast({ title: api.errMsg(err, '操作失败'), icon: 'none' });
          });
      }
    });
  },

  // ══ v0.7.0 依据来源全文展开（用户令 0930 第 11 条）：点条目展开完整条文 ══
  // v0.7.8 法规条文动辄上千字，原生 modal 不可滚被截断（合规敏感）→ 改页内自绘可滚动弹层
  onCiteTap(e) {
    const n = e.currentTarget.dataset.n;
    const c = (this.data.citations || []).find((x) => x.n === n);
    if (!n || !c) return;
    wx.showLoading({ title: '依据展开中…', mask: true });
    api.citationFulltext(this.data.id, n)
      .then((d) => {
        wx.hideLoading();
        this.setData({
          citeShow: true,
          citeTitle: '依据 [' + n + '] ' + (c.source || '').slice(0, 12),
          citeText: ((d && d.text) || '暂无展开内容') + '\n\n（以上为 AI 整理的依据解读，以官方发布文本为准）'
        });
      })
      .catch((err) => {
        wx.hideLoading();
        wx.showToast({ title: api.errMsg(err, '展开失败'), icon: 'none', duration: 2200 });
      });
  },

  // 依据弹层关闭：清长文省内存（按钮文案 citeBtn 常驻不清）
  onCiteClose() {
    this.setData({ citeShow: false, citeTitle: '', citeText: '' });
  },

  // ══ v0.6.0 免费延伸层（100× 弧线）══

  // 要点速览 + 相关问题：每答案引擎缓存一次；失败→隐藏区块（优雅降级）
  _loadDigest() {
    api.digest(this.data.id)
      .then((d) => this.setData({ tldr: (d && d.tldr) || [], related: (d && d.related) || [] }))
      .catch(() => this.setData({ tldr: [], related: [] }));
  },

  _loadFollowups() {
    api.followups(this.data.id)
      .then((d) => {
        const items = (d && d.items) || [];
        this.setData({ fuList: items });
        if (items.some((x) => x.status === 'pending')) this._pollFollowups();
      })
      .catch(() => { /* 静默：追问区可后补 */ });
  },

  // 追问轮询：2s 一拍；网络抖断不再静默放弃——退避 5s 重排，最多 5 次，
  // 连续超限把 pending 气泡收口为 error 态（复用 fu-a-error 渲染；重进本页即重拉重试）
  _pollFollowups() {
    if (this._fuTimer) return;
    if (!this._visible) { this._resumeFuPoll = true; return; }   // 隐藏态不空烧：标记待恢复
    this._fuTimer = setTimeout(() => {
      this._fuTimer = null;
      api.followups(this.data.id)
        .then((d) => {
          this._fuFails = 0;
          const items = (d && d.items) || [];
          this.setData({ fuList: items });
          if (items.some((x) => x.status === 'pending')) this._pollFollowups();
        })
        .catch(() => {
          this._fuFails = (this._fuFails || 0) + 1;
          if (!this._visible) { this._resumeFuPoll = true; return; }   // 请求期间被切走：不重排，标记待恢复
          if (this._fuFails < 5) {
            // 退避重排：失败后 5s 再轮询（_stopTimers 可清理，onUnload/onHide 不漏定时器）
            this._fuTimer = setTimeout(() => {
              this._fuTimer = null;
              this._pollFollowups();
            }, 5000);
            return;
          }
          // 连续 5 次失败：收口为 error 态，绝不让气泡永久停在「追问回答生成中…」
          this._fuFails = 0;
          this.setData({
            fuList: this.data.fuList.map((x) => (x.status === 'pending'
              ? { ...x, status: 'error', error_text: '网络波动，稍后重进本页自动重试' }
              : x))
          });
        });
    }, 2000);
  },

  onFuInput(e) {
    const v = (e.detail.value || '');
    this.setData({ fuInput: v, canSendFu: v.trim().length >= 2 });
  },

  // 免费追问：发送→本地即时挂 pending 气泡→2s 轮询回答（智谱接地，不烧 KB 积分）
  onFuSend() {
    const q = (this.data.fuInput || '').trim();
    if (q.length < 2) {
      wx.showToast({ title: '追问至少 2 个字', icon: 'none' });
      return;
    }
    if (this.data.fuSending) return;
    this.setData({ fuSending: true });
    api.followup(this.data.id, q.slice(0, 200))
      .then((d) => {
        this.setData({
          fuSending: false,
          fuInput: '', canSendFu: false,
          fuLeftA: d.left_answer, fuLeftG: d.left_global,
          fuList: this.data.fuList.concat([{
            id: d.id, question: q, answer: '', status: 'pending', error_text: ''
          }])
        });
        this._pollFollowups();
      })
      .catch((err) => {
        this.setData({ fuSending: false });
        wx.showToast({ title: api.errMsg(err, '追问失败'), icon: 'none', duration: 2500 });
      });
  },

  // 相关问题 chip → 预填提问框（用户自己按提问，不代花次数）
  onRelatedTap(e) {
    const q = (e.currentTarget.dataset.q || '').trim();
    if (!q) return;
    wx.setStorageSync('qw_prefill', q);
    wx.switchTab({ url: '/pages/ask/ask' });
  },

  // 分享海报：引擎 Pillow 生成（问题+要点+品牌+小程序码）→ 系统图片分享面板
  onPoster() {
    if (this.data.posterBusy) return;
    this.setData({ posterBusy: true });
    wx.showLoading({ title: '海报生成中…', mask: true });
    api.poster(this.data.id)
      .then((d) => new Promise((resolve, reject) => {
        // 固定文件名（按答案）：重复生成不堆积
        const path = wx.env.USER_DATA_PATH + '/poster-' + this.data.id + '.png';
        wx.getFileSystemManager().writeFile({
          filePath: path,
          data: (d && d.b64) || '',
          encoding: 'base64',
          success: () => resolve(path),
          fail: () => reject(new Error('本机写入失败'))
        });
      }))
      .then((path) => {
        wx.hideLoading();
        this.setData({ posterBusy: false });
        if (wx.showShareImageMenu) {
          wx.showShareImageMenu({
            path,
            entrancePath: '/pages/ask/ask',   // 分享图携带小程序入口，便于扫码回流
            fail: () => this._previewPoster(path)
          });
        } else {
          this._previewPoster(path);   // 老基础库：预览菜单可长按转发
        }
      })
      .catch((err) => {
        wx.hideLoading();
        this.setData({ posterBusy: false });
        wx.showToast({ title: api.errMsg(err, '海报生成失败'), icon: 'none' });
      });
  },

  _previewPoster(path) {
    wx.previewImage({ urls: [path], fail: () => wx.showToast({ title: '海报已生成', icon: 'none' }) });
  },

  onShareAppMessage() {
    // 用户令 v0.5.0：分享标题统一为「总包AI顾问-免费咨询」
    return {
      title: '总包AI顾问-免费咨询',
      path: '/pages/answer/answer?id=' + this.data.id
    };
  }
});
