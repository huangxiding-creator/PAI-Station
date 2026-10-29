Get-CimInstance Win32_Process -Filter "Name='chrome.exe'" | Where-Object { $null -ne $_.CommandLine -and $_.CommandLine.Contains('headless') } | ForEach-Object {
  Write-Output ("KILL " + $_.ProcessId + " :: " + $_.CommandLine.Substring(0, [Math]::Min(200, $_.CommandLine.Length)))
  Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
}
Write-Output "---remaining chrome count---"
(Get-Process chrome -ErrorAction SilentlyContinue).Count
