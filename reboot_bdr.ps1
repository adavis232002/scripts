$ProcessActive = Get-Process dwm -ErrorAction SilentlyContinue
if($ProcessActive -eq $null)
{
	Write-host NO
}
else
{
	Write-host YES
}