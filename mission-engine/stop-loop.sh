#!/usr/bin/env bash
# 优雅停止: 置停止旗，loop 下一轮自查点退出
cd "$(dirname "$0")"; touch .auto-loop-stop; echo "停止令已置，循环将在自查点退出"
