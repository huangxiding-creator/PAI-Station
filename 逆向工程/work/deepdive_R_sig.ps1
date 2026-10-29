[Console]::OutputEncoding = [Text.Encoding]::UTF8
$paths = @(
  'E:\AI-Station\逆向工程\extracted\app64\识流AI助手.exe',
  'E:\AI-Station\逆向工程\extracted\app64\resources\elevate.exe',
  'E:\AI-Station\逆向工程\extracted\app64\resources\app.asar.unpacked\node_modules\@thiflow\robot\标准版\64位模块\wyhkm.dll',
  'E:\AI-Station\逆向工程\extracted\app64\resources\app.asar.unpacked\node_modules\@thiflow\robot\精简版\64位模块\wyhr.dll'
)
foreach ($p in $paths) {
  $sig = Get-AuthenticodeSignature -FilePath $p
  $name = Split-Path $p -Leaf
  $subject = if ($sig.SignerCertificate) { $sig.SignerCertificate.Subject } else { '(no cert)' }
  Write-Output ("{0} :: {1} :: {2}" -f $name, $sig.Status, $subject)
}
