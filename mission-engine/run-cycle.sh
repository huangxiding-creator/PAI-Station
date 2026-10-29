#!/usr/bin/env bash
cd /e/AI-Station/mission-engine || exit 9
exec env SKIP_PEAK_GATE=1 FIRST_RUN_ONLY=1 CYCLE_TIMEOUT_SECONDS=1500 /usr/bin/bash /e/AI-Station/mission-engine/auto-loop.sh
