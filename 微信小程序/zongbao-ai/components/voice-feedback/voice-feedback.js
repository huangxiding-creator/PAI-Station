// components/voice-feedback/voice-feedback.js — 语音反馈+AI评分+退款组件
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
    refundAmount: 0,
    refundPct: 0,
    email: '',
    showEmailBox: false,
    submitted: false,
    loading: false,
    timer: null,
  },

  lifetimes: {
    detached() {
      if (this.data.timer) clearInterval(this.data.timer);
    }
  },

  methods: {
    // 按住开始录音
    startRecord() {
      if (this.data.submitted) return;
      const rm = wx.getRecorderManager();
      this.setData({ recording: true, recordTime: 0, transcript: '' });
      rm.start({ format: 'mp3', duration: 60000, sampleRate: 16000, numberOfChannels: 1 });
      const timer = setInterval(() => {
        this.setData({ recordTime: this.data.recordTime + 1 });
        if (this.data.recordTime >= 60) this.stopRecord();
      }, 1000);
      this.setData({ timer });
    },

    // 松开停止录音
    stopRecord() {
      if (!this.data.recording) return;
      const rm = wx.getRecorderManager();
      rm.stop();
      if (this.data.timer) clearInterval(this.data.timer);
      this.setData({ recording: false });
    },

    // 录音结束 → 转文字
    onRecordEnd(e) {
      const tempFilePath = e.detail.tempFilePath;
      if (this.data.recordTime < 3) {
        wx.showToast({ title: '说话时间太短（至少3秒）', icon: 'none' });
        return;
      }
      this.setData({ loading: true });
      this.speechToText(tempFilePath);
    },

    // 语音转文字（腾讯云ASR或微信内置）
    speechToText(filePath) {
      const fs = wx.getFileSystemManager();
      fs.readFile({
        filePath: filePath,
        encoding: 'base64',
        success: (res) => {
          const audioBase64 = res.data;
          wx.request({
            url: 'https://infra.textria.cn/api/asr',
            method: 'POST',
            header: { 'Content-Type': 'application/json' },
            data: { audio: audioBase64, format: 'mp3' },
            success: (asrRes) => {
              const transcript = asrRes.data.text || '';
              if (transcript.length < 10) {
                wx.showToast({ title: '未能识别语音内容', icon: 'none' });
                this.setData({ loading: false });
                return;
              }
              this.setData({ transcript, loading: false });
            },
            fail: () => {
              // 兜底：让用户手动输入
              wx.showModal({
                title: '语音识别失败',
                content: '请直接输入文字反馈',
                editable: true,
                success: (modalRes) => {
                  if (modalRes.confirm && modalRes.content) {
                    this.setData({ transcript: modalRes.content, loading: false });
                  } else {
                    this.setData({ loading: false });
                  }
                }
              });
            }
          });
        }
      });
    },

    // 提交反馈
    submitFeedback() {
      if (!this.data.transcript || this.data.transcript.length < 20) {
        wx.showToast({ title: '反馈内容至少20字', icon: 'none' });
        return;
      }
      this.setData({ loading: true });
      const app = getApp();
      wx.request({
        url: `${app.globalData.engineBase}/api/report/${this.data.sku}/voice_feedback`,
        method: 'POST',
        header: { 'Content-Type': 'application/json' },
        data: {
          transcript: this.data.transcript,
          openid: this.data.openid || 'anonymous',
        },
        success: (res) => {
          if (res.data.ok) {
            this.setData({
              scores: res.data.scores,
              refundAmount: res.data.refund_amount,
              refundPct: res.data.refund_percentage,
              showEmailBox: true,
              loading: false,
              submitted: true,
            });
          } else {
            wx.showToast({ title: res.data.error || '提交失败', icon: 'none' });
            this.setData({ loading: false });
          }
        },
        fail: () => {
          wx.showToast({ title: '网络错误', icon: 'none' });
          this.setData({ loading: false });
        }
      });
    },

    // 提交邮箱
    submitEmail() {
      const email = this.data.email.trim();
      if (!email.includes('@')) {
        wx.showToast({ title: '请输入有效邮箱', icon: 'none' });
        return;
      }
      const app = getApp();
      wx.request({
        url: `${app.globalData.engineBase}/api/report/${this.data.sku}/feedback_email`,
        method: 'POST',
        header: { 'Content-Type': 'application/json' },
        data: { email, openid: this.data.openid },
        success: () => {
          wx.showToast({ title: '邮箱已登记', icon: 'success' });
          this.setData({ showEmailBox: false });
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
