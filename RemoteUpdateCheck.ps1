
$ip = "192.168.1.90"

$CurDir = Split-Path $MyInvocation.MyCommand.Path -Parent
$TimeStamp = $(Get-Date).ToString("yyyyMMdd_HHmmss")
$FilePath = $CurDir + "\" + "OSUpdateCheck_makennayo_" + $TimeStamp + ".txt"

Invoke-Command -Computername $ip -FilePath ".\OSUpdateCheck.ps1" -Credential administrator | Out-File -filepath $FilePath


