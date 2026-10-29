#!/usr/bin/env bash
cd /e/AI-Station/mission-engine
CB=$(find "$USERPROFILE/.vscode/extensions" -maxdepth 4 -path "*claude-code-*/resources/native-binary/claude.exe" 2>/dev/null | sort -V | tail -1)
echo "[可见执行窗] 已批任务: 年终总结信息化产线 APPR-20261023-165252-79c9"
echo "[可见执行窗] 引擎: $CB"
"$CB" -p "读EXEC-年终总结产线.md并完整执行该任务书(含CLAUDE.md全部红线),60分钟窗,过程与结果同时打印到本窗口" 2>&1 | tee logs/exec-visible.log
