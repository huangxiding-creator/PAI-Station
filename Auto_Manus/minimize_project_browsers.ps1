$ErrorActionPreference = "SilentlyContinue"
# Minimize all AUTOMATION browser windows (project-owned), never user's own Chrome.
# Verdict: cmdline has --remote-debugging-port (automation takeover form; a human
# never launches Chrome with a debug port). Covers DrissionPage / bb-browser / any leg.
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll")] public static extern bool IsIconic(IntPtr hWnd);
    [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr hWnd);
}
"@
$min = 0
# 0928 豁免: djyanbao 下载活跃期 (驱动 python 在跑) 不能最小化 — 最小化会
# 使 visibilityState=hidden, 压制 VIP 下载浮窗 → 0923 实锤 FAIL 坑.
# 判据: 存在 cmdline 含 djyanbao 的 python → 豁免 _djyanbao_profile 的窗口.
$djActive = [bool](Get-CimInstance Win32_Process -Filter "Name='python.exe'" |
    Where-Object { $_.CommandLine -match "djyanbao" })
Get-CimInstance Win32_Process -Filter "Name='chrome.exe'" | Where-Object {
    $_.CommandLine -match "--remote-debugging-port" -and $_.CommandLine -notmatch "--type="
} | Where-Object {
    -not ($djActive -and $_.CommandLine -match "_djyanbao_profile")
} | ForEach-Object {
    $p = Get-Process -Id $_.ProcessId
    $h = $p.MainWindowHandle
    if ($h -ne 0 -and [Win32]::IsWindowVisible($h) -and -not [Win32]::IsIconic($h)) {
        [Win32]::ShowWindowAsync($h, 6) | Out-Null  # SW_MINIMIZE
        $min++
        Write-Output ("MINIMIZED pid=" + $_.ProcessId + " title=" + $p.MainWindowTitle)
    } elseif ($h -ne 0) {
        Write-Output ("ok-hidden pid=" + $_.ProcessId + " iconic=" + [Win32]::IsIconic($h))
    }
}
Write-Output ("done minimized=" + $min)
