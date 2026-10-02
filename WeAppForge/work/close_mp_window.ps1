[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
# 只关小程序窗口（WeChatAppEx 20576 的主窗口），不动微信主进程
$p = Get-Process -Id 20576 -ErrorAction SilentlyContinue
if ($p -and $p.MainWindowTitle) {
  Write-Output ("closing window: " + $p.MainWindowTitle)
  # 发送 WM_CLOSE (0x0010) 到该窗口 —— 只关这个窗口
  Add-Type @"
using System;
using System.Runtime.InteropServices;
public class W32Close {
  [DllImport("user32.dll")] public static extern bool PostMessage(IntPtr h, uint msg, IntPtr w, IntPtr l);
}
"@
  [W32Close]::PostMessage($p.MainWindowHandle, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero) | Out-Null
  Start-Sleep -Seconds 3
  $p2 = Get-Process -Id 20576 -ErrorAction SilentlyContinue
  if ($p2 -and $p2.MainWindowTitle) { Write-Output ("STILL_OPEN: " + $p2.MainWindowTitle) }
  else { Write-Output "WINDOW_CLOSED" }
} else {
  Write-Output "NO_WINDOW"
}
