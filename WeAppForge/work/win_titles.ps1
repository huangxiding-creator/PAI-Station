[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
Get-Process WeChatAppEx,Weixin,WeChat -ErrorAction SilentlyContinue |
  Where-Object { $_.MainWindowTitle } |
  Select-Object ProcessName, Id, MainWindowTitle |
  Format-Table -AutoSize | Out-String -Width 200
