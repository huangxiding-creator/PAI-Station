// utils/ai.ts — AI 对话（云开发 extend.AI 流式；未开通时明确降级提示）
import { appConfig } from '../config/index'

export interface ChatMessage {
  role: 'user' | 'assistant'
  content: string
}

export interface AiSession {
  send: (history: ChatMessage[], onDelta: (text: string) => void) => Promise<string>
}

/** 创建 AI 会话；云未开通返回 null，由 UI 层降级展示 */
export function createAiSession(): AiSession | null {
  if (!appConfig.features.cloud || !wx.cloud) return null
  const ai = (wx.cloud as unknown as { extend: { AI: { create: (opt: object) => any } } }).extend.AI
  if (!ai) return null
  const model = ai.create({ model: 'deepseek' })
  return {
    async send(history, onDelta): Promise<string> {
      let full = ''
      const res = await model.stream({
        messages: history.map((m) => ({ role: m.role, content: m.content })),
      })
      for await (const chunk of res.textStream) {
        full += chunk
        onDelta(chunk)
      }
      return full
    },
  }
}
