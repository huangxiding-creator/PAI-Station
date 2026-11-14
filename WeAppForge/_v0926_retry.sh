#!/bin/bash
# IDE 冷启动后 automator 常见瞬哑——轮询重试直到探针通过或 10 分钟止
for i in $(seq 1 40); do
  sleep 15
  r=$(node /e/AI-Station/WeAppForge/_v0926_probe.cjs 2>&1 | head -4)
  if echo "$r" | grep -q "sdk:"; then
    echo "PROBE PASS at attempt $i:"
    echo "$r"
    exit 0
  fi
  echo "[attempt $i] still deaf: $(echo "$r" | head -1)"
done
echo "PROBE TIMEOUT 10min"
exit 2
