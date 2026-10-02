$ErrorActionPreference = "SilentlyContinue"
# 清杀全部 corps 实例 (python 全杀 + bash fill 排除自身祖先链防自杀).
# 0925 互踩根修配套: fill.sh 启动前调用 (先清后立, 任何交错收敛单实例).
$chain = @()
$p = $PID
while ($p) {
  $chain += $p
  $p = (Get-CimInstance Win32_Process -Filter "ProcessId=$p").ParentProcessId
}
Get-CimInstance Win32_Process |
  Where-Object {
    $_.Name -eq "python.exe" -and
    ($_.CommandLine -match "epc50_corps")
  } |
  ForEach-Object {
    Stop-Process -Id $_.ProcessId -Force
    Write-Output ("killed-py " + $_.ProcessId)
  }
Get-CimInstance Win32_Process |
  Where-Object {
    ($_.Name -eq "bash.exe") -and
    ($_.CommandLine -match "epc50_corps_fill") -and
    ($chain -notcontains $_.ProcessId)
  } |
  ForEach-Object {
    Stop-Process -Id $_.ProcessId -Force
    Write-Output ("killed-sh " + $_.ProcessId)
  }
Write-Output "done"
