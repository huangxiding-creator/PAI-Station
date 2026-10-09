// pages/ai/ai.ts — AI 助手：云开发 extend.AI 对话（未开通时降级说明 + 输入就位）
import { createAiSession, ChatMessage } from '../../utils/ai'
import { appConfig } from '../../config/index'

Page({
  data: {
    messages: [] as Array<ChatMessage & { streaming?: boolean }>,
    input: '',
    cloudReady: appConfig.features.cloud,
    sending: false,
  },
  session: null as ReturnType<typeof createAiSession>,
  onLoad() {
    this.session = createAiSession()
    this.setData({
      messages: [
        {
          role: 'assistant',
          content: this.session
            ? '你好，我是总包学园 AI 助手。可以问我研报里的商机、政策与数据。'
            : 'AI 功能随云开发环境开通上线，当前为预览模式。输入框已就位，敬请期待。',
        },
      ],
    })
  },
  onInput(e: { detail: { value: string } }) {
    this.setData({ input: e.detail.value })
  },
  async onSend() {
    const text = this.data.input.trim()
    if (!text || this.data.sending) return
    if (!this.session) {
      wx.showToast({ title: 'AI 服务开通中', icon: 'none' })
      return
    }
    const messages: Array<ChatMessage & { streaming?: boolean }> = [
      ...this.data.messages,
      { role: 'user', content: text },
      { role: 'assistant', content: '', streaming: true },
    ]
    this.setData({ messages, input: '', sending: true })
    try {
      const history = messages
        .filter((m) => !m.streaming && m.content)
        .map((m) => ({ role: m.role, content: m.content }))
      const finalText = await this.session!.send(history, (delta) => {
        const last = this.data.messages[this.data.messages.length - 1]
        const next = [...this.data.messages.slice(0, -1), { ...last, content: last.content + delta }]
        this.setData({ messages: next })
      })
      const closed = [...this.data.messages.slice(0, -1), { role: 'assistant' as const, content: finalText }]
      this.setData({ messages: closed })
    } catch (e) {
      console.error('[ai] 会话失败', e)
      const failed = [...this.data.messages.slice(0, -1), { role: 'assistant' as const, content: 'AI 暂时不可用，请稍后再试。' }]
      this.setData({ messages: failed })
    } finally {
      this.setData({ sending: false })
    }
  },
})
