[Console]::OutputEncoding = [Text.Encoding]::UTF8
$root = 'E:\AI-Station'
$exe = Get-ChildItem -LiteralPath $root -Recurse -Filter '*.exe' -ErrorAction SilentlyContinue | Where-Object { $_.FullName -like '*app64*' }
foreach ($f in $exe) {
  $sig = Get-AuthenticodeSignature -LiteralPath $f.FullName
  $subject = if ($sig.SignerCertificate) { $sig.SignerCertificate.Subject } else { '(no cert)' }
  Write-Output ("{0} :: {1} :: {2}" -f $f.Name, $sig.Status, $subject)
}
$dlls = Get-ChildItem -LiteralPath $root -Recurse -Include 'wyhkm.dll','wyhr.dll' -ErrorAction SilentlyContinue
foreach ($f in $dlls) {
  $sig = Get-AuthenticodeSignature -LiteralPath $f.FullName
  $subject = if ($sig.SignerCertificate) { $sig.SignerCertificate.Subject } else { '(no cert)' }
  Write-Output ("{0} ({1}) :: {2} :: {3}" -f $f.Name, $f.Directory.Name, $sig.Status, $subject)
}
