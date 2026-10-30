#!/usr/bin/env bash
cd /e/AI-Station/mission-engine
CB=$(find "$USERPROFILE/.vscode/extensions" -maxdepth 4 -path "*claude-code-*/resources/native-binary/claude.exe" 2>/dev/null | sort -V | tail -1)
echo "[v2] 硬超时2400s+实时流 APPR-79c9"
timeout 2400 "$CB" -p "读EXEC-年终总结产线.md并完整执行(含CLAUDE.md红线);分阶段落盘07任务/2026年年终总结/,边做边留中间产物" --output-format stream-json 2>&1 | py -X utf8 _streamfilter.py | tee logs/exec-visible2.log
echo "[v2] rc=$?"
