$ErrorActionPreference = "SilentlyContinue"
# 杀 corps python (Name 过滤天然不自匹配)
Get-CimInstance Win32_Process -Filter "Name='python.exe'" |
  Where-Object { $_.CommandLine -match "corps" } |
  ForEach-Object {
    Stop-Process -Id $_.ProcessId -Force
    Write-Output ("killed-py " + $_.ProcessId)
  }
# bash 清单落盘 (不在命令行暴露关键词匹配, 文件中筛)
Get-CimInstance Win32_Process -Filter "Name='bash.exe'" |
  Select-Object ProcessId, CommandLine |
  ConvertTo-Json | Out-File -Encoding utf8 C:\Users\91216\AppData\Local\Temp\bash_list.json
Write-Output "dumped"
