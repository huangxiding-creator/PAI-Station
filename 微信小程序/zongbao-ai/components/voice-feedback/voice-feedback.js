// components/voice-feedback/voice-feedback.js — 反馈+AI评分+按质退款组件 v2 (1017 修三断点)
// v2: ① 请求URL从不存在的 app.globalData.engineBase 改 utils/config.BASE_URL (ai.epcschool.top)
//     ② 语音识别从不通的外部ASR改微信同声传译插件, 插件缺失自动降级文字输入
//     ③ 新增文字反馈主路径 (永远可用); 邮箱登记携带 feedback_id 回填
const BASE_URL = require('../../utils/config').BASE_URL;

// 微信同声传译插件 (可选能力: 声明于 app.json; 未开通/不支持时静默降级文字输入)
let _si = null;
try { _si = requirePlugin('WechatSI'); } catch (e) { _si = null; }

Component({
  properties: {
    sku: { type: String, value: '' },
    reportTitle: { type: String, value: '' },
    openid: { type: String, value: '' },
  },

  data: {
    recording: false,
    recordTime: 0,
    transcript: '',
    scores: null,
    feedbackId: '',
    refundAmount: 0,
    refundPct: 0,
    email: '',
    showEmailBox: false,
    submitted: false,
    loading: false,
    timer: null,
    voiceReady: !!_si,
  },

  lifetimes: {
    detached() {
      if (this.data.timer) clearInterval(this.data.timer);
    }
  },

  methods: {
    // ── 语音腿 (WechatSI 插件; 缺失时引导文字) ─────────────────
    startRecord() {
      if (this.data.submitted) return;
      if (!_si || !_si.getRecordRecognitionManager) {
        wx.showToast({ title: '语音识别未就绪，请直接打字反馈', icon: 'none' });
        return;
      }
      if (this.data.recording) return;
      if (!this._siManager) {
        const mgr = _si.getRecordRecognitionManager();
        mgr.onStart = () => this.setData({ recording: true, recordTime: 0, transcript: '' });
        mgr.onRecognize = (res) => {
          const t = (res && res.result) || '';
          if (t) this.setData({ transcript: t });
        };
        mgr.onStop = (res) => {
          if (this.data.timer) clearInterval(this.data.timer);
          const t = ((res && res.result) || this.data.transcript || '').trim();
          this.setData({ recording: false, transcript: t });
          if (t.length < 20) {
            wx.showToast({ title: '说的内容太短，可打字补充后提交', icon: 'none' });
          }
        };
        mgr.onError = () => {
          if (this.data.timer) clearInterval(this.data.timer);
          this.setData({ recording: false });
          wx.showToast({ title: '语音识别失败，请直接打字反馈', icon: 'none' });
        };
        this._siManager = mgr;
      }
      this._siManager.start({ duration: 60000, lang: 'zh_CN' });
      const timer = setInterval(() => {
        this.setData({ recordTime: this.data.recordTime + 1 });
        if (this.data.recordTime >= 60) this.stopRecord();
      }, 1000);
      this.setData({ timer });
    },

    stopRecord() {
      if (!this.data.recording) return;
      if (this.data.timer) clearInterval(this.data.timer);
      if (this._siManager) this._siManager.stop();
      this.setData({ recording: false });
    },

    // ── 文字腿 (主路径, 永远可用) ─────────────────────────────
    onTextInput(e) {
      this.setData({ transcript: e.detail.value });
    },

    // 提交反馈 → 引擎六维评分
    submitFeedback() {
      const t = (this.data.transcript || '').trim();
      if (t.length < 20) {
        wx.showToast({ title: '反馈内容至少20字', icon: 'none' });
        return;
      }
      this.setData({ loading: true });
      wx.request({
        url: `${BASE_URL}/api/report/${this.data.sku}/voice_feedback`,
        method: 'POST',
        header: { 'Content-Type': 'application/json' },
        data: {
          transcript: t,
          openid: this.data.openid || 'anonymous',
          channel: this._usedVoice ? 'voice' : 'text',
        },
        success: (res) => {
          if (res.data && res.data.ok) {
            this.setData({
              scores: res.data.scores,
              feedbackId: res.data.feedback_id || '',
              refundAmount: res.data.refund_amount,
              refundPct: res.data.refund_percentage,
              showEmailBox: true,
              loading: false,
              submitted: true,
            });
          } else {
            wx.showToast({ title: (res.data && res.data.error) || '提交失败', icon: 'none' });
            this.setData({ loading: false });
          }
        },
        fail: () => {
          wx.showToast({ title: '网络错误', icon: 'none' });
          this.setData({ loading: false });
        }
      });
    },

    // 邮箱登记 (改版后新版免费发送)
    submitEmail() {
      const email = (this.data.email || '').trim();
      if (!email.includes('@')) {
        wx.showToast({ title: '请输入有效邮箱', icon: 'none' });
        return;
      }
      wx.request({
        url: `${BASE_URL}/api/report/${this.data.sku}/feedback_email`,
        method: 'POST',
        header: { 'Content-Type': 'application/json' },
        data: {
          email,
          openid: this.data.openid,
          feedback_id: this.data.feedbackId,
        },
        success: () => {
          wx.showToast({ title: '邮箱已登记，新版免费送达', icon: 'success' });
          this.setData({ showEmailBox: false });
        },
        fail: () => {
          wx.showToast({ title: '邮箱登记失败，稍后可重试', icon: 'none' });
        }
      });
    },

    onEmailInput(e) {
      this.setData({ email: e.detail.value });
    },

    skipEmail() {
      this.setData({ showEmailBox: false });
    },
  }
});
