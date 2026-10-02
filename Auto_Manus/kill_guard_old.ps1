$ErrorActionPreference = "SilentlyContinue"
# 换血专用: 只杀旧 guard python + 其 probe_nodes 子进程 (不碰 fill/corps)
Get-CimInstance Win32_Process -Filter "Name='python.exe'" |
  Where-Object {
    ($_.CommandLine -match "epc50_yield_guard") -or
    ($_.CommandLine -match "probe_nodes")
  } |
  ForEach-Object {
    Stop-Process -Id $_.ProcessId -Force
    Write-Output ("killed " + $_.ProcessId + " :: " + $_.CommandLine.Substring(0, 80))
  }
Write-Output "done"
