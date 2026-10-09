"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createAiSession = createAiSession;
// utils/ai.ts — AI 对话（云开发 extend.AI 流式；未开通时明确降级提示）
const index_1 = require("../config/index");
/** 创建 AI 会话；云未开通返回 null，由 UI 层降级展示 */
function createAiSession() {
    if (!index_1.appConfig.features.cloud || !wx.cloud)
        return null;
    const ai = wx.cloud.extend.AI;
    if (!ai)
        return null;
    const model = ai.create({ model: 'deepseek' });
    return {
        async send(history, onDelta) {
            let full = '';
            const res = await model.stream({
                messages: history.map((m) => ({ role: m.role, content: m.content })),
            });
            for await (const chunk of res.textStream) {
                full += chunk;
                onDelta(chunk);
            }
            return full;
        },
    };
}
