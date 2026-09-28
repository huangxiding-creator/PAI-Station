#!/bin/bash
# v2 (0924 用户令 100% 生产级): 输出全程落盘可观测 + 收官语义分离
#   收官 (待派0=1)  = 额度真用完      → guard 休眠至 08:05 (quota_done)
#   收官 (登录墙)   = 有账号发不出    → guard 冷却 1h 重试 (不误标额度尽)
# 可观测: corps 输出 tee 到 data/fill_corps_out.log (旧版 $() 吞几小时输出,
#         H1 观测盲区; 派单/失败逐行实时可查)
export PYTHONIOENCODING=utf-8
cd /e/AI-Station/Auto_Manus
LIVE=data/fill_corps_out.log
# 0928 永久闸: Manus 平台封号实锤 (账户已被暂停/ToS violation), 用户令
# 杜绝此类风险 — 军团链永久停用, 旗标在即退出. 恢复须用户明示.
if [ -f data/MANUS_CORPS_HALTED ]; then
  echo "=== 军团永久停用中 ($(head -1 data/MANUS_CORPS_HALTED)), 退出 $(date +%F) ===" | tee -a "$LIVE"
  exit 0
fi
# 0925 单实例闸 (多 fill 并存互踩实锤: 双 python 共享 9333 浏览器互相切号,
# 无sid+登录墙假象四起; MSYS pid 域内 kill -0 自洽)
PIDF=data/fill_run.pid
if [ -f "$PIDF" ] && kill -0 "$(cat "$PIDF")" 2>/dev/null; then
  echo "=== fill 已在跑 (pid $(cat "$PIDF")), 单实例闸退出 $(date +%F) ===" | tee -a "$LIVE"
  exit 0
fi
# 0925 加固: 先清后立 — pid 闸对 MSYS/Windows pid 域错位有绕过路径
# (三 bash 双 python 共享 9333 互踩实锤). 过闸后清杀一切残留 corps
# 实例 (kill_corps_all.ps1 排除自身祖先链防自杀), 保证启动者拥有
# 唯一实例; 交错竞态下任何顺序都收敛到单实例.
# 0928 无窗铁律: bash 直接 spawn powershell 会自建 console 闪黑窗 (5min/次
# 弹窗投诉实锤) → python 包装 + CREATE_NO_WINDOW (SouGouWeDown2 windowsHide 同款修法)
python -c "import subprocess,sys; sys.exit(subprocess.run(['powershell','-NoProfile','-ExecutionPolicy','Bypass','-File','kill_corps_all.ps1'],creationflags=0x08000000).returncode)" >> "$LIVE" 2>&1
rm -f "$PIDF"
echo $$ > "$PIDF"
trap 'rm -f "$PIDF"' EXIT
for i in 1 2 3 4 5 6; do
  echo "=== 第 $i 轮 $(date +%H:%M:%S) ===" | tee -a "$LIVE"
  out=$(python epc50_corps.py --all 2>&1 | tee -a "$LIVE")
  echo "$out" | head -1
  echo "$out" | tail -1
  echo "$out" | grep -E "✓ T|✗" | tail -3
  sent=$(echo "$out" | tail -1 | grep -oE "发出 [0-9]+" | grep -oE "[0-9]+")
  todo0=$(echo "$out" | head -1 | grep -c "今日待派 0")
  quotadead=$(echo "$out" | grep -c "军团额度尽")
  if [ "$todo0" = "1" ]; then
    echo "=== 收官 (待派0=1 本轮发出=${sent:-0}) $(date +%F) ==="
    break
  fi
  if [ "$quotadead" = "1" ]; then
    echo "=== 收官 (待派0=1 军团额度尽 本轮发出=${sent:-0}) $(date +%F) ==="
    break
  fi
  if [ "${sent:-0}" = "0" ]; then
    echo "=== 收官 (登录墙 发出=0) $(date +%F) ==="
    break
  fi
  sleep 180  # 0928 用户令: 窗口/浏览器操作间隔 60s→180s 降频
done
