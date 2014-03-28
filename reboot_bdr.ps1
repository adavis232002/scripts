function fncCheckService{
param($ServiceName)

$timeout = new-timespan -Minutes 1
$sw = [diagnostics.stopwatch]::StartNew()
while ($sw.elapsed -lt $timeout){
    $arrService = Get-Service -Name $ServiceName
	write-host $arrService.Status
	if ($arrService.Status -eq "Stopped"){
		write-host "Service has been stopped"
        return
        }
 
    start-sleep -seconds 5
}
 
write-host "Service did not stop in a timely manner"
}

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
        fncCheckService -ServiceName "TermService"

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

