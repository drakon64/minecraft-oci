If ([System.Environment]::Is64BitOperatingSystem) {
	$Phantom = "phantom-windows.exe"
}
Else {
	$Phantom = "phantom-windows-32bit.exe"
}

Start-Process -FilePath $Phantom -ArgumentList "-server $(Get-Content -Path phantom.txt)" -NoNewWindow -Wait