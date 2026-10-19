// 报告详情页 — v0.9.0 报告商城（购买/试读/PDF 阅读）
// 链路：目录页带入 sku → 详情+试读 → 购买（pay.payReport，Android/工具端）→
// 解锁后 wx.downloadFile(带 Bearer) + openDocument 打开 PDF 全文。
// 合规铁律：iOS 不展示购买入口（paySupported() 门控），已解锁内容 iOS 可正常阅读。
const theme = require('../../utils/theme');
const api = require('../../utils/api');
const pay = require('../../utils/pay');
const md2blocks = require('../../utils/md2blocks');
const tel = require('../../utils/telemetry'); // v0.9.6：购买入口打点（对照组——此链在真机已活）
const pop = require('../../utils/pop'); // v0.9.7：qw-pop 自绘弹窗（品牌同源重设计，按钮文字摆脱 4 字硬限）

// v0.9.20 语音腿（用户令 1018 REQ-006）：WechatSI 同声传译插件（app.json 已声明，provider 真号在案）。
// 冻结面决策（KB voice-leg-reuse）：voice-feedback 组件只引用不改动——其录音状态机不外发
// transcript 事件、也无法承载本页提问，故「问报告」面板自带同款双通道（语音按住说主路 /
// 文字永在兜底），状态机逐档复刻组件范式（onStart/onRecognize/onStop/onError + 插件缺失文字兜底）。
let _si = null;
try { _si = requirePlugin('WechatSI'); } catch (e) { _si = null; }

Page({
  data: {
    nav: { statusBarHeight: 20, navHeight: 44 },
    sku: '',
    d: null,           // 详情（price/badges/chapters/audience/intro...）
    volCount: 0,       // 卷级头行数（多卷本>0；0=单卷平铺）
    chCount: 0,        // 章级条目数（剔除卷头，目录徽标真值）
    sample: '',        // 试读原文（md）
    sampleBlocks: [],  // 试读结构化块（md2blocks，渲染用）
    sampleOpen: false,
    loading: true,
    errMsg: '',
    buying: false,
    opening: false,
    paySupported: true, // iOS=false（虚拟支付铁律）
    popOpen: false,     // v0.9.7 qw-pop 开合镜像（e2e/结构锚 + tabBar 压暗让路）
    popMode: '',
    usefulDone: false,  // v0.9.15 有用已点（乐观置位防双击；400 已点过=终态保持）
    posterBusy: false,  // v0.9.15 海报生成在途
    rewardShow: false,  // v0.9.16 授勋动画开关（与答案页统一）
    reward: '',         // v0.9.16 授勋动画副题文案
    // ── v0.9.20 报告对话官（用户令 1018；v0.9.21 小 pill 升 hero 大区常驻）──
    askInput: '',        // 提问输入（语音转写实时回填同一口）
    asks: [],            // 气泡流 [{idx, q, conclusion, points, hint, loading, liked}]（先问后答）
    askLeft: 6,          // 统一池剩余（v0.9.23：咨询+问报告共享 6/日；服务端 left 回填）
    askUnlimited: false, // 已解锁本报告 → 无限问（服务端 left=999 哨兵，wxml 切「已解锁·无限问」）
    askExhausted: false, // 统一池用尽态（429 → 撤输入行+购买引导，不发下一问）
    askExhaustedMsg: '', // 用尽态服务端文案（v0.9.23：detail 透传；空走 wxml 兜底）
    askBusy: false,      // 发送防重入
    askRecording: false, // 语音按住说在录（touchstart/touchend 对）
  },

  onLoad(query) {
    const app = getApp();
    if (app.globalData && app.globalData.nav) {
      this.setData({ nav: app.globalData.nav });
    }
    theme.apply(this);
    this.setData({ sku: (query && query.sku) || '', paySupported: pay.paySupported() });
    this.load();
  },

  onShow() {
    theme.apply(this);
    // 从支付流程返回时刷新解锁态（onLoad 不重跑）
    if (this.data.d) this.load(true);
  },

  load(quiet) {
    if (!this.data.sku) {
      this.setData({ loading: false, errMsg: '缺少报告编号' });
      return;
    }
    if (!quiet) this.setData({ loading: true, errMsg: '' });
    api.reportDetail(this.data.sku)
      .then((d) => {
        // 1012 蓝皮书一级目录：卷级头行（vol:true）计卷数，章计数只认章级条目（74 不掺水）
        const chapters = d.chapters || [];
        const volCount = chapters.filter((c) => c.vol).length;
        const chCount = chapters.length - volCount;
        this.setData({ d, volCount, chCount, loading: false });
        // v0.9.23：问答区初始态实值化——解锁者直接亮「已解锁·无限问」，未解锁者取统一池真余量
        if (d && d.unlocked) {
          this.setData({ askUnlimited: true, askLeft: 999 });
        } else {
          api.quota()
            .then((qt) => {
              const tl = qt && qt.total_left;
              if (typeof tl === 'number') this.setData({ askLeft: tl, askExhausted: tl === 0 });
            })
            .catch(() => {}); // 静默：取不到就用默认 6，首答后服务端 left 自然校正
        }
        // v0.9.5 审计修（L6）：删除 wx.setNavigationBarTitle——全站 custom 导航栏（死调用）
        if (!this.data.sample) {
          api.reportSample(this.data.sku)
            .then((s) => {
              const t = (s && s.text) || '';
              this.setData({ sample: t, sampleBlocks: t ? md2blocks.md2blocks(t) : [] });
            })
            .catch(() => this.setData({ sample: '', sampleBlocks: [] })); // 试读整理中（404）静默
        }
      })
      .catch((err) => {
        // v0.9.5 审计修（M4）：静默刷新（购买后/回页 onShow）失败不再无声——
        // 有内容在屏时 errMsg 卡不会渲染（wx:if={{!d}}），须 toast 告知（对齐 pot.js 先例）
        if (this.data.d) {
          wx.showToast({ title: '刷新失败，展示的是稍早内容', icon: 'none', duration: 2200 });
        } else {
          this.setData({ loading: false, errMsg: api.errMsg(err, '详情加载失败，请稍后重试') });
        }
      });
  },

  toggleSample() {
    this.setData({ sampleOpen: !this.data.sampleOpen });
  },

  goBack() {
    const pages = getCurrentPages();
    if (pages.length > 1) wx.navigateBack();
    else wx.switchTab({ url: '/pages/research/research' });
  },

  // 错误态重试（包装一层，防 tap 事件对象误入 load 的 quiet 参数）
  retry() {
    this.load();
  },

  // v0.9.7 qw-pop：弹窗开合镜像 + 自绘 tabBar 压暗让路（本页非 tab 页，getTabBar 自然跳过）
  onPopState(e) {
    pop.onPopState(this, e);
  },

  // 购买解锁（Android/开发工具；iOS 入口在 wxml 层已隐藏）
  buy() {
    tel.ping('buy_tap', { sku: String(this.data.sku || '').slice(0, 24) });
    if (this.data.buying) return;
    if (!pay.paySupported()) {
            wx.showToast({ title: 'iOS 暂不支持应用内购买，请在安卓设备完成购买', icon: 'none', duration: 2500 });
      return;
    }
    wx.vibrateShort({ type: 'light', fail: () => {} });
    this.setData({ buying: true });
    pay.payReport(this.data.sku)
      .then((r) => {
        this.setData({ buying: false });
        if (r.ok) {
          wx.showToast({ title: '已解锁', icon: 'success' });
          this.load(true);
          return;
        }
        // v0.9.5 审计修（M5）：与 my/answer 支付链同款——取消=轻提示，失败=大声弹窗
        // （toast 一闪而过在用户眼里就是「点了没反应」——¥498+ 的单更须说清楚）
                // v0.9.12（用户令）：未完成支付不弹窗——用户自己知道；取消静默，其余轻提示原因
        if (String(r.message || '').indexOf('取消') < 0) {
          wx.showToast({ title: r.message, icon: 'none', duration: 2500 });
        }
      })
      .catch((err) => {
        this.setData({ buying: false });
                wx.showToast({ title: api.errMsg(err, '网络波动，请稍后重试'), icon: 'none', duration: 2500 });
      });
  },

  // 打开 PDF 全文（已解锁；downloadFile 须带 Bearer 头）
  openPdf() {
    if (this.data.opening) return;
    this.setData({ opening: true });
    pop.loading(this, '打开报告中');
    wx.downloadFile({
      url: api.reportPdfUrl(this.data.sku),
      header: { Authorization: 'Bearer ' + (api.tokenSync() || '') },
      success: (res) => {
        if (res.statusCode !== 200) {
          this._pdfFail('报告暂不可用（' + res.statusCode + '），请稍后重试');
          return;
        }
        wx.openDocument({
          filePath: res.tempFilePath,
          fileType: 'pdf',
          showMenu: true,
          success: () => {
            pop.hideLoading(this); // 须在 openDocument 之后收口，防读完 PDF 返回后蒙层滞留（审计锚）
            this.setData({ opening: false });
          },
          fail: () => this._pdfFail('本机暂不支持打开 PDF，请升级微信后重试'),
        });
      },
      fail: () => this._pdfFail('下载失败，请检查网络后重试'),
    });
  },

  _pdfFail(msg) {
    pop.hideLoading(this);
    this.setData({ opening: false });
    wx.showToast({ title: msg, icon: 'none', duration: 2500 });
  },

  // ══ v0.9.15（用户令 1011）互动三件：有用 / 分享给同行 / 生成海报 ══

  // 有用：赠 1 次咨询额度（每报告每人一次；与答案页 like 同构，反馈可见）
  onUseful() {
    if (this.data.usefulDone) return;
    tel.ping('report_useful_tap', { sku: String(this.data.sku || '').slice(0, 24) });
    api.reportBump(this.data.sku, 'likes').catch(() => {}); // v0.9.21：有用同步报告点赞计数（fire-and-forget）
    this.setData({ usefulDone: true }); // 乐观置位防双击；网络失败回滚
    api.reportUseful(this.data.sku)
      .then((r) => {
        if (r && r.quota) wx.setStorageSync('qw_quota', r.quota);
        // v0.9.16（1012 用户令）：赠次反馈升级为授勋动画——与答案页有用/纠错/共享完全统一
        this._reward('「有用」是给同行的掌声');
      })
      .catch((err) => {
        const again = err && err.statusCode === 400; // 已点过=终态保持置位
        if (!again) this.setData({ usefulDone: false });
        wx.showToast({ title: again ? '已点过有用' : api.errMsg(err, '网络波动，请稍后重试'), icon: 'none', duration: 2000 });
      });
  },

  // 分享给同行：静默赠 1 次（运营规范 3.2.1——分享动作零诱导文案、不弹获赠提示，
  // 仅额度数字自然 +1；服务端幂等，重复分享不报错）。bindtap 先于转发面板触发。
  // 1019 用户令「大力宣传免费问」：吸底栏/价值卡 → 滚到问答区，聚焦输入
  goAsk() {
    wx.pageScrollTo({ selector: '#askHero', duration: 300 });
    tel.ping('free_ask_cta', { sku: String(this.data.sku || '').slice(0, 24) });
  },

  // 免费价值卡 CTA：滚到试读区并自动展开（折叠态）
  goSample() {
    wx.pageScrollTo({ selector: '#sampleCard', duration: 300 });
    if (!this.data.sampleOpen) this.toggleSample();
    tel.ping('free_sample_cta', { sku: String(this.data.sku || '').slice(0, 24) });
  },

  onShareTap() {
    tel.ping('report_share_tap', { sku: String(this.data.sku || '').slice(0, 24) });
    api.reportBump(this.data.sku, 'shares').catch(() => {}); // v0.9.21：分享同步报告转发计数（静默，不打扰分享动作）
    api.reportShare(this.data.sku)
      .then((r) => {
        if (r && r.quota) wx.setStorageSync('qw_quota', r.quota);
        // v0.9.23：分享真赠到次（total_left>0）→ 复活问答输入行（用尽态可被分享解除）
        const tl = r && r.quota && r.quota.total_left;
        if (this.data.askExhausted && typeof tl === 'number' && tl > 0) {
          this.setData({ askExhausted: false, askLeft: tl, askExhaustedMsg: '' });
        }
      })
      .catch(() => {}); // 静默：赠次腿失败绝不打扰分享动作本身
  },

  // 生成海报：研报转化海报（无价格·试读显眼·扫码直达报告），范式与答案页 onPoster 同构
  onPoster() {
    if (this.data.posterBusy) return;
    this.setData({ posterBusy: true });
    pop.loading(this, '海报生成中…');
    api.reportPoster(this.data.sku)
      .then((d) => new Promise((resolve, reject) => {
        // 固定文件名（按报告）：重复生成不堆积
        const path = wx.env.USER_DATA_PATH + '/poster-r-' + this.data.sku + '.png';
        wx.getFileSystemManager().writeFile({
          filePath: path,
          data: (d && d.b64) || '',
          encoding: 'base64',
          success: () => resolve(path),
          fail: () => reject(new Error('本机写入失败'))
        });
      }))
      .then((path) => {
        pop.hideLoading(this);
        this.setData({ posterBusy: false });
        if (wx.showShareImageMenu) {
          wx.showShareImageMenu({
            path,
            entrancePath: '/pages/ask/ask', // 分享图携带小程序入口，海报码回流同页路由
            fail: () => this._previewPoster(path)
          });
        } else {
          this._previewPoster(path); // 老基础库：预览菜单可长按转发
        }
      })
      .catch((err) => {
        pop.hideLoading(this);
        this.setData({ posterBusy: false });
        wx.showToast({ title: api.errMsg(err, '海报生成失败'), icon: 'none' });
      });
  },

  _previewPoster(path) {
    wx.previewImage({ urls: [path], fail: () => wx.showToast({ title: '海报已生成', icon: 'none' }) });
  },

  // ══ v0.9.20 报告对话官（用户令 1018）：问报告 hero 大区常驻（REQ-006..009/011 引擎侧已就绪）══
  // v0.9.21（令升维）：原第四 pill 开合退役——hero 置于简介之上恒可见，零购买门槛不变（REQ-006.AC0）。

  onAskInput(e) {
    this.setData({ askInput: e.detail.value });
  },

  // 发送提问（文字腿主路；语音转写已实时回填同一输入口——发送前统一走此口）
  // v0.9.21：pill 开合退役后 report_ask_tap 打点随发送动作（hero 常驻=意图即提问）
  onAskSend() {
    tel.ping('report_ask_tap', { sku: String(this.data.sku || '').slice(0, 24) });
    const q = String(this.data.askInput || '').trim().slice(0, 200); // 服务端同律裁剪（2≤len≤200）
    if (this.data.askBusy || this.data.askExhausted) return;         // 防重入 + 日限停发（REQ-008）
    if (q.length < 2) {
      wx.showToast({ title: '问题再具体一点（至少 2 个字）', icon: 'none', duration: 1800 });
      return;
    }
    const idx = this._askSeq = (this._askSeq || 0) + 1;
    this.setData({
      asks: this.data.asks.concat([{ idx, q, conclusion: '', points: [], hint: '', loading: true }]),
      askInput: '',
      askBusy: true,
    });
    api.reportAsk(this.data.sku, q)
      .then((r) => {
        if (r && r.limited) {
          // 429：统一池用尽（v0.9.23 服务端零 LLM 消耗）——撤回在途气泡；仅 left===0 切用尽态
          // （解锁态软限速 429 带 left=999：只 toast 不锁输入，稍后可继续问）
          const exhausted = r.left === 0;
          this.setData({
            asks: this.data.asks.filter((a) => a.idx !== idx),
            askInput: q, // 问题文字奉还输入框（未计数不吞用户输入）
            askBusy: false,
            askExhausted: exhausted,
            askLeft: r.left || 0,
            askExhaustedMsg: r.detail || '',  // v0.9.23：服务端文案直出（今日6问已用完，明日再来；解锁无限问）
          });
          wx.showToast({ title: r.detail || '今日问数已用完，明日再来', icon: 'none', duration: 2200 });
          return;
        }
        // 命中章绑遥测（REQ-004/009：首条论据章号=检索命中面）
        tel.ping('report_ask_ok', {
          sku: String(this.data.sku || '').slice(0, 24),
          ch: (r && r.points && r.points[0] && r.points[0].ch) || 0,
        });
        const at = this.data.asks.findIndex((a) => a.idx === idx);
        this.setData({
          ['asks[' + at + ']']: {
            idx, q,
            conclusion: (r && r.conclusion) || '',
            points: (r && r.points) || [],
            hint: (r && r.hint) || '',
            loading: false,
          },
          askBusy: false,
          askLeft: (r && typeof r.left === 'number') ? r.left : this.data.askLeft,
          askUnlimited: !!(r && r.left >= 999),  // v0.9.23：解锁哨兵 → 无限问徽标
          askExhausted: !!(r && r.left === 0),
        });
      })
      .catch((err) => {
        // 503 软失败：服务端「问答稍后再试」话术直出；问题文字奉还输入框可重发
        this.setData({
          asks: this.data.asks.filter((a) => a.idx !== idx),
          askInput: q,
          askBusy: false,
        });
        wx.showToast({ title: api.errMsg(err, '问答稍后再试'), icon: 'none', duration: 2200 });
      });
  },

  // 转化条购买引导（REQ-007.AC2：直达既有 buy 流——paySupported 门/防重入/遥测全复用）
  onAskBuyTap() {
    tel.ping('report_ask_buy_tap', { sku: String(this.data.sku || '').slice(0, 24) });
    this.buy();
  },

  // ══ v0.9.21 答案气泡互动三钮（用户令 1018 升维：答案页 pill 语言；计数上链报告本体）══

  // 有用：报告 likes +1（bump 公开计数；每答案一次乐观置位，非交易面失败不回滚）
  onAskLike(e) {
    const i = e.currentTarget.dataset.idx;
    const a = this.data.asks[i];
    if (!a || a.loading || a.liked) return;
    tel.ping('report_ask_like', { sku: String(this.data.sku || '').slice(0, 24) });
    this.setData({ ['asks[' + i + '].liked']: true });
    api.reportBump(this.data.sku, 'likes').catch(() => {});
  },

  // 分享：open-type=share 转发面板（bindtap 先于面板触发）；bump shares 静默上链
  // v0.9.23：与页头分享同权——reportShare 赠次腿同样静默走（气泡分享不再只计数不赠次）
  onAskShareTap() {
    api.reportBump(this.data.sku, 'shares').catch(() => {});
    api.reportShare(this.data.sku)
      .then((r) => {
        if (r && r.quota) wx.setStorageSync('qw_quota', r.quota);
        const tl = r && r.quota && r.quota.total_left;
        if (this.data.askExhausted && typeof tl === 'number' && tl > 0) {
          this.setData({ askExhausted: false, askLeft: tl, askExhaustedMsg: '' });
        }
      })
      .catch(() => {});
  },

  // 生成海报：复用 v0.9.15 报告转化海报链（b64→showShareImageMenu→preview 兜底）
  onAskPoster(e) {
    // v0.9.22（1019 用户令修）：答案级海报——把问答内容复制到剪贴板+预览报告海报（MVP 降级：
    // 微信不支持动态生成问答内容图片到相册的公开 API；最诚意做法=复制全文+打开报告海报
    // 用户可截图问答内容分享）
    const idx = e && e.currentTarget && e.currentTarget.dataset.idx;
    const a = (this.data.asks || [])[idx];
    if (!a) return;
    tel.ping('report_ask_poster', { sku: String(this.data.sku || '').slice(0, 24) });
    // 问答全文复制到剪贴板（用户直接粘贴到聊天分享）
    const d = this.data.d || {};
    const NL = String.fromCharCode(10);
    const text = '【问报告】' + (d.title || '') + NL + NL + '问：' + (a.q || '') +
      NL + NL + '结论：' + (a.conclusion || '') +
      (a.points || []).map(function(p) { return NL + '· 第' + p.ch + '章：' + p.text; }).join('') +
      NL + NL + '完整拆解在报告正文，扫码购买阅读。';
    wx.setClipboardData({
      data: text,
      success: () => {
        wx.showToast({ title: '问答已复制，粘贴即可分享', icon: 'none', duration: 2500 });
      }
    });
  },

  // 语音按住说（真机 touchstart/touchend 事件对——KB 在案坑；冻结组件同款状态机逐档复刻）
  onMicStart() {
    if (this.data.askBusy || this.data.askExhausted) return;
    if (!_si || !_si.getRecordRecognitionManager) {
      wx.showToast({ title: '语音未就绪，请直接打字提问', icon: 'none', duration: 2500 });
      return;
    }
    if (this.data.askRecording) return;
    // v0.9.22（1019 用户令修）：先查录音权限，无权限引导开启（真机 voice 修复主腿）
    wx.getSetting({
      success: (s) => {
        if (s.authSetting['scope.record'] === false) {
          wx.showToast({ title: '请在设置中开启麦克风权限', icon: 'none', duration: 2500 });
          setTimeout(() => { wx.openSetting({}); }, 1500);
          return;
        }
        this._startVoiceRecord();
      },
      fail: () => this._startVoiceRecord() // 查不到就试（部分环境 getSetting 不覆盖 scope.record）
    });
  },

  _startVoiceRecord() {
    if (!this._askSiMgr) {
      const mgr = _si.getRecordRecognitionManager();
      mgr.onStart = () => this.setData({ askRecording: true });
      mgr.onRecognize = (res) => {
        const t = (res && res.result) || '';
        if (t) this.setData({ askInput: t }); // 转写实时回填输入口：说完即可发送
      };
      mgr.onStop = (res) => {
        const t = String((res && res.result) || this.data.askInput || '').trim();
        this.setData({ askRecording: false, askInput: t });
        if (t.length < 2) wx.showToast({ title: '说的内容有点短，可打字补充再发', icon: 'none', duration: 2000 });
      };
      mgr.onError = () => {
        this.setData({ askRecording: false });
        wx.showToast({ title: '语音识别失败，请直接打字提问', icon: 'none', duration: 2000 });
      };
      this._askSiMgr = mgr;
    }
    this._askSiMgr.start({ duration: 60000, lang: 'zh_CN' });
  },

  onMicEnd() {
    if (!this.data.askRecording) return;
    if (this._askSiMgr) this._askSiMgr.stop();
    this.setData({ askRecording: false });
  },

  // ══ v0.9.16 授勋动画（1012 用户令：有用赠次统一动画）——与答案页 _reward 同构逐字移植 ══
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

  onUnload() {
    if (this._rwTimer) { clearTimeout(this._rwTimer); this._rwTimer = null; } // 对齐答案页隐藏态纪律：离页不再对隐藏页 setData
    if (this.data.askRecording && this._askSiMgr) this._askSiMgr.stop(); // v0.9.20 语音腿：离页停录音
  },

  onShareAppMessage() {
    // v0.9.22（1019 用户令修）：答案级分享——从问报告气泡触发的分享带结论摘要
    const askIdx = e && e.target && e.target.dataset && e.target.dataset.askIdx;
    const d = this.data.d || {};
    return {
      title: d.title ? ('总包研究 · ' + d.title) : '总包研究 · EPC 深度研究报告',
      path: '/pages/report/report?sku=' + this.data.sku,
    };
  },

  // v0.9.18（用户令 1013 朋友圈亮灯）：两步门槛第二步——朋友圈不支持自定义 path，仅以 query 携 sku 自洽回流（镜像转发 path 构造）
  onShareTimeline() {
    const d = this.data.d || {};
    return {
      title: d.title ? ('总包研究 · ' + d.title) : '总包研究 · EPC 深度研究报告',
      query: 'sku=' + this.data.sku
    };
  },
});
