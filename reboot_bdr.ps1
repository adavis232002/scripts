$ProcessActive = Get-Process dwm1 -ErrorAction SilentlyContinue
if($ProcessActive -eq $null)
{
	#Determine type of BDR for safe shutdown by looking if the service executable exists
    $BDR_Type_Replay4 = Test-Path "C:\Program Files (x86)\AppAssure Software\Replay Server\Server64\TevoTarget.exe"
    $BDR_Type_AppAssure5 = Test-Path "C:\Program Files\AppRecovery\Core\CoreService\Core.Service.exe"
    $BDR_Type_StorageCraft = Test-Path "C:\Program Files (x86)\StorageCraft\ShadowProtect\ShadowProtectSvc.exe"
    if($BDR_Type_Replay4 -eq "True")
    {
        #Stop Replay Core service, wait for it to shutdown, and send ok to reboot status back to Kaseya
        #Stop-Service ReplayServer64
        fncCheckService -ServiceName "wudfsvc"

    }
    elseif($BDR_Type_AppAssure5 -eq "True")
    {
        Write-Host BDR is AppAssure 5
    }
    elseif($BDR_Type_StorageCraft -eq "True")
    {
       Write-Host BDR is Storage Craft
    }
    else
    {
        Write-Host BDR is unknown
    }
}
else
{
	Write-host User Logged On
}

function fncCheckService{
param($ServiceName)
$arrService = Get-Service -Name $ServiceName
$i = 0
write-host $i
while(($arrService.Status -eq "Running") -or ($i -lt 1))
{
write-host "Service is still running"
$counter++
}
}