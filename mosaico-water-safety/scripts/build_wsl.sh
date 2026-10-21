#!/usr/bin/env bash
# 水利安检卡 WSL 构建脚本: rsync 固件源 → bmgr 配板 → idf.py build → bin 回传 Windows
# 用法: wsl -e bash -lc '/mnt/e/AI-Station/mosaico-water-safety/scripts/build_wsl.sh'
set -euo pipefail

IDF="${IDF_DIR:-$HOME/esp/master}"
SRC=/mnt/e/AI-Station/mosaico-water-safety/firmware
WORK=~/build/mosaico-firmware
OUT=/mnt/e/AI-Station/mosaico-water-safety/firmware_out

source "$IDF/export.sh" >/dev/null

# 走宿主 clash(7890) 拉 GitHub 组件; 国内 CDN/镜像走直连
PH=$(ip route show default | awk '{print $3}')
if curl -sx "http://$PH:7890" -m 6 -o /dev/null https://github.com; then
  export http_proxy="http://$PH:7890" https_proxy="http://$PH:7890"
  export HTTP_PROXY="http://$PH:7890" HTTPS_PROXY="http://$PH:7890"
  export no_proxy="localhost,127.0.0.1,.espressif.com,espressif.com,.tuna.tsinghua.edu.cn"
  export NO_PROXY="localhost,127.0.0.1,.espressif.com,espressif.com,.tuna.tsinghua.edu.cn"
  echo "[proxy] on via $PH:7890 (espressif.com direct)"
else
  echo "[proxy] host 7890 不可达, 直连模式"
fi

mkdir -p ~/build
rsync -a --delete --exclude '.git/' --exclude 'build/' --exclude 'build-*/' --exclude 'managed_components/' "$SRC/" "$WORK/"

python -m pip install --disable-pip-version-check -q -r "$WORK/requirements.txt" 2>&1 | tail -1 || true

cd "$WORK"
if [ ! -f sdkconfig ] || [ "${FORCE_CONFIG:-0}" = "1" ]; then
  idf.py -B build bmgr -c ./boards -b esp_mosaico
fi
idf.py -B build build

mkdir -p "$OUT"
cp -v build/esp_mosaico*.bin "$OUT/" 2>/dev/null || true
cp -v build/bootloader/bootloader.bin "$OUT/" 2>/dev/null || true
cp -v build/partition_table/partition-table.bin "$OUT/" 2>/dev/null || true
for f in system.bin storage.bin; do
  find build -name "$f" -exec cp -v {} "$OUT/" \; 2>/dev/null || true
done
echo "BUILD_DONE"
ls -la "$OUT" | tail -8
