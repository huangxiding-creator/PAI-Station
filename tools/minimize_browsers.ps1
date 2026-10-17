# Minimize all visible Chrome/Edge windows (collection browsers).
# Order 2026-10-03: browsers opened for data collection must run minimized.
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
}
"@
$min = 6  # SW_MINIMIZE
Get-Process | Where-Object { $_.Name -match 'chrome|msedge' -and $_.MainWindowTitle } | ForEach-Object {
    [void][Win32]::ShowWindow($_.MainWindowHandle, $min)
    Write-Output ("minimized " + $_.Id + " " + $_.MainWindowTitle.Substring(0, [Math]::Min(30, $_.MainWindowTitle.Length)))
}
