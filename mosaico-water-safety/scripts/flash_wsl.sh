#!/usr/bin/env bash
# 水利安检卡烧录脚本（WSL 侧）: 使用 IDF esptool 全量烧录 7 件
# 用法: wsl -e bash /mnt/e/AI-Station/mosaico-water-safety/scripts/flash_wsl.sh [COM_PORT]
# 不给 COM_PORT 则自动探测 /dev/ttyACM*
set -euo pipefail
source ~/esp/master/export.sh >/dev/null 2>&1
OUT=/mnt/e/AI-Station/mosaico-water-safety/firmware_out

PORT="${1:-}"
if [ -z "$PORT" ]; then
  PORT=$(ls /dev/ttyACM* /dev/ttyUSB* 2>/dev/null | head -1)
  if [ -z "$PORT" ]; then
    echo "[err] 未找到串口. 请先 usbipd bind + attach (见 README), 或手动指定: $0 /dev/ttyACM0"
    exit 2
  fi
fi
echo "[flash] port=$PORT"

python -m esptool --chip esp32s31 -b 460800 \
  --before default-reset --after hard-reset --no-stub \
  write-flash --flash-mode dio --flash-size 16MB --flash-freq 80m \
  0x2000 "$OUT/bootloader.bin" \
  0x8000 "$OUT/partition-table.bin" \
  0x9000 "$OUT/ota_data_claw.bin" \
  0x20000 "$OUT/vibe-mode.bin" \
  0x210000 "$OUT/edge_agent.bin" \
  0x9e0000 "$OUT/ui_apps.bin" \
  0xcb0000 "$OUT/system.bin"

echo "FLASH_DONE"
