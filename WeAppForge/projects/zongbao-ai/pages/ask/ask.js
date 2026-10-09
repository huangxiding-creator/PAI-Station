// 咨询页 — 总包AI顾问 v0.5.0
// v0.5.0（用户九点令）：语音全撤（输入法自带语音）；AI优化提问（免费池改写为递进三小问）；
// 布局=咨询问题输入框 → [AI优化提问|立即咨询]；常用咨询→示范性问题；免费 6 次/天+四动作赠次
const api = require('../../utils/api');
const theme = require('../../utils/theme');
const kbstats = require('../../utils/kbstats');
const tel = require('../../utils/telemetry'); // v0.9.6：真机执行轨迹打点（devtools 全绿+真机失灵双盲区的地面真值腿）
const pop = require('../../utils/pop'); // v0.9.7：qw-pop 自绘弹窗（按钮文字摆脱原生 4 字硬限）

// EPC 总承包热点题库：tag=chip 标签，q=递进三小问全文（点按填入）
const SAMPLES = [
  {
    tag: 'EPC 计价调价',
    q: 'EPC 固定总价合同下材料价格大幅上涨，我方还能申请调价吗？政策和示范文本的依据是什么？'
      + '具体要走什么程序、准备哪些证据，才能把调价真正落地拿到钱？'
  },
  {
    tag: '设计变更索赔',
    q: 'EPC 项目业主口头提出设计变更，费用和工期责任怎么划分？变更估价应按什么原则计算、'
      + '不平衡报价部位被变更怎么应对？从指令、签证到索赔的完整证据链和时效要点有哪些？'
  },
  {
    tag: '背靠背条款',
    q: '总包对分包的"背靠背"付款条款现在还有效吗？实务和裁判倾向怎么看、'
      + '哪些情形下不被支持？条款不被支持后按什么规则付款，总包该如何合规设计付款条件管理资金风险？'
  },
  {
    tag: '联合体投标',
    q: 'EPC 联合体各方资质怎么搭配、牵头方有什么法定责任？联合体协议必须写哪些条款'
      + '才能避免连带责任黑洞？中标后一方想退出或违约时该怎么处理？'
  },
  {
    tag: '结算与审计',
    q: '竣工结算被无限期拖延怎么办？政府项目"以审计结果为准"条款的效力边界在哪里、'
      + '超过约定时间不答复能否视为认可？承包人破解拖延的程序和时效抓手有哪些？'
  },
  {
    tag: '不平衡报价',
    q: 'EPC 项目不平衡报价有哪些合法的应用场景？什么报价结构会被认定为串通投标或导致废标？'
      + '中标后如何通过变更与调价把报价策略合规兑现？'
  }
];

// v0.9.2（1009 审计 HIGH 修复）：程序化回填统一入口——不受 textarea maxlength=500 截断的
// setData 路径（预填/AI优化采用/示范题）全部经此截断，保证 data.question 与所见一致。
const Q_MAX = 500;

// v0.9.5 审计修（L17）：隐私告知弹窗唯一出处——_gateAndLogin 与 submitQuestion 此前各持一份
// 全文拷贝，文案改动漏一处=合规口径分裂。同意→记忆+回调；拒绝→静默不发登录/不提问。
// v0.9.6（1009 真机根因战）：原生 confirmText 硬限 ≤4 字符——「同意并继续」6 字在真机
// 弹窗调用直接静默 fail（devtools 宽松不校验+e2e mock=双盲区）→ 隐私门整链静默死
// =额度「–」+免费咨询点了没反应。v0.9.7 根因战终局：换 qw-pop 自绘组件，按钮文字
// 无长度限制也无静默失败路径，原 400ms 重试腿整段删除（合规口径仍唯一出处）。
const PRIVACY_CONTENT = '为提供咨询服务，我们将通过微信登录获取您的 openid 用于额度记账，'
  + '并将您提交的问题与生成的回答存储在服务器；您自愿共享的问答将在「锅圈」公开展示，可随时取消共享。'
  + '本服务解答内容由人工智能（AI）生成，仅供参考。'
  + '详见「我的 · 用户协议与隐私政策」。';

function showPrivacyModal(page, onAgree) {
  return pop.modal(page, {
    kicker: '隐私 · PRIVACY',
    title: '隐私保护告知',
    content: PRIVACY_CONTENT,
    confirmText: '同意',
    cancelText: '不同意',
    maskClosable: false,
    selectable: true
  }).then((r) => {
    if (!r.confirm) return; // 拒绝：不发登录，不收集任何标识
    wx.setStorageSync('qw_privacy_ok', 1);
    if (onAgree) onAgree();
  });
}

Page({
  data: {
    question: '',
    charCount: 0,
    canAsk: false,
    qFocus: false,   // v0.9.4：空点CTA聚焦输入框
    askHint: '',    // e2e 可见的反馈状态位（empty/short）
    asking: false,
    optimizing: false,  // AI优化提问进行中
    samples: SAMPLES,
    quota: null,       // {free_left, bonus_left, total_left}
    quotaText: '—',
    loginReady: false,
    netStatus: '',     // ''未知 / 'ok' / 'down'（红卡常驻提示）
    nav: { statusBarHeight: 20, navHeight: 44 },
    kbStats: kbstats.KB_STATS,  // v0.9.5 审计修（L18）：信任带四数同源 zhiku（utils/kbstats.js）
    sheetNo: '',       // 图纸编号（咨询单装饰）
    popOpen: false,    // v0.9.7 qw-pop 开合镜像（e2e/结构锚 + tabBar 压暗让路）
    popMode: ''
  },

  onLoad(options) {
    const app = getApp();
    if (app.globalData && app.globalData.nav) {
      this.setData({ nav: app.globalData.nav });
    }
    theme.apply(this); // v0.7.4 首帧即上主题变量（onShow 仍会再刷，不闪白）
    // v0.7.4 海报深链闭环：海报码 scene "s=p&a={aid}" → 直达本篇答案
    // v0.9.2：畸形百分号序列防 URIError（与 home 跳板页同型加固）
    let sc = '';
    try {
      sc = decodeURIComponent((options && options.scene) || '');
    } catch (e) {
      sc = '';
    }
    const dm = sc.match(/^s=p&a=(.+)$/);
    if (dm && dm[1]) {
      this._posterAid = dm[1];
      this._gotoPoster();
    }
    // 委托单编号：GC + 月日（GC-0929 风格的制图装饰）
    const now = new Date();
    const pad = (n) => (n < 10 ? '0' + n : '' + n);
    this.setData({ sheetNo: 'GC-' + pad(now.getMonth() + 1) + pad(now.getDate()) });
    // v0.9.2（1009 审计 HIGH 修复）：隐私告知门前置——同意后才发起登录（wx.login+POST /api/login），
    // 拒绝则不收集 openid、额度票根保持空态；此前 onLoad 无条件 silentLogin、告知却是事后补的。
    tel.ping('ask_load');
    this._gateAndLogin();
  },

  // 隐私门 + 登录：已同意过直接登录
  // v0.9.8（用户令 1009）：冷启动不自动弹隐私告知（首屏不打断）；
  // 告知移至首次提交闸 submitQuestion——未同意前仍不收集 openid、不发登录（合规口径不变）
  _gateAndLogin() {
    tel.ping('ask_gate', { agreed: !!wx.getStorageSync('qw_privacy_ok') });
    if (wx.getStorageSync('qw_privacy_ok')) {
      this.silentLogin();
    }
  },

  // v0.7.4 海报深链导航（onLoad 首跳 + onShow 兜底重试；成功即清位，3 次上限防循环）
  _gotoPoster() {
    const aid = this._posterAid;
    if (!aid) return;
    this._posterTries = (this._posterTries || 0) + 1;
    if (this._posterTries > 3) { this._posterAid = ''; return; }
    wx.navigateTo({
      url: '/pages/answer/answer?id=' + aid,
      success: () => { this._posterAid = ''; },
      fail: () => { /* onLoad 期导航偶发被冻结，留待 onShow 重试 */ }
    });
  },

  onShow() {
    theme.apply(this);
    if (this._posterAid) this._gotoPoster(); // v0.7.4 海报深链兜底重试
    // 自绘 tabBar 选中态
    if (typeof this.getTabBar === 'function' && this.getTabBar()) {
      this.getTabBar().setData({ selected: 0 });
    }
    // v0.6.0 相关问题 chip 预填（答案页 onRelatedTap 写入；用户自己按提问，不代花次数）
    const prefill = wx.getStorageSync('qw_prefill');
    if (prefill) {
      wx.removeStorageSync('qw_prefill');
      this._fill(prefill); // v0.9.2：经统一截断入口（服务端生成的相关问题可能超 500 字）
    }
    // 从答案页返回（可能互动拿了赠次）→ 刷新配额
    if (this.data.loginReady) this.refreshQuota();
  },

  // v0.9.7 qw-pop：弹窗开合镜像 + 自绘 tabBar 压暗让路（本页是 tab 页，弹窗期间 tabBar 不可误触）
  onPopState(e) {
    pop.onPopState(this, e);
  },

  silentLogin() {
    api.ensureLogin()
      .then(() => {
        tel.ping('ask_login_ok');
        this.setData({ loginReady: true });
        this.refreshQuota();
      })
      .catch((err) => {
        tel.ping('ask_login_fail', { m: api.errMsg(err, '').slice(0, 60) });
        this.setData({ netStatus: 'down' });
        wx.showToast({ title: api.errMsg(err, '登录失败'), icon: 'none' });
      });
  },

  recheck() {
    if (!api.tokenSync()) {
      this.silentLogin();
    } else {
      this.refreshQuota();
    }
  },

  refreshQuota() {
    api.quota()
      .then((d) => {
        const q = d.quota || d;
        tel.ping('ask_quota', { f: q && q.free_left, b: q && q.bonus_left });
        this.setData({ netStatus: 'ok' });
        this.applyQuota(q);
      })
      .catch(() => {
        this.setData({ netStatus: 'down' });
        // 静默失败：保留缓存/旧值，不打断提问主流程
        const cached = wx.getStorageSync('qw_quota');
        if (cached) this.applyQuota(cached);
        // v0.9.5 审计修：用户手点「点击重试」仍失败时给一声轻提示（红卡虽在，
        // 但重试动作本身不许「点了没反应」——服务恢复前明确告知）
        if (this._retriedOnce) {
          wx.showToast({ title: '服务还没恢复，请稍后再试', icon: 'none', duration: 2000 });
        }
        this._retriedOnce = true;
      });
  },

  applyQuota(q) {
    if (!q || typeof q.total_left !== 'number') return;
    wx.setStorageSync('qw_quota', q);
    const parts = ['剩余 ' + q.free_left + ' 次'];
    if (q.bonus_left > 0) parts.push('互动加赠 ' + q.bonus_left + ' 次');
    this.setData({ quota: q, quotaText: parts.join(' · ') });
  },

  // 程序化回填统一入口：截到 500 与 maxlength 同步（v0.9.2，审计 MEDIUM 修复）
  _fill(v) {
    const s = String(v || '').slice(0, Q_MAX);
    this.setData({ question: s, charCount: s.length, canAsk: s.trim().length >= 2 });
  },

  onInput(e) {
    const v = e.detail.value || '';
    this.setData({
      question: v,
      charCount: v.length,
      canAsk: v.trim().length >= 2,  // 与服务端校验同源：非空+有意义
      askHint: '',
      qFocus: false   // v0.9.5 审计修：焦点已落输入框即复位——再次空点可重新触发聚焦翻转
    });
  },

  onSample(e) {
    const idx = e.currentTarget.dataset.i;
    const s = this.data.samples[idx];
    if (!s) return;
    this._fill(s.q);
  },

  onClear() {
    this.setData({ question: '', charCount: 0, canAsk: false });
  },

  // ── AI优化提问：把用户问题改写成更深入/更清晰/更究竟/更根本的递进式三小问 ──
  onOptimize() {
    const q = (this.data.question || '').trim();
    if (this.data.optimizing) return;
    // v0.9.4：与主CTA同款必反馈（此前静默 return）
    if (q.length < 2) {
      this.setData({ askHint: q ? 'short' : 'empty', qFocus: !q });
      wx.showToast({ title: q ? '问题至少输入 2 个字' : '请先输入您的问题', icon: 'none' });
      return;
    }
    if (wx.vibrateShort) { try { wx.vibrateShort({ type: 'light', fail: () => {} }); } catch (e) { /* 老客户端 */ } }
    this.setData({ optimizing: true });
    pop.loading(this, 'AI 优化中…');
    api.optimize(q)
      .then((d) => {
        pop.hideLoading(this);
        this.setData({ optimizing: false });
        const better = (d.optimized || '').trim();
        if (!better) {
          wx.showToast({ title: '优化结果为空，请稍后再试', icon: 'none' });
          return;
        }
        // 用户令：优化后交给用户过目，采用才替换（不静默改写）
        pop.modal(this, {
          kicker: '优化 · OPTIMIZE',
          title: 'AI 优化后的提问',
          content: better,
          confirmText: '采用',
          cancelText: '保留原问'
        }).then((r) => {
          if (r.confirm) {
            this._fill(better); // v0.9.2：经统一截断入口（优化文本不受 maxlength 约束）
            wx.showToast({ title: '已填入，可直接咨询', icon: 'none', duration: 1800 });
          }
        });
      })
      .catch((err) => {
        pop.hideLoading(this);
        this.setData({ optimizing: false });
        pop.modal(this, {
          kicker: '优化 · OPTIMIZE',
          title: '优化没成功',
          content: api.errMsg(err, 'AI 优化失败，请稍后再试'),
          showCancel: false,
          confirmText: '知道了'
        });
      });
  },

  onSubmit() {
    tel.ping('ask_tap'); // 真机「点了没反应」判别锚：tap 到没到处理器
    if (this.data.asking) return;
    // v0.9.4（1009 真机实测修复）：主 CTA 恒有反馈——空问提示并聚焦输入框（此前静默 return=「点了没反应」）
    if (!this.data.canAsk) {
      const q = (this.data.question || '').trim();
      this.setData({ askHint: q ? 'short' : 'empty', qFocus: !q });
      wx.showToast({ title: q ? '问题至少输入 2 个字' : '请先输入您的问题', icon: 'none' });
      return;
    }
    this.submitQuestion(this.data.question.trim());
  },

  submitQuestion(q) {
    if (this.data.asking || !q || q.trim().length < 2) return;
    // v0.7.4 提审合规：首次使用前隐私告知（同意一次即记忆，拒绝则不发起登录）
    if (!wx.getStorageSync('qw_privacy_ok')) {
      showPrivacyModal(this, () => this._doSubmit(q));
      return;
    }
    this._doSubmit(q);
  },

  _doSubmit(q) {
    if (this.data.asking || !q || q.trim().length < 2) return;
    if (wx.vibrateShort) { try { wx.vibrateShort({ type: 'light', fail: () => {} }); } catch (e) { /* 老客户端无触感 */ } }
    this.setData({ asking: true });
    api.ask(q)
      .then((d) => {
        tel.ping('ask_ok', { id: String(d && d.id || '').slice(0, 16) });
        // v0.2.2 秒回：立即进答案页看实时进度（总包智库后台跑）。
        // v0.9.2（审计 MEDIUM 修复）：清空输入移入 success 回调——偶发导航失败时用户问题不丢，
        // 并弹窗兜底引导从「咨询记录」进入。
        if (d.quota) this.applyQuota(d.quota);
        wx.navigateTo({
          url: '/pages/answer/answer?id=' + d.id,
          success: () => {
            this.setData({ asking: false, question: '', charCount: 0, canAsk: false });
          },
          fail: () => {
            this.setData({ asking: false });
            pop.modal(this, {
              kicker: '咨询 · CONSULT',
              title: '回答已生成',
              content: '页面跳转没成功，回答已存入「咨询记录」，从「我的」页可查看。',
              showCancel: false,
              confirmText: '知道了'
            });
          }
        });
      })
      .catch((err) => {
        tel.ping('ask_fail', { code: err && err.statusCode, m: api.errMsg(err, '').slice(0, 60) });
        this.setData({ asking: false });
        const msg = api.errMsg(err, '咨询失败');
        if (err && err.statusCode === 402) {
          // 配额用尽：引导互动赚次数（有用/纠错各+1，上不封顶）
          pop.modal(this, {
            kicker: '额度 · QUOTA',
            title: '今日次数已用完',
            content: '打开任意一篇回答，点「有用 / 纠错」即可各再获 1 次咨询机会（多答多得，不封顶）；明天 0 点恢复 6 次。',
            confirmText: '去互动'
          }).then((r) => { if (r.confirm) wx.switchTab({ url: '/pages/my/my' }); });
        } else {
          // 大声失败：弹窗常驻（toast 一闪而过=用户眼中"没反应"）
          pop.modal(this, {
            kicker: '咨询 · CONSULT',
            title: '咨询没成功',
            content: msg + (err && err.raw ? '\n(' + err.raw.slice(0, 60) + ')' : ''),
            showCancel: false,
            confirmText: '知道了'
          });
        }
      });
  }
});
