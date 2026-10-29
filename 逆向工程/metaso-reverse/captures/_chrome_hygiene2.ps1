$left = Get-CimInstance Win32_Process -Filter "Name='chrome.exe'" | Where-Object { $null -ne $_.CommandLine -and $_.CommandLine -match 'headless' }
foreach ($p in $left) {
  Write-Output ("KILL " + $p.ProcessId + " :: " + $p.CommandLine.Substring(0, [Math]::Min(180, $p.CommandLine.Length)))
  Stop-Process -Id $p.ProcessId -Force -ErrorAction SilentlyContinue
}
if (-not $left) { Write-Output "no leftover headless chrome found" }
Write-Output ("remaining total: " + (Get-Process chrome -ErrorAction SilentlyContinue).Count)
