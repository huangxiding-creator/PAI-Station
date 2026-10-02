$ErrorActionPreference = "SilentlyContinue"
Get-CimInstance Win32_Process |
  Where-Object {
    ($_.Name -eq "python.exe" -or $_.Name -eq "bash.exe") -and
    ($_.CommandLine -match "epc50_yield_guard|epc50_corps|epc50_sougo_queue")
  } |
  ForEach-Object {
    Write-Output ($_.ProcessId.ToString() + " | " + $_.Name + " | " +
      $_.CommandLine.Substring(0, [Math]::Min(90, $_.CommandLine.Length)))
  }
