[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
Add-Type -AssemblyName System.Drawing
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
  [DllImport("user32.dll")] public static extern bool PrintWindow(IntPtr hwnd, IntPtr hdc, uint flags);
  [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr hwnd, out RECT r);
  [DllImport("user32.dll")] public static extern bool EnumWindows(EnumWindowsProc cb, IntPtr l);
  public delegate bool EnumWindowsProc(IntPtr h, IntPtr l);
  [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr h, System.Text.StringBuilder s, int n);
  [DllImport("user32.dll")] public static extern int GetWindowTextLength(IntPtr h);
  [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr h);
  [DllImport("user32.dll")] public static extern uint GetWindowThreadProcessId(IntPtr h, out uint pid);
  public struct RECT { public int Left, Top, Right, Bottom; }
}
"@
$targets = Get-Process WeChatAppEx -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle }
$i = 0
foreach ($p in $targets) {
  $h = $p.MainWindowHandle
  if ($h -eq [IntPtr]::Zero) { continue }
  $r = New-Object Win32+RECT
  [Win32]::GetWindowRect($h, [ref]$r) | Out-Null
  $w = $r.Right - $r.Left; $ht = $r.Bottom - $r.Top
  Write-Output ("WIN pid={0} rect={1}x{2} title={3}" -f $p.Id, $w, $ht, $p.MainWindowTitle)
  if ($w -gt 0 -and $ht -gt 0) {
    $bmp = New-Object System.Drawing.Bitmap($w, $ht)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $hdc = $g.GetHdc()
    [Win32]::PrintWindow($h, $hdc, 2) | Out-Null
    $g.ReleaseHdc($hdc); $g.Dispose()
    $out = "E:\AI-Station\WeAppForge\work\mp_win_{0}_{1}.png" -f $p.Id, $i
    $bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Output "SAVED $out"
  }
  $i++
}
Write-Output "TOTAL $i"
